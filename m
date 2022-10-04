Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748D15F3B43
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJDCSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJDCRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:17:14 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB0A3FA3C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 19:16:45 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3584be56efbso65174817b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 19:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date;
        bh=QTgsboOBJfQ6StFcL+CXhaEWYleJHOoZxAlHNiY8EnA=;
        b=NkvbAjeRmLFYrQpii7dGuxZsTyzPCcFaKRcX6l2Ah9CK1wG8OSkz8fnGnHv6d91JKp
         onKZsvjniJrkS33Zl+vEwTCG8bQamt0/hMpg9eOjjLkNSg5wRBARExpryCYgOIx8bftV
         2YTjL05aWRHydbXl2iO9SLrsD/WO6QPXRLiEFuzKX4fXZNm5LPY/pHTfn6K56kM9KOEJ
         C71gkFOdS9aw+MPse+tqWiQEbZ09Q9f6WTRbtuq1fNFR82sNSoI+XJYvibIB86s608pN
         VzfPSZhga6cMD/IcJP7pV/7ZimdEe06zMjEOFo+zyR02uF7K1IdT1Mg/g+iBpJgR+4Du
         N19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date;
        bh=QTgsboOBJfQ6StFcL+CXhaEWYleJHOoZxAlHNiY8EnA=;
        b=hlrTQvp7fTCj7bR/3/hmOg0tjHiHeuGkKN+VJcYXa+eOvkoZcL9lTDxgyqnBIL0yNs
         JStsINUzS+xtOpVanymMLN/sKyJNS6xeXO0XbKLtOfm5K2rCkDiyvuz9zHuEE87Ebmih
         IwwzwVm/tjaC2msGZWuLGEp9Q0pCA00ZNxUSZPZ3Hu9LwuG/5zwVm94Sar05J2Rd/Fap
         wYw17tAzDO+4FbTvFRne9uVAWUb3q+7F9H2Xlx5SAr1k8yTk150sGhnM5HNym0NFGleV
         +KrhsxPs8paLGBG5menW6mbXYwrKRp39/TOTBSF3E1JX/ak27Oyi3NLeH7oESiQ79uHQ
         sKeg==
X-Gm-Message-State: ACrzQf3TBeoPAwPn7GRgeBtcPsJPfHYbmhWN8Nte8wwmcnmpL8Wa5sXL
        njxr+P6TbRGS8jIXt13RDPW/NvheCjSS
X-Google-Smtp-Source: AMsMyM6aJr+oHPoBwVdRhpAhGCpgXTepQg7eOthQ0ctuDULMCNI5bBy9XPfRBjPaJbAMn5O9iy6AvuW/kyr7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a86d:8afd:70b1:9b0c])
 (user=irogers job=sendgmr) by 2002:a05:6902:120f:b0:676:aaa4:8434 with SMTP
 id s15-20020a056902120f00b00676aaa48434mr24413584ybu.218.1664849802379; Mon,
 03 Oct 2022 19:16:42 -0700 (PDT)
Date:   Mon,  3 Oct 2022 19:15:58 -0700
In-Reply-To: <20221004021612.325521-1-irogers@google.com>
Message-Id: <20221004021612.325521-10-irogers@google.com>
Mime-Version: 1.0
References: <20221004021612.325521-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Subject: [PATCH v3 09/23] perf vendor events: Update Intel cascadelakex
From:   Ian Rogers <irogers@google.com>
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Events remain at v1.16, and the metrics are based on TMA 4.4 full.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/downloa=
d_and_gen.py
with updates at:
https://github.com/captain5050/event-converter-for-linux-perf

Updates include:
 - Removal of ScaleUnit from uncore events by Zhengjun Xing
   <zhengjun.xing@linux.intel.com>.
 - Rename of topdown TMA metrics from Frontend_Bound to tma_frontend_bound.
 - _SMT suffix metrics are dropped as the #SMT_On and #EBS_Mode are
   correctly expanded in the single main metric.
 - Addition of all 6 levels of TMA metrics. Child metrics are placed
   in a group named after their parent allowing children of a metric
   to be easily measured using the metric name with a _group suffix.
 - ## and ##? operators are correctly expanded.
 - The locate-with column is added to the long description describing
   a sampling event.
 - Metrics are written in terms of other metrics to reduce the
   expression size and increase readability.
 - Latest metrics from: https://github.com/intel/perfmon-metrics

Tested with 'perf test':
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/cascadelakex/clx-metrics.json    | 1285 ++++++++++-------
 .../arch/x86/cascadelakex/uncore-memory.json  |   18 +-
 .../arch/x86/cascadelakex/uncore-other.json   |   10 +-
 3 files changed, 787 insertions(+), 526 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b=
/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
index 46613504b816..81de1149297d 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
@@ -1,148 +1,742 @@
 [
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * CPU_CLK_UNHALTED=
.THREAD)",
-        "MetricGroup": "TopdownL1",
-        "MetricName": "Frontend_Bound",
-        "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Machine_Width uops every c=
ycle to the Backend. Frontend Bound denotes unutilized issue-slots when the=
re is no Backend stall; i.e. bubbles where Frontend delivered no uops while=
 Backend could have accepted them. For example; stalls due to instruction-c=
ache misses would be categorized under Frontend Bound."
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / SLOTS",
+        "MetricGroup": "PGO;TopdownL1;tma_L1_group",
+        "MetricName": "tma_frontend_bound",
+        "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Machine_Width uops every c=
ycle to the Backend. Frontend Bound denotes unutilized issue-slots when the=
re is no Backend stall; i.e. bubbles where Frontend delivered no uops while=
 Backend could have accepted them. For example; stalls due to instruction-c=
ache misses would be categorized under Frontend Bound. Sample with: FRONTEN=
D_RETIRED.LATENCY_GE_4_PS",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend. SMT version; use wh=
en SMT is enabled and measuring per logical CPU.",
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * ( ( CPU_CLK_UNHA=
LTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHA=
LTED.REF_XCLK ) ))",
-        "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Frontend_Bound_SMT",
-        "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Machine_Width uops every c=
ycle to the Backend. Frontend Bound denotes unutilized issue-slots when the=
re is no Backend stall; i.e. bubbles where Frontend delivered no uops while=
 Backend could have accepted them. For example; stalls due to instruction-c=
ache misses would be categorized under Frontend Bound. SMT version; use whe=
n SMT is enabled and measuring per logical CPU."
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues",
+        "MetricExpr": "4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE=
 / SLOTS",
+        "MetricGroup": "Frontend;TopdownL2;tma_L2_group;tma_frontend_bound=
_group",
+        "MetricName": "tma_fetch_latency",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend latency issues.  For example; instruction-=
cache misses; iTLB misses or fetch stalls after a branch misprediction are =
categorized under Frontend Latency. In such cases; the Frontend eventually =
delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_=
16_PS;FRONTEND_RETIRED.LATENCY_GE_8_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses",
+        "MetricExpr": "(ICACHE_16B.IFDATA_STALL + 2 * cpu@ICACHE_16B.IFDAT=
A_STALL\\,cmask\\=3D1\\,edge@) / CLKS",
+        "MetricGroup": "BigFoot;FetchLat;IcMiss;TopdownL3;tma_fetch_latenc=
y_group",
+        "MetricName": "tma_icache_misses",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to instruction cache misses. Sample with: FRONTEND_RE=
TIRED.L2_MISS_PS;FRONTEND_RETIRED.L1I_MISS_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
+        "MetricExpr": "ICACHE_64B.IFTAG_STALL / CLKS",
+        "MetricGroup": "BigFoot;FetchLat;MemoryTLB;TopdownL3;tma_fetch_lat=
ency_group",
+        "MetricName": "tma_itlb_misses",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: FRONTE=
ND_RETIRED.STLB_MISS_PS;FRONTEND_RETIRED.ITLB_MISS_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers",
+        "MetricExpr": "INT_MISC.CLEAR_RESTEER_CYCLES / CLKS + tma_unknown_=
branches",
+        "MetricGroup": "FetchLat;TopdownL3;tma_fetch_latency_group",
+        "MetricName": "tma_branch_resteers",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fro=
ntend delay in fetching operations from corrected path; following all sorts=
 of miss-predicted branches. For example; branchy code with lots of miss-pr=
edictions might get categorized under Branch Resteers. Note the value of th=
is node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_BRA=
NCHES",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Branch Misprediction=
 at execution stage",
+        "MetricExpr": "(BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRED.AL=
L_BRANCHES + MACHINE_CLEARS.COUNT)) * INT_MISC.CLEAR_RESTEER_CYCLES / CLKS"=
,
+        "MetricGroup": "BadSpec;BrMispredicts;TopdownL4;tma_branch_resteer=
s_group",
+        "MetricName": "tma_mispredicts_resteers",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage.  Sample with: INT_MISC.CLEAR_RESTEER_CYCLES",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Machine Clears",
+        "MetricExpr": "(1 - (BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIR=
ED.ALL_BRANCHES + MACHINE_CLEARS.COUNT))) * INT_MISC.CLEAR_RESTEER_CYCLES /=
 CLKS",
+        "MetricGroup": "BadSpec;MachineClears;TopdownL4;tma_branch_resteer=
s_group",
+        "MetricName": "tma_clears_resteers",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Machine Clears.  Sa=
mple with: INT_MISC.CLEAR_RESTEER_CYCLES",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to new branch address clears",
+        "MetricExpr": "9 * BACLEARS.ANY / CLKS",
+        "MetricGroup": "BigFoot;FetchLat;TopdownL4;tma_branch_resteers_gro=
up",
+        "MetricName": "tma_unknown_branches",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to new branch address clears. These are fetched branc=
hes the Branch Prediction Unit was unable to recognize (First fetch or hitt=
ing BPU capacity limit). Sample with: BACLEARS.ANY",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to switches from DSB to MITE pipelines",
+        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / CLKS",
+        "MetricGroup": "DSBmiss;FetchLat;TopdownL3;tma_fetch_latency_group=
",
+        "MetricName": "tma_dsb_switches",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 was stalled due to Length Changing Prefixes (LCPs)",
+        "MetricExpr": "ILD_STALL.LCP / CLKS",
+        "MetricGroup": "FetchLat;TopdownL3;tma_fetch_latency_group",
+        "MetricName": "tma_lcp",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS)",
+        "MetricExpr": "2 * IDQ.MS_SWITCHES / CLKS",
+        "MetricGroup": "FetchLat;MicroSeq;TopdownL3;tma_fetch_latency_grou=
p",
+        "MetricName": "tma_ms_switches",
+        "PublicDescription": "This metric estimates the fraction of cycles=
 when the CPU was stalled due to switches of uop delivery to the Microcode =
Sequencer (MS). Commonly used instructions are optimized for delivery by th=
e DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Cert=
ain operations cannot be handled natively by the execution pipeline; and mu=
st be performed by microcode (small programs injected into the execution st=
ream). Switching to the MS too often can negatively impact performance. The=
 MS is designated to deliver long uop flows required by CISC instructions l=
ike CPUID; or uncommon conditions like Floating Point Assists when dealing =
with Denormals. Sample with: IDQ.MS_SWITCHES",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend bandwidth issues",
+        "MetricExpr": "tma_frontend_bound - tma_fetch_latency",
+        "MetricGroup": "FetchBW;Frontend;TopdownL2;tma_L2_group;tma_fronte=
nd_bound_group",
+        "MetricName": "tma_fetch_bandwidth",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LA=
TENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the MITE pipeline (the legacy deco=
de pipeline)",
+        "MetricExpr": "(IDQ.ALL_MITE_CYCLES_ANY_UOPS - IDQ.ALL_MITE_CYCLES=
_4_UOPS) / CORE_CLKS / 2",
+        "MetricGroup": "DSBmiss;FetchBW;TopdownL3;tma_fetch_bandwidth_grou=
p",
+        "MetricName": "tma_mite",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to the MITE pipeline (the legacy dec=
ode pipeline). This pipeline is used for code that was not pre-cached in th=
e DSB or LSD. For example; inefficiencies due to asymmetric decoders; use o=
f long immediate or LCP can manifest as MITE fetch bandwidth bottleneck. Sa=
mple with: FRONTEND_RETIRED.ANY_DSB_MISS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles whe=
re decoder-0 was the only active decoder",
+        "MetricExpr": "(cpu@INST_DECODED.DECODERS\\,cmask\\=3D1@ - cpu@INS=
T_DECODED.DECODERS\\,cmask\\=3D2@) / CORE_CLKS",
+        "MetricGroup": "DSBmiss;FetchBW;TopdownL4;tma_mite_group",
+        "MetricName": "tma_decoder0_alone",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to DSB (decoded uop cache) fetch pipe=
line",
+        "MetricExpr": "(IDQ.ALL_DSB_CYCLES_ANY_UOPS - IDQ.ALL_DSB_CYCLES_4=
_UOPS) / CORE_CLKS / 2",
+        "MetricGroup": "DSB;FetchBW;TopdownL3;tma_fetch_bandwidth_group",
+        "MetricName": "tma_dsb",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here.",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 *=
 INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.THREAD)",
-        "MetricGroup": "TopdownL1",
-        "MetricName": "Bad_Speculation",
-        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example."
+        "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * =
((INT_MISC.RECOVERY_CYCLES_ANY / 2) if #SMT_on else INT_MISC.RECOVERY_CYCLE=
S)) / SLOTS",
+        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricName": "tma_bad_speculation",
+        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction",
+        "MetricExpr": "(BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRED.AL=
L_BRANCHES + MACHINE_CLEARS.COUNT)) * tma_bad_speculation",
+        "MetricGroup": "BadSpec;BrMispredicts;TopdownL2;tma_L2_group;tma_b=
ad_speculation_group",
+        "MetricName": "tma_branch_mispredicts",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations. SMT version; use when SMT is enabled an=
d measuring per logical CPU.",
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 *=
 ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_CLK_UNHALTED.THREAD =
/ 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCL=
K ) ))",
-        "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Bad_Speculation_SMT",
-        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example. SMT version; use when SMT is enabled and measuring p=
er logical CPU."
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Machine Clears",
+        "MetricExpr": "tma_bad_speculation - tma_branch_mispredicts",
+        "MetricGroup": "BadSpec;MachineClears;TopdownL2;tma_L2_group;tma_b=
ad_speculation_group",
+        "MetricName": "tma_machine_clears",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Machine Clears.  These slots are either wasted by uo=
ps fetched prior to the clear; or stalls the out-of-order portion of the ma=
chine needs to recover its state after the clear. For example; this can hap=
pen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modif=
ying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
-        "MetricConstraint": "NO_NMI_WATCHDOG",
-        "MetricExpr": "1 - (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * CPU_CLK_UNH=
ALTED.THREAD)) - ( UOPS_ISSUED.ANY + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * =
CPU_CLK_UNHALTED.THREAD)",
-        "MetricGroup": "TopdownL1",
-        "MetricName": "Backend_Bound",
-        "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound."
+        "MetricExpr": "1 - tma_frontend_bound - (UOPS_ISSUED.ANY + 4 * ((I=
NT_MISC.RECOVERY_CYCLES_ANY / 2) if #SMT_on else INT_MISC.RECOVERY_CYCLES))=
 / SLOTS",
+        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricName": "tma_backend_bound",
+        "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
+        "MetricExpr": "((CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.BOUN=
D_ON_STORES) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UTIL + =
tma_retiring * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) =
* tma_backend_bound",
+        "MetricGroup": "Backend;TopdownL2;tma_L2_group;tma_backend_bound_g=
roup",
+        "MetricName": "tma_memory_bound",
+        "PublicDescription": "This metric represents fraction of slots the=
 Memory subsystem within the Backend was a bottleneck.  Memory Bound estima=
tes fraction of slots where pipeline is likely stalled due to demand load o=
r store instructions. This accounts mainly for (1) non-completed in-flight =
memory demand loads which coincides with execution units starvation; in add=
ition to (2) cases where stores could impose backpressure on the pipeline w=
hen many of them get buffered at the same time (less common out of the two)=
.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache",
+        "MetricExpr": "max((CYCLE_ACTIVITY.STALLS_MEM_ANY - CYCLE_ACTIVITY=
.STALLS_L1D_MISS) / CLKS, 0)",
+        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_mem=
ory_bound_group",
+        "MetricName": "tma_l1_bound",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled without loads missing the L1 data cache.  The L1 data cache typical=
ly has the shortest latency.  However; in certain cases like loads blocked =
on older stores; a load might suffer due to high latency even though it is =
being satisfied by the L1. Another example is loads who miss in the TLB. Th=
ese cases are characterized by execution unit stalls; while some non-comple=
ted demand load lives in the machine without having that demand load missin=
g the L1 cache. Sample with: MEM_LOAD_RETIRED.L1_HIT_PS;MEM_LOAD_RETIRED.FB=
_HIT_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
+        "MetricExpr": "min(9 * cpu@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\\=3D1=
@ + DTLB_LOAD_MISSES.WALK_ACTIVE, max(CYCLE_ACTIVITY.CYCLES_MEM_ANY - CYCLE=
_ACTIVITY.CYCLES_L1D_MISS, 0)) / CLKS",
+        "MetricGroup": "MemoryTLB;TopdownL4;tma_l1_bound_group",
+        "MetricName": "tma_dtlb_load",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the (first level) DTLB was missed by load accesses, that late=
r on hit in second-level TLB (STLB)",
+        "MetricExpr": "tma_dtlb_load - tma_load_stlb_miss",
+        "MetricGroup": "MemoryTLB;TopdownL5;tma_dtlb_load_group",
+        "MetricName": "tma_load_stlb_hit",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
where the Second-level TLB (STLB) was missed by load accesses, performing a=
 hardware page walk",
+        "MetricExpr": "DTLB_LOAD_MISSES.WALK_ACTIVE / CLKS",
+        "MetricGroup": "MemoryTLB;TopdownL5;tma_dtlb_load_group",
+        "MetricName": "tma_load_stlb_miss",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates fraction of cyc=
les when the memory subsystem had loads blocked since they could not forwar=
d data from earlier (in program order) overlapping stores",
+        "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / CLKS",
+        "MetricGroup": "TopdownL4;tma_l1_bound_group",
+        "MetricName": "tma_store_fwd_blk",
+        "PublicDescription": "This metric roughly estimates fraction of cy=
cles when the memory subsystem had loads blocked since they could not forwa=
rd data from earlier (in program order) overlapping stores. To streamline m=
emory operations in the pipeline; a load can avoid waiting for memory if a =
prior in-flight store is writing the data that the load wants to read (stor=
e forwarding process). However; in some cases the load may be blocked for a=
 significant time pending the store forward. For example; when the prior st=
ore is writing a smaller region than the load is reading.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
+        "MetricExpr": "(12 * max(0, MEM_INST_RETIRED.LOCK_LOADS - L2_RQSTS=
.ALL_RFO) + (MEM_INST_RETIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES) * (=
11 * L2_RQSTS.RFO_HIT + min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DEMAND_RFO))) / CLKS",
+        "MetricGroup": "Offcore;TopdownL4;tma_l1_bound_group",
+        "MetricName": "tma_lock_latency",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them. Sample with: MEM_INST_RETIRED.LOCK_LOA=
DS_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles hand=
ling memory load split accesses - load that cross 64-byte cache line bounda=
ry",
+        "MetricExpr": "Load_Miss_Real_Latency * LD_BLOCKS.NO_SR / CLKS",
+        "MetricGroup": "TopdownL4;tma_l1_bound_group",
+        "MetricName": "tma_split_loads",
+        "PublicDescription": "This metric estimates fraction of cycles han=
dling memory load split accesses - load that cross 64-byte cache line bound=
ary.  Sample with: MEM_INST_RETIRED.SPLIT_LOADS_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often memory load a=
ccesses were aliased by preceding stores (in program order) with a 4K addre=
ss offset",
+        "MetricExpr": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS / CLKS",
+        "MetricGroup": "TopdownL4;tma_l1_bound_group",
+        "MetricName": "tma_4k_aliasing",
+        "PublicDescription": "This metric estimates how often memory load =
accesses were aliased by preceding stores (in program order) with a 4K addr=
ess offset. False match is possible; which incur a few cycles load re-issue=
. However; the short re-issue duration is often hidden by the out-of-order =
core and HW optimizations; hence a user may safely ignore a high value of t=
his metric unless it manages to propagate up into parent nodes of the hiera=
rchy (e.g. to L1_Bound).",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
+        "MetricExpr": "Load_Miss_Real_Latency * cpu@L1D_PEND_MISS.FB_FULL\=
\,cmask\\=3D1@ / CLKS",
+        "MetricGroup": "MemoryBW;TopdownL4;tma_l1_bound_group",
+        "MetricName": "tma_fb_full",
+        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory).",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads",
+        "MetricExpr": "((MEM_LOAD_RETIRED.L2_HIT * (1 + (MEM_LOAD_RETIRED.=
FB_HIT / MEM_LOAD_RETIRED.L1_MISS))) / ((MEM_LOAD_RETIRED.L2_HIT * (1 + (ME=
M_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))) + cpu@L1D_PEND_MISS.FB_=
FULL\\,cmask\\=3D1@)) * ((CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.S=
TALLS_L2_MISS) / CLKS)",
+        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_mem=
ory_bound_group",
+        "MetricName": "tma_l2_bound",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_RETIRED.L2_HIT_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
+        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L2_MISS - CYCLE_ACTIVITY.STA=
LLS_L3_MISS) / CLKS",
+        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_mem=
ory_bound_group",
+        "MetricName": "tma_l3_bound",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
+        "MetricExpr": "((44 * Average_Frequency) * (MEM_LOAD_L3_HIT_RETIRE=
D.XSNP_HITM * (OCR.DEMAND_DATA_RD.L3_HIT.HITM_OTHER_CORE / (OCR.DEMAND_DATA=
_RD.L3_HIT.HITM_OTHER_CORE + OCR.DEMAND_DATA_RD.L3_HIT.HIT_OTHER_CORE_FWD))=
) + (44 * Average_Frequency) * MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS) * (1 + (M=
EM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) / 2) / CLKS",
+        "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_l3_bound_g=
roup",
+        "MetricName": "tma_contested_accesses",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
+        "MetricExpr": "(44 * Average_Frequency) * (MEM_LOAD_L3_HIT_RETIRED=
.XSNP_HIT + MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM * (1 - (OCR.DEMAND_DATA_RD.L3=
_HIT.HITM_OTHER_CORE / (OCR.DEMAND_DATA_RD.L3_HIT.HITM_OTHER_CORE + OCR.DEM=
AND_DATA_RD.L3_HIT.HIT_OTHER_CORE_FWD)))) * (1 + (MEM_LOAD_RETIRED.FB_HIT /=
 MEM_LOAD_RETIRED.L1_MISS) / 2) / CLKS",
