Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C5F69BF79
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjBSJa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjBSJay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:30:54 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87D0DBEA
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:30:28 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-53688a1b4fdso17683647b3.22
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wg6Vhc0tzXLtuHVnUe0I2g0P4qJqToZ80hJnRYQxPs0=;
        b=sp7/fQQsO9W+LlsOnpJG+P/P7DJMBeB98TfnNytNFYtpz/0yssRiPrGjn+I1r5L/5X
         c6ElwFWnoa438rqXKPOi9uhXzdOS3quV37lrfudok/YfuJcClffSrjbvFL2u2JUGpmen
         dcCCJEbX7MOTJuKB3DYnmbAct8VLFk6+Tmp1Hclh29VUXmLBbuLNze2bQzW6XJ0xZvtL
         /29YtEkDXh+BqKCn0V8uaF5Wooj5HaR/ALQsAxSiLm6Jch7ixxigT29DUqgr+UYtZEoS
         qbEnEK/GURwxA4mPxq+gNzOuKFCAi5+l9jMfX8N6Xbyp0N/1W+tcsbQtStkmWiLXvz5D
         K4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wg6Vhc0tzXLtuHVnUe0I2g0P4qJqToZ80hJnRYQxPs0=;
        b=O3mYcOZARkPhIayKdjV9B8x95kXVmRoI3e5V1qJsoTxTEbjW0qEYOrbSp+KJr4ZQrr
         77ZFKseH6ZXIrjNgmDcC1muQXdhHWyxZDUHcJfT3rWScwap4o858HI6V6u4Gw9nQSN57
         uh9TuwUfoEHK2WeVAodf3V0RdHCHM8SIuVXrIsRavWaZOeUOA2sPjTNUrFn68aZi5IQu
         tspYsR6FU1RfyOuYGQwgtFLO+7N4sUpNi4tnzUxMb6KiuA+ldRuYSZrhM3heVrQ00j/1
         VCLnYL5YNkVYVbwyIaaGnFTRtPer4BbnXoZi6ByL4OtmlN+nh/gd+4uYeNfij+s5D5DX
         VFuw==
X-Gm-Message-State: AO0yUKW3TXpBbANmyiVtI2IFTNdi8q7AoQFqhn6uPKQl/i535+Isw9Oa
        +XPRHRnYgKKWJAxcgimt5z9jWT/YvfwH
X-Google-Smtp-Source: AK7set+TOhnDTDhEOKZqtlJmim/sqrca61Vfm63IdlsrFEVA8VXKomhzmaDe6REtpNh5mLOcAeSek4kshq2Q
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a05:6902:45:b0:995:ccb:1aae with SMTP id
 m5-20020a056902004500b009950ccb1aaemr109854ybh.13.1676799025326; Sun, 19 Feb
 2023 01:30:25 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:07 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-11-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 10/51] perf vendor events intel: Refresh alderlake events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
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

Update the alderlake events from 1.16 to 1.18. Generation was done
using https://github.com/intel/perfmon.

Notable changes are new events and event descriptions, TMA metrics are
updated to version 4.5, TMA info metrics are renamed from their node
name to be lower case and prefixed by tma_info_, MetricThreshold
expressions are added, smi_cost and transaction metric groups are
added replicating existing hard coded metrics in stat-shadow.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/alderlake/adl-metrics.json       | 3190 ++++++++++-------
 .../pmu-events/arch/x86/alderlake/cache.json  |   36 +-
 .../arch/x86/alderlake/floating-point.json    |   27 +
 .../arch/x86/alderlake/frontend.json          |    9 +
 .../pmu-events/arch/x86/alderlake/memory.json |    3 +-
 .../arch/x86/alderlake/pipeline.json          |   14 +-
 .../arch/x86/alderlake/uncore-other.json      |   28 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |    2 +-
 8 files changed, 1902 insertions(+), 1407 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/to=
ols/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
index 2eb3d7464d9f..7bb8410a2bf9 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
@@ -1,2034 +1,2440 @@
 [
     {
-        "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
-        "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.UO=
P_DROPPING / SLOTS",
-        "MetricGroup": "PGO;TopdownL1;tma_L1_group",
-        "MetricName": "tma_frontend_bound",
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
ache misses would be categorized under Frontend Bound. Sample with: FRONTEN=
D_RETIRED.LATENCY_GE_4_PS",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "C10 residency percent per package",
+        "MetricExpr": "cstate_pkg@c10\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C10_Pkg_Residency",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues",
-        "MetricExpr": "topdown\\-fetch\\-lat / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.U=
OP_DROPPING / SLOTS",
-        "MetricGroup": "Frontend;TopdownL2;tma_L2_group;tma_frontend_bound=
_group",
-        "MetricName": "tma_fetch_latency",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend latency issues.  For example; instruction-=
cache misses; iTLB misses or fetch stalls after a branch misprediction are =
categorized under Frontend Latency. In such cases; the Frontend eventually =
delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_=
16_PS;FRONTEND_RETIRED.LATENCY_GE_8_PS",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "C1 residency percent per core",
+        "MetricExpr": "cstate_core@c1\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C1_Core_Residency",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses",
-        "MetricExpr": "ICACHE_DATA.STALLS / CLKS",
-        "MetricGroup": "BigFoot;FetchLat;IcMiss;TopdownL3;tma_fetch_latenc=
y_group",
-        "MetricName": "tma_icache_misses",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to instruction cache misses. Sample with: FRONTEND_RE=
TIRED.L2_MISS_PS;FRONTEND_RETIRED.L1I_MISS_PS",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "C2 residency percent per package",
+        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C2_Pkg_Residency",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
-        "MetricExpr": "ICACHE_TAG.STALLS / CLKS",
-        "MetricGroup": "BigFoot;FetchLat;MemoryTLB;TopdownL3;tma_fetch_lat=
ency_group",
-        "MetricName": "tma_itlb_misses",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: FRONTE=
ND_RETIRED.STLB_MISS_PS;FRONTEND_RETIRED.ITLB_MISS_PS",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "C3 residency percent per package",
+        "MetricExpr": "cstate_pkg@c3\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C3_Pkg_Residency",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers",
-        "MetricExpr": "INT_MISC.CLEAR_RESTEER_CYCLES / CLKS + tma_unknown_=
branches",
-        "MetricGroup": "FetchLat;TopdownL3;tma_fetch_latency_group",
-        "MetricName": "tma_branch_resteers",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fro=
ntend delay in fetching operations from corrected path; following all sorts=
 of miss-predicted branches. For example; branchy code with lots of miss-pr=
edictions might get categorized under Branch Resteers. Note the value of th=
is node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_BRA=
NCHES",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "C6 residency percent per core",
+        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C6_Core_Residency",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Branch Misprediction=
 at execution stage",
-        "MetricExpr": "tma_branch_mispredicts / tma_bad_speculation * INT_=
MISC.CLEAR_RESTEER_CYCLES / CLKS",
-        "MetricGroup": "BadSpec;BrMispredicts;TopdownL4;tma_branch_resteer=
s_group",
-        "MetricName": "tma_mispredicts_resteers",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage.  Sample with: INT_MISC.CLEAR_RESTEER_CYCLES",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "C6 residency percent per package",
+        "MetricExpr": "cstate_pkg@c6\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C6_Pkg_Residency",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Machine Clears",
-        "MetricExpr": "(1 - tma_branch_mispredicts / tma_bad_speculation) =
* INT_MISC.CLEAR_RESTEER_CYCLES / CLKS",
-        "MetricGroup": "BadSpec;MachineClears;TopdownL4;tma_branch_resteer=
s_group",
-        "MetricName": "tma_clears_resteers",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Machine Clears.  Sa=
mple with: INT_MISC.CLEAR_RESTEER_CYCLES",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "C7 residency percent per core",
+        "MetricExpr": "cstate_core@c7\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C7_Core_Residency",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to new branch address clears",
-        "MetricExpr": "INT_MISC.UNKNOWN_BRANCH_CYCLES / CLKS",
-        "MetricGroup": "BigFoot;FetchLat;TopdownL4;tma_branch_resteers_gro=
up",
-        "MetricName": "tma_unknown_branches",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to new branch address clears. These are fetched branc=
hes the Branch Prediction Unit was unable to recognize (First fetch or hitt=
ing BPU capacity limit). Sample with: FRONTEND_RETIRED.UNKNOWN_BRANCH",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "C7 residency percent per package",
+        "MetricExpr": "cstate_pkg@c7\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C7_Pkg_Residency",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to switches from DSB to MITE pipelines",
-        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / CLKS",
-        "MetricGroup": "DSBmiss;FetchLat;TopdownL3;tma_fetch_latency_group=
",
-        "MetricName": "tma_dsb_switches",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS_PS",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "C8 residency percent per package",
+        "MetricExpr": "cstate_pkg@c8\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C8_Pkg_Residency",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles CPU=
 was stalled due to Length Changing Prefixes (LCPs)",
-        "MetricExpr": "DECODE.LCP / CLKS",
-        "MetricGroup": "FetchLat;TopdownL3;tma_fetch_latency_group",
-        "MetricName": "tma_lcp",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs.",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "C9 residency percent per package",
+        "MetricExpr": "cstate_pkg@c9\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C9_Pkg_Residency",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS)",
-        "MetricExpr": "3 * IDQ.MS_SWITCHES / CLKS",
-        "MetricGroup": "FetchLat;MicroSeq;TopdownL3;tma_fetch_latency_grou=
p",
-        "MetricName": "tma_ms_switches",
-        "PublicDescription": "This metric estimates the fraction of cycles=
 when the CPU was stalled due to switches of uop delivery to the Microcode =
Sequencer (MS). Commonly used instructions are optimized for delivery by th=
e DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Cert=
ain operations cannot be handled natively by the execution pipeline; and mu=
st be performed by microcode (small programs injected into the execution st=
ream). Switching to the MS too often can negatively impact performance. The=
 MS is designated to deliver long uop flows required by CISC instructions l=
ike CPUID; or uncommon conditions like Floating Point Assists when dealing =
with Denormals. Sample with: FRONTEND_RETIRED.MS_FLOWS",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Uncore frequency per die [GHZ]",
+        "MetricExpr": "tma_info_socket_clks / #num_dies / duration_time / =
1e9",
+        "MetricGroup": "SoC",
+        "MetricName": "UNCORE_FREQ"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend bandwidth issues",
-        "MetricExpr": "max(0, tma_frontend_bound - tma_fetch_latency)",
-        "MetricGroup": "FetchBW;Frontend;TopdownL2;tma_L2_group;tma_fronte=
nd_bound_group",
-        "MetricName": "tma_fetch_bandwidth",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LA=
TENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Percentage of cycles spent in System Manageme=
nt Interrupts.",
+        "MetricExpr": "((msr@aperf@ - cycles) / msr@aperf@ if msr@smi@ > 0=
 else 0)",
+        "MetricGroup": "smi",
+        "MetricName": "smi_cycles",
+        "MetricThreshold": "smi_cycles > 0.1",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the MITE pipeline (the legacy deco=
de pipeline)",
-        "MetricExpr": "(IDQ.MITE_CYCLES_ANY - IDQ.MITE_CYCLES_OK) / CORE_C=
LKS / 2",
-        "MetricGroup": "DSBmiss;FetchBW;TopdownL3;tma_fetch_bandwidth_grou=
p",
-        "MetricName": "tma_mite",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to the MITE pipeline (the legacy dec=
ode pipeline). This pipeline is used for code that was not pre-cached in th=
e DSB or LSD. For example; inefficiencies due to asymmetric decoders; use o=
f long immediate or LCP can manifest as MITE fetch bandwidth bottleneck. Sa=
mple with: FRONTEND_RETIRED.ANY_DSB_MISS",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Number of SMI interrupts.",
+        "MetricExpr": "msr@smi@",
+        "MetricGroup": "smi",
+        "MetricName": "smi_num",
+        "ScaleUnit": "1SMI#"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles whe=
re decoder-0 was the only active decoder",
-        "MetricExpr": "(cpu_core@INST_DECODED.DECODERS\\,cmask\\=3D1@ - cp=
u_core@INST_DECODED.DECODERS\\,cmask\\=3D2@) / CORE_CLKS",
-        "MetricGroup": "DSBmiss;FetchBW;TopdownL4;tma_mite_group",
-        "MetricName": "tma_decoder0_alone",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Percentage of cycles in aborted transactions.=
",
+        "MetricExpr": "max(cpu@cycles\\-t@ - cpu@cycles\\-ct@, 0) / cycles=
",
+        "MetricGroup": "transaction",
+        "MetricName": "tsx_aborted_cycles",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to DSB (decoded uop cache) fetch pipe=
line",
-        "MetricExpr": "(IDQ.DSB_CYCLES_ANY - IDQ.DSB_CYCLES_OK) / CORE_CLK=
S / 2",
-        "MetricGroup": "DSB;FetchBW;TopdownL3;tma_fetch_bandwidth_group",
-        "MetricName": "tma_dsb",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here.",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Number of cycles within a transaction divided=
 by the number of elisions.",
+        "MetricExpr": "cpu@cycles\\-t@ / cpu@el\\-start@",
+        "MetricGroup": "transaction",
+        "MetricName": "tsx_cycles_per_elision",
+        "ScaleUnit": "1cycles / elision"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to LSD (Loop Stream Detector) unit",
-        "MetricExpr": "(LSD.CYCLES_ACTIVE - LSD.CYCLES_OK) / CORE_CLKS / 2=
",
-        "MetricGroup": "FetchBW;LSD;TopdownL3;tma_fetch_bandwidth_group",
-        "MetricName": "tma_lsd",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to LSD (Loop Stream Detector) unit. =
 LSD typically does well sustaining Uop supply. However; in some rare cases=
; optimal uop-delivery could not be reached for small loops whose size (in =
terms of number of uops) does not suit well the LSD structure.",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Number of cycles within a transaction divided=
 by the number of transactions.",
+        "MetricExpr": "cpu@cycles\\-t@ / cpu@tx\\-start@",
+        "MetricGroup": "transaction",
+        "MetricName": "tsx_cycles_per_transaction",
+        "ScaleUnit": "1cycles / transaction"
     },
     {
-        "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
-        "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_bound + t=
ma_retiring), 0)",
-        "MetricGroup": "TopdownL1;tma_L1_group",
-        "MetricName": "tma_bad_speculation",
-        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Percentage of cycles within a transaction reg=
ion.",
+        "MetricExpr": "cpu@cycles\\-t@ / cycles",
+        "MetricGroup": "transaction",
+        "MetricName": "tsx_transactional_cycles",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction",
-        "MetricExpr": "topdown\\-br\\-mispredict / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * SL=
OTS",
-        "MetricGroup": "BadSpec;BrMispredicts;TopdownL2;tma_L2_group;tma_b=
ad_speculation_group",
-        "MetricName": "tma_branch_mispredicts",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: TOPDOWN.BR_MISPREDICT_SLOTS",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to certain allocation restrictions.",
+        "MetricExpr": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS / tma_info_slot=
s",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricName": "tma_alloc_restriction",
+        "MetricThreshold": "tma_alloc_restriction > 0.1",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Machine Clears",
-        "MetricExpr": "max(0, tma_bad_speculation - tma_branch_mispredicts=
)",
-        "MetricGroup": "BadSpec;MachineClears;TopdownL2;tma_L2_group;tma_b=
ad_speculation_group",
-        "MetricName": "tma_machine_clears",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Machine Clears.  These slots are either wasted by uo=
ps fetched prior to the clear; or stalls the out-of-order portion of the ma=
chine needs to recover its state after the clear. For example; this can hap=
pen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modif=
ying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT",
+        "BriefDescription": "Counts the total number of issue slots  that =
were not consumed by the backend due to backend stalls",
+        "MetricExpr": "TOPDOWN_BE_BOUND.ALL / tma_info_slots",
+        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricName": "tma_backend_bound",
+        "MetricThreshold": "tma_backend_bound > 0.1",
+        "PublicDescription": "Counts the total number of issue slots  that=
 were not consumed by the backend due to backend stalls.  Note that uops mu=
st be available for consumption in order for this event to count.  If a uop=
 is not available (IQ is empty), this event will not count.   The rest of t=
hese subevents count backend stalls, in cycles, due to an outstanding reque=
st which is memory bound vs core bound.   The subevents are not slot based =
events and therefore can not be precisely added or subtracted from the Back=
end_Bound_Aux subevents which are slot based.",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
-        "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * SLOTS",
+        "BriefDescription": "Counts the total number of issue slots  that =
were not consumed by the backend due to backend stalls",
+        "MetricExpr": "tma_backend_bound",
         "MetricGroup": "TopdownL1;tma_L1_group",
-        "MetricName": "tma_backend_bound",
-        "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
+        "MetricName": "tma_backend_bound_aux",
+        "MetricThreshold": "tma_backend_bound_aux > 0.2",
+        "PublicDescription": "Counts the total number of issue slots  that=
 were not consumed by the backend due to backend stalls.  Note that UOPS mu=
st be available for consumption in order for this event to count.  If a uop=
 is not available (IQ is empty), this event will not count.  All of these s=
ubevents count backend stalls, in slots, due to a resource limitation.   Th=
ese are not cycle based events and therefore can not be precisely added or =
subtracted from the Backend_Bound subevents which are cycle based.  These s=
ubevents are supplementary to Backend_Bound and can be used to analyze resu=
lts from a resource perspective at allocation.",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
-        "MetricExpr": "topdown\\-mem\\-bound / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * SLOTS"=
,
-        "MetricGroup": "Backend;TopdownL2;tma_L2_group;tma_backend_bound_g=
roup",
-        "MetricName": "tma_memory_bound",
-        "PublicDescription": "This metric represents fraction of slots the=
 Memory subsystem within the Backend was a bottleneck.  Memory Bound estima=
tes fraction of slots where pipeline is likely stalled due to demand load o=
r store instructions. This accounts mainly for (1) non-completed in-flight =
memory demand loads which coincides with execution units starvation; in add=
ition to (2) cases where stores could impose backpressure on the pipeline w=
hen many of them get buffered at the same time (less common out of the two)=
.",
+        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a misp=
redicted jump or a machine clear",
+        "MetricExpr": "(tma_info_slots - (TOPDOWN_FE_BOUND.ALL + TOPDOWN_B=
E_BOUND.ALL + TOPDOWN_RETIRING.ALL)) / tma_info_slots",
+        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricName": "tma_bad_speculation",
+        "MetricThreshold": "tma_bad_speculation > 0.15",
+        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window including r=
elevant microcode flows and while uops are not yet available in the instruc=
tion queue (IQ). Also includes the issue slots that were consumed by the ba=
ckend but were thrown away because they were younger than the mispredict or=
 machine clear.",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache",
-        "MetricExpr": "max((EXE_ACTIVITY.BOUND_ON_LOADS - MEMORY_ACTIVITY.=
STALLS_L1D_MISS) / CLKS, 0)",
-        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_mem=
ory_bound_group",
-        "MetricName": "tma_l1_bound",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled without loads missing the L1 data cache.  The L1 data cache typical=
ly has the shortest latency.  However; in certain cases like loads blocked =
on older stores; a load might suffer due to high latency even though it is =
being satisfied by the L1. Another example is loads who miss in the TLB. Th=
ese cases are characterized by execution unit stalls; while some non-comple=
ted demand load lives in the machine without having that demand load missin=
g the L1 cache. Sample with: MEM_LOAD_RETIRED.L1_HIT_PS;MEM_LOAD_RETIRED.FB=
_HIT_PS",
+        "BriefDescription": "Counts the number of uops that are not from t=
he microsequencer.",
+        "MetricExpr": "(TOPDOWN_RETIRING.ALL - UOPS_RETIRED.MS) / tma_info=
_slots",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_retiring_group",
+        "MetricName": "tma_base",
+        "MetricThreshold": "tma_base > 0.6",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
-        "MetricExpr": "min(7 * cpu_core@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\=
\=3D1@ + DTLB_LOAD_MISSES.WALK_ACTIVE, max(CYCLE_ACTIVITY.CYCLES_MEM_ANY - =
MEMORY_ACTIVITY.CYCLES_L1D_MISS, 0)) / CLKS",
-        "MetricGroup": "MemoryTLB;TopdownL4;tma_l1_bound_group",
-        "MetricName": "tma_dtlb_load",
-        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS_PS",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to BACLEARS, which occurs when the Branch =
Target Buffer (BTB) prediction or lack thereof, was corrected by a later br=
anch predictor in the frontend",
+        "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_DETECT / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_frontend_latency_group"=
,
+        "MetricName": "tma_branch_detect",
+        "MetricThreshold": "tma_branch_detect > 0.05",
+        "PublicDescription": "Counts the number of issue slots  that were =
not delivered by the frontend due to BACLEARS, which occurs when the Branch=
 Target Buffer (BTB) prediction or lack thereof, was corrected by a later b=
ranch predictor in the frontend. Includes BACLEARS due to all branch types =
including conditional and unconditional jumps, returns, and indirect branch=
es.",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the (first level) DTLB was missed by load accesses, that late=
r on hit in second-level TLB (STLB)",
-        "MetricExpr": "tma_dtlb_load - tma_load_stlb_miss",
-        "MetricGroup": "MemoryTLB;TopdownL5;tma_dtlb_load_group",
-        "MetricName": "tma_load_stlb_hit",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to branch mispredicts.",
+        "MetricExpr": "TOPDOWN_BAD_SPECULATION.MISPREDICT / tma_info_slots=
",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
+        "MetricName": "tma_branch_mispredicts",
+        "MetricThreshold": "tma_branch_mispredicts > 0.05",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
where the Second-level TLB (STLB) was missed by load accesses, performing a=
 hardware page walk",
-        "MetricExpr": "DTLB_LOAD_MISSES.WALK_ACTIVE / CLKS",
-        "MetricGroup": "MemoryTLB;TopdownL5;tma_dtlb_load_group",
-        "MetricName": "tma_load_stlb_miss",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to BTCLEARS, which occurs when the Branch =
Target Buffer (BTB) predicts a taken branch.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_RESTEER / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_frontend_latency_group"=
,
+        "MetricName": "tma_branch_resteer",
+        "MetricThreshold": "tma_branch_resteer > 0.05",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric roughly estimates fraction of cyc=
les when the memory subsystem had loads blocked since they could not forwar=
d data from earlier (in program order) overlapping stores",
-        "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / CLKS",
-        "MetricGroup": "TopdownL4;tma_l1_bound_group",
-        "MetricName": "tma_store_fwd_blk",
-        "PublicDescription": "This metric roughly estimates fraction of cy=
cles when the memory subsystem had loads blocked since they could not forwa=
rd data from earlier (in program order) overlapping stores. To streamline m=
emory operations in the pipeline; a load can avoid waiting for memory if a =
prior in-flight store is writing the data that the load wants to read (stor=
e forwarding process). However; in some cases the load may be blocked for a=
 significant time pending the store forward. For example; when the prior st=
