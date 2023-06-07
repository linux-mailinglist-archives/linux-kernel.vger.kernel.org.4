Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A497265E1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjFGQ1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjFGQ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:27:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE6B11F;
        Wed,  7 Jun 2023 09:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686155244; x=1717691244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YSv2OOWGOAQZHH1tEzBJAE3oasGT2Li+d6S17eQPZxA=;
  b=P2tmBX1qToZ0V6E1+NkduhooscSb7tl7898kSkuwAyTtk5j6FT6vcz3N
   IaPuGmgMQ0nGOh85FcehzqYaBHeTDH9OHB97O9WiKK+LZSE6kFJN5Sw+7
   4DM8yFb9T3r1CIafRAWQtDj9EbDlrybcLVrhX9BgLf8oNDfHmNL69dham
   tsqsD2lvkxpo5ub3dbqxKwfOx29sb76ROuUFfzQAI2eR2Lc0HZmW6C5tV
   I5Eocka3Rf9EAZShNM4earnDtLl5fHFD3n/n2bzjKt907O7SsppKq+s1q
   E4xozUqNGvIcl/EwQLokL2UalBbLUBsOSd26iDR72eS0NEdP5sxNy/TJc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="355892629"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="355892629"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 09:27:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="774697661"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="774697661"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jun 2023 09:27:20 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        irogers@google.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/8] perf metric: JSON flag to default metric group
Date:   Wed,  7 Jun 2023 09:26:55 -0700
Message-Id: <20230607162700.3234712-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230607162700.3234712-1-kan.liang@linux.intel.com>
References: <20230607162700.3234712-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

For the default output, the default metric group could vary on different
platforms. For example, on SPR, the TopdownL1 and TopdownL2 metrics
should be displayed in the default mode. On ICL, only the TopdownL1
should be displayed.

Add a flag so we can tag the default metric group for different
platforms rather than hack the perf code.

The flag is added to Intel TopdownL1 since ICL and TopdownL2 metrics
since SPR.

Add a new field, DefaultMetricgroupName, in the JSON file to indicate
the real metric group name.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 .../arch/x86/alderlake/adl-metrics.json       | 20 ++++---
 .../arch/x86/icelake/icl-metrics.json         | 20 ++++---
 .../arch/x86/icelakex/icx-metrics.json        | 20 ++++---
 .../arch/x86/sapphirerapids/spr-metrics.json  | 60 +++++++++++--------
 .../arch/x86/tigerlake/tgl-metrics.json       | 20 ++++---
 5 files changed, 84 insertions(+), 56 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
index c9f7e3d4ab08..e78c85220e27 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
@@ -832,22 +832,24 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
+        "DefaultMetricgroupName": "TopdownL1",
         "MetricExpr": "cpu_core@topdown\\-be\\-bound@ / (cpu_core@topdown\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiring@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
-        "MetricgroupNoGroup": "TopdownL1",
+        "MetricgroupNoGroup": "TopdownL1;Default",
         "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
+        "DefaultMetricgroupName": "TopdownL1",
         "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_bound + tma_retiring), 0)",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
-        "MetricgroupNoGroup": "TopdownL1",
+        "MetricgroupNoGroup": "TopdownL1;Default",
         "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -1112,11 +1114,12 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
+        "DefaultMetricgroupName": "TopdownL1",
         "MetricExpr": "cpu_core@topdown\\-fe\\-bound@ / (cpu_core@topdown\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiring@ + cpu_core@topdown\\-be\\-bound@) - cpu_core@INT_MISC.UOP_DROPPING@ / tma_info_thread_slots",
-        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "Default;PGO;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
-        "MetricgroupNoGroup": "TopdownL1",
+        "MetricgroupNoGroup": "TopdownL1;Default",
         "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. Sample with: FRONTEND_RETIRED.LATENCY_GE_4_PS",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2316,11 +2319,12 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
+        "DefaultMetricgroupName": "TopdownL1",
         "MetricExpr": "cpu_core@topdown\\-retiring@ / (cpu_core@topdown\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiring@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
-        "MetricgroupNoGroup": "TopdownL1",
+        "MetricgroupNoGroup": "TopdownL1;Default",
         "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.SLOTS",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
index 20210742171d..cc4edf855064 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
@@ -111,21 +111,23 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
+        "DefaultMetricgroupName": "TopdownL1",
         "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 5 * cpu@INT_MISC.RECOVERY_CYCLES\\,cmask\\=1\\,edge@ / tma_info_thread_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
