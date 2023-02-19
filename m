Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600D469BF99
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjBSJdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjBSJdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:33:50 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BD21206E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:32:40 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 144-20020a250596000000b008fa1d22bd55so1988436ybf.21
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZa444TGelSxfyFGIASgMZVRbr1mUgy5fMfkXk2Hphs=;
        b=s8MwD3XcpksdpAQ44IhNk599hvZCE39mG8ERX3KznRk7WbK33EPKtTHl604SaZu22f
         W8udp7rA36r7w8E0tgNmbNccHgZTRlSSS+ibAhjSQDm2kR0xfrJTCUllsJ5FEoSbew8r
         9V/QOqjRnmU5oExwB1uVzUYmEpLoDTPEWHbpNWSMTlZ2njVfC/nC/iTfMw86FYFBBbsA
         fECKHQYBu+7Bg9fWIuwrxYPgcC/Zy1oh6sofUQQcbNz48pd1v/VYyYc0ygU6eZt/PVIR
         HB/fT0nE8qNWp9G4+mdhKprjItsI7wAVcMIM2OdJfg42ox/dekM3ajN+0++EeFXX7G9d
         coAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lZa444TGelSxfyFGIASgMZVRbr1mUgy5fMfkXk2Hphs=;
        b=m6c9n5DSsSr1qhyJk2CcTn6L3M5NfBnJBQqaGba+LhpQ/2P9AZB6c+/jJC6E0PxI6I
         510MMMslSiRYkGW+9JkU69PteR7le6tllPRxE4gl2vFwKOGjICsOKN/uG4FGEVg+IO/U
         EWRgNWz6g6SanQT06k6wTOMvQqLBk/dsqqL/OldN8sAZkxC18j+sfAQiYUtmCHAkQRsC
         w28w4CVJu10xmHwGaPrG7XLn3ZetORx2o74qh5gV6yGn3KeF5gCT7a9f4RQuns+litq7
         ZGRWRN//W22SpjcerCum7MsuQMZRQ5Jwx3GnP5bAuEHg+TMeBktiJA49Fykto6toDOHF
         KL5A==
X-Gm-Message-State: AO0yUKUYTC2F636PS8TEKtMqB9YMZDP/qw3Pnskzuc2WGEe4K3a6RxW7
        aXimRosnLA1E0o816TTSDlM11YK7dz2s
X-Google-Smtp-Source: AK7set+ScGCNWwFLva7yP399KIhjoQC04WpP4l3gpZLURZ0z5SYtuxdS8Bq6tVZ5IrgmF08eXlihMAp6zfTK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a05:6902:11cd:b0:90d:a6c0:6870 with SMTP
 id n13-20020a05690211cd00b0090da6c06870mr390938ybu.2.1676799129953; Sun, 19
 Feb 2023 01:32:09 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:20 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-24-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 23/51] perf vendor events intel: Refresh jaketown events
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

Update the jaketown events from 21 to 22. Generation was done
using https://github.com/intel/perfmon.

Notable changes are improved event descriptions, TMA metrics are
updated to version 4.5, TMA info metrics are renamed from their node
name to be lower case and prefixed by tma_info_, MetricThreshold
expressions are added, and the smi_cost metric group is added
replicating existing hard coded metrics in stat-shadow.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/jaketown/cache.json   |   6 +-
 .../arch/x86/jaketown/floating-point.json     |   2 +-
 .../arch/x86/jaketown/frontend.json           |  12 +-
 .../arch/x86/jaketown/jkt-metrics.json        | 602 ++++++++++--------
 .../arch/x86/jaketown/pipeline.json           |   2 +-
 .../arch/x86/jaketown/uncore-cache.json       |  22 +-
 .../x86/jaketown/uncore-interconnect.json     |  74 +--
 .../arch/x86/jaketown/uncore-memory.json      |   4 +-
 .../arch/x86/jaketown/uncore-other.json       |  22 +-
 .../arch/x86/jaketown/uncore-power.json       |   8 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 11 files changed, 409 insertions(+), 347 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/jaketown/cache.json b/tools/per=
f/pmu-events/arch/x86/jaketown/cache.json
index f1271039b6b2..b9769d39940c 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/cache.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/cache.json
@@ -37,7 +37,7 @@
         "UMask": "0x5"
     },
     {
-        "BriefDescription": "Cycles a demand request was blocked due to Fi=
ll Buffers inavailability.",
+        "BriefDescription": "Cycles a demand request was blocked due to Fi=
ll Buffers unavailability.",
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL",
@@ -45,7 +45,7 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "L1D miss oustandings duration in cycles.",
+        "BriefDescription": "L1D miss outstanding duration in cycles.",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING",
         "SampleAfterValue": "2000003",
@@ -500,7 +500,7 @@
         "UMask": "0x8"
     },
     {
-        "BriefDescription": "Cacheable and noncachaeble code read requests=
.",
+        "BriefDescription": "Cacheable and non-cacheable code read request=
s.",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.DEMAND_CODE_RD",
         "SampleAfterValue": "100003",
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/floating-point.json b/=
tools/perf/pmu-events/arch/x86/jaketown/floating-point.json
index 8c2a246adef9..79e8f403c426 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/floating-point.json
@@ -64,7 +64,7 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "Number of FP Computational Uops Executed this=
 cycle. The number of FADD, FSUB, FCOM, FMULs, integer MULsand IMULs, FDIVs=
, FPREMs, FSQRTS, integer DIVs, and IDIVs. This event does not distinguish =
an FADD used in the middle of a transcendental flow from a s.",
+        "BriefDescription": "Number of FP Computational Uops Executed this=
 cycle. The number of FADD, FSUB, FCOM, FMULs, integer MULs and IMULs, FDIV=
s, FPREMs, FSQRTS, integer DIVs, and IDIVs. This event does not distinguish=
 an FADD used in the middle of a transcendental flow from a s.",
         "EventCode": "0x10",
         "EventName": "FP_COMP_OPS_EXE.X87",
         "SampleAfterValue": "2000003",
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/frontend.json b/tools/=
perf/pmu-events/arch/x86/jaketown/frontend.json
index 3f4fc3481112..754ee2749485 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/frontend.json
@@ -134,7 +134,7 @@
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "Cycles when uops are being delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy.",
+        "BriefDescription": "Cycles when uops are being delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequencer (MS) is busy.",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_CYCLES",
@@ -143,7 +143,7 @@
         "UMask": "0x30"
     },
     {
-        "BriefDescription": "Cycles when uops initiated by Decode Stream B=
uffer (DSB) are being delivered to Instruction Decode Queue (IDQ) while Mic=
rocode Sequenser (MS) is busy.",
+        "BriefDescription": "Cycles when uops initiated by Decode Stream B=
uffer (DSB) are being delivered to Instruction Decode Queue (IDQ) while Mic=
rocode Sequencer (MS) is busy.",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_DSB_CYCLES",
@@ -151,7 +151,7 @@
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "Deliveries to Instruction Decode Queue (IDQ) =
initiated by Decode Stream Buffer (DSB) while Microcode Sequenser (MS) is b=
usy.",
+        "BriefDescription": "Deliveries to Instruction Decode Queue (IDQ) =
initiated by Decode Stream Buffer (DSB) while Microcode Sequencer (MS) is b=
usy.",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x79",
@@ -160,14 +160,14 @@
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "Uops initiated by Decode Stream Buffer (DSB) =
that are being delivered to Instruction Decode Queue (IDQ) while Microcode =
Sequenser (MS) is busy.",
+        "BriefDescription": "Uops initiated by Decode Stream Buffer (DSB) =
that are being delivered to Instruction Decode Queue (IDQ) while Microcode =
Sequencer (MS) is busy.",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_DSB_UOPS",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "Uops initiated by MITE and delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy.",
+        "BriefDescription": "Uops initiated by MITE and delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequencer (MS) is busy.",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_MITE_UOPS",
         "SampleAfterValue": "2000003",
@@ -183,7 +183,7 @@
         "UMask": "0x30"
     },
     {
-        "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) while Microcode Sequenser (MS) is busy.",
+        "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) while Microcode Sequencer (MS) is busy.",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_UOPS",
         "SampleAfterValue": "2000003",
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json b/too=
ls/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
index cb1420df3768..e8f4e5c01c9f 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
@@ -1,449 +1,511 @@
 [
     {
-        "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / SLOTS",
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
ache misses would be categorized under Frontend Bound.",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues",
-        "MetricExpr": "4 * min(CPU_CLK_UNHALTED.THREAD, IDQ_UOPS_NOT_DELIV=
ERED.CYCLES_0_UOPS_DELIV.CORE) / SLOTS",
-        "MetricGroup": "Frontend;TopdownL2;tma_L2_group;tma_frontend_bound=
_group",
-        "MetricName": "tma_fetch_latency",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend latency issues.  For example; instruction-=
cache misses; iTLB misses or fetch stalls after a branch misprediction are =
categorized under Frontend Latency. In such cases; the Frontend eventually =
delivers no uops for some period. Sample with: RS_EVENTS.EMPTY_END",
+        "BriefDescription": "C2 residency percent per package",
+        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C2_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
-        "MetricExpr": "(12 * ITLB_MISSES.STLB_HIT + ITLB_MISSES.WALK_DURAT=
ION) / CLKS",
-        "MetricGroup": "BigFoot;FetchLat;MemoryTLB;TopdownL3;tma_fetch_lat=
ency_group",
-        "MetricName": "tma_itlb_misses",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: ITLB_M=
ISSES.WALK_COMPLETED",
+        "BriefDescription": "C3 residency percent per core",
+        "MetricExpr": "cstate_core@c3\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C3_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers",
-        "MetricExpr": "12 * (BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS=
.COUNT + BACLEARS.ANY) / CLKS",
-        "MetricGroup": "FetchLat;TopdownL3;tma_fetch_latency_group",
-        "MetricName": "tma_branch_resteers",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fro=
ntend delay in fetching operations from corrected path; following all sorts=
 of miss-predicted branches. For example; branchy code with lots of miss-pr=
edictions might get categorized under Branch Resteers. Note the value of th=
is node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_BRA=
NCHES",
+        "BriefDescription": "C3 residency percent per package",
+        "MetricExpr": "cstate_pkg@c3\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C3_Pkg_Residency",
         "ScaleUnit": "100%"
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
 this metric measures the exposed penalty.",
