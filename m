Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD5B706F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjEQRiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjEQRiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:38:23 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652BFFA
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:38:18 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56098b41d42so10492287b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684345097; x=1686937097;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aegyWnSI1/SQB9csm125NntdHFPP3ygswFR3mDwWLCQ=;
        b=Pvxxs5kYpGlpYzwxHFZxHZPi4WMeD7YEQhkPZD+I01tSabMoLVksGeEHJJxzLV94VQ
         KK7kZDka++cj080NjDUYr3HB6yeUdCfhO/5PRE+xUQgddOr2oStr8bwvbZDPa6KM7ji5
         r6dGK3E3A0YHsUkkZgIBKw+VKjGKtA0aqw1rgXt+Rvidrg3QKR1u7GT5lXqQcmx8Z4Nf
         BdkSfV4c5+Qz5mhqQVwLxl1TJG7vzcrdzu9OQBBJL6Wgxr6cgqhnb0eggSnvjCpoCc8o
         plwabgmzfT2uAB+8bsuBJS+Q8B0WPwCyJYcGU8fKasStmiXf7rFde7GSwM4tLYNUKt+T
         A7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684345097; x=1686937097;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aegyWnSI1/SQB9csm125NntdHFPP3ygswFR3mDwWLCQ=;
        b=JxqiC8iWlbxXYnGmElLW6nZx4GduZE72UZAIfxDnTaDY6N4NWo9KGALGEEiGgtdKLh
         jwcgtlJECfDLToMIy0ACrZKpry8X8iZ7ByK09tgVbDd1w6Ywv8fj8MPakvpm8iks+qym
         F1+s3D4EwcAiMJzJXgzYvvpMSgIb0aU19fJT5mAVjpTlZsmiqZPqkSeZaPqO7//XoqPV
         xbPzWLQATrbt5axOZ6gjhnud580fEgDpl1hGVIXk7Ltnqcd6ux5fUUKug4MlATIkZvL0
         QYYqhUD/Ti8EV81JeYC2trvYChQfkAGBPYNolV3hKKp7SX+fRmO3L7L8eaVC/NvM7495
         e/Zg==
X-Gm-Message-State: AC+VfDzgVgfs8TgN6InR+FTC6Z86EGV4a9wKSpL0qJNT8t3eloQWAAS3
        UbfGqdI8a331jObdCnh/9d+fCVo6yKpv
X-Google-Smtp-Source: ACHHUZ4iVhU7rBvfKtPNxMjFI2RcYgb2zwumsyTWc3M9NifesiGBZukBmL4yPZ3KIvtUqliur+il/fiwrHKA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:eb06:5af6:40f:47ca])
 (user=irogers job=sendgmr) by 2002:a81:8d54:0:b0:55d:d5b1:c2bd with SMTP id
 w20-20020a818d54000000b0055dd5b1c2bdmr23304246ywj.8.1684345097515; Wed, 17
 May 2023 10:38:17 -0700 (PDT)
Date:   Wed, 17 May 2023 10:37:50 -0700
In-Reply-To: <20230517173805.602113-1-irogers@google.com>
Message-Id: <20230517173805.602113-2-irogers@google.com>
Mime-Version: 1.0
References: <20230517173805.602113-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v3 01/15] perf vendor events intel: Update alderlake events/metrics
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update events to v21 including the new event SQ_MISC.BUS_LOCK and
improved comments. Metrics are updated to make TMA info metric names
synchronized. Events and metrics were generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/alderlake/adl-metrics.json       | 1314 ++++++++---------
 .../pmu-events/arch/x86/alderlake/cache.json  |    9 +
 .../pmu-events/arch/x86/alderlake/memory.json |    6 +-
 .../arch/x86/alderlaken/adln-metrics.json     |  276 ++--
 tools/perf/pmu-events/arch/x86/mapfile.csv    |    4 +-
 5 files changed, 784 insertions(+), 825 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/to=
ols/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
index 840f6f6fc8c5..c9f7e3d4ab08 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
@@ -71,7 +71,7 @@
     },
     {
         "BriefDescription": "Uncore frequency per die [GHZ]",
-        "MetricExpr": "tma_info_socket_clks / #num_dies / duration_time / =
1e9",
+        "MetricExpr": "tma_info_system_socket_clks / #num_dies / duration_=
time / 1e9",
         "MetricGroup": "SoC",
         "MetricName": "UNCORE_FREQ"
     },
@@ -120,7 +120,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to certain allocation restrictions.",
-        "MetricExpr": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS / tma_info_slot=
s",
+        "MetricExpr": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS / tma_info_core=
_slots",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_alloc_restriction",
         "MetricThreshold": "tma_alloc_restriction > 0.1",
@@ -129,7 +129,7 @@
     },
     {
         "BriefDescription": "Counts the total number of issue slots  that =
were not consumed by the backend due to backend stalls",
-        "MetricExpr": "TOPDOWN_BE_BOUND.ALL / tma_info_slots",
+        "MetricExpr": "TOPDOWN_BE_BOUND.ALL / tma_info_core_slots",
         "MetricGroup": "TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.1",
@@ -151,7 +151,7 @@
     },
     {
         "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a misp=
redicted jump or a machine clear",
-        "MetricExpr": "(tma_info_slots - (cpu_atom@TOPDOWN_FE_BOUND.ALL@ +=
 cpu_atom@TOPDOWN_BE_BOUND.ALL@ + cpu_atom@TOPDOWN_RETIRING.ALL@)) / tma_in=
fo_slots",
+        "MetricExpr": "(tma_info_core_slots - (cpu_atom@TOPDOWN_FE_BOUND.A=
LL@ + cpu_atom@TOPDOWN_BE_BOUND.ALL@ + cpu_atom@TOPDOWN_RETIRING.ALL@)) / t=
ma_info_core_slots",
         "MetricGroup": "TopdownL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
@@ -162,7 +162,7 @@
     },
     {
         "BriefDescription": "Counts the number of uops that are not from t=
he microsequencer.",
-        "MetricExpr": "(cpu_atom@TOPDOWN_RETIRING.ALL@ - cpu_atom@UOPS_RET=
IRED.MS@) / tma_info_slots",
+        "MetricExpr": "(cpu_atom@TOPDOWN_RETIRING.ALL@ - cpu_atom@UOPS_RET=
IRED.MS@) / tma_info_core_slots",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_retiring_group",
         "MetricName": "tma_base",
         "MetricThreshold": "tma_base > 0.6",
@@ -172,7 +172,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to BACLEARS, which occurs when the Branch =
Target Buffer (BTB) prediction or lack thereof, was corrected by a later br=
anch predictor in the frontend",
-        "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_DETECT / tma_info_slots",
+        "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_DETECT / tma_info_core_slot=
s",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_latency_group",
         "MetricName": "tma_branch_detect",
         "MetricThreshold": "tma_branch_detect > 0.05",
@@ -182,7 +182,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to branch mispredicts.",
-        "MetricExpr": "TOPDOWN_BAD_SPECULATION.MISPREDICT / tma_info_slots=
",
+        "MetricExpr": "TOPDOWN_BAD_SPECULATION.MISPREDICT / tma_info_core_=
slots",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
         "MetricName": "tma_branch_mispredicts",
         "MetricThreshold": "tma_branch_mispredicts > 0.05",
@@ -192,7 +192,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to BTCLEARS, which occurs when the Branch =
Target Buffer (BTB) predicts a taken branch.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_RESTEER / tma_info_slots",
+        "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_RESTEER / tma_info_core_slo=
ts",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_latency_group",
         "MetricName": "tma_branch_resteer",
         "MetricThreshold": "tma_branch_resteer > 0.05",
@@ -201,7 +201,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to the microcode sequencer (MS).",
-        "MetricExpr": "TOPDOWN_FE_BOUND.CISC / tma_info_slots",
+        "MetricExpr": "TOPDOWN_FE_BOUND.CISC / tma_info_core_slots",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_bandwidth_group",
         "MetricName": "tma_cisc",
         "MetricThreshold": "tma_cisc > 0.05",
@@ -220,7 +220,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to decode stalls.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.DECODE / tma_info_slots",
+        "MetricExpr": "TOPDOWN_FE_BOUND.DECODE / tma_info_core_slots",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_bandwidth_group",
         "MetricName": "tma_decode",
         "MetricThreshold": "tma_decode > 0.05",
@@ -239,7 +239,7 @@
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load miss which hit in DRAM or MMIO (Non-DRAM).",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "cpu_atom@MEM_BOUND_STALLS.LOAD_DRAM_HIT@ / tma_info=
_clks - max((cpu_atom@MEM_BOUND_STALLS.LOAD@ - cpu_atom@LD_HEAD.L1_MISS_AT_=
RET@) / tma_info_clks, 0) * cpu_atom@MEM_BOUND_STALLS.LOAD_DRAM_HIT@ / cpu_=
atom@MEM_BOUND_STALLS.LOAD@",
+        "MetricExpr": "cpu_atom@MEM_BOUND_STALLS.LOAD_DRAM_HIT@ / tma_info=
_core_clks - max((cpu_atom@MEM_BOUND_STALLS.LOAD@ - cpu_atom@LD_HEAD.L1_MIS=
S_AT_RET@) / tma_info_core_clks, 0) * cpu_atom@MEM_BOUND_STALLS.LOAD_DRAM_H=
IT@ / cpu_atom@MEM_BOUND_STALLS.LOAD@",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
         "MetricName": "tma_dram_bound",
         "MetricThreshold": "tma_dram_bound > 0.1",
@@ -248,7 +248,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to a machine clear classified as a fast nuke=
 due to memory ordering, memory disambiguation and memory renaming.",
-        "MetricExpr": "TOPDOWN_BAD_SPECULATION.FASTNUKE / tma_info_slots",
+        "MetricExpr": "TOPDOWN_BAD_SPECULATION.FASTNUKE / tma_info_core_sl=
ots",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
         "MetricName": "tma_fast_nuke",
         "MetricThreshold": "tma_fast_nuke > 0.05",
@@ -257,7 +257,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to frontend bandwidth restrictions due to =
decode, predecode, cisc, and other limitations.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH / tma_info_slot=
s",
+        "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH / tma_info_core=
_slots",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
         "MetricName": "tma_fetch_bandwidth",
         "MetricThreshold": "tma_fetch_bandwidth > 0.1",
@@ -267,7 +267,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to frontend bandwidth restrictions due to =
decode, predecode, cisc, and other limitations.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY / tma_info_slots"=
,
+        "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY / tma_info_core_s=
lots",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
         "MetricName": "tma_fetch_latency",
         "MetricThreshold": "tma_fetch_latency > 0.15",
@@ -286,7 +286,7 @@
     },
     {
         "BriefDescription": "Counts the number of floating point divide op=
erations per uop.",
-        "MetricExpr": "UOPS_RETIRED.FPDIV / tma_info_slots",
+        "MetricExpr": "UOPS_RETIRED.FPDIV / tma_info_core_slots",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_base_group",
         "MetricName": "tma_fpdiv_uops",
         "MetricThreshold": "tma_fpdiv_uops > 0.2",
@@ -295,7 +295,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to frontend stalls.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.ALL / tma_info_slots",
+        "MetricExpr": "TOPDOWN_FE_BOUND.ALL / tma_info_core_slots",
         "MetricGroup": "TopdownL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.2",
@@ -305,254 +305,228 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to instruction cache misses.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.ICACHE / tma_info_slots",
+        "MetricExpr": "TOPDOWN_FE_BOUND.ICACHE / tma_info_core_slots",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_latency_group",
         "MetricName": "tma_icache_misses",
         "MetricThreshold": "tma_icache_misses > 0.05",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
-    {
-        "BriefDescription": "Percentage of total non-speculative loads wit=
h a address aliasing block",
-        "MetricExpr": "100 * cpu_atom@LD_BLOCKS.4K_ALIAS@ / MEM_UOPS_RETIR=
ED.ALL_LOADS",
-        "MetricName": "tma_info_address_alias_blocks",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Ratio of all branches which mispredict",
-        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.ALL_=
BRANCHES",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_branch_mispredict_ratio",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Ratio between Mispredicted branches and unkno=
wn branches",
-        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / BACLEARS.ANY",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_branch_mispredict_to_unknown_branch_ratio"=
,
-        "Unit": "cpu_atom"
-    },
     {
         "BriefDescription": "",
         "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE@",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_clks",
+        "MetricName": "tma_info_core_clks",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "",
         "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE_P@",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_clks_p",
+        "MetricName": "tma_info_core_clks_p",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Cycles Per Instruction",
-        "MetricExpr": "tma_info_clks / INST_RETIRED.ANY",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_cpi",
+        "MetricExpr": "tma_info_core_clks / INST_RETIRED.ANY",
+        "MetricName": "tma_info_core_cpi",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Average CPU Utilization",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_cpu_utilization",
+        "BriefDescription": "Instructions Per Cycle",
+        "MetricExpr": "INST_RETIRED.ANY / tma_info_core_clks",
+        "MetricName": "tma_info_core_ipc",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Cycle cost per DRAM hit",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_DRAM_HIT / MEM_LOAD_UOPS_RETI=
RED.DRAM_HIT",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_cycles_per_demand_load_dram_hit",
+        "BriefDescription": "",
+        "MetricExpr": "5 * tma_info_core_clks",
+        "MetricName": "tma_info_core_slots",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Cycle cost per L2 hit",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_L2_HIT / MEM_LOAD_UOPS_RETIRE=
D.L2_HIT",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_cycles_per_demand_load_l2_hit",
+        "BriefDescription": "Uops Per Instruction",
+        "MetricExpr": "UOPS_RETIRED.ALL / INST_RETIRED.ANY",
+        "MetricName": "tma_info_core_upi",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Cycle cost per LLC hit",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_LLC_HIT / MEM_LOAD_UOPS_RETIR=
ED.L3_HIT",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_cycles_per_demand_load_l3_hit",
+        "BriefDescription": "Percent of instruction miss cost that hit in =
DRAM",
+        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.IFETCH_DRAM_HIT@ / =
cpu_atom@MEM_BOUND_STALLS.IFETCH@",
+        "MetricName": "tma_info_frontend_inst_miss_cost_dramhit_percent",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of all uops which are FPDiv uops",
-        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.FPDIV@ / UOPS_RETIRED.A=
LL",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_fpdiv_uop_ratio",
+        "BriefDescription": "Percent of instruction miss cost that hit in =
the L2",
+        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.IFETCH_L2_HIT@ / cp=
u_atom@MEM_BOUND_STALLS.IFETCH@",
+        "MetricName": "tma_info_frontend_inst_miss_cost_l2hit_percent",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of all uops which are IDiv uops",
-        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.IDIV@ / UOPS_RETIRED.AL=
L",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_idiv_uop_ratio",
+        "BriefDescription": "Percent of instruction miss cost that hit in =
the L3",
+        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.IFETCH_LLC_HIT@ / c=
pu_atom@MEM_BOUND_STALLS.IFETCH@",
+        "MetricName": "tma_info_frontend_inst_miss_cost_l3hit_percent",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percent of instruction miss cost that hit in =
DRAM",
-        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.IFETCH_DRAM_HIT@ / =
cpu_atom@MEM_BOUND_STALLS.IFETCH@",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_inst_miss_cost_dramhit_percent",
+        "BriefDescription": "Ratio of all branches which mispredict",
+        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.ALL_=
BRANCHES",
+        "MetricName": "tma_info_inst_mix_branch_mispredict_ratio",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percent of instruction miss cost that hit in =
the L2",
-        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.IFETCH_L2_HIT@ / cp=
u_atom@MEM_BOUND_STALLS.IFETCH@",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_inst_miss_cost_l2hit_percent",
+        "BriefDescription": "Ratio between Mispredicted branches and unkno=
wn branches",
+        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / BACLEARS.ANY",
+        "MetricName": "tma_info_inst_mix_branch_mispredict_to_unknown_bran=
ch_ratio",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percent of instruction miss cost that hit in =
the L3",
-        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.IFETCH_LLC_HIT@ / c=
pu_atom@MEM_BOUND_STALLS.IFETCH@",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_inst_miss_cost_l3hit_percent",
+        "BriefDescription": "Percentage of all uops which are FPDiv uops",
+        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.FPDIV@ / UOPS_RETIRED.A=
LL",
+        "MetricName": "tma_info_inst_mix_fpdiv_uop_ratio",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurance rate)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_ipbranch",
+        "BriefDescription": "Percentage of all uops which are IDiv uops",
+        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.IDIV@ / UOPS_RETIRED.AL=
L",
+        "MetricName": "tma_info_inst_mix_idiv_uop_ratio",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions Per Cycle",
-        "MetricExpr": "INST_RETIRED.ANY / tma_info_clks",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_ipc",
+        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurance rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricName": "tma_info_inst_mix_ipbranch",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Instruction per (near) call (lower number mea=
ns higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.CALL",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_ipcall",
+        "MetricName": "tma_info_inst_mix_ipcall",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Instructions per Far Branch",
         "MetricExpr": "INST_RETIRED.ANY / (cpu_atom@BR_INST_RETIRED.FAR_BR=
ANCH@ / 2)",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_ipfarbranch",
+        "MetricName": "tma_info_inst_mix_ipfarbranch",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Instructions per Load",
         "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_LOADS",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_ipload",
+        "MetricName": "tma_info_inst_mix_ipload",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Instructions per retired conditional Branch M=
isprediction where the branch was not taken",
         "MetricExpr": "INST_RETIRED.ANY / (cpu_atom@BR_MISP_RETIRED.COND@ =
- cpu_atom@BR_MISP_RETIRED.COND_TAKEN@)",
-        "MetricName": "tma_info_ipmisp_cond_ntaken",
+        "MetricName": "tma_info_inst_mix_ipmisp_cond_ntaken",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Instructions per retired conditional Branch M=
isprediction where the branch was taken",
         "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_TAKEN",
-        "MetricName": "tma_info_ipmisp_cond_taken",
+        "MetricName": "tma_info_inst_mix_ipmisp_cond_taken",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Instructions per retired indirect call or jum=
p Branch Misprediction",
         "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.INDIRECT",
-        "MetricName": "tma_info_ipmisp_indirect",
+        "MetricName": "tma_info_inst_mix_ipmisp_indirect",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Instructions per retired return Branch Mispre=
diction",
         "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.RETURN",
-        "MetricName": "tma_info_ipmisp_ret",
+        "MetricName": "tma_info_inst_mix_ipmisp_ret",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Instructions per retired Branch Misprediction=
",
         "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_ipmispredict",
+        "MetricName": "tma_info_inst_mix_ipmispredict",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Instructions per Store",
         "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_STORES",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_ipstore",
+        "MetricName": "tma_info_inst_mix_ipstore",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE@k / CPU_CLK_UNHALTED=
.CORE",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_kernel_utilization",
+        "BriefDescription": "Percentage of all uops which are ucode ops",
+        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.MS@ / UOPS_RETIRED.ALL"=
,
+        "MetricName": "tma_info_inst_mix_microcode_uop_ratio",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of all uops which are x87 uops",
+        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.X87@ / UOPS_RETIRED.ALL=
",
+        "MetricName": "tma_info_inst_mix_x87_uop_ratio",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of total non-speculative loads wit=
h a address aliasing block",
+        "MetricExpr": "100 * cpu_atom@LD_BLOCKS.4K_ALIAS@ / MEM_UOPS_RETIR=
ED.ALL_LOADS",
+        "MetricName": "tma_info_l1_bound_address_alias_blocks",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Percentage of total non-speculative loads tha=
t are splits",
         "MetricExpr": "100 * cpu_atom@MEM_UOPS_RETIRED.SPLIT_LOADS@ / MEM_=
UOPS_RETIRED.ALL_LOADS",
-        "MetricName": "tma_info_load_splits",
+        "MetricName": "tma_info_l1_bound_load_splits",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "load ops retired per 1000 instruction",
-        "MetricExpr": "1e3 * cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@ / INST_R=
ETIRED.ANY",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_memloadpki",
+        "BriefDescription": "Percentage of total non-speculative loads wit=
h a store forward or unknown store address block",
+        "MetricExpr": "100 * cpu_atom@LD_BLOCKS.DATA_UNKNOWN@ / MEM_UOPS_R=
ETIRED.ALL_LOADS",
+        "MetricName": "tma_info_l1_bound_store_fwd_blocks",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of all uops which are ucode ops",
-        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.MS@ / UOPS_RETIRED.ALL"=
,
-        "MetricGroup": " ",
-        "MetricName": "tma_info_microcode_uop_ratio",
+        "BriefDescription": "Cycle cost per DRAM hit",
+        "MetricExpr": "MEM_BOUND_STALLS.LOAD_DRAM_HIT / MEM_LOAD_UOPS_RETI=
RED.DRAM_HIT",
+        "MetricName": "tma_info_memory_cycles_per_demand_load_dram_hit",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "",
-        "MetricExpr": "5 * tma_info_clks",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_slots",
+        "BriefDescription": "Cycle cost per L2 hit",
+        "MetricExpr": "MEM_BOUND_STALLS.LOAD_L2_HIT / MEM_LOAD_UOPS_RETIRE=
D.L2_HIT",
+        "MetricName": "tma_info_memory_cycles_per_demand_load_l2_hit",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of total non-speculative loads wit=
h a store forward or unknown store address block",
-        "MetricExpr": "100 * cpu_atom@LD_BLOCKS.DATA_UNKNOWN@ / MEM_UOPS_R=
ETIRED.ALL_LOADS",
-        "MetricName": "tma_info_store_fwd_blocks",
+        "BriefDescription": "Cycle cost per LLC hit",
+        "MetricExpr": "MEM_BOUND_STALLS.LOAD_LLC_HIT / MEM_LOAD_UOPS_RETIR=
ED.L3_HIT",
+        "MetricName": "tma_info_memory_cycles_per_demand_load_l3_hit",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
-        "MetricExpr": "tma_info_clks / CPU_CLK_UNHALTED.REF_TSC",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_turbo_utilization",
+        "BriefDescription": "load ops retired per 1000 instruction",
+        "MetricExpr": "1e3 * cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@ / INST_R=
ETIRED.ANY",
+        "MetricName": "tma_info_memory_memloadpki",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Uops Per Instruction",
-        "MetricExpr": "UOPS_RETIRED.ALL / INST_RETIRED.ANY",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_upi",
+        "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricName": "tma_info_system_cpu_utilization",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of all uops which are x87 uops",
-        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.X87@ / UOPS_RETIRED.ALL=
",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_x87_uop_ratio",
+        "BriefDescription": "Fraction of cycles spent in Kernel mode",
+        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE@k / CPU_CLK_UNHALTED=
.CORE",
+        "MetricGroup": "Summary",
+        "MetricName": "tma_info_system_kernel_utilization",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
+        "MetricExpr": "tma_info_core_clks / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricGroup": "Power",
+        "MetricName": "tma_info_system_turbo_utilization",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to Instruction Table Lookaside Buffer (ITL=
B) misses.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.ITLB / tma_info_slots",
+        "MetricExpr": "TOPDOWN_FE_BOUND.ITLB / tma_info_core_slots",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_latency_group",
         "MetricName": "tma_itlb_misses",
         "MetricThreshold": "tma_itlb_misses > 0.05",