-        "MetricgroupNoGroup": "TopdownL1",
+        "MetricgroupNoGroup": "TopdownL1;Default",
         "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
+        "DefaultMetricgroupName": "TopdownL1",
         "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_bound + tma_retiring), 0)",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
-        "MetricgroupNoGroup": "TopdownL1",
+        "MetricgroupNoGroup": "TopdownL1;Default",
         "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
         "ScaleUnit": "100%"
     },
@@ -372,11 +374,12 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
+        "DefaultMetricgroupName": "TopdownL1",
         "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.UOP_DROPPING / tma_info_thread_slots",
-        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "Default;PGO;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
-        "MetricgroupNoGroup": "TopdownL1",
+        "MetricgroupNoGroup": "TopdownL1;Default",
         "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. Sample with: FRONTEND_RETIRED.LATENCY_GE_4_PS",
         "ScaleUnit": "100%"
     },
@@ -1378,11 +1381,12 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
+        "DefaultMetricgroupName": "TopdownL1",
         "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_info_thread_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
-        "MetricgroupNoGroup": "TopdownL1",
+        "MetricgroupNoGroup": "TopdownL1;Default",
         "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.SLOTS",
         "ScaleUnit": "100%"
     },
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
index ef25cda019be..6f25b5b7aaf6 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
@@ -315,21 +315,23 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
+        "DefaultMetricgroupName": "TopdownL1",
         "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 5 * cpu@INT_MISC.RECOVERY_CYCLES\\,cmask\\=1\\,edge@ / tma_info_thread_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
-        "MetricgroupNoGroup": "TopdownL1",
+        "MetricgroupNoGroup": "TopdownL1;Default",
         "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
+        "DefaultMetricgroupName": "TopdownL1",
         "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_bound + tma_retiring), 0)",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
-        "MetricgroupNoGroup": "TopdownL1",
+        "MetricgroupNoGroup": "TopdownL1;Default",
         "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
         "ScaleUnit": "100%"
     },
@@ -576,11 +578,12 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
+        "DefaultMetricgroupName": "TopdownL1",
         "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.UOP_DROPPING / tma_info_thread_slots",
-        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "Default;PGO;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
-        "MetricgroupNoGroup": "TopdownL1",
+        "MetricgroupNoGroup": "TopdownL1;Default",
         "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. Sample with: FRONTEND_RETIRED.LATENCY_GE_4_PS",
         "ScaleUnit": "100%"
     },
@@ -1674,11 +1677,12 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
+        "DefaultMetricgroupName": "TopdownL1",
         "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_info_thread_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
-        "MetricgroupNoGroup": "TopdownL1",
+        "MetricgroupNoGroup": "TopdownL1;Default",
         "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.SLOTS",
         "ScaleUnit": "100%"
     },
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
index 4f3dd85540b6..c732982f70b5 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
@@ -340,31 +340,34 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
+        "DefaultMetricgroupName": "TopdownL1",
         "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_info_thread_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
-        "MetricgroupNoGroup": "TopdownL1",
+        "MetricgroupNoGroup": "TopdownL1;Default",
         "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
+        "DefaultMetricgroupName": "TopdownL1",
         "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_bound + tma_retiring), 0)",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
-        "MetricgroupNoGroup": "TopdownL1",
+        "MetricgroupNoGroup": "TopdownL1;Default",
         "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of slots the CPU has wasted due to Branch Misprediction",
+        "DefaultMetricgroupName": "TopdownL2",
         "MetricExpr": "topdown\\-br\\-mispredict / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_info_thread_slots",
-        "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueBM",
+        "MetricGroup": "BadSpec;BrMispredicts;Default;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueBM",
         "MetricName": "tma_branch_mispredicts",
         "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_speculation > 0.15",
-        "MetricgroupNoGroup": "TopdownL2",
+        "MetricgroupNoGroup": "TopdownL2;Default",
         "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Branch Misprediction.  These slots are either wasted by uops fetched from an incorrectly speculated program path; or stalls when the out-of-order part of the machine needs to recover its state from a speculative path. Sample with: TOPDOWN.BR_MISPREDICT_SLOTS. Related metrics: tma_info_bad_spec_branch_misprediction_cost, tma_info_bottleneck_mispredictions, tma_mispredicts_resteers",
         "ScaleUnit": "100%"
     },