ore is writing a smaller region than the load is reading.",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to the microcode sequencer (MS).",
+        "MetricExpr": "TOPDOWN_FE_BOUND.CISC / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_frontend_bandwidth_grou=
p",
+        "MetricName": "tma_cisc",
+        "MetricThreshold": "tma_cisc > 0.05",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
-        "MetricExpr": "(16 * max(0, MEM_INST_RETIRED.LOCK_LOADS - L2_RQSTS=
.ALL_RFO) + MEM_INST_RETIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES * (10=
 * L2_RQSTS.RFO_HIT + min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTAN=
DING.CYCLES_WITH_DEMAND_RFO))) / CLKS",
-        "MetricGroup": "Offcore;TopdownL4;tma_l1_bound_group",
-        "MetricName": "tma_lock_latency",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them. Sample with: MEM_INST_RETIRED.LOCK_LOA=
DS_PS",
+        "BriefDescription": "Counts the number of cycles due to backend bo=
und stalls that are core execution bound and not attributed to outstanding =
demand load or store stalls.",
+        "MetricExpr": "max(0, tma_backend_bound - tma_load_store_bound)",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
+        "MetricName": "tma_core_bound",
+        "MetricThreshold": "tma_core_bound > 0.1",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles hand=
ling memory load split accesses - load that cross 64-byte cache line bounda=
ry",
-        "MetricExpr": "Load_Miss_Real_Latency * LD_BLOCKS.NO_SR / CLKS",
-        "MetricGroup": "TopdownL4;tma_l1_bound_group",
-        "MetricName": "tma_split_loads",
-        "PublicDescription": "This metric estimates fraction of cycles han=
dling memory load split accesses - load that cross 64-byte cache line bound=
ary.  Sample with: MEM_INST_RETIRED.SPLIT_LOADS_PS",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to decode stalls.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.DECODE / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_frontend_bandwidth_grou=
p",
+        "MetricName": "tma_decode",
+        "MetricThreshold": "tma_decode > 0.05",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
-        "MetricExpr": "L1D_PEND_MISS.FB_FULL / CLKS",
-        "MetricGroup": "MemoryBW;TopdownL4;tma_l1_bound_group",
-        "MetricName": "tma_fb_full",
-        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory).",
+        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to memory disambiguation.",
+        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.DISAMBIGUATION / MACHINE=
_CLEARS.SLOW)",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
+        "MetricName": "tma_disambiguation",
+        "MetricThreshold": "tma_disambiguation > 0.02",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads",
-        "MetricExpr": "(MEMORY_ACTIVITY.STALLS_L1D_MISS - MEMORY_ACTIVITY.=
STALLS_L2_MISS) / CLKS",
-        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_mem=
ory_bound_group",
-        "MetricName": "tma_l2_bound",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_RETIRED.L2_HIT_PS",
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load miss which hit in DRAM or MMIO (Non-DRAM).",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "MEM_BOUND_STALLS.LOAD_DRAM_HIT / tma_info_clks - ME=
M_BOUND_STALLS_AT_RET_CORRECTION * MEM_BOUND_STALLS.LOAD_DRAM_HIT / MEM_BOU=
ND_STALLS.LOAD",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_load_store_bound_group"=
,
+        "MetricName": "tma_dram_bound",
+        "MetricThreshold": "tma_dram_bound > 0.1",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
-        "MetricExpr": "(MEMORY_ACTIVITY.STALLS_L2_MISS - MEMORY_ACTIVITY.S=
TALLS_L3_MISS) / CLKS",
-        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_mem=
ory_bound_group",
-        "MetricName": "tma_l3_bound",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to a machine clear classified as a fast nuke=
 due to memory ordering, memory disambiguation and memory renaming.",
+        "MetricExpr": "TOPDOWN_BAD_SPECULATION.FASTNUKE / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
+        "MetricName": "tma_fast_nuke",
+        "MetricThreshold": "tma_fast_nuke > 0.05",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
-        "MetricExpr": "(25 * Average_Frequency * (MEM_LOAD_L3_HIT_RETIRED.=
XSNP_FWD * (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM / (OCR.DEMAND_DATA_RD.L3_H=
IT.SNOOP_HITM + OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) + 24 * Aver=
age_Frequency * MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS) * (1 + MEM_LOAD_RETIRED.=
FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / CLKS",
-        "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_l3_bound_g=
roup",
-        "MetricName": "tma_contested_accesses",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_FWD;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS",
+        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to FP assists.",
+        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.FP_ASSIST / MACHINE_CLEA=
RS.SLOW)",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
+        "MetricName": "tma_fp_assist",
+        "MetricThreshold": "tma_fp_assist > 0.02",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
-        "MetricExpr": "24 * Average_Frequency * (MEM_LOAD_L3_HIT_RETIRED.X=
SNP_NO_FWD + MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD * (1 - OCR.DEMAND_DATA_RD.L3_=
HIT.SNOOP_HITM / (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM + OCR.DEMAND_DATA_RD=
.L3_HIT.SNOOP_HIT_WITH_FWD))) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RET=
IRED.L1_MISS / 2) / CLKS",
-        "MetricGroup": "Offcore;Snoop;TopdownL4;tma_l3_bound_group",
-        "MetricName": "tma_data_sharing",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_L3_HIT_RETIRED.XSNP_NO_FWD",
+        "BriefDescription": "Counts the number of floating point operation=
s per uop with all default weighting.",
+        "MetricExpr": "UOPS_RETIRED.FPDIV / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_base_group",
+        "MetricName": "tma_fp_uops",
+        "MetricThreshold": "tma_fp_uops > 0.2",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited)",
-        "MetricExpr": "9 * Average_Frequency * MEM_LOAD_RETIRED.L3_HIT * (=
1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / CLKS",
-        "MetricGroup": "MemoryLat;TopdownL4;tma_l3_bound_group",
-        "MetricName": "tma_l3_hit_latency",
-        "PublicDescription": "This metric represents fraction of cycles wi=
th demand load accesses that hit the L3 cache under unloaded scenarios (pos=
sibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L=
3 hits) will improve the latency; reduce contention with sibling physical c=
ores and increase performance.  Note the value of this node may overlap wit=
h its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to frontend bandwidth restrictions due to =
decode, predecode, cisc, and other limitations.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH / tma_info_slot=
s",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
+        "MetricName": "tma_frontend_bandwidth",
+        "MetricThreshold": "tma_frontend_bandwidth > 0.1",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric measures fraction of cycles where=
 the Super Queue (SQ) was full taking into account all request-types and bo=
th hardware SMT threads (Logical Processors)",
-        "MetricExpr": "(XQ.FULL_CYCLES + L1D_PEND_MISS.L2_STALLS) / CLKS",
-        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_l3_bound_group",
-        "MetricName": "tma_sq_full",
-        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). The Super Queue is used for =
requests to access the L2 cache or to go out to the Uncore.",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to frontend stalls.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.ALL / tma_info_slots",
+        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricName": "tma_frontend_bound",
+        "MetricThreshold": "tma_frontend_bound > 0.2",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
-        "MetricExpr": "MEMORY_ACTIVITY.STALLS_L3_MISS / CLKS",
-        "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_memory_bound_gr=
oup",
-        "MetricName": "tma_dram_bound",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_RETIRED=
.L3_MISS_PS",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to frontend bandwidth restrictions due to =
decode, predecode, cisc, and other limitations.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY / tma_info_slots"=
,
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
+        "MetricName": "tma_frontend_latency",
+        "MetricThreshold": "tma_frontend_latency > 0.15",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory (DRAM)",
-        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu_core@OFFCORE_REQUE=
STS_OUTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / CLKS",
-        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_dram_bound_group",
-        "MetricName": "tma_mem_bandwidth",
-        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory (DRAM).  The underlying heuristic assumes that a simi=
lar off-core traffic is generated by all IA cores. This metric does not agg=
regate non-data-read requests by this logical processor; requests from othe=
r IA Logical Processors/Physical Cores/sockets; or other non-IA devices lik=
e GPU; hence the maximum external memory bandwidth limits may or may not be=
 approached when this metric is flagged (see Uncore counters for that).",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to instruction cache misses.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.ICACHE / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_frontend_latency_group"=
,
+        "MetricName": "tma_icache",
+        "MetricThreshold": "tma_icache > 0.05",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles wher=
e the performance was likely hurt due to latency from external memory (DRAM=
)",
-        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DATA_RD) / CLKS - tma_mem_bandwidth",
-        "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_dram_bound_group",
-        "MetricName": "tma_mem_latency",
-        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory (DRA=
M).  This metric does not aggregate requests from other Logical Processors/=
Physical Cores/sockets (see Uncore counters for that).",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Percentage of total non-speculative loads wit=
h a address aliasing block",
+        "MetricExpr": "100 * LD_BLOCKS.4K_ALIAS / MEM_UOPS_RETIRED.ALL_LOA=
DS",
+        "MetricName": "tma_info_address_alias_blocks",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to RFO store memory accesses; RFO store issue a read-for-ownership =
request before the write",
-        "MetricExpr": "tma_st_buffer",
-        "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_memory_bound_gr=
oup",
-        "MetricName": "tma_store_bound",
-        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to RFO store memory accesses; RFO store issue a read-for-ownership=
 request before the write. Even though store accesses do not typically stal=
l out-of-order CPUs; there are few cases where stores can lead to actual st=
alls. This metric will be flagged should RFO stores be a bottleneck. Sample=
 with: MEM_INST_RETIRED.ALL_STORES_PS",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Ratio of all branches which mispredict",
+        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.ALL_=
BRANCHES",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_branch_mispredict_ratio",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
-        "MetricExpr": "(MEM_STORE_RETIRED.L2_HIT * 10 * (1 - MEM_INST_RETI=
RED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES) + (1 - MEM_INST_RETIRED.LOCK_=
LOADS / MEM_INST_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE=
_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / CLKS",
-        "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_store_bound_group"=
,
-        "MetricName": "tma_store_latency",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full)",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Ratio between Mispredicted branches and unkno=
wn branches",
+        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / BACLEARS.ANY",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_branch_mispredict_to_unknown_branch_ratio"=
,
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
-        "MetricExpr": "28 * Average_Frequency * OCR.DEMAND_RFO.L3_HIT.SNOO=
P_HITM / CLKS",
-        "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_store_boun=
d_group",
-        "MetricName": "tma_false_sharing",
-        "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line.  Sample with: OCR.DEMAND_RFO.=
L3_HIT.SNOOP_HITM",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "",
+        "MetricExpr": "CPU_CLK_UNHALTED.CORE",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_clks",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents rate of split store ac=
cesses",
-        "MetricExpr": "MEM_INST_RETIRED.SPLIT_STORES / CORE_CLKS",
-        "MetricGroup": "TopdownL4;tma_store_bound_group",
-        "MetricName": "tma_split_stores",
-        "PublicDescription": "This metric represents rate of split store a=
ccesses.  Consider aligning your data to the 64-byte cache line granularity=
. Sample with: MEM_INST_RETIRED.SPLIT_STORES_PS",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "",
+        "MetricExpr": "CPU_CLK_UNHALTED.CORE_P",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_clks_p",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to Streaming store memory accesses; Streaming store optimize out a =
read request required by RFO stores",
-        "MetricExpr": "9 * OCR.STREAMING_WR.ANY_RESPONSE / CLKS",
-        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_store_bound_group",
-        "MetricName": "tma_streaming_stores",
-        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to Streaming store memory accesses; Streaming store optimize out a=
 read request required by RFO stores. Even though store accesses do not typ=
ically stall out-of-order CPUs; there are few cases where stores can lead t=
o actual stalls. This metric will be flagged should Streaming stores be a b=
ottleneck. Sample with: OCR.STREAMING_WR.ANY_RESPONSE",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Cycles Per Instruction",
+        "MetricExpr": "tma_info_clks / INST_RETIRED.ANY",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_cpi",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
-        "MetricExpr": "(7 * cpu_core@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=
=3D1@ + DTLB_STORE_MISSES.WALK_ACTIVE) / CORE_CLKS",
-        "MetricGroup": "MemoryTLB;TopdownL4;tma_store_bound_group",
-        "MetricName": "tma_dtlb_store",
-        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES_PS",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_cpu_utilization",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the TLB was missed by store accesses, hitting in the second-l=
evel TLB (STLB)",
-        "MetricExpr": "tma_dtlb_store - tma_store_stlb_miss",
-        "MetricGroup": "MemoryTLB;TopdownL5;tma_dtlb_store_group",
-        "MetricName": "tma_store_stlb_hit",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Cycle cost per DRAM hit",
+        "MetricExpr": "MEM_BOUND_STALLS.LOAD_DRAM_HIT / MEM_LOAD_UOPS_RETI=
RED.DRAM_HIT",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_cycles_per_demand_load_dram_hit",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
where the STLB was missed by store accesses, performing a hardware page wal=
k",
-        "MetricExpr": "DTLB_STORE_MISSES.WALK_ACTIVE / CORE_CLKS",
-        "MetricGroup": "MemoryTLB;TopdownL5;tma_dtlb_store_group",
-        "MetricName": "tma_store_stlb_miss",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Cycle cost per L2 hit",
+        "MetricExpr": "MEM_BOUND_STALLS.LOAD_L2_HIT / MEM_LOAD_UOPS_RETIRE=
D.L2_HIT",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_cycles_per_demand_load_l2_hit",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e Core non-memory issues were of a bottleneck",
-        "MetricExpr": "max(0, tma_backend_bound - tma_memory_bound)",
-        "MetricGroup": "Backend;Compute;TopdownL2;tma_L2_group;tma_backend=
_bound_group",
-        "MetricName": "tma_core_bound",
-        "PublicDescription": "This metric represents fraction of slots whe=
re Core non-memory issues were of a bottleneck.  Shortage in hardware compu=
te resources; or dependencies in software's instructions are both categoriz=
ed under Core Bound. Hence it may indicate the machine ran out of an out-of=
-order resource; certain execution units are overloaded or dependencies in =
program's data- or instruction-flow are limiting the performance (e.g. FP-c=
hained long-latency arithmetic operations).",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Cycle cost per LLC hit",
+        "MetricExpr": "MEM_BOUND_STALLS.LOAD_LLC_HIT / MEM_LOAD_UOPS_RETIR=
ED.L3_HIT",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_cycles_per_demand_load_l3_hit",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles whe=
re the Divider unit was active",
-        "MetricExpr": "ARITH.DIVIDER_ACTIVE / CLKS",
-        "MetricGroup": "TopdownL3;tma_core_bound_group",
-        "MetricName": "tma_divider",
-        "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIVIDER_ACTIVE",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Percentage of all uops which are FPDiv uops",
+        "MetricExpr": "100 * UOPS_RETIRED.FPDIV / UOPS_RETIRED.ALL",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_fpdiv_uop_ratio",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
-        "MetricExpr": "((cpu_core@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x=
80@ + (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * cpu_core@EXE_ACTIVITY.2_P=
ORTS_UTIL\\,umask\\=3D0xc@)) / CLKS if ARITH.DIVIDER_ACTIVE < CYCLE_ACTIVIT=
Y.STALLS_TOTAL - EXE_ACTIVITY.BOUND_ON_LOADS else (EXE_ACTIVITY.1_PORTS_UTI=
L + tma_retiring * cpu_core@EXE_ACTIVITY.2_PORTS_UTIL\\,umask\\=3D0xc@) / C=
LKS)",
-        "MetricGroup": "PortsUtil;TopdownL3;tma_core_bound_group",
-        "MetricName": "tma_ports_utilization",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations.",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Percentage of all uops which are IDiv uops",
+        "MetricExpr": "100 * UOPS_RETIRED.IDIV / UOPS_RETIRED.ALL",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_idiv_uop_ratio",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
-        "MetricExpr": "cpu_core@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x80=
@ / CLKS + tma_serializing_operation * (CYCLE_ACTIVITY.STALLS_TOTAL - EXE_A=
CTIVITY.BOUND_ON_LOADS) / CLKS",
-        "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
-        "MetricName": "tma_ports_utilized_0",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U executed no uops on any execution port (Logical Processor cycles since IC=
L, Physical Core cycles otherwise). Long-latency instructions like divides =
may contribute to this metric.",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Percent of instruction miss cost that hit in =
DRAM",
+        "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_DRAM_HIT / MEM_BOUND_=
STALLS.IFETCH",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_inst_miss_cost_dramhit_percent",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU issue-pipeline was stalled due to serializing operations",
-        "MetricExpr": "RESOURCE_STALLS.SCOREBOARD / CLKS",
-        "MetricGroup": "TopdownL5;tma_ports_utilized_0_group",
-        "MetricName": "tma_serializing_operation",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU issue-pipeline was stalled due to serializing operations. Instruction=
s like CPUID; WRMSR or LFENCE serialize the out-of-order execution which ma=
y limit performance. Sample with: RESOURCE_STALLS.SCOREBOARD",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Percent of instruction miss cost that hit in =
the L2",
+        "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_L2_HIT / MEM_BOUND_ST=
ALLS.IFETCH",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_inst_miss_cost_l2hit_percent",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to PAUSE Instructions",
-        "MetricExpr": "CPU_CLK_UNHALTED.PAUSE / CLKS",
-        "MetricGroup": "TopdownL6;tma_serializing_operation_group",
-        "MetricName": "tma_slow_pause",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to PAUSE Instructions. Sample with: CPU_CLK_UNHALTED.=
PAUSE_INST",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Percent of instruction miss cost that hit in =
the L3",
+        "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_LLC_HIT / MEM_BOUND_S=
TALLS.IFETCH",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_inst_miss_cost_l3hit_percent",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to LFENCE Instructions.",
-        "MetricExpr": "13 * MISC2_RETIRED.LFENCE / CLKS",
-        "MetricGroup": "TopdownL6;tma_serializing_operation_group",
-        "MetricName": "tma_memory_fence",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurance rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_ipbranch",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "The Mixing_Vectors metric gives the percentag=
e of injected blend uops out of all uops issued",
-        "MetricExpr": "160 * ASSISTS.SSE_AVX_MIX / CLKS",
-        "MetricGroup": "TopdownL5;tma_ports_utilized_0_group",
-        "MetricName": "tma_mixing_vectors",
-        "PublicDescription": "The Mixing_Vectors metric gives the percenta=
ge of injected blend uops out of all uops issued. Usually a Mixing_Vectors =
over 5% is worth investigating. Read more in Appendix B1 of the Optimizatio=
ns Guide for this topic.",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Instructions Per Cycle",
+        "MetricExpr": "INST_RETIRED.ANY / tma_info_clks",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_ipc",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles whe=
re the CPU executed total of 1 uop per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "EXE_ACTIVITY.1_PORTS_UTIL / CLKS",
-        "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
-        "MetricName": "tma_ports_utilized_1",
-        "PublicDescription": "This metric represents fraction of cycles wh=
ere the CPU executed total of 1 uop per cycle on all execution ports (Logic=
al Processor cycles since ICL, Physical Core cycles otherwise). This can be=
 due to heavy data-dependency among software instructions; or over oversubs=
cribing a particular hardware resource. In some other cases with high 1_Por=
t_Utilized and L1_Bound; this metric can point to L1 data-cache latency bot=
tleneck that may not necessarily manifest with complete execution starvatio=
n (due to the short L1 latency e.g. walking a linked list) - looking at the=
 assembly can be helpful. Sample with: EXE_ACTIVITY.1_PORTS_UTIL",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Instruction per (near) call (lower number mea=
ns higher occurance rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.CALL",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_ipcall",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 2 uops per cycle on all execution ports (Logical Process=
or cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "EXE_ACTIVITY.2_PORTS_UTIL / CLKS",
-        "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
-        "MetricName": "tma_ports_utilized_2",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop. S=
ample with: EXE_ACTIVITY.2_PORTS_UTIL",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Instructions per Far Branch",
+        "MetricExpr": "INST_RETIRED.ANY / (BR_INST_RETIRED.FAR_BRANCH / 2)=
",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_ipfarbranch",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "UOPS_EXECUTED.CYCLES_GE_3 / CLKS",
-        "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
-        "MetricName": "tma_ports_utilized_3m",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 3 or more uops per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise). Sample with:=
 UOPS_EXECUTED.CYCLES_GE_3",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Instructions per Load",
+        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_LOADS",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_ipload",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
-        "MetricExpr": "(UOPS_DISPATCHED.PORT_0 + UOPS_DISPATCHED.PORT_1 + =
UOPS_DISPATCHED.PORT_5_11 + UOPS_DISPATCHED.PORT_6) / (5 * CORE_CLKS)",
-        "MetricGroup": "TopdownL5;tma_ports_utilized_3m_group",
-        "MetricName": "tma_alu_op_utilization",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_ipmispredict",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd b=
ranch) Sample with: UOPS_DISPATCHED.PORT_0",
-        "MetricExpr": "UOPS_DISPATCHED.PORT_0 / CORE_CLKS",
-        "MetricGroup": "Compute;TopdownL6;tma_alu_op_utilization_group",
-        "MetricName": "tma_port_0",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Instructions per Store",
+        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_STORES",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_ipstore",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 1 (ALU) Sample with: UOPS_DISPATCHE=
D.PORT_1",
-        "MetricExpr": "UOPS_DISPATCHED.PORT_1 / CORE_CLKS",
-        "MetricGroup": "TopdownL6;tma_alu_op_utilization_group",
-        "MetricName": "tma_port_1",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Fraction of cycles spent in Kernel mode",
+        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE@k / CPU_CLK_UNHALTED=
.CORE",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_kernel_utilization",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 6 ([HSW+]Primary Branch and simple =
ALU) Sample with: UOPS_DISPATCHED.PORT_6",
-        "MetricExpr": "UOPS_DISPATCHED.PORT_6 / CORE_CLKS",
-        "MetricGroup": "TopdownL6;tma_alu_op_utilization_group",
-        "MetricName": "tma_port_6",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Percentage of total non-speculative loads tha=
t are splits",
+        "MetricExpr": "100 * MEM_UOPS_RETIRED.SPLIT_LOADS / MEM_UOPS_RETIR=
ED.ALL_LOADS",
+        "MetricName": "tma_info_load_splits",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Load operations Sample with: UO=
PS_DISPATCHED.PORT_2_3_10",
-        "MetricExpr": "UOPS_DISPATCHED.PORT_2_3_10 / (3 * CORE_CLKS)",
-        "MetricGroup": "TopdownL5;tma_ports_utilized_3m_group",
-        "MetricName": "tma_load_op_utilization",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "load ops retired per 1000 instruction",
+        "MetricExpr": "1e3 * MEM_UOPS_RETIRED.ALL_LOADS / INST_RETIRED.ANY=
",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_memloadpki",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Store operations Sample with: U=
OPS_DISPATCHED.PORT_7_8",
-        "MetricExpr": "(UOPS_DISPATCHED.PORT_4_9 + UOPS_DISPATCHED.PORT_7_=
8) / (4 * CORE_CLKS)",
-        "MetricGroup": "TopdownL5;tma_ports_utilized_3m_group",
-        "MetricName": "tma_store_op_utilization",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Percentage of all uops which are ucode ops",
+        "MetricExpr": "100 * UOPS_RETIRED.MS / UOPS_RETIRED.ALL",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_microcode_uop_ratio",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
-        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * SLOTS",
-        "MetricGroup": "TopdownL1;tma_L1_group",
-        "MetricName": "tma_retiring",
-        "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided.  Sample with: UOPS_RETIRE=
D.SLOTS",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "",
+        "MetricExpr": "5 * tma_info_clks",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_slots",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations -- instructions that require=
 no more than one uop (micro-operation)",
-        "MetricExpr": "max(0, tma_retiring - tma_heavy_operations)",
-        "MetricGroup": "Retire;TopdownL2;tma_L2_group;tma_retiring_group",
-        "MetricName": "tma_light_operations",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring light-weight operations -- instructions that requir=
e no more than one uop (micro-operation). This correlates with total number=
 of instructions used by the program. A uops-per-instruction (see UPI metri=
c) ratio of 1 or less should be expected for decently optimized software ru=
nning on Intel Core/Xeon products. While this often indicates efficient X86=
 instructions were executed; high value does not necessarily mean better pe=
rformance cannot be achieved. Sample with: INST_RETIRED.PREC_DIST",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Percentage of total non-speculative loads wit=
h a store forward or unknown store address block",
+        "MetricExpr": "100 * LD_BLOCKS.DATA_UNKNOWN / MEM_UOPS_RETIRED.ALL=
_LOADS",
+        "MetricName": "tma_info_store_fwd_blocks",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents overall arithmetic flo=
ating-point (FP) operations fraction the CPU has executed (retired)",
-        "MetricExpr": "tma_x87_use + tma_fp_scalar + tma_fp_vector",
-        "MetricGroup": "HPC;TopdownL3;tma_light_operations_group",
-        "MetricName": "tma_fp_arith",
-        "PublicDescription": "This metric represents overall arithmetic fl=
oating-point (FP) operations fraction the CPU has executed (retired). Note =
this metric's value may exceed its parent due to use of \"Uops\" CountDomai=
n and FMA double-counting.",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
+        "MetricExpr": "tma_info_clks / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_turbo_utilization",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric serves as an approximation of leg=
acy x87 usage",
-        "MetricExpr": "tma_retiring * UOPS_EXECUTED.X87 / UOPS_EXECUTED.TH=
READ",
-        "MetricGroup": "Compute;TopdownL4;tma_fp_arith_group",
-        "MetricName": "tma_x87_use",
-        "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint.",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Uops Per Instruction",
+        "MetricExpr": "UOPS_RETIRED.ALL / INST_RETIRED.ANY",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_upi",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) scalar uops fraction the CPU has retired",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE) / (tma_retiring * SLOTS)",
-        "MetricGroup": "Compute;Flops;TopdownL4;tma_fp_arith_group",
-        "MetricName": "tma_fp_scalar",
-        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting.",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "BriefDescription": "Percentage of all uops which are x87 uops",
+        "MetricExpr": "100 * UOPS_RETIRED.X87 / UOPS_RETIRED.ALL",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_x87_uop_ratio",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) vector uops fraction the CPU has retired aggregated across all v=
ector widths",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBL=
E + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) / (tma_retiring * SLOTS)",
-        "MetricGroup": "Compute;Flops;TopdownL4;tma_fp_arith_group",
-        "MetricName": "tma_fp_vector",
-        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting.",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to Instruction Table Lookaside Buffer (ITL=
B) misses.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.ITLB / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_frontend_latency_group"=
,
+        "MetricName": "tma_itlb",
+        "MetricThreshold": "tma_itlb > 0.05",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 128-bit wide vectors",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.128B_PACKED_SINGLE) / (tma_retiring * SLOTS)",
-        "MetricGroup": "Compute;Flops;TopdownL5;tma_fp_vector_group",
-        "MetricName": "tma_fp_vector_128b",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting.",
+        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a load block.",
+        "MetricExpr": "LD_HEAD.L1_BOUND_AT_RET / tma_info_clks",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_load_store_bound_group"=
,
+        "MetricName": "tma_l1_bound",
+        "MetricThreshold": "tma_l1_bound > 0.1",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 256-bit wide vectors",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.256B_PACKED_SINGLE) / (tma_retiring * SLOTS)",
-        "MetricGroup": "Compute;Flops;TopdownL5;tma_fp_vector_group",
-        "MetricName": "tma_fp_vector_256b",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting.",
+        "BriefDescription": "Counts the number of cycles a core is stalled=
 due to a demand load which hit in the L2 Cache.",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "MEM_BOUND_STALLS.LOAD_L2_HIT / tma_info_clks - MEM_=
