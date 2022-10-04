Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FE45F3B55
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiJDCUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiJDCSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:18:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7444D3ED78
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 19:17:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n132-20020a25408a000000b006bcd0b35b44so11373657yba.21
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 19:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date;
        bh=3xsi+1npBdo6nobu8EYert8P4XssPVKd4PP77XWYoDk=;
        b=bukc/5TIS+byKa+thNd1p5WncGPZwiOtJUd0L9q5x1r2GP/WktwcC93kom/J+G/Bll
         h1TZqHLT615v3fiR+W+M8Xh73lCGmbAEXCEQek5+VnLP4W1K7uvqCezsMkEHI1s4Omkq
         FsOqcg8mQYEuZX7Y4nPOeKcB486P7FPoiRhF6feb8xVw3TBPc1Lw3jc9UJyFpH3VTgrm
         XsRUn6ToPct4V1wO6BCZO/3idEmfJSWKeHb2w3A4xTBxgnDfUIDvsS7oa12gtjf/SLtp
         poYCflmFwHRXO15tcNowIuJesp86gmN6mPSQ9LrSSSwQrxpxyo2nnsrWIxBhiD0U3L6B
         MPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date;
        bh=3xsi+1npBdo6nobu8EYert8P4XssPVKd4PP77XWYoDk=;
        b=httlkaoBYHDypYhXhClqo7cGrCxXWLbl/QxOo8iS/jtn/RMK93ZmWYipsgwwqU/2oi
         s1qqbIeSJ3vZsKQo6JLVrQQg5Bk9Kqr71DwZOC3oTyBFgSQeWsTi1Gm6YbVA5ZPAKADn
         xVvUHZ0QC48L4jVlab6kaTtzNzbrwVGsgft5YYVYrlBmT8YwV9WmabZW1yTDtQQI260L
         G+5IvA8TsiIj/yTf2o6Y8oamntF4gsoG7RceHwXAY19w3oU/4JLJD7+gM9iy/kjFkRSo
         RJUZiCIkntQKRZ0X80r+onZDzNsqehZxGS0OVig0aG9d+1mw9NZRsF8Ku7ljAs7GEwqK
         MKmg==
X-Gm-Message-State: ACrzQf12E8NJmZFmtEEsTtmt13qvu2M0iUlXNaB0gnliewd1XBu9ciT0
        MoNXt8nCIDWceXXIygcTCWMK8ip8EaxK
X-Google-Smtp-Source: AMsMyM4JOmNU4igrmOJ4Di4uSeV5GnnO16mUaSUKP2bG9oGfvYzEfnPsm+kl7+QW6A8cGTgR/N8Z/7EaJqjK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a86d:8afd:70b1:9b0c])
 (user=irogers job=sendgmr) by 2002:a0d:de43:0:b0:349:31bd:e8d5 with SMTP id
 h64-20020a0dde43000000b0034931bde8d5mr21836131ywe.283.1664849837191; Mon, 03
 Oct 2022 19:17:17 -0700 (PDT)
Date:   Mon,  3 Oct 2022 19:16:10 -0700
In-Reply-To: <20221004021612.325521-1-irogers@google.com>
Message-Id: <20221004021612.325521-22-irogers@google.com>
Mime-Version: 1.0
References: <20221004021612.325521-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Subject: [PATCH v3 21/23] perf vendor events: Update Intel skylake
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Events remain at v53, and the metrics are based on TMA 4.4 full.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/downloa=
d_and_gen.py
with updates at:
https://github.com/captain5050/event-converter-for-linux-perf

Updates include:
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

Tested with 'perf test':
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/skylake/skl-metrics.json         | 861 ++++++++++++++----
 1 file changed, 679 insertions(+), 182 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tool=
