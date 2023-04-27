Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243D16F0C48
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244638AbjD0TGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244628AbjD0TGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:06:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C2C4680;
        Thu, 27 Apr 2023 12:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682622407; x=1714158407;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ZkhXYTqDUCwk2f1u1Xh+MfGDv3R+8+CQvUHZgBzX/2g=;
  b=g9w3xBq+TxSpPEdfpl6FjeFcBgHfTwcFDXg+j6pzb9Tt7nSEG3HEYzDf
   0awawpk1WQY039zMRfKKeTxTzmdaGPzD89JZ/dy+5xbCvlWA2lKJgn4lL
   DDq+s5iQ+XsDfNqAZulN8V0iwl0ke6xHf7tz42nWqAA5U8Uy6wMIimVOI
   2rslISQYWs6uO8lQPS6EsAKktxpQJe0cBpf9Rtr+gAhTNCgDeyA96yOqR
   LiugtqBaHCD8NYnX8Agot5e+orvTpJNRVmX79nkF1bgGwvwh3w+jG4btD
   6+EBIYJSVqBs/UOvI+POB0dnTCHbP4riTaLrIOeBuwHZtYv7hRu7peG2n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="412897464"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="412897464"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:06:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="1024241952"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="1024241952"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 27 Apr 2023 12:06:45 -0700
Received: from [10.209.41.222] (kliang2-mobl1.ccr.corp.intel.com [10.209.41.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 898D0580CD0;
        Thu, 27 Apr 2023 12:06:41 -0700 (PDT)
Message-ID: <23a15658-e3f7-59f2-24b3-cfafe87f4145@linux.intel.com>
Date:   Thu, 27 Apr 2023 15:06:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 03/40] perf vendor events intel: Add icelake metric
 constraints
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
 <20230426070050.1315519-4-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230426070050.1315519-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-26 3:00 a.m., Ian Rogers wrote:
> Previously these constraints were disabled as they contained topdown
> events. Since:
> https://lore.kernel.org/all/20230312021543.3060328-9-irogers@google.com/
> the topdown events are correctly grouped even if no group exists.
> 
> This change was created by PR:
> https://github.com/intel/perfmon/pull/71
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  .../perf/pmu-events/arch/x86/icelake/icl-metrics.json | 11 +++++++++++

Since it targets fixing the hybrid issues, could you please move the
unrelated patch out of the series? A huge series is realy hard to be
reviewed.


Thanks,
Kan

>  1 file changed, 11 insertions(+)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
> index f45ae3483df4..cb58317860ea 100644
> --- a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
> @@ -311,6 +311,7 @@
>      },
>      {
>          "BriefDescription": "This metric represents overall arithmetic floating-point (FP) operations fraction the CPU has executed (retired)",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
>          "MetricExpr": "tma_x87_use + tma_fp_scalar + tma_fp_vector",
>          "MetricGroup": "HPC;TopdownL3;tma_L3_group;tma_light_operations_group",
>          "MetricName": "tma_fp_arith",
> @@ -413,6 +414,7 @@
>      },
>      {
>          "BriefDescription": "Branch Misprediction Cost: Fraction of TMA slots wasted per non-speculative branch misprediction (retired JEClear)",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
>          "MetricExpr": "(tma_branch_mispredicts + tma_fetch_latency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) * tma_info_slots / BR_MISP_RETIRED.ALL_BRANCHES",
>          "MetricGroup": "Bad;BrMispredicts;tma_issueBM",
>          "MetricName": "tma_info_branch_misprediction_cost",
> @@ -458,6 +460,7 @@
>      },
>      {
>          "BriefDescription": "Probability of Core Bound bottleneck hidden by SMT-profiling artifacts",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
>          "MetricExpr": "(100 * (1 - tma_core_bound / tma_ports_utilization if tma_core_bound < tma_ports_utilization else 1) if tma_info_smt_2t_utilization > 0.5 else 0)",
>          "MetricGroup": "Cor;SMT",
>          "MetricName": "tma_info_core_bound_likely",
> @@ -510,6 +513,7 @@
>      },
>      {
>          "BriefDescription": "Total pipeline cost of DSB (uop cache) misses - subset of the Instruction_Fetch_BW Bottleneck",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
>          "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb + tma_lsd + tma_mite))",
>          "MetricGroup": "DSBmiss;Fed;tma_issueFB",
>          "MetricName": "tma_info_dsb_misses",
> @@ -591,6 +595,7 @@
>      },
>      {
>          "BriefDescription": "Total pipeline cost of instruction fetch bandwidth related bottlenecks",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
>          "MetricExpr": "100 * (tma_frontend_bound - tma_fetch_latency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) - tma_info_big_code",
>          "MetricGroup": "Fed;FetchBW;Frontend",
>          "MetricName": "tma_info_instruction_fetch_bw",
> @@ -929,6 +934,7 @@
>      },
>      {
>          "BriefDescription": "Total pipeline cost of Memory Address Translation related bottlenecks (data-side TLBs)",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
>          "MetricExpr": "100 * tma_memory_bound * (tma_l1_bound / max(tma_memory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (tma_dtlb_load / max(tma_l1_bound, tma_4k_aliasing + tma_dtlb_load + tma_fb_full + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (tma_dtlb_store / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tma_store_latency + tma_streaming_stores)))",
>          "MetricGroup": "Mem;MemoryTLB;Offcore;tma_issueTLB",
>          "MetricName": "tma_info_memory_data_tlbs",
> @@ -937,6 +943,7 @@
>      },
>      {
>          "BriefDescription": "Total pipeline cost of Memory Latency related bottlenecks (external memory and off-core caches)",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
>          "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (tma_l3_hit_latency / (tma_contested_accesses + tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_l2_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound))",
>          "MetricGroup": "Mem;MemoryLat;Offcore;tma_issueLat",
>          "MetricName": "tma_info_memory_latency",
> @@ -945,6 +952,7 @@
>      },
>      {
>          "BriefDescription": "Total pipeline cost of Branch Misprediction related bottlenecks",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
>          "MetricExpr": "100 * (tma_branch_mispredicts + tma_fetch_latency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
>          "MetricGroup": "Bad;BadSpec;BrMispredicts;tma_issueBM",
>          "MetricName": "tma_info_mispredictions",
> @@ -996,6 +1004,7 @@
>      },
>      {
>          "BriefDescription": "Average number of Uops retired in cycles where at least one uop has retired.",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
>          "MetricExpr": "tma_retiring * tma_info_slots / cpu@UOPS_RETIRED.SLOTS\\,cmask\\=1@",
>          "MetricGroup": "Pipeline;Ret",
>          "MetricName": "tma_info_retire"
> @@ -1196,6 +1205,7 @@
>      },
>      {
>          "BriefDescription": "This metric represents fraction of slots where the CPU was retiring memory operations -- uops for memory load or store accesses.",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
>          "MetricExpr": "tma_light_operations * MEM_INST_RETIRED.ANY / INST_RETIRED.ANY",
>          "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operations_group",
>          "MetricName": "tma_memory_operations",
> @@ -1266,6 +1276,7 @@
>      },
>      {
>          "BriefDescription": "This metric represents the remaining light uops fraction the CPU has executed - remaining means not covered by other sibling nodes",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
>          "MetricExpr": "max(0, tma_light_operations - (tma_fp_arith + tma_memory_operations + tma_branch_instructions + tma_nop_instructions))",
>          "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operations_group",
>          "MetricName": "tma_other_light_ops",