BOUND_STALLS_AT_RET_CORRECTION * MEM_BOUND_STALLS.LOAD_L2_HIT / MEM_BOUND_S=
TALLS.LOAD",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_load_store_bound_group"=
,
+        "MetricName": "tma_l2_bound",
+        "MetricThreshold": "tma_l2_bound > 0.1",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents overall Integer (Int) =
select operations fraction the CPU has executed (retired)",
-        "MetricExpr": "tma_int_vector_128b + tma_int_vector_256b + tma_shu=
ffles",
-        "MetricGroup": "Pipeline;TopdownL3;tma_light_operations_group",
-        "MetricName": "tma_int_operations",
-        "PublicDescription": "This metric represents overall Integer (Int)=
 select operations fraction the CPU has executed (retired). Vector/Matrix I=
nt operations and shuffles are counted. Note this metric's value may exceed=
 its parent due to use of \"Uops\" CountDomain.",
+        "BriefDescription": "Counts the number of cycles a core is stalled=
 due to a demand load which hit in the Last Level Cache (LLC) or other core=
 with HITE/F/M.",
+        "MetricExpr": "MEM_BOUND_STALLS.LOAD_LLC_HIT / tma_info_clks - MEM=
_BOUND_STALLS_AT_RET_CORRECTION * MEM_BOUND_STALLS.LOAD_LLC_HIT / MEM_BOUND=
_STALLS.LOAD",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_load_store_bound_group"=
,
+        "MetricName": "tma_l3_bound",
+        "MetricThreshold": "tma_l3_bound > 0.1",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents 128-bit vector Integer=
 ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction the=
 CPU has retired.",
-        "MetricExpr": "(INT_VEC_RETIRED.ADD_128 + INT_VEC_RETIRED.VNNI_128=
) / (tma_retiring * SLOTS)",
-        "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_int_opera=
tions_group",
-        "MetricName": "tma_int_vector_128b",
+        "BriefDescription": "Counts the number of cycles, relative to the =
number of mem_scheduler slots, in which uops are blocked due to load buffer=
 full",
+        "MetricExpr": "tma_mem_scheduler * MEM_SCHEDULER_BLOCK.LD_BUF / ME=
M_SCHEDULER_BLOCK.ALL",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_mem_scheduler_group",
+        "MetricName": "tma_ld_buffer",
+        "MetricThreshold": "tma_ld_buffer > 0.05",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents 256-bit vector Integer=
 ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction the=
 CPU has retired.",
-        "MetricExpr": "(INT_VEC_RETIRED.ADD_256 + INT_VEC_RETIRED.MUL_256 =
+ INT_VEC_RETIRED.VNNI_256) / (tma_retiring * SLOTS)",
-        "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_int_opera=
tions_group",
-        "MetricName": "tma_int_vector_256b",
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to stores or loads.",
+        "MetricExpr": "min(tma_backend_bound, LD_HEAD.ANY_AT_RET / tma_inf=
o_clks + tma_store_bound)",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
+        "MetricName": "tma_load_store_bound",
+        "MetricThreshold": "tma_load_store_bound > 0.2",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents Shuffle (cross \"vecto=
r lane\" data transfers) uops fraction the CPU has retired.",
-        "MetricExpr": "INT_VEC_RETIRED.SHUFFLES / (tma_retiring * SLOTS)",
-        "MetricGroup": "HPC;Pipeline;TopdownL4;tma_int_operations_group",
-        "MetricName": "tma_shuffles",
+        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a mach=
ine clear (nuke) of any kind including memory ordering and memory disambigu=
ation.",
+        "MetricExpr": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS / tma_info_s=
lots",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
+        "MetricName": "tma_machine_clears",
+        "MetricThreshold": "tma_machine_clears > 0.05",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations -- uops for memory load or store a=
ccesses.",
-        "MetricExpr": "tma_light_operations * MEM_UOP_RETIRED.ANY / (tma_r=
etiring * SLOTS)",
-        "MetricGroup": "Pipeline;TopdownL3;tma_light_operations_group",
-        "MetricName": "tma_memory_operations",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to memory reservation stalls in which a sche=
duler is not able to accept uops.",
+        "MetricExpr": "TOPDOWN_BE_BOUND.MEM_SCHEDULER / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricName": "tma_mem_scheduler",
+        "MetricThreshold": "tma_mem_scheduler > 0.1",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions -- where one uop can represent mu=
ltiple contiguous instructions",
-        "MetricExpr": "tma_light_operations * INST_RETIRED.MACRO_FUSED / (=
tma_retiring * SLOTS)",
-        "MetricGroup": "Pipeline;TopdownL3;tma_light_operations_group",
-        "MetricName": "tma_fused_instructions",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring fused instructions -- where one uop can represent m=
ultiple contiguous instructions. The instruction pairs of CMP+JCC or DEC+JC=
C are commonly used examples.",
+        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to memory ordering.",
+        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.MEMORY_ORDERING / MACHIN=
E_CLEARS.SLOW)",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
+        "MetricName": "tma_memory_ordering",
+        "MetricThreshold": "tma_memory_ordering > 0.02",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring branch instructions that were not fused",
-        "MetricExpr": "tma_light_operations * (BR_INST_RETIRED.ALL_BRANCHE=
S - INST_RETIRED.MACRO_FUSED) / (tma_retiring * SLOTS)",
-        "MetricGroup": "Pipeline;TopdownL3;tma_light_operations_group",
-        "MetricName": "tma_non_fused_branches",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring branch instructions that were not fused. Non-condit=
ional branches like direct JMP or CALL would count here. Can be used to exa=
mine fusible conditional jumps that were not fused.",
+        "BriefDescription": "Counts the number of uops that are from the c=
omplex flows issued by the micro-sequencer (MS)",
+        "MetricExpr": "tma_microcode_sequencer",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_retiring_group",
+        "MetricName": "tma_ms_uops",
+        "MetricThreshold": "tma_ms_uops > 0.05",
+        "PublicDescription": "Counts the number of uops that are from the =
complex flows issued by the micro-sequencer (MS).  This includes uops from =
flows due to complex instructions, faults, assists, and inserted flows.",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring NOP (no op) instructions",
-        "MetricExpr": "tma_light_operations * INST_RETIRED.NOP / (tma_reti=
ring * SLOTS)",
-        "MetricGroup": "Pipeline;TopdownL3;tma_light_operations_group",
-        "MetricName": "tma_nop_instructions",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring NOP (no op) instructions. Compilers often use NOPs =
for certain address alignments - e.g. start address of a function or loop b=
ody. Sample with: INST_RETIRED.NOP",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to IEC or FPC RAT stalls, which can be due t=
o FIQ or IEC reservation stalls in which the integer, floating point or SIM=
D scheduler is not able to accept uops.",
+        "MetricExpr": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER / tma_info_slots=
",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricName": "tma_non_mem_scheduler",
+        "MetricThreshold": "tma_non_mem_scheduler > 0.1",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents the remaining light uo=
ps fraction the CPU has executed - remaining means not covered by other sib=
ling nodes. May undercount due to FMA double counting",
-        "MetricExpr": "max(0, tma_light_operations - (tma_fp_arith + tma_i=
nt_operations + tma_memory_operations + tma_fused_instructions + tma_non_fu=
sed_branches + tma_nop_instructions))",
-        "MetricGroup": "Pipeline;TopdownL3;tma_light_operations_group",
-        "MetricName": "tma_other_light_ops",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to a machine clear (slow nuke).",
+        "MetricExpr": "TOPDOWN_BAD_SPECULATION.NUKE / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
+        "MetricName": "tma_nuke",
+        "MetricThreshold": "tma_nuke > 0.05",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or microcoded sequences",
-        "MetricExpr": "topdown\\-heavy\\-ops / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * SLOTS"=
,
-        "MetricGroup": "Retire;TopdownL2;tma_L2_group;tma_retiring_group",
-        "MetricName": "tma_heavy_operations",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or microcoded sequences. This highly-correlates with the=
 uop length of these instructions/sequences. Sample with: UOPS_RETIRED.HEAV=
Y",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to other common frontend stalls not catego=
rized.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.OTHER / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_frontend_bandwidth_grou=
p",
+        "MetricName": "tma_other_fb",
+        "MetricThreshold": "tma_other_fb > 0.05",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring instructions that that are decoder into two or up to=
 ([SNB+] four; [ADL+] five) uops",
-        "MetricExpr": "tma_heavy_operations - tma_microcode_sequencer",
-        "MetricGroup": "TopdownL3;tma_heavy_operations_group",
-        "MetricName": "tma_few_uops_instructions",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring instructions that that are decoder into two or up t=
o ([SNB+] four; [ADL+] five) uops. This highly-correlates with the number o=
f uops in such instructions.",
+        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a number of other lo=
ad blocks.",
+        "MetricExpr": "LD_HEAD.OTHER_AT_RET / tma_info_clks",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
+        "MetricName": "tma_other_l1",
+        "MetricThreshold": "tma_other_l1 > 0.05",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU was retiring uops fetched by the Microcode Sequencer (MS) unit",
-        "MetricExpr": "tma_ms_uops",
-        "MetricGroup": "MicroSeq;TopdownL3;tma_heavy_operations_group",
-        "MetricName": "tma_microcode_sequencer",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The M=
S is used for CISC instructions not supported by the default decoders (like=
 repeat move strings; or CPUID); or by microcode assists used to address so=
me operation modes (like in Floating Point assists). These cases can often =
be avoided. Sample with: UOPS_RETIRED.MS",
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load miss which hits in the L2, LLC, DRAM or MMIO (Non-D=
RAM) but could not be correctly attributed or cycles in which the load miss=
 is waiting on a request buffer.",
+        "MetricExpr": "max(0, tma_load_store_bound - (tma_store_bound + tm=
a_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound))",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_load_store_bound_group"=
,
+        "MetricName": "tma_other_load_store",
+        "MetricThreshold": "tma_other_load_store > 0.1",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops delivered by the Microcode_Sequencer as a result of Assists=
",
-        "MetricExpr": "100 * cpu_core@ASSISTS.ANY\\,umask\\=3D0x1B@ / SLOT=
S",
-        "MetricGroup": "TopdownL4;tma_microcode_sequencer_group",
-        "MetricName": "tma_assists",
-        "PublicDescription": "This metric estimates fraction of slots the =
CPU retired uops delivered by the Microcode_Sequencer as a result of Assist=
s. Assists are long sequences of uops that are required in certain corner-c=
ases for operations that cannot be handled natively by the execution pipeli=
ne. For example; when working with very small floating point values (so-cal=
led Denormals); the FP units are not set up to perform these operations nat=
ively. Instead; a sequence of instructions to perform the computation on th=
e Denormals is injected into the pipeline. Since these microcode sequences =
might be dozens of uops long; Assists can be extremely deleterious to perfo=
rmance and they can be avoided in many cases. Sample with: ASSISTS.ANY",
+        "BriefDescription": "Counts the number of uops retired excluding m=
s and fp div uops.",
+        "MetricExpr": "(TOPDOWN_RETIRING.ALL - UOPS_RETIRED.MS - UOPS_RETI=
RED.FPDIV) / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_base_group",
+        "MetricName": "tma_other_ret",
+        "MetricThreshold": "tma_other_ret > 0.3",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric roughly estimates fraction of slo=
ts the CPU retired uops as a result of handing Page Faults",
-        "MetricExpr": "99 * ASSISTS.PAGE_FAULT / SLOTS",
-        "MetricGroup": "TopdownL5;tma_assists_group",
-        "MetricName": "tma_page_faults",
-        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Page Faults. A Page Fault m=
ay apply on first application access to a memory page. Note operating syste=
m handling of page faults accounts for the majority of its cost.",
+        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to page faults.",
+        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.PAGE_FAULT / MACHINE_CLE=
ARS.SLOW)",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
+        "MetricName": "tma_page_fault",
+        "MetricThreshold": "tma_page_fault > 0.02",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric roughly estimates fraction of slo=
ts the CPU retired uops as a result of handing Floating Point (FP) Assists"=
,
-        "MetricExpr": "30 * ASSISTS.FP / SLOTS",
-        "MetricGroup": "HPC;TopdownL5;tma_assists_group",
-        "MetricName": "tma_fp_assists",
-        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Floating Point (FP) Assists=
. FP Assist may apply when working with very small floating point values (s=
o-called denormals).",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to wrong predecodes.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.PREDECODE / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_frontend_bandwidth_grou=
p",
+        "MetricName": "tma_predecode",
+        "MetricThreshold": "tma_predecode > 0.05",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops as a result of handing SSE to AVX* or AVX* to SSE transitio=
n Assists. ",
-        "MetricExpr": "63 * ASSISTS.SSE_AVX_MIX / SLOTS",
-        "MetricGroup": "HPC;TopdownL5;tma_assists_group",
-        "MetricName": "tma_avx_assists",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to the physical register file unable to acce=
pt an entry (marble stalls).",
+        "MetricExpr": "TOPDOWN_BE_BOUND.REGISTER / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricName": "tma_register",
+        "MetricThreshold": "tma_register > 0.1",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles the =
CPU retired uops originated from CISC (complex instruction set computer) in=
struction",
-        "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
-        "MetricGroup": "TopdownL4;tma_microcode_sequencer_group",
-        "MetricName": "tma_cisc",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU retired uops originated from CISC (complex instruction set computer) i=
nstruction. A CISC instruction has multiple uops that are required to perfo=
rm the instruction's functionality as in the case of read-modify-write as a=
n example. Since these instructions require multiple uops they may or may n=
ot imply sub-optimal use of machine resources. Sample with: FRONTEND_RETIRE=
D.MS_FLOWS",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to the reorder buffer being full (ROB stalls=
).",
+        "MetricExpr": "TOPDOWN_BE_BOUND.REORDER_BUFFER / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricName": "tma_reorder_buffer",
+        "MetricThreshold": "tma_reorder_buffer > 0.1",
         "ScaleUnit": "100%",
-        "Unit": "cpu_core"
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
-        "MetricExpr": "100 * (tma_branch_mispredicts + tma_fetch_latency *=
 tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_i=
cache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
-        "MetricGroup": "Bad;BadSpec;BrMispredicts",
-        "MetricName": "Mispredictions",
-        "Unit": "cpu_core"
+        "BriefDescription": "Counts the total number of issue slots  that =
were not consumed by the backend due to backend stalls",
+        "MetricExpr": "tma_backend_bound",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_aux_group=
",
+        "MetricName": "tma_resource_bound",
+        "MetricThreshold": "tma_resource_bound > 0.2",
+        "PublicDescription": "Counts the total number of issue slots  that=
 were not consumed by the backend due to backend stalls.  Note that uops mu=
st be available for consumption in order for this event to count.  If a uop=
 is not available (IQ is empty), this event will not count.",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
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
-        "MetricGroup": "Mem;MemoryBW;Offcore",
-        "MetricName": "Memory_Bandwidth",
-        "Unit": "cpu_core"
+        "BriefDescription": "Counts the numer of issue slots  that result =
in retirement slots.",
+        "MetricExpr": "TOPDOWN_RETIRING.ALL / tma_info_slots",
+        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricName": "tma_retiring",
+        "MetricThreshold": "tma_retiring > 0.75",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Total pipeline cost of Memory Latency related=
 bottlenecks (external memory and off-core caches)",
-        "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (=
tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_l3_bound / (=
tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bou=
nd) * (tma_l3_hit_latency / (tma_contested_accesses + tma_data_sharing + tm=
a_l3_hit_latency + tma_sq_full)) + tma_l2_bound / (tma_dram_bound + tma_l1_=
bound + tma_l2_bound + tma_l3_bound + tma_store_bound))",
-        "MetricGroup": "Mem;MemoryLat;Offcore",
-        "MetricName": "Memory_Latency",
-        "Unit": "cpu_core"
+        "BriefDescription": "Counts the number of cycles, relative to the =
number of mem_scheduler slots, in which uops are blocked due to RSV full re=
lative",
+        "MetricExpr": "tma_mem_scheduler * MEM_SCHEDULER_BLOCK.RSV / MEM_S=
CHEDULER_BLOCK.ALL",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_mem_scheduler_group",
+        "MetricName": "tma_rsv",
+        "MetricThreshold": "tma_rsv > 0.05",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
-        "MetricExpr": "100 * tma_memory_bound * (tma_l1_bound / max(tma_me=
mory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + t=
ma_store_bound) * (tma_dtlb_load / max(tma_l1_bound, tma_dtlb_load + tma_fb=
_full + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_stor=
e_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tm=
a_store_bound) * (tma_dtlb_store / (tma_dtlb_store + tma_false_sharing + tm=
a_split_stores + tma_store_latency + tma_streaming_stores)))",
-        "MetricGroup": "Mem;MemoryTLB;Offcore",
-        "MetricName": "Memory_Data_TLBs",
-        "Unit": "cpu_core"
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to scoreboards from the instruction queue (I=
Q), jump execution unit (JEU), or microcode sequencer (MS).",
+        "MetricExpr": "TOPDOWN_BE_BOUND.SERIALIZATION / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricName": "tma_serialization",
+        "MetricThreshold": "tma_serialization > 0.1",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Total pipeline cost of branch related instruc=
tions (used for program control-flow including function calls)",
-        "MetricExpr": "100 * ((BR_INST_RETIRED.COND + 3 * BR_INST_RETIRED.=
NEAR_CALL + (BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.COND_TAKEN - 2 * =
BR_INST_RETIRED.NEAR_CALL)) / SLOTS)",
-        "MetricGroup": "Ret",
-        "MetricName": "Branching_Overhead",
-        "Unit": "cpu_core"
+        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to SMC.",
+        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.SMC / MACHINE_CLEARS.SLO=
W)",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
+        "MetricName": "tma_smc",
+        "MetricThreshold": "tma_smc > 0.02",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
-        "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_branch_resteers + tma_dsb_switch=
es + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)",
-        "MetricGroup": "BigFoot;Fed;Frontend;IcMiss;MemoryTLB",
-        "MetricName": "Big_Code",
-        "Unit": "cpu_core"
+        "BriefDescription": "Counts the number of cycles, relative to the =
number of mem_scheduler slots, in which uops are blocked due to store buffe=
r full",
+        "MetricExpr": "tma_store_bound",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_mem_scheduler_group",
+        "MetricName": "tma_st_buffer",
+        "MetricThreshold": "tma_st_buffer > 0.05",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks",
-        "MetricExpr": "100 * (tma_frontend_bound - tma_fetch_latency * tma=
_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icach=
e_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) - Big_Code",
-        "MetricGroup": "Fed;FetchBW;Frontend",
-        "MetricName": "Instruction_Fetch_BW",
-        "Unit": "cpu_core"
+        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a first level TLB mi=
ss.",
+        "MetricExpr": "LD_HEAD.DTLB_MISS_AT_RET / tma_info_clks",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
+        "MetricName": "tma_stlb_hit",
+        "MetricThreshold": "tma_stlb_hit > 0.05",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
-        "MetricExpr": "INST_RETIRED.ANY / CLKS",
-        "MetricGroup": "Ret;Summary",
-        "MetricName": "IPC",
-        "Unit": "cpu_core"
+        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a second level TLB m=
iss requiring a page walk.",
+        "MetricExpr": "LD_HEAD.PGWALK_AT_RET / tma_info_clks",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
+        "MetricName": "tma_stlb_miss",
+        "MetricThreshold": "tma_stlb_miss > 0.05",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Uops Per Instruction",
-        "MetricExpr": "tma_retiring * SLOTS / INST_RETIRED.ANY",
-        "MetricGroup": "Pipeline;Ret;Retire",
-        "MetricName": "UPI",
-        "Unit": "cpu_core"
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to store buffer full.",
+        "MetricExpr": "tma_mem_scheduler * (MEM_SCHEDULER_BLOCK.ST_BUF / M=
EM_SCHEDULER_BLOCK.ALL)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_load_store_bound_group"=
,
+        "MetricName": "tma_store_bound",
+        "MetricThreshold": "tma_store_bound > 0.1",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instruction per taken branch",
-        "MetricExpr": "tma_retiring * SLOTS / BR_INST_RETIRED.NEAR_TAKEN",
-        "MetricGroup": "Branches;Fed;FetchBW",
-        "MetricName": "UpTB",
-        "Unit": "cpu_core"
+        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a store forward bloc=
k.",
+        "MetricExpr": "LD_HEAD.ST_ADDR_AT_RET / tma_info_clks",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
+        "MetricName": "tma_store_fwd",
+        "MetricThreshold": "tma_store_fwd > 0.05",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
-        "MetricExpr": "1 / IPC",
-        "MetricGroup": "Mem;Pipeline",
-        "MetricName": "CPI",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
+        "MetricExpr": "(UOPS_DISPATCHED.PORT_0 + UOPS_DISPATCHED.PORT_1 + =
UOPS_DISPATCHED.PORT_5_11 + UOPS_DISPATCHED.PORT_6) / (5 * tma_info_core_cl=
ks)",
+        "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
+        "MetricName": "tma_alu_op_utilization",
+        "MetricThreshold": "tma_alu_op_utilization > 0.6",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "Pipeline",
-        "MetricName": "CLKS",
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops delivered by the Microcode_Sequencer as a result of Assists=
",
+        "MetricExpr": "100 * cpu_core@ASSISTS.ANY\\,umask\\=3D0x1B@ / tma_=
info_slots",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
+        "MetricName": "tma_assists",
+        "MetricThreshold": "tma_assists > 0.1 & (tma_microcode_sequencer >=
 0.05 & tma_heavy_operations > 0.1)",
+        "PublicDescription": "This metric estimates fraction of slots the =
CPU retired uops delivered by the Microcode_Sequencer as a result of Assist=
s. Assists are long sequences of uops that are required in certain corner-c=
ases for operations that cannot be handled natively by the execution pipeli=
ne. For example; when working with very small floating point values (so-cal=
led Denormals); the FP units are not set up to perform these operations nat=
ively. Instead; a sequence of instructions to perform the computation on th=
e Denormals is injected into the pipeline. Since these microcode sequences =
might be dozens of uops long; Assists can be extremely deleterious to perfo=
rmance and they can be avoided in many cases. Sample with: ASSISTS.ANY",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
-        "MetricExpr": "TOPDOWN.SLOTS",
-        "MetricGroup": "tma_L1_group",
-        "MetricName": "SLOTS",
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops as a result of handing SSE to AVX* or AVX* to SSE transitio=
n Assists.",
+        "MetricExpr": "63 * ASSISTS.SSE_AVX_MIX / tma_info_slots",
+        "MetricGroup": "HPC;TopdownL5;tma_L5_group;tma_assists_group",
+        "MetricName": "tma_avx_assists",
+        "MetricThreshold": "tma_avx_assists > 0.1",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fraction of Physical Core issue-slots utilize=
d by this Logical Processor",
-        "MetricExpr": "(SLOTS / (TOPDOWN.SLOTS / 2) if #SMT_on else 1)",
-        "MetricGroup": "SMT;tma_L1_group",
-        "MetricName": "Slots_Utilization",
+        "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
+        "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_inf=
o_slots",
+        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricName": "tma_backend_bound",
+        "MetricThreshold": "tma_backend_bound > 0.2",
+        "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "The ratio of Executed- by Issued-Uops",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / UOPS_ISSUED.ANY",
-        "MetricGroup": "Cor;Pipeline",
-        "MetricName": "Execute_per_Issue",
-        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage.",
+        "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
+        "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_bound + t=
ma_retiring), 0)",
+        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricName": "tma_bad_speculation",
+        "MetricThreshold": "tma_bad_speculation > 0.15",
+        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions Per Cycle across hyper-threads (=
per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / CORE_CLKS",
-        "MetricGroup": "Ret;SMT;tma_L1_group",
-        "MetricName": "CoreIPC",
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction",
+        "MetricExpr": "topdown\\-br\\-mispredict / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tm=
a_info_slots",
+        "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_group=
;tma_bad_speculation_group;tma_issueBM",
+        "MetricName": "tma_branch_mispredicts",
+        "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specula=
tion > 0.15",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: TOPDOWN.BR_MISPREDICT_SLOTS. Related metrics: =
tma_info_branch_misprediction_cost, tma_info_mispredictions, tma_mispredict=
s_resteers",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 =
* (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PA=
CKED_DOUBLE) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) / CORE_CLKS",
-        "MetricGroup": "Flops;Ret",
-        "MetricName": "FLOPc",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers",
+        "MetricExpr": "INT_MISC.CLEAR_RESTEER_CYCLES / tma_info_clks + tma=
_unknown_branches",
+        "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group",
+        "MetricName": "tma_branch_resteers",
+        "MetricThreshold": "tma_branch_resteers > 0.05 & (tma_fetch_latenc=
y > 0.1 & tma_frontend_bound > 0.15)",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fro=
ntend delay in fetching operations from corrected path; following all sorts=
 of miss-predicted branches. For example; branchy code with lots of miss-pr=
