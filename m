Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815BE6F605C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 22:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjECU6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 16:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjECU6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 16:58:03 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E8F8A52;
        Wed,  3 May 2023 13:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683147468; x=1714683468;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=kDWJPccnX7Juh6OeI51ySr5bPYrksMkW1c+XhtllAqY=;
  b=BTIAZDir/sUpT6KVq+TzinLzahJAyjiFxCQt048plUj5Ct7rZzO07dSM
   EFEgn/RTOGQJXOH1AMuYDfk/5ykIBHItf21eMW0c5EdfXYKU61ZqJmHR6
   tWBskGbgMmJ/0yceFlvXvjPXWWM7vi77sFJBmWjiZJH7KS9aMHsGe2ybK
   LxeWibdLsjDmEphS/FcrPxaDuNxlojiRUa8GPFmBsI+KKBGNSiX48KLBp
   DTVZQ75k0M4md04WesJ3sLPbh+zPgJydhaEAlmM+1uJdDuCPXegHQ+Fqj
   7eFOrMxlQ8ZFqzUpv22i0RvYgqd8o6bE2FnfkFygRAe/sKT4H/DFQI0zE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="411922289"
X-IronPort-AV: E=Sophos;i="5.99,248,1677571200"; 
   d="scan'208";a="411922289"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 13:57:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="727297535"
X-IronPort-AV: E=Sophos;i="5.99,248,1677571200"; 
   d="scan'208";a="727297535"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 03 May 2023 13:57:45 -0700
