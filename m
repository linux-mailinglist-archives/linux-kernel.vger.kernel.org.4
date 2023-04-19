Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3706E79CE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjDSMbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbjDSMbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:31:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F04883D8;
        Wed, 19 Apr 2023 05:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681907479; x=1713443479;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ms4CryhYtDp4tIqhE0yt+qiaJQ9HXwQjuuAqzSeax4k=;
  b=lLoyqxtAL+CWa4/u0ELkPtFkaNvbxvZqPit02YKXtLwPu5Ry0iIzuBXI
   Yih91wntsErpYh9YxVfGVzhZqQATi1fOixFudzk8045K+NmUy5UeN/y5z
   iiGGE3zXJzSzXC1LTYQSK1f/2ERKzhDlgG41/Ioi61686nFtGrMawpz2B
   6unZTclwoTumiCwhC7JjR3gjnqXkn4QR95UmVMdrAeeyomsZPbOrxwRBX
   8AMXXN5S+GRmZlrritV+dafMh0UbLR4T0kFS6hoLmlV+6lrU9d22whmkT
   JBFPReCKb48pb1awmhhny3IYbEP8KYsa4ePwt/RBQusJJQplekmCEcUrJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="408342794"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="408342794"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 05:31:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="684962247"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="684962247"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 19 Apr 2023 05:31:18 -0700
Received: from [10.209.41.10] (kliang2-mobl1.ccr.corp.intel.com [10.209.41.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id E92EB580C4C;
        Wed, 19 Apr 2023 05:31:16 -0700 (PDT)
Message-ID: <84b19053-2e9f-5251-6816-26d2475894c0@linux.intel.com>
Date:   Wed, 19 Apr 2023 08:31:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] perf stat: Introduce skippable evsels
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
 <99150cb1-fe50-97cf-ad80-cceb9194eb9a@linux.intel.com>
 <CAP-5=fXZSACj=kGM5t3pBHkQ-W1i0eJayAQ77_ToEp4zXWzJnw@mail.gmail.com>
 <ea899096-0599-f2a0-04a3-d90a3aa7d45d@linux.intel.com>
 <CAP-5=fVVFjKgUGV8zVurd99BOhASQ9mMaZqOyw13PYLhZWpsOA@mail.gmail.com>
 <CAP-5=fW_JwabjEUqSLaJn+tuHXLoyRWqJVVCh_z1dhXJ6On=MQ@mail.gmail.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fW_JwabjEUqSLaJn+tuHXLoyRWqJVVCh_z1dhXJ6On=MQ@mail.gmail.com>
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



On 2023-04-18 9:00 p.m., Ian Rogers wrote:
> On Tue, Apr 18, 2023 at 5:12 PM Ian Rogers <irogers@google.com> wrote:
>>
>> On Tue, Apr 18, 2023 at 2:51 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>
>>>
>>>
>>> On 2023-04-18 4:08 p.m., Ian Rogers wrote:
>>>> On Tue, Apr 18, 2023 at 11:19 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2023-04-18 11:43 a.m., Ian Rogers wrote:
>>>>>> On Tue, Apr 18, 2023 at 6:03 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 2023-04-17 2:13 p.m., Ian Rogers wrote:
>>>>>>>> The json TopdownL1 is enabled if present unconditionally for perf stat
>>>>>>>> default. Enabling it on Skylake has multiplexing as TopdownL1 on
>>>>>>>> Skylake has multiplexing unrelated to this change - at least on the
>>>>>>>> machine I was testing on. We can remove the metric group TopdownL1 on
>>>>>>>> Skylake so that we don't enable it by default, there is still the
>>>>>>>> group TmaL1. To me, disabling TopdownL1 seems less desirable than
>>>>>>>> running with multiplexing - previously to get into topdown analysis
>>>>>>>> there has to be knowledge that "perf stat -M TopdownL1" is the way to
>>>>>>>> do this.
>>>>>>>
>>>>>>> To be honest, I don't think it's a good idea to remove the TopdownL1. We
>>>>>>> cannot remove it just because the new way cannot handle it. The perf
>>>>>>> stat default works well until 6.3-rc7. It's a regression issue of the
>>>>>>> current perf-tools-next.
>>>>>>
>>>>>> I'm not so clear it is a regression to consistently add TopdownL1 for
>>>>>> all architectures supporting it.
>>>>>
>>>>>
>>>>> Breaking the perf stat default is a regression.
>>>>
>>>> Breaking is overstating the use of multiplexing. The impact is less
>>>> accuracy in the IPC and branch misses default metrics,
>>>
>>> Inaccuracy is a breakage for the default.
>>
>> Can you present a case where this matters? The events are already not
>> grouped and so inaccurate for metrics.
> 
> Removing CPUs without perf metrics from the TopdownL1 metric group is
> implemented here:
> https://lore.kernel.org/lkml/20230419005423.343862-6-irogers@google.com/
> Note, this applies to pre-Icelake and atom CPUs as these also lack
> perf metric (aka topdown) events.
>

That may give the end user the impression that the pre-Icelake doesn't
support the Topdown Level1 events, which is not true.

I think perf should either keep it for all Intel platforms which
supports tma_L1_group, or remove the TopdownL1 name entirely for Intel
platform (let the end user use the tma_L1_group and the name exposed by
the kernel as before.).


> With that change I don't have a case that requires skippable evsels,
> and so we can take that series with patch 6 over the v1 of that series
> with this change.
> 

I'm afraid this is not the only problem the commit 94b1a603fca7 ("perf
stat: Add TopdownL1 metric as a default if present") in the
perf-tools-next branch introduced.

The topdown L2 in the perf stat default on SPR and big core of the ADL
is still missed. I don't see a possible fix for this on the current
perf-tools-next branch.

Thanks,
Kan
