Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92586E5683
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 03:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjDRBfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 21:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjDRBfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:35:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E831A6;
        Mon, 17 Apr 2023 18:35:41 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Q0mdR2MWqzL0NK;
        Tue, 18 Apr 2023 09:32:59 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Apr 2023 09:35:23 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
Subject: Re: [PATCH] perf/core: Fix perf_sample_data not properly initialized
 for different swevents in perf_tp_event()
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230412095240.181516-1-yangjihong1@huawei.com>
 <20230417114512.GK83892@hirez.programming.kicks-ass.net>
Message-ID: <15805714-27c0-b8ff-143a-8f768704a673@huawei.com>
Date:   Tue, 18 Apr 2023 09:35:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20230417114512.GK83892@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/4/17 19:45, Peter Zijlstra wrote:
> On Wed, Apr 12, 2023 at 09:52:40AM +0000, Yang Jihong wrote:
>> data->sample_flags may be modified in perf_prepare_sample(),
>> in perf_tp_event(), different swevents use the same on-stack
>> perf_sample_data, the previous swevent may change sample_flags in
>> perf_prepare_sample(), as a result, some members of perf_sample_data are
>> not correctly initialized when next swevent_event preparing sample
>> (for example data->id, the value varies according to swevent).
>>
>> A simple scenario triggers this problem is as follows:
>>
>>    # perf record -e sched:sched_switch --switch-output-event sched:sched_switch -a sleep 1
>>    [ perf record: dump data: Woken up 0 times ]
>>    [ perf record: Dump perf.data.2023041209014396 ]
>>    [ perf record: dump data: Woken up 0 times ]
>>    [ perf record: Dump perf.data.2023041209014662 ]
>>    [ perf record: dump data: Woken up 0 times ]
>>    [ perf record: Dump perf.data.2023041209014910 ]
>>    [ perf record: Woken up 0 times to write data ]
>>    [ perf record: Dump perf.data.2023041209015164 ]
>>    [ perf record: Captured and wrote 0.069 MB perf.data.<timestamp> ]
>>    # ls -l
>>    total 860
>>    -rw------- 1 root root  95694 Apr 12 09:01 perf.data.2023041209014396
>>    -rw------- 1 root root 606430 Apr 12 09:01 perf.data.2023041209014662
>>    -rw------- 1 root root  82246 Apr 12 09:01 perf.data.2023041209014910
>>    -rw------- 1 root root  82342 Apr 12 09:01 perf.data.2023041209015164
>>    # perf script -i perf.data.2023041209014396
>>    0x11d58 [0x80]: failed to process type: 9 [Bad address]
>>
>> Solution: Add perf_sample_data_flags_{save, restore} helpers to save and
>> restore sample_flags when processing different swevents
>>
>> After fix:
>>
>>    # perf record -e sched:sched_switch --switch-output-event sched:sched_switch -a sleep 1
>>    [ perf record: dump data: Woken up 0 times ]
>>    [ perf record: Dump perf.data.2023041209442259 ]
>>    [ perf record: dump data: Woken up 0 times ]
>>    [ perf record: Dump perf.data.2023041209442514 ]
>>    [ perf record: dump data: Woken up 0 times ]
>>    [ perf record: Dump perf.data.2023041209442760 ]
>>    [ perf record: Woken up 0 times to write data ]
>>    [ perf record: Dump perf.data.2023041209443003 ]
>>    [ perf record: Captured and wrote 0.069 MB perf.data.<timestamp> ]
>>    # ls -l
>>    total 864
>>    -rw------- 1 root root 100166 Apr 12 09:44 perf.data.2023041209442259
>>    -rw------- 1 root root 606438 Apr 12 09:44 perf.data.2023041209442514
>>    -rw------- 1 root root  82246 Apr 12 09:44 perf.data.2023041209442760
>>    -rw------- 1 root root  82342 Apr 12 09:44 perf.data.2023041209443003
>>    # perf script -i perf.data.2023041209442259 | head -n 5
>>                perf   232 [000]    66.846217: sched:sched_switch: prev_comm=perf prev_pid=232 prev_prio=120 prev_state=D ==> next_comm=perf next_pid=234 next_prio=120
>>                perf   234 [000]    66.846449: sched:sched_switch: prev_comm=perf prev_pid=234 prev_prio=120 prev_state=S ==> next_comm=perf next_pid=232 next_prio=120
>>                perf   232 [000]    66.846546: sched:sched_switch: prev_comm=perf prev_pid=232 prev_prio=120 prev_state=R ==> next_comm=perf next_pid=234 next_prio=120
>>                perf   234 [000]    66.846606: sched:sched_switch: prev_comm=perf prev_pid=234 prev_prio=120 prev_state=S ==> next_comm=perf next_pid=232 next_prio=120
>>                perf   232 [000]    66.846646: sched:sched_switch: prev_comm=perf prev_pid=232 prev_prio=120 prev_state=R ==> next_comm=perf next_pid=234 next_prio=120
> 
> This seems a little bit short on analysis; what actual flags are the
> problem? Much of the data will in fact be identical between these
> invocations and endlessly re-computing that is wasteful.
> 
In the preceding example, data->id is incorrectly initialized,
that is, PERF_SAMPLE_ID | PERF_SAMPLE_IDENTIFIER
The detailed process is as follows:
1. In the example of perf record, create two swevents evt1 and evt2,
and attach to sched:sched_switch, assume that the IDs are 10 and 11
2. In perf_tp_event():
struct perf_sample_data data // on-stack value
hlist_for_each_entry_rcu
  -> perf_swevent_event(evt1, &data)
   -> perf_swevent_overflow(evt1, &data)
    -> ...
     -> perf_prepare_sample(evt1, &data)
      -> __perf_event_header__init_id(evt1, &data)
       -> data->sample_flags |= data->type & PERF_SAMPLE_ID_ALL
          // data->sample_flags set PERF_SAMPLE_ID | PERF_SAMPLE_IDENTIFIER
       -> if (sample_type & (PERF_SAMPLE_ID | PERF_SAMPLE_IDENTIFIER))
                   data->id = primary_event_id(event);
          // for evt1, the if condition is met,
          // and data->id can be correctly initialized.