s/perf/pmu-events/arch/x86/skylake/skl-metrics.json
index 73fa72d3dcb1..f138b9836b51 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
@@ -1,148 +1,694 @@
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
9 * L2_RQSTS.RFO_HIT + min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTA=
NDING.CYCLES_WITH_DEMAND_RFO))) / CLKS",
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
+        "MetricExpr": "((18.5 * Average_Frequency) * MEM_LOAD_L3_HIT_RETIR=
ED.XSNP_HITM + (16.5 * Average_Frequency) * MEM_LOAD_L3_HIT_RETIRED.XSNP_MI=
SS) * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) / 2) / CLKS=
",
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
+        "MetricExpr": "(16.5 * Average_Frequency) * MEM_LOAD_L3_HIT_RETIRE=
D.XSNP_HIT * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) / 2)=
 / CLKS",
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
+        "MetricExpr": "(6.5 * Average_Frequency) * MEM_LOAD_RETIRED.L3_HIT=
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
+        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L3_MISS / CLKS + ((CYCLE_ACT=
IVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / CLKS) - tma_l2_bou=
nd)",
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
+        "MetricExpr": "((L2_RQSTS.RFO_HIT * 9 * (1 - (MEM_INST_RETIRED.LOC=
K_LOADS / MEM_INST_RETIRED.ALL_STORES))) + (1 - (MEM_INST_RETIRED.LOCK_LOAD=
S / MEM_INST_RETIRED.ALL_STORES)) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_RE=
QUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / CLKS",
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
+        "MetricExpr": "(22 * Average_Frequency) * OFFCORE_RESPONSE.DEMAND_=
RFO.L3_HIT.SNOOP_HITM / CLKS",
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
+    },
+    {
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
E + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) / UOPS_RETIRED.RETIRE_SLOTS",
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
 INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.THREAD))) * ( ( (CYCLE_=
ACTIVITY.STALLS_L3_MISS / CPU_CLK_UNHALTED.THREAD + (( CYCLE_ACTIVITY.STALL=
S_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / CPU_CLK_UNHALTED.THREAD) - (=
( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETI=
RED.L1_MISS) )) / ( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_H=
IT / MEM_LOAD_RETIRED.L1_MISS) )) + cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=3D1=
@ ) ) * (( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS )=
 / CPU_CLK_UNHALTED.THREAD))) / #((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_AC=
TIVITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_P=
ORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_UNHALTED.THREAD)) * E=
XE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_UOPS=
_NOT_DELIVERED.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) - ( UOPS_ISSUED.ANY + =
4 * INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.THREAD))) ) * ( (min=
( CPU_CLK_UNHALTED.THREAD , cpu@OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD\\,=
cmask\\=3D4@ ) / CPU_CLK_UNHALTED.THREAD) / #(CYCLE_ACTIVITY.STALLS_L3_MISS=
 / CPU_CLK_UNHALTED.THREAD + (( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTI=
VITY.STALLS_L2_MISS ) / CPU_CLK_UNHALTED.THREAD) - (( (MEM_LOAD_RETIRED.L2_=
HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) / ( (ME=
M_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L=
1_MISS) )) + cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=3D1@ ) ) * (( CYCLE_ACTIVI=
TY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / CPU_CLK_UNHALTED.THR=
EAD))) ) + ( (( CYCLE_ACTIVITY.STALLS_L2_MISS - CYCLE_ACTIVITY.STALLS_L3_MI=
SS ) / CPU_CLK_UNHALTED.THREAD) / #((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_=
ACTIVITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1=
_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_UNHALTED.THREAD)) *=
 EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_UO=