+        "BriefDescription": "C6 residency percent per core",
+        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C6_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles CPU=
 was stalled due to Length Changing Prefixes (LCPs)",
-        "MetricExpr": "ILD_STALL.LCP / CLKS",
-        "MetricGroup": "FetchLat;TopdownL3;tma_fetch_latency_group",
-        "MetricName": "tma_lcp",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs.",
+        "BriefDescription": "C6 residency percent per package",
+        "MetricExpr": "cstate_pkg@c6\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C6_Pkg_Residency",
         "ScaleUnit": "100%"
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
with Denormals. Sample with: IDQ.MS_SWITCHES",
+        "BriefDescription": "C7 residency percent per core",
+        "MetricExpr": "cstate_core@c7\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C7_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend bandwidth issues",
-        "MetricExpr": "tma_frontend_bound - tma_fetch_latency",
-        "MetricGroup": "FetchBW;Frontend;TopdownL2;tma_L2_group;tma_fronte=
nd_bound_group",
-        "MetricName": "tma_fetch_bandwidth",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend.",
+        "BriefDescription": "C7 residency percent per package",
+        "MetricExpr": "cstate_pkg@c7\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C7_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
-        "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * =
(INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)=
) / SLOTS",
-        "MetricGroup": "TopdownL1;tma_L1_group",
-        "MetricName": "tma_bad_speculation",
-        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Uncore frequency per die [GHZ]",
+        "MetricExpr": "tma_info_socket_clks / #num_dies / duration_time / =
1e9",
+        "MetricGroup": "SoC",
+        "MetricName": "UNCORE_FREQ"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction",
-        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRED.ALL=
_BRANCHES + MACHINE_CLEARS.COUNT) * tma_bad_speculation",
-        "MetricGroup": "BadSpec;BrMispredicts;TopdownL2;tma_L2_group;tma_b=
ad_speculation_group",
-        "MetricName": "tma_branch_mispredicts",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES",
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
-        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Machine Clears",
-        "MetricExpr": "tma_bad_speculation - tma_branch_mispredicts",
-        "MetricGroup": "BadSpec;MachineClears;TopdownL2;tma_L2_group;tma_b=
ad_speculation_group",
-        "MetricName": "tma_machine_clears",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Machine Clears.  These slots are either wasted by uo=
ps fetched prior to the clear; or stalls the out-of-order portion of the ma=
chine needs to recover its state after the clear. For example; this can hap=
pen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modif=
ying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Number of SMI interrupts.",
+        "MetricExpr": "msr@smi@",
+        "MetricGroup": "smi",
+        "MetricName": "smi_num",
+        "ScaleUnit": "1SMI#"
     },
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma=
_retiring)",
-        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
+        "MetricThreshold": "tma_backend_bound > 0.2",
         "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound.",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
-        "MetricExpr": "(min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.STALLS=
_L1D_PENDING) + RESOURCE_STALLS.SB) / (min(CPU_CLK_UNHALTED.THREAD, CYCLE_A=
CTIVITY.CYCLES_NO_DISPATCH) + cpu@UOPS_DISPATCHED.THREAD\\,cmask\\=3D1@ - c=
pu@UOPS_DISPATCHED.THREAD\\,cmask\\=3D3@ if IPC > 1.8 else (cpu@UOPS_DISPAT=
CHED.THREAD\\,cmask\\=3D2@ - RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > =
0.1 else RESOURCE_STALLS.SB)) * tma_backend_bound",
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
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
-        "MetricExpr": "(7 * DTLB_LOAD_MISSES.STLB_HIT + DTLB_LOAD_MISSES.W=
ALK_DURATION) / CLKS",
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
 miss. Sample with: MEM_UOPS_RETIRED.STLB_MISS_LOADS_PS",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
-        "MetricExpr": "MEM_LOAD_UOPS_RETIRED.LLC_HIT / (MEM_LOAD_UOPS_RETI=
RED.LLC_HIT + 7 * MEM_LOAD_UOPS_RETIRED.LLC_MISS) * CYCLE_ACTIVITY.STALLS_L=
2_PENDING / CLKS",
-        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_mem=
ory_bound_group",
-        "MetricName": "tma_l3_bound",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT_PS",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
-        "MetricExpr": "(1 - MEM_LOAD_UOPS_RETIRED.LLC_HIT / (MEM_LOAD_UOPS=
_RETIRED.LLC_HIT + 7 * MEM_LOAD_UOPS_RETIRED.LLC_MISS)) * CYCLE_ACTIVITY.ST=
ALLS_L2_PENDING / CLKS",
-        "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_memory_bound_gr=
oup",
-        "MetricName": "tma_dram_bound",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_UOPS_RE=
TIRED.L3_MISS_PS",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory (DRAM)",
-        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D6@) / CLKS",
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
+        "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
+        "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * =
(INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)=
) / tma_info_slots",
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
         "ScaleUnit": "100%"
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
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRED.ALL=
_BRANCHES + MACHINE_CLEARS.COUNT) * tma_bad_speculation",
+        "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_group=
;tma_bad_speculation_group;tma_issueBM",
+        "MetricName": "tma_branch_mispredicts",
+        "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specula=
tion > 0.15",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics:=
 tma_info_branch_misprediction_cost, tma_mispredicts_resteers",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to RFO store memory accesses; RFO store issue a read-for-ownership =
request before the write",
-        "MetricExpr": "RESOURCE_STALLS.SB / CLKS",
-        "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_memory_bound_gr=
oup",
-        "MetricName": "tma_store_bound",
-        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to RFO store memory accesses; RFO store issue a read-for-ownership=
 request before the write. Even though store accesses do not typically stal=
l out-of-order CPUs; there are few cases where stores can lead to actual st=
alls. This metric will be flagged should RFO stores be a bottleneck. Sample=
 with: MEM_UOPS_RETIRED.ALL_STORES_PS",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers",
+        "MetricExpr": "12 * (BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS=
.COUNT + BACLEARS.ANY) / tma_info_clks",
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e Core non-memory issues were of a bottleneck",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "tma_backend_bound - tma_memory_bound",
-        "MetricGroup": "Backend;Compute;TopdownL2;tma_L2_group;tma_backend=
_bound_group",
+        "MetricGroup": "Backend;Compute;TmaL2;TopdownL2;tma_L2_group;tma_b=
ackend_bound_group",
         "MetricName": "tma_core_bound",
+        "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2=
",
         "PublicDescription": "This metric represents fraction of slots whe=
re Core non-memory issues were of a bottleneck.  Shortage in hardware compu=
te resources; or dependencies in software's instructions are both categoriz=
ed under Core Bound. Hence it may indicate the machine ran out of an out-of=
-order resource; certain execution units are overloaded or dependencies in =
program's data- or instruction-flow are limiting the performance (e.g. FP-c=
hained long-latency arithmetic operations).",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re the Divider unit was active",
-        "MetricExpr": "ARITH.FPU_DIV_ACTIVE / CORE_CLKS",
-        "MetricGroup": "TopdownL3;tma_core_bound_group",
+        "MetricExpr": "ARITH.FPU_DIV_ACTIVE / tma_info_core_clks",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_core_bound_group",
         "MetricName": "tma_divider",
+        "MetricThreshold": "tma_divider > 0.2 & (tma_core_bound > 0.1 & tm=
a_backend_bound > 0.2)",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIVIDER_UOPS",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
-        "MetricExpr": "((min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLE=
S_NO_DISPATCH) + cpu@UOPS_DISPATCHED.THREAD\\,cmask\\=3D1@ - cpu@UOPS_DISPA=
TCHED.THREAD\\,cmask\\=3D3@ if IPC > 1.8 else (cpu@UOPS_DISPATCHED.THREAD\\=
,cmask\\=3D2@ - RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else RESO=
URCE_STALLS.SB)) - RESOURCE_STALLS.SB - min(CPU_CLK_UNHALTED.THREAD, CYCLE_=
ACTIVITY.STALLS_L1D_PENDING)) / CLKS",
-        "MetricGroup": "PortsUtil;TopdownL3;tma_core_bound_group",
-        "MetricName": "tma_ports_utilization",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations.",
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
+        "MetricConstraint": "NO_GROUP_EVENTS_SMT",
+        "MetricExpr": "(1 - MEM_LOAD_UOPS_RETIRED.LLC_HIT / (MEM_LOAD_UOPS=
_RETIRED.LLC_HIT + 7 * MEM_LOAD_UOPS_RETIRED.LLC_MISS)) * CYCLE_ACTIVITY.ST=
ALLS_L2_PENDING / tma_info_clks",
+        "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
+        "MetricName": "tma_dram_bound",
+        "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_UOPS_RE=
TIRED.L3_MISS_PS",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / SLOTS",
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
D.RETIRE_SLOTS",
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
 this metric measures the exposed penalty. Related metrics: tma_fetch_bandw=
idth, tma_info_dsb_coverage, tma_lcp",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations -- instructions that require=
 no more than one uop (micro-operation)",
-        "MetricExpr": "tma_retiring - tma_heavy_operations",
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
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
+        "MetricExpr": "(7 * DTLB_LOAD_MISSES.STLB_HIT + DTLB_LOAD_MISSES.W=
ALK_DURATION) / tma_info_clks",
+        "MetricGroup": "MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB;tma_=
l1_bound_group",
+        "MetricName": "tma_dtlb_load",
+        "MetricThreshold": "tma_dtlb_load > 0.1",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_UOPS_RETIRED.STLB_MISS_LOADS_PS. Related metrics: t=
ma_dtlb_store",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend bandwidth issues",
+        "MetricExpr": "tma_frontend_bound - tma_fetch_latency",
+        "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tma_=
frontend_bound_group;tma_issueFB",
+        "MetricName": "tma_fetch_bandwidth",
+        "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bound=
 > 0.15 & tma_info_ipc / 4 > 0.35",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Rel=
