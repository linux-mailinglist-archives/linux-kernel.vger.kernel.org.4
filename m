Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E00670F91A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbjEXOuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjEXOuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:50:04 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232FA186;
        Wed, 24 May 2023 07:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684939802; x=1716475802;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=5fdZE8CeYER2e0BohBw+9R2zBuKprSdnjb8+Hr/nphY=;
  b=Yq3qD5j3Isr+NNQaputYOt9KMO0PdZZl7MtaSM8/wg9YUarYhMifIMZb
   W6ZL7ND7QTWhpIF0P5Us6W/zfOXJBcIbFy8azJM9hg5vBXmqt2W+xT87p
   xb2rsl1rYJkItlQ/2odF2sJYpMGXUujPDwY1sAtqI2OEKlX7OFYotAtCi
   wPAtH9X31ZpvqjXwDUhxNEDFM4vGxglTggkytQ9a4vv9gcOAQupDyRBTy
   MHXFt1K67kkNNGrIP4uRsiUkQ8Nk16XfcvrJK/2Tg/YFO537cT+gbtvVz
   OZSWOBHnYUqbil4IV8tfHVmC8CeA4q18m8Cfm1tulrBt5ndRsR3e7bDUg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="352432552"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="352432552"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 07:50:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="707546634"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="707546634"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 24 May 2023 07:50:00 -0700
Received: from [10.255.229.190] (kliang2-mobl1.ccr.corp.intel.com [10.255.229.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id F384B580D5D;
        Wed, 24 May 2023 07:49:56 -0700 (PDT)
Message-ID: <a8f3654a-17d6-4b89-1b77-5f0116aa7254@linux.intel.com>
Date:   Wed, 24 May 2023 10:49:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 00/23] PMU refactoring and improvements
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
References: <20230522064330.189127-1-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230522064330.189127-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-22 2:43 a.m., Ian Rogers wrote:
> Separate the code in pmu.[ch] into the set/list of PMUs and the code
> for a particular PMU. Move the set/list of PMUs code into
> pmus.[ch]. Clean up hybrid code and remove hybrid PMU list, it is
> sufficient to scan PMUs looking for core ones. Add core PMU list and
> perf_pmus__scan_core that just reads core PMUs. Switch code that skips
> non-core PMUs during a perf_pmus__scan, to use the
> perf_pmus__scan_core variant. Don't scan sysfs for PMUs if all such
> PMUs have been previously scanned/loaded. Scanning just core PMUs, for
> the cases it is applicable, can improve the sysfs reading time by more
> than 4 fold on my laptop, as servers generally have many more uncore
> PMUs the improvement there should be larger:
> 
> ```
> $ perf bench internals pmu-scan -i 1000
> Computing performance of sysfs PMU event scan for 1000 times
>   Average core PMU scanning took: 989.231 usec (+- 1.535 usec)
>   Average PMU scanning took: 4309.425 usec (+- 74.322 usec)
> ```
> 
> The patch "perf pmu: Separate pmu and pmus" moves and renames a lot of
> functions, and is consequently large. The changes are trivial, but
> kept together to keep the overall number of patches more reasonable.
> 
> v2. Address Kan's review comments wrt "cycles" -> "cycles:P" and
>     "uncore_pmus" -> "other_pmus".
> 
> Ian Rogers (23):
>   perf tools: Warn if no user requested CPUs match PMU's CPUs
>   perf evlist: Remove evlist__warn_hybrid_group
>   perf evlist: Remove __evlist__add_default
>   perf evlist: Reduce scope of evlist__has_hybrid
>   perf pmu: Remove perf_pmu__hybrid_mounted
>   perf pmu: Detect ARM and hybrid PMUs with sysfs
>   perf pmu: Add is_core to pmu
>   perf pmu: Rewrite perf_pmu__has_hybrid to avoid list
>   perf x86: Iterate hybrid PMUs as core PMUs
>   perf topology: Avoid hybrid list for hybrid topology
>   perf evsel: Compute is_hybrid from PMU being core
>   perf header: Avoid hybrid PMU list in write_pmu_caps
>   perf metrics: Remove perf_pmu__is_hybrid use
>   perf stat: Avoid hybrid PMU list
>   perf mem: Avoid hybrid PMU list
>   perf pmu: Remove perf_pmu__hybrid_pmus list
>   perf pmus: Prefer perf_pmu__scan over perf_pmus__for_each_pmu
>   perf x86 mem: minor refactor to is_mem_loads_aux_event
>   perf pmu: Separate pmu and pmus
>   perf pmus: Split pmus list into core and other
>   perf pmus: Allow just core PMU scanning
>   perf pmus: Avoid repeated sysfs scanning
>   perf pmus: Ensure all PMUs are read for find_by_type


The patch set also triggers Segmentation fault with default mode on my
hybrid machine.

# ./perf stat sleep 1

 Performance counter stats for 'sleep 1':

              0.53 msec task-clock                       #    0.001 CPUs
utilized
                 1      context-switches                 #    1.875 K/sec
                 0      cpu-migrations                   #    0.000 /sec
                68      page-faults                      #  127.476 K/sec
Segmentation fault (core dumped)

Program received signal SIGSEGV, Segmentation fault.
evsel__is_hybrid (evsel=0x55555609a1a0) at util/evsel.c:3143
3143            return pmu->is_core;
(gdb) backtrace
#0  evsel__is_hybrid (evsel=0x55555609a1a0) at util/evsel.c:3143
#1  evsel__is_hybrid (evsel=evsel@entry=0x55555609a1a0) at util/evsel.c:3135
#2  0x0000555555759468 in hybrid_uniquify (config=0x555555f931e0
<stat_config>, evsel=0x55555609a1a0)
    at util/stat-display.c:813
