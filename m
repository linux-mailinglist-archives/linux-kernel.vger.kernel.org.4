Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09458668ECC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241113AbjAMHE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241584AbjAMHE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:04:28 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADFF76223;
        Thu, 12 Jan 2023 22:53:10 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NtXC56n2SzJrJR;
        Fri, 13 Jan 2023 14:51:45 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 13 Jan 2023 14:53:05 +0800
Subject: Re: [PATCH v2] perf record: Fix coredump with --overwrite and
 --max-size
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <jiwei.sun@windriver.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221229124728.66515-1-yangjihong1@huawei.com>
 <Y7MEWK/z19QCaNoi@kernel.org>
 <CAM9d7cjcWKBephb5p9ZPU2+wDAz04DYQJoKczORioD=es10hPw@mail.gmail.com>
 <c65f89ef-173c-b828-f3b2-266387903149@huawei.com>
 <CAM9d7chN9ecR7EgA1eN1QQXypZDwCFC-ym6BTQ0d1_XjuruLFw@mail.gmail.com>
 <a08af34e-acf2-d370-06bb-ea43d467f89d@huawei.com>
 <CAM9d7ci_TRrqBQVQNW8=GwakUr7SsZpYxaaty-S4bxF8zJWyqw@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <58686bd7-6789-d1c4-a560-b8b0670212f3@huawei.com>