ated metrics: tma_dsb_switches, tma_info_dsb_coverage, tma_lcp",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues",
+        "MetricExpr": "4 * min(CPU_CLK_UNHALTED.THREAD, IDQ_UOPS_NOT_DELIV=
ERED.CYCLES_0_UOPS_DELIV.CORE) / tma_info_slots",
+        "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend=
_bound_group",
+        "MetricName": "tma_fetch_latency",
+        "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound >=
 0.15",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend latency issues.  For example; instruction-=
cache misses; iTLB misses or fetch stalls after a branch misprediction are =
categorized under Frontend Latency. In such cases; the Frontend eventually =
delivers no uops for some period. Sample with: RS_EVENTS.EMPTY_END",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents overall arithmetic flo=
ating-point (FP) operations fraction the CPU has executed (retired)",
         "MetricExpr": "tma_x87_use + tma_fp_scalar + tma_fp_vector",
-        "MetricGroup": "HPC;TopdownL3;tma_light_operations_group",
+        "MetricGroup": "HPC;TopdownL3;tma_L3_group;tma_light_operations_gr=
oup",
         "MetricName": "tma_fp_arith",
+        "MetricThreshold": "tma_fp_arith > 0.2 & tma_light_operations > 0.=
6",
         "PublicDescription": "This metric represents overall arithmetic fl=
oating-point (FP) operations fraction the CPU has executed (retired). Note =
this metric's value may exceed its parent due to use of \"Uops\" CountDomai=
n and FMA double-counting.",
         "ScaleUnit": "100%"
     },
-    {
-        "BriefDescription": "This metric serves as an approximation of leg=
acy x87 usage",
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS * FP_COMP_OPS_EXE.X87 / U=
OPS_DISPATCHED.THREAD",
-        "MetricGroup": "Compute;TopdownL4;tma_fp_arith_group",
-        "MetricName": "tma_x87_use",
-        "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint.",
-        "ScaleUnit": "100%"
-    },
     {
         "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) scalar uops fraction the CPU has retired",
         "MetricExpr": "(FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EX=
E.SSE_SCALAR_DOUBLE) / UOPS_DISPATCHED.THREAD",
-        "MetricGroup": "Compute;Flops;TopdownL4;tma_fp_arith_group",
+        "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_scalar",
-        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting.",
+        "MetricThreshold": "tma_fp_scalar > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting. Related metrics: tma_fp_vector, tma_fp_vector_512b, tm=
a_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) vector uops fraction the CPU has retired aggregated across all v=
ector widths",
         "MetricExpr": "(FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + FP_COMP_OPS_EX=
E.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE=
) / UOPS_DISPATCHED.THREAD",
-        "MetricGroup": "Compute;Flops;TopdownL4;tma_fp_arith_group",
+        "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_vector",
-        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting.",
+        "MetricThreshold": "tma_fp_vector > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting. Related metrics: t=
ma_fp_scalar, tma_fp_vector_512b, tma_port_6, tma_ports_utilized_2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_slots",
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
cache misses would be categorized under Frontend Bound.",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or microcoded sequences",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or micro-coded sequences",
         "MetricExpr": "tma_microcode_sequencer",
-        "MetricGroup": "Retire;TopdownL2;tma_L2_group;tma_retiring_group",
+        "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_g=
roup",
         "MetricName": "tma_heavy_operations",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or microcoded sequences. This highly-correlates with the=
 uop length of these instructions/sequences.",
+        "MetricThreshold": "tma_heavy_operations > 0.1",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or micro-coded sequences. This highly-correlates with th=
e uop length of these instructions/sequences.",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU was retiring uops fetched by the Microcode Sequencer (MS) unit",
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / UOPS_ISSUED.ANY * IDQ.M=
S_UOPS / SLOTS",
-        "MetricGroup": "MicroSeq;TopdownL3;tma_heavy_operations_group",
-        "MetricName": "tma_microcode_sequencer",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The M=
S is used for CISC instructions not supported by the default decoders (like=
 repeat move strings; or CPUID); or by microcode assists used to address so=
me operation modes (like in Floating Point assists). These cases can often =
be avoided. Sample with: IDQ.MS_UOPS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Measured Average Frequency for unhalted proce=
ssors [GHz]",
+        "MetricExpr": "tma_info_turbo_utilization * TSC / 1e9 / duration_t=
ime",
+        "MetricGroup": "Power;Summary",
+        "MetricName": "tma_info_average_frequency"
     },
     {
-        "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
-        "MetricExpr": "INST_RETIRED.ANY / CLKS",
-        "MetricGroup": "Ret;Summary",
-        "MetricName": "IPC"
+        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "Pipeline",
+        "MetricName": "tma_info_clks"
     },
     {
-        "BriefDescription": "Uops Per Instruction",
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
-        "MetricGroup": "Pipeline;Ret;Retire",
-        "MetricName": "UPI"
+        "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
+        "MetricExpr": "(CPU_CLK_UNHALTED.THREAD / 2 * (1 + CPU_CLK_UNHALTE=
D.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK) if #core_wide < 1 else (CP=
U_CLK_UNHALTED.THREAD_ANY / 2 if #SMT_on else tma_info_clks))",
+        "MetricGroup": "SMT",
+        "MetricName": "tma_info_core_clks"
+    },
+    {
+        "BriefDescription": "Instructions Per Cycle across hyper-threads (=
per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / tma_info_core_clks",
+        "MetricGroup": "Ret;SMT;TmaL1;tma_L1_group",
+        "MetricName": "tma_info_coreipc"
     },
     {
         "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
-        "MetricExpr": "1 / IPC",
+        "MetricExpr": "1 / tma_info_ipc",
         "MetricGroup": "Mem;Pipeline",
-        "MetricName": "CPI"
+        "MetricName": "tma_info_cpi"
     },
     {
-        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "Pipeline",
-        "MetricName": "CLKS"
+        "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricGroup": "HPC;Summary",
+        "MetricName": "tma_info_cpu_utilization"
     },
     {
-        "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
-        "MetricExpr": "4 * CORE_CLKS",
-        "MetricGroup": "tma_L1_group",
-        "MetricName": "SLOTS"
+        "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
+        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e=
9 / duration_time",
+        "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
+        "MetricName": "tma_info_dram_bw_use",
+        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_mem_bandwidth"
+    },
+    {
+        "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
+        "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_=
UOPS + IDQ.MS_UOPS)",
+        "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
+        "MetricName": "tma_info_dsb_coverage",
+        "MetricThreshold": "tma_info_dsb_coverage < 0.7 & tma_info_ipc / 4=
 > 0.35",
+        "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_lcp"
     },
     {
         "BriefDescription": "The ratio of Executed- by Issued-Uops",
         "MetricExpr": "UOPS_DISPATCHED.THREAD / UOPS_ISSUED.ANY",
         "MetricGroup": "Cor;Pipeline",
-        "MetricName": "Execute_per_Issue",
+        "MetricName": "tma_info_execute_per_issue",
         "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage."
     },
-    {
-        "BriefDescription": "Instructions Per Cycle across hyper-threads (=
per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / CORE_CLKS",
-        "MetricGroup": "Ret;SMT;tma_L1_group",
-        "MetricName": "CoreIPC"
-    },
     {
         "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricExpr": "(FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EX=
E.SSE_SCALAR_DOUBLE + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * (FP_COMP_=
OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE) + 8 * SIMD_FP_256.PA=
CKED_SINGLE) / CORE_CLKS",
+        "MetricExpr": "(FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EX=
E.SSE_SCALAR_DOUBLE + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * (FP_COMP_=
OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE) + 8 * SIMD_FP_256.PA=
CKED_SINGLE) / tma_info_core_clks",
         "MetricGroup": "Flops;Ret",
