Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C716F706CD4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjEQP2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjEQP1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:27:36 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6015D1999
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:27:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba81b37d9d2so1502609276.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684337229; x=1686929229;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=scERHn4KAKqjFXkfza/rfdMuUcGsv0Oj7wkhKQwhvWI=;
        b=XqMhxDl+SA8mN4eWxHkhSei7QZ9yGC/TQJmYNQCDcuBR85eZU5/rvPHj5qs3hAmPCM
         /QMeK2nP9ZoPrjzyay4wT1hYIzw3NW4DWtR0VvngkDi5fOB6JaYGiVxxUJqGe2/lRdck
         ENmVTeKvf6aLYUAfFjjB/IzzGdELZh5f2K44NixUrg9HDAzve9mcAXQYaJEW1O5qC79u
         m+b8NHGZHvc4yRh20UApmkxxXes5nWFEjuBQSkWjQbatZnn1xIZflwDbZQh+eBGEhLhG
         0grxFdTF7Ht0wHGxO540vu84wzUFXInCf+J5Nzoqwr5+wKPxH1oL6NGi7O/1d+t4oaHe
         lLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684337229; x=1686929229;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=scERHn4KAKqjFXkfza/rfdMuUcGsv0Oj7wkhKQwhvWI=;
        b=jfsBKr2ICWZDHmy5mu6RVt2BiBDVqVom64zq+RmtSyDpA3PKVGnZ8gWOKqXM/Owy3/
         T5tzxLzw5xraUVY1joJxJ0VsMlEvqd9Zbtt7kz6phCwEnuBU28YvhOqCY70yS2SyuEcJ
         u7NqciVrkU2lfRslNdZgpCXlkQwaD4YVQGBVroU0TC/zJK2sTJjcftyob42hyZM8OQmh
         9iKST57RVXBmxG2qpeghUUNY99Mexmzwwy/UBYk3fR89zCw5W3aZZ/3IoMTJUsdjqe4Y
         VyElmRwF+pEQ/h/hvkoW9Zfv9RLHqSOjhlIBM8+6YjOI/TjZQBnzxFIObrq6blc7bocC
         C5Iw==
X-Gm-Message-State: AC+VfDzf/GQCiJc4RVTwx0CB2hafZyVL2e5Z08SiTRie745zf6yeyWbL
        otMPcY3lQ1/TWBeAQYBLz9NMvMKfLOJV
X-Google-Smtp-Source: ACHHUZ7Hk2bExAlIH41Efu12n1FH0DZ9ROUTCPk7cpiD+qwIhyARZO9LMj6oUpUO4zHHNL6539m6CYi8CxlS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:628b:7e78:d09b:39b])
 (user=irogers job=sendgmr) by 2002:a25:67c2:0:b0:ba8:13d6:3bc0 with SMTP id
 b185-20020a2567c2000000b00ba813d63bc0mr2963167ybc.6.1684337229422; Wed, 17
 May 2023 08:27:09 -0700 (PDT)
Date:   Wed, 17 May 2023 08:26:22 -0700
In-Reply-To: <20230517152626.563559-1-irogers@google.com>
Message-Id: <20230517152626.563559-12-irogers@google.com>
Mime-Version: 1.0
References: <20230517152626.563559-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v2 11/15] perf vendor events intel: Update skylake/skylakex events/metrics
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

Update skylake events to v60 and skylakex events to v1.30, adding the
events FP_ARITH_INST_RETIRED.4_FLOPS, FP_ARITH_INST_RETIRED.8_FLOPS,
FP_ARITH_INST_RETIRED.SCALAR, FP_ARITH_INST_RETIRED.VECTOR and
INT_MISC.CLEARS_COUNT. Metrics are updated to make TMA info metric
names synchronized. Events and metrics were generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |    4 +-
 .../arch/x86/skylake/floating-point.json      |    8 +
 .../pmu-events/arch/x86/skylake/pipeline.json |   15 +-
 .../arch/x86/skylake/skl-metrics.json         |  875 ++++++------
 .../arch/x86/skylakex/floating-point.json     |   31 +
 .../arch/x86/skylakex/pipeline.json           |   23 +-
 .../arch/x86/skylakex/skx-metrics.json        | 1183 ++++++++++-------
 7 files changed, 1219 insertions(+), 920 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 59afd27feb1d..4731a92af9f9 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -26,8 +26,8 @@ GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-(8F|CF),v1.13,sapphirerapids,core
 GenuineIntel-6-AF,v1.00,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
-GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v55,skylake,core
-GenuineIntel-6-55-[01234],v1.29,skylakex,core
+GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v56,skylake,core
+GenuineIntel-6-55-[01234],v1.30,skylakex,core
 GenuineIntel-6-86,v1.20,snowridgex,core
 GenuineIntel-6-8[CD],v1.10,tigerlake,core
 GenuineIntel-6-2C,v4,westmereep-dp,core
diff --git a/tools/perf/pmu-events/arch/x86/skylake/floating-point.json b/t=
ools/perf/pmu-events/arch/x86/skylake/floating-point.json
index 4d494a5cabbf..5891bd74af60 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/floating-point.json
@@ -31,6 +31,14 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x20"
     },
+    {
+        "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d single and 256-bit packed double precision FP instructions retired; some =
instructions will count twice as noted below.  Each count represents 2 or/a=
nd 4 computation operations, 1 for each element.  Applies to SSE* and AVX* =
packed single precision and packed double precision FP instructions: ADD SU=
B HADD HSUB SUBADD MUL DIV MIN MAX RCP14 RSQRT14 SQRT DPP FM(N)ADD/SUB.  DP=
P and FM(N)ADD/SUB count twice as they perform 2 calculations per element."=
,
+        "EventCode": "0xC7",
+        "EventName": "FP_ARITH_INST_RETIRED.4_FLOPS",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision and 256-bit packed double precision  floating-point ins=
tructions retired; some instructions will count twice as noted below.  Each=
 count represents 2 or/and 4 computation operations, one for each element. =
 Applies to SSE* and AVX* packed single precision floating-point and packed=
 double precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL=
 DIV MIN MAX RCP14 RSQRT14 SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB ins=
tructions count twice as they perform 2 calculations per element. The DAZ a=
nd FTZ flags in the MXCSR register need to be set when using these events."=
,
+        "SampleAfterValue": "1000003",
+        "UMask": "0x18"
+    },
     {
         "BriefDescription": "Counts once for most SIMD scalar computationa=
l floating-point instructions retired. Counts twice for DPP and FM(N)ADD/SU=
B instructions retired.",
         "EventCode": "0xC7",
diff --git a/tools/perf/pmu-events/arch/x86/skylake/pipeline.json b/tools/p=
erf/pmu-events/arch/x86/skylake/pipeline.json
index 2dfc3af08eff..cc800fb8180a 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/pipeline.json
@@ -26,12 +26,21 @@
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "Conditional branch instructions retired.",
+        "BriefDescription": "Conditional branch instructions retired. [Thi=
s event is alias to BR_INST_RETIRED.CONDITIONAL]",
+        "Errata": "SKL091",
+        "EventCode": "0xC4",
+        "EventName": "BR_INST_RETIRED.COND",
+        "PublicDescription": "This event counts conditional branch instruc=
tions retired. [This event is alias to BR_INST_RETIRED.CONDITIONAL]",
+        "SampleAfterValue": "400009",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Conditional branch instructions retired. [Thi=
s event is alias to BR_INST_RETIRED.COND]",
         "Errata": "SKL091",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.CONDITIONAL",
         "PEBS": "1",
-        "PublicDescription": "This event counts conditional branch instruc=
tions retired.",
+        "PublicDescription": "This event counts conditional branch instruc=
tions retired. [This event is alias to BR_INST_RETIRED.COND]",
         "SampleAfterValue": "400009",
         "UMask": "0x1"
     },
@@ -405,9 +414,9 @@
         "UMask": "0x1"
     },
     {
-        "AnyThread": "1",
         "BriefDescription": "Clears speculative count",
         "CounterMask": "1",
+        "EdgeDetect": "1",
         "EventCode": "0x0D",
         "EventName": "INT_MISC.CLEARS_COUNT",
         "PublicDescription": "Counts the number of speculative clears due =
to any type of branch misprediction or machine clears",
diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tool=
s/perf/pmu-events/arch/x86/skylake/skl-metrics.json
index 21ef6c9be816..2ed88842b880 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
@@ -50,7 +50,7 @@
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
@@ -71,7 +71,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often memory load a=
ccesses were aliased by preceding stores (in program order) with a 4K addre=
ss offset",
-        "MetricExpr": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS / tma_info_clks",
+        "MetricExpr": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS / tma_info_thread_c=
lks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_4k_aliasing",
         "MetricThreshold": "tma_4k_aliasing > 0.2 & (tma_l1_bound > 0.1 & =
(tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -80,7 +80,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
-        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_0 + UOPS_DISPATCHED_PORT=
.PORT_1 + UOPS_DISPATCHED_PORT.PORT_5 + UOPS_DISPATCHED_PORT.PORT_6) / tma_=
info_slots",
+        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_0 + UOPS_DISPATCHED_PORT=
.PORT_1 + UOPS_DISPATCHED_PORT.PORT_5 + UOPS_DISPATCHED_PORT.PORT_6) / tma_=
info_thread_slots",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_alu_op_utilization",
         "MetricThreshold": "tma_alu_op_utilization > 0.6",
@@ -88,7 +88,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops delivered by the Microcode_Sequencer as a result of Assists=
",
-        "MetricExpr": "100 * (FP_ASSIST.ANY + OTHER_ASSISTS.ANY) / tma_inf=
o_slots",
+        "MetricExpr": "100 * (FP_ASSIST.ANY + OTHER_ASSISTS.ANY) / tma_inf=
o_thread_slots",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
         "MetricName": "tma_assists",
         "MetricThreshold": "tma_assists > 0.1 & (tma_microcode_sequencer >=
 0.05 & tma_heavy_operations > 0.1)",
@@ -97,7 +97,7 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
-        "MetricExpr": "1 - tma_frontend_bound - (UOPS_ISSUED.ANY + 4 * (IN=
T_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)) /=
 tma_info_slots",
+        "MetricExpr": "1 - tma_frontend_bound - (UOPS_ISSUED.ANY + 4 * (IN=
T_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)) /=
 tma_info_thread_slots",
         "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
@@ -107,7 +107,7 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
-        "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * =
(INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)=
) / tma_info_slots",
+        "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * =
(INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)=
) / tma_info_thread_slots",
         "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
@@ -123,12 +123,12 @@
         "MetricName": "tma_branch_mispredicts",
         "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specula=
tion > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics:=
 tma_info_branch_misprediction_cost, tma_info_mispredictions, tma_mispredic=
ts_resteers",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics:=
 tma_info_bad_spec_branch_misprediction_cost, tma_info_bottleneck_mispredic=
tions, tma_mispredicts_resteers",
         "ScaleUnit": "100%"
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
@@ -146,7 +146,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Machine Clears",
-        "MetricExpr": "(1 - BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRE=
D.ALL_BRANCHES + MACHINE_CLEARS.COUNT)) * INT_MISC.CLEAR_RESTEER_CYCLES / t=
ma_info_clks",
+        "MetricExpr": "(1 - BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRE=
D.ALL_BRANCHES + MACHINE_CLEARS.COUNT)) * INT_MISC.CLEAR_RESTEER_CYCLES / t=
ma_info_thread_clks",
         "MetricGroup": "BadSpec;MachineClears;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group;tma_issueMC",
         "MetricName": "tma_clears_resteers",
         "MetricThreshold": "tma_clears_resteers > 0.05 & (tma_branch_reste=
ers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
@@ -156,7 +156,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(18.5 * tma_info_average_frequency * MEM_LOAD_L3_HI=
T_RETIRED.XSNP_HITM + 16.5 * tma_info_average_frequency * MEM_LOAD_L3_HIT_R=
ETIRED.XSNP_MISS) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS=
 / 2) / tma_info_clks",
+        "MetricExpr": "(18.5 * tma_info_system_average_frequency * MEM_LOA=
D_L3_HIT_RETIRED.XSNP_HITM + 16.5 * tma_info_system_average_frequency * MEM=
_LOAD_L3_HIT_RETIRED.XSNP_MISS) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_R=
ETIRED.L1_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_l3_bound_group",
         "MetricName": "tma_contested_accesses",
         "MetricThreshold": "tma_contested_accesses > 0.05 & (tma_l3_bound =
> 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -177,7 +177,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "16.5 * tma_info_average_frequency * MEM_LOAD_L3_HIT=
_RETIRED.XSNP_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS=
 / 2) / tma_info_clks",
+        "MetricExpr": "16.5 * tma_info_system_average_frequency * MEM_LOAD=
_L3_HIT_RETIRED.XSNP_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.=
L1_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "Offcore;Snoop;TopdownL4;tma_L4_group;tma_issueSync=
xn;tma_l3_bound_group",
         "MetricName": "tma_data_sharing",
         "MetricThreshold": "tma_data_sharing > 0.05 & (tma_l3_bound > 0.05=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -186,16 +186,16 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re decoder-0 was the only active decoder",
-        "MetricExpr": "(cpu@INST_DECODED.DECODERS\\,cmask\\=3D1@ - cpu@INS=
T_DECODED.DECODERS\\,cmask\\=3D2@) / tma_info_core_clks / 2",
+        "MetricExpr": "(cpu@INST_DECODED.DECODERS\\,cmask\\=3D1@ - cpu@INS=
T_DECODED.DECODERS\\,cmask\\=3D2@) / tma_info_core_core_clks / 2",
         "MetricGroup": "DSBmiss;FetchBW;TopdownL4;tma_L4_group;tma_issueD0=
;tma_mite_group",
         "MetricName": "tma_decoder0_alone",
-        "MetricThreshold": "tma_decoder0_alone > 0.1 & (tma_mite > 0.1 & (=
tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_ipc / 4 > =
0.35))",
+        "MetricThreshold": "tma_decoder0_alone > 0.1 & (tma_mite > 0.1 & (=
tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_thread_ipc=
 / 4 > 0.35))",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere decoder-0 was the only active decoder. Related metrics: tma_few_uops_in=
structions",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re the Divider unit was active",
-        "MetricExpr": "ARITH.DIVIDER_ACTIVE / tma_info_clks",
+        "MetricExpr": "ARITH.DIVIDER_ACTIVE / tma_info_thread_clks",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_core_bound_group",
         "MetricName": "tma_divider",
         "MetricThreshold": "tma_divider > 0.2 & (tma_core_bound > 0.1 & tm=
a_backend_bound > 0.2)",
@@ -205,7 +205,7 @@
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "CYCLE_ACTIVITY.STALLS_L3_MISS / tma_info_clks + (CY=
CLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_info_cl=
ks - tma_l2_bound",
+        "MetricExpr": "CYCLE_ACTIVITY.STALLS_L3_MISS / tma_info_thread_clk=
s + (CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_=
info_thread_clks - tma_l2_bound",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_dram_bound",
         "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2)",
@@ -214,45 +214,45 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to DSB (decoded uop cache) fetch pipe=
line",
-        "MetricExpr": "(IDQ.ALL_DSB_CYCLES_ANY_UOPS - IDQ.ALL_DSB_CYCLES_4=
_UOPS) / tma_info_core_clks / 2",
+        "MetricExpr": "(IDQ.ALL_DSB_CYCLES_ANY_UOPS - IDQ.ALL_DSB_CYCLES_4=
_UOPS) / tma_info_core_core_clks / 2",
         "MetricGroup": "DSB;FetchBW;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
         "MetricName": "tma_dsb",
-        "MetricThreshold": "tma_dsb > 0.15 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_ipc / 4 > 0.35)",
+        "MetricThreshold": "tma_dsb > 0.15 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_thread_ipc / 4 > 0.35)",
         "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here.",
         "ScaleUnit": "100%"
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
-        "MetricExpr": "min(9 * cpu@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\\=3D1=
@ + DTLB_LOAD_MISSES.WALK_ACTIVE, max(CYCLE_ACTIVITY.CYCLES_MEM_ANY - CYCLE=
_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_clks",
+        "MetricExpr": "min(9 * cpu@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\\=3D1=
@ + DTLB_LOAD_MISSES.WALK_ACTIVE, max(CYCLE_ACTIVITY.CYCLES_MEM_ANY - CYCLE=
_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
-        "MetricExpr": "(9 * cpu@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=3D1@ =
+ DTLB_STORE_MISSES.WALK_ACTIVE) / tma_info_core_clks",
+        "MetricExpr": "(9 * cpu@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=3D1@ =
+ DTLB_STORE_MISSES.WALK_ACTIVE) / tma_info_core_core_clks",
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "22 * tma_info_average_frequency * OFFCORE_RESPONSE.=
DEMAND_RFO.L3_HIT.SNOOP_HITM / tma_info_clks",
+        "MetricExpr": "22 * tma_info_system_average_frequency * OFFCORE_RE=
SPONSE.DEMAND_RFO.L3_HIT.SNOOP_HITM / tma_info_thread_clks",
         "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_store_bound_group",
         "MetricName": "tma_false_sharing",
         "MetricThreshold": "tma_false_sharing > 0.05 & (tma_store_bound > =
0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -262,11 +262,11 @@
     {
         "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
-        "MetricExpr": "tma_info_load_miss_real_latency * cpu@L1D_PEND_MISS=
.FB_FULL\\,cmask\\=3D1@ / tma_info_clks",
+        "MetricExpr": "tma_info_memory_load_miss_real_latency * cpu@L1D_PE=
ND_MISS.FB_FULL\\,cmask\\=3D1@ / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
@@ -274,14 +274,14 @@
         "MetricExpr": "tma_frontend_bound - tma_fetch_latency",
         "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_=
frontend_bound_group;tma_issueFB",
         "MetricName": "tma_fetch_bandwidth",
-        "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound=
 > 0.15 & tma_info_ipc / 4 > 0.35",
+        "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound=
 > 0.15 & tma_info_thread_ipc / 4 > 0.35",
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues",
-        "MetricExpr": "4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE=
 / tma_info_slots",
+        "MetricExpr": "4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE=
 / tma_info_thread_slots",
         "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend=
_bound_group",
         "MetricName": "tma_fetch_latency",
         "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound >=
 0.15",
@@ -347,7 +347,7 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_slots",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_thread_slots=
",
         "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
@@ -366,7 +366,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or micro-coded sequences",
-        "MetricExpr": "(UOPS_RETIRED.RETIRE_SLOTS + UOPS_RETIRED.MACRO_FUS=
ED - INST_RETIRED.ANY) / tma_info_slots",
+        "MetricExpr": "(UOPS_RETIRED.RETIRE_SLOTS + UOPS_RETIRED.MACRO_FUS=
ED - INST_RETIRED.ANY) / tma_info_thread_slots",
         "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_g=
roup",
         "MetricName": "tma_heavy_operations",
         "MetricThreshold": "tma_heavy_operations > 0.1",
@@ -376,7 +376,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses",
-        "MetricExpr": "(ICACHE_16B.IFDATA_STALL + 2 * cpu@ICACHE_16B.IFDAT=
A_STALL\\,cmask\\=3D1\\,edge@) / tma_info_clks",
+        "MetricExpr": "(ICACHE_16B.IFDATA_STALL + 2 * cpu@ICACHE_16B.IFDAT=
A_STALL\\,cmask\\=3D1\\,edge@) / tma_info_thread_clks",
         "MetricGroup": "BigFoot;FetchLat;IcMiss;TopdownL3;tma_L3_group;tma=
_fetch_latency_group",
         "MetricName": "tma_icache_misses",
         "MetricThreshold": "tma_icache_misses > 0.05 & (tma_fetch_latency =
> 0.1 & tma_frontend_bound > 0.15)",
@@ -384,220 +384,231 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Measured Average Frequency for unhalted proce=
ssors [GHz]",
-        "MetricExpr": "tma_info_turbo_utilization * TSC / 1e9 / duration_t=
ime",
-        "MetricGroup": "Power;Summary",
-        "MetricName": "tma_info_average_frequency"
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
+        "MetricExpr": "(tma_branch_mispredicts + tma_fetch_latency * tma_m=
ispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icache_=
misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) * tma_info_thread_sl=
ots / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;BrMispredicts;tma_issueBM",
+        "MetricName": "tma_info_bad_spec_branch_misprediction_cost",
+        "PublicDescription": "Branch Misprediction Cost: Fraction of TMA s=
lots wasted per non-speculative branch misprediction (retired JEClear). Rel=
ated metrics: tma_branch_mispredicts, tma_info_bottleneck_mispredictions, t=
ma_mispredicts_resteers"
+    },
+    {
+        "BriefDescription": "Instructions per retired mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
+        "MetricExpr": "tma_info_inst_mix_instructions / (UOPS_RETIRED.RETI=
RE_SLOTS / UOPS_ISSUED.ANY * cpu@BR_MISP_EXEC.ALL_BRANCHES\\,umask\\=3D0xE4=
@)",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "tma_info_bad_spec_ipmisp_indirect",
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1e3"
+    },
+    {
+        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts",
+        "MetricName": "tma_info_bad_spec_ipmispredict",
+        "MetricThreshold": "tma_info_bad_spec_ipmispredict < 200"
+    },
+    {
+        "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(100 * (1 - tma_core_bound / tma_ports_utilization =
if tma_core_bound < tma_ports_utilization else 1) if tma_info_system_smt_2t=
_utilization > 0.5 else 0)",
+        "MetricGroup": "Cor;SMT",
+        "MetricName": "tma_info_botlnk_l0_core_bound_likely",
+        "MetricThreshold": "tma_info_botlnk_l0_core_bound_likely > 0.5"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + =
tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb + tm=
a_mite))",
+        "MetricGroup": "DSBmiss;Fed;tma_issueFB",
+        "MetricName": "tma_info_botlnk_l2_dsb_misses",
+        "MetricThreshold": "tma_info_botlnk_l2_dsb_misses > 10",
+        "PublicDescription": "Total pipeline cost of DSB (uop cache) misse=
s - subset of the Instruction_Fetch_BW Bottleneck. Related metrics: tma_dsb=
_switches, tma_fetch_bandwidth, tma_info_frontend_dsb_coverage, tma_info_in=
st_mix_iptb, tma_lcp"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses +=
 tma_lcp + tma_ms_switches))",
+        "MetricGroup": "Fed;FetchLat;IcMiss;tma_issueFL",
+        "MetricName": "tma_info_botlnk_l2_ic_misses",
+        "MetricThreshold": "tma_info_botlnk_l2_ic_misses > 5",
+        "PublicDescription": "Total pipeline cost of Instruction Cache mis=
ses - subset of the Big_Code Bottleneck. Related metrics: "
     },
     {
         "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_branch_resteers + tma_dsb_switch=
es + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)",
         "MetricGroup": "BigFoot;Fed;Frontend;IcMiss;MemoryTLB;tma_issueBC"=