Date:   Fri, 13 Jan 2023 14:53:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7ci_TRrqBQVQNW8=GwakUr7SsZpYxaaty-S4bxF8zJWyqw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/1/11 3:21, Namhyung Kim wrote:
> On Sun, Jan 8, 2023 at 6:47 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> Hello,
>>
>> On 2023/1/7 5:12, Namhyung Kim wrote:
>>> Hello,
>>>
>>> On Wed, Jan 4, 2023 at 8:09 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>>>>
>>>> Hello,
>>>>
>>>> On 2023/1/4 0:50, Namhyung Kim wrote:
>>>>> On Mon, Jan 2, 2023 at 8:20 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>>>>>
>>>>>> Em Thu, Dec 29, 2022 at 12:47:28PM +0000, Yang Jihong escreveu:
>>>>>>> When --overwrite and --max-size options of perf record are used together,
>>>>>>> a segmentation fault occurs. The following is an example:
>>>>>>>
>>>>>>>     # perf record -e sched:sched* --overwrite --max-size 1M -a -- sleep 1
>>>>>>>      [ perf record: Woken up 1 times to write data ]
>>>>>>>      perf: Segmentation fault
>>>>>>>      Obtained 1 stack frames.
>>>>>>>      [0xc4c67f]
>>>>>>>      Segmentation fault (core dumped)
>>>>>>>
>>>>>>> backtrace of the core file is as follows:
>>>>>>>
>>>>>>>      #0  0x0000000000417990 in process_locked_synthesized_event (tool=0x0, event=0x15, sample=0x1de0, machine=0xf8) at builtin-record.c:630
>>>>>>>      #1  0x000000000057ee53 in perf_event__synthesize_threads (nr_threads_synthesize=21, mmap_data=<optimized out>, needs_mmap=<optimized out>, machine=0x17ad9b0, process=<optimized out>, tool=0x0) at util/synthetic-events.c:1950
>>>>>>>      #2  __machine__synthesize_threads (nr_threads_synthesize=0, data_mmap=<optimized out>, needs_mmap=<optimized out>, process=<optimized out>, threads=0x8, target=0x8, tool=0x0, machine=0x17ad9b0) at util/synthetic-events.c:1936
>>>>>>>      #3  machine__synthesize_threads (machine=0x17ad9b0, target=0x8, threads=0x8, needs_mmap=<optimized out>, data_mmap=<optimized out>, nr_threads_synthesize=0) at util/synthetic-events.c:1947
>>>>>>>      #4  0x000000000040165d in record__synthesize (tail=<optimized out>, rec=0xbe2520 <record>) at builtin-record.c:2010
>>>>>>>      #5  0x0000000000403989 in __cmd_record (argc=<optimized out>, argv=<optimized out>, rec=0xbe2520 <record>) at builtin-record.c:2810
>>>>>>>      #6  0x00000000004196ba in record__init_thread_user_masks (rec=0xbe2520 <record>, cpus=0x17a65f0) at builtin-record.c:3837
>>>>>>>      #7  record__init_thread_masks (rec=0xbe2520 <record>) at builtin-record.c:3938
>>>>>>>      #8  cmd_record (argc=1, argv=0x7ffdd692dc60) at builtin-record.c:4241
>>>>>>>      #9  0x00000000004b701d in pager_command_config (var=0x0, value=0x15 <error: Cannot access memory at address 0x15>, data=0x1de0) at perf.c:117
>>>>>>>      #10 0x00000000004b732b in get_leaf_frame_caller_aarch64 (sample=0xfffffffb, thread=0x0, usr_idx=<optimized out>) at util/arm64-frame-pointer-unwind-support.c:56
>>>>>>>      #11 0x0000000000406331 in execv_dashed_external (argv=0x7ffdd692d9e8) at perf.c:410
>>>>>>>      #12 run_argv (argcp=<synthetic pointer>, argv=<synthetic pointer>) at perf.c:431
>>>>>>>      #13 main (argc=<optimized out>, argv=0x7ffdd692d9e8) at perf.c:562
>>>>>>>
>>>>>>> The reason is that record__bytes_written accesses the freed memory rec->thread_data,
>>>>>>> The process is as follows:
>>>>>>>      __cmd_record
>>>>>>>        -> record__free_thread_data
>>>>>>>          -> zfree(&rec->thread_data)         // free rec->thread_data
>>>>>>>        -> record__synthesize
>>>>>>>          -> perf_event__synthesize_id_index
>>>>>>>            -> process_synthesized_event
>>>>>>>              -> record__write
>>>>>>>                -> record__bytes_written     // access rec->thread_data
>>>>>>>
>>>>>>> we only need to check the value of done first.
>>>>>>> Also add variable check in record__bytes_written for code hardening,
>>>>>>> and save bytes_written separately to reduce one calculation.
>>>>>>>
>>>>>>> Fixes: 6d57581659f7 ("perf record: Add support for limit perf output file size")
>>>>>>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>>>>>>> ---
>>>>>>>
>>>>>>> Changes since v1:
>>>>>>>     - Add variable check in record__bytes_written for code hardening.
>>>>>>>     - Save bytes_written separately to reduce one calculation.
>>>>>>>     - Remove rec->opts.tail_synthesize check.
>>>>>>
>>>>>> Namhyung, are you ok with this now?
>>>>>>
>>>>>> - Arnaldo
>>>>>>
>>>>>>>     tools/perf/builtin-record.c | 26 +++++++++++++++++---------
>>>>>>>     1 file changed, 17 insertions(+), 9 deletions(-)
>>>>>>>
>>>>>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>>>>>>> index 29dcd454b8e2..acba9e43e519 100644
>>>>>>> --- a/tools/perf/builtin-record.c
>>>>>>> +++ b/tools/perf/builtin-record.c
>>>>>>> @@ -230,16 +230,29 @@ static u64 record__bytes_written(struct record *rec)
>>>>>>>          u64 bytes_written = rec->bytes_written;
>>>>>>>          struct record_thread *thread_data = rec->thread_data;
>>>>>>>
>>>>>>> +     if (thread_data == NULL)
>>>>>>> +             return bytes_written;
>>>>>>> +
>>>>>
>>>>> Then it won't count bytes written by threads, right?
>>>>> I think it needs to be saved somewhere.
>>>>>
>>>> I'm not sure here. Can you explain it more clearly, thanks :)
>>>> I can modify it accordingly.
>>>>
>>>> I think if thread_data == NULL, it is not thread data.
>>>> In this case, we just return rec->bytes_written.
>>>
>>> It can be thread data but freed before tail synthesis, right?
>>> In that case, I think it needs to add bytes_written by threads
>>> to calculate the correct data size.
>> Em... In the __cmd_record function, record__stop_threads is called
>> before record__free_thread_data, so if the thread has been freed, there
>> will be no thread data.
>> I think it's okay to ignore the situation you mentioned above.
> 
> Right, the thread data is already freed, but we need the size.
> 
> I think it didn't (and won't) update to rec->bytes_written for the data
> written by the threads (data.X file) because it's only for the main
> 'data' file.  So record__bytes_written() will return a smaller number
> after the threads are gone.  But I think it should return the total
> data size.
> 
Yes, the total data size including data.X file should be returned here 
to fit the semantics, so there's a problem here, too. will fix in next 
version.

Thanks,
Yang