@@ -561,7 +535,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a load block.",
-        "MetricExpr": "LD_HEAD.L1_BOUND_AT_RET / tma_info_clks",
+        "MetricExpr": "LD_HEAD.L1_BOUND_AT_RET / tma_info_core_clks",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
         "MetricName": "tma_l1_bound",
         "MetricThreshold": "tma_l1_bound > 0.1",
@@ -571,7 +545,7 @@
     {
         "BriefDescription": "Counts the number of cycles a core is stalled=
 due to a demand load which hit in the L2 Cache.",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "cpu_atom@MEM_BOUND_STALLS.LOAD_L2_HIT@ / tma_info_c=
lks - max((cpu_atom@MEM_BOUND_STALLS.LOAD@ - cpu_atom@LD_HEAD.L1_MISS_AT_RE=
T@) / tma_info_clks, 0) * cpu_atom@MEM_BOUND_STALLS.LOAD_L2_HIT@ / cpu_atom=
@MEM_BOUND_STALLS.LOAD@",
+        "MetricExpr": "cpu_atom@MEM_BOUND_STALLS.LOAD_L2_HIT@ / tma_info_c=
ore_clks - max((cpu_atom@MEM_BOUND_STALLS.LOAD@ - cpu_atom@LD_HEAD.L1_MISS_=
AT_RET@) / tma_info_core_clks, 0) * cpu_atom@MEM_BOUND_STALLS.LOAD_L2_HIT@ =
/ cpu_atom@MEM_BOUND_STALLS.LOAD@",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
         "MetricName": "tma_l2_bound",
         "MetricThreshold": "tma_l2_bound > 0.1",
@@ -580,7 +554,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles a core is stalled=
 due to a demand load which hit in the Last Level Cache (LLC) or other core=
 with HITE/F/M.",
-        "MetricExpr": "cpu_atom@MEM_BOUND_STALLS.LOAD_LLC_HIT@ / tma_info_=
clks - max((cpu_atom@MEM_BOUND_STALLS.LOAD@ - cpu_atom@LD_HEAD.L1_MISS_AT_R=
ET@) / tma_info_clks, 0) * cpu_atom@MEM_BOUND_STALLS.LOAD_LLC_HIT@ / cpu_at=
om@MEM_BOUND_STALLS.LOAD@",
+        "MetricExpr": "cpu_atom@MEM_BOUND_STALLS.LOAD_LLC_HIT@ / tma_info_=
core_clks - max((cpu_atom@MEM_BOUND_STALLS.LOAD@ - cpu_atom@LD_HEAD.L1_MISS=
_AT_RET@) / tma_info_core_clks, 0) * cpu_atom@MEM_BOUND_STALLS.LOAD_LLC_HIT=
@ / cpu_atom@MEM_BOUND_STALLS.LOAD@",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
         "MetricThreshold": "tma_l3_bound > 0.1",
@@ -598,7 +572,7 @@
     },
     {
         "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a mach=
ine clear (nuke) of any kind including memory ordering and memory disambigu=
ation.",
-        "MetricExpr": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS / tma_info_s=
lots",
+        "MetricExpr": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS / tma_info_c=
ore_slots",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
         "MetricName": "tma_machine_clears",
         "MetricThreshold": "tma_machine_clears > 0.05",
@@ -608,7 +582,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to memory reservation stalls in which a sche=
duler is not able to accept uops.",
-        "MetricExpr": "TOPDOWN_BE_BOUND.MEM_SCHEDULER / tma_info_slots",
+        "MetricExpr": "TOPDOWN_BE_BOUND.MEM_SCHEDULER / tma_info_core_slot=
s",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_mem_scheduler",
         "MetricThreshold": "tma_mem_scheduler > 0.1",
@@ -617,7 +591,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to stores or loads.",
-        "MetricExpr": "min(cpu_atom@TOPDOWN_BE_BOUND.ALL@ / tma_info_slots=
, cpu_atom@LD_HEAD.ANY_AT_RET@ / tma_info_clks + tma_store_bound)",
+        "MetricExpr": "min(cpu_atom@TOPDOWN_BE_BOUND.ALL@ / tma_info_core_=
slots, cpu_atom@LD_HEAD.ANY_AT_RET@ / tma_info_core_clks + tma_store_bound)=
",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
         "MetricName": "tma_memory_bound",
         "MetricThreshold": "tma_memory_bound > 0.2",
@@ -636,7 +610,7 @@
     },
     {
         "BriefDescription": "Counts the number of uops that are from the c=
omplex flows issued by the micro-sequencer (MS)",
-        "MetricExpr": "UOPS_RETIRED.MS / tma_info_slots",
+        "MetricExpr": "UOPS_RETIRED.MS / tma_info_core_slots",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_retiring_group",
         "MetricName": "tma_ms_uops",
         "MetricThreshold": "tma_ms_uops > 0.05",
@@ -647,7 +621,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to IEC or FPC RAT stalls, which can be due t=
o FIQ or IEC reservation stalls in which the integer, floating point or SIM=
D scheduler is not able to accept uops.",
-        "MetricExpr": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER / tma_info_slots=
",
+        "MetricExpr": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER / tma_info_core_=
slots",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_non_mem_scheduler",
         "MetricThreshold": "tma_non_mem_scheduler > 0.1",
@@ -656,7 +630,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to a machine clear (slow nuke).",
-        "MetricExpr": "TOPDOWN_BAD_SPECULATION.NUKE / tma_info_slots",
+        "MetricExpr": "TOPDOWN_BAD_SPECULATION.NUKE / tma_info_core_slots"=
,
         "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
         "MetricName": "tma_nuke",
         "MetricThreshold": "tma_nuke > 0.05",
@@ -665,7 +639,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to other common frontend stalls not catego=
rized.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.OTHER / tma_info_slots",
+        "MetricExpr": "TOPDOWN_FE_BOUND.OTHER / tma_info_core_slots",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_bandwidth_group",
         "MetricName": "tma_other_fb",
         "MetricThreshold": "tma_other_fb > 0.05",
@@ -674,7 +648,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a number of other lo=
ad blocks.",
-        "MetricExpr": "LD_HEAD.OTHER_AT_RET / tma_info_clks",
+        "MetricExpr": "LD_HEAD.OTHER_AT_RET / tma_info_core_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_other_l1",
         "MetricThreshold": "tma_other_l1 > 0.05",
@@ -692,7 +666,7 @@
     },
     {
         "BriefDescription": "Counts the number of uops retired excluding m=
s and fp div uops.",
-        "MetricExpr": "(cpu_atom@TOPDOWN_RETIRING.ALL@ - cpu_atom@UOPS_RET=
IRED.MS@ - cpu_atom@UOPS_RETIRED.FPDIV@) / tma_info_slots",
+        "MetricExpr": "(cpu_atom@TOPDOWN_RETIRING.ALL@ - cpu_atom@UOPS_RET=
IRED.MS@ - cpu_atom@UOPS_RETIRED.FPDIV@) / tma_info_core_slots",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_base_group",
         "MetricName": "tma_other_ret",
         "MetricThreshold": "tma_other_ret > 0.3",
@@ -710,7 +684,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to wrong predecodes.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.PREDECODE / tma_info_slots",
+        "MetricExpr": "TOPDOWN_FE_BOUND.PREDECODE / tma_info_core_slots",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_bandwidth_group",
         "MetricName": "tma_predecode",
         "MetricThreshold": "tma_predecode > 0.05",
@@ -719,7 +693,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to the physical register file unable to acce=
pt an entry (marble stalls).",
-        "MetricExpr": "TOPDOWN_BE_BOUND.REGISTER / tma_info_slots",
+        "MetricExpr": "TOPDOWN_BE_BOUND.REGISTER / tma_info_core_slots",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_register",
         "MetricThreshold": "tma_register > 0.1",
@@ -728,7 +702,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to the reorder buffer being full (ROB stalls=
).",
-        "MetricExpr": "TOPDOWN_BE_BOUND.REORDER_BUFFER / tma_info_slots",
+        "MetricExpr": "TOPDOWN_BE_BOUND.REORDER_BUFFER / tma_info_core_slo=
ts",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_reorder_buffer",
         "MetricThreshold": "tma_reorder_buffer > 0.1",
@@ -748,7 +722,7 @@
     },
     {
         "BriefDescription": "Counts the numer of issue slots  that result =
in retirement slots.",
-        "MetricExpr": "TOPDOWN_RETIRING.ALL / tma_info_slots",
+        "MetricExpr": "TOPDOWN_RETIRING.ALL / tma_info_core_slots",
         "MetricGroup": "TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.75",
@@ -767,7 +741,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to scoreboards from the instruction queue (I=
Q), jump execution unit (JEU), or microcode sequencer (MS).",
-        "MetricExpr": "TOPDOWN_BE_BOUND.SERIALIZATION / tma_info_slots",
+        "MetricExpr": "TOPDOWN_BE_BOUND.SERIALIZATION / tma_info_core_slot=
s",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_serialization",
         "MetricThreshold": "tma_serialization > 0.1",
@@ -794,7 +768,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a first level TLB mi=
ss.",
-        "MetricExpr": "LD_HEAD.DTLB_MISS_AT_RET / tma_info_clks",
+        "MetricExpr": "LD_HEAD.DTLB_MISS_AT_RET / tma_info_core_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_stlb_hit",
         "MetricThreshold": "tma_stlb_hit > 0.05",
@@ -803,7 +777,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a second level TLB m=
iss requiring a page walk.",
-        "MetricExpr": "LD_HEAD.PGWALK_AT_RET / tma_info_clks",
+        "MetricExpr": "LD_HEAD.PGWALK_AT_RET / tma_info_core_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_stlb_miss",
         "MetricThreshold": "tma_stlb_miss > 0.05",
@@ -821,7 +795,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a store forward bloc=
k.",
-        "MetricExpr": "LD_HEAD.ST_ADDR_AT_RET / tma_info_clks",
+        "MetricExpr": "LD_HEAD.ST_ADDR_AT_RET / tma_info_core_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_store_fwd_blk",
         "MetricThreshold": "tma_store_fwd_blk > 0.05",
@@ -830,7 +804,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
-        "MetricExpr": "(cpu_core@UOPS_DISPATCHED.PORT_0@ + cpu_core@UOPS_D=
ISPATCHED.PORT_1@ + cpu_core@UOPS_DISPATCHED.PORT_5_11@ + cpu_core@UOPS_DIS=
PATCHED.PORT_6@) / (5 * tma_info_core_clks)",
+        "MetricExpr": "(cpu_core@UOPS_DISPATCHED.PORT_0@ + cpu_core@UOPS_D=
ISPATCHED.PORT_1@ + cpu_core@UOPS_DISPATCHED.PORT_5_11@ + cpu_core@UOPS_DIS=
PATCHED.PORT_6@) / (5 * tma_info_core_core_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_alu_op_utilization",
         "MetricThreshold": "tma_alu_op_utilization > 0.6",
@@ -839,7 +813,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops delivered by the Microcode_Sequencer as a result of Assists=
",
-        "MetricExpr": "100 * cpu_core@ASSISTS.ANY\\,umask\\=3D0x1B@ / tma_=
info_slots",
+        "MetricExpr": "100 * cpu_core@ASSISTS.ANY\\,umask\\=3D0x1B@ / tma_=
info_thread_slots",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
         "MetricName": "tma_assists",
         "MetricThreshold": "tma_assists > 0.1 & (tma_microcode_sequencer >=
 0.05 & tma_heavy_operations > 0.1)",
@@ -849,7 +823,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops as a result of handing SSE to AVX* or AVX* to SSE transitio=
n Assists.",
-        "MetricExpr": "63 * cpu_core@ASSISTS.SSE_AVX_MIX@ / tma_info_slots=
",
+        "MetricExpr": "63 * cpu_core@ASSISTS.SSE_AVX_MIX@ / tma_info_threa=
d_slots",
         "MetricGroup": "HPC;TopdownL5;tma_L5_group;tma_assists_group",
         "MetricName": "tma_avx_assists",
         "MetricThreshold": "tma_avx_assists > 0.1",
@@ -858,7 +832,7 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
-        "MetricExpr": "cpu_core@topdown\\-be\\-bound@ / (cpu_core@topdown\=
\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retirin=
g@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_slots",
+        "MetricExpr": "cpu_core@topdown\\-be\\-bound@ / (cpu_core@topdown\=
\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retirin=
g@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
         "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
@@ -880,18 +854,18 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction",
-        "MetricExpr": "cpu_core@topdown\\-br\\-mispredict@ / (cpu_core@top=
down\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-re=
tiring@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_slots",
+        "MetricExpr": "cpu_core@topdown\\-br\\-mispredict@ / (cpu_core@top=
down\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-re=
tiring@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
         "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_group=
;tma_bad_speculation_group;tma_issueBM",
         "MetricName": "tma_branch_mispredicts",
         "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specula=
tion > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: TOPDOWN.BR_MISPREDICT_SLOTS. Related metrics: =
tma_info_branch_misprediction_cost, tma_info_mispredictions, tma_mispredict=
s_resteers",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: TOPDOWN.BR_MISPREDICT_SLOTS. Related metrics: =
tma_info_bad_spec_branch_misprediction_cost, tma_info_bottleneck_mispredict=
ions, tma_mispredicts_resteers",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers",
-        "MetricExpr": "INT_MISC.CLEAR_RESTEER_CYCLES / tma_info_clks + tma=
_unknown_branches",
+        "MetricExpr": "INT_MISC.CLEAR_RESTEER_CYCLES / tma_info_thread_clk=
s + tma_unknown_branches",
         "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group",
         "MetricName": "tma_branch_resteers",
         "MetricThreshold": "tma_branch_resteers > 0.05 & (tma_fetch_latenc=
y > 0.1 & tma_frontend_bound > 0.15)",
@@ -911,7 +885,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Machine Clears",
-        "MetricExpr": "(1 - tma_branch_mispredicts / tma_bad_speculation) =
* cpu_core@INT_MISC.CLEAR_RESTEER_CYCLES@ / tma_info_clks",
+        "MetricExpr": "(1 - tma_branch_mispredicts / tma_bad_speculation) =
* cpu_core@INT_MISC.CLEAR_RESTEER_CYCLES@ / tma_info_thread_clks",
         "MetricGroup": "BadSpec;MachineClears;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group;tma_issueMC",
         "MetricName": "tma_clears_resteers",
         "MetricThreshold": "tma_clears_resteers > 0.05 & (tma_branch_reste=
ers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
@@ -922,7 +896,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(25 * tma_info_average_frequency * (cpu_core@MEM_LO=
AD_L3_HIT_RETIRED.XSNP_FWD@ * (cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT=
M@ / (cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ + cpu_core@OCR.DEMAND_=
DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD@))) + 24 * tma_info_average_frequency * c=
pu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS@) * (1 + cpu_core@MEM_LOAD_RETIRE=
D.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_MISS@ / 2) / tma_info_clks",
+        "MetricExpr": "(25 * tma_info_system_average_frequency * (cpu_core=
@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ * (cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SN=
OOP_HITM@ / (cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ + cpu_core@OCR.=
DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD@))) + 24 * tma_info_system_average=
_frequency * cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS@) * (1 + cpu_core@M=
EM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_MISS@ / 2) / tma_inf=
o_thread_clks",
         "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_l3_bound_group",
         "MetricName": "tma_contested_accesses",
         "MetricThreshold": "tma_contested_accesses > 0.05 & (tma_l3_bound =
> 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -944,7 +918,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "24 * tma_info_average_frequency * (cpu_core@MEM_LOA=
D_L3_HIT_RETIRED.XSNP_NO_FWD@ + cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ =
* (1 - cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ / (cpu_core@OCR.DEMAN=
D_DATA_RD.L3_HIT.SNOOP_HITM@ + cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT=
_WITH_FWD@))) * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_=
RETIRED.L1_MISS@ / 2) / tma_info_clks",
+        "MetricExpr": "24 * tma_info_system_average_frequency * (cpu_core@=
MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD@ + cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSN=
P_FWD@ * (1 - cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ / (cpu_core@OC=
R.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ + cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SN=
OOP_HIT_WITH_FWD@))) * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@ME=
M_LOAD_RETIRED.L1_MISS@ / 2) / tma_info_thread_clks",
         "MetricGroup": "Offcore;Snoop;TopdownL4;tma_L4_group;tma_issueSync=
xn;tma_l3_bound_group",
         "MetricName": "tma_data_sharing",
         "MetricThreshold": "tma_data_sharing > 0.05 & (tma_l3_bound > 0.05=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -954,17 +928,17 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re decoder-0 was the only active decoder",
-        "MetricExpr": "(cpu_core@INST_DECODED.DECODERS\\,cmask\\=3D1@ - cp=
u_core@INST_DECODED.DECODERS\\,cmask\\=3D2@) / tma_info_core_clks / 2",
+        "MetricExpr": "(cpu_core@INST_DECODED.DECODERS\\,cmask\\=3D1@ - cp=
u_core@INST_DECODED.DECODERS\\,cmask\\=3D2@) / tma_info_core_core_clks / 2"=
,
         "MetricGroup": "DSBmiss;FetchBW;TopdownL4;tma_L4_group;tma_issueD0=
;tma_mite_group",
         "MetricName": "tma_decoder0_alone",
-        "MetricThreshold": "tma_decoder0_alone > 0.1 & (tma_mite > 0.1 & (=
tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_ipc / 6 > =
0.35))",
+        "MetricThreshold": "tma_decoder0_alone > 0.1 & (tma_mite > 0.1 & (=
tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_thread_ipc=
 / 6 > 0.35))",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere decoder-0 was the only active decoder. Related metrics: tma_few_uops_in=
structions",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re the Divider unit was active",
-        "MetricExpr": "ARITH.DIV_ACTIVE / tma_info_clks",
+        "MetricExpr": "ARITH.DIV_ACTIVE / tma_info_thread_clks",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_core_bound_group",
         "MetricName": "tma_divider",
         "MetricThreshold": "tma_divider > 0.2 & (tma_core_bound > 0.1 & tm=
a_backend_bound > 0.2)",
@@ -975,7 +949,7 @@
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "cpu_core@MEMORY_ACTIVITY.STALLS_L3_MISS@ / tma_info=
_clks",
+        "MetricExpr": "cpu_core@MEMORY_ACTIVITY.STALLS_L3_MISS@ / tma_info=
_thread_clks",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_dram_bound",
         "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2)",
@@ -985,47 +959,47 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to DSB (decoded uop cache) fetch pipe=
line",
-        "MetricExpr": "(cpu_core@IDQ.DSB_CYCLES_ANY@ - cpu_core@IDQ.DSB_CY=
CLES_OK@) / tma_info_core_clks / 2",
+        "MetricExpr": "(cpu_core@IDQ.DSB_CYCLES_ANY@ - cpu_core@IDQ.DSB_CY=
CLES_OK@) / tma_info_core_core_clks / 2",
         "MetricGroup": "DSB;FetchBW;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
         "MetricName": "tma_dsb",
-        "MetricThreshold": "tma_dsb > 0.15 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_ipc / 6 > 0.35)",
+        "MetricThreshold": "tma_dsb > 0.15 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_thread_ipc / 6 > 0.35)",
         "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here.",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to switches from DSB to MITE pipelines",
-        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / tma_info_clks",
+        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / tma_info_thread_=
clks",
         "MetricGroup": "DSBmiss;FetchLat;TopdownL3;tma_L3_group;tma_fetch_=
latency_group;tma_issueFB",
         "MetricName": "tma_dsb_switches",
         "MetricThreshold": "tma_dsb_switches > 0.05 & (tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15)",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS_PS. Related metrics: tma_fetch_bandwidth, tma_info_dsb_coverage, tma=
_info_dsb_misses, tma_info_iptb, tma_lcp",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS_PS. Related metrics: tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_mis=
ses, tma_info_frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
-        "MetricExpr": "min(7 * cpu_core@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\=
\=3D1@ + cpu_core@DTLB_LOAD_MISSES.WALK_ACTIVE@, max(cpu_core@CYCLE_ACTIVIT=
Y.CYCLES_MEM_ANY@ - cpu_core@MEMORY_ACTIVITY.CYCLES_L1D_MISS@, 0)) / tma_in=
fo_clks",
+        "MetricExpr": "min(7 * cpu_core@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\=
\=3D1@ + cpu_core@DTLB_LOAD_MISSES.WALK_ACTIVE@, max(cpu_core@CYCLE_ACTIVIT=
Y.CYCLES_MEM_ANY@ - cpu_core@MEMORY_ACTIVITY.CYCLES_L1D_MISS@, 0)) / tma_in=
fo_thread_clks",
         "MetricGroup": "MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB;tma_=
l1_bound_group",
         "MetricName": "tma_dtlb_load",
         "MetricThreshold": "tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & (t=