+        "MetricGroup": "Offcore;Snoop;TopdownL4;tma_l3_bound_group",
+        "MetricName": "tma_data_sharing",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_L3_HIT_RETIRED.XSNP_HIT_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited)",
+        "MetricExpr": "(17 * Average_Frequency) * MEM_LOAD_RETIRED.L3_HIT =
* (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) / 2) / CLKS",
+        "MetricGroup": "MemoryLat;TopdownL4;tma_l3_bound_group",
+        "MetricName": "tma_l3_hit_latency",
+        "PublicDescription": "This metric represents fraction of cycles wi=
th demand load accesses that hit the L3 cache under unloaded scenarios (pos=
sibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L=
3 hits) will improve the latency; reduce contention with sibling physical c=
ores and increase performance.  Note the value of this node may overlap wit=
h its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric measures fraction of cycles where=
 the Super Queue (SQ) was full taking into account all request-types and bo=
th hardware SMT threads (Logical Processors)",
+        "MetricExpr": "((OFFCORE_REQUESTS_BUFFER.SQ_FULL / 2) if #SMT_on e=
lse OFFCORE_REQUESTS_BUFFER.SQ_FULL) / CORE_CLKS",
+        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_l3_bound_group",
+        "MetricName": "tma_sq_full",
+        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). The Super Queue is used for =
requests to access the L2 cache or to go out to the Uncore.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
+        "MetricExpr": "((CYCLE_ACTIVITY.STALLS_L3_MISS / CLKS + ((CYCLE_AC=
TIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / CLKS) - tma_l2_bo=
und) - tma_pmm_bound)",
+        "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_memory_bound_gr=
oup",
+        "MetricName": "tma_dram_bound",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_RETIRED=
.L3_MISS_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory (DRAM)",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / CLKS",
+        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_dram_bound_group",
+        "MetricName": "tma_mem_bandwidth",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory (DRAM).  The underlying heuristic assumes that a simi=
lar off-core traffic is generated by all IA cores. This metric does not agg=
regate non-data-read requests by this logical processor; requests from othe=
r IA Logical Processors/Physical Cores/sockets; or other non-IA devices lik=
e GPU; hence the maximum external memory bandwidth limits may or may not be=
 approached when this metric is flagged (see Uncore counters for that).",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles wher=
e the performance was likely hurt due to latency from external memory (DRAM=
)",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DATA_RD) / CLKS - tma_mem_bandwidth",
+        "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_dram_bound_group",
+        "MetricName": "tma_mem_latency",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory (DRA=
M).  This metric does not aggregate requests from other Logical Processors/=
Physical Cores/sockets (see Uncore counters for that).",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from local memory",
+        "MetricExpr": "(59.5 * Average_Frequency) * MEM_LOAD_L3_MISS_RETIR=
ED.LOCAL_DRAM * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) /=
 2) / CLKS",
+        "MetricGroup": "Server;TopdownL5;tma_mem_latency_group",
+        "MetricName": "tma_local_dram",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from local memory. Caching will =
improve the latency and increase performance. Sample with: MEM_LOAD_L3_MISS=
_RETIRED.LOCAL_DRAM_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote memory",
+        "MetricExpr": "(127 * Average_Frequency) * MEM_LOAD_L3_MISS_RETIRE=
D.REMOTE_DRAM * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) /=
 2) / CLKS",
+        "MetricGroup": "Server;Snoop;TopdownL5;tma_mem_latency_group",
+        "MetricName": "tma_remote_dram",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote memory. This is caus=
ed often due to non-optimal NUMA allocations. #link to NUMA article Sample =
with: MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote cache in other socket=
s including synchronizations issues",
+        "MetricExpr": "((89.5 * Average_Frequency) * MEM_LOAD_L3_MISS_RETI=
RED.REMOTE_HITM + (89.5 * Average_Frequency) * MEM_LOAD_L3_MISS_RETIRED.REM=
OTE_FWD) * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) / 2) /=
 CLKS",
+        "MetricGroup": "Offcore;Server;Snoop;TopdownL5;tma_mem_latency_gro=
up",
+        "MetricName": "tma_remote_cache",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote cache in other socke=
ts including synchronizations issues. This is caused often due to non-optim=
al NUMA allocations. #link to NUMA article Sample with: MEM_LOAD_L3_MISS_RE=
TIRED.REMOTE_HITM_PS;MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates (based on idle =
latencies) how often the CPU was stalled on accesses to external 3D-Xpoint =
(Crystal Ridge, a.k.a",
+        "MetricExpr": "(((1 - ((19 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM=
 * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))) + 10 * ((MEM=
_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD=
_RETIRED.L1_MISS))) + (MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * (1 + (MEM_LOAD=
_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))) + (MEM_LOAD_L3_MISS_RETIRED.R=
EMOTE_HITM * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))))) =
/ ((19 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM * (1 + (MEM_LOAD_RETIRED.FB_=
HIT / MEM_LOAD_RETIRED.L1_MISS))) + 10 * ((MEM_LOAD_L3_MISS_RETIRED.LOCAL_D=
RAM * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))) + (MEM_LO=
AD_L3_MISS_RETIRED.REMOTE_FWD * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RE=
TIRED.L1_MISS))) + (MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM * (1 + (MEM_LOAD_R=
ETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))))) + (25 * (MEM_LOAD_RETIRED.LOC=
AL_PMM * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))) + 33 *=
 (MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM=
_LOAD_RETIRED.L1_MISS))))))) * (CYCLE_ACTIVITY.STALLS_L3_MISS / CLKS + ((CY=
CLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / CLKS) - tma=
_l2_bound)) if (1000000 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM + MEM_LOAD_R=
ETIRED.LOCAL_PMM) > MEM_LOAD_RETIRED.L1_MISS) else 0)",
+        "MetricGroup": "MemoryBound;Server;TmaL3mem;TopdownL3;tma_memory_b=
ound_group",
+        "MetricName": "tma_pmm_bound",
+        "PublicDescription": "This metric roughly estimates (based on idle=
 latencies) how often the CPU was stalled on accesses to external 3D-Xpoint=
 (Crystal Ridge, a.k.a. IXP) memory by loads, PMM stands for Persistent Mem=
ory Module. ",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to RFO store memory accesses; RFO store issue a read-for-ownership =
request before the write",
+        "MetricExpr": "EXE_ACTIVITY.BOUND_ON_STORES / CLKS",
+        "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_memory_bound_gr=
oup",
+        "MetricName": "tma_store_bound",
+        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to RFO store memory accesses; RFO store issue a read-for-ownership=
 request before the write. Even though store accesses do not typically stal=
l out-of-order CPUs; there are few cases where stores can lead to actual st=
alls. This metric will be flagged should RFO stores be a bottleneck. Sample=
 with: MEM_INST_RETIRED.ALL_STORES_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
+        "MetricExpr": "((L2_RQSTS.RFO_HIT * 11 * (1 - (MEM_INST_RETIRED.LO=
CK_LOADS / MEM_INST_RETIRED.ALL_STORES))) + (1 - (MEM_INST_RETIRED.LOCK_LOA=
DS / MEM_INST_RETIRED.ALL_STORES)) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_R=
EQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / CLKS",
+        "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_store_bound_group"=
,
+        "MetricName": "tma_store_latency",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full)",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
+        "MetricExpr": "((110 * Average_Frequency) * (OCR.DEMAND_RFO.L3_MIS=
S.REMOTE_HITM + OCR.PF_L2_RFO.L3_MISS.REMOTE_HITM) + (47.5 * Average_Freque=
ncy) * (OCR.DEMAND_RFO.L3_HIT.HITM_OTHER_CORE + OCR.PF_L2_RFO.L3_HIT.HITM_O=
THER_CORE)) / CLKS",
+        "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_store_boun=
d_group",
+        "MetricName": "tma_false_sharing",
+        "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line.  Sample with: MEM_LOAD_L3_HIT=
_RETIRED.XSNP_HITM_PS;OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_HITM",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents rate of split store ac=
cesses",
+        "MetricExpr": "MEM_INST_RETIRED.SPLIT_STORES / CORE_CLKS",
+        "MetricGroup": "TopdownL4;tma_store_bound_group",
+        "MetricName": "tma_split_stores",
+        "PublicDescription": "This metric represents rate of split store a=
ccesses.  Consider aligning your data to the 64-byte cache line granularity=
. Sample with: MEM_INST_RETIRED.SPLIT_STORES_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
+        "MetricExpr": "(9 * cpu@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=3D1@ =
+ DTLB_STORE_MISSES.WALK_ACTIVE) / CORE_CLKS",
+        "MetricGroup": "MemoryTLB;TopdownL4;tma_store_bound_group",
+        "MetricName": "tma_dtlb_store",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES_PS",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend. SMT version; use when SMT is enabled and me=
asuring per logical CPU.",
-        "MetricExpr": "1 - (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * ( ( CPU_CLK=
_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK=
_UNHALTED.REF_XCLK ) ))) - ( UOPS_ISSUED.ANY + 4 * ( INT_MISC.RECOVERY_CYCL=
ES_ANY / 2 ) ) / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNH=
ALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
-        "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Backend_Bound_SMT",
-        "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound. SMT version; use when SMT is enabled and measuring per lo=
gical CPU."
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the TLB was missed by store accesses, hitting in the second-l=
evel TLB (STLB)",
+        "MetricExpr": "tma_dtlb_store - tma_store_stlb_miss",
+        "MetricGroup": "MemoryTLB;TopdownL5;tma_dtlb_store_group",
+        "MetricName": "tma_store_stlb_hit",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
where the STLB was missed by store accesses, performing a hardware page wal=
k",
+        "MetricExpr": "DTLB_STORE_MISSES.WALK_ACTIVE / CORE_CLKS",
+        "MetricGroup": "MemoryTLB;TopdownL5;tma_dtlb_store_group",
+        "MetricName": "tma_store_stlb_miss",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e Core non-memory issues were of a bottleneck",
+        "MetricExpr": "tma_backend_bound - tma_memory_bound",
+        "MetricGroup": "Backend;Compute;TopdownL2;tma_L2_group;tma_backend=
_bound_group",
+        "MetricName": "tma_core_bound",
+        "PublicDescription": "This metric represents fraction of slots whe=
re Core non-memory issues were of a bottleneck.  Shortage in hardware compu=
te resources; or dependencies in software's instructions are both categoriz=
ed under Core Bound. Hence it may indicate the machine ran out of an out-of=
-order resource; certain execution units are overloaded or dependencies in =
program's data- or instruction-flow are limiting the performance (e.g. FP-c=
hained long-latency arithmetic operations).",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the Divider unit was active",
+        "MetricExpr": "ARITH.DIVIDER_ACTIVE / CLKS",
+        "MetricGroup": "TopdownL3;tma_core_bound_group",
+        "MetricName": "tma_divider",
+        "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIVIDER_ACTIVE",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
+        "MetricExpr": "(EXE_ACTIVITY.EXE_BOUND_0_PORTS + (EXE_ACTIVITY.1_P=
ORTS_UTIL + tma_retiring * EXE_ACTIVITY.2_PORTS_UTIL)) / CLKS if (ARITH.DIV=
IDER_ACTIVE < (CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.STALLS_MEM_ANY)=
) else (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * EXE_ACTIVITY.2_PORTS_UTI=
L) / CLKS",
+        "MetricGroup": "PortsUtil;TopdownL3;tma_core_bound_group",
+        "MetricName": "tma_ports_utilization",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
+        "MetricExpr": "(UOPS_EXECUTED.CORE_CYCLES_NONE / 2 if #SMT_on else=
 CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.STALLS_MEM_ANY) / CORE_CLKS",
+        "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
+        "MetricName": "tma_ports_utilized_0",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed no uops on any execution port (Logical Processor cycles since IC=
L, Physical Core cycles otherwise). Long-latency instructions like divides =
may contribute to this metric.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU issue-pipeline was stalled due to serializing operations",
+        "MetricExpr": "PARTIAL_RAT_STALLS.SCOREBOARD / CLKS",
+        "MetricGroup": "TopdownL5;tma_ports_utilized_0_group",
+        "MetricName": "tma_serializing_operation",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU issue-pipeline was stalled due to serializing operations. Instruction=
s like CPUID; WRMSR or LFENCE serialize the out-of-order execution which ma=
y limit performance. Sample with: PARTIAL_RAT_STALLS.SCOREBOARD",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to PAUSE Instructions",
+        "MetricExpr": "40 * ROB_MISC_EVENTS.PAUSE_INST / CLKS",
+        "MetricGroup": "TopdownL6;tma_serializing_operation_group",
+        "MetricName": "tma_slow_pause",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to PAUSE Instructions. Sample with: MISC_RETIRED.PAUS=
E_INST",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "The Mixing_Vectors metric gives the percentag=
e of injected blend uops out of all uops issued",
+        "MetricExpr": "CLKS * UOPS_ISSUED.VECTOR_WIDTH_MISMATCH / UOPS_ISS=
UED.ANY",
+        "MetricGroup": "TopdownL5;tma_ports_utilized_0_group",
+        "MetricName": "tma_mixing_vectors",
+        "PublicDescription": "The Mixing_Vectors metric gives the percenta=
ge of injected blend uops out of all uops issued. Usually a Mixing_Vectors =
over 5% is worth investigating. Read more in Appendix B1 of the Optimizatio=
ns Guide for this topic.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the CPU executed total of 1 uop per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise)",
+        "MetricExpr": "((UOPS_EXECUTED.CORE_CYCLES_GE_1 - UOPS_EXECUTED.CO=
RE_CYCLES_GE_2) / 2 if #SMT_on else EXE_ACTIVITY.1_PORTS_UTIL) / CORE_CLKS"=
,
+        "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
+        "MetricName": "tma_ports_utilized_1",
+        "PublicDescription": "This metric represents fraction of cycles wh=
ere the CPU executed total of 1 uop per cycle on all execution ports (Logic=
al Processor cycles since ICL, Physical Core cycles otherwise). This can be=
 due to heavy data-dependency among software instructions; or over oversubs=
cribing a particular hardware resource. In some other cases with high 1_Por=
t_Utilized and L1_Bound; this metric can point to L1 data-cache latency bot=
tleneck that may not necessarily manifest with complete execution starvatio=
n (due to the short L1 latency e.g. walking a linked list) - looking at the=
 assembly can be helpful.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 2 uops per cycle on all execution ports (Logical Process=
or cycles since ICL, Physical Core cycles otherwise)",
+        "MetricExpr": "((UOPS_EXECUTED.CORE_CYCLES_GE_2 - UOPS_EXECUTED.CO=
RE_CYCLES_GE_3) / 2 if #SMT_on else EXE_ACTIVITY.2_PORTS_UTIL) / CORE_CLKS"=
,
+        "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
+        "MetricName": "tma_ports_utilized_2",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise).",
+        "MetricExpr": "(UOPS_EXECUTED.CORE_CYCLES_GE_3 / 2 if #SMT_on else=
 UOPS_EXECUTED.CORE_CYCLES_GE_3) / CORE_CLKS",
+        "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
+        "MetricName": "tma_ports_utilized_3m",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
+        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_0 + UOPS_DISPATCHED_PORT=
.PORT_1 + UOPS_DISPATCHED_PORT.PORT_5 + UOPS_DISPATCHED_PORT.PORT_6) / (4 *=
 CORE_CLKS)",
+        "MetricGroup": "TopdownL5;tma_ports_utilized_3m_group",
+        "MetricName": "tma_alu_op_utilization",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd b=
ranch) Sample with: UOPS_DISPATCHED_PORT.PORT_0",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_0 / CORE_CLKS",
+        "MetricGroup": "Compute;TopdownL6;tma_alu_op_utilization_group",
+        "MetricName": "tma_port_0",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 1 (ALU) Sample with: UOPS_DISPATCHE=
D_PORT.PORT_1",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_1 / CORE_CLKS",
+        "MetricGroup": "TopdownL6;tma_alu_op_utilization_group",
+        "MetricName": "tma_port_1",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 5 ([SNB+] Branches and ALU; [HSW+] =
ALU) Sample with: UOPS_DISPATCHED.PORT_5",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_5 / CORE_CLKS",
+        "MetricGroup": "TopdownL6;tma_alu_op_utilization_group",
+        "MetricName": "tma_port_5",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 6 ([HSW+]Primary Branch and simple =
ALU) Sample with: UOPS_DISPATCHED_PORT.PORT_6",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_6 / CORE_CLKS",
+        "MetricGroup": "TopdownL6;tma_alu_op_utilization_group",
+        "MetricName": "tma_port_6",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Load operations Sample with: UO=
PS_DISPATCHED.PORT_2_3",
+        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_2 + UOPS_DISPATCHED_PORT=
.PORT_3 + UOPS_DISPATCHED_PORT.PORT_7 - UOPS_DISPATCHED_PORT.PORT_4) / (2 *=
 CORE_CLKS)",
+        "MetricGroup": "TopdownL5;tma_ports_utilized_3m_group",
+        "MetricName": "tma_load_op_utilization",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 2 ([SNB+]Loads and Store-address; [=
ICL+] Loads) Sample with: UOPS_DISPATCHED_PORT.PORT_2",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_2 / CORE_CLKS",
+        "MetricGroup": "TopdownL6;tma_load_op_utilization_group",
+        "MetricName": "tma_port_2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 3 ([SNB+]Loads and Store-address; [=
ICL+] Loads) Sample with: UOPS_DISPATCHED_PORT.PORT_3",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_3 / CORE_CLKS",
+        "MetricGroup": "TopdownL6;tma_load_op_utilization_group",
+        "MetricName": "tma_port_3",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Store operations",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_4 / CORE_CLKS",
+        "MetricGroup": "TopdownL5;tma_ports_utilized_3m_group",
+        "MetricName": "tma_store_op_utilization",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 4 (Store-data) Sample with: UOPS_DI=
SPATCHED_PORT.PORT_4",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_4 / CORE_CLKS",
+        "MetricGroup": "TopdownL6;tma_store_op_utilization_group",
+        "MetricName": "tma_port_4",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 7 ([HSW+]simple Store-address) Samp=
le with: UOPS_DISPATCHED_PORT.PORT_7",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_7 / CORE_CLKS",
+        "MetricGroup": "TopdownL6;tma_store_op_utilization_group",
+        "MetricName": "tma_port_7",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_UNHALTED.T=
HREAD)",
-        "MetricGroup": "TopdownL1",
-        "MetricName": "Retiring",
-        "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided. "
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / SLOTS",
+        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricName": "tma_retiring",
+        "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided.  Sample with: UOPS_RETIRE=
D.RETIRE_SLOTS",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired. SMT ver=
sion; use when SMT is enabled and measuring per logical CPU.",
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * ( ( CPU_CLK_UNHALT=
ED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALT=
ED.REF_XCLK ) ))",
-        "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Retiring_SMT",
-        "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided. SMT version; use when SMT=
 is enabled and measuring per logical CPU."
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations -- instructions that require=
 no more than one uop (micro-operation)",
+        "MetricExpr": "tma_retiring - tma_heavy_operations",
+        "MetricGroup": "Retire;TopdownL2;tma_L2_group;tma_retiring_group",
+        "MetricName": "tma_light_operations",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring light-weight operations -- instructions that requir=
e no more than one uop (micro-operation). This correlates with total number=
 of instructions used by the program. A uops-per-instruction (see UPI metri=
c) ratio of 1 or less should be expected for decently optimized software ru=
nning on Intel Core/Xeon products. While this often indicates efficient X86=
 instructions were executed; high value does not necessarily mean better pe=
rformance cannot be achieved. Sample with: INST_RETIRED.PREC_DIST",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
-        "MetricExpr": "100 * ( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_=
RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_=
RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALT=
ED.THREAD))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * =
CPU_CLK_UNHALTED.THREAD)) * ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETI=
RED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * INT_MISC.CLEAR_RESTEER_CYCLES =
/ CPU_CLK_UNHALTED.THREAD) / #(4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DEL=
IV.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) )",
-        "MetricGroup": "Bad;BadSpec;BrMispredicts",
-        "MetricName": "Mispredictions"
+        "BriefDescription": "This metric represents overall arithmetic flo=
ating-point (FP) operations fraction the CPU has executed (retired)",
+        "MetricExpr": "tma_x87_use + tma_fp_scalar + tma_fp_vector",
+        "MetricGroup": "HPC;TopdownL3;tma_light_operations_group",
+        "MetricName": "tma_fp_arith",
+        "PublicDescription": "This metric represents overall arithmetic fl=
oating-point (FP) operations fraction the CPU has executed (retired). Note =
this metric's value may exceed its parent due to use of \"Uops\" CountDomai=
n and FMA double-counting.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric serves as an approximation of leg=
acy x87 usage",
+        "MetricExpr": "tma_retiring * UOPS_EXECUTED.X87 / UOPS_EXECUTED.TH=
READ",
+        "MetricGroup": "Compute;TopdownL4;tma_fp_arith_group",
+        "MetricName": "tma_x87_use",
+        "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) scalar uops fraction the CPU has retired",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE) / UOPS_RETIRED.RETIRE_SLOTS",
+        "MetricGroup": "Compute;Flops;TopdownL4;tma_fp_arith_group",
+        "MetricName": "tma_fp_scalar",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) vector uops fraction the CPU has retired aggregated across all v=
ector widths",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBL=
E + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_P=
ACKED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE) / UOPS_RETIRED.RET=
IRE_SLOTS",
+        "MetricGroup": "Compute;Flops;TopdownL4;tma_fp_arith_group",
+        "MetricName": "tma_fp_vector",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 128-bit wide vectors",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.128B_PACKED_SINGLE) / UOPS_RETIRED.RETIRE_SLOTS",
+        "MetricGroup": "Compute;Flops;TopdownL5;tma_fp_vector_group",
+        "MetricName": "tma_fp_vector_128b",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 256-bit wide vectors",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.256B_PACKED_SINGLE) / UOPS_RETIRED.RETIRE_SLOTS",
+        "MetricGroup": "Compute;Flops;TopdownL5;tma_fp_vector_group",
+        "MetricName": "tma_fp_vector_256b",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 512-bit wide vectors",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.512B_PACKED_SINGLE) / UOPS_RETIRED.RETIRE_SLOTS",
+        "MetricGroup": "Compute;Flops;TopdownL5;tma_fp_vector_group",
+        "MetricName": "tma_fp_vector_512b",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 512-bit wide vectors. May overcount=
 due to FMA double counting.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations -- uops for memory load or store a=