Received: from [10.209.46.175] (kliang2-mobl1.ccr.corp.intel.com [10.209.46.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id ADBF1580569;
        Wed,  3 May 2023 13:57:41 -0700 (PDT)
Message-ID: <0be4aeef-9c91-5ab2-637b-688a11ceda53@linux.intel.com>
Date:   Wed, 3 May 2023 16:57:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 03/44] perf metric: Json flag to not group events if
 gathering a metric group
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
References: <20230502223851.2234828-1-irogers@google.com>
 <20230502223851.2234828-4-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230502223851.2234828-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-02 6:38 p.m., Ian Rogers wrote:
> Some metric groups have metrics that don't have fully overlapping
> events, meaning that the group's events become unique event groups
> that may need to multiplex with each other. This can be particularly
> unfortunate when the groups wouldn't need to multiplex because there
> are sufficient hardware counters.
> 
> Add a flag so that if recording a metric group then the metrics within
> the group needn't use groups for their events. The flag is added to
> Intel TopdownL1 and TopdownL2 metrics.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  .../arch/x86/alderlake/adl-metrics.json       | 26 +++++++++++++++++++
>  .../arch/x86/alderlaken/adln-metrics.json     | 14 ++++++++++
>  .../arch/x86/broadwell/bdw-metrics.json       | 12 +++++++++
>  .../arch/x86/broadwellde/bdwde-metrics.json   | 12 +++++++++
>  .../arch/x86/broadwellx/bdx-metrics.json      | 12 +++++++++
>  .../arch/x86/cascadelakex/clx-metrics.json    | 12 +++++++++
>  .../arch/x86/haswell/hsw-metrics.json         | 12 +++++++++
>  .../arch/x86/haswellx/hsx-metrics.json        | 12 +++++++++
>  .../arch/x86/icelake/icl-metrics.json         | 12 +++++++++
>  .../arch/x86/icelakex/icx-metrics.json        | 12 +++++++++
>  .../arch/x86/ivybridge/ivb-metrics.json       | 12 +++++++++
>  .../arch/x86/ivytown/ivt-metrics.json         | 12 +++++++++
>  .../arch/x86/jaketown/jkt-metrics.json        | 12 +++++++++
>  .../arch/x86/sandybridge/snb-metrics.json     | 12 +++++++++
>  .../arch/x86/sapphirerapids/spr-metrics.json  | 12 +++++++++
>  .../arch/x86/skylake/skl-metrics.json         | 12 +++++++++
>  .../arch/x86/skylakex/skx-metrics.json        | 12 +++++++++
>  .../arch/x86/tigerlake/tgl-metrics.json       | 12 +++++++++
>  tools/perf/pmu-events/jevents.py              |  4 ++-
>  tools/perf/pmu-events/pmu-events.h            |  1 +
>  tools/perf/util/metricgroup.c                 |  8 +++---
>  21 files changed, 240 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> index 75d80e70e5cd..1f9047553942 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> @@ -133,6 +133,7 @@
>          "MetricGroup": "TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.1",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "Counts the total number of issue slots  that were not consumed by the backend due to backend stalls.  Note that uops must be available for consumption in order for this event to count.  If a uop is not available (IQ is empty), this event will not count.   The rest of these subevents count backend stalls, in cycles, due to an outstanding request which is memory bound vs core bound.   The subevents are not slot based events and therefore can not be precisely added or subtracted from the Backend_Bound_Aux subevents which are slot based.",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
> @@ -143,6 +144,7 @@
>          "MetricGroup": "TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound_aux",
>          "MetricThreshold": "tma_backend_bound_aux > 0.2",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "Counts the total number of issue slots  that were not consumed by the backend due to backend stalls.  Note that UOPS must be available for consumption in order for this event to count.  If a uop is not available (IQ is empty), this event will not count.  All of these subevents count backend stalls, in slots, due to a resource limitation.   These are not cycle based events and therefore can not be precisely added or subtracted from the Backend_Bound subevents which are cycle based.  These subevents are supplementary to Backend_Bound and can be used to analyze results from a resource perspective at allocation.",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
> @@ -153,6 +155,7 @@
>          "MetricGroup": "TopdownL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "Counts the total number of issue slots that were not consumed by the backend because allocation is stalled due to a mispredicted jump or a machine clear. Only issue slots wasted due to fast nukes such as memory ordering nukes are counted. Other nukes are not accounted for. Counts all issue slots blocked during this recovery window including relevant microcode flows and while uops are not yet available in the instruction queue (IQ). Also includes the issue slots that were consumed by the backend but were thrown away because they were younger than the mispredict or machine clear.",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
> @@ -163,6 +166,7 @@
>          "MetricGroup": "TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_base",
>          "MetricThreshold": "tma_base > 0.6",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
> @@ -182,6 +186,7 @@
>          "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
>          "MetricName": "tma_branch_mispredicts",
>          "MetricThreshold": "tma_branch_mispredicts > 0.05",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
> @@ -209,6 +214,7 @@
>          "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_core_bound",
>          "MetricThreshold": "tma_core_bound > 0.1",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
> @@ -255,6 +261,7 @@
>          "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
>          "MetricName": "tma_fetch_bandwidth",
>          "MetricThreshold": "tma_fetch_bandwidth > 0.1",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
> @@ -264,6 +271,7 @@
>          "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
>          "MetricName": "tma_fetch_latency",
>          "MetricThreshold": "tma_fetch_latency > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
> @@ -291,6 +299,7 @@
>          "MetricGroup": "TopdownL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
> @@ -593,6 +602,7 @@
>          "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
>          "MetricName": "tma_machine_clears",
>          "MetricThreshold": "tma_machine_clears > 0.05",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
> @@ -611,6 +621,7 @@
>          "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_memory_bound",
>          "MetricThreshold": "tma_memory_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
> @@ -629,6 +640,7 @@
>          "MetricGroup": "TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_ms_uops",
>          "MetricThreshold": "tma_ms_uops > 0.05",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "Counts the number of uops that are from the complex flows issued by the micro-sequencer (MS).  This includes uops from flows due to complex instructions, faults, assists, and inserted flows.",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
> @@ -729,6 +741,7 @@
>          "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_aux_group",
>          "MetricName": "tma_resource_bound",
>          "MetricThreshold": "tma_resource_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "Counts the total number of issue slots  that were not consumed by the backend due to backend stalls.  Note that uops must be available for consumption in order for this event to count.  If a uop is not available (IQ is empty), this event will not count.",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
> @@ -739,6 +752,7 @@
>          "MetricGroup": "TopdownL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.75",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
> @@ -848,6 +862,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
> @@ -858,6 +873,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
> @@ -868,6 +884,7 @@
>          "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueBM",
>          "MetricName": "tma_branch_mispredicts",
>          "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Branch Misprediction.  These slots are either wasted by uops fetched from an incorrectly speculated program path; or stalls when the out-of-order part of the machine needs to recover its state from a speculative path. Sample with: TOPDOWN.BR_MISPREDICT_SLOTS. Related metrics: tma_info_branch_misprediction_cost, tma_info_mispredictions, tma_mispredicts_resteers",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
> @@ -919,6 +936,7 @@
>          "MetricGroup": "Backend;Compute;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_core_bound",
>          "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where Core non-memory issues were of a bottleneck.  Shortage in hardware compute resources; or dependencies in software's instructions are both categorized under Core Bound. Hence it may indicate the machine ran out of an out-of-order resource; certain execution units are overloaded or dependencies in program's data- or instruction-flow are limiting the performance (e.g. FP-chained long-latency arithmetic operations).",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
> @@ -1031,6 +1049,7 @@
>          "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group;tma_issueFB",
>          "MetricName": "tma_fetch_bandwidth",
>          "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_ipc / 6 > 0.35",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend bandwidth issues.  For example; inefficiencies at the instruction decoders; or restrictions for caching in the DSB (decoded uops cache) are categorized under Fetch Bandwidth. In such cases; the Frontend typically delivers suboptimal amount of uops to the Backend. Sample with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_switches, tma_info_dsb_coverage, tma_info_dsb_misses, tma_info_iptb, tma_lcp",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
> @@ -1041,6 +1060,7 @@
>          "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group",
>          "MetricName": "tma_fetch_latency",
>          "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend latency issues.  For example; instruction-cache misses; iTLB misses or fetch stalls after a branch misprediction are categorized under Frontend Latency. In such cases; the Frontend eventually delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_16_PS;FRONTEND_RETIRED.LATENCY_GE_8_PS",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
> @@ -1121,6 +1141,7 @@
>          "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. Sample with: FRONTEND_RETIRED.LATENCY_GE_4_PS",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
> @@ -1141,6 +1162,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_heavy_operations",
>          "MetricThreshold": "tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring heavy-weight operations -- instructions that require two or more uops or micro-coded sequences. This highly-correlates with the uop length of these instructions/sequences. Sample with: UOPS_RETIRED.HEAVY",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
> @@ -2023,6 +2045,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_light_operations",
>          "MetricThreshold": "tma_light_operations > 0.6",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring light-weight operations -- instructions that require no more than one uop (micro-operation). This correlates with total number of instructions used by the program. A uops-per-instruction (see UopPI metric) ratio of 1 or less should be expected for decently optimized software running on Intel Core/Xeon products. While this often indicates efficient X86 instructions were executed; high value does not necessarily mean better performance cannot be achieved. Sample with: INST_RETIRED.PREC_DIST",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
> @@ -2082,6 +2105,7 @@
>          "MetricGroup": "BadSpec;MachineClears;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
>          "MetricName": "tma_machine_clears",
>          "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Machine Clears.  These slots are either wasted by uops fetched prior to the clear; or stalls the out-of-order portion of the machine needs to recover its state after the clear. For example; this can happen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modifying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: tma_clears_resteers, tma_contested_accesses, tma_data_sharing, tma_false_sharing, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_remote_cache",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
> @@ -2112,6 +2136,7 @@
>          "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_memory_bound",
>          "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the Memory subsystem within the Backend was a bottleneck.  Memory Bound estimates fraction of slots where pipeline is likely stalled due to demand load or store instructions. This accounts mainly for (1) non-completed in-flight memory demand loads which coincides with execution units starvation; in addition to (2) cases where stores could impose backpressure on the pipeline when many of them get buffered at the same time (less common out of the two).",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
> @@ -2310,6 +2335,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.SLOTS",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
> diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json b/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
> index 1a85d935c733..0402adbf7d92 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
> @@ -98,6 +98,7 @@
>          "MetricGroup": "TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.1",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "Counts the total number of issue slots  that were not consumed by the backend due to backend stalls.  Note that uops must be available for consumption in order for this event to count.  If a uop is not available (IQ is empty), this event will not count.   The rest of these subevents count backend stalls, in cycles, due to an outstanding request which is memory bound vs core bound.   The subevents are not slot based events and therefore can not be precisely added or subtracted from the Backend_Bound_Aux subevents which are slot based.",
>          "ScaleUnit": "100%"
>      },
> @@ -107,6 +108,7 @@
>          "MetricGroup": "TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound_aux",
>          "MetricThreshold": "tma_backend_bound_aux > 0.2",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "Counts the total number of issue slots  that were not consumed by the backend due to backend stalls.  Note that UOPS must be available for consumption in order for this event to count.  If a uop is not available (IQ is empty), this event will not count.  All of these subevents count backend stalls, in slots, due to a resource limitation.   These are not cycle based events and therefore can not be precisely added or subtracted from the Backend_Bound subevents which are cycle based.  These subevents are supplementary to Backend_Bound and can be used to analyze results from a resource perspective at allocation.",
>          "ScaleUnit": "100%"
>      },
> @@ -116,6 +118,7 @@
>          "MetricGroup": "TopdownL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "Counts the total number of issue slots that were not consumed by the backend because allocation is stalled due to a mispredicted jump or a machine clear. Only issue slots wasted due to fast nukes such as memory ordering nukes are counted. Other nukes are not accounted for. Counts all issue slots blocked during this recovery window including relevant microcode flows and while uops are not yet available in the instruction queue (IQ). Also includes the issue slots that were consumed by the backend but were thrown away because they were younger than the mispredict or machine clear.",
>          "ScaleUnit": "100%"
>      },
> @@ -125,6 +128,7 @@
>          "MetricGroup": "TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_base",
>          "MetricThreshold": "tma_base > 0.6",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "ScaleUnit": "100%"
>      },
>      {
> @@ -142,6 +146,7 @@
>          "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
>          "MetricName": "tma_branch_mispredicts",
>          "MetricThreshold": "tma_branch_mispredicts > 0.05",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "ScaleUnit": "100%"
>      },
>      {
> @@ -166,6 +171,7 @@
>          "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_core_bound",
>          "MetricThreshold": "tma_core_bound > 0.1",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "ScaleUnit": "100%"
>      },
>      {
> @@ -207,6 +213,7 @@
>          "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
>          "MetricName": "tma_fetch_bandwidth",
>          "MetricThreshold": "tma_fetch_bandwidth > 0.1",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "ScaleUnit": "100%"
>      },
>      {
> @@ -215,6 +222,7 @@
>          "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
>          "MetricName": "tma_fetch_latency",
>          "MetricThreshold": "tma_fetch_latency > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "ScaleUnit": "100%"
>      },
>      {
> @@ -239,6 +247,7 @@
>          "MetricGroup": "TopdownL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "ScaleUnit": "100%"
>      },
>      {
> @@ -499,6 +508,7 @@
>          "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
>          "MetricName": "tma_machine_clears",
>          "MetricThreshold": "tma_machine_clears > 0.05",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "ScaleUnit": "100%"
>      },
>      {
> @@ -515,6 +525,7 @@
>          "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_memory_bound",
>          "MetricThreshold": "tma_memory_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "ScaleUnit": "100%"
>      },
>      {
> @@ -531,6 +542,7 @@
>          "MetricGroup": "TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_ms_uops",
>          "MetricThreshold": "tma_ms_uops > 0.05",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "Counts the number of uops that are from the complex flows issued by the micro-sequencer (MS).  This includes uops from flows due to complex instructions, faults, assists, and inserted flows.",
>          "ScaleUnit": "100%"
>      },
> @@ -620,6 +632,7 @@
>          "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_aux_group",
>          "MetricName": "tma_resource_bound",
>          "MetricThreshold": "tma_resource_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "Counts the total number of issue slots  that were not consumed by the backend due to backend stalls.  Note that uops must be available for consumption in order for this event to count.  If a uop is not available (IQ is empty), this event will not count.",
>          "ScaleUnit": "100%"
>      },
> @@ -629,6 +642,7 @@
>          "MetricGroup": "TopdownL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.75",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "ScaleUnit": "100%"
>      },
>      {
> diff --git a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> index 51cf8560a8d3..f9e2316601e1 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> @@ -103,6 +103,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
>          "ScaleUnit": "100%"
>      },
> @@ -112,6 +113,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
>          "ScaleUnit": "100%"
>      },
> @@ -122,6 +124,7 @@
>          "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueBM",
>          "MetricName": "tma_branch_mispredicts",
>          "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Branch Misprediction.  These slots are either wasted by uops fetched from an incorrectly speculated program path; or stalls when the out-of-order part of the machine needs to recover its state from a speculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics: tma_info_branch_misprediction_cost, tma_mispredicts_resteers",
>          "ScaleUnit": "100%"
>      },
> @@ -170,6 +173,7 @@
>          "MetricGroup": "Backend;Compute;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_core_bound",
>          "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where Core non-memory issues were of a bottleneck.  Shortage in hardware compute resources; or dependencies in software's instructions are both categorized under Core Bound. Hence it may indicate the machine ran out of an out-of-order resource; certain execution units are overloaded or dependencies in program's data- or instruction-flow are limiting the performance (e.g. FP-chained long-latency arithmetic operations).",
>          "ScaleUnit": "100%"
>      },
> @@ -263,6 +267,7 @@
>          "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group;tma_issueFB",
>          "MetricName": "tma_fetch_bandwidth",
>          "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_ipc / 4 > 0.35",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend bandwidth issues.  For example; inefficiencies at the instruction decoders; or restrictions for caching in the DSB (decoded uops cache) are categorized under Fetch Bandwidth. In such cases; the Frontend typically delivers suboptimal amount of uops to the Backend. Related metrics: tma_dsb_switches, tma_info_dsb_coverage, tma_info_iptb, tma_lcp",
>          "ScaleUnit": "100%"
>      },
> @@ -272,6 +277,7 @@
>          "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group",
>          "MetricName": "tma_fetch_latency",
>          "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend latency issues.  For example; instruction-cache misses; iTLB misses or fetch stalls after a branch misprediction are categorized under Frontend Latency. In such cases; the Frontend eventually delivers no uops for some period. Sample with: RS_EVENTS.EMPTY_END",
>          "ScaleUnit": "100%"
>      },
> @@ -326,6 +332,7 @@
>          "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
>          "ScaleUnit": "100%"
>      },
> @@ -335,6 +342,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_heavy_operations",
>          "MetricThreshold": "tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring heavy-weight operations -- instructions that require two or more uops or micro-coded sequences. This highly-correlates with the uop length of these instructions/sequences.",
>          "ScaleUnit": "100%"
>      },
> @@ -828,6 +836,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_light_operations",
>          "MetricThreshold": "tma_light_operations > 0.6",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring light-weight operations -- instructions that require no more than one uop (micro-operation). This correlates with total number of instructions used by the program. A uops-per-instruction (see UopPI metric) ratio of 1 or less should be expected for decently optimized software running on Intel Core/Xeon products. While this often indicates efficient X86 instructions were executed; high value does not necessarily mean better performance cannot be achieved. Sample with: INST_RETIRED.PREC_DIST",
>          "ScaleUnit": "100%"
>      },
> @@ -858,6 +867,7 @@
>          "MetricGroup": "BadSpec;MachineClears;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
>          "MetricName": "tma_machine_clears",
>          "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Machine Clears.  These slots are either wasted by uops fetched prior to the clear; or stalls the out-of-order portion of the machine needs to recover its state after the clear. For example; this can happen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modifying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: tma_clears_resteers, tma_contested_accesses, tma_data_sharing, tma_false_sharing, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_remote_cache",
>          "ScaleUnit": "100%"
>      },
> @@ -886,6 +896,7 @@
>          "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_memory_bound",
>          "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the Memory subsystem within the Backend was a bottleneck.  Memory Bound estimates fraction of slots where pipeline is likely stalled due to demand load or store instructions. This accounts mainly for (1) non-completed in-flight memory demand loads which coincides with execution units starvation; in addition to (2) cases where stores could impose backpressure on the pipeline when many of them get buffered at the same time (less common out of the two).",
>          "ScaleUnit": "100%"
>      },
> @@ -1048,6 +1059,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.RETIRE_SLOTS",
>          "ScaleUnit": "100%"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> index fb57c7382408..e9c46d336a8e 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> @@ -97,6 +97,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
>          "ScaleUnit": "100%"
>      },
> @@ -106,6 +107,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
>          "ScaleUnit": "100%"
>      },
> @@ -116,6 +118,7 @@
>          "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueBM",
>          "MetricName": "tma_branch_mispredicts",
>          "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Branch Misprediction.  These slots are either wasted by uops fetched from an incorrectly speculated program path; or stalls when the out-of-order part of the machine needs to recover its state from a speculative path. Sample with: TOPDOWN.BR_MISPREDICT_SLOTS. Related metrics: tma_info_branch_misprediction_cost, tma_mispredicts_resteers",
>          "ScaleUnit": "100%"
>      },
> @@ -164,6 +167,7 @@
>          "MetricGroup": "Backend;Compute;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_core_bound",
>          "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where Core non-memory issues were of a bottleneck.  Shortage in hardware compute resources; or dependencies in software's instructions are both categorized under Core Bound. Hence it may indicate the machine ran out of an out-of-order resource; certain execution units are overloaded or dependencies in program's data- or instruction-flow are limiting the performance (e.g. FP-chained long-latency arithmetic operations).",
>          "ScaleUnit": "100%"
>      },
> @@ -248,6 +252,7 @@
>          "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group;tma_issueFB",
>          "MetricName": "tma_fetch_bandwidth",
>          "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_ipc / 4 > 0.35",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend bandwidth issues.  For example; inefficiencies at the instruction decoders; or restrictions for caching in the DSB (decoded uops cache) are categorized under Fetch Bandwidth. In such cases; the Frontend typically delivers suboptimal amount of uops to the Backend. Sample with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_switches, tma_info_dsb_coverage, tma_info_iptb, tma_lcp",
>          "ScaleUnit": "100%"
>      },
> @@ -257,6 +262,7 @@
>          "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group",
>          "MetricName": "tma_fetch_latency",
>          "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend latency issues.  For example; instruction-cache misses; iTLB misses or fetch stalls after a branch misprediction are categorized under Frontend Latency. In such cases; the Frontend eventually delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_16_PS;FRONTEND_RETIRED.LATENCY_GE_8_PS",
>          "ScaleUnit": "100%"
>      },
> @@ -311,6 +317,7 @@
>          "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. Sample with: FRONTEND_RETIRED.LATENCY_GE_4_PS",
>          "ScaleUnit": "100%"
>      },
> @@ -320,6 +327,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_heavy_operations",
>          "MetricThreshold": "tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring heavy-weight operations -- instructions that require two or more uops or micro-coded sequences. This highly-correlates with the uop length of these instructions/sequences.",
>          "ScaleUnit": "100%"
>      },
> @@ -795,6 +803,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_light_operations",
>          "MetricThreshold": "tma_light_operations > 0.6",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring light-weight operations -- instructions that require no more than one uop (micro-operation). This correlates with total number of instructions used by the program. A uops-per-instruction (see UopPI metric) ratio of 1 or less should be expected for decently optimized software running on Intel Core/Xeon products. While this often indicates efficient X86 instructions were executed; high value does not necessarily mean better performance cannot be achieved. Sample with: INST_RETIRED.PREC_DIST",
>          "ScaleUnit": "100%"
>      },
> @@ -825,6 +834,7 @@
>          "MetricGroup": "BadSpec;MachineClears;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
>          "MetricName": "tma_machine_clears",
>          "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Machine Clears.  These slots are either wasted by uops fetched prior to the clear; or stalls the out-of-order portion of the machine needs to recover its state after the clear. For example; this can happen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modifying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: tma_clears_resteers, tma_contested_accesses, tma_data_sharing, tma_false_sharing, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_remote_cache",
>          "ScaleUnit": "100%"
>      },
> @@ -853,6 +863,7 @@
>          "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_memory_bound",
>          "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the Memory subsystem within the Backend was a bottleneck.  Memory Bound estimates fraction of slots where pipeline is likely stalled due to demand load or store instructions. This accounts mainly for (1) non-completed in-flight memory demand loads which coincides with execution units starvation; in addition to (2) cases where stores could impose backpressure on the pipeline when many of them get buffered at the same time (less common out of the two).",
>          "ScaleUnit": "100%"
>      },
> @@ -1013,6 +1024,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.SLOTS",
>          "ScaleUnit": "100%"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
> index 65ec0c9e55d1..437b9867acb9 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
> @@ -103,6 +103,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
>          "ScaleUnit": "100%"
>      },
> @@ -112,6 +113,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
>          "ScaleUnit": "100%"
>      },
> @@ -122,6 +124,7 @@
>          "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueBM",
>          "MetricName": "tma_branch_mispredicts",
>          "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Branch Misprediction.  These slots are either wasted by uops fetched from an incorrectly speculated program path; or stalls when the out-of-order part of the machine needs to recover its state from a speculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics: tma_info_branch_misprediction_cost, tma_mispredicts_resteers",
>          "ScaleUnit": "100%"
>      },
> @@ -170,6 +173,7 @@
>          "MetricGroup": "Backend;Compute;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_core_bound",
>          "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where Core non-memory issues were of a bottleneck.  Shortage in hardware compute resources; or dependencies in software's instructions are both categorized under Core Bound. Hence it may indicate the machine ran out of an out-of-order resource; certain execution units are overloaded or dependencies in program's data- or instruction-flow are limiting the performance (e.g. FP-chained long-latency arithmetic operations).",
>          "ScaleUnit": "100%"
>      },
> @@ -263,6 +267,7 @@
>          "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group;tma_issueFB",
>          "MetricName": "tma_fetch_bandwidth",
>          "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_ipc / 4 > 0.35",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend bandwidth issues.  For example; inefficiencies at the instruction decoders; or restrictions for caching in the DSB (decoded uops cache) are categorized under Fetch Bandwidth. In such cases; the Frontend typically delivers suboptimal amount of uops to the Backend. Related metrics: tma_dsb_switches, tma_info_dsb_coverage, tma_info_iptb, tma_lcp",
>          "ScaleUnit": "100%"
>      },
> @@ -272,6 +277,7 @@
>          "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group",
>          "MetricName": "tma_fetch_latency",
>          "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend latency issues.  For example; instruction-cache misses; iTLB misses or fetch stalls after a branch misprediction are categorized under Frontend Latency. In such cases; the Frontend eventually delivers no uops for some period. Sample with: RS_EVENTS.EMPTY_END",
>          "ScaleUnit": "100%"
>      },
> @@ -326,6 +332,7 @@
>          "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
>          "ScaleUnit": "100%"
>      },
> @@ -335,6 +342,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_heavy_operations",
>          "MetricThreshold": "tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring heavy-weight operations -- instructions that require two or more uops or micro-coded sequences. This highly-correlates with the uop length of these instructions/sequences.",
>          "ScaleUnit": "100%"
>      },
> @@ -829,6 +837,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_light_operations",
>          "MetricThreshold": "tma_light_operations > 0.6",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring light-weight operations -- instructions that require no more than one uop (micro-operation). This correlates with total number of instructions used by the program. A uops-per-instruction (see UopPI metric) ratio of 1 or less should be expected for decently optimized software running on Intel Core/Xeon products. While this often indicates efficient X86 instructions were executed; high value does not necessarily mean better performance cannot be achieved. Sample with: INST_RETIRED.PREC_DIST",
>          "ScaleUnit": "100%"
>      },
> @@ -869,6 +878,7 @@
>          "MetricGroup": "BadSpec;MachineClears;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
>          "MetricName": "tma_machine_clears",
>          "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Machine Clears.  These slots are either wasted by uops fetched prior to the clear; or stalls the out-of-order portion of the machine needs to recover its state after the clear. For example; this can happen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modifying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: tma_clears_resteers, tma_contested_accesses, tma_data_sharing, tma_false_sharing, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_remote_cache",
>          "ScaleUnit": "100%"
>      },
> @@ -897,6 +907,7 @@
>          "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_memory_bound",
>          "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the Memory subsystem within the Backend was a bottleneck.  Memory Bound estimates fraction of slots where pipeline is likely stalled due to demand load or store instructions. This accounts mainly for (1) non-completed in-flight memory demand loads which coincides with execution units starvation; in addition to (2) cases where stores could impose backpressure on the pipeline when many of them get buffered at the same time (less common out of the two).",
>          "ScaleUnit": "100%"
>      },
> @@ -1079,6 +1090,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.RETIRE_SLOTS",
>          "ScaleUnit": "100%"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> index 8f7dc72accd0..875c766222e3 100644
> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> @@ -101,6 +101,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
>          "ScaleUnit": "100%"
>      },
> @@ -110,6 +111,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
>          "ScaleUnit": "100%"
>      },
> @@ -120,6 +122,7 @@
>          "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueBM",
>          "MetricName": "tma_branch_mispredicts",
>          "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Branch Misprediction.  These slots are either wasted by uops fetched from an incorrectly speculated program path; or stalls when the out-of-order part of the machine needs to recover its state from a speculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics: tma_info_branch_misprediction_cost, tma_info_mispredictions, tma_mispredicts_resteers",
>          "ScaleUnit": "100%"
>      },
> @@ -167,6 +170,7 @@
>          "MetricGroup": "Backend;Compute;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_core_bound",
>          "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where Core non-memory issues were of a bottleneck.  Shortage in hardware compute resources; or dependencies in software's instructions are both categorized under Core Bound. Hence it may indicate the machine ran out of an out-of-order resource; certain execution units are overloaded or dependencies in program's data- or instruction-flow are limiting the performance (e.g. FP-chained long-latency arithmetic operations).",
>          "ScaleUnit": "100%"
>      },
> @@ -271,6 +275,7 @@
>          "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group;tma_issueFB",
>          "MetricName": "tma_fetch_bandwidth",
>          "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_ipc / 4 > 0.35",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend bandwidth issues.  For example; inefficiencies at the instruction decoders; or restrictions for caching in the DSB (decoded uops cache) are categorized under Fetch Bandwidth. In such cases; the Frontend typically delivers suboptimal amount of uops to the Backend. Sample with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_switches, tma_info_dsb_coverage, tma_info_dsb_misses, tma_info_iptb, tma_lcp",
>          "ScaleUnit": "100%"
>      },
> @@ -280,6 +285,7 @@
>          "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group",
>          "MetricName": "tma_fetch_latency",
>          "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend latency issues.  For example; instruction-cache misses; iTLB misses or fetch stalls after a branch misprediction are categorized under Frontend Latency. In such cases; the Frontend eventually delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_16_PS;FRONTEND_RETIRED.LATENCY_GE_8_PS",
>          "ScaleUnit": "100%"
>      },
> @@ -354,6 +360,7 @@
>          "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. Sample with: FRONTEND_RETIRED.LATENCY_GE_4_PS",
>          "ScaleUnit": "100%"
>      },
> @@ -372,6 +379,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_heavy_operations",
>          "MetricThreshold": "tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring heavy-weight operations -- instructions that require two or more uops or micro-coded sequences. This highly-correlates with the uop length of these instructions/sequences.",
>          "ScaleUnit": "100%"
>      },
> @@ -1142,6 +1150,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_light_operations",
>          "MetricThreshold": "tma_light_operations > 0.6",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring light-weight operations -- instructions that require no more than one uop (micro-operation). This correlates with total number of instructions used by the program. A uops-per-instruction (see UopPI metric) ratio of 1 or less should be expected for decently optimized software running on Intel Core/Xeon products. While this often indicates efficient X86 instructions were executed; high value does not necessarily mean better performance cannot be achieved. Sample with: INST_RETIRED.PREC_DIST",
>          "ScaleUnit": "100%"
>      },
> @@ -1196,6 +1205,7 @@
>          "MetricGroup": "BadSpec;MachineClears;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
>          "MetricName": "tma_machine_clears",
>          "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Machine Clears.  These slots are either wasted by uops fetched prior to the clear; or stalls the out-of-order portion of the machine needs to recover its state after the clear. For example; this can happen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modifying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: tma_clears_resteers, tma_contested_accesses, tma_data_sharing, tma_false_sharing, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_remote_cache",
>          "ScaleUnit": "100%"
>      },
> @@ -1224,6 +1234,7 @@
>          "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_memory_bound",
>          "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the Memory subsystem within the Backend was a bottleneck.  Memory Bound estimates fraction of slots where pipeline is likely stalled due to demand load or store instructions. This accounts mainly for (1) non-completed in-flight memory demand loads which coincides with execution units starvation; in addition to (2) cases where stores could impose backpressure on the pipeline when many of them get buffered at the same time (less common out of the two).",
>          "ScaleUnit": "100%"
>      },
> @@ -1458,6 +1469,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.RETIRE_SLOTS",
>          "ScaleUnit": "100%"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json b/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
> index 2528418200bb..9570a88d6d1c 100644
> --- a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
> @@ -103,6 +103,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
>          "ScaleUnit": "100%"
>      },
> @@ -112,6 +113,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
>          "ScaleUnit": "100%"
>      },
> @@ -122,6 +124,7 @@
>          "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueBM",
>          "MetricName": "tma_branch_mispredicts",
>          "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Branch Misprediction.  These slots are either wasted by uops fetched from an incorrectly speculated program path; or stalls when the out-of-order part of the machine needs to recover its state from a speculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics: tma_info_branch_misprediction_cost, tma_mispredicts_resteers",
>          "ScaleUnit": "100%"
>      },
> @@ -161,6 +164,7 @@
>          "MetricGroup": "Backend;Compute;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_core_bound",
>          "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where Core non-memory issues were of a bottleneck.  Shortage in hardware compute resources; or dependencies in software's instructions are both categorized under Core Bound. Hence it may indicate the machine ran out of an out-of-order resource; certain execution units are overloaded or dependencies in program's data- or instruction-flow are limiting the performance (e.g. FP-chained long-latency arithmetic operations).",
>          "ScaleUnit": "100%"
>      },
> @@ -254,6 +258,7 @@
>          "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group;tma_issueFB",
>          "MetricName": "tma_fetch_bandwidth",
>          "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_ipc / 4 > 0.35",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend bandwidth issues.  For example; inefficiencies at the instruction decoders; or restrictions for caching in the DSB (decoded uops cache) are categorized under Fetch Bandwidth. In such cases; the Frontend typically delivers suboptimal amount of uops to the Backend. Related metrics: tma_dsb_switches, tma_info_dsb_coverage, tma_info_iptb, tma_lcp",
>          "ScaleUnit": "100%"
>      },
> @@ -263,6 +268,7 @@
>          "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group",
>          "MetricName": "tma_fetch_latency",
>          "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend latency issues.  For example; instruction-cache misses; iTLB misses or fetch stalls after a branch misprediction are categorized under Frontend Latency. In such cases; the Frontend eventually delivers no uops for some period. Sample with: RS_EVENTS.EMPTY_END",
>          "ScaleUnit": "100%"
>      },
> @@ -272,6 +278,7 @@
>          "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
>          "ScaleUnit": "100%"
>      },
> @@ -281,6 +288,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_heavy_operations",
>          "MetricThreshold": "tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring heavy-weight operations -- instructions that require two or more uops or micro-coded sequences. This highly-correlates with the uop length of these instructions/sequences.",
>          "ScaleUnit": "100%"
>      },
> @@ -663,6 +671,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_light_operations",
>          "MetricThreshold": "tma_light_operations > 0.6",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring light-weight operations -- instructions that require no more than one uop (micro-operation). This correlates with total number of instructions used by the program. A uops-per-instruction (see UopPI metric) ratio of 1 or less should be expected for decently optimized software running on Intel Core/Xeon products. While this often indicates efficient X86 instructions were executed; high value does not necessarily mean better performance cannot be achieved. Sample with: INST_RETIRED.PREC_DIST",
>          "ScaleUnit": "100%"
>      },
> @@ -693,6 +702,7 @@
>          "MetricGroup": "BadSpec;MachineClears;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
>          "MetricName": "tma_machine_clears",
>          "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Machine Clears.  These slots are either wasted by uops fetched prior to the clear; or stalls the out-of-order portion of the machine needs to recover its state after the clear. For example; this can happen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modifying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: tma_clears_resteers, tma_contested_accesses, tma_data_sharing, tma_false_sharing, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_remote_cache",
>          "ScaleUnit": "100%"
>      },
> @@ -721,6 +731,7 @@
>          "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_memory_bound",
>          "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the Memory subsystem within the Backend was a bottleneck.  Memory Bound estimates fraction of slots where pipeline is likely stalled due to demand load or store instructions. This accounts mainly for (1) non-completed in-flight memory demand loads which coincides with execution units starvation; in addition to (2) cases where stores could impose backpressure on the pipeline when many of them get buffered at the same time (less common out of the two).",
>          "ScaleUnit": "100%"
>      },
> @@ -874,6 +885,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.RETIRE_SLOTS",
>          "ScaleUnit": "100%"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
> index 11f152c346eb..a522202cf684 100644
> --- a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
> @@ -103,6 +103,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
>          "ScaleUnit": "100%"
>      },
> @@ -112,6 +113,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
>          "ScaleUnit": "100%"
>      },
> @@ -122,6 +124,7 @@
>          "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueBM",
>          "MetricName": "tma_branch_mispredicts",
>          "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Branch Misprediction.  These slots are either wasted by uops fetched from an incorrectly speculated program path; or stalls when the out-of-order part of the machine needs to recover its state from a speculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics: tma_info_branch_misprediction_cost, tma_mispredicts_resteers",
>          "ScaleUnit": "100%"
>      },
> @@ -161,6 +164,7 @@
>          "MetricGroup": "Backend;Compute;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_core_bound",
>          "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where Core non-memory issues were of a bottleneck.  Shortage in hardware compute resources; or dependencies in software's instructions are both categorized under Core Bound. Hence it may indicate the machine ran out of an out-of-order resource; certain execution units are overloaded or dependencies in program's data- or instruction-flow are limiting the performance (e.g. FP-chained long-latency arithmetic operations).",
>          "ScaleUnit": "100%"
>      },
> @@ -254,6 +258,7 @@
>          "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group;tma_issueFB",
>          "MetricName": "tma_fetch_bandwidth",
>          "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_ipc / 4 > 0.35",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend bandwidth issues.  For example; inefficiencies at the instruction decoders; or restrictions for caching in the DSB (decoded uops cache) are categorized under Fetch Bandwidth. In such cases; the Frontend typically delivers suboptimal amount of uops to the Backend. Related metrics: tma_dsb_switches, tma_info_dsb_coverage, tma_info_iptb, tma_lcp",
>          "ScaleUnit": "100%"
>      },
> @@ -263,6 +268,7 @@
>          "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group",
>          "MetricName": "tma_fetch_latency",
>          "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend latency issues.  For example; instruction-cache misses; iTLB misses or fetch stalls after a branch misprediction are categorized under Frontend Latency. In such cases; the Frontend eventually delivers no uops for some period. Sample with: RS_EVENTS.EMPTY_END",
>          "ScaleUnit": "100%"
>      },
> @@ -272,6 +278,7 @@
>          "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
>          "ScaleUnit": "100%"
>      },
> @@ -281,6 +288,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_heavy_operations",
>          "MetricThreshold": "tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring heavy-weight operations -- instructions that require two or more uops or micro-coded sequences. This highly-correlates with the uop length of these instructions/sequences.",
>          "ScaleUnit": "100%"
>      },
> @@ -664,6 +672,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_light_operations",
>          "MetricThreshold": "tma_light_operations > 0.6",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring light-weight operations -- instructions that require no more than one uop (micro-operation). This correlates with total number of instructions used by the program. A uops-per-instruction (see UopPI metric) ratio of 1 or less should be expected for decently optimized software running on Intel Core/Xeon products. While this often indicates efficient X86 instructions were executed; high value does not necessarily mean better performance cannot be achieved. Sample with: INST_RETIRED.PREC_DIST",
>          "ScaleUnit": "100%"
>      },
> @@ -704,6 +713,7 @@
>          "MetricGroup": "BadSpec;MachineClears;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
>          "MetricName": "tma_machine_clears",
>          "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Machine Clears.  These slots are either wasted by uops fetched prior to the clear; or stalls the out-of-order portion of the machine needs to recover its state after the clear. For example; this can happen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modifying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: tma_clears_resteers, tma_contested_accesses, tma_data_sharing, tma_false_sharing, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_remote_cache",
>          "ScaleUnit": "100%"
>      },
> @@ -732,6 +742,7 @@
>          "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_memory_bound",
>          "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the Memory subsystem within the Backend was a bottleneck.  Memory Bound estimates fraction of slots where pipeline is likely stalled due to demand load or store instructions. This accounts mainly for (1) non-completed in-flight memory demand loads which coincides with execution units starvation; in addition to (2) cases where stores could impose backpressure on the pipeline when many of them get buffered at the same time (less common out of the two).",
>          "ScaleUnit": "100%"
>      },
> @@ -905,6 +916,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.RETIRE_SLOTS",
>          "ScaleUnit": "100%"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
> index f45ae3483df4..1a2154f28b7b 100644
> --- a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
> @@ -115,6 +115,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
>          "ScaleUnit": "100%"
>      },
> @@ -124,6 +125,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
>          "ScaleUnit": "100%"
>      },
> @@ -141,6 +143,7 @@
>          "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueBM",
>          "MetricName": "tma_branch_mispredicts",
>          "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Branch Misprediction.  These slots are either wasted by uops fetched from an incorrectly speculated program path; or stalls when the out-of-order part of the machine needs to recover its state from a speculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics: tma_info_branch_misprediction_cost, tma_info_mispredictions, tma_mispredicts_resteers",
>          "ScaleUnit": "100%"
>      },
> @@ -187,6 +190,7 @@
>          "MetricGroup": "Backend;Compute;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_core_bound",
>          "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where Core non-memory issues were of a bottleneck.  Shortage in hardware compute resources; or dependencies in software's instructions are both categorized under Core Bound. Hence it may indicate the machine ran out of an out-of-order resource; certain execution units are overloaded or dependencies in program's data- or instruction-flow are limiting the performance (e.g. FP-chained long-latency arithmetic operations).",
>          "ScaleUnit": "100%"
>      },
> @@ -288,6 +292,7 @@
>          "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group;tma_issueFB",
>          "MetricName": "tma_fetch_bandwidth",
>          "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_ipc / 5 > 0.35",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend bandwidth issues.  For example; inefficiencies at the instruction decoders; or restrictions for caching in the DSB (decoded uops cache) are categorized under Fetch Bandwidth. In such cases; the Frontend typically delivers suboptimal amount of uops to the Backend. Sample with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_switches, tma_info_dsb_coverage, tma_info_dsb_misses, tma_info_iptb, tma_lcp",
>          "ScaleUnit": "100%"
>      },
> @@ -297,6 +302,7 @@
>          "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group",
>          "MetricName": "tma_fetch_latency",
>          "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend latency issues.  For example; instruction-cache misses; iTLB misses or fetch stalls after a branch misprediction are categorized under Frontend Latency. In such cases; the Frontend eventually delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_16_PS;FRONTEND_RETIRED.LATENCY_GE_8_PS",
>          "ScaleUnit": "100%"
>      },
> @@ -369,6 +375,7 @@
>          "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. Sample with: FRONTEND_RETIRED.LATENCY_GE_4_PS",
>          "ScaleUnit": "100%"
>      },
> @@ -378,6 +385,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_heavy_operations",
>          "MetricThreshold": "tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring heavy-weight operations -- instructions that require two or more uops or micro-coded sequences. This highly-correlates with the uop length of these instructions/sequences.",
>          "ScaleUnit": "100%"
>      },
> @@ -1111,6 +1119,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_light_operations",
>          "MetricThreshold": "tma_light_operations > 0.6",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring light-weight operations -- instructions that require no more than one uop (micro-operation). This correlates with total number of instructions used by the program. A uops-per-instruction (see UopPI metric) ratio of 1 or less should be expected for decently optimized software running on Intel Core/Xeon products. While this often indicates efficient X86 instructions were executed; high value does not necessarily mean better performance cannot be achieved. Sample with: INST_RETIRED.PREC_DIST",
>          "ScaleUnit": "100%"
>      },
> @@ -1164,6 +1173,7 @@
>          "MetricGroup": "BadSpec;MachineClears;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
>          "MetricName": "tma_machine_clears",
>          "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Machine Clears.  These slots are either wasted by uops fetched prior to the clear; or stalls the out-of-order portion of the machine needs to recover its state after the clear. For example; this can happen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modifying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: tma_clears_resteers, tma_contested_accesses, tma_data_sharing, tma_false_sharing, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_remote_cache",
>          "ScaleUnit": "100%"
>      },
> @@ -1191,6 +1201,7 @@
>          "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_memory_bound",
>          "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the Memory subsystem within the Backend was a bottleneck.  Memory Bound estimates fraction of slots where pipeline is likely stalled due to demand load or store instructions. This accounts mainly for (1) non-completed in-flight memory demand loads which coincides with execution units starvation; in addition to (2) cases where stores could impose backpressure on the pipeline when many of them get buffered at the same time (less common out of the two).",
>          "ScaleUnit": "100%"
>      },
> @@ -1360,6 +1371,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.SLOTS",
>          "ScaleUnit": "100%"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
> index 0f9b174dfc22..1ef772b40e04 100644
> --- a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
> @@ -80,6 +80,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
>          "ScaleUnit": "100%"
>      },
> @@ -89,6 +90,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
>          "ScaleUnit": "100%"
>      },
> @@ -106,6 +108,7 @@
>          "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueBM",
>          "MetricName": "tma_branch_mispredicts",
>          "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Branch Misprediction.  These slots are either wasted by uops fetched from an incorrectly speculated program path; or stalls when the out-of-order part of the machine needs to recover its state from a speculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics: tma_info_branch_misprediction_cost, tma_info_mispredictions, tma_mispredicts_resteers",
>          "ScaleUnit": "100%"
>      },
> @@ -152,6 +155,7 @@
>          "MetricGroup": "Backend;Compute;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_core_bound",
>          "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where Core non-memory issues were of a bottleneck.  Shortage in hardware compute resources; or dependencies in software's instructions are both categorized under Core Bound. Hence it may indicate the machine ran out of an out-of-order resource; certain execution units are overloaded or dependencies in program's data- or instruction-flow are limiting the performance (e.g. FP-chained long-latency arithmetic operations).",
>          "ScaleUnit": "100%"
>      },
> @@ -253,6 +257,7 @@
>          "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group;tma_issueFB",
>          "MetricName": "tma_fetch_bandwidth",
>          "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_ipc / 5 > 0.35",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend bandwidth issues.  For example; inefficiencies at the instruction decoders; or restrictions for caching in the DSB (decoded uops cache) are categorized under Fetch Bandwidth. In such cases; the Frontend typically delivers suboptimal amount of uops to the Backend. Sample with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_switches, tma_info_dsb_coverage, tma_info_dsb_misses, tma_info_iptb, tma_lcp",
>          "ScaleUnit": "100%"
>      },
> @@ -262,6 +267,7 @@
>          "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group",
>          "MetricName": "tma_fetch_latency",
>          "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend latency issues.  For example; instruction-cache misses; iTLB misses or fetch stalls after a branch misprediction are categorized under Frontend Latency. In such cases; the Frontend eventually delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_16_PS;FRONTEND_RETIRED.LATENCY_GE_8_PS",
>          "ScaleUnit": "100%"
>      },
> @@ -334,6 +340,7 @@
>          "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. Sample with: FRONTEND_RETIRED.LATENCY_GE_4_PS",
>          "ScaleUnit": "100%"
>      },
> @@ -343,6 +350,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_heavy_operations",
>          "MetricThreshold": "tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring heavy-weight operations -- instructions that require two or more uops or micro-coded sequences. This highly-correlates with the uop length of these instructions/sequences.",
>          "ScaleUnit": "100%"
>      },
> @@ -1134,6 +1142,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_light_operations",
>          "MetricThreshold": "tma_light_operations > 0.6",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring light-weight operations -- instructions that require no more than one uop (micro-operation). This correlates with total number of instructions used by the program. A uops-per-instruction (see UopPI metric) ratio of 1 or less should be expected for decently optimized software running on Intel Core/Xeon products. While this often indicates efficient X86 instructions were executed; high value does not necessarily mean better performance cannot be achieved. Sample with: INST_RETIRED.PREC_DIST",
>          "ScaleUnit": "100%"
>      },
> @@ -1187,6 +1196,7 @@
>          "MetricGroup": "BadSpec;MachineClears;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
>          "MetricName": "tma_machine_clears",
>          "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Machine Clears.  These slots are either wasted by uops fetched prior to the clear; or stalls the out-of-order portion of the machine needs to recover its state after the clear. For example; this can happen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modifying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: tma_clears_resteers, tma_contested_accesses, tma_data_sharing, tma_false_sharing, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_remote_cache",
>          "ScaleUnit": "100%"
>      },
> @@ -1214,6 +1224,7 @@
>          "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_memory_bound",
>          "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the Memory subsystem within the Backend was a bottleneck.  Memory Bound estimates fraction of slots where pipeline is likely stalled due to demand load or store instructions. This accounts mainly for (1) non-completed in-flight memory demand loads which coincides with execution units starvation; in addition to (2) cases where stores could impose backpressure on the pipeline when many of them get buffered at the same time (less common out of the two).",
>          "ScaleUnit": "100%"
>      },
> @@ -1410,6 +1421,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.SLOTS",
>          "ScaleUnit": "100%"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
> index 5247f69c13b6..11080ccffd51 100644
> --- a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
> @@ -103,6 +103,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
>          "ScaleUnit": "100%"
>      },
> @@ -112,6 +113,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
>          "ScaleUnit": "100%"
>      },
> @@ -122,6 +124,7 @@
>          "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueBM",
>          "MetricName": "tma_branch_mispredicts",
>          "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Branch Misprediction.  These slots are either wasted by uops fetched from an incorrectly speculated program path; or stalls when the out-of-order part of the machine needs to recover its state from a speculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics: tma_info_branch_misprediction_cost, tma_mispredicts_resteers",
>          "ScaleUnit": "100%"
>      },
> @@ -161,6 +164,7 @@
>          "MetricGroup": "Backend;Compute;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_core_bound",
>          "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where Core non-memory issues were of a bottleneck.  Shortage in hardware compute resources; or dependencies in software's instructions are both categorized under Core Bound. Hence it may indicate the machine ran out of an out-of-order resource; certain execution units are overloaded or dependencies in program's data- or instruction-flow are limiting the performance (e.g. FP-chained long-latency arithmetic operations).",
>          "ScaleUnit": "100%"
>      },
> @@ -254,6 +258,7 @@
>          "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group;tma_issueFB",
>          "MetricName": "tma_fetch_bandwidth",
>          "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_ipc / 4 > 0.35",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend bandwidth issues.  For example; inefficiencies at the instruction decoders; or restrictions for caching in the DSB (decoded uops cache) are categorized under Fetch Bandwidth. In such cases; the Frontend typically delivers suboptimal amount of uops to the Backend. Related metrics: tma_dsb_switches, tma_info_dsb_coverage, tma_info_iptb, tma_lcp",
>          "ScaleUnit": "100%"
>      },
> @@ -263,6 +268,7 @@
>          "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group",
>          "MetricName": "tma_fetch_latency",
>          "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend latency issues.  For example; instruction-cache misses; iTLB misses or fetch stalls after a branch misprediction are categorized under Frontend Latency. In such cases; the Frontend eventually delivers no uops for some period. Sample with: RS_EVENTS.EMPTY_END",
>          "ScaleUnit": "100%"
>      },
> @@ -299,6 +305,7 @@
>          "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
>          "ScaleUnit": "100%"
>      },
> @@ -308,6 +315,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_heavy_operations",
>          "MetricThreshold": "tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring heavy-weight operations -- instructions that require two or more uops or micro-coded sequences. This highly-correlates with the uop length of these instructions/sequences.",
>          "ScaleUnit": "100%"
>      },
> @@ -724,6 +732,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_light_operations",
>          "MetricThreshold": "tma_light_operations > 0.6",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring light-weight operations -- instructions that require no more than one uop (micro-operation). This correlates with total number of instructions used by the program. A uops-per-instruction (see UopPI metric) ratio of 1 or less should be expected for decently optimized software running on Intel Core/Xeon products. While this often indicates efficient X86 instructions were executed; high value does not necessarily mean better performance cannot be achieved. Sample with: INST_RETIRED.PREC_DIST",
>          "ScaleUnit": "100%"
>      },
> @@ -754,6 +763,7 @@
>          "MetricGroup": "BadSpec;MachineClears;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
>          "MetricName": "tma_machine_clears",
>          "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Machine Clears.  These slots are either wasted by uops fetched prior to the clear; or stalls the out-of-order portion of the machine needs to recover its state after the clear. For example; this can happen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modifying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: tma_clears_resteers, tma_contested_accesses, tma_data_sharing, tma_false_sharing, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_remote_cache",
>          "ScaleUnit": "100%"
>      },
> @@ -782,6 +792,7 @@
>          "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_memory_bound",
>          "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the Memory subsystem within the Backend was a bottleneck.  Memory Bound estimates fraction of slots where pipeline is likely stalled due to demand load or store instructions. This accounts mainly for (1) non-completed in-flight memory demand loads which coincides with execution units starvation; in addition to (2) cases where stores could impose backpressure on the pipeline when many of them get buffered at the same time (less common out of the two).",
>          "ScaleUnit": "100%"
>      },
> @@ -917,6 +928,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.RETIRE_SLOTS",
>          "ScaleUnit": "100%"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
> index 89469b10fa30..65a46d659c0a 100644
> --- a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
> @@ -103,6 +103,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
>          "ScaleUnit": "100%"
>      },
> @@ -112,6 +113,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
>          "ScaleUnit": "100%"
>      },
> @@ -122,6 +124,7 @@
>          "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueBM",
>          "MetricName": "tma_branch_mispredicts",
>          "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Branch Misprediction.  These slots are either wasted by uops fetched from an incorrectly speculated program path; or stalls when the out-of-order part of the machine needs to recover its state from a speculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics: tma_info_branch_misprediction_cost, tma_mispredicts_resteers",
>          "ScaleUnit": "100%"
>      },
> @@ -161,6 +164,7 @@
>          "MetricGroup": "Backend;Compute;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_core_bound",
>          "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where Core non-memory issues were of a bottleneck.  Shortage in hardware compute resources; or dependencies in software's instructions are both categorized under Core Bound. Hence it may indicate the machine ran out of an out-of-order resource; certain execution units are overloaded or dependencies in program's data- or instruction-flow are limiting the performance (e.g. FP-chained long-latency arithmetic operations).",
>          "ScaleUnit": "100%"
>      },
> @@ -254,6 +258,7 @@
>          "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group;tma_issueFB",
>          "MetricName": "tma_fetch_bandwidth",
>          "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_ipc / 4 > 0.35",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend bandwidth issues.  For example; inefficiencies at the instruction decoders; or restrictions for caching in the DSB (decoded uops cache) are categorized under Fetch Bandwidth. In such cases; the Frontend typically delivers suboptimal amount of uops to the Backend. Related metrics: tma_dsb_switches, tma_info_dsb_coverage, tma_info_iptb, tma_lcp",
>          "ScaleUnit": "100%"
>      },
> @@ -263,6 +268,7 @@
>          "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group",
>          "MetricName": "tma_fetch_latency",
>          "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend latency issues.  For example; instruction-cache misses; iTLB misses or fetch stalls after a branch misprediction are categorized under Frontend Latency. In such cases; the Frontend eventually delivers no uops for some period. Sample with: RS_EVENTS.EMPTY_END",
>          "ScaleUnit": "100%"
>      },
> @@ -299,6 +305,7 @@
>          "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
>          "ScaleUnit": "100%"
>      },
> @@ -308,6 +315,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_heavy_operations",
>          "MetricThreshold": "tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring heavy-weight operations -- instructions that require two or more uops or micro-coded sequences. This highly-correlates with the uop length of these instructions/sequences.",
>          "ScaleUnit": "100%"
>      },
> @@ -725,6 +733,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_light_operations",
>          "MetricThreshold": "tma_light_operations > 0.6",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring light-weight operations -- instructions that require no more than one uop (micro-operation). This correlates with total number of instructions used by the program. A uops-per-instruction (see UopPI metric) ratio of 1 or less should be expected for decently optimized software running on Intel Core/Xeon products. While this often indicates efficient X86 instructions were executed; high value does not necessarily mean better performance cannot be achieved. Sample with: INST_RETIRED.PREC_DIST",
>          "ScaleUnit": "100%"
>      },
> @@ -765,6 +774,7 @@
>          "MetricGroup": "BadSpec;MachineClears;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
>          "MetricName": "tma_machine_clears",
>          "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Machine Clears.  These slots are either wasted by uops fetched prior to the clear; or stalls the out-of-order portion of the machine needs to recover its state after the clear. For example; this can happen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modifying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: tma_clears_resteers, tma_contested_accesses, tma_data_sharing, tma_false_sharing, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_remote_cache",
>          "ScaleUnit": "100%"
>      },
> @@ -793,6 +803,7 @@
>          "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_memory_bound",
>          "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the Memory subsystem within the Backend was a bottleneck.  Memory Bound estimates fraction of slots where pipeline is likely stalled due to demand load or store instructions. This accounts mainly for (1) non-completed in-flight memory demand loads which coincides with execution units starvation; in addition to (2) cases where stores could impose backpressure on the pipeline when many of them get buffered at the same time (less common out of the two).",
>          "ScaleUnit": "100%"
>      },
> @@ -948,6 +959,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.RETIRE_SLOTS",
>          "ScaleUnit": "100%"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
> index e8f4e5c01c9f..66a6f657bd6f 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
> @@ -76,6 +76,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
>          "ScaleUnit": "100%"
>      },
> @@ -85,6 +86,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
>          "ScaleUnit": "100%"
>      },
> @@ -95,6 +97,7 @@
>          "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueBM",
>          "MetricName": "tma_branch_mispredicts",
>          "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Branch Misprediction.  These slots are either wasted by uops fetched from an incorrectly speculated program path; or stalls when the out-of-order part of the machine needs to recover its state from a speculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics: tma_info_branch_misprediction_cost, tma_mispredicts_resteers",
>          "ScaleUnit": "100%"
>      },
> @@ -114,6 +117,7 @@
>          "MetricGroup": "Backend;Compute;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_core_bound",
>          "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where Core non-memory issues were of a bottleneck.  Shortage in hardware compute resources; or dependencies in software's instructions are both categorized under Core Bound. Hence it may indicate the machine ran out of an out-of-order resource; certain execution units are overloaded or dependencies in program's data- or instruction-flow are limiting the performance (e.g. FP-chained long-latency arithmetic operations).",
>          "ScaleUnit": "100%"
>      },
> @@ -160,6 +164,7 @@
>          "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group;tma_issueFB",
>          "MetricName": "tma_fetch_bandwidth",
>          "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_ipc / 4 > 0.35",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend bandwidth issues.  For example; inefficiencies at the instruction decoders; or restrictions for caching in the DSB (decoded uops cache) are categorized under Fetch Bandwidth. In such cases; the Frontend typically delivers suboptimal amount of uops to the Backend. Related metrics: tma_dsb_switches, tma_info_dsb_coverage, tma_lcp",
>          "ScaleUnit": "100%"
>      },
> @@ -169,6 +174,7 @@
>          "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group",
>          "MetricName": "tma_fetch_latency",
>          "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend latency issues.  For example; instruction-cache misses; iTLB misses or fetch stalls after a branch misprediction are categorized under Frontend Latency. In such cases; the Frontend eventually delivers no uops for some period. Sample with: RS_EVENTS.EMPTY_END",
>          "ScaleUnit": "100%"
>      },
> @@ -205,6 +211,7 @@
>          "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
>          "ScaleUnit": "100%"
>      },
> @@ -214,6 +221,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_heavy_operations",
>          "MetricThreshold": "tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring heavy-weight operations -- instructions that require two or more uops or micro-coded sequences. This highly-correlates with the uop length of these instructions/sequences.",
>          "ScaleUnit": "100%"
>      },
> @@ -412,6 +420,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_light_operations",
>          "MetricThreshold": "tma_light_operations > 0.6",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring light-weight operations -- instructions that require no more than one uop (micro-operation). This correlates with total number of instructions used by the program. A uops-per-instruction (see UopPI metric) ratio of 1 or less should be expected for decently optimized software running on Intel Core/Xeon products. While this often indicates efficient X86 instructions were executed; high value does not necessarily mean better performance cannot be achieved. Sample with: INST_RETIRED.PREC_DIST",
>          "ScaleUnit": "100%"
>      },
> @@ -422,6 +431,7 @@
>          "MetricGroup": "BadSpec;MachineClears;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
>          "MetricName": "tma_machine_clears",
>          "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Machine Clears.  These slots are either wasted by uops fetched prior to the clear; or stalls the out-of-order portion of the machine needs to recover its state after the clear. For example; this can happen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modifying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: tma_clears_resteers, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_remote_cache",
>          "ScaleUnit": "100%"
>      },
> @@ -450,6 +460,7 @@
>          "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_memory_bound",
>          "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the Memory subsystem within the Backend was a bottleneck.  Memory Bound estimates fraction of slots where pipeline is likely stalled due to demand load or store instructions. This accounts mainly for (1) non-completed in-flight memory demand loads which coincides with execution units starvation; in addition to (2) cases where stores could impose backpressure on the pipeline when many of them get buffered at the same time (less common out of the two).",
>          "ScaleUnit": "100%"
>      },
> @@ -487,6 +498,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.RETIRE_SLOTS",
>          "ScaleUnit": "100%"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
> index 4a99fe515f4b..4b8bc19392a4 100644
> --- a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
> @@ -76,6 +76,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
>          "ScaleUnit": "100%"
>      },
> @@ -85,6 +86,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
>          "ScaleUnit": "100%"
>      },
> @@ -95,6 +97,7 @@
>          "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueBM",
>          "MetricName": "tma_branch_mispredicts",
>          "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Branch Misprediction.  These slots are either wasted by uops fetched from an incorrectly speculated program path; or stalls when the out-of-order part of the machine needs to recover its state from a speculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics: tma_info_branch_misprediction_cost, tma_mispredicts_resteers",
>          "ScaleUnit": "100%"
>      },
> @@ -114,6 +117,7 @@
>          "MetricGroup": "Backend;Compute;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_core_bound",
>          "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where Core non-memory issues were of a bottleneck.  Shortage in hardware compute resources; or dependencies in software's instructions are both categorized under Core Bound. Hence it may indicate the machine ran out of an out-of-order resource; certain execution units are overloaded or dependencies in program's data- or instruction-flow are limiting the performance (e.g. FP-chained long-latency arithmetic operations).",
>          "ScaleUnit": "100%"
>      },
> @@ -160,6 +164,7 @@
>          "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group;tma_issueFB",
>          "MetricName": "tma_fetch_bandwidth",
>          "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_ipc / 4 > 0.35",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend bandwidth issues.  For example; inefficiencies at the instruction decoders; or restrictions for caching in the DSB (decoded uops cache) are categorized under Fetch Bandwidth. In such cases; the Frontend typically delivers suboptimal amount of uops to the Backend. Related metrics: tma_dsb_switches, tma_info_dsb_coverage, tma_lcp",
>          "ScaleUnit": "100%"
>      },
> @@ -169,6 +174,7 @@
>          "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group",
>          "MetricName": "tma_fetch_latency",
>          "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend latency issues.  For example; instruction-cache misses; iTLB misses or fetch stalls after a branch misprediction are categorized under Frontend Latency. In such cases; the Frontend eventually delivers no uops for some period. Sample with: RS_EVENTS.EMPTY_END",
>          "ScaleUnit": "100%"
>      },
> @@ -205,6 +211,7 @@
>          "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
>          "ScaleUnit": "100%"
>      },
> @@ -214,6 +221,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_heavy_operations",
>          "MetricThreshold": "tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring heavy-weight operations -- instructions that require two or more uops or micro-coded sequences. This highly-correlates with the uop length of these instructions/sequences.",
>          "ScaleUnit": "100%"
>      },
> @@ -411,6 +419,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_light_operations",
>          "MetricThreshold": "tma_light_operations > 0.6",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring light-weight operations -- instructions that require no more than one uop (micro-operation). This correlates with total number of instructions used by the program. A uops-per-instruction (see UopPI metric) ratio of 1 or less should be expected for decently optimized software running on Intel Core/Xeon products. While this often indicates efficient X86 instructions were executed; high value does not necessarily mean better performance cannot be achieved. Sample with: INST_RETIRED.PREC_DIST",
>          "ScaleUnit": "100%"
>      },
> @@ -421,6 +430,7 @@
>          "MetricGroup": "BadSpec;MachineClears;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
>          "MetricName": "tma_machine_clears",
>          "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Machine Clears.  These slots are either wasted by uops fetched prior to the clear; or stalls the out-of-order portion of the machine needs to recover its state after the clear. For example; this can happen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modifying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: tma_clears_resteers, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_remote_cache",
>          "ScaleUnit": "100%"
>      },
> @@ -449,6 +459,7 @@
>          "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_memory_bound",
>          "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the Memory subsystem within the Backend was a bottleneck.  Memory Bound estimates fraction of slots where pipeline is likely stalled due to demand load or store instructions. This accounts mainly for (1) non-completed in-flight memory demand loads which coincides with execution units starvation; in addition to (2) cases where stores could impose backpressure on the pipeline when many of them get buffered at the same time (less common out of the two).",
>          "ScaleUnit": "100%"
>      },
> @@ -486,6 +497,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.RETIRE_SLOTS",
>          "ScaleUnit": "100%"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
> index 126300b7ae77..620fc5bd2217 100644
> --- a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
> @@ -87,6 +87,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
>          "ScaleUnit": "100%"
>      },
> @@ -96,6 +97,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
>          "ScaleUnit": "100%"
>      },
> @@ -105,6 +107,7 @@
>          "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueBM",
>          "MetricName": "tma_branch_mispredicts",
>          "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Branch Misprediction.  These slots are either wasted by uops fetched from an incorrectly speculated program path; or stalls when the out-of-order part of the machine needs to recover its state from a speculative path. Sample with: TOPDOWN.BR_MISPREDICT_SLOTS. Related metrics: tma_info_branch_misprediction_cost, tma_info_mispredictions, tma_mispredicts_resteers",
>          "ScaleUnit": "100%"
>      },
> @@ -151,6 +154,7 @@
>          "MetricGroup": "Backend;Compute;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_core_bound",
>          "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where Core non-memory issues were of a bottleneck.  Shortage in hardware compute resources; or dependencies in software's instructions are both categorized under Core Bound. Hence it may indicate the machine ran out of an out-of-order resource; certain execution units are overloaded or dependencies in program's data- or instruction-flow are limiting the performance (e.g. FP-chained long-latency arithmetic operations).",
>          "ScaleUnit": "100%"
>      },
> @@ -252,6 +256,7 @@
>          "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group;tma_issueFB",
>          "MetricName": "tma_fetch_bandwidth",
>          "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_ipc / 6 > 0.35",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend bandwidth issues.  For example; inefficiencies at the instruction decoders; or restrictions for caching in the DSB (decoded uops cache) are categorized under Fetch Bandwidth. In such cases; the Frontend typically delivers suboptimal amount of uops to the Backend. Sample with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_switches, tma_info_dsb_coverage, tma_info_dsb_misses, tma_info_iptb, tma_lcp",
>          "ScaleUnit": "100%"
>      },
> @@ -261,6 +266,7 @@
>          "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group",
>          "MetricName": "tma_fetch_latency",
>          "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend latency issues.  For example; instruction-cache misses; iTLB misses or fetch stalls after a branch misprediction are categorized under Frontend Latency. In such cases; the Frontend eventually delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_16_PS;FRONTEND_RETIRED.LATENCY_GE_8_PS",
>          "ScaleUnit": "100%"
>      },
> @@ -351,6 +357,7 @@
>          "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. Sample with: FRONTEND_RETIRED.LATENCY_GE_4_PS",
>          "ScaleUnit": "100%"
>      },
> @@ -369,6 +376,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_heavy_operations",
>          "MetricThreshold": "tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring heavy-weight operations -- instructions that require two or more uops or micro-coded sequences. This highly-correlates with the uop length of these instructions/sequences. Sample with: UOPS_RETIRED.HEAVY",
>          "ScaleUnit": "100%"
>      },
> @@ -1216,6 +1224,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_light_operations",
>          "MetricThreshold": "tma_light_operations > 0.6",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring light-weight operations -- instructions that require no more than one uop (micro-operation). This correlates with total number of instructions used by the program. A uops-per-instruction (see UopPI metric) ratio of 1 or less should be expected for decently optimized software running on Intel Core/Xeon products. While this often indicates efficient X86 instructions were executed; high value does not necessarily mean better performance cannot be achieved. Sample with: INST_RETIRED.PREC_DIST",
>          "ScaleUnit": "100%"
>      },
> @@ -1269,6 +1278,7 @@
>          "MetricGroup": "BadSpec;MachineClears;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
>          "MetricName": "tma_machine_clears",
>          "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Machine Clears.  These slots are either wasted by uops fetched prior to the clear; or stalls the out-of-order portion of the machine needs to recover its state after the clear. For example; this can happen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modifying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: tma_clears_resteers, tma_contested_accesses, tma_data_sharing, tma_false_sharing, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_remote_cache",
>          "ScaleUnit": "100%"
>      },
> @@ -1304,6 +1314,7 @@
>          "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_memory_bound",
>          "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the Memory subsystem within the Backend was a bottleneck.  Memory Bound estimates fraction of slots where pipeline is likely stalled due to demand load or store instructions. This accounts mainly for (1) non-completed in-flight memory demand loads which coincides with execution units starvation; in addition to (2) cases where stores could impose backpressure on the pipeline when many of them get buffered at the same time (less common out of the two).",
>          "ScaleUnit": "100%"
>      },
> @@ -1509,6 +1520,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.SLOTS",
>          "ScaleUnit": "100%"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> index a6d212b349f5..21ef6c9be816 100644
> --- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> @@ -101,6 +101,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
>          "ScaleUnit": "100%"
>      },
> @@ -110,6 +111,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
>          "ScaleUnit": "100%"
>      },
> @@ -120,6 +122,7 @@
>          "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueBM",
>          "MetricName": "tma_branch_mispredicts",
>          "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Branch Misprediction.  These slots are either wasted by uops fetched from an incorrectly speculated program path; or stalls when the out-of-order part of the machine needs to recover its state from a speculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics: tma_info_branch_misprediction_cost, tma_info_mispredictions, tma_mispredicts_resteers",
>          "ScaleUnit": "100%"
>      },
> @@ -167,6 +170,7 @@
>          "MetricGroup": "Backend;Compute;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_core_bound",
>          "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where Core non-memory issues were of a bottleneck.  Shortage in hardware compute resources; or dependencies in software's instructions are both categorized under Core Bound. Hence it may indicate the machine ran out of an out-of-order resource; certain execution units are overloaded or dependencies in program's data- or instruction-flow are limiting the performance (e.g. FP-chained long-latency arithmetic operations).",
>          "ScaleUnit": "100%"
>      },
> @@ -271,6 +275,7 @@
>          "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group;tma_issueFB",
>          "MetricName": "tma_fetch_bandwidth",
>          "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_ipc / 4 > 0.35",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend bandwidth issues.  For example; inefficiencies at the instruction decoders; or restrictions for caching in the DSB (decoded uops cache) are categorized under Fetch Bandwidth. In such cases; the Frontend typically delivers suboptimal amount of uops to the Backend. Sample with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_switches, tma_info_dsb_coverage, tma_info_dsb_misses, tma_info_iptb, tma_lcp",
>          "ScaleUnit": "100%"
>      },
> @@ -280,6 +285,7 @@
>          "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group",
>          "MetricName": "tma_fetch_latency",
>          "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend latency issues.  For example; instruction-cache misses; iTLB misses or fetch stalls after a branch misprediction are categorized under Frontend Latency. In such cases; the Frontend eventually delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_16_PS;FRONTEND_RETIRED.LATENCY_GE_8_PS",
>          "ScaleUnit": "100%"
>      },
> @@ -345,6 +351,7 @@
>          "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. Sample with: FRONTEND_RETIRED.LATENCY_GE_4_PS",
>          "ScaleUnit": "100%"
>      },
> @@ -363,6 +370,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_heavy_operations",
>          "MetricThreshold": "tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring heavy-weight operations -- instructions that require two or more uops or micro-coded sequences. This highly-correlates with the uop length of these instructions/sequences.",
>          "ScaleUnit": "100%"
>      },
> @@ -1065,6 +1073,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_light_operations",
>          "MetricThreshold": "tma_light_operations > 0.6",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring light-weight operations -- instructions that require no more than one uop (micro-operation). This correlates with total number of instructions used by the program. A uops-per-instruction (see UopPI metric) ratio of 1 or less should be expected for decently optimized software running on Intel Core/Xeon products. While this often indicates efficient X86 instructions were executed; high value does not necessarily mean better performance cannot be achieved. Sample with: INST_RETIRED.PREC_DIST",
>          "ScaleUnit": "100%"
>      },
> @@ -1110,6 +1119,7 @@
>          "MetricGroup": "BadSpec;MachineClears;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
>          "MetricName": "tma_machine_clears",
>          "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Machine Clears.  These slots are either wasted by uops fetched prior to the clear; or stalls the out-of-order portion of the machine needs to recover its state after the clear. For example; this can happen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modifying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: tma_clears_resteers, tma_contested_accesses, tma_data_sharing, tma_false_sharing, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_remote_cache",
>          "ScaleUnit": "100%"
>      },
> @@ -1138,6 +1148,7 @@
>          "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_memory_bound",
>          "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the Memory subsystem within the Backend was a bottleneck.  Memory Bound estimates fraction of slots where pipeline is likely stalled due to demand load or store instructions. This accounts mainly for (1) non-completed in-flight memory demand loads which coincides with execution units starvation; in addition to (2) cases where stores could impose backpressure on the pipeline when many of them get buffered at the same time (less common out of the two).",
>          "ScaleUnit": "100%"
>      },
> @@ -1343,6 +1354,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.RETIRE_SLOTS",
>          "ScaleUnit": "100%"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> index fa2f7f126a30..eb6f12c0343d 100644
> --- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> @@ -101,6 +101,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
>          "ScaleUnit": "100%"
>      },
> @@ -110,6 +111,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
>          "ScaleUnit": "100%"
>      },
> @@ -120,6 +122,7 @@
>          "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueBM",
>          "MetricName": "tma_branch_mispredicts",
>          "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Branch Misprediction.  These slots are either wasted by uops fetched from an incorrectly speculated program path; or stalls when the out-of-order part of the machine needs to recover its state from a speculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics: tma_info_branch_misprediction_cost, tma_info_mispredictions, tma_mispredicts_resteers",
>          "ScaleUnit": "100%"
>      },
> @@ -167,6 +170,7 @@
>          "MetricGroup": "Backend;Compute;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_core_bound",
>          "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where Core non-memory issues were of a bottleneck.  Shortage in hardware compute resources; or dependencies in software's instructions are both categorized under Core Bound. Hence it may indicate the machine ran out of an out-of-order resource; certain execution units are overloaded or dependencies in program's data- or instruction-flow are limiting the performance (e.g. FP-chained long-latency arithmetic operations).",
>          "ScaleUnit": "100%"
>      },
> @@ -271,6 +275,7 @@
>          "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group;tma_issueFB",
>          "MetricName": "tma_fetch_bandwidth",
>          "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_ipc / 4 > 0.35",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend bandwidth issues.  For example; inefficiencies at the instruction decoders; or restrictions for caching in the DSB (decoded uops cache) are categorized under Fetch Bandwidth. In such cases; the Frontend typically delivers suboptimal amount of uops to the Backend. Sample with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_switches, tma_info_dsb_coverage, tma_info_dsb_misses, tma_info_iptb, tma_lcp",
>          "ScaleUnit": "100%"
>      },
> @@ -280,6 +285,7 @@
>          "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group",
>          "MetricName": "tma_fetch_latency",
>          "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend latency issues.  For example; instruction-cache misses; iTLB misses or fetch stalls after a branch misprediction are categorized under Frontend Latency. In such cases; the Frontend eventually delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_16_PS;FRONTEND_RETIRED.LATENCY_GE_8_PS",
>          "ScaleUnit": "100%"
>      },
> @@ -354,6 +360,7 @@
>          "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. Sample with: FRONTEND_RETIRED.LATENCY_GE_4_PS",
>          "ScaleUnit": "100%"
>      },
> @@ -372,6 +379,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_heavy_operations",
>          "MetricThreshold": "tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring heavy-weight operations -- instructions that require two or more uops or micro-coded sequences. This highly-correlates with the uop length of these instructions/sequences.",
>          "ScaleUnit": "100%"
>      },
> @@ -1123,6 +1131,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_light_operations",
>          "MetricThreshold": "tma_light_operations > 0.6",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring light-weight operations -- instructions that require no more than one uop (micro-operation). This correlates with total number of instructions used by the program. A uops-per-instruction (see UopPI metric) ratio of 1 or less should be expected for decently optimized software running on Intel Core/Xeon products. While this often indicates efficient X86 instructions were executed; high value does not necessarily mean better performance cannot be achieved. Sample with: INST_RETIRED.PREC_DIST",
>          "ScaleUnit": "100%"
>      },
> @@ -1177,6 +1186,7 @@
>          "MetricGroup": "BadSpec;MachineClears;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
>          "MetricName": "tma_machine_clears",
>          "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Machine Clears.  These slots are either wasted by uops fetched prior to the clear; or stalls the out-of-order portion of the machine needs to recover its state after the clear. For example; this can happen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modifying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: tma_clears_resteers, tma_contested_accesses, tma_data_sharing, tma_false_sharing, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_remote_cache",
>          "ScaleUnit": "100%"
>      },
> @@ -1205,6 +1215,7 @@
>          "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_memory_bound",
>          "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the Memory subsystem within the Backend was a bottleneck.  Memory Bound estimates fraction of slots where pipeline is likely stalled due to demand load or store instructions. This accounts mainly for (1) non-completed in-flight memory demand loads which coincides with execution units starvation; in addition to (2) cases where stores could impose backpressure on the pipeline when many of them get buffered at the same time (less common out of the two).",
>          "ScaleUnit": "100%"
>      },
> @@ -1429,6 +1440,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.RETIRE_SLOTS",
>          "ScaleUnit": "100%"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json b/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
> index 4c80d6be6cf1..b442ed4acfbb 100644
> --- a/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
> @@ -109,6 +109,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
>          "ScaleUnit": "100%"
>      },
> @@ -118,6 +119,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
>          "ScaleUnit": "100%"
>      },
> @@ -135,6 +137,7 @@
>          "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueBM",
>          "MetricName": "tma_branch_mispredicts",
>          "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Branch Misprediction.  These slots are either wasted by uops fetched from an incorrectly speculated program path; or stalls when the out-of-order part of the machine needs to recover its state from a speculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics: tma_info_branch_misprediction_cost, tma_info_mispredictions, tma_mispredicts_resteers",
>          "ScaleUnit": "100%"
>      },
> @@ -181,6 +184,7 @@
>          "MetricGroup": "Backend;Compute;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_core_bound",
>          "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where Core non-memory issues were of a bottleneck.  Shortage in hardware compute resources; or dependencies in software's instructions are both categorized under Core Bound. Hence it may indicate the machine ran out of an out-of-order resource; certain execution units are overloaded or dependencies in program's data- or instruction-flow are limiting the performance (e.g. FP-chained long-latency arithmetic operations).",
>          "ScaleUnit": "100%"
>      },
> @@ -282,6 +286,7 @@
>          "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group;tma_issueFB",
>          "MetricName": "tma_fetch_bandwidth",
>          "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_ipc / 5 > 0.35",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend bandwidth issues.  For example; inefficiencies at the instruction decoders; or restrictions for caching in the DSB (decoded uops cache) are categorized under Fetch Bandwidth. In such cases; the Frontend typically delivers suboptimal amount of uops to the Backend. Sample with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_switches, tma_info_dsb_coverage, tma_info_dsb_misses, tma_info_iptb, tma_lcp",
>          "ScaleUnit": "100%"
>      },
> @@ -291,6 +296,7 @@
>          "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group",
>          "MetricName": "tma_fetch_latency",
>          "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend latency issues.  For example; instruction-cache misses; iTLB misses or fetch stalls after a branch misprediction are categorized under Frontend Latency. In such cases; the Frontend eventually delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_16_PS;FRONTEND_RETIRED.LATENCY_GE_8_PS",
>          "ScaleUnit": "100%"
>      },
> @@ -363,6 +369,7 @@
>          "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. Sample with: FRONTEND_RETIRED.LATENCY_GE_4_PS",
>          "ScaleUnit": "100%"
>      },
> @@ -372,6 +379,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_heavy_operations",
>          "MetricThreshold": "tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring heavy-weight operations -- instructions that require two or more uops or micro-coded sequences. This highly-correlates with the uop length of these instructions/sequences.",
>          "ScaleUnit": "100%"
>      },
> @@ -1125,6 +1133,7 @@
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
>          "MetricName": "tma_light_operations",
>          "MetricThreshold": "tma_light_operations > 0.6",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots where the CPU was retiring light-weight operations -- instructions that require no more than one uop (micro-operation). This correlates with total number of instructions used by the program. A uops-per-instruction (see UopPI metric) ratio of 1 or less should be expected for decently optimized software running on Intel Core/Xeon products. While this often indicates efficient X86 instructions were executed; high value does not necessarily mean better performance cannot be achieved. Sample with: INST_RETIRED.PREC_DIST",
>          "ScaleUnit": "100%"
>      },
> @@ -1178,6 +1187,7 @@
>          "MetricGroup": "BadSpec;MachineClears;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
>          "MetricName": "tma_machine_clears",
>          "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Machine Clears.  These slots are either wasted by uops fetched prior to the clear; or stalls the out-of-order portion of the machine needs to recover its state after the clear. For example; this can happen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modifying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: tma_clears_resteers, tma_contested_accesses, tma_data_sharing, tma_false_sharing, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_remote_cache",
>          "ScaleUnit": "100%"
>      },
> @@ -1205,6 +1215,7 @@
>          "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
>          "MetricName": "tma_memory_bound",
>          "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
>          "PublicDescription": "This metric represents fraction of slots the Memory subsystem within the Backend was a bottleneck.  Memory Bound estimates fraction of slots where pipeline is likely stalled due to demand load or store instructions. This accounts mainly for (1) non-completed in-flight memory demand loads which coincides with execution units starvation; in addition to (2) cases where stores could impose backpressure on the pipeline when many of them get buffered at the same time (less common out of the two).",
>          "ScaleUnit": "100%"
>      },
> @@ -1374,6 +1385,7 @@
>          "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.SLOTS",
>          "ScaleUnit": "100%"
>      },
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index ca99b9cfe4ad..f57a8f274025 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -52,7 +52,8 @@ _json_event_attributes = [
>  # Attributes that are in pmu_metric rather than pmu_event.
>  _json_metric_attributes = [
>      'metric_name', 'metric_group', 'metric_expr', 'metric_threshold', 'desc',
> -    'long_desc', 'unit', 'compat', 'aggr_mode', 'event_grouping'
> +    'long_desc', 'unit', 'compat', 'metricgroup_no_group', 'aggr_mode',
> +    'event_grouping'
>  ]
>  # Attributes that are bools or enum int values, encoded as '0', '1',...
>  _json_enum_attributes = ['aggr_mode', 'deprecated', 'event_grouping', 'perpkg']
> @@ -303,6 +304,7 @@ class JsonEvent:
>      self.deprecated = jd.get('Deprecated')
>      self.metric_name = jd.get('MetricName')
>      self.metric_group = jd.get('MetricGroup')
> +    self.metricgroup_no_group = jd.get('MetricgroupNoGroup')
>      self.event_grouping = convert_metric_constraint(jd.get('MetricConstraint'))
>      self.metric_expr = None
>      if 'MetricExpr' in jd:
> diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
> index b7dff8f1021f..80349685cf4d 100644
> --- a/tools/perf/pmu-events/pmu-events.h
> +++ b/tools/perf/pmu-events/pmu-events.h
> @@ -59,6 +59,7 @@ struct pmu_metric {
>  	const char *compat;
>  	const char *desc;
>  	const char *long_desc;
> +	const char *metricgroup_no_group;
>  	enum aggr_mode_class aggr_mode;
>  	enum metric_event_groups event_grouping;
>  };
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 4b9a16291b96..e1acb0d23b95 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1144,12 +1144,12 @@ static int metricgroup__add_metric_callback(const struct pmu_metric *pm,
>  	struct metricgroup__add_metric_data *data = vdata;
>  	int ret = 0;
>  
> -	if (pm->metric_expr &&
> -		(match_metric(pm->metric_group, data->metric_name) ||
> -		 match_metric(pm->metric_name, data->metric_name))) {
> +	if (pm->metric_expr && match_pm_metric(pm, data->metric_name)) {
> +		bool metric_no_group = data->metric_no_group ||
> +			match_metric(data->metric_name, pm->metricgroup_no_group);
>  
>  		data->has_match = true;
> -		ret = add_metric(data->list, pm, data->modifier, data->metric_no_group,
> +		ret = add_metric(data->list, pm, data->modifier, metric_no_group,
>  				 data->metric_no_threshold, data->user_requested_cpu_list,
>  				 data->system_wide, /*root_metric=*/NULL,
>  				 /*visited_metrics=*/NULL, table);