ma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS_PS. Related metrics: t=
ma_dtlb_store, tma_info_memory_data_tlbs",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS_PS. Related metrics: t=
ma_dtlb_store, tma_info_bottleneck_memory_data_tlbs",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
-        "MetricExpr": "(7 * cpu_core@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=
=3D1@ + cpu_core@DTLB_STORE_MISSES.WALK_ACTIVE@) / tma_info_core_clks",
+        "MetricExpr": "(7 * cpu_core@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=
=3D1@ + cpu_core@DTLB_STORE_MISSES.WALK_ACTIVE@) / tma_info_core_core_clks"=
,
         "MetricGroup": "MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB;tma_=
store_bound_group",
         "MetricName": "tma_dtlb_store",
         "MetricThreshold": "tma_dtlb_store > 0.05 & (tma_store_bound > 0.2=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES_PS. Related metrics: tma_dtlb_load, =
tma_info_memory_data_tlbs",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES_PS. Related metrics: tma_dtlb_load, =
tma_info_bottleneck_memory_data_tlbs",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
-        "MetricExpr": "28 * tma_info_average_frequency * cpu_core@OCR.DEMA=
ND_RFO.L3_HIT.SNOOP_HITM@ / tma_info_clks",
+        "MetricExpr": "28 * tma_info_system_average_frequency * cpu_core@O=
CR.DEMAND_RFO.L3_HIT.SNOOP_HITM@ / tma_info_thread_clks",
         "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_store_bound_group",
         "MetricName": "tma_false_sharing",
         "MetricThreshold": "tma_false_sharing > 0.05 & (tma_store_bound > =
0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -1035,11 +1009,11 @@
     },
     {
         "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
-        "MetricExpr": "L1D_PEND_MISS.FB_FULL / tma_info_clks",
+        "MetricExpr": "L1D_PEND_MISS.FB_FULL / tma_info_thread_clks",
         "MetricGroup": "MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;tma_is=
sueSL;tma_issueSmSt;tma_l1_bound_group",
         "MetricName": "tma_fb_full",
         "MetricThreshold": "tma_fb_full > 0.3",
-        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_info_dram_bw_use, tma_info_memory_b=
andwidth, tma_mem_bandwidth, tma_sq_full, tma_store_latency, tma_streaming_=
stores",
+        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_info_bottleneck_memory_bandwidth, t=
ma_info_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_store_laten=
cy, tma_streaming_stores",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1048,15 +1022,15 @@
         "MetricExpr": "max(0, tma_frontend_bound - tma_fetch_latency)",
         "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_=
frontend_bound_group;tma_issueFB",
         "MetricName": "tma_fetch_bandwidth",
-        "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound=
 > 0.15 & tma_info_ipc / 6 > 0.35",
+        "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound=
 > 0.15 & tma_info_thread_ipc / 6 > 0.35",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LA=
TENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_sw=
itches, tma_info_dsb_coverage, tma_info_dsb_misses, tma_info_iptb, tma_lcp"=
,
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LA=
TENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_sw=
itches, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_=
info_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues",
-        "MetricExpr": "cpu_core@topdown\\-fetch\\-lat@ / (cpu_core@topdown=
\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiri=
ng@ + cpu_core@topdown\\-be\\-bound@) - cpu_core@INT_MISC.UOP_DROPPING@ / t=
ma_info_slots",
+        "MetricExpr": "cpu_core@topdown\\-fetch\\-lat@ / (cpu_core@topdown=
\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiri=
ng@ + cpu_core@topdown\\-be\\-bound@) - cpu_core@INT_MISC.UOP_DROPPING@ / t=
ma_info_thread_slots",
         "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend=
_bound_group",
         "MetricName": "tma_fetch_latency",
         "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound >=
 0.15",
@@ -1088,7 +1062,7 @@
     },
     {
         "BriefDescription": "This metric roughly estimates fraction of slo=
ts the CPU retired uops as a result of handing Floating Point (FP) Assists"=
,
-        "MetricExpr": "30 * cpu_core@ASSISTS.FP@ / tma_info_slots",
+        "MetricExpr": "30 * cpu_core@ASSISTS.FP@ / tma_info_thread_slots",
         "MetricGroup": "HPC;TopdownL5;tma_L5_group;tma_assists_group",
         "MetricName": "tma_fp_assists",
         "MetricThreshold": "tma_fp_assists > 0.1",
@@ -1098,7 +1072,7 @@
     },
     {
         "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) scalar uops fraction the CPU has retired",
-        "MetricExpr": "cpu_core@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umas=
k\\=3D0x03@ / (tma_retiring * tma_info_slots)",
+        "MetricExpr": "cpu_core@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umas=
k\\=3D0x03@ / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_scalar",
         "MetricThreshold": "tma_fp_scalar > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
@@ -1108,7 +1082,7 @@
     },
     {
         "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) vector uops fraction the CPU has retired aggregated across all v=
ector widths",
-        "MetricExpr": "cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\=
,umask\\=3D0x3c@ / (tma_retiring * tma_info_slots)",
+        "MetricExpr": "cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\=
,umask\\=3D0x3c@ / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_vector",
         "MetricThreshold": "tma_fp_vector > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
@@ -1118,7 +1092,7 @@
     },
     {
         "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 128-bit wide vectors",
-        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@=
 + cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE@) / (tma_retiring * tm=
a_info_slots)",
+        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@=
 + cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE@) / (tma_retiring * tm=
a_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_128b",
         "MetricThreshold": "tma_fp_vector_128b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
@@ -1128,7 +1102,7 @@
     },
     {
         "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 256-bit wide vectors",
-        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE@=
 + cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@) / (tma_retiring * tm=
a_info_slots)",
+        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE@=
 + cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@) / (tma_retiring * tm=
a_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_256b",
         "MetricThreshold": "tma_fp_vector_256b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
@@ -1138,7 +1112,7 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
-        "MetricExpr": "cpu_core@topdown\\-fe\\-bound@ / (cpu_core@topdown\=
\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retirin=
g@ + cpu_core@topdown\\-be\\-bound@) - cpu_core@INT_MISC.UOP_DROPPING@ / tm=
a_info_slots",
+        "MetricExpr": "cpu_core@topdown\\-fe\\-bound@ / (cpu_core@topdown\=
\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retirin=
g@ + cpu_core@topdown\\-be\\-bound@) - cpu_core@INT_MISC.UOP_DROPPING@ / tm=
a_info_thread_slots",
         "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
@@ -1149,7 +1123,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions -- where one uop can represent mu=
ltiple contiguous instructions",
-        "MetricExpr": "tma_light_operations * cpu_core@INST_RETIRED.MACRO_=
FUSED@ / (tma_retiring * tma_info_slots)",
+        "MetricExpr": "tma_light_operations * cpu_core@INST_RETIRED.MACRO_=
FUSED@ / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_fused_instructions",
         "MetricThreshold": "tma_fused_instructions > 0.1 & tma_light_opera=
tions > 0.6",
@@ -1159,7 +1133,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or micro-coded sequences",
-        "MetricExpr": "cpu_core@topdown\\-heavy\\-ops@ / (cpu_core@topdown=
\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiri=
ng@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_slots",
+        "MetricExpr": "cpu_core@topdown\\-heavy\\-ops@ / (cpu_core@topdown=
\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiri=
ng@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
         "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_g=
roup",
         "MetricName": "tma_heavy_operations",
         "MetricThreshold": "tma_heavy_operations > 0.1",
@@ -1170,7 +1144,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses",
-        "MetricExpr": "ICACHE_DATA.STALLS / tma_info_clks",
+        "MetricExpr": "ICACHE_DATA.STALLS / tma_info_thread_clks",
         "MetricGroup": "BigFoot;FetchLat;IcMiss;TopdownL3;tma_L3_group;tma=
_fetch_latency_group",
         "MetricName": "tma_icache_misses",
         "MetricThreshold": "tma_icache_misses > 0.05 & (tma_fetch_latency =
> 0.1 & tma_frontend_bound > 0.15)",
@@ -1179,251 +1153,300 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Measured Average Frequency for unhalted proce=
ssors [GHz]",
-        "MetricExpr": "tma_info_turbo_utilization * TSC / 1e9 / duration_t=
ime",
-        "MetricGroup": "Power;Summary",
-        "MetricName": "tma_info_average_frequency",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_branch_resteers + tma_dsb_switch=
es + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)",
-        "MetricGroup": "BigFoot;Fed;Frontend;IcMiss;MemoryTLB;tma_issueBC"=
,
-        "MetricName": "tma_info_big_code",
-        "MetricThreshold": "tma_info_big_code > 20",
-        "PublicDescription": "Total pipeline cost of instruction fetch rel=
ated bottlenecks by large code footprint programs (i-side cache; TLB and BT=
B misses). Related metrics: tma_info_branching_overhead",
+        "MetricExpr": "(tma_branch_mispredicts + tma_fetch_latency * tma_m=
ispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icache_=
misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) * tma_info_thread_sl=
ots / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;BrMispredicts;tma_issueBM",
+        "MetricName": "tma_info_bad_spec_branch_misprediction_cost",
+        "PublicDescription": "Branch Misprediction Cost: Fraction of TMA s=
lots wasted per non-speculative branch misprediction (retired JEClear). Rel=
ated metrics: tma_branch_mispredicts, tma_info_bottleneck_mispredictions, t=
ma_mispredicts_resteers",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Branch instructions per taken branch.",
-        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
-        "MetricGroup": "Branches;Fed;PGO",
-        "MetricName": "tma_info_bptkbranch",
+        "BriefDescription": "Instructions per retired mispredicts for cond=
itional non-taken branches (lower number means higher occurrence rate).",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_NTAKEN",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "tma_info_bad_spec_ipmisp_cond_ntaken",
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_cond_ntaken < 200",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(tma_branch_mispredicts + tma_fetch_latency * tma_m=
ispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icache_=
misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) * tma_info_slots / B=
R_MISP_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;BrMispredicts;tma_issueBM",
-        "MetricName": "tma_info_branch_misprediction_cost",
-        "PublicDescription": "Branch Misprediction Cost: Fraction of TMA s=
lots wasted per non-speculative branch misprediction (retired JEClear). Rel=
ated metrics: tma_branch_mispredicts, tma_info_mispredictions, tma_mispredi=
cts_resteers",
+        "BriefDescription": "Instructions per retired mispredicts for cond=
itional taken branches (lower number means higher occurrence rate).",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_TAKEN",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "tma_info_bad_spec_ipmisp_cond_taken",
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_cond_taken < 200",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Total pipeline cost of branch related instruc=
tions (used for program control-flow including function calls)",
-        "MetricExpr": "100 * ((cpu_core@BR_INST_RETIRED.COND@ + 3 * cpu_co=
re@BR_INST_RETIRED.NEAR_CALL@ + (cpu_core@BR_INST_RETIRED.NEAR_TAKEN@ - cpu=
_core@BR_INST_RETIRED.COND_TAKEN@ - 2 * cpu_core@BR_INST_RETIRED.NEAR_CALL@=
)) / tma_info_slots)",
-        "MetricGroup": "Ret;tma_issueBC",
-        "MetricName": "tma_info_branching_overhead",
-        "MetricThreshold": "tma_info_branching_overhead > 10",
-        "PublicDescription": "Total pipeline cost of branch related instru=
ctions (used for program control-flow including function calls). Related me=
trics: tma_info_big_code",
+        "BriefDescription": "Instructions per retired mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
+        "MetricExpr": "cpu_core@BR_MISP_RETIRED.INDIRECT_CALL\\,umask\\=3D=
0x80@ / BR_MISP_RETIRED.INDIRECT",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "tma_info_bad_spec_ipmisp_indirect",
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1e3",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fraction of branches that are CALL or RET",
-        "MetricExpr": "(cpu_core@BR_INST_RETIRED.NEAR_CALL@ + cpu_core@BR_=
INST_RETIRED.NEAR_RETURN@) / BR_INST_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;Branches",
-        "MetricName": "tma_info_callret",
+        "BriefDescription": "Instructions per retired mispredicts for retu=
rn branches (lower number means higher occurrence rate).",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.RET",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "tma_info_bad_spec_ipmisp_ret",
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_ret < 500",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
-        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.THREAD@",
-        "MetricGroup": "Pipeline",
-        "MetricName": "tma_info_clks",
+        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts",
+        "MetricName": "tma_info_bad_spec_ipmispredict",
+        "MetricThreshold": "tma_info_bad_spec_ipmispredict < 200",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
-        "MetricExpr": "1e3 * cpu_core@ITLB_MISSES.WALK_COMPLETED@ / INST_R=
ETIRED.ANY",
-        "MetricGroup": "Fed;MemoryTLB",
-        "MetricName": "tma_info_code_stlb_mpki",
+        "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(100 * (1 - tma_core_bound / tma_ports_utilization =
if tma_core_bound < tma_ports_utilization else 1) if tma_info_system_smt_2t=
_utilization > 0.5 else 0)",
+        "MetricGroup": "Cor;SMT",
+        "MetricName": "tma_info_botlnk_l0_core_bound_likely",
+        "MetricThreshold": "tma_info_botlnk_l0_core_bound_likely > 0.5",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fraction of branches that are non-taken condi=
tionals",
-        "MetricExpr": "BR_INST_RETIRED.COND_NTAKEN / BR_INST_RETIRED.ALL_B=
RANCHES",
-        "MetricGroup": "Bad;Branches;CodeGen;PGO",
-        "MetricName": "tma_info_cond_nt",
+        "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + =
tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb + tm=
a_lsd + tma_mite))",
+        "MetricGroup": "DSBmiss;Fed;tma_issueFB",
+        "MetricName": "tma_info_botlnk_l2_dsb_misses",
+        "MetricThreshold": "tma_info_botlnk_l2_dsb_misses > 10",
+        "PublicDescription": "Total pipeline cost of DSB (uop cache) misse=
s - subset of the Instruction_Fetch_BW Bottleneck. Related metrics: tma_dsb=
_switches, tma_fetch_bandwidth, tma_info_frontend_dsb_coverage, tma_info_in=
st_mix_iptb, tma_lcp",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fraction of branches that are taken condition=
als",
-        "MetricExpr": "BR_INST_RETIRED.COND_TAKEN / BR_INST_RETIRED.ALL_BR=
ANCHES",
-        "MetricGroup": "Bad;Branches;CodeGen;PGO",
-        "MetricName": "tma_info_cond_tk",
+        "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses +=
 tma_lcp + tma_ms_switches))",
+        "MetricGroup": "Fed;FetchLat;IcMiss;tma_issueFL",
+        "MetricName": "tma_info_botlnk_l2_ic_misses",
+        "MetricThreshold": "tma_info_botlnk_l2_ic_misses > 5",
+        "PublicDescription": "Total pipeline cost of Instruction Cache mis=
ses - subset of the Big_Code Bottleneck. Related metrics: ",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
+        "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(100 * (1 - tma_core_bound / tma_ports_utilization =
if tma_core_bound < tma_ports_utilization else 1) if tma_info_smt_2t_utiliz=
ation > 0.5 else 0)",
-        "MetricGroup": "Cor;SMT",
-        "MetricName": "tma_info_core_bound_likely",
-        "MetricThreshold": "tma_info_core_bound_likely > 0.5",
+        "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_branch_resteers + tma_dsb_switch=
es + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)",
+        "MetricGroup": "BigFoot;Fed;Frontend;IcMiss;MemoryTLB;tma_issueBC"=
,
+        "MetricName": "tma_info_bottleneck_big_code",
+        "MetricThreshold": "tma_info_bottleneck_big_code > 20",
+        "PublicDescription": "Total pipeline cost of instruction fetch rel=
ated bottlenecks by large code footprint programs (i-side cache; TLB and BT=
B misses). Related metrics: tma_info_bottleneck_branching_overhead",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
-        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.DISTRIBUTED@",
-        "MetricGroup": "SMT",
-        "MetricName": "tma_info_core_clks",
+        "BriefDescription": "Total pipeline cost of branch related instruc=
tions (used for program control-flow including function calls)",
+        "MetricExpr": "100 * ((cpu_core@BR_INST_RETIRED.COND@ + 3 * cpu_co=
re@BR_INST_RETIRED.NEAR_CALL@ + (cpu_core@BR_INST_RETIRED.NEAR_TAKEN@ - cpu=
_core@BR_INST_RETIRED.COND_TAKEN@ - 2 * cpu_core@BR_INST_RETIRED.NEAR_CALL@=
)) / tma_info_thread_slots)",
+        "MetricGroup": "Ret;tma_issueBC",
+        "MetricName": "tma_info_bottleneck_branching_overhead",
+        "MetricThreshold": "tma_info_bottleneck_branching_overhead > 10",
+        "PublicDescription": "Total pipeline cost of branch related instru=
ctions (used for program control-flow including function calls). Related me=
trics: tma_info_bottleneck_big_code",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions Per Cycle across hyper-threads (=
per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / tma_info_core_clks",
-        "MetricGroup": "Ret;SMT;TmaL1;tma_L1_group",
-        "MetricName": "tma_info_coreipc",
+        "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "100 * (tma_frontend_bound - tma_fetch_latency * tma=
_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icach=
e_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) - tma_info_bottlen=
eck_big_code",
+        "MetricGroup": "Fed;FetchBW;Frontend",
+        "MetricName": "tma_info_bottleneck_instruction_fetch_bw",
+        "MetricThreshold": "tma_info_bottleneck_instruction_fetch_bw > 20"=
,
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
-        "MetricExpr": "1 / tma_info_ipc",
-        "MetricGroup": "Mem;Pipeline",
-        "MetricName": "tma_info_cpi",
+        "BriefDescription": "Total pipeline cost of (external) Memory Band=
width related bottlenecks",
+        "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (=
tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_l3_bound /=
 (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_b=
ound) * (tma_sq_full / (tma_contested_accesses + tma_data_sharing + tma_l3_=
hit_latency + tma_sq_full))) + tma_l1_bound / (tma_dram_bound + tma_l1_boun=
d + tma_l2_bound + tma_l3_bound + tma_store_bound) * (tma_fb_full / (tma_dt=
lb_load + tma_fb_full + tma_lock_latency + tma_split_loads + tma_store_fwd_=
blk))",
+        "MetricGroup": "Mem;MemoryBW;Offcore;tma_issueBW",
+        "MetricName": "tma_info_bottleneck_memory_bandwidth",
+        "MetricThreshold": "tma_info_bottleneck_memory_bandwidth > 20",
+        "PublicDescription": "Total pipeline cost of (external) Memory Ban=
dwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_system_d=
ram_bw_use, tma_mem_bandwidth, tma_sq_full",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average CPU Utilization",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
-        "MetricGroup": "HPC;Summary",
-        "MetricName": "tma_info_cpu_utilization",
+        "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "100 * tma_memory_bound * (tma_l1_bound / max(tma_me=
mory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + t=
ma_store_bound) * (tma_dtlb_load / max(tma_l1_bound, tma_dtlb_load + tma_fb=
_full + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_stor=
e_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tm=
a_store_bound) * (tma_dtlb_store / (tma_dtlb_store + tma_false_sharing + tm=
a_split_stores + tma_store_latency + tma_streaming_stores)))",
+        "MetricGroup": "Mem;MemoryTLB;Offcore;tma_issueTLB",
+        "MetricName": "tma_info_bottleneck_memory_data_tlbs",
+        "MetricThreshold": "tma_info_bottleneck_memory_data_tlbs > 20",
+        "PublicDescription": "Total pipeline cost of Memory Address Transl=
ation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_load,=
 tma_dtlb_store",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average Parallel L2 cache miss data reads",
-        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD / OFFCORE_=
REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
-        "MetricGroup": "Memory_BW;Offcore",
-        "MetricName": "tma_info_data_l2_mlp",
+        "BriefDescription": "Total pipeline cost of Memory Latency related=
 bottlenecks (external memory and off-core caches)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (=
tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_l3_bound / (=
tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bou=
nd) * (tma_l3_hit_latency / (tma_contested_accesses + tma_data_sharing + tm=
a_l3_hit_latency + tma_sq_full)) + tma_l2_bound / (tma_dram_bound + tma_l1_=
bound + tma_l2_bound + tma_l3_bound + tma_store_bound))",
+        "MetricGroup": "Mem;MemoryLat;Offcore;tma_issueLat",
+        "MetricName": "tma_info_bottleneck_memory_latency",
+        "MetricThreshold": "tma_info_bottleneck_memory_latency > 20",
+        "PublicDescription": "Total pipeline cost of Memory Latency relate=
d bottlenecks (external memory and off-core caches). Related metrics: tma_l=
3_hit_latency, tma_mem_latency",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
-        "MetricExpr": "64 * (UNC_ARB_TRK_REQUESTS.ALL + UNC_ARB_COH_TRK_RE=
QUESTS.ALL) / 1e6 / duration_time / 1e3",
-        "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
-        "MetricName": "tma_info_dram_bw_use",
-        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_fb_full, tma_info_memory_ba=
ndwidth, tma_mem_bandwidth, tma_sq_full",
+        "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "100 * (tma_branch_mispredicts + tma_fetch_latency *=
 tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_i=
cache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts;tma_issueBM",
+        "MetricName": "tma_info_bottleneck_mispredictions",
+        "MetricThreshold": "tma_info_bottleneck_mispredictions > 20",
+        "PublicDescription": "Total pipeline cost of Branch Misprediction =
related bottlenecks. Related metrics: tma_branch_mispredicts, tma_info_bad_=
spec_branch_misprediction_cost, tma_mispredicts_resteers",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
-        "MetricExpr": "IDQ.DSB_UOPS / cpu_core@UOPS_ISSUED.ANY@",
-        "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
-        "MetricName": "tma_info_dsb_coverage",
-        "MetricThreshold": "tma_info_dsb_coverage < 0.7 & tma_info_ipc / 6=
 > 0.35",
-        "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_dsb_misses, tma_info_iptb, tma_lcp",
+        "BriefDescription": "Fraction of branches that are CALL or RET",
+        "MetricExpr": "(cpu_core@BR_INST_RETIRED.NEAR_CALL@ + cpu_core@BR_=
INST_RETIRED.NEAR_RETURN@) / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;Branches",
+        "MetricName": "tma_info_branches_callret",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + =
tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb + tm=
a_lsd + tma_mite))",
-        "MetricGroup": "DSBmiss;Fed;tma_issueFB",
-        "MetricName": "tma_info_dsb_misses",
-        "MetricThreshold": "tma_info_dsb_misses > 10",
-        "PublicDescription": "Total pipeline cost of DSB (uop cache) misse=
s - subset of the Instruction_Fetch_BW Bottleneck. Related metrics: tma_dsb=
_switches, tma_fetch_bandwidth, tma_info_dsb_coverage, tma_info_iptb, tma_l=
cp",
+        "BriefDescription": "Fraction of branches that are non-taken condi=
tionals",
+        "MetricExpr": "BR_INST_RETIRED.COND_NTAKEN / BR_INST_RETIRED.ALL_B=
RANCHES",
+        "MetricGroup": "Bad;Branches;CodeGen;PGO",
+        "MetricName": "tma_info_branches_cond_nt",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
.",
-        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / cpu_core@DSB2MIT=
E_SWITCHES.PENALTY_CYCLES\\,cmask\\=3D1\\,edge@",
-        "MetricGroup": "DSBmiss",
-        "MetricName": "tma_info_dsb_switch_cost",
+        "BriefDescription": "Fraction of branches that are taken condition=
als",
+        "MetricExpr": "BR_INST_RETIRED.COND_TAKEN / BR_INST_RETIRED.ALL_BR=
ANCHES",
+        "MetricGroup": "Bad;Branches;CodeGen;PGO",
+        "MetricName": "tma_info_branches_cond_tk",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-thread",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu_core@UOPS_EXECUTED.THREA=
D\\,cmask\\=3D1@",
-        "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
-        "MetricName": "tma_info_execute",
+        "BriefDescription": "Fraction of branches that are unconditional (=
direct or indirect) jumps",
+        "MetricExpr": "(cpu_core@BR_INST_RETIRED.NEAR_TAKEN@ - cpu_core@BR=
_INST_RETIRED.COND_TAKEN@ - 2 * cpu_core@BR_INST_RETIRED.NEAR_CALL@) / BR_I=
NST_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;Branches",
+        "MetricName": "tma_info_branches_jump",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "The ratio of Executed- by Issued-Uops",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / UOPS_ISSUED.ANY",
-        "MetricGroup": "Cor;Pipeline",
-        "MetricName": "tma_info_execute_per_issue",
-        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage.",
+        "BriefDescription": "Fraction of branches of other types (not indi=
vidually covered by other metrics in Info.Branches group)",
+        "MetricExpr": "1 - (tma_info_branches_cond_nt + tma_info_branches_=
cond_tk + tma_info_branches_callret + tma_info_branches_jump)",
+        "MetricGroup": "Bad;Branches",
+        "MetricName": "tma_info_branches_other_branches",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
-        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / INST_RETI=
RED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_fb_hpki",
+        "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
+        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.DISTRIBUTED@",
+        "MetricGroup": "SMT",
+        "MetricName": "tma_info_core_core_clks",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average number of Uops issued by front-end wh=
en it issued something",
-        "MetricExpr": "UOPS_ISSUED.ANY / cpu_core@UOPS_ISSUED.ANY\\,cmask\=
\=3D1@",
-        "MetricGroup": "Fed;FetchBW",
-        "MetricName": "tma_info_fetch_upc",
+        "BriefDescription": "Instructions Per Cycle across hyper-threads (=
per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / tma_info_core_core_clks",
+        "MetricGroup": "Ret;SMT;TmaL1;tma_L1_group",
+        "MetricName": "tma_info_core_coreipc",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Floating Point Operations Per Cycle",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.SCALAR_SINGLE@ + cp=
u_core@FP_ARITH_INST_RETIRED.SCALAR_DOUBLE@ + 2 * cpu_core@FP_ARITH_INST_RE=
TIRED.128B_PACKED_DOUBLE@ + 4 * (cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED=
_SINGLE@ + cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE@) + 8 * cpu_co=
re@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@) / tma_info_core_clks",
+        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.SCALAR_SINGLE@ + cp=
u_core@FP_ARITH_INST_RETIRED.SCALAR_DOUBLE@ + 2 * cpu_core@FP_ARITH_INST_RE=
TIRED.128B_PACKED_DOUBLE@ + 4 * (cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED=
_SINGLE@ + cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE@) + 8 * cpu_co=
re@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@) / tma_info_core_core_clks",
         "MetricGroup": "Flops;Ret",