-        "MetricName": "FLOPc"
+        "MetricName": "tma_info_flopc"
+    },
+    {
+        "BriefDescription": "Giga Floating Point Operations Per Second",
+        "MetricExpr": "(FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EX=
E.SSE_SCALAR_DOUBLE + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * (FP_COMP_=
OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE) + 8 * SIMD_FP_256.PA=
CKED_SINGLE) / 1e9 / duration_time",
+        "MetricGroup": "Cor;Flops;HPC",
+        "MetricName": "tma_info_gflops",
+        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine."
     },
     {
         "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
         "MetricExpr": "UOPS_DISPATCHED.THREAD / (cpu@UOPS_DISPATCHED.CORE\=
\,cmask\\=3D1@ / 2 if #SMT_on else cpu@UOPS_DISPATCHED.CORE\\,cmask\\=3D1@)=
",
         "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
-        "MetricName": "ILP"
+        "MetricName": "tma_info_ilp"
     },
     {
-        "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
-        "MetricExpr": "(CPU_CLK_UNHALTED.THREAD / 2 * (1 + CPU_CLK_UNHALTE=
D.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK) if #core_wide < 1 else (CP=
U_CLK_UNHALTED.THREAD_ANY / 2 if #SMT_on else CLKS))",
-        "MetricGroup": "SMT",
-        "MetricName": "CORE_CLKS"
+        "BriefDescription": "Total number of retired Instructions",
+        "MetricExpr": "INST_RETIRED.ANY",
+        "MetricGroup": "Summary;TmaL1;tma_L1_group",
+        "MetricName": "tma_info_instructions",
+        "PublicDescription": "Total number of retired Instructions. Sample=
 with: INST_RETIRED.PREC_DIST"
     },
     {
-        "BriefDescription": "Total number of retired Instructions Sample w=
ith: INST_RETIRED.PREC_DIST",
-        "MetricExpr": "INST_RETIRED.ANY",
-        "MetricGroup": "Summary;tma_L1_group",
-        "MetricName": "Instructions"
+        "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
+        "MetricExpr": "INST_RETIRED.ANY / tma_info_clks",
+        "MetricGroup": "Ret;Summary",
+        "MetricName": "tma_info_ipc"
     },
     {
-        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / cpu@UOPS_RETIRED.RETIRE=
_SLOTS\\,cmask\\=3D1@",
-        "MetricGroup": "Pipeline;Ret",
-        "MetricName": "Retire"
+        "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
+        "MetricGroup": "Branches;OS",
+        "MetricName": "tma_info_ipfarbranch",
+        "MetricThreshold": "tma_info_ipfarbranch < 1e6"
     },
     {
-        "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
-        "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_=
UOPS + IDQ.MS_UOPS)",
-        "MetricGroup": "DSB;Fed;FetchBW",
-        "MetricName": "DSB_Coverage"
+        "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
+        "MetricGroup": "OS",
+        "MetricName": "tma_info_kernel_cpi"
     },
     {
-        "BriefDescription": "Average CPU Utilization",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
-        "MetricGroup": "HPC;Summary",
-        "MetricName": "CPU_Utilization"
+        "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.THRE=
AD",
+        "MetricGroup": "OS",
+        "MetricName": "tma_info_kernel_utilization",
+        "MetricThreshold": "tma_info_kernel_utilization > 0.05"
     },
     {
-        "BriefDescription": "Measured Average Frequency for unhalted proce=
ssors [GHz]",
-        "MetricExpr": "Turbo_Utilization * TSC / 1e9 / duration_time",
-        "MetricGroup": "Power;Summary",
-        "MetricName": "Average_Frequency"
+        "BriefDescription": "Average number of parallel data read requests=
 to external memory",
+        "MetricExpr": "UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=3D0x18=
2@ / UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=3D0x182\\,thresh\\=3D1@",
+        "MetricGroup": "Mem;MemoryBW;SoC",
+        "MetricName": "tma_info_mem_parallel_reads",
+        "PublicDescription": "Average number of parallel data read request=
s to external memory. Accounts for demand loads and L1/L2 prefetches"
     },
     {
-        "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "(FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EX=
E.SSE_SCALAR_DOUBLE + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * (FP_COMP_=
OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE) + 8 * SIMD_FP_256.PA=
CKED_SINGLE) / 1e9 / duration_time",
-        "MetricGroup": "Cor;Flops;HPC",
-        "MetricName": "GFLOPs",
-        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine."
+        "BriefDescription": "Average latency of data read request to exter=
nal memory (in nanoseconds)",
+        "MetricExpr": "1e9 * (UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=
=3D0x182@ / UNC_C_TOR_INSERTS.MISS_OPCODE@filter_opc\\=3D0x182@) / (tma_inf=
o_socket_clks / duration_time)",
+        "MetricGroup": "Mem;MemoryLat;SoC",
+        "MetricName": "tma_info_mem_read_latency",
+        "PublicDescription": "Average latency of data read request to exte=
rnal memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetche=
s. ([RKL+]memory-controller only)"
     },
     {
-        "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
-        "MetricExpr": "CLKS / CPU_CLK_UNHALTED.REF_TSC",
-        "MetricGroup": "Power",
-        "MetricName": "Turbo_Utilization"
+        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / cpu@UOPS_RETIRED.RETIRE=
_SLOTS\\,cmask\\=3D1@",
+        "MetricGroup": "Pipeline;Ret",
+        "MetricName": "tma_info_retire"
+    },
+    {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
+        "MetricExpr": "4 * tma_info_core_clks",
+        "MetricGroup": "TmaL1;tma_L1_group",
+        "MetricName": "tma_info_slots"
     },
     {
         "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
         "MetricExpr": "(1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / (CPU_CLK_=
UNHALTED.REF_XCLK_ANY / 2) if #SMT_on else 0)",
         "MetricGroup": "SMT",
-        "MetricName": "SMT_2T_Utilization"
+        "MetricName": "tma_info_smt_2t_utilization"
     },
     {
-        "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.THRE=
AD",
-        "MetricGroup": "OS",
-        "MetricName": "Kernel_Utilization"
+        "BriefDescription": "Socket actual clocks when any core is active =
on that socket",
+        "MetricExpr": "cbox_0@event\\=3D0x0@",
+        "MetricGroup": "SoC",
+        "MetricName": "tma_info_socket_clks"
     },
     {
-        "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
-        "MetricGroup": "OS",
-        "MetricName": "Kernel_CPI"
+        "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
+        "MetricExpr": "tma_info_clks / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricGroup": "Power",
+        "MetricName": "tma_info_turbo_utilization"
     },
     {
-        "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
-        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e=
9 / duration_time",
-        "MetricGroup": "HPC;Mem;MemoryBW;SoC",
-        "MetricName": "DRAM_BW_Use"
+        "BriefDescription": "Uops Per Instruction",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
+        "MetricGroup": "Pipeline;Ret;Retire",
+        "MetricName": "tma_info_uoppi",
+        "MetricThreshold": "tma_info_uoppi > 1.05"
     },
     {
-        "BriefDescription": "Average latency of data read request to exter=
nal memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetches=
",
-        "MetricExpr": "1e9 * (UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=
=3D0x182@ / UNC_C_TOR_INSERTS.MISS_OPCODE@filter_opc\\=3D0x182@) / (Socket_=
CLKS / duration_time)",
-        "MetricGroup": "Mem;MemoryLat;SoC",
-        "MetricName": "MEM_Read_Latency"
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
+        "MetricExpr": "(12 * ITLB_MISSES.STLB_HIT + ITLB_MISSES.WALK_DURAT=
ION) / tma_info_clks",
+        "MetricGroup": "BigFoot;FetchLat;MemoryTLB;TopdownL3;tma_L3_group;=
tma_fetch_latency_group",
+        "MetricName": "tma_itlb_misses",
+        "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: ITLB_M=
ISSES.WALK_COMPLETED",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average number of parallel data read requests=
 to external memory. Accounts for demand loads and L1/L2 prefetches",
-        "MetricExpr": "UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=3D0x18=
2@ / UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=3D0x182\\,thresh\\=3D1@",
-        "MetricGroup": "Mem;MemoryBW;SoC",
-        "MetricName": "MEM_Parallel_Reads"
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
+        "MetricConstraint": "NO_GROUP_EVENTS_SMT",
+        "MetricExpr": "MEM_LOAD_UOPS_RETIRED.LLC_HIT / (MEM_LOAD_UOPS_RETI=
RED.LLC_HIT + 7 * MEM_LOAD_UOPS_RETIRED.LLC_MISS) * CYCLE_ACTIVITY.STALLS_L=
2_PENDING / tma_info_clks",
+        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
+        "MetricName": "tma_l3_bound",
+        "MetricThreshold": "tma_l3_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT_PS",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Socket actual clocks when any core is active =
on that socket",
-        "MetricExpr": "cbox_0@event\\=3D0x0@",
-        "MetricGroup": "SoC",
-        "MetricName": "Socket_CLKS"
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 was stalled due to Length Changing Prefixes (LCPs)",
+        "MetricExpr": "ILD_STALL.LCP / tma_info_clks",
+        "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group;tma_issueFB",
+        "MetricName": "tma_lcp",
+        "MetricThreshold": "tma_lcp > 0.05 & (tma_fetch_latency > 0.1 & tm=
a_frontend_bound > 0.15)",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs. Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_dsb_coverage",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
-        "MetricGroup": "Branches;OS",
-        "MetricName": "IpFarBranch"
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations -- instructions that require=
 no more than one uop (micro-operation)",
+        "MetricExpr": "tma_retiring - tma_heavy_operations",
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
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Uncore frequency per die [GHZ]",
-        "MetricExpr": "Socket_CLKS / #num_dies / duration_time / 1e9",
-        "MetricGroup": "SoC",
-        "MetricName": "UNCORE_FREQ"
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Machine Clears",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "tma_bad_speculation - tma_branch_mispredicts",
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
tma_clears_resteers, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches=
, tma_remote_cache",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C3 residency percent per core",
-        "MetricExpr": "cstate_core@c3\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C3_Core_Residency",
+        "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory (DRAM)",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D6@) / tma_info_clks",
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
ated metrics: tma_info_dram_bw_use",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C6 residency percent per core",
-        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C6_Core_Residency",
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
Physical Cores/sockets (see Uncore counters for that). Related metrics: ",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C7 residency percent per core",
-        "MetricExpr": "cstate_core@c7\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C7_Core_Residency",
+        "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.STALLS=
_L1D_PENDING) + RESOURCE_STALLS.SB) / (min(CPU_CLK_UNHALTED.THREAD, CYCLE_A=
CTIVITY.CYCLES_NO_DISPATCH) + cpu@UOPS_DISPATCHED.THREAD\\,cmask\\=3D1@ - (=
cpu@UOPS_DISPATCHED.THREAD\\,cmask\\=3D3@ if tma_info_ipc > 1.8 else cpu@UO=
PS_DISPATCHED.THREAD\\,cmask\\=3D2@) - (RS_EVENTS.EMPTY_CYCLES if tma_fetch=
_latency > 0.1 else 0) + RESOURCE_STALLS.SB) * tma_backend_bound",
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
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C2 residency percent per package",
-        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C2_Pkg_Residency",
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was retiring uops fetched by the Microcode Sequencer (MS) unit",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / UOPS_ISSUED.ANY * IDQ.M=
S_UOPS / tma_info_slots",
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
be avoided. Sample with: IDQ.MS_UOPS. Related metrics: tma_clears_resteers,=
 tma_l1_bound, tma_machine_clears, tma_ms_switches",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C3 residency percent per package",
-        "MetricExpr": "cstate_pkg@c3\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C3_Pkg_Residency",
+        "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS)",
+        "MetricExpr": "3 * IDQ.MS_SWITCHES / tma_info_clks",
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
with Denormals. Sample with: IDQ.MS_SWITCHES. Related metrics: tma_clears_r=
esteers, tma_l1_bound, tma_machine_clears, tma_microcode_sequencer, tma_mix=
ing_vectors, tma_serializing_operation",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C6 residency percent per package",
-        "MetricExpr": "cstate_pkg@c6\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C6_Pkg_Residency",
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLES=
_NO_DISPATCH) + cpu@UOPS_DISPATCHED.THREAD\\,cmask\\=3D1@ - (cpu@UOPS_DISPA=
TCHED.THREAD\\,cmask\\=3D3@ if tma_info_ipc > 1.8 else cpu@UOPS_DISPATCHED.=
THREAD\\,cmask\\=3D2@) - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1=
 else 0) + RESOURCE_STALLS.SB - RESOURCE_STALLS.SB - min(CPU_CLK_UNHALTED.T=
HREAD, CYCLE_ACTIVITY.STALLS_L1D_PENDING)) / tma_info_clks",
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
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C7 residency percent per package",
-        "MetricExpr": "cstate_pkg@c7\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C7_Pkg_Residency",
+        "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_slots",
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
.RETIRE_SLOTS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to RFO store memory accesses; RFO store issue a read-for-ownership =
request before the write",
+        "MetricExpr": "RESOURCE_STALLS.SB / tma_info_clks",
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
 with: MEM_UOPS_RETIRED.ALL_STORES_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric serves as an approximation of leg=