,
-        "MetricName": "tma_info_big_code",
-        "MetricThreshold": "tma_info_big_code > 20",
-        "PublicDescription": "Total pipeline cost of instruction fetch rel=
ated bottlenecks by large code footprint programs (i-side cache; TLB and BT=
B misses). Related metrics: tma_info_branching_overhead"
+        "MetricName": "tma_info_bottleneck_big_code",
+        "MetricThreshold": "tma_info_bottleneck_big_code > 20",
+        "PublicDescription": "Total pipeline cost of instruction fetch rel=
ated bottlenecks by large code footprint programs (i-side cache; TLB and BT=
B misses). Related metrics: tma_info_bottleneck_branching_overhead"
     },
     {
-        "BriefDescription": "Branch instructions per taken branch.",
-        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
-        "MetricGroup": "Branches;Fed;PGO",
-        "MetricName": "tma_info_bptkbranch"
+        "BriefDescription": "Total pipeline cost of branch related instruc=
tions (used for program control-flow including function calls)",
+        "MetricExpr": "100 * ((BR_INST_RETIRED.CONDITIONAL + 3 * BR_INST_R=
ETIRED.NEAR_CALL + (BR_INST_RETIRED.NEAR_TAKEN - (BR_INST_RETIRED.CONDITION=
AL - BR_INST_RETIRED.NOT_TAKEN) - 2 * BR_INST_RETIRED.NEAR_CALL)) / tma_inf=
o_thread_slots)",
+        "MetricGroup": "Ret;tma_issueBC",
+        "MetricName": "tma_info_bottleneck_branching_overhead",
+        "MetricThreshold": "tma_info_bottleneck_branching_overhead > 10",
+        "PublicDescription": "Total pipeline cost of branch related instru=
ctions (used for program control-flow including function calls). Related me=
trics: tma_info_bottleneck_big_code"
     },
     {
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
-        "MetricExpr": "(tma_branch_mispredicts + tma_fetch_latency * tma_m=
ispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icache_=
misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) * tma_info_slots / B=
R_MISP_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;BrMispredicts;tma_issueBM",
-        "MetricName": "tma_info_branch_misprediction_cost",
-        "PublicDescription": "Branch Misprediction Cost: Fraction of TMA s=
lots wasted per non-speculative branch misprediction (retired JEClear). Rel=
ated metrics: tma_branch_mispredicts, tma_info_mispredictions, tma_mispredi=
cts_resteers"
+        "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "100 * (tma_frontend_bound - tma_fetch_latency * tma=
_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icach=
e_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) - tma_info_bottlen=
eck_big_code",
+        "MetricGroup": "Fed;FetchBW;Frontend",
+        "MetricName": "tma_info_bottleneck_instruction_fetch_bw",
+        "MetricThreshold": "tma_info_bottleneck_instruction_fetch_bw > 20"
     },
     {
-        "BriefDescription": "Total pipeline cost of branch related instruc=
tions (used for program control-flow including function calls)",
-        "MetricExpr": "100 * ((BR_INST_RETIRED.CONDITIONAL + 3 * BR_INST_R=
ETIRED.NEAR_CALL + (BR_INST_RETIRED.NEAR_TAKEN - (BR_INST_RETIRED.CONDITION=
AL - BR_INST_RETIRED.NOT_TAKEN) - 2 * BR_INST_RETIRED.NEAR_CALL)) / tma_inf=
o_slots)",
-        "MetricGroup": "Ret;tma_issueBC",
-        "MetricName": "tma_info_branching_overhead",
-        "MetricThreshold": "tma_info_branching_overhead > 10",
-        "PublicDescription": "Total pipeline cost of branch related instru=
ctions (used for program control-flow including function calls). Related me=
trics: tma_info_big_code"
+        "BriefDescription": "Total pipeline cost of (external) Memory Band=
width related bottlenecks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (=
tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_l3_bound /=
 (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_b=
ound) * (tma_sq_full / (tma_contested_accesses + tma_data_sharing + tma_l3_=
hit_latency + tma_sq_full))) + tma_l1_bound / (tma_dram_bound + tma_l1_boun=
d + tma_l2_bound + tma_l3_bound + tma_store_bound) * (tma_fb_full / (tma_4k=
_aliasing + tma_dtlb_load + tma_fb_full + tma_lock_latency + tma_split_load=
s + tma_store_fwd_blk))",
+        "MetricGroup": "Mem;MemoryBW;Offcore;tma_issueBW",
+        "MetricName": "tma_info_bottleneck_memory_bandwidth",
+        "MetricThreshold": "tma_info_bottleneck_memory_bandwidth > 20",
+        "PublicDescription": "Total pipeline cost of (external) Memory Ban=
dwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_system_d=
ram_bw_use, tma_mem_bandwidth, tma_sq_full"
     },
     {
-        "BriefDescription": "Fraction of branches that are CALL or RET",
-        "MetricExpr": "(BR_INST_RETIRED.NEAR_CALL + BR_INST_RETIRED.NEAR_R=
ETURN) / BR_INST_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;Branches",
-        "MetricName": "tma_info_callret"
+        "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "100 * tma_memory_bound * (tma_l1_bound / max(tma_me=
mory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + t=
ma_store_bound) * (tma_dtlb_load / max(tma_l1_bound, tma_4k_aliasing + tma_=
dtlb_load + tma_fb_full + tma_lock_latency + tma_split_loads + tma_store_fw=
d_blk)) + tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound +=
 tma_l3_bound + tma_store_bound) * (tma_dtlb_store / (tma_dtlb_store + tma_=
false_sharing + tma_split_stores + tma_store_latency)))",
+        "MetricGroup": "Mem;MemoryTLB;Offcore;tma_issueTLB",
+        "MetricName": "tma_info_bottleneck_memory_data_tlbs",
+        "MetricThreshold": "tma_info_bottleneck_memory_data_tlbs > 20",
+        "PublicDescription": "Total pipeline cost of Memory Address Transl=
ation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_load,=
 tma_dtlb_store"
     },
     {
-        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "Pipeline",
-        "MetricName": "tma_info_clks"
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
3_hit_latency, tma_mem_latency"
     },
     {
-        "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
-        "MetricExpr": "1e3 * ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.ANY=
",
-        "MetricGroup": "Fed;MemoryTLB",
-        "MetricName": "tma_info_code_stlb_mpki"
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
spec_branch_misprediction_cost, tma_mispredicts_resteers"
+    },
+    {
+        "BriefDescription": "Fraction of branches that are CALL or RET",
+        "MetricExpr": "(BR_INST_RETIRED.NEAR_CALL + BR_INST_RETIRED.NEAR_R=
ETURN) / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;Branches",
+        "MetricName": "tma_info_branches_callret"
     },
     {
         "BriefDescription": "Fraction of branches that are non-taken condi=
tionals",
         "MetricExpr": "BR_INST_RETIRED.NOT_TAKEN / BR_INST_RETIRED.ALL_BRA=
NCHES",
         "MetricGroup": "Bad;Branches;CodeGen;PGO",
-        "MetricName": "tma_info_cond_nt"
+        "MetricName": "tma_info_branches_cond_nt"
     },
     {
         "BriefDescription": "Fraction of branches that are taken condition=
als",
         "MetricExpr": "(BR_INST_RETIRED.CONDITIONAL - BR_INST_RETIRED.NOT_=
TAKEN) / BR_INST_RETIRED.ALL_BRANCHES",
         "MetricGroup": "Bad;Branches;CodeGen;PGO",
-        "MetricName": "tma_info_cond_tk"
+        "MetricName": "tma_info_branches_cond_tk"
     },
     {
-        "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
+        "BriefDescription": "Fraction of branches that are unconditional (=
direct or indirect) jumps",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(100 * (1 - tma_core_bound / tma_ports_utilization =
if tma_core_bound < tma_ports_utilization else 1) if tma_info_smt_2t_utiliz=
ation > 0.5 else 0)",
-        "MetricGroup": "Cor;SMT",
-        "MetricName": "tma_info_core_bound_likely",
-        "MetricThreshold": "tma_info_core_bound_likely > 0.5"
+        "MetricExpr": "(BR_INST_RETIRED.NEAR_TAKEN - (BR_INST_RETIRED.COND=
ITIONAL - BR_INST_RETIRED.NOT_TAKEN) - 2 * BR_INST_RETIRED.NEAR_CALL) / BR_=
INST_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;Branches",
+        "MetricName": "tma_info_branches_jump"
     },
     {
         "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
-        "MetricExpr": "(CPU_CLK_UNHALTED.THREAD / 2 * (1 + CPU_CLK_UNHALTE=
D.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK) if #core_wide < 1 else (CP=
U_CLK_UNHALTED.THREAD_ANY / 2 if #SMT_on else tma_info_clks))",
+        "MetricExpr": "(CPU_CLK_UNHALTED.THREAD / 2 * (1 + CPU_CLK_UNHALTE=
D.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK) if #core_wide < 1 else (CP=
U_CLK_UNHALTED.THREAD_ANY / 2 if #SMT_on else tma_info_thread_clks))",
         "MetricGroup": "SMT",
-        "MetricName": "tma_info_core_clks"
+        "MetricName": "tma_info_core_core_clks"
     },
     {
         "BriefDescription": "Instructions Per Cycle across hyper-threads (=
per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / tma_info_core_clks",
+        "MetricExpr": "INST_RETIRED.ANY / tma_info_core_core_clks",
         "MetricGroup": "Ret;SMT;TmaL1;tma_L1_group",
-        "MetricName": "tma_info_coreipc"
+        "MetricName": "tma_info_core_coreipc"
     },
     {
-        "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
-        "MetricExpr": "1 / tma_info_ipc",
-        "MetricGroup": "Mem;Pipeline",
-        "MetricName": "tma_info_cpi"
-    },
-    {
-        "BriefDescription": "Average CPU Utilization",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
-        "MetricGroup": "HPC;Summary",
-        "MetricName": "tma_info_cpu_utilization"
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 =
* (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PA=
CKED_DOUBLE) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) / tma_info_cor=
e_core_clks",
+        "MetricGroup": "Flops;Ret",
+        "MetricName": "tma_info_core_flopc"
     },
     {
-        "BriefDescription": "Average Parallel L2 cache miss data reads",
-        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD / OFFCORE_=
REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
-        "MetricGroup": "Memory_BW;Offcore",
-        "MetricName": "tma_info_data_l2_mlp"
+        "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
+        "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\,umask\\=3D0x3c@) =
/ (2 * tma_info_core_core_clks)",
+        "MetricGroup": "Cor;Flops;HPC",
+        "MetricName": "tma_info_core_fp_arith_utilization",
+        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)."
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
ndwidth, tma_mem_bandwidth, tma_sq_full"
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
+        "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
+        "MetricName": "tma_info_core_ilp"
     },
     {
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
         "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + IDQ.MITE_UOPS + IDQ.=
MS_UOPS)",
         "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
-        "MetricName": "tma_info_dsb_coverage",
-        "MetricThreshold": "tma_info_dsb_coverage < 0.7 & tma_info_ipc / 4=
 > 0.35",
-        "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_dsb_misses, tma_info_iptb, tma_lcp"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + =
tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb + tm=
a_mite))",
-        "MetricGroup": "DSBmiss;Fed;tma_issueFB",
-        "MetricName": "tma_info_dsb_misses",
-        "MetricThreshold": "tma_info_dsb_misses > 10",
-        "PublicDescription": "Total pipeline cost of DSB (uop cache) misse=
s - subset of the Instruction_Fetch_BW Bottleneck. Related metrics: tma_dsb=
_switches, tma_fetch_bandwidth, tma_info_dsb_coverage, tma_info_iptb, tma_l=
cp"
+        "MetricName": "tma_info_frontend_dsb_coverage",
+        "MetricThreshold": "tma_info_frontend_dsb_coverage < 0.7 & tma_inf=
o_thread_ipc / 4 > 0.35",
+        "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_inst_mix_iptb, tma_lcp"
     },
     {
         "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
.",
         "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / DSB2MITE_SWITCHE=
S.COUNT",
         "MetricGroup": "DSBmiss",
-        "MetricName": "tma_info_dsb_switch_cost"
-    },
-    {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-thread",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D1@",
-        "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
-        "MetricName": "tma_info_execute"
-    },
-    {
-        "BriefDescription": "The ratio of Executed- by Issued-Uops",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / UOPS_ISSUED.ANY",
-        "MetricGroup": "Cor;Pipeline",
-        "MetricName": "tma_info_execute_per_issue",
-        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage."
-    },
-    {
-        "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
-        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.FB_HIT / INST_RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_fb_hpki"
+        "MetricName": "tma_info_frontend_dsb_switch_cost"
     },
     {
         "BriefDescription": "Average number of Uops issued by front-end wh=
en it issued something",
         "MetricExpr": "UOPS_ISSUED.ANY / cpu@UOPS_ISSUED.ANY\\,cmask\\=3D1=
@",
         "MetricGroup": "Fed;FetchBW",
-        "MetricName": "tma_info_fetch_upc"
+        "MetricName": "tma_info_frontend_fetch_upc"
     },
     {
-        "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 =
* (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PA=
CKED_DOUBLE) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) / tma_info_cor=
e_clks",
-        "MetricGroup": "Flops;Ret",
-        "MetricName": "tma_info_flopc"
-    },
-    {
-        "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\,umask\\=3D0x3c@) =
/ (2 * tma_info_core_clks)",
-        "MetricGroup": "Cor;Flops;HPC",
-        "MetricName": "tma_info_fp_arith_utilization",
-        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)."
+        "BriefDescription": "Average Latency for L1 instruction cache miss=
es",
+        "MetricExpr": "ICACHE_16B.IFDATA_STALL / cpu@ICACHE_16B.IFDATA_STA=
LL\\,cmask\\=3D1\\,edge@ + 2",
+        "MetricGroup": "Fed;FetchLat;IcMiss",
+        "MetricName": "tma_info_frontend_icache_miss_latency"
     },
     {
-        "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 =
* (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PA=
CKED_DOUBLE) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) / 1e9 / durati=
on_time",
-        "MetricGroup": "Cor;Flops;HPC",
-        "MetricName": "tma_info_gflops",
-        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine."
+        "BriefDescription": "Instructions per non-speculative DSB miss (lo=
wer number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / FRONTEND_RETIRED.ANY_DSB_MISS",
+        "MetricGroup": "DSBmiss;Fed",
+        "MetricName": "tma_info_frontend_ipdsb_miss_ret",
+        "MetricThreshold": "tma_info_frontend_ipdsb_miss_ret < 50"
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
ses - subset of the Big_Code Bottleneck. Related metrics: "
+        "BriefDescription": "Instructions per speculative Unknown Branch M=
isprediction (BAClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "tma_info_inst_mix_instructions / BACLEARS.ANY",
+        "MetricGroup": "Fed",
+        "MetricName": "tma_info_frontend_ipunknown_branch"
     },
     {
-        "BriefDescription": "Average Latency for L1 instruction cache miss=
es",
-        "MetricExpr": "ICACHE_16B.IFDATA_STALL / cpu@ICACHE_16B.IFDATA_STA=
LL\\,cmask\\=3D1\\,edge@ + 2",
-        "MetricGroup": "Fed;FetchLat;IcMiss",
-        "MetricName": "tma_info_icache_miss_latency"
+        "BriefDescription": "L2 cache true code cacheline misses per kilo =
instruction",
+        "MetricExpr": "1e3 * FRONTEND_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "IcMiss",
+        "MetricName": "tma_info_frontend_l2mpki_code"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
-        "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
-        "MetricName": "tma_info_ilp"
+        "BriefDescription": "L2 cache speculative code cacheline misses pe=
r kilo instruction",
+        "MetricExpr": "1e3 * L2_RQSTS.CODE_RD_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "IcMiss",
+        "MetricName": "tma_info_frontend_l2mpki_code_all"
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
-        "MetricThreshold": "tma_info_instruction_fetch_bw > 20"
+        "BriefDescription": "Branch instructions per taken branch.",
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
+        "MetricGroup": "Branches;Fed;PGO",
+        "MetricName": "tma_info_inst_mix_bptkbranch"
     },
     {
         "BriefDescription": "Total number of retired Instructions",
         "MetricExpr": "INST_RETIRED.ANY",
         "MetricGroup": "Summary;TmaL1;tma_L1_group",
-        "MetricName": "tma_info_instructions",
+        "MetricName": "tma_info_inst_mix_instructions",
         "PublicDescription": "Total number of retired Instructions. Sample=
 with: INST_RETIRED.PREC_DIST"
     },
     {
@@ -605,416 +616,404 @@
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "INST_RETIRED.ANY / (cpu@FP_ARITH_INST_RETIRED.SCALA=
R_SINGLE\\,umask\\=3D0x03@ + cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\=
,umask\\=3D0x3c@)",
         "MetricGroup": "Flops;InsType",
-        "MetricName": "tma_info_iparith",
-        "MetricThreshold": "tma_info_iparith < 10",
+        "MetricName": "tma_info_inst_mix_iparith",
+        "MetricThreshold": "tma_info_inst_mix_iparith < 10",
         "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). May undercount due to FMA doubl=
e counting. Approximated prior to BDW."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-bi=
t instruction (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.128B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE)",
         "MetricGroup": "Flops;FpVector;InsType",
-        "MetricName": "tma_info_iparith_avx128",
-        "MetricThreshold": "tma_info_iparith_avx128 < 10",
+        "MetricName": "tma_info_inst_mix_iparith_avx128",
+        "MetricThreshold": "tma_info_inst_mix_iparith_avx128 < 10",
         "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). May undercount =
due to FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX* 256-bit i=
nstruction (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.256B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE)",
         "MetricGroup": "Flops;FpVector;InsType",
-        "MetricName": "tma_info_iparith_avx256",
-        "MetricThreshold": "tma_info_iparith_avx256 < 10",
+        "MetricName": "tma_info_inst_mix_iparith_avx256",
+        "MetricThreshold": "tma_info_inst_mix_iparith_avx256 < 10",
         "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). May undercount due=
 to FMA double counting."
     },
     {
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
ercount due to FMA double counting."
     },
     {
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
ercount due to FMA double counting."
     },
     {
         "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
         "MetricGroup": "Branches;Fed;InsType",
-        "MetricName": "tma_info_ipbranch",
-        "MetricThreshold": "tma_info_ipbranch < 8"
-    },
-    {
-        "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
-        "MetricExpr": "INST_RETIRED.ANY / tma_info_clks",
-        "MetricGroup": "Ret;Summary",
-        "MetricName": "tma_info_ipc"
+        "MetricName": "tma_info_inst_mix_ipbranch",
+        "MetricThreshold": "tma_info_inst_mix_ipbranch < 8"
     },
     {
         "BriefDescription": "Instructions per (near) call (lower number me=
ans higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
         "MetricGroup": "Branches;Fed;PGO",
-        "MetricName": "tma_info_ipcall",
-        "MetricThreshold": "tma_info_ipcall < 200"
-    },
-    {
-        "BriefDescription": "Instructions per non-speculative DSB miss (lo=
wer number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / FRONTEND_RETIRED.ANY_DSB_MISS",
-        "MetricGroup": "DSBmiss;Fed",
-        "MetricName": "tma_info_ipdsb_miss_ret",
-        "MetricThreshold": "tma_info_ipdsb_miss_ret < 50"
-    },
-    {
-        "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
-        "MetricGroup": "Branches;OS",
-        "MetricName": "tma_info_ipfarbranch",
-        "MetricThreshold": "tma_info_ipfarbranch < 1e6"
+        "MetricName": "tma_info_inst_mix_ipcall",
+        "MetricThreshold": "tma_info_inst_mix_ipcall < 200"
     },
     {
         "BriefDescription": "Instructions per Floating Point (FP) Operatio=
n (lower number means higher occurrence rate)",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR_SI=
NGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE + 2 * FP_ARITH_INST_RETIRED.128B=
_PACKED_DOUBLE + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_I=
NST_RETIRED.256B_PACKED_DOUBLE) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SIN=
GLE)",
         "MetricGroup": "Flops;InsType",
-        "MetricName": "tma_info_ipflop",
-        "MetricThreshold": "tma_info_ipflop < 10"
+        "MetricName": "tma_info_inst_mix_ipflop",
+        "MetricThreshold": "tma_info_inst_mix_ipflop < 10"
     },
     {
         "BriefDescription": "Instructions per Load (lower number means hig=
her occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_LOADS",
         "MetricGroup": "InsType",
-        "MetricName": "tma_info_ipload",
-        "MetricThreshold": "tma_info_ipload < 3"
-    },
-    {
-        "BriefDescription": "Instructions per retired mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
-        "MetricExpr": "tma_info_instructions / (UOPS_RETIRED.RETIRE_SLOTS =
/ UOPS_ISSUED.ANY * cpu@BR_MISP_EXEC.ALL_BRANCHES\\,umask\\=3D0xE4@)",
-        "MetricGroup": "Bad;BrMispredicts",
-        "MetricName": "tma_info_ipmisp_indirect",
-        "MetricThreshold": "tma_info_ipmisp_indirect < 1e3"
-    },
-    {
-        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;BadSpec;BrMispredicts",
-        "MetricName": "tma_info_ipmispredict",
-        "MetricThreshold": "tma_info_ipmispredict < 200"
+        "MetricName": "tma_info_inst_mix_ipload",
+        "MetricThreshold": "tma_info_inst_mix_ipload < 3"
     },
     {
         "BriefDescription": "Instructions per Store (lower number means hi=
gher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_STORES",
         "MetricGroup": "InsType",
-        "MetricName": "tma_info_ipstore",
-        "MetricThreshold": "tma_info_ipstore < 8"
+        "MetricName": "tma_info_inst_mix_ipstore",
+        "MetricThreshold": "tma_info_inst_mix_ipstore < 8"
     },
     {
         "BriefDescription": "Instructions per Software prefetch instructio=
n (of any type: NTA/T0/T1/T2/Prefetch) (lower number means higher occurrenc=
e rate)",
         "MetricExpr": "INST_RETIRED.ANY / cpu@SW_PREFETCH_ACCESS.T0\\,umas=
k\\=3D0xF@",
         "MetricGroup": "Prefetches",
-        "MetricName": "tma_info_ipswpf",
-        "MetricThreshold": "tma_info_ipswpf < 100"
+        "MetricName": "tma_info_inst_mix_ipswpf",
+        "MetricThreshold": "tma_info_inst_mix_ipswpf < 100"
     },
     {
         "BriefDescription": "Instruction per taken branch",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
         "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO;tma_issueFB",
-        "MetricName": "tma_info_iptb",
-        "MetricThreshold": "tma_info_iptb < 9",
-        "PublicDescription": "Instruction per taken branch. Related metric=
s: tma_dsb_switches, tma_fetch_bandwidth, tma_info_dsb_coverage, tma_info_d=
sb_misses, tma_lcp"
-    },
-    {
-        "BriefDescription": "Instructions per speculative Unknown Branch M=
isprediction (BAClear) (lower number means higher occurrence rate)",
-        "MetricExpr": "tma_info_instructions / BACLEARS.ANY",
-        "MetricGroup": "Fed",
-        "MetricName": "tma_info_ipunknown_branch"
+        "MetricName": "tma_info_inst_mix_iptb",
+        "MetricThreshold": "tma_info_inst_mix_iptb < 9",
+        "PublicDescription": "Instruction per taken branch. Related metric=
s: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_misses, tm=
a_info_frontend_dsb_coverage, tma_lcp"
     },
     {
-        "BriefDescription": "Fraction of branches that are unconditional (=
direct or indirect) jumps",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(BR_INST_RETIRED.NEAR_TAKEN - (BR_INST_RETIRED.COND=
ITIONAL - BR_INST_RETIRED.NOT_TAKEN) - 2 * BR_INST_RETIRED.NEAR_CALL) / BR_=
INST_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;Branches",
-        "MetricName": "tma_info_jump"
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / duration_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_core_l1d_cache_fill_bw"
     },
     {
-        "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
-        "MetricGroup": "OS",
-        "MetricName": "tma_info_kernel_cpi"
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / duration_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_core_l2_cache_fill_bw"
     },
     {
-        "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.THRE=
AD",
-        "MetricGroup": "OS",
-        "MetricName": "tma_info_kernel_utilization",
-        "MetricThreshold": "tma_info_kernel_utilization > 0.05"
+        "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
+        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1e9 / duration=
_time",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "tma_info_memory_core_l3_cache_access_bw"
     },
     {
-        "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / duration_time",
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / duration_time",
         "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l1d_cache_fill_bw"
+        "MetricName": "tma_info_memory_core_l3_cache_fill_bw"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
-        "MetricExpr": "tma_info_l1d_cache_fill_bw",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l1d_cache_fill_bw_1t"
+        "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
+        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.FB_HIT / INST_RETIRED.ANY",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "tma_info_memory_fb_hpki"
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY",
         "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l1mpki"
+        "MetricName": "tma_info_memory_l1mpki"
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 all demand loads (including speculative)",
         "MetricExpr": "1e3 * L2_RQSTS.ALL_DEMAND_DATA_RD / INST_RETIRED.AN=
Y",
         "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l1mpki_load"
-    },
-    {
-        "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / duration_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l2_cache_fill_bw"
-    },
-    {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
-        "MetricExpr": "tma_info_l2_cache_fill_bw",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l2_cache_fill_bw_1t"
+        "MetricName": "tma_info_memory_l1mpki_load"
     },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all re=