edictions might get categorized under Branch Resteers. Note the value of th=
is node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_BRA=
NCHES",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
-        "MetricExpr": "(FP_ARITH_DISPATCHED.PORT_0 + FP_ARITH_DISPATCHED.P=
ORT_1 + FP_ARITH_DISPATCHED.PORT_5) / (2 * CORE_CLKS)",
-        "MetricGroup": "Cor;Flops;HPC",
-        "MetricName": "FP_Arith_Utilization",
-        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n).",
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU retired uops originated from CISC (complex instruction set computer) in=
struction",
+        "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
+        "MetricName": "tma_cisc",
+        "MetricThreshold": "tma_cisc > 0.1 & (tma_microcode_sequencer > 0.=
05 & tma_heavy_operations > 0.1)",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU retired uops originated from CISC (complex instruction set computer) i=
nstruction. A CISC instruction has multiple uops that are required to perfo=
rm the instruction's functionality as in the case of read-modify-write as a=
n example. Since these instructions require multiple uops they may or may n=
ot imply sub-optimal use of machine resources. Sample with: FRONTEND_RETIRE=
D.MS_FLOWS",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
-        "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
-        "MetricName": "ILP",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Machine Clears",
+        "MetricExpr": "(1 - tma_branch_mispredicts / tma_bad_speculation) =
* INT_MISC.CLEAR_RESTEER_CYCLES / tma_info_clks",
+        "MetricGroup": "BadSpec;MachineClears;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group;tma_issueMC",
+        "MetricName": "tma_clears_resteers",
+        "MetricThreshold": "tma_clears_resteers > 0.05 & (tma_branch_reste=
ers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Machine Clears. Sam=
ple with: INT_MISC.CLEAR_RESTEER_CYCLES. Related metrics: tma_l1_bound, tma=
_machine_clears, tma_microcode_sequencer, tma_ms_switches",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
-        "MetricExpr": "((1 - tma_core_bound / tma_ports_utilization if tma=
_core_bound < tma_ports_utilization else 1) if SMT_2T_Utilization > 0.5 els=
e 0)",
-        "MetricGroup": "Cor;SMT",
-        "MetricName": "Core_Bound_Likely",
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(25 * tma_info_average_frequency * (MEM_LOAD_L3_HIT=
_RETIRED.XSNP_FWD * (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM / (OCR.DEMAND_DAT=
A_RD.L3_HIT.SNOOP_HITM + OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) + =
24 * tma_info_average_frequency * MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS) * (1 +=
 MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_info_clks",
+        "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_l3_bound_group",
+        "MetricName": "tma_contested_accesses",
+        "MetricThreshold": "tma_contested_accesses > 0.05 & (tma_l3_bound =
> 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_FWD;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS. Related m=
etrics: tma_data_sharing, tma_false_sharing, tma_machine_clears, tma_remote=
_cache",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
-        "MetricExpr": "CPU_CLK_UNHALTED.DISTRIBUTED",
-        "MetricGroup": "SMT",
-        "MetricName": "CORE_CLKS",
+        "BriefDescription": "This metric represents fraction of slots wher=
e Core non-memory issues were of a bottleneck",
+        "MetricExpr": "max(0, tma_backend_bound - tma_memory_bound)",
+        "MetricGroup": "Backend;Compute;TmaL2;TopdownL2;tma_L2_group;tma_b=
ackend_bound_group",
+        "MetricName": "tma_core_bound",
+        "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2=
",
+        "PublicDescription": "This metric represents fraction of slots whe=
re Core non-memory issues were of a bottleneck.  Shortage in hardware compu=
te resources; or dependencies in software's instructions are both categoriz=
ed under Core Bound. Hence it may indicate the machine ran out of an out-of=
-order resource; certain execution units are overloaded or dependencies in =
program's data- or instruction-flow are limiting the performance (e.g. FP-c=
hained long-latency arithmetic operations).",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per Load (lower number means hig=
her occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_LOADS",
-        "MetricGroup": "InsType",
-        "MetricName": "IpLoad",
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "24 * tma_info_average_frequency * (MEM_LOAD_L3_HIT_=
RETIRED.XSNP_NO_FWD + MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD * (1 - OCR.DEMAND_DA=
TA_RD.L3_HIT.SNOOP_HITM / (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM + OCR.DEMAN=
D_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM=
_LOAD_RETIRED.L1_MISS / 2) / tma_info_clks",
+        "MetricGroup": "Offcore;Snoop;TopdownL4;tma_L4_group;tma_issueSync=
xn;tma_l3_bound_group",
+        "MetricName": "tma_data_sharing",
+        "MetricThreshold": "tma_data_sharing > 0.05 & (tma_l3_bound > 0.05=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_L3_HIT_RETIRED.XSNP_NO_FWD. Related metrics: tma_contested_accesses, tma=
_false_sharing, tma_machine_clears, tma_remote_cache",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per Store (lower number means hi=
gher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_STORES",
-        "MetricGroup": "InsType",
-        "MetricName": "IpStore",
+        "BriefDescription": "This metric represents fraction of cycles whe=
re decoder-0 was the only active decoder",
+        "MetricExpr": "(cpu_core@INST_DECODED.DECODERS\\,cmask\\=3D1@ - cp=
u_core@INST_DECODED.DECODERS\\,cmask\\=3D2@) / tma_info_core_clks / 2",
+        "MetricGroup": "DSBmiss;FetchBW;TopdownL4;tma_L4_group;tma_issueD0=
;tma_mite_group",
+        "MetricName": "tma_decoder0_alone",
+        "MetricThreshold": "tma_decoder0_alone > 0.1 & (tma_mite > 0.1 & (=
tma_fetch_bandwidth > 0.1 & tma_frontend_bound > 0.15 & tma_info_ipc / 6 > =
0.35))",
+        "PublicDescription": "This metric represents fraction of cycles wh=
ere decoder-0 was the only active decoder. Related metrics: tma_few_uops_in=
structions",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Branches;Fed;InsType",
-        "MetricName": "IpBranch",
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the Divider unit was active",
+        "MetricExpr": "ARITH.DIV_ACTIVE / tma_info_clks",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_core_bound_group",
+        "MetricName": "tma_divider",
+        "MetricThreshold": "tma_divider > 0.2 & (tma_core_bound > 0.1 & tm=
a_backend_bound > 0.2)",
+        "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIVIDER_ACTIVE",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per (near) call (lower number me=
ans higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
-        "MetricGroup": "Branches;Fed;PGO",
-        "MetricName": "IpCall",
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "MEMORY_ACTIVITY.STALLS_L3_MISS / tma_info_clks",
+        "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
+        "MetricName": "tma_dram_bound",
+        "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_RETIRED=
.L3_MISS_PS",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instruction per taken branch",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
-        "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO",
-        "MetricName": "IpTB",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to DSB (decoded uop cache) fetch pipe=
line",
+        "MetricExpr": "(IDQ.DSB_CYCLES_ANY - IDQ.DSB_CYCLES_OK) / tma_info=
_core_clks / 2",
+        "MetricGroup": "DSB;FetchBW;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
+        "MetricName": "tma_dsb",
+        "MetricThreshold": "tma_dsb > 0.15 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_ipc / 6 > 0.35)",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here.",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Branch instructions per taken branch. ",
-        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
-        "MetricGroup": "Branches;Fed;PGO",
-        "MetricName": "BpTkBranch",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to switches from DSB to MITE pipelines",
+        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / tma_info_clks",
+        "MetricGroup": "DSBmiss;FetchLat;TopdownL3;tma_L3_group;tma_fetch_=
latency_group;tma_issueFB",
+        "MetricName": "tma_dsb_switches",
+        "MetricThreshold": "tma_dsb_switches > 0.05 & (tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15)",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS_PS. Related metrics: tma_fetch_bandwidth, tma_info_dsb_coverage, tma=
_info_dsb_misses, tma_info_iptb, tma_lcp",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per Floating Point (FP) Operatio=
n (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR_SI=
NGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE + 2 * FP_ARITH_INST_RETIRED.128B=
_PACKED_DOUBLE + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_I=
NST_RETIRED.256B_PACKED_DOUBLE) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SIN=
GLE)",
-        "MetricGroup": "Flops;InsType",
-        "MetricName": "IpFLOP",
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
+        "MetricExpr": "min(7 * cpu_core@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\=
\=3D1@ + DTLB_LOAD_MISSES.WALK_ACTIVE, max(CYCLE_ACTIVITY.CYCLES_MEM_ANY - =
MEMORY_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_clks",
+        "MetricGroup": "MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB;tma_=
l1_bound_group",
+        "MetricName": "tma_dtlb_load",
+        "MetricThreshold": "tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & (t=
ma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS_PS. Related metrics: t=
ma_dtlb_store, tma_info_memory_data_tlbs",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per FP Arithmetic instruction (l=
ower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR_SI=
NGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE + (FP_ARITH_INST_RETIRED.128B_PA=
CKED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETI=
RED.256B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE))",
-        "MetricGroup": "Flops;InsType",
-        "MetricName": "IpArith",
-        "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). May undercount due to FMA doubl=
e counting. Approximated prior to BDW.",
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
+        "MetricExpr": "(7 * cpu_core@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=
=3D1@ + DTLB_STORE_MISSES.WALK_ACTIVE) / tma_info_core_clks",
+        "MetricGroup": "MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB;tma_=
store_bound_group",
+        "MetricName": "tma_dtlb_store",
+        "MetricThreshold": "tma_dtlb_store > 0.05 & (tma_store_bound > 0.2=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES_PS. Related metrics: tma_dtlb_load, =
tma_info_memory_data_tlbs",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per FP Arithmetic Scalar Single-=
Precision instruction (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED.SCALAR_SIN=
GLE",
-        "MetricGroup": "Flops;FpScalar;InsType",
-        "MetricName": "IpArith_Scalar_SP",
-        "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). May und=
ercount due to FMA double counting.",
+        "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
+        "MetricExpr": "28 * tma_info_average_frequency * OCR.DEMAND_RFO.L3=
_HIT.SNOOP_HITM / tma_info_clks",
+        "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_store_bound_group",
+        "MetricName": "tma_false_sharing",
+        "MetricThreshold": "tma_false_sharing > 0.05 & (tma_store_bound > =
0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line. Sample with: OCR.DEMAND_RFO.L=
3_HIT.SNOOP_HITM. Related metrics: tma_contested_accesses, tma_data_sharing=
, tma_machine_clears, tma_remote_cache",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per FP Arithmetic Scalar Double-=
Precision instruction (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED.SCALAR_DOU=
BLE",
-        "MetricGroup": "Flops;FpScalar;InsType",
-        "MetricName": "IpArith_Scalar_DP",
-        "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). May und=
ercount due to FMA double counting.",
+        "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
+        "MetricExpr": "L1D_PEND_MISS.FB_FULL / tma_info_clks",
+        "MetricGroup": "MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;tma_is=
sueSL;tma_issueSmSt;tma_l1_bound_group",
+        "MetricName": "tma_fb_full",
+        "MetricThreshold": "tma_fb_full > 0.3",
+        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_info_dram_bw_use, tma_info_memory_b=
andwidth, tma_mem_bandwidth, tma_sq_full, tma_store_latency, tma_streaming_=
stores",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-bi=
t instruction (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.128B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE)",
-        "MetricGroup": "Flops;FpVector;InsType",
-        "MetricName": "IpArith_AVX128",
-        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). May undercount =
due to FMA double counting.",
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend bandwidth issues",
+        "MetricExpr": "max(0, tma_frontend_bound - tma_fetch_latency)",
+        "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_=
frontend_bound_group;tma_issueFB",
+        "MetricName": "tma_fetch_bandwidth",
+        "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound=
 > 0.15 & tma_info_ipc / 6 > 0.35",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LA=
TENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_sw=
itches, tma_info_dsb_coverage, tma_info_dsb_misses, tma_info_iptb, tma_lcp"=
,
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per FP Arithmetic AVX* 256-bit i=
nstruction (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.256B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE)",
-        "MetricGroup": "Flops;FpVector;InsType",
-        "MetricName": "IpArith_AVX256",
-        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). May undercount due=
 to FMA double counting.",
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues",
+        "MetricExpr": "topdown\\-fetch\\-lat / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.U=
OP_DROPPING / tma_info_slots",
+        "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend=
_bound_group",
+        "MetricName": "tma_fetch_latency",
+        "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound >=
 0.15",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend latency issues.  For example; instruction-=
cache misses; iTLB misses or fetch stalls after a branch misprediction are =
categorized under Frontend Latency. In such cases; the Frontend eventually =
delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_=
16_PS;FRONTEND_RETIRED.LATENCY_GE_8_PS",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per Software prefetch instructio=
n (of any type: NTA/T0/T1/T2/Prefetch) (lower number means higher occurrenc=
e rate)",
-        "MetricExpr": "INST_RETIRED.ANY / cpu_core@SW_PREFETCH_ACCESS.T0\\=
,umask\\=3D0xF@",
-        "MetricGroup": "Prefetches",
-        "MetricName": "IpSWPF",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring instructions that that are decoder into two or up to=
 ([SNB+] four; [ADL+] five) uops",
+        "MetricExpr": "max(0, tma_heavy_operations - tma_microcode_sequenc=
er)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_heavy_operations_group;=
tma_issueD0",
+        "MetricName": "tma_few_uops_instructions",
+        "MetricThreshold": "tma_few_uops_instructions > 0.05 & tma_heavy_o=
perations > 0.1",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring instructions that that are decoder into two or up t=
o ([SNB+] four; [ADL+] five) uops. This highly-correlates with the number o=
f uops in such instructions. Related metrics: tma_decoder0_alone",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Total number of retired Instructions Sample w=
ith: INST_RETIRED.PREC_DIST",
-        "MetricExpr": "INST_RETIRED.ANY",
-        "MetricGroup": "Summary;tma_L1_group",
-        "MetricName": "Instructions",
+        "BriefDescription": "This metric represents overall arithmetic flo=
ating-point (FP) operations fraction the CPU has executed (retired)",
+        "MetricExpr": "tma_x87_use + tma_fp_scalar + tma_fp_vector",
+        "MetricGroup": "HPC;TopdownL3;tma_L3_group;tma_light_operations_gr=
oup",
+        "MetricName": "tma_fp_arith",
+        "MetricThreshold": "tma_fp_arith > 0.2 & tma_light_operations > 0.=
6",
+        "PublicDescription": "This metric represents overall arithmetic fl=
oating-point (FP) operations fraction the CPU has executed (retired). Note =
this metric's value may exceed its parent due to use of \"Uops\" CountDomai=
n and FMA double-counting.",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
-        "MetricExpr": "tma_retiring * SLOTS / cpu_core@UOPS_RETIRED.SLOTS\=
\,cmask\\=3D1@",
-        "MetricGroup": "Pipeline;Ret",
-        "MetricName": "Retire",
+        "BriefDescription": "This metric roughly estimates fraction of slo=
ts the CPU retired uops as a result of handing Floating Point (FP) Assists"=
,
+        "MetricExpr": "30 * ASSISTS.FP / tma_info_slots",
+        "MetricGroup": "HPC;TopdownL5;tma_L5_group;tma_assists_group",
+        "MetricName": "tma_fp_assists",
+        "MetricThreshold": "tma_fp_assists > 0.1",
+        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Floating Point (FP) Assists=
. FP Assist may apply when working with very small floating point values (s=
o-called Denormals).",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Estimated fraction of retirement-cycles deali=
ng with repeat instructions",
-        "MetricExpr": "INST_RETIRED.REP_ITERATION / cpu_core@UOPS_RETIRED.=
SLOTS\\,cmask\\=3D1@",
-        "MetricGroup": "Pipeline;Ret",
-        "MetricName": "Strings_Cycles",
+        "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) scalar uops fraction the CPU has retired",
+        "MetricExpr": "cpu_core@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umas=
k\\=3D0x03@ / (tma_retiring * tma_info_slots)",
+        "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
+        "MetricName": "tma_fp_scalar",
+        "MetricThreshold": "tma_fp_scalar > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting. Related metrics: tma_fp_vector, tma_fp_vector_128b, tm=
a_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_vector_2=
56b, tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per a microcode Assist invocatio=
n. See Assists tree node for details (lower number means higher occurrence =
rate)",
-        "MetricExpr": "INST_RETIRED.ANY / cpu_core@ASSISTS.ANY\\,umask\\=
=3D0x1B@",
-        "MetricGroup": "Pipeline;Ret;Retire",
-        "MetricName": "IpAssist",
+        "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) vector uops fraction the CPU has retired aggregated across all v=
ector widths",
+        "MetricExpr": "cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\=
,umask\\=3D0x3c@ / (tma_retiring * tma_info_slots)",
+        "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
+        "MetricName": "tma_fp_vector",
+        "MetricThreshold": "tma_fp_vector > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting. Related metrics: t=
ma_fp_scalar, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, t=
ma_int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_5=
, tma_port_6, tma_ports_utilized_2",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu_core@UOPS_EXECUTED.THREA=
D\\,cmask\\=3D1@",
-        "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
-        "MetricName": "Execute",
+        "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 128-bit wide vectors",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.128B_PACKED_SINGLE) / (tma_retiring * tma_info_slots)",
+        "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
+        "MetricName": "tma_fp_vector_128b",
+        "MetricThreshold": "tma_fp_vector_128b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_vecto=
r_256b, tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_=
2",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average number of Uops issued by front-end wh=
en it issued something",
-        "MetricExpr": "UOPS_ISSUED.ANY / cpu_core@UOPS_ISSUED.ANY\\,cmask\=
\=3D1@",
-        "MetricGroup": "Fed;FetchBW",
-        "MetricName": "Fetch_UpC",
+        "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 256-bit wide vectors",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.256B_PACKED_SINGLE) / (tma_retiring * tma_info_slots)",
+        "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
+        "MetricName": "tma_fp_vector_256b",
+        "MetricThreshold": "tma_fp_vector_256b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_128b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_vecto=
r_256b, tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_=
2",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fraction of Uops delivered by the LSD (Loop S=
tream Detector; aka Loop Cache)",
-        "MetricExpr": "LSD.UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS=
 + IDQ.MS_UOPS)",
-        "MetricGroup": "Fed;LSD",
-        "MetricName": "LSD_Coverage",
+        "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
+        "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.UO=
P_DROPPING / tma_info_slots",
+        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
+        "MetricName": "tma_frontend_bound",
+        "MetricThreshold": "tma_frontend_bound > 0.15",
+        "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Pipeline_Width uops every =
cycle to the Backend. Frontend Bound denotes unutilized issue-slots when th=
ere is no Backend stall; i.e. bubbles where Frontend delivered no uops whil=
e Backend could have accepted them. For example; stalls due to instruction-=
cache misses would be categorized under Frontend Bound. Sample with: FRONTE=
ND_RETIRED.LATENCY_GE_4_PS",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
-        "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_=
UOPS + IDQ.MS_UOPS)",
-        "MetricGroup": "DSB;Fed;FetchBW",
-        "MetricName": "DSB_Coverage",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions -- where one uop can represent mu=
ltiple contiguous instructions",
+        "MetricExpr": "tma_light_operations * INST_RETIRED.MACRO_FUSED / (=
tma_retiring * tma_info_slots)",
+        "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
+        "MetricName": "tma_fused_instructions",
+        "MetricThreshold": "tma_fused_instructions > 0.1 & tma_light_opera=
tions > 0.6",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring fused instructions -- where one uop can represent m=
ultiple contiguous instructions. The instruction pairs of CMP+JCC or DEC+JC=
C are commonly used examples.",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
.",
-        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / cpu_core@DSB2MIT=
E_SWITCHES.PENALTY_CYCLES\\,cmask\\=3D1\\,edge@",
-        "MetricGroup": "DSBmiss",
-        "MetricName": "DSB_Switch_Cost",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or micro-coded sequences",
+        "MetricExpr": "topdown\\-heavy\\-ops / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_in=
fo_slots",
+        "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_g=
roup",
+        "MetricName": "tma_heavy_operations",
+        "MetricThreshold": "tma_heavy_operations > 0.1",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or micro-coded sequences. This highly-correlates with th=
e uop length of these instructions/sequences. Sample with: UOPS_RETIRED.HEA=
VY",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Total penalty related to DSB (uop cache) miss=
es - subset of the Instruction_Fetch_BW Bottleneck.",
-        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + =
tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb + tm=
a_lsd + tma_mite))",
-        "MetricGroup": "DSBmiss;Fed",
-        "MetricName": "DSB_Misses",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses",
+        "MetricExpr": "ICACHE_DATA.STALLS / tma_info_clks",
+        "MetricGroup": "BigFoot;FetchLat;IcMiss;TopdownL3;tma_L3_group;tma=
_fetch_latency_group",
+        "MetricName": "tma_icache_misses",
+        "MetricThreshold": "tma_icache_misses > 0.05 & (tma_fetch_latency =
> 0.1 & tma_frontend_bound > 0.15)",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to instruction cache misses. Sample with: FRONTEND_RE=
TIRED.L2_MISS_PS;FRONTEND_RETIRED.L1I_MISS_PS",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Number of Instructions per non-speculative DS=
B miss (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / FRONTEND_RETIRED.ANY_DSB_MISS",
-        "MetricGroup": "DSBmiss;Fed",
-        "MetricName": "IpDSB_Miss_Ret",
+        "BriefDescription": "Measured Average Frequency for unhalted proce=
ssors [GHz]",
+        "MetricExpr": "tma_info_turbo_utilization * TSC / 1e9 / duration_t=
ime",
+        "MetricGroup": "Power;Summary",
+        "MetricName": "tma_info_average_frequency",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;BadSpec;BrMispredicts",
-        "MetricName": "IpMispredict",
+        "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_branch_resteers + tma_dsb_switch=
es + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)",
+        "MetricGroup": "BigFoot;Fed;Frontend;IcMiss;MemoryTLB;tma_issueBC"=
,
+        "MetricName": "tma_info_big_code",
+        "MetricThreshold": "tma_info_big_code > 20",
+        "PublicDescription": "Total pipeline cost of instruction fetch rel=
ated bottlenecks by large code footprint programs (i-side cache; TLB and BT=
B misses). Related metrics: tma_info_branching_overhead",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
-        "MetricExpr": "(tma_branch_mispredicts + tma_fetch_latency * tma_m=
ispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icache_=
misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) * SLOTS / BR_MISP_RE=
TIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;BrMispredicts",
-        "MetricName": "Branch_Misprediction_Cost",
+        "BriefDescription": "Branch instructions per taken branch.",
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
+        "MetricGroup": "Branches;Fed;PGO",
+        "MetricName": "tma_info_bptkbranch",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fraction of branches that are non-taken condi=
tionals",
-        "MetricExpr": "BR_INST_RETIRED.COND_NTAKEN / BR_INST_RETIRED.ALL_B=
RANCHES",
-        "MetricGroup": "Bad;Branches;CodeGen;PGO",
-        "MetricName": "Cond_NT",
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
+        "MetricExpr": "(tma_branch_mispredicts + tma_fetch_latency * tma_m=
ispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icache_=
misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) * tma_info_slots / B=
R_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;BrMispredicts;tma_issueBM",
+        "MetricName": "tma_info_branch_misprediction_cost",
+        "PublicDescription": "Branch Misprediction Cost: Fraction of TMA s=
lots wasted per non-speculative branch misprediction (retired JEClear). Rel=
ated metrics: tma_branch_mispredicts, tma_info_mispredictions, tma_mispredi=
cts_resteers",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fraction of branches that are taken condition=
als",
-        "MetricExpr": "BR_INST_RETIRED.COND_TAKEN / BR_INST_RETIRED.ALL_BR=
ANCHES",
-        "MetricGroup": "Bad;Branches;CodeGen;PGO",
-        "MetricName": "Cond_TK",
+        "BriefDescription": "Total pipeline cost of branch related instruc=
tions (used for program control-flow including function calls)",
+        "MetricExpr": "100 * ((BR_INST_RETIRED.COND + 3 * BR_INST_RETIRED.=
NEAR_CALL + (BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.COND_TAKEN - 2 * =
BR_INST_RETIRED.NEAR_CALL)) / tma_info_slots)",
+        "MetricGroup": "Ret;tma_issueBC",
+        "MetricName": "tma_info_branching_overhead",
+        "MetricThreshold": "tma_info_branching_overhead > 10",
+        "PublicDescription": "Total pipeline cost of branch related instru=
ctions (used for program control-flow including function calls). Related me=
trics: tma_info_big_code",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Fraction of branches that are CALL or RET",
         "MetricExpr": "(BR_INST_RETIRED.NEAR_CALL + BR_INST_RETIRED.NEAR_R=