@@ -407,11 +410,12 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots where Core non-memory issues were of a bottleneck",
+        "DefaultMetricgroupName": "TopdownL2",
         "MetricExpr": "max(0, tma_backend_bound - tma_memory_bound)",
-        "MetricGroup": "Backend;Compute;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
+        "MetricGroup": "Backend;Compute;Default;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
         "MetricName": "tma_core_bound",
         "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2",
-        "MetricgroupNoGroup": "TopdownL2",
+        "MetricgroupNoGroup": "TopdownL2;Default",
         "PublicDescription": "This metric represents fraction of slots where Core non-memory issues were of a bottleneck.  Shortage in hardware compute resources; or dependencies in software's instructions are both categorized under Core Bound. Hence it may indicate the machine ran out of an out-of-order resource; certain execution units are overloaded or dependencies in program's data- or instruction-flow are limiting the performance (e.g. FP-chained long-latency arithmetic operations).",
         "ScaleUnit": "100%"
     },
@@ -509,21 +513,23 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend bandwidth issues",
+        "DefaultMetricgroupName": "TopdownL2",
         "MetricExpr": "max(0, tma_frontend_bound - tma_fetch_latency)",
-        "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group;tma_issueFB",
+        "MetricGroup": "Default;FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group;tma_issueFB",
         "MetricName": "tma_fetch_bandwidth",
         "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_thread_ipc / 6 > 0.35",
-        "MetricgroupNoGroup": "TopdownL2",
+        "MetricgroupNoGroup": "TopdownL2;Default",
         "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend bandwidth issues.  For example; inefficiencies at the instruction decoders; or restrictions for caching in the DSB (decoded uops cache) are categorized under Fetch Bandwidth. In such cases; the Frontend typically delivers suboptimal amount of uops to the Backend. Sample with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_switches, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend latency issues",
+        "DefaultMetricgroupName": "TopdownL2",
         "MetricExpr": "topdown\\-fetch\\-lat / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.UOP_DROPPING / tma_info_thread_slots",
-        "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group",
+        "MetricGroup": "Default;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend_bound_group",
         "MetricName": "tma_fetch_latency",
         "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
-        "MetricgroupNoGroup": "TopdownL2",
+        "MetricgroupNoGroup": "TopdownL2;Default",
         "PublicDescription": "This metric represents fraction of slots the CPU was stalled due to Frontend latency issues.  For example; instruction-cache misses; iTLB misses or fetch stalls after a branch misprediction are categorized under Frontend Latency. In such cases; the Frontend eventually delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_16_PS;FRONTEND_RETIRED.LATENCY_GE_8_PS",
         "ScaleUnit": "100%"
     },
@@ -611,11 +617,12 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
+        "DefaultMetricgroupName": "TopdownL1",
         "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.UOP_DROPPING / tma_info_thread_slots",
-        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "Default;PGO;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
-        "MetricgroupNoGroup": "TopdownL1",
+        "MetricgroupNoGroup": "TopdownL1;Default",
         "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. Sample with: FRONTEND_RETIRED.LATENCY_GE_4_PS",
         "ScaleUnit": "100%"
     },
@@ -630,11 +637,12 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots where the CPU was retiring heavy-weight operations -- instructions that require two or more uops or micro-coded sequences",
+        "DefaultMetricgroupName": "TopdownL2",
         "MetricExpr": "topdown\\-heavy\\-ops / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_info_thread_slots",
-        "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
+        "MetricGroup": "Default;Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
         "MetricName": "tma_heavy_operations",
         "MetricThreshold": "tma_heavy_operations > 0.1",
-        "MetricgroupNoGroup": "TopdownL2",
+        "MetricgroupNoGroup": "TopdownL2;Default",
         "PublicDescription": "This metric represents fraction of slots where the CPU was retiring heavy-weight operations -- instructions that require two or more uops or micro-coded sequences. This highly-correlates with the uop length of these instructions/sequences. Sample with: UOPS_RETIRED.HEAVY",
         "ScaleUnit": "100%"
     },
@@ -1486,11 +1494,12 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots where the CPU was retiring light-weight operations -- instructions that require no more than one uop (micro-operation)",
+        "DefaultMetricgroupName": "TopdownL2",
         "MetricExpr": "max(0, tma_retiring - tma_heavy_operations)",
-        "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
+        "MetricGroup": "Default;Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_group",
         "MetricName": "tma_light_operations",
         "MetricThreshold": "tma_light_operations > 0.6",