quest types (including speculative)",
         "MetricExpr": "1e3 * (L2_RQSTS.REFERENCES - L2_RQSTS.MISS) / INST_=
RETIRED.ANY",
         "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l2hpki_all"
+        "MetricName": "tma_info_memory_l2hpki_all"
     },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all de=
mand loads  (including speculative)",
         "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_HIT / INST_RETIRED.AN=
Y",
         "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l2hpki_load"
+        "MetricName": "tma_info_memory_l2hpki_load"
     },
     {
         "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
         "MetricGroup": "Backend;CacheMisses;Mem",
-        "MetricName": "tma_info_l2mpki"
+        "MetricName": "tma_info_memory_l2mpki"
     },
     {
         "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all request types (including speculative)",
         "MetricExpr": "1e3 * L2_RQSTS.MISS / INST_RETIRED.ANY",
         "MetricGroup": "CacheMisses;Mem;Offcore",
-        "MetricName": "tma_info_l2mpki_all"
-    },
-    {
-        "BriefDescription": "L2 cache true code cacheline misses per kilo =
instruction",
-        "MetricExpr": "1e3 * FRONTEND_RETIRED.L2_MISS / INST_RETIRED.ANY",
-        "MetricGroup": "IcMiss",
-        "MetricName": "tma_info_l2mpki_code"
-    },
-    {
-        "BriefDescription": "L2 cache speculative code cacheline misses pe=
r kilo instruction",
-        "MetricExpr": "1e3 * L2_RQSTS.CODE_RD_MISS / INST_RETIRED.ANY",
-        "MetricGroup": "IcMiss",
-        "MetricName": "tma_info_l2mpki_code_all"
+        "MetricName": "tma_info_memory_l2mpki_all"
     },
     {
         "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all demand loads  (including speculative)",
         "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_MISS / INST_RETIRED.A=
NY",
         "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l2mpki_load"
-    },
-    {
-        "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1e9 / duration=
_time",
-        "MetricGroup": "Mem;MemoryBW;Offcore",
-        "MetricName": "tma_info_l3_cache_access_bw"
+        "MetricName": "tma_info_memory_l2mpki_load"
     },
     {
-        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
-        "MetricExpr": "tma_info_l3_cache_access_bw",
-        "MetricGroup": "Mem;MemoryBW;Offcore",
-        "MetricName": "tma_info_l3_cache_access_bw_1t"
+        "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "tma_info_memory_l3mpki"
     },
     {
-        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / duration_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l3_cache_fill_bw"
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / (MEM_LOAD_RETIRED.L1_MISS +=
 MEM_LOAD_RETIRED.FB_HIT)",
+        "MetricGroup": "Mem;MemoryBound;MemoryLat",
+        "MetricName": "tma_info_memory_load_miss_real_latency"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "tma_info_l3_cache_fill_bw",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l3_cache_fill_bw_1t"
+        "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLE=
S",
+        "MetricGroup": "Mem;MemoryBW;MemoryBound",
+        "MetricName": "tma_info_memory_mlp",
+        "PublicDescription": "Memory-Level-Parallelism (average number of =
L1 miss demand load when there is at least one such miss. Per-Logical Proce=
ssor)"
     },
     {
-        "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l3mpki"
+        "BriefDescription": "Average Parallel L2 cache miss data reads",
+        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD / OFFCORE_=
REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
+        "MetricGroup": "Memory_BW;Offcore",
+        "MetricName": "tma_info_memory_oro_data_l2_mlp"
     },
     {
         "BriefDescription": "Average Latency for L2 cache miss demand Load=
s",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS.DEMAND_DATA_RD",
         "MetricGroup": "Memory_Lat;Offcore",
-        "MetricName": "tma_info_load_l2_miss_latency"
+        "MetricName": "tma_info_memory_oro_load_l2_miss_latency"
     },
     {
         "BriefDescription": "Average Parallel L2 cache miss demand Loads",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_DATA_RD",
         "MetricGroup": "Memory_BW;Offcore",
-        "MetricName": "tma_info_load_l2_mlp"
+        "MetricName": "tma_info_memory_oro_load_l2_mlp"
     },
     {
-        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / (MEM_LOAD_RETIRED.L1_MISS +=
 MEM_LOAD_RETIRED.FB_HIT)",
-        "MetricGroup": "Mem;MemoryBound;MemoryLat",
-        "MetricName": "tma_info_load_miss_real_latency"
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_core_l1d_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_thread_l1d_cache_fill_bw_1t"
+    },
+    {
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_core_l2_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_thread_l2_cache_fill_bw_1t"
+    },
+    {
+        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_core_l3_cache_access_bw",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "tma_info_memory_thread_l3_cache_access_bw_1t"
+    },
+    {
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_core_l3_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_thread_l3_cache_fill_bw_1t"
+    },
+    {
+        "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
+        "MetricExpr": "1e3 * ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.ANY=
",
+        "MetricGroup": "Fed;MemoryTLB",
+        "MetricName": "tma_info_memory_tlb_code_stlb_mpki"
     },
     {
         "BriefDescription": "STLB (2nd level TLB) data load speculative mi=
sses per kilo instruction (misses of any page-size that complete the page w=
alk)",
         "MetricExpr": "1e3 * DTLB_LOAD_MISSES.WALK_COMPLETED / INST_RETIRE=
D.ANY",
         "MetricGroup": "Mem;MemoryTLB",
-        "MetricName": "tma_info_load_stlb_mpki"
+        "MetricName": "tma_info_memory_tlb_load_stlb_mpki"
+    },
+    {
+        "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
+        "MetricExpr": "(ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_P=
ENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING) / (2 * tma_info=
_core_core_clks)",
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_tlb_page_walks_utilization",
+        "MetricThreshold": "tma_info_memory_tlb_page_walks_utilization > 0=
.5"
+    },
+    {
+        "BriefDescription": "STLB (2nd level TLB) data store speculative m=
isses per kilo instruction (misses of any page-size that complete the page =
walk)",
+        "MetricExpr": "1e3 * DTLB_STORE_MISSES.WALK_COMPLETED / INST_RETIR=
ED.ANY",
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_tlb_store_stlb_mpki"
+    },
+    {
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-thread",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D1@",
+        "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
+        "MetricName": "tma_info_pipeline_execute"
+    },
+    {
+        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / cpu@UOPS_RETIRED.RETIRE=
_SLOTS\\,cmask\\=3D1@",
+        "MetricGroup": "Pipeline;Ret",
+        "MetricName": "tma_info_pipeline_retire"
+    },
+    {
+        "BriefDescription": "Measured Average Frequency for unhalted proce=
ssors [GHz]",
+        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / dur=
ation_time",
+        "MetricGroup": "Power;Summary",
+        "MetricName": "tma_info_system_average_frequency"
+    },
+    {
+        "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricGroup": "HPC;Summary",
+        "MetricName": "tma_info_system_cpu_utilization"
+    },
+    {
+        "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
+        "MetricExpr": "64 * (UNC_ARB_TRK_REQUESTS.ALL + UNC_ARB_COH_TRK_RE=
QUESTS.ALL) / 1e6 / duration_time / 1e3",
+        "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
+        "MetricName": "tma_info_system_dram_bw_use",
+        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_fb_full, tma_info_bottlenec=
k_memory_bandwidth, tma_mem_bandwidth, tma_sq_full"
+    },
+    {
+        "BriefDescription": "Giga Floating Point Operations Per Second",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 =
* (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PA=
CKED_DOUBLE) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) / 1e9 / durati=
on_time",
+        "MetricGroup": "Cor;Flops;HPC",
+        "MetricName": "tma_info_system_gflops",
+        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine."
+    },
+    {
+        "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
+        "MetricGroup": "Branches;OS",
+        "MetricName": "tma_info_system_ipfarbranch",
+        "MetricThreshold": "tma_info_system_ipfarbranch < 1e6"
+    },
+    {
+        "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
+        "MetricGroup": "OS",
+        "MetricName": "tma_info_system_kernel_cpi"
+    },
+    {
+        "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.THRE=
AD",
+        "MetricGroup": "OS",
+        "MetricName": "tma_info_system_kernel_utilization",
+        "MetricThreshold": "tma_info_system_kernel_utilization > 0.05"
     },
     {
         "BriefDescription": "Average number of parallel data read requests=
 to external memory",
         "MetricExpr": "UNC_ARB_TRK_OCCUPANCY.DATA_READ / UNC_ARB_TRK_OCCUP=
ANCY.DATA_READ@thresh\\=3D1@",
         "MetricGroup": "Mem;MemoryBW;SoC",
-        "MetricName": "tma_info_mem_parallel_reads",
+        "MetricName": "tma_info_system_mem_parallel_reads",
         "PublicDescription": "Average number of parallel data read request=
s to external memory. Accounts for demand loads and L1/L2 prefetches"
     },
     {
         "BriefDescription": "Average number of parallel requests to extern=
al memory",
         "MetricExpr": "UNC_ARB_TRK_OCCUPANCY.ALL / UNC_ARB_TRK_OCCUPANCY.C=
YCLES_WITH_ANY_REQUEST",
         "MetricGroup": "Mem;SoC",
-        "MetricName": "tma_info_mem_parallel_requests",
+        "MetricName": "tma_info_system_mem_parallel_requests",
         "PublicDescription": "Average number of parallel requests to exter=
nal memory. Accounts for all requests"
     },
     {
         "BriefDescription": "Average latency of data read request to exter=
nal memory (in nanoseconds)",
-        "MetricExpr": "1e9 * (UNC_ARB_TRK_OCCUPANCY.DATA_READ / UNC_ARB_TR=
K_REQUESTS.DATA_READ) / (tma_info_socket_clks / duration_time)",
+        "MetricExpr": "1e9 * (UNC_ARB_TRK_OCCUPANCY.DATA_READ / UNC_ARB_TR=
K_REQUESTS.DATA_READ) / (tma_info_system_socket_clks / duration_time)",
         "MetricGroup": "Mem;MemoryLat;SoC",
-        "MetricName": "tma_info_mem_read_latency",
+        "MetricName": "tma_info_system_mem_read_latency",
         "PublicDescription": "Average latency of data read request to exte=
rnal memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetche=
s. ([RKL+]memory-controller only)"
     },
     {
         "BriefDescription": "Average latency of all requests to external m=
emory (in Uncore cycles)",
         "MetricExpr": "UNC_ARB_TRK_OCCUPANCY.ALL / UNC_ARB_TRK_REQUESTS.AL=
L",
         "MetricGroup": "Mem;SoC",
-        "MetricName": "tma_info_mem_request_latency"
+        "MetricName": "tma_info_system_mem_request_latency"
     },
     {
-        "BriefDescription": "Total pipeline cost of (external) Memory Band=
width related bottlenecks",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (=
tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_l3_bound /=
 (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_b=
ound) * (tma_sq_full / (tma_contested_accesses + tma_data_sharing + tma_l3_=
hit_latency + tma_sq_full))) + tma_l1_bound / (tma_dram_bound + tma_l1_boun=
d + tma_l2_bound + tma_l3_bound + tma_store_bound) * (tma_fb_full / (tma_4k=
_aliasing + tma_dtlb_load + tma_fb_full + tma_lock_latency + tma_split_load=
s + tma_store_fwd_blk))",
-        "MetricGroup": "Mem;MemoryBW;Offcore;tma_issueBW",
-        "MetricName": "tma_info_memory_bandwidth",
-        "MetricThreshold": "tma_info_memory_bandwidth > 20",
-        "PublicDescription": "Total pipeline cost of (external) Memory Ban=
dwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_dram_bw_=
use, tma_mem_bandwidth, tma_sq_full"
+        "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
+        "MetricExpr": "(1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / (CPU_CLK_=
UNHALTED.REF_XCLK_ANY / 2) if #SMT_on else 0)",
+        "MetricGroup": "SMT",
+        "MetricName": "tma_info_system_smt_2t_utilization"
     },
     {
-        "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * tma_memory_bound * (tma_l1_bound / max(tma_me=
mory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + t=
ma_store_bound) * (tma_dtlb_load / max(tma_l1_bound, tma_4k_aliasing + tma_=
dtlb_load + tma_fb_full + tma_lock_latency + tma_split_loads + tma_store_fw=
d_blk)) + tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound +=
 tma_l3_bound + tma_store_bound) * (tma_dtlb_store / (tma_dtlb_store + tma_=
false_sharing + tma_split_stores + tma_store_latency)))",
-        "MetricGroup": "Mem;MemoryTLB;Offcore;tma_issueTLB",
-        "MetricName": "tma_info_memory_data_tlbs",
-        "MetricThreshold": "tma_info_memory_data_tlbs > 20",
-        "PublicDescription": "Total pipeline cost of Memory Address Transl=
ation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_load,=
 tma_dtlb_store"
+        "BriefDescription": "Socket actual clocks when any core is active =
on that socket",
+        "MetricExpr": "UNC_CLOCK.SOCKET",
+        "MetricGroup": "SoC",
+        "MetricName": "tma_info_system_socket_clks"
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
3_hit_latency, tma_mem_latency"
+        "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
+        "MetricExpr": "tma_info_thread_clks / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricGroup": "Power",
+        "MetricName": "tma_info_system_turbo_utilization"
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
ch_misprediction_cost, tma_mispredicts_resteers"
+        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "Pipeline",
+        "MetricName": "tma_info_thread_clks"
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
ssor)"
+        "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
+        "MetricExpr": "1 / tma_info_thread_ipc",
+        "MetricGroup": "Mem;Pipeline",
+        "MetricName": "tma_info_thread_cpi"
     },
     {
-        "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
-        "MetricExpr": "(ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_P=
ENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING) / (2 * tma_info=
_core_clks)",
-        "MetricGroup": "Mem;MemoryTLB",
-        "MetricName": "tma_info_page_walks_utilization",
-        "MetricThreshold": "tma_info_page_walks_utilization > 0.5"
+        "BriefDescription": "The ratio of Executed- by Issued-Uops",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / UOPS_ISSUED.ANY",
+        "MetricGroup": "Cor;Pipeline",
+        "MetricName": "tma_info_thread_execute_per_issue",
+        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage."
     },
     {
-        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / cpu@UOPS_RETIRED.RETIRE=
_SLOTS\\,cmask\\=3D1@",
-        "MetricGroup": "Pipeline;Ret",
-        "MetricName": "tma_info_retire"
+        "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
+        "MetricExpr": "INST_RETIRED.ANY / tma_info_thread_clks",
+        "MetricGroup": "Ret;Summary",
+        "MetricName": "tma_info_thread_ipc"
     },
     {
         "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
-        "MetricExpr": "4 * tma_info_core_clks",
+        "MetricExpr": "4 * tma_info_core_core_clks",
         "MetricGroup": "TmaL1;tma_L1_group",
-        "MetricName": "tma_info_slots"
-    },
-    {
-        "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
-        "MetricExpr": "(1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / (CPU_CLK_=
UNHALTED.REF_XCLK_ANY / 2) if #SMT_on else 0)",
-        "MetricGroup": "SMT",
-        "MetricName": "tma_info_smt_2t_utilization"
-    },
-    {
-        "BriefDescription": "Socket actual clocks when any core is active =
on that socket",
-        "MetricExpr": "UNC_CLOCK.SOCKET",
-        "MetricGroup": "SoC",
-        "MetricName": "tma_info_socket_clks"
-    },
-    {
-        "BriefDescription": "STLB (2nd level TLB) data store speculative m=
isses per kilo instruction (misses of any page-size that complete the page =
walk)",
-        "MetricExpr": "1e3 * DTLB_STORE_MISSES.WALK_COMPLETED / INST_RETIR=
ED.ANY",
-        "MetricGroup": "Mem;MemoryTLB",
-        "MetricName": "tma_info_store_stlb_mpki"
-    },
-    {
-        "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
-        "MetricExpr": "tma_info_clks / CPU_CLK_UNHALTED.REF_TSC",
-        "MetricGroup": "Power",
-        "MetricName": "tma_info_turbo_utilization"
+        "MetricName": "tma_info_thread_slots"
     },
     {
         "BriefDescription": "Uops Per Instruction",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
         "MetricGroup": "Pipeline;Ret;Retire",
-        "MetricName": "tma_info_uoppi",
-        "MetricThreshold": "tma_info_uoppi > 1.05"
+        "MetricName": "tma_info_thread_uoppi",
+        "MetricThreshold": "tma_info_thread_uoppi > 1.05"
     },
     {
         "BriefDescription": "Instruction per taken branch",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / BR_INST_RETIRED.NEAR_TA=
KEN",
         "MetricGroup": "Branches;Fed;FetchBW",
-        "MetricName": "tma_info_uptb",
-        "MetricThreshold": "tma_info_uptb < 6"
+        "MetricName": "tma_info_thread_uptb",
+        "MetricThreshold": "tma_info_thread_uptb < 6"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
-        "MetricExpr": "ICACHE_64B.IFTAG_STALL / tma_info_clks",
+        "MetricExpr": "ICACHE_64B.IFTAG_STALL / tma_info_thread_clks",
         "MetricGroup": "BigFoot;FetchLat;MemoryTLB;TopdownL3;tma_L3_group;=
tma_fetch_latency_group",
         "MetricName": "tma_itlb_misses",
         "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
@@ -1023,7 +1022,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache",
-        "MetricExpr": "max((CYCLE_ACTIVITY.STALLS_MEM_ANY - CYCLE_ACTIVITY=
.STALLS_L1D_MISS) / tma_info_clks, 0)",
+        "MetricExpr": "max((CYCLE_ACTIVITY.STALLS_MEM_ANY - CYCLE_ACTIVITY=
.STALLS_L1D_MISS) / tma_info_thread_clks, 0)",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_issueL1;tma_issueMC;tma_memory_bound_group",
         "MetricName": "tma_l1_bound",
         "MetricThreshold": "tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2)",
@@ -1033,7 +1032,7 @@
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "MEM_LOAD_RETIRED.L2_HIT * (1 + MEM_LOAD_RETIRED.FB_=
HIT / MEM_LOAD_RETIRED.L1_MISS) / (MEM_LOAD_RETIRED.L2_HIT * (1 + MEM_LOAD_=
RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + cpu@L1D_PEND_MISS.FB_FULL\\,cm=
ask\\=3D1@) * ((CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_M=
ISS) / tma_info_clks)",
+        "MetricExpr": "MEM_LOAD_RETIRED.L2_HIT * (1 + MEM_LOAD_RETIRED.FB_=
HIT / MEM_LOAD_RETIRED.L1_MISS) / (MEM_LOAD_RETIRED.L2_HIT * (1 + MEM_LOAD_=
RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + cpu@L1D_PEND_MISS.FB_FULL\\,cm=
ask\\=3D1@) * ((CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_M=
ISS) / tma_info_thread_clks)",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
         "MetricName": "tma_l2_bound",
         "MetricThreshold": "tma_l2_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
@@ -1042,7 +1041,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
-        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L2_MISS - CYCLE_ACTIVITY.STA=
LLS_L3_MISS) / tma_info_clks",
+        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L2_MISS - CYCLE_ACTIVITY.STA=
LLS_L3_MISS) / tma_info_thread_clks",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
         "MetricThreshold": "tma_l3_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
@@ -1051,20 +1050,20 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited)",
-        "MetricExpr": "6.5 * tma_info_average_frequency * MEM_LOAD_RETIRED=
.L3_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tm=
a_info_clks",
+        "MetricExpr": "6.5 * tma_info_system_average_frequency * MEM_LOAD_=
RETIRED.L3_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / =
2) / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 was stalled due to Length Changing Prefixes (LCPs)",
-        "MetricExpr": "ILD_STALL.LCP / tma_info_clks",
+        "MetricExpr": "ILD_STALL.LCP / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
@@ -1079,7 +1078,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Load operations",
-        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_2 + UOPS_DISPATCHED_PORT=
.PORT_3 + UOPS_DISPATCHED_PORT.PORT_7 - UOPS_DISPATCHED_PORT.PORT_4) / (2 *=
 tma_info_core_clks)",
+        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_2 + UOPS_DISPATCHED_PORT=
.PORT_3 + UOPS_DISPATCHED_PORT.PORT_7 - UOPS_DISPATCHED_PORT.PORT_4) / (2 *=
 tma_info_core_core_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_load_op_utilization",
         "MetricThreshold": "tma_load_op_utilization > 0.6",
@@ -1097,7 +1096,7 @@
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
@@ -1105,7 +1104,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
-        "MetricExpr": "(12 * max(0, MEM_INST_RETIRED.LOCK_LOADS - L2_RQSTS=
.ALL_RFO) + MEM_INST_RETIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES * (9 =
* L2_RQSTS.RFO_HIT + min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTAND=
ING.CYCLES_WITH_DEMAND_RFO))) / tma_info_clks",
+        "MetricExpr": "(12 * max(0, MEM_INST_RETIRED.LOCK_LOADS - L2_RQSTS=
.ALL_RFO) + MEM_INST_RETIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES * (9 =
* L2_RQSTS.RFO_HIT + min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTAND=
ING.CYCLES_WITH_DEMAND_RFO))) / tma_info_thread_clks",
         "MetricGroup": "Offcore;TopdownL4;tma_L4_group;tma_issueRFO;tma_l1=
