Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F25712C51
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237444AbjEZSRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjEZSRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:17:17 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEB412A;
        Fri, 26 May 2023 11:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685125032; x=1716661032;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=o3P5GMOHUbd1RynT+xVq4dnw3tawyMZSbeXlFyQDd1A=;
  b=gbo5vNywOta5U3Bs9JQzwOXT2iy/h/g/29nVGUCnXCFjBwEZuonFCUOx
   2QxMrDNgzWcb6B1WIKGgI+QOuV1WNYmQGD6nIoUL/qsgtSLuFgBIvJaa2
   BxL0o+xcm8yDmCJba+iUc+46JLQScXsTztVMFSYa0iQtYEAERPUI0qFAD
   3gHo0nJ62IKyFV3nqhfxjCTKAG4OOslPDFzWidMx4BAWoeriWqp5oQaZT
   o8UE1VsOx0vEs/D7mePviJZosJIr5ogQOZQPhLPA9HzrGRCHV0HsKVOzg
   1pLslJ+WbI3pYOQg+bHUBDayZQtkd5kZQOhul8pVfNSnY/wye1PhTaYOS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="353113061"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="353113061"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 11:17:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="795170762"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="795170762"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 26 May 2023 11:17:09 -0700
Received: from [10.209.100.85] (kliang2-mobl1.ccr.corp.intel.com [10.209.100.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C6AC95807E2;
        Fri, 26 May 2023 11:17:05 -0700 (PDT)
Message-ID: <ff66c90b-b59e-5720-dd88-f15311a74e50@linux.intel.com>
Date:   Fri, 26 May 2023 14:17:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v3 00/35] PMU refactoring and improvements
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
References: <20230524221831.1741381-1-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-24 6:17 p.m., Ian Rogers wrote:
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

Other than the small suggestion in patch 16, the patch set looks good to
me. Thanks Ian!

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> v3. Address fixing hybrid user specified CPU maps by doing it in
>     propagate maps. Remove nearly all references to cpu_core/cpu_atom
>     in particular by removing is_pmu_hybrid - hybrid is now >1 core
>     PMU. Addresses comments by Kan and Namhyung.
> v2. Address Kan's review comments wrt "cycles" -> "cycles:P" and
>     "uncore_pmus" -> "other_pmus".
> 
> Ian Rogers (35):
>   perf cpumap: Add intersect function
>   perf tests: Organize cpu_map tests into a single suite
>   perf cpumap: Add equal function
>   libperf cpumap: Add "any CPU"/dummy test function
>   perf pmu: Detect ARM and hybrid PMUs with sysfs
>   perf pmu: Add is_core to pmu
>   perf evsel: Add is_pmu_core inorder to interpret own_cpus
>   perf pmu: Add CPU map for "cpu" PMUs
>   perf evlist: Propagate user CPU maps intersecting core PMU maps
>   perf evlist: Allow has_user_cpus to be set on hybrid
>   perf target: Remove unused hybrid value
>   perf tools: Warn if no user requested CPUs match PMU's CPUs
>   perf evlist: Remove evlist__warn_hybrid_group
>   perf evlist: Remove __evlist__add_default
>   perf evlist: Reduce scope of evlist__has_hybrid
>   perf pmu: Remove perf_pmu__hybrid_mounted
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
>   perf pmus: Add function to return count of core PMUs
>   perf pmus: Remove perf_pmus__has_hybrid
>   perf pmu: Remove is_pmu_hybrid
> 
>  tools/lib/perf/cpumap.c                 |  61 +++
>  tools/lib/perf/evlist.c                 |  25 +-
>  tools/lib/perf/include/internal/evsel.h |   9 +
>  tools/lib/perf/include/perf/cpumap.h    |  14 +
>  tools/perf/arch/arm/util/auxtrace.c     |   7 +-
>  tools/perf/arch/arm/util/cs-etm.c       |   4 +-
>  tools/perf/arch/arm64/util/pmu.c        |   6 +-
>  tools/perf/arch/x86/tests/hybrid.c      |   7 +-
>  tools/perf/arch/x86/util/auxtrace.c     |   5 +-
>  tools/perf/arch/x86/util/evlist.c       |  25 +-
>  tools/perf/arch/x86/util/evsel.c        |  27 +-
>  tools/perf/arch/x86/util/intel-bts.c    |   4 +-
>  tools/perf/arch/x86/util/intel-pt.c     |   4 +-
>  tools/perf/arch/x86/util/mem-events.c   |  17 +-
>  tools/perf/arch/x86/util/perf_regs.c    |  15 +-
>  tools/perf/arch/x86/util/topdown.c      |   5 +-
>  tools/perf/bench/pmu-scan.c             |  60 +--
>  tools/perf/builtin-c2c.c                |   9 +-
>  tools/perf/builtin-list.c               |   4 +-
>  tools/perf/builtin-mem.c                |   9 +-
>  tools/perf/builtin-record.c             |  29 +-
>  tools/perf/builtin-stat.c               |  14 +-
>  tools/perf/builtin-top.c                |  10 +-
>  tools/perf/tests/attr.c                 |  11 +-
>  tools/perf/tests/builtin-test.c         |   4 +-
>  tools/perf/tests/cpumap.c               |  92 ++++-
>  tools/perf/tests/event_groups.c         |   7 +-
>  tools/perf/tests/parse-events.c         |  15 +-
>  tools/perf/tests/parse-metric.c         |   9 +-
>  tools/perf/tests/pmu-events.c           |   6 +-
>  tools/perf/tests/switch-tracking.c      |  14 +-
>  tools/perf/tests/tests.h                |   4 +-
>  tools/perf/tests/topology.c             |  16 +-
>  tools/perf/util/Build                   |   2 -
>  tools/perf/util/cpumap.c                |   4 +-
>  tools/perf/util/cpumap.h                |   4 +-
>  tools/perf/util/cputopo.c               |  12 +-
>  tools/perf/util/env.c                   |   5 +-
>  tools/perf/util/evlist-hybrid.c         | 162 --------
>  tools/perf/util/evlist-hybrid.h         |  15 -
>  tools/perf/util/evlist.c                |  64 +++-
>  tools/perf/util/evlist.h                |   9 +-
>  tools/perf/util/evsel.c                 |  60 +--
>  tools/perf/util/evsel.h                 |   3 -
>  tools/perf/util/header.c                |  27 +-
>  tools/perf/util/mem-events.c            |  25 +-
>  tools/perf/util/metricgroup.c           |   9 +-
>  tools/perf/util/parse-events.c          |  25 +-
>  tools/perf/util/parse-events.y          |   3 +-
>  tools/perf/util/pfm.c                   |   6 +-
>  tools/perf/util/pmu-hybrid.c            |  52 ---
>  tools/perf/util/pmu-hybrid.h            |  32 --
>  tools/perf/util/pmu.c                   | 483 ++----------------------
>  tools/perf/util/pmu.h                   |  25 +-
>  tools/perf/util/pmus.c                  | 465 ++++++++++++++++++++++-
>  tools/perf/util/pmus.h                  |  15 +-
>  tools/perf/util/print-events.c          |  15 +-
>  tools/perf/util/python-ext-sources      |   1 -
>  tools/perf/util/stat-display.c          |  19 +-
>  tools/perf/util/target.h                |   1 -
>  60 files changed, 1002 insertions(+), 1089 deletions(-)
>  delete mode 100644 tools/perf/util/evlist-hybrid.c
>  delete mode 100644 tools/perf/util/evlist-hybrid.h
>  delete mode 100644 tools/perf/util/pmu-hybrid.c
>  delete mode 100644 tools/perf/util/pmu-hybrid.h
> 
