Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB7F7408B9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 04:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjF1CzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 22:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjF1CzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 22:55:14 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00F91BD9;
        Tue, 27 Jun 2023 19:55:12 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QrR5B1SrPz1HC6D;
        Wed, 28 Jun 2023 10:54:54 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 10:55:09 +0800
Subject: Re: [PATCH] perf top & record: Fix segfault when default cycles event
 is not supported
To:     Ian Rogers <irogers@google.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230614151625.2077-1-yangjihong1@huawei.com>
 <CAP-5=fUf0+7HwZ+AHUR0nRD5QnfPn9_CPMEdJZP_5goPfrPB+Q@mail.gmail.com>
 <CAP-5=fVOXjjcusjv858SOGrnNgE2w2sb7zS=0sZUpdFfR1T_GA@mail.gmail.com>
 <668a6159-b7a8-ed25-d8fa-5584a4c04d37@huawei.com>
 <CAP-5=fX6nWRboZ2dWc1h_y0pe5TAgs0QC0qwCeaLcALfJ+5YEA@mail.gmail.com>
 <cc3a669d-570b-2f0d-ce0f-0f4bee417eb2@huawei.com>
 <CAP-5=fU-F6sCP+Bf-RssRxtvZs79OcjONbphExiGq390cBcZvw@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <3a7e3842-9383-bdcf-6d20-3b47005cbdae@huawei.com>
Date:   Wed, 28 Jun 2023 10:55:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAP-5=fU-F6sCP+Bf-RssRxtvZs79OcjONbphExiGq390cBcZvw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/6/28 2:32, Ian Rogers wrote:
> On Thu, Jun 15, 2023 at 4:46 AM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> Hello,
>>
>> On 2023/6/15 10:04, Ian Rogers wrote:
>>> On Wed, Jun 14, 2023 at 6:55 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>>>>
>>>> Hello,
>>>>
>>>> On 2023/6/15 6:03, Ian Rogers wrote:
>>>>> On Wed, Jun 14, 2023 at 9:18 AM Ian Rogers <irogers@google.com> wrote:
>>>>>>
>>>>>> On Wed, Jun 14, 2023 at 8:18 AM Yang Jihong <yangjihong1@huawei.com> wrote:
>>>>>>>
>>>>>>> The perf-record and perf-top call parse_event() to add a cycles event to
>>>>>>> an empty evlist. For the system that does not support hardware cycles
>>>>>>> event, such as QEMU, the evlist is empty due to the following code process:
>>>>>>>
>>>>>>>      parse_event(evlist, "cycles:P" or ""cycles:Pu")
>>>>>>>        parse_events(evlist, "cycles:P")
>>>>>>>          __parse_events
>>>>>>>            ...
>>>>>>>            ret = parse_events__scanner(str, &parse_state);
>>>>>>>            // ret = 0
>>>>>>>            ...
>>>>>>>            ret2 = parse_events__sort_events_and_fix_groups()
>>>>>>>            if (ret2 < 0)
>>>>>>>              return ret;
>>>>>>>            // The cycles event is not supported, here ret2 = -EINVAL,
>>>>>>>            // Here return 0.
>>>>>>>            ...
>>>>>>>            evlist__splice_list_tail(evlist)
>>>>>>>            // The code here does not execute to, so the evlist is still empty.
>>>>>>>
>>>>>>> A null pointer occurs when the content in the evlist is accessed later.
>>>>>>>
>>>>>>> Before:
>>>>>>>
>>>>>>>      # perf list hw
>>>>>>>
>>>>>>>      List of pre-defined events (to be used in -e or -M):
>>>>>>>
>>>>>>>      # perf record true
>>>>>>>      libperf: Miscounted nr_mmaps 0 vs 1
>>>>>>>      WARNING: No sample_id_all support, falling back to unordered processing
>>>>>>>      perf: Segmentation fault
>>>>>>>      Obtained 1 stack frames.
>>>>>>>      [0xc5beff]
>>>>>>>      Segmentation fault
>>>>>>>
>>>>>>> Solution:
>>>>>>>      If cycles event is not supported, try to fall back to cpu-clock event.
>>>>>>>
>>>>>>> After:
>>>>>>>      # perf record true
>>>>>>>      [ perf record: Woken up 1 times to write data ]
>>>>>>>      [ perf record: Captured and wrote 0.006 MB perf.data ]
>>>>>>>      #
>>>>>>>
>>>>>>> Fixes: 7b100989b4f6 ("perf evlist: Remove __evlist__add_default")
>>>>>>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>>>>>>
>>>>>> Thanks, useful addition. The cpu-clock fall back wasn't present before
>>>>>> 7b100989b4f6 so is the fixes tag correct?
>>>>>
>>>>> Hmm... it should be coming from evsel__fallback:
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/evsel.c?h=tmp.perf-tools-next#n2840
>>>>> so we shouldn't duplicate that logic. The question is why we're not
>>>>> doing the fallback.
>>>>>
>>>>
>>>> Yes, it's a bit of the same logic as evsel__fallback, or we can call
>>>> evlist__add_default() as before, simply create an evsel of hardware
>>>> cycles and add it directly to evlist.
>>>>
>>>> Please confirm whether this solution is feasible. If it is feasible, I
>>>> will send a v2 version.
>>>
>>> The previous evlist__add_default logic didn't handle wildcard PMUs for
>>> cycles, hence wanting to reuse the parse events logic. The error is
>>> that the logic now isn't doing the fallback properly. I think an
>>> evlist__add_cycles which uses evsel__fallback makes sense matching the
>>> previous logic. I'd be happy if you took a look. I'll write a patch so
>>> that the perf_pmus list of core PMUs is never empty.
>>>
>>
>> The gdb calltrace for core dump is as follows:
>>
>> (gdb) bt
>> #0  0x00000000005ffaa2 in __perf_cpu_map__nr (cpus=0x0) at cpumap.c:283
>> #1  0x00000000005ffd17 in perf_cpu_map__max (map=0x0) at cpumap.c:371
>> #2  0x0000000000565644 in cpu_map_data__alloc
>> (syn_data=syn_data@entry=0x7ffc843bff30,
>> header_size=header_size@entry=8) at util/synthetic-events.c:1273
>> #3  0x0000000000568712 in cpu_map_event__new (map=<optimized out>) at
>> util/synthetic-events.c:1321
>> #4  perf_event__synthesize_cpu_map (tool=tool@entry=0xc37580 <record>,
>> map=<optimized out>, process=process@entry=0x413a80
>> <process_synthesized_event>, machine=machine@entry=0x0) at
>> util/synthetic-events.c:1341
>> #5  0x000000000041426e in record__synthesize (tail=tail@entry=false,
>> rec=0xc37580 <record>) at builtin-record.c:2050
>> #6  0x0000000000415a0b in __cmd_record (argc=<optimized out>,
>> argv=<optimized out>, rec=0xc37580 <record>) at builtin-record.c:2512
>> #7  0x0000000000418f22 in cmd_record (argc=<optimized out>,
>> argv=<optimized out>) at builtin-record.c:4260
>> #8  0x00000000004babdd in run_builtin (p=p@entry=0xc3a0e8
>> <commands+264>, argc=argc@entry=2, argv=argv@entry=0x7ffc843c5b30) at
>> perf.c:323
>> #9  0x0000000000401632 in handle_internal_command (argv=0x7ffc843c5b30,
>> argc=2) at perf.c:377
>> #10 run_argv (argcp=<synthetic pointer>, argv=<synthetic pointer>) at
>> perf.c:421
>> #11 main (argc=2, argv=0x7ffc843c5b30) at perf.c:537
>>
>> The direct cause of the problem is that rec->evlist->core.all_cpus is
>> empty, resulting in null pointer access.
>>
>> The code process is as follows:
>>
>> cmd_record
>>     parse_event(rec->evlist)
>>     // Hardware cycle events should not be supported here, so rec->evlist
>> is empty
>>     ...
>>
>>     evlist__create_maps(rec->evlist)
>>       perf_evlist__set_maps(&rec->evlist->core)
>>            perf_evlist__propagate_maps(&rec->evlist->core)
>>              perf_evlist__for_each_evsel(&rec->evlist->core, evsel)
>>                  // because rec->evlist is empty, don't get into that
>> __perf_evlist__propagate_maps(), so rec->evlist->core.all_cpus is NULL.
>>                    __perf_evlist__propagate_maps
>>                      rec->evlist->core.all_cpus = perf_cpu_map__merge(evlist->all_cpus,
>> evsel->cpus);
>>     ...
>>
>>     __cmd_record
>>       record__synthesize
>>         perf_event__synthesize_cpu_map(rec->evlist->core.all_cpus)
>>           cpu_map_event__new(rec->evlist->core.all_cpus)
>>                    cpu_map_data__alloc(rec->evlist->core.all_cpus)
>>                      perf_cpu_map__max(rec->evlist->core.all_cpus)
>>                            __perf_cpu_map__nr
>>                            // Here null pointer access!
>>          ...
>>
>>          record__open
>>         evsel__fallback
>>            // Here fallback is just starting
>>
> 
> Sorry, I don't follow this. I sent out a patch for the no core PMU
> case - please take a look:
> https://lore.kernel.org/lkml/20230627182834.117565-1-irogers@google.com/
Thanks for the patch, it seems to solve the problem. I'll test it now.

