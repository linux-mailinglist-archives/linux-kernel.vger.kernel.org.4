Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3F569BF7C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjBSJbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjBSJbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:31:12 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1745E12595
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:30:36 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a34-20020a25a1a5000000b0092aabd4fa90so2167713ybi.18
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pg8DtD/6AWtZUKUB0xk490e6K26T1+8gvWgbrGLVsfA=;
        b=hr35H7hV2yotrjnrYtqxRDqhq5ee1Refjs9MiQhrAo48+q64Pp73OggomQ3mtUkFQ3
         lr5RbP06IUlqvH7vhExRFFbU1xlMy4YZP9sKZYWHsahmu887mIOnx/CwpznVSHvuulJ0
         bA5d1aCu3iF6f6+AeY2ABMhlsrGhDKm7c6YAU/HD1cfh87Av5h7UwaJYS1yvqSHHvvWs
         ZijmN7vTOyoiWR7+Y42Fk6Xc1gv2k6FFAOoQRPlcOtW4wja9w35qoGs8+OwsRbB0Wbic
         xvTkKnyzLhhaz0VD1676Iq7RPRYxXB8do84zqAAXB1OIvayCArQLyGEhMTQidf6JHUzr
         tQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pg8DtD/6AWtZUKUB0xk490e6K26T1+8gvWgbrGLVsfA=;
        b=RyHrb/MtPJqCpT3TWRyYUdtyTrHF3rhiW2ORDYanklhuB+1wOraFBs97taj2wGx99I
         PK5C8UvSPaa2iqu67wp53F3BgHboaVjRnAxY7nWdoDLdZamkKTfIatx4KTdf0CgqekKc
         geEjTLUic9gwPerhHrP450Mqj5sMu4inv9zvXz8Z6tUgdcKKyF6Un8bFezAYTcl7PxqF
         FQ339A+923OuRJKRhkNjCzy3HMcx9UCsbvFDwj4FRnB/kur6hzYwrXKKArDRI8pnvswJ
         rlPlNzcW9eHckrnz4HVPy5Fz+r3e21v0ox9R6MGNq/cwhMhPKtFLTA0WxGzsg33l7teJ
         IYqg==
X-Gm-Message-State: AO0yUKWN2u1mUu2KrtJKrmgeup2fFeFHDLuc1LhqXwXuc5MGFSgV5lkB
        hjyKFLho+P3afyhALM6yRnl7wzbul6Yt
X-Google-Smtp-Source: AK7set8Sv7RlRXfXBSFCEFMYu+4e0+7JqohBZbpAc5Fs/naKKTOxM/hbiNR1c7n8JMSSaIzH+aFy67uWySoC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a25:8589:0:b0:92c:2340:4de0 with SMTP id
 x9-20020a258589000000b0092c23404de0mr1502249ybk.310.1676799034298; Sun, 19
 Feb 2023 01:30:34 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:08 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-12-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 11/51] perf vendor events intel: Refresh alderlake-n metrics
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the alderlake-n events from 1.16 to 1.18 (no change) and
metrics. Generation was done using https://github.com/intel/perfmon.

Notable changes are TMA metrics are updated to version 4.5, TMA info
metrics are renamed from their node name to be lower case and prefixed
by tma_info_, MetricThreshold expressions are added and the smi_cost
metric group is added replicating existing hard coded metrics in
stat-shadow.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/alderlaken/adln-metrics.json     | 811 ++++++++++--------
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 2 files changed, 454 insertions(+), 359 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json b/=
tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
index 9ab1d5bcf4a2..5078c468480f 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
@@ -1,583 +1,678 @@
 [
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to frontend stalls.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.ALL / SLOTS",
-        "MetricGroup": "TopdownL1",
-        "MetricName": "tma_frontend_bound",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to frontend bandwidth restrictions due to =
decode, predecode, cisc, and other limitations.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY / SLOTS",
-        "MetricGroup": "TopdownL2;tma_frontend_bound_group",
-        "MetricName": "tma_frontend_latency",
+        "BriefDescription": "C10 residency percent per package",
+        "MetricExpr": "cstate_pkg@c10\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C10_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to instruction cache misses.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.ICACHE / SLOTS",
-        "MetricGroup": "TopdownL3;tma_frontend_latency_group",
-        "MetricName": "tma_icache",
+        "BriefDescription": "C1 residency percent per core",
+        "MetricExpr": "cstate_core@c1\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C1_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to Instruction Table Lookaside Buffer (ITL=
B) misses.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.ITLB / SLOTS",
-        "MetricGroup": "TopdownL3;tma_frontend_latency_group",
-        "MetricName": "tma_itlb",
+        "BriefDescription": "C2 residency percent per package",
+        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C2_Pkg_Residency",
         "ScaleUnit": "100%"
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
+        "BriefDescription": "C3 residency percent per package",
+        "MetricExpr": "cstate_pkg@c3\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C3_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to BTCLEARS, which occurs when the Branch =
Target Buffer (BTB) predicts a taken branch.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_RESTEER / SLOTS",
-        "MetricGroup": "TopdownL3;tma_frontend_latency_group",
-        "MetricName": "tma_branch_resteer",
+        "BriefDescription": "C6 residency percent per core",
+        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C6_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to frontend bandwidth restrictions due to =
decode, predecode, cisc, and other limitations.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH / SLOTS",
-        "MetricGroup": "TopdownL2;tma_frontend_bound_group",
-        "MetricName": "tma_frontend_bandwidth",
+        "BriefDescription": "C6 residency percent per package",
+        "MetricExpr": "cstate_pkg@c6\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C6_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to the microcode sequencer (MS).",
-        "MetricExpr": "TOPDOWN_FE_BOUND.CISC / SLOTS",
-        "MetricGroup": "TopdownL3;tma_frontend_bandwidth_group",
-        "MetricName": "tma_cisc",
+        "BriefDescription": "C7 residency percent per core",
+        "MetricExpr": "cstate_core@c7\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C7_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to decode stalls.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.DECODE / SLOTS",
-        "MetricGroup": "TopdownL3;tma_frontend_bandwidth_group",
-        "MetricName": "tma_decode",
+        "BriefDescription": "C7 residency percent per package",
+        "MetricExpr": "cstate_pkg@c7\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C7_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to wrong predecodes.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.PREDECODE / SLOTS",
-        "MetricGroup": "TopdownL3;tma_frontend_bandwidth_group",
-        "MetricName": "tma_predecode",
+        "BriefDescription": "C8 residency percent per package",
+        "MetricExpr": "cstate_pkg@c8\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C8_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to other common frontend stalls not catego=
rized.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.OTHER / SLOTS",
-        "MetricGroup": "TopdownL3;tma_frontend_bandwidth_group",
-        "MetricName": "tma_other_fb",
+        "BriefDescription": "C9 residency percent per package",
+        "MetricExpr": "cstate_pkg@c9\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C9_Pkg_Residency",
         "ScaleUnit": "100%"
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
+        "BriefDescription": "Percentage of cycles spent in System Manageme=
nt Interrupts.",
+        "MetricExpr": "((msr@aperf@ - cycles) / msr@aperf@ if msr@smi@ > 0=
 else 0)",
