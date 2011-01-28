#!/bin/bash

#declare -a var2[0]=1
#printf "value array index 0 is %d \n" "${var2[0]}"

#extracting pid of firefox-bin
declare pid=$(pgrep firefox-bin)
#printf "Process is %d \n" $pid

#concatinate to make expression for reading wchan of firefox's process pid.
declare query='/proc/'
declare query2="/wchan"
declare final_query=$query$pid$query2
#printf "query is %s \n" $final_query

#read state
#compare wchan to 0
#if 0 then check for the next 5 seconds
#if true kill pid
declare readState
declare i=1
declare count=0
while [ $i -le 10 ]; do
	read readState <$final_query
#	printf "%s \n" $readState
	if [[ $readState == 0 ]]; then 
		count=$(($count+1))
	fi
	i=$(($i+1))

	sleep 1
done
#printf "value is %d \n" $count
if [[ $count > 8 ]]; then 
	kill $pid
fi

exit 0