acy x87 usage",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS * FP_COMP_OPS_EXE.X87 / U=
OPS_DISPATCHED.THREAD",
+        "MetricGroup": "Compute;TopdownL4;tma_L4_group;tma_fp_arith_group"=
,
+        "MetricName": "tma_x87_use",
+        "MetricThreshold": "tma_x87_use > 0.1 & (tma_fp_arith > 0.2 & tma_=
light_operations > 0.6)",
+        "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint.",
         "ScaleUnit": "100%"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json b/tools/=
perf/pmu-events/arch/x86/jaketown/pipeline.json
index 11d41ce8c922..85c04fe7632a 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
@@ -501,7 +501,7 @@
         "BriefDescription": "Cases when loads get true Block-on-Store bloc=
king code preventing store forwarding.",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
-        "PublicDescription": "This event counts loads that followed a stor=
e to the same address, where the data could not be forwarded inside the pip=
eline from the store to the load.  The most common reason why store forward=
ing would be blocked is when a load's address range overlaps with a preceed=
ing smaller uncompleted store.  See the table of not supported store forwar=
ds in the Intel? 64 and IA-32 Architectures Optimization Reference Manual. =
 The penalty for blocked store forwarding is that the load must wait for th=
e store to complete before it can be issued.",
+        "PublicDescription": "This event counts loads that followed a stor=
e to the same address, where the data could not be forwarded inside the pip=
eline from the store to the load.  The most common reason why store forward=
ing would be blocked is when a load's address range overlaps with a precedi=
ng smaller uncompleted store.  See the table of not supported store forward=
s in the Intel? 64 and IA-32 Architectures Optimization Reference Manual.  =
The penalty for blocked store forwarding is that the load must wait for the=
 store to complete before it can be issued.",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json b/to=
ols/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
index b9e68f9f33ea..47830ca5c682 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
@@ -572,7 +572,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.EVICTION",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x4",
         "Unit": "CBO"
     },
@@ -581,7 +581,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_ALL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0xa",
         "Unit": "CBO"
     },
@@ -590,7 +590,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x3",
         "Unit": "CBO"
     },
@@ -599,7 +599,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_ALL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x48",
         "Unit": "CBO"
     },
@@ -608,7 +608,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_EVICTION",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x44",
         "Unit": "CBO"
     },
@@ -617,7 +617,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_MISS_ALL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x4a",
         "Unit": "CBO"
     },
@@ -626,7 +626,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_MISS_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x43",
         "Unit": "CBO"
     },
@@ -635,7 +635,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x41",
         "Unit": "CBO"
     },
@@ -644,7 +644,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_WB",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x50",
         "Unit": "CBO"
     },
@@ -653,7 +653,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x1",
         "Unit": "CBO"
     },
@@ -662,7 +662,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.WB",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x10",
         "Unit": "CBO"
     },
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.js=
on b/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
index 1c2cf94889a1..b16bb649225d 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
@@ -20,7 +20,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
@@ -29,7 +29,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_RBT",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.",
         "UMask": "0x8",
         "Unit": "QPI LL"
     },
@@ -38,7 +38,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_RBT",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
@@ -47,7 +47,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.SUCCESS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
@@ -80,7 +80,7 @@
         "EventCode": "0x9",
         "EventName": "UNC_Q_RxL_BYPASSED",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that an incoming =
flit was able to bypass the flit buffer and pass directly across the BGF an=
d into the Egress.  This is a latency optimization, and should generally be=
 the common case.  If this value is less than the number of flits transfere=
d, it implies that there was queueing getting onto the ring, and thus the t=
ransactions saw higher latency.",
+        "PublicDescription": "Counts the number of times that an incoming =
flit was able to bypass the flit buffer and pass directly across the BGF an=
d into the Egress.  This is a latency optimization, and should generally be=
 the common case.  If this value is less than the number of flits transferr=
ed, it implies that there was queueing getting onto the ring, and thus the =
transactions saw higher latency.",
         "Unit": "QPI LL"
     },
     {
@@ -176,7 +176,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_Q_RxL_FLITS_G0.DATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each '=
flit' is made up of 80 bits of information (in addition to some ECC data). =
 In full-width (L0) mode, flits are made up of four 'fits', each of which c=
ontains 20 bits of data (along with some additional ECC data).   In half-wi=
dth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as =
many fits to transmit a flit.  When one talks about QPI 'speed' (for exampl=
e, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the =
system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can =
calculate the bandwidth of the link by taking: flits*80b/time.  Note that t=
his is not the same as 'data' bandwidth.  For example, when we are transfer=
ing a 64B cacheline across QPI, we will break it into 9 flits -- 1 with hea=
der information and 8 with 64 bits of actual 'data' and an additional 16 bi=
ts of other information.  To calculate 'data' bandwidth, one should therefo=
re do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each '=
flit' is made up of 80 bits of information (in addition to some ECC data). =
 In full-width (L0) mode, flits are made up of four 'fits', each of which c=
ontains 20 bits of data (along with some additional ECC data).   In half-wi=
dth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as =
many fits to transmit a flit.  When one talks about QPI 'speed' (for exampl=
e, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the =
system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can =
calculate the bandwidth of the link by taking: flits*80b/time.  Note that t=
his is not the same as 'data' bandwidth.  For example, when we are transfer=
ring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with he=
ader information and 8 with 64 bits of actual 'data' and an additional 16 b=
its of other information.  To calculate 'data' bandwidth, one should theref=
ore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
@@ -185,7 +185,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_Q_RxL_FLITS_G0.IDLE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each '=
flit' is made up of 80 bits of information (in addition to some ECC data). =
 In full-width (L0) mode, flits are made up of four 'fits', each of which c=
ontains 20 bits of data (along with some additional ECC data).   In half-wi=
dth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as =
many fits to transmit a flit.  When one talks about QPI 'speed' (for exampl=
e, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the =
system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can =
calculate the bandwidth of the link by taking: flits*80b/time.  Note that t=
his is not the same as 'data' bandwidth.  For example, when we are transfer=
ing a 64B cacheline across QPI, we will break it into 9 flits -- 1 with hea=
der information and 8 with 64 bits of actual 'data' and an additional 16 bi=
ts of other information.  To calculate 'data' bandwidth, one should therefo=
re do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each '=
flit' is made up of 80 bits of information (in addition to some ECC data). =
 In full-width (L0) mode, flits are made up of four 'fits', each of which c=
ontains 20 bits of data (along with some additional ECC data).   In half-wi=
dth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as =
many fits to transmit a flit.  When one talks about QPI 'speed' (for exampl=
e, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the =
system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can =
calculate the bandwidth of the link by taking: flits*80b/time.  Note that t=
his is not the same as 'data' bandwidth.  For example, when we are transfer=
ring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with he=
ader information and 8 with 64 bits of actual 'data' and an additional 16 b=
its of other information.  To calculate 'data' bandwidth, one should theref=
ore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
@@ -194,7 +194,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_Q_RxL_FLITS_G0.NON_DATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each '=
flit' is made up of 80 bits of information (in addition to some ECC data). =
 In full-width (L0) mode, flits are made up of four 'fits', each of which c=
ontains 20 bits of data (along with some additional ECC data).   In half-wi=
dth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as =
many fits to transmit a flit.  When one talks about QPI 'speed' (for exampl=
e, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the =
system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can =
calculate the bandwidth of the link by taking: flits*80b/time.  Note that t=
his is not the same as 'data' bandwidth.  For example, when we are transfer=
ing a 64B cacheline across QPI, we will break it into 9 flits -- 1 with hea=
der information and 8 with 64 bits of actual 'data' and an additional 16 bi=
ts of other information.  To calculate 'data' bandwidth, one should therefo=
re do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each '=
flit' is made up of 80 bits of information (in addition to some ECC data). =
 In full-width (L0) mode, flits are made up of four 'fits', each of which c=
ontains 20 bits of data (along with some additional ECC data).   In half-wi=
dth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as =
many fits to transmit a flit.  When one talks about QPI 'speed' (for exampl=
e, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the =
system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can =
calculate the bandwidth of the link by taking: flits*80b/time.  Note that t=
his is not the same as 'data' bandwidth.  For example, when we are transfer=
ring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with he=
ader information and 8 with 64 bits of actual 'data' and an additional 16 b=
its of other information.  To calculate 'data' bandwidth, one should theref=
ore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
@@ -203,7 +203,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.DRS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x18",
         "Unit": "QPI LL"
     },
@@ -212,7 +212,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.DRS_DATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x8",
         "Unit": "QPI LL"
     },
@@ -221,7 +221,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.DRS_NONDATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x10",
         "Unit": "QPI LL"
     },
@@ -230,7 +230,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.HOM",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x6",
         "Unit": "QPI LL"
     },
@@ -239,7 +239,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.HOM_NONREQ",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
@@ -248,7 +248,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.HOM_REQ",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
@@ -257,7 +257,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.SNP",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
@@ -266,7 +266,7 @@
         "EventCode": "0x3",
         "EventName": "UNC_Q_RxL_FLITS_G2.NCB",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0xc",
         "Unit": "QPI LL"
     },
@@ -275,7 +275,7 @@
         "EventCode": "0x3",
         "EventName": "UNC_Q_RxL_FLITS_G2.NCB_DATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
@@ -284,7 +284,7 @@
         "EventCode": "0x3",
         "EventName": "UNC_Q_RxL_FLITS_G2.NCB_NONDATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x8",
         "Unit": "QPI LL"
     },
@@ -293,7 +293,7 @@
         "EventCode": "0x3",
         "EventName": "UNC_Q_RxL_FLITS_G2.NCS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x10",
         "Unit": "QPI LL"
     },
@@ -302,7 +302,7 @@
         "EventCode": "0x3",
         "EventName": "UNC_Q_RxL_FLITS_G2.NDR_AD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
