Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CAA68B3D6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 02:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjBFB25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 20:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBFB24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 20:28:56 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A4117CCA;
        Sun,  5 Feb 2023 17:28:54 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4P97rm3xCPzRrZX;
        Mon,  6 Feb 2023 09:26:32 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 6 Feb 2023 09:28:51 +0800
Subject: Re: [PATCH v3] perf record: Fix segfault with --overwrite and
 --max-size
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <acme@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <jiwei.sun@windriver.com>
References: <20230113073803.102950-1-yangjihong1@huawei.com>
 <29a8e0bc-e90b-b371-962b-58a4b8c87f20@huawei.com>
Message-ID: <ee213278-7e76-586b-0564-843dc7a3c84f@huawei.com>
Date:   Mon, 6 Feb 2023 09:28:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <29a8e0bc-e90b-b371-962b-58a4b8c87f20@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Ping again, please take time to review, thanks.


Thanks,
Yang


On 2023/1/28 9:27, Yang Jihong wrote:
> Hello,
> 
> The data written by the thread (data.X file) has been saved as 
> recommended in v2 patch. Please check whether it is feasible. Thank you.
> 
> Thanks,
> Yang
> 
> On 2023/1/13 15:38, Yang Jihong wrote:
>> When --overwrite and --max-size options of perf record are used together,
>> a segmentation fault occurs. The following is an example:
>>
>>    # perf record -e sched:sched* --overwrite --max-size 1K -a -- sleep 1
>>    [ perf record: Woken up 1 times to write data ]
>>    perf: Segmentation fault
>>    Obtained 12 stack frames.
>>    ./perf/perf(+0x197673) [0x55f99710b673]
>>    /lib/x86_64-linux-gnu/libc.so.6(+0x3ef0f) [0x7fa45f3cff0f]
>>    ./perf/perf(+0x8eb40) [0x55f997002b40]
>>    ./perf/perf(+0x1f6882) [0x55f99716a882]
>>    ./perf/perf(+0x794c2) [0x55f996fed4c2]
>>    ./perf/perf(+0x7b7c7) [0x55f996fef7c7]
>>    ./perf/perf(+0x9074b) [0x55f99700474b]
>>    ./perf/perf(+0x12e23c) [0x55f9970a223c]
>>    ./perf/perf(+0x12e54a) [0x55f9970a254a]
>>    ./perf/perf(+0x7db60) [0x55f996ff1b60]
>>    /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xe6) 
>> [0x7fa45f3b2c86]
>>    ./perf/perf(+0x7dfe9) [0x55f996ff1fe9]
>>    Segmentation fault (core dumped)
>>
>> backtrace of the core file is as follows:
>>
>>    (gdb) bt
>>    #0  record__bytes_written (rec=0x55f99755a200 <record>) at 
>> builtin-record.c:234
>>    #1  record__output_max_size_exceeded (rec=0x55f99755a200 <record>) 
>> at builtin-record.c:242
>>    #2  record__write (map=0x0, size=12816, bf=0x55f9978da2e0, 
>> rec=0x55f99755a200 <record>) at builtin-record.c:263
>>    #3  process_synthesized_event (tool=tool@entry=0x55f99755a200 
>> <record>, event=event@entry=0x55f9978da2e0, sample=sample@entry=0x0, 
>> machine=machine@entry=0x55f997893658) at builtin-record.c:618
>>    #4  0x000055f99716a883 in __perf_event__synthesize_id_index 
>> (tool=tool@entry=0x55f99755a200 <record>, 
>> process=process@entry=0x55f997002aa0 <process_synthesized_event>, 
>> evlist=0x55f9978928b0, machine=machine@entry=0x55f997893658,
>>        from=from@entry=0) at util/synthetic-events.c:1895
>>    #5  0x000055f99716a91f in perf_event__synthesize_id_index 
>> (tool=tool@entry=0x55f99755a200 <record>, 
>> process=process@entry=0x55f997002aa0 <process_synthesized_event>, 
>> evlist=<optimized out>, machine=machine@entry=0x55f997893658)
>>        at util/synthetic-events.c:1905
>>    #6  0x000055f996fed4c3 in record__synthesize (tail=tail@entry=true, 
>> rec=0x55f99755a200 <record>) at builtin-record.c:1997
>>    #7  0x000055f996fef7c8 in __cmd_record (argc=argc@entry=2, 
>> argv=argv@entry=0x7ffc67551260, rec=0x55f99755a200 <record>) at 
>> builtin-record.c:2802
>>    #8  0x000055f99700474c in cmd_record (argc=<optimized out>, 
>> argv=0x7ffc67551260) at builtin-record.c:4258
>>    #9  0x000055f9970a223d in run_builtin (p=0x55f997564d88 
>> <commands+264>, argc=10, argv=0x7ffc67551260) at perf.c:330
>>    #10 0x000055f9970a254b in handle_internal_command (argc=10, 
>> argv=0x7ffc67551260) at perf.c:384
>>    #11 0x000055f996ff1b61 in run_argv (argcp=<synthetic pointer>, 
>> argv=<synthetic pointer>) at perf.c:428
>>    #12 main (argc=<optimized out>, argv=0x7ffc67551260) at perf.c:562
>>
>> The reason is that record__bytes_written accesses the freed memory 
>> rec->thread_data,
>> The process is as follows:
>>    __cmd_record
>>      -> record__free_thread_data
>>        -> zfree(&rec->thread_data)         // free rec->thread_data
>>      -> record__synthesize
>>        -> perf_event__synthesize_id_index
>>          -> process_synthesized_event
>>            -> record__write
>>              -> record__bytes_written      // access rec->thread_data
>>
>> We add a member variable "thread_bytes_written" in the struct "record"
>> to save the data size written by the threads.
>>
>> Fixes: 6d57581659f7 ("perf record: Add support for limit perf output 
>> file size")
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> ---
>>
>> Changes since v2:
>>   - Save data size written by threads to calculate the correct total 
>> data size.
>>   - Update commit message.
>>
>> Changes since v1:
>>   - Add variable check in record__bytes_written for code hardening.
>>   - Save bytes_written separately to reduce one calculation.
>>   - Remove rec->opts.tail_synthesize check.
>>
>>   tools/perf/builtin-record.c | 16 ++++++----------
>>   1 file changed, 6 insertions(+), 10 deletions(-)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index 29dcd454b8e2..8374117e66f6 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -154,6 +154,7 @@ struct record {
>>       struct perf_tool    tool;
>>       struct record_opts    opts;
>>       u64            bytes_written;
>> +    u64            thread_bytes_written;
>>       struct perf_data    data;
>>       struct auxtrace_record    *itr;
>>       struct evlist    *evlist;
>> @@ -226,14 +227,7 @@ static bool switch_output_time(struct record *rec)
>>   static u64 record__bytes_written(struct record *rec)
>>   {
>> -    int t;
>> -    u64 bytes_written = rec->bytes_written;
>> -    struct record_thread *thread_data = rec->thread_data;
>> -
>> -    for (t = 0; t < rec->nr_threads; t++)
>> -        bytes_written += thread_data[t].bytes_written;
>> -
>> -    return bytes_written;
>> +    return rec->bytes_written + rec->thread_bytes_written;
>>   }
>>   static bool record__output_max_size_exceeded(struct record *rec)
>> @@ -255,10 +249,12 @@ static int record__write(struct record *rec, 
>> struct mmap *map __maybe_unused,
>>           return -1;
>>       }
>> -    if (map && map->file)
>> +    if (map && map->file) {
>>           thread->bytes_written += size;
>> -    else
>> +        rec->thread_bytes_written += size;
>> +    } else {
>>           rec->bytes_written += size;
>> +    }
>>       if (record__output_max_size_exceeded(rec) && !done) {
>>           fprintf(stderr, "[ perf record: perf size limit reached (%" 
>> PRIu64 " KB),"
>>
> 
> .