_bound_group",
         "MetricName": "tma_lock_latency",
         "MetricThreshold": "tma_lock_latency > 0.2 & (tma_l1_bound > 0.1 &=
 (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -1125,20 +1124,20 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory (DRAM)",
-        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_clks",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the performance was likely hurt due to latency from external memory (DRAM=
)",
-        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DATA_RD) / tma_info_clks - tma_mem_bandwidth",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DATA_RD) / tma_info_thread_clks - tma_mem_bandwidth",
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
         "ScaleUnit": "100%"
     },
     {
@@ -1162,7 +1161,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU was retiring uops fetched by the Microcode Sequencer (MS) unit",
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / UOPS_ISSUED.ANY * IDQ.M=
S_UOPS / tma_info_slots",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / UOPS_ISSUED.ANY * IDQ.M=
S_UOPS / tma_info_thread_slots",
         "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_heavy_operatio=
ns_group;tma_issueMC;tma_issueMS",
         "MetricName": "tma_microcode_sequencer",
         "MetricThreshold": "tma_microcode_sequencer > 0.05 & tma_heavy_ope=
rations > 0.1",
@@ -1171,19 +1170,19 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Branch Misprediction=
 at execution stage",
-        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRED.ALL=
_BRANCHES + MACHINE_CLEARS.COUNT) * INT_MISC.CLEAR_RESTEER_CYCLES / tma_inf=
o_clks",
+        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRED.ALL=
_BRANCHES + MACHINE_CLEARS.COUNT) * INT_MISC.CLEAR_RESTEER_CYCLES / tma_inf=
o_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the MITE pipeline (the legacy deco=
de pipeline)",
-        "MetricExpr": "(IDQ.ALL_MITE_CYCLES_ANY_UOPS - IDQ.ALL_MITE_CYCLES=
_4_UOPS) / tma_info_core_clks / 2",
+        "MetricExpr": "(IDQ.ALL_MITE_CYCLES_ANY_UOPS - IDQ.ALL_MITE_CYCLES=
_4_UOPS) / tma_info_core_core_clks / 2",
         "MetricGroup": "DSBmiss;FetchBW;TopdownL3;tma_L3_group;tma_fetch_b=
andwidth_group",
         "MetricName": "tma_mite",
-        "MetricThreshold": "tma_mite > 0.1 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_ipc / 4 > 0.35)",
+        "MetricThreshold": "tma_mite > 0.1 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_thread_ipc / 4 > 0.35)",
         "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to the MITE pipeline (the legacy dec=
ode pipeline). This pipeline is used for code that was not pre-cached in th=
e DSB or LSD. For example; inefficiencies due to asymmetric decoders; use o=
f long immediate or LCP can manifest as MITE fetch bandwidth bottleneck. Sa=
mple with: FRONTEND_RETIRED.ANY_DSB_MISS",
         "ScaleUnit": "100%"
     },
@@ -1198,7 +1197,7 @@
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS)",
-        "MetricExpr": "2 * IDQ.MS_SWITCHES / tma_info_clks",
+        "MetricExpr": "2 * IDQ.MS_SWITCHES / tma_info_thread_clks",
         "MetricGroup": "FetchLat;MicroSeq;TopdownL3;tma_L3_group;tma_fetch=
_latency_group;tma_issueMC;tma_issueMS;tma_issueMV;tma_issueSO",
         "MetricName": "tma_ms_switches",
         "MetricThreshold": "tma_ms_switches > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
@@ -1234,7 +1233,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd b=
ranch)",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_0 / tma_info_core_clks",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_0 / tma_info_core_core_cl=
ks",
         "MetricGroup": "Compute;TopdownL6;tma_L6_group;tma_alu_op_utilizat=
ion_group;tma_issue2P",
         "MetricName": "tma_port_0",
         "MetricThreshold": "tma_port_0 > 0.6",
@@ -1243,7 +1242,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 1 (ALU)",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_1 / tma_info_core_clks",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_1 / tma_info_core_core_cl=
ks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_1",
         "MetricThreshold": "tma_port_1 > 0.6",
@@ -1252,7 +1251,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 2 ([SNB+]Loads and Store-address; [=
ICL+] Loads)",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_2 / tma_info_core_clks",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_2 / tma_info_core_core_cl=
ks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_load_op_utilization_gro=
up",
         "MetricName": "tma_port_2",
         "MetricThreshold": "tma_port_2 > 0.6",
@@ -1261,7 +1260,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 3 ([SNB+]Loads and Store-address; [=
ICL+] Loads)",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_3 / tma_info_core_clks",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_3 / tma_info_core_core_cl=
ks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_load_op_utilization_gro=
up",
         "MetricName": "tma_port_3",
         "MetricThreshold": "tma_port_3 > 0.6",
@@ -1279,7 +1278,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 5 ([SNB+] Branches and ALU; [HSW+] =
ALU)",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_5 / tma_info_core_clks",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_5 / tma_info_core_core_cl=
ks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_5",
         "MetricThreshold": "tma_port_5 > 0.6",
@@ -1288,7 +1287,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 6 ([HSW+]Primary Branch and simple =
ALU)",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_6 / tma_info_core_clks",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_6 / tma_info_core_core_cl=
ks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_6",
         "MetricThreshold": "tma_port_6 > 0.6",
@@ -1297,7 +1296,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 7 ([HSW+]simple Store-address)",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_7 / tma_info_core_clks",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_7 / tma_info_core_core_cl=
ks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_store_op_utilization_gr=
oup",
         "MetricName": "tma_port_7",
         "MetricThreshold": "tma_port_7 > 0.6",
@@ -1306,7 +1305,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
-        "MetricExpr": "((EXE_ACTIVITY.EXE_BOUND_0_PORTS + (EXE_ACTIVITY.1_=
PORTS_UTIL + tma_retiring * EXE_ACTIVITY.2_PORTS_UTIL)) / tma_info_clks if =
ARITH.DIVIDER_ACTIVE < CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.STALLS_=
MEM_ANY else (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * EXE_ACTIVITY.2_POR=
TS_UTIL) / tma_info_clks)",
+        "MetricExpr": "((EXE_ACTIVITY.EXE_BOUND_0_PORTS + (EXE_ACTIVITY.1_=
PORTS_UTIL + tma_retiring * EXE_ACTIVITY.2_PORTS_UTIL)) / tma_info_thread_c=
lks if ARITH.DIVIDER_ACTIVE < CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.=
STALLS_MEM_ANY else (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * EXE_ACTIVIT=
Y.2_PORTS_UTIL) / tma_info_thread_clks)",
         "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
         "MetricName": "tma_ports_utilization",
         "MetricThreshold": "tma_ports_utilization > 0.15 & (tma_core_bound=
 > 0.1 & tma_backend_bound > 0.2)",
@@ -1315,7 +1314,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
-        "MetricExpr": "(UOPS_EXECUTED.CORE_CYCLES_NONE / 2 if #SMT_on else=
 CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.STALLS_MEM_ANY) / tma_info_co=
re_clks",
+        "MetricExpr": "(UOPS_EXECUTED.CORE_CYCLES_NONE / 2 if #SMT_on else=
 CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.STALLS_MEM_ANY) / tma_info_co=
re_core_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_0",
         "MetricThreshold": "tma_ports_utilized_0 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -1324,7 +1323,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re the CPU executed total of 1 uop per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "((UOPS_EXECUTED.CORE_CYCLES_GE_1 - UOPS_EXECUTED.CO=
RE_CYCLES_GE_2) / 2 if #SMT_on else EXE_ACTIVITY.1_PORTS_UTIL) / tma_info_c=
ore_clks",
+        "MetricExpr": "((UOPS_EXECUTED.CORE_CYCLES_GE_1 - UOPS_EXECUTED.CO=
RE_CYCLES_GE_2) / 2 if #SMT_on else EXE_ACTIVITY.1_PORTS_UTIL) / tma_info_c=
ore_core_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issueL1;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_1",
         "MetricThreshold": "tma_ports_utilized_1 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -1333,7 +1332,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 2 uops per cycle on all execution ports (Logical Process=
or cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "((UOPS_EXECUTED.CORE_CYCLES_GE_2 - UOPS_EXECUTED.CO=
RE_CYCLES_GE_3) / 2 if #SMT_on else EXE_ACTIVITY.2_PORTS_UTIL) / tma_info_c=
ore_clks",
+        "MetricExpr": "((UOPS_EXECUTED.CORE_CYCLES_GE_2 - UOPS_EXECUTED.CO=
RE_CYCLES_GE_3) / 2 if #SMT_on else EXE_ACTIVITY.2_PORTS_UTIL) / tma_info_c=
ore_core_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issue2P;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_2",
         "MetricThreshold": "tma_ports_utilized_2 > 0.15 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -1342,7 +1341,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise).",
-        "MetricExpr": "(UOPS_EXECUTED.CORE_CYCLES_GE_3 / 2 if #SMT_on else=
 UOPS_EXECUTED.CORE_CYCLES_GE_3) / tma_info_core_clks",
+        "MetricExpr": "(UOPS_EXECUTED.CORE_CYCLES_GE_3 / 2 if #SMT_on else=
 UOPS_EXECUTED.CORE_CYCLES_GE_3) / tma_info_core_core_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_3m",
         "MetricThreshold": "tma_ports_utilized_3m > 0.7 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -1350,7 +1349,7 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_slots",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_thread_slots",
         "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
@@ -1360,7 +1359,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU issue-pipeline was stalled due to serializing operations",
-        "MetricExpr": "PARTIAL_RAT_STALLS.SCOREBOARD / tma_info_clks",
+        "MetricExpr": "PARTIAL_RAT_STALLS.SCOREBOARD / tma_info_thread_clk=
s",
         "MetricGroup": "PortsUtil;TopdownL5;tma_L5_group;tma_issueSO;tma_p=
orts_utilized_0_group",
         "MetricName": "tma_serializing_operation",
         "MetricThreshold": "tma_serializing_operation > 0.1 & (tma_ports_u=
tilized_0 > 0.2 & (tma_ports_utilization > 0.15 & (tma_core_bound > 0.1 & t=
ma_backend_bound > 0.2)))",
@@ -1370,7 +1369,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles hand=
ling memory load split accesses - load that cross 64-byte cache line bounda=
ry",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
-        "MetricExpr": "tma_info_load_miss_real_latency * LD_BLOCKS.NO_SR /=
 tma_info_clks",
+        "MetricExpr": "tma_info_memory_load_miss_real_latency * LD_BLOCKS.=
NO_SR / tma_info_thread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_split_loads",
         "MetricThreshold": "tma_split_loads > 0.2 & (tma_l1_bound > 0.1 & =
(tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -1379,7 +1378,7 @@
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
@@ -1388,16 +1387,16 @@
     },
     {
         "BriefDescription": "This metric measures fraction of cycles where=
 the Super Queue (SQ) was full taking into account all request-types and bo=
th hardware SMT threads (Logical Processors)",
-        "MetricExpr": "(OFFCORE_REQUESTS_BUFFER.SQ_FULL / 2 if #SMT_on els=
e OFFCORE_REQUESTS_BUFFER.SQ_FULL) / tma_info_core_clks",
+        "MetricExpr": "(OFFCORE_REQUESTS_BUFFER.SQ_FULL / 2 if #SMT_on els=
e OFFCORE_REQUESTS_BUFFER.SQ_FULL) / tma_info_core_core_clks",
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
         "ScaleUnit": "100%"
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
@@ -1406,7 +1405,7 @@
     },
     {
         "BriefDescription": "This metric roughly estimates fraction of cyc=
les when the memory subsystem had loads blocked since they could not forwar=
d data from earlier (in program order) overlapping stores",
-        "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / tma_info_clks",
+        "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / tma_info_thread_clks=
",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_store_fwd_blk",
         "MetricThreshold": "tma_store_fwd_blk > 0.1 & (tma_l1_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -1416,7 +1415,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
-        "MetricExpr": "(L2_RQSTS.RFO_HIT * 9 * (1 - MEM_INST_RETIRED.LOCK_=
LOADS / MEM_INST_RETIRED.ALL_STORES) + (1 - MEM_INST_RETIRED.LOCK_LOADS / M=
EM_INST_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS=
_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / tma_info_clks",
+        "MetricExpr": "(L2_RQSTS.RFO_HIT * 9 * (1 - MEM_INST_RETIRED.LOCK_=
LOADS / MEM_INST_RETIRED.ALL_STORES) + (1 - MEM_INST_RETIRED.LOCK_LOADS / M=
EM_INST_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS=
_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / tma_info_thread_clks",
         "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_issue=
RFO;tma_issueSL;tma_store_bound_group",
         "MetricName": "tma_store_latency",
         "MetricThreshold": "tma_store_latency > 0.1 & (tma_store_bound > 0=
.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -1425,7 +1424,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Store operations",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_4 / tma_info_core_clks",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_4 / tma_info_core_core_cl=
ks",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_store_op_utilization",
         "MetricThreshold": "tma_store_op_utilization > 0.6",
@@ -1441,7 +1440,7 @@
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
@@ -1449,7 +1448,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to new branch address clears",
-        "MetricExpr": "9 * BACLEARS.ANY / tma_info_clks",
+        "MetricExpr": "9 * BACLEARS.ANY / tma_info_thread_clks",
         "MetricGroup": "BigFoot;FetchLat;TopdownL4;tma_L4_group;tma_branch=
_resteers_group",
         "MetricName": "tma_unknown_branches",
         "MetricThreshold": "tma_unknown_branches > 0.05 & (tma_branch_rest=
eers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/floating-point.json b/=
tools/perf/pmu-events/arch/x86/skylakex/floating-point.json
index 64dd36387209..384b3c551a1f 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/floating-point.json
@@ -31,6 +31,14 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x20"
     },
+    {
+        "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d single and 256-bit packed double precision FP instructions retired; some =
instructions will count twice as noted below.  Each count represents 2 or/a=
nd 4 computation operations, 1 for each element.  Applies to SSE* and AVX* =
packed single precision and packed double precision FP instructions: ADD SU=
B HADD HSUB SUBADD MUL DIV MIN MAX RCP14 RSQRT14 SQRT DPP FM(N)ADD/SUB.  DP=
P and FM(N)ADD/SUB count twice as they perform 2 calculations per element."=
,
+        "EventCode": "0xC7",
+        "EventName": "FP_ARITH_INST_RETIRED.4_FLOPS",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision and 256-bit packed double precision  floating-point ins=
tructions retired; some instructions will count twice as noted below.  Each=
 count represents 2 or/and 4 computation operations, one for each element. =
 Applies to SSE* and AVX* packed single precision floating-point and packed=
 double precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL=
 DIV MIN MAX RCP14 RSQRT14 SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB ins=
tructions count twice as they perform 2 calculations per element. The DAZ a=
nd FTZ flags in the MXCSR register need to be set when using these events."=
,
+        "SampleAfterValue": "1000003",
+        "UMask": "0x18"
+    },
     {
         "BriefDescription": "Counts number of SSE/AVX computational 512-bi=
t packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 8 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed double =
precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14=
 RCP14 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform =
2 calculations per element.",
         "EventCode": "0xC7",
@@ -47,6 +55,22 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x80"
     },
+    {
+        "BriefDescription": "Number of SSE/AVX computational 256-bit packe=
d single precision and 512-bit packed double precision  FP instructions ret=
ired; some instructions will count twice as noted below.  Each count repres=
ents 8 computation operations, 1 for each element.  Applies to SSE* and AVX=
* packed single precision and double precision FP instructions: ADD SUB HAD=
D HSUB SUBADD MUL DIV MIN MAX SQRT RSQRT RSQRT14 RCP RCP14 DPP FM(N)ADD/SUB=
.  DPP and FM(N)ADD/SUB count twice as they perform 2 calculations per elem=
ent.",
+        "EventCode": "0xC7",
+        "EventName": "FP_ARITH_INST_RETIRED.8_FLOPS",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed single precision and 512-bit packed double precision  floating-point ins=
tructions retired; some instructions will count twice as noted below.  Each=
 count represents 8 computation operations, one for each element.  Applies =
to SSE* and AVX* packed single precision and double precision floating-poin=
t instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT RSQRT RSQRT14=
 RCP RCP14 DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice=
 as they perform 2 calculations per element. The DAZ and FTZ flags in the M=
XCSR register need to be set when using these events.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x18"
+    },
+    {
+        "BriefDescription": "Counts once for most SIMD scalar computationa=
l floating-point instructions retired. Counts twice for DPP and FM(N)ADD/SU=
B instructions retired.",
+        "EventCode": "0xC7",
+        "EventName": "FP_ARITH_INST_RETIRED.SCALAR",
+        "PublicDescription": "Counts once for most SIMD scalar computation=
al single precision and double precision floating-point instructions retire=
d; some instructions will count twice as noted below.  Each count represent=
s 1 computational operation. Applies to SIMD scalar single precision floati=
ng-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.=
  FM(N)ADD/SUB instructions count twice as they perform 2 calculations per =
element. The DAZ and FTZ flags in the MXCSR register need to be set when us=
ing these events.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x3"
+    },
     {
         "BriefDescription": "Counts once for most SIMD scalar computationa=
l double precision floating-point instructions retired. Counts twice for DP=
P and FM(N)ADD/SUB instructions retired.",
         "EventCode": "0xC7",
@@ -63,6 +87,13 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
+    {
+        "BriefDescription": "Number of any Vector retired FP arithmetic in=
structions",
+        "EventCode": "0xC7",
+        "EventName": "FP_ARITH_INST_RETIRED.VECTOR",
+        "SampleAfterValue": "2000003",
+        "UMask": "0xfc"
+    },
     {
         "BriefDescription": "Cycles with any input/output SSE or FP assist=
",
         "CounterMask": "1",
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json b/tools/=
perf/pmu-events/arch/x86/skylakex/pipeline.json
index 0f06e314fe36..31a1663d57f8 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json
@@ -26,12 +26,21 @@
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "Conditional branch instructions retired.",
+        "BriefDescription": "Conditional branch instructions retired. [Thi=
s event is alias to BR_INST_RETIRED.CONDITIONAL]",
+        "Errata": "SKL091",
+        "EventCode": "0xC4",
+        "EventName": "BR_INST_RETIRED.COND",
+        "PublicDescription": "This event counts conditional branch instruc=
tions retired. [This event is alias to BR_INST_RETIRED.CONDITIONAL]",
+        "SampleAfterValue": "400009",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Conditional branch instructions retired. [Thi=
s event is alias to BR_INST_RETIRED.COND]",
         "Errata": "SKL091",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.CONDITIONAL",
         "PEBS": "1",
-        "PublicDescription": "This event counts conditional branch instruc=
tions retired.",
+        "PublicDescription": "This event counts conditional branch instruc=
tions retired. [This event is alias to BR_INST_RETIRED.COND]",
         "SampleAfterValue": "400009",
         "UMask": "0x1"
     },
@@ -413,6 +422,16 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Clears speculative count",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0x0D",
+        "EventName": "INT_MISC.CLEARS_COUNT",
+        "PublicDescription": "Counts the number of speculative clears due =
to any type of branch misprediction or machine clears",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Cycles the issue-stage is waiting for front-e=
nd to fetch from resteered path following branch misprediction or machine c=
lear events.",
         "EventCode": "0x0D",
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/too=
ls/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
index eb6f12c0343d..507d39efacc8 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
@@ -50,10 +50,219 @@
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
+    {
+        "BriefDescription": "Cycles per instruction retired; indicating ho=
w much time each executed instruction took; in units of cycles.",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / INST_RETIRED.ANY",
+        "MetricName": "cpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "CPU operating frequency (in GHz)",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC =
* #SYSTEM_TSC_FREQ / 1e9",
+        "MetricName": "cpu_operating_frequency",
+        "ScaleUnit": "1GHz"
+    },
+    {
+        "BriefDescription": "Percentage of time spent in the active CPU po=
wer state C0",
+        "MetricExpr": "tma_info_system_cpu_utilization",
+        "MetricName": "cpu_utilization",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
2 megabyte page sizes) caused by demand data loads to the total number of c=
ompleted instructions",
+        "MetricExpr": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M / INST_RETIRE=
D.ANY",
+        "MetricName": "dtlb_2mb_large_page_load_mpi",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 2 megabyte page sizes) caused by demand data loads to the total number of =
completed instructions. This implies it missed in the Data Translation Look=
aside Buffer (DTLB) and further levels of TLB.",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data loads to the total number of complete=
d instructions",
+        "MetricExpr": "DTLB_LOAD_MISSES.WALK_COMPLETED / INST_RETIRED.ANY"=
,
+        "MetricName": "dtlb_load_mpi",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data loads to the total number of complet=
ed instructions. This implies it missed in the DTLB and further levels of T=
LB.",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data stores to the total number of complet=
ed instructions",
+        "MetricExpr": "DTLB_STORE_MISSES.WALK_COMPLETED / INST_RETIRED.ANY=
",
+        "MetricName": "dtlb_store_mpi",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data stores to the total number of comple=
ted instructions. This implies it missed in the DTLB and further levels of =
TLB.",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the CPU.",
+        "MetricExpr": "(UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 + UNC_IIO_D=
ATA_REQ_OF_CPU.MEM_READ.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 + UN=
C_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3) * 4 / 1e6 / duration_time",
+        "MetricName": "io_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the CPU.",
+        "MetricExpr": "(UNC_IIO_PAYLOAD_BYTES_IN.MEM_WRITE.PART0 + UNC_IIO=
_PAYLOAD_BYTES_IN.MEM_WRITE.PART1 + UNC_IIO_PAYLOAD_BYTES_IN.MEM_WRITE.PART=
2 + UNC_IIO_PAYLOAD_BYTES_IN.MEM_WRITE.PART3) * 4 / 1e6 / duration_time",
+        "MetricName": "io_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total n=
umber of completed instructions",
+        "MetricExpr": "ITLB_MISSES.WALK_COMPLETED_2M_4M / INST_RETIRED.ANY=
",
+        "MetricName": "itlb_large_page_mpi",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total =
number of completed instructions. This implies it missed in the Instruction=
 Translation Lookaside Buffer (ITLB) and further levels of TLB.",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by a code fetch to the total number of completed ins=
tructions",
+        "MetricExpr": "ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.ANY",
+        "MetricName": "itlb_mpi",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by a code fetch to the total number of completed in=
structions. This implies it missed in the ITLB (Instruction TLB) and furthe=
r levels of TLB.",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of code read requests missing=
 in L1 instruction cache (includes prefetches) to the total number of compl=
eted instructions",
+        "MetricExpr": "L2_RQSTS.ALL_CODE_RD / INST_RETIRED.ANY",
+        "MetricName": "l1_i_code_read_misses_with_prefetches_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of demand load requests hitti=
ng in L1 data cache to the total number of completed instructions",
+        "MetricExpr": "MEM_LOAD_RETIRED.L1_HIT / INST_RETIRED.ANY",
+        "MetricName": "l1d_demand_data_read_hits_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of requests missing L1 data c=
ache (includes data+rfo w/ prefetches) to the total number of completed ins=
tructions",
+        "MetricExpr": "L1D.REPLACEMENT / INST_RETIRED.ANY",
+        "MetricName": "l1d_mpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of code read request missing =
L2 cache to the total number of completed instructions",
+        "MetricExpr": "L2_RQSTS.CODE_RD_MISS / INST_RETIRED.ANY",
+        "MetricName": "l2_demand_code_mpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed demand load requ=
ests hitting in L2 cache to the total number of completed instructions",
+        "MetricExpr": "MEM_LOAD_RETIRED.L2_HIT / INST_RETIRED.ANY",
+        "MetricName": "l2_demand_data_read_hits_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed data read reques=
t missing L2 cache to the total number of completed instructions",
+        "MetricExpr": "MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricName": "l2_demand_data_read_mpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of requests missing L2 cache =
(includes code+data+rfo w/ prefetches) to the total number of completed ins=
tructions",
+        "MetricExpr": "L2_LINES_IN.ALL / INST_RETIRED.ANY",
+        "MetricName": "l2_mpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of code read requests missing=
 last level core cache (includes demand w/ prefetches) to the total number =