@@ -311,7 +311,7 @@
         "EventCode": "0x3",
         "EventName": "UNC_Q_RxL_FLITS_G2.NDR_AK",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
@@ -553,7 +553,7 @@
         "BriefDescription": "Flits Transferred - Group 0; Data Tx Flits",
         "EventName": "UNC_Q_TxL_FLITS_G0.DATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach 'flit' is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four 'fits', each of wh=
ich contains 20 bits of data (along with some additional ECC data).   In ha=
lf-width (L0p) mode, the fits are only 10 bits, and therefore it takes twic=
e as many fits to transmit a flit.  When one talks about QPI 'speed' (for e=
xample, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0,=
 the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One=
 can calculate the bandwidth of the link by taking: flits*80b/time.  Note t=
hat this is not the same as 'data' bandwidth.  For example, when we are tra=
nsfering a 64B cacheline across QPI, we will break it into 9 flits -- 1 wit=
h header information and 8 with 64 bits of actual 'data' and an additional =
16 bits of other information.  To calculate 'data' bandwidth, one should th=
erefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach 'flit' is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four 'fits', each of wh=
ich contains 20 bits of data (along with some additional ECC data).   In ha=
lf-width (L0p) mode, the fits are only 10 bits, and therefore it takes twic=
e as many fits to transmit a flit.  When one talks about QPI 'speed' (for e=
xample, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0,=
 the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One=
 can calculate the bandwidth of the link by taking: flits*80b/time.  Note t=
hat this is not the same as 'data' bandwidth.  For example, when we are tra=
nsferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 wi=
th header information and 8 with 64 bits of actual 'data' and an additional=
 16 bits of other information.  To calculate 'data' bandwidth, one should t=
herefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
@@ -561,7 +561,7 @@
         "BriefDescription": "Flits Transferred - Group 0; Idle and Null Fl=
its",
         "EventName": "UNC_Q_TxL_FLITS_G0.IDLE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach 'flit' is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four 'fits', each of wh=
ich contains 20 bits of data (along with some additional ECC data).   In ha=
lf-width (L0p) mode, the fits are only 10 bits, and therefore it takes twic=
e as many fits to transmit a flit.  When one talks about QPI 'speed' (for e=
xample, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0,=
 the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One=
 can calculate the bandwidth of the link by taking: flits*80b/time.  Note t=
hat this is not the same as 'data' bandwidth.  For example, when we are tra=
nsfering a 64B cacheline across QPI, we will break it into 9 flits -- 1 wit=
h header information and 8 with 64 bits of actual 'data' and an additional =
16 bits of other information.  To calculate 'data' bandwidth, one should th=
erefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach 'flit' is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four 'fits', each of wh=
ich contains 20 bits of data (along with some additional ECC data).   In ha=
lf-width (L0p) mode, the fits are only 10 bits, and therefore it takes twic=
e as many fits to transmit a flit.  When one talks about QPI 'speed' (for e=
xample, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0,=
 the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One=
 can calculate the bandwidth of the link by taking: flits*80b/time.  Note t=
hat this is not the same as 'data' bandwidth.  For example, when we are tra=
nsferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 wi=
th header information and 8 with 64 bits of actual 'data' and an additional=
 16 bits of other information.  To calculate 'data' bandwidth, one should t=
herefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
@@ -569,7 +569,7 @@
         "BriefDescription": "Flits Transferred - Group 0; Non-Data protoco=
l Tx Flits",
         "EventName": "UNC_Q_TxL_FLITS_G0.NON_DATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach 'flit' is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four 'fits', each of wh=
ich contains 20 bits of data (along with some additional ECC data).   In ha=
lf-width (L0p) mode, the fits are only 10 bits, and therefore it takes twic=
e as many fits to transmit a flit.  When one talks about QPI 'speed' (for e=
xample, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0,=
 the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One=
 can calculate the bandwidth of the link by taking: flits*80b/time.  Note t=
hat this is not the same as 'data' bandwidth.  For example, when we are tra=
nsfering a 64B cacheline across QPI, we will break it into 9 flits -- 1 wit=
h header information and 8 with 64 bits of actual 'data' and an additional =
16 bits of other information.  To calculate 'data' bandwidth, one should th=
erefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach 'flit' is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four 'fits', each of wh=
ich contains 20 bits of data (along with some additional ECC data).   In ha=
lf-width (L0p) mode, the fits are only 10 bits, and therefore it takes twic=
e as many fits to transmit a flit.  When one talks about QPI 'speed' (for e=
xample, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0,=
 the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One=
 can calculate the bandwidth of the link by taking: flits*80b/time.  Note t=
hat this is not the same as 'data' bandwidth.  For example, when we are tra=
nsferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 wi=
th header information and 8 with 64 bits of actual 'data' and an additional=
 16 bits of other information.  To calculate 'data' bandwidth, one should t=
herefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
@@ -577,7 +577,7 @@
         "BriefDescription": "Flits Transferred - Group 1; DRS Flits (both =
Header and Data)",
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three 'groups' that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' =
is made up of 80 bits of information (in addition to some ECC data).  In fu=
ll-width (L0) mode, flits are made up of four 'fits', each of which contain=
s 20 bits of data (along with some additional ECC data).   In half-width (L=
0p) mode, the fits are only 10 bits, and therefore it takes twice as many f=
its to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0=
 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system=
 will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcul=
ate the bandwidth of the link by taking: flits*80b/time.  Note that this is=
 not the same as 'data' bandwidth.  For example, when we are transferring a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
         "UMask": "0x18",
         "Unit": "QPI LL"
     },
@@ -585,7 +585,7 @@
         "BriefDescription": "Flits Transferred - Group 1; DRS Data Flits",
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS_DATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three 'groups' that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' =
is made up of 80 bits of information (in addition to some ECC data).  In fu=
ll-width (L0) mode, flits are made up of four 'fits', each of which contain=
s 20 bits of data (along with some additional ECC data).   In half-width (L=
0p) mode, the fits are only 10 bits, and therefore it takes twice as many f=
its to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0=
 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system=
 will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcul=
ate the bandwidth of the link by taking: flits*80b/time.  Note that this is=
 not the same as 'data' bandwidth.  For example, when we are transferring a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
         "UMask": "0x8",
         "Unit": "QPI LL"
     },
@@ -593,7 +593,7 @@
         "BriefDescription": "Flits Transferred - Group 1; DRS Header Flits=
",
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS_NONDATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three 'groups' that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' =
is made up of 80 bits of information (in addition to some ECC data).  In fu=
ll-width (L0) mode, flits are made up of four 'fits', each of which contain=
s 20 bits of data (along with some additional ECC data).   In half-width (L=
0p) mode, the fits are only 10 bits, and therefore it takes twice as many f=
its to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0=
 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system=
 will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcul=
ate the bandwidth of the link by taking: flits*80b/time.  Note that this is=
 not the same as 'data' bandwidth.  For example, when we are transferring a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
         "UMask": "0x10",
         "Unit": "QPI LL"
     },
@@ -601,7 +601,7 @@
         "BriefDescription": "Flits Transferred - Group 1; HOM Flits",
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three 'groups' that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' =
is made up of 80 bits of information (in addition to some ECC data).  In fu=
ll-width (L0) mode, flits are made up of four 'fits', each of which contain=
s 20 bits of data (along with some additional ECC data).   In half-width (L=
0p) mode, the fits are only 10 bits, and therefore it takes twice as many f=
its to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0=
 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system=
 will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcul=
ate the bandwidth of the link by taking: flits*80b/time.  Note that this is=
 not the same as 'data' bandwidth.  For example, when we are transferring a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
         "UMask": "0x6",
         "Unit": "QPI LL"
     },
@@ -609,7 +609,7 @@
         "BriefDescription": "Flits Transferred - Group 1; HOM Non-Request =
Flits",
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM_NONREQ",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three 'groups' that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' =
is made up of 80 bits of information (in addition to some ECC data).  In fu=
ll-width (L0) mode, flits are made up of four 'fits', each of which contain=
s 20 bits of data (along with some additional ECC data).   In half-width (L=
0p) mode, the fits are only 10 bits, and therefore it takes twice as many f=
its to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0=
 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system=
 will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcul=
ate the bandwidth of the link by taking: flits*80b/time.  Note that this is=
 not the same as 'data' bandwidth.  For example, when we are transferring a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
@@ -617,7 +617,7 @@
         "BriefDescription": "Flits Transferred - Group 1; HOM Request Flit=
s",
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM_REQ",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three 'groups' that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' =
is made up of 80 bits of information (in addition to some ECC data).  In fu=
ll-width (L0) mode, flits are made up of four 'fits', each of which contain=
s 20 bits of data (along with some additional ECC data).   In half-width (L=
0p) mode, the fits are only 10 bits, and therefore it takes twice as many f=
its to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0=
 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system=
 will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcul=
ate the bandwidth of the link by taking: flits*80b/time.  Note that this is=
 not the same as 'data' bandwidth.  For example, when we are transferring a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
@@ -625,7 +625,7 @@
         "BriefDescription": "Flits Transferred - Group 1; SNP Flits",
         "EventName": "UNC_Q_TxL_FLITS_G1.SNP",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three 'groups' that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' =
is made up of 80 bits of information (in addition to some ECC data).  In fu=
ll-width (L0) mode, flits are made up of four 'fits', each of which contain=
s 20 bits of data (along with some additional ECC data).   In half-width (L=
0p) mode, the fits are only 10 bits, and therefore it takes twice as many f=
its to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0=
 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system=
 will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcul=
ate the bandwidth of the link by taking: flits*80b/time.  Note that this is=
 not the same as 'data' bandwidth.  For example, when we are transferring a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
@@ -634,7 +634,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NCB",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three 'groups' that allow us to track flits=
.  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' =
is made up of 80 bits of information (in addition to some ECC data).  In fu=
ll-width (L0) mode, flits are made up of four 'fits', each of which contain=
s 20 bits of data (along with some additional ECC data).   In half-width (L=
0p) mode, the fits are only 10 bits, and therefore it takes twice as many f=
its to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0=
 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system=
 will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcul=
ate the bandwidth of the link by taking: flits*80b/time.  Note that this is=
 not the same as 'data' bandwidth.  For example, when we are transferring a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
         "UMask": "0xc",
         "Unit": "QPI LL"
     },