PS_NOT_DELIVERED.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) - ( UOPS_ISSUED.ANY =
+ 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.THREAD))) ) * ( (O=
FFCORE_REQUESTS_BUFFER.SQ_FULL / CPU_CLK_UNHALTED.THREAD) / #(( CYCLE_ACTIV=
ITY.STALLS_L2_MISS - CYCLE_ACTIVITY.STALLS_L3_MISS ) / CPU_CLK_UNHALTED.THR=
EAD) ) ) + ( (max( ( CYCLE_ACTIVITY.STALLS_MEM_ANY - CYCLE_ACTIVITY.STALLS_=
L1D_MISS ) / CPU_CLK_UNHALTED.THREAD , 0 )) / #((( CYCLE_ACTIVITY.STALLS_ME=
M_ANY + EXE_ACTIVITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EX=
E_ACTIVITY.1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_UNHALTE=
D.THREAD)) * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) * =
(1 - (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) - ( UOPS=
_ISSUED.ANY + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.THREAD=
))) ) * ( ((L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS + MEM_LOAD_R=
ETIRED.FB_HIT )) * cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=3D1@ / CPU_CLK_UNHAL=
TED.THREAD) / #(max( ( CYCLE_ACTIVITY.STALLS_MEM_ANY - CYCLE_ACTIVITY.STALL=
S_L1D_MISS ) / CPU_CLK_UNHALTED.THREAD , 0 )) ) ",
+        "MetricExpr": "100 * tma_memory_bound * ((tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + (tma_l3_boun=
d / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_stor=
e_bound)) * (tma_sq_full / (tma_contested_accesses + tma_data_sharing + tma=
_l3_hit_latency + tma_sq_full))) + (tma_l1_bound / (tma_dram_bound + tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_fb_full / (=
tma_4k_aliasing + tma_dtlb_load + tma_fb_full + tma_lock_latency + tma_spli=
t_loads + tma_store_fwd_blk)) ",
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
CLK_UNHALTED.REF_XCLK ) )))) * ( ( (CYCLE_ACTIVITY.STALLS_L3_MISS / CPU_CLK=
_UNHALTED.THREAD + (( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALL=
S_L2_MISS ) / CPU_CLK_UNHALTED.THREAD) - (( (MEM_LOAD_RETIRED.L2_HIT * ( 1 =
+ (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) / ( (MEM_LOAD_RET=
IRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) ))=
 + cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=3D1@ ) ) * (( CYCLE_ACTIVITY.STALLS_=
L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / CPU_CLK_UNHALTED.THREAD))) / #=
((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.BOUND_ON_STORES ) / (CYCLE=
_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_=
SLOTS / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE=
_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * EXE_ACTIVITY.2_PORTS_UTI=
L) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_UOPS_NOT_DELIVERED.CORE / (=
4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_A=
CTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) - ( UOPS_ISSUED.ANY + 4 * ( INT_MIS=
C.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( =
1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )=
 * ( (min( CPU_CLK_UNHALTED.THREAD , cpu@OFFCORE_REQUESTS_OUTSTANDING.ALL_D=
ATA_RD\\,cmask\\=3D4@ ) / CPU_CLK_UNHALTED.THREAD) / #(CYCLE_ACTIVITY.STALL=
S_L3_MISS / CPU_CLK_UNHALTED.THREAD + (( CYCLE_ACTIVITY.STALLS_L1D_MISS - C=
YCLE_ACTIVITY.STALLS_L2_MISS ) / CPU_CLK_UNHALTED.THREAD) - (( (MEM_LOAD_RE=
TIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )=
) / ( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_=
RETIRED.L1_MISS) )) + cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=3D1@ ) ) * (( CYC=
LE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / CPU_CLK_UNH=
ALTED.THREAD))) ) + ( (( CYCLE_ACTIVITY.STALLS_L2_MISS - CYCLE_ACTIVITY.STA=
LLS_L3_MISS ) / CPU_CLK_UNHALTED.THREAD) / #((( CYCLE_ACTIVITY.STALLS_MEM_A=
NY + EXE_ACTIVITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_A=
CTIVITY.1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * ( ( CPU_CLK_UNHALT=
ED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALT=
ED.REF_XCLK ) ))) * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STOR=
ES)) * (1 - (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD=
 / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XC=
LK ) ))) - ( UOPS_ISSUED.ANY + 4 * ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) /=
 (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD=
_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) ) * ( (( OFFCORE_REQUESTS_BUFFER=
.SQ_FULL / 2 ) / ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED=
.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )) / #(( CYCLE_ACTIVITY.ST=
ALLS_L2_MISS - CYCLE_ACTIVITY.STALLS_L3_MISS ) / CPU_CLK_UNHALTED.THREAD) )=
 ) + ( (max( ( CYCLE_ACTIVITY.STALLS_MEM_ANY - CYCLE_ACTIVITY.STALLS_L1D_MI=
SS ) / CPU_CLK_UNHALTED.THREAD , 0 )) / #((( CYCLE_ACTIVITY.STALLS_MEM_ANY =
+ EXE_ACTIVITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTI=
VITY.1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * ( ( CPU_CLK_UNHALTED.=
THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.=
REF_XCLK ) ))) * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)=
) * (1 - (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / =
2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK =
) ))) - ( UOPS_ISSUED.ANY + 4 * ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4=
 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_AC=
TIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) ) * ( ((L1D_PEND_MISS.PENDING / ( M=
EM_LOAD_RETIRED.L1_MISS + MEM_LOAD_RETIRED.FB_HIT )) * cpu@L1D_PEND_MISS.FB=
_FULL\\,cmask\\=3D1@ / CPU_CLK_UNHALTED.THREAD) / #(max( ( CYCLE_ACTIVITY.S=
TALLS_MEM_ANY - CYCLE_ACTIVITY.STALLS_L1D_MISS ) / CPU_CLK_UNHALTED.THREAD =
, 0 )) ) ",
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
 INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.THREAD))) * ( ( (CYCLE_=
ACTIVITY.STALLS_L3_MISS / CPU_CLK_UNHALTED.THREAD + (( CYCLE_ACTIVITY.STALL=
S_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / CPU_CLK_UNHALTED.THREAD) - (=
( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETI=
RED.L1_MISS) )) / ( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_H=
IT / MEM_LOAD_RETIRED.L1_MISS) )) + cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=3D1=
@ ) ) * (( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS )=
 / CPU_CLK_UNHALTED.THREAD))) / #((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_AC=
TIVITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_P=
ORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_UNHALTED.THREAD)) * E=
XE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_UOPS=
_NOT_DELIVERED.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) - ( UOPS_ISSUED.ANY + =
4 * INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.THREAD))) ) * ( (min=
( CPU_CLK_UNHALTED.THREAD , OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_R=
D ) / CPU_CLK_UNHALTED.THREAD - (min( CPU_CLK_UNHALTED.THREAD , cpu@OFFCORE=
_REQUESTS_OUTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@ ) / CPU_CLK_UNHALTED.THREA=
D)) / #(CYCLE_ACTIVITY.STALLS_L3_MISS / CPU_CLK_UNHALTED.THREAD + (( CYCLE_=
ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / CPU_CLK_UNHALT=
ED.THREAD) - (( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT /=
 MEM_LOAD_RETIRED.L1_MISS) )) / ( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOA=
D_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + cpu@L1D_PEND_MISS.FB_FULL=
\\,cmask\\=3D1@ ) ) * (( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.ST=
ALLS_L2_MISS ) / CPU_CLK_UNHALTED.THREAD))) ) + ( (( CYCLE_ACTIVITY.STALLS_=
L2_MISS - CYCLE_ACTIVITY.STALLS_L3_MISS ) / CPU_CLK_UNHALTED.THREAD) / #(((=
 CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.BOUND_ON_STORES ) / (CYCLE_AC=
TIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLO=
TS / (4 * CPU_CLK_UNHALTED.THREAD)) * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTI=
VITY.BOUND_ON_STORES)) * (1 - (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * CPU_CLK_U=
NHALTED.THREAD)) - ( UOPS_ISSUED.ANY + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 =
* CPU_CLK_UNHALTED.THREAD))) ) * ( (( (10 * ((CPU_CLK_UNHALTED.THREAD / CPU=
_CLK_UNHALTED.REF_TSC) * msr@tsc@ / 1000000000 / duration_time)) - (3.5 * (=
(CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC) * msr@tsc@ / 100000000=
0 / duration_time)) ) * MEM_LOAD_RETIRED.L3_HIT * (1 + (MEM_LOAD_RETIRED.FB=
_HIT / MEM_LOAD_RETIRED.L1_MISS) / 2) / CPU_CLK_UNHALTED.THREAD) / #(( CYCL=
E_ACTIVITY.STALLS_L2_MISS - CYCLE_ACTIVITY.STALLS_L3_MISS ) / CPU_CLK_UNHAL=
TED.THREAD) ) + ( (( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_=
HIT / MEM_LOAD_RETIRED.L1_MISS) )) / ( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (ME=
M_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + cpu@L1D_PEND_MISS.FB=
_FULL\\,cmask\\=3D1@ ) ) * (( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVI=
TY.STALLS_L2_MISS ) / CPU_CLK_UNHALTED.THREAD)) / #((( CYCLE_ACTIVITY.STALL=
S_MEM_ANY + EXE_ACTIVITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL +=
 (EXE_ACTIVITY.1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_UNH=
ALTED.THREAD)) * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)=
) * (1 - (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) - ( =
UOPS_ISSUED.ANY + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.TH=
READ))) ) )",
+        "MetricExpr": "100 * tma_memory_bound * ((tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + (tma_l3_bound =
/ (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_=
bound)) * (tma_l3_hit_latency / (tma_contested_accesses + tma_data_sharing =
+ tma_l3_hit_latency + tma_sq_full)) + (tma_l2_bound / (tma_dram_bound + tm=
a_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)))",
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
CLK_UNHALTED.REF_XCLK ) )))) * ( ( (CYCLE_ACTIVITY.STALLS_L3_MISS / CPU_CLK=
_UNHALTED.THREAD + (( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALL=
S_L2_MISS ) / CPU_CLK_UNHALTED.THREAD) - (( (MEM_LOAD_RETIRED.L2_HIT * ( 1 =
+ (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) / ( (MEM_LOAD_RET=
IRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) ))=
 + cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=3D1@ ) ) * (( CYCLE_ACTIVITY.STALLS_=
L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / CPU_CLK_UNHALTED.THREAD))) / #=
((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.BOUND_ON_STORES ) / (CYCLE=
_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_=
SLOTS / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE=
_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * EXE_ACTIVITY.2_PORTS_UTI=
L) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_UOPS_NOT_DELIVERED.CORE / (=
4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_A=
CTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) - ( UOPS_ISSUED.ANY + 4 * ( INT_MIS=
C.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( =
1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )=
 * ( (min( CPU_CLK_UNHALTED.THREAD , OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WI=
TH_DATA_RD ) / CPU_CLK_UNHALTED.THREAD - (min( CPU_CLK_UNHALTED.THREAD , cp=
u@OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@ ) / CPU_CLK_UNHAL=
TED.THREAD)) / #(CYCLE_ACTIVITY.STALLS_L3_MISS / CPU_CLK_UNHALTED.THREAD + =
(( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / CPU_C=
LK_UNHALTED.THREAD) - (( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED=
.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) / ( (MEM_LOAD_RETIRED.L2_HIT * ( 1 +=
 (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) )) + cpu@L1D_PEND_MIS=
S.FB_FULL\\,cmask\\=3D1@ ) ) * (( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_AC=
TIVITY.STALLS_L2_MISS ) / CPU_CLK_UNHALTED.THREAD))) ) + ( (( CYCLE_ACTIVIT=
Y.STALLS_L2_MISS - CYCLE_ACTIVITY.STALLS_L3_MISS ) / CPU_CLK_UNHALTED.THREA=
D) / #((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.BOUND_ON_STORES ) / =
(CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UTIL + (UOPS_RETIRED.R=
ETIRE_SLOTS / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALT=
ED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * EXE_ACTIVITY.2_POR=
TS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_UOPS_NOT_DELIVERED.CO=
RE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_TH=
READ_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) - ( UOPS_ISSUED.ANY + 4 * ( I=
NT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 =
) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) =
)))) ) * ( (( (10 * ((CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC) *=
 msr@tsc@ / 1000000000 / duration_time)) - (3.5 * ((CPU_CLK_UNHALTED.THREAD=
 / CPU_CLK_UNHALTED.REF_TSC) * msr@tsc@ / 1000000000 / duration_time)) ) * =
MEM_LOAD_RETIRED.L3_HIT * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.=
L1_MISS) / 2) / CPU_CLK_UNHALTED.THREAD) / #(( CYCLE_ACTIVITY.STALLS_L2_MIS=
S - CYCLE_ACTIVITY.STALLS_L3_MISS ) / CPU_CLK_UNHALTED.THREAD) ) + ( (( (ME=
M_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L=
1_MISS) )) / ( (MEM_LOAD_RETIRED.L2_HIT * ( 1 + (MEM_LOAD_RETIRED.FB_HIT / =
MEM_LOAD_RETIRED.L1_MISS) )) + cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=3D1@ ) )=
 * (( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / CP=
U_CLK_UNHALTED.THREAD)) / #((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIVITY=
.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_U=
TIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) *=
 ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))=
 * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_=