ETURN) / BR_INST_RETIRED.ALL_BRANCHES",
         "MetricGroup": "Bad;Branches",
-        "MetricName": "CallRet",
+        "MetricName": "tma_info_callret",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fraction of branches that are unconditional (=
direct or indirect) jumps",
-        "MetricExpr": "(BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.COND_=
TAKEN - 2 * BR_INST_RETIRED.NEAR_CALL) / BR_INST_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;Branches",
-        "MetricName": "Jump",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Fraction of branches of other types (not indi=
vidually covered by other metrics in Info.Branches group)",
-        "MetricExpr": "1 - (Cond_NT + Cond_TK + CallRet + Jump)",
-        "MetricGroup": "Bad;Branches",
-        "MetricName": "Other_Branches",
+        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "Pipeline",
+        "MetricName": "tma_info_clks",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / MEM_LOAD_COMPLETED.L1_MISS_=
ANY",
-        "MetricGroup": "Mem;MemoryBound;MemoryLat",
-        "MetricName": "Load_Miss_Real_Latency",
+        "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
+        "MetricExpr": "1e3 * ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.ANY=
",
+        "MetricGroup": "Fed;MemoryTLB",
+        "MetricName": "tma_info_code_stlb_mpki",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss. Per-Logical Proces=
sor)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLE=
S",
-        "MetricGroup": "Mem;MemoryBW;MemoryBound",
-        "MetricName": "MLP",
+        "BriefDescription": "Fraction of branches that are non-taken condi=
tionals",
+        "MetricExpr": "BR_INST_RETIRED.COND_NTAKEN / BR_INST_RETIRED.ALL_B=
RANCHES",
+        "MetricGroup": "Bad;Branches;CodeGen;PGO",
+        "MetricName": "tma_info_cond_nt",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "L1MPKI",
+        "BriefDescription": "Fraction of branches that are taken condition=
als",
+        "MetricExpr": "BR_INST_RETIRED.COND_TAKEN / BR_INST_RETIRED.ALL_BR=
ANCHES",
+        "MetricGroup": "Bad;Branches;CodeGen;PGO",
+        "MetricName": "tma_info_cond_tk",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "L1 cache true misses per kilo instruction for=
 all demand loads (including speculative)",
-        "MetricExpr": "1e3 * L2_RQSTS.ALL_DEMAND_DATA_RD / INST_RETIRED.AN=
Y",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "L1MPKI_Load",
+        "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
+        "MetricExpr": "(100 * (1 - tma_core_bound / tma_ports_utilization =
if tma_core_bound < tma_ports_utilization else 1) if tma_info_smt_2t_utiliz=
ation > 0.5 else 0)",
+        "MetricGroup": "Cor;SMT",
+        "MetricName": "tma_info_core_bound_likely",
+        "MetricThreshold": "tma_info_core_bound_likely > 0.5",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
-        "MetricGroup": "Backend;CacheMisses;Mem",
-        "MetricName": "L2MPKI",
+        "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
+        "MetricExpr": "CPU_CLK_UNHALTED.DISTRIBUTED",
+        "MetricGroup": "SMT",
+        "MetricName": "tma_info_core_clks",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all request types (including speculative)",
-        "MetricExpr": "1e3 * L2_RQSTS.MISS / INST_RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem;Offcore",
-        "MetricName": "L2MPKI_All",
+        "BriefDescription": "Instructions Per Cycle across hyper-threads (=
per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / tma_info_core_clks",
+        "MetricGroup": "Ret;SMT;TmaL1;tma_L1_group",
+        "MetricName": "tma_info_coreipc",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all demand loads  (including speculative)",
-        "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_MISS / INST_RETIRED.A=
NY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "L2MPKI_Load",
+        "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
+        "MetricExpr": "1 / tma_info_ipc",
+        "MetricGroup": "Mem;Pipeline",
+        "MetricName": "tma_info_cpi",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "L2 cache hits per kilo instruction for all re=
quest types (including speculative)",
-        "MetricExpr": "1e3 * (L2_RQSTS.REFERENCES - L2_RQSTS.MISS) / INST_=
RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "L2HPKI_All",
+        "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricGroup": "HPC;Summary",
+        "MetricName": "tma_info_cpu_utilization",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "L2 cache hits per kilo instruction for all de=
mand loads  (including speculative)",
-        "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_HIT / INST_RETIRED.AN=
Y",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "L2HPKI_Load",
+        "BriefDescription": "Average Parallel L2 cache miss data reads",
+        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD / OFFCORE_=
REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
+        "MetricGroup": "Memory_BW;Offcore",
+        "MetricName": "tma_info_data_l2_mlp",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "L3MPKI",
+        "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
+        "MetricExpr": "64 * (UNC_ARB_TRK_REQUESTS.ALL + UNC_ARB_COH_TRK_RE=
QUESTS.ALL) / 1e6 / duration_time / 1e3",
+        "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
+        "MetricName": "tma_info_dram_bw_use",
+        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_fb_full, tma_info_memory_ba=
ndwidth, tma_mem_bandwidth, tma_sq_full",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
-        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.FB_HIT / INST_RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "FB_HPKI",
+        "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
+        "MetricExpr": "IDQ.DSB_UOPS / UOPS_ISSUED.ANY",
+        "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
+        "MetricName": "tma_info_dsb_coverage",
+        "MetricThreshold": "tma_info_dsb_coverage < 0.7 & tma_info_ipc / 6=
 > 0.35",
+        "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_dsb_misses, tma_info_iptb, tma_lcp",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
-        "MetricConstraint": "NO_NMI_WATCHDOG",
-        "MetricExpr": "(ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_P=
ENDING + DTLB_STORE_MISSES.WALK_PENDING) / (4 * CORE_CLKS)",
-        "MetricGroup": "Mem;MemoryTLB",
-        "MetricName": "Page_Walks_Utilization",
+        "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + =
tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb + tm=
a_lsd + tma_mite))",
+        "MetricGroup": "DSBmiss;Fed;tma_issueFB",
+        "MetricName": "tma_info_dsb_misses",
+        "MetricThreshold": "tma_info_dsb_misses > 10",
+        "PublicDescription": "Total pipeline cost of DSB (uop cache) misse=
s - subset of the Instruction_Fetch_BW Bottleneck. Related metrics: tma_dsb=
_switches, tma_fetch_bandwidth, tma_info_dsb_coverage, tma_info_iptb, tma_l=
cp",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / duration_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L1D_Cache_Fill_BW",
+        "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
.",
+        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / cpu_core@DSB2MIT=
E_SWITCHES.PENALTY_CYCLES\\,cmask\\=3D1\\,edge@",
+        "MetricGroup": "DSBmiss",
+        "MetricName": "tma_info_dsb_switch_cost",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / duration_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L2_Cache_Fill_BW",
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-thread",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu_core@UOPS_EXECUTED.THREA=
D\\,cmask\\=3D1@",
+        "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
+        "MetricName": "tma_info_execute",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / duration_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L3_Cache_Fill_BW",
+        "BriefDescription": "The ratio of Executed- by Issued-Uops",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / UOPS_ISSUED.ANY",
+        "MetricGroup": "Cor;Pipeline",
+        "MetricName": "tma_info_execute_per_issue",
+        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage.",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1e9 / duration=
_time",
-        "MetricGroup": "Mem;MemoryBW;Offcore",
-        "MetricName": "L3_Cache_Access_BW",
+        "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
+        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.FB_HIT / INST_RETIRED.ANY",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "tma_info_fb_hpki",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
-        "MetricExpr": "L1D_Cache_Fill_BW",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L1D_Cache_Fill_BW_1T",
+        "BriefDescription": "Average number of Uops issued by front-end wh=
en it issued something",
+        "MetricExpr": "UOPS_ISSUED.ANY / cpu_core@UOPS_ISSUED.ANY\\,cmask\=
\=3D1@",
+        "MetricGroup": "Fed;FetchBW",
+        "MetricName": "tma_info_fetch_upc",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
-        "MetricExpr": "L2_Cache_Fill_BW",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L2_Cache_Fill_BW_1T",
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 =
* (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PA=
CKED_DOUBLE) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) / tma_info_cor=
e_clks",
+        "MetricGroup": "Flops;Ret",
+        "MetricName": "tma_info_flopc",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "L3_Cache_Fill_BW",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L3_Cache_Fill_BW_1T",
+        "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(FP_ARITH_DISPATCHED.PORT_0 + FP_ARITH_DISPATCHED.P=
ORT_1 + FP_ARITH_DISPATCHED.PORT_5) / (2 * tma_info_core_clks)",
+        "MetricGroup": "Cor;Flops;HPC",
+        "MetricName": "tma_info_fp_arith_utilization",
+        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n).",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
-        "MetricExpr": "L3_Cache_Access_BW",
-        "MetricGroup": "Mem;MemoryBW;Offcore",
-        "MetricName": "L3_Cache_Access_BW_1T",
+        "BriefDescription": "Giga Floating Point Operations Per Second",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 =
* (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PA=
CKED_DOUBLE) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) / 1e9 / durati=
on_time",
+        "MetricGroup": "Cor;Flops;HPC",
+        "MetricName": "tma_info_gflops",
+        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine.",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average CPU Utilization",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
-        "MetricGroup": "HPC;Summary",
-        "MetricName": "CPU_Utilization",
+        "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses +=
 tma_lcp + tma_ms_switches))",
+        "MetricGroup": "Fed;FetchLat;IcMiss;tma_issueFL",
+        "MetricName": "tma_info_ic_misses",
+        "MetricThreshold": "tma_info_ic_misses > 5",
+        "PublicDescription": "Total pipeline cost of Instruction Cache mis=
ses - subset of the Big_Code Bottleneck. Related metrics: ",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Measured Average Frequency for unhalted proce=
ssors [GHz]",
-        "MetricExpr": "Turbo_Utilization * TSC / 1e9 / duration_time",
-        "MetricGroup": "Power;Summary",
-        "MetricName": "Average_Frequency",
+        "BriefDescription": "Average Latency for L1 instruction cache miss=
es",
+        "MetricExpr": "ICACHE_DATA.STALLS / cpu_core@ICACHE_DATA.STALLS\\,=
cmask\\=3D1\\,edge@",
+        "MetricGroup": "Fed;FetchLat;IcMiss",
+        "MetricName": "tma_info_icache_miss_latency",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 =
* (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PA=
CKED_DOUBLE) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) / 1e9 / durati=
on_time",
-        "MetricGroup": "Cor;Flops;HPC",
-        "MetricName": "GFLOPs",
-        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine.",
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
+        "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
+        "MetricName": "tma_info_ilp",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
-        "MetricExpr": "CLKS / CPU_CLK_UNHALTED.REF_TSC",
-        "MetricGroup": "Power",
-        "MetricName": "Turbo_Utilization",
+        "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks",
+        "MetricExpr": "100 * (tma_frontend_bound - tma_fetch_latency * tma=
_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icach=
e_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) - tma_info_big_cod=
e",
+        "MetricGroup": "Fed;FetchBW;Frontend",
+        "MetricName": "tma_info_instruction_fetch_bw",
+        "MetricThreshold": "tma_info_instruction_fetch_bw > 20",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
-        "MetricExpr": "(1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_U=
NHALTED.REF_DISTRIBUTED if #SMT_on else 0)",
-        "MetricGroup": "SMT",
-        "MetricName": "SMT_2T_Utilization",
+        "BriefDescription": "Total number of retired Instructions",
+        "MetricExpr": "INST_RETIRED.ANY",
+        "MetricGroup": "Summary;TmaL1;tma_L1_group",
+        "MetricName": "tma_info_instructions",
+        "PublicDescription": "Total number of retired Instructions. Sample=
 with: INST_RETIRED.PREC_DIST",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.THRE=
AD",
-        "MetricGroup": "OS",
-        "MetricName": "Kernel_Utilization",
+        "BriefDescription": "Instructions per FP Arithmetic instruction (l=
ower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / (cpu_core@FP_ARITH_INST_RETIRED.=
SCALAR_SINGLE\\,umask\\=3D0x03@ + cpu_core@FP_ARITH_INST_RETIRED.128B_PACKE=
D_DOUBLE\\,umask\\=3D0x3c@)",
+        "MetricGroup": "Flops;InsType",
+        "MetricName": "tma_info_iparith",
+        "MetricThreshold": "tma_info_iparith < 10",
+        "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). May undercount due to FMA doubl=
e counting. Approximated prior to BDW.",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
-        "MetricGroup": "OS",
-        "MetricName": "Kernel_CPI",
+        "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-bi=
t instruction (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.128B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE)",
+        "MetricGroup": "Flops;FpVector;InsType",
+        "MetricName": "tma_info_iparith_avx128",
+        "MetricThreshold": "tma_info_iparith_avx128 < 10",
+        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). May undercount =
due to FMA double counting.",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
-        "MetricExpr": "64 * (UNC_ARB_TRK_REQUESTS.ALL + UNC_ARB_COH_TRK_RE=
QUESTS.ALL) / 1e6 / duration_time / 1e3",
-        "MetricGroup": "HPC;Mem;MemoryBW;SoC",
-        "MetricName": "DRAM_BW_Use",
+        "BriefDescription": "Instructions per FP Arithmetic AVX* 256-bit i=
nstruction (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.256B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE)",
+        "MetricGroup": "Flops;FpVector;InsType",
+        "MetricName": "tma_info_iparith_avx256",
+        "MetricThreshold": "tma_info_iparith_avx256 < 10",
+        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). May undercount due=
 to FMA double counting.",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average number of parallel requests to extern=
al memory. Accounts for all requests",
-        "MetricExpr": "UNC_ARB_TRK_OCCUPANCY.ALL / UNC_ARB_TRK_REQUESTS.AL=
L",
-        "MetricGroup": "Mem;SoC",
-        "MetricName": "MEM_Parallel_Requests",
+        "BriefDescription": "Instructions per FP Arithmetic Scalar Double-=
Precision instruction (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED.SCALAR_DOU=
BLE",
+        "MetricGroup": "Flops;FpScalar;InsType",
+        "MetricName": "tma_info_iparith_scalar_dp",
+        "MetricThreshold": "tma_info_iparith_scalar_dp < 10",
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). May und=
ercount due to FMA double counting.",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Socket actual clocks when any core is active =
on that socket",
-        "MetricExpr": "UNC_CLOCK.SOCKET",
-        "MetricGroup": "SoC",
-        "MetricName": "Socket_CLKS",
+        "BriefDescription": "Instructions per FP Arithmetic Scalar Single-=
Precision instruction (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED.SCALAR_SIN=
GLE",
+        "MetricGroup": "Flops;FpScalar;InsType",
+        "MetricName": "tma_info_iparith_scalar_sp",
+        "MetricThreshold": "tma_info_iparith_scalar_sp < 10",
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). May und=
ercount due to FMA double counting.",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
-        "MetricGroup": "Branches;OS",
-        "MetricName": "IpFarBranch",
+        "BriefDescription": "Instructions per a microcode Assist invocatio=
n",
+        "MetricExpr": "INST_RETIRED.ANY / cpu_core@ASSISTS.ANY\\,umask\\=
=3D0x1B@",
+        "MetricGroup": "Pipeline;Ret;Retire",
+        "MetricName": "tma_info_ipassist",
+        "MetricThreshold": "tma_info_ipassist < 100e3",
+        "PublicDescription": "Instructions per a microcode Assist invocati=
on. See Assists tree node for details (lower number means higher occurrence=
 rate)",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Uncore frequency per die [GHZ]",
-        "MetricExpr": "Socket_CLKS / #num_dies / duration_time / 1e9",
-        "MetricGroup": "SoC",
-        "MetricName": "UNCORE_FREQ"
+        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Branches;Fed;InsType",
+        "MetricName": "tma_info_ipbranch",
+        "MetricThreshold": "tma_info_ipbranch < 8",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to frontend stalls.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.ALL / SLOTS",
-        "MetricGroup": "TopdownL1",
-        "MetricName": "tma_frontend_bound",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
+        "MetricExpr": "INST_RETIRED.ANY / tma_info_clks",
+        "MetricGroup": "Ret;Summary",
+        "MetricName": "tma_info_ipc",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to frontend bandwidth restrictions due to =
decode, predecode, cisc, and other limitations.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY / SLOTS",
-        "MetricGroup": "TopdownL2;tma_frontend_bound_group",
-        "MetricName": "tma_frontend_latency",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Instructions per (near) call (lower number me=
ans higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
+        "MetricGroup": "Branches;Fed;PGO",
+        "MetricName": "tma_info_ipcall",
+        "MetricThreshold": "tma_info_ipcall < 200",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to instruction cache misses.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.ICACHE / SLOTS",
-        "MetricGroup": "TopdownL3;tma_frontend_latency_group",
-        "MetricName": "tma_icache",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Instructions per non-speculative DSB miss (lo=
wer number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / FRONTEND_RETIRED.ANY_DSB_MISS",
+        "MetricGroup": "DSBmiss;Fed",
+        "MetricName": "tma_info_ipdsb_miss_ret",
+        "MetricThreshold": "tma_info_ipdsb_miss_ret < 50",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to Instruction Table Lookaside Buffer (ITL=
B) misses.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.ITLB / SLOTS",
-        "MetricGroup": "TopdownL3;tma_frontend_latency_group",
-        "MetricName": "tma_itlb",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
+        "MetricGroup": "Branches;OS",
+        "MetricName": "tma_info_ipfarbranch",
+        "MetricThreshold": "tma_info_ipfarbranch < 1e6",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to BACLEARS, which occurs when the Branch =
Target Buffer (BTB) prediction or lack thereof, was corrected by a later br=
anch predictor in the frontend",
-        "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_DETECT / SLOTS",
-        "MetricGroup": "TopdownL3;tma_frontend_latency_group",
-        "MetricName": "tma_branch_detect",
-        "PublicDescription": "Counts the number of issue slots  that were =
not delivered by the frontend due to BACLEARS, which occurs when the Branch=
 Target Buffer (BTB) prediction or lack thereof, was corrected by a later b=
ranch predictor in the frontend. Includes BACLEARS due to all branch types =
including conditional and unconditional jumps, returns, and indirect branch=
es.",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Instructions per Floating Point (FP) Operatio=
n (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR_SI=
NGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE + 2 * FP_ARITH_INST_RETIRED.128B=
_PACKED_DOUBLE + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_I=
NST_RETIRED.256B_PACKED_DOUBLE) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SIN=
GLE)",
+        "MetricGroup": "Flops;InsType",
+        "MetricName": "tma_info_ipflop",
+        "MetricThreshold": "tma_info_ipflop < 10",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to BTCLEARS, which occurs when the Branch =
Target Buffer (BTB) predicts a taken branch.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_RESTEER / SLOTS",
-        "MetricGroup": "TopdownL3;tma_frontend_latency_group",
-        "MetricName": "tma_branch_resteer",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Instructions per Load (lower number means hig=
her occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_LOADS",
+        "MetricGroup": "InsType",
+        "MetricName": "tma_info_ipload",
+        "MetricThreshold": "tma_info_ipload < 3",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to frontend bandwidth restrictions due to =
decode, predecode, cisc, and other limitations.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH / SLOTS",
-        "MetricGroup": "TopdownL2;tma_frontend_bound_group",
-        "MetricName": "tma_frontend_bandwidth",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Instructions per retired mispredicts for cond=
itional non-taken branches (lower number means higher occurrence rate).",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_NTAKEN",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "tma_info_ipmisp_cond_ntaken",
+        "MetricThreshold": "tma_info_ipmisp_cond_ntaken < 200",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to the microcode sequencer (MS).",
-        "MetricExpr": "TOPDOWN_FE_BOUND.CISC / SLOTS",
-        "MetricGroup": "TopdownL3;tma_frontend_bandwidth_group",
-        "MetricName": "tma_cisc",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Instructions per retired mispredicts for cond=
itional taken branches (lower number means higher occurrence rate).",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_TAKEN",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "tma_info_ipmisp_cond_taken",
+        "MetricThreshold": "tma_info_ipmisp_cond_taken < 200",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to decode stalls.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.DECODE / SLOTS",
-        "MetricGroup": "TopdownL3;tma_frontend_bandwidth_group",
-        "MetricName": "tma_decode",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Instructions per retired mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
+        "MetricExpr": "cpu_core@BR_MISP_RETIRED.INDIRECT_CALL\\,umask\\=3D=
0x80@ / BR_MISP_RETIRED.INDIRECT",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "tma_info_ipmisp_indirect",
+        "MetricThreshold": "tma_info_ipmisp_indirect < 1e3",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to wrong predecodes.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.PREDECODE / SLOTS",
-        "MetricGroup": "TopdownL3;tma_frontend_bandwidth_group",
-        "MetricName": "tma_predecode",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Instructions per retired mispredicts for retu=
rn branches (lower number means higher occurrence rate).",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.RET",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "tma_info_ipmisp_ret",
+        "MetricThreshold": "tma_info_ipmisp_ret < 500",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to other common frontend stalls not catego=
rized.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.OTHER / SLOTS",
-        "MetricGroup": "TopdownL3;tma_frontend_bandwidth_group",
-        "MetricName": "tma_other_fb",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts",
+        "MetricName": "tma_info_ipmispredict",
+        "MetricThreshold": "tma_info_ipmispredict < 200",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a misp=
redicted jump or a machine clear",
-        "MetricExpr": "(SLOTS - (TOPDOWN_FE_BOUND.ALL + TOPDOWN_BE_BOUND.A=
LL + TOPDOWN_RETIRING.ALL)) / SLOTS",
-        "MetricGroup": "TopdownL1",
-        "MetricName": "tma_bad_speculation",
-        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window including r=
elevant microcode flows and while uops are not yet available in the instruc=
tion queue (IQ). Also includes the issue slots that were consumed by the ba=
ckend but were thrown away because they were younger than the mispredict or=
 machine clear.",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Instructions per Store (lower number means hi=