@@ -643,7 +643,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NCB_DATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three 'groups' that allow us to track flits=
.  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' =
is made up of 80 bits of information (in addition to some ECC data).  In fu=
ll-width (L0) mode, flits are made up of four 'fits', each of which contain=
s 20 bits of data (along with some additional ECC data).   In half-width (L=
0p) mode, the fits are only 10 bits, and therefore it takes twice as many f=
its to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0=
 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system=
 will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcul=
ate the bandwidth of the link by taking: flits*80b/time.  Note that this is=
 not the same as 'data' bandwidth.  For example, when we are transferring a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
@@ -652,7 +652,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NCB_NONDATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three 'groups' that allow us to track flits=
.  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' =
is made up of 80 bits of information (in addition to some ECC data).  In fu=
ll-width (L0) mode, flits are made up of four 'fits', each of which contain=
s 20 bits of data (along with some additional ECC data).   In half-width (L=
0p) mode, the fits are only 10 bits, and therefore it takes twice as many f=
its to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0=
 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system=
 will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcul=
ate the bandwidth of the link by taking: flits*80b/time.  Note that this is=
 not the same as 'data' bandwidth.  For example, when we are transferring a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
         "UMask": "0x8",
         "Unit": "QPI LL"
     },
@@ -661,7 +661,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NCS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three 'groups' that allow us to track flits=
.  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' =
is made up of 80 bits of information (in addition to some ECC data).  In fu=
ll-width (L0) mode, flits are made up of four 'fits', each of which contain=
s 20 bits of data (along with some additional ECC data).   In half-width (L=
0p) mode, the fits are only 10 bits, and therefore it takes twice as many f=
its to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0=
 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system=
 will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcul=
ate the bandwidth of the link by taking: flits*80b/time.  Note that this is=
 not the same as 'data' bandwidth.  For example, when we are transferring a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
         "UMask": "0x10",
         "Unit": "QPI LL"
     },
@@ -670,7 +670,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NDR_AD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three 'groups' that allow us to track flits=
.  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' =
is made up of 80 bits of information (in addition to some ECC data).  In fu=
ll-width (L0) mode, flits are made up of four 'fits', each of which contain=
s 20 bits of data (along with some additional ECC data).   In half-width (L=
0p) mode, the fits are only 10 bits, and therefore it takes twice as many f=
its to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0=
 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system=
 will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcul=
ate the bandwidth of the link by taking: flits*80b/time.  Note that this is=
 not the same as 'data' bandwidth.  For example, when we are transferring a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
@@ -679,7 +679,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NDR_AK",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three 'groups' that allow us to track flits=
.  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' =
is made up of 80 bits of information (in addition to some ECC data).  In fu=
ll-width (L0) mode, flits are made up of four 'fits', each of which contain=
s 20 bits of data (along with some additional ECC data).   In half-width (L=
0p) mode, the fits are only 10 bits, and therefore it takes twice as many f=
its to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0=
 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system=
 will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcul=
ate the bandwidth of the link by taking: flits*80b/time.  Note that this is=
 not the same as 'data' bandwidth.  For example, when we are transferring a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-memory.json b/t=
ools/perf/pmu-events/arch/x86/jaketown/uncore-memory.json
index 2faf0dc6675d..6dcc9415a462 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-memory.json
@@ -101,7 +101,7 @@
         "EventCode": "0x9",
         "EventName": "UNC_M_ECC_CORRECTABLE_ERRORS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of ECC errors detected and=
 corrected by the iMC on this channel.  This counter is only useful with EC=
C DRAM devices.  This count will increment one time for each correction reg=
ardless of the number of bits corrected.  The iMC can correct up to 4 bit e=
rrors in independent channel mode and 8 bit erros in lockstep mode.",
+        "PublicDescription": "Counts the number of ECC errors detected and=
 corrected by the iMC on this channel.  This counter is only useful with EC=
C DRAM devices.  This count will increment one time for each correction reg=
ardless of the number of bits corrected.  The iMC can correct up to 4 bit e=
rrors in independent channel mode and 8 bit errors in lockstep mode.",
         "Unit": "iMC"
     },
     {
@@ -413,7 +413,7 @@
         "EventCode": "0x81",
         "EventName": "UNC_M_WPQ_OCCUPANCY",
         "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancies of the Write Pen=
ding Queue each cycle.  This can then be used to calculate both the average=
 queue occupancy (in conjunction with the number of cycles not empty) and t=
he average latency (in conjunction with the number of allocations).  The WP=
Q is used to schedule write out to the memory controller and to track the w=
rites.  Requests allocate into the WPQ soon after they enter the memory con=
troller, and need credits for an entry in this buffer before being sent fro=
m the HA to the iMC.  They deallocate after being issued to DRAM.  Write re=
quests themselves are able to complete (from the perspective of the rest of=
 the system) as soon they have 'posted' to the iMC.  This is not to be conf=
used with actually performing the write to DRAM.  Therefore, the average la=
tency for this queue is actually not useful for deconstruction intermediate=
 write latencies.  So, we provide filtering based on if the request has pos=
ted or not.  By using the 'not posted' filter, we can track how long writes=
 spent in the iMC before completions were sent to the HA.  The 'posted' fil=
ter, on the other hand, provides information about how much queueing is act=
ually happenning in the iMC for writes before they are actually issued to m=
emory.  High average occupancies will generally coincide with high write ma=
jor mode counts.",
+        "PublicDescription": "Accumulates the occupancies of the Write Pen=
ding Queue each cycle.  This can then be used to calculate both the average=
 queue occupancy (in conjunction with the number of cycles not empty) and t=
he average latency (in conjunction with the number of allocations).  The WP=
Q is used to schedule write out to the memory controller and to track the w=
rites.  Requests allocate into the WPQ soon after they enter the memory con=
troller, and need credits for an entry in this buffer before being sent fro=
m the HA to the iMC.  They deallocate after being issued to DRAM.  Write re=
quests themselves are able to complete (from the perspective of the rest of=
 the system) as soon they have 'posted' to the iMC.  This is not to be conf=
used with actually performing the write to DRAM.  Therefore, the average la=
tency for this queue is actually not useful for deconstruction intermediate=
 write latencies.  So, we provide filtering based on if the request has pos=
ted or not.  By using the 'not posted' filter, we can track how long writes=
 spent in the iMC before completions were sent to the HA.  The 'posted' fil=
ter, on the other hand, provides information about how much queueing is act=
ually happening in the iMC for writes before they are actually issued to me=
mory.  High average occupancies will generally coincide with high write maj=
or mode counts.",
         "Unit": "iMC"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-other.json b/to=
ols/perf/pmu-events/arch/x86/jaketown/uncore-other.json
index 51a9a4e81046..ca727c0e1865 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-other.json
@@ -284,7 +284,7 @@
         "EventCode": "0xD",
         "EventName": "UNC_I_TxR_REQUEST_OCCUPANCY",
         "PerPkg": "1",
-        "PublicDescription": "Accumultes the number of outstanding outboun=
d requests from the IRP to the switch (towards the devices).  This can be u=
sed in conjuection with the allocations event in order to calculate average=
 latency of outbound requests.",
+        "PublicDescription": "Accumulates the number of outstanding outbou=
nd requests from the IRP to the switch (towards the devices).  This can be =
used in conjunction with the allocations event in order to calculate averag=
e latency of outbound requests.",
         "Unit": "IRP"
     },
     {
@@ -630,7 +630,7 @@
         "EventCode": "0x20",
         "EventName": "UNC_R3_IIO_CREDITS_ACQUIRED.DRS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times the NCS/NCB/DRS c=
redit is acquried in the QPI for sending messages on BL to the IIO.  There =
is one credit for each of these three message classes (three credits total)=
.  NCS is used for reads to PCIe space, NCB is used for transfering data wi=
thout coherency, and DRS is used for transfering data with coherency (cacha=
ble PCI transactions).  This event can only track one message class at a ti=
me.",
+        "PublicDescription": "Counts the number of times the NCS/NCB/DRS c=
redit is acquired in the QPI for sending messages on BL to the IIO.  There =
is one credit for each of these three message classes (three credits total)=
.  NCS is used for reads to PCIe space, NCB is used for transferring data w=
ithout coherency, and DRS is used for transferring data with coherency (cac=
heable PCI transactions).  This event can only track one message class at a=
 time.",
         "UMask": "0x8",
         "Unit": "R3QPI"
     },
@@ -639,7 +639,7 @@
         "EventCode": "0x20",
         "EventName": "UNC_R3_IIO_CREDITS_ACQUIRED.NCB",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times the NCS/NCB/DRS c=
redit is acquried in the QPI for sending messages on BL to the IIO.  There =
is one credit for each of these three message classes (three credits total)=
.  NCS is used for reads to PCIe space, NCB is used for transfering data wi=
thout coherency, and DRS is used for transfering data with coherency (cacha=
ble PCI transactions).  This event can only track one message class at a ti=
me.",
+        "PublicDescription": "Counts the number of times the NCS/NCB/DRS c=
redit is acquired in the QPI for sending messages on BL to the IIO.  There =
is one credit for each of these three message classes (three credits total)=
.  NCS is used for reads to PCIe space, NCB is used for transferring data w=
ithout coherency, and DRS is used for transferring data with coherency (cac=
heable PCI transactions).  This event can only track one message class at a=
 time.",
         "UMask": "0x10",
         "Unit": "R3QPI"
     },
@@ -648,7 +648,7 @@
         "EventCode": "0x20",
         "EventName": "UNC_R3_IIO_CREDITS_ACQUIRED.NCS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times the NCS/NCB/DRS c=
redit is acquried in the QPI for sending messages on BL to the IIO.  There =
is one credit for each of these three message classes (three credits total)=
.  NCS is used for reads to PCIe space, NCB is used for transfering data wi=
thout coherency, and DRS is used for transfering data with coherency (cacha=
ble PCI transactions).  This event can only track one message class at a ti=
me.",
+        "PublicDescription": "Counts the number of times the NCS/NCB/DRS c=
redit is acquired in the QPI for sending messages on BL to the IIO.  There =
is one credit for each of these three message classes (three credits total)=
.  NCS is used for reads to PCIe space, NCB is used for transferring data w=
ithout coherency, and DRS is used for transferring data with coherency (cac=
heable PCI transactions).  This event can only track one message class at a=
 time.",
         "UMask": "0x20",
         "Unit": "R3QPI"
     },