UOPS_NOT_DELIVERED.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CP=
U_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) - ( UOPS=
_ISSUED.ANY + 4 * ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_CLK=
_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK=
_UNHALTED.REF_XCLK ) )))) ) )",
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
tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, tma_4k_aliasing + tm=
a_dtlb_load + tma_fb_full + tma_lock_latency + tma_split_loads + tma_store_=
fwd_blk)) + (tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_boun=
d + tma_l3_bound + tma_store_bound)) * (tma_dtlb_store / (tma_dtlb_store + =
tma_false_sharing + tma_split_stores + tma_store_latency))) ",
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
@@ -160,8 +706,8 @@
     },
     {
         "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
-        "MetricExpr": "1 / (INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD)",
-        "MetricGroup": "Pipeline;Mem",
+        "MetricExpr": "1 / IPC",
+        "MetricGroup": "Mem;Pipeline",
         "MetricName": "CPI"
     },
     {
@@ -172,16 +718,10 @@
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
@@ -191,63 +731,38 @@
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
ED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE ) / =
CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "Ret;Flops",
+        "MetricExpr": "(1 * (FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARIT=
H_INST_RETIRED.SCALAR_DOUBLE) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBL=
E + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.2=
56B_PACKED_DOUBLE) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) / CORE_C=
LKS",
+        "MetricGroup": "Flops;Ret",
         "MetricName": "FLOPc"
     },
