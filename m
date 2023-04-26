Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9CA6EF5D9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241065AbjDZNx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240471AbjDZNxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:53:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDEC618E;
        Wed, 26 Apr 2023 06:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682517231; x=1714053231;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=3T7kOMxDiUDzT49gf01keEFfZf7FOAhw7PRQ1rP2MYw=;
  b=G1Nf3VXEIurmztnhARWPjT99xO3lm6h8/vItXuJC5GWuVhqqq+6MBwjR
   kt10MJwU0LnoaA7H4hDJ6UslmDFipVMD82ulQGxNzDL5fuaxo3w2cDJzQ
   vdE84UZeJGWqds48840OS/EQoc8lnQyBiPGk/61erZf93ema3n4BGbyAk
   pJhui3PaOvzYoXtuPHFhSklgs1tXgsBc5aa1GXJXuDYHuZIKa/3y2jHmh
   SaIc4yjUTYfPSRjYmhn3m5stnDU1MFY+YAVtKOdPmrwaxAvJusZKg42gk
   /vLuqe65n0KOIbeQjd9CIJWeuuhRJ9s5AoRso/hMS20awUjwC/aVDPVq8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="344564354"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="344564354"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 06:53:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="671354095"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="671354095"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 26 Apr 2023 06:53:50 -0700