-        "MetricName": "tma_info_flopc",
+        "MetricName": "tma_info_core_flopc",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(cpu_core@FP_ARITH_DISPATCHED.PORT_0@ + cpu_core@FP=
_ARITH_DISPATCHED.PORT_1@ + cpu_core@FP_ARITH_DISPATCHED.PORT_5@) / (2 * tm=
a_info_core_clks)",
+        "MetricExpr": "(cpu_core@FP_ARITH_DISPATCHED.PORT_0@ + cpu_core@FP=
_ARITH_DISPATCHED.PORT_1@ + cpu_core@FP_ARITH_DISPATCHED.PORT_5@) / (2 * tm=
a_info_core_core_clks)",
         "MetricGroup": "Cor;Flops;HPC",
-        "MetricName": "tma_info_fp_arith_utilization",
+        "MetricName": "tma_info_core_fp_arith_utilization",
         "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n).",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.SCALAR_SINGLE@ + cp=
u_core@FP_ARITH_INST_RETIRED.SCALAR_DOUBLE@ + 2 * cpu_core@FP_ARITH_INST_RE=
TIRED.128B_PACKED_DOUBLE@ + 4 * (cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED=
_SINGLE@ + cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE@) + 8 * cpu_co=
re@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@) / 1e9 / duration_time",
-        "MetricGroup": "Cor;Flops;HPC",
-        "MetricName": "tma_info_gflops",
-        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine.",
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (cpu_core@UOPS_EXECUTED.CORE=
_CYCLES_GE_1@ / 2 if #SMT_on else cpu_core@UOPS_EXECUTED.CORE_CYCLES_GE_1@)=
",
+        "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
+        "MetricName": "tma_info_core_ilp",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck",
-        "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses +=
 tma_lcp + tma_ms_switches))",
-        "MetricGroup": "Fed;FetchLat;IcMiss;tma_issueFL",
-        "MetricName": "tma_info_ic_misses",
-        "MetricThreshold": "tma_info_ic_misses > 5",
-        "PublicDescription": "Total pipeline cost of Instruction Cache mis=
ses - subset of the Big_Code Bottleneck. Related metrics: ",
+        "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
+        "MetricExpr": "IDQ.DSB_UOPS / cpu_core@UOPS_ISSUED.ANY@",
+        "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
+        "MetricName": "tma_info_frontend_dsb_coverage",
+        "MetricThreshold": "tma_info_frontend_dsb_coverage < 0.7 & tma_inf=
o_thread_ipc / 6 > 0.35",
+        "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_inst_mix_iptb, tma_lcp",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
.",
+        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / cpu_core@DSB2MIT=
E_SWITCHES.PENALTY_CYCLES\\,cmask\\=3D1\\,edge@",
+        "MetricGroup": "DSBmiss",
+        "MetricName": "tma_info_frontend_dsb_switch_cost",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Average number of Uops issued by front-end wh=
en it issued something",
+        "MetricExpr": "UOPS_ISSUED.ANY / cpu_core@UOPS_ISSUED.ANY\\,cmask\=
\=3D1@",
+        "MetricGroup": "Fed;FetchBW",
+        "MetricName": "tma_info_frontend_fetch_upc",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Average Latency for L1 instruction cache miss=
es",
         "MetricExpr": "ICACHE_DATA.STALLS / cpu_core@ICACHE_DATA.STALLS\\,=
cmask\\=3D1\\,edge@",
         "MetricGroup": "Fed;FetchLat;IcMiss",
-        "MetricName": "tma_info_icache_miss_latency",
+        "MetricName": "tma_info_frontend_icache_miss_latency",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (cpu_core@UOPS_EXECUTED.CORE=
_CYCLES_GE_1@ / 2 if #SMT_on else cpu_core@UOPS_EXECUTED.CORE_CYCLES_GE_1@)=
",
-        "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
-        "MetricName": "tma_info_ilp",
+        "BriefDescription": "Instructions per non-speculative DSB miss (lo=
wer number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / FRONTEND_RETIRED.ANY_DSB_MISS",
+        "MetricGroup": "DSBmiss;Fed",
+        "MetricName": "tma_info_frontend_ipdsb_miss_ret",
+        "MetricThreshold": "tma_info_frontend_ipdsb_miss_ret < 50",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * (tma_frontend_bound - tma_fetch_latency * tma=
_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icach=
e_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) - tma_info_big_cod=
e",
-        "MetricGroup": "Fed;FetchBW;Frontend",
-        "MetricName": "tma_info_instruction_fetch_bw",
-        "MetricThreshold": "tma_info_instruction_fetch_bw > 20",
+        "BriefDescription": "Instructions per speculative Unknown Branch M=
isprediction (BAClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "tma_info_inst_mix_instructions / BACLEARS.ANY",
+        "MetricGroup": "Fed",
+        "MetricName": "tma_info_frontend_ipunknown_branch",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "L2 cache true code cacheline misses per kilo =
instruction",
+        "MetricExpr": "1e3 * cpu_core@FRONTEND_RETIRED.L2_MISS@ / INST_RET=
IRED.ANY",
+        "MetricGroup": "IcMiss",
+        "MetricName": "tma_info_frontend_l2mpki_code",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "L2 cache speculative code cacheline misses pe=
r kilo instruction",
+        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.CODE_RD_MISS@ / INST_RETIRE=
D.ANY",
+        "MetricGroup": "IcMiss",
+        "MetricName": "tma_info_frontend_l2mpki_code_all",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Fraction of Uops delivered by the LSD (Loop S=
tream Detector; aka Loop Cache)",
+        "MetricExpr": "LSD.UOPS / cpu_core@UOPS_ISSUED.ANY@",
+        "MetricGroup": "Fed;LSD",
+        "MetricName": "tma_info_frontend_lsd_coverage",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Branch instructions per taken branch.",
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
+        "MetricGroup": "Branches;Fed;PGO",
+        "MetricName": "tma_info_inst_mix_bptkbranch",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Total number of retired Instructions",
         "MetricExpr": "cpu_core@INST_RETIRED.ANY@",
         "MetricGroup": "Summary;TmaL1;tma_L1_group",
-        "MetricName": "tma_info_instructions",
+        "MetricName": "tma_info_inst_mix_instructions",
         "PublicDescription": "Total number of retired Instructions. Sample=
 with: INST_RETIRED.PREC_DIST",
         "Unit": "cpu_core"
     },
@@ -1431,8 +1454,8 @@
         "BriefDescription": "Instructions per FP Arithmetic instruction (l=
ower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / (cpu_core@FP_ARITH_INST_RETIRED.=
SCALAR_SINGLE\\,umask\\=3D0x03@ + cpu_core@FP_ARITH_INST_RETIRED.128B_PACKE=
D_DOUBLE\\,umask\\=3D0x3c@)",
         "MetricGroup": "Flops;InsType",
-        "MetricName": "tma_info_iparith",
-        "MetricThreshold": "tma_info_iparith < 10",
+        "MetricName": "tma_info_inst_mix_iparith",
+        "MetricThreshold": "tma_info_inst_mix_iparith < 10",
         "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). May undercount due to FMA doubl=
e counting. Approximated prior to BDW.",
         "Unit": "cpu_core"
     },
@@ -1440,8 +1463,8 @@
         "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-bi=
t instruction (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / (cpu_core@FP_ARITH_INST_RETIRED.=
128B_PACKED_DOUBLE@ + cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE@)",
         "MetricGroup": "Flops;FpVector;InsType",
-        "MetricName": "tma_info_iparith_avx128",
-        "MetricThreshold": "tma_info_iparith_avx128 < 10",
+        "MetricName": "tma_info_inst_mix_iparith_avx128",
+        "MetricThreshold": "tma_info_inst_mix_iparith_avx128 < 10",
         "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). May undercount =
due to FMA double counting.",
         "Unit": "cpu_core"
     },
@@ -1449,8 +1472,8 @@
         "BriefDescription": "Instructions per FP Arithmetic AVX* 256-bit i=
nstruction (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / (cpu_core@FP_ARITH_INST_RETIRED.=
256B_PACKED_DOUBLE@ + cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@)",
         "MetricGroup": "Flops;FpVector;InsType",
-        "MetricName": "tma_info_iparith_avx256",
-        "MetricThreshold": "tma_info_iparith_avx256 < 10",
+        "MetricName": "tma_info_inst_mix_iparith_avx256",
+        "MetricThreshold": "tma_info_inst_mix_iparith_avx256 < 10",
         "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). May undercount due=
 to FMA double counting.",
         "Unit": "cpu_core"
     },
@@ -1458,8 +1481,8 @@
         "BriefDescription": "Instructions per FP Arithmetic Scalar Double-=
Precision instruction (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED.SCALAR_DOU=
BLE",
         "MetricGroup": "Flops;FpScalar;InsType",
-        "MetricName": "tma_info_iparith_scalar_dp",
-        "MetricThreshold": "tma_info_iparith_scalar_dp < 10",
+        "MetricName": "tma_info_inst_mix_iparith_scalar_dp",
+        "MetricThreshold": "tma_info_inst_mix_iparith_scalar_dp < 10",
         "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). May und=
ercount due to FMA double counting.",
         "Unit": "cpu_core"
     },
@@ -1467,494 +1490,445 @@
         "BriefDescription": "Instructions per FP Arithmetic Scalar Single-=
Precision instruction (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED.SCALAR_SIN=
GLE",
         "MetricGroup": "Flops;FpScalar;InsType",
-        "MetricName": "tma_info_iparith_scalar_sp",
-        "MetricThreshold": "tma_info_iparith_scalar_sp < 10",
+        "MetricName": "tma_info_inst_mix_iparith_scalar_sp",
+        "MetricThreshold": "tma_info_inst_mix_iparith_scalar_sp < 10",
         "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). May und=
ercount due to FMA double counting.",
         "Unit": "cpu_core"
     },
