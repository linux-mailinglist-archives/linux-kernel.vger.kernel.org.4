Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E0F6E6BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjDRSUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjDRSTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:19:54 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFA9B443;
        Tue, 18 Apr 2023 11:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681841992; x=1713377992;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EaJ5gfiiuj5YHjbWBVe3EzL2utzaW26I67s3AkAOJeo=;
  b=Ht42/zAj90pvF4D1tK6uR35QGL7NYj/Wpq3Aeu3KXgTD6QvR5hLpp0JX
   1V4Gu9wf6FSa2NYen+ZDu+TW9vOA1FmRSQKD0bdFbX1kVmvjKs0T1TGuX
   mEjE/oeLkyfwES6uQg3ZX6IIOwoelO5UhxhG5SotEAopMy/R6zM5gFK6h
   jaPBI1JG+jEhw0XBfdZFDGc9PLz5JfJPAviRJ5VBfhDsFmOPHho8EufOA
   VLFv1YdvgpHukoc2iuVyi1YazarkvRTdO9UW+ri7ITCbv/GAnHsIhloSI
   KjXucIcRXUVWe1kstk3ibpDGjbhpF8jfJfC8lEg4UwxS7QzXujwnEhkS6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="348009325"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="348009325"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 11:19:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="815308054"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="815308054"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 18 Apr 2023 11:19:51 -0700