of completed instructions",
+        "MetricExpr": "cha@UNC_CHA_TOR_INSERTS.IA_MISS\\,config1\\=3D0x12C=
C0233@ / INST_RETIRED.ANY",
+        "MetricName": "llc_code_read_mpi_demand_plus_prefetch",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand and prefetch data read miss (read memory access) in nano seconds",
+        "MetricExpr": "1e9 * (cha@UNC_CHA_TOR_OCCUPANCY.IA_MISS\\,config1\=
\=3D0x40433@ / cha@UNC_CHA_TOR_INSERTS.IA_MISS\\,config1\\=3D0x40433@) / (U=
NC_CHA_CLOCKTICKS / (#num_cores / #num_packages * #num_packages)) * duratio=
n_time",
+        "MetricName": "llc_data_read_demand_plus_prefetch_miss_latency",
+        "ScaleUnit": "1ns"
+    },
+    {
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand and prefetch data read miss (read memory access) addressed to local m=
emory in nano seconds",
+        "MetricExpr": "1e9 * (cha@UNC_CHA_TOR_OCCUPANCY.IA_MISS\\,config1\=
\=3D0x40432@ / cha@UNC_CHA_TOR_INSERTS.IA_MISS\\,config1\\=3D0x40432@) / (U=
NC_CHA_CLOCKTICKS / (#num_cores / #num_packages * #num_packages)) * duratio=
n_time",
+        "MetricName": "llc_data_read_demand_plus_prefetch_miss_latency_for=
_local_requests",
+        "ScaleUnit": "1ns"
+    },
+    {
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand and prefetch data read miss (read memory access) addressed to remote =
memory in nano seconds",
+        "MetricExpr": "1e9 * (cha@UNC_CHA_TOR_OCCUPANCY.IA_MISS\\,config1\=
\=3D0x40431@ / cha@UNC_CHA_TOR_INSERTS.IA_MISS\\,config1\\=3D0x40431@) / (U=
NC_CHA_CLOCKTICKS / (#num_cores / #num_packages * #num_packages)) * duratio=
n_time",
+        "MetricName": "llc_data_read_demand_plus_prefetch_miss_latency_for=
_remote_requests",
+        "ScaleUnit": "1ns"
+    },
+    {
+        "BriefDescription": "Ratio of number of data read requests missing=
 last level core cache (includes demand w/ prefetches) to the total number =
of completed instructions",
+        "MetricExpr": "cha@UNC_CHA_TOR_INSERTS.IA_MISS\\,config1\\=3D0x12D=
40433@ / INST_RETIRED.ANY",
+        "MetricName": "llc_data_read_mpi_demand_plus_prefetch",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Bandwidth (MB/sec) of read requests that miss=
 the last level cache (LLC) and go to local memory.",
+        "MetricExpr": "UNC_CHA_REQUESTS.READS_LOCAL * 64 / 1e6 / duration_=
time",
+        "MetricName": "llc_miss_local_memory_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth (MB/sec) of write requests that mis=
s the last level cache (LLC) and go to local memory.",
+        "MetricExpr": "UNC_CHA_REQUESTS.WRITES_LOCAL * 64 / 1e6 / duration=
_time",
+        "MetricName": "llc_miss_local_memory_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth (MB/sec) of read requests that miss=
 the last level cache (LLC) and go to remote memory.",
+        "MetricExpr": "UNC_CHA_REQUESTS.READS_REMOTE * 64 / 1e6 / duration=
_time",
+        "MetricName": "llc_miss_remote_memory_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "The ratio of number of completed memory load =
instructions to the total number completed instructions",
+        "MetricExpr": "MEM_INST_RETIRED.ALL_LOADS / INST_RETIRED.ANY",
+        "MetricName": "loads_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "DDR memory read bandwidth (MB/sec)",
+        "MetricExpr": "UNC_M_CAS_COUNT.RD * 64 / 1e6 / duration_time",
+        "MetricName": "memory_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "DDR memory bandwidth (MB/sec)",
+        "MetricExpr": "(UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) * 64 / 1e=
6 / duration_time",
+        "MetricName": "memory_bandwidth_total",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "DDR memory write bandwidth (MB/sec)",
+        "MetricExpr": "UNC_M_CAS_COUNT.WR * 64 / 1e6 / duration_time",
+        "MetricName": "memory_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Memory read that miss the last level cache (L=
LC) addressed to local DRAM as a percentage of total memory read accesses, =
does not include LLC prefetches.",
+        "MetricExpr": "cha@UNC_CHA_TOR_INSERTS.IA_MISS\\,config1\\=3D0x404=
32@ / (cha@UNC_CHA_TOR_INSERTS.IA_MISS\\,config1\\=3D0x40432@ + cha@UNC_CHA=
_TOR_INSERTS.IA_MISS\\,config1\\=3D0x40431@)",
+        "MetricName": "numa_reads_addressed_to_local_dram",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Memory reads that miss the last level cache (=
LLC) addressed to remote DRAM as a percentage of total memory read accesses=
, does not include LLC prefetches.",
+        "MetricExpr": "cha@UNC_CHA_TOR_INSERTS.IA_MISS\\,config1\\=3D0x404=
31@ / (cha@UNC_CHA_TOR_INSERTS.IA_MISS\\,config1\\=3D0x40432@ + cha@UNC_CHA=
_TOR_INSERTS.IA_MISS\\,config1\\=3D0x40431@)",
+        "MetricName": "numa_reads_addressed_to_remote_dram",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Uops delivered from decoded instruction cache=
 (decoded stream buffer or DSB) as a percent of total uops delivered to Ins=
truction Decode Queue",
+        "MetricExpr": "IDQ.DSB_UOPS / UOPS_ISSUED.ANY",
+        "MetricName": "percent_uops_delivered_from_decoded_icache",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Uops delivered from legacy decode pipeline (M=
icro-instruction Translation Engine or MITE) as a percent of total uops del=
ivered to Instruction Decode Queue",
+        "MetricExpr": "IDQ.MITE_UOPS / UOPS_ISSUED.ANY",
+        "MetricName": "percent_uops_delivered_from_legacy_decode_pipeline"=
,
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Uops delivered from microcode sequencer (MS) =
as a percent of total uops delivered to Instruction Decode Queue",
+        "MetricExpr": "IDQ.MS_UOPS / UOPS_ISSUED.ANY",
+        "MetricName": "percent_uops_delivered_from_microcode_sequencer",
+        "ScaleUnit": "100%"
+    },
     {
         "BriefDescription": "Percentage of cycles spent in System Manageme=
nt Interrupts.",
         "MetricExpr": "((msr@aperf@ - cycles) / msr@aperf@ if msr@smi@ > 0=
 else 0)",
@@ -69,9 +278,15 @@
         "MetricName": "smi_num",
         "ScaleUnit": "1SMI#"
     },
+    {
+        "BriefDescription": "The ratio of number of completed memory store=
 instructions to the total number completed instructions",
+        "MetricExpr": "MEM_INST_RETIRED.ALL_STORES / INST_RETIRED.ANY",
+        "MetricName": "stores_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
     {
         "BriefDescription": "This metric estimates how often memory load a=
ccesses were aliased by preceding stores (in program order) with a 4K addre=
ss offset",
-        "MetricExpr": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS / tma_info_clks",
+        "MetricExpr": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS / tma_info_thread_c=
lks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_4k_aliasing",
         "MetricThreshold": "tma_4k_aliasing > 0.2 & (tma_l1_bound > 0.1 & =
(tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -80,7 +295,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
-        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_0 + UOPS_DISPATCHED_PORT=
.PORT_1 + UOPS_DISPATCHED_PORT.PORT_5 + UOPS_DISPATCHED_PORT.PORT_6) / tma_=
info_slots",
+        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_0 + UOPS_DISPATCHED_PORT=
.PORT_1 + UOPS_DISPATCHED_PORT.PORT_5 + UOPS_DISPATCHED_PORT.PORT_6) / tma_=
info_thread_slots",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_alu_op_utilization",
         "MetricThreshold": "tma_alu_op_utilization > 0.6",
@@ -88,7 +303,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops delivered by the Microcode_Sequencer as a result of Assists=
",
-        "MetricExpr": "100 * (FP_ASSIST.ANY + OTHER_ASSISTS.ANY) / tma_inf=
o_slots",
+        "MetricExpr": "100 * (FP_ASSIST.ANY + OTHER_ASSISTS.ANY) / tma_inf=
o_thread_slots",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
         "MetricName": "tma_assists",
         "MetricThreshold": "tma_assists > 0.1 & (tma_microcode_sequencer >=
 0.05 & tma_heavy_operations > 0.1)",
@@ -97,7 +312,7 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
-        "MetricExpr": "1 - tma_frontend_bound - (UOPS_ISSUED.ANY + 4 * (IN=
T_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)) /=
 tma_info_slots",
+        "MetricExpr": "1 - tma_frontend_bound - (UOPS_ISSUED.ANY + 4 * (IN=
T_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)) /=
 tma_info_thread_slots",
         "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
@@ -107,7 +322,7 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
-        "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * =
(INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)=
) / tma_info_slots",
+        "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * =
(INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)=
) / tma_info_thread_slots",
         "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
@@ -123,12 +338,12 @@
         "MetricName": "tma_branch_mispredicts",
         "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specula=
tion > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics:=
 tma_info_branch_misprediction_cost, tma_info_mispredictions, tma_mispredic=
ts_resteers",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics:=
 tma_info_bad_spec_branch_misprediction_cost, tma_info_bottleneck_mispredic=
tions, tma_mispredicts_resteers",
         "ScaleUnit": "100%"
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
@@ -146,7 +361,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Machine Clears",
-        "MetricExpr": "(1 - BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRE=
D.ALL_BRANCHES + MACHINE_CLEARS.COUNT)) * INT_MISC.CLEAR_RESTEER_CYCLES / t=
ma_info_clks",
+        "MetricExpr": "(1 - BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRE=
D.ALL_BRANCHES + MACHINE_CLEARS.COUNT)) * INT_MISC.CLEAR_RESTEER_CYCLES / t=
ma_info_thread_clks",
         "MetricGroup": "BadSpec;MachineClears;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group;tma_issueMC",
         "MetricName": "tma_clears_resteers",
         "MetricThreshold": "tma_clears_resteers > 0.05 & (tma_branch_reste=
ers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
@@ -156,7 +371,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(44 * tma_info_average_frequency * (MEM_LOAD_L3_HIT=
_RETIRED.XSNP_HITM * (OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.HITM_OTHER_COR=
E / (OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.HITM_OTHER_CORE + OFFCORE_RESPO=
NSE.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) + 44 * tma_info_average_fre=
quency * MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS) * (1 + MEM_LOAD_RETIRED.FB_HIT =
/ MEM_LOAD_RETIRED.L1_MISS / 2) / tma_info_clks",
+        "MetricExpr": "(44 * tma_info_system_average_frequency * (MEM_LOAD=
_L3_HIT_RETIRED.XSNP_HITM * (OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.HITM_OT=
HER_CORE / (OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.HITM_OTHER_CORE + OFFCOR=
E_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) + 44 * tma_info_syst=
em_average_frequency * MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS) * (1 + MEM_LOAD_R=
ETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_l3_bound_group",
         "MetricName": "tma_contested_accesses",
         "MetricThreshold": "tma_contested_accesses > 0.05 & (tma_l3_bound =
> 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -177,7 +392,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "44 * tma_info_average_frequency * (MEM_LOAD_L3_HIT_=
RETIRED.XSNP_HIT + MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM * (1 - OFFCORE_RESPONS=
E.DEMAND_DATA_RD.L3_HIT.HITM_OTHER_CORE / (OFFCORE_RESPONSE.DEMAND_DATA_RD.=
L3_HIT.HITM_OTHER_CORE + OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_W=
ITH_FWD))) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) /=
 tma_info_clks",
+        "MetricExpr": "44 * tma_info_system_average_frequency * (MEM_LOAD_=
L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM * (1 - OFFCORE_=
RESPONSE.DEMAND_DATA_RD.L3_HIT.HITM_OTHER_CORE / (OFFCORE_RESPONSE.DEMAND_D=
ATA_RD.L3_HIT.HITM_OTHER_CORE + OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOO=
P_HIT_WITH_FWD))) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS=
 / 2) / tma_info_thread_clks",
         "MetricGroup": "Offcore;Snoop;TopdownL4;tma_L4_group;tma_issueSync=
xn;tma_l3_bound_group",
         "MetricName": "tma_data_sharing",
         "MetricThreshold": "tma_data_sharing > 0.05 & (tma_l3_bound > 0.05=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -186,16 +401,16 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re decoder-0 was the only active decoder",
-        "MetricExpr": "(cpu@INST_DECODED.DECODERS\\,cmask\\=3D1@ - cpu@INS=
T_DECODED.DECODERS\\,cmask\\=3D2@) / tma_info_core_clks / 2",
+        "MetricExpr": "(cpu@INST_DECODED.DECODERS\\,cmask\\=3D1@ - cpu@INS=
T_DECODED.DECODERS\\,cmask\\=3D2@) / tma_info_core_core_clks / 2",
         "MetricGroup": "DSBmiss;FetchBW;TopdownL4;tma_L4_group;tma_issueD0=
;tma_mite_group",
         "MetricName": "tma_decoder0_alone",
-        "MetricThreshold": "tma_decoder0_alone > 0.1 & (tma_mite > 0.1 & (=
tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_ipc / 4 > =
0.35))",
+        "MetricThreshold": "tma_decoder0_alone > 0.1 & (tma_mite > 0.1 & (=
tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_thread_ipc=
 / 4 > 0.35))",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere decoder-0 was the only active decoder. Related metrics: tma_few_uops_in=
structions",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re the Divider unit was active",
-        "MetricExpr": "ARITH.DIVIDER_ACTIVE / tma_info_clks",
+        "MetricExpr": "ARITH.DIVIDER_ACTIVE / tma_info_thread_clks",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_core_bound_group",
         "MetricName": "tma_divider",
         "MetricThreshold": "tma_divider > 0.2 & (tma_core_bound > 0.1 & tm=
a_backend_bound > 0.2)",
@@ -205,7 +420,7 @@
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "CYCLE_ACTIVITY.STALLS_L3_MISS / tma_info_clks + (CY=
CLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_info_cl=
ks - tma_l2_bound",
+        "MetricExpr": "CYCLE_ACTIVITY.STALLS_L3_MISS / tma_info_thread_clk=
s + (CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_=
info_thread_clks - tma_l2_bound",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_dram_bound",
         "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2)",
@@ -214,45 +429,45 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to DSB (decoded uop cache) fetch pipe=
line",
-        "MetricExpr": "(IDQ.ALL_DSB_CYCLES_ANY_UOPS - IDQ.ALL_DSB_CYCLES_4=
_UOPS) / tma_info_core_clks / 2",
+        "MetricExpr": "(IDQ.ALL_DSB_CYCLES_ANY_UOPS - IDQ.ALL_DSB_CYCLES_4=
_UOPS) / tma_info_core_core_clks / 2",
         "MetricGroup": "DSB;FetchBW;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
         "MetricName": "tma_dsb",
-        "MetricThreshold": "tma_dsb > 0.15 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_ipc / 4 > 0.35)",
+        "MetricThreshold": "tma_dsb > 0.15 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_thread_ipc / 4 > 0.35)",
         "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here.",
         "ScaleUnit": "100%"
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
-        "MetricExpr": "min(9 * cpu@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\\=3D1=
@ + DTLB_LOAD_MISSES.WALK_ACTIVE, max(CYCLE_ACTIVITY.CYCLES_MEM_ANY - CYCLE=
_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_clks",
+        "MetricExpr": "min(9 * cpu@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\\=3D1=
@ + DTLB_LOAD_MISSES.WALK_ACTIVE, max(CYCLE_ACTIVITY.CYCLES_MEM_ANY - CYCLE=
_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
-        "MetricExpr": "(9 * cpu@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=3D1@ =
+ DTLB_STORE_MISSES.WALK_ACTIVE) / tma_info_core_clks",
+        "MetricExpr": "(9 * cpu@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=3D1@ =
+ DTLB_STORE_MISSES.WALK_ACTIVE) / tma_info_core_core_clks",
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(110 * tma_info_average_frequency * (OFFCORE_RESPON=
SE.DEMAND_RFO.L3_MISS.REMOTE_HITM + OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS.REMO=
TE_HITM) + 47.5 * tma_info_average_frequency * (OFFCORE_RESPONSE.DEMAND_RFO=
.L3_HIT.HITM_OTHER_CORE + OFFCORE_RESPONSE.PF_L2_RFO.L3_HIT.HITM_OTHER_CORE=
)) / tma_info_clks",
+        "MetricExpr": "(110 * tma_info_system_average_frequency * (OFFCORE=
_RESPONSE.DEMAND_RFO.L3_MISS.REMOTE_HITM + OFFCORE_RESPONSE.PF_L2_RFO.L3_MI=
SS.REMOTE_HITM) + 47.5 * tma_info_system_average_frequency * (OFFCORE_RESPO=
NSE.DEMAND_RFO.L3_HIT.HITM_OTHER_CORE + OFFCORE_RESPONSE.PF_L2_RFO.L3_HIT.H=
ITM_OTHER_CORE)) / tma_info_thread_clks",
         "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_store_bound_group",
         "MetricName": "tma_false_sharing",
         "MetricThreshold": "tma_false_sharing > 0.05 & (tma_store_bound > =
0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -262,11 +477,11 @@
     {
         "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
-        "MetricExpr": "tma_info_load_miss_real_latency * cpu@L1D_PEND_MISS=
.FB_FULL\\,cmask\\=3D1@ / tma_info_clks",
+        "MetricExpr": "tma_info_memory_load_miss_real_latency * cpu@L1D_PE=
ND_MISS.FB_FULL\\,cmask\\=3D1@ / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
@@ -274,14 +489,14 @@
         "MetricExpr": "tma_frontend_bound - tma_fetch_latency",
         "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_=
frontend_bound_group;tma_issueFB",
         "MetricName": "tma_fetch_bandwidth",
-        "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound=
 > 0.15 & tma_info_ipc / 4 > 0.35",
+        "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound=
 > 0.15 & tma_info_thread_ipc / 4 > 0.35",
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues",
-        "MetricExpr": "4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE=
 / tma_info_slots",
+        "MetricExpr": "4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE=
 / tma_info_thread_slots",
         "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend=
_bound_group",
         "MetricName": "tma_fetch_latency",
         "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound >=
 0.15",
@@ -356,7 +571,7 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_slots",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_thread_slots=
",
         "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
@@ -375,7 +590,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or micro-coded sequences",
-        "MetricExpr": "(UOPS_RETIRED.RETIRE_SLOTS + UOPS_RETIRED.MACRO_FUS=
ED - INST_RETIRED.ANY) / tma_info_slots",
+        "MetricExpr": "(UOPS_RETIRED.RETIRE_SLOTS + UOPS_RETIRED.MACRO_FUS=
ED - INST_RETIRED.ANY) / tma_info_thread_slots",
         "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_g=
roup",
         "MetricName": "tma_heavy_operations",
         "MetricThreshold": "tma_heavy_operations > 0.1",
@@ -385,7 +600,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses",
-        "MetricExpr": "(ICACHE_16B.IFDATA_STALL + 2 * cpu@ICACHE_16B.IFDAT=
A_STALL\\,cmask\\=3D1\\,edge@) / tma_info_clks",
+        "MetricExpr": "(ICACHE_16B.IFDATA_STALL + 2 * cpu@ICACHE_16B.IFDAT=
A_STALL\\,cmask\\=3D1\\,edge@) / tma_info_thread_clks",
         "MetricGroup": "BigFoot;FetchLat;IcMiss;TopdownL3;tma_L3_group;tma=
_fetch_latency_group",
         "MetricName": "tma_icache_misses",
         "MetricThreshold": "tma_icache_misses > 0.05 & (tma_fetch_latency =
> 0.1 & tma_frontend_bound > 0.15)",
@@ -393,686 +608,692 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Measured Average Frequency for unhalted proce=
ssors [GHz]",
-        "MetricExpr": "tma_info_turbo_utilization * TSC / 1e9 / duration_t=
ime",
-        "MetricGroup": "Power;Summary",
-        "MetricName": "tma_info_average_frequency"
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
+        "MetricExpr": "(tma_branch_mispredicts + tma_fetch_latency * tma_m=
ispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icache_=
misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) * tma_info_thread_sl=
ots / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;BrMispredicts;tma_issueBM",
+        "MetricName": "tma_info_bad_spec_branch_misprediction_cost",
+        "PublicDescription": "Branch Misprediction Cost: Fraction of TMA s=
lots wasted per non-speculative branch misprediction (retired JEClear). Rel=
ated metrics: tma_branch_mispredicts, tma_info_bottleneck_mispredictions, t=
ma_mispredicts_resteers"
+    },
+    {
+        "BriefDescription": "Instructions per retired mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
+        "MetricExpr": "tma_info_inst_mix_instructions / (UOPS_RETIRED.RETI=
RE_SLOTS / UOPS_ISSUED.ANY * cpu@BR_MISP_EXEC.ALL_BRANCHES\\,umask\\=3D0xE4=
@)",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "tma_info_bad_spec_ipmisp_indirect",
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1e3"
+    },
+    {
+        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "tma_info_core_ipmispredict",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts",
+        "MetricName": "tma_info_bad_spec_ipmispredict",
+        "MetricThreshold": "tma_info_bad_spec_ipmispredict < 200"
+    },
+    {
+        "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(100 * (1 - tma_core_bound / tma_ports_utilization =
if tma_core_bound < tma_ports_utilization else 1) if tma_info_system_smt_2t=
_utilization > 0.5 else 0)",
+        "MetricGroup": "Cor;SMT",
+        "MetricName": "tma_info_botlnk_l0_core_bound_likely",
+        "MetricThreshold": "tma_info_botlnk_l0_core_bound_likely > 0.5"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + =
tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb + tm=
a_mite))",
+        "MetricGroup": "DSBmiss;Fed;tma_issueFB",
+        "MetricName": "tma_info_botlnk_l2_dsb_misses",
+        "MetricThreshold": "tma_info_botlnk_l2_dsb_misses > 10",
+        "PublicDescription": "Total pipeline cost of DSB (uop cache) misse=
s - subset of the Instruction_Fetch_BW Bottleneck. Related metrics: tma_dsb=
_switches, tma_fetch_bandwidth, tma_info_frontend_dsb_coverage, tma_info_in=
st_mix_iptb, tma_lcp"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses +=
 tma_lcp + tma_ms_switches))",
+        "MetricGroup": "Fed;FetchLat;IcMiss;tma_issueFL",
+        "MetricName": "tma_info_botlnk_l2_ic_misses",
+        "MetricThreshold": "tma_info_botlnk_l2_ic_misses > 5",
+        "PublicDescription": "Total pipeline cost of Instruction Cache mis=
ses - subset of the Big_Code Bottleneck. Related metrics: "
     },
     {
         "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_branch_resteers + tma_dsb_switch=
es + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)",
         "MetricGroup": "BigFoot;Fed;Frontend;IcMiss;MemoryTLB;tma_issueBC"=