-        "MetricgroupNoGroup": "TopdownL2",
+        "MetricgroupNoGroup": "TopdownL2;Default",
         "PublicDescription": "This metric represents fraction of slots where the CPU was retiring light-weight operations -- instructions that require no more than one uop (micro-operation). This correlates with total number of instructions used by the program. A uops-per-instruction (see UopPI metric) ratio of 1 or less should be expected for decently optimized software running on Intel Core/Xeon products. While this often indicates efficient X86 instructions were executed; high value does not necessarily mean better performance cannot be achieved. Sample with: INST_RETIRED.PREC_DIST",
         "ScaleUnit": "100%"
     },
@@ -1540,11 +1549,12 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the CPU has wasted due to Machine Clears",
+        "DefaultMetricgroupName": "TopdownL2",
         "MetricExpr": "max(0, tma_bad_speculation - tma_branch_mispredicts)",
-        "MetricGroup": "BadSpec;MachineClears;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
+        "MetricGroup": "BadSpec;Default;MachineClears;TmaL2;TopdownL2;tma_L2_group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
         "MetricName": "tma_machine_clears",
         "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation > 0.15",
-        "MetricgroupNoGroup": "TopdownL2",
+        "MetricgroupNoGroup": "TopdownL2;Default",
         "PublicDescription": "This metric represents fraction of slots the CPU has wasted due to Machine Clears.  These slots are either wasted by uops fetched prior to the clear; or stalls the out-of-order portion of the machine needs to recover its state after the clear. For example; this can happen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modifying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: tma_clears_resteers, tma_contested_accesses, tma_data_sharing, tma_false_sharing, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_remote_cache",
         "ScaleUnit": "100%"
     },
@@ -1576,11 +1586,12 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the Memory subsystem within the Backend was a bottleneck",
+        "DefaultMetricgroupName": "TopdownL2",
         "MetricExpr": "topdown\\-mem\\-bound / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_info_thread_slots",
-        "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
+        "MetricGroup": "Backend;Default;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
         "MetricName": "tma_memory_bound",
         "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "MetricgroupNoGroup": "TopdownL2",
+        "MetricgroupNoGroup": "TopdownL2;Default",
         "PublicDescription": "This metric represents fraction of slots the Memory subsystem within the Backend was a bottleneck.  Memory Bound estimates fraction of slots where pipeline is likely stalled due to demand load or store instructions. This accounts mainly for (1) non-completed in-flight memory demand loads which coincides with execution units starvation; in addition to (2) cases where stores could impose backpressure on the pipeline when many of them get buffered at the same time (less common out of the two).",
         "ScaleUnit": "100%"
     },
@@ -1784,11 +1795,12 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
+        "DefaultMetricgroupName": "TopdownL1",
         "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_info_thread_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
-        "MetricgroupNoGroup": "TopdownL1",
+        "MetricgroupNoGroup": "TopdownL1;Default",
         "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.SLOTS",
         "ScaleUnit": "100%"
     },
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json b/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
index d0538a754288..83346911aa63 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
@@ -105,21 +105,23 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
+        "DefaultMetricgroupName": "TopdownL1",
         "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 5 * cpu@INT_MISC.RECOVERY_CYCLES\\,cmask\\=1\\,edge@ / tma_info_thread_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
-        "MetricgroupNoGroup": "TopdownL1",
+        "MetricgroupNoGroup": "TopdownL1;Default",
         "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
+        "DefaultMetricgroupName": "TopdownL1",
         "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_bound + tma_retiring), 0)",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
-        "MetricgroupNoGroup": "TopdownL1",
+        "MetricgroupNoGroup": "TopdownL1;Default",
         "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
         "ScaleUnit": "100%"
     },
@@ -366,11 +368,12 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
+        "DefaultMetricgroupName": "TopdownL1",
         "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.UOP_DROPPING / tma_info_thread_slots",
-        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "Default;PGO;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
-        "MetricgroupNoGroup": "TopdownL1",
+        "MetricgroupNoGroup": "TopdownL1;Default",
         "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. Sample with: FRONTEND_RETIRED.LATENCY_GE_4_PS",
         "ScaleUnit": "100%"
     },
@@ -1392,11 +1395,12 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
+        "DefaultMetricgroupName": "TopdownL1",
         "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_info_thread_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
-        "MetricgroupNoGroup": "TopdownL1",
+        "MetricgroupNoGroup": "TopdownL1;Default",
         "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.SLOTS",
         "ScaleUnit": "100%"
     },
-- 
2.35.1