-    {
-        "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricExpr": "( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_AR=
ITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DO=
UBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIR=
ED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE ) / =
( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIV=
E / CPU_CLK_UNHALTED.REF_XCLK ) )",
-        "MetricGroup": "Ret;Flops_SMT",
-        "MetricName": "FLOPc_SMT"
-    },
     {
         "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
-        "MetricExpr": "( (FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_I=
NST_RETIRED.SCALAR_DOUBLE) + (FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP=
_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_=
DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) ) / ( 2 * CPU_CLK_UNHALT=
ED.THREAD )",
+        "MetricExpr": "((FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_IN=
ST_RETIRED.SCALAR_DOUBLE) + (FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_=
ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_D=
OUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE)) / (2 * CORE_CLKS)",
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
DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) ) / ( 2 * ( ( CPU_CLK_UN=
HALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UN=
HALTED.REF_XCLK ) ) )",
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
@@ -289,13 +804,13 @@
     },
     {
         "BriefDescription": "Instructions per Floating Point (FP) Operatio=
n (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / ( 1 * ( FP_ARITH_INST_RETIRED.SC=
ALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RET=
IRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + =
FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B=
_PACKED_SINGLE )",
+        "MetricExpr": "INST_RETIRED.ANY / (1 * (FP_ARITH_INST_RETIRED.SCAL=
AR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE) + 2 * FP_ARITH_INST_RETIRE=
D.128B_PACKED_DOUBLE + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_A=
RITH_INST_RETIRED.256B_PACKED_DOUBLE) + 8 * FP_ARITH_INST_RETIRED.256B_PACK=
ED_SINGLE)",
         "MetricGroup": "Flops;InsType",
         "MetricName": "IpFLOP"
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic instruction (l=
ower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / ( (FP_ARITH_INST_RETIRED.SCALAR_=
SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE) + (FP_ARITH_INST_RETIRED.128B=
_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_R=
ETIRED.256B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) )",
+        "MetricExpr": "INST_RETIRED.ANY / ((FP_ARITH_INST_RETIRED.SCALAR_S=
INGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE) + (FP_ARITH_INST_RETIRED.128B_=
PACKED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RE=
TIRED.256B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE))",
         "MetricGroup": "Flops;InsType",
         "MetricName": "IpArith",
         "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). May undercount due to FMA doubl=
e counting. Approximated prior to BDW."
@@ -316,14 +831,14 @@
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
@@ -335,9 +850,9 @@
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
@@ -372,16 +887,10 @@
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
@@ -396,16 +905,10 @@
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
@@ -414,101 +917,95 @@
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
@@ -535,25 +1032,25 @@
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
@@ -565,26 +1062,26 @@
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
IRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE ) =
/ 1000000000 ) / duration_time",
+        "MetricExpr": "((1 * (FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARI=
TH_INST_RETIRED.SCALAR_DOUBLE) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUB=
LE + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.=
256B_PACKED_DOUBLE) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) / 10000=
00000) / duration_time",
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
         "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
-        "MetricExpr": "1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_=
UNHALTED.REF_XCLK_ANY / 2 ) if #SMT_on else 0",
+        "MetricExpr": "1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / (CPU_CLK_U=
NHALTED.REF_XCLK_ANY / 2) if #SMT_on else 0",
         "MetricGroup": "SMT",
         "MetricName": "SMT_2T_Utilization"
     },
@@ -602,7 +1099,7 @@
     },
     {
         "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
-        "MetricExpr": "64 * ( arb@event\\=3D0x81\\,umask\\=3D0x1@ + arb@ev=
ent\\=3D0x84\\,umask\\=3D0x1@ ) / 1000000 / duration_time / 1000",
+        "MetricExpr": "64 * (arb@event\\=3D0x81\\,umask\\=3D0x1@ + arb@eve=
nt\\=3D0x84\\,umask\\=3D0x1@) / 1000000 / duration_time / 1000",
         "MetricGroup": "HPC;Mem;MemoryBW;SoC",
         "MetricName": "DRAM_BW_Use"
     },
--=20
2.38.0.rc1.362.ged0d419d3c-goog