,
-        "MetricName": "tma_info_big_code",
-        "MetricThreshold": "tma_info_big_code > 20",
-        "PublicDescription": "Total pipeline cost of instruction fetch rel=
ated bottlenecks by large code footprint programs (i-side cache; TLB and BT=
B misses). Related metrics: tma_info_branching_overhead"
+        "MetricName": "tma_info_bottleneck_big_code",
+        "MetricThreshold": "tma_info_bottleneck_big_code > 20",
+        "PublicDescription": "Total pipeline cost of instruction fetch rel=
ated bottlenecks by large code footprint programs (i-side cache; TLB and BT=
B misses). Related metrics: tma_info_bottleneck_branching_overhead"
     },
     {
-        "BriefDescription": "Branch instructions per taken branch.",
-        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
-        "MetricGroup": "Branches;Fed;PGO",
-        "MetricName": "tma_info_bptkbranch"
+        "BriefDescription": "Total pipeline cost of branch related instruc=
tions (used for program control-flow including function calls)",
+        "MetricExpr": "100 * ((BR_INST_RETIRED.CONDITIONAL + 3 * BR_INST_R=
ETIRED.NEAR_CALL + (BR_INST_RETIRED.NEAR_TAKEN - (BR_INST_RETIRED.CONDITION=
AL - BR_INST_RETIRED.NOT_TAKEN) - 2 * BR_INST_RETIRED.NEAR_CALL)) / tma_inf=
o_thread_slots)",
+        "MetricGroup": "Ret;tma_issueBC",
+        "MetricName": "tma_info_bottleneck_branching_overhead",
+        "MetricThreshold": "tma_info_bottleneck_branching_overhead > 10",
+        "PublicDescription": "Total pipeline cost of branch related instru=
ctions (used for program control-flow including function calls). Related me=
trics: tma_info_bottleneck_big_code"
     },
     {
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
-        "MetricExpr": "(tma_branch_mispredicts + tma_fetch_latency * tma_m=
ispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icache_=
misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) * tma_info_slots / B=
R_MISP_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;BrMispredicts;tma_issueBM",
-        "MetricName": "tma_info_branch_misprediction_cost",
-        "PublicDescription": "Branch Misprediction Cost: Fraction of TMA s=
lots wasted per non-speculative branch misprediction (retired JEClear). Rel=
ated metrics: tma_branch_mispredicts, tma_info_mispredictions, tma_mispredi=
cts_resteers"
+        "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "100 * (tma_frontend_bound - tma_fetch_latency * tma=
_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icach=
e_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) - tma_info_bottlen=
eck_big_code",
+        "MetricGroup": "Fed;FetchBW;Frontend",
+        "MetricName": "tma_info_bottleneck_instruction_fetch_bw",
+        "MetricThreshold": "tma_info_bottleneck_instruction_fetch_bw > 20"
     },
     {
-        "BriefDescription": "Total pipeline cost of branch related instruc=
tions (used for program control-flow including function calls)",
-        "MetricExpr": "100 * ((BR_INST_RETIRED.CONDITIONAL + 3 * BR_INST_R=
ETIRED.NEAR_CALL + (BR_INST_RETIRED.NEAR_TAKEN - (BR_INST_RETIRED.CONDITION=
AL - BR_INST_RETIRED.NOT_TAKEN) - 2 * BR_INST_RETIRED.NEAR_CALL)) / tma_inf=
o_slots)",
-        "MetricGroup": "Ret;tma_issueBC",
-        "MetricName": "tma_info_branching_overhead",
-        "MetricThreshold": "tma_info_branching_overhead > 10",
-        "PublicDescription": "Total pipeline cost of branch related instru=
ctions (used for program control-flow including function calls). Related me=
trics: tma_info_big_code"
+        "BriefDescription": "Total pipeline cost of (external) Memory Band=
width related bottlenecks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (=
tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_l3_bound /=
 (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_b=
ound) * (tma_sq_full / (tma_contested_accesses + tma_data_sharing + tma_l3_=
hit_latency + tma_sq_full))) + tma_l1_bound / (tma_dram_bound + tma_l1_boun=
d + tma_l2_bound + tma_l3_bound + tma_store_bound) * (tma_fb_full / (tma_4k=
_aliasing + tma_dtlb_load + tma_fb_full + tma_lock_latency + tma_split_load=
s + tma_store_fwd_blk))",
+        "MetricGroup": "Mem;MemoryBW;Offcore;tma_issueBW",
+        "MetricName": "tma_info_bottleneck_memory_bandwidth",
+        "MetricThreshold": "tma_info_bottleneck_memory_bandwidth > 20",
+        "PublicDescription": "Total pipeline cost of (external) Memory Ban=
dwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_system_d=
ram_bw_use, tma_mem_bandwidth, tma_sq_full"
     },
     {
-        "BriefDescription": "Fraction of branches that are CALL or RET",
-        "MetricExpr": "(BR_INST_RETIRED.NEAR_CALL + BR_INST_RETIRED.NEAR_R=
ETURN) / BR_INST_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;Branches",
-        "MetricName": "tma_info_callret"
+        "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "100 * tma_memory_bound * (tma_l1_bound / max(tma_me=
mory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + t=
ma_store_bound) * (tma_dtlb_load / max(tma_l1_bound, tma_4k_aliasing + tma_=
dtlb_load + tma_fb_full + tma_lock_latency + tma_split_loads + tma_store_fw=
d_blk)) + tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound +=
 tma_l3_bound + tma_store_bound) * (tma_dtlb_store / (tma_dtlb_store + tma_=
false_sharing + tma_split_stores + tma_store_latency)))",
+        "MetricGroup": "Mem;MemoryTLB;Offcore;tma_issueTLB",
+        "MetricName": "tma_info_bottleneck_memory_data_tlbs",
+        "MetricThreshold": "tma_info_bottleneck_memory_data_tlbs > 20",
+        "PublicDescription": "Total pipeline cost of Memory Address Transl=
ation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_load,=
 tma_dtlb_store"
     },
     {
-        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "Pipeline",
-        "MetricName": "tma_info_clks"
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
3_hit_latency, tma_mem_latency"
     },
     {
-        "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
-        "MetricExpr": "1e3 * ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.ANY=
",
-        "MetricGroup": "Fed;MemoryTLB",
-        "MetricName": "tma_info_code_stlb_mpki"
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
spec_branch_misprediction_cost, tma_mispredicts_resteers"
+    },
+    {
+        "BriefDescription": "Fraction of branches that are CALL or RET",
+        "MetricExpr": "(BR_INST_RETIRED.NEAR_CALL + BR_INST_RETIRED.NEAR_R=
ETURN) / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;Branches",
+        "MetricName": "tma_info_branches_callret"
     },
     {
         "BriefDescription": "Fraction of branches that are non-taken condi=
tionals",
         "MetricExpr": "BR_INST_RETIRED.NOT_TAKEN / BR_INST_RETIRED.ALL_BRA=
NCHES",
         "MetricGroup": "Bad;Branches;CodeGen;PGO",
-        "MetricName": "tma_info_cond_nt"
+        "MetricName": "tma_info_branches_cond_nt"
     },
     {
         "BriefDescription": "Fraction of branches that are taken condition=
als",
         "MetricExpr": "(BR_INST_RETIRED.CONDITIONAL - BR_INST_RETIRED.NOT_=
TAKEN) / BR_INST_RETIRED.ALL_BRANCHES",
         "MetricGroup": "Bad;Branches;CodeGen;PGO",
-        "MetricName": "tma_info_cond_tk"
+        "MetricName": "tma_info_branches_cond_tk"
     },
     {
-        "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
+        "BriefDescription": "Fraction of branches that are unconditional (=
direct or indirect) jumps",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(100 * (1 - tma_core_bound / tma_ports_utilization =
if tma_core_bound < tma_ports_utilization else 1) if tma_info_smt_2t_utiliz=
ation > 0.5 else 0)",
-        "MetricGroup": "Cor;SMT",
-        "MetricName": "tma_info_core_bound_likely",
-        "MetricThreshold": "tma_info_core_bound_likely > 0.5"
+        "MetricExpr": "(BR_INST_RETIRED.NEAR_TAKEN - (BR_INST_RETIRED.COND=
ITIONAL - BR_INST_RETIRED.NOT_TAKEN) - 2 * BR_INST_RETIRED.NEAR_CALL) / BR_=
INST_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;Branches",
+        "MetricName": "tma_info_branches_jump"
     },
     {
         "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
-        "MetricExpr": "(CPU_CLK_UNHALTED.THREAD / 2 * (1 + CPU_CLK_UNHALTE=
D.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK) if #core_wide < 1 else (CP=
U_CLK_UNHALTED.THREAD_ANY / 2 if #SMT_on else tma_info_clks))",
+        "MetricExpr": "(CPU_CLK_UNHALTED.THREAD / 2 * (1 + CPU_CLK_UNHALTE=
D.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK) if #core_wide < 1 else (CP=
U_CLK_UNHALTED.THREAD_ANY / 2 if #SMT_on else tma_info_thread_clks))",
         "MetricGroup": "SMT",
-        "MetricName": "tma_info_core_clks"
+        "MetricName": "tma_info_core_core_clks"
     },
     {
         "BriefDescription": "Instructions Per Cycle across hyper-threads (=
per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / tma_info_core_clks",
+        "MetricExpr": "INST_RETIRED.ANY / tma_info_core_core_clks",
         "MetricGroup": "Ret;SMT;TmaL1;tma_L1_group",
-        "MetricName": "tma_info_coreipc"
+        "MetricName": "tma_info_core_coreipc"
     },
     {
-        "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
-        "MetricExpr": "1 / tma_info_ipc",
-        "MetricGroup": "Mem;Pipeline",
-        "MetricName": "tma_info_cpi"
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 =
* (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PA=
CKED_DOUBLE) + 8 * (FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INS=
T_RETIRED.512B_PACKED_DOUBLE) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SING=
LE) / tma_info_core_core_clks",
+        "MetricGroup": "Flops;Ret",
+        "MetricName": "tma_info_core_flopc"
     },
     {
-        "BriefDescription": "Average CPU Utilization",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
-        "MetricGroup": "HPC;Summary",
-        "MetricName": "tma_info_cpu_utilization"
+        "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
+        "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\,umask\\=3D0xfc@) =
/ (2 * tma_info_core_core_clks)",
+        "MetricGroup": "Cor;Flops;HPC",
+        "MetricName": "tma_info_core_fp_arith_utilization",
+        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)."
     },
     {
-        "BriefDescription": "Average Parallel L2 cache miss data reads",
-        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD / OFFCORE_=
REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
-        "MetricGroup": "Memory_BW;Offcore",
-        "MetricName": "tma_info_data_l2_mlp"
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
+        "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
+        "MetricName": "tma_info_core_ilp"
     },
     {
-        "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
-        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e=
9 / duration_time",
-        "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
-        "MetricName": "tma_info_dram_bw_use",
-        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_fb_full, tma_info_memory_ba=
ndwidth, tma_mem_bandwidth, tma_sq_full"
+        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_core_ipmispredict",
+        "MetricgroupNoGroup": "TopdownL1"
     },
     {
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
         "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + IDQ.MITE_UOPS + IDQ.=
MS_UOPS)",
         "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
-        "MetricName": "tma_info_dsb_coverage",
-        "MetricThreshold": "tma_info_dsb_coverage < 0.7 & tma_info_ipc / 4=
 > 0.35",
-        "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_dsb_misses, tma_info_iptb, tma_lcp"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + =
tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb + tm=
a_mite))",
-        "MetricGroup": "DSBmiss;Fed;tma_issueFB",
-        "MetricName": "tma_info_dsb_misses",
-        "MetricThreshold": "tma_info_dsb_misses > 10",
-        "PublicDescription": "Total pipeline cost of DSB (uop cache) misse=
s - subset of the Instruction_Fetch_BW Bottleneck. Related metrics: tma_dsb=
_switches, tma_fetch_bandwidth, tma_info_dsb_coverage, tma_info_iptb, tma_l=
cp"
+        "MetricName": "tma_info_frontend_dsb_coverage",
+        "MetricThreshold": "tma_info_frontend_dsb_coverage < 0.7 & tma_inf=
o_thread_ipc / 4 > 0.35",
+        "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_inst_mix_iptb, tma_lcp"
     },
     {
         "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
.",
         "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / DSB2MITE_SWITCHE=
S.COUNT",
         "MetricGroup": "DSBmiss",
-        "MetricName": "tma_info_dsb_switch_cost"
-    },
-    {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-thread",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D1@",
-        "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
-        "MetricName": "tma_info_execute"
-    },
-    {
-        "BriefDescription": "The ratio of Executed- by Issued-Uops",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / UOPS_ISSUED.ANY",
-        "MetricGroup": "Cor;Pipeline",
-        "MetricName": "tma_info_execute_per_issue",
-        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage."
-    },
-    {
-        "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
-        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.FB_HIT / INST_RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_fb_hpki"
+        "MetricName": "tma_info_frontend_dsb_switch_cost"
     },
     {
         "BriefDescription": "Average number of Uops issued by front-end wh=
en it issued something",
         "MetricExpr": "UOPS_ISSUED.ANY / cpu@UOPS_ISSUED.ANY\\,cmask\\=3D1=
@",
         "MetricGroup": "Fed;FetchBW",
-        "MetricName": "tma_info_fetch_upc"
+        "MetricName": "tma_info_frontend_fetch_upc"
     },
     {
-        "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 =
* (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PA=
CKED_DOUBLE) + 8 * (FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INS=
T_RETIRED.512B_PACKED_DOUBLE) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SING=
LE) / tma_info_core_clks",
-        "MetricGroup": "Flops;Ret",
-        "MetricName": "tma_info_flopc"
-    },
-    {
-        "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\,umask\\=3D0xfc@) =
/ (2 * tma_info_core_clks)",
-        "MetricGroup": "Cor;Flops;HPC",
-        "MetricName": "tma_info_fp_arith_utilization",
-        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)."
+        "BriefDescription": "Average Latency for L1 instruction cache miss=
es",
+        "MetricExpr": "ICACHE_16B.IFDATA_STALL / cpu@ICACHE_16B.IFDATA_STA=
LL\\,cmask\\=3D1\\,edge@ + 2",
+        "MetricGroup": "Fed;FetchLat;IcMiss",
+        "MetricName": "tma_info_frontend_icache_miss_latency"
     },
     {
-        "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 =
* (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PA=
CKED_DOUBLE) + 8 * (FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INS=
T_RETIRED.512B_PACKED_DOUBLE) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SING=
LE) / 1e9 / duration_time",
-        "MetricGroup": "Cor;Flops;HPC",
-        "MetricName": "tma_info_gflops",
-        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine."
+        "BriefDescription": "Instructions per non-speculative DSB miss (lo=
wer number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / FRONTEND_RETIRED.ANY_DSB_MISS",
+        "MetricGroup": "DSBmiss;Fed",
+        "MetricName": "tma_info_frontend_ipdsb_miss_ret",
+        "MetricThreshold": "tma_info_frontend_ipdsb_miss_ret < 50"
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
ses - subset of the Big_Code Bottleneck. Related metrics: "
+        "BriefDescription": "Instructions per speculative Unknown Branch M=
isprediction (BAClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "tma_info_inst_mix_instructions / BACLEARS.ANY",
+        "MetricGroup": "Fed",
+        "MetricName": "tma_info_frontend_ipunknown_branch"
     },
     {
-        "BriefDescription": "Average Latency for L1 instruction cache miss=
es",
-        "MetricExpr": "ICACHE_16B.IFDATA_STALL / cpu@ICACHE_16B.IFDATA_STA=
LL\\,cmask\\=3D1\\,edge@ + 2",
-        "MetricGroup": "Fed;FetchLat;IcMiss",
-        "MetricName": "tma_info_icache_miss_latency"
+        "BriefDescription": "L2 cache true code cacheline misses per kilo =
instruction",
+        "MetricExpr": "1e3 * FRONTEND_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "IcMiss",
+        "MetricName": "tma_info_frontend_l2mpki_code"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
-        "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
-        "MetricName": "tma_info_ilp"
+        "BriefDescription": "L2 cache speculative code cacheline misses pe=
r kilo instruction",
+        "MetricExpr": "1e3 * L2_RQSTS.CODE_RD_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "IcMiss",
+        "MetricName": "tma_info_frontend_l2mpki_code_all"
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
-        "MetricThreshold": "tma_info_instruction_fetch_bw > 20"
+        "BriefDescription": "Branch instructions per taken branch.",
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
+        "MetricGroup": "Branches;Fed;PGO",
+        "MetricName": "tma_info_inst_mix_bptkbranch"
     },
     {
         "BriefDescription": "Total number of retired Instructions",
         "MetricExpr": "INST_RETIRED.ANY",
         "MetricGroup": "Summary;TmaL1;tma_L1_group",
-        "MetricName": "tma_info_instructions",
+        "MetricName": "tma_info_inst_mix_instructions",
         "PublicDescription": "Total number of retired Instructions. Sample=
 with: INST_RETIRED.PREC_DIST"
     },
-    {
-        "BriefDescription": "Average IO (network or disk) Bandwidth Use fo=
r Reads [GB / sec]",
-        "MetricExpr": "(UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 + UNC_IIO_=
DATA_REQ_OF_CPU.MEM_WRITE.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 +=
 UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3) * 4 / 1e9 / duration_time",
-        "MetricGroup": "IoBW;Mem;Server;SoC",
-        "MetricName": "tma_info_io_read_bw"
-    },
-    {
-        "BriefDescription": "Average IO (network or disk) Bandwidth Use fo=
r Writes [GB / sec]",
-        "MetricExpr": "(UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 + UNC_IIO_D=
ATA_REQ_OF_CPU.MEM_READ.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 + UN=
C_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3) * 4 / 1e9 / duration_time",
-        "MetricGroup": "IoBW;Mem;Server;SoC",
-        "MetricName": "tma_info_io_write_bw"
-    },
     {
         "BriefDescription": "Instructions per FP Arithmetic instruction (l=
ower number means higher occurrence rate)",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "INST_RETIRED.ANY / (cpu@FP_ARITH_INST_RETIRED.SCALA=
R_SINGLE\\,umask\\=3D0x03@ + cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\=
,umask\\=3D0xfc@)",
         "MetricGroup": "Flops;InsType",
-        "MetricName": "tma_info_iparith",
-        "MetricThreshold": "tma_info_iparith < 10",
+        "MetricName": "tma_info_inst_mix_iparith",
+        "MetricThreshold": "tma_info_inst_mix_iparith < 10",
         "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). May undercount due to FMA doubl=
e counting. Approximated prior to BDW."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-bi=
t instruction (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.128B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE)",
         "MetricGroup": "Flops;FpVector;InsType",
-        "MetricName": "tma_info_iparith_avx128",
-        "MetricThreshold": "tma_info_iparith_avx128 < 10",
+        "MetricName": "tma_info_inst_mix_iparith_avx128",
+        "MetricThreshold": "tma_info_inst_mix_iparith_avx128 < 10",
         "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). May undercount =
due to FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX* 256-bit i=
nstruction (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.256B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE)",
         "MetricGroup": "Flops;FpVector;InsType",
-        "MetricName": "tma_info_iparith_avx256",
-        "MetricThreshold": "tma_info_iparith_avx256 < 10",
+        "MetricName": "tma_info_inst_mix_iparith_avx256",
+        "MetricThreshold": "tma_info_inst_mix_iparith_avx256 < 10",
         "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). May undercount due=
 to FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX 512-bit in=
struction (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.512B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE)",
         "MetricGroup": "Flops;FpVector;InsType",
-        "MetricName": "tma_info_iparith_avx512",
-        "MetricThreshold": "tma_info_iparith_avx512 < 10",
+        "MetricName": "tma_info_inst_mix_iparith_avx512",
+        "MetricThreshold": "tma_info_inst_mix_iparith_avx512 < 10",
         "PublicDescription": "Instructions per FP Arithmetic AVX 512-bit i=
nstruction (lower number means higher occurrence rate). May undercount due =
to FMA double counting."
     },
     {
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
ercount due to FMA double counting."
     },
     {
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
ercount due to FMA double counting."
     },
     {
         "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
         "MetricGroup": "Branches;Fed;InsType",
-        "MetricName": "tma_info_ipbranch",
-        "MetricThreshold": "tma_info_ipbranch < 8"
-    },
-    {
-        "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
-        "MetricExpr": "INST_RETIRED.ANY / tma_info_clks",
-        "MetricGroup": "Ret;Summary",
-        "MetricName": "tma_info_ipc"
+        "MetricName": "tma_info_inst_mix_ipbranch",
+        "MetricThreshold": "tma_info_inst_mix_ipbranch < 8"
     },
     {
         "BriefDescription": "Instructions per (near) call (lower number me=
ans higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
         "MetricGroup": "Branches;Fed;PGO",
-        "MetricName": "tma_info_ipcall",
-        "MetricThreshold": "tma_info_ipcall < 200"
-    },
-    {
-        "BriefDescription": "Instructions per non-speculative DSB miss (lo=
wer number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / FRONTEND_RETIRED.ANY_DSB_MISS",
-        "MetricGroup": "DSBmiss;Fed",
-        "MetricName": "tma_info_ipdsb_miss_ret",
-        "MetricThreshold": "tma_info_ipdsb_miss_ret < 50"
-    },
-    {
-        "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
-        "MetricGroup": "Branches;OS",
-        "MetricName": "tma_info_ipfarbranch",
-        "MetricThreshold": "tma_info_ipfarbranch < 1e6"
+        "MetricName": "tma_info_inst_mix_ipcall",
+        "MetricThreshold": "tma_info_inst_mix_ipcall < 200"
     },
     {
         "BriefDescription": "Instructions per Floating Point (FP) Operatio=
n (lower number means higher occurrence rate)",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR_SI=
NGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE + 2 * FP_ARITH_INST_RETIRED.128B=
_PACKED_DOUBLE + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_I=
NST_RETIRED.256B_PACKED_DOUBLE) + 8 * (FP_ARITH_INST_RETIRED.256B_PACKED_SI=
NGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE) + 16 * FP_ARITH_INST_RETIR=
ED.512B_PACKED_SINGLE)",
         "MetricGroup": "Flops;InsType",
