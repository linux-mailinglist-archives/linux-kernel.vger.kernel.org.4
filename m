Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625026E79DC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbjDSMi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbjDSMi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:38:57 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68CBAD0C;
        Wed, 19 Apr 2023 05:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681907923; x=1713443923;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rbenE3wLb2+TJQpThS3Ck13/VoGYjtwAybBLmgf6OQk=;
  b=U6QGSfBtoFJKL0b4nfXQ5FYpcd/2xDm2bWyTx1C/CBhySGTh/xwT7sug
   AcKdwY1tag9WYAblwRw5dEvA3XcC/0PQ98YtTNo+SSKYoGjHhSKaD/BGb
   xRvGVs8NUqvqtmlGeAqm5kHT2TI5SwiYOp3wkv6LWsZY7IebnKrKm48WU
   ruDQO2CwG1b96x8Z/sFKQIqQXq7QlmJUSzKmNInDGH4FGNFaNJ1QTxsrk
   KK7986vVpJw8d8obWdpdMIeV7faZc4rVBobRhIzko334OIXenYLYI+IUr
   +t53LJX/b97C7N845O3nWuqg+fc53uYA1VJ3bR7UA+duXE1WgG5jnjTTr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="334243524"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="334243524"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 05:38:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="694039500"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="694039500"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 19 Apr 2023 05:38:15 -0700