ccesses.",
+        "MetricExpr": "tma_light_operations * MEM_INST_RETIRED.ANY / INST_=
RETIRED.ANY",
+        "MetricGroup": "Pipeline;TopdownL3;tma_light_operations_group",
+        "MetricName": "tma_memory_operations",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions -- where one uop can represent mu=
ltiple contiguous instructions",
+        "MetricExpr": "tma_light_operations * UOPS_RETIRED.MACRO_FUSED / U=
OPS_RETIRED.RETIRE_SLOTS",
+        "MetricGroup": "Pipeline;TopdownL3;tma_light_operations_group",
+        "MetricName": "tma_fused_instructions",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring fused instructions -- where one uop can represent m=
ultiple contiguous instructions. The instruction pairs of CMP+JCC or DEC+JC=
C are commonly used examples.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring branch instructions that were not fused",
+        "MetricExpr": "tma_light_operations * (BR_INST_RETIRED.ALL_BRANCHE=
S - UOPS_RETIRED.MACRO_FUSED) / UOPS_RETIRED.RETIRE_SLOTS",
+        "MetricGroup": "Pipeline;TopdownL3;tma_light_operations_group",
+        "MetricName": "tma_non_fused_branches",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring branch instructions that were not fused. Non-condit=
ional branches like direct JMP or CALL would count here. Can be used to exa=
mine fusible conditional jumps that were not fused.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring NOP (no op) instructions",
+        "MetricExpr": "tma_light_operations * INST_RETIRED.NOP / UOPS_RETI=
RED.RETIRE_SLOTS",
+        "MetricGroup": "Pipeline;TopdownL3;tma_light_operations_group",
+        "MetricName": "tma_nop_instructions",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring NOP (no op) instructions. Compilers often use NOPs =
for certain address alignments - e.g. start address of a function or loop b=
ody. Sample with: INST_RETIRED.NOP",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents the remaining light uo=
ps fraction the CPU has executed - remaining means not covered by other sib=
ling nodes. May undercount due to FMA double counting",
+        "MetricExpr": "max(0, tma_light_operations - (tma_fp_arith + tma_m=
emory_operations + tma_fused_instructions + tma_non_fused_branches + tma_no=
p_instructions))",
+        "MetricGroup": "Pipeline;TopdownL3;tma_light_operations_group",
+        "MetricName": "tma_other_light_ops",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or microcoded sequences",
+        "MetricExpr": "(UOPS_RETIRED.RETIRE_SLOTS + UOPS_RETIRED.MACRO_FUS=
ED - INST_RETIRED.ANY) / SLOTS",
+        "MetricGroup": "Retire;TopdownL2;tma_L2_group;tma_retiring_group",
+        "MetricName": "tma_heavy_operations",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or microcoded sequences. This highly-correlates with the=
 uop length of these instructions/sequences.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring instructions that that are decoder into two or up to=
 ([SNB+] four; [ADL+] five) uops",
+        "MetricExpr": "tma_heavy_operations - tma_microcode_sequencer",
+        "MetricGroup": "TopdownL3;tma_heavy_operations_group",
+        "MetricName": "tma_few_uops_instructions",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring instructions that that are decoder into two or up t=
o ([SNB+] four; [ADL+] five) uops. This highly-correlates with the number o=
f uops in such instructions.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was retiring uops fetched by the Microcode Sequencer (MS) unit",
+        "MetricExpr": "(UOPS_RETIRED.RETIRE_SLOTS / UOPS_ISSUED.ANY) * IDQ=
.MS_UOPS / SLOTS",
+        "MetricGroup": "MicroSeq;TopdownL3;tma_heavy_operations_group",
+        "MetricName": "tma_microcode_sequencer",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The M=
S is used for CISC instructions not supported by the default decoders (like=
 repeat move strings; or CPUID); or by microcode assists used to address so=
me operation modes (like in Floating Point assists). These cases can often =
be avoided. Sample with: IDQ.MS_UOPS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops delivered by the Microcode_Sequencer as a result of Assists=
",
+        "MetricExpr": "100 * (FP_ASSIST.ANY + OTHER_ASSISTS.ANY) / SLOTS",
+        "MetricGroup": "TopdownL4;tma_microcode_sequencer_group",
+        "MetricName": "tma_assists",
+        "PublicDescription": "This metric estimates fraction of slots the =
CPU retired uops delivered by the Microcode_Sequencer as a result of Assist=
s. Assists are long sequences of uops that are required in certain corner-c=
ases for operations that cannot be handled natively by the execution pipeli=
ne. For example; when working with very small floating point values (so-cal=
led Denormals); the FP units are not set up to perform these operations nat=
ively. Instead; a sequence of instructions to perform the computation on th=
e Denormals is injected into the pipeline. Since these microcode sequences =
might be dozens of uops long; Assists can be extremely deleterious to perfo=
rmance and they can be avoided in many cases. Sample with: OTHER_ASSISTS.AN=
Y",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU retired uops originated from CISC (complex instruction set computer) in=
struction",
+        "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
+        "MetricGroup": "TopdownL4;tma_microcode_sequencer_group",
+        "MetricName": "tma_cisc",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU retired uops originated from CISC (complex instruction set computer) i=
nstruction. A CISC instruction has multiple uops that are required to perfo=
rm the instruction's functionality as in the case of read-modify-write as a=
n example. Since these instructions require multiple uops they may or may n=
ot imply sub-optimal use of machine resources.",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
-        "MetricExpr": "100 * ( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_=
RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_=
RETIRED.RETIRE_SLOTS + 4 * ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( =
( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE =
/ CPU_CLK_UNHALTED.REF_XCLK ) )))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_U=
OPS_DELIV.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNH=
ALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * ((BR_MISP_RETIR=
ED.ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) =
* INT_MISC.CLEAR_RESTEER_CYCLES / CPU_CLK_UNHALTED.THREAD) / #(4 * IDQ_UOPS=
_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD =
/ 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCL=
K ) ))) )",
-        "MetricGroup": "Bad;BadSpec;BrMispredicts_SMT",
-        "MetricName": "Mispredictions_SMT"
+        "MetricExpr": "100 * (tma_branch_mispredicts + tma_fetch_latency *=
 tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_i=
cache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts",
+        "MetricName": "Mispredictions"
     },
     {
         "BriefDescription": "Total pipeline cost of (external) Memory Band=
width related bottlenecks",
-        "MetricExpr": "100 * ((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIV=
ITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORT=
S_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_UNHALTED.THREAD)) * EXE_=
ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_UOPS_NO=
T_DELIVERED.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) - ( UOPS_ISSUED.ANY + 4 *=
 INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.THREAD))) * ( ( ( (CYCL=
E_ACTIVITY.STALLS_L3_MISS / CPU_CLK_UNHALTED.THREAD + (( CYCLE_ACTIVITY.STA=
LLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / CPU_CLK_UNHALTED.THREAD) -=
 (( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RE=
TIRED.L1_MISS) )) / ( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB=
_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=
=3D1@ ) ) * (( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MI=
SS ) / CPU_CLK_UNHALTED.THREAD))) - ( ( ( 1 - ( ( 19 * (MEM_LOAD_L3_MISS_RE=
TIRED.REMOTE_DRAM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MI=
SS) )) + 10 * ( (MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * ( 1 + (MEM_LOAD_RETI=
RED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + (MEM_LOAD_L3_MISS_RETIRED.REMOT=
E_FWD * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + (ME=
M_LOAD_L3_MISS_RETIRED.REMOTE_HITM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_L=
OAD_RETIRED.L1_MISS) )) ) ) / ( ( 19 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRA=
M * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + 10 * ( =
(MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM=
_LOAD_RETIRED.L1_MISS) )) + (MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * ( 1 + (M=
EM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + (MEM_LOAD_L3_MISS_R=
ETIRED.REMOTE_HITM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_M=
ISS) )) ) ) + ( 25 * ( MEM_LOAD_RETIRED.LOCAL_PMM * ( 1 + (MEM_LOAD_RETIRED=
.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) ) ) + 33 * ( MEM_LOAD_L3_MISS_RETIRED.R=
EMOTE_PMM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) ) ) =
) ) ) ) * (CYCLE_ACTIVITY.STALLS_L3_MISS / CPU_CLK_UNHALTED.THREAD + (( CYC=
LE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / CPU_CLK_UNH=
ALTED.THREAD) - (( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HI=
T / MEM_LOAD_RETIRED.L1_MISS) )) / ( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_=
LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + cpu@L1D_PEND_MISS.FB_F=
ULL\\,cmask\\=3D1@ ) ) * (( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY=
.STALLS_L2_MISS ) / CPU_CLK_UNHALTED.THREAD))) ) if ( 1000000 * ( MEM_LOAD_=
L3_MISS_RETIRED.REMOTE_PMM + MEM_LOAD_RETIRED.LOCAL_PMM ) > MEM_LOAD_RETIRE=
D.L1_MISS ) else 0 ) ) / #((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.=
BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UT=
IL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_UNHALTED.THREAD)) * EXE_ACTI=
VITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_UOPS_NOT_DE=
LIVERED.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) - ( UOPS_ISSUED.ANY + 4 * INT=
_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.THREAD))) ) * ( (min( CPU_C=
LK_UNHALTED.THREAD , cpu@OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD\\,cmask\\=
=3D4@ ) / CPU_CLK_UNHALTED.THREAD) / #( (CYCLE_ACTIVITY.STALLS_L3_MISS / CP=
U_CLK_UNHALTED.THREAD + (( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.=
STALLS_L2_MISS ) / CPU_CLK_UNHALTED.THREAD) - (( (MEM_LOAD_RETIRED.L2_HIT *=
 ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) / ( (MEM_LOA=
D_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MIS=
S) )) + cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=3D1@ ) ) * (( CYCLE_ACTIVITY.ST=
ALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / CPU_CLK_UNHALTED.THREAD))=
) - ( ( ( 1 - ( ( 19 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM * ( 1 + (MEM_L=
OAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + 10 * ( (MEM_LOAD_L3_MIS=
S_RETIRED.LOCAL_DRAM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1=
_MISS) )) + (MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * ( 1 + (MEM_LOAD_RETIRED.=
FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + (MEM_LOAD_L3_MISS_RETIRED.REMOTE_HI=
TM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) ) ) / ( =
( 19 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM * ( 1 + (MEM_LOAD_RETIRED.FB_H=
IT / MEM_LOAD_RETIRED.L1_MISS) )) + 10 * ( (MEM_LOAD_L3_MISS_RETIRED.LOCAL_=
DRAM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + (MEM=
_LOAD_L3_MISS_RETIRED.REMOTE_FWD * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOA=
D_RETIRED.L1_MISS) )) + (MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM * ( 1 + (MEM_=
LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) ) ) + ( 25 * ( MEM_LOAD_=
RETIRED.LOCAL_PMM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MI=
SS) ) ) + 33 * ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM * ( 1 + (MEM_LOAD_RETI=
RED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) ) ) ) ) ) ) * (CYCLE_ACTIVITY.STALLS=
_L3_MISS / CPU_CLK_UNHALTED.THREAD + (( CYCLE_ACTIVITY.STALLS_L1D_MISS - CY=
CLE_ACTIVITY.STALLS_L2_MISS ) / CPU_CLK_UNHALTED.THREAD) - (( (MEM_LOAD_RET=
IRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) ))=
 / ( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_R=
ETIRED.L1_MISS) )) + cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=3D1@ ) ) * (( CYCL=
E_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / CPU_CLK_UNHA=
LTED.THREAD))) ) if ( 1000000 * ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM + MEM=
_LOAD_RETIRED.LOCAL_PMM ) > MEM_LOAD_RETIRED.L1_MISS ) else 0 ) ) ) + ( (( =
CYCLE_ACTIVITY.STALLS_L2_MISS - CYCLE_ACTIVITY.STALLS_L3_MISS ) / CPU_CLK_U=
NHALTED.THREAD) / #((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.BOUND_O=
N_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UTIL + (U=
OPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_UNHALTED.THREAD)) * EXE_ACTIVITY.2_=
PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_UOPS_NOT_DELIVERED=
.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) - ( UOPS_ISSUED.ANY + 4 * INT_MISC.R=
ECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.THREAD))) ) * ( (OFFCORE_REQUESTS_=
BUFFER.SQ_FULL / CPU_CLK_UNHALTED.THREAD) / #(( CYCLE_ACTIVITY.STALLS_L2_MI=
SS - CYCLE_ACTIVITY.STALLS_L3_MISS ) / CPU_CLK_UNHALTED.THREAD) ) ) + ( (ma=
x( ( CYCLE_ACTIVITY.STALLS_MEM_ANY - CYCLE_ACTIVITY.STALLS_L1D_MISS ) / CPU=
_CLK_UNHALTED.THREAD , 0 )) / #((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTI=
VITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_POR=
TS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_UNHALTED.THREAD)) * EXE=
_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_UOPS_N=
OT_DELIVERED.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) - ( UOPS_ISSUED.ANY + 4 =
* INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.THREAD))) ) * ( ((L1D_=
PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS + MEM_LOAD_RETIRED.FB_HIT ))=
 * cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=3D1@ / CPU_CLK_UNHALTED.THREAD) / #(=
max( ( CYCLE_ACTIVITY.STALLS_MEM_ANY - CYCLE_ACTIVITY.STALLS_L1D_MISS ) / C=
PU_CLK_UNHALTED.THREAD , 0 )) ) ",
+        "MetricExpr": "100 * tma_memory_bound * ((tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma=
_store_bound)) * (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)=
) + (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_=
bound + tma_pmm_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_a=
ccesses + tma_data_sharing + tma_l3_hit_latency + tma_sq_full))) + (tma_l1_=
bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_=
pmm_bound + tma_store_bound)) * (tma_fb_full / (tma_4k_aliasing + tma_dtlb_=
load + tma_fb_full + tma_lock_latency + tma_split_loads + tma_store_fwd_blk=
)) ",
         "MetricGroup": "Mem;MemoryBW;Offcore",
         "MetricName": "Memory_Bandwidth"
     },
-    {
-        "BriefDescription": "Total pipeline cost of (external) Memory Band=
width related bottlenecks",
-        "MetricExpr": "100 * ((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIV=
ITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORT=
S_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 =
) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) =
))) * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (I=
DQ_UOPS_NOT_DELIVERED.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 +=
 CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) - ( U=
OPS_ISSUED.ANY + 4 * ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_=
CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_=
CLK_UNHALTED.REF_XCLK ) )))) * ( ( ( (CYCLE_ACTIVITY.STALLS_L3_MISS / CPU_C=
LK_UNHALTED.THREAD + (( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STA=
LLS_L2_MISS ) / CPU_CLK_UNHALTED.THREAD) - (( (MEM_LOAD_RETIRED.L2_HIT * ( =
1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) / ( (MEM_LOAD_R=
ETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) =
)) + cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=3D1@ ) ) * (( CYCLE_ACTIVITY.STALL=
S_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / CPU_CLK_UNHALTED.THREAD))) -=
 ( ( ( 1 - ( ( 19 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM * ( 1 + (MEM_LOAD=
_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + 10 * ( (MEM_LOAD_L3_MISS_R=
ETIRED.LOCAL_DRAM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MI=
SS) )) + (MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * ( 1 + (MEM_LOAD_RETIRED.FB_=
HIT / MEM_LOAD_RETIRED.L1_MISS) )) + (MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM =
* ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) ) ) / ( ( 1=
9 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT =
/ MEM_LOAD_RETIRED.L1_MISS) )) + 10 * ( (MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRA=
M * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + (MEM_LO=
AD_L3_MISS_RETIRED.REMOTE_FWD * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_R=
ETIRED.L1_MISS) )) + (MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM * ( 1 + (MEM_LOA=
D_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) ) ) + ( 25 * ( MEM_LOAD_RET=
IRED.LOCAL_PMM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS)=
 ) ) + 33 * ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM * ( 1 + (MEM_LOAD_RETIRED=
.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) ) ) ) ) ) ) * (CYCLE_ACTIVITY.STALLS_L3=
_MISS / CPU_CLK_UNHALTED.THREAD + (( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE=
_ACTIVITY.STALLS_L2_MISS ) / CPU_CLK_UNHALTED.THREAD) - (( (MEM_LOAD_RETIRE=
D.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) / =
( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETI=
RED.L1_MISS) )) + cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=3D1@ ) ) * (( CYCLE_A=
CTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / CPU_CLK_UNHALTE=
D.THREAD))) ) if ( 1000000 * ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM + MEM_LO=
AD_RETIRED.LOCAL_PMM ) > MEM_LOAD_RETIRED.L1_MISS ) else 0 ) ) / #((( CYCLE=
_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY=
.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (=
4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_A=
CTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_=
ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * ( ( C=
PU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / C=
PU_CLK_UNHALTED.REF_XCLK ) ))) - ( UOPS_ISSUED.ANY + 4 * ( INT_MISC.RECOVER=
Y_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_C=
LK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) ) * ( (min=
( CPU_CLK_UNHALTED.THREAD , cpu@OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD\\,=
cmask\\=3D4@ ) / CPU_CLK_UNHALTED.THREAD) / #( (CYCLE_ACTIVITY.STALLS_L3_MI=
SS / CPU_CLK_UNHALTED.THREAD + (( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_AC=
TIVITY.STALLS_L2_MISS ) / CPU_CLK_UNHALTED.THREAD) - (( (MEM_LOAD_RETIRED.L=
2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) / ( (=
MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED=
.L1_MISS) )) + cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=3D1@ ) ) * (( CYCLE_ACTI=
VITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / CPU_CLK_UNHALTED.T=
HREAD))) - ( ( ( 1 - ( ( 19 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM * ( 1 +=
 (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + 10 * ( (MEM_LOAD=
_L3_MISS_RETIRED.LOCAL_DRAM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RET=
IRED.L1_MISS) )) + (MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * ( 1 + (MEM_LOAD_R=
ETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + (MEM_LOAD_L3_MISS_RETIRED.RE=
MOTE_HITM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) )=
 ) / ( ( 19 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM * ( 1 + (MEM_LOAD_RETIR=
ED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + 10 * ( (MEM_LOAD_L3_MISS_RETIRED=
.LOCAL_DRAM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) ))=
 + (MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / =
MEM_LOAD_RETIRED.L1_MISS) )) + (MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM * ( 1 =
+ (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) ) ) + ( 25 * ( ME=
M_LOAD_RETIRED.LOCAL_PMM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRE=
D.L1_MISS) ) ) + 33 * ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM * ( 1 + (MEM_LO=
AD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) ) ) ) ) ) ) * (CYCLE_ACTIVITY=
.STALLS_L3_MISS / CPU_CLK_UNHALTED.THREAD + (( CYCLE_ACTIVITY.STALLS_L1D_MI=
SS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / CPU_CLK_UNHALTED.THREAD) - (( (MEM_L=
OAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_M=
ISS) )) / ( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM=
_LOAD_RETIRED.L1_MISS) )) + cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=3D1@ ) ) * =
(( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / CPU_C=
LK_UNHALTED.THREAD))) ) if ( 1000000 * ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_PM=
M + MEM_LOAD_RETIRED.LOCAL_PMM ) > MEM_LOAD_RETIRED.L1_MISS ) else 0 ) ) ) =
+ ( (( CYCLE_ACTIVITY.STALLS_L2_MISS - CYCLE_ACTIVITY.STALLS_L3_MISS ) / CP=
U_CLK_UNHALTED.THREAD) / #((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.=
BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UT=
IL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * =
( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) =
* EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_U=
OPS_NOT_DELIVERED.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU=
_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) - ( UOPS_=
ISSUED.ANY + 4 * ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_CLK_=
UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_=
UNHALTED.REF_XCLK ) )))) ) * ( (( OFFCORE_REQUESTS_BUFFER.SQ_FULL / 2 ) / (=
 ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE=
 / CPU_CLK_UNHALTED.REF_XCLK ) )) / #(( CYCLE_ACTIVITY.STALLS_L2_MISS - CYC=