-        "MetricName": "tma_info_ipflop",
-        "MetricThreshold": "tma_info_ipflop < 10"
+        "MetricName": "tma_info_inst_mix_ipflop",
+        "MetricThreshold": "tma_info_inst_mix_ipflop < 10"
     },
     {
-        "BriefDescription": "Instructions per Load (lower number means hig=
her occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_LOADS",
-        "MetricGroup": "InsType",
-        "MetricName": "tma_info_ipload",
-        "MetricThreshold": "tma_info_ipload < 3"
-    },
-    {
-        "BriefDescription": "Instructions per retired mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
-        "MetricExpr": "tma_info_instructions / (UOPS_RETIRED.RETIRE_SLOTS =
/ UOPS_ISSUED.ANY * cpu@BR_MISP_EXEC.ALL_BRANCHES\\,umask\\=3D0xE4@)",
-        "MetricGroup": "Bad;BrMispredicts",
-        "MetricName": "tma_info_ipmisp_indirect",
-        "MetricThreshold": "tma_info_ipmisp_indirect < 1e3"
-    },
-    {
-        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;BadSpec;BrMispredicts",
-        "MetricName": "tma_info_ipmispredict",
-        "MetricThreshold": "tma_info_ipmispredict < 200"
+        "BriefDescription": "Instructions per Load (lower number means hig=
her occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_LOADS",
+        "MetricGroup": "InsType",
+        "MetricName": "tma_info_inst_mix_ipload",
+        "MetricThreshold": "tma_info_inst_mix_ipload < 3"
     },
     {
         "BriefDescription": "Instructions per Store (lower number means hi=
gher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_STORES",
         "MetricGroup": "InsType",
-        "MetricName": "tma_info_ipstore",
-        "MetricThreshold": "tma_info_ipstore < 8"
+        "MetricName": "tma_info_inst_mix_ipstore",
+        "MetricThreshold": "tma_info_inst_mix_ipstore < 8"
     },
     {
         "BriefDescription": "Instructions per Software prefetch instructio=
n (of any type: NTA/T0/T1/T2/Prefetch) (lower number means higher occurrenc=
e rate)",
         "MetricExpr": "INST_RETIRED.ANY / cpu@SW_PREFETCH_ACCESS.T0\\,umas=
k\\=3D0xF@",
         "MetricGroup": "Prefetches",
-        "MetricName": "tma_info_ipswpf",
-        "MetricThreshold": "tma_info_ipswpf < 100"
+        "MetricName": "tma_info_inst_mix_ipswpf",
+        "MetricThreshold": "tma_info_inst_mix_ipswpf < 100"
     },
     {
         "BriefDescription": "Instruction per taken branch",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
         "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO;tma_issueFB",
-        "MetricName": "tma_info_iptb",
-        "MetricThreshold": "tma_info_iptb < 9",
-        "PublicDescription": "Instruction per taken branch. Related metric=
s: tma_dsb_switches, tma_fetch_bandwidth, tma_info_dsb_coverage, tma_info_d=
sb_misses, tma_lcp"
+        "MetricName": "tma_info_inst_mix_iptb",
+        "MetricThreshold": "tma_info_inst_mix_iptb < 9",
+        "PublicDescription": "Instruction per taken branch. Related metric=
s: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_misses, tm=
a_info_frontend_dsb_coverage, tma_lcp"
     },
     {
-        "BriefDescription": "Instructions per speculative Unknown Branch M=
isprediction (BAClear) (lower number means higher occurrence rate)",
-        "MetricExpr": "tma_info_instructions / BACLEARS.ANY",
-        "MetricGroup": "Fed",
-        "MetricName": "tma_info_ipunknown_branch"
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / duration_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_core_l1d_cache_fill_bw"
     },
     {
-        "BriefDescription": "Fraction of branches that are unconditional (=
direct or indirect) jumps",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(BR_INST_RETIRED.NEAR_TAKEN - (BR_INST_RETIRED.COND=
ITIONAL - BR_INST_RETIRED.NOT_TAKEN) - 2 * BR_INST_RETIRED.NEAR_CALL) / BR_=
INST_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;Branches",
-        "MetricName": "tma_info_jump"
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / duration_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_core_l2_cache_fill_bw"
     },
     {
-        "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
-        "MetricGroup": "OS",
-        "MetricName": "tma_info_kernel_cpi"
+        "BriefDescription": "Rate of non silent evictions from the L2 cach=
e per Kilo instruction",
+        "MetricExpr": "1e3 * L2_LINES_OUT.NON_SILENT / tma_info_inst_mix_i=
nstructions",
+        "MetricGroup": "L2Evicts;Mem;Server",
+        "MetricName": "tma_info_memory_core_l2_evictions_nonsilent_pki"
     },
     {
-        "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.THRE=
AD",
-        "MetricGroup": "OS",
-        "MetricName": "tma_info_kernel_utilization",
-        "MetricThreshold": "tma_info_kernel_utilization > 0.05"
+        "BriefDescription": "Rate of silent evictions from the L2 cache pe=
r Kilo instruction where the evicted lines are dropped (no writeback to L3 =
or memory)",
+        "MetricExpr": "1e3 * L2_LINES_OUT.SILENT / tma_info_inst_mix_instr=
uctions",
+        "MetricGroup": "L2Evicts;Mem;Server",
+        "MetricName": "tma_info_memory_core_l2_evictions_silent_pki"
     },
     {
-        "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / duration_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l1d_cache_fill_bw"
+        "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
+        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1e9 / duration=
_time",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "tma_info_memory_core_l3_cache_access_bw"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
-        "MetricExpr": "tma_info_l1d_cache_fill_bw",
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / duration_time",
         "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l1d_cache_fill_bw_1t"
+        "MetricName": "tma_info_memory_core_l3_cache_fill_bw"
+    },
+    {
+        "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
+        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.FB_HIT / INST_RETIRED.ANY",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "tma_info_memory_fb_hpki"
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY",
         "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l1mpki"
+        "MetricName": "tma_info_memory_l1mpki"
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 all demand loads (including speculative)",
         "MetricExpr": "1e3 * L2_RQSTS.ALL_DEMAND_DATA_RD / INST_RETIRED.AN=
Y",
         "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l1mpki_load"
-    },
-    {
-        "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / duration_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l2_cache_fill_bw"
-    },
-    {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
-        "MetricExpr": "tma_info_l2_cache_fill_bw",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l2_cache_fill_bw_1t"
-    },
-    {
-        "BriefDescription": "Rate of non silent evictions from the L2 cach=
e per Kilo instruction",
-        "MetricExpr": "1e3 * L2_LINES_OUT.NON_SILENT / tma_info_instructio=
ns",
-        "MetricGroup": "L2Evicts;Mem;Server",
-        "MetricName": "tma_info_l2_evictions_nonsilent_pki"
-    },
-    {
-        "BriefDescription": "Rate of silent evictions from the L2 cache pe=
r Kilo instruction where the evicted lines are dropped (no writeback to L3 =
or memory)",
-        "MetricExpr": "1e3 * L2_LINES_OUT.SILENT / tma_info_instructions",
-        "MetricGroup": "L2Evicts;Mem;Server",
-        "MetricName": "tma_info_l2_evictions_silent_pki"
+        "MetricName": "tma_info_memory_l1mpki_load"
     },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all re=
quest types (including speculative)",
         "MetricExpr": "1e3 * (L2_RQSTS.REFERENCES - L2_RQSTS.MISS) / INST_=
RETIRED.ANY",
         "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l2hpki_all"
+        "MetricName": "tma_info_memory_l2hpki_all"
     },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all de=
mand loads  (including speculative)",
         "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_HIT / INST_RETIRED.AN=
Y",
         "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l2hpki_load"
+        "MetricName": "tma_info_memory_l2hpki_load"
     },
     {
         "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
         "MetricGroup": "Backend;CacheMisses;Mem",
-        "MetricName": "tma_info_l2mpki"
+        "MetricName": "tma_info_memory_l2mpki"
     },
     {
         "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all request types (including speculative)",
         "MetricExpr": "1e3 * L2_RQSTS.MISS / INST_RETIRED.ANY",
         "MetricGroup": "CacheMisses;Mem;Offcore",
-        "MetricName": "tma_info_l2mpki_all"
-    },
-    {
-        "BriefDescription": "L2 cache true code cacheline misses per kilo =
instruction",
-        "MetricExpr": "1e3 * FRONTEND_RETIRED.L2_MISS / INST_RETIRED.ANY",
-        "MetricGroup": "IcMiss",
-        "MetricName": "tma_info_l2mpki_code"
-    },
-    {
-        "BriefDescription": "L2 cache speculative code cacheline misses pe=
r kilo instruction",
-        "MetricExpr": "1e3 * L2_RQSTS.CODE_RD_MISS / INST_RETIRED.ANY",
-        "MetricGroup": "IcMiss",
-        "MetricName": "tma_info_l2mpki_code_all"
+        "MetricName": "tma_info_memory_l2mpki_all"
     },
     {
         "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all demand loads  (including speculative)",
         "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_MISS / INST_RETIRED.A=
NY",
         "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l2mpki_load"
-    },
-    {
-        "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1e9 / duration=
_time",
-        "MetricGroup": "Mem;MemoryBW;Offcore",
-        "MetricName": "tma_info_l3_cache_access_bw"
+        "MetricName": "tma_info_memory_l2mpki_load"
     },
     {
-        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
-        "MetricExpr": "tma_info_l3_cache_access_bw",
-        "MetricGroup": "Mem;MemoryBW;Offcore",
-        "MetricName": "tma_info_l3_cache_access_bw_1t"
+        "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "tma_info_memory_l3mpki"
     },
     {
-        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / duration_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l3_cache_fill_bw"
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / (MEM_LOAD_RETIRED.L1_MISS +=
 MEM_LOAD_RETIRED.FB_HIT)",
+        "MetricGroup": "Mem;MemoryBound;MemoryLat",
+        "MetricName": "tma_info_memory_load_miss_real_latency"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "tma_info_l3_cache_fill_bw",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l3_cache_fill_bw_1t"
+        "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLE=
S",
+        "MetricGroup": "Mem;MemoryBW;MemoryBound",
+        "MetricName": "tma_info_memory_mlp",
+        "PublicDescription": "Memory-Level-Parallelism (average number of =
L1 miss demand load when there is at least one such miss. Per-Logical Proce=
ssor)"
     },
     {
-        "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l3mpki"
+        "BriefDescription": "Average Parallel L2 cache miss data reads",
+        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD / OFFCORE_=
REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
+        "MetricGroup": "Memory_BW;Offcore",
+        "MetricName": "tma_info_memory_oro_data_l2_mlp"
     },
     {
         "BriefDescription": "Average Latency for L2 cache miss demand Load=
s",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS.DEMAND_DATA_RD",
         "MetricGroup": "Memory_Lat;Offcore",
-        "MetricName": "tma_info_load_l2_miss_latency"
+        "MetricName": "tma_info_memory_oro_load_l2_miss_latency"
     },
     {
         "BriefDescription": "Average Parallel L2 cache miss demand Loads",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_DATA_RD",
         "MetricGroup": "Memory_BW;Offcore",
-        "MetricName": "tma_info_load_l2_mlp"
+        "MetricName": "tma_info_memory_oro_load_l2_mlp"
     },
     {
-        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / (MEM_LOAD_RETIRED.L1_MISS +=
 MEM_LOAD_RETIRED.FB_HIT)",
-        "MetricGroup": "Mem;MemoryBound;MemoryLat",
-        "MetricName": "tma_info_load_miss_real_latency"
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_core_l1d_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_thread_l1d_cache_fill_bw_1t"
+    },
+    {
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_core_l2_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_thread_l2_cache_fill_bw_1t"
+    },
+    {
+        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_core_l3_cache_access_bw",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "tma_info_memory_thread_l3_cache_access_bw_1t"
+    },
+    {
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_core_l3_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_thread_l3_cache_fill_bw_1t"
+    },
+    {
+        "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
+        "MetricExpr": "1e3 * ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.ANY=
",
+        "MetricGroup": "Fed;MemoryTLB",
+        "MetricName": "tma_info_memory_tlb_code_stlb_mpki"
     },
     {
         "BriefDescription": "STLB (2nd level TLB) data load speculative mi=
sses per kilo instruction (misses of any page-size that complete the page w=
alk)",
         "MetricExpr": "1e3 * DTLB_LOAD_MISSES.WALK_COMPLETED / INST_RETIRE=
D.ANY",
         "MetricGroup": "Mem;MemoryTLB",
-        "MetricName": "tma_info_load_stlb_mpki"
+        "MetricName": "tma_info_memory_tlb_load_stlb_mpki"
     },
     {
-        "BriefDescription": "Average latency of data read request to exter=
nal DRAM memory [in nanoseconds]",
-        "MetricExpr": "1e9 * (UNC_M_RPQ_OCCUPANCY / UNC_M_RPQ_INSERTS) / i=
mc_0@event\\=3D0x0@",
-        "MetricGroup": "Mem;MemoryLat;Server;SoC",
-        "MetricName": "tma_info_mem_dram_read_latency",
-        "PublicDescription": "Average latency of data read request to exte=
rnal DRAM memory [in nanoseconds]. Accounts for demand loads and L1/L2 data=
-read prefetches"
+        "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
+        "MetricExpr": "(ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_P=
ENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING) / (2 * tma_info=
_core_core_clks)",
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_tlb_page_walks_utilization",
+        "MetricThreshold": "tma_info_memory_tlb_page_walks_utilization > 0=
.5"
     },
     {
-        "BriefDescription": "Average number of parallel data read requests=
 to external memory",
-        "MetricExpr": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / UNC_CHA_TOR_OCC=
UPANCY.IA_MISS_DRD@thresh\\=3D1@",
-        "MetricGroup": "Mem;MemoryBW;SoC",
-        "MetricName": "tma_info_mem_parallel_reads",
-        "PublicDescription": "Average number of parallel data read request=
s to external memory. Accounts for demand loads and L1/L2 prefetches"
+        "BriefDescription": "STLB (2nd level TLB) data store speculative m=
isses per kilo instruction (misses of any page-size that complete the page =
walk)",
+        "MetricExpr": "1e3 * DTLB_STORE_MISSES.WALK_COMPLETED / INST_RETIR=
ED.ANY",
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_tlb_store_stlb_mpki"
     },
     {
-        "BriefDescription": "Average latency of data read request to exter=
nal memory (in nanoseconds)",
-        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / UNC_CHA_=
TOR_INSERTS.IA_MISS_DRD) / (tma_info_socket_clks / duration_time)",
-        "MetricGroup": "Mem;MemoryLat;SoC",
-        "MetricName": "tma_info_mem_read_latency",
-        "PublicDescription": "Average latency of data read request to exte=
rnal memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetche=
s. ([RKL+]memory-controller only)"
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-thread",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D1@",
+        "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
+        "MetricName": "tma_info_pipeline_execute"
     },
     {
-        "BriefDescription": "Total pipeline cost of (external) Memory Band=
width related bottlenecks",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (=
tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_l3_bound /=
 (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_b=
ound) * (tma_sq_full / (tma_contested_accesses + tma_data_sharing + tma_l3_=
hit_latency + tma_sq_full))) + tma_l1_bound / (tma_dram_bound + tma_l1_boun=
d + tma_l2_bound + tma_l3_bound + tma_store_bound) * (tma_fb_full / (tma_4k=
_aliasing + tma_dtlb_load + tma_fb_full + tma_lock_latency + tma_split_load=
s + tma_store_fwd_blk))",
-        "MetricGroup": "Mem;MemoryBW;Offcore;tma_issueBW",
-        "MetricName": "tma_info_memory_bandwidth",
-        "MetricThreshold": "tma_info_memory_bandwidth > 20",
-        "PublicDescription": "Total pipeline cost of (external) Memory Ban=
dwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_dram_bw_=
use, tma_mem_bandwidth, tma_sq_full"
+        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / cpu@UOPS_RETIRED.RETIRE=
_SLOTS\\,cmask\\=3D1@",
+        "MetricGroup": "Pipeline;Ret",
+        "MetricName": "tma_info_pipeline_retire"
     },
     {
-        "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * tma_memory_bound * (tma_l1_bound / max(tma_me=
mory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + t=
ma_store_bound) * (tma_dtlb_load / max(tma_l1_bound, tma_4k_aliasing + tma_=
dtlb_load + tma_fb_full + tma_lock_latency + tma_split_loads + tma_store_fw=
d_blk)) + tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound +=
 tma_l3_bound + tma_store_bound) * (tma_dtlb_store / (tma_dtlb_store + tma_=
false_sharing + tma_split_stores + tma_store_latency)))",
-        "MetricGroup": "Mem;MemoryTLB;Offcore;tma_issueTLB",
-        "MetricName": "tma_info_memory_data_tlbs",
-        "MetricThreshold": "tma_info_memory_data_tlbs > 20",
-        "PublicDescription": "Total pipeline cost of Memory Address Transl=
ation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_load,=
 tma_dtlb_store"
+        "BriefDescription": "Measured Average Frequency for unhalted proce=
ssors [GHz]",
+        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / dur=
ation_time",
+        "MetricGroup": "Power;Summary",
+        "MetricName": "tma_info_system_average_frequency"
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
3_hit_latency, tma_mem_latency"
+        "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricGroup": "HPC;Summary",
+        "MetricName": "tma_info_system_cpu_utilization"
     },
     {
-        "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
+        "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
+        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e=
9 / duration_time",
+        "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
+        "MetricName": "tma_info_system_dram_bw_use",
+        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_fb_full, tma_info_bottlenec=
k_memory_bandwidth, tma_mem_bandwidth, tma_sq_full"
+    },
+    {
+        "BriefDescription": "Giga Floating Point Operations Per Second",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * (tma_branch_mispredicts + tma_fetch_latency *=
 tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_i=
cache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
-        "MetricGroup": "Bad;BadSpec;BrMispredicts;tma_issueBM",
-        "MetricName": "tma_info_mispredictions",
-        "MetricThreshold": "tma_info_mispredictions > 20",
-        "PublicDescription": "Total pipeline cost of Branch Misprediction =
related bottlenecks. Related metrics: tma_branch_mispredicts, tma_info_bran=
ch_misprediction_cost, tma_mispredicts_resteers"
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 =
* (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PA=
CKED_DOUBLE) + 8 * (FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INS=
T_RETIRED.512B_PACKED_DOUBLE) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SING=
LE) / 1e9 / duration_time",
+        "MetricGroup": "Cor;Flops;HPC",
+        "MetricName": "tma_info_system_gflops",
+        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine."
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
ssor)"
+        "BriefDescription": "Average IO (network or disk) Bandwidth Use fo=
r Reads [GB / sec]",
+        "MetricExpr": "(UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 + UNC_IIO_=
DATA_REQ_OF_CPU.MEM_WRITE.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 +=
 UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3) * 4 / 1e9 / duration_time",
+        "MetricGroup": "IoBW;Mem;Server;SoC",
+        "MetricName": "tma_info_system_io_read_bw"
     },
     {
-        "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
-        "MetricExpr": "(ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_P=
ENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING) / (2 * tma_info=
_core_clks)",
-        "MetricGroup": "Mem;MemoryTLB",
-        "MetricName": "tma_info_page_walks_utilization",
-        "MetricThreshold": "tma_info_page_walks_utilization > 0.5"
+        "BriefDescription": "Average IO (network or disk) Bandwidth Use fo=
r Writes [GB / sec]",
+        "MetricExpr": "(UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 + UNC_IIO_D=
ATA_REQ_OF_CPU.MEM_READ.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 + UN=
C_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3) * 4 / 1e9 / duration_time",
+        "MetricGroup": "IoBW;Mem;Server;SoC",
+        "MetricName": "tma_info_system_io_write_bw"
+    },
+    {
+        "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
+        "MetricGroup": "Branches;OS",
+        "MetricName": "tma_info_system_ipfarbranch",
+        "MetricThreshold": "tma_info_system_ipfarbranch < 1e6"
+    },
+    {
+        "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
+        "MetricGroup": "OS",
+        "MetricName": "tma_info_system_kernel_cpi"
+    },
+    {
+        "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.THRE=
AD",
+        "MetricGroup": "OS",
+        "MetricName": "tma_info_system_kernel_utilization",
+        "MetricThreshold": "tma_info_system_kernel_utilization > 0.05"
+    },
+    {
+        "BriefDescription": "Average latency of data read request to exter=
nal DRAM memory [in nanoseconds]",
+        "MetricExpr": "1e9 * (UNC_M_RPQ_OCCUPANCY / UNC_M_RPQ_INSERTS) / i=
mc_0@event\\=3D0x0@",
+        "MetricGroup": "Mem;MemoryLat;Server;SoC",
+        "MetricName": "tma_info_system_mem_dram_read_latency",
+        "PublicDescription": "Average latency of data read request to exte=
rnal DRAM memory [in nanoseconds]. Accounts for demand loads and L1/L2 data=
-read prefetches"
+    },
+    {
+        "BriefDescription": "Average number of parallel data read requests=
 to external memory",
+        "MetricExpr": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / UNC_CHA_TOR_OCC=
UPANCY.IA_MISS_DRD@thresh\\=3D1@",
+        "MetricGroup": "Mem;MemoryBW;SoC",
+        "MetricName": "tma_info_system_mem_parallel_reads",
+        "PublicDescription": "Average number of parallel data read request=
s to external memory. Accounts for demand loads and L1/L2 prefetches"
+    },
+    {
+        "BriefDescription": "Average latency of data read request to exter=
nal memory (in nanoseconds)",
+        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / UNC_CHA_=
TOR_INSERTS.IA_MISS_DRD) / (tma_info_system_socket_clks / duration_time)",
+        "MetricGroup": "Mem;MemoryLat;SoC",
+        "MetricName": "tma_info_system_mem_read_latency",
+        "PublicDescription": "Average latency of data read request to exte=
rnal memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetche=
s. ([RKL+]memory-controller only)"
     },
     {
         "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for baseline license level 0",
-        "MetricExpr": "(CORE_POWER.LVL0_TURBO_LICENSE / 2 / tma_info_core_=
clks if #SMT_on else CORE_POWER.LVL0_TURBO_LICENSE / tma_info_core_clks)",
+        "MetricExpr": "(CORE_POWER.LVL0_TURBO_LICENSE / 2 / tma_info_core_=
core_clks if #SMT_on else CORE_POWER.LVL0_TURBO_LICENSE / tma_info_core_cor=
e_clks)",
         "MetricGroup": "Power",
-        "MetricName": "tma_info_power_license0_utilization",
+        "MetricName": "tma_info_system_power_license0_utilization",
         "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for baseline license level 0.  This includes non=
-AVX codes, SSE, AVX 128-bit, and low-current AVX 256-bit codes."
     },
     {
         "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for license level 1",
-        "MetricExpr": "(CORE_POWER.LVL1_TURBO_LICENSE / 2 / tma_info_core_=
clks if #SMT_on else CORE_POWER.LVL1_TURBO_LICENSE / tma_info_core_clks)",
+        "MetricExpr": "(CORE_POWER.LVL1_TURBO_LICENSE / 2 / tma_info_core_=
core_clks if #SMT_on else CORE_POWER.LVL1_TURBO_LICENSE / tma_info_core_cor=
e_clks)",
         "MetricGroup": "Power",
-        "MetricName": "tma_info_power_license1_utilization",
-        "MetricThreshold": "tma_info_power_license1_utilization > 0.5",
+        "MetricName": "tma_info_system_power_license1_utilization",
+        "MetricThreshold": "tma_info_system_power_license1_utilization > 0=
.5",
         "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for license level 1.  This includes high current=
 AVX 256-bit instructions as well as low current AVX 512-bit instructions."
     },
     {
         "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for license level 2 (introduced in SKX)",
-        "MetricExpr": "(CORE_POWER.LVL2_TURBO_LICENSE / 2 / tma_info_core_=
clks if #SMT_on else CORE_POWER.LVL2_TURBO_LICENSE / tma_info_core_clks)",
+        "MetricExpr": "(CORE_POWER.LVL2_TURBO_LICENSE / 2 / tma_info_core_=
core_clks if #SMT_on else CORE_POWER.LVL2_TURBO_LICENSE / tma_info_core_cor=
e_clks)",
         "MetricGroup": "Power",
-        "MetricName": "tma_info_power_license2_utilization",
-        "MetricThreshold": "tma_info_power_license2_utilization > 0.5",
+        "MetricName": "tma_info_system_power_license2_utilization",
+        "MetricThreshold": "tma_info_system_power_license2_utilization > 0=
.5",
         "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for license level 2 (introduced in SKX).  This i=
ncludes high current AVX 512-bit instructions."
     },
-    {
-        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / cpu@UOPS_RETIRED.RETIRE=
_SLOTS\\,cmask\\=3D1@",
-        "MetricGroup": "Pipeline;Ret",
-        "MetricName": "tma_info_retire"
-    },
-    {
-        "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
-        "MetricExpr": "4 * tma_info_core_clks",
-        "MetricGroup": "TmaL1;tma_L1_group",
-        "MetricName": "tma_info_slots"
-    },
     {
         "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
         "MetricExpr": "(1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / (CPU_CLK_=
UNHALTED.REF_XCLK_ANY / 2) if #SMT_on else 0)",
         "MetricGroup": "SMT",