+        "MetricGroup": "smi",
+        "MetricName": "smi_cycles",
+        "MetricThreshold": "smi_cycles > 0.1",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to branch mispredicts.",
-        "MetricExpr": "TOPDOWN_BAD_SPECULATION.MISPREDICT / SLOTS",
-        "MetricGroup": "TopdownL2;tma_bad_speculation_group",
-        "MetricName": "tma_branch_mispredicts",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Number of SMI interrupts.",
+        "MetricExpr": "msr@smi@",
+        "MetricGroup": "smi",
+        "MetricName": "smi_num",
+        "ScaleUnit": "1SMI#"
     },
     {
-        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a mach=
ine clear (nuke) of any kind including memory ordering and memory disambigu=
ation.",
-        "MetricExpr": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS / SLOTS",
-        "MetricGroup": "TopdownL2;tma_bad_speculation_group",
-        "MetricName": "tma_machine_clears",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to certain allocation restrictions.",
+        "MetricExpr": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS / tma_info_slot=
s",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricName": "tma_alloc_restriction",
+        "MetricThreshold": "tma_alloc_restriction > 0.1",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to a machine clear (slow nuke).",
-        "MetricExpr": "TOPDOWN_BAD_SPECULATION.NUKE / SLOTS",
-        "MetricGroup": "TopdownL3;tma_machine_clears_group",
-        "MetricName": "tma_nuke",
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
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to SMC. ",
-        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.SMC / MACHINE_CLEARS.SLO=
W)",
-        "MetricGroup": "TopdownL4;tma_nuke_group",
-        "MetricName": "tma_smc",
+        "BriefDescription": "Counts the total number of issue slots  that =
were not consumed by the backend due to backend stalls",
+        "MetricExpr": "tma_backend_bound",
+        "MetricGroup": "TopdownL1;tma_L1_group",
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
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to memory ordering. ",
-        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.MEMORY_ORDERING / MACHIN=
E_CLEARS.SLOW)",
-        "MetricGroup": "TopdownL4;tma_nuke_group",
-        "MetricName": "tma_memory_ordering",
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
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to FP assists. ",
-        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.FP_ASSIST / MACHINE_CLEA=
RS.SLOW)",
-        "MetricGroup": "TopdownL4;tma_nuke_group",
-        "MetricName": "tma_fp_assist",
+        "BriefDescription": "Counts the number of uops that are not from t=
he microsequencer.",
+        "MetricExpr": "(TOPDOWN_RETIRING.ALL - UOPS_RETIRED.MS) / tma_info=
_slots",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_retiring_group",
+        "MetricName": "tma_base",
+        "MetricThreshold": "tma_base > 0.6",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to memory disambiguation. ",
-        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.DISAMBIGUATION / MACHINE=
_CLEARS.SLOW)",
-        "MetricGroup": "TopdownL4;tma_nuke_group",
-        "MetricName": "tma_disambiguation",
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
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to page faults. ",
-        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.PAGE_FAULT / MACHINE_CLE=
ARS.SLOW)",
-        "MetricGroup": "TopdownL4;tma_nuke_group",
-        "MetricName": "tma_page_fault",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to branch mispredicts.",
+        "MetricExpr": "TOPDOWN_BAD_SPECULATION.MISPREDICT / tma_info_slots=
",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
+        "MetricName": "tma_branch_mispredicts",
+        "MetricThreshold": "tma_branch_mispredicts > 0.05",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to a machine clear classified as a fast nuke=
 due to memory ordering, memory disambiguation and memory renaming.",