> I haven't got a reproduction for failing to open cycles and it's not
> clear to me why evsel__fallback isn't being used to fallback to clock.
> Were you able to look at this?

1. In the QEMU environment that does not support hardware events, as 
shown in [1], the sysfs node related to the core PMU does not exist in 
the /sys/bus/event_source/devices/ directory.
As a result, evlist is empty after perf_recod invokes 
parse_event(evlist, "cycles:P").

2. When perf_record initializes the member in evlist->core, the content 
of some members is NULL because evlist is empty. For example, the value 
of evlist->core.all_cpus is NULL.

3. Access the content in evlist->core.all_cpus. The null pointer access 
is triggered, as shown in [2]. At this time, perf_record has not invoked 
evsel__fallback() yet.

4. evsel__fallback() is invoked in record__open(). Therefore, segfault 
occurs before fallback to clock.

[1]:
# ls /sys/bus/event_source/devices/
breakpoint  kprobe  msr  software  tracepoint  uprobe

[2]:
cmd_record
   __cmd_record
     record__synthesize
       perf_event__synthesize_cpu_map(evlist->core.all_cpus)
         cpu_map_event__new(evlist->core.all_cpus)
           cpu_map_data__alloc(evlist->core.all_cpus)
             perf_cpu_map__max(evlist->core.all_cpus)
               __perf_cpu_map__nr
               // Here null pointer access ...

Thanks,
Yang
