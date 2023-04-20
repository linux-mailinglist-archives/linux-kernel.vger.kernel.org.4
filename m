Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70CB6E9555
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjDTNEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjDTNED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:04:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5833B1701;
        Thu, 20 Apr 2023 06:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681995841; x=1713531841;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rs9hGpL9hZ7PY6bMFzqPctc6xPuvDUhoDEmOgEq2GRg=;
  b=FLwtsbClaUNC2F14tPHDmvvsy7cX+/I8R2zoeXqlq+kWS147KO/qItgg
   ebp5OkVHZCcV6N6obv1hYlljrO9HyCdQlVzDCzlG13MBQmsxe40MsDEzN
   ZhbKzFLKNOT2zpZ6p6mMfd7SVb7Ny1Pr5+vy5w4OBCMUFhmCFNqUFRi/x
   3FCeYTxIjfLoEHS8ikLfSS9VTi9gXV7O72CYwCjgQ1Mw82EK09c8QssmE
   5MQeOIoQxYaw921KuAW7JATFeUf5nu7ZY77CZms2PY/jiUEe40t8oucMz
   9elfDzwWJiLOkt6o0raROJ7JGlg4xrmIg9ydquxw88ufRt1sayCZyVcUf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="345733852"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="345733852"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 06:03:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="781232441"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="781232441"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Apr 2023 06:02:59 -0700