-        "MetricName": "tma_info_smt_2t_utilization"
+        "MetricName": "tma_info_system_smt_2t_utilization"
     },
     {
         "BriefDescription": "Socket actual clocks when any core is active =
on that socket",
         "MetricExpr": "cha_0@event\\=3D0x0@",
         "MetricGroup": "SoC",
-        "MetricName": "tma_info_socket_clks"
-    },
-    {
-        "BriefDescription": "STLB (2nd level TLB) data store speculative m=
isses per kilo instruction (misses of any page-size that complete the page =
walk)",
-        "MetricExpr": "1e3 * DTLB_STORE_MISSES.WALK_COMPLETED / INST_RETIR=
ED.ANY",
-        "MetricGroup": "Mem;MemoryTLB",
-        "MetricName": "tma_info_store_stlb_mpki"
+        "MetricName": "tma_info_system_socket_clks"
     },
     {
         "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
-        "MetricExpr": "tma_info_clks / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "tma_info_thread_clks / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Power",
-        "MetricName": "tma_info_turbo_utilization"
+        "MetricName": "tma_info_system_turbo_utilization"
+    },
+    {
+        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "Pipeline",
+        "MetricName": "tma_info_thread_clks"
+    },
+    {
+        "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
+        "MetricExpr": "1 / tma_info_thread_ipc",
+        "MetricGroup": "Mem;Pipeline",
+        "MetricName": "tma_info_thread_cpi"
+    },
+    {
+        "BriefDescription": "The ratio of Executed- by Issued-Uops",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / UOPS_ISSUED.ANY",
+        "MetricGroup": "Cor;Pipeline",
+        "MetricName": "tma_info_thread_execute_per_issue",
+        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage."
+    },
+    {
+        "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
+        "MetricExpr": "INST_RETIRED.ANY / tma_info_thread_clks",
+        "MetricGroup": "Ret;Summary",
+        "MetricName": "tma_info_thread_ipc"
+    },
+    {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
+        "MetricExpr": "4 * tma_info_core_core_clks",
+        "MetricGroup": "TmaL1;tma_L1_group",
+        "MetricName": "tma_info_thread_slots"
     },
     {
         "BriefDescription": "Uops Per Instruction",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
         "MetricGroup": "Pipeline;Ret;Retire",
-        "MetricName": "tma_info_uoppi",
-        "MetricThreshold": "tma_info_uoppi > 1.05"
+        "MetricName": "tma_info_thread_uoppi",
+        "MetricThreshold": "tma_info_thread_uoppi > 1.05"
     },
     {
         "BriefDescription": "Instruction per taken branch",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / BR_INST_RETIRED.NEAR_TA=
KEN",
         "MetricGroup": "Branches;Fed;FetchBW",
-        "MetricName": "tma_info_uptb",
-        "MetricThreshold": "tma_info_uptb < 6"
+        "MetricName": "tma_info_thread_uptb",
+        "MetricThreshold": "tma_info_thread_uptb < 6"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
-        "MetricExpr": "ICACHE_64B.IFTAG_STALL / tma_info_clks",
+        "MetricExpr": "ICACHE_64B.IFTAG_STALL / tma_info_thread_clks",
         "MetricGroup": "BigFoot;FetchLat;MemoryTLB;TopdownL3;tma_L3_group;=
tma_fetch_latency_group",
         "MetricName": "tma_itlb_misses",
         "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
@@ -1081,7 +1302,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache",
-        "MetricExpr": "max((CYCLE_ACTIVITY.STALLS_MEM_ANY - CYCLE_ACTIVITY=
.STALLS_L1D_MISS) / tma_info_clks, 0)",
+        "MetricExpr": "max((CYCLE_ACTIVITY.STALLS_MEM_ANY - CYCLE_ACTIVITY=
.STALLS_L1D_MISS) / tma_info_thread_clks, 0)",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_issueL1;tma_issueMC;tma_memory_bound_group",
         "MetricName": "tma_l1_bound",
         "MetricThreshold": "tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2)",
@@ -1091,7 +1312,7 @@
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "MEM_LOAD_RETIRED.L2_HIT * (1 + MEM_LOAD_RETIRED.FB_=
HIT / MEM_LOAD_RETIRED.L1_MISS) / (MEM_LOAD_RETIRED.L2_HIT * (1 + MEM_LOAD_=
RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + cpu@L1D_PEND_MISS.FB_FULL\\,cm=
ask\\=3D1@) * ((CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_M=
ISS) / tma_info_clks)",
+        "MetricExpr": "MEM_LOAD_RETIRED.L2_HIT * (1 + MEM_LOAD_RETIRED.FB_=
HIT / MEM_LOAD_RETIRED.L1_MISS) / (MEM_LOAD_RETIRED.L2_HIT * (1 + MEM_LOAD_=
RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + cpu@L1D_PEND_MISS.FB_FULL\\,cm=
ask\\=3D1@) * ((CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_M=
ISS) / tma_info_thread_clks)",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
         "MetricName": "tma_l2_bound",
         "MetricThreshold": "tma_l2_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
@@ -1100,7 +1321,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
-        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L2_MISS - CYCLE_ACTIVITY.STA=
LLS_L3_MISS) / tma_info_clks",
+        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L2_MISS - CYCLE_ACTIVITY.STA=
LLS_L3_MISS) / tma_info_thread_clks",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
         "MetricThreshold": "tma_l3_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
@@ -1109,20 +1330,20 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited)",
-        "MetricExpr": "17 * tma_info_average_frequency * MEM_LOAD_RETIRED.=
L3_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma=
_info_clks",
+        "MetricExpr": "17 * tma_info_system_average_frequency * MEM_LOAD_R=
ETIRED.L3_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2=
) / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 was stalled due to Length Changing Prefixes (LCPs)",
-        "MetricExpr": "ILD_STALL.LCP / tma_info_clks",
+        "MetricExpr": "ILD_STALL.LCP / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
@@ -1137,7 +1358,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Load operations",
-        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_2 + UOPS_DISPATCHED_PORT=
.PORT_3 + UOPS_DISPATCHED_PORT.PORT_7 - UOPS_DISPATCHED_PORT.PORT_4) / (2 *=
 tma_info_core_clks)",
+        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_2 + UOPS_DISPATCHED_PORT=
.PORT_3 + UOPS_DISPATCHED_PORT.PORT_7 - UOPS_DISPATCHED_PORT.PORT_4) / (2 *=
 tma_info_core_core_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_load_op_utilization",
         "MetricThreshold": "tma_load_op_utilization > 0.6",
@@ -1155,7 +1376,7 @@
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
@@ -1163,7 +1384,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from local memory",
-        "MetricExpr": "59.5 * tma_info_average_frequency * MEM_LOAD_L3_MIS=
S_RETIRED.LOCAL_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_M=
ISS / 2) / tma_info_clks",
+        "MetricExpr": "59.5 * tma_info_system_average_frequency * MEM_LOAD=
_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIR=
ED.L1_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "Server;TopdownL5;tma_L5_group;tma_mem_latency_grou=
p",
         "MetricName": "tma_local_dram",
         "MetricThreshold": "tma_local_dram > 0.1 & (tma_mem_latency > 0.1 =
& (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2=
)))",
@@ -1172,7 +1393,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
-        "MetricExpr": "(12 * max(0, MEM_INST_RETIRED.LOCK_LOADS - L2_RQSTS=
.ALL_RFO) + MEM_INST_RETIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES * (11=
 * L2_RQSTS.RFO_HIT + min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTAN=
DING.CYCLES_WITH_DEMAND_RFO))) / tma_info_clks",
+        "MetricExpr": "(12 * max(0, MEM_INST_RETIRED.LOCK_LOADS - L2_RQSTS=
.ALL_RFO) + MEM_INST_RETIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES * (11=
 * L2_RQSTS.RFO_HIT + min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTAN=
DING.CYCLES_WITH_DEMAND_RFO))) / tma_info_thread_clks",
         "MetricGroup": "Offcore;TopdownL4;tma_L4_group;tma_issueRFO;tma_l1=
_bound_group",
         "MetricName": "tma_lock_latency",
         "MetricThreshold": "tma_lock_latency > 0.2 & (tma_l1_bound > 0.1 &=
 (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -1192,20 +1413,20 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory (DRAM)",
-        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_clks",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the performance was likely hurt due to latency from external memory (DRAM=
)",
-        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DATA_RD) / tma_info_clks - tma_mem_bandwidth",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DATA_RD) / tma_info_thread_clks - tma_mem_bandwidth",
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
         "ScaleUnit": "100%"
     },
     {
@@ -1229,7 +1450,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU was retiring uops fetched by the Microcode Sequencer (MS) unit",
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / UOPS_ISSUED.ANY * IDQ.M=
S_UOPS / tma_info_slots",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / UOPS_ISSUED.ANY * IDQ.M=
S_UOPS / tma_info_thread_slots",
         "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_heavy_operatio=
ns_group;tma_issueMC;tma_issueMS",
         "MetricName": "tma_microcode_sequencer",
         "MetricThreshold": "tma_microcode_sequencer > 0.05 & tma_heavy_ope=
rations > 0.1",
@@ -1238,19 +1459,19 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Branch Misprediction=
 at execution stage",
-        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRED.ALL=
_BRANCHES + MACHINE_CLEARS.COUNT) * INT_MISC.CLEAR_RESTEER_CYCLES / tma_inf=
o_clks",
+        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRED.ALL=
_BRANCHES + MACHINE_CLEARS.COUNT) * INT_MISC.CLEAR_RESTEER_CYCLES / tma_inf=
o_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the MITE pipeline (the legacy deco=
de pipeline)",
-        "MetricExpr": "(IDQ.ALL_MITE_CYCLES_ANY_UOPS - IDQ.ALL_MITE_CYCLES=
_4_UOPS) / tma_info_core_clks / 2",
+        "MetricExpr": "(IDQ.ALL_MITE_CYCLES_ANY_UOPS - IDQ.ALL_MITE_CYCLES=
_4_UOPS) / tma_info_core_core_clks / 2",
         "MetricGroup": "DSBmiss;FetchBW;TopdownL3;tma_L3_group;tma_fetch_b=
andwidth_group",
         "MetricName": "tma_mite",
-        "MetricThreshold": "tma_mite > 0.1 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_ipc / 4 > 0.35)",
+        "MetricThreshold": "tma_mite > 0.1 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_thread_ipc / 4 > 0.35)",
         "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to the MITE pipeline (the legacy dec=
ode pipeline). This pipeline is used for code that was not pre-cached in th=
e DSB or LSD. For example; inefficiencies due to asymmetric decoders; use o=
f long immediate or LCP can manifest as MITE fetch bandwidth bottleneck. Sa=
mple with: FRONTEND_RETIRED.ANY_DSB_MISS",
         "ScaleUnit": "100%"
     },
@@ -1265,7 +1486,7 @@
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS)",
-        "MetricExpr": "2 * IDQ.MS_SWITCHES / tma_info_clks",
+        "MetricExpr": "2 * IDQ.MS_SWITCHES / tma_info_thread_clks",
         "MetricGroup": "FetchLat;MicroSeq;TopdownL3;tma_L3_group;tma_fetch=
_latency_group;tma_issueMC;tma_issueMS;tma_issueMV;tma_issueSO",
         "MetricName": "tma_ms_switches",
         "MetricThreshold": "tma_ms_switches > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
@@ -1301,7 +1522,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd b=
ranch)",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_0 / tma_info_core_clks",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_0 / tma_info_core_core_cl=
ks",
         "MetricGroup": "Compute;TopdownL6;tma_L6_group;tma_alu_op_utilizat=
ion_group;tma_issue2P",
         "MetricName": "tma_port_0",
         "MetricThreshold": "tma_port_0 > 0.6",
@@ -1310,7 +1531,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 1 (ALU)",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_1 / tma_info_core_clks",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_1 / tma_info_core_core_cl=
ks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_1",
         "MetricThreshold": "tma_port_1 > 0.6",
@@ -1319,7 +1540,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 2 ([SNB+]Loads and Store-address; [=
ICL+] Loads)",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_2 / tma_info_core_clks",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_2 / tma_info_core_core_cl=
ks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_load_op_utilization_gro=
up",
         "MetricName": "tma_port_2",
         "MetricThreshold": "tma_port_2 > 0.6",
@@ -1328,7 +1549,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 3 ([SNB+]Loads and Store-address; [=
ICL+] Loads)",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_3 / tma_info_core_clks",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_3 / tma_info_core_core_cl=
ks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_load_op_utilization_gro=
up",
         "MetricName": "tma_port_3",
         "MetricThreshold": "tma_port_3 > 0.6",
@@ -1346,7 +1567,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 5 ([SNB+] Branches and ALU; [HSW+] =
ALU)",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_5 / tma_info_core_clks",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_5 / tma_info_core_core_cl=
ks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_5",
         "MetricThreshold": "tma_port_5 > 0.6",
@@ -1355,7 +1576,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 6 ([HSW+]Primary Branch and simple =
ALU)",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_6 / tma_info_core_clks",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_6 / tma_info_core_core_cl=
ks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_6",
         "MetricThreshold": "tma_port_6 > 0.6",
@@ -1364,7 +1585,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 7 ([HSW+]simple Store-address)",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_7 / tma_info_core_clks",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_7 / tma_info_core_core_cl=
ks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_store_op_utilization_gr=
oup",
         "MetricName": "tma_port_7",
         "MetricThreshold": "tma_port_7 > 0.6",
@@ -1373,7 +1594,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
-        "MetricExpr": "((EXE_ACTIVITY.EXE_BOUND_0_PORTS + (EXE_ACTIVITY.1_=
PORTS_UTIL + tma_retiring * EXE_ACTIVITY.2_PORTS_UTIL)) / tma_info_clks if =
ARITH.DIVIDER_ACTIVE < CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.STALLS_=
MEM_ANY else (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * EXE_ACTIVITY.2_POR=
TS_UTIL) / tma_info_clks)",
+        "MetricExpr": "((EXE_ACTIVITY.EXE_BOUND_0_PORTS + (EXE_ACTIVITY.1_=
PORTS_UTIL + tma_retiring * EXE_ACTIVITY.2_PORTS_UTIL)) / tma_info_thread_c=
lks if ARITH.DIVIDER_ACTIVE < CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.=
STALLS_MEM_ANY else (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * EXE_ACTIVIT=
Y.2_PORTS_UTIL) / tma_info_thread_clks)",
         "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
         "MetricName": "tma_ports_utilization",
         "MetricThreshold": "tma_ports_utilization > 0.15 & (tma_core_bound=
 > 0.1 & tma_backend_bound > 0.2)",
@@ -1382,7 +1603,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
-        "MetricExpr": "(UOPS_EXECUTED.CORE_CYCLES_NONE / 2 if #SMT_on else=
 CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.STALLS_MEM_ANY) / tma_info_co=
re_clks",
+        "MetricExpr": "(UOPS_EXECUTED.CORE_CYCLES_NONE / 2 if #SMT_on else=
 CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.STALLS_MEM_ANY) / tma_info_co=
re_core_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_0",
         "MetricThreshold": "tma_ports_utilized_0 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -1391,7 +1612,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re the CPU executed total of 1 uop per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "((UOPS_EXECUTED.CORE_CYCLES_GE_1 - UOPS_EXECUTED.CO=
RE_CYCLES_GE_2) / 2 if #SMT_on else EXE_ACTIVITY.1_PORTS_UTIL) / tma_info_c=
ore_clks",
+        "MetricExpr": "((UOPS_EXECUTED.CORE_CYCLES_GE_1 - UOPS_EXECUTED.CO=
RE_CYCLES_GE_2) / 2 if #SMT_on else EXE_ACTIVITY.1_PORTS_UTIL) / tma_info_c=
ore_core_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issueL1;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_1",
         "MetricThreshold": "tma_ports_utilized_1 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -1400,7 +1621,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 2 uops per cycle on all execution ports (Logical Process=
or cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "((UOPS_EXECUTED.CORE_CYCLES_GE_2 - UOPS_EXECUTED.CO=
RE_CYCLES_GE_3) / 2 if #SMT_on else EXE_ACTIVITY.2_PORTS_UTIL) / tma_info_c=
ore_clks",
+        "MetricExpr": "((UOPS_EXECUTED.CORE_CYCLES_GE_2 - UOPS_EXECUTED.CO=
RE_CYCLES_GE_3) / 2 if #SMT_on else EXE_ACTIVITY.2_PORTS_UTIL) / tma_info_c=
ore_core_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issue2P;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_2",
         "MetricThreshold": "tma_ports_utilized_2 > 0.15 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -1409,7 +1630,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise).",
-        "MetricExpr": "(UOPS_EXECUTED.CORE_CYCLES_GE_3 / 2 if #SMT_on else=
 UOPS_EXECUTED.CORE_CYCLES_GE_3) / tma_info_core_clks",
+        "MetricExpr": "(UOPS_EXECUTED.CORE_CYCLES_GE_3 / 2 if #SMT_on else=
 UOPS_EXECUTED.CORE_CYCLES_GE_3) / tma_info_core_core_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_3m",
         "MetricThreshold": "tma_ports_utilized_3m > 0.7 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -1418,7 +1639,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote cache in other socket=
s including synchronizations issues",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
-        "MetricExpr": "(89.5 * tma_info_average_frequency * MEM_LOAD_L3_MI=
SS_RETIRED.REMOTE_HITM + 89.5 * tma_info_average_frequency * MEM_LOAD_L3_MI=
SS_RETIRED.REMOTE_FWD) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1=
_MISS / 2) / tma_info_clks",
+        "MetricExpr": "(89.5 * tma_info_system_average_frequency * MEM_LOA=
D_L3_MISS_RETIRED.REMOTE_HITM + 89.5 * tma_info_system_average_frequency * =
MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_L=
OAD_RETIRED.L1_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "Offcore;Server;Snoop;TopdownL5;tma_L5_group;tma_is=
sueSyncxn;tma_mem_latency_group",
         "MetricName": "tma_remote_cache",
         "MetricThreshold": "tma_remote_cache > 0.05 & (tma_mem_latency > 0=
.1 & (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > =
0.2)))",
@@ -1427,7 +1648,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote memory",
-        "MetricExpr": "127 * tma_info_average_frequency * MEM_LOAD_L3_MISS=
_RETIRED.REMOTE_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_M=
ISS / 2) / tma_info_clks",
+        "MetricExpr": "127 * tma_info_system_average_frequency * MEM_LOAD_=
L3_MISS_RETIRED.REMOTE_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIR=
ED.L1_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "Server;Snoop;TopdownL5;tma_L5_group;tma_mem_latenc=
y_group",
         "MetricName": "tma_remote_dram",
         "MetricThreshold": "tma_remote_dram > 0.1 & (tma_mem_latency > 0.1=
 & (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.=
2)))",
@@ -1436,7 +1657,7 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_slots",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_thread_slots",
         "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
@@ -1446,7 +1667,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU issue-pipeline was stalled due to serializing operations",
-        "MetricExpr": "PARTIAL_RAT_STALLS.SCOREBOARD / tma_info_clks",
+        "MetricExpr": "PARTIAL_RAT_STALLS.SCOREBOARD / tma_info_thread_clk=
s",
         "MetricGroup": "PortsUtil;TopdownL5;tma_L5_group;tma_issueSO;tma_p=
orts_utilized_0_group",
         "MetricName": "tma_serializing_operation",
         "MetricThreshold": "tma_serializing_operation > 0.1 & (tma_ports_u=
tilized_0 > 0.2 & (tma_ports_utilization > 0.15 & (tma_core_bound > 0.1 & t=
ma_backend_bound > 0.2)))",
@@ -1456,7 +1677,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles hand=
ling memory load split accesses - load that cross 64-byte cache line bounda=
ry",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
-        "MetricExpr": "tma_info_load_miss_real_latency * LD_BLOCKS.NO_SR /=
 tma_info_clks",
+        "MetricExpr": "tma_info_memory_load_miss_real_latency * LD_BLOCKS.=
NO_SR / tma_info_thread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_split_loads",
         "MetricThreshold": "tma_split_loads > 0.2 & (tma_l1_bound > 0.1 & =
(tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -1465,7 +1686,7 @@
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
@@ -1474,16 +1695,16 @@
     },
     {
         "BriefDescription": "This metric measures fraction of cycles where=
 the Super Queue (SQ) was full taking into account all request-types and bo=
th hardware SMT threads (Logical Processors)",
-        "MetricExpr": "(OFFCORE_REQUESTS_BUFFER.SQ_FULL / 2 if #SMT_on els=
e OFFCORE_REQUESTS_BUFFER.SQ_FULL) / tma_info_core_clks",
+        "MetricExpr": "(OFFCORE_REQUESTS_BUFFER.SQ_FULL / 2 if #SMT_on els=
e OFFCORE_REQUESTS_BUFFER.SQ_FULL) / tma_info_core_core_clks",
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
         "ScaleUnit": "100%"
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
@@ -1492,7 +1713,7 @@
     },
     {
         "BriefDescription": "This metric roughly estimates fraction of cyc=
les when the memory subsystem had loads blocked since they could not forwar=
d data from earlier (in program order) overlapping stores",
-        "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / tma_info_clks",
+        "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / tma_info_thread_clks=
",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_store_fwd_blk",
         "MetricThreshold": "tma_store_fwd_blk > 0.1 & (tma_l1_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -1502,7 +1723,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
-        "MetricExpr": "(L2_RQSTS.RFO_HIT * 11 * (1 - MEM_INST_RETIRED.LOCK=
_LOADS / MEM_INST_RETIRED.ALL_STORES) + (1 - MEM_INST_RETIRED.LOCK_LOADS / =
MEM_INST_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUEST=
S_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / tma_info_clks",
+        "MetricExpr": "(L2_RQSTS.RFO_HIT * 11 * (1 - MEM_INST_RETIRED.LOCK=
_LOADS / MEM_INST_RETIRED.ALL_STORES) + (1 - MEM_INST_RETIRED.LOCK_LOADS / =
MEM_INST_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUEST=
S_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / tma_info_thread_clks",
         "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_issue=
RFO;tma_issueSL;tma_store_bound_group",
         "MetricName": "tma_store_latency",
         "MetricThreshold": "tma_store_latency > 0.1 & (tma_store_bound > 0=
.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -1511,7 +1732,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Store operations",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_4 / tma_info_core_clks",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_4 / tma_info_core_core_cl=
ks",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_store_op_utilization",
         "MetricThreshold": "tma_store_op_utilization > 0.6",
@@ -1527,7 +1748,7 @@
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
@@ -1535,7 +1756,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to new branch address clears",
-        "MetricExpr": "9 * BACLEARS.ANY / tma_info_clks",
+        "MetricExpr": "9 * BACLEARS.ANY / tma_info_thread_clks",
         "MetricGroup": "BigFoot;FetchLat;TopdownL4;tma_L4_group;tma_branch=
_resteers_group",
         "MetricName": "tma_unknown_branches",
         "MetricThreshold": "tma_unknown_branches > 0.05 & (tma_branch_rest=
eers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
@@ -1578,5 +1799,17 @@
         "MetricGroup": "transaction",
         "MetricName": "tsx_transactional_cycles",
         "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Uncore operating frequency in GHz",
+        "MetricExpr": "UNC_CHA_CLOCKTICKS / (#num_cores / #num_packages * =
#num_packages) / 1e9 / duration_time",
+        "MetricName": "uncore_frequency",
+        "ScaleUnit": "1GHz"
+    },
+    {
+        "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data t=
ransmit bandwidth (MB/sec)",
+        "MetricExpr": "UNC_UPI_TxL_FLITS.ALL_DATA * 7.111111111111111 / 1e=
6 / duration_time",
+        "MetricName": "upi_data_transmit_bw",
+        "ScaleUnit": "1MB/s"
     }
 ]
--=20
2.40.1.606.ga4b1b128d6-goog