#3  uniquify_counter (counter=0x55555609a1a0, config=0x555555f931e0
<stat_config>) at util/stat-display.c:818
#4  print_counter_aggrdata (config=config@entry=0x555555f931e0
<stat_config>,
    counter=counter@entry=0x55555609a1a0, aggr_idx=aggr_idx@entry=0,
os=os@entry=0x7fffffff8fe0)
    at util/stat-display.c:888
#5  0x000055555575b119 in print_counter (os=<optimized out>,
counter=<optimized out>, config=<optimized out>)
    at util/stat-display.c:1019
#6  print_counter (os=0x7fffffff8fe0, counter=0x55555609a1a0,
config=0x555555f931e0 <stat_config>)
    at util/stat-display.c:1009
#7  evlist__print_counters (evlist=0x555556029da0,
config=config@entry=0x555555f931e0 <stat_config>,
    _target=_target@entry=0x555555f42de0 <target>, ts=ts@entry=0x0,
argc=argc@entry=2,
    argv=argv@entry=0x7fffffffe1d0) at util/stat-display.c:1480
#8  0x000055555562009c in print_counters (argv=0x7fffffffe1d0, argc=2,
ts=0x0) at builtin-stat.c:979
#9  print_counters (argv=0x7fffffffe1d0, argc=2, ts=0x0) at
builtin-stat.c:971
#10 cmd_stat (argc=2, argv=0x7fffffffe1d0) at builtin-stat.c:2832
#11 0x00005555556b6670 in run_builtin (p=p@entry=0x555555f9c590
<commands+336>, argc=argc@entry=3,
    argv=argv@entry=0x7fffffffe1d0) at perf.c:323
#12 0x00005555555ff2d9 in handle_internal_command (argv=0x7fffffffe1d0,
argc=3) at perf.c:377
#13 run_argv (argv=<synthetic pointer>, argcp=<synthetic pointer>) at
perf.c:421
#14 main (argc=3, argv=0x7fffffffe1d0) at perf.c:537

Thanks,
Kan
> 
>  tools/perf/arch/arm/util/auxtrace.c   |   7 +-
>  tools/perf/arch/arm/util/cs-etm.c     |   4 +-
>  tools/perf/arch/arm64/util/pmu.c      |   6 +-
>  tools/perf/arch/x86/tests/hybrid.c    |   7 +-
>  tools/perf/arch/x86/util/auxtrace.c   |   5 +-
>  tools/perf/arch/x86/util/evlist.c     |  25 +-
>  tools/perf/arch/x86/util/evsel.c      |  27 +-
>  tools/perf/arch/x86/util/intel-bts.c  |   4 +-
>  tools/perf/arch/x86/util/intel-pt.c   |   4 +-
>  tools/perf/arch/x86/util/mem-events.c |  17 +-
>  tools/perf/arch/x86/util/perf_regs.c  |  15 +-
>  tools/perf/arch/x86/util/topdown.c    |   5 +-
>  tools/perf/bench/pmu-scan.c           |  60 ++--
>  tools/perf/builtin-c2c.c              |   9 +-
>  tools/perf/builtin-list.c             |   4 +-
>  tools/perf/builtin-mem.c              |   9 +-
>  tools/perf/builtin-record.c           |  29 +-
>  tools/perf/builtin-stat.c             |  15 +-
>  tools/perf/builtin-top.c              |  10 +-
>  tools/perf/tests/attr.c               |   4 +-
>  tools/perf/tests/event_groups.c       |   7 +-
>  tools/perf/tests/parse-events.c       |  15 +-
>  tools/perf/tests/parse-metric.c       |   4 +-
>  tools/perf/tests/pmu-events.c         |   6 +-
>  tools/perf/tests/switch-tracking.c    |   4 +-
>  tools/perf/tests/topology.c           |   4 +-
>  tools/perf/util/Build                 |   2 -
>  tools/perf/util/cpumap.h              |   2 +-
>  tools/perf/util/cputopo.c             |  16 +-
>  tools/perf/util/env.c                 |   5 +-
>  tools/perf/util/evlist-hybrid.c       | 162 ---------
>  tools/perf/util/evlist-hybrid.h       |  15 -
>  tools/perf/util/evlist.c              |  67 +++-
>  tools/perf/util/evlist.h              |   9 +-
>  tools/perf/util/evsel.c               |  57 +--
>  tools/perf/util/evsel.h               |   3 -
>  tools/perf/util/header.c              |  27 +-
>  tools/perf/util/mem-events.c          |  17 +-
>  tools/perf/util/metricgroup.c         |   9 +-
>  tools/perf/util/parse-events.c        |  24 +-
>  tools/perf/util/parse-events.y        |   3 +-
>  tools/perf/util/pfm.c                 |   6 +-
>  tools/perf/util/pmu-hybrid.c          |  52 ---
>  tools/perf/util/pmu-hybrid.h          |  32 --
>  tools/perf/util/pmu.c                 | 482 ++------------------------
>  tools/perf/util/pmu.h                 |  26 +-
>  tools/perf/util/pmus.c                | 477 ++++++++++++++++++++++++-
>  tools/perf/util/pmus.h                |  15 +-
>  tools/perf/util/print-events.c        |  15 +-
>  tools/perf/util/python-ext-sources    |   1 -
>  tools/perf/util/stat-display.c        |  21 +-
>  51 files changed, 819 insertions(+), 1032 deletions(-)
>  delete mode 100644 tools/perf/util/evlist-hybrid.c
>  delete mode 100644 tools/perf/util/evlist-hybrid.h
>  delete mode 100644 tools/perf/util/pmu-hybrid.c
>  delete mode 100644 tools/perf/util/pmu-hybrid.h
> 