@@ -657,7 +657,7 @@
         "EventCode": "0x21",
         "EventName": "UNC_R3_IIO_CREDITS_REJECT.DRS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that a request at=
tempted to acquire an NCS/NCB/DRS credit in the QPI for sending messages on=
 BL to the IIO but was rejected because no credit was available.  There is =
one credit for each of these three message classes (three credits total).  =
NCS is used for reads to PCIe space, NCB is used for transfering data witho=
ut coherency, and DRS is used for transfering data with coherency (cachable=
 PCI transactions).  This event can only track one message class at a time.=
",
+        "PublicDescription": "Counts the number of times that a request at=
tempted to acquire an NCS/NCB/DRS credit in the QPI for sending messages on=
 BL to the IIO but was rejected because no credit was available.  There is =
one credit for each of these three message classes (three credits total).  =
NCS is used for reads to PCIe space, NCB is used for transferring data with=
out coherency, and DRS is used for transferring data with coherency (cachea=
ble PCI transactions).  This event can only track one message class at a ti=
me.",
         "UMask": "0x8",
         "Unit": "R3QPI"
     },
@@ -666,7 +666,7 @@
         "EventCode": "0x21",
         "EventName": "UNC_R3_IIO_CREDITS_REJECT.NCB",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that a request at=
tempted to acquire an NCS/NCB/DRS credit in the QPI for sending messages on=
 BL to the IIO but was rejected because no credit was available.  There is =
one credit for each of these three message classes (three credits total).  =
NCS is used for reads to PCIe space, NCB is used for transfering data witho=
ut coherency, and DRS is used for transfering data with coherency (cachable=
 PCI transactions).  This event can only track one message class at a time.=
",
+        "PublicDescription": "Counts the number of times that a request at=
tempted to acquire an NCS/NCB/DRS credit in the QPI for sending messages on=
 BL to the IIO but was rejected because no credit was available.  There is =
one credit for each of these three message classes (three credits total).  =
NCS is used for reads to PCIe space, NCB is used for transferring data with=
out coherency, and DRS is used for transferring data with coherency (cachea=
ble PCI transactions).  This event can only track one message class at a ti=
me.",
         "UMask": "0x10",
         "Unit": "R3QPI"
     },
@@ -675,7 +675,7 @@
         "EventCode": "0x21",
         "EventName": "UNC_R3_IIO_CREDITS_REJECT.NCS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that a request at=
tempted to acquire an NCS/NCB/DRS credit in the QPI for sending messages on=
 BL to the IIO but was rejected because no credit was available.  There is =
one credit for each of these three message classes (three credits total).  =
NCS is used for reads to PCIe space, NCB is used for transfering data witho=
ut coherency, and DRS is used for transfering data with coherency (cachable=
 PCI transactions).  This event can only track one message class at a time.=
",
+        "PublicDescription": "Counts the number of times that a request at=
tempted to acquire an NCS/NCB/DRS credit in the QPI for sending messages on=
 BL to the IIO but was rejected because no credit was available.  There is =
one credit for each of these three message classes (three credits total).  =
NCS is used for reads to PCIe space, NCB is used for transferring data with=
out coherency, and DRS is used for transferring data with coherency (cachea=
ble PCI transactions).  This event can only track one message class at a ti=
me.",
         "UMask": "0x20",
         "Unit": "R3QPI"
     },
@@ -684,7 +684,7 @@
         "EventCode": "0x22",
         "EventName": "UNC_R3_IIO_CREDITS_USED.DRS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the NCS/NCB=
/DRS credit is in use in the QPI for sending messages on BL to the IIO.  Th=
ere is one credit for each of these three message classes (three credits to=
tal).  NCS is used for reads to PCIe space, NCB is used for transfering dat=
a without coherency, and DRS is used for transfering data with coherency (c=
achable PCI transactions).  This event can only track one message class at =
a time.",
+        "PublicDescription": "Counts the number of cycles when the NCS/NCB=
/DRS credit is in use in the QPI for sending messages on BL to the IIO.  Th=
ere is one credit for each of these three message classes (three credits to=
tal).  NCS is used for reads to PCIe space, NCB is used for transferring da=
ta without coherency, and DRS is used for transferring data with coherency =
(cacheable PCI transactions).  This event can only track one message class =
at a time.",
         "UMask": "0x8",
         "Unit": "R3QPI"
     },
@@ -693,7 +693,7 @@
         "EventCode": "0x22",
         "EventName": "UNC_R3_IIO_CREDITS_USED.NCB",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the NCS/NCB=
/DRS credit is in use in the QPI for sending messages on BL to the IIO.  Th=
ere is one credit for each of these three message classes (three credits to=
tal).  NCS is used for reads to PCIe space, NCB is used for transfering dat=
a without coherency, and DRS is used for transfering data with coherency (c=
achable PCI transactions).  This event can only track one message class at =
a time.",
+        "PublicDescription": "Counts the number of cycles when the NCS/NCB=
/DRS credit is in use in the QPI for sending messages on BL to the IIO.  Th=
ere is one credit for each of these three message classes (three credits to=
tal).  NCS is used for reads to PCIe space, NCB is used for transferring da=
ta without coherency, and DRS is used for transferring data with coherency =
(cacheable PCI transactions).  This event can only track one message class =
at a time.",
         "UMask": "0x10",
         "Unit": "R3QPI"
     },
@@ -702,7 +702,7 @@
         "EventCode": "0x22",
         "EventName": "UNC_R3_IIO_CREDITS_USED.NCS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the NCS/NCB=
/DRS credit is in use in the QPI for sending messages on BL to the IIO.  Th=
ere is one credit for each of these three message classes (three credits to=
tal).  NCS is used for reads to PCIe space, NCB is used for transfering dat=
a without coherency, and DRS is used for transfering data with coherency (c=
achable PCI transactions).  This event can only track one message class at =
a time.",
+        "PublicDescription": "Counts the number of cycles when the NCS/NCB=
/DRS credit is in use in the QPI for sending messages on BL to the IIO.  Th=
ere is one credit for each of these three message classes (three credits to=
tal).  NCS is used for reads to PCIe space, NCB is used for transferring da=
ta without coherency, and DRS is used for transferring data with coherency =
(cacheable PCI transactions).  This event can only track one message class =
at a time.",
         "UMask": "0x20",
         "Unit": "R3QPI"
     },
@@ -1107,7 +1107,7 @@
         "EventCode": "0x33",
         "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED",
         "PerPkg": "1",
-        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credts from the VN0 pool.  N=
ote that a single packet may require multiple flit buffers (i.e. when data =
is being transfered).  Therefore, this event will increment by the number o=
f credits acquired in each cycle.  Filtering based on message class is not =
provided.  One can count the number of packets transfered in a given messag=
e class using an qfclk event.",
+        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credits from the VN0 pool.  =
Note that a single packet may require multiple flit buffers (i.e. when data=
 is being transferred).  Therefore, this event will increment by the number=
 of credits acquired in each cycle.  Filtering based on message class is no=
t provided.  One can count the number of packets transferred in a given mes=
sage class using an qfclk event.",
         "Unit": "R3QPI"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json b/to=
ols/perf/pmu-events/arch/x86/jaketown/uncore-power.json
index 638aa8a35cdb..b3ee5d741015 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
@@ -234,7 +234,7 @@
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
         "PerPkg": "1",
-        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in C0.  It can be used by itself to get the average=
 number of cores in C0, with threshholding to generate histograms, or with =
other PCU events and occupancy triggering to capture other details.",
+        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in C0.  It can be used by itself to get the average=
 number of cores in C0, with thresholding to generate histograms, or with o=
ther PCU events and occupancy triggering to capture other details.",
         "Unit": "PCU"
     },
     {
@@ -242,7 +242,7 @@
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
         "PerPkg": "1",
-        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in C0.  It can be used by itself to get the average=
 number of cores in C0, with threshholding to generate histograms, or with =
other PCU events and occupancy triggering to capture other details.",
+        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in C0.  It can be used by itself to get the average=
 number of cores in C0, with thresholding to generate histograms, or with o=
ther PCU events and occupancy triggering to capture other details.",
         "Unit": "PCU"
     },
     {
@@ -250,7 +250,7 @@
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
         "PerPkg": "1",
-        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in C0.  It can be used by itself to get the average=
 number of cores in C0, with threshholding to generate histograms, or with =
other PCU events and occupancy triggering to capture other details.",
+        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in C0.  It can be used by itself to get the average=
 number of cores in C0, with thresholding to generate histograms, or with o=
ther PCU events and occupancy triggering to capture other details.",
         "Unit": "PCU"
     },
     {
@@ -266,7 +266,7 @@
         "EventCode": "0x9",
         "EventName": "UNC_P_PROCHOT_INTERNAL_CYCLES",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that we are in I=
nteral PROCHOT mode.  This mode is triggered when a sensor on the die deter=
mines that we are too hot and must throttle to avoid damaging the chip.",
+        "PublicDescription": "Counts the number of cycles that we are in I=
nternal PROCHOT mode.  This mode is triggered when a sensor on the die dete=
rmines that we are too hot and must throttle to avoid damaging the chip.",
         "Unit": "PCU"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 77af9d0bf6d4..afe811f154d7 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -16,7 +16,7 @@ GenuineIntel-6-(7D|7E|A7),v1.17,icelake,core
 GenuineIntel-6-6[AC],v1.18,icelakex,core
 GenuineIntel-6-3A,v23,ivybridge,core
 GenuineIntel-6-3E,v22,ivytown,core
-GenuineIntel-6-2D,v21,jaketown,core
+GenuineIntel-6-2D,v22,jaketown,core
 GenuineIntel-6-(57|85),v9,knightslanding,core
 GenuineIntel-6-A[AC],v1.00,meteorlake,core
 GenuineIntel-6-1[AEF],v3,nehalemep,core
--=20
2.39.2.637.g21b0678d19-goog