gher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_STORES",
+        "MetricGroup": "InsType",
+        "MetricName": "tma_info_ipstore",
+        "MetricThreshold": "tma_info_ipstore < 8",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to branch mispredicts.",
-        "MetricExpr": "TOPDOWN_BAD_SPECULATION.MISPREDICT / SLOTS",
-        "MetricGroup": "TopdownL2;tma_bad_speculation_group",
-        "MetricName": "tma_branch_mispredicts",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Instructions per Software prefetch instructio=
n (of any type: NTA/T0/T1/T2/Prefetch) (lower number means higher occurrenc=
e rate)",
+        "MetricExpr": "INST_RETIRED.ANY / cpu_core@SW_PREFETCH_ACCESS.T0\\=
,umask\\=3D0xF@",
+        "MetricGroup": "Prefetches",
+        "MetricName": "tma_info_ipswpf",
+        "MetricThreshold": "tma_info_ipswpf < 100",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a mach=
ine clear (nuke) of any kind including memory ordering and memory disambigu=
ation.",
-        "MetricExpr": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS / SLOTS",
-        "MetricGroup": "TopdownL2;tma_bad_speculation_group",
-        "MetricName": "tma_machine_clears",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Instruction per taken branch",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
+        "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO;tma_issueFB",
+        "MetricName": "tma_info_iptb",
+        "MetricThreshold": "tma_info_iptb < 13",
+        "PublicDescription": "Instruction per taken branch. Related metric=
s: tma_dsb_switches, tma_fetch_bandwidth, tma_info_dsb_coverage, tma_info_d=
sb_misses, tma_lcp",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to a machine clear (slow nuke).",
-        "MetricExpr": "TOPDOWN_BAD_SPECULATION.NUKE / SLOTS",
-        "MetricGroup": "TopdownL3;tma_machine_clears_group",
-        "MetricName": "tma_nuke",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Instructions per speculative Unknown Branch M=
isprediction (BAClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "tma_info_instructions / BACLEARS.ANY",
+        "MetricGroup": "Fed",
+        "MetricName": "tma_info_ipunknown_branch",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to SMC. ",
-        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.SMC / MACHINE_CLEARS.SLO=
W)",
-        "MetricGroup": "TopdownL4;tma_nuke_group",
-        "MetricName": "tma_smc",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Fraction of branches that are unconditional (=
direct or indirect) jumps",
+        "MetricExpr": "(BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.COND_=
TAKEN - 2 * BR_INST_RETIRED.NEAR_CALL) / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;Branches",
+        "MetricName": "tma_info_jump",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to memory ordering. ",
-        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.MEMORY_ORDERING / MACHIN=
E_CLEARS.SLOW)",
-        "MetricGroup": "TopdownL4;tma_nuke_group",
-        "MetricName": "tma_memory_ordering",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
+        "MetricGroup": "OS",
+        "MetricName": "tma_info_kernel_cpi",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to FP assists. ",
-        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.FP_ASSIST / MACHINE_CLEA=
RS.SLOW)",
-        "MetricGroup": "TopdownL4;tma_nuke_group",
-        "MetricName": "tma_fp_assist",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.THRE=
AD",
+        "MetricGroup": "OS",
+        "MetricName": "tma_info_kernel_utilization",
+        "MetricThreshold": "tma_info_kernel_utilization > 0.05",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to memory disambiguation. ",
-        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.DISAMBIGUATION / MACHINE=
_CLEARS.SLOW)",
-        "MetricGroup": "TopdownL4;tma_nuke_group",
-        "MetricName": "tma_disambiguation",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / duration_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_l1d_cache_fill_bw",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to page faults. ",
-        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.PAGE_FAULT / MACHINE_CLE=
ARS.SLOW)",
-        "MetricGroup": "TopdownL4;tma_nuke_group",
-        "MetricName": "tma_page_fault",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
+        "MetricExpr": "tma_info_l1d_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_l1d_cache_fill_bw_1t",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to a machine clear classified as a fast nuke=
 due to memory ordering, memory disambiguation and memory renaming.",
-        "MetricExpr": "TOPDOWN_BAD_SPECULATION.FASTNUKE / SLOTS",
-        "MetricGroup": "TopdownL3;tma_machine_clears_group",
-        "MetricName": "tma_fast_nuke",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "tma_info_l1mpki",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the total number of issue slots  that =
were not consumed by the backend due to backend stalls",
-        "MetricExpr": "TOPDOWN_BE_BOUND.ALL / SLOTS",
-        "MetricGroup": "TopdownL1",
-        "MetricName": "tma_backend_bound",
-        "PublicDescription": "Counts the total number of issue slots  that=
 were not consumed by the backend due to backend stalls.  Note that uops mu=
st be available for consumption in order for this event to count.  If a uop=
 is not available (IQ is empty), this event will not count.   The rest of t=
hese subevents count backend stalls, in cycles, due to an outstanding reque=
st which is memory bound vs core bound.   The subevents are not slot based =
events and therefore can not be precisely added or subtracted from the Back=
end_Bound_Aux subevents which are slot based.",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "L1 cache true misses per kilo instruction for=
 all demand loads (including speculative)",
+        "MetricExpr": "1e3 * L2_RQSTS.ALL_DEMAND_DATA_RD / INST_RETIRED.AN=
Y",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "tma_info_l1mpki_load",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of cycles due to backend bo=
und stalls that are core execution bound and not attributed to outstanding =
demand load or store stalls. ",
-        "MetricExpr": "max(0, tma_backend_bound - tma_load_store_bound)",
-        "MetricGroup": "TopdownL2;tma_backend_bound_group",
-        "MetricName": "tma_core_bound",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / duration_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_l2_cache_fill_bw",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to stores or loads. ",
-        "MetricExpr": "min(tma_backend_bound, LD_HEAD.ANY_AT_RET / CLKS + =
tma_store_bound)",
-        "MetricGroup": "TopdownL2;tma_backend_bound_group",
-        "MetricName": "tma_load_store_bound",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
+        "MetricExpr": "tma_info_l2_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_l2_cache_fill_bw_1t",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to store buffer full.",
-        "MetricExpr": "tma_st_buffer",
-        "MetricGroup": "TopdownL3;tma_load_store_bound_group",
-        "MetricName": "tma_store_bound",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "L2 cache hits per kilo instruction for all re=
quest types (including speculative)",
+        "MetricExpr": "1e3 * (L2_RQSTS.REFERENCES - L2_RQSTS.MISS) / INST_=
RETIRED.ANY",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "tma_info_l2hpki_all",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a load block.",
-        "MetricExpr": "LD_HEAD.L1_BOUND_AT_RET / CLKS",
-        "MetricGroup": "TopdownL3;tma_load_store_bound_group",
-        "MetricName": "tma_l1_bound",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "L2 cache hits per kilo instruction for all de=
mand loads  (including speculative)",
+        "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_HIT / INST_RETIRED.AN=
Y",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "tma_info_l2hpki_load",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a store forward bloc=
k.",
-        "MetricExpr": "LD_HEAD.ST_ADDR_AT_RET / CLKS",
-        "MetricGroup": "TopdownL4;tma_l1_bound_group",
-        "MetricName": "tma_store_fwd",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Backend;CacheMisses;Mem",
+        "MetricName": "tma_info_l2mpki",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a first level TLB mi=
ss.",
-        "MetricExpr": "LD_HEAD.DTLB_MISS_AT_RET / CLKS",
-        "MetricGroup": "TopdownL4;tma_l1_bound_group",
-        "MetricName": "tma_stlb_hit",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all request types (including speculative)",
+        "MetricExpr": "1e3 * L2_RQSTS.MISS / INST_RETIRED.ANY",
+        "MetricGroup": "CacheMisses;Mem;Offcore",
+        "MetricName": "tma_info_l2mpki_all",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a second level TLB m=
iss requiring a page walk.",
-        "MetricExpr": "LD_HEAD.PGWALK_AT_RET / CLKS",
-        "MetricGroup": "TopdownL4;tma_l1_bound_group",
-        "MetricName": "tma_stlb_miss",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "L2 cache true code cacheline misses per kilo =
instruction",
+        "MetricExpr": "1e3 * FRONTEND_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "IcMiss",
+        "MetricName": "tma_info_l2mpki_code",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a number of other lo=
ad blocks.",
-        "MetricExpr": "LD_HEAD.OTHER_AT_RET / CLKS",
-        "MetricGroup": "TopdownL4;tma_l1_bound_group",
-        "MetricName": "tma_other_l1",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "L2 cache speculative code cacheline misses pe=
r kilo instruction",
+        "MetricExpr": "1e3 * L2_RQSTS.CODE_RD_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "IcMiss",
+        "MetricName": "tma_info_l2mpki_code_all",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of cycles a core is stalled=
 due to a demand load which hit in the L2 Cache.",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_L2_HIT / CLKS - MEM_BOUND_STA=
LLS_AT_RET_CORRECTION * MEM_BOUND_STALLS.LOAD_L2_HIT / MEM_BOUND_STALLS.LOA=
D",
-        "MetricGroup": "TopdownL3;tma_load_store_bound_group",
-        "MetricName": "tma_l2_bound",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all demand loads  (including speculative)",
+        "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_MISS / INST_RETIRED.A=
NY",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "tma_info_l2mpki_load",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of cycles a core is stalled=
 due to a demand load which hit in the Last Level Cache (LLC) or other core=
 with HITE/F/M.",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_LLC_HIT / CLKS - MEM_BOUND_ST=
ALLS_AT_RET_CORRECTION * MEM_BOUND_STALLS.LOAD_LLC_HIT / MEM_BOUND_STALLS.L=
OAD",
-        "MetricGroup": "TopdownL3;tma_load_store_bound_group",
-        "MetricName": "tma_l3_bound",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
+        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1e9 / duration=
_time",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "tma_info_l3_cache_access_bw",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load miss which hit in DRAM or MMIO (Non-DRAM).",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_DRAM_HIT / CLKS - MEM_BOUND_S=
TALLS_AT_RET_CORRECTION * MEM_BOUND_STALLS.LOAD_DRAM_HIT / MEM_BOUND_STALLS=
.LOAD",
-        "MetricGroup": "TopdownL3;tma_load_store_bound_group",
-        "MetricName": "tma_dram_bound",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
+        "MetricExpr": "tma_info_l3_cache_access_bw",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "tma_info_l3_cache_access_bw_1t",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load miss which hits in the L2, LLC, DRAM or MMIO (Non-D=
RAM) but could not be correctly attributed or cycles in which the load miss=
 is waiting on a request buffer.",
-        "MetricExpr": "max(0, tma_load_store_bound - (tma_store_bound + tm=
a_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound))",
-        "MetricGroup": "TopdownL3;tma_load_store_bound_group",
-        "MetricName": "tma_other_load_store",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / duration_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_l3_cache_fill_bw",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the total number of issue slots  that =
were not consumed by the backend due to backend stalls",
-        "MetricExpr": "tma_backend_bound",
-        "MetricGroup": "TopdownL1",
-        "MetricName": "tma_backend_bound_aux",
-        "PublicDescription": "Counts the total number of issue slots  that=
 were not consumed by the backend due to backend stalls.  Note that UOPS mu=
st be available for consumption in order for this event to count.  If a uop=
 is not available (IQ is empty), this event will not count.  All of these s=
ubevents count backend stalls, in slots, due to a resource limitation.   Th=
ese are not cycle based events and therefore can not be precisely added or =
subtracted from the Backend_Bound subevents which are cycle based.  These s=
ubevents are supplementary to Backend_Bound and can be used to analyze resu=
lts from a resource perspective at allocation.  ",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
+        "MetricExpr": "tma_info_l3_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_l3_cache_fill_bw_1t",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the total number of issue slots  that =
were not consumed by the backend due to backend stalls",
-        "MetricExpr": "tma_backend_bound",
-        "MetricGroup": "TopdownL2;tma_backend_bound_aux_group",
-        "MetricName": "tma_resource_bound",
-        "PublicDescription": "Counts the total number of issue slots  that=
 were not consumed by the backend due to backend stalls.  Note that uops mu=
st be available for consumption in order for this event to count.  If a uop=
 is not available (IQ is empty), this event will not count. ",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "tma_info_l3mpki",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to memory reservation stalls in which a sche=
duler is not able to accept uops.",
-        "MetricExpr": "TOPDOWN_BE_BOUND.MEM_SCHEDULER / SLOTS",
-        "MetricGroup": "TopdownL3;tma_resource_bound_group",
-        "MetricName": "tma_mem_scheduler",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Average Latency for L2 cache miss demand Load=
s",
+        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS.DEMAND_DATA_RD",
+        "MetricGroup": "Memory_Lat;Offcore",
+        "MetricName": "tma_info_load_l2_miss_latency",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of cycles, relative to the =
number of mem_scheduler slots, in which uops are blocked due to store buffe=
r full",
-        "MetricExpr": "tma_mem_scheduler * (MEM_SCHEDULER_BLOCK.ST_BUF / M=
EM_SCHEDULER_BLOCK.ALL)",
-        "MetricGroup": "TopdownL4;tma_mem_scheduler_group",
-        "MetricName": "tma_st_buffer",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Average Parallel L2 cache miss demand Loads",
+        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / cpu_c=
ore@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,cmask\\=3D1@",
+        "MetricGroup": "Memory_BW;Offcore",
+        "MetricName": "tma_info_load_l2_mlp",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of cycles, relative to the =
number of mem_scheduler slots, in which uops are blocked due to load buffer=
 full",
-        "MetricExpr": "tma_mem_scheduler * MEM_SCHEDULER_BLOCK.LD_BUF / ME=
M_SCHEDULER_BLOCK.ALL",
-        "MetricGroup": "TopdownL4;tma_mem_scheduler_group",
-        "MetricName": "tma_ld_buffer",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Average Latency for L3 cache miss demand Load=
s",
+        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAND_DATA_RD=
 / OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
+        "MetricGroup": "Memory_Lat;Offcore",
+        "MetricName": "tma_info_load_l3_miss_latency",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of cycles, relative to the =
number of mem_scheduler slots, in which uops are blocked due to RSV full re=
lative ",
-        "MetricExpr": "tma_mem_scheduler * MEM_SCHEDULER_BLOCK.RSV / MEM_S=
CHEDULER_BLOCK.ALL",
-        "MetricGroup": "TopdownL4;tma_mem_scheduler_group",
-        "MetricName": "tma_rsv",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / MEM_LOAD_COMPLETED.L1_MISS_=
ANY",
+        "MetricGroup": "Mem;MemoryBound;MemoryLat",
+        "MetricName": "tma_info_load_miss_real_latency",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to IEC or FPC RAT stalls, which can be due t=
o FIQ or IEC reservation stalls in which the integer, floating point or SIM=
D scheduler is not able to accept uops.",
-        "MetricExpr": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER / SLOTS",
-        "MetricGroup": "TopdownL3;tma_resource_bound_group",
-        "MetricName": "tma_non_mem_scheduler",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "STLB (2nd level TLB) data load speculative mi=
sses per kilo instruction (misses of any page-size that complete the page w=
alk)",
+        "MetricExpr": "1e3 * DTLB_LOAD_MISSES.WALK_COMPLETED / INST_RETIRE=
D.ANY",
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_load_stlb_mpki",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to the physical register file unable to acce=
pt an entry (marble stalls).",
-        "MetricExpr": "TOPDOWN_BE_BOUND.REGISTER / SLOTS",
-        "MetricGroup": "TopdownL3;tma_resource_bound_group",
-        "MetricName": "tma_register",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Fraction of Uops delivered by the LSD (Loop S=
tream Detector; aka Loop Cache)",
+        "MetricExpr": "LSD.UOPS / UOPS_ISSUED.ANY",
+        "MetricGroup": "Fed;LSD",
+        "MetricName": "tma_info_lsd_coverage",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to the reorder buffer being full (ROB stalls=
).",
-        "MetricExpr": "TOPDOWN_BE_BOUND.REORDER_BUFFER / SLOTS",
-        "MetricGroup": "TopdownL3;tma_resource_bound_group",
-        "MetricName": "tma_reorder_buffer",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Average number of parallel data read requests=
 to external memory",
+        "MetricExpr": "UNC_ARB_DAT_OCCUPANCY.RD / cpu_core@UNC_ARB_DAT_OCC=
UPANCY.RD\\,cmask\\=3D1@",
+        "MetricGroup": "Mem;MemoryBW;SoC",
+        "MetricName": "tma_info_mem_parallel_reads",
+        "PublicDescription": "Average number of parallel data read request=
s to external memory. Accounts for demand loads and L1/L2 prefetches",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to certain allocation restrictions.",
-        "MetricExpr": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS / SLOTS",
-        "MetricGroup": "TopdownL3;tma_resource_bound_group",
-        "MetricName": "tma_alloc_restriction",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Average latency of data read request to exter=
nal memory (in nanoseconds)",
+        "MetricExpr": "(UNC_ARB_TRK_OCCUPANCY.RD + UNC_ARB_DAT_OCCUPANCY.R=
D) / UNC_ARB_TRK_REQUESTS.RD",
+        "MetricGroup": "Mem;MemoryLat;SoC",
+        "MetricName": "tma_info_mem_read_latency",
+        "PublicDescription": "Average latency of data read request to exte=
rnal memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetche=
s. ([RKL+]memory-controller only)",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to scoreboards from the instruction queue (I=
Q), jump execution unit (JEU), or microcode sequencer (MS).",
-        "MetricExpr": "TOPDOWN_BE_BOUND.SERIALIZATION / SLOTS",
-        "MetricGroup": "TopdownL3;tma_resource_bound_group",
-        "MetricName": "tma_serialization",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Average latency of all requests to external m=
emory (in Uncore cycles)",
+        "MetricExpr": "(UNC_ARB_TRK_OCCUPANCY.ALL + UNC_ARB_DAT_OCCUPANCY.=
RD) / UNC_ARB_TRK_REQUESTS.ALL",
+        "MetricGroup": "Mem;SoC",
+        "MetricName": "tma_info_mem_request_latency",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the numer of issue slots  that result =
in retirement slots. ",
-        "MetricExpr": "TOPDOWN_RETIRING.ALL / SLOTS",
-        "MetricGroup": "TopdownL1",
-        "MetricName": "tma_retiring",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
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
+        "MetricName": "tma_info_memory_bandwidth",
+        "MetricThreshold": "tma_info_memory_bandwidth > 20",
+        "PublicDescription": "Total pipeline cost of (external) Memory Ban=
dwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_dram_bw_=
use, tma_mem_bandwidth, tma_sq_full",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of uops that are not from t=
he microsequencer. ",
-        "MetricExpr": "(TOPDOWN_RETIRING.ALL - UOPS_RETIRED.MS) / SLOTS",
-        "MetricGroup": "TopdownL2;tma_retiring_group",
-        "MetricName": "tma_base",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
+        "MetricExpr": "100 * tma_memory_bound * (tma_l1_bound / max(tma_me=
mory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + t=
ma_store_bound) * (tma_dtlb_load / max(tma_l1_bound, tma_dtlb_load + tma_fb=
_full + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_stor=
e_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tm=
a_store_bound) * (tma_dtlb_store / (tma_dtlb_store + tma_false_sharing + tm=
a_split_stores + tma_store_latency + tma_streaming_stores)))",
+        "MetricGroup": "Mem;MemoryTLB;Offcore;tma_issueTLB",
+        "MetricName": "tma_info_memory_data_tlbs",
+        "MetricThreshold": "tma_info_memory_data_tlbs > 20",
+        "PublicDescription": "Total pipeline cost of Memory Address Transl=
ation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_load,=
 tma_dtlb_store",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of floating point operation=
s per uop with all default weighting.",
-        "MetricExpr": "UOPS_RETIRED.FPDIV / SLOTS",
-        "MetricGroup": "TopdownL3;tma_base_group",
-        "MetricName": "tma_fp_uops",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Total pipeline cost of Memory Latency related=
 bottlenecks (external memory and off-core caches)",
+        "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (=
tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_l3_bound / (=
tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bou=
nd) * (tma_l3_hit_latency / (tma_contested_accesses + tma_data_sharing + tm=
a_l3_hit_latency + tma_sq_full)) + tma_l2_bound / (tma_dram_bound + tma_l1_=
bound + tma_l2_bound + tma_l3_bound + tma_store_bound))",
+        "MetricGroup": "Mem;MemoryLat;Offcore;tma_issueLat",
+        "MetricName": "tma_info_memory_latency",
+        "MetricThreshold": "tma_info_memory_latency > 20",
+        "PublicDescription": "Total pipeline cost of Memory Latency relate=
d bottlenecks (external memory and off-core caches). Related metrics: tma_l=
3_hit_latency, tma_mem_latency",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of uops retired excluding m=
s and fp div uops.",
-        "MetricExpr": "(TOPDOWN_RETIRING.ALL - UOPS_RETIRED.MS - UOPS_RETI=
RED.FPDIV) / SLOTS",
-        "MetricGroup": "TopdownL3;tma_base_group",
-        "MetricName": "tma_other_ret",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
+        "MetricExpr": "100 * (tma_branch_mispredicts + tma_fetch_latency *=
 tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_i=
cache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts;tma_issueBM",
+        "MetricName": "tma_info_mispredictions",
+        "MetricThreshold": "tma_info_mispredictions > 20",
+        "PublicDescription": "Total pipeline cost of Branch Misprediction =
related bottlenecks. Related metrics: tma_branch_mispredicts, tma_info_bran=
ch_misprediction_cost, tma_mispredicts_resteers",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of uops that are from the c=
omplex flows issued by the micro-sequencer (MS)",
-        "MetricExpr": "UOPS_RETIRED.MS / SLOTS",
-        "MetricGroup": "TopdownL2;tma_retiring_group",
-        "MetricName": "tma_ms_uops",
-        "PublicDescription": "Counts the number of uops that are from the =
complex flows issued by the micro-sequencer (MS).  This includes uops from =
flows due to complex instructions, faults, assists, and inserted flows.",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLE=
S",
+        "MetricGroup": "Mem;MemoryBW;MemoryBound",
+        "MetricName": "tma_info_mlp",
+        "PublicDescription": "Memory-Level-Parallelism (average number of =
L1 miss demand load when there is at least one such miss. Per-Logical Proce=
ssor)",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "",
-        "MetricExpr": "CPU_CLK_UNHALTED.CORE",
-        "MetricName": "CLKS",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Fraction of branches of other types (not indi=
vidually covered by other metrics in Info.Branches group)",
+        "MetricExpr": "1 - (tma_info_cond_nt + tma_info_cond_tk + tma_info=
_callret + tma_info_jump)",
+        "MetricGroup": "Bad;Branches",
+        "MetricName": "tma_info_other_branches",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "",
-        "MetricExpr": "CPU_CLK_UNHALTED.CORE_P",
-        "MetricName": "CLKS_P",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
+        "MetricExpr": "(ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_P=
ENDING + DTLB_STORE_MISSES.WALK_PENDING) / (4 * tma_info_core_clks)",
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_page_walks_utilization",
+        "MetricThreshold": "tma_info_page_walks_utilization > 0.5",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "",
-        "MetricExpr": "5 * CLKS",
-        "MetricName": "SLOTS",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
+        "MetricExpr": "tma_retiring * tma_info_slots / cpu_core@UOPS_RETIR=
ED.SLOTS\\,cmask\\=3D1@",
+        "MetricGroup": "Pipeline;Ret",
+        "MetricName": "tma_info_retire",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions Per Cycle",
-        "MetricExpr": "INST_RETIRED.ANY / CLKS",
-        "MetricName": "IPC",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
+        "MetricExpr": "TOPDOWN.SLOTS",
+        "MetricGroup": "TmaL1;tma_L1_group",
+        "MetricName": "tma_info_slots",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Cycles Per Instruction",
-        "MetricExpr": "CLKS / INST_RETIRED.ANY",
-        "MetricName": "CPI",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Fraction of Physical Core issue-slots utilize=
d by this Logical Processor",
+        "MetricExpr": "(tma_info_slots / (TOPDOWN.SLOTS / 2) if #SMT_on el=
se 1)",
+        "MetricGroup": "SMT;TmaL1;tma_L1_group",
+        "MetricName": "tma_info_slots_utilization",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Uops Per Instruction",
-        "MetricExpr": "UOPS_RETIRED.ALL / INST_RETIRED.ANY",
-        "MetricName": "UPI",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
+        "MetricExpr": "(1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_U=
NHALTED.REF_DISTRIBUTED if #SMT_on else 0)",
+        "MetricGroup": "SMT",
+        "MetricName": "tma_info_smt_2t_utilization",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Percentage of total non-speculative loads wit=
h a store forward or unknown store address block",
-        "MetricExpr": "100 * LD_BLOCKS.DATA_UNKNOWN / MEM_UOPS_RETIRED.ALL=
_LOADS",
-        "MetricName": "Store_Fwd_Blocks",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Socket actual clocks when any core is active =
on that socket",
+        "MetricExpr": "UNC_CLOCK.SOCKET",
+        "MetricGroup": "SoC",
+        "MetricName": "tma_info_socket_clks",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Percentage of total non-speculative loads wit=
h a address aliasing block",
-        "MetricExpr": "100 * LD_BLOCKS.4K_ALIAS / MEM_UOPS_RETIRED.ALL_LOA=
DS",
-        "MetricName": "Address_Alias_Blocks",
-        "Unit": "cpu_atom"
+        "BriefDescription": "STLB (2nd level TLB) data store speculative m=
isses per kilo instruction (misses of any page-size that complete the page =
walk)",
+        "MetricExpr": "1e3 * DTLB_STORE_MISSES.WALK_COMPLETED / INST_RETIR=
ED.ANY",
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_store_stlb_mpki",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Percentage of total non-speculative loads tha=
t are splits",
-        "MetricExpr": "100 * MEM_UOPS_RETIRED.SPLIT_LOADS / MEM_UOPS_RETIR=
ED.ALL_LOADS",
-        "MetricName": "Load_Splits",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Estimated fraction of retirement-cycles deali=
ng with repeat instructions",
+        "MetricExpr": "INST_RETIRED.REP_ITERATION / cpu_core@UOPS_RETIRED.=
SLOTS\\,cmask\\=3D1@",
+        "MetricGroup": "Pipeline;Ret",
+        "MetricName": "tma_info_strings_cycles",
+        "MetricThreshold": "tma_info_strings_cycles > 0.1",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurance rate)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
-        "MetricName": "IpBranch",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
+        "MetricExpr": "tma_info_clks / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricGroup": "Power",
+        "MetricName": "tma_info_turbo_utilization",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instruction per (near) call (lower number mea=
ns higher occurance rate)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.CALL",
-        "MetricName": "IpCall",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Uops Per Instruction",
+        "MetricExpr": "tma_retiring * tma_info_slots / INST_RETIRED.ANY",
+        "MetricGroup": "Pipeline;Ret;Retire",
+        "MetricName": "tma_info_uoppi",
+        "MetricThreshold": "tma_info_uoppi > 1.05",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per Load",
-        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_LOADS",
-        "MetricName": "IpLoad",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Instruction per taken branch",
+        "MetricExpr": "tma_retiring * tma_info_slots / BR_INST_RETIRED.NEA=
R_TAKEN",
+        "MetricGroup": "Branches;Fed;FetchBW",
+        "MetricName": "tma_info_uptb",
+        "MetricThreshold": "tma_info_uptb < 9",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per Store",
-        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_STORES",
-        "MetricName": "IpStore",
-        "Unit": "cpu_atom"
+        "BriefDescription": "This metric represents overall Integer (Int) =
select operations fraction the CPU has executed (retired)",
+        "MetricExpr": "tma_int_vector_128b + tma_int_vector_256b + tma_shu=
ffles",
+        "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
+        "MetricName": "tma_int_operations",
+        "MetricThreshold": "tma_int_operations > 0.1 & tma_light_operation=
s > 0.6",
+        "PublicDescription": "This metric represents overall Integer (Int)=
 select operations fraction the CPU has executed (retired). Vector/Matrix I=