LE_ACTIVITY.STALLS_L3_MISS ) / CPU_CLK_UNHALTED.THREAD) ) ) + ( (max( ( CYC=
LE_ACTIVITY.STALLS_MEM_ANY - CYCLE_ACTIVITY.STALLS_L1D_MISS ) / CPU_CLK_UNH=
ALTED.THREAD , 0 )) / #((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.BOU=
ND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UTIL =
+ (UOPS_RETIRED.RETIRE_SLOTS / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1=
 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * E=
XE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_UOPS=
_NOT_DELIVERED.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CL=
K_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) - ( UOPS_ISS=
UED.ANY + 4 * ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_CLK_UNH=
ALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNH=
ALTED.REF_XCLK ) )))) ) * ( ((L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1=
_MISS + MEM_LOAD_RETIRED.FB_HIT )) * cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=3D=
1@ / CPU_CLK_UNHALTED.THREAD) / #(max( ( CYCLE_ACTIVITY.STALLS_MEM_ANY - CY=
CLE_ACTIVITY.STALLS_L1D_MISS ) / CPU_CLK_UNHALTED.THREAD , 0 )) ) ",
-        "MetricGroup": "Mem;MemoryBW;Offcore_SMT",
-        "MetricName": "Memory_Bandwidth_SMT"
-    },
     {
         "BriefDescription": "Total pipeline cost of Memory Latency related=
 bottlenecks (external memory and off-core caches)",
-        "MetricExpr": "100 * ((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIV=
ITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORT=
S_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_UNHALTED.THREAD)) * EXE_=
ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_UOPS_NO=
T_DELIVERED.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) - ( UOPS_ISSUED.ANY + 4 *=
 INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.THREAD))) * ( ( ( (CYCL=
E_ACTIVITY.STALLS_L3_MISS / CPU_CLK_UNHALTED.THREAD + (( CYCLE_ACTIVITY.STA=
LLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / CPU_CLK_UNHALTED.THREAD) -=
 (( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RE=
TIRED.L1_MISS) )) / ( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB=
_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=
=3D1@ ) ) * (( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MI=
SS ) / CPU_CLK_UNHALTED.THREAD))) - ( ( ( 1 - ( ( 19 * (MEM_LOAD_L3_MISS_RE=
TIRED.REMOTE_DRAM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MI=
SS) )) + 10 * ( (MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * ( 1 + (MEM_LOAD_RETI=
RED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + (MEM_LOAD_L3_MISS_RETIRED.REMOT=
E_FWD * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + (ME=
M_LOAD_L3_MISS_RETIRED.REMOTE_HITM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_L=
OAD_RETIRED.L1_MISS) )) ) ) / ( ( 19 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRA=
M * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + 10 * ( =
(MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM=
_LOAD_RETIRED.L1_MISS) )) + (MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * ( 1 + (M=
EM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + (MEM_LOAD_L3_MISS_R=
ETIRED.REMOTE_HITM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_M=
ISS) )) ) ) + ( 25 * ( MEM_LOAD_RETIRED.LOCAL_PMM * ( 1 + (MEM_LOAD_RETIRED=
.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) ) ) + 33 * ( MEM_LOAD_L3_MISS_RETIRED.R=
EMOTE_PMM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) ) ) =
) ) ) ) * (CYCLE_ACTIVITY.STALLS_L3_MISS / CPU_CLK_UNHALTED.THREAD + (( CYC=
LE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / CPU_CLK_UNH=
ALTED.THREAD) - (( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HI=
T / MEM_LOAD_RETIRED.L1_MISS) )) / ( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_=
LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + cpu@L1D_PEND_MISS.FB_F=
ULL\\,cmask\\=3D1@ ) ) * (( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY=
.STALLS_L2_MISS ) / CPU_CLK_UNHALTED.THREAD))) ) if ( 1000000 * ( MEM_LOAD_=
L3_MISS_RETIRED.REMOTE_PMM + MEM_LOAD_RETIRED.LOCAL_PMM ) > MEM_LOAD_RETIRE=
D.L1_MISS ) else 0 ) ) / #((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.=
BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UT=
IL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_UNHALTED.THREAD)) * EXE_ACTI=
VITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_UOPS_NOT_DE=
LIVERED.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) - ( UOPS_ISSUED.ANY + 4 * INT=
_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.THREAD))) ) * ( (min( CPU_C=
LK_UNHALTED.THREAD , OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD ) / C=
PU_CLK_UNHALTED.THREAD - (min( CPU_CLK_UNHALTED.THREAD , cpu@OFFCORE_REQUES=
TS_OUTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@ ) / CPU_CLK_UNHALTED.THREAD)) / #=
( (CYCLE_ACTIVITY.STALLS_L3_MISS / CPU_CLK_UNHALTED.THREAD + (( CYCLE_ACTIV=
ITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / CPU_CLK_UNHALTED.TH=
READ) - (( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_=
LOAD_RETIRED.L1_MISS) )) / ( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RET=
IRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + cpu@L1D_PEND_MISS.FB_FULL\\,cm=
ask\\=3D1@ ) ) * (( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_=
L2_MISS ) / CPU_CLK_UNHALTED.THREAD))) - ( ( ( 1 - ( ( 19 * (MEM_LOAD_L3_MI=
SS_RETIRED.REMOTE_DRAM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.=
L1_MISS) )) + 10 * ( (MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * ( 1 + (MEM_LOAD=
_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + (MEM_LOAD_L3_MISS_RETIRED.=
REMOTE_FWD * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) =
+ (MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / =
MEM_LOAD_RETIRED.L1_MISS) )) ) ) / ( ( 19 * (MEM_LOAD_L3_MISS_RETIRED.REMOT=
E_DRAM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + 10=
 * ( (MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT =
/ MEM_LOAD_RETIRED.L1_MISS) )) + (MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * ( 1=
 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + (MEM_LOAD_L3_M=
ISS_RETIRED.REMOTE_HITM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED=
.L1_MISS) )) ) ) + ( 25 * ( MEM_LOAD_RETIRED.LOCAL_PMM * ( 1 + (MEM_LOAD_RE=
TIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) ) ) + 33 * ( MEM_LOAD_L3_MISS_RETI=
RED.REMOTE_PMM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS)=
 ) ) ) ) ) ) * (CYCLE_ACTIVITY.STALLS_L3_MISS / CPU_CLK_UNHALTED.THREAD + (=
( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / CPU_CL=
K_UNHALTED.THREAD) - (( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.=
FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) / ( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + =
(MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + cpu@L1D_PEND_MISS=
.FB_FULL\\,cmask\\=3D1@ ) ) * (( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACT=
IVITY.STALLS_L2_MISS ) / CPU_CLK_UNHALTED.THREAD))) ) if ( 1000000 * ( MEM_=
LOAD_L3_MISS_RETIRED.REMOTE_PMM + MEM_LOAD_RETIRED.LOCAL_PMM ) > MEM_LOAD_R=
ETIRED.L1_MISS ) else 0 ) ) ) + ( (( CYCLE_ACTIVITY.STALLS_L2_MISS - CYCLE_=
ACTIVITY.STALLS_L3_MISS ) / CPU_CLK_UNHALTED.THREAD) / #((( CYCLE_ACTIVITY.=
STALLS_MEM_ANY + EXE_ACTIVITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TO=
TAL + (EXE_ACTIVITY.1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CL=
K_UNHALTED.THREAD)) * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_ST=
ORES)) * (1 - (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * CPU_CLK_UNHALTED.THREAD))=
 - ( UOPS_ISSUED.ANY + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALT=
ED.THREAD))) ) * ( (( (20.5 * ((CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.=
REF_TSC) * msr@tsc@ / 1000000000 / duration_time)) - (3.5 * ((CPU_CLK_UNHAL=
TED.THREAD / CPU_CLK_UNHALTED.REF_TSC) * msr@tsc@ / 1000000000 / duration_t=
ime)) ) * MEM_LOAD_RETIRED.L3_HIT * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOA=
D_RETIRED.L1_MISS) / 2) / CPU_CLK_UNHALTED.THREAD) / #(( CYCLE_ACTIVITY.STA=
LLS_L2_MISS - CYCLE_ACTIVITY.STALLS_L3_MISS ) / CPU_CLK_UNHALTED.THREAD) ) =
+ ( (( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD=
_RETIRED.L1_MISS) )) / ( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED=
.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + cpu@L1D_PEND_MISS.FB_FULL\\,cmask\=
\=3D1@ ) ) * (( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_M=
ISS ) / CPU_CLK_UNHALTED.THREAD)) / #((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EX=
E_ACTIVITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY=
.1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_UNHALTED.THREAD))=
 * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_=
UOPS_NOT_DELIVERED.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) - ( UOPS_ISSUED.AN=
Y + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.THREAD))) ) )",
+        "MetricExpr": "100 * tma_memory_bound * ((tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma=
_store_bound)) * (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) =
+ (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bo=
und + tma_pmm_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contes=
ted_accesses + tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + (tma=
_l2_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + =
tma_pmm_bound + tma_store_bound)))",
         "MetricGroup": "Mem;MemoryLat;Offcore",
         "MetricName": "Memory_Latency"
     },
-    {
-        "BriefDescription": "Total pipeline cost of Memory Latency related=
 bottlenecks (external memory and off-core caches)",
-        "MetricExpr": "100 * ((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIV=
ITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORT=
S_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 =
) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) =
))) * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (I=
DQ_UOPS_NOT_DELIVERED.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 +=
 CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) - ( U=
OPS_ISSUED.ANY + 4 * ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_=
CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_=
CLK_UNHALTED.REF_XCLK ) )))) * ( ( ( (CYCLE_ACTIVITY.STALLS_L3_MISS / CPU_C=
LK_UNHALTED.THREAD + (( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STA=
LLS_L2_MISS ) / CPU_CLK_UNHALTED.THREAD) - (( (MEM_LOAD_RETIRED.L2_HIT * ( =
1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) / ( (MEM_LOAD_R=
ETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) =
)) + cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=3D1@ ) ) * (( CYCLE_ACTIVITY.STALL=
S_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / CPU_CLK_UNHALTED.THREAD))) -=
 ( ( ( 1 - ( ( 19 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM * ( 1 + (MEM_LOAD=
_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + 10 * ( (MEM_LOAD_L3_MISS_R=
ETIRED.LOCAL_DRAM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MI=
SS) )) + (MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * ( 1 + (MEM_LOAD_RETIRED.FB_=
HIT / MEM_LOAD_RETIRED.L1_MISS) )) + (MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM =
* ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) ) ) / ( ( 1=
9 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT =
/ MEM_LOAD_RETIRED.L1_MISS) )) + 10 * ( (MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRA=
M * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + (MEM_LO=
AD_L3_MISS_RETIRED.REMOTE_FWD * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_R=
ETIRED.L1_MISS) )) + (MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM * ( 1 + (MEM_LOA=
D_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) ) ) + ( 25 * ( MEM_LOAD_RET=
IRED.LOCAL_PMM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS)=
 ) ) + 33 * ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM * ( 1 + (MEM_LOAD_RETIRED=
.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) ) ) ) ) ) ) * (CYCLE_ACTIVITY.STALLS_L3=
_MISS / CPU_CLK_UNHALTED.THREAD + (( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE=
_ACTIVITY.STALLS_L2_MISS ) / CPU_CLK_UNHALTED.THREAD) - (( (MEM_LOAD_RETIRE=
D.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) / =
( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETI=
RED.L1_MISS) )) + cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=3D1@ ) ) * (( CYCLE_A=
CTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / CPU_CLK_UNHALTE=
D.THREAD))) ) if ( 1000000 * ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM + MEM_LO=
AD_RETIRED.LOCAL_PMM ) > MEM_LOAD_RETIRED.L1_MISS ) else 0 ) ) / #((( CYCLE=
_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY=
.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (=
4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_A=
CTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_=
ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * ( ( C=
PU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / C=
PU_CLK_UNHALTED.REF_XCLK ) ))) - ( UOPS_ISSUED.ANY + 4 * ( INT_MISC.RECOVER=
Y_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_C=
LK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) ) * ( (min=
( CPU_CLK_UNHALTED.THREAD , OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_R=
D ) / CPU_CLK_UNHALTED.THREAD - (min( CPU_CLK_UNHALTED.THREAD , cpu@OFFCORE=
_REQUESTS_OUTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@ ) / CPU_CLK_UNHALTED.THREA=
D)) / #( (CYCLE_ACTIVITY.STALLS_L3_MISS / CPU_CLK_UNHALTED.THREAD + (( CYCL=
E_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / CPU_CLK_UNHA=
LTED.THREAD) - (( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT=
 / MEM_LOAD_RETIRED.L1_MISS) )) / ( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_L=
OAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + cpu@L1D_PEND_MISS.FB_FU=
LL\\,cmask\\=3D1@ ) ) * (( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.=
STALLS_L2_MISS ) / CPU_CLK_UNHALTED.THREAD))) - ( ( ( 1 - ( ( 19 * (MEM_LOA=
D_L3_MISS_RETIRED.REMOTE_DRAM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_R=
ETIRED.L1_MISS) )) + 10 * ( (MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * ( 1 + (M=
EM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + (MEM_LOAD_L3_MISS_R=
ETIRED.REMOTE_FWD * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MI=
SS) )) + (MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM * ( 1 + (MEM_LOAD_RETIRED.FB=
_HIT / MEM_LOAD_RETIRED.L1_MISS) )) ) ) / ( ( 19 * (MEM_LOAD_L3_MISS_RETIRE=
D.REMOTE_DRAM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) =
)) + 10 * ( (MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * ( 1 + (MEM_LOAD_RETIRED.=
FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + (MEM_LOAD_L3_MISS_RETIRED.REMOTE_FW=
D * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + (MEM_LO=
AD_L3_MISS_RETIRED.REMOTE_HITM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_=
RETIRED.L1_MISS) )) ) ) + ( 25 * ( MEM_LOAD_RETIRED.LOCAL_PMM * ( 1 + (MEM_=
LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) ) ) + 33 * ( MEM_LOAD_L3_MI=
SS_RETIRED.REMOTE_PMM * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L=
1_MISS) ) ) ) ) ) ) * (CYCLE_ACTIVITY.STALLS_L3_MISS / CPU_CLK_UNHALTED.THR=
EAD + (( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) /=
 CPU_CLK_UNHALTED.THREAD) - (( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_R=
ETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) / ( (MEM_LOAD_RETIRED.L2_HIT *=
 ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + cpu@L1D_PE=
ND_MISS.FB_FULL\\,cmask\\=3D1@ ) ) * (( CYCLE_ACTIVITY.STALLS_L1D_MISS - CY=
CLE_ACTIVITY.STALLS_L2_MISS ) / CPU_CLK_UNHALTED.THREAD))) ) if ( 1000000 *=
 ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM + MEM_LOAD_RETIRED.LOCAL_PMM ) > MEM=
_LOAD_RETIRED.L1_MISS ) else 0 ) ) ) + ( (( CYCLE_ACTIVITY.STALLS_L2_MISS -=
 CYCLE_ACTIVITY.STALLS_L3_MISS ) / CPU_CLK_UNHALTED.THREAD) / #((( CYCLE_AC=
TIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.ST=
ALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 *=
 ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTI=
VE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACT=
IVITY.BOUND_ON_STORES)) * (1 - (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * ( ( CPU_=
CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_=
CLK_UNHALTED.REF_XCLK ) ))) - ( UOPS_ISSUED.ANY + 4 * ( INT_MISC.RECOVERY_C=
YCLES_ANY / 2 ) ) / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_=
UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) ) * ( (( (20.=
5 * ((CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC) * msr@tsc@ / 1000=
000000 / duration_time)) - (3.5 * ((CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHAL=
TED.REF_TSC) * msr@tsc@ / 1000000000 / duration_time)) ) * MEM_LOAD_RETIRED=
.L3_HIT * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) / 2) / =
CPU_CLK_UNHALTED.THREAD) / #(( CYCLE_ACTIVITY.STALLS_L2_MISS - CYCLE_ACTIVI=
TY.STALLS_L3_MISS ) / CPU_CLK_UNHALTED.THREAD) ) + ( (( (MEM_LOAD_RETIRED.L=
2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) / ( (=
MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED=
.L1_MISS) )) + cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=3D1@ ) ) * (( CYCLE_ACTI=
VITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / CPU_CLK_UNHALTED.T=
HREAD)) / #((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.BOUND_ON_STORES=
 ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UTIL + (UOPS_RETI=
RED.RETIRE_SLOTS / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_U=
NHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * EXE_ACTIVITY.=
2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_UOPS_NOT_DELIVER=
ED.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.O=
NE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) - ( UOPS_ISSUED.ANY + 4 =
* ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_CLK_UNHALTED.THREAD=
 / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XC=
LK ) )))) ) )",
-        "MetricGroup": "Mem;MemoryLat;Offcore_SMT",
-        "MetricName": "Memory_Latency_SMT"
-    },
     {
         "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
-        "MetricExpr": "100 * ((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIV=
ITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORT=
S_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_UNHALTED.THREAD)) * EXE_=
ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_UOPS_NO=
T_DELIVERED.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) - ( UOPS_ISSUED.ANY + 4 *=
 INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.THREAD))) * ( ( (max( (=
 CYCLE_ACTIVITY.STALLS_MEM_ANY - CYCLE_ACTIVITY.STALLS_L1D_MISS ) / CPU_CLK=
_UNHALTED.THREAD , 0 )) / ((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.=
BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UT=
IL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_UNHALTED.THREAD)) * EXE_ACTI=
VITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_UOPS_NOT_DE=
LIVERED.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) - ( UOPS_ISSUED.ANY + 4 * INT=
_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.THREAD))) ) * ( (min( 9 * c=
pu@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\\=3D1@ + DTLB_LOAD_MISSES.WALK_ACTIVE =
, max( CYCLE_ACTIVITY.CYCLES_MEM_ANY - CYCLE_ACTIVITY.CYCLES_L1D_MISS , 0 )=
 ) / CPU_CLK_UNHALTED.THREAD) / (max( ( CYCLE_ACTIVITY.STALLS_MEM_ANY - CYC=
LE_ACTIVITY.STALLS_L1D_MISS ) / CPU_CLK_UNHALTED.THREAD , 0 )) ) + ( (EXE_A=
CTIVITY.BOUND_ON_STORES / CPU_CLK_UNHALTED.THREAD) / #((( CYCLE_ACTIVITY.ST=
ALLS_MEM_ANY + EXE_ACTIVITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTA=
L + (EXE_ACTIVITY.1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_=
UNHALTED.THREAD)) * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STOR=
ES)) * (1 - (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) -=
 ( UOPS_ISSUED.ANY + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED=
.THREAD))) ) * ( (( 9 * cpu@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=3D1@ + DTL=
B_STORE_MISSES.WALK_ACTIVE ) / CPU_CLK_UNHALTED.THREAD) / #(EXE_ACTIVITY.BO=
UND_ON_STORES / CPU_CLK_UNHALTED.THREAD) ) ) ",
+        "MetricExpr": "100 * tma_memory_bound * ((tma_l1_bound / max(tma_m=
emory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + =
tma_pmm_bound + tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, tma_=
4k_aliasing + tma_dtlb_load + tma_fb_full + tma_lock_latency + tma_split_lo=
ads + tma_store_fwd_blk)) + (tma_store_bound / (tma_dram_bound + tma_l1_bou=
nd + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma_store_bound)) * (tma=
_dtlb_store / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tma_=
store_latency))) ",
         "MetricGroup": "Mem;MemoryTLB;Offcore",
         "MetricName": "Memory_Data_TLBs"
     },
-    {
-        "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
-        "MetricExpr": "100 * ((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIV=
ITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORT=
S_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 =
) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) =
))) * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (I=
DQ_UOPS_NOT_DELIVERED.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 +=
 CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) - ( U=
OPS_ISSUED.ANY + 4 * ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_=
CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_=
CLK_UNHALTED.REF_XCLK ) )))) * ( ( (max( ( CYCLE_ACTIVITY.STALLS_MEM_ANY - =
CYCLE_ACTIVITY.STALLS_L1D_MISS ) / CPU_CLK_UNHALTED.THREAD , 0 )) / ((( CYC=
LE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.BOUND_ON_STORES ) / (CYCLE_ACTIVI=
TY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS /=
 (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD=
_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * EXE_ACTIVITY.2_PORTS_UTIL) + EX=
E_ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * ( (=
 CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE /=
 CPU_CLK_UNHALTED.REF_XCLK ) ))) - ( UOPS_ISSUED.ANY + 4 * ( INT_MISC.RECOV=
ERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU=
_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) ) * ( (m=
in( 9 * cpu@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\\=3D1@ + DTLB_LOAD_MISSES.WAL=
K_ACTIVE , max( CYCLE_ACTIVITY.CYCLES_MEM_ANY - CYCLE_ACTIVITY.CYCLES_L1D_M=
ISS , 0 ) ) / CPU_CLK_UNHALTED.THREAD) / (max( ( CYCLE_ACTIVITY.STALLS_MEM_=
ANY - CYCLE_ACTIVITY.STALLS_L1D_MISS ) / CPU_CLK_UNHALTED.THREAD , 0 )) ) +=
 ( (EXE_ACTIVITY.BOUND_ON_STORES / CPU_CLK_UNHALTED.THREAD) / #((( CYCLE_AC=
TIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.ST=
ALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 *=
 ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTI=
VE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACT=
IVITY.BOUND_ON_STORES)) * (1 - (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * ( ( CPU_=
CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_=
CLK_UNHALTED.REF_XCLK ) ))) - ( UOPS_ISSUED.ANY + 4 * ( INT_MISC.RECOVERY_C=
YCLES_ANY / 2 ) ) / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_=
UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) ) * ( (( 9 * =
cpu@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=3D1@ + DTLB_STORE_MISSES.WALK_ACTI=
VE ) / ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREA=
D_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )) / #(EXE_ACTIVITY.BOUND_ON_STORES =
/ CPU_CLK_UNHALTED.THREAD) ) ) ",
-        "MetricGroup": "Mem;MemoryTLB;Offcore_SMT",
-        "MetricName": "Memory_Data_TLBs_SMT"
-    },
     {
         "BriefDescription": "Total pipeline cost of branch related instruc=
tions (used for program control-flow including function calls)",
-        "MetricExpr": "100 * (( BR_INST_RETIRED.CONDITIONAL + 3 * BR_INST_=
RETIRED.NEAR_CALL + (BR_INST_RETIRED.NEAR_TAKEN - ( BR_INST_RETIRED.CONDITI=
ONAL - BR_INST_RETIRED.NOT_TAKEN ) - 2 * BR_INST_RETIRED.NEAR_CALL) ) / (4 =
* CPU_CLK_UNHALTED.THREAD))",
+        "MetricExpr": "100 * ((BR_INST_RETIRED.CONDITIONAL + 3 * BR_INST_R=
ETIRED.NEAR_CALL + (BR_INST_RETIRED.NEAR_TAKEN - (BR_INST_RETIRED.CONDITION=
AL - BR_INST_RETIRED.NOT_TAKEN) - 2 * BR_INST_RETIRED.NEAR_CALL)) / SLOTS)"=
,
         "MetricGroup": "Ret",
         "MetricName": "Branching_Overhead"
     },
-    {
-        "BriefDescription": "Total pipeline cost of branch related instruc=
tions (used for program control-flow including function calls)",
-        "MetricExpr": "100 * (( BR_INST_RETIRED.CONDITIONAL + 3 * BR_INST_=
RETIRED.NEAR_CALL + (BR_INST_RETIRED.NEAR_TAKEN - ( BR_INST_RETIRED.CONDITI=
ONAL - BR_INST_RETIRED.NOT_TAKEN ) - 2 * BR_INST_RETIRED.NEAR_CALL) ) / (4 =
* ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACT=
IVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "MetricGroup": "Ret_SMT",
-        "MetricName": "Branching_Overhead_SMT"
-    },
     {
         "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
-        "MetricExpr": "100 * (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DEL=
IV.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) * ( (ICACHE_64B.IFTAG_STALL / CPU_=
CLK_UNHALTED.THREAD) + (( ICACHE_16B.IFDATA_STALL + 2 * cpu@ICACHE_16B.IFDA=
TA_STALL\\,cmask\\=3D1\\,edge@ ) / CPU_CLK_UNHALTED.THREAD) + (9 * BACLEARS=
.ANY / CPU_CLK_UNHALTED.THREAD) ) / #(4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_U=
OPS_DELIV.CORE / (4 * CPU_CLK_UNHALTED.THREAD))",
+        "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_branch_resteers + tma_dsb_switch=
es + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)",
         "MetricGroup": "BigFoot;Fed;Frontend;IcMiss;MemoryTLB",
         "MetricName": "Big_Code"
     },