-    {
-        "BriefDescription": "Instructions per a microcode Assist invocatio=
n",
-        "MetricExpr": "INST_RETIRED.ANY / cpu_core@ASSISTS.ANY\\,umask\\=
=3D0x1B@",
-        "MetricGroup": "Pipeline;Ret;Retire",
-        "MetricName": "tma_info_ipassist",
-        "MetricThreshold": "tma_info_ipassist < 100e3",
-        "PublicDescription": "Instructions per a microcode Assist invocati=
on. See Assists tree node for details (lower number means higher occurrence=
 rate)",
-        "Unit": "cpu_core"
-    },
     {
         "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
         "MetricGroup": "Branches;Fed;InsType",
-        "MetricName": "tma_info_ipbranch",
-        "MetricThreshold": "tma_info_ipbranch < 8",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
-        "MetricExpr": "INST_RETIRED.ANY / tma_info_clks",
-        "MetricGroup": "Ret;Summary",
-        "MetricName": "tma_info_ipc",
+        "MetricName": "tma_info_inst_mix_ipbranch",
+        "MetricThreshold": "tma_info_inst_mix_ipbranch < 8",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Instructions per (near) call (lower number me=
ans higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
         "MetricGroup": "Branches;Fed;PGO",
-        "MetricName": "tma_info_ipcall",
-        "MetricThreshold": "tma_info_ipcall < 200",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Instructions per non-speculative DSB miss (lo=
wer number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / FRONTEND_RETIRED.ANY_DSB_MISS",
-        "MetricGroup": "DSBmiss;Fed",
-        "MetricName": "tma_info_ipdsb_miss_ret",
-        "MetricThreshold": "tma_info_ipdsb_miss_ret < 50",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
-        "MetricExpr": "INST_RETIRED.ANY / cpu_core@BR_INST_RETIRED.FAR_BRA=
NCH@u",
-        "MetricGroup": "Branches;OS",
-        "MetricName": "tma_info_ipfarbranch",
-        "MetricThreshold": "tma_info_ipfarbranch < 1e6",
+        "MetricName": "tma_info_inst_mix_ipcall",
+        "MetricThreshold": "tma_info_inst_mix_ipcall < 200",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Instructions per Floating Point (FP) Operatio=
n (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / (cpu_core@FP_ARITH_INST_RETIRED.=
SCALAR_SINGLE@ + cpu_core@FP_ARITH_INST_RETIRED.SCALAR_DOUBLE@ + 2 * cpu_co=
re@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@ + 4 * (cpu_core@FP_ARITH_INST_=
RETIRED.128B_PACKED_SINGLE@ + cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_DO=
UBLE@) + 8 * cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@)",
         "MetricGroup": "Flops;InsType",
-        "MetricName": "tma_info_ipflop",
-        "MetricThreshold": "tma_info_ipflop < 10",
+        "MetricName": "tma_info_inst_mix_ipflop",
+        "MetricThreshold": "tma_info_inst_mix_ipflop < 10",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Instructions per Load (lower number means hig=
her occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_LOADS",
         "MetricGroup": "InsType",
-        "MetricName": "tma_info_ipload",
-        "MetricThreshold": "tma_info_ipload < 3",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Instructions per retired mispredicts for cond=
itional non-taken branches (lower number means higher occurrence rate).",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_NTAKEN",
-        "MetricGroup": "Bad;BrMispredicts",
-        "MetricName": "tma_info_ipmisp_cond_ntaken",
-        "MetricThreshold": "tma_info_ipmisp_cond_ntaken < 200",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Instructions per retired mispredicts for cond=
itional taken branches (lower number means higher occurrence rate).",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_TAKEN",
-        "MetricGroup": "Bad;BrMispredicts",
-        "MetricName": "tma_info_ipmisp_cond_taken",
-        "MetricThreshold": "tma_info_ipmisp_cond_taken < 200",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Instructions per retired mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
-        "MetricExpr": "cpu_core@BR_MISP_RETIRED.INDIRECT_CALL\\,umask\\=3D=
0x80@ / BR_MISP_RETIRED.INDIRECT",
-        "MetricGroup": "Bad;BrMispredicts",
-        "MetricName": "tma_info_ipmisp_indirect",
-        "MetricThreshold": "tma_info_ipmisp_indirect < 1e3",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Instructions per retired mispredicts for retu=
rn branches (lower number means higher occurrence rate).",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.RET",
-        "MetricGroup": "Bad;BrMispredicts",
-        "MetricName": "tma_info_ipmisp_ret",
-        "MetricThreshold": "tma_info_ipmisp_ret < 500",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;BadSpec;BrMispredicts",
-        "MetricName": "tma_info_ipmispredict",
-        "MetricThreshold": "tma_info_ipmispredict < 200",
+        "MetricName": "tma_info_inst_mix_ipload",
+        "MetricThreshold": "tma_info_inst_mix_ipload < 3",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Instructions per Store (lower number means hi=
gher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_STORES",
         "MetricGroup": "InsType",
-        "MetricName": "tma_info_ipstore",
-        "MetricThreshold": "tma_info_ipstore < 8",
+        "MetricName": "tma_info_inst_mix_ipstore",
+        "MetricThreshold": "tma_info_inst_mix_ipstore < 8",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Instructions per Software prefetch instructio=
n (of any type: NTA/T0/T1/T2/Prefetch) (lower number means higher occurrenc=
e rate)",
         "MetricExpr": "INST_RETIRED.ANY / cpu_core@SW_PREFETCH_ACCESS.T0\\=
,umask\\=3D0xF@",
         "MetricGroup": "Prefetches",
-        "MetricName": "tma_info_ipswpf",
-        "MetricThreshold": "tma_info_ipswpf < 100",
+        "MetricName": "tma_info_inst_mix_ipswpf",
+        "MetricThreshold": "tma_info_inst_mix_ipswpf < 100",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Instruction per taken branch",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
         "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO;tma_issueFB",
-        "MetricName": "tma_info_iptb",
-        "MetricThreshold": "tma_info_iptb < 13",
-        "PublicDescription": "Instruction per taken branch. Related metric=
s: tma_dsb_switches, tma_fetch_bandwidth, tma_info_dsb_coverage, tma_info_d=
sb_misses, tma_lcp",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Instructions per speculative Unknown Branch M=
isprediction (BAClear) (lower number means higher occurrence rate)",
-        "MetricExpr": "tma_info_instructions / BACLEARS.ANY",
-        "MetricGroup": "Fed",
-        "MetricName": "tma_info_ipunknown_branch",
+        "MetricName": "tma_info_inst_mix_iptb",
+        "MetricThreshold": "tma_info_inst_mix_iptb < 13",
+        "PublicDescription": "Instruction per taken branch. Related metric=
s: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_misses, tm=
a_info_frontend_dsb_coverage, tma_lcp",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fraction of branches that are unconditional (=
direct or indirect) jumps",
-        "MetricExpr": "(cpu_core@BR_INST_RETIRED.NEAR_TAKEN@ - cpu_core@BR=
_INST_RETIRED.COND_TAKEN@ - 2 * cpu_core@BR_INST_RETIRED.NEAR_CALL@) / BR_I=
NST_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;Branches",
-        "MetricName": "tma_info_jump",
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
+        "MetricExpr": "64 * cpu_core@L1D.REPLACEMENT@ / 1e9 / duration_tim=
e",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_core_l1d_cache_fill_bw",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / cpu_core@INST_RETIRED=
.ANY_P@k",
-        "MetricGroup": "OS",
-        "MetricName": "tma_info_kernel_cpi",
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
+        "MetricExpr": "64 * cpu_core@L2_LINES_IN.ALL@ / 1e9 / duration_tim=
e",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_core_l2_cache_fill_bw",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.THRE=
AD",
-        "MetricGroup": "OS",
-        "MetricName": "tma_info_kernel_utilization",
-        "MetricThreshold": "tma_info_kernel_utilization > 0.05",
+        "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
+        "MetricExpr": "64 * cpu_core@OFFCORE_REQUESTS.ALL_REQUESTS@ / 1e9 =
/ duration_time",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "tma_info_memory_core_l3_cache_access_bw",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
-        "MetricExpr": "64 * cpu_core@L1D.REPLACEMENT@ / 1e9 / duration_tim=
e",
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
+        "MetricExpr": "64 * cpu_core@LONGEST_LAT_CACHE.MISS@ / 1e9 / durat=
ion_time",
         "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l1d_cache_fill_bw",
+        "MetricName": "tma_info_memory_core_l3_cache_fill_bw",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
-        "MetricExpr": "tma_info_l1d_cache_fill_bw",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l1d_cache_fill_bw_1t",
+        "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
+        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / INST_RETI=
RED.ANY",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "tma_info_memory_fb_hpki",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.L1_MISS@ / INST_RET=
IRED.ANY",
         "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l1mpki",
+        "MetricName": "tma_info_memory_l1mpki",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 all demand loads (including speculative)",
         "MetricExpr": "1e3 * cpu_core@L2_RQSTS.ALL_DEMAND_DATA_RD@ / INST_=
RETIRED.ANY",
         "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l1mpki_load",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
-        "MetricExpr": "64 * cpu_core@L2_LINES_IN.ALL@ / 1e9 / duration_tim=
e",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l2_cache_fill_bw",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
-        "MetricExpr": "tma_info_l2_cache_fill_bw",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l2_cache_fill_bw_1t",
+        "MetricName": "tma_info_memory_l1mpki_load",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all re=
quest types (including speculative)",
         "MetricExpr": "1e3 * (cpu_core@L2_RQSTS.REFERENCES@ - cpu_core@L2_=
RQSTS.MISS@) / INST_RETIRED.ANY",
         "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l2hpki_all",
+        "MetricName": "tma_info_memory_l2hpki_all",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all de=
mand loads  (including speculative)",
         "MetricExpr": "1e3 * cpu_core@L2_RQSTS.DEMAND_DATA_RD_HIT@ / INST_=
RETIRED.ANY",
         "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l2hpki_load",
+        "MetricName": "tma_info_memory_l2hpki_load",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.L2_MISS@ / INST_RET=
IRED.ANY",
         "MetricGroup": "Backend;CacheMisses;Mem",
-        "MetricName": "tma_info_l2mpki",
+        "MetricName": "tma_info_memory_l2mpki",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all request types (including speculative)",
         "MetricExpr": "1e3 * cpu_core@L2_RQSTS.MISS@ / INST_RETIRED.ANY",
         "MetricGroup": "CacheMisses;Mem;Offcore",
-        "MetricName": "tma_info_l2mpki_all",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "L2 cache true code cacheline misses per kilo =
instruction",
-        "MetricExpr": "1e3 * cpu_core@FRONTEND_RETIRED.L2_MISS@ / INST_RET=
IRED.ANY",
-        "MetricGroup": "IcMiss",
-        "MetricName": "tma_info_l2mpki_code",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "L2 cache speculative code cacheline misses pe=
r kilo instruction",
-        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.CODE_RD_MISS@ / INST_RETIRE=
D.ANY",
-        "MetricGroup": "IcMiss",
-        "MetricName": "tma_info_l2mpki_code_all",
+        "MetricName": "tma_info_memory_l2mpki_all",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all demand loads  (including speculative)",
         "MetricExpr": "1e3 * cpu_core@L2_RQSTS.DEMAND_DATA_RD_MISS@ / INST=
_RETIRED.ANY",
         "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l2mpki_load",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "64 * cpu_core@OFFCORE_REQUESTS.ALL_REQUESTS@ / 1e9 =
/ duration_time",
-        "MetricGroup": "Mem;MemoryBW;Offcore",
-        "MetricName": "tma_info_l3_cache_access_bw",
+        "MetricName": "tma_info_memory_l2mpki_load",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
-        "MetricExpr": "tma_info_l3_cache_access_bw",
-        "MetricGroup": "Mem;MemoryBW;Offcore",
-        "MetricName": "tma_info_l3_cache_access_bw_1t",
+        "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.L3_MISS@ / INST_RET=
IRED.ANY",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "tma_info_memory_l3mpki",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
-        "MetricExpr": "64 * cpu_core@LONGEST_LAT_CACHE.MISS@ / 1e9 / durat=
ion_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l3_cache_fill_bw",
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / MEM_LOAD_COMPLETED.L1_MISS_=
ANY",
+        "MetricGroup": "Mem;MemoryBound;MemoryLat",
+        "MetricName": "tma_info_memory_load_miss_real_latency",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "tma_info_l3_cache_fill_bw",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l3_cache_fill_bw_1t",
+        "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLE=
S",
+        "MetricGroup": "Mem;MemoryBW;MemoryBound",
+        "MetricName": "tma_info_memory_mlp",
+        "PublicDescription": "Memory-Level-Parallelism (average number of =
L1 miss demand load when there is at least one such miss. Per-Logical Proce=
ssor)",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.L3_MISS@ / INST_RET=
IRED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l3mpki",
+        "BriefDescription": "Average Parallel L2 cache miss data reads",
+        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD / OFFCORE_=
REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
+        "MetricGroup": "Memory_BW;Offcore",
+        "MetricName": "tma_info_memory_oro_data_l2_mlp",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Average Latency for L2 cache miss demand Load=
s",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS.DEMAND_DATA_RD",
         "MetricGroup": "Memory_Lat;Offcore",
-        "MetricName": "tma_info_load_l2_miss_latency",
+        "MetricName": "tma_info_memory_oro_load_l2_miss_latency",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Average Parallel L2 cache miss demand Loads",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / cpu_c=
ore@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,cmask\\=3D1@",
         "MetricGroup": "Memory_BW;Offcore",
-        "MetricName": "tma_info_load_l2_mlp",
+        "MetricName": "tma_info_memory_oro_load_l2_mlp",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Average Latency for L3 cache miss demand Load=
s",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAND_DATA_RD=
 / OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
         "MetricGroup": "Memory_Lat;Offcore",
-        "MetricName": "tma_info_load_l3_miss_latency",
+        "MetricName": "tma_info_memory_oro_load_l3_miss_latency",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / MEM_LOAD_COMPLETED.L1_MISS_=
ANY",
-        "MetricGroup": "Mem;MemoryBound;MemoryLat",
-        "MetricName": "tma_info_load_miss_real_latency",
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_core_l1d_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_thread_l1d_cache_fill_bw_1t",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_core_l2_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_thread_l2_cache_fill_bw_1t",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_core_l3_cache_access_bw",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "tma_info_memory_thread_l3_cache_access_bw_1t",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_core_l3_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_thread_l3_cache_fill_bw_1t",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
+        "MetricExpr": "1e3 * cpu_core@ITLB_MISSES.WALK_COMPLETED@ / INST_R=
ETIRED.ANY",
+        "MetricGroup": "Fed;MemoryTLB",
+        "MetricName": "tma_info_memory_tlb_code_stlb_mpki",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "STLB (2nd level TLB) data load speculative mi=
sses per kilo instruction (misses of any page-size that complete the page w=
alk)",
         "MetricExpr": "1e3 * cpu_core@DTLB_LOAD_MISSES.WALK_COMPLETED@ / I=
NST_RETIRED.ANY",
         "MetricGroup": "Mem;MemoryTLB",
-        "MetricName": "tma_info_load_stlb_mpki",
+        "MetricName": "tma_info_memory_tlb_load_stlb_mpki",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fraction of Uops delivered by the LSD (Loop S=
tream Detector; aka Loop Cache)",
-        "MetricExpr": "LSD.UOPS / cpu_core@UOPS_ISSUED.ANY@",
-        "MetricGroup": "Fed;LSD",
-        "MetricName": "tma_info_lsd_coverage",
+        "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
+        "MetricExpr": "(cpu_core@ITLB_MISSES.WALK_PENDING@ + cpu_core@DTLB=
_LOAD_MISSES.WALK_PENDING@ + cpu_core@DTLB_STORE_MISSES.WALK_PENDING@) / (4=
 * tma_info_core_core_clks)",
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_tlb_page_walks_utilization",
+        "MetricThreshold": "tma_info_memory_tlb_page_walks_utilization > 0=
.5",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average number of parallel data read requests=
 to external memory",
-        "MetricExpr": "UNC_ARB_DAT_OCCUPANCY.RD / cpu_core@UNC_ARB_DAT_OCC=
UPANCY.RD\\,cmask\\=3D1@",
-        "MetricGroup": "Mem;MemoryBW;SoC",
-        "MetricName": "tma_info_mem_parallel_reads",
-        "PublicDescription": "Average number of parallel data read request=
s to external memory. Accounts for demand loads and L1/L2 prefetches",
+        "BriefDescription": "STLB (2nd level TLB) data store speculative m=
isses per kilo instruction (misses of any page-size that complete the page =
walk)",
+        "MetricExpr": "1e3 * cpu_core@DTLB_STORE_MISSES.WALK_COMPLETED@ / =
INST_RETIRED.ANY",
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_tlb_store_stlb_mpki",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average latency of data read request to exter=
nal memory (in nanoseconds)",
-        "MetricExpr": "(UNC_ARB_TRK_OCCUPANCY.RD + UNC_ARB_DAT_OCCUPANCY.R=
D) / UNC_ARB_TRK_REQUESTS.RD",
-        "MetricGroup": "Mem;MemoryLat;SoC",
-        "MetricName": "tma_info_mem_read_latency",
-        "PublicDescription": "Average latency of data read request to exte=
rnal memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetche=
s. ([RKL+]memory-controller only)",
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-thread",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu_core@UOPS_EXECUTED.THREA=
D\\,cmask\\=3D1@",
+        "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
+        "MetricName": "tma_info_pipeline_execute",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average latency of all requests to external m=
emory (in Uncore cycles)",
-        "MetricExpr": "(UNC_ARB_TRK_OCCUPANCY.ALL + UNC_ARB_DAT_OCCUPANCY.=
RD) / UNC_ARB_TRK_REQUESTS.ALL",
-        "MetricGroup": "Mem;SoC",
-        "MetricName": "tma_info_mem_request_latency",
+        "BriefDescription": "Instructions per a microcode Assist invocatio=
n",
+        "MetricExpr": "INST_RETIRED.ANY / cpu_core@ASSISTS.ANY\\,umask\\=
=3D0x1B@",
+        "MetricGroup": "Pipeline;Ret;Retire",
+        "MetricName": "tma_info_pipeline_ipassist",
+        "MetricThreshold": "tma_info_pipeline_ipassist < 100e3",
+        "PublicDescription": "Instructions per a microcode Assist invocati=
on. See Assists tree node for details (lower number means higher occurrence=
 rate)",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Total pipeline cost of (external) Memory Band=
width related bottlenecks",
-        "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (=
tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_l3_bound /=
 (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_b=
ound) * (tma_sq_full / (tma_contested_accesses + tma_data_sharing + tma_l3_=
hit_latency + tma_sq_full))) + tma_l1_bound / (tma_dram_bound + tma_l1_boun=
d + tma_l2_bound + tma_l3_bound + tma_store_bound) * (tma_fb_full / (tma_dt=
lb_load + tma_fb_full + tma_lock_latency + tma_split_loads + tma_store_fwd_=
blk))",
-        "MetricGroup": "Mem;MemoryBW;Offcore;tma_issueBW",
-        "MetricName": "tma_info_memory_bandwidth",
-        "MetricThreshold": "tma_info_memory_bandwidth > 20",
-        "PublicDescription": "Total pipeline cost of (external) Memory Ban=
dwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_dram_bw_=
use, tma_mem_bandwidth, tma_sq_full",
+        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu_core@UOP=
S_RETIRED.SLOTS\\,cmask\\=3D1@",
+        "MetricGroup": "Pipeline;Ret",
+        "MetricName": "tma_info_pipeline_retire",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * tma_memory_bound * (tma_l1_bound / max(tma_me=
mory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + t=
ma_store_bound) * (tma_dtlb_load / max(tma_l1_bound, tma_dtlb_load + tma_fb=
_full + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_stor=
e_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tm=
a_store_bound) * (tma_dtlb_store / (tma_dtlb_store + tma_false_sharing + tm=
a_split_stores + tma_store_latency + tma_streaming_stores)))",
-        "MetricGroup": "Mem;MemoryTLB;Offcore;tma_issueTLB",
-        "MetricName": "tma_info_memory_data_tlbs",
-        "MetricThreshold": "tma_info_memory_data_tlbs > 20",
-        "PublicDescription": "Total pipeline cost of Memory Address Transl=
ation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_load,=
 tma_dtlb_store",
+        "BriefDescription": "Estimated fraction of retirement-cycles deali=
ng with repeat instructions",
+        "MetricExpr": "INST_RETIRED.REP_ITERATION / cpu_core@UOPS_RETIRED.=
SLOTS\\,cmask\\=3D1@",
+        "MetricGroup": "Pipeline;Ret",
+        "MetricName": "tma_info_pipeline_strings_cycles",
+        "MetricThreshold": "tma_info_pipeline_strings_cycles > 0.1",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Total pipeline cost of Memory Latency related=
 bottlenecks (external memory and off-core caches)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (=
tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_l3_bound / (=
tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bou=
nd) * (tma_l3_hit_latency / (tma_contested_accesses + tma_data_sharing + tm=
a_l3_hit_latency + tma_sq_full)) + tma_l2_bound / (tma_dram_bound + tma_l1_=
bound + tma_l2_bound + tma_l3_bound + tma_store_bound))",
-        "MetricGroup": "Mem;MemoryLat;Offcore;tma_issueLat",
-        "MetricName": "tma_info_memory_latency",
-        "MetricThreshold": "tma_info_memory_latency > 20",
-        "PublicDescription": "Total pipeline cost of Memory Latency relate=
d bottlenecks (external memory and off-core caches). Related metrics: tma_l=
3_hit_latency, tma_mem_latency",
+        "BriefDescription": "Measured Average Frequency for unhalted proce=
ssors [GHz]",
+        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / dur=
ation_time",
+        "MetricGroup": "Power;Summary",
+        "MetricName": "tma_info_system_average_frequency",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * (tma_branch_mispredicts + tma_fetch_latency *=
 tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_i=
cache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
-        "MetricGroup": "Bad;BadSpec;BrMispredicts;tma_issueBM",
-        "MetricName": "tma_info_mispredictions",
-        "MetricThreshold": "tma_info_mispredictions > 20",
-        "PublicDescription": "Total pipeline cost of Branch Misprediction =
related bottlenecks. Related metrics: tma_branch_mispredicts, tma_info_bran=
ch_misprediction_cost, tma_mispredicts_resteers",
+        "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricGroup": "HPC;Summary",
+        "MetricName": "tma_info_system_cpu_utilization",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLE=
S",
-        "MetricGroup": "Mem;MemoryBW;MemoryBound",
-        "MetricName": "tma_info_mlp",
-        "PublicDescription": "Memory-Level-Parallelism (average number of =
L1 miss demand load when there is at least one such miss. Per-Logical Proce=
ssor)",
+        "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
+        "MetricExpr": "64 * (UNC_ARB_TRK_REQUESTS.ALL + UNC_ARB_COH_TRK_RE=
QUESTS.ALL) / 1e6 / duration_time / 1e3",
+        "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
+        "MetricName": "tma_info_system_dram_bw_use",
+        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_fb_full, tma_info_bottlenec=
k_memory_bandwidth, tma_mem_bandwidth, tma_sq_full",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fraction of branches of other types (not indi=
vidually covered by other metrics in Info.Branches group)",
-        "MetricExpr": "1 - (tma_info_cond_nt + tma_info_cond_tk + tma_info=
_callret + tma_info_jump)",
-        "MetricGroup": "Bad;Branches",
-        "MetricName": "tma_info_other_branches",
+        "BriefDescription": "Giga Floating Point Operations Per Second",
+        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.SCALAR_SINGLE@ + cp=
u_core@FP_ARITH_INST_RETIRED.SCALAR_DOUBLE@ + 2 * cpu_core@FP_ARITH_INST_RE=
TIRED.128B_PACKED_DOUBLE@ + 4 * (cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED=
_SINGLE@ + cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE@) + 8 * cpu_co=
re@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@) / 1e9 / duration_time",
+        "MetricGroup": "Cor;Flops;HPC",
+        "MetricName": "tma_info_system_gflops",
+        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine.",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
-        "MetricExpr": "(cpu_core@ITLB_MISSES.WALK_PENDING@ + cpu_core@DTLB=
_LOAD_MISSES.WALK_PENDING@ + cpu_core@DTLB_STORE_MISSES.WALK_PENDING@) / (4=
 * tma_info_core_clks)",
-        "MetricGroup": "Mem;MemoryTLB",
-        "MetricName": "tma_info_page_walks_utilization",
-        "MetricThreshold": "tma_info_page_walks_utilization > 0.5",
+        "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
+        "MetricExpr": "INST_RETIRED.ANY / cpu_core@BR_INST_RETIRED.FAR_BRA=
NCH@u",
+        "MetricGroup": "Branches;OS",
+        "MetricName": "tma_info_system_ipfarbranch",
+        "MetricThreshold": "tma_info_system_ipfarbranch < 1e6",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "tma_retiring * tma_info_slots / cpu_core@UOPS_RETIR=
ED.SLOTS\\,cmask\\=3D1@",
-        "MetricGroup": "Pipeline;Ret",
-        "MetricName": "tma_info_retire",
+        "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / cpu_core@INST_RETIRED=
.ANY_P@k",
+        "MetricGroup": "OS",
+        "MetricName": "tma_info_system_kernel_cpi",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
-        "MetricExpr": "cpu_core@TOPDOWN.SLOTS@",
-        "MetricGroup": "TmaL1;tma_L1_group",
-        "MetricName": "tma_info_slots",
+        "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.THRE=
AD",
+        "MetricGroup": "OS",
+        "MetricName": "tma_info_system_kernel_utilization",
+        "MetricThreshold": "tma_info_system_kernel_utilization > 0.05",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fraction of Physical Core issue-slots utilize=
d by this Logical Processor",
-        "MetricExpr": "(tma_info_slots / (cpu_core@TOPDOWN.SLOTS@ / 2) if =
#SMT_on else 1)",
-        "MetricGroup": "SMT;TmaL1;tma_L1_group",
-        "MetricName": "tma_info_slots_utilization",
+        "BriefDescription": "Average number of parallel data read requests=
 to external memory",
+        "MetricExpr": "UNC_ARB_DAT_OCCUPANCY.RD / cpu_core@UNC_ARB_DAT_OCC=
UPANCY.RD\\,cmask\\=3D1@",
+        "MetricGroup": "Mem;MemoryBW;SoC",
+        "MetricName": "tma_info_system_mem_parallel_reads",
+        "PublicDescription": "Average number of parallel data read request=
s to external memory. Accounts for demand loads and L1/L2 prefetches",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Average latency of data read request to exter=
nal memory (in nanoseconds)",
+        "MetricExpr": "(UNC_ARB_TRK_OCCUPANCY.RD + UNC_ARB_DAT_OCCUPANCY.R=
D) / UNC_ARB_TRK_REQUESTS.RD",
+        "MetricGroup": "Mem;MemoryLat;SoC",
+        "MetricName": "tma_info_system_mem_read_latency",
+        "PublicDescription": "Average latency of data read request to exte=
rnal memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetche=
s. ([RKL+]memory-controller only)",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Average latency of all requests to external m=
emory (in Uncore cycles)",
+        "MetricExpr": "(UNC_ARB_TRK_OCCUPANCY.ALL + UNC_ARB_DAT_OCCUPANCY.=
RD) / UNC_ARB_TRK_REQUESTS.ALL",
+        "MetricGroup": "Mem;SoC",
+        "MetricName": "tma_info_system_mem_request_latency",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
         "MetricExpr": "(1 - cpu_core@CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE@ /=
 cpu_core@CPU_CLK_UNHALTED.REF_DISTRIBUTED@ if #SMT_on else 0)",
         "MetricGroup": "SMT",
-        "MetricName": "tma_info_smt_2t_utilization",
+        "MetricName": "tma_info_system_smt_2t_utilization",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Socket actual clocks when any core is active =
on that socket",
         "MetricExpr": "UNC_CLOCK.SOCKET",
         "MetricGroup": "SoC",
-        "MetricName": "tma_info_socket_clks",
+        "MetricName": "tma_info_system_socket_clks",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "STLB (2nd level TLB) data store speculative m=
isses per kilo instruction (misses of any page-size that complete the page =
walk)",
-        "MetricExpr": "1e3 * cpu_core@DTLB_STORE_MISSES.WALK_COMPLETED@ / =
INST_RETIRED.ANY",
-        "MetricGroup": "Mem;MemoryTLB",
-        "MetricName": "tma_info_store_stlb_mpki",
+        "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
+        "MetricExpr": "tma_info_thread_clks / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricGroup": "Power",
+        "MetricName": "tma_info_system_turbo_utilization",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Estimated fraction of retirement-cycles deali=
ng with repeat instructions",
-        "MetricExpr": "INST_RETIRED.REP_ITERATION / cpu_core@UOPS_RETIRED.=
SLOTS\\,cmask\\=3D1@",
-        "MetricGroup": "Pipeline;Ret",
-        "MetricName": "tma_info_strings_cycles",
-        "MetricThreshold": "tma_info_strings_cycles > 0.1",
+        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
+        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.THREAD@",
+        "MetricGroup": "Pipeline",
+        "MetricName": "tma_info_thread_clks",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
-        "MetricExpr": "tma_info_clks / CPU_CLK_UNHALTED.REF_TSC",
-        "MetricGroup": "Power",
-        "MetricName": "tma_info_turbo_utilization",
+        "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
+        "MetricExpr": "1 / tma_info_thread_ipc",
+        "MetricGroup": "Mem;Pipeline",
+        "MetricName": "tma_info_thread_cpi",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "The ratio of Executed- by Issued-Uops",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / UOPS_ISSUED.ANY",
+        "MetricGroup": "Cor;Pipeline",
+        "MetricName": "tma_info_thread_execute_per_issue",
+        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage.",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
+        "MetricExpr": "INST_RETIRED.ANY / tma_info_thread_clks",
+        "MetricGroup": "Ret;Summary",
+        "MetricName": "tma_info_thread_ipc",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
+        "MetricExpr": "cpu_core@TOPDOWN.SLOTS@",
+        "MetricGroup": "TmaL1;tma_L1_group",
+        "MetricName": "tma_info_thread_slots",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Fraction of Physical Core issue-slots utilize=
d by this Logical Processor",
+        "MetricExpr": "(tma_info_thread_slots / (cpu_core@TOPDOWN.SLOTS@ /=
 2) if #SMT_on else 1)",