Received: from [10.255.228.114] (kliang2-mobl1.ccr.corp.intel.com [10.255.228.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 6F591580BBE;
        Thu, 20 Apr 2023 06:02:57 -0700 (PDT)
Message-ID: <46508ba1-6bd5-a28e-5ae8-bc69a679b2c5@linux.intel.com>
Date:   Thu, 20 Apr 2023 09:02:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] perf stat: Introduce skippable evsels
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Yasin, Ahmad" <ahmad.yasin@intel.com>,
        "Taylor, Perry" <perry.taylor@intel.com>,
        "Alt, Samantha" <samantha.alt@intel.com>,
        "Biggers, Caleb" <caleb.biggers@intel.com>,
        "Wang, Weilin" <weilin.wang@intel.com>,
        Edward <edward.baker@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230414051922.3625666-1-irogers@google.com>
 <ce92dd1b-23f6-ea52-a47d-fccc24fa20ea@linux.intel.com>
 <CAP-5=fWRy4NEqhB6-b98+m7SV5=oyBOMVuOHwmvKZCJuXcsQEg@mail.gmail.com>
 <d1fe801a-22d0-1f9b-b127-227b21635bd5@linux.intel.com>
 <CAP-5=fXCmKAUn24r0YYHaO63mabZCXae-hAT2WCtk+YYmvS9xg@mail.gmail.com>
 <99150cb1-fe50-97cf-ad80-cceb9194eb9a@linux.intel.com>
 <CAP-5=fXZSACj=kGM5t3pBHkQ-W1i0eJayAQ77_ToEp4zXWzJnw@mail.gmail.com>
 <ea899096-0599-f2a0-04a3-d90a3aa7d45d@linux.intel.com>
 <CAP-5=fVVFjKgUGV8zVurd99BOhASQ9mMaZqOyw13PYLhZWpsOA@mail.gmail.com>
 <CAP-5=fW_JwabjEUqSLaJn+tuHXLoyRWqJVVCh_z1dhXJ6On=MQ@mail.gmail.com>
 <84b19053-2e9f-5251-6816-26d2475894c0@linux.intel.com>
 <CAP-5=fWJKmo4eLKe9+=3pKGe7g+xfA+YxOz7AOgqLfcRNzNaLw@mail.gmail.com>
 <201a2ad6-3fb4-4b2a-d8a4-34d924e680c3@linux.intel.com>
 <CAP-5=fVWN5=URg0Og7KW7f7L4LSw6D8ghOKjP7La=0c+MkXFCg@mail.gmail.com>
 <2b8768bf-de24-946f-62da-6ed171a5c324@linux.intel.com>
 <CAP-5=fU9WeBga_tQKi6QKX1-t=C1w5CoPc8Rn9myR=1CxeQuMg@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fU9WeBga_tQKi6QKX1-t=C1w5CoPc8Rn9myR=1CxeQuMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-19 8:23 p.m., Ian Rogers wrote:
> On Wed, Apr 19, 2023 at 11:57 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>> On 2023-04-19 12:51 p.m., Ian Rogers wrote:
>>>>>>> With that change I don't have a case that requires skippable evsels,
>>>>>>> and so we can take that series with patch 6 over the v1 of that series
>>>>>>> with this change.
>>>>>>>
>>>>>>
>>>>>> I'm afraid this is not the only problem the commit 94b1a603fca7 ("perf
>>>>>> stat: Add TopdownL1 metric as a default if present") in the
>>>>>> perf-tools-next branch introduced.
>>>>>>
>>>>>> The topdown L2 in the perf stat default on SPR and big core of the ADL
>>>>>> is still missed. I don't see a possible fix for this on the current
>>>>>> perf-tools-next branch.
>>>>>
>>>>> I thought in its current state the json metrics for TopdownL2 on SPR
>>>>> have multiplexing. Given L1 is used to drill down to L2, it seems odd
>>>>> to start on L2, but given L1 is used to compute the thresholds for L2,
>>>>> this should be to have both L1 and L2 on these platforms. However,
>>>>> that doesn't work as you don't want multiplexing.
>>>>>
>>>>> This all seems backward to avoid potential multiplexing on branch miss
>>>>> rate and IPC, just always having TopdownL1 seems cleanest with the
>>>>> skippable evsels working around the permissions issue - as put forward
>>>>> in this patch. Possibly adding L2 metrics on ADL/SPR, but only once
>>>>> the multiplexing issue is resolved.
>>>>>
>>>>
>>>> No, not just that issue. Based to what I tested these days, perf stat
>>>> default has issues/regressions on most of the Intel platforms with the
>>>> current perf-tools-next and perf/core branch of acme's repo.
>>>>
>>>> For the pre-ICL platforms:
>>>> - The permission issue. (This patch tried to address.)
>>>> - Unclean perf stat default. (This patch failed to address.)
>>>>   Unnecessary multiplexing for cycles.
>>>>   Display partial of the TopdownL1
>>>>
>>>> https://lore.kernel.org/lkml/d1fe801a-22d0-1f9b-b127-227b21635bd5@linux.intel.com/
>>>>
>>>> For SPR platforms
>>>> - Topdown L2 metrics is missed, while it works with the current 6.3-rc7.
>>>>
>>>> For ADL/RPL platforms
>>>> - Segmentation fault which I just found this morning.
>>>> # ./perf stat true
>>>> Segmentation fault (core dumped)
>>>
>>> This may also stem from the reference count checking work that Arnaldo
>>> is currently merging. It is hard to test hybrid because it uses
>>> non-generic code paths.
>>
>> There are two places which causes the Segmentation fault.
>> One place is the TopdownL1.
>>
>> After I disable the TopdownL1 and add !counter->name as below, there are
>> no errors for the ./perf stat true.
>>
>> (The below is just for test purpose.)
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index 7a641a67486d..8e12ed1141e0 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -1892,7 +1892,7 @@ static int add_default_attributes(void)
>>                  * Add TopdownL1 metrics if they exist. To minimize
>>                  * multiplexing, don't request threshold computation.
>>                  */
>> -               if (metricgroup__has_metric("TopdownL1")) {
>> +               if (0 && metricgroup__has_metric("TopdownL1")) {
> 
> So hybrid has something different that causes this. Can you provide
> the information to solve?

Here is the backtrace.

#0  get_group_fd (thread=0, cpu_map_idx=<optimized out>,
evsel=0x555556015af0) at util/evsel.c:1722
#1  evsel__open_cpu (evsel=<optimized out>, cpus=<optimized out>,
threads=<optimized out>,
    start_cpu_map_idx=<optimized out>, end_cpu_map_idx=<optimized out>)
at util/evsel.c:2105
#2  0x000055555561dd9e in __run_perf_stat (run_idx=<optimized out>,
argv=0x7fffffffe1d0, argc=1)
    at builtin-stat.c:734
#3  run_perf_stat (run_idx=<optimized out>, argv=0x7fffffffe1d0, argc=1)
at builtin-stat.c:949
#4  cmd_stat (argc=1, argv=0x7fffffffe1d0) at builtin-stat.c:2537
#5  0x00005555556b56a0 in run_builtin (p=p@entry=0x555555f84450
<commands+336>, argc=argc@entry=2,
    argv=argv@entry=0x7fffffffe1d0) at perf.c:323