Received: from [10.209.125.134] (kliang2-mobl1.ccr.corp.intel.com [10.209.125.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 70B63580C9A;
        Tue, 18 Apr 2023 11:19:50 -0700 (PDT)
Message-ID: <99150cb1-fe50-97cf-ad80-cceb9194eb9a@linux.intel.com>
Date:   Tue, 18 Apr 2023 14:19:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] perf stat: Introduce skippable evsels
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230414051922.3625666-1-irogers@google.com>
 <56ac61a0-ccf0-210e-e429-11062a07b8bf@linux.intel.com>
 <CAP-5=fXz1vw48A2tWgcNDSZsnvnOO7_jA+py3p_Khi_igz0hJw@mail.gmail.com>
 <5031f492-9734-be75-3283-5961771d87c8@linux.intel.com>
 <CAP-5=fW2aAijt8tqydszQHQFmsfeQO2S0hb7Z27RtXxG4Zmm-w@mail.gmail.com>
 <ce92dd1b-23f6-ea52-a47d-fccc24fa20ea@linux.intel.com>
 <CAP-5=fWRy4NEqhB6-b98+m7SV5=oyBOMVuOHwmvKZCJuXcsQEg@mail.gmail.com>
 <d1fe801a-22d0-1f9b-b127-227b21635bd5@linux.intel.com>
 <CAP-5=fXCmKAUn24r0YYHaO63mabZCXae-hAT2WCtk+YYmvS9xg@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fXCmKAUn24r0YYHaO63mabZCXae-hAT2WCtk+YYmvS9xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-18 11:43 a.m., Ian Rogers wrote:
> On Tue, Apr 18, 2023 at 6:03 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2023-04-17 2:13 p.m., Ian Rogers wrote:
>>> The json TopdownL1 is enabled if present unconditionally for perf stat
>>> default. Enabling it on Skylake has multiplexing as TopdownL1 on
>>> Skylake has multiplexing unrelated to this change - at least on the
>>> machine I was testing on. We can remove the metric group TopdownL1 on
>>> Skylake so that we don't enable it by default, there is still the
>>> group TmaL1. To me, disabling TopdownL1 seems less desirable than
>>> running with multiplexing - previously to get into topdown analysis
>>> there has to be knowledge that "perf stat -M TopdownL1" is the way to
>>> do this.
>>
>> To be honest, I don't think it's a good idea to remove the TopdownL1. We
>> cannot remove it just because the new way cannot handle it. The perf
>> stat default works well until 6.3-rc7. It's a regression issue of the
>> current perf-tools-next.
> 
> I'm not so clear it is a regression to consistently add TopdownL1 for
> all architectures supporting it. 


Breaking the perf stat default is a regression.

The reason we once added the TopdownL1 for ICL and later platform is
that it doesn't break the original design (a *clean* output).

> The assertion is that because
> TopdownL1 has multiplexing and multiplexing is global then we've
> lowered the accuracy of other metrics, but the only other hardware
> metrics in the default output pre-Icelake are IPC and branch miss
> rate. Having TopdownL1 is a way of drilling into performance issues,
> while IPC and branch miss rate are putting your finger in the air to
> see which way the wind is blowing. Perhaps we should drop these if
> TopdownL1 is present.
> 
>> But I'm OK to add some flags with the metrics to assist the perf tool to
>> specially handle the case if you prefer to modify the event list.
> 
> We've already removed thresholds from the default output, we could
> remove groups.
> 
>>>
>>> This doesn't relate to this change which is about making it so that
>>> failing to set up TopdownL1 doesn't cause an early exit. The reason I
>>> showed TigerLake output was that on TigerLake the skip/fallback
>>> approach works while Skylake just needs the events disabled/skipped
>>> unless it has sufficient permissions. Note the :u on the events in:
>>
>> The perf_event_open() should be good to detect the insufficient
>> permission, but it doesn't work to detect an existing of an event.
>> That's because the kernel only checks the features not specific events.
>> It's not a reliable way to rely on the output of the perf_event_open() here.
> 
> I'm unclear why not as not having perf_event_open fail seems like a
> kernel bug. I can see there is little motivation to fix this on older
> architectures like Skylake.

Updating kernel may not be an option here. Because
- There is no issue with the existing perf tool until 6.3-rc7. It
doesn't sound like a defect of the kernel.
- The kernel for the SKL has been there for many years. It's impossible
to change all the kernels to support a new requirement from the perf tool.

> We do attempt to workaround it with the
> errata flags on the metrics introduced here:
> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py#L1296
>
If so, I would still suggest to check the slots and topdown events in
sysfs and decide whether to append the TopdownL1 to perf stat default.

So we probably need a ARCH specific is_event_available(), before
appending the events.


>>>> From your test result in the v2 description, we can see that there is no
>>>> TopdownL1, which is good and expected. However, there is a (48.99%) with
>>>> cycles:u event, which implies multiplexing. Could you please check
>>>> what's the problem here?
>>>> Also, if it's because of the backgroud, all the events should be
>>>> multiplexing. But it looks like only cycle:u has multiplexing. Other
>>>> events, instructions:u, branches:u and branch-misses:u work without
>>>> multiplexing. That's very strange.
>>> I wasn't able to reproduce it and suspect it was a transient thing. I
>>> think there are multiplexing things to look into, 2 events on a fixed
>>> counter on Icelake+ will trigger multiplexing on all counters, and
>>> Skylake's 3 fixed and 4 generic should fit TopdownL1.
>>
>> Just found a cascade lake. With this patch + the current
>> perf-tools-next, partial of the TopdownL1 and multiplexing can still be
>> observed.
>>
>> $ sudo ./perf stat true
>>
>>  Performance counter stats for 'true':
>>
>>               2.91 msec task-clock                       #    0.316 CPUs
>> utilized
>>                  0      context-switches                 #    0.000 /sec
>>                  0      cpu-migrations                   #    0.000 /sec
>>                 45      page-faults                      #   15.474 K/sec
>>          2,819,972      cycles                           #    0.970 GHz
>>                        (60.14%)
>>          5,391,406      instructions                     #    1.91  insn
>> per cycle
>>          1,068,575      branches                         #  367.442 M/sec
>>              8,455      branch-misses                    #    0.79% of
>> all branches
>>             70,283      CPU_CLK_UNHALTED.REF_XCLK        #   24.168
>> M/sec
>>             48,806      INT_MISC.RECOVERY_CYCLES_ANY     #   16.783
>> M/sec                       (39.86%)
>>
>>        0.009204517 seconds time elapsed
>>
>>        0.000000000 seconds user
>>        0.009614000 seconds sys
> 
> The issue here is that 'true' ran very quickly and so we skipped the
> output of the events with 0 counts, no metrics were computed due to
> the zero counts. Cascade lake has the same TopdownL1 multiplexing
> issues as Skylake.
> 

I tried other benchmark. I can still observe the multiplexing. But my
remote machine just crashed. I'm asking the tech support. So I cannot do
more tests.

Thanks,
Kan