-    {
-        "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
-        "MetricExpr": "100 * (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DEL=
IV.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.O=
NE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * ( (ICACHE_64B.IFTAG_ST=
ALL / CPU_CLK_UNHALTED.THREAD) + (( ICACHE_16B.IFDATA_STALL + 2 * cpu@ICACH=
E_16B.IFDATA_STALL\\,cmask\\=3D1\\,edge@ ) / CPU_CLK_UNHALTED.THREAD) + (9 =
* BACLEARS.ANY / CPU_CLK_UNHALTED.THREAD) ) / #(4 * IDQ_UOPS_NOT_DELIVERED.=
CYCLES_0_UOPS_DELIV.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + C=
PU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "MetricGroup": "BigFoot;Fed;Frontend;IcMiss;MemoryTLB_SMT",
-        "MetricName": "Big_Code_SMT"
-    },
     {
         "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks",
-        "MetricExpr": "100 * ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * CPU_CLK=
_UNHALTED.THREAD)) - (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE /=
 (4 * CPU_CLK_UNHALTED.THREAD)) * ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MIS=
P_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * INT_MISC.CLEAR_RESTEER_C=
YCLES / CPU_CLK_UNHALTED.THREAD) / #(4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UO=
PS_DELIV.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) ) - (100 * (4 * IDQ_UOPS_NOT=
_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) * ( (I=
CACHE_64B.IFTAG_STALL / CPU_CLK_UNHALTED.THREAD) + (( ICACHE_16B.IFDATA_STA=
LL + 2 * cpu@ICACHE_16B.IFDATA_STALL\\,cmask\\=3D1\\,edge@ ) / CPU_CLK_UNHA=
LTED.THREAD) + (9 * BACLEARS.ANY / CPU_CLK_UNHALTED.THREAD) ) / #(4 * IDQ_U=
OPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * CPU_CLK_UNHALTED.THREAD))=
)",
+        "MetricExpr": "100 * (tma_frontend_bound - tma_fetch_latency * tma=
_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icach=
e_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) - Big_Code",
         "MetricGroup": "Fed;FetchBW;Frontend",
         "MetricName": "Instruction_Fetch_BW"
     },
-    {
-        "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks",
-        "MetricExpr": "100 * ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * ( ( CPU=
_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU=
_CLK_UNHALTED.REF_XCLK ) ))) - (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DE=
LIV.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.=
ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * ((BR_MISP_RETIRED.ALL=
_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * INT_=
MISC.CLEAR_RESTEER_CYCLES / CPU_CLK_UNHALTED.THREAD) / #(4 * IDQ_UOPS_NOT_D=
ELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) =
* ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))=
) ) - (100 * (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * ( =
( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE =
/ CPU_CLK_UNHALTED.REF_XCLK ) ))) * ( (ICACHE_64B.IFTAG_STALL / CPU_CLK_UNH=
ALTED.THREAD) + (( ICACHE_16B.IFDATA_STALL + 2 * cpu@ICACHE_16B.IFDATA_STAL=
L\\,cmask\\=3D1\\,edge@ ) / CPU_CLK_UNHALTED.THREAD) + (9 * BACLEARS.ANY / =
CPU_CLK_UNHALTED.THREAD) ) / #(4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DEL=
IV.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.O=
NE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))))",
-        "MetricGroup": "Fed;FetchBW;Frontend_SMT",
-        "MetricName": "Instruction_Fetch_BW_SMT"
-    },
     {
         "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
-        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
+        "MetricExpr": "INST_RETIRED.ANY / CLKS",
         "MetricGroup": "Ret;Summary",
         "MetricName": "IPC"
     },
@@ -158,6 +752,12 @@
         "MetricGroup": "Branches;Fed;FetchBW",
         "MetricName": "UpTB"
     },
+    {
+        "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
+        "MetricExpr": "1 / IPC",
+        "MetricGroup": "Mem;Pipeline",
+        "MetricName": "CPI"
+    },
     {
         "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
@@ -166,16 +766,10 @@
     },
     {
         "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
-        "MetricExpr": "4 * CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "TmaL1",
+        "MetricExpr": "4 * CORE_CLKS",
+        "MetricGroup": "tma_L1_group",
         "MetricName": "SLOTS"
     },
-    {
-        "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
-        "MetricExpr": "4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_C=
LK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
-        "MetricGroup": "TmaL1_SMT",
-        "MetricName": "SLOTS_SMT"
-    },
     {
         "BriefDescription": "The ratio of Executed- by Issued-Uops",
         "MetricExpr": "UOPS_EXECUTED.THREAD / UOPS_ISSUED.ANY",
@@ -185,63 +779,38 @@
     },
     {
         "BriefDescription": "Instructions Per Cycle across hyper-threads (=
per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "Ret;SMT;TmaL1",
+        "MetricExpr": "INST_RETIRED.ANY / CORE_CLKS",
+        "MetricGroup": "Ret;SMT;tma_L1_group",
         "MetricName": "CoreIPC"
     },
-    {
-        "BriefDescription": "Instructions Per Cycle across hyper-threads (=
per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / ( ( CPU_CLK_UNHALTED.THREAD / 2 =
) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) =
)",
-        "MetricGroup": "Ret;SMT;TmaL1_SMT",
-        "MetricName": "CoreIPC_SMT"
-    },
     {
         "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricExpr": "( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_AR=
ITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DO=
UBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIR=
ED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + =
FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512=
B_PACKED_SINGLE ) / CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "Ret;Flops",
+        "MetricExpr": "(1 * (FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARIT=
H_INST_RETIRED.SCALAR_DOUBLE) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBL=
E + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.2=
56B_PACKED_DOUBLE) + 8 * (FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARI=
TH_INST_RETIRED.512B_PACKED_DOUBLE) + 16 * FP_ARITH_INST_RETIRED.512B_PACKE=
D_SINGLE) / CORE_CLKS",
+        "MetricGroup": "Flops;Ret",
         "MetricName": "FLOPc"
     },
-    {
-        "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricExpr": "( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_AR=
ITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DO=
UBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIR=
ED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + =
FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512=
B_PACKED_SINGLE ) / ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHAL=
TED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
-        "MetricGroup": "Ret;Flops_SMT",
-        "MetricName": "FLOPc_SMT"
-    },
     {
         "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
-        "MetricExpr": "( (FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_I=
NST_RETIRED.SCALAR_DOUBLE) + (FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP=
_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_=
DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.5=
12B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE) ) / ( 2 * CPU=
_CLK_UNHALTED.THREAD )",
+        "MetricExpr": "((FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_IN=
ST_RETIRED.SCALAR_DOUBLE) + (FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_=
ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_D=
OUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.51=
2B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE)) / (2 * CORE_C=
LKS)",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "FP_Arith_Utilization",
         "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)."
     },
-    {
-        "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width). SMT versi=
on; use when SMT is enabled and measuring per logical CPU.",
-        "MetricExpr": "( (FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_I=
NST_RETIRED.SCALAR_DOUBLE) + (FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP=
_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_=
DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.5=
12B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE) ) / ( 2 * ( (=
 CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE /=
 CPU_CLK_UNHALTED.REF_XCLK ) ) )",
-        "MetricGroup": "Cor;Flops;HPC_SMT",
-        "MetricName": "FP_Arith_Utilization_SMT",
-        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n). SMT version; use when SMT is enabled and measuring per logical CPU."
-    },
     {
         "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (( UOPS_EXECUTED.CORE_CYCLES=
_GE_1 / 2 ) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / ((UOPS_EXECUTED.CORE_CYCLES_=
GE_1 / 2) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
         "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
         "MetricName": "ILP"
     },
     {
         "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
-        "MetricExpr": "( 1 - ((1 - (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * CPU=
_CLK_UNHALTED.THREAD)) - ( UOPS_ISSUED.ANY + 4 * INT_MISC.RECOVERY_CYCLES )=
 / (4 * CPU_CLK_UNHALTED.THREAD)) - ((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE=
_ACTIVITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.=
1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_UNHALTED.THREAD)) =
* EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_U=
OPS_NOT_DELIVERED.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) - ( UOPS_ISSUED.ANY=
 + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.THREAD)))) / ((EX=
E_ACTIVITY.EXE_BOUND_0_PORTS + (EXE_ACTIVITY.1_PORTS_UTIL + (UOPS_RETIRED.R=
ETIRE_SLOTS / (4 * CPU_CLK_UNHALTED.THREAD)) * EXE_ACTIVITY.2_PORTS_UTIL)) =
/ CPU_CLK_UNHALTED.THREAD if ( ARITH.DIVIDER_ACTIVE < ( CYCLE_ACTIVITY.STAL=
LS_TOTAL - CYCLE_ACTIVITY.STALLS_MEM_ANY ) ) else (EXE_ACTIVITY.1_PORTS_UTI=
L + (UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_UNHALTED.THREAD)) * EXE_ACTIV=
ITY.2_PORTS_UTIL) / CPU_CLK_UNHALTED.THREAD) if ((1 - (IDQ_UOPS_NOT_DELIVER=
ED.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) - ( UOPS_ISSUED.ANY + 4 * INT_MISC=
.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.THREAD)) - ((( CYCLE_ACTIVITY.ST=
ALLS_MEM_ANY + EXE_ACTIVITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTA=
L + (EXE_ACTIVITY.1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_=
UNHALTED.THREAD)) * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STOR=
ES)) * (1 - (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) -=
 ( UOPS_ISSUED.ANY + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED=
.THREAD)))) < ((EXE_ACTIVITY.EXE_BOUND_0_PORTS + (EXE_ACTIVITY.1_PORTS_UTIL=
 + (UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_UNHALTED.THREAD)) * EXE_ACTIVI=
TY.2_PORTS_UTIL)) / CPU_CLK_UNHALTED.THREAD if ( ARITH.DIVIDER_ACTIVE < ( C=
YCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.STALLS_MEM_ANY ) ) else (EXE_AC=
TIVITY.1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_UNHALTED.TH=
READ)) * EXE_ACTIVITY.2_PORTS_UTIL) / CPU_CLK_UNHALTED.THREAD) else 1 ) if =
0 > 0.5 else 0",
+        "MetricExpr": "(1 - tma_core_bound / tma_ports_utilization if tma_=
core_bound < tma_ports_utilization else 1) if SMT_2T_Utilization > 0.5 else=
 0",
         "MetricGroup": "Cor;SMT",
         "MetricName": "Core_Bound_Likely"
     },
-    {
-        "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
-        "MetricExpr": "( 1 - ((1 - (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * ( (=
 CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE /=
 CPU_CLK_UNHALTED.REF_XCLK ) ))) - ( UOPS_ISSUED.ANY + 4 * ( INT_MISC.RECOV=
ERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU=
_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) - ((( CYC=
LE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.BOUND_ON_STORES ) / (CYCLE_ACTIVI=
TY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS /=
 (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD=
_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * EXE_ACTIVITY.2_PORTS_UTIL) + EX=
E_ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * ( (=
 CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE /=
 CPU_CLK_UNHALTED.REF_XCLK ) ))) - ( UOPS_ISSUED.ANY + 4 * ( INT_MISC.RECOV=
ERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU=
_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))))) / ((EXE=
_ACTIVITY.EXE_BOUND_0_PORTS + (EXE_ACTIVITY.1_PORTS_UTIL + (UOPS_RETIRED.RE=
TIRE_SLOTS / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTE=
D.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * EXE_ACTIVITY.2_PORT=
S_UTIL)) / CPU_CLK_UNHALTED.THREAD if ( ARITH.DIVIDER_ACTIVE < ( CYCLE_ACTI=
VITY.STALLS_TOTAL - CYCLE_ACTIVITY.STALLS_MEM_ANY ) ) else (EXE_ACTIVITY.1_=
PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * ( ( CPU_CLK_UNHALTED.THREAD =
/ 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCL=
K ) ))) * EXE_ACTIVITY.2_PORTS_UTIL) / CPU_CLK_UNHALTED.THREAD) if ((1 - (I=
DQ_UOPS_NOT_DELIVERED.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 +=
 CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) - ( U=
OPS_ISSUED.ANY + 4 * ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_=
CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_=
CLK_UNHALTED.REF_XCLK ) ))) - ((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIV=
ITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORT=
S_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 =
) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) =
))) * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (I=
DQ_UOPS_NOT_DELIVERED.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 +=
 CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) - ( U=
OPS_ISSUED.ANY + 4 * ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_=
CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_=
CLK_UNHALTED.REF_XCLK ) ))))) < ((EXE_ACTIVITY.EXE_BOUND_0_PORTS + (EXE_ACT=
IVITY.1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * ( ( CPU_CLK_UNHALTED=
.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED=
.REF_XCLK ) ))) * EXE_ACTIVITY.2_PORTS_UTIL)) / CPU_CLK_UNHALTED.THREAD if =
( ARITH.DIVIDER_ACTIVE < ( CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.STA=
LLS_MEM_ANY ) ) else (EXE_ACTIVITY.1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOT=
S / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THR=
EAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * EXE_ACTIVITY.2_PORTS_UTIL) /=
 CPU_CLK_UNHALTED.THREAD) else 1 ) if (1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTI=
VE / ( CPU_CLK_UNHALTED.REF_XCLK_ANY / 2 )) > 0.5 else 0",
-        "MetricGroup": "Cor;SMT_SMT",
-        "MetricName": "Core_Bound_Likely_SMT"
-    },
     {
         "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
-        "MetricExpr": "( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else=
 CPU_CLK_UNHALTED.THREAD",
+        "MetricExpr": "((CPU_CLK_UNHALTED.THREAD / 2) * (1 + CPU_CLK_UNHAL=
TED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK)) if #core_wide < 1 else =
(CPU_CLK_UNHALTED.THREAD_ANY / 2) if #SMT_on else CLKS",
         "MetricGroup": "SMT",
         "MetricName": "CORE_CLKS"
     },
@@ -283,13 +852,13 @@
     },
     {
         "BriefDescription": "Instructions per Floating Point (FP) Operatio=
n (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / ( 1 * ( FP_ARITH_INST_RETIRED.SC=
ALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RET=
IRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + =
FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.25=
6B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARI=
TH_INST_RETIRED.512B_PACKED_SINGLE )",
+        "MetricExpr": "INST_RETIRED.ANY / (1 * (FP_ARITH_INST_RETIRED.SCAL=
AR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE) + 2 * FP_ARITH_INST_RETIRE=
D.128B_PACKED_DOUBLE + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_A=
RITH_INST_RETIRED.256B_PACKED_DOUBLE) + 8 * (FP_ARITH_INST_RETIRED.256B_PAC=
KED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE) + 16 * FP_ARITH_INST=
_RETIRED.512B_PACKED_SINGLE)",
         "MetricGroup": "Flops;InsType",
         "MetricName": "IpFLOP"
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic instruction (l=
ower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / ( (FP_ARITH_INST_RETIRED.SCALAR_=
SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE) + (FP_ARITH_INST_RETIRED.128B=
_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_R=
ETIRED.256B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_A=
RITH_INST_RETIRED.512B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SI=
NGLE) )",
+        "MetricExpr": "INST_RETIRED.ANY / ((FP_ARITH_INST_RETIRED.SCALAR_S=
INGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE) + (FP_ARITH_INST_RETIRED.128B_=
PACKED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RE=
TIRED.256B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_AR=
ITH_INST_RETIRED.512B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SIN=
GLE))",
         "MetricGroup": "Flops;InsType",
         "MetricName": "IpArith",
         "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). May undercount due to FMA doubl=
e counting. Approximated prior to BDW."
@@ -310,21 +879,21 @@
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-bi=
t instruction (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / ( FP_ARITH_INST_RETIRED.128B_PAC=
KED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE )",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.128B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE)",
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "IpArith_AVX128",
         "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). May undercount =
due to FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX* 256-bit i=
nstruction (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / ( FP_ARITH_INST_RETIRED.256B_PAC=
KED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.256B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE)",
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "IpArith_AVX256",
         "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). May undercount due=
 to FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX 512-bit in=
struction (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / ( FP_ARITH_INST_RETIRED.512B_PAC=
KED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE )",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.512B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE)",
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "IpArith_AVX512",
         "PublicDescription": "Instructions per FP Arithmetic AVX 512-bit i=
nstruction (lower number means higher occurrence rate). May undercount due =
to FMA double counting."
@@ -336,9 +905,9 @@
         "MetricName": "IpSWPF"
     },
     {
-        "BriefDescription": "Total number of retired Instructions, Sample =
with: INST_RETIRED.PREC_DIST",
+        "BriefDescription": "Total number of retired Instructions Sample w=
ith: INST_RETIRED.PREC_DIST",
         "MetricExpr": "INST_RETIRED.ANY",
-        "MetricGroup": "Summary;TmaL1",
+        "MetricGroup": "Summary;tma_L1_group",
         "MetricName": "Instructions"
     },
     {
@@ -373,16 +942,10 @@
     },
     {
         "BriefDescription": "Total penalty related to DSB (uop cache) miss=
es - subset of the Instruction_Fetch_BW Bottleneck.",
-        "MetricExpr": "100 * ( (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_D=
ELIV.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) * (DSB2MITE_SWITCHES.PENALTY_CYC=
LES / CPU_CLK_UNHALTED.THREAD) / #(4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS=
_DELIV.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) + ((IDQ_UOPS_NOT_DELIVERED.COR=
E / (4 * CPU_CLK_UNHALTED.THREAD)) - (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_U=
OPS_DELIV.CORE / (4 * CPU_CLK_UNHALTED.THREAD))) * (( IDQ.ALL_MITE_CYCLES_A=
NY_UOPS - IDQ.ALL_MITE_CYCLES_4_UOPS ) / CPU_CLK_UNHALTED.THREAD / 2) / #((=
IDQ_UOPS_NOT_DELIVERED.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) - (4 * IDQ_UOP=
S_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * CPU_CLK_UNHALTED.THREAD))) =
)",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + =
tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb + tm=
a_mite))",
         "MetricGroup": "DSBmiss;Fed",
         "MetricName": "DSB_Misses"
     },
-    {
-        "BriefDescription": "Total penalty related to DSB (uop cache) miss=
es - subset of the Instruction_Fetch_BW Bottleneck.",
-        "MetricExpr": "100 * ( (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_D=
ELIV.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED=
.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * (DSB2MITE_SWITCHES.P=
ENALTY_CYCLES / CPU_CLK_UNHALTED.THREAD) / #(4 * IDQ_UOPS_NOT_DELIVERED.CYC=
LES_0_UOPS_DELIV.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_=
CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) + ((IDQ_UO=
PS_NOT_DELIVERED.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_=
CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) - (4 * IDQ=
_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * ( ( CPU_CLK_UNHALTED.TH=
READ / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.RE=
F_XCLK ) )))) * (( IDQ.ALL_MITE_CYCLES_ANY_UOPS - IDQ.ALL_MITE_CYCLES_4_UOP=
S ) / ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD=
_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ) / 2) / #((IDQ_UOPS_NOT_DELIVERED.CO=
RE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_TH=
READ_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) - (4 * IDQ_UOPS_NOT_DELIVERED=
.CYCLES_0_UOPS_DELIV.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + =
CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
-        "MetricGroup": "DSBmiss;Fed_SMT",
-        "MetricName": "DSB_Misses_SMT"
-    },
     {
         "BriefDescription": "Number of Instructions per non-speculative DS=
B miss (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / FRONTEND_RETIRED.ANY_DSB_MISS",
@@ -397,16 +960,10 @@
     },
     {
         "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
-        "MetricExpr": " ( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIR=
ED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIR=
ED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.TH=
READ))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * CPU_C=
LK_UNHALTED.THREAD)) * ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.A=
LL_BRANCHES + MACHINE_CLEARS.COUNT )) * INT_MISC.CLEAR_RESTEER_CYCLES / CPU=
_CLK_UNHALTED.THREAD) / #(4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CO=
RE / (4 * CPU_CLK_UNHALTED.THREAD)) ) * (4 * CPU_CLK_UNHALTED.THREAD) / BR_=
MISP_RETIRED.ALL_BRANCHES",
+        "MetricExpr": " (tma_branch_mispredicts + tma_fetch_latency * tma_=
mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icache=
_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) * SLOTS / BR_MISP_R=
ETIRED.ALL_BRANCHES",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "Branch_Misprediction_Cost"
     },
-    {
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
-        "MetricExpr": " ( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIR=
ED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIR=
ED.RETIRE_SLOTS + 4 * ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU=
_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU=
_CLK_UNHALTED.REF_XCLK ) )))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_D=
ELIV.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED=
.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * ((BR_MISP_RETIRED.AL=
L_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * INT=
_MISC.CLEAR_RESTEER_CYCLES / CPU_CLK_UNHALTED.THREAD) / #(4 * IDQ_UOPS_NOT_=
DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 )=
 * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )=
)) ) * (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_=
THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )) / BR_MISP_RETIRED.ALL_BRANCH=
ES",
-        "MetricGroup": "Bad;BrMispredicts_SMT",
-        "MetricName": "Branch_Misprediction_Cost_SMT"
-    },
     {
         "BriefDescription": "Fraction of branches that are non-taken condi=
tionals",
         "MetricExpr": "BR_INST_RETIRED.NOT_TAKEN / BR_INST_RETIRED.ALL_BRA=
NCHES",
@@ -415,101 +972,95 @@
     },
     {
         "BriefDescription": "Fraction of branches that are taken condition=
als",
-        "MetricExpr": "( BR_INST_RETIRED.CONDITIONAL - BR_INST_RETIRED.NOT=
_TAKEN )  / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricExpr": "(BR_INST_RETIRED.CONDITIONAL - BR_INST_RETIRED.NOT_=
TAKEN) / BR_INST_RETIRED.ALL_BRANCHES",
         "MetricGroup": "Bad;Branches;CodeGen;PGO",
         "MetricName": "Cond_TK"
     },
     {
         "BriefDescription": "Fraction of branches that are CALL or RET",
-        "MetricExpr": "( BR_INST_RETIRED.NEAR_CALL + BR_INST_RETIRED.NEAR_=
RETURN ) / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricExpr": "(BR_INST_RETIRED.NEAR_CALL + BR_INST_RETIRED.NEAR_R=
ETURN) / BR_INST_RETIRED.ALL_BRANCHES",
         "MetricGroup": "Bad;Branches",
         "MetricName": "CallRet"
     },
     {
         "BriefDescription": "Fraction of branches that are unconditional (=
direct or indirect) jumps",
-        "MetricExpr": "(BR_INST_RETIRED.NEAR_TAKEN - ( BR_INST_RETIRED.CON=
DITIONAL - BR_INST_RETIRED.NOT_TAKEN ) - 2 * BR_INST_RETIRED.NEAR_CALL) / B=
R_INST_RETIRED.ALL_BRANCHES",
+        "MetricExpr": "(BR_INST_RETIRED.NEAR_TAKEN - (BR_INST_RETIRED.COND=
ITIONAL - BR_INST_RETIRED.NOT_TAKEN) - 2 * BR_INST_RETIRED.NEAR_CALL) / BR_=
INST_RETIRED.ALL_BRANCHES",
         "MetricGroup": "Bad;Branches",
         "MetricName": "Jump"
     },
     {
         "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS =
+ MEM_LOAD_RETIRED.FB_HIT )",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / (MEM_LOAD_RETIRED.L1_MISS +=
 MEM_LOAD_RETIRED.FB_HIT)",
         "MetricGroup": "Mem;MemoryBound;MemoryLat",
         "MetricName": "Load_Miss_Real_Latency"
     },
     {
         "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss. Per-Logical Proces=
sor)",
         "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLE=