-        "MetricExpr": "TOPDOWN_BAD_SPECULATION.FASTNUKE / SLOTS",
-        "MetricGroup": "TopdownL3;tma_machine_clears_group",
-        "MetricName": "tma_fast_nuke",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to BTCLEARS, which occurs when the Branch =
Target Buffer (BTB) predicts a taken branch.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_RESTEER / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_frontend_latency_group"=
,
+        "MetricName": "tma_branch_resteer",
+        "MetricThreshold": "tma_branch_resteer > 0.05",
         "ScaleUnit": "100%"
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
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to the microcode sequencer (MS).",
+        "MetricExpr": "TOPDOWN_FE_BOUND.CISC / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_frontend_bandwidth_grou=
p",
+        "MetricName": "tma_cisc",
+        "MetricThreshold": "tma_cisc > 0.05",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of cycles due to backend bo=
und stalls that are core execution bound and not attributed to outstanding =
demand load or store stalls. ",
+        "BriefDescription": "Counts the number of cycles due to backend bo=
und stalls that are core execution bound and not attributed to outstanding =
demand load or store stalls.",
         "MetricExpr": "max(0, tma_backend_bound - tma_load_store_bound)",
-        "MetricGroup": "TopdownL2;tma_backend_bound_group",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
         "MetricName": "tma_core_bound",
+        "MetricThreshold": "tma_core_bound > 0.1",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to stores or loads. ",
-        "MetricExpr": "min(tma_backend_bound, LD_HEAD.ANY_AT_RET / CLKS + =
tma_store_bound)",
-        "MetricGroup": "TopdownL2;tma_backend_bound_group",
-        "MetricName": "tma_load_store_bound",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to decode stalls.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.DECODE / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_frontend_bandwidth_grou=
p",
+        "MetricName": "tma_decode",
+        "MetricThreshold": "tma_decode > 0.05",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to store buffer full.",
-        "MetricExpr": "tma_st_buffer",
-        "MetricGroup": "TopdownL3;tma_load_store_bound_group",
-        "MetricName": "tma_store_bound",
+        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to memory disambiguation.",
+        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.DISAMBIGUATION / MACHINE=
_CLEARS.SLOW)",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
+        "MetricName": "tma_disambiguation",
+        "MetricThreshold": "tma_disambiguation > 0.02",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a load block.",
-        "MetricExpr": "LD_HEAD.L1_BOUND_AT_RET / CLKS",
-        "MetricGroup": "TopdownL3;tma_load_store_bound_group",
-        "MetricName": "tma_l1_bound",
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
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a store forward bloc=
k.",
-        "MetricExpr": "LD_HEAD.ST_ADDR_AT_RET / CLKS",
-        "MetricGroup": "TopdownL4;tma_l1_bound_group",
-        "MetricName": "tma_store_fwd",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to a machine clear classified as a fast nuke=
 due to memory ordering, memory disambiguation and memory renaming.",
+        "MetricExpr": "TOPDOWN_BAD_SPECULATION.FASTNUKE / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
+        "MetricName": "tma_fast_nuke",
+        "MetricThreshold": "tma_fast_nuke > 0.05",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a first level TLB mi=
ss.",
-        "MetricExpr": "LD_HEAD.DTLB_MISS_AT_RET / CLKS",
-        "MetricGroup": "TopdownL4;tma_l1_bound_group",
-        "MetricName": "tma_stlb_hit",
+        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to FP assists.",
+        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.FP_ASSIST / MACHINE_CLEA=
RS.SLOW)",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
+        "MetricName": "tma_fp_assist",
+        "MetricThreshold": "tma_fp_assist > 0.02",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a second level TLB m=
iss requiring a page walk.",
-        "MetricExpr": "LD_HEAD.PGWALK_AT_RET / CLKS",
-        "MetricGroup": "TopdownL4;tma_l1_bound_group",
-        "MetricName": "tma_stlb_miss",
+        "BriefDescription": "Counts the number of floating point operation=
s per uop with all default weighting.",
+        "MetricExpr": "UOPS_RETIRED.FPDIV / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_base_group",
+        "MetricName": "tma_fp_uops",
+        "MetricThreshold": "tma_fp_uops > 0.2",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a number of other lo=
ad blocks.",
-        "MetricExpr": "LD_HEAD.OTHER_AT_RET / CLKS",
-        "MetricGroup": "TopdownL4;tma_l1_bound_group",
-        "MetricName": "tma_other_l1",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to frontend bandwidth restrictions due to =
decode, predecode, cisc, and other limitations.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH / tma_info_slot=
s",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
+        "MetricName": "tma_frontend_bandwidth",
+        "MetricThreshold": "tma_frontend_bandwidth > 0.1",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of cycles a core is stalled=
 due to a demand load which hit in the L2 Cache.",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_L2_HIT / CLKS - MEM_BOUND_STA=