nt operations and shuffles are counted. Note this metric's value may exceed=
 its parent due to use of \"Uops\" CountDomain.",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
-        "MetricName": "IpMispredict",
-        "Unit": "cpu_atom"
+        "BriefDescription": "This metric represents 128-bit vector Integer=
 ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction the=
 CPU has retired",
+        "MetricExpr": "(INT_VEC_RETIRED.ADD_128 + INT_VEC_RETIRED.VNNI_128=
) / (tma_retiring * tma_info_slots)",
+        "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_L4_group;=
tma_int_operations_group;tma_issue2P",
+        "MetricName": "tma_int_vector_128b",
+        "MetricThreshold": "tma_int_vector_128b > 0.1 & (tma_int_operation=
s > 0.1 & tma_light_operations > 0.6)",
+        "PublicDescription": "This metric represents 128-bit vector Intege=
r ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction th=
e CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_ve=
ctor_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_256b, tma=
_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per Far Branch",
-        "MetricExpr": "INST_RETIRED.ANY / (BR_INST_RETIRED.FAR_BRANCH / 2)=
",
-        "MetricName": "IpFarBranch",
-        "Unit": "cpu_atom"
+        "BriefDescription": "This metric represents 256-bit vector Integer=
 ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction the=
 CPU has retired",
+        "MetricExpr": "(INT_VEC_RETIRED.ADD_256 + INT_VEC_RETIRED.MUL_256 =
+ INT_VEC_RETIRED.VNNI_256) / (tma_retiring * tma_info_slots)",
+        "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_L4_group;=
tma_int_operations_group;tma_issue2P",
+        "MetricName": "tma_int_vector_256b",
+        "MetricThreshold": "tma_int_vector_256b > 0.1 & (tma_int_operation=
s > 0.1 & tma_light_operations > 0.6)",
+        "PublicDescription": "This metric represents 256-bit vector Intege=
r ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction th=
e CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_ve=
ctor_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, tma=
_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Ratio of all branches which mispredict",
-        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.ALL_=
BRANCHES",
-        "MetricName": "Branch_Mispredict_Ratio",
-        "Unit": "cpu_atom"
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
+        "MetricExpr": "ICACHE_TAG.STALLS / tma_info_clks",
+        "MetricGroup": "BigFoot;FetchLat;MemoryTLB;TopdownL3;tma_L3_group;=
tma_fetch_latency_group",
+        "MetricName": "tma_itlb_misses",
+        "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: FRONTE=
ND_RETIRED.STLB_MISS_PS;FRONTEND_RETIRED.ITLB_MISS_PS",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Ratio between Mispredicted branches and unkno=
wn branches",
-        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / BACLEARS.ANY",
-        "MetricName": "Branch_Mispredict_to_Unknown_Branch_Ratio",
-        "Unit": "cpu_atom"
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache",
+        "MetricExpr": "max((EXE_ACTIVITY.BOUND_ON_LOADS - MEMORY_ACTIVITY.=
STALLS_L1D_MISS) / tma_info_clks, 0)",
+        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_issueL1;tma_issueMC;tma_memory_bound_group",
+        "MetricName": "tma_l1_bound",
+        "MetricThreshold": "tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled without loads missing the L1 data cache.  The L1 data cache typical=
ly has the shortest latency.  However; in certain cases like loads blocked =
on older stores; a load might suffer due to high latency even though it is =
being satisfied by the L1. Another example is loads who miss in the TLB. Th=
ese cases are characterized by execution unit stalls; while some non-comple=
ted demand load lives in the machine without having that demand load missin=
g the L1 cache. Sample with: MEM_LOAD_RETIRED.L1_HIT_PS;MEM_LOAD_RETIRED.FB=
_HIT_PS. Related metrics: tma_clears_resteers, tma_machine_clears, tma_micr=
ocode_sequencer, tma_ms_switches, tma_ports_utilized_1",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Percentage of all uops which are ucode ops",
-        "MetricExpr": "100 * UOPS_RETIRED.MS / UOPS_RETIRED.ALL",
-        "MetricName": "Microcode_Uop_Ratio",
-        "Unit": "cpu_atom"
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(MEMORY_ACTIVITY.STALLS_L1D_MISS - MEMORY_ACTIVITY.=
STALLS_L2_MISS) / tma_info_clks",
+        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
+        "MetricName": "tma_l2_bound",
+        "MetricThreshold": "tma_l2_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_RETIRED.L2_HIT_PS",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Percentage of all uops which are FPDiv uops",
-        "MetricExpr": "100 * UOPS_RETIRED.FPDIV / UOPS_RETIRED.ALL",
-        "MetricName": "FPDiv_Uop_Ratio",
-        "Unit": "cpu_atom"
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
+        "MetricExpr": "(MEMORY_ACTIVITY.STALLS_L2_MISS - MEMORY_ACTIVITY.S=
TALLS_L3_MISS) / tma_info_clks",
+        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
+        "MetricName": "tma_l3_bound",
+        "MetricThreshold": "tma_l3_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Percentage of all uops which are IDiv uops",
-        "MetricExpr": "100 * UOPS_RETIRED.IDIV / UOPS_RETIRED.ALL",
-        "MetricName": "IDiv_Uop_Ratio",
-        "Unit": "cpu_atom"
+        "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited)",
+        "MetricExpr": "9 * tma_info_average_frequency * MEM_LOAD_RETIRED.L=
3_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_=
info_clks",
+        "MetricGroup": "MemoryLat;TopdownL4;tma_L4_group;tma_issueLat;tma_=
l3_bound_group",
+        "MetricName": "tma_l3_hit_latency",
+        "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound > 0.0=
5 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric represents fraction of cycles wi=
th demand load accesses that hit the L3 cache under unloaded scenarios (pos=
sibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L=
3 hits) will improve the latency; reduce contention with sibling physical c=
ores and increase performance.  Note the value of this node may overlap wit=
h its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: t=
ma_info_memory_latency, tma_mem_latency",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Percentage of all uops which are x87 uops",
-        "MetricExpr": "100 * UOPS_RETIRED.X87 / UOPS_RETIRED.ALL",
-        "MetricName": "X87_Uop_Ratio",
-        "Unit": "cpu_atom"
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 was stalled due to Length Changing Prefixes (LCPs)",
+        "MetricExpr": "DECODE.LCP / tma_info_clks",
+        "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group;tma_issueFB",
+        "MetricName": "tma_lcp",
+        "MetricThreshold": "tma_lcp > 0.05 & (tma_fetch_latency > 0.1 & tm=
a_frontend_bound > 0.15)",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs. Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_dsb_coverage, tma_info_dsb_misses, tma_info_iptb",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
-        "MetricExpr": "CLKS / CPU_CLK_UNHALTED.REF_TSC",
-        "MetricName": "Turbo_Utilization",
-        "Unit": "cpu_atom"
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations -- instructions that require=
 no more than one uop (micro-operation)",
+        "MetricExpr": "max(0, tma_retiring - tma_heavy_operations)",
+        "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_g=
roup",
+        "MetricName": "tma_light_operations",
+        "MetricThreshold": "tma_light_operations > 0.6",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring light-weight operations -- instructions that requir=
e no more than one uop (micro-operation). This correlates with total number=
 of instructions used by the program. A uops-per-instruction (see UopPI met=
ric) ratio of 1 or less should be expected for decently optimized software =
running on Intel Core/Xeon products. While this often indicates efficient X=
86 instructions were executed; high value does not necessarily mean better =
performance cannot be achieved. Sample with: INST_RETIRED.PREC_DIST",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE@k / CPU_CLK_UNHALTED=
.CORE",
-        "MetricName": "Kernel_Utilization",
-        "Unit": "cpu_atom"
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Load operations",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_2_3_10 / (3 * tma_info_core_cl=
ks)",
+        "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
+        "MetricName": "tma_load_op_utilization",
+        "MetricThreshold": "tma_load_op_utilization > 0.6",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port for Load operations. Sample with: =
UOPS_DISPATCHED.PORT_2_3_10",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average CPU Utilization",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
-        "MetricName": "CPU_Utilization",
-        "Unit": "cpu_atom"
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the (first level) DTLB was missed by load accesses, that late=
r on hit in second-level TLB (STLB)",
+        "MetricExpr": "tma_dtlb_load - tma_load_stlb_miss",
+        "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_load_gro=
up",
+        "MetricName": "tma_load_stlb_hit",
+        "MetricThreshold": "tma_load_stlb_hit > 0.05 & (tma_dtlb_load > 0.=
1 & (tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2=
)))",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Cycle cost per L2 hit",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_L2_HIT / MEM_LOAD_UOPS_RETIRE=
D.L2_HIT",
-        "MetricName": "Cycles_per_Demand_Load_L2_Hit",
-        "Unit": "cpu_atom"
+        "BriefDescription": "This metric estimates the fraction of cycles =
where the Second-level TLB (STLB) was missed by load accesses, performing a=
 hardware page walk",
+        "MetricExpr": "DTLB_LOAD_MISSES.WALK_ACTIVE / tma_info_clks",
+        "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_load_gro=
up",
+        "MetricName": "tma_load_stlb_miss",
+        "MetricThreshold": "tma_load_stlb_miss > 0.05 & (tma_dtlb_load > 0=
.1 & (tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.=
2)))",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Cycle cost per LLC hit",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_LLC_HIT / MEM_LOAD_UOPS_RETIR=
ED.L3_HIT",
-        "MetricName": "Cycles_per_Demand_Load_L3_Hit",
-        "Unit": "cpu_atom"
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(16 * max(0, MEM_INST_RETIRED.LOCK_LOADS - L2_RQSTS=
.ALL_RFO) + MEM_INST_RETIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES * (10=
 * L2_RQSTS.RFO_HIT + min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTAN=
DING.CYCLES_WITH_DEMAND_RFO))) / tma_info_clks",
+        "MetricGroup": "Offcore;TopdownL4;tma_L4_group;tma_issueRFO;tma_l1=
_bound_group",
+        "MetricName": "tma_lock_latency",
+        "MetricThreshold": "tma_lock_latency > 0.2 & (tma_l1_bound > 0.1 &=
 (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them. Sample with: MEM_INST_RETIRED.LOCK_LOA=
DS_PS. Related metrics: tma_store_latency",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Cycle cost per DRAM hit",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_DRAM_HIT / MEM_LOAD_UOPS_RETI=
RED.DRAM_HIT",
-        "MetricName": "Cycles_per_Demand_Load_DRAM_Hit",
-        "Unit": "cpu_atom"
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to LSD (Loop Stream Detector) unit",
+        "MetricExpr": "(LSD.CYCLES_ACTIVE - LSD.CYCLES_OK) / tma_info_core=
_clks / 2",
+        "MetricGroup": "FetchBW;LSD;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
+        "MetricName": "tma_lsd",
+        "MetricThreshold": "tma_lsd > 0.15 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_ipc / 6 > 0.35)",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to LSD (Loop Stream Detector) unit. =
 LSD typically does well sustaining Uop supply. However; in some rare cases=
; optimal uop-delivery could not be reached for small loops whose size (in =
terms of number of uops) does not suit well the LSD structure.",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Percent of instruction miss cost that hit in =
the L2",
-        "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_L2_HIT / MEM_BOUND_ST=
ALLS.IFETCH",
-        "MetricName": "Inst_Miss_Cost_L2Hit_Percent",
-        "Unit": "cpu_atom"
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Machine Clears",
+        "MetricExpr": "max(0, tma_bad_speculation - tma_branch_mispredicts=
)",
+        "MetricGroup": "BadSpec;MachineClears;TmaL2;TopdownL2;tma_L2_group=
;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
+        "MetricName": "tma_machine_clears",
+        "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation=
 > 0.15",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Machine Clears.  These slots are either wasted by uo=
ps fetched prior to the clear; or stalls the out-of-order portion of the ma=
chine needs to recover its state after the clear. For example; this can hap=
pen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modif=
ying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: =
tma_clears_resteers, tma_contested_accesses, tma_data_sharing, tma_false_sh=
aring, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_remote_c=
ache",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Percent of instruction miss cost that hit in =
the L3",
-        "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_LLC_HIT / MEM_BOUND_S=
TALLS.IFETCH",
-        "MetricName": "Inst_Miss_Cost_L3Hit_Percent",
-        "Unit": "cpu_atom"
+        "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory (DRAM)",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu_core@OFFCORE_REQUE=
STS_OUTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_clks",
+        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_dram_b=
ound_group;tma_issueBW",
+        "MetricName": "tma_mem_bandwidth",
+        "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_dram_bound > 0.=
1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory (DRAM).  The underlying heuristic assumes that a simi=
lar off-core traffic is generated by all IA cores. This metric does not agg=
regate non-data-read requests by this logical processor; requests from othe=
r IA Logical Processors/Physical Cores/sockets; or other non-IA devices lik=
e GPU; hence the maximum external memory bandwidth limits may or may not be=
 approached when this metric is flagged (see Uncore counters for that). Rel=
ated metrics: tma_fb_full, tma_info_dram_bw_use, tma_info_memory_bandwidth,=
 tma_sq_full",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Percent of instruction miss cost that hit in =
DRAM",
-        "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_DRAM_HIT / MEM_BOUND_=
STALLS.IFETCH",
-        "MetricName": "Inst_Miss_Cost_DRAMHit_Percent",
-        "Unit": "cpu_atom"
+        "BriefDescription": "This metric estimates fraction of cycles wher=
e the performance was likely hurt due to latency from external memory (DRAM=
)",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DATA_RD) / tma_info_clks - tma_mem_bandwidth",
+        "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_dram_=
bound_group;tma_issueLat",
+        "MetricName": "tma_mem_latency",
+        "MetricThreshold": "tma_mem_latency > 0.1 & (tma_dram_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory (DRA=
M).  This metric does not aggregate requests from other Logical Processors/=
Physical Cores/sockets (see Uncore counters for that). Related metrics: tma=
_info_memory_latency, tma_l3_hit_latency",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "load ops retired per 1000 instruction",
-        "MetricExpr": "1e3 * MEM_UOPS_RETIRED.ALL_LOADS / INST_RETIRED.ANY=
",
-        "MetricName": "MemLoadPKI",
-        "Unit": "cpu_atom"
+        "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
+        "MetricExpr": "topdown\\-mem\\-bound / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_in=
fo_slots",
+        "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_b=
ound_group",
+        "MetricName": "tma_memory_bound",
+        "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0=
.2",
+        "PublicDescription": "This metric represents fraction of slots the=
 Memory subsystem within the Backend was a bottleneck.  Memory Bound estima=
tes fraction of slots where pipeline is likely stalled due to demand load o=
r store instructions. This accounts mainly for (1) non-completed in-flight =
memory demand loads which coincides with execution units starvation; in add=
ition to (2) cases where stores could impose backpressure on the pipeline w=
hen many of them get buffered at the same time (less common out of the two)=
.",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "C1 residency percent per core",
-        "MetricExpr": "cstate_core@c1\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C1_Core_Residency",
-        "ScaleUnit": "100%"
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to LFENCE Instructions.",
+        "MetricExpr": "13 * MISC2_RETIRED.LFENCE / tma_info_clks",
+        "MetricGroup": "TopdownL6;tma_L6_group;tma_serializing_operation_g=
roup",
+        "MetricName": "tma_memory_fence",
+        "MetricThreshold": "tma_memory_fence > 0.05 & (tma_serializing_ope=
ration > 0.1 & (tma_ports_utilized_0 > 0.2 & (tma_ports_utilization > 0.15 =
& (tma_core_bound > 0.1 & tma_backend_bound > 0.2))))",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "C6 residency percent per core",
-        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C6_Core_Residency",
-        "ScaleUnit": "100%"
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations -- uops for memory load or store a=
ccesses.",
+        "MetricExpr": "tma_light_operations * MEM_UOP_RETIRED.ANY / (tma_r=
etiring * tma_info_slots)",
+        "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
+        "MetricName": "tma_memory_operations",
+        "MetricThreshold": "tma_memory_operations > 0.1 & tma_light_operat=
ions > 0.6",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "C7 residency percent per core",
-        "MetricExpr": "cstate_core@c7\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C7_Core_Residency",
-        "ScaleUnit": "100%"
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was retiring uops fetched by the Microcode Sequencer (MS) unit",
+        "MetricExpr": "UOPS_RETIRED.MS / tma_info_slots",
+        "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_heavy_operatio=
ns_group;tma_issueMC;tma_issueMS",
+        "MetricName": "tma_microcode_sequencer",
+        "MetricThreshold": "tma_microcode_sequencer > 0.05 & tma_heavy_ope=
rations > 0.1",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The M=
S is used for CISC instructions not supported by the default decoders (like=
 repeat move strings; or CPUID); or by microcode assists used to address so=
me operation modes (like in Floating Point assists). These cases can often =
be avoided. Sample with: UOPS_RETIRED.MS. Related metrics: tma_clears_reste=
ers, tma_l1_bound, tma_machine_clears, tma_ms_switches",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "C2 residency percent per package",
-        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C2_Pkg_Residency",
-        "ScaleUnit": "100%"
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Branch Misprediction=
 at execution stage",
+        "MetricExpr": "tma_branch_mispredicts / tma_bad_speculation * INT_=
MISC.CLEAR_RESTEER_CYCLES / tma_info_clks",
+        "MetricGroup": "BadSpec;BrMispredicts;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group;tma_issueBM",
+        "MetricName": "tma_mispredicts_resteers",
+        "MetricThreshold": "tma_mispredicts_resteers > 0.05 & (tma_branch_=
resteers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage. Sample with: INT_MISC.CLEAR_RESTEER_CYCLES. Related m=
etrics: tma_branch_mispredicts, tma_info_branch_misprediction_cost, tma_inf=
o_mispredictions",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "C3 residency percent per package",
-        "MetricExpr": "cstate_pkg@c3\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C3_Pkg_Residency",
-        "ScaleUnit": "100%"
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the MITE pipeline (the legacy deco=
de pipeline)",
+        "MetricExpr": "(IDQ.MITE_CYCLES_ANY - IDQ.MITE_CYCLES_OK) / tma_in=
fo_core_clks / 2",
+        "MetricGroup": "DSBmiss;FetchBW;TopdownL3;tma_L3_group;tma_fetch_b=
andwidth_group",
+        "MetricName": "tma_mite",
+        "MetricThreshold": "tma_mite > 0.1 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_ipc / 6 > 0.35)",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to the MITE pipeline (the legacy dec=
ode pipeline). This pipeline is used for code that was not pre-cached in th=
e DSB or LSD. For example; inefficiencies due to asymmetric decoders; use o=
f long immediate or LCP can manifest as MITE fetch bandwidth bottleneck. Sa=
mple with: FRONTEND_RETIRED.ANY_DSB_MISS",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "C6 residency percent per package",
-        "MetricExpr": "cstate_pkg@c6\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C6_Pkg_Residency",
-        "ScaleUnit": "100%"
+        "BriefDescription": "The Mixing_Vectors metric gives the percentag=
e of injected blend uops out of all uops issued",
+        "MetricExpr": "160 * ASSISTS.SSE_AVX_MIX / tma_info_clks",
+        "MetricGroup": "TopdownL5;tma_L5_group;tma_issueMV;tma_ports_utili=
zed_0_group",
+        "MetricName": "tma_mixing_vectors",
+        "MetricThreshold": "tma_mixing_vectors > 0.05",
+        "PublicDescription": "The Mixing_Vectors metric gives the percenta=
ge of injected blend uops out of all uops issued. Usually a Mixing_Vectors =
over 5% is worth investigating. Read more in Appendix B1 of the Optimizatio=
ns Guide for this topic. Related metrics: tma_ms_switches",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "C7 residency percent per package",
-        "MetricExpr": "cstate_pkg@c7\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C7_Pkg_Residency",
-        "ScaleUnit": "100%"
+        "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS)",
+        "MetricExpr": "3 * cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D1\\,edge@ =
/ (tma_retiring * tma_info_slots / UOPS_ISSUED.ANY) / tma_info_clks",
+        "MetricGroup": "FetchLat;MicroSeq;TopdownL3;tma_L3_group;tma_fetch=
_latency_group;tma_issueMC;tma_issueMS;tma_issueMV;tma_issueSO",
+        "MetricName": "tma_ms_switches",
+        "MetricThreshold": "tma_ms_switches > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
+        "PublicDescription": "This metric estimates the fraction of cycles=
 when the CPU was stalled due to switches of uop delivery to the Microcode =
Sequencer (MS). Commonly used instructions are optimized for delivery by th=
e DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Cert=
ain operations cannot be handled natively by the execution pipeline; and mu=
st be performed by microcode (small programs injected into the execution st=
ream). Switching to the MS too often can negatively impact performance. The=
 MS is designated to deliver long uop flows required by CISC instructions l=