+        "MetricGroup": "SMT;TmaL1;tma_L1_group",
+        "MetricName": "tma_info_thread_slots_utilization",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Uops Per Instruction",
-        "MetricExpr": "tma_retiring * tma_info_slots / INST_RETIRED.ANY",
+        "MetricExpr": "tma_retiring * tma_info_thread_slots / INST_RETIRED=
.ANY",
         "MetricGroup": "Pipeline;Ret;Retire",
-        "MetricName": "tma_info_uoppi",
-        "MetricThreshold": "tma_info_uoppi > 1.05",
+        "MetricName": "tma_info_thread_uoppi",
+        "MetricThreshold": "tma_info_thread_uoppi > 1.05",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Instruction per taken branch",
-        "MetricExpr": "tma_retiring * tma_info_slots / BR_INST_RETIRED.NEA=
R_TAKEN",
+        "MetricExpr": "tma_retiring * tma_info_thread_slots / BR_INST_RETI=
RED.NEAR_TAKEN",
         "MetricGroup": "Branches;Fed;FetchBW",
-        "MetricName": "tma_info_uptb",
-        "MetricThreshold": "tma_info_uptb < 9",
+        "MetricName": "tma_info_thread_uptb",
+        "MetricThreshold": "tma_info_thread_uptb < 9",
         "Unit": "cpu_core"
     },
     {
@@ -1969,7 +1943,7 @@
     },
     {
         "BriefDescription": "This metric represents 128-bit vector Integer=
 ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction the=
 CPU has retired",
-        "MetricExpr": "(cpu_core@INT_VEC_RETIRED.ADD_128@ + cpu_core@INT_V=
EC_RETIRED.VNNI_128@) / (tma_retiring * tma_info_slots)",
+        "MetricExpr": "(cpu_core@INT_VEC_RETIRED.ADD_128@ + cpu_core@INT_V=
EC_RETIRED.VNNI_128@) / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_L4_group;=
tma_int_operations_group;tma_issue2P",
         "MetricName": "tma_int_vector_128b",
         "MetricThreshold": "tma_int_vector_128b > 0.1 & (tma_int_operation=
s > 0.1 & tma_light_operations > 0.6)",
@@ -1979,7 +1953,7 @@
     },
     {
         "BriefDescription": "This metric represents 256-bit vector Integer=
 ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction the=
 CPU has retired",
-        "MetricExpr": "(cpu_core@INT_VEC_RETIRED.ADD_256@ + cpu_core@INT_V=
EC_RETIRED.MUL_256@ + cpu_core@INT_VEC_RETIRED.VNNI_256@) / (tma_retiring *=
 tma_info_slots)",
+        "MetricExpr": "(cpu_core@INT_VEC_RETIRED.ADD_256@ + cpu_core@INT_V=
EC_RETIRED.MUL_256@ + cpu_core@INT_VEC_RETIRED.VNNI_256@) / (tma_retiring *=
 tma_info_thread_slots)",
         "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_L4_group;=
tma_int_operations_group;tma_issue2P",
         "MetricName": "tma_int_vector_256b",
         "MetricThreshold": "tma_int_vector_256b > 0.1 & (tma_int_operation=
s > 0.1 & tma_light_operations > 0.6)",
@@ -1989,7 +1963,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
-        "MetricExpr": "ICACHE_TAG.STALLS / tma_info_clks",
+        "MetricExpr": "ICACHE_TAG.STALLS / tma_info_thread_clks",
         "MetricGroup": "BigFoot;FetchLat;MemoryTLB;TopdownL3;tma_L3_group;=
tma_fetch_latency_group",
         "MetricName": "tma_itlb_misses",
         "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
@@ -1999,7 +1973,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache",
-        "MetricExpr": "max((cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@ - cpu_co=
re@MEMORY_ACTIVITY.STALLS_L1D_MISS@) / tma_info_clks, 0)",
+        "MetricExpr": "max((cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@ - cpu_co=
re@MEMORY_ACTIVITY.STALLS_L1D_MISS@) / tma_info_thread_clks, 0)",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_issueL1;tma_issueMC;tma_memory_bound_group",
         "MetricName": "tma_l1_bound",
         "MetricThreshold": "tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2)",
@@ -2010,7 +1984,7 @@
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(cpu_core@MEMORY_ACTIVITY.STALLS_L1D_MISS@ - cpu_co=
re@MEMORY_ACTIVITY.STALLS_L2_MISS@) / tma_info_clks",
+        "MetricExpr": "(cpu_core@MEMORY_ACTIVITY.STALLS_L1D_MISS@ - cpu_co=
re@MEMORY_ACTIVITY.STALLS_L2_MISS@) / tma_info_thread_clks",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
         "MetricName": "tma_l2_bound",
         "MetricThreshold": "tma_l2_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
@@ -2020,7 +1994,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
-        "MetricExpr": "(cpu_core@MEMORY_ACTIVITY.STALLS_L2_MISS@ - cpu_cor=
e@MEMORY_ACTIVITY.STALLS_L3_MISS@) / tma_info_clks",
+        "MetricExpr": "(cpu_core@MEMORY_ACTIVITY.STALLS_L2_MISS@ - cpu_cor=
e@MEMORY_ACTIVITY.STALLS_L3_MISS@) / tma_info_thread_clks",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
         "MetricThreshold": "tma_l3_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
@@ -2030,21 +2004,21 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited)",
-        "MetricExpr": "9 * tma_info_average_frequency * cpu_core@MEM_LOAD_=
RETIRED.L3_HIT@ * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOA=
D_RETIRED.L1_MISS@ / 2) / tma_info_clks",
+        "MetricExpr": "9 * tma_info_system_average_frequency * cpu_core@ME=
M_LOAD_RETIRED.L3_HIT@ * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@=
MEM_LOAD_RETIRED.L1_MISS@ / 2) / tma_info_thread_clks",
         "MetricGroup": "MemoryLat;TopdownL4;tma_L4_group;tma_issueLat;tma_=
l3_bound_group",
         "MetricName": "tma_l3_hit_latency",
         "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound > 0.0=
5 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric represents fraction of cycles wi=
th demand load accesses that hit the L3 cache under unloaded scenarios (pos=
sibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L=
3 hits) will improve the latency; reduce contention with sibling physical c=
ores and increase performance.  Note the value of this node may overlap wit=
h its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: t=
ma_info_memory_latency, tma_mem_latency",
+        "PublicDescription": "This metric represents fraction of cycles wi=
th demand load accesses that hit the L3 cache under unloaded scenarios (pos=
sibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L=
3 hits) will improve the latency; reduce contention with sibling physical c=
ores and increase performance.  Note the value of this node may overlap wit=
h its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: t=
ma_info_bottleneck_memory_latency, tma_mem_latency",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 was stalled due to Length Changing Prefixes (LCPs)",
-        "MetricExpr": "DECODE.LCP / tma_info_clks",
+        "MetricExpr": "DECODE.LCP / tma_info_thread_clks",
         "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group;tma_issueFB",
         "MetricName": "tma_lcp",
         "MetricThreshold": "tma_lcp > 0.05 & (tma_fetch_latency > 0.1 & tm=
a_frontend_bound > 0.15)",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs. Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_dsb_coverage, tma_info_dsb_misses, tma_info_iptb",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs. Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, t=
ma_info_inst_mix_iptb",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2061,7 +2035,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Load operations",
-        "MetricExpr": "UOPS_DISPATCHED.PORT_2_3_10 / (3 * tma_info_core_cl=
ks)",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_2_3_10 / (3 * tma_info_core_co=
re_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_load_op_utilization",
         "MetricThreshold": "tma_load_op_utilization > 0.6",
@@ -2080,7 +2054,7 @@
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
where the Second-level TLB (STLB) was missed by load accesses, performing a=
 hardware page walk",
-        "MetricExpr": "DTLB_LOAD_MISSES.WALK_ACTIVE / tma_info_clks",
+        "MetricExpr": "DTLB_LOAD_MISSES.WALK_ACTIVE / tma_info_thread_clks=
",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_load_gro=
up",
         "MetricName": "tma_load_stlb_miss",
         "MetricThreshold": "tma_load_stlb_miss > 0.05 & (tma_dtlb_load > 0=
.1 & (tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.=
2)))",
@@ -2090,7 +2064,7 @@
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(16 * max(0, cpu_core@MEM_INST_RETIRED.LOCK_LOADS@ =
- cpu_core@L2_RQSTS.ALL_RFO@) + cpu_core@MEM_INST_RETIRED.LOCK_LOADS@ / cpu=
_core@MEM_INST_RETIRED.ALL_STORES@ * (10 * cpu_core@L2_RQSTS.RFO_HIT@ + min=
(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFFCORE_REQUESTS_OUTSTANDING.C=
YCLES_WITH_DEMAND_RFO@))) / tma_info_clks",
+        "MetricExpr": "(16 * max(0, cpu_core@MEM_INST_RETIRED.LOCK_LOADS@ =
- cpu_core@L2_RQSTS.ALL_RFO@) + cpu_core@MEM_INST_RETIRED.LOCK_LOADS@ / cpu=
_core@MEM_INST_RETIRED.ALL_STORES@ * (10 * cpu_core@L2_RQSTS.RFO_HIT@ + min=
(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFFCORE_REQUESTS_OUTSTANDING.C=
YCLES_WITH_DEMAND_RFO@))) / tma_info_thread_clks",
         "MetricGroup": "Offcore;TopdownL4;tma_L4_group;tma_issueRFO;tma_l1=
_bound_group",
         "MetricName": "tma_lock_latency",
         "MetricThreshold": "tma_lock_latency > 0.2 & (tma_l1_bound > 0.1 &=
 (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -2100,10 +2074,10 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to LSD (Loop Stream Detector) unit",
-        "MetricExpr": "(cpu_core@LSD.CYCLES_ACTIVE@ - cpu_core@LSD.CYCLES_=
OK@) / tma_info_core_clks / 2",
+        "MetricExpr": "(cpu_core@LSD.CYCLES_ACTIVE@ - cpu_core@LSD.CYCLES_=
OK@) / tma_info_core_core_clks / 2",
         "MetricGroup": "FetchBW;LSD;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
         "MetricName": "tma_lsd",
-        "MetricThreshold": "tma_lsd > 0.15 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_ipc / 6 > 0.35)",
+        "MetricThreshold": "tma_lsd > 0.15 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_thread_ipc / 6 > 0.35)",
         "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to LSD (Loop Stream Detector) unit. =
 LSD typically does well sustaining Uop supply. However; in some rare cases=
; optimal uop-delivery could not be reached for small loops whose size (in =
terms of number of uops) does not suit well the LSD structure.",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2121,27 +2095,27 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory (DRAM)",
-        "MetricExpr": "min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFF=
CORE_REQUESTS_OUTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_clks",
+        "MetricExpr": "min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFF=
CORE_REQUESTS_OUTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_thread_clk=
s",
         "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_dram_b=
ound_group;tma_issueBW",
         "MetricName": "tma_mem_bandwidth",
         "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_dram_bound > 0.=
1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory (DRAM).  The underlying heuristic assumes that a simi=
lar off-core traffic is generated by all IA cores. This metric does not agg=
regate non-data-read requests by this logical processor; requests from othe=
r IA Logical Processors/Physical Cores/sockets; or other non-IA devices lik=
e GPU; hence the maximum external memory bandwidth limits may or may not be=
 approached when this metric is flagged (see Uncore counters for that). Rel=
ated metrics: tma_fb_full, tma_info_dram_bw_use, tma_info_memory_bandwidth,=
 tma_sq_full",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory (DRAM).  The underlying heuristic assumes that a simi=
lar off-core traffic is generated by all IA cores. This metric does not agg=
regate non-data-read requests by this logical processor; requests from othe=
r IA Logical Processors/Physical Cores/sockets; or other non-IA devices lik=
e GPU; hence the maximum external memory bandwidth limits may or may not be=
 approached when this metric is flagged (see Uncore counters for that). Rel=
ated metrics: tma_fb_full, tma_info_bottleneck_memory_bandwidth, tma_info_s=
ystem_dram_bw_use, tma_sq_full",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the performance was likely hurt due to latency from external memory (DRAM=
)",
-        "MetricExpr": "min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFF=
CORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD@) / tma_info_clks - tma_mem_b=
andwidth",
+        "MetricExpr": "min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFF=
CORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD@) / tma_info_thread_clks - tm=
a_mem_bandwidth",
         "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_dram_=
bound_group;tma_issueLat",
         "MetricName": "tma_mem_latency",
         "MetricThreshold": "tma_mem_latency > 0.1 & (tma_dram_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory (DRA=
M).  This metric does not aggregate requests from other Logical Processors/=
Physical Cores/sockets (see Uncore counters for that). Related metrics: tma=
_info_memory_latency, tma_l3_hit_latency",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory (DRA=
M).  This metric does not aggregate requests from other Logical Processors/=
Physical Cores/sockets (see Uncore counters for that). Related metrics: tma=
_info_bottleneck_memory_latency, tma_l3_hit_latency",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
-        "MetricExpr": "cpu_core@topdown\\-mem\\-bound@ / (cpu_core@topdown=
\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiri=
ng@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_slots",
+        "MetricExpr": "cpu_core@topdown\\-mem\\-bound@ / (cpu_core@topdown=
\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiri=
ng@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
         "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_b=
ound_group",
         "MetricName": "tma_memory_bound",
         "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0=
.2",
@@ -2152,7 +2126,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to LFENCE Instructions.",
-        "MetricExpr": "13 * cpu_core@MISC2_RETIRED.LFENCE@ / tma_info_clks=
",
+        "MetricExpr": "13 * cpu_core@MISC2_RETIRED.LFENCE@ / tma_info_thre=
ad_clks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_serializing_operation_g=
roup",
         "MetricName": "tma_memory_fence",
         "MetricThreshold": "tma_memory_fence > 0.05 & (tma_serializing_ope=
ration > 0.1 & (tma_ports_utilized_0 > 0.2 & (tma_ports_utilization > 0.15 =
& (tma_core_bound > 0.1 & tma_backend_bound > 0.2))))",
@@ -2162,7 +2136,7 @@
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations -- uops for memory load or store a=
ccesses.",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "tma_light_operations * cpu_core@MEM_UOP_RETIRED.ANY=
@ / (tma_retiring * tma_info_slots)",
+        "MetricExpr": "tma_light_operations * cpu_core@MEM_UOP_RETIRED.ANY=
@ / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_memory_operations",
         "MetricThreshold": "tma_memory_operations > 0.1 & tma_light_operat=
ions > 0.6",
@@ -2171,7 +2145,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU was retiring uops fetched by the Microcode Sequencer (MS) unit",
-        "MetricExpr": "UOPS_RETIRED.MS / tma_info_slots",
+        "MetricExpr": "UOPS_RETIRED.MS / tma_info_thread_slots",
         "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_heavy_operatio=
ns_group;tma_issueMC;tma_issueMS",
         "MetricName": "tma_microcode_sequencer",
         "MetricThreshold": "tma_microcode_sequencer > 0.05 & tma_heavy_ope=
rations > 0.1",
@@ -2181,27 +2155,27 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Branch Misprediction=
 at execution stage",
-        "MetricExpr": "tma_branch_mispredicts / tma_bad_speculation * cpu_=
core@INT_MISC.CLEAR_RESTEER_CYCLES@ / tma_info_clks",
+        "MetricExpr": "tma_branch_mispredicts / tma_bad_speculation * cpu_=
core@INT_MISC.CLEAR_RESTEER_CYCLES@ / tma_info_thread_clks",
         "MetricGroup": "BadSpec;BrMispredicts;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group;tma_issueBM",
         "MetricName": "tma_mispredicts_resteers",
         "MetricThreshold": "tma_mispredicts_resteers > 0.05 & (tma_branch_=
resteers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage. Sample with: INT_MISC.CLEAR_RESTEER_CYCLES. Related m=
etrics: tma_branch_mispredicts, tma_info_branch_misprediction_cost, tma_inf=
o_mispredictions",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage. Sample with: INT_MISC.CLEAR_RESTEER_CYCLES. Related m=
etrics: tma_branch_mispredicts, tma_info_bad_spec_branch_misprediction_cost=
, tma_info_bottleneck_mispredictions",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the MITE pipeline (the legacy deco=
de pipeline)",
-        "MetricExpr": "(cpu_core@IDQ.MITE_CYCLES_ANY@ - cpu_core@IDQ.MITE_=
CYCLES_OK@) / tma_info_core_clks / 2",
+        "MetricExpr": "(cpu_core@IDQ.MITE_CYCLES_ANY@ - cpu_core@IDQ.MITE_=
CYCLES_OK@) / tma_info_core_core_clks / 2",
         "MetricGroup": "DSBmiss;FetchBW;TopdownL3;tma_L3_group;tma_fetch_b=
andwidth_group",
         "MetricName": "tma_mite",
-        "MetricThreshold": "tma_mite > 0.1 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_ipc / 6 > 0.35)",
+        "MetricThreshold": "tma_mite > 0.1 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_thread_ipc / 6 > 0.35)",
         "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to the MITE pipeline (the legacy dec=
ode pipeline). This pipeline is used for code that was not pre-cached in th=
e DSB or LSD. For example; inefficiencies due to asymmetric decoders; use o=
f long immediate or LCP can manifest as MITE fetch bandwidth bottleneck. Sa=
mple with: FRONTEND_RETIRED.ANY_DSB_MISS",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "The Mixing_Vectors metric gives the percentag=
e of injected blend uops out of all uops issued",
-        "MetricExpr": "160 * cpu_core@ASSISTS.SSE_AVX_MIX@ / tma_info_clks=
",
+        "MetricExpr": "160 * cpu_core@ASSISTS.SSE_AVX_MIX@ / tma_info_thre=
ad_clks",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_issueMV;tma_ports_utili=
zed_0_group",
         "MetricName": "tma_mixing_vectors",
         "MetricThreshold": "tma_mixing_vectors > 0.05",
@@ -2211,7 +2185,7 @@
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS)",
-        "MetricExpr": "3 * cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D1\\,edge@ =
/ (tma_retiring * tma_info_slots / cpu_core@UOPS_ISSUED.ANY@) / tma_info_cl=
ks",
+        "MetricExpr": "3 * cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D1\\,edge@ =
/ (tma_retiring * tma_info_thread_slots / cpu_core@UOPS_ISSUED.ANY@) / tma_=
info_thread_clks",
         "MetricGroup": "FetchLat;MicroSeq;TopdownL3;tma_L3_group;tma_fetch=
_latency_group;tma_issueMC;tma_issueMS;tma_issueMV;tma_issueSO",
         "MetricName": "tma_ms_switches",
         "MetricThreshold": "tma_ms_switches > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
@@ -2221,7 +2195,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring branch instructions that were not fused",
-        "MetricExpr": "tma_light_operations * (cpu_core@BR_INST_RETIRED.AL=
L_BRANCHES@ - cpu_core@INST_RETIRED.MACRO_FUSED@) / (tma_retiring * tma_inf=
o_slots)",
+        "MetricExpr": "tma_light_operations * (cpu_core@BR_INST_RETIRED.AL=
L_BRANCHES@ - cpu_core@INST_RETIRED.MACRO_FUSED@) / (tma_retiring * tma_inf=
o_thread_slots)",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_non_fused_branches",
         "MetricThreshold": "tma_non_fused_branches > 0.1 & tma_light_opera=
tions > 0.6",
@@ -2231,7 +2205,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring NOP (no op) instructions",
-        "MetricExpr": "tma_light_operations * cpu_core@INST_RETIRED.NOP@ /=
 (tma_retiring * tma_info_slots)",
+        "MetricExpr": "tma_light_operations * cpu_core@INST_RETIRED.NOP@ /=
 (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_nop_instructions",
         "MetricThreshold": "tma_nop_instructions > 0.1 & tma_light_operati=
ons > 0.6",
@@ -2252,7 +2226,7 @@
     },
     {
         "BriefDescription": "This metric roughly estimates fraction of slo=
ts the CPU retired uops as a result of handing Page Faults",
-        "MetricExpr": "99 * cpu_core@ASSISTS.PAGE_FAULT@ / tma_info_slots"=
,
+        "MetricExpr": "99 * cpu_core@ASSISTS.PAGE_FAULT@ / tma_info_thread=
_slots",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_assists_group",
         "MetricName": "tma_page_faults",
         "MetricThreshold": "tma_page_faults > 0.05",
@@ -2262,7 +2236,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd b=
ranch)",
-        "MetricExpr": "UOPS_DISPATCHED.PORT_0 / tma_info_core_clks",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_0 / tma_info_core_core_clks",
         "MetricGroup": "Compute;TopdownL6;tma_L6_group;tma_alu_op_utilizat=
ion_group;tma_issue2P",
         "MetricName": "tma_port_0",
         "MetricThreshold": "tma_port_0 > 0.6",
@@ -2272,7 +2246,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 1 (ALU)",
-        "MetricExpr": "UOPS_DISPATCHED.PORT_1 / tma_info_core_clks",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_1 / tma_info_core_core_clks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_1",
         "MetricThreshold": "tma_port_1 > 0.6",
@@ -2282,7 +2256,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 6 ([HSW+]Primary Branch and simple =
ALU)",
-        "MetricExpr": "UOPS_DISPATCHED.PORT_6 / tma_info_core_clks",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_6 / tma_info_core_core_clks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_6",
         "MetricThreshold": "tma_port_6 > 0.6",
