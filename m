Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881566E654A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjDRNEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjDRNEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:04:13 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491B1167D3;
        Tue, 18 Apr 2023 06:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681823021; x=1713359021;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W4laPTnxn8gRjHlLf35lx4tyRIr+YXGAtg+gDUCc6ws=;
  b=SZLHPlTZQI5NKjZiWHgLzRs1tIAta8CpNJj8HQMugIzamjNMKokPfuCR
   kmud4BxZp9yD8VhpouyPc+MhU1My3ltBbaQ3U1BLqMSaJgHumVGMXR8/w
   nKCFdNW5TNtY0f6DypkFunAC2Mx0zUpj2v1/h1BDTVAunI9YkBL1Y2xqA
   dONh+uQL+GoKQXf4cWMb5avA71J72iHghtBbdn9m6whIOD5+sZ8NEQq5u
   ZwNVK7Qt0MEHa1wUaShfn456095clm1JEPXjhHfl8OAZvgdcRrJsr60Ki
   4FTkGVoz9arq3eXsOyHJ0dPQ9X1lQfUbNQkYwK/ICo55NhIAjEZ6ZEaR6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="342651927"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="342651927"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 06:03:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="693610902"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="693610902"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 18 Apr 2023 06:03:32 -0700
Received: from [10.209.125.134] (kliang2-mobl1.ccr.corp.intel.com [10.209.125.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 18DA0580B56;
        Tue, 18 Apr 2023 06:03:30 -0700 (PDT)
Message-ID: <d1fe801a-22d0-1f9b-b127-227b21635bd5@linux.intel.com>
Date:   Tue, 18 Apr 2023 09:03:30 -0400
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
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fWRy4NEqhB6-b98+m7SV5=oyBOMVuOHwmvKZCJuXcsQEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-17 2:13 p.m., Ian Rogers wrote:
> The json TopdownL1 is enabled if present unconditionally for perf stat
> default. Enabling it on Skylake has multiplexing as TopdownL1 on
> Skylake has multiplexing unrelated to this change - at least on the
> machine I was testing on. We can remove the metric group TopdownL1 on
> Skylake so that we don't enable it by default, there is still the
> group TmaL1. To me, disabling TopdownL1 seems less desirable than
> running with multiplexing - previously to get into topdown analysis
> there has to be knowledge that "perf stat -M TopdownL1" is the way to
> do this.

To be honest, I don't think it's a good idea to remove the TopdownL1. We
cannot remove it just because the new way cannot handle it. The perf
stat default works well until 6.3-rc7. It's a regression issue of the
current perf-tools-next.

But I'm OK to add some flags with the metrics to assist the perf tool to
specially handle the case if you prefer to modify the event list.

> 
> This doesn't relate to this change which is about making it so that
> failing to set up TopdownL1 doesn't cause an early exit. The reason I
> showed TigerLake output was that on TigerLake the skip/fallback
> approach works while Skylake just needs the events disabled/skipped
> unless it has sufficient permissions. Note the :u on the events in:

The perf_event_open() should be good to detect the insufficient
permission, but it doesn't work to detect an existing of an event.
That's because the kernel only checks the features not specific events.
It's not a reliable way to rely on the output of the perf_event_open() here.


>> From your test result in the v2 description, we can see that there is no
>> TopdownL1, which is good and expected. However, there is a (48.99%) with
>> cycles:u event, which implies multiplexing. Could you please check
>> what's the problem here?
>> Also, if it's because of the backgroud, all the events should be
>> multiplexing. But it looks like only cycle:u has multiplexing. Other
>> events, instructions:u, branches:u and branch-misses:u work without
>> multiplexing. That's very strange.
> I wasn't able to reproduce it and suspect it was a transient thing. I
> think there are multiplexing things to look into, 2 events on a fixed
> counter on Icelake+ will trigger multiplexing on all counters, and
> Skylake's 3 fixed and 4 generic should fit TopdownL1.

Just found a cascade lake. With this patch + the current
perf-tools-next, partial of the TopdownL1 and multiplexing can still be
observed.

$ sudo ./perf stat true

 Performance counter stats for 'true':

              2.91 msec task-clock                       #    0.316 CPUs
utilized
                 0      context-switches                 #    0.000 /sec
                 0      cpu-migrations                   #    0.000 /sec
                45      page-faults                      #   15.474 K/sec
         2,819,972      cycles                           #    0.970 GHz
                       (60.14%)
         5,391,406      instructions                     #    1.91  insn
per cycle
         1,068,575      branches                         #  367.442 M/sec
             8,455      branch-misses                    #    0.79% of
all branches
            70,283      CPU_CLK_UNHALTED.REF_XCLK        #   24.168
M/sec
            48,806      INT_MISC.RECOVERY_CYCLES_ANY     #   16.783
M/sec                       (39.86%)

       0.009204517 seconds time elapsed

       0.000000000 seconds user
       0.009614000 seconds sys


Thanks,
Kan
