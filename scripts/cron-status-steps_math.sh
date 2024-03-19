C_ID="steps_math"
LOG_FILENAME="log-$C_ID-$(date +%Y%m%d%H%M%S).txt"
TMP_LOG_FILENAME="log-$C_ID-tmp.txt"

COUNT_VAL=20
INTERVAL_SEC=5
initial_count=0
while [ $initial_count -lt $COUNT_VAL ]
do
    dfx canister status $C_ID --log=file --logfile=$TMP_LOG_FILENAME
    TIME_VAR=`cat $TMP_LOG_FILENAME | awk 'NR==1' | awk '{ print $3 }'`
    STORAGE_VAR=`cat $TMP_LOG_FILENAME | awk 'NR==7' | awk -F'[()]' '{print $2}'`
    BALANCE_VAR=`cat $TMP_LOG_FILENAME | awk 'NR==8' | awk '{ print $2 }'`
    echo "$TIME_VAR,$STORAGE_VAR,$BALANCE_VAR" >> $LOG_FILENAME
    rm -rf $TMP_LOG_FILENAME

    initial_count=$((initial_count+1))
    echo "[`date +%Y-%m-%dT%H:%M:%S`] $initial_count"
    sleep $INTERVAL_SEC
done