@@ -2292,7 +2266,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
-        "MetricExpr": "((cpu_core@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x=
80@ + tma_serializing_operation * (cpu_core@CYCLE_ACTIVITY.STALLS_TOTAL@ - =
cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@) + (cpu_core@EXE_ACTIVITY.1_PORTS_UTI=
L@ + tma_retiring * cpu_core@EXE_ACTIVITY.2_PORTS_UTIL\\,umask\\=3D0xc@)) /=
 tma_info_clks if cpu_core@ARITH.DIV_ACTIVE@ < cpu_core@CYCLE_ACTIVITY.STAL=
LS_TOTAL@ - cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@ else (cpu_core@EXE_ACTIVI=
TY.1_PORTS_UTIL@ + tma_retiring * cpu_core@EXE_ACTIVITY.2_PORTS_UTIL\\,umas=
k\\=3D0xc@) / tma_info_clks)",
+        "MetricExpr": "((cpu_core@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x=
80@ + tma_serializing_operation * (cpu_core@CYCLE_ACTIVITY.STALLS_TOTAL@ - =
cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@) + (cpu_core@EXE_ACTIVITY.1_PORTS_UTI=
L@ + tma_retiring * cpu_core@EXE_ACTIVITY.2_PORTS_UTIL\\,umask\\=3D0xc@)) /=
 tma_info_thread_clks if cpu_core@ARITH.DIV_ACTIVE@ < cpu_core@CYCLE_ACTIVI=
TY.STALLS_TOTAL@ - cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@ else (cpu_core@EXE=
_ACTIVITY.1_PORTS_UTIL@ + tma_retiring * cpu_core@EXE_ACTIVITY.2_PORTS_UTIL=
\\,umask\\=3D0xc@) / tma_info_thread_clks)",
         "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
         "MetricName": "tma_ports_utilization",
         "MetricThreshold": "tma_ports_utilization > 0.15 & (tma_core_bound=
 > 0.1 & tma_backend_bound > 0.2)",
@@ -2302,7 +2276,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
-        "MetricExpr": "cpu_core@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x80=
@ / tma_info_clks + tma_serializing_operation * (cpu_core@CYCLE_ACTIVITY.ST=
ALLS_TOTAL@ - cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@) / tma_info_clks",
+        "MetricExpr": "cpu_core@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x80=
@ / tma_info_thread_clks + tma_serializing_operation * (cpu_core@CYCLE_ACTI=
VITY.STALLS_TOTAL@ - cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@) / tma_info_thre=
ad_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_0",
         "MetricThreshold": "tma_ports_utilized_0 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -2312,7 +2286,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re the CPU executed total of 1 uop per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "EXE_ACTIVITY.1_PORTS_UTIL / tma_info_clks",
+        "MetricExpr": "EXE_ACTIVITY.1_PORTS_UTIL / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issueL1;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_1",
         "MetricThreshold": "tma_ports_utilized_1 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -2322,7 +2296,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 2 uops per cycle on all execution ports (Logical Process=
or cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "EXE_ACTIVITY.2_PORTS_UTIL / tma_info_clks",
+        "MetricExpr": "EXE_ACTIVITY.2_PORTS_UTIL / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issue2P;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_2",
         "MetricThreshold": "tma_ports_utilized_2 > 0.15 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -2332,7 +2306,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "UOPS_EXECUTED.CYCLES_GE_3 / tma_info_clks",
+        "MetricExpr": "UOPS_EXECUTED.CYCLES_GE_3 / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_3m",
         "MetricThreshold": "tma_ports_utilized_3m > 0.7 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -2342,7 +2316,7 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
-        "MetricExpr": "cpu_core@topdown\\-retiring@ / (cpu_core@topdown\\-=
fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiring@=
 + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_slots",
+        "MetricExpr": "cpu_core@topdown\\-retiring@ / (cpu_core@topdown\\-=
fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiring@=
 + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
         "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
@@ -2353,7 +2327,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU issue-pipeline was stalled due to serializing operations",
-        "MetricExpr": "RESOURCE_STALLS.SCOREBOARD / tma_info_clks",
+        "MetricExpr": "RESOURCE_STALLS.SCOREBOARD / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL5;tma_L5_group;tma_issueSO;tma_p=
orts_utilized_0_group",
         "MetricName": "tma_serializing_operation",
         "MetricThreshold": "tma_serializing_operation > 0.1 & (tma_ports_u=
tilized_0 > 0.2 & (tma_ports_utilization > 0.15 & (tma_core_bound > 0.1 & t=
ma_backend_bound > 0.2)))",
@@ -2363,7 +2337,7 @@
     },
     {
         "BriefDescription": "This metric represents Shuffle (cross \"vecto=
r lane\" data transfers) uops fraction the CPU has retired.",
-        "MetricExpr": "INT_VEC_RETIRED.SHUFFLES / (tma_retiring * tma_info=
_slots)",
+        "MetricExpr": "INT_VEC_RETIRED.SHUFFLES / (tma_retiring * tma_info=
_thread_slots)",
         "MetricGroup": "HPC;Pipeline;TopdownL4;tma_L4_group;tma_int_operat=
ions_group",
         "MetricName": "tma_shuffles",
         "MetricThreshold": "tma_shuffles > 0.1 & (tma_int_operations > 0.1=
 & tma_light_operations > 0.6)",
@@ -2372,7 +2346,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to PAUSE Instructions",
-        "MetricExpr": "CPU_CLK_UNHALTED.PAUSE / tma_info_clks",
+        "MetricExpr": "CPU_CLK_UNHALTED.PAUSE / tma_info_thread_clks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_serializing_operation_g=
roup",
         "MetricName": "tma_slow_pause",
         "MetricThreshold": "tma_slow_pause > 0.05 & (tma_serializing_opera=
tion > 0.1 & (tma_ports_utilized_0 > 0.2 & (tma_ports_utilization > 0.15 & =
(tma_core_bound > 0.1 & tma_backend_bound > 0.2))))",
@@ -2382,7 +2356,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles hand=
ling memory load split accesses - load that cross 64-byte cache line bounda=
ry",
-        "MetricExpr": "tma_info_load_miss_real_latency * cpu_core@LD_BLOCK=
S.NO_SR@ / tma_info_clks",
+        "MetricExpr": "tma_info_memory_load_miss_real_latency * cpu_core@L=
D_BLOCKS.NO_SR@ / tma_info_thread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_split_loads",
         "MetricThreshold": "tma_split_loads > 0.2 & (tma_l1_bound > 0.1 & =
(tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -2392,7 +2366,7 @@
     },
     {
         "BriefDescription": "This metric represents rate of split store ac=
cesses",
-        "MetricExpr": "MEM_INST_RETIRED.SPLIT_STORES / tma_info_core_clks"=
,
+        "MetricExpr": "MEM_INST_RETIRED.SPLIT_STORES / tma_info_core_core_=
clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_issueSpSt;tma_store_bou=
nd_group",
         "MetricName": "tma_split_stores",
         "MetricThreshold": "tma_split_stores > 0.2 & (tma_store_bound > 0.=
2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -2402,17 +2376,17 @@
     },
     {
         "BriefDescription": "This metric measures fraction of cycles where=
 the Super Queue (SQ) was full taking into account all request-types and bo=
th hardware SMT threads (Logical Processors)",
-        "MetricExpr": "(cpu_core@XQ.FULL_CYCLES@ + cpu_core@L1D_PEND_MISS.=
L2_STALLS@) / tma_info_clks",
+        "MetricExpr": "(cpu_core@XQ.FULL_CYCLES@ + cpu_core@L1D_PEND_MISS.=
L2_STALLS@) / tma_info_thread_clks",
         "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_issueB=
W;tma_l3_bound_group",
         "MetricName": "tma_sq_full",
         "MetricThreshold": "tma_sq_full > 0.3 & (tma_l3_bound > 0.05 & (tm=
a_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_fb_full=
, tma_info_dram_bw_use, tma_info_memory_bandwidth, tma_mem_bandwidth",
+        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_fb_full=
, tma_info_bottleneck_memory_bandwidth, tma_info_system_dram_bw_use, tma_me=
m_bandwidth",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to RFO store memory accesses; RFO store issue a read-for-ownership =
request before the write",
-        "MetricExpr": "EXE_ACTIVITY.BOUND_ON_STORES / tma_info_clks",
+        "MetricExpr": "EXE_ACTIVITY.BOUND_ON_STORES / tma_info_thread_clks=
",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_store_bound",
         "MetricThreshold": "tma_store_bound > 0.2 & (tma_memory_bound > 0.=
2 & tma_backend_bound > 0.2)",
@@ -2422,7 +2396,7 @@
     },
     {
         "BriefDescription": "This metric roughly estimates fraction of cyc=
les when the memory subsystem had loads blocked since they could not forwar=
d data from earlier (in program order) overlapping stores",
-        "MetricExpr": "13 * cpu_core@LD_BLOCKS.STORE_FORWARD@ / tma_info_c=
lks",
+        "MetricExpr": "13 * cpu_core@LD_BLOCKS.STORE_FORWARD@ / tma_info_t=
hread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_store_fwd_blk",
         "MetricThreshold": "tma_store_fwd_blk > 0.1 & (tma_l1_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -2432,7 +2406,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
-        "MetricExpr": "(cpu_core@MEM_STORE_RETIRED.L2_HIT@ * 10 * (1 - cpu=
_core@MEM_INST_RETIRED.LOCK_LOADS@ / cpu_core@MEM_INST_RETIRED.ALL_STORES@)=
 + (1 - cpu_core@MEM_INST_RETIRED.LOCK_LOADS@ / cpu_core@MEM_INST_RETIRED.A=
LL_STORES@) * min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFFCORE_REQUE=
STS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO@)) / tma_info_clks",
+        "MetricExpr": "(cpu_core@MEM_STORE_RETIRED.L2_HIT@ * 10 * (1 - cpu=
_core@MEM_INST_RETIRED.LOCK_LOADS@ / cpu_core@MEM_INST_RETIRED.ALL_STORES@)=
 + (1 - cpu_core@MEM_INST_RETIRED.LOCK_LOADS@ / cpu_core@MEM_INST_RETIRED.A=
LL_STORES@) * min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFFCORE_REQUE=
STS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO@)) / tma_info_thread_clks",
         "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_issue=
RFO;tma_issueSL;tma_store_bound_group",
         "MetricName": "tma_store_latency",
         "MetricThreshold": "tma_store_latency > 0.1 & (tma_store_bound > 0=
.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -2442,7 +2416,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Store operations",
-        "MetricExpr": "(cpu_core@UOPS_DISPATCHED.PORT_4_9@ + cpu_core@UOPS=
_DISPATCHED.PORT_7_8@) / (4 * tma_info_core_clks)",
+        "MetricExpr": "(cpu_core@UOPS_DISPATCHED.PORT_4_9@ + cpu_core@UOPS=
_DISPATCHED.PORT_7_8@) / (4 * tma_info_core_core_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_store_op_utilization",
         "MetricThreshold": "tma_store_op_utilization > 0.6",
@@ -2461,7 +2435,7 @@
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
where the STLB was missed by store accesses, performing a hardware page wal=
k",
-        "MetricExpr": "DTLB_STORE_MISSES.WALK_ACTIVE / tma_info_core_clks"=
,
+        "MetricExpr": "DTLB_STORE_MISSES.WALK_ACTIVE / tma_info_core_core_=
clks",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_store_gr=
oup",
         "MetricName": "tma_store_stlb_miss",
         "MetricThreshold": "tma_store_stlb_miss > 0.05 & (tma_dtlb_store >=
 0.05 & (tma_store_bound > 0.2 & (tma_memory_bound > 0.2 & tma_backend_boun=
d > 0.2)))",
@@ -2470,7 +2444,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to Streaming store memory accesses; Streaming store optimize out a =
read request required by RFO stores",
-        "MetricExpr": "9 * cpu_core@OCR.STREAMING_WR.ANY_RESPONSE@ / tma_i=
nfo_clks",
+        "MetricExpr": "9 * cpu_core@OCR.STREAMING_WR.ANY_RESPONSE@ / tma_i=
nfo_thread_clks",
         "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_issueS=
mSt;tma_store_bound_group",
         "MetricName": "tma_streaming_stores",
         "MetricThreshold": "tma_streaming_stores > 0.2 & (tma_store_bound =
> 0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -2480,7 +2454,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to new branch address clears",
-        "MetricExpr": "INT_MISC.UNKNOWN_BRANCH_CYCLES / tma_info_clks",
+        "MetricExpr": "INT_MISC.UNKNOWN_BRANCH_CYCLES / tma_info_thread_cl=
ks",
         "MetricGroup": "BigFoot;FetchLat;TopdownL4;tma_L4_group;tma_branch=
_resteers_group",
         "MetricName": "tma_unknown_branches",
         "MetricThreshold": "tma_unknown_branches > 0.05 & (tma_branch_rest=
eers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/cache.json b/tools/pe=
rf/pmu-events/arch/x86/alderlake/cache.json
index 51770416bcc2..b3d7f8fb50df 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/cache.json
@@ -1017,6 +1017,15 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts bus locks, accounts for cache line spl=
it locks and UC locks.",
+        "EventCode": "0x2c",
+        "EventName": "SQ_MISC.BUS_LOCK",
+        "PublicDescription": "Counts the more expensive bus lock needed to=
 enforce cache coherency for certain memory accesses that need to be done a=
tomically.  Can be created by issuing an atomic instruction (via the LOCK p=
refix) which causes a cache line split or accesses uncacheable memory.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Number of PREFETCHNTA instructions executed."=
,
         "EventCode": "0x40",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/memory.json b/tools/p=
erf/pmu-events/arch/x86/alderlake/memory.json
index 55827b276e6e..73d92d5c9f9d 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/memory.json
@@ -93,19 +93,21 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "MEMORY_ACTIVITY.STALLS_L2_MISS",
+        "BriefDescription": "Execution stalls while L2 cache miss demand c=
acheable load request is outstanding.",
         "CounterMask": "5",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.STALLS_L2_MISS",
+        "PublicDescription": "Execution stalls while L2 cache miss demand =
cacheable load request is outstanding (will not count for uncacheable deman=
d requests e.g. bus lock).",
         "SampleAfterValue": "1000003",
         "UMask": "0x5",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "MEMORY_ACTIVITY.STALLS_L3_MISS",
+        "BriefDescription": "Execution stalls while L3 cache miss demand c=
acheable load request is outstanding.",
         "CounterMask": "9",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.STALLS_L3_MISS",
+        "PublicDescription": "Execution stalls while L3 cache miss demand =
cacheable load request is outstanding (will not count for uncacheable deman=
d requests e.g. bus lock).",
         "SampleAfterValue": "1000003",
         "UMask": "0x9",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json b/=
tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
index f4b3c3883643..ed9ff25a03cf 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
@@ -86,7 +86,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to certain allocation restrictions.",
-        "MetricExpr": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS / tma_info_slot=
s",
+        "MetricExpr": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS / tma_info_core=
_slots",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_alloc_restriction",
         "MetricThreshold": "tma_alloc_restriction > 0.1",
@@ -94,7 +94,7 @@
     },
     {
         "BriefDescription": "Counts the total number of issue slots  that =
were not consumed by the backend due to backend stalls",
-        "MetricExpr": "TOPDOWN_BE_BOUND.ALL / tma_info_slots",
+        "MetricExpr": "TOPDOWN_BE_BOUND.ALL / tma_info_core_slots",
         "MetricGroup": "TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.1",
@@ -114,7 +114,7 @@
     },
     {
         "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a misp=
redicted jump or a machine clear",
-        "MetricExpr": "(tma_info_slots - (TOPDOWN_FE_BOUND.ALL + TOPDOWN_B=
E_BOUND.ALL + TOPDOWN_RETIRING.ALL)) / tma_info_slots",
+        "MetricExpr": "(tma_info_core_slots - (TOPDOWN_FE_BOUND.ALL + TOPD=
OWN_BE_BOUND.ALL + TOPDOWN_RETIRING.ALL)) / tma_info_core_slots",
         "MetricGroup": "TopdownL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
@@ -124,7 +124,7 @@
     },
     {
         "BriefDescription": "Counts the number of uops that are not from t=
he microsequencer.",
-        "MetricExpr": "(TOPDOWN_RETIRING.ALL - UOPS_RETIRED.MS) / tma_info=
_slots",
+        "MetricExpr": "(TOPDOWN_RETIRING.ALL - UOPS_RETIRED.MS) / tma_info=
_core_slots",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_retiring_group",
         "MetricName": "tma_base",
         "MetricThreshold": "tma_base > 0.6",
@@ -133,7 +133,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to BACLEARS, which occurs when the Branch =
Target Buffer (BTB) prediction or lack thereof, was corrected by a later br=
anch predictor in the frontend",
-        "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_DETECT / tma_info_slots",
+        "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_DETECT / tma_info_core_slot=
s",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_latency_group",
         "MetricName": "tma_branch_detect",
         "MetricThreshold": "tma_branch_detect > 0.05",
@@ -142,7 +142,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to branch mispredicts.",
-        "MetricExpr": "TOPDOWN_BAD_SPECULATION.MISPREDICT / tma_info_slots=
",
+        "MetricExpr": "TOPDOWN_BAD_SPECULATION.MISPREDICT / tma_info_core_=
slots",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
         "MetricName": "tma_branch_mispredicts",
         "MetricThreshold": "tma_branch_mispredicts > 0.05",
@@ -151,7 +151,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to BTCLEARS, which occurs when the Branch =
Target Buffer (BTB) predicts a taken branch.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_RESTEER / tma_info_slots",
+        "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_RESTEER / tma_info_core_slo=
ts",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_latency_group",
         "MetricName": "tma_branch_resteer",
         "MetricThreshold": "tma_branch_resteer > 0.05",
@@ -159,7 +159,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to the microcode sequencer (MS).",
-        "MetricExpr": "TOPDOWN_FE_BOUND.CISC / tma_info_slots",
+        "MetricExpr": "TOPDOWN_FE_BOUND.CISC / tma_info_core_slots",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_bandwidth_group",
         "MetricName": "tma_cisc",
         "MetricThreshold": "tma_cisc > 0.05",
@@ -176,7 +176,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to decode stalls.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.DECODE / tma_info_slots",
+        "MetricExpr": "TOPDOWN_FE_BOUND.DECODE / tma_info_core_slots",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_bandwidth_group",
         "MetricName": "tma_decode",
         "MetricThreshold": "tma_decode > 0.05",
@@ -193,7 +193,7 @@
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load miss which hit in DRAM or MMIO (Non-DRAM).",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_DRAM_HIT / tma_info_clks - ma=
x((MEM_BOUND_STALLS.LOAD - LD_HEAD.L1_MISS_AT_RET) / tma_info_clks, 0) * ME=
M_BOUND_STALLS.LOAD_DRAM_HIT / MEM_BOUND_STALLS.LOAD",
+        "MetricExpr": "MEM_BOUND_STALLS.LOAD_DRAM_HIT / tma_info_core_clks=
 - max((MEM_BOUND_STALLS.LOAD - LD_HEAD.L1_MISS_AT_RET) / tma_info_core_clk=
s, 0) * MEM_BOUND_STALLS.LOAD_DRAM_HIT / MEM_BOUND_STALLS.LOAD",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
         "MetricName": "tma_dram_bound",
         "MetricThreshold": "tma_dram_bound > 0.1",
@@ -201,7 +201,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to a machine clear classified as a fast nuke=
 due to memory ordering, memory disambiguation and memory renaming.",
-        "MetricExpr": "TOPDOWN_BAD_SPECULATION.FASTNUKE / tma_info_slots",
+        "MetricExpr": "TOPDOWN_BAD_SPECULATION.FASTNUKE / tma_info_core_sl=
ots",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
         "MetricName": "tma_fast_nuke",
         "MetricThreshold": "tma_fast_nuke > 0.05",
@@ -209,7 +209,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to frontend bandwidth restrictions due to =
decode, predecode, cisc, and other limitations.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH / tma_info_slot=
s",
+        "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH / tma_info_core=
_slots",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
         "MetricName": "tma_fetch_bandwidth",
         "MetricThreshold": "tma_fetch_bandwidth > 0.1",
@@ -218,7 +218,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to frontend bandwidth restrictions due to =
decode, predecode, cisc, and other limitations.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY / tma_info_slots"=
,
+        "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY / tma_info_core_s=
lots",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
         "MetricName": "tma_fetch_latency",
         "MetricThreshold": "tma_fetch_latency > 0.15",
@@ -235,7 +235,7 @@
     },
     {
         "BriefDescription": "Counts the number of floating point divide op=
erations per uop.",
-        "MetricExpr": "UOPS_RETIRED.FPDIV / tma_info_slots",
+        "MetricExpr": "UOPS_RETIRED.FPDIV / tma_info_core_slots",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_base_group",
         "MetricName": "tma_fpdiv_uops",
         "MetricThreshold": "tma_fpdiv_uops > 0.2",
@@ -243,7 +243,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to frontend stalls.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.ALL / tma_info_slots",
+        "MetricExpr": "TOPDOWN_FE_BOUND.ALL / tma_info_core_slots",
         "MetricGroup": "TopdownL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.2",
@@ -252,218 +252,192 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to instruction cache misses.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.ICACHE / tma_info_slots",
+        "MetricExpr": "TOPDOWN_FE_BOUND.ICACHE / tma_info_core_slots",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_latency_group",
         "MetricName": "tma_icache_misses",
         "MetricThreshold": "tma_icache_misses > 0.05",
         "ScaleUnit": "100%"
     },