#6  0x00005555555fe2d9 in handle_internal_command (argv=0x7fffffffe1d0,
argc=2) at perf.c:377
#7  run_argv (argv=<synthetic pointer>, argcp=<synthetic pointer>) at
perf.c:421
#8  main (argc=2, argv=0x7fffffffe1d0) at perf.c:537

> 
>>                         struct evlist *metric_evlist = evlist__new();
>>                         struct evsel *metric_evsel;
>>
>> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
>> index 6b46bbb3d322..072fa56744b4 100644
>> --- a/tools/perf/util/stat-display.c
>> +++ b/tools/perf/util/stat-display.c
>> @@ -747,7 +747,7 @@ static void uniquify_event_name(struct evsel *counter)
>>         int ret = 0;
>>
>>         if (counter->uniquified_name || counter->use_config_name ||
>> -           !counter->pmu_name || !strncmp(counter->name, counter->pmu_name,
>> +           !counter->pmu_name || !counter->name ||
>> !strncmp(counter->name, counter->pmu_name,
>>                                            strlen(counter->pmu_name)))
>>                 return;
> 
> Is this a pre-existing hybrid bug? It is a real shame hybrid shows so
> few common code paths. In general evsel__name should be preferred over
> directly accessing name.


I don't think so.

I haven't dig into the bug yet. But from the source code I can tell that
the check is the same as the current 6.3-rc7.

For the current 6.3-rc7, perf stat true works.
The perf stat -M TopdownL1 --metric-no-group can work as well.

But with the current perf-tools-next branch, perf stat true gives a
Segmentation fault.

The TopdownL1 doesn't work either.

# ./perf stat -M TopdownL1 --metric-no-group
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument)
for event (topdown-retiring).
/bin/dmesg | grep -i perf may provide additional information.



> 
>>>
>>>> After the test on a hybrid machine, I incline to revert the commit
>>>> 94b1a603fca7 ("perf stat: Add TopdownL1 metric as a default if present")
>>>> and related patches for now.
>>>>
>>>> To clarify, I do not object a generic solution for the Topdown on
>>>> different ARCHs. But the current generic solution aka TopdownL1 has all
>>>> kinds of problems on most of Intel platforms. We should fix them first
>>>> before applying to the mainline.
>>>
>>> No, 6.3 has many issues as do the default events/metrics:
>>
>> To be honest, I don't think they are real critical issues. For the first
>> one, I think there was already a temporary fix. For the others, they are
>> there for years.
> 
> This isn't true. The aggregation bug was raised to me by Intel and
> stems from aggregation refactoring in per-thread mode done by
> Namhyung.
> 
>> However, the solution you proposed in the huge patch set
>> (https://lore.kernel.org/lkml/20230219092848.639226-37-irogers@google.com/)
>> brings many critical issues on different Intel platforms, crashes,
>> Missing features, etc.
>> Also, I was just told that many of our existing tools which on top of
>> the perf tool will also be broken, because all the annotations of the
>> kernel top-down metrics event disappeared.
>>
>> So we really should revert the patches. I don't think patches 39 to 51
>> are well-tested and reviewed.
> 
> The only issue I'm aware of is that hard coded use of the inaccurate
> hard coded metrics now needs to switch to json metrics. This seems a
> worthwhile update anyway, and not one that would justify breaking perf
> stat metrics.
> 

I have pointed out many issues (crash, missing features, user-visible
changes which breaking existing tools) many times in the previous reply,
I will not repeat the details again here.

The json metrics in the current perf-tools-next branch which you want to
switch to also has many bugs based on my recent test.
- The TopdownL2 triggers unnecessary multiplexing on SPR.
- Doesn't work on hybrid platforms while the current 6.3-rc7 can.

The difference between the hard coded kernel metrics and the json
metrics is that the json metrics just collect two more events, e.g., on
Tigerlake. The core metrics is exactly the same. It's good enough for a
initial judgement with core metrics.

I don't think the switching is a good choice and necessary based on all
of the above issues.

Thanks,
Kan