S",
-        "MetricGroup": "Mem;MemoryBound;MemoryBW",
+        "MetricGroup": "Mem;MemoryBW;MemoryBound",
         "MetricName": "MLP"
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1000 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY"=
,
-        "MetricGroup": "Mem;CacheMisses",
+        "MetricGroup": "CacheMisses;Mem",
         "MetricName": "L1MPKI"
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 all demand loads (including speculative)",
         "MetricExpr": "1000 * L2_RQSTS.ALL_DEMAND_DATA_RD / INST_RETIRED.A=
NY",
-        "MetricGroup": "Mem;CacheMisses",
+        "MetricGroup": "CacheMisses;Mem",
         "MetricName": "L1MPKI_Load"
     },
     {
         "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1000 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY"=
,
-        "MetricGroup": "Mem;Backend;CacheMisses",
+        "MetricGroup": "Backend;CacheMisses;Mem",
         "MetricName": "L2MPKI"
     },
     {
         "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all request types (including speculative)",
         "MetricExpr": "1000 * L2_RQSTS.MISS / INST_RETIRED.ANY",
-        "MetricGroup": "Mem;CacheMisses;Offcore",
+        "MetricGroup": "CacheMisses;Mem;Offcore",
         "MetricName": "L2MPKI_All"
     },
     {
         "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all demand loads  (including speculative)",
         "MetricExpr": "1000 * L2_RQSTS.DEMAND_DATA_RD_MISS / INST_RETIRED.=
ANY",
-        "MetricGroup": "Mem;CacheMisses",
+        "MetricGroup": "CacheMisses;Mem",
         "MetricName": "L2MPKI_Load"
     },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all re=
quest types (including speculative)",
-        "MetricExpr": "1000 * ( L2_RQSTS.REFERENCES - L2_RQSTS.MISS ) / IN=
ST_RETIRED.ANY",
-        "MetricGroup": "Mem;CacheMisses",
+        "MetricExpr": "1000 * (L2_RQSTS.REFERENCES - L2_RQSTS.MISS) / INST=
_RETIRED.ANY",
+        "MetricGroup": "CacheMisses;Mem",
         "MetricName": "L2HPKI_All"
     },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all de=
mand loads  (including speculative)",
         "MetricExpr": "1000 * L2_RQSTS.DEMAND_DATA_RD_HIT / INST_RETIRED.A=
NY",
-        "MetricGroup": "Mem;CacheMisses",
+        "MetricGroup": "CacheMisses;Mem",
         "MetricName": "L2HPKI_Load"
     },
     {
         "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1000 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY"=
,
-        "MetricGroup": "Mem;CacheMisses",
+        "MetricGroup": "CacheMisses;Mem",
         "MetricName": "L3MPKI"
     },
     {
         "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
         "MetricExpr": "1000 * MEM_LOAD_RETIRED.FB_HIT / INST_RETIRED.ANY",
-        "MetricGroup": "Mem;CacheMisses",
+        "MetricGroup": "CacheMisses;Mem",
         "MetricName": "FB_HPKI"
     },
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
         "MetricConstraint": "NO_NMI_WATCHDOG",
-        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_=
PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * CPU_C=
LK_UNHALTED.THREAD )",
+        "MetricExpr": "(ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_P=
ENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING) / (2 * CORE_CLK=
S)",
         "MetricGroup": "Mem;MemoryTLB",
         "MetricName": "Page_Walks_Utilization"
     },
-    {
-        "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
-        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_=
PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * ( ( C=
PU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / C=
PU_CLK_UNHALTED.REF_XCLK ) ) )",
-        "MetricGroup": "Mem;MemoryTLB_SMT",
-        "MetricName": "Page_Walks_Utilization_SMT"
-    },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
         "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
@@ -536,37 +1087,37 @@
     },
     {
         "BriefDescription": "Rate of silent evictions from the L2 cache pe=
r Kilo instruction where the evicted lines are dropped (no writeback to L3 =
or memory)",
-        "MetricExpr": "1000 * L2_LINES_OUT.SILENT / INST_RETIRED.ANY",
+        "MetricExpr": "1000 * L2_LINES_OUT.SILENT / Instructions",
         "MetricGroup": "L2Evicts;Mem;Server",
         "MetricName": "L2_Evictions_Silent_PKI"
     },
     {
         "BriefDescription": "Rate of non silent evictions from the L2 cach=
e per Kilo instruction",
-        "MetricExpr": "1000 * L2_LINES_OUT.NON_SILENT / INST_RETIRED.ANY",
+        "MetricExpr": "1000 * L2_LINES_OUT.NON_SILENT / Instructions",
         "MetricGroup": "L2Evicts;Mem;Server",
         "MetricName": "L2_Evictions_NonSilent_PKI"
     },
     {
         "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
-        "MetricExpr": "(64 * L1D.REPLACEMENT / 1000000000 / duration_time)=
",
+        "MetricExpr": "L1D_Cache_Fill_BW",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "L1D_Cache_Fill_BW_1T"
     },
     {
         "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
-        "MetricExpr": "(64 * L2_LINES_IN.ALL / 1000000000 / duration_time)=
",
+        "MetricExpr": "L2_Cache_Fill_BW",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "L2_Cache_Fill_BW_1T"
     },
     {
         "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "(64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duratio=
n_time)",
+        "MetricExpr": "L3_Cache_Fill_BW",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "L3_Cache_Fill_BW_1T"
     },
     {
         "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
-        "MetricExpr": "(64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 / =
duration_time)",
+        "MetricExpr": "L3_Cache_Access_BW",
         "MetricGroup": "Mem;MemoryBW;Offcore",
         "MetricName": "L3_Cache_Access_BW_1T"
     },
@@ -578,68 +1129,47 @@
     },
     {
         "BriefDescription": "Measured Average Frequency for unhalted proce=
ssors [GHz]",
-        "MetricExpr": "(CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC=
) * msr@tsc@ / 1000000000 / duration_time",
-        "MetricGroup": "Summary;Power",
+        "MetricExpr": "Turbo_Utilization * msr@tsc@ / 1000000000 / duratio=
n_time",
+        "MetricGroup": "Power;Summary",
         "MetricName": "Average_Frequency"
     },
     {
         "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "( ( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_=
ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_=
DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RET=
IRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE =
+ FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.5=
12B_PACKED_SINGLE ) / 1000000000 ) / duration_time",
+        "MetricExpr": "((1 * (FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARI=
TH_INST_RETIRED.SCALAR_DOUBLE) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUB=
LE + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.=
256B_PACKED_DOUBLE) + 8 * (FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_AR=
ITH_INST_RETIRED.512B_PACKED_DOUBLE) + 16 * FP_ARITH_INST_RETIRED.512B_PACK=
ED_SINGLE) / 1000000000) / duration_time",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "GFLOPs",
         "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine."
     },
     {
         "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC"=
,
+        "MetricExpr": "CLKS / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Power",
         "MetricName": "Turbo_Utilization"
     },
     {
         "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for baseline license level 0",
-        "MetricExpr": "CORE_POWER.LVL0_TURBO_LICENSE / CPU_CLK_UNHALTED.TH=
READ",
+        "MetricExpr": "CORE_POWER.LVL0_TURBO_LICENSE / 2 / CORE_CLKS if #S=
MT_on else CORE_POWER.LVL0_TURBO_LICENSE / CORE_CLKS",
         "MetricGroup": "Power",
         "MetricName": "Power_License0_Utilization",
         "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for baseline license level 0.  This includes non=
-AVX codes, SSE, AVX 128-bit, and low-current AVX 256-bit codes."
     },
-    {
-        "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for baseline license level 0. SMT version; use wh=
en SMT is enabled and measuring per logical CPU.",
-        "MetricExpr": "CORE_POWER.LVL0_TURBO_LICENSE / 2 / ( ( CPU_CLK_UNH=
ALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNH=
ALTED.REF_XCLK ) )",
-        "MetricGroup": "Power_SMT",
-        "MetricName": "Power_License0_Utilization_SMT",
-        "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for baseline license level 0.  This includes non=
-AVX codes, SSE, AVX 128-bit, and low-current AVX 256-bit codes. SMT versio=
n; use when SMT is enabled and measuring per logical CPU."
-    },
     {
         "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for license level 1",
-        "MetricExpr": "CORE_POWER.LVL1_TURBO_LICENSE / CPU_CLK_UNHALTED.TH=
READ",
+        "MetricExpr": "CORE_POWER.LVL1_TURBO_LICENSE / 2 / CORE_CLKS if #S=
MT_on else CORE_POWER.LVL1_TURBO_LICENSE / CORE_CLKS",
         "MetricGroup": "Power",
         "MetricName": "Power_License1_Utilization",
         "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for license level 1.  This includes high current=
 AVX 256-bit instructions as well as low current AVX 512-bit instructions."
     },
-    {
-        "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for license level 1. SMT version; use when SMT is=
 enabled and measuring per logical CPU.",
-        "MetricExpr": "CORE_POWER.LVL1_TURBO_LICENSE / 2 / ( ( CPU_CLK_UNH=
ALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNH=
ALTED.REF_XCLK ) )",
-        "MetricGroup": "Power_SMT",
-        "MetricName": "Power_License1_Utilization_SMT",
-        "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for license level 1.  This includes high current=
 AVX 256-bit instructions as well as low current AVX 512-bit instructions. =
SMT version; use when SMT is enabled and measuring per logical CPU."
-    },
     {
         "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for license level 2 (introduced in SKX)",
-        "MetricExpr": "CORE_POWER.LVL2_TURBO_LICENSE / CPU_CLK_UNHALTED.TH=
READ",
+        "MetricExpr": "CORE_POWER.LVL2_TURBO_LICENSE / 2 / CORE_CLKS if #S=
MT_on else CORE_POWER.LVL2_TURBO_LICENSE / CORE_CLKS",
         "MetricGroup": "Power",
         "MetricName": "Power_License2_Utilization",
         "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for license level 2 (introduced in SKX).  This i=
ncludes high current AVX 512-bit instructions."
     },
-    {
-        "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for license level 2 (introduced in SKX). SMT vers=
ion; use when SMT is enabled and measuring per logical CPU.",
-        "MetricExpr": "CORE_POWER.LVL2_TURBO_LICENSE / 2 / ( ( CPU_CLK_UNH=
ALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNH=
ALTED.REF_XCLK ) )",
-        "MetricGroup": "Power_SMT",
-        "MetricName": "Power_License2_Utilization_SMT",
-        "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for license level 2 (introduced in SKX).  This i=
ncludes high current AVX 512-bit instructions. SMT version; use when SMT is=
 enabled and measuring per logical CPU."
-    },
     {
         "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
-        "MetricExpr": "1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_=
UNHALTED.REF_XCLK_ANY / 2 ) if #SMT_on else 0",
+        "MetricExpr": "1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / (CPU_CLK_U=
NHALTED.REF_XCLK_ANY / 2) if #SMT_on else 0",
         "MetricGroup": "SMT",
         "MetricName": "SMT_2T_Utilization"
     },
@@ -657,13 +1187,13 @@
     },
     {
         "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
-        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@ca=
s_count_write@ ) / 1000000000 ) / duration_time",
+        "MetricExpr": "(64 * (uncore_imc@cas_count_read@ + uncore_imc@cas_=
count_write@) / 1000000000) / duration_time",
         "MetricGroup": "HPC;Mem;MemoryBW;SoC",
         "MetricName": "DRAM_BW_Use"
     },
     {
         "BriefDescription": "Average latency of data read request to exter=
nal memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetches=
",
-        "MetricExpr": "1000000000 * ( cha@event\\=3D0x36\\,umask\\=3D0x21\=
\,config\\=3D0x40433@ / cha@event\\=3D0x35\\,umask\\=3D0x21\\,config\\=3D0x=
40433@ ) / ( cha_0@event\\=3D0x0@ / duration_time )",
+        "MetricExpr": "1000000000 * (cha@event\\=3D0x36\\,umask\\=3D0x21\\=
,config\\=3D0x40433@ / cha@event\\=3D0x35\\,umask\\=3D0x21\\,config\\=3D0x4=
0433@) / (Socket_CLKS / duration_time)",
         "MetricGroup": "Mem;MemoryLat;SoC",
         "MetricName": "MEM_Read_Latency"
     },
@@ -675,38 +1205,38 @@
     },
     {
         "BriefDescription": "Average latency of data read request to exter=
nal 3D X-Point memory [in nanoseconds]. Accounts for demand loads and L1/L2=
 data-read prefetches",
-        "MetricExpr": "( 1000000000 * ( imc@event\\=3D0xe0\\,umask\\=3D0x1=
@ / imc@event\\=3D0xe3@ ) / imc_0@event\\=3D0x0@ )",
-        "MetricGroup": "Mem;MemoryLat;SoC;Server",
+        "MetricExpr": "(1000000000 * (imc@event\\=3D0xe0\\,umask\\=3D0x1@ =
/ imc@event\\=3D0xe3@) / imc_0@event\\=3D0x0@)",
+        "MetricGroup": "Mem;MemoryLat;Server;SoC",
         "MetricName": "MEM_PMM_Read_Latency"
     },
     {
         "BriefDescription": "Average latency of data read request to exter=
nal DRAM memory [in nanoseconds]. Accounts for demand loads and L1/L2 data-=
read prefetches",
-        "MetricExpr": "1000000000 * ( UNC_M_RPQ_OCCUPANCY / UNC_M_RPQ_INSE=
RTS ) / imc_0@event\\=3D0x0@",
-        "MetricGroup": "Mem;MemoryLat;SoC;Server",
+        "MetricExpr": "1000000000 * (UNC_M_RPQ_OCCUPANCY / UNC_M_RPQ_INSER=
TS) / imc_0@event\\=3D0x0@",
+        "MetricGroup": "Mem;MemoryLat;Server;SoC",
         "MetricName": "MEM_DRAM_Read_Latency"
     },
     {
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for reads [=
GB / sec]",
-        "MetricExpr": "( ( 64 * imc@event\\=3D0xe3@ / 1000000000 ) / durat=
ion_time )",
-        "MetricGroup": "Mem;MemoryBW;SoC;Server",
+        "MetricExpr": "((64 * imc@event\\=3D0xe3@ / 1000000000) / duration=
_time)",
+        "MetricGroup": "Mem;MemoryBW;Server;SoC",
         "MetricName": "PMM_Read_BW"
     },
     {
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for Writes =
[GB / sec]",
-        "MetricExpr": "( ( 64 * imc@event\\=3D0xe7@ / 1000000000 ) / durat=
ion_time )",
-        "MetricGroup": "Mem;MemoryBW;SoC;Server",
+        "MetricExpr": "((64 * imc@event\\=3D0xe7@ / 1000000000) / duration=
_time)",
+        "MetricGroup": "Mem;MemoryBW;Server;SoC",
         "MetricName": "PMM_Write_BW"
     },
     {
         "BriefDescription": "Average IO (network or disk) Bandwidth Use fo=
r Writes [GB / sec]",
-        "MetricExpr": "( UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 + UNC_IIO_=
DATA_REQ_OF_CPU.MEM_READ.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 + U=
NC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3 ) * 4 / 1000000000 / duration_time",
-        "MetricGroup": "IoBW;Mem;SoC;Server",
+        "MetricExpr": "(UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 + UNC_IIO_D=
ATA_REQ_OF_CPU.MEM_READ.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 + UN=
C_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3) * 4 / 1000000000 / duration_time",
+        "MetricGroup": "IoBW;Mem;Server;SoC",
         "MetricName": "IO_Write_BW"
     },
     {
         "BriefDescription": "Average IO (network or disk) Bandwidth Use fo=
r Reads [GB / sec]",
-        "MetricExpr": "( UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 + UNC_IIO=
_DATA_REQ_OF_CPU.MEM_WRITE.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 =
+ UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3 ) * 4 / 1000000000 / duration_tim=
e",
-        "MetricGroup": "IoBW;Mem;SoC;Server",
+        "MetricExpr": "(UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 + UNC_IIO_=
DATA_REQ_OF_CPU.MEM_WRITE.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 +=
 UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3) * 4 / 1000000000 / duration_time"=
,
+        "MetricGroup": "IoBW;Mem;Server;SoC",
         "MetricName": "IO_Read_BW"
     },
     {
@@ -715,12 +1245,6 @@
         "MetricGroup": "SoC",
         "MetricName": "Socket_CLKS"
     },
-    {
-        "BriefDescription": "Uncore frequency per die [GHZ]",
-        "MetricExpr": "cha_0@event\\=3D0x0@ / #num_dies / duration_time / =
1000000000",
-        "MetricGroup": "SoC",
-        "MetricName": "UNCORE_FREQ"
-    },
     {
         "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
@@ -770,26 +1294,18 @@
         "MetricName": "C7_Pkg_Residency"
     },
     {
-        "BriefDescription": "Percentage of time spent in the active CPU po=
wer state C0",
-        "MetricExpr": "100 * CPU_CLK_UNHALTED.REF_TSC / TSC",
-        "MetricGroup": "",
-        "MetricName": "cpu_utilization_percent",
-        "ScaleUnit": "1%"
+        "BriefDescription": "Uncore frequency per die [GHZ]",
+        "MetricExpr": "Socket_CLKS / #num_dies / duration_time / 100000000=
0",
+        "MetricGroup": "SoC",
+        "MetricName": "UNCORE_FREQ"
     },
     {
         "BriefDescription": "CPU operating frequency (in GHz)",
-        "MetricExpr": "( CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TS=
C * #SYSTEM_TSC_FREQ ) / 1000000000",
+        "MetricExpr": "(( CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_T=
SC * #SYSTEM_TSC_FREQ ) / 1000000000) / duration_time",
         "MetricGroup": "",
         "MetricName": "cpu_operating_frequency",
         "ScaleUnit": "1GHz"
     },