LLS_AT_RET_CORRECTION * MEM_BOUND_STALLS.LOAD_L2_HIT / MEM_BOUND_STALLS.LOA=
D",
-        "MetricGroup": "TopdownL3;tma_load_store_bound_group",
-        "MetricName": "tma_l2_bound",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to frontend stalls.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.ALL / tma_info_slots",
+        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricName": "tma_frontend_bound",
+        "MetricThreshold": "tma_frontend_bound > 0.2",
         "ScaleUnit": "100%"
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
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to frontend bandwidth restrictions due to =
decode, predecode, cisc, and other limitations.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY / tma_info_slots"=
,
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
+        "MetricName": "tma_frontend_latency",
+        "MetricThreshold": "tma_frontend_latency > 0.15",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load miss which hit in DRAM or MMIO (Non-DRAM).",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_DRAM_HIT / CLKS - MEM_BOUND_S=
TALLS_AT_RET_CORRECTION * MEM_BOUND_STALLS.LOAD_DRAM_HIT / MEM_BOUND_STALLS=
.LOAD",
-        "MetricGroup": "TopdownL3;tma_load_store_bound_group",
-        "MetricName": "tma_dram_bound",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to instruction cache misses.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.ICACHE / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_frontend_latency_group"=
,
+        "MetricName": "tma_icache",
+        "MetricThreshold": "tma_icache > 0.05",
         "ScaleUnit": "100%"
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
-        "ScaleUnit": "100%"
+        "BriefDescription": "Percentage of total non-speculative loads wit=
h a address aliasing block",
+        "MetricExpr": "100 * LD_BLOCKS.4K_ALIAS / MEM_UOPS_RETIRED.ALL_LOA=
DS",
+        "MetricName": "tma_info_address_alias_blocks"
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
-        "ScaleUnit": "100%"
+        "BriefDescription": "Ratio of all branches which mispredict",
+        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.ALL_=
BRANCHES",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_branch_mispredict_ratio"
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
-        "ScaleUnit": "100%"
+        "BriefDescription": "Ratio between Mispredicted branches and unkno=
wn branches",
+        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / BACLEARS.ANY",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_branch_mispredict_to_unknown_branch_ratio"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to memory reservation stalls in which a sche=
duler is not able to accept uops.",
-        "MetricExpr": "TOPDOWN_BE_BOUND.MEM_SCHEDULER / SLOTS",
-        "MetricGroup": "TopdownL3;tma_resource_bound_group",
-        "MetricName": "tma_mem_scheduler",
-        "ScaleUnit": "100%"
+        "BriefDescription": "",
+        "MetricExpr": "CPU_CLK_UNHALTED.CORE",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_clks"
     },
     {
-        "BriefDescription": "Counts the number of cycles, relative to the =
number of mem_scheduler slots, in which uops are blocked due to store buffe=
r full",
-        "MetricExpr": "tma_mem_scheduler * (MEM_SCHEDULER_BLOCK.ST_BUF / M=
EM_SCHEDULER_BLOCK.ALL)",
-        "MetricGroup": "TopdownL4;tma_mem_scheduler_group",
-        "MetricName": "tma_st_buffer",
-        "ScaleUnit": "100%"
+        "BriefDescription": "",
+        "MetricExpr": "CPU_CLK_UNHALTED.CORE_P",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_clks_p"
     },
     {
-        "BriefDescription": "Counts the number of cycles, relative to the =
number of mem_scheduler slots, in which uops are blocked due to load buffer=
 full",
-        "MetricExpr": "tma_mem_scheduler * MEM_SCHEDULER_BLOCK.LD_BUF / ME=
M_SCHEDULER_BLOCK.ALL",
-        "MetricGroup": "TopdownL4;tma_mem_scheduler_group",
-        "MetricName": "tma_ld_buffer",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Cycles Per Instruction",
+        "MetricExpr": "tma_info_clks / INST_RETIRED.ANY",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_cpi"
     },
     {
-        "BriefDescription": "Counts the number of cycles, relative to the =
number of mem_scheduler slots, in which uops are blocked due to RSV full re=
lative ",
-        "MetricExpr": "tma_mem_scheduler * MEM_SCHEDULER_BLOCK.RSV / MEM_S=
CHEDULER_BLOCK.ALL",
-        "MetricGroup": "TopdownL4;tma_mem_scheduler_group",
-        "MetricName": "tma_rsv",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_cpu_utilization"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to IEC or FPC RAT stalls, which can be due t=
o FIQ or IEC reservation stalls in which the integer, floating point or SIM=
D scheduler is not able to accept uops.",
-        "MetricExpr": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER / SLOTS",
-        "MetricGroup": "TopdownL3;tma_resource_bound_group",
-        "MetricName": "tma_non_mem_scheduler",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Cycle cost per DRAM hit",
+        "MetricExpr": "MEM_BOUND_STALLS.LOAD_DRAM_HIT / MEM_LOAD_UOPS_RETI=
RED.DRAM_HIT",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_cycles_per_demand_load_dram_hit"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to the physical register file unable to acce=
pt an entry (marble stalls).",
-        "MetricExpr": "TOPDOWN_BE_BOUND.REGISTER / SLOTS",
-        "MetricGroup": "TopdownL3;tma_resource_bound_group",
-        "MetricName": "tma_register",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Cycle cost per L2 hit",
+        "MetricExpr": "MEM_BOUND_STALLS.LOAD_L2_HIT / MEM_LOAD_UOPS_RETIRE=
D.L2_HIT",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_cycles_per_demand_load_l2_hit"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to the reorder buffer being full (ROB stalls=
).",
-        "MetricExpr": "TOPDOWN_BE_BOUND.REORDER_BUFFER / SLOTS",
-        "MetricGroup": "TopdownL3;tma_resource_bound_group",
-        "MetricName": "tma_reorder_buffer",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Cycle cost per LLC hit",
+        "MetricExpr": "MEM_BOUND_STALLS.LOAD_LLC_HIT / MEM_LOAD_UOPS_RETIR=
ED.L3_HIT",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_cycles_per_demand_load_l3_hit"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to certain allocation restrictions.",
-        "MetricExpr": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS / SLOTS",
-        "MetricGroup": "TopdownL3;tma_resource_bound_group",
-        "MetricName": "tma_alloc_restriction",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Percentage of all uops which are FPDiv uops",
+        "MetricExpr": "100 * UOPS_RETIRED.FPDIV / UOPS_RETIRED.ALL",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_fpdiv_uop_ratio"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to scoreboards from the instruction queue (I=
Q), jump execution unit (JEU), or microcode sequencer (MS).",
-        "MetricExpr": "TOPDOWN_BE_BOUND.SERIALIZATION / SLOTS",
-        "MetricGroup": "TopdownL3;tma_resource_bound_group",
-        "MetricName": "tma_serialization",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Percentage of all uops which are IDiv uops",
+        "MetricExpr": "100 * UOPS_RETIRED.IDIV / UOPS_RETIRED.ALL",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_idiv_uop_ratio"
     },
     {
-        "BriefDescription": "Counts the numer of issue slots  that result =
in retirement slots. ",
-        "MetricExpr": "TOPDOWN_RETIRING.ALL / SLOTS",
-        "MetricGroup": "TopdownL1",
-        "MetricName": "tma_retiring",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Percent of instruction miss cost that hit in =
DRAM",
+        "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_DRAM_HIT / MEM_BOUND_=
STALLS.IFETCH",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_inst_miss_cost_dramhit_percent"
     },
     {
-        "BriefDescription": "Counts the number of uops that are not from t=
he microsequencer. ",
-        "MetricExpr": "(TOPDOWN_RETIRING.ALL - UOPS_RETIRED.MS) / SLOTS",
-        "MetricGroup": "TopdownL2;tma_retiring_group",
-        "MetricName": "tma_base",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Percent of instruction miss cost that hit in =
the L2",
+        "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_L2_HIT / MEM_BOUND_ST=
ALLS.IFETCH",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_inst_miss_cost_l2hit_percent"
     },
     {
-        "BriefDescription": "Counts the number of floating point operation=
s per uop with all default weighting.",
-        "MetricExpr": "UOPS_RETIRED.FPDIV / SLOTS",
-        "MetricGroup": "TopdownL3;tma_base_group",
-        "MetricName": "tma_fp_uops",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Percent of instruction miss cost that hit in =
the L3",
+        "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_LLC_HIT / MEM_BOUND_S=
TALLS.IFETCH",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_inst_miss_cost_l3hit_percent"
     },
     {
-        "BriefDescription": "Counts the number of uops retired excluding m=
s and fp div uops.",
-        "MetricExpr": "(TOPDOWN_RETIRING.ALL - UOPS_RETIRED.MS - UOPS_RETI=
RED.FPDIV) / SLOTS",
-        "MetricGroup": "TopdownL3;tma_base_group",
-        "MetricName": "tma_other_ret",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurance rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_ipbranch"
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
-        "ScaleUnit": "100%"
+        "BriefDescription": "Instructions Per Cycle",
+        "MetricExpr": "INST_RETIRED.ANY / tma_info_clks",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_ipc"
     },
     {
-        "BriefDescription": "",
-        "MetricExpr": "CPU_CLK_UNHALTED.CORE",
-        "MetricName": "CLKS"
+        "BriefDescription": "Instruction per (near) call (lower number mea=
ns higher occurance rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.CALL",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_ipcall"
     },
     {
-        "BriefDescription": "",
-        "MetricExpr": "CPU_CLK_UNHALTED.CORE_P",
-        "MetricName": "CLKS_P"
+        "BriefDescription": "Instructions per Far Branch",
+        "MetricExpr": "INST_RETIRED.ANY / (BR_INST_RETIRED.FAR_BRANCH / 2)=
",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_ipfarbranch"
     },
     {
-        "BriefDescription": "",
-        "MetricExpr": "5 * CLKS",
-        "MetricName": "SLOTS"
+        "BriefDescription": "Instructions per Load",
+        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_LOADS",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_ipload"
     },
     {
-        "BriefDescription": "Instructions Per Cycle",
-        "MetricExpr": "INST_RETIRED.ANY / CLKS",
-        "MetricName": "IPC"
+        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_ipmispredict"
     },
     {
-        "BriefDescription": "Cycles Per Instruction",
-        "MetricExpr": "CLKS / INST_RETIRED.ANY",
-        "MetricName": "CPI"
+        "BriefDescription": "Instructions per Store",
+        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_STORES",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_ipstore"
     },
     {
-        "BriefDescription": "Uops Per Instruction",
-        "MetricExpr": "UOPS_RETIRED.ALL / INST_RETIRED.ANY",
-        "MetricName": "UPI"
+        "BriefDescription": "Fraction of cycles spent in Kernel mode",
+        "MetricExpr": "cpu@CPU_CLK_UNHALTED.CORE@k / CPU_CLK_UNHALTED.CORE=
",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_kernel_utilization"
     },
     {
-        "BriefDescription": "Percentage of total non-speculative loads wit=
h a store forward or unknown store address block",
-        "MetricExpr": "100 * LD_BLOCKS.DATA_UNKNOWN / MEM_UOPS_RETIRED.ALL=
_LOADS",
-        "MetricName": "Store_Fwd_Blocks"
+        "BriefDescription": "Percentage of total non-speculative loads tha=
t are splits",
+        "MetricExpr": "100 * MEM_UOPS_RETIRED.SPLIT_LOADS / MEM_UOPS_RETIR=
ED.ALL_LOADS",
+        "MetricName": "tma_info_load_splits"
     },
     {
-        "BriefDescription": "Percentage of total non-speculative loads wit=
h a address aliasing block",
-        "MetricExpr": "100 * LD_BLOCKS.4K_ALIAS / MEM_UOPS_RETIRED.ALL_LOA=
DS",
-        "MetricName": "Address_Alias_Blocks"
+        "BriefDescription": "load ops retired per 1000 instruction",
+        "MetricExpr": "1e3 * MEM_UOPS_RETIRED.ALL_LOADS / INST_RETIRED.ANY=
",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_memloadpki"
     },
     {
-        "BriefDescription": "Percentage of total non-speculative loads tha=
t are splits",
-        "MetricExpr": "100 * MEM_UOPS_RETIRED.SPLIT_LOADS / MEM_UOPS_RETIR=
ED.ALL_LOADS",
-        "MetricName": "Load_Splits"
+        "BriefDescription": "Percentage of all uops which are ucode ops",
+        "MetricExpr": "100 * UOPS_RETIRED.MS / UOPS_RETIRED.ALL",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_microcode_uop_ratio"
     },
     {
-        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
-        "MetricName": "IpBranch"
+        "BriefDescription": "",
+        "MetricExpr": "5 * tma_info_clks",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_slots"
     },
     {
-        "BriefDescription": "Instruction per (near) call (lower number mea=
ns higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.CALL",
-        "MetricName": "IpCall"
+        "BriefDescription": "Percentage of total non-speculative loads wit=
h a store forward or unknown store address block",
+        "MetricExpr": "100 * LD_BLOCKS.DATA_UNKNOWN / MEM_UOPS_RETIRED.ALL=
_LOADS",
+        "MetricName": "tma_info_store_fwd_blocks"
     },
     {
-        "BriefDescription": "Instructions per Load",
-        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_LOADS",
-        "MetricName": "IpLoad"
+        "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
+        "MetricExpr": "tma_info_clks / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_turbo_utilization"
     },
     {
-        "BriefDescription": "Instructions per Store",
-        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_STORES",
-        "MetricName": "IpStore"
+        "BriefDescription": "Uops Per Instruction",
+        "MetricExpr": "UOPS_RETIRED.ALL / INST_RETIRED.ANY",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_upi"
     },
     {
-        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
-        "MetricName": "IpMispredict"
+        "BriefDescription": "Percentage of all uops which are x87 uops",
+        "MetricExpr": "100 * UOPS_RETIRED.X87 / UOPS_RETIRED.ALL",
+        "MetricGroup": " ",
+        "MetricName": "tma_info_x87_uop_ratio"
     },
     {
-        "BriefDescription": "Instructions per Far Branch",
-        "MetricExpr": "INST_RETIRED.ANY / (BR_INST_RETIRED.FAR_BRANCH / 2)=
",
-        "MetricName": "IpFarBranch"
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to Instruction Table Lookaside Buffer (ITL=
B) misses.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.ITLB / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_frontend_latency_group"=
,
+        "MetricName": "tma_itlb",
+        "MetricThreshold": "tma_itlb > 0.05",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Ratio of all branches which mispredict",
-        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.ALL_=
BRANCHES",
-        "MetricName": "Branch_Mispredict_Ratio"
+        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a load block.",
+        "MetricExpr": "LD_HEAD.L1_BOUND_AT_RET / tma_info_clks",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_load_store_bound_group"=
,
+        "MetricName": "tma_l1_bound",
+        "MetricThreshold": "tma_l1_bound > 0.1",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Ratio between Mispredicted branches and unkno=
wn branches",
-        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / BACLEARS.ANY",
-        "MetricName": "Branch_Mispredict_to_Unknown_Branch_Ratio"
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
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Percentage of all uops which are ucode ops",
-        "MetricExpr": "100 * UOPS_RETIRED.MS / UOPS_RETIRED.ALL",
-        "MetricName": "Microcode_Uop_Ratio"
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
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Percentage of all uops which are FPDiv uops",
-        "MetricExpr": "100 * UOPS_RETIRED.FPDIV / UOPS_RETIRED.ALL",
-        "MetricName": "FPDiv_Uop_Ratio"
+        "BriefDescription": "Counts the number of cycles, relative to the =
number of mem_scheduler slots, in which uops are blocked due to load buffer=
 full",
+        "MetricExpr": "tma_mem_scheduler * MEM_SCHEDULER_BLOCK.LD_BUF / ME=
M_SCHEDULER_BLOCK.ALL",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_mem_scheduler_group",
+        "MetricName": "tma_ld_buffer",
+        "MetricThreshold": "tma_ld_buffer > 0.05",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Percentage of all uops which are IDiv uops",
-        "MetricExpr": "100 * UOPS_RETIRED.IDIV / UOPS_RETIRED.ALL",
-        "MetricName": "IDiv_Uop_Ratio"
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to stores or loads.",
+        "MetricExpr": "min(tma_backend_bound, LD_HEAD.ANY_AT_RET / tma_inf=
o_clks + tma_store_bound)",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
+        "MetricName": "tma_load_store_bound",
+        "MetricThreshold": "tma_load_store_bound > 0.2",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Percentage of all uops which are x87 uops",
-        "MetricExpr": "100 * UOPS_RETIRED.X87 / UOPS_RETIRED.ALL",
-        "MetricName": "X87_Uop_Ratio"
+        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a mach=
ine clear (nuke) of any kind including memory ordering and memory disambigu=
ation.",
+        "MetricExpr": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS / tma_info_s=
lots",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
+        "MetricName": "tma_machine_clears",
+        "MetricThreshold": "tma_machine_clears > 0.05",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
-        "MetricExpr": "CLKS / CPU_CLK_UNHALTED.REF_TSC",
-        "MetricName": "Turbo_Utilization"
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to memory reservation stalls in which a sche=
duler is not able to accept uops.",
+        "MetricExpr": "TOPDOWN_BE_BOUND.MEM_SCHEDULER / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricName": "tma_mem_scheduler",
+        "MetricThreshold": "tma_mem_scheduler > 0.1",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "cpu@CPU_CLK_UNHALTED.CORE@k / CPU_CLK_UNHALTED.CORE=
",
-        "MetricName": "Kernel_Utilization"
+        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to memory ordering.",
+        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.MEMORY_ORDERING / MACHIN=
E_CLEARS.SLOW)",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
+        "MetricName": "tma_memory_ordering",
+        "MetricThreshold": "tma_memory_ordering > 0.02",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average CPU Utilization",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
-        "MetricName": "CPU_Utilization"
+        "BriefDescription": "Counts the number of uops that are from the c=
omplex flows issued by the micro-sequencer (MS)",
+        "MetricExpr": "UOPS_RETIRED.MS / tma_info_slots",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_retiring_group",
+        "MetricName": "tma_ms_uops",
+        "MetricThreshold": "tma_ms_uops > 0.05",
+        "PublicDescription": "Counts the number of uops that are from the =
complex flows issued by the micro-sequencer (MS).  This includes uops from =
flows due to complex instructions, faults, assists, and inserted flows.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Cycle cost per L2 hit",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_L2_HIT / MEM_LOAD_UOPS_RETIRE=
D.L2_HIT",
-        "MetricName": "Cycles_per_Demand_Load_L2_Hit"
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to IEC or FPC RAT stalls, which can be due t=
o FIQ or IEC reservation stalls in which the integer, floating point or SIM=
D scheduler is not able to accept uops.",
+        "MetricExpr": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER / tma_info_slots=
",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricName": "tma_non_mem_scheduler",
+        "MetricThreshold": "tma_non_mem_scheduler > 0.1",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Cycle cost per LLC hit",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_LLC_HIT / MEM_LOAD_UOPS_RETIR=
ED.L3_HIT",
-        "MetricName": "Cycles_per_Demand_Load_L3_Hit"
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to a machine clear (slow nuke).",
+        "MetricExpr": "TOPDOWN_BAD_SPECULATION.NUKE / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
+        "MetricName": "tma_nuke",
+        "MetricThreshold": "tma_nuke > 0.05",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Cycle cost per DRAM hit",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_DRAM_HIT / MEM_LOAD_UOPS_RETI=
RED.DRAM_HIT",
-        "MetricName": "Cycles_per_Demand_Load_DRAM_Hit"
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to other common frontend stalls not catego=
rized.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.OTHER / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_frontend_bandwidth_grou=
p",
+        "MetricName": "tma_other_fb",
+        "MetricThreshold": "tma_other_fb > 0.05",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Percent of instruction miss cost that hit in =
the L2",
-        "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_L2_HIT / MEM_BOUND_ST=
ALLS.IFETCH",
-        "MetricName": "Inst_Miss_Cost_L2Hit_Percent"
+        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a number of other lo=
ad blocks.",
+        "MetricExpr": "LD_HEAD.OTHER_AT_RET / tma_info_clks",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
+        "MetricName": "tma_other_l1",
+        "MetricThreshold": "tma_other_l1 > 0.05",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Percent of instruction miss cost that hit in =
the L3",
-        "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_LLC_HIT / MEM_BOUND_S=
TALLS.IFETCH",
-        "MetricName": "Inst_Miss_Cost_L3Hit_Percent"
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
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Percent of instruction miss cost that hit in =
DRAM",
-        "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_DRAM_HIT / MEM_BOUND_=
STALLS.IFETCH",
-        "MetricName": "Inst_Miss_Cost_DRAMHit_Percent"
+        "BriefDescription": "Counts the number of uops retired excluding m=
s and fp div uops.",
+        "MetricExpr": "(TOPDOWN_RETIRING.ALL - UOPS_RETIRED.MS - UOPS_RETI=
RED.FPDIV) / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_base_group",
+        "MetricName": "tma_other_ret",
+        "MetricThreshold": "tma_other_ret > 0.3",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "load ops retired per 1000 instruction",
-        "MetricExpr": "1e3 * MEM_UOPS_RETIRED.ALL_LOADS / INST_RETIRED.ANY=
",
-        "MetricName": "MemLoadPKI"
+        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to page faults.",
+        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.PAGE_FAULT / MACHINE_CLE=
ARS.SLOW)",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
+        "MetricName": "tma_page_fault",
+        "MetricThreshold": "tma_page_fault > 0.02",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C1 residency percent per core",
-        "MetricExpr": "cstate_core@c1\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C1_Core_Residency",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to wrong predecodes.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.PREDECODE / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_frontend_bandwidth_grou=
p",
+        "MetricName": "tma_predecode",
+        "MetricThreshold": "tma_predecode > 0.05",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C6 residency percent per core",
-        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C6_Core_Residency",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to the physical register file unable to acce=
pt an entry (marble stalls).",
+        "MetricExpr": "TOPDOWN_BE_BOUND.REGISTER / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricName": "tma_register",
+        "MetricThreshold": "tma_register > 0.1",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C7 residency percent per core",
-        "MetricExpr": "cstate_core@c7\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C7_Core_Residency",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to the reorder buffer being full (ROB stalls=
).",
+        "MetricExpr": "TOPDOWN_BE_BOUND.REORDER_BUFFER / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricName": "tma_reorder_buffer",
+        "MetricThreshold": "tma_reorder_buffer > 0.1",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C2 residency percent per package",
-        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C2_Pkg_Residency",
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
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C3 residency percent per package",
-        "MetricExpr": "cstate_pkg@c3\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C3_Pkg_Residency",
+        "BriefDescription": "Counts the numer of issue slots  that result =
in retirement slots.",
+        "MetricExpr": "TOPDOWN_RETIRING.ALL / tma_info_slots",
+        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricName": "tma_retiring",
+        "MetricThreshold": "tma_retiring > 0.75",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C6 residency percent per package",
-        "MetricExpr": "cstate_pkg@c6\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C6_Pkg_Residency",
+        "BriefDescription": "Counts the number of cycles, relative to the =
number of mem_scheduler slots, in which uops are blocked due to RSV full re=
lative",
+        "MetricExpr": "tma_mem_scheduler * MEM_SCHEDULER_BLOCK.RSV / MEM_S=
CHEDULER_BLOCK.ALL",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_mem_scheduler_group",
+        "MetricName": "tma_rsv",
+        "MetricThreshold": "tma_rsv > 0.05",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C7 residency percent per package",
-        "MetricExpr": "cstate_pkg@c7\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C7_Pkg_Residency",
+        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to scoreboards from the instruction queue (I=
Q), jump execution unit (JEU), or microcode sequencer (MS).",
+        "MetricExpr": "TOPDOWN_BE_BOUND.SERIALIZATION / tma_info_slots",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricName": "tma_serialization",
+        "MetricThreshold": "tma_serialization > 0.1",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C8 residency percent per package",
-        "MetricExpr": "cstate_pkg@c8\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C8_Pkg_Residency",
+        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to SMC.",
+        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.SMC / MACHINE_CLEARS.SLO=
W)",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
+        "MetricName": "tma_smc",
+        "MetricThreshold": "tma_smc > 0.02",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C9 residency percent per package",
-        "MetricExpr": "cstate_pkg@c9\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C9_Pkg_Residency",
+        "BriefDescription": "Counts the number of cycles, relative to the =
number of mem_scheduler slots, in which uops are blocked due to store buffe=
r full",
+        "MetricExpr": "tma_store_bound",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_mem_scheduler_group",
+        "MetricName": "tma_st_buffer",
+        "MetricThreshold": "tma_st_buffer > 0.05",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C10 residency percent per package",
-        "MetricExpr": "cstate_pkg@c10\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C10_Pkg_Residency",
+        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a first level TLB mi=
ss.",
+        "MetricExpr": "LD_HEAD.DTLB_MISS_AT_RET / tma_info_clks",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
+        "MetricName": "tma_stlb_hit",
+        "MetricThreshold": "tma_stlb_hit > 0.05",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a second level TLB m=
iss requiring a page walk.",
+        "MetricExpr": "LD_HEAD.PGWALK_AT_RET / tma_info_clks",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
+        "MetricName": "tma_stlb_miss",
+        "MetricThreshold": "tma_stlb_miss > 0.05",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to store buffer full.",
+        "MetricExpr": "tma_mem_scheduler * (MEM_SCHEDULER_BLOCK.ST_BUF / M=
EM_SCHEDULER_BLOCK.ALL)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_load_store_bound_group"=
,
+        "MetricName": "tma_store_bound",
+        "MetricThreshold": "tma_store_bound > 0.1",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a store forward bloc=
k.",
+        "MetricExpr": "LD_HEAD.ST_ADDR_AT_RET / tma_info_clks",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
+        "MetricName": "tma_store_fwd",
+        "MetricThreshold": "tma_store_fwd > 0.05",
         "ScaleUnit": "100%"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 4bcccab07ea9..cad51223d0ea 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,6 +1,6 @@
 Family-model,Version,Filename,EventType
 GenuineIntel-6-(97|9A|B7|BA|BF),v1.18,alderlake,core
-GenuineIntel-6-BE,v1.16,alderlaken,core
+GenuineIntel-6-BE,v1.18,alderlaken,core
 GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
 GenuineIntel-6-(3D|47),v26,broadwell,core
 GenuineIntel-6-56,v7,broadwellde,core
--=20
2.39.2.637.g21b0678d19-goog

