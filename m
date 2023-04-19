Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E776E7C27
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjDSORX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbjDSOQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:16:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9CF1B4;
        Wed, 19 Apr 2023 07:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681913796; x=1713449796;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IV0n4/rkVEdJYzohLV5j0qEktEX8ATK9WtKvknQGQ3g=;
  b=SgPeQXAKz50iPk2MmrByWWB9aLyVPl8KiYrTH3efpX2QNziRvqORDJvF
   JNwuYecxNtrSVfbTvAP7DCUx+xQuKPcF1DYMt06WnkkQCcUOv3APit5yT
   mFL37w05U7w/fMwxRHaBi3xX+n97xbqluXr8WFRXpMzLA39k5zHddMXQ9
   iSUy5GbplnowqVOhkBw0U4YqyxnAUoF+9uMgOyxo9tPxkYIpStr9hhmuG
   kusyJFTT9VPo4J6BMnepDKFoXNZnXO3ixGwT3IuCxSAbNxLOfUxGYaxGb
   OFMx5+daHRjv/nOoUMlW57aDt9A4I+wj5maAh2B6puqojtLnEslWxph/Z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="329633983"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="329633983"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 07:16:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="815642367"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="815642367"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 19 Apr 2023 07:16:35 -0700
Received: from [10.209.41.10] (kliang2-mobl1.ccr.corp.intel.com [10.209.41.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 70877580505;
        Wed, 19 Apr 2023 07:16:34 -0700 (PDT)
Message-ID: <201a2ad6-3fb4-4b2a-d8a4-34d924e680c3@linux.intel.com>
Date:   Wed, 19 Apr 2023 10:16:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] perf stat: Introduce skippable evsels
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
 <99150cb1-fe50-97cf-ad80-cceb9194eb9a@linux.intel.com>
 <CAP-5=fXZSACj=kGM5t3pBHkQ-W1i0eJayAQ77_ToEp4zXWzJnw@mail.gmail.com>
 <ea899096-0599-f2a0-04a3-d90a3aa7d45d@linux.intel.com>
 <CAP-5=fVVFjKgUGV8zVurd99BOhASQ9mMaZqOyw13PYLhZWpsOA@mail.gmail.com>
 <CAP-5=fW_JwabjEUqSLaJn+tuHXLoyRWqJVVCh_z1dhXJ6On=MQ@mail.gmail.com>
 <84b19053-2e9f-5251-6816-26d2475894c0@linux.intel.com>
 <CAP-5=fWJKmo4eLKe9+=3pKGe7g+xfA+YxOz7AOgqLfcRNzNaLw@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fWJKmo4eLKe9+=3pKGe7g+xfA+YxOz7AOgqLfcRNzNaLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-19 9:19 a.m., Ian Rogers wrote:
> On Wed, Apr 19, 2023 at 5:31 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2023-04-18 9:00 p.m., Ian Rogers wrote:
>>> On Tue, Apr 18, 2023 at 5:12 PM Ian Rogers <irogers@google.com> wrote:
>>>>
>>>> On Tue, Apr 18, 2023 at 2:51 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2023-04-18 4:08 p.m., Ian Rogers wrote:
>>>>>> On Tue, Apr 18, 2023 at 11:19 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 2023-04-18 11:43 a.m., Ian Rogers wrote:
>>>>>>>> On Tue, Apr 18, 2023 at 6:03 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 2023-04-17 2:13 p.m., Ian Rogers wrote:
>>>>>>>>>> The json TopdownL1 is enabled if present unconditionally for perf stat
>>>>>>>>>> default. Enabling it on Skylake has multiplexing as TopdownL1 on
>>>>>>>>>> Skylake has multiplexing unrelated to this change - at least on the
>>>>>>>>>> machine I was testing on. We can remove the metric group TopdownL1 on
>>>>>>>>>> Skylake so that we don't enable it by default, there is still the
>>>>>>>>>> group TmaL1. To me, disabling TopdownL1 seems less desirable than
>>>>>>>>>> running with multiplexing - previously to get into topdown analysis
>>>>>>>>>> there has to be knowledge that "perf stat -M TopdownL1" is the way to
>>>>>>>>>> do this.
>>>>>>>>>
>>>>>>>>> To be honest, I don't think it's a good idea to remove the TopdownL1. We
>>>>>>>>> cannot remove it just because the new way cannot handle it. The perf
>>>>>>>>> stat default works well until 6.3-rc7. It's a regression issue of the
>>>>>>>>> current perf-tools-next.
>>>>>>>>
>>>>>>>> I'm not so clear it is a regression to consistently add TopdownL1 for
>>>>>>>> all architectures supporting it.
>>>>>>>
>>>>>>>
>>>>>>> Breaking the perf stat default is a regression.
>>>>>>
>>>>>> Breaking is overstating the use of multiplexing. The impact is less
>>>>>> accuracy in the IPC and branch misses default metrics,
>>>>>
>>>>> Inaccuracy is a breakage for the default.
>>>>
>>>> Can you present a case where this matters? The events are already not
>>>> grouped and so inaccurate for metrics.
>>>
>>> Removing CPUs without perf metrics from the TopdownL1 metric group is
>>> implemented here:
>>> https://lore.kernel.org/lkml/20230419005423.343862-6-irogers@google.com/
>>> Note, this applies to pre-Icelake and atom CPUs as these also lack
>>> perf metric (aka topdown) events.
>>>
>>
>> That may give the end user the impression that the pre-Icelake doesn't
>> support the Topdown Level1 events, which is not true.
>>
>> I think perf should either keep it for all Intel platforms which
>> supports tma_L1_group, or remove the TopdownL1 name entirely for Intel
>> platform (let the end user use the tma_L1_group and the name exposed by
>> the kernel as before.).
> 
> How does this work on hybrid systems? We will enable TopdownL1 because
> of the presence of perf metric (aka topdown) events but this will also
> enable TopdownL1 on the atom core.


This is the output from a hybrid system with current 6.3-rc7.

As you can see that the Topdown L1 and L2 are displayed for the big
core. No Topdown events are displayed for the atom core.

(BTW: The 99.15% is not multiplexing. I think it's because the perf stat
may starts from the big core and it takes a little bit time to run
something on the small core.)


$perf stat ./hybrid_triad_loop.sh

 Performance counter stats for './hybrid_triad_loop.sh':

            211.80 msec task-clock                       #    0.996 CPUs
utilized
                 5      context-switches                 #   23.608 /sec
                 3      cpu-migrations                   #   14.165 /sec
               652      page-faults                      #    3.078 K/sec
       411,470,713      cpu_core/cycles/                 #    1.943 G/sec
       607,566,483      cpu_atom/cycles/                 #    2.869
G/sec                       (99.15%)
     1,613,379,362      cpu_core/instructions/           #    7.618 G/sec
     1,616,816,312      cpu_atom/instructions/           #    7.634
G/sec                       (99.15%)
       202,876,952      cpu_core/branches/               #  957.884 M/sec
       202,367,829      cpu_atom/branches/               #  955.480
M/sec                       (99.15%)
            56,740      cpu_core/branch-misses/          #  267.898 K/sec
            19,033      cpu_atom/branch-misses/          #   89.864
K/sec                       (99.15%)
     2,468,765,562      cpu_core/slots/                  #   11.656 G/sec
     1,411,184,398      cpu_core/topdown-retiring/       #     57.4%
Retiring
         4,671,159      cpu_core/topdown-bad-spec/       #      0.2% Bad
Speculation
        92,222,378      cpu_core/topdown-fe-bound/       #      3.7%
Frontend Bound
       952,516,107      cpu_core/topdown-be-bound/       #     38.7%
Backend Bound
         2,696,347      cpu_core/topdown-heavy-ops/      #      0.1%
Heavy Operations          #     57.2% Light Operations
         4,460,659      cpu_core/topdown-br-mispredict/  #      0.2%
Branch Mispredict         #      0.0% Machine Clears
        19,538,486      cpu_core/topdown-fetch-lat/      #      0.8%
Fetch Latency             #      3.0% Fetch Bandwidth
        24,170,592      cpu_core/topdown-mem-bound/      #      1.0%
Memory Bound              #     37.7% Core Bound

       0.212598999 seconds time elapsed

       0.212525000 seconds user
       0.000000000 seconds sys


> 
>>
>>> With that change I don't have a case that requires skippable evsels,
>>> and so we can take that series with patch 6 over the v1 of that series
>>> with this change.
>>>
>>
>> I'm afraid this is not the only problem the commit 94b1a603fca7 ("perf
>> stat: Add TopdownL1 metric as a default if present") in the
>> perf-tools-next branch introduced.
>>
>> The topdown L2 in the perf stat default on SPR and big core of the ADL
>> is still missed. I don't see a possible fix for this on the current
>> perf-tools-next branch.
> 
> I thought in its current state the json metrics for TopdownL2 on SPR
> have multiplexing. Given L1 is used to drill down to L2, it seems odd
> to start on L2, but given L1 is used to compute the thresholds for L2,
> this should be to have both L1 and L2 on these platforms. However,
> that doesn't work as you don't want multiplexing.
> 
> This all seems backward to avoid potential multiplexing on branch miss
> rate and IPC, just always having TopdownL1 seems cleanest with the
> skippable evsels working around the permissions issue - as put forward
> in this patch. Possibly adding L2 metrics on ADL/SPR, but only once
> the multiplexing issue is resolved.
> 

No, not just that issue. Based to what I tested these days, perf stat
default has issues/regressions on most of the Intel platforms with the
current perf-tools-next and perf/core branch of acme's repo.

For the pre-ICL platforms:
- The permission issue. (This patch tried to address.)
- Unclean perf stat default. (This patch failed to address.)
  Unnecessary multiplexing for cycles.
  Display partial of the TopdownL1

https://lore.kernel.org/lkml/d1fe801a-22d0-1f9b-b127-227b21635bd5@linux.intel.com/

For SPR platforms
- Topdown L2 metrics is missed, while it works with the current 6.3-rc7.

For ADL/RPL platforms
- Segmentation fault which I just found this morning.
# ./perf stat true
Segmentation fault (core dumped)


After the test on a hybrid machine, I incline to revert the commit
94b1a603fca7 ("perf stat: Add TopdownL1 metric as a default if present")
and related patches for now.

To clarify, I do not object a generic solution for the Topdown on
different ARCHs. But the current generic solution aka TopdownL1 has all
kinds of problems on most of Intel platforms. We should fix them first
before applying to the mainline.

Thanks,
Kan