-    {
-        "BriefDescription": "Cycles per instruction retired; indicating ho=
w much time each executed instruction took; in units of cycles.",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / INST_RETIRED.ANY",
-        "MetricGroup": "",
-        "MetricName": "cpi",
-        "ScaleUnit": "1per_instr"
-    },
     {
         "BriefDescription": "The ratio of number of completed memory load =
instructions to the total number completed instructions",
         "MetricExpr": "MEM_INST_RETIRED.ALL_LOADS / INST_RETIRED.ANY",
@@ -808,7 +1324,7 @@
         "BriefDescription": "Ratio of number of requests missing L1 data c=
ache (includes data+rfo w/ prefetches) to the total number of completed ins=
tructions",
         "MetricExpr": "L1D.REPLACEMENT / INST_RETIRED.ANY",
         "MetricGroup": "",
-        "MetricName": "l1d_mpi_includes_data_plus_rfo_with_prefetches",
+        "MetricName": "l1d_mpi",
         "ScaleUnit": "1per_instr"
     },
     {
@@ -836,7 +1352,7 @@
         "BriefDescription": "Ratio of number of requests missing L2 cache =
(includes code+data+rfo w/ prefetches) to the total number of completed ins=
tructions",
         "MetricExpr": "L2_LINES_IN.ALL / INST_RETIRED.ANY",
         "MetricGroup": "",
-        "MetricName": "l2_mpi_includes_code_plus_data_plus_rfo_with_prefet=
ches",
+        "MetricName": "l2_mpi",
         "ScaleUnit": "1per_instr"
     },
     {
@@ -869,21 +1385,21 @@
     },
     {
         "BriefDescription": "Average latency of a last level cache (LLC) d=
emand and prefetch data read miss (read memory access) in nano seconds",
-        "MetricExpr": "( ( 1000000000 * ( cha@unc_cha_tor_occupancy.ia_mis=
s\\,config1\\=3D0x4043300000000@ / cha@unc_cha_tor_inserts.ia_miss\\,config=
1\\=3D0x4043300000000@ ) / ( UNC_CHA_CLOCKTICKS / ( source_count(UNC_CHA_CL=
OCKTICKS) * #num_packages ) ) ) * duration_time )",
+        "MetricExpr": "( 1000000000 * ( cha@unc_cha_tor_occupancy.ia_miss\=
\,config1\\=3D0x4043300000000@ / cha@unc_cha_tor_inserts.ia_miss\\,config1\=
\=3D0x4043300000000@ ) / ( UNC_CHA_CLOCKTICKS / ( source_count(UNC_CHA_CLOC=
KTICKS) * #num_packages ) ) ) * duration_time",
         "MetricGroup": "",
         "MetricName": "llc_data_read_demand_plus_prefetch_miss_latency",
         "ScaleUnit": "1ns"
     },
     {
         "BriefDescription": "Average latency of a last level cache (LLC) d=
emand and prefetch data read miss (read memory access) addressed to local m=
emory in nano seconds",
-        "MetricExpr": "( ( 1000000000 * ( cha@unc_cha_tor_occupancy.ia_mis=
s\\,config1\\=3D0x4043200000000@ / cha@unc_cha_tor_inserts.ia_miss\\,config=
1\\=3D0x4043200000000@ ) / ( UNC_CHA_CLOCKTICKS / ( source_count(UNC_CHA_CL=
OCKTICKS) * #num_packages ) ) ) * duration_time )",
+        "MetricExpr": "( 1000000000 * ( cha@unc_cha_tor_occupancy.ia_miss\=
\,config1\\=3D0x4043200000000@ / cha@unc_cha_tor_inserts.ia_miss\\,config1\=
\=3D0x4043200000000@ ) / ( UNC_CHA_CLOCKTICKS / ( source_count(UNC_CHA_CLOC=
KTICKS) * #num_packages ) ) ) * duration_time",
         "MetricGroup": "",
         "MetricName": "llc_data_read_demand_plus_prefetch_miss_latency_for=
_local_requests",
         "ScaleUnit": "1ns"
     },
     {
         "BriefDescription": "Average latency of a last level cache (LLC) d=
emand and prefetch data read miss (read memory access) addressed to remote =
memory in nano seconds",
-        "MetricExpr": "( ( 1000000000 * ( cha@unc_cha_tor_occupancy.ia_mis=
s\\,config1\\=3D0x4043100000000@ / cha@unc_cha_tor_inserts.ia_miss\\,config=
1\\=3D0x4043100000000@ ) / ( UNC_CHA_CLOCKTICKS / ( source_count(UNC_CHA_CL=
OCKTICKS) * #num_packages ) ) ) * duration_time )",
+        "MetricExpr": "( 1000000000 * ( cha@unc_cha_tor_occupancy.ia_miss\=
\,config1\\=3D0x4043100000000@ / cha@unc_cha_tor_inserts.ia_miss\\,config1\=
\=3D0x4043100000000@ ) / ( UNC_CHA_CLOCKTICKS / ( source_count(UNC_CHA_CLOC=
KTICKS) * #num_packages ) ) ) * duration_time",
         "MetricGroup": "",
         "MetricName": "llc_data_read_demand_plus_prefetch_miss_latency_for=
_remote_requests",
         "ScaleUnit": "1ns"
@@ -892,54 +1408,54 @@
         "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by a code fetch to the total number of completed ins=
tructions. This implies it missed in the ITLB (Instruction TLB) and further=
 levels of TLB.",
         "MetricExpr": "ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.ANY",
         "MetricGroup": "",
-        "MetricName": "itlb_2nd_level_mpi",
+        "MetricName": "itlb_mpi",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Ratio of number of completed page walks (for =
2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total n=
umber of completed instructions. This implies it missed in the Instruction =
Translation Lookaside Buffer (ITLB) and further levels of TLB.",
         "MetricExpr": "ITLB_MISSES.WALK_COMPLETED_2M_4M / INST_RETIRED.ANY=
",
         "MetricGroup": "",
-        "MetricName": "itlb_2nd_level_large_page_mpi",
+        "MetricName": "itlb_large_page_mpi",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data loads to the total number of complete=
d instructions. This implies it missed in the DTLB and further levels of TL=
B.",
         "MetricExpr": "DTLB_LOAD_MISSES.WALK_COMPLETED / INST_RETIRED.ANY"=
,
         "MetricGroup": "",
-        "MetricName": "dtlb_2nd_level_load_mpi",
+        "MetricName": "dtlb_load_mpi",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Ratio of number of completed page walks (for =
2 megabyte page sizes) caused by demand data loads to the total number of c=
ompleted instructions. This implies it missed in the Data Translation Looka=
side Buffer (DTLB) and further levels of TLB.",
         "MetricExpr": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M / INST_RETIRE=
D.ANY",
         "MetricGroup": "",
-        "MetricName": "dtlb_2nd_level_2mb_large_page_load_mpi",
+        "MetricName": "dtlb_2mb_large_page_load_mpi",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data stores to the total number of complet=
ed instructions. This implies it missed in the DTLB and further levels of T=
LB.",
         "MetricExpr": "DTLB_STORE_MISSES.WALK_COMPLETED / INST_RETIRED.ANY=
",
         "MetricGroup": "",
-        "MetricName": "dtlb_2nd_level_store_mpi",
+        "MetricName": "dtlb_store_mpi",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Memory read that miss the last level cache (L=
LC) addressed to local DRAM as a percentage of total memory read accesses, =
does not include LLC prefetches.",
         "MetricExpr": "100 * cha@unc_cha_tor_inserts.ia_miss\\,config1\\=
=3D0x4043200000000@ / ( cha@unc_cha_tor_inserts.ia_miss\\,config1\\=3D0x404=
3200000000@ + cha@unc_cha_tor_inserts.ia_miss\\,config1\\=3D0x4043100000000=
@ )",
         "MetricGroup": "",
-        "MetricName": "numa_percent_reads_addressed_to_local_dram",
+        "MetricName": "numa_reads_addressed_to_local_dram",
         "ScaleUnit": "1%"
     },
     {
         "BriefDescription": "Memory reads that miss the last level cache (=
LLC) addressed to remote DRAM as a percentage of total memory read accesses=
, does not include LLC prefetches.",
         "MetricExpr": "100 * cha@unc_cha_tor_inserts.ia_miss\\,config1\\=
=3D0x4043100000000@ / ( cha@unc_cha_tor_inserts.ia_miss\\,config1\\=3D0x404=
3200000000@ + cha@unc_cha_tor_inserts.ia_miss\\,config1\\=3D0x4043100000000=
@ )",
         "MetricGroup": "",
-        "MetricName": "numa_percent_reads_addressed_to_remote_dram",
+        "MetricName": "numa_reads_addressed_to_remote_dram",
         "ScaleUnit": "1%"
     },
     {
         "BriefDescription": "Uncore operating frequency in GHz",
-        "MetricExpr": "UNC_CHA_CLOCKTICKS / ( source_count(UNC_CHA_CLOCKTI=
CKS) * #num_packages ) / 1000000000",
+        "MetricExpr": "( UNC_CHA_CLOCKTICKS / ( source_count(UNC_CHA_CLOCK=
TICKS) * #num_packages ) / 1000000000) / duration_time",
         "MetricGroup": "",
         "MetricName": "uncore_frequency",
         "ScaleUnit": "1GHz"
@@ -948,7 +1464,7 @@
         "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data t=
ransmit bandwidth (MB/sec)",
         "MetricExpr": "( UNC_UPI_TxL_FLITS.ALL_DATA * (64 / 9.0) / 1000000=
) / duration_time",
         "MetricGroup": "",
-        "MetricName": "upi_data_transmit_bw_only_data",
+        "MetricName": "upi_data_transmit_bw",
         "ScaleUnit": "1MB/s"
     },
     {
@@ -997,35 +1513,35 @@
         "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the CPU.",
         "MetricExpr": "(( UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 + UNC_IIO=
_DATA_REQ_OF_CPU.MEM_READ.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 + =
UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3 ) * 4 / 1000000) / duration_time",
         "MetricGroup": "",
-        "MetricName": "io_bandwidth_read",
+        "MetricName": "io_bandwidth_disk_or_network_writes",
         "ScaleUnit": "1MB/s"
     },
     {
         "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the CPU.",
         "MetricExpr": "(( UNC_IIO_PAYLOAD_BYTES_IN.MEM_WRITE.PART0 + UNC_I=
IO_PAYLOAD_BYTES_IN.MEM_WRITE.PART1 + UNC_IIO_PAYLOAD_BYTES_IN.MEM_WRITE.PA=
RT2 + UNC_IIO_PAYLOAD_BYTES_IN.MEM_WRITE.PART3 ) * 4 / 1000000) / duration_=
time",
         "MetricGroup": "",
-        "MetricName": "io_bandwidth_write",
+        "MetricName": "io_bandwidth_disk_or_network_reads",
         "ScaleUnit": "1MB/s"
     },
     {
         "BriefDescription": "Uops delivered from decoded instruction cache=
 (decoded stream buffer or DSB) as a percent of total uops delivered to Ins=
truction Decode Queue",
         "MetricExpr": "100 * ( IDQ.DSB_UOPS / ( IDQ.DSB_UOPS + IDQ.MITE_UO=
PS + IDQ.MS_UOPS + LSD.UOPS ) )",
         "MetricGroup": "",
-        "MetricName": "percent_uops_delivered_from_decoded_icache_dsb",
+        "MetricName": "percent_uops_delivered_from_decoded_icache",
         "ScaleUnit": "1%"
     },
     {
         "BriefDescription": "Uops delivered from legacy decode pipeline (M=
icro-instruction Translation Engine or MITE) as a percent of total uops del=
ivered to Instruction Decode Queue",
         "MetricExpr": "100 * ( IDQ.MITE_UOPS / ( IDQ.DSB_UOPS + IDQ.MITE_U=
OPS + IDQ.MS_UOPS + LSD.UOPS ) )",
         "MetricGroup": "",
-        "MetricName": "percent_uops_delivered_from_legacy_decode_pipeline_=
mite",
+        "MetricName": "percent_uops_delivered_from_legacy_decode_pipeline"=
,
         "ScaleUnit": "1%"
     },
     {
         "BriefDescription": "Uops delivered from microcode sequencer (MS) =
as a percent of total uops delivered to Instruction Decode Queue",
         "MetricExpr": "100 * ( IDQ.MS_UOPS / ( IDQ.DSB_UOPS + IDQ.MITE_UOP=
S + IDQ.MS_UOPS + LSD.UOPS ) )",
         "MetricGroup": "",
-        "MetricName": "percent_uops_delivered_from_microcode_sequencer_ms"=
,
+        "MetricName": "percent_uops_delivered_from_microcode_sequencer",
         "ScaleUnit": "1%"
     },
     {
@@ -1050,255 +1566,10 @@
         "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend. Frontend denotes th=
e first part of the processor core responsible to fetch operations that are=
 executed later on by the Backend part. Within the Frontend; a branch predi=
ctor predicts the next address to fetch; cache-lines are fetched from the m=
emory subsystem; parsed into instructions; and lastly decoded into micro-op=
erations (uops). Ideally the Frontend can issue Machine_Width uops every cy=
cle to the Backend. Frontend Bound denotes unutilized issue-slots when ther=
e is no Backend stall; i.e. bubbles where Frontend delivered no uops while =
Backend could have accepted them. For example; stalls due to instruction-ca=
che misses would be categorized under Frontend Bound.",
-        "MetricExpr": "100 * ( IDQ_UOPS_NOT_DELIVERED.CORE / ( ( 4 ) * ( (=
 CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREA=
D ) ) ) )",
-        "MetricGroup": "TmaL1;PGO",
-        "MetricName": "tma_frontend_bound_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues.  For example; instruction-c=
ache misses; iTLB misses or fetch stalls after a branch misprediction are c=
ategorized under Frontend Latency. In such cases; the Frontend eventually d=
elivers no uops for some period.",
-        "MetricExpr": "100 * ( ( 4 ) * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOP=
S_DELIV.CORE / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on e=
lse ( CPU_CLK_UNHALTED.THREAD ) ) ) )",
-        "MetricGroup": "Frontend;TmaL2;m_tma_frontend_bound_percent",
-        "MetricName": "tma_fetch_latency_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses.",
-        "MetricExpr": "100 * ( ( ICACHE_16B.IFDATA_STALL + 2 * cpu@ICACHE_=
16B.IFDATA_STALL\\,cmask\\=3D0x1\\,edge\\=3D0x1@ ) / ( CPU_CLK_UNHALTED.THR=
EAD ) )",
-        "MetricGroup": "BigFoot;FetchLat;IcMiss;TmaL3;m_tma_fetch_latency_=
percent",
-        "MetricName": "tma_icache_misses_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses.",
-        "MetricExpr": "100 * ( ICACHE_64B.IFTAG_STALL / ( CPU_CLK_UNHALTED=
.THREAD ) )",
-        "MetricGroup": "BigFoot;FetchLat;MemoryTLB;TmaL3;m_tma_fetch_laten=
cy_percent",
-        "MetricName": "tma_itlb_misses_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fron=
tend delay in fetching operations from corrected path; following all sorts =
of miss-predicted branches. For example; branchy code with lots of miss-pre=
dictions might get categorized under Branch Resteers. Note the value of thi=
s node may overlap with its siblings.",
-        "MetricExpr": "100 * ( INT_MISC.CLEAR_RESTEER_CYCLES / ( CPU_CLK_U=
NHALTED.THREAD ) + ( ( 9 ) * BACLEARS.ANY / ( CPU_CLK_UNHALTED.THREAD ) ) )=
",
-        "MetricGroup": "FetchLat;TmaL3;m_tma_fetch_latency_percent",
-        "MetricName": "tma_branch_resteers_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to switches from DSB to MITE pipelines. The DSB (decod=
ed i-cache) is a Uop Cache where the front-end directly delivers Uops (micr=
o operations) avoiding heavy x86 decoding. The DSB pipeline has shorter lat=
ency and delivered higher bandwidth than the MITE (legacy instruction decod=
e pipeline). Switching between the two pipelines can cause penalties hence =
this metric measures the exposed penalty.",
-        "MetricExpr": "100 * ( DSB2MITE_SWITCHES.PENALTY_CYCLES / ( CPU_CL=
K_UNHALTED.THREAD ) )",
-        "MetricGroup": "DSBmiss;FetchLat;TmaL3;m_tma_fetch_latency_percent=
",
-        "MetricName": "tma_dsb_switches_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of cycles CPU=
 was stalled due to Length Changing Prefixes (LCPs). Using proper compiler =
flags or Intel Compiler by default will certainly avoid this. #Link: Optimi=
zation Guide about LCP BKMs.",
-        "MetricExpr": "100 * ( ILD_STALL.LCP / ( CPU_CLK_UNHALTED.THREAD )=
 )",
-        "MetricGroup": "FetchLat;TmaL3;m_tma_fetch_latency_percent",
-        "MetricName": "tma_lcp_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS). Commonly used instructions are optimized for delivery by the=
 DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Certa=
in operations cannot be handled natively by the execution pipeline; and mus=
t be performed by microcode (small programs injected into the execution str=
eam). Switching to the MS too often can negatively impact performance. The =
MS is designated to deliver long uop flows required by CISC instructions li=
ke CPUID; or uncommon conditions like Floating Point Assists when dealing w=
ith Denormals.",
-        "MetricExpr": "100 * ( ( 2 ) * IDQ.MS_SWITCHES / ( CPU_CLK_UNHALTE=
D.THREAD ) )",
-        "MetricGroup": "FetchLat;MicroSeq;TmaL3;m_tma_fetch_latency_percen=
t",
-        "MetricName": "tma_ms_switches_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend bandwidth issues.  For example; inefficienc=
ies at the instruction decoders; or restrictions for caching in the DSB (de=
coded uops cache) are categorized under Fetch Bandwidth. In such cases; the=
 Frontend typically delivers suboptimal amount of uops to the Backend.",
-        "MetricExpr": "100 * ( ( IDQ_UOPS_NOT_DELIVERED.CORE / ( ( 4 ) * (=
 ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THR=
EAD ) ) ) ) - ( ( 4 ) * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (=
 ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UN=
HALTED.THREAD ) ) ) ) )",
-        "MetricGroup": "FetchBW;Frontend;TmaL2;m_tma_frontend_bound_percen=
t",
-        "MetricName": "tma_fetch_bandwidth_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the MITE pipeline (the legacy deco=
de pipeline). This pipeline is used for code that was not pre-cached in the=
 DSB or LSD. For example; inefficiencies due to asymmetric decoders; use of=
 long immediate or LCP can manifest as MITE fetch bandwidth bottleneck.",
-        "MetricExpr": "100 * ( ( IDQ.ALL_MITE_CYCLES_ANY_UOPS - IDQ.ALL_MI=
TE_CYCLES_4_UOPS ) / ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else =
( CPU_CLK_UNHALTED.THREAD ) ) / 2 )",
-        "MetricGroup": "DSBmiss;FetchBW;TmaL3;m_tma_fetch_bandwidth_percen=
t",
-        "MetricName": "tma_mite_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to DSB (decoded uop cache) fetch pipe=
line.  For example; inefficient utilization of the DSB cache structure or b=
ank conflict when reading from it; are categorized here.",
-        "MetricExpr": "100 * ( ( IDQ.ALL_DSB_CYCLES_ANY_UOPS - IDQ.ALL_DSB=
_CYCLES_4_UOPS ) / ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( =
CPU_CLK_UNHALTED.THREAD ) ) / 2 )",
-        "MetricGroup": "DSB;FetchBW;TmaL3;m_tma_fetch_bandwidth_percent",
-        "MetricName": "tma_dsb_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations. This include slots used to issue uops t=
hat do not eventually get retired and slots for which the issue-pipeline wa=
s blocked due to recovery from earlier incorrect speculation. For example; =
wasted work due to miss-predicted branches are categorized under Bad Specul=
ation category. Incorrect data speculation followed by Memory Ordering Nuke=
s is another example.",
-        "MetricExpr": "100 * ( ( UOPS_ISSUED.ANY - ( UOPS_RETIRED.RETIRE_S=
LOTS ) + ( 4 ) * ( ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) if #SMT_on else INT=
_MISC.RECOVERY_CYCLES ) ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 )=
 if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) )",
-        "MetricGroup": "TmaL1",
-        "MetricName": "tma_bad_speculation_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction.  These slots are either wasted =
by uops fetched from an incorrectly speculated program path; or stalls when=
 the out-of-order part of the machine needs to recover its state from a spe=
culative path.",
-        "MetricExpr": "100 * ( ( BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_=
RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT ) ) * ( ( UOPS_ISSUED.ANY - ( U=
OPS_RETIRED.RETIRE_SLOTS ) + ( 4 ) * ( ( INT_MISC.RECOVERY_CYCLES_ANY / 2 )=
 if #SMT_on else INT_MISC.RECOVERY_CYCLES ) ) / ( ( 4 ) * ( ( CPU_CLK_UNHAL=
TED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) )",
-        "MetricGroup": "BadSpec;BrMispredicts;TmaL2;m_tma_bad_speculation_=
percent",
-        "MetricName": "tma_branch_mispredicts_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Machine Clears.  These slots are either wasted by uop=
s fetched prior to the clear; or stalls the out-of-order portion of the mac=
hine needs to recover its state after the clear. For example; this can happ=
en due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modify=
ing-Code (SMC) nukes.",
-        "MetricExpr": "100 * ( ( ( UOPS_ISSUED.ANY - ( UOPS_RETIRED.RETIRE=
_SLOTS ) + ( 4 ) * ( ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) if #SMT_on else I=
NT_MISC.RECOVERY_CYCLES ) ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2=
 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) - ( ( BR_MISP_RETIRED.=
ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT ) ) * =
( ( UOPS_ISSUED.ANY - ( UOPS_RETIRED.RETIRE_SLOTS ) + ( 4 ) * ( ( INT_MISC.=
RECOVERY_CYCLES_ANY / 2 ) if #SMT_on else INT_MISC.RECOVERY_CYCLES ) ) / ( =
( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNH=
ALTED.THREAD ) ) ) ) ) )",
-        "MetricGroup": "BadSpec;MachineClears;TmaL2;m_tma_bad_speculation_=
percent",
-        "MetricName": "tma_machine_clears_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend. Backend is the portion of the processor cor=
e where the out-of-order scheduler dispatches ready uops into their respect=
ive execution units; and once completed these uops get retired according to=
 program order. For example; stalls due to data-cache misses or stalls due =
to the divider unit being overloaded are both categorized under Backend Bou=
nd. Backend Bound is further divided into two main categories: Memory Bound=
 and Core Bound.",
-        "MetricExpr": "100 * ( 1 - ( IDQ_UOPS_NOT_DELIVERED.CORE / ( ( 4 )=
 * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED=
.THREAD ) ) ) ) - ( UOPS_ISSUED.ANY + ( 4 ) * ( ( INT_MISC.RECOVERY_CYCLES_=
ANY / 2 ) if #SMT_on else INT_MISC.RECOVERY_CYCLES ) ) / ( ( 4 ) * ( ( CPU_=
CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) )=
 ) )",
-        "MetricGroup": "TmaL1",
-        "MetricName": "tma_backend_bound_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck.  Memory Bound estimat=
es fraction of slots where pipeline is likely stalled due to demand load or=
 store instructions. This accounts mainly for (1) non-completed in-flight m=
emory demand loads which coincides with execution units starvation; in addi=
tion to (2) cases where stores could impose backpressure on the pipeline wh=
en many of them get buffered at the same time (less common out of the two).=
",
-        "MetricExpr": "100 * ( ( ( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACT=
IVITY.BOUND_ON_STORES ) / ( CYCLE_ACTIVITY.STALLS_TOTAL + ( EXE_ACTIVITY.1_=
PORTS_UTIL + ( ( UOPS_RETIRED.RETIRE_SLOTS ) / ( ( 4 ) * ( ( CPU_CLK_UNHALT=
ED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) * EXE=
_ACTIVITY.2_PORTS_UTIL ) + EXE_ACTIVITY.BOUND_ON_STORES ) ) * ( 1 - ( IDQ_U=
OPS_NOT_DELIVERED.CORE / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if=
 #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) - ( UOPS_ISSUED.ANY + ( 4 )=
 * ( ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) if #SMT_on else INT_MISC.RECOVERY=
_CYCLES ) ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on el=
se ( CPU_CLK_UNHALTED.THREAD ) ) ) ) )",
-        "MetricGroup": "Backend;TmaL2;m_tma_backend_bound_percent",
-        "MetricName": "tma_memory_bound_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache.  The L1 data cache typicall=
y has the shortest latency.  However; in certain cases like loads blocked o=
n older stores; a load might suffer due to high latency even though it is b=
eing satisfied by the L1. Another example is loads who miss in the TLB. The=
se cases are characterized by execution unit stalls; while some non-complet=
ed demand load lives in the machine without having that demand load missing=
 the L1 cache.",
-        "MetricExpr": "100 * ( max( ( CYCLE_ACTIVITY.STALLS_MEM_ANY - CYCL=
E_ACTIVITY.STALLS_L1D_MISS ) / ( CPU_CLK_UNHALTED.THREAD ) , 0 ) )",
-        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TmaL3;m_tma_memor=
y_bound_percent",
-        "MetricName": "tma_l1_bound_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 m=
isses/L2 hits) can improve the latency and increase performance.",
-        "MetricExpr": "100 * ( ( ( MEM_LOAD_RETIRED.L2_HIT * ( 1 + ( MEM_L=
OAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) / ( ( MEM_LOAD_RETI=
RED.L2_HIT * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS )=
 ) ) ) + cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=3D0x1@ ) ) * ( ( CYCLE_ACTIVIT=
Y.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / ( CPU_CLK_UNHALTED.TH=
READ ) ) )",
-        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TmaL3;m_tma_memor=
y_bound_percent",
-        "MetricName": "tma_l2_bound_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core. =
 Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency and=
 increase performance.",