Received: from [10.209.41.10] (kliang2-mobl1.ccr.corp.intel.com [10.209.41.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id A0B78580C4C;
        Wed, 19 Apr 2023 05:38:13 -0700 (PDT)
Message-ID: <f1ecaa76-9cfa-21b4-7a9d-00c050ef378e@linux.intel.com>
Date:   Wed, 19 Apr 2023 08:38:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 6/6] perf vendor events intel: Remove TopdownL1 from
 CPUs without perf metric events
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
References: <20230419005423.343862-1-irogers@google.com>
 <20230419005423.343862-6-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230419005423.343862-6-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-18 8:54 p.m., Ian Rogers wrote:
> As requested by Kan in:
> https://lore.kernel.org/lkml/ea899096-0599-f2a0-04a3-d90a3aa7d45d@linux.intel.com/
> 
> Note, atom CPUs lack perf metric (aka topdown) events and so these
> metrics are also not placed in the group TopdownL1 to avoid perf stat
> showing them by default.
> 
> Suggested-by: Kan Liang <kan.liang@linux.intel.com>

Sorry, this is not my intention.

For the details, plese see
https://lore.kernel.org/lkml/84b19053-2e9f-5251-6816-26d2475894c0@linux.intel.com/

Thanks,
Kan


> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  .../pmu-events/arch/x86/alderlake/adl-metrics.json     | 10 +++++-----
>  .../pmu-events/arch/x86/alderlaken/adln-metrics.json   | 10 +++++-----
>  .../pmu-events/arch/x86/broadwell/bdw-metrics.json     |  8 ++++----
>  .../pmu-events/arch/x86/broadwellde/bdwde-metrics.json |  8 ++++----
>  .../pmu-events/arch/x86/broadwellx/bdx-metrics.json    |  8 ++++----
>  .../pmu-events/arch/x86/cascadelakex/clx-metrics.json  |  8 ++++----
>  .../perf/pmu-events/arch/x86/haswell/hsw-metrics.json  |  8 ++++----
>  .../perf/pmu-events/arch/x86/haswellx/hsx-metrics.json |  8 ++++----
>  .../pmu-events/arch/x86/ivybridge/ivb-metrics.json     |  8 ++++----
>  .../perf/pmu-events/arch/x86/ivytown/ivt-metrics.json  |  8 ++++----
>  .../perf/pmu-events/arch/x86/jaketown/jkt-metrics.json |  8 ++++----
>  .../pmu-events/arch/x86/sandybridge/snb-metrics.json   |  8 ++++----
>  .../perf/pmu-events/arch/x86/skylake/skl-metrics.json  |  8 ++++----
>  .../perf/pmu-events/arch/x86/skylakex/skx-metrics.json |  8 ++++----
>  14 files changed, 58 insertions(+), 58 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> index d09361dacd4f..a837ed8666fe 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> @@ -130,7 +130,7 @@
>      {
>          "BriefDescription": "Counts the total number of issue slots  that were not consumed by the backend due to backend stalls",
>          "MetricExpr": "TOPDOWN_BE_BOUND.ALL / tma_info_slots",
> -        "MetricGroup": "TopdownL1;tma_L1_group",
> +        "MetricGroup": "tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.1",
>          "PublicDescription": "Counts the total number of issue slots  that were not consumed by the backend due to backend stalls.  Note that uops must be available for consumption in order for this event to count.  If a uop is not available (IQ is empty), this event will not count.   The rest of these subevents count backend stalls, in cycles, due to an outstanding request which is memory bound vs core bound.   The subevents are not slot based events and therefore can not be precisely added or subtracted from the Backend_Bound_Aux subevents which are slot based.",
> @@ -140,7 +140,7 @@
>      {
>          "BriefDescription": "Counts the total number of issue slots  that were not consumed by the backend due to backend stalls",
>          "MetricExpr": "tma_backend_bound",
> -        "MetricGroup": "TopdownL1;tma_L1_group",
> +        "MetricGroup": "tma_L1_group",
>          "MetricName": "tma_backend_bound_aux",
>          "MetricThreshold": "tma_backend_bound_aux > 0.2",
>          "PublicDescription": "Counts the total number of issue slots  that were not consumed by the backend due to backend stalls.  Note that UOPS must be available for consumption in order for this event to count.  If a uop is not available (IQ is empty), this event will not count.  All of these subevents count backend stalls, in slots, due to a resource limitation.   These are not cycle based events and therefore can not be precisely added or subtracted from the Backend_Bound subevents which are cycle based.  These subevents are supplementary to Backend_Bound and can be used to analyze results from a resource perspective at allocation.",
> @@ -150,7 +150,7 @@
>      {
>          "BriefDescription": "Counts the total number of issue slots that were not consumed by the backend because allocation is stalled due to a mispredicted jump or a machine clear",
>          "MetricExpr": "(tma_info_slots - (TOPDOWN_FE_BOUND.ALL + TOPDOWN_BE_BOUND.ALL + TOPDOWN_RETIRING.ALL)) / tma_info_slots",
> -        "MetricGroup": "TopdownL1;tma_L1_group",
> +        "MetricGroup": "tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
>          "PublicDescription": "Counts the total number of issue slots that were not consumed by the backend because allocation is stalled due to a mispredicted jump or a machine clear. Only issue slots wasted due to fast nukes such as memory ordering nukes are counted. Other nukes are not accounted for. Counts all issue slots blocked during this recovery window including relevant microcode flows and while uops are not yet available in the instruction queue (IQ). Also includes the issue slots that were consumed by the backend but were thrown away because they were younger than the mispredict or machine clear.",
> @@ -288,7 +288,7 @@
>      {
>          "BriefDescription": "Counts the number of issue slots  that were not consumed by the backend due to frontend stalls.",
>          "MetricExpr": "TOPDOWN_FE_BOUND.ALL / tma_info_slots",
> -        "MetricGroup": "TopdownL1;tma_L1_group",
> +        "MetricGroup": "tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.2",
>          "ScaleUnit": "100%",
> @@ -736,7 +736,7 @@
>      {
>          "BriefDescription": "Counts the numer of issue slots  that result in retirement slots.",
>          "MetricExpr": "TOPDOWN_RETIRING.ALL / tma_info_slots",
> -        "MetricGroup": "TopdownL1;tma_L1_group",
> +        "MetricGroup": "tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.75",
>          "ScaleUnit": "100%",
> diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json b/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
> index 1a85d935c733..66bd7e376e88 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
> @@ -95,7 +95,7 @@
>      {
>          "BriefDescription": "Counts the total number of issue slots  that were not consumed by the backend due to backend stalls",
>          "MetricExpr": "TOPDOWN_BE_BOUND.ALL / tma_info_slots",
> -        "MetricGroup": "TopdownL1;tma_L1_group",
> +        "MetricGroup": "tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.1",
>          "PublicDescription": "Counts the total number of issue slots  that were not consumed by the backend due to backend stalls.  Note that uops must be available for consumption in order for this event to count.  If a uop is not available (IQ is empty), this event will not count.   The rest of these subevents count backend stalls, in cycles, due to an outstanding request which is memory bound vs core bound.   The subevents are not slot based events and therefore can not be precisely added or subtracted from the Backend_Bound_Aux subevents which are slot based.",
> @@ -104,7 +104,7 @@
>      {
>          "BriefDescription": "Counts the total number of issue slots  that were not consumed by the backend due to backend stalls",
>          "MetricExpr": "tma_backend_bound",
> -        "MetricGroup": "TopdownL1;tma_L1_group",
> +        "MetricGroup": "tma_L1_group",
>          "MetricName": "tma_backend_bound_aux",
>          "MetricThreshold": "tma_backend_bound_aux > 0.2",
>          "PublicDescription": "Counts the total number of issue slots  that were not consumed by the backend due to backend stalls.  Note that UOPS must be available for consumption in order for this event to count.  If a uop is not available (IQ is empty), this event will not count.  All of these subevents count backend stalls, in slots, due to a resource limitation.   These are not cycle based events and therefore can not be precisely added or subtracted from the Backend_Bound subevents which are cycle based.  These subevents are supplementary to Backend_Bound and can be used to analyze results from a resource perspective at allocation.",
> @@ -113,7 +113,7 @@
>      {
>          "BriefDescription": "Counts the total number of issue slots that were not consumed by the backend because allocation is stalled due to a mispredicted jump or a machine clear",
>          "MetricExpr": "(tma_info_slots - (TOPDOWN_FE_BOUND.ALL + TOPDOWN_BE_BOUND.ALL + TOPDOWN_RETIRING.ALL)) / tma_info_slots",
> -        "MetricGroup": "TopdownL1;tma_L1_group",
> +        "MetricGroup": "tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
>          "PublicDescription": "Counts the total number of issue slots that were not consumed by the backend because allocation is stalled due to a mispredicted jump or a machine clear. Only issue slots wasted due to fast nukes such as memory ordering nukes are counted. Other nukes are not accounted for. Counts all issue slots blocked during this recovery window including relevant microcode flows and while uops are not yet available in the instruction queue (IQ). Also includes the issue slots that were consumed by the backend but were thrown away because they were younger than the mispredict or machine clear.",
> @@ -236,7 +236,7 @@
>      {
>          "BriefDescription": "Counts the number of issue slots  that were not consumed by the backend due to frontend stalls.",
>          "MetricExpr": "TOPDOWN_FE_BOUND.ALL / tma_info_slots",
> -        "MetricGroup": "TopdownL1;tma_L1_group",
> +        "MetricGroup": "tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.2",
>          "ScaleUnit": "100%"
> @@ -626,7 +626,7 @@
>      {
>          "BriefDescription": "Counts the numer of issue slots  that result in retirement slots.",
>          "MetricExpr": "TOPDOWN_RETIRING.ALL / tma_info_slots",
> -        "MetricGroup": "TopdownL1;tma_L1_group",
> +        "MetricGroup": "tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.75",
>          "ScaleUnit": "100%"
> diff --git a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> index 51cf8560a8d3..8a954a2ef703 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> @@ -100,7 +100,7 @@
>          "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
>          "MetricConstraint": "NO_GROUP_EVENTS_NMI",
>          "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma_retiring)",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
> @@ -109,7 +109,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
>          "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)) / tma_info_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
> @@ -323,7 +323,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
>          "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_slots",
> -        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "PGO;TmaL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
> @@ -1045,7 +1045,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
>          "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.RETIRE_SLOTS",
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> index fb57c7382408..1cd150d714ba 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> @@ -94,7 +94,7 @@
>          "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
>          "MetricConstraint": "NO_GROUP_EVENTS_NMI",
>          "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma_retiring)",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
> @@ -103,7 +103,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
>          "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)) / tma_info_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
> @@ -308,7 +308,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
>          "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_slots",
> -        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "PGO;TmaL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. Sample with: FRONTEND_RETIRED.LATENCY_GE_4_PS",
> @@ -1010,7 +1010,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
>          "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.SLOTS",
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
> index 65ec0c9e55d1..b0e03a84d7f4 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
> @@ -100,7 +100,7 @@
>          "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
>          "MetricConstraint": "NO_GROUP_EVENTS_NMI",
>          "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma_retiring)",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
> @@ -109,7 +109,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
>          "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)) / tma_info_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
> @@ -323,7 +323,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
>          "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_slots",
> -        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "PGO;TmaL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
> @@ -1076,7 +1076,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
>          "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.RETIRE_SLOTS",
> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> index 8f7dc72accd0..36cee1086fa5 100644
> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> @@ -98,7 +98,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
>          "MetricExpr": "1 - tma_frontend_bound - (UOPS_ISSUED.ANY + 4 * (INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)) / tma_info_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
> @@ -107,7 +107,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
>          "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)) / tma_info_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
> @@ -351,7 +351,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
>          "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_slots",
> -        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "PGO;TmaL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. Sample with: FRONTEND_RETIRED.LATENCY_GE_4_PS",
> @@ -1455,7 +1455,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
>          "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.RETIRE_SLOTS",
> diff --git a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json b/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
> index 2528418200bb..41b15da86580 100644
> --- a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
> @@ -100,7 +100,7 @@
>          "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
>          "MetricConstraint": "NO_GROUP_EVENTS_NMI",
>          "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma_retiring)",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
> @@ -109,7 +109,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
>          "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)) / tma_info_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
> @@ -269,7 +269,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
>          "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_slots",
> -        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "PGO;TmaL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
> @@ -871,7 +871,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
>          "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.RETIRE_SLOTS",
> diff --git a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
> index 11f152c346eb..000e7301ce81 100644
> --- a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
> @@ -100,7 +100,7 @@
>          "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
>          "MetricConstraint": "NO_GROUP_EVENTS_NMI",
>          "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma_retiring)",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
> @@ -109,7 +109,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
>          "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)) / tma_info_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
> @@ -269,7 +269,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
>          "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_slots",
> -        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "PGO;TmaL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
> @@ -902,7 +902,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
>          "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.RETIRE_SLOTS",
> diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
> index 5247f69c13b6..9caac46d3359 100644
> --- a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
> @@ -100,7 +100,7 @@
>          "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
>          "MetricConstraint": "NO_GROUP_EVENTS_NMI",
>          "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma_retiring)",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
> @@ -109,7 +109,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
>          "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)) / tma_info_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
> @@ -296,7 +296,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
>          "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_slots",
> -        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "PGO;TmaL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
> @@ -914,7 +914,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
>          "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.RETIRE_SLOTS",
> diff --git a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
> index 89469b10fa30..9c1a4b9ef748 100644
> --- a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
> @@ -100,7 +100,7 @@
>          "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
>          "MetricConstraint": "NO_GROUP_EVENTS_NMI",
>          "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma_retiring)",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
> @@ -109,7 +109,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
>          "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)) / tma_info_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
> @@ -296,7 +296,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
>          "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_slots",
> -        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "PGO;TmaL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
> @@ -945,7 +945,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
>          "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.RETIRE_SLOTS",
> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
> index e8f4e5c01c9f..914dbf0d839c 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
> @@ -73,7 +73,7 @@
>          "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
>          "MetricConstraint": "NO_GROUP_EVENTS_NMI",
>          "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma_retiring)",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
> @@ -82,7 +82,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
>          "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)) / tma_info_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
> @@ -202,7 +202,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
>          "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_slots",
> -        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "PGO;TmaL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
> @@ -484,7 +484,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
>          "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.RETIRE_SLOTS",
> diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
> index 4a99fe515f4b..687ea8c6b8a8 100644
> --- a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
> @@ -73,7 +73,7 @@
>          "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
>          "MetricConstraint": "NO_GROUP_EVENTS_NMI",
>          "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma_retiring)",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
> @@ -82,7 +82,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
>          "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)) / tma_info_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
> @@ -202,7 +202,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
>          "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_slots",
> -        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "PGO;TmaL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
> @@ -483,7 +483,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
>          "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.RETIRE_SLOTS",
> diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> index a6d212b349f5..32f4a16db4ea 100644
> --- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> @@ -98,7 +98,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
>          "MetricExpr": "1 - tma_frontend_bound - (UOPS_ISSUED.ANY + 4 * (INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)) / tma_info_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
> @@ -107,7 +107,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
>          "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)) / tma_info_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
> @@ -342,7 +342,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
>          "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_slots",
> -        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "PGO;TmaL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. Sample with: FRONTEND_RETIRED.LATENCY_GE_4_PS",
> @@ -1340,7 +1340,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
>          "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.RETIRE_SLOTS",
> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> index fa2f7f126a30..48fe6738c112 100644
> --- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> @@ -98,7 +98,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
>          "MetricExpr": "1 - tma_frontend_bound - (UOPS_ISSUED.ANY + 4 * (INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)) / tma_info_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
>          "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
> @@ -107,7 +107,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
>          "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)) / tma_info_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
>          "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
> @@ -351,7 +351,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
>          "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_slots",
> -        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "PGO;TmaL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
>          "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. Sample with: FRONTEND_RETIRED.LATENCY_GE_4_PS",
> @@ -1426,7 +1426,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
>          "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
>          "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.RETIRE_SLOTS",