ike CPUID; or uncommon conditions like Floating Point Assists when dealing =
with Denormals. Sample with: FRONTEND_RETIRED.MS_FLOWS. Related metrics: tm=
a_clears_resteers, tma_l1_bound, tma_machine_clears, tma_microcode_sequence=
r, tma_mixing_vectors, tma_serializing_operation",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "C8 residency percent per package",
-        "MetricExpr": "cstate_pkg@c8\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C8_Pkg_Residency",
-        "ScaleUnit": "100%"
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring branch instructions that were not fused",
+        "MetricExpr": "tma_light_operations * (BR_INST_RETIRED.ALL_BRANCHE=
S - INST_RETIRED.MACRO_FUSED) / (tma_retiring * tma_info_slots)",
+        "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
+        "MetricName": "tma_non_fused_branches",
+        "MetricThreshold": "tma_non_fused_branches > 0.1 & tma_light_opera=
tions > 0.6",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring branch instructions that were not fused. Non-condit=
ional branches like direct JMP or CALL would count here. Can be used to exa=
mine fusible conditional jumps that were not fused.",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "C9 residency percent per package",
-        "MetricExpr": "cstate_pkg@c9\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C9_Pkg_Residency",
-        "ScaleUnit": "100%"
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring NOP (no op) instructions",
+        "MetricExpr": "tma_light_operations * INST_RETIRED.NOP / (tma_reti=
ring * tma_info_slots)",
+        "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
+        "MetricName": "tma_nop_instructions",
+        "MetricThreshold": "tma_nop_instructions > 0.1 & tma_light_operati=
ons > 0.6",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring NOP (no op) instructions. Compilers often use NOPs =
for certain address alignments - e.g. start address of a function or loop b=
ody. Sample with: INST_RETIRED.NOP",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "C10 residency percent per package",
-        "MetricExpr": "cstate_pkg@c10\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C10_Pkg_Residency",
-        "ScaleUnit": "100%"
+        "BriefDescription": "This metric represents the remaining light uo=
ps fraction the CPU has executed - remaining means not covered by other sib=
ling nodes",
+        "MetricExpr": "max(0, tma_light_operations - (tma_fp_arith + tma_i=
nt_operations + tma_memory_operations + tma_fused_instructions + tma_non_fu=
sed_branches + tma_nop_instructions))",
+        "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
+        "MetricName": "tma_other_light_ops",
+        "MetricThreshold": "tma_other_light_ops > 0.3 & tma_light_operatio=
ns > 0.6",
+        "PublicDescription": "This metric represents the remaining light u=
ops fraction the CPU has executed - remaining means not covered by other si=
bling nodes. May undercount due to FMA double counting",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates fraction of slo=
ts the CPU retired uops as a result of handing Page Faults",
+        "MetricExpr": "99 * ASSISTS.PAGE_FAULT / tma_info_slots",
+        "MetricGroup": "TopdownL5;tma_L5_group;tma_assists_group",
+        "MetricName": "tma_page_faults",
+        "MetricThreshold": "tma_page_faults > 0.05",
+        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Page Faults. A Page Fault m=
ay apply on first application access to a memory page. Note operating syste=
m handling of page faults accounts for the majority of its cost.",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd b=
ranch)",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_0 / tma_info_core_clks",
+        "MetricGroup": "Compute;TopdownL6;tma_L6_group;tma_alu_op_utilizat=
ion_group;tma_issue2P",
+        "MetricName": "tma_port_0",
+        "MetricThreshold": "tma_port_0 > 0.6",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd =
branch). Sample with: UOPS_DISPATCHED.PORT_0. Related metrics: tma_fp_scala=
r, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512=
b, tma_int_vector_128b, tma_int_vector_256b, tma_port_1, tma_port_5, tma_po=
rt_6, tma_ports_utilized_2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 1 (ALU)",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_1 / tma_info_core_clks",
+        "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
+        "MetricName": "tma_port_1",
+        "MetricThreshold": "tma_port_1 > 0.6",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 1 (ALU). Sample with: UOPS_DISPATC=
HED.PORT_1. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_12=
8b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_ve=
ctor_256b, tma_port_0, tma_port_5, tma_port_6, tma_ports_utilized_2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 6 ([HSW+]Primary Branch and simple =
ALU)",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_6 / tma_info_core_clks",
+        "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
+        "MetricName": "tma_port_6",
+        "MetricThreshold": "tma_port_6 > 0.6",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 6 ([HSW+]Primary Branch and simple=
 ALU). Sample with: UOPS_DISPATCHED.PORT_6. Related metrics: tma_fp_scalar,=
 tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b,=
 tma_int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_port=
_5, tma_ports_utilized_2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
+        "MetricExpr": "((cpu_core@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x=
80@ + tma_serializing_operation * (CYCLE_ACTIVITY.STALLS_TOTAL - EXE_ACTIVI=
TY.BOUND_ON_LOADS) + (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * cpu_core@E=
XE_ACTIVITY.2_PORTS_UTIL\\,umask\\=3D0xc@)) / tma_info_clks if ARITH.DIV_AC=
TIVE < CYCLE_ACTIVITY.STALLS_TOTAL - EXE_ACTIVITY.BOUND_ON_LOADS else (EXE_=
ACTIVITY.1_PORTS_UTIL + tma_retiring * cpu_core@EXE_ACTIVITY.2_PORTS_UTIL\\=
,umask\\=3D0xc@) / tma_info_clks)",
+        "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
+        "MetricName": "tma_ports_utilization",
+        "MetricThreshold": "tma_ports_utilization > 0.15 & (tma_core_bound=
 > 0.1 & tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations.",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
+        "MetricExpr": "cpu_core@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x80=
@ / tma_info_clks + tma_serializing_operation * (CYCLE_ACTIVITY.STALLS_TOTA=
L - EXE_ACTIVITY.BOUND_ON_LOADS) / tma_info_clks",
+        "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
+        "MetricName": "tma_ports_utilized_0",
+        "MetricThreshold": "tma_ports_utilized_0 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed no uops on any execution port (Logical Processor cycles since IC=
L, Physical Core cycles otherwise). Long-latency instructions like divides =
may contribute to this metric.",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the CPU executed total of 1 uop per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise)",
+        "MetricExpr": "EXE_ACTIVITY.1_PORTS_UTIL / tma_info_clks",
+        "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issueL1;tma_p=
orts_utilization_group",
+        "MetricName": "tma_ports_utilized_1",
+        "MetricThreshold": "tma_ports_utilized_1 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric represents fraction of cycles wh=
ere the CPU executed total of 1 uop per cycle on all execution ports (Logic=
al Processor cycles since ICL, Physical Core cycles otherwise). This can be=
 due to heavy data-dependency among software instructions; or over oversubs=
cribing a particular hardware resource. In some other cases with high 1_Por=
t_Utilized and L1_Bound; this metric can point to L1 data-cache latency bot=
tleneck that may not necessarily manifest with complete execution starvatio=
n (due to the short L1 latency e.g. walking a linked list) - looking at the=
 assembly can be helpful. Sample with: EXE_ACTIVITY.1_PORTS_UTIL. Related m=
etrics: tma_l1_bound",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 2 uops per cycle on all execution ports (Logical Process=
or cycles since ICL, Physical Core cycles otherwise)",
+        "MetricExpr": "EXE_ACTIVITY.2_PORTS_UTIL / tma_info_clks",
+        "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issue2P;tma_p=
orts_utilization_group",
+        "MetricName": "tma_ports_utilized_2",
+        "MetricThreshold": "tma_ports_utilized_2 > 0.15 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop. S=
ample with: EXE_ACTIVITY.2_PORTS_UTIL. Related metrics: tma_fp_scalar, tma_=
fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_=
int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_5, t=
ma_port_6",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise)",
+        "MetricExpr": "UOPS_EXECUTED.CYCLES_GE_3 / tma_info_clks",
+        "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
+        "MetricName": "tma_ports_utilized_3m",
+        "MetricThreshold": "tma_ports_utilized_3m > 0.7 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 3 or more uops per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise). Sample with:=
 UOPS_EXECUTED.CYCLES_GE_3",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
+        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_info_=
slots",
+        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricName": "tma_retiring",
+        "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
+        "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided. Sample with: UOPS_RETIRED=
.SLOTS",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU issue-pipeline was stalled due to serializing operations",
+        "MetricExpr": "RESOURCE_STALLS.SCOREBOARD / tma_info_clks",
+        "MetricGroup": "PortsUtil;TopdownL5;tma_L5_group;tma_issueSO;tma_p=
orts_utilized_0_group",
+        "MetricName": "tma_serializing_operation",
+        "MetricThreshold": "tma_serializing_operation > 0.1 & (tma_ports_u=
tilized_0 > 0.2 & (tma_ports_utilization > 0.15 & (tma_core_bound > 0.1 & t=
ma_backend_bound > 0.2)))",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU issue-pipeline was stalled due to serializing operations. Instruction=
s like CPUID; WRMSR or LFENCE serialize the out-of-order execution which ma=
y limit performance. Sample with: RESOURCE_STALLS.SCOREBOARD. Related metri=
cs: tma_ms_switches",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric represents Shuffle (cross \"vecto=
r lane\" data transfers) uops fraction the CPU has retired.",
+        "MetricExpr": "INT_VEC_RETIRED.SHUFFLES / (tma_retiring * tma_info=
_slots)",
+        "MetricGroup": "HPC;Pipeline;TopdownL4;tma_L4_group;tma_int_operat=
ions_group",
+        "MetricName": "tma_shuffles",
+        "MetricThreshold": "tma_shuffles > 0.1 & (tma_int_operations > 0.1=
 & tma_light_operations > 0.6)",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to PAUSE Instructions",
+        "MetricExpr": "CPU_CLK_UNHALTED.PAUSE / tma_info_clks",
+        "MetricGroup": "TopdownL6;tma_L6_group;tma_serializing_operation_g=
roup",
+        "MetricName": "tma_slow_pause",
+        "MetricThreshold": "tma_slow_pause > 0.05 & (tma_serializing_opera=
tion > 0.1 & (tma_ports_utilized_0 > 0.2 & (tma_ports_utilization > 0.15 & =
(tma_core_bound > 0.1 & tma_backend_bound > 0.2))))",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to PAUSE Instructions. Sample with: CPU_CLK_UNHALTED.=
PAUSE_INST",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles hand=
ling memory load split accesses - load that cross 64-byte cache line bounda=
ry",
+        "MetricExpr": "tma_info_load_miss_real_latency * LD_BLOCKS.NO_SR /=
 tma_info_clks",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
+        "MetricName": "tma_split_loads",
+        "MetricThreshold": "tma_split_loads > 0.2 & (tma_l1_bound > 0.1 & =
(tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric estimates fraction of cycles han=
dling memory load split accesses - load that cross 64-byte cache line bound=
ary. Sample with: MEM_INST_RETIRED.SPLIT_LOADS_PS",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric represents rate of split store ac=
cesses",
+        "MetricExpr": "MEM_INST_RETIRED.SPLIT_STORES / tma_info_core_clks"=
,
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_issueSpSt;tma_store_bou=
nd_group",
+        "MetricName": "tma_split_stores",
+        "MetricThreshold": "tma_split_stores > 0.2 & (tma_store_bound > 0.=
2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric represents rate of split store a=
ccesses.  Consider aligning your data to the 64-byte cache line granularity=
. Sample with: MEM_INST_RETIRED.SPLIT_STORES_PS. Related metrics: tma_port_=
4",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric measures fraction of cycles where=
 the Super Queue (SQ) was full taking into account all request-types and bo=
th hardware SMT threads (Logical Processors)",
+        "MetricExpr": "(XQ.FULL_CYCLES + L1D_PEND_MISS.L2_STALLS) / tma_in=
fo_clks",
+        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_issueB=
W;tma_l3_bound_group",
+        "MetricName": "tma_sq_full",
+        "MetricThreshold": "tma_sq_full > 0.3 & (tma_l3_bound > 0.05 & (tm=
a_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_fb_full=
, tma_info_dram_bw_use, tma_info_memory_bandwidth, tma_mem_bandwidth",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to RFO store memory accesses; RFO store issue a read-for-ownership =
request before the write",
+        "MetricExpr": "EXE_ACTIVITY.BOUND_ON_STORES / tma_info_clks",
+        "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
+        "MetricName": "tma_store_bound",
+        "MetricThreshold": "tma_store_bound > 0.2 & (tma_memory_bound > 0.=
2 & tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to RFO store memory accesses; RFO store issue a read-for-ownership=
 request before the write. Even though store accesses do not typically stal=
l out-of-order CPUs; there are few cases where stores can lead to actual st=
alls. This metric will be flagged should RFO stores be a bottleneck. Sample=
 with: MEM_INST_RETIRED.ALL_STORES_PS",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates fraction of cyc=
les when the memory subsystem had loads blocked since they could not forwar=
d data from earlier (in program order) overlapping stores",
+        "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / tma_info_clks",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
+        "MetricName": "tma_store_fwd_blk",
+        "MetricThreshold": "tma_store_fwd_blk > 0.1 & (tma_l1_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric roughly estimates fraction of cy=
cles when the memory subsystem had loads blocked since they could not forwa=
rd data from earlier (in program order) overlapping stores. To streamline m=
emory operations in the pipeline; a load can avoid waiting for memory if a =
prior in-flight store is writing the data that the load wants to read (stor=
e forwarding process). However; in some cases the load may be blocked for a=
 significant time pending the store forward. For example; when the prior st=
ore is writing a smaller region than the load is reading.",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
+        "MetricExpr": "(MEM_STORE_RETIRED.L2_HIT * 10 * (1 - MEM_INST_RETI=
RED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES) + (1 - MEM_INST_RETIRED.LOCK_=
LOADS / MEM_INST_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE=
_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / tma_info_clks",
+        "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_issue=
RFO;tma_issueSL;tma_store_bound_group",
+        "MetricName": "tma_store_latency",
+        "MetricThreshold": "tma_store_latency > 0.1 & (tma_store_bound > 0=
.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full). Related metrics: tma_fb_full, tma_lock_latency",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Store operations",
+        "MetricExpr": "(UOPS_DISPATCHED.PORT_4_9 + UOPS_DISPATCHED.PORT_7_=
8) / (4 * tma_info_core_clks)",
+        "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
+        "MetricName": "tma_store_op_utilization",
+        "MetricThreshold": "tma_store_op_utilization > 0.6",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port for Store operations. Sample with:=
 UOPS_DISPATCHED.PORT_7_8",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the TLB was missed by store accesses, hitting in the second-l=
evel TLB (STLB)",
+        "MetricExpr": "tma_dtlb_store - tma_store_stlb_miss",
+        "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_store_gr=
oup",
+        "MetricName": "tma_store_stlb_hit",
+        "MetricThreshold": "tma_store_stlb_hit > 0.05 & (tma_dtlb_store > =
0.05 & (tma_store_bound > 0.2 & (tma_memory_bound > 0.2 & tma_backend_bound=
 > 0.2)))",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
where the STLB was missed by store accesses, performing a hardware page wal=
k",
+        "MetricExpr": "DTLB_STORE_MISSES.WALK_ACTIVE / tma_info_core_clks"=
,
+        "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_store_gr=
oup",
+        "MetricName": "tma_store_stlb_miss",
+        "MetricThreshold": "tma_store_stlb_miss > 0.05 & (tma_dtlb_store >=
 0.05 & (tma_store_bound > 0.2 & (tma_memory_bound > 0.2 & tma_backend_boun=
d > 0.2)))",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to Streaming store memory accesses; Streaming store optimize out a =
read request required by RFO stores",
+        "MetricExpr": "9 * OCR.STREAMING_WR.ANY_RESPONSE / tma_info_clks",
+        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_issueS=
mSt;tma_store_bound_group",
+        "MetricName": "tma_streaming_stores",
+        "MetricThreshold": "tma_streaming_stores > 0.2 & (tma_store_bound =
> 0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to Streaming store memory accesses; Streaming store optimize out a=
 read request required by RFO stores. Even though store accesses do not typ=
ically stall out-of-order CPUs; there are few cases where stores can lead t=
o actual stalls. This metric will be flagged should Streaming stores be a b=
ottleneck. Sample with: OCR.STREAMING_WR.ANY_RESPONSE. Related metrics: tma=
_fb_full",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to new branch address clears",
+        "MetricExpr": "INT_MISC.UNKNOWN_BRANCH_CYCLES / tma_info_clks",
+        "MetricGroup": "BigFoot;FetchLat;TopdownL4;tma_L4_group;tma_branch=
_resteers_group",
+        "MetricName": "tma_unknown_branches",
+        "MetricThreshold": "tma_unknown_branches > 0.05 & (tma_branch_rest=
eers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to new branch address clears. These are fetched branc=
hes the Branch Prediction Unit was unable to recognize (e.g. first time the=
 branch is fetched or hitting BTB capacity limit). Sample with: FRONTEND_RE=
TIRED.UNKNOWN_BRANCH",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric serves as an approximation of leg=
acy x87 usage",
+        "MetricExpr": "tma_retiring * UOPS_EXECUTED.X87 / UOPS_EXECUTED.TH=
READ",
+        "MetricGroup": "Compute;TopdownL4;tma_L4_group;tma_fp_arith_group"=
,
+        "MetricName": "tma_x87_use",
+        "MetricThreshold": "tma_x87_use > 0.1 & (tma_fp_arith > 0.2 & tma_=
light_operations > 0.6)",
+        "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint.",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/cache.json b/tools/pe=
rf/pmu-events/arch/x86/alderlake/cache.json
index adc9887b8ae0..51770416bcc2 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/cache.json
@@ -92,19 +92,19 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "All accesses to L2 cache[This event is alias =
to L2_RQSTS.REFERENCES]",
+        "BriefDescription": "All accesses to L2 cache [This event is alias=
 to L2_RQSTS.REFERENCES]",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.ALL",
-        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses.[This event is alias to L2_RQSTS.REFERENCES]",
+        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_RQSTS.REFERENCES]",
         "SampleAfterValue": "200003",
         "UMask": "0xff",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Read requests with true-miss in L2 cache.[Thi=
s event is alias to L2_RQSTS.MISS]",
+        "BriefDescription": "Read requests with true-miss in L2 cache. [Th=
is event is alias to L2_RQSTS.MISS]",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.MISS",
-        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses.[This event is alias to L2_RQSTS.MISS]",
+        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses. [This event is alias to L2_RQSTS.MISS]",
         "SampleAfterValue": "200003",
         "UMask": "0x3f",
         "Unit": "cpu_core"
@@ -198,19 +198,19 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Read requests with true-miss in L2 cache.[Thi=
s event is alias to L2_REQUEST.MISS]",
+        "BriefDescription": "Read requests with true-miss in L2 cache. [Th=
is event is alias to L2_REQUEST.MISS]",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.MISS",
-        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses.[This event is alias to L2_REQUEST.MISS]",
+        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses. [This event is alias to L2_REQUEST.MISS]",
         "SampleAfterValue": "200003",
         "UMask": "0x3f",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "All accesses to L2 cache[This event is alias =
to L2_REQUEST.ALL]",
+        "BriefDescription": "All accesses to L2 cache [This event is alias=
 to L2_REQUEST.ALL]",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.REFERENCES",
-        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses.[This event is alias to L2_REQUEST.ALL]",
+        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_REQUEST.ALL]",
         "SampleAfterValue": "200003",
         "UMask": "0xff",
         "Unit": "cpu_core"
@@ -895,7 +895,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD"=
,
+        "BriefDescription": "Counts demand data reads that resulted in a s=
noop hit in another cores caches which forwarded the unmodified data to the=
 requesting core.",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -980,6 +980,15 @@
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Cycles where at least 1 outstanding demand da=
ta read request is pending.",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_DATA=
_RD",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "For every cycle where the core is waiting on =
at least 1 outstanding Demand RFO request, increments by 1.",
         "CounterMask": "1",
@@ -999,6 +1008,15 @@
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "For every cycle, increments by the number of =
outstanding demand data read requests pending.",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD",
+        "PublicDescription": "For every cycle, increments by the number of=
 outstanding demand data read requests pending.   Requests are considered o=
utstanding from the time they miss the core's L2 cache until the transactio=
n completion message is sent to the requestor.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Number of PREFETCHNTA instructions executed."=
,
         "EventCode": "0x40",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json b=
/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
index 3eb7cab9b431..c8ba96c4a7f8 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
@@ -85,6 +85,24 @@
         "UMask": "0x20",
         "Unit": "cpu_core"
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
+        "EventCode": "0xc7",
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
+        "SampleAfterValue": "100003",
+        "UMask": "0x18",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of SSE/AVX computational scalar floati=
ng-point instructions retired; some instructions will count twice as noted =
below.  Applies to SSE* and AVX* scalar, double and single precision floati=
ng-point: ADD SUB MUL DIV MIN MAX RCP14 RSQRT14 RANGE SQRT DPP FM(N)ADD/SUB=
.  DPP and FM(N)ADD/SUB instructions count twice as they perform multiple c=
alculations per element.",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_INST_RETIRED.SCALAR",
+        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision and double precision floating-point instructions retired; some =
instructions will count twice as noted below.  Each count represents 1 comp=
utational operation. Applies to SSE* and AVX* scalar single precision float=
ing-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB=
.  FM(N)ADD/SUB instructions count twice as they perform 2 calculations per=
 element. The DAZ and FTZ flags in the MXCSR register need to be set when u=
sing these events.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts number of SSE/AVX computational scalar=
 double precision floating-point instructions retired; some instructions wi=
ll count twice as noted below.  Each count represents 1 computational opera=
tion. Applies to SSE* and AVX* scalar double precision floating-point instr=
uctions: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructi=
ons count twice as they perform 2 calculations per element.",
         "EventCode": "0xc7",
@@ -103,6 +121,15 @@
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Number of any Vector retired FP arithmetic in=
structions",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_INST_RETIRED.VECTOR",
+        "PublicDescription": "Number of any Vector retired FP arithmetic i=
nstructions.  The DAZ and FTZ flags in the MXCSR register need to be set wh=
en using these events.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xfc",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of floating point operation=
s retired that required microcode assist.",
         "EventCode": "0xc3",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/frontend.json b/tools=
/perf/pmu-events/arch/x86/alderlake/frontend.json
index 250cd128b674..81349100fe32 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
@@ -8,6 +8,15 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Clears due to Unknown Branches.",
+        "EventCode": "0x60",
+        "EventName": "BACLEARS.ANY",
+        "PublicDescription": "Number of times the front-end is resteered w=
hen it finds a branch instruction in a fetch line. This is called Unknown B=
ranch which occurs for the first time a branch instruction is fetched or wh=
en the branch is not tracked by the BPU (Branch Prediction Unit) anymore.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction.",
         "EventCode": "0x87",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/memory.json b/tools/p=
erf/pmu-events/arch/x86/alderlake/memory.json
index 7595eb4ab46f..37f3d062a788 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/memory.json
@@ -278,10 +278,9 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Demand Data Read requests who miss L3 cache",
+        "BriefDescription": "Counts demand data read requests that miss th=
e L3 cache.",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
-        "PublicDescription": "Demand Data Read requests who miss L3 cache.=
",
         "SampleAfterValue": "100003",
         "UMask": "0x10",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/alderlake/pipeline.json
index f46fa7ba168a..2dba3a115f97 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
@@ -793,13 +793,25 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "INST_RETIRED.REP_ITERATION",
+        "BriefDescription": "Iterations of Repeat string retired instructi=
ons.",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.REP_ITERATION",
+        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note the number of ite=
rations is implementation-dependent.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Clears speculative count",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.CLEARS_COUNT",
+        "PublicDescription": "Counts the number of speculative clears due =
to any type of branch misprediction or machine clears",
+        "SampleAfterValue": "500009",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts cycles after recovery from a branch mi=
sprediction or machine clear till the first uop is issued from the resteere=
d path.",
         "EventCode": "0xad",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json b/t=
ools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
index bc5fb6b76065..5f3b4c6e2e39 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
@@ -24,7 +24,7 @@
         "Unit": "ARB"
     },
     {
-        "BriefDescription": "Number of coherent read requests sent to memo=
ry controller that were issued by any core.",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_ARB_REQ_TRK_REQUEST.DRD",
         "EventCode": "0x81",
         "EventName": "UNC_ARB_DAT_REQUESTS.RD",
         "PerPkg": "1",
@@ -40,7 +40,15 @@
         "Unit": "ARB"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_ARB_DAT_REQUESTS.RD",
+        "BriefDescription": "Each cycle count number of 'valid' coherent D=
ata Read entries . Such entry is defined as valid when it is allocated till=
 deallocation. Doesn't include prefetches [This event is alias to UNC_ARB_T=
RK_OCCUPANCY.RD]",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_REQ_TRK_OCCUPANCY.DRD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of all coherent Data Read entries. Doe=
sn't include prefetches [This event is alias to UNC_ARB_TRK_REQUESTS.RD]",
         "EventCode": "0x81",
         "EventName": "UNC_ARB_REQ_TRK_REQUEST.DRD",
         "PerPkg": "1",
@@ -55,6 +63,14 @@
         "UMask": "0x1",
         "Unit": "ARB"
     },
+    {
+        "BriefDescription": "Each cycle count number of 'valid' coherent D=
ata Read entries . Such entry is defined as valid when it is allocated till=
 deallocation. Doesn't include prefetches [This event is alias to UNC_ARB_R=
EQ_TRK_OCCUPANCY.DRD]",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.RD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
     {
         "BriefDescription": "Counts the number of coherent and in-coherent=
 requests initiated by IA cores, processor graphic units, or LLC.",
         "EventCode": "0x81",
@@ -63,6 +79,14 @@
         "UMask": "0x1",
         "Unit": "ARB"
     },
+    {
+        "BriefDescription": "Number of all coherent Data Read entries. Doe=
sn't include prefetches [This event is alias to UNC_ARB_REQ_TRK_REQUEST.DRD=
]",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.RD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
     {
         "BriefDescription": "This 48-bit fixed counter counts the UCLK cyc=
les.",
         "EventCode": "0xff",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 5facdac6fe8e..4bcccab07ea9 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,5 +1,5 @@
 Family-model,Version,Filename,EventType
-GenuineIntel-6-(97|9A|B7|BA|BF),v1.16,alderlake,core
+GenuineIntel-6-(97|9A|B7|BA|BF),v1.18,alderlake,core
 GenuineIntel-6-BE,v1.16,alderlaken,core
 GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
 GenuineIntel-6-(3D|47),v26,broadwell,core
--=20
2.39.2.637.g21b0678d19-goog