-        "MetricExpr": "100 * ( ( CYCLE_ACTIVITY.STALLS_L2_MISS - CYCLE_ACT=
IVITY.STALLS_L3_MISS ) / ( CPU_CLK_UNHALTED.THREAD ) )",
-        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TmaL3;m_tma_memor=
y_bound_percent",
-        "MetricName": "tma_l3_bound_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads. Better caching can i=
mprove the latency and increase performance.",
-        "MetricExpr": "100 * ( min( ( ( ( CYCLE_ACTIVITY.STALLS_L3_MISS / =
( CPU_CLK_UNHALTED.THREAD ) + ( ( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_AC=
TIVITY.STALLS_L2_MISS ) / ( CPU_CLK_UNHALTED.THREAD ) ) - ( ( ( MEM_LOAD_RE=
TIRED.L2_HIT * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS=
 ) ) ) ) / ( ( MEM_LOAD_RETIRED.L2_HIT * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / =
( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) + cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=3D=
0x1@ ) ) * ( ( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MI=
SS ) / ( CPU_CLK_UNHALTED.THREAD ) ) ) ) - ( min( ( ( ( ( 1 - ( ( ( 19 * ( =
MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( =
MEM_LOAD_RETIRED.L1_MISS ) ) ) ) + 10 * ( ( MEM_LOAD_L3_MISS_RETIRED.LOCAL_=
DRAM * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) )=
 + ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT =
/ ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) + ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_HI=
TM * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) )=
 ) / ( ( 19 * ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM * ( 1 + ( MEM_LOAD_RET=
IRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) + 10 * ( ( MEM_LOAD_L3_MIS=
S_RETIRED.LOCAL_DRAM * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED=
.L1_MISS ) ) ) ) + ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * ( 1 + ( MEM_LOAD=
_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) + ( MEM_LOAD_L3_MISS_R=
ETIRED.REMOTE_HITM * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L=
1_MISS ) ) ) ) ) ) + ( 25 * ( ( MEM_LOAD_RETIRED.LOCAL_PMM * ( 1 + ( MEM_LO=
AD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) ) + 33 * ( ( MEM_LOA=
D_L3_MISS_RETIRED.REMOTE_PMM * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD=
_RETIRED.L1_MISS ) ) ) ) ) ) ) ) ) ) * ( CYCLE_ACTIVITY.STALLS_L3_MISS / ( =
CPU_CLK_UNHALTED.THREAD ) + ( ( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTI=
VITY.STALLS_L2_MISS ) / ( CPU_CLK_UNHALTED.THREAD ) ) - ( ( ( MEM_LOAD_RETI=
RED.L2_HIT * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS )=
 ) ) ) / ( ( MEM_LOAD_RETIRED.L2_HIT * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( =
MEM_LOAD_RETIRED.L1_MISS ) ) ) ) + cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=3D0x=
1@ ) ) * ( ( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS=
 ) / ( CPU_CLK_UNHALTED.THREAD ) ) ) ) ) if ( ( 1000000 ) * ( MEM_LOAD_L3_M=
ISS_RETIRED.REMOTE_PMM + MEM_LOAD_RETIRED.LOCAL_PMM ) > MEM_LOAD_RETIRED.L1=
_MISS ) else 0 ) ) , ( 1 ) ) ) ) ) , ( 1 ) ) )",
-        "MetricGroup": "MemoryBound;TmaL3mem;TmaL3;m_tma_memory_bound_perc=
ent",
-        "MetricName": "tma_dram_bound_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric roughly estimates (based on idle =
latencies) how often the CPU was stalled on accesses to external 3D-Xpoint =
(Crystal Ridge, a.k.a. IXP) memory by loads, PMM stands for Persistent Memo=
ry Module. ",
-        "MetricExpr": "100 * ( min( ( ( ( ( 1 - ( ( ( 19 * ( MEM_LOAD_L3_M=
ISS_RETIRED.REMOTE_DRAM * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETI=
RED.L1_MISS ) ) ) ) + 10 * ( ( MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * ( 1 + =
( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) + ( MEM_LOAD=
_L3_MISS_RETIRED.REMOTE_FWD * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_=
RETIRED.L1_MISS ) ) ) ) + ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM * ( 1 + ( =
MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) ) ) / ( ( 19 *=
 ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT /=
 ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) + 10 * ( ( MEM_LOAD_L3_MISS_RETIRED.LOC=
AL_DRAM * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) ) =
) ) + ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * ( 1 + ( MEM_LOAD_RETIRED.FB_H=
IT / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) + ( MEM_LOAD_L3_MISS_RETIRED.REMOTE=
_HITM * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) =
) ) ) + ( 25 * ( ( MEM_LOAD_RETIRED.LOCAL_PMM * ( 1 + ( MEM_LOAD_RETIRED.FB=
_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) ) + 33 * ( ( MEM_LOAD_L3_MISS_RET=
IRED.REMOTE_PMM * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_M=
ISS ) ) ) ) ) ) ) ) ) ) * ( CYCLE_ACTIVITY.STALLS_L3_MISS / ( CPU_CLK_UNHAL=
TED.THREAD ) + ( ( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L=
2_MISS ) / ( CPU_CLK_UNHALTED.THREAD ) ) - ( ( ( MEM_LOAD_RETIRED.L2_HIT * =
( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) / ( ( =
MEM_LOAD_RETIRED.L2_HIT * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETI=
RED.L1_MISS ) ) ) ) + cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=3D0x1@ ) ) * ( ( =
CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / ( CPU_CL=
K_UNHALTED.THREAD ) ) ) ) ) if ( ( 1000000 ) * ( MEM_LOAD_L3_MISS_RETIRED.R=
EMOTE_PMM + MEM_LOAD_RETIRED.LOCAL_PMM ) > MEM_LOAD_RETIRED.L1_MISS ) else =
0 ) ) , ( 1 ) ) )",
-        "MetricGroup": "MemoryBound;Server;TmaL3mem;TmaL3;m_tma_memory_bou=
nd_percent",
-        "MetricName": "tma_pmm_bound_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to RFO store memory accesses; RFO store issue a read-for-ownership =
request before the write. Even though store accesses do not typically stall=
 out-of-order CPUs; there are few cases where stores can lead to actual sta=
lls. This metric will be flagged should RFO stores be a bottleneck.",
-        "MetricExpr": "100 * ( EXE_ACTIVITY.BOUND_ON_STORES / ( CPU_CLK_UN=
HALTED.THREAD ) )",
-        "MetricGroup": "MemoryBound;TmaL3mem;TmaL3;m_tma_memory_bound_perc=
ent",
-        "MetricName": "tma_store_bound_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of slots wher=
e Core non-memory issues were of a bottleneck.  Shortage in hardware comput=
e resources; or dependencies in software's instructions are both categorize=
d under Core Bound. Hence it may indicate the machine ran out of an out-of-=
order resource; certain execution units are overloaded or dependencies in p=
rogram's data- or instruction-flow are limiting the performance (e.g. FP-ch=
ained long-latency arithmetic operations).",
-        "MetricExpr": "100 * ( ( 1 - ( IDQ_UOPS_NOT_DELIVERED.CORE / ( ( 4=
 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALT=
ED.THREAD ) ) ) ) - ( UOPS_ISSUED.ANY + ( 4 ) * ( ( INT_MISC.RECOVERY_CYCLE=
S_ANY / 2 ) if #SMT_on else INT_MISC.RECOVERY_CYCLES ) ) / ( ( 4 ) * ( ( CP=
U_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREAD )=
 ) ) ) - ( ( ( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.BOUND_ON_STORES=
 ) / ( CYCLE_ACTIVITY.STALLS_TOTAL + ( EXE_ACTIVITY.1_PORTS_UTIL + ( ( UOPS=
_RETIRED.RETIRE_SLOTS ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) i=
f #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) * EXE_ACTIVITY.2_PORTS_UTI=
L ) + EXE_ACTIVITY.BOUND_ON_STORES ) ) * ( 1 - ( IDQ_UOPS_NOT_DELIVERED.COR=
E / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_C=
LK_UNHALTED.THREAD ) ) ) ) - ( UOPS_ISSUED.ANY + ( 4 ) * ( ( INT_MISC.RECOV=
ERY_CYCLES_ANY / 2 ) if #SMT_on else INT_MISC.RECOVERY_CYCLES ) ) / ( ( 4 )=
 * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED=
.THREAD ) ) ) ) ) )",
-        "MetricGroup": "Backend;TmaL2;Compute;m_tma_backend_bound_percent"=
,
-        "MetricName": "tma_core_bound_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of cycles whe=
re the Divider unit was active. Divide and square root instructions are per=
formed by the Divider unit and can take considerably longer latency than in=
teger or Floating Point addition; subtraction; or multiplication.",
-        "MetricExpr": "100 * ( ARITH.DIVIDER_ACTIVE / ( CPU_CLK_UNHALTED.T=
HREAD ) )",
-        "MetricGroup": "TmaL3;m_tma_core_bound_percent",
-        "MetricName": "tma_divider_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related).  Two distinct categories can be attributed into this met=
ric: (1) heavy data-dependency among contiguous instructions would manifest=
 in this metric - such cases are often referred to as low Instruction Level=
 Parallelism (ILP). (2) Contention on some hardware execution unit other th=
an Divider. For example; when there are too many multiply operations.",
-        "MetricExpr": "100 * ( ( EXE_ACTIVITY.EXE_BOUND_0_PORTS + ( EXE_AC=
TIVITY.1_PORTS_UTIL + ( ( UOPS_RETIRED.RETIRE_SLOTS ) / ( ( 4 ) * ( ( CPU_C=
LK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) =
) ) * EXE_ACTIVITY.2_PORTS_UTIL ) ) / ( CPU_CLK_UNHALTED.THREAD ) if ( ARIT=
H.DIVIDER_ACTIVE < ( CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.STALLS_ME=
M_ANY ) ) else ( EXE_ACTIVITY.1_PORTS_UTIL + ( ( UOPS_RETIRED.RETIRE_SLOTS =
) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_C=
LK_UNHALTED.THREAD ) ) ) ) * EXE_ACTIVITY.2_PORTS_UTIL ) / ( CPU_CLK_UNHALT=
ED.THREAD ) )",
-        "MetricGroup": "PortsUtil;TmaL3;m_tma_core_bound_percent",
-        "MetricName": "tma_ports_utilization_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired. Ideally=
; all pipeline slots would be attributed to the Retiring category.  Retirin=
g of 100% would indicate the maximum Pipeline_Width throughput was achieved=
.  Maximizing Retiring typically increases the Instructions-per-cycle (see =
IPC metric). Note that a high Retiring value does not necessary mean there =
is no room for more performance.  For example; Heavy-operations or Microcod=
e Assists are categorized under Retiring. They often indicate suboptimal pe=
rformance and can often be optimized or avoided. ",
-        "MetricExpr": "100 * ( ( UOPS_RETIRED.RETIRE_SLOTS ) / ( ( 4 ) * (=
 ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THR=
EAD ) ) ) )",
-        "MetricGroup": "TmaL1",
-        "MetricName": "tma_retiring_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations -- instructions that require=
 no more than one uop (micro-operation). This correlates with total number =
of instructions used by the program. A uops-per-instruction (see UPI metric=
) ratio of 1 or less should be expected for decently optimized software run=
ning on Intel Core/Xeon products. While this often indicates efficient X86 =
instructions were executed; high value does not necessarily mean better per=
formance cannot be achieved.",
-        "MetricExpr": "100 * ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) / ( ( 4 ) *=
 ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.T=
HREAD ) ) ) ) - ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) + UOPS_RETIRED.MACRO_FUSE=
D - INST_RETIRED.ANY ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if=
 #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) )",
-        "MetricGroup": "Retire;TmaL2;m_tma_retiring_percent",
-        "MetricName": "tma_light_operations_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents overall arithmetic flo=
ating-point (FP) operations fraction the CPU has executed (retired). Note t=
his metric's value may exceed its parent due to use of \"Uops\" CountDomain=
 and FMA double-counting.",
-        "MetricExpr": "100 * ( ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) / ( ( 4 )=
 * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED=
.THREAD ) ) ) ) * UOPS_EXECUTED.X87 / UOPS_EXECUTED.THREAD ) + ( ( FP_ARITH=
_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) / ( UOP=
S_RETIRED.RETIRE_SLOTS ) ) + ( min( ( ( FP_ARITH_INST_RETIRED.128B_PACKED_D=
OUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.25=
6B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST=
_RETIRED.512B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE ) / =
( UOPS_RETIRED.RETIRE_SLOTS ) ) , ( 1 ) ) ) )",
-        "MetricGroup": "HPC;TmaL3;m_tma_light_operations_percent",
-        "MetricName": "tma_fp_arith_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations -- uops for memory load or store a=
ccesses.",
-        "MetricExpr": "100 * ( ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) / ( ( 4 )=
 * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED=
.THREAD ) ) ) ) - ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) + UOPS_RETIRED.MACRO_FU=
SED - INST_RETIRED.ANY ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) =
if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) ) * MEM_INST_RETIRED.ANY =
/ INST_RETIRED.ANY )",
-        "MetricGroup": "Pipeline;TmaL3;m_tma_light_operations_percent",
-        "MetricName": "tma_memory_operations_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions -- where one uop can represent mu=
ltiple contiguous instructions. The instruction pairs of CMP+JCC or DEC+JCC=
 are commonly used examples.",
-        "MetricExpr": "100 * ( ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) / ( ( 4 )=
 * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED=
.THREAD ) ) ) ) - ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) + UOPS_RETIRED.MACRO_FU=
SED - INST_RETIRED.ANY ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) =
if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) ) * UOPS_RETIRED.MACRO_FU=
SED / ( UOPS_RETIRED.RETIRE_SLOTS ) )",
-        "MetricGroup": "Pipeline;TmaL3;m_tma_light_operations_percent",
-        "MetricName": "tma_fused_instructions_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring branch instructions that were not fused. Non-conditi=
onal branches like direct JMP or CALL would count here. Can be used to exam=
ine fusible conditional jumps that were not fused.",
-        "MetricExpr": "100 * ( ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) / ( ( 4 )=
 * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED=
.THREAD ) ) ) ) - ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) + UOPS_RETIRED.MACRO_FU=
SED - INST_RETIRED.ANY ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) =
if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) ) * ( BR_INST_RETIRED.ALL=
_BRANCHES - UOPS_RETIRED.MACRO_FUSED ) / ( UOPS_RETIRED.RETIRE_SLOTS ) )",
-        "MetricGroup": "Pipeline;TmaL3;m_tma_light_operations_percent",
-        "MetricName": "tma_non_fused_branches_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring NOP (no op) instructions. Compilers often use NOPs f=
or certain address alignments - e.g. start address of a function or loop bo=
dy.",
-        "MetricExpr": "100 * ( ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) / ( ( 4 )=
 * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED=
.THREAD ) ) ) ) - ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) + UOPS_RETIRED.MACRO_FU=
SED - INST_RETIRED.ANY ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) =
if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) ) * INST_RETIRED.NOP / ( =
UOPS_RETIRED.RETIRE_SLOTS ) )",
-        "MetricGroup": "Pipeline;TmaL3;m_tma_light_operations_percent",
-        "MetricName": "tma_nop_instructions_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents the remaining light uo=
ps fraction the CPU has executed - remaining means not covered by other sib=
ling nodes. May undercount due to FMA double counting",
-        "MetricExpr": "100 * ( max( 0 , ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) =
/ ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK=
_UNHALTED.THREAD ) ) ) ) - ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) + UOPS_RETIRED=
.MACRO_FUSED - INST_RETIRED.ANY ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_A=
NY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) ) - ( ( ( ( ( UO=
PS_RETIRED.RETIRE_SLOTS ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 )=
 if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) * UOPS_EXECUTED.X87 / UO=
PS_EXECUTED.THREAD ) + ( ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_I=
NST_RETIRED.SCALAR_DOUBLE ) / ( UOPS_RETIRED.RETIRE_SLOTS ) ) + ( min( ( ( =
FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKE=
D_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED=
.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE + FP_ARITH_I=
NST_RETIRED.512B_PACKED_SINGLE ) / ( UOPS_RETIRED.RETIRE_SLOTS ) ) , ( 1 ) =
) ) ) + ( ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTE=
D.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) - ( ( =
( UOPS_RETIRED.RETIRE_SLOTS ) + UOPS_RETIRED.MACRO_FUSED - INST_RETIRED.ANY=
 ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_=
CLK_UNHALTED.THREAD ) ) ) ) ) * MEM_INST_RETIRED.ANY / INST_RETIRED.ANY ) +=
 ( ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREA=
D_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) - ( ( ( UOPS_=
RETIRED.RETIRE_SLOTS ) + UOPS_RETIRED.MACRO_FUSED - INST_RETIRED.ANY ) / ( =
( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNH=
ALTED.THREAD ) ) ) ) ) * UOPS_RETIRED.MACRO_FUSED / ( UOPS_RETIRED.RETIRE_S=
LOTS ) ) + ( ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) / ( ( 4 ) * ( ( CPU_CLK_UNHA=
LTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) - (=
 ( ( UOPS_RETIRED.RETIRE_SLOTS ) + UOPS_RETIRED.MACRO_FUSED - INST_RETIRED.=
ANY ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( C=
PU_CLK_UNHALTED.THREAD ) ) ) ) ) * ( BR_INST_RETIRED.ALL_BRANCHES - UOPS_RE=
TIRED.MACRO_FUSED ) / ( UOPS_RETIRED.RETIRE_SLOTS ) ) + ( ( ( ( UOPS_RETIRE=
D.RETIRE_SLOTS ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_=
on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) - ( ( ( UOPS_RETIRED.RETIRE_SLOTS=
 ) + UOPS_RETIRED.MACRO_FUSED - INST_RETIRED.ANY ) / ( ( 4 ) * ( ( CPU_CLK_=
UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) )=
 ) * INST_RETIRED.NOP / ( UOPS_RETIRED.RETIRE_SLOTS ) ) ) ) )",
-        "MetricGroup": "Pipeline;TmaL3;m_tma_light_operations_percent",
-        "MetricName": "tma_other_light_ops_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or microcoded sequences. This highly-correlates with the =
uop length of these instructions/sequences.",
-        "MetricExpr": "100 * ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) + UOPS_RETI=
RED.MACRO_FUSED - INST_RETIRED.ANY ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREA=
D_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) )",
-        "MetricGroup": "Retire;TmaL2;m_tma_retiring_percent",
-        "MetricName": "tma_heavy_operations_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring instructions that that are decoder into two or up to=
 ([SNB+] four; [ADL+] five) uops. This highly-correlates with the number of=
 uops in such instructions.",
-        "MetricExpr": "100 * ( ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) + UOPS_RE=
TIRED.MACRO_FUSED - INST_RETIRED.ANY ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THR=
EAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) - ( ( ( UOP=
S_RETIRED.RETIRE_SLOTS ) / UOPS_ISSUED.ANY ) * IDQ.MS_UOPS / ( ( 4 ) * ( ( =
CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREAD=
 ) ) ) ) )",
-        "MetricGroup": "TmaL3;m_tma_heavy_operations_percent",
-        "MetricName": "tma_few_uops_instructions_percent",
-        "ScaleUnit": "1%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The MS=
 is used for CISC instructions not supported by the default decoders (like =
repeat move strings; or CPUID); or by microcode assists used to address som=
e operation modes (like in Floating Point assists). These cases can often b=
e avoided.",
-        "MetricExpr": "100 * ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) / UOPS_ISSU=
ED.ANY ) * IDQ.MS_UOPS / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if=
 #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) )",
-        "MetricGroup": "MicroSeq;TmaL3;m_tma_heavy_operations_percent",
-        "MetricName": "tma_microcode_sequencer_percent",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to LSD (Loop Stream Detector) unit.  =
LSD typically does well sustaining Uop supply. However; in some rare cases;=
 optimal uop-delivery could not be reached for small loops whose size (in t=
erms of number of uops) does not suit well the LSD structure.",
+        "MetricExpr": "100 * ( ( LSD.CYCLES_ACTIVE - LSD.CYCLES_4_UOPS ) /=
 ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.T=
HREAD ) ) / 2 )",
+        "MetricGroup": "FetchBW;LSD;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
+        "MetricName": "tma_lsd",
         "ScaleUnit": "1%"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json=
 b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
index 6facfb244cd3..326b674045c6 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
@@ -27,20 +27,19 @@
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "read requests to memory controller. Derived f=
rom unc_m_cas_count.rd",
+        "BriefDescription": "All DRAM Read CAS Commands issued (including =
underfills)",
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
-        "EventName": "LLC_MISSES.MEM_READ",
+        "EventName": "UNC_M_CAS_COUNT.RD",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "read requests to memory controller",
+        "BriefDescription": "read requests to memory controller. Derived f=
rom unc_m_cas_count.rd",
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
-        "EventName": "UNC_M_CAS_COUNT.RD",
+        "EventName": "LLC_MISSES.MEM_READ",
         "PerPkg": "1",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
@@ -56,20 +55,19 @@
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "write requests to memory controller. Derived =
from unc_m_cas_count.wr",
+        "BriefDescription": "All DRAM Write CAS commands issued",
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
-        "EventName": "LLC_MISSES.MEM_WRITE",
+        "EventName": "UNC_M_CAS_COUNT.WR",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
         "UMask": "0xC",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "write requests to memory controller",
+        "BriefDescription": "write requests to memory controller. Derived =
from unc_m_cas_count.wr",
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
-        "EventName": "UNC_M_CAS_COUNT.WR",
+        "EventName": "LLC_MISSES.MEM_WRITE",
         "PerPkg": "1",
         "ScaleUnit": "64Bytes",
         "UMask": "0xC",
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json =
b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
index a29bba230f49..e10530c21ef8 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
@@ -1477,7 +1477,6 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x01",
-        "ScaleUnit": "4Bytes",
         "UMask": "0x01",
         "Unit": "IIO"
     },
@@ -1489,7 +1488,6 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x02",
-        "ScaleUnit": "4Bytes",
         "UMask": "0x01",
         "Unit": "IIO"
     },
@@ -1501,7 +1499,6 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x04",
-        "ScaleUnit": "4Bytes",
         "UMask": "0x01",
         "Unit": "IIO"
     },
@@ -1513,7 +1510,6 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x08",
-        "ScaleUnit": "4Bytes",
         "UMask": "0x01",
         "Unit": "IIO"
     },
@@ -1584,7 +1580,6 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x01",
-        "ScaleUnit": "4Bytes",
         "UMask": "0x04",
         "Unit": "IIO"
     },
@@ -1596,7 +1591,6 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x02",
-        "ScaleUnit": "4Bytes",
         "UMask": "0x04",
         "Unit": "IIO"
     },
@@ -1608,7 +1602,6 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x04",
-        "ScaleUnit": "4Bytes",
         "UMask": "0x04",
         "Unit": "IIO"
     },
@@ -1620,7 +1613,6 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x08",
-        "ScaleUnit": "4Bytes",
         "UMask": "0x04",
         "Unit": "IIO"
     },
@@ -2254,7 +2246,7 @@
         "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "FLITs received which bypassed the Slot0 Recei=
ve Buffer",
+        "BriefDescription": "FLITs received which bypassed the Slot0 Recie=
ve Buffer",
         "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "UNC_UPI_RxL_BYPASSED.SLOT2",
--=20
2.38.0.rc1.362.ged0d419d3c-goog