Received: from [10.212.235.211] (kliang2-mobl1.ccr.corp.intel.com [10.212.235.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D309E580C9A;
        Wed, 26 Apr 2023 06:53:46 -0700 (PDT)
Message-ID: <bff481ba-e60a-763f-0aa0-3ee53302c480@linux.intel.com>
Date:   Wed, 26 Apr 2023 09:53:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 00/40] Fix perf on Intel hybrid CPUs
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230426070050.1315519-1-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230426070050.1315519-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-26 3:00 a.m., Ian Rogers wrote:
> TL;DR: hybrid doesn't crash, json metrics work on hybrid on both PMUs
> or individually, event parsing doesn't always scan all PMUs, more and
> new tests that also run without hybrid, less code.
> 
> The first patches were previously posted to improve metrics here:
> "perf stat: Introduce skippable evsels"
> https://lore.kernel.org/all/20230414051922.3625666-1-irogers@google.com/
> "perf vendor events intel: Add xxx metric constraints"
> https://lore.kernel.org/all/20230419005423.343862-1-irogers@google.com/
> 
> Next are some general test improvements.
> 
> Next event parsing is rewritten to not scan all PMUs for the benefit
> of raw and legacy cache parsing, instead these are handled by the
> lexer and a new term type. This ultimately removes the need for the
> event parser for hybrid to be recursive as legacy cache can be just a
> term. Tests are re-enabled for events with hyphens, so AMD's
> branch-brs event is now parsable.
> 
> The cputype option is made a generic pmu filter flag and is tested
> even on non-hybrid systems.
> 
> The final patches address specific json metric issues on hybrid, in
> both the json metrics and the metric code. They also bring in a new
> json option to not group events when matching a metricgroup, this
> helps reduce counter pressure for TopdownL1 and TopdownL2 metric
> groups. The updates to the script that updates the json are posted in:
> https://github.com/intel/perfmon/pull/73
> 
> The patches add slightly more code than they remove, in areas like
> better json metric constraints and tests, but in the core util code,
> the removal of hybrid is a net reduction:
>  20 files changed, 631 insertions(+), 951 deletions(-)
> 
> There's specific detail with each patch, but for now here is the 6.3
> output followed by that from perf-tools-next with the patch series
> applied. The tool is running on an Alderlake CPU on an elderly 5.15
> kernel:
> 
> Events on hybrid that parse and pass tests:
> '''
> $ perf-6.3 version
> perf version 6.3.rc7.gb7bc77e2f2c7
> $ perf-6.3 test
> ...
>   6.1: Test event parsing                       : FAILED!
> ...
> $ perf test
> ...
>   6: Parse event definition strings             :
>   6.1: Test event parsing                       : Ok
>   6.2: Parsing of all PMU events from sysfs     : Ok
>   6.3: Parsing of given PMU events from sysfs   : Ok
>   6.4: Parsing of aliased events from sysfs     : Skip (no aliases in sysfs)
>   6.5: Parsing of aliased events                : Ok
>   6.6: Parsing of terms (event modifiers)       : Ok
> ...
> '''
> 
> No event/metric running with json metrics and TopdownL1 on both PMUs:
> '''
> $ perf-6.3 stat -a sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>          24,073.58 msec cpu-clock                        #   23.975 CPUs utilized             
>                350      context-switches                 #   14.539 /sec                      
>                 25      cpu-migrations                   #    1.038 /sec                      
>                 66      page-faults                      #    2.742 /sec                      
>         21,257,199      cpu_core/cycles/                 #  883.009 K/sec                     
>          2,162,192      cpu_atom/cycles/                 #   89.816 K/sec                     
>          6,679,379      cpu_core/instructions/           #  277.457 K/sec                     
>            753,197      cpu_atom/instructions/           #   31.287 K/sec                     
>          1,300,647      cpu_core/branches/               #   54.028 K/sec                     
>            148,652      cpu_atom/branches/               #    6.175 K/sec                     
>            117,429      cpu_core/branch-misses/          #    4.878 K/sec                     
>             14,396      cpu_atom/branch-misses/          #  598.000 /sec                      
>        123,097,644      cpu_core/slots/                  #    5.113 M/sec                     
>          9,241,207      cpu_core/topdown-retiring/       #      7.5% Retiring                 
>          8,903,288      cpu_core/topdown-bad-spec/       #      7.2% Bad Speculation          
>         66,590,029      cpu_core/topdown-fe-bound/       #     54.1% Frontend Bound           
>         38,397,500      cpu_core/topdown-be-bound/       #     31.2% Backend Bound            
>          3,294,283      cpu_core/topdown-heavy-ops/      #      2.7% Heavy Operations          #      4.8% Light Operations         
>          8,855,769      cpu_core/topdown-br-mispredict/  #      7.2% Branch Mispredict         #      0.0% Machine Clears           
>         57,695,714      cpu_core/topdown-fetch-lat/      #     46.9% Fetch Latency             #      7.2% Fetch Bandwidth          
>         12,823,926      cpu_core/topdown-mem-bound/      #     10.4% Memory Bound              #     20.8% Core Bound               
> 
>        1.004093622 seconds time elapsed
> 
> $ perf stat -a sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>          24,064.65 msec cpu-clock                        #   23.973 CPUs utilized             
>                384      context-switches                 #   15.957 /sec                      
>                 24      cpu-migrations                   #    0.997 /sec                      
>                 71      page-faults                      #    2.950 /sec                      
>         19,737,646      cpu_core/cycles/                 #  820.192 K/sec                     
>        122,018,505      cpu_atom/cycles/                 #    5.070 M/sec                       (63.32%)
>          7,636,653      cpu_core/instructions/           #  317.339 K/sec                     
>         16,266,629      cpu_atom/instructions/           #  675.955 K/sec                       (72.50%)
>          1,552,995      cpu_core/branches/               #   64.534 K/sec                     
>          3,208,143      cpu_atom/branches/               #  133.314 K/sec                       (72.50%)
>            132,151      cpu_core/branch-misses/          #    5.491 K/sec                     
>            547,285      cpu_atom/branch-misses/          #   22.742 K/sec                       (72.49%)
>         32,110,597      cpu_atom/TOPDOWN_RETIRING.ALL/   #    1.334 M/sec                     
>                                                   #     18.4 %  tma_bad_speculation      (72.48%)
>        228,006,765      cpu_atom/TOPDOWN_FE_BOUND.ALL/   #    9.475 M/sec                     
>                                                   #     38.1 %  tma_frontend_bound       (72.47%)
>        225,866,251      cpu_atom/TOPDOWN_BE_BOUND.ALL/   #    9.386 M/sec                     
>                                                   #     37.7 %  tma_backend_bound      
>                                                   #     37.7 %  tma_backend_bound_aux    (72.73%)
>        119,748,254      cpu_atom/CPU_CLK_UNHALTED.CORE/  #    4.976 M/sec                     
>                                                   #      5.2 %  tma_retiring             (73.14%)
>         31,363,579      cpu_atom/TOPDOWN_RETIRING.ALL/   #    1.303 M/sec                       (73.37%)
>        227,907,321      cpu_atom/TOPDOWN_FE_BOUND.ALL/   #    9.471 M/sec                       (63.95%)
>        228,803,268      cpu_atom/TOPDOWN_BE_BOUND.ALL/   #    9.508 M/sec                       (63.55%)
>        113,357,334      cpu_core/TOPDOWN.SLOTS/          #     30.5 %  tma_backend_bound      
>                                                   #      9.2 %  tma_retiring           
>                                                   #      8.7 %  tma_bad_speculation    
>                                                   #     51.6 %  tma_frontend_bound     
>         10,451,044      cpu_core/topdown-retiring/                                            
>          9,687,449      cpu_core/topdown-bad-spec/                                            
>         58,703,214      cpu_core/topdown-fe-bound/                                            
>         34,540,660      cpu_core/topdown-be-bound/                                            
>            154,902      cpu_core/INT_MISC.UOP_DROPPING/  #    6.437 K/sec                     
> 
>        1.003818397 seconds time elapsed
> '''

Thanks for the fixes. That should work for -M or --topdown options.
But I don't think the above output is better than the 6.3 for the
*default* of perf stat?

- The multiplexing in the atom core messes up the other events.
- The "M/sec" seems useless for the Topdown events.
- The tma_* is not a generic name.
  "Retiring" is much better than "tma_retiring" as a generic annotation.
  It should works for both X86 and Arm.

As the default, it's better to provide a clean and generic ouptput for
the end users.

If the users want to know more details, they can use -M or --topdown
options. The events/formats are expected to be different among ARCHs.

Also, there should be a bug for all atom Topdown events. They are
displayed twice.

Thanks,
Kan