-    {
-        "BriefDescription": "Percentage of total non-speculative loads wit=
h a address aliasing block",
-        "MetricExpr": "100 * LD_BLOCKS.4K_ALIAS / MEM_UOPS_RETIRED.ALL_LOA=
DS",
-        "MetricName": "tma_info_address_alias_blocks"
-    },
-    {
-        "BriefDescription": "Ratio of all branches which mispredict",
-        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.ALL_=
BRANCHES",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_branch_mispredict_ratio"
-    },
-    {
-        "BriefDescription": "Ratio between Mispredicted branches and unkno=
wn branches",
-        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / BACLEARS.ANY",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_branch_mispredict_to_unknown_branch_ratio"
-    },
     {
         "BriefDescription": "",
         "MetricExpr": "CPU_CLK_UNHALTED.CORE",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_clks"
+        "MetricName": "tma_info_core_clks"
     },
     {
         "BriefDescription": "",
         "MetricExpr": "CPU_CLK_UNHALTED.CORE_P",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_clks_p"
+        "MetricName": "tma_info_core_clks_p"
     },
     {
         "BriefDescription": "Cycles Per Instruction",
-        "MetricExpr": "tma_info_clks / INST_RETIRED.ANY",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_cpi"
-    },
-    {
-        "BriefDescription": "Average CPU Utilization",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_cpu_utilization"
-    },
-    {
-        "BriefDescription": "Cycle cost per DRAM hit",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_DRAM_HIT / MEM_LOAD_UOPS_RETI=
RED.DRAM_HIT",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_cycles_per_demand_load_dram_hit"
-    },
-    {
-        "BriefDescription": "Cycle cost per L2 hit",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_L2_HIT / MEM_LOAD_UOPS_RETIRE=
D.L2_HIT",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_cycles_per_demand_load_l2_hit"
+        "MetricExpr": "tma_info_core_clks / INST_RETIRED.ANY",
+        "MetricName": "tma_info_core_cpi"
     },
     {
-        "BriefDescription": "Cycle cost per LLC hit",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_LLC_HIT / MEM_LOAD_UOPS_RETIR=
ED.L3_HIT",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_cycles_per_demand_load_l3_hit"
+        "BriefDescription": "Instructions Per Cycle",
+        "MetricExpr": "INST_RETIRED.ANY / tma_info_core_clks",
+        "MetricName": "tma_info_core_ipc"
     },
     {
-        "BriefDescription": "Percentage of all uops which are FPDiv uops",
-        "MetricExpr": "100 * UOPS_RETIRED.FPDIV / UOPS_RETIRED.ALL",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_fpdiv_uop_ratio"
+        "BriefDescription": "",
+        "MetricExpr": "5 * tma_info_core_clks",
+        "MetricName": "tma_info_core_slots"
     },
     {
-        "BriefDescription": "Percentage of all uops which are IDiv uops",
-        "MetricExpr": "100 * UOPS_RETIRED.IDIV / UOPS_RETIRED.ALL",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_idiv_uop_ratio"
+        "BriefDescription": "Uops Per Instruction",
+        "MetricExpr": "UOPS_RETIRED.ALL / INST_RETIRED.ANY",
+        "MetricName": "tma_info_core_upi"
     },
     {
         "BriefDescription": "Percent of instruction miss cost that hit in =
DRAM",
         "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_DRAM_HIT / MEM_BOUND_=
STALLS.IFETCH",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_inst_miss_cost_dramhit_percent"
+        "MetricName": "tma_info_frontend_inst_miss_cost_dramhit_percent"
     },
     {
         "BriefDescription": "Percent of instruction miss cost that hit in =
the L2",
         "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_L2_HIT / MEM_BOUND_ST=
ALLS.IFETCH",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_inst_miss_cost_l2hit_percent"
+        "MetricName": "tma_info_frontend_inst_miss_cost_l2hit_percent"
     },
     {
         "BriefDescription": "Percent of instruction miss cost that hit in =
the L3",
         "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_LLC_HIT / MEM_BOUND_S=
TALLS.IFETCH",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_inst_miss_cost_l3hit_percent"
+        "MetricName": "tma_info_frontend_inst_miss_cost_l3hit_percent"
     },
     {
-        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurance rate)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_ipbranch"
+        "BriefDescription": "Ratio of all branches which mispredict",
+        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.ALL_=
BRANCHES",
+        "MetricName": "tma_info_inst_mix_branch_mispredict_ratio"
     },
     {
-        "BriefDescription": "Instructions Per Cycle",
-        "MetricExpr": "INST_RETIRED.ANY / tma_info_clks",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_ipc"
+        "BriefDescription": "Ratio between Mispredicted branches and unkno=
wn branches",
+        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / BACLEARS.ANY",
+        "MetricName": "tma_info_inst_mix_branch_mispredict_to_unknown_bran=
ch_ratio"
+    },
+    {
+        "BriefDescription": "Percentage of all uops which are FPDiv uops",
+        "MetricExpr": "100 * UOPS_RETIRED.FPDIV / UOPS_RETIRED.ALL",
+        "MetricName": "tma_info_inst_mix_fpdiv_uop_ratio"
+    },
+    {
+        "BriefDescription": "Percentage of all uops which are IDiv uops",
+        "MetricExpr": "100 * UOPS_RETIRED.IDIV / UOPS_RETIRED.ALL",
+        "MetricName": "tma_info_inst_mix_idiv_uop_ratio"
+    },
+    {
+        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurance rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricName": "tma_info_inst_mix_ipbranch"
     },
     {
         "BriefDescription": "Instruction per (near) call (lower number mea=
ns higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.CALL",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_ipcall"
+        "MetricName": "tma_info_inst_mix_ipcall"
     },
     {
         "BriefDescription": "Instructions per Far Branch",
         "MetricExpr": "INST_RETIRED.ANY / (BR_INST_RETIRED.FAR_BRANCH / 2)=
",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_ipfarbranch"
+        "MetricName": "tma_info_inst_mix_ipfarbranch"
     },
     {
         "BriefDescription": "Instructions per Load",
         "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_LOADS",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_ipload"
+        "MetricName": "tma_info_inst_mix_ipload"
     },
     {
         "BriefDescription": "Instructions per retired conditional Branch M=
isprediction where the branch was not taken",
         "MetricExpr": "INST_RETIRED.ANY / (BR_MISP_RETIRED.COND - BR_MISP_=
RETIRED.COND_TAKEN)",
-        "MetricName": "tma_info_ipmisp_cond_ntaken"
+        "MetricName": "tma_info_inst_mix_ipmisp_cond_ntaken"
     },
     {
         "BriefDescription": "Instructions per retired conditional Branch M=
isprediction where the branch was taken",
         "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_TAKEN",
-        "MetricName": "tma_info_ipmisp_cond_taken"
+        "MetricName": "tma_info_inst_mix_ipmisp_cond_taken"
     },
     {
         "BriefDescription": "Instructions per retired indirect call or jum=
p Branch Misprediction",
         "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.INDIRECT",
-        "MetricName": "tma_info_ipmisp_indirect"
+        "MetricName": "tma_info_inst_mix_ipmisp_indirect"
     },
     {
         "BriefDescription": "Instructions per retired return Branch Mispre=
diction",
         "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.RETURN",
-        "MetricName": "tma_info_ipmisp_ret"
+        "MetricName": "tma_info_inst_mix_ipmisp_ret"
     },
     {
         "BriefDescription": "Instructions per retired Branch Misprediction=
",
         "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_ipmispredict"
+        "MetricName": "tma_info_inst_mix_ipmispredict"
     },
     {
         "BriefDescription": "Instructions per Store",
         "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_STORES",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_ipstore"
+        "MetricName": "tma_info_inst_mix_ipstore"
     },
     {
-        "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "cpu@CPU_CLK_UNHALTED.CORE@k / CPU_CLK_UNHALTED.CORE=
",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_kernel_utilization"
+        "BriefDescription": "Percentage of all uops which are ucode ops",
+        "MetricExpr": "100 * UOPS_RETIRED.MS / UOPS_RETIRED.ALL",
+        "MetricName": "tma_info_inst_mix_microcode_uop_ratio"
+    },
+    {
+        "BriefDescription": "Percentage of all uops which are x87 uops",
+        "MetricExpr": "100 * UOPS_RETIRED.X87 / UOPS_RETIRED.ALL",
+        "MetricName": "tma_info_inst_mix_x87_uop_ratio"
+    },
+    {
+        "BriefDescription": "Percentage of total non-speculative loads wit=
h a address aliasing block",
+        "MetricExpr": "100 * LD_BLOCKS.4K_ALIAS / MEM_UOPS_RETIRED.ALL_LOA=
DS",
+        "MetricName": "tma_info_l1_bound_address_alias_blocks"
     },
     {
         "BriefDescription": "Percentage of total non-speculative loads tha=
t are splits",
         "MetricExpr": "100 * MEM_UOPS_RETIRED.SPLIT_LOADS / MEM_UOPS_RETIR=
ED.ALL_LOADS",
-        "MetricName": "tma_info_load_splits"
+        "MetricName": "tma_info_l1_bound_load_splits"
     },
     {
-        "BriefDescription": "load ops retired per 1000 instruction",
-        "MetricExpr": "1e3 * MEM_UOPS_RETIRED.ALL_LOADS / INST_RETIRED.ANY=
",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_memloadpki"
+        "BriefDescription": "Percentage of total non-speculative loads wit=
h a store forward or unknown store address block",
+        "MetricExpr": "100 * LD_BLOCKS.DATA_UNKNOWN / MEM_UOPS_RETIRED.ALL=
_LOADS",
+        "MetricName": "tma_info_l1_bound_store_fwd_blocks"
     },
     {
-        "BriefDescription": "Percentage of all uops which are ucode ops",
-        "MetricExpr": "100 * UOPS_RETIRED.MS / UOPS_RETIRED.ALL",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_microcode_uop_ratio"
+        "BriefDescription": "Cycle cost per DRAM hit",
+        "MetricExpr": "MEM_BOUND_STALLS.LOAD_DRAM_HIT / MEM_LOAD_UOPS_RETI=
RED.DRAM_HIT",
+        "MetricName": "tma_info_memory_cycles_per_demand_load_dram_hit"
     },
     {
-        "BriefDescription": "",
-        "MetricExpr": "5 * tma_info_clks",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_slots"
+        "BriefDescription": "Cycle cost per L2 hit",
+        "MetricExpr": "MEM_BOUND_STALLS.LOAD_L2_HIT / MEM_LOAD_UOPS_RETIRE=
D.L2_HIT",
+        "MetricName": "tma_info_memory_cycles_per_demand_load_l2_hit"
     },
     {
-        "BriefDescription": "Percentage of total non-speculative loads wit=
h a store forward or unknown store address block",
-        "MetricExpr": "100 * LD_BLOCKS.DATA_UNKNOWN / MEM_UOPS_RETIRED.ALL=
_LOADS",
-        "MetricName": "tma_info_store_fwd_blocks"
+        "BriefDescription": "Cycle cost per LLC hit",
+        "MetricExpr": "MEM_BOUND_STALLS.LOAD_LLC_HIT / MEM_LOAD_UOPS_RETIR=
ED.L3_HIT",
+        "MetricName": "tma_info_memory_cycles_per_demand_load_l3_hit"
     },
     {
-        "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
-        "MetricExpr": "tma_info_clks / CPU_CLK_UNHALTED.REF_TSC",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_turbo_utilization"
+        "BriefDescription": "load ops retired per 1000 instruction",
+        "MetricExpr": "1e3 * MEM_UOPS_RETIRED.ALL_LOADS / INST_RETIRED.ANY=
",
+        "MetricName": "tma_info_memory_memloadpki"
     },
     {
-        "BriefDescription": "Uops Per Instruction",
-        "MetricExpr": "UOPS_RETIRED.ALL / INST_RETIRED.ANY",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_upi"
+        "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricName": "tma_info_system_cpu_utilization"
     },
     {
-        "BriefDescription": "Percentage of all uops which are x87 uops",
-        "MetricExpr": "100 * UOPS_RETIRED.X87 / UOPS_RETIRED.ALL",
-        "MetricGroup": " ",
-        "MetricName": "tma_info_x87_uop_ratio"
+        "BriefDescription": "Fraction of cycles spent in Kernel mode",
+        "MetricExpr": "cpu@CPU_CLK_UNHALTED.CORE@k / CPU_CLK_UNHALTED.CORE=
",
+        "MetricGroup": "Summary",
+        "MetricName": "tma_info_system_kernel_utilization"
+    },
+    {
+        "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
+        "MetricExpr": "tma_info_core_clks / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricGroup": "Power",
+        "MetricName": "tma_info_system_turbo_utilization"
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to Instruction Table Lookaside Buffer (ITL=
B) misses.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.ITLB / tma_info_slots",
+        "MetricExpr": "TOPDOWN_FE_BOUND.ITLB / tma_info_core_slots",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_latency_group",
         "MetricName": "tma_itlb_misses",
         "MetricThreshold": "tma_itlb_misses > 0.05",
@@ -471,7 +445,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a load block.",
-        "MetricExpr": "LD_HEAD.L1_BOUND_AT_RET / tma_info_clks",
+        "MetricExpr": "LD_HEAD.L1_BOUND_AT_RET / tma_info_core_clks",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
         "MetricName": "tma_l1_bound",
         "MetricThreshold": "tma_l1_bound > 0.1",
@@ -480,7 +454,7 @@
     {
         "BriefDescription": "Counts the number of cycles a core is stalled=
 due to a demand load which hit in the L2 Cache.",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_L2_HIT / tma_info_clks - max(=
(MEM_BOUND_STALLS.LOAD - LD_HEAD.L1_MISS_AT_RET) / tma_info_clks, 0) * MEM_=
BOUND_STALLS.LOAD_L2_HIT / MEM_BOUND_STALLS.LOAD",
+        "MetricExpr": "MEM_BOUND_STALLS.LOAD_L2_HIT / tma_info_core_clks -=
 max((MEM_BOUND_STALLS.LOAD - LD_HEAD.L1_MISS_AT_RET) / tma_info_core_clks,=
 0) * MEM_BOUND_STALLS.LOAD_L2_HIT / MEM_BOUND_STALLS.LOAD",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
         "MetricName": "tma_l2_bound",
         "MetricThreshold": "tma_l2_bound > 0.1",
@@ -488,7 +462,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles a core is stalled=
 due to a demand load which hit in the Last Level Cache (LLC) or other core=
 with HITE/F/M.",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_LLC_HIT / tma_info_clks - max=
((MEM_BOUND_STALLS.LOAD - LD_HEAD.L1_MISS_AT_RET) / tma_info_clks, 0) * MEM=
_BOUND_STALLS.LOAD_LLC_HIT / MEM_BOUND_STALLS.LOAD",
+        "MetricExpr": "MEM_BOUND_STALLS.LOAD_LLC_HIT / tma_info_core_clks =
- max((MEM_BOUND_STALLS.LOAD - LD_HEAD.L1_MISS_AT_RET) / tma_info_core_clks=
, 0) * MEM_BOUND_STALLS.LOAD_LLC_HIT / MEM_BOUND_STALLS.LOAD",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
         "MetricThreshold": "tma_l3_bound > 0.1",
@@ -504,7 +478,7 @@
     },
     {
         "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a mach=
ine clear (nuke) of any kind including memory ordering and memory disambigu=
ation.",
-        "MetricExpr": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS / tma_info_s=
lots",
+        "MetricExpr": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS / tma_info_c=
ore_slots",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
         "MetricName": "tma_machine_clears",
         "MetricThreshold": "tma_machine_clears > 0.05",
@@ -513,7 +487,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to memory reservation stalls in which a sche=
duler is not able to accept uops.",
-        "MetricExpr": "TOPDOWN_BE_BOUND.MEM_SCHEDULER / tma_info_slots",
+        "MetricExpr": "TOPDOWN_BE_BOUND.MEM_SCHEDULER / tma_info_core_slot=
s",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_mem_scheduler",
         "MetricThreshold": "tma_mem_scheduler > 0.1",
@@ -521,7 +495,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to stores or loads.",
-        "MetricExpr": "min(tma_backend_bound, LD_HEAD.ANY_AT_RET / tma_inf=
o_clks + tma_store_bound)",
+        "MetricExpr": "min(tma_backend_bound, LD_HEAD.ANY_AT_RET / tma_inf=
o_core_clks + tma_store_bound)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
         "MetricName": "tma_memory_bound",
         "MetricThreshold": "tma_memory_bound > 0.2",
@@ -538,7 +512,7 @@
     },
     {
         "BriefDescription": "Counts the number of uops that are from the c=
omplex flows issued by the micro-sequencer (MS)",
-        "MetricExpr": "UOPS_RETIRED.MS / tma_info_slots",
+        "MetricExpr": "UOPS_RETIRED.MS / tma_info_core_slots",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_retiring_group",
         "MetricName": "tma_ms_uops",
         "MetricThreshold": "tma_ms_uops > 0.05",
@@ -548,7 +522,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to IEC or FPC RAT stalls, which can be due t=
o FIQ or IEC reservation stalls in which the integer, floating point or SIM=
D scheduler is not able to accept uops.",
-        "MetricExpr": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER / tma_info_slots=
",
+        "MetricExpr": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER / tma_info_core_=
slots",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_non_mem_scheduler",
         "MetricThreshold": "tma_non_mem_scheduler > 0.1",
@@ -556,7 +530,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to a machine clear (slow nuke).",
-        "MetricExpr": "TOPDOWN_BAD_SPECULATION.NUKE / tma_info_slots",
+        "MetricExpr": "TOPDOWN_BAD_SPECULATION.NUKE / tma_info_core_slots"=
,
         "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
         "MetricName": "tma_nuke",
         "MetricThreshold": "tma_nuke > 0.05",
@@ -564,7 +538,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to other common frontend stalls not catego=
rized.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.OTHER / tma_info_slots",
+        "MetricExpr": "TOPDOWN_FE_BOUND.OTHER / tma_info_core_slots",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_bandwidth_group",
         "MetricName": "tma_other_fb",
         "MetricThreshold": "tma_other_fb > 0.05",
@@ -572,7 +546,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a number of other lo=
ad blocks.",
-        "MetricExpr": "LD_HEAD.OTHER_AT_RET / tma_info_clks",
+        "MetricExpr": "LD_HEAD.OTHER_AT_RET / tma_info_core_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_other_l1",
         "MetricThreshold": "tma_other_l1 > 0.05",
@@ -588,7 +562,7 @@
     },
     {
         "BriefDescription": "Counts the number of uops retired excluding m=
s and fp div uops.",
-        "MetricExpr": "(TOPDOWN_RETIRING.ALL - UOPS_RETIRED.MS - UOPS_RETI=
RED.FPDIV) / tma_info_slots",
+        "MetricExpr": "(TOPDOWN_RETIRING.ALL - UOPS_RETIRED.MS - UOPS_RETI=
RED.FPDIV) / tma_info_core_slots",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_base_group",
         "MetricName": "tma_other_ret",
         "MetricThreshold": "tma_other_ret > 0.3",
@@ -604,7 +578,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to wrong predecodes.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.PREDECODE / tma_info_slots",
+        "MetricExpr": "TOPDOWN_FE_BOUND.PREDECODE / tma_info_core_slots",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_bandwidth_group",
         "MetricName": "tma_predecode",
         "MetricThreshold": "tma_predecode > 0.05",
@@ -612,7 +586,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to the physical register file unable to acce=
pt an entry (marble stalls).",
-        "MetricExpr": "TOPDOWN_BE_BOUND.REGISTER / tma_info_slots",
+        "MetricExpr": "TOPDOWN_BE_BOUND.REGISTER / tma_info_core_slots",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_register",
         "MetricThreshold": "tma_register > 0.1",
@@ -620,7 +594,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to the reorder buffer being full (ROB stalls=
).",
-        "MetricExpr": "TOPDOWN_BE_BOUND.REORDER_BUFFER / tma_info_slots",
+        "MetricExpr": "TOPDOWN_BE_BOUND.REORDER_BUFFER / tma_info_core_slo=
ts",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_reorder_buffer",
         "MetricThreshold": "tma_reorder_buffer > 0.1",
@@ -638,7 +612,7 @@
     },
     {
         "BriefDescription": "Counts the numer of issue slots  that result =
in retirement slots.",
-        "MetricExpr": "TOPDOWN_RETIRING.ALL / tma_info_slots",
+        "MetricExpr": "TOPDOWN_RETIRING.ALL / tma_info_core_slots",
         "MetricGroup": "TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.75",
@@ -655,7 +629,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to scoreboards from the instruction queue (I=
Q), jump execution unit (JEU), or microcode sequencer (MS).",
-        "MetricExpr": "TOPDOWN_BE_BOUND.SERIALIZATION / tma_info_slots",
+        "MetricExpr": "TOPDOWN_BE_BOUND.SERIALIZATION / tma_info_core_slot=
s",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_serialization",
         "MetricThreshold": "tma_serialization > 0.1",
@@ -679,7 +653,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a first level TLB mi=
ss.",
-        "MetricExpr": "LD_HEAD.DTLB_MISS_AT_RET / tma_info_clks",
+        "MetricExpr": "LD_HEAD.DTLB_MISS_AT_RET / tma_info_core_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_stlb_hit",
         "MetricThreshold": "tma_stlb_hit > 0.05",
@@ -687,7 +661,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a second level TLB m=
iss requiring a page walk.",
-        "MetricExpr": "LD_HEAD.PGWALK_AT_RET / tma_info_clks",
+        "MetricExpr": "LD_HEAD.PGWALK_AT_RET / tma_info_core_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_stlb_miss",
         "MetricThreshold": "tma_stlb_miss > 0.05",
@@ -703,7 +677,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a store forward bloc=
k.",
-        "MetricExpr": "LD_HEAD.ST_ADDR_AT_RET / tma_info_clks",
+        "MetricExpr": "LD_HEAD.ST_ADDR_AT_RET / tma_info_core_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_store_fwd_blk",
         "MetricThreshold": "tma_store_fwd_blk > 0.05",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 66c37a3cbf43..c8d564f6091d 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,6 +1,6 @@
 Family-model,Version,Filename,EventType
-GenuineIntel-6-(97|9A|B7|BA|BF),v1.20,alderlake,core
-GenuineIntel-6-BE,v1.20,alderlaken,core
+GenuineIntel-6-(97|9A|B7|BA|BF),v1.21,alderlake,core
+GenuineIntel-6-BE,v1.21,alderlaken,core
 GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
 GenuineIntel-6-(3D|47),v27,broadwell,core
 GenuineIntel-6-56,v9,broadwellde,core
--=20
2.40.1.606.ga4b1b128d6-goog