...
  -> perf_swevent_event(evt2, &data)
   -> perf_swevent_overflow(evt2, &data)
    -> ...
     -> perf_prepare_sample(evt2, &data)
      -> __perf_event_header__init_id(evt2, &data)
       -> if (sample_type & (PERF_SAMPLE_ID | PERF_SAMPLE_IDENTIFIER))
                   data->id = primary_event_id(event);
          // data->sample_flags set PERF_SAMPLE_ID | 
PERF_SAMPLE_IDENTIFIER in evt1,
          // therefore, the condition is not met for evt2.
          // As a result, the ID of evt2 is not assigned to data-id.

> I'm thinking perhaps those flags that update ->dyn_size are the problem?
> At the same time, Should you not also then clear dyn_size?
Yes, according to the code, dyn_size should also be cleared.
Maybe we need to change it to the following, which would be more 
appropriate?

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10144,14 +10144,14 @@ void perf_tp_event(u16 event_type, u64 count, 
void *record, int entry_size,
                 },
         };

-       perf_sample_data_init(&data, 0, 0);
-       perf_sample_save_raw_data(&data, &raw);
-
         perf_trace_buf_update(record, event_type);

         hlist_for_each_entry_rcu(event, head, hlist_entry) {
-               if (perf_tp_event_match(event, &data, regs))
+               if (perf_tp_event_match(event, &data, regs)) {
+                       perf_sample_data_init(&data, 0, 0);
+                       perf_sample_save_raw_data(&data, &raw);
                         perf_swevent_event(event, count, &data, regs);
+               }
         }

Thanks,
Yang.


> 
> .
> 
