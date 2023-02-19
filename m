Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF2B69BF81
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjBSJbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjBSJbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:31:37 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A58E045
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:31:01 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536885323c1so17956327b3.15
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wvJNBFtzajYi6R5dh+10ijP9wjGKOWLD2Nx4Wagg34=;
        b=MNL4A804Y0heXhzUZa1nxN9jJb6sRSQYDdChK5TO5YcqocaZ/yqDRWcFwHakubBHpk
         EJXZocwa+6YL7sHN+770EZcqWqK8WMtRGtRIad7FkZAVC4cCv+jUyLVKOVX6epfRAsGw
         iN3mkmaNKhzbKWowpag06diTUdqz4KU6KSG5t/zzqqlLja4dHHfKd5E8d0f08FWUNffL
         WxJt5miz+eK0GYkKiZYmsGlsrzW1iQx7AA0VJaJ6fYe9BuWmPTmN2Dkv9kSXhxovV7jT
         88jYo9vocbRsH3D51oI06ILSi0v423B2/wZOzGR5CxnLHkxziAQSTa5Ilh3+KdcOM3xj
         doCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2wvJNBFtzajYi6R5dh+10ijP9wjGKOWLD2Nx4Wagg34=;
        b=lQIfaLM2afajTYGTa+TgSFSHd4Q0cbRNihEIv9H2LMF5IqUawjOLsEtwnAXBDBG4iW
         dIj2B4L8HhOkEmZK4B+QXV2pNZEwhfsNwWa7t2hbKh1iT0CDi+HHZdlwrwsD1kh8oCBl
         iEb2L7+goyPW8t0PpGkH0loRw/+BC1auOtty1neNVpHuLK4720KNMFP/MNucvEj3DBGu
         yuDM6jDd70SpanUhwoRu8RADd66fHZ71nWvCGBv3hCty6KzwXTHyONwpDSsnklpDNoEL
         vrZj+zxarsQ4+d7SWsJNhmy8kc865ZlqBjx0Eafgv13CVg7DgFj6k1dYhv8Frf2b7I/0
         nJZg==
X-Gm-Message-State: AO0yUKVBuUr4QgBuI62yhvNnKqXKojSXUjHoJ5kEEMPeWbbZrqkgqBwR
        hHkNF07M6wKD6rglCwHVrgfaFxHCAyaB
X-Google-Smtp-Source: AK7set/0eZVEU+IOHxiF1yMx+mQdtJvaFm7oEgIT8s4LvNe/Qy4ocif/Q8nBpVLPzGl8ieDP2X7+blHWKDlv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a05:6902:154b:b0:8e3:6aea:973 with SMTP id
 r11-20020a056902154b00b008e36aea0973mr399044ybu.4.1676799059917; Sun, 19 Feb
 2023 01:30:59 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:11 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-15-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 14/51] perf vendor events intel: Refresh broadwellx metrics
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

Update the broadwellx metrics to TMA version 4.5. Generation was done
using https://github.com/intel/perfmon.

Notable changes are TMA info metrics are renamed from their node name
to be lower case and prefixed by tma_info_, MetricThreshold
expressions are added, "Sample with" documentation is added to many
TMA metrics, and the smi_cost metric group is added replicating
existing hard coded metrics in stat-shadow.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/broadwellx/bdx-metrics.json      | 1626 ++++++++---------
 .../arch/x86/broadwellx/uncore-cache.json     |   74 +-
 .../x86/broadwellx/uncore-interconnect.json   |   64 +-
 .../arch/x86/broadwellx/uncore-other.json     |    4 +-
 4 files changed, 873 insertions(+), 895 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json b/t=
ools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
index f5c8f707c692..65ec0c9e55d1 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
@@ -1,1189 +1,1167 @@
 [
     {
-        "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
-        "MetricExpr": "INST_RETIRED.ANY / CLKS",
-        "MetricGroup": "Ret;Summary",
-        "MetricName": "IPC"
-    },
-    {
-        "BriefDescription": "Uops Per Instruction",
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
-        "MetricGroup": "Pipeline;Ret;Retire",
-        "MetricName": "UPI"
-    },
-    {
-        "BriefDescription": "Instruction per taken branch",
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / BR_INST_RETIRED.NEAR_TA=
KEN",
-        "MetricGroup": "Branches;Fed;FetchBW",
-        "MetricName": "UpTB"
-    },
-    {
-        "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
-        "MetricExpr": "1 / IPC",
-        "MetricGroup": "Mem;Pipeline",
-        "MetricName": "CPI"
-    },
-    {
-        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "Pipeline",
-        "MetricName": "CLKS"
-    },
-    {
-        "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
-        "MetricExpr": "4 * CORE_CLKS",
-        "MetricGroup": "tma_L1_group",
-        "MetricName": "SLOTS"
-    },
-    {
-        "BriefDescription": "The ratio of Executed- by Issued-Uops",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / UOPS_ISSUED.ANY",
-        "MetricGroup": "Cor;Pipeline",
-        "MetricName": "Execute_per_Issue",
-        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage."
-    },
-    {
-        "BriefDescription": "Instructions Per Cycle across hyper-threads (=
per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / CORE_CLKS",
-        "MetricGroup": "Ret;SMT;tma_L1_group",
-        "MetricName": "CoreIPC"
-    },
-    {
-        "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 =
* (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PA=
CKED_DOUBLE) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) / CORE_CLKS",
-        "MetricGroup": "Flops;Ret",
-        "MetricName": "FLOPc"
+        "BriefDescription": "C2 residency percent per package",
+        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C2_Pkg_Residency",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE + (FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_AR=
ITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOU=
BLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE)) / (2 * CORE_CLKS)",
-        "MetricGroup": "Cor;Flops;HPC",
-        "MetricName": "FP_Arith_Utilization",
-        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)."
+        "BriefDescription": "C3 residency percent per core",
+        "MetricExpr": "cstate_core@c3\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C3_Core_Residency",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (cpu@UOPS_EXECUTED.CORE\\,cm=
ask\\=3D1@ / 2 if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
-        "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
-        "MetricName": "ILP"
+        "BriefDescription": "C3 residency percent per package",
+        "MetricExpr": "cstate_pkg@c3\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C3_Pkg_Residency",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
-        "MetricExpr": "(CPU_CLK_UNHALTED.THREAD / 2 * (1 + CPU_CLK_UNHALTE=
D.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK) if #core_wide < 1 else (CP=
U_CLK_UNHALTED.THREAD_ANY / 2 if #SMT_on else CLKS))",
-        "MetricGroup": "SMT",
-        "MetricName": "CORE_CLKS"
+        "BriefDescription": "C6 residency percent per core",
+        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C6_Core_Residency",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Instructions per Load (lower number means hig=
her occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_LOADS",
-        "MetricGroup": "InsType",
-        "MetricName": "IpLoad"
+        "BriefDescription": "C6 residency percent per package",
+        "MetricExpr": "cstate_pkg@c6\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C6_Pkg_Residency",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Instructions per Store (lower number means hi=
gher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_STORES",
-        "MetricGroup": "InsType",
-        "MetricName": "IpStore"
+        "BriefDescription": "C7 residency percent per core",
+        "MetricExpr": "cstate_core@c7\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C7_Core_Residency",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Branches;Fed;InsType",
-        "MetricName": "IpBranch"
+        "BriefDescription": "C7 residency percent per package",
+        "MetricExpr": "cstate_pkg@c7\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C7_Pkg_Residency",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Instructions per (near) call (lower number me=
ans higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
-        "MetricGroup": "Branches;Fed;PGO",
-        "MetricName": "IpCall"
+        "BriefDescription": "Uncore frequency per die [GHZ]",
+        "MetricExpr": "tma_info_socket_clks / #num_dies / duration_time / =
1e9",
+        "MetricGroup": "SoC",
+        "MetricName": "UNCORE_FREQ"
     },
     {
-        "BriefDescription": "Instruction per taken branch",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
-        "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO",
-        "MetricName": "IpTB"
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
-        "BriefDescription": "Branch instructions per taken branch. ",
-        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
-        "MetricGroup": "Branches;Fed;PGO",
-        "MetricName": "BpTkBranch"
+        "BriefDescription": "Number of SMI interrupts.",
+        "MetricExpr": "msr@smi@",
+        "MetricGroup": "smi",
+        "MetricName": "smi_num",
+        "ScaleUnit": "1SMI#"
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
-        "MetricName": "IpFLOP"
+        "BriefDescription": "This metric estimates how often memory load a=
ccesses were aliased by preceding stores (in program order) with a 4K addre=
ss offset",
+        "MetricExpr": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS / tma_info_clks",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
+        "MetricName": "tma_4k_aliasing",
+        "MetricThreshold": "tma_4k_aliasing > 0.2 & (tma_l1_bound > 0.1 & =
(tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric estimates how often memory load =
accesses were aliased by preceding stores (in program order) with a 4K addr=
ess offset. False match is possible; which incur a few cycles load re-issue=
. However; the short re-issue duration is often hidden by the out-of-order =
core and HW optimizations; hence a user may safely ignore a high value of t=
his metric unless it manages to propagate up into parent nodes of the hiera=
rchy (e.g. to L1_Bound).",
+        "ScaleUnit": "100%"
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
e counting. Approximated prior to BDW."
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
+        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_0 + UOPS_DISPATCHED_PORT=
.PORT_1 + UOPS_DISPATCHED_PORT.PORT_5 + UOPS_DISPATCHED_PORT.PORT_6) / tma_=
info_slots",
+        "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
+        "MetricName": "tma_alu_op_utilization",
+        "MetricThreshold": "tma_alu_op_utilization > 0.6",
+        "ScaleUnit": "100%"
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
ercount due to FMA double counting."
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops delivered by the Microcode_Sequencer as a result of Assists=
",
+        "MetricExpr": "100 * OTHER_ASSISTS.ANY_WB_ASSIST / tma_info_slots"=
,
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
rmance and they can be avoided in many cases. Sample with: OTHER_ASSISTS.AN=
Y",
+        "ScaleUnit": "100%"
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
ercount due to FMA double counting."
+        "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
+        "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma=
_retiring)",
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
d and Core Bound.",
+        "ScaleUnit": "100%"
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
due to FMA double counting."
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
+        "ScaleUnit": "100%"
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
 to FMA double counting."
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
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Total number of retired Instructions Sample w=
ith: INST_RETIRED.PREC_DIST",
-        "MetricExpr": "INST_RETIRED.ANY",
-        "MetricGroup": "Summary;tma_L1_group",
-        "MetricName": "Instructions"
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
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / cpu@UOPS_RETIRED.RETIRE=
_SLOTS\\,cmask\\=3D1@",
-        "MetricGroup": "Pipeline;Ret",
-        "MetricName": "Retire"
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU retired uops originated from CISC (complex instruction set computer) in=
struction",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
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
ot imply sub-optimal use of machine resources.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D1@",
-        "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
-        "MetricName": "Execute"
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Machine Clears",
+        "MetricExpr": "MACHINE_CLEARS.COUNT * tma_branch_resteers / (BR_MI=
SP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + BACLEARS.ANY)",
+        "MetricGroup": "BadSpec;MachineClears;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group;tma_issueMC",
+        "MetricName": "tma_clears_resteers",
+        "MetricThreshold": "tma_clears_resteers > 0.05 & (tma_branch_reste=
ers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Machine Clears. Rel=
ated metrics: tma_l1_bound, tma_machine_clears, tma_microcode_sequencer, tm=
a_ms_switches",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
-        "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_=
UOPS + IDQ.MS_UOPS)",
-        "MetricGroup": "DSB;Fed;FetchBW",
-        "MetricName": "DSB_Coverage"
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(60 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HITM * (1 =
+ MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_=
UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS=
_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_LO=
AD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_D=
RAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS_RET=
IRED.REMOTE_FWD))) + 43 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS * (1 + ME=
M_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UOPS=
_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_L3_=
HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_LOAD_U=
OPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_DRAM =
+ MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS_RETIRED=
.REMOTE_FWD)))) / tma_info_clks",
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
M_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS. Re=
lated metrics: tma_data_sharing, tma_false_sharing, tma_machine_clears, tma=
_remote_cache",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;BadSpec;BrMispredicts",
-        "MetricName": "IpMispredict"
+        "BriefDescription": "This metric represents fraction of slots wher=
e Core non-memory issues were of a bottleneck",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "tma_backend_bound - tma_memory_bound",
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
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
-        "MetricExpr": "(tma_branch_mispredicts + tma_fetch_latency * tma_m=
ispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icache_=
misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) * SLOTS / BR_MISP_RE=
TIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;BrMispredicts",
-        "MetricName": "Branch_Misprediction_Cost"
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "43 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT * (1 + =
MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UO=
PS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_L=
3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_LOAD=
_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_DRA=
M + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS_RETIR=
ED.REMOTE_FWD))) / tma_info_clks",
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
AD_L3_HIT_RETIRED.XSNP_HIT_PS. Related metrics: tma_contested_accesses, tma=
_false_sharing, tma_machine_clears, tma_remote_cache",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / (MEM_LOAD_UOPS_RETIRED.L1_M=
ISS + MEM_LOAD_UOPS_RETIRED.HIT_LFB)",
-        "MetricGroup": "Mem;MemoryBound;MemoryLat",
-        "MetricName": "Load_Miss_Real_Latency"
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the Divider unit was active",
+        "MetricExpr": "ARITH.FPU_DIV_ACTIVE / tma_info_core_clks",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_core_bound_group",
+        "MetricName": "tma_divider",
+        "MetricThreshold": "tma_divider > 0.2 & (tma_core_bound > 0.1 & tm=
a_backend_bound > 0.2)",
+        "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIVIDER_UOPS",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss. Per-Logical Proces=
sor)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLE=
S",
-        "MetricGroup": "Mem;MemoryBW;MemoryBound",
-        "MetricName": "MLP"
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
+        "MetricConstraint": "NO_GROUP_EVENTS_SMT",
+        "MetricExpr": "(1 - MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD_UOPS_=
RETIRED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS)) * CYCLE_ACTIVITY.STALL=
S_L2_MISS / tma_info_clks",
+        "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
+        "MetricName": "tma_dram_bound",
+        "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_UOPS_RE=
TIRED.L3_MISS_PS",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1e3 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED.=
ANY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "L1MPKI"
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to DSB (decoded uop cache) fetch pipe=
line",
+        "MetricExpr": "(IDQ.ALL_DSB_CYCLES_ANY_UOPS - IDQ.ALL_DSB_CYCLES_4=
_UOPS) / tma_info_core_clks / 2",
+        "MetricGroup": "DSB;FetchBW;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
+        "MetricName": "tma_dsb",
+        "MetricThreshold": "tma_dsb > 0.15 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_ipc / 4 > 0.35)",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1e3 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.=
ANY",
-        "MetricGroup": "Backend;CacheMisses;Mem",
-        "MetricName": "L2MPKI"
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
idth, tma_info_dsb_coverage, tma_info_iptb, tma_lcp",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all request types (including speculative)",
-        "MetricExpr": "1e3 * L2_RQSTS.MISS / INST_RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem;Offcore",
-        "MetricName": "L2MPKI_All"
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
+        "MetricExpr": "(8 * DTLB_LOAD_MISSES.STLB_HIT + cpu@DTLB_LOAD_MISS=
ES.WALK_DURATION\\,cmask\\=3D1@ + 7 * DTLB_LOAD_MISSES.WALK_COMPLETED) / tm=
a_info_clks",
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
 miss. Sample with: MEM_UOPS_RETIRED.STLB_MISS_LOADS_PS. Related metrics: t=
ma_dtlb_store",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all demand loads  (including speculative)",
-        "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_MISS / INST_RETIRED.A=
NY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "L2MPKI_Load"
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
+        "MetricExpr": "(8 * DTLB_STORE_MISSES.STLB_HIT + cpu@DTLB_STORE_MI=
SSES.WALK_DURATION\\,cmask\\=3D1@ + 7 * DTLB_STORE_MISSES.WALK_COMPLETED) /=
 tma_info_clks",
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
ith: MEM_UOPS_RETIRED.STLB_MISS_STORES_PS. Related metrics: tma_dtlb_load",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "L2 cache hits per kilo instruction for all re=
quest types (including speculative)",
-        "MetricExpr": "1e3 * (L2_RQSTS.REFERENCES - L2_RQSTS.MISS) / INST_=
RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "L2HPKI_All"
+        "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
+        "MetricExpr": "(200 * OFFCORE_RESPONSE.DEMAND_RFO.LLC_MISS.REMOTE_=
HITM + 60 * OFFCORE_RESPONSE.DEMAND_RFO.LLC_HIT.HITM_OTHER_CORE) / tma_info=
_clks",
+        "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_store_bound_group",
+        "MetricName": "tma_false_sharing",
+        "MetricThreshold": "tma_false_sharing > 0.05 & (tma_store_bound > =
0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line. Sample with: MEM_LOAD_L3_HIT_=
RETIRED.XSNP_HITM_PS;OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_HITM. Related=
 metrics: tma_contested_accesses, tma_data_sharing, tma_machine_clears, tma=
_remote_cache",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "L2 cache hits per kilo instruction for all de=
mand loads  (including speculative)",
-        "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_HIT / INST_RETIRED.AN=
Y",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "L2HPKI_Load"
+        "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "tma_info_load_miss_real_latency * cpu@L1D_PEND_MISS=
.FB_FULL\\,cmask\\=3D1@ / tma_info_clks",
+        "MetricGroup": "MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;tma_is=
sueSL;tma_issueSmSt;tma_l1_bound_group",
+        "MetricName": "tma_fb_full",
+        "MetricThreshold": "tma_fb_full > 0.3",
+        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_info_dram_bw_use, tma_mem_bandwidth=
, tma_sq_full, tma_store_latency, tma_streaming_stores",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1e3 * MEM_LOAD_UOPS_RETIRED.L3_MISS / INST_RETIRED.=
ANY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "L3MPKI"
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
ated metrics: tma_dsb_switches, tma_info_dsb_coverage, tma_info_iptb, tma_l=
cp",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
-        "MetricConstraint": "NO_NMI_WATCHDOG",
-        "MetricExpr": "(ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_=
DURATION + DTLB_STORE_MISSES.WALK_DURATION + 7 * (DTLB_STORE_MISSES.WALK_CO=
MPLETED + DTLB_LOAD_MISSES.WALK_COMPLETED + ITLB_MISSES.WALK_COMPLETED)) / =
(2 * CORE_CLKS)",
-        "MetricGroup": "Mem;MemoryTLB",
-        "MetricName": "Page_Walks_Utilization"
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues",
+        "MetricExpr": "4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE=
 / tma_info_slots",
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
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / duration_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L1D_Cache_Fill_BW"
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
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / duration_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L2_Cache_Fill_BW"
+        "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) scalar uops fraction the CPU has retired",
+        "MetricExpr": "cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ / UOPS_RETIRED.RETIRE_SLOTS",
+        "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
+        "MetricName": "tma_fp_scalar",
+        "MetricThreshold": "tma_fp_scalar > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting. Related metrics: tma_fp_vector, tma_fp_vector_128b, tm=
a_fp_vector_256b, tma_fp_vector_512b, tma_port_0, tma_port_1, tma_port_5, t=
ma_port_6, tma_ports_utilized_2",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / duration_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L3_Cache_Fill_BW"
+        "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) vector uops fraction the CPU has retired aggregated across all v=
ector widths",
+        "MetricExpr": "cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\,umas=
k\\=3D0x3c@ / UOPS_RETIRED.RETIRE_SLOTS",
+        "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
+        "MetricName": "tma_fp_vector",
+        "MetricThreshold": "tma_fp_vector > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting. Related metrics: t=
ma_fp_scalar, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, t=
ma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
-        "MetricExpr": "L1D_Cache_Fill_BW",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L1D_Cache_Fill_BW_1T"
+        "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 128-bit wide vectors",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.128B_PACKED_SINGLE) / UOPS_RETIRED.RETIRE_SLOTS",
+        "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
+        "MetricName": "tma_fp_vector_128b",
+        "MetricThreshold": "tma_fp_vector_128b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_256b, tma_fp_vector_512b, tma_port_0, tma_port_1, tma_port_5=
, tma_port_6, tma_ports_utilized_2",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
-        "MetricExpr": "L2_Cache_Fill_BW",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L2_Cache_Fill_BW_1T"
+        "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 256-bit wide vectors",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.256B_PACKED_SINGLE) / UOPS_RETIRED.RETIRE_SLOTS",
+        "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
+        "MetricName": "tma_fp_vector_256b",
+        "MetricThreshold": "tma_fp_vector_256b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_128b, tma_fp_vector_512b, tma_port_0, tma_port_1, tma_port_5=
, tma_port_6, tma_ports_utilized_2",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "L3_Cache_Fill_BW",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L3_Cache_Fill_BW_1T"
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
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
-        "MetricExpr": "0",
-        "MetricGroup": "Mem;MemoryBW;Offcore",
-        "MetricName": "L3_Cache_Access_BW_1T"
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or micro-coded sequences",
+        "MetricExpr": "tma_microcode_sequencer",
+        "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_g=
roup",
+        "MetricName": "tma_heavy_operations",
+        "MetricThreshold": "tma_heavy_operations > 0.1",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or micro-coded sequences. This highly-correlates with th=
e uop length of these instructions/sequences.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average CPU Utilization",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
-        "MetricGroup": "HPC;Summary",
-        "MetricName": "CPU_Utilization"
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses.",
+        "MetricExpr": "ICACHE.IFDATA_STALL / tma_info_clks",
+        "MetricGroup": "BigFoot;FetchLat;IcMiss;TopdownL3;tma_L3_group;tma=
_fetch_latency_group",
+        "MetricName": "tma_icache_misses",
+        "MetricThreshold": "tma_icache_misses > 0.05 & (tma_fetch_latency =
> 0.1 & tma_frontend_bound > 0.15)",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Measured Average Frequency for unhalted proce=
ssors [GHz]",
-        "MetricExpr": "Turbo_Utilization * TSC / 1e9 / duration_time",
+        "MetricExpr": "tma_info_turbo_utilization * TSC / 1e9 / duration_t=
ime",
         "MetricGroup": "Power;Summary",
-        "MetricName": "Average_Frequency"
+        "MetricName": "tma_info_average_frequency"
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
instructions, vector-width and AMX engine."
-    },
-    {
-        "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
-        "MetricExpr": "CLKS / CPU_CLK_UNHALTED.REF_TSC",
-        "MetricGroup": "Power",
-        "MetricName": "Turbo_Utilization"
-    },
-    {
-        "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
-        "MetricExpr": "(1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / (CPU_CLK_=
UNHALTED.REF_XCLK_ANY / 2) if #SMT_on else 0)",
-        "MetricGroup": "SMT",
-        "MetricName": "SMT_2T_Utilization"
-    },
-    {
-        "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.THRE=
AD",
-        "MetricGroup": "OS",
-        "MetricName": "Kernel_Utilization"
-    },
-    {
-        "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
-        "MetricGroup": "OS",
-        "MetricName": "Kernel_CPI"
-    },
-    {
-        "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
-        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e=
9 / duration_time",
-        "MetricGroup": "HPC;Mem;MemoryBW;SoC",
-        "MetricName": "DRAM_BW_Use"
+        "BriefDescription": "Branch instructions per taken branch.",
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
+        "MetricGroup": "Branches;Fed;PGO",
+        "MetricName": "tma_info_bptkbranch"
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
ated metrics: tma_branch_mispredicts, tma_mispredicts_resteers"
     },
     {
-        "BriefDescription": "Average number of parallel data read requests=
 to external memory. Accounts for demand loads and L1/L2 prefetches",
-        "MetricExpr": "UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=3D0x18=
2@ / UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=3D0x182\\,thresh\\=3D1@",
-        "MetricGroup": "Mem;MemoryBW;SoC",
-        "MetricName": "MEM_Parallel_Reads"
+        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "Pipeline",
+        "MetricName": "tma_info_clks"
     },
     {
-        "BriefDescription": "Socket actual clocks when any core is active =
on that socket",
-        "MetricExpr": "cbox_0@event\\=3D0x0@",
-        "MetricGroup": "SoC",
-        "MetricName": "Socket_CLKS"
+        "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
+        "MetricExpr": "(CPU_CLK_UNHALTED.THREAD / 2 * (1 + CPU_CLK_UNHALTE=
D.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK) if #core_wide < 1 else (CP=
U_CLK_UNHALTED.THREAD_ANY / 2 if #SMT_on else tma_info_clks))",
+        "MetricGroup": "SMT",
+        "MetricName": "tma_info_core_clks"
     },
     {
-        "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
-        "MetricGroup": "Branches;OS",
-        "MetricName": "IpFarBranch"
+        "BriefDescription": "Instructions Per Cycle across hyper-threads (=
per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / tma_info_core_clks",
+        "MetricGroup": "Ret;SMT;TmaL1;tma_L1_group",
+        "MetricName": "tma_info_coreipc"
     },
     {
-        "BriefDescription": "Uncore frequency per die [GHZ]",
-        "MetricExpr": "Socket_CLKS / #num_dies / duration_time / 1e9",
-        "MetricGroup": "SoC",
-        "MetricName": "UNCORE_FREQ"
+        "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
+        "MetricExpr": "1 / tma_info_ipc",
+        "MetricGroup": "Mem;Pipeline",
+        "MetricName": "tma_info_cpi"
     },
     {
-        "BriefDescription": "CPU operating frequency (in GHz)",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC =
* #SYSTEM_TSC_FREQ / 1e9 / duration_time",
-        "MetricName": "cpu_operating_frequency",
-        "ScaleUnit": "1GHz"
+        "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricGroup": "HPC;Summary",
+        "MetricName": "tma_info_cpu_utilization"
     },
     {
-        "BriefDescription": "Cycles per instruction retired; indicating ho=
w much time each executed instruction took; in units of cycles.",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / INST_RETIRED.ANY",
-        "MetricName": "cpi",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "Average Parallel L2 cache miss data reads",
+        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD / OFFCORE_=
REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
+        "MetricGroup": "Memory_BW;Offcore",
+        "MetricName": "tma_info_data_l2_mlp"
     },
     {
-        "BriefDescription": "The ratio of number of completed memory load =
instructions to the total number completed instructions",
-        "MetricExpr": "MEM_UOPS_RETIRED.ALL_LOADS / INST_RETIRED.ANY",
-        "MetricName": "loads_per_instr",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
+        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e=
9 / duration_time",
+        "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
+        "MetricName": "tma_info_dram_bw_use",
+        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_fb_full, tma_mem_bandwidth,=
 tma_sq_full"
     },
     {
-        "BriefDescription": "The ratio of number of completed memory store=
 instructions to the total number completed instructions",
-        "MetricExpr": "MEM_UOPS_RETIRED.ALL_STORES / INST_RETIRED.ANY",
-        "MetricName": "stores_per_instr",
-        "ScaleUnit": "1per_instr"
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
bandwidth, tma_info_iptb, tma_lcp"
     },
     {
-        "BriefDescription": "Ratio of number of requests missing L1 data c=
ache (includes data+rfo w/ prefetches) to the total number of completed ins=
tructions",
-        "MetricExpr": "L1D.REPLACEMENT / INST_RETIRED.ANY",
-        "MetricName": "l1d_mpi",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-thread",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D1@",
+        "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
+        "MetricName": "tma_info_execute"
     },
     {
-        "BriefDescription": "Ratio of number of demand load requests hitti=
ng in L1 data cache to the total number of completed instructions",
-        "MetricExpr": "MEM_LOAD_UOPS_RETIRED.L1_HIT / INST_RETIRED.ANY",
-        "MetricName": "l1d_demand_data_read_hits_per_instr",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "The ratio of Executed- by Issued-Uops",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / UOPS_ISSUED.ANY",
+        "MetricGroup": "Cor;Pipeline",
+        "MetricName": "tma_info_execute_per_issue",
+        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage."
     },
     {
-        "BriefDescription": "Ratio of number of code read requests missing=
 in L1 instruction cache (includes prefetches) to the total number of compl=
eted instructions",
-        "MetricExpr": "L2_RQSTS.ALL_CODE_RD / INST_RETIRED.ANY",
-        "MetricName": "l1_i_code_read_misses_with_prefetches_per_instr",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 =
* (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PA=
CKED_DOUBLE) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) / tma_info_cor=
e_clks",
+        "MetricGroup": "Flops;Ret",
+        "MetricName": "tma_info_flopc"
     },
     {
-        "BriefDescription": "Ratio of number of completed demand load requ=
ests hitting in L2 cache to the total number of completed instructions",
-        "MetricExpr": "MEM_LOAD_UOPS_RETIRED.L2_HIT / INST_RETIRED.ANY",
-        "MetricName": "l2_demand_data_read_hits_per_instr",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
+        "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\,umask\\=3D0x3c@) =
/ (2 * tma_info_core_clks)",
+        "MetricGroup": "Cor;Flops;HPC",
+        "MetricName": "tma_info_fp_arith_utilization",
+        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)."
     },
     {
-        "BriefDescription": "Ratio of number of requests missing L2 cache =
(includes code+data+rfo w/ prefetches) to the total number of completed ins=
tructions",
-        "MetricExpr": "L2_LINES_IN.ALL / INST_RETIRED.ANY",
-        "MetricName": "l2_mpi",
-        "ScaleUnit": "1per_instr"
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
instructions, vector-width and AMX engine."
     },
     {
-        "BriefDescription": "Ratio of number of completed data read reques=
t missing L2 cache to the total number of completed instructions",
-        "MetricExpr": "MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
-        "MetricName": "l2_demand_data_read_mpi",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (cpu@UOPS_EXECUTED.CORE\\,cm=
ask\\=3D1@ / 2 if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
+        "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
+        "MetricName": "tma_info_ilp"
     },
     {
-        "BriefDescription": "Ratio of number of code read request missing =
L2 cache to the total number of completed instructions",
-        "MetricExpr": "L2_RQSTS.CODE_RD_MISS / INST_RETIRED.ANY",
-        "MetricName": "l2_demand_code_mpi",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "Total number of retired Instructions",
+        "MetricExpr": "INST_RETIRED.ANY",
+        "MetricGroup": "Summary;TmaL1;tma_L1_group",
+        "MetricName": "tma_info_instructions",
+        "PublicDescription": "Total number of retired Instructions. Sample=
 with: INST_RETIRED.PREC_DIST"
     },
     {
-        "BriefDescription": "Ratio of number of data read requests missing=
 last level core cache (includes demand w/ prefetches) to the total number =
of completed instructions",
-        "MetricExpr": "(cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=
=3D0x182@ + cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=3D0x192@) / I=
NST_RETIRED.ANY",
-        "MetricName": "llc_data_read_mpi_demand_plus_prefetch",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "Instructions per FP Arithmetic instruction (l=
ower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / (cpu@FP_ARITH_INST_RETIRED.SCALA=
R_SINGLE\\,umask\\=3D0x03@ + cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\=
,umask\\=3D0x3c@)",
+        "MetricGroup": "Flops;InsType",
+        "MetricName": "tma_info_iparith",
+        "MetricThreshold": "tma_info_iparith < 10",
+        "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). May undercount due to FMA doubl=
e counting. Approximated prior to BDW."
     },
     {
-        "BriefDescription": "Ratio of number of code read requests missing=
 last level core cache (includes demand w/ prefetches) to the total number =
of completed instructions",
-        "MetricExpr": "(cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=
=3D0x181@ + cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=3D0x191@) / I=
NST_RETIRED.ANY",
-        "MetricName": "llc_code_read_mpi_demand_plus_prefetch",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-bi=
t instruction (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.128B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE)",
+        "MetricGroup": "Flops;FpVector;InsType",
+        "MetricName": "tma_info_iparith_avx128",
+        "MetricThreshold": "tma_info_iparith_avx128 < 10",
+        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). May undercount =
due to FMA double counting."
     },
     {
-        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand and prefetch data read miss (read memory access) in nano seconds",
-        "MetricExpr": "1e9 * (cbox@UNC_C_TOR_OCCUPANCY.MISS_OPCODE\\,filte=
r_opc\\=3D0x182@ / cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=3D0x18=
2@) / (UNC_C_CLOCKTICKS / (#num_cores / #num_packages * #num_packages)) * d=
uration_time",
-        "MetricName": "llc_data_read_demand_plus_prefetch_miss_latency",
-        "ScaleUnit": "1ns"
+        "BriefDescription": "Instructions per FP Arithmetic AVX* 256-bit i=
nstruction (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.256B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE)",
+        "MetricGroup": "Flops;FpVector;InsType",
+        "MetricName": "tma_info_iparith_avx256",
+        "MetricThreshold": "tma_info_iparith_avx256 < 10",
+        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). May undercount due=
 to FMA double counting."
     },
     {
-        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand and prefetch data read miss (read memory access) addressed to local m=
emory in nano seconds",
-        "MetricExpr": "1e9 * (cbox@UNC_C_TOR_OCCUPANCY.MISS_LOCAL_OPCODE\\=
,filter_opc\\=3D0x182@ / cbox@UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE\\,filter_=
opc\\=3D0x182@) / (UNC_C_CLOCKTICKS / (#num_cores / #num_packages * #num_pa=
ckages)) * duration_time",
-        "MetricName": "llc_data_read_demand_plus_prefetch_miss_latency_for=
_local_requests",
-        "ScaleUnit": "1ns"
+        "BriefDescription": "Instructions per FP Arithmetic Scalar Double-=
Precision instruction (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED.SCALAR_DOU=
BLE",
+        "MetricGroup": "Flops;FpScalar;InsType",
+        "MetricName": "tma_info_iparith_scalar_dp",
+        "MetricThreshold": "tma_info_iparith_scalar_dp < 10",
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). May und=
ercount due to FMA double counting."
     },
     {
-        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand and prefetch data read miss (read memory access) addressed to remote =
memory in nano seconds",
-        "MetricExpr": "1e9 * (cbox@UNC_C_TOR_OCCUPANCY.MISS_REMOTE_OPCODE\=
\,filter_opc\\=3D0x182@ / cbox@UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE\\,filte=
r_opc\\=3D0x182@) / (UNC_C_CLOCKTICKS / (#num_cores / #num_packages * #num_=
packages)) * duration_time",
-        "MetricName": "llc_data_read_demand_plus_prefetch_miss_latency_for=
_remote_requests",
-        "ScaleUnit": "1ns"
+        "BriefDescription": "Instructions per FP Arithmetic Scalar Single-=
Precision instruction (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED.SCALAR_SIN=
GLE",
+        "MetricGroup": "Flops;FpScalar;InsType",
+        "MetricName": "tma_info_iparith_scalar_sp",
+        "MetricThreshold": "tma_info_iparith_scalar_sp < 10",
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). May und=
ercount due to FMA double counting."
     },
     {
-        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by a code fetch to the total number of completed ins=
tructions",
-        "MetricExpr": "ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.ANY",
-        "MetricName": "itlb_mpi",
-        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by a code fetch to the total number of completed in=
structions. This implies it missed in the ITLB (Instruction TLB) and furthe=
r levels of TLB.",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Branches;Fed;InsType",
+        "MetricName": "tma_info_ipbranch",
+        "MetricThreshold": "tma_info_ipbranch < 8"
     },
     {
-        "BriefDescription": "Ratio of number of completed page walks (for =
2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total n=
umber of completed instructions",
-        "MetricExpr": "ITLB_MISSES.WALK_COMPLETED_2M_4M / INST_RETIRED.ANY=
",
-        "MetricName": "itlb_large_page_mpi",
-        "PublicDescription": "Ratio of number of completed page walks (for=
 2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total =
number of completed instructions. This implies it missed in the Instruction=
 Translation Lookaside Buffer (ITLB) and further levels of TLB.",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
+        "MetricExpr": "INST_RETIRED.ANY / tma_info_clks",
+        "MetricGroup": "Ret;Summary",
+        "MetricName": "tma_info_ipc"
     },
     {
-        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data loads to the total number of complete=
d instructions",
-        "MetricExpr": "DTLB_LOAD_MISSES.WALK_COMPLETED / INST_RETIRED.ANY"=
,
-        "MetricName": "dtlb_load_mpi",
-        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data loads to the total number of complet=
ed instructions. This implies it missed in the DTLB and further levels of T=
LB.",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "Instructions per (near) call (lower number me=
ans higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
+        "MetricGroup": "Branches;Fed;PGO",
+        "MetricName": "tma_info_ipcall",
+        "MetricThreshold": "tma_info_ipcall < 200"
     },
     {
-        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data stores to the total number of complet=
ed instructions",
-        "MetricExpr": "DTLB_STORE_MISSES.WALK_COMPLETED / INST_RETIRED.ANY=
",
-        "MetricName": "dtlb_store_mpi",
-        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data stores to the total number of comple=
ted instructions. This implies it missed in the DTLB and further levels of =
TLB.",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
+        "MetricGroup": "Branches;OS",
+        "MetricName": "tma_info_ipfarbranch",
+        "MetricThreshold": "tma_info_ipfarbranch < 1e6"
     },
     {
-        "BriefDescription": "Memory read that miss the last level cache (L=
LC) addressed to local DRAM as a percentage of total memory read accesses, =
does not include LLC prefetches.",
-        "MetricExpr": "cbox@UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE\\,filter_o=
pc\\=3D0x182@ / (cbox@UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE\\,filter_opc\\=3D=
0x182@ + cbox@UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE\\,filter_opc\\=3D0x182@)=
",
-        "MetricName": "numa_reads_addressed_to_local_dram",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Instructions per Floating Point (FP) Operatio=
n (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR_SI=
NGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE + 2 * FP_ARITH_INST_RETIRED.128B=
_PACKED_DOUBLE + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_I=
NST_RETIRED.256B_PACKED_DOUBLE) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SIN=
GLE)",
+        "MetricGroup": "Flops;InsType",
+        "MetricName": "tma_info_ipflop",
+        "MetricThreshold": "tma_info_ipflop < 10"
     },
     {
-        "BriefDescription": "Memory reads that miss the last level cache (=
LLC) addressed to remote DRAM as a percentage of total memory read accesses=
, does not include LLC prefetches.",
-        "MetricExpr": "cbox@UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE\\,filter_=
opc\\=3D0x182@ / (cbox@UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE\\,filter_opc\\=
=3D0x182@ + cbox@UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE\\,filter_opc\\=3D0x18=
2@)",
-        "MetricName": "numa_reads_addressed_to_remote_dram",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Instructions per Load (lower number means hig=
her occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_LOADS",
+        "MetricGroup": "InsType",
+        "MetricName": "tma_info_ipload",
+        "MetricThreshold": "tma_info_ipload < 3"
     },
     {
-        "BriefDescription": "Uncore operating frequency in GHz",
-        "MetricExpr": "UNC_C_CLOCKTICKS / (#num_cores / #num_packages * #n=
um_packages) / 1e9 / duration_time",
-        "MetricName": "uncore_frequency",
-        "ScaleUnit": "1GHz"
+        "BriefDescription": "Instructions per retired mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
+        "MetricExpr": "tma_info_instructions / (UOPS_RETIRED.RETIRE_SLOTS =
/ UOPS_ISSUED.ANY * cpu@BR_MISP_EXEC.ALL_BRANCHES\\,umask\\=3D0xE4@)",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "tma_info_ipmisp_indirect",
+        "MetricThreshold": "tma_info_ipmisp_indirect < 1e3"
     },
     {
-        "BriefDescription": "Intel(R) Quick Path Interconnect (QPI) data t=
ransmit bandwidth (MB/sec)",
-        "MetricExpr": "UNC_Q_TxL_FLITS_G0.DATA * 8 / 1e6 / duration_time",
-        "MetricName": "qpi_data_transmit_bw",
-        "ScaleUnit": "1MB/s"
+        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts",
+        "MetricName": "tma_info_ipmispredict",
+        "MetricThreshold": "tma_info_ipmispredict < 200"
     },
     {
-        "BriefDescription": "DDR memory read bandwidth (MB/sec)",
-        "MetricExpr": "UNC_M_CAS_COUNT.RD * 64 / 1e6 / duration_time",
-        "MetricName": "memory_bandwidth_read",
-        "ScaleUnit": "1MB/s"
+        "BriefDescription": "Instructions per Store (lower number means hi=
gher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_STORES",
+        "MetricGroup": "InsType",
+        "MetricName": "tma_info_ipstore",
+        "MetricThreshold": "tma_info_ipstore < 8"
     },
     {
-        "BriefDescription": "DDR memory write bandwidth (MB/sec)",
-        "MetricExpr": "UNC_M_CAS_COUNT.WR * 64 / 1e6 / duration_time",
-        "MetricName": "memory_bandwidth_write",
-        "ScaleUnit": "1MB/s"
+        "BriefDescription": "Instruction per taken branch",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
+        "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO;tma_issueFB",
+        "MetricName": "tma_info_iptb",
+        "MetricThreshold": "tma_info_iptb < 9",
+        "PublicDescription": "Instruction per taken branch. Related metric=
s: tma_dsb_switches, tma_fetch_bandwidth, tma_info_dsb_coverage, tma_lcp"
     },
     {
-        "BriefDescription": "DDR memory bandwidth (MB/sec)",
-        "MetricExpr": "(UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) * 64 / 1e=
6 / duration_time",
-        "MetricName": "memory_bandwidth_total",
-        "ScaleUnit": "1MB/s"
+        "BriefDescription": "Instructions per speculative Unknown Branch M=
isprediction (BAClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "tma_info_instructions / BACLEARS.ANY",
+        "MetricGroup": "Fed",
+        "MetricName": "tma_info_ipunknown_branch"
     },
     {
-        "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the CPU.",
-        "MetricExpr": "cbox@UNC_C_TOR_INSERTS.OPCODE\\,filter_opc\\=3D0x19=
e@ * 64 / 1e6 / duration_time",
-        "MetricName": "io_bandwidth_disk_or_network_writes",
-        "ScaleUnit": "1MB/s"
+        "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
+        "MetricGroup": "OS",
+        "MetricName": "tma_info_kernel_cpi"
     },
     {
-        "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the CPU.",
-        "MetricExpr": "(cbox@UNC_C_TOR_INSERTS.OPCODE\\,filter_opc\\=3D0x1=
c8\\,filter_tid\\=3D0x3e@ + cbox@UNC_C_TOR_INSERTS.OPCODE\\,filter_opc\\=3D=
0x180\\,filter_tid\\=3D0x3e@) * 64 / 1e6 / duration_time",
-        "MetricName": "io_bandwidth_disk_or_network_reads",
-        "ScaleUnit": "1MB/s"
+        "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.THRE=
AD",
+        "MetricGroup": "OS",
+        "MetricName": "tma_info_kernel_utilization",
+        "MetricThreshold": "tma_info_kernel_utilization > 0.05"
     },
     {
-        "BriefDescription": "Uops delivered from decoded instruction cache=
 (decoded stream buffer or DSB) as a percent of total uops delivered to Ins=
truction Decode Queue",
-        "MetricExpr": "IDQ.DSB_UOPS / UOPS_ISSUED.ANY",
-        "MetricName": "percent_uops_delivered_from_decoded_icache",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / duration_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_l1d_cache_fill_bw"
     },
     {
-        "BriefDescription": "Uops delivered from legacy decode pipeline (M=
icro-instruction Translation Engine or MITE) as a percent of total uops del=
ivered to Instruction Decode Queue",
-        "MetricExpr": "IDQ.MITE_UOPS / UOPS_ISSUED.ANY",
-        "MetricName": "percent_uops_delivered_from_legacy_decode_pipeline"=
,
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
+        "MetricExpr": "tma_info_l1d_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_l1d_cache_fill_bw_1t"
     },
     {
-        "BriefDescription": "Uops delivered from microcode sequencer (MS) =
as a percent of total uops delivered to Instruction Decode Queue",
-        "MetricExpr": "IDQ.MS_UOPS / UOPS_ISSUED.ANY",
-        "MetricName": "percent_uops_delivered_from_microcode_sequencer",
-        "ScaleUnit": "100%"
+        "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1e3 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED.=
ANY",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "tma_info_l1mpki"
     },
     {
-        "BriefDescription": "Uops delivered from loop stream detector(LSD)=
 as a percent of total uops delivered to Instruction Decode Queue",
-        "MetricExpr": "LSD.UOPS / UOPS_ISSUED.ANY",
-        "MetricName": "percent_uops_delivered_from_loop_stream_detector",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / duration_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_l2_cache_fill_bw"
     },
     {
-        "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / SLOTS",
-        "MetricGroup": "PGO;TopdownL1;tma_L1_group;tma_L1_group",
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
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
+        "MetricExpr": "tma_info_l2_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_l2_cache_fill_bw_1t"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues",
-        "MetricExpr": "4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE=
 / SLOTS",
-        "MetricGroup": "Frontend;TopdownL2;tma_L2_group;tma_L2_group;tma_f=
rontend_bound_group",
-        "MetricName": "tma_fetch_latency",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend latency issues.  For example; instruction-=
cache misses; iTLB misses or fetch stalls after a branch misprediction are =
categorized under Frontend Latency. In such cases; the Frontend eventually =
delivers no uops for some period.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "L2 cache hits per kilo instruction for all re=
quest types (including speculative)",
+        "MetricExpr": "1e3 * (L2_RQSTS.REFERENCES - L2_RQSTS.MISS) / INST_=
RETIRED.ANY",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "tma_info_l2hpki_all"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses.",
-        "MetricExpr": "ICACHE.IFDATA_STALL / CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "BigFoot;FetchLat;IcMiss;TopdownL3;tma_L3_group;tma=
_fetch_latency_group",
-        "MetricName": "tma_icache_misses",
-        "ScaleUnit": "100%"
+        "BriefDescription": "L2 cache hits per kilo instruction for all de=
mand loads  (including speculative)",
+        "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_HIT / INST_RETIRED.AN=
Y",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "tma_info_l2hpki_load"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses.",
-        "MetricExpr": "(14 * ITLB_MISSES.STLB_HIT + cpu@ITLB_MISSES.WALK_D=
URATION\\,cmask\\=3D0x1@ + 7 * ITLB_MISSES.WALK_COMPLETED) / CPU_CLK_UNHALT=
ED.THREAD",
-        "MetricGroup": "BigFoot;FetchLat;MemoryTLB;TopdownL3;tma_L3_group;=
tma_fetch_latency_group",
-        "MetricName": "tma_itlb_misses",
-        "ScaleUnit": "100%"
+        "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1e3 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.=
ANY",
+        "MetricGroup": "Backend;CacheMisses;Mem",
+        "MetricName": "tma_info_l2mpki"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers",
-        "MetricExpr": "12 * (BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS=
.COUNT + BACLEARS.ANY) / CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group",
-        "MetricName": "tma_branch_resteers",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fro=
ntend delay in fetching operations from corrected path; following all sorts=
 of miss-predicted branches. For example; branchy code with lots of miss-pr=
edictions might get categorized under Branch Resteers. Note the value of th=
is node may overlap with its siblings.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all request types (including speculative)",
+        "MetricExpr": "1e3 * L2_RQSTS.MISS / INST_RETIRED.ANY",
+        "MetricGroup": "CacheMisses;Mem;Offcore",
+        "MetricName": "tma_info_l2mpki_all"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Branch Misprediction=
 at execution stage. ",
-        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES * tma_branch_resteers =
/ (BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + BACLEARS.ANY)",
-        "MetricGroup": "BadSpec;BrMispredicts;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group",
-        "MetricName": "tma_mispredicts_resteers",
-        "ScaleUnit": "100%"
+        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all demand loads  (including speculative)",
+        "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_MISS / INST_RETIRED.A=
NY",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "tma_info_l2mpki_load"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Machine Clears. ",
-        "MetricExpr": "MACHINE_CLEARS.COUNT * tma_branch_resteers / (BR_MI=
SP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + BACLEARS.ANY)",
-        "MetricGroup": "BadSpec;MachineClears;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group",
-        "MetricName": "tma_clears_resteers",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
+        "MetricExpr": "0",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "tma_info_l3_cache_access_bw_1t"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to new branch address clears",
-        "MetricExpr": "tma_branch_resteers - tma_mispredicts_resteers - tm=
a_clears_resteers",
-        "MetricGroup": "BigFoot;FetchLat;TopdownL4;tma_L4_group;tma_branch=
_resteers_group",
-        "MetricName": "tma_unknown_branches",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to new branch address clears. These are fetched branc=
hes the Branch Prediction Unit was unable to recognize (First fetch or hitt=
ing BPU capacity limit).",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / duration_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_l3_cache_fill_bw"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to switches from DSB to MITE pipelines",
-        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / CPU_CLK_UNHALTED=
.THREAD",
-        "MetricGroup": "DSBmiss;FetchLat;TopdownL3;tma_L3_group;tma_fetch_=
latency_group",
-        "MetricName": "tma_dsb_switches",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
+        "MetricExpr": "tma_info_l3_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_l3_cache_fill_bw_1t"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles CPU=
 was stalled due to Length Changing Prefixes (LCPs)",
-        "MetricExpr": "ILD_STALL.LCP / CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group",
-        "MetricName": "tma_lcp",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1e3 * MEM_LOAD_UOPS_RETIRED.L3_MISS / INST_RETIRED.=
ANY",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "tma_info_l3mpki"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS)",
-        "MetricExpr": "2 * IDQ.MS_SWITCHES / CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "FetchLat;MicroSeq;TopdownL3;tma_L3_group;tma_fetch=
_latency_group",
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
with Denormals.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average Latency for L2 cache miss demand Load=
s",
+        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS.DEMAND_DATA_RD",
+        "MetricGroup": "Memory_Lat;Offcore",
+        "MetricName": "tma_info_load_l2_miss_latency"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend bandwidth issues",
-        "MetricExpr": "tma_frontend_bound - tma_fetch_latency",
-        "MetricGroup": "FetchBW;Frontend;TopdownL2;tma_L2_group;tma_L2_gro=
up;tma_frontend_bound_group",
-        "MetricName": "tma_fetch_bandwidth",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average Parallel L2 cache miss demand Loads",
+        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_DATA_RD",
+        "MetricGroup": "Memory_BW;Offcore",
+        "MetricName": "tma_info_load_l2_mlp"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the MITE pipeline (the legacy deco=
de pipeline)",
-        "MetricExpr": "(IDQ.ALL_MITE_CYCLES_ANY_UOPS - IDQ.ALL_MITE_CYCLES=
_4_UOPS) / CORE_CLKS / 2",
-        "MetricGroup": "DSBmiss;FetchBW;TopdownL3;tma_L3_group;tma_fetch_b=
andwidth_group",
-        "MetricName": "tma_mite",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to the MITE pipeline (the legacy dec=
ode pipeline). This pipeline is used for code that was not pre-cached in th=
e DSB or LSD. For example; inefficiencies due to asymmetric decoders; use o=
f long immediate or LCP can manifest as MITE fetch bandwidth bottleneck.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / (MEM_LOAD_UOPS_RETIRED.L1_M=
ISS + MEM_LOAD_UOPS_RETIRED.HIT_LFB)",
+        "MetricGroup": "Mem;MemoryBound;MemoryLat",
+        "MetricName": "tma_info_load_miss_real_latency"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to DSB (decoded uop cache) fetch pipe=
line",
-        "MetricExpr": "(IDQ.ALL_DSB_CYCLES_ANY_UOPS - IDQ.ALL_DSB_CYCLES_4=
_UOPS) / CORE_CLKS / 2",
-        "MetricGroup": "DSB;FetchBW;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
-        "MetricName": "tma_dsb",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here.",
-        "ScaleUnit": "100%"
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
-        "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
-        "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * =
(INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)=
) / SLOTS",
-        "MetricGroup": "TopdownL1;tma_L1_group;tma_L1_group",
-        "MetricName": "tma_bad_speculation",
-        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
-        "ScaleUnit": "100%"
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
-        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction",
-        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRED.ALL=
_BRANCHES + MACHINE_CLEARS.COUNT) * tma_bad_speculation",
-        "MetricGroup": "BadSpec;BrMispredicts;TopdownL2;tma_L2_group;tma_L=
2_group;tma_bad_speculation_group",
-        "MetricName": "tma_branch_mispredicts",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLE=
S",
+        "MetricGroup": "Mem;MemoryBW;MemoryBound",
+        "MetricName": "tma_info_mlp",
+        "PublicDescription": "Memory-Level-Parallelism (average number of =
L1 miss demand load when there is at least one such miss. Per-Logical Proce=
ssor)"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Machine Clears",
-        "MetricExpr": "tma_bad_speculation - tma_branch_mispredicts",
-        "MetricGroup": "BadSpec;MachineClears;TopdownL2;tma_L2_group;tma_L=
2_group;tma_bad_speculation_group",
-        "MetricName": "tma_machine_clears",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Machine Clears.  These slots are either wasted by uo=
ps fetched prior to the clear; or stalls the out-of-order portion of the ma=
chine needs to recover its state after the clear. For example; this can hap=
pen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modif=
ying-Code (SMC) nukes.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
+        "MetricExpr": "(ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_=
DURATION + DTLB_STORE_MISSES.WALK_DURATION + 7 * (DTLB_STORE_MISSES.WALK_CO=
MPLETED + DTLB_LOAD_MISSES.WALK_COMPLETED + ITLB_MISSES.WALK_COMPLETED)) / =
(2 * tma_info_core_clks)",
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_page_walks_utilization",
+        "MetricThreshold": "tma_info_page_walks_utilization > 0.5"
     },
     {
-        "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
-        "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + UOP=
S_RETIRED.RETIRE_SLOTS / SLOTS)",
-        "MetricGroup": "TopdownL1;tma_L1_group;tma_L1_group",
-        "MetricName": "tma_backend_bound",
-        "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / cpu@UOPS_RETIRED.RETIRE=
_SLOTS\\,cmask\\=3D1@",
+        "MetricGroup": "Pipeline;Ret",
+        "MetricName": "tma_info_retire"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
-        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_MEM_ANY + RESOURCE_STALLS.SB=
) / (CYCLE_ACTIVITY.STALLS_TOTAL + UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC - (UO=
PS_EXECUTED.CYCLES_GE_3_UOPS_EXEC if INST_RETIRED.ANY / CPU_CLK_UNHALTED.TH=
READ > 1.8 else UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC) - (RS_EVENTS.EMPTY_CYC=
LES if tma_fetch_latency > 0.1 else 0) + RESOURCE_STALLS.SB) * tma_backend_=
bound",
-        "MetricGroup": "Backend;TopdownL2;tma_L2_group;tma_L2_group;tma_ba=
ckend_bound_group",
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
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
+        "MetricExpr": "4 * tma_info_core_clks",
+        "MetricGroup": "TmaL1;tma_L1_group",
+        "MetricName": "tma_info_slots"
     },
     {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache",
-        "MetricExpr": "max((CYCLE_ACTIVITY.STALLS_MEM_ANY - CYCLE_ACTIVITY=
.STALLS_L1D_MISS) / CPU_CLK_UNHALTED.THREAD, 0)",
-        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
-        "MetricName": "tma_l1_bound",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled without loads missing the L1 data cache.  The L1 data cache typical=
ly has the shortest latency.  However; in certain cases like loads blocked =
on older stores; a load might suffer due to high latency even though it is =
being satisfied by the L1. Another example is loads who miss in the TLB. Th=
ese cases are characterized by execution unit stalls; while some non-comple=
ted demand load lives in the machine without having that demand load missin=
g the L1 cache.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
+        "MetricExpr": "(1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / (CPU_CLK_=
UNHALTED.REF_XCLK_ANY / 2) if #SMT_on else 0)",
+        "MetricGroup": "SMT",
+        "MetricName": "tma_info_smt_2t_utilization"
     },
     {
-        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
-        "MetricExpr": "(8 * DTLB_LOAD_MISSES.STLB_HIT + cpu@DTLB_LOAD_MISS=
ES.WALK_DURATION\\,cmask\\=3D0x1@ + 7 * DTLB_LOAD_MISSES.WALK_COMPLETED) / =
CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "MemoryTLB;TopdownL4;tma_L4_group;tma_l1_bound_grou=
p",
-        "MetricName": "tma_dtlb_load",
-        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Socket actual clocks when any core is active =
on that socket",
+        "MetricExpr": "cbox_0@event\\=3D0x0@",
+        "MetricGroup": "SoC",
+        "MetricName": "tma_info_socket_clks"
     },
     {
-        "BriefDescription": "This metric roughly estimates fraction of cyc=
les when the memory subsystem had loads blocked since they could not forwar=
d data from earlier (in program order) overlapping stores",
-        "MetricExpr": "min(13 * LD_BLOCKS.STORE_FORWARD / CPU_CLK_UNHALTED=
.THREAD, 1)",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
-        "MetricName": "tma_store_fwd_blk",
-        "PublicDescription": "This metric roughly estimates fraction of cy=
cles when the memory subsystem had loads blocked since they could not forwa=
rd data from earlier (in program order) overlapping stores. To streamline m=
emory operations in the pipeline; a load can avoid waiting for memory if a =
prior in-flight store is writing the data that the load wants to read (stor=
e forwarding process). However; in some cases the load may be blocked for a=
 significant time pending the store forward. For example; when the prior st=
ore is writing a smaller region than the load is reading.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
+        "MetricExpr": "tma_info_clks / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricGroup": "Power",
+        "MetricName": "tma_info_turbo_utilization"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
-        "MetricExpr": "min(MEM_UOPS_RETIRED.LOCK_LOADS / MEM_UOPS_RETIRED.=
ALL_STORES * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTANDING.CYCL=
ES_WITH_DEMAND_RFO) / CPU_CLK_UNHALTED.THREAD, 1)",
-        "MetricGroup": "Offcore;TopdownL4;tma_L4_group;tma_l1_bound_group"=
,
-        "MetricName": "tma_lock_latency",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Uops Per Instruction",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
+        "MetricGroup": "Pipeline;Ret;Retire",
+        "MetricName": "tma_info_uoppi",
+        "MetricThreshold": "tma_info_uoppi > 1.05"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles hand=
ling memory load split accesses - load that cross 64-byte cache line bounda=
ry. ",
-        "MetricExpr": "min(Load_Miss_Real_Latency * LD_BLOCKS.NO_SR / CPU_=
CLK_UNHALTED.THREAD, 1)",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
-        "MetricName": "tma_split_loads",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Instruction per taken branch",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / BR_INST_RETIRED.NEAR_TA=
KEN",
+        "MetricGroup": "Branches;Fed;FetchBW",
+        "MetricName": "tma_info_uptb",
+        "MetricThreshold": "tma_info_uptb < 6"
     },
     {
-        "BriefDescription": "This metric estimates how often memory load a=
ccesses were aliased by preceding stores (in program order) with a 4K addre=
ss offset",
-        "MetricExpr": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS / CPU_CLK_UNHALTED.=
THREAD",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
-        "MetricName": "tma_4k_aliasing",
-        "PublicDescription": "This metric estimates how often memory load =
accesses were aliased by preceding stores (in program order) with a 4K addr=
ess offset. False match is possible; which incur a few cycles load re-issue=
. However; the short re-issue duration is often hidden by the out-of-order =
core and HW optimizations; hence a user may safely ignore a high value of t=
his metric unless it manages to propagate up into parent nodes of the hiera=
rchy (e.g. to L1_Bound).",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
+        "MetricExpr": "(14 * ITLB_MISSES.STLB_HIT + cpu@ITLB_MISSES.WALK_D=
URATION\\,cmask\\=3D1@ + 7 * ITLB_MISSES.WALK_COMPLETED) / tma_info_clks",
+        "MetricGroup": "BigFoot;FetchLat;MemoryTLB;TopdownL3;tma_L3_group;=
tma_fetch_latency_group",
+        "MetricName": "tma_itlb_misses",
+        "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: ITLB_M=
ISSES.WALK_COMPLETED",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
-        "MetricExpr": "Load_Miss_Real_Latency * cpu@L1D_PEND_MISS.FB_FULL\=
\,cmask\\=3D0x1@ / CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "MemoryBW;TopdownL4;tma_L4_group;tma_l1_bound_group=
",
-        "MetricName": "tma_fb_full",
-        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory).",
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache",
+        "MetricExpr": "max((CYCLE_ACTIVITY.STALLS_MEM_ANY - CYCLE_ACTIVITY=
.STALLS_L1D_MISS) / tma_info_clks, 0)",
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
g the L1 cache. Sample with: MEM_LOAD_UOPS_RETIRED.L1_HIT_PS;MEM_LOAD_UOPS_=
RETIRED.HIT_LFB_PS. Related metrics: tma_clears_resteers, tma_machine_clear=
s, tma_microcode_sequencer, tma_ms_switches, tma_ports_utilized_1",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads",
-        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.ST=
ALLS_L2_MISS) / CPU_CLK_UNHALTED.THREAD",
+        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.ST=
ALLS_L2_MISS) / tma_info_clks",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
         "MetricName": "tma_l2_bound",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance.",
+        "MetricThreshold": "tma_l2_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_UOPS_RETIRED.L2_HIT_PS",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
-        "MetricExpr": "MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD_UOPS_RETIR=
ED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS) * CYCLE_ACTIVITY.STALLS_L2_M=
ISS / CPU_CLK_UNHALTED.THREAD",
+        "MetricConstraint": "NO_GROUP_EVENTS_SMT",
+        "MetricExpr": "MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD_UOPS_RETIR=
ED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS) * CYCLE_ACTIVITY.STALLS_L2_M=
ISS / tma_info_clks",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance.",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
-        "MetricExpr": "min((60 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HITM *=
 (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_L=
OAD_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_=
UOPS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + ME=
M_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMO=
TE_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS=
_RETIRED.REMOTE_FWD))) + 43 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS * (1 =
+ MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_=
UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS=
_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_LO=
AD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_D=
RAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS_RET=
IRED.REMOTE_FWD)))) / CPU_CLK_UNHALTED.THREAD, 1)",
-        "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_l3_bound_group",
-        "MetricName": "tma_contested_accesses",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing.",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
-        "MetricExpr": "min(43 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT * (=
1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOA=
D_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UO=
PS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_=
LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE=
_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS_R=
ETIRED.REMOTE_FWD))) / CPU_CLK_UNHALTED.THREAD, 1)",
-        "MetricGroup": "Offcore;Snoop;TopdownL4;tma_L4_group;tma_l3_bound_=
group",
-        "MetricName": "tma_data_sharing",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance.",
+        "MetricThreshold": "tma_l3_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT_PS",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited)",
-        "MetricExpr": "min(41 * (MEM_LOAD_UOPS_RETIRED.L3_HIT * (1 + MEM_L=
OAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UOPS_RE=
TIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_L3_HIT=
_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_LOAD_UOPS=
_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_DRAM + M=
EM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS_RETIRED.RE=
MOTE_FWD))) / CPU_CLK_UNHALTED.THREAD, 1)",
-        "MetricGroup": "MemoryLat;TopdownL4;tma_L4_group;tma_l3_bound_grou=
p",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "41 * (MEM_LOAD_UOPS_RETIRED.L3_HIT * (1 + MEM_LOAD_=
UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UOPS_RETIRE=
D.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_L3_HIT_RET=
IRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_LOAD_UOPS_L3_=
MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_DRAM + MEM_L=
OAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE=
_FWD))) / tma_info_clks",
+        "MetricGroup": "MemoryLat;TopdownL4;tma_L4_group;tma_issueLat;tma_=
l3_bound_group",
         "MetricName": "tma_l3_hit_latency",
-        "PublicDescription": "This metric represents fraction of cycles wi=
th demand load accesses that hit the L3 cache under unloaded scenarios (pos=
sibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L=
3 hits) will improve the latency; reduce contention with sibling physical c=
ores and increase performance.  Note the value of this node may overlap wit=
h its siblings.",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "This metric measures fraction of cycles where=
 the Super Queue (SQ) was full taking into account all request-types and bo=
th hardware SMT threads (Logical Processors)",
-        "MetricExpr": "(OFFCORE_REQUESTS_BUFFER.SQ_FULL / 2 if #SMT_on els=
e OFFCORE_REQUESTS_BUFFER.SQ_FULL) / CORE_CLKS",
-        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_l3_bou=
nd_group",
-        "MetricName": "tma_sq_full",
-        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). The Super Queue is used for =
requests to access the L2 cache or to go out to the Uncore.",
+        "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound > 0.0=
5 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric represents fraction of cycles wi=
th demand load accesses that hit the L3 cache under unloaded scenarios (pos=
sibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L=
3 hits) will improve the latency; reduce contention with sibling physical c=
ores and increase performance.  Note the value of this node may overlap wit=
h its siblings. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT_PS. Related metri=
cs: tma_mem_latency",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
-        "MetricExpr": "min((1 - MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD_U=
OPS_RETIRED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS)) * CYCLE_ACTIVITY.S=
TALLS_L2_MISS / CPU_CLK_UNHALTED.THREAD, 1)",
-        "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
-        "MetricName": "tma_dram_bound",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance.",
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
bandwidth, tma_info_dsb_coverage, tma_info_iptb",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory (DRAM)",
-        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D0x4@) / CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_dram_b=
ound_group",
-        "MetricName": "tma_mem_bandwidth",
-        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory (DRAM).  The underlying heuristic assumes that a simi=
lar off-core traffic is generated by all IA cores. This metric does not agg=
regate non-data-read requests by this logical processor; requests from othe=
r IA Logical Processors/Physical Cores/sockets; or other non-IA devices lik=
e GPU; hence the maximum external memory bandwidth limits may or may not be=
 approached when this metric is flagged (see Uncore counters for that).",
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
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles wher=
e the performance was likely hurt due to latency from external memory (DRAM=
)",
-        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DATA_RD) / CPU_CLK_UNHALTED.THREAD - tma_mem_bandwidth",
-        "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_dram_=
bound_group",
-        "MetricName": "tma_mem_latency",
-        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory (DRA=
M).  This metric does not aggregate requests from other Logical Processors/=
Physical Cores/sockets (see Uncore counters for that).",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Load operations",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
+        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_2 + UOPS_DISPATCHED_PORT=
.PORT_3 + UOPS_DISPATCHED_PORT.PORT_7 - UOPS_DISPATCHED_PORT.PORT_4) / (2 *=
 tma_info_core_clks)",
+        "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
+        "MetricName": "tma_load_op_utilization",
+        "MetricThreshold": "tma_load_op_utilization > 0.6",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port for Load operations. Sample with: =
UOPS_DISPATCHED.PORT_2_3",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from local memory",
-        "MetricExpr": "min(200 * (MEM_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM=
 * (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM=
_LOAD_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOA=
D_UOPS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + =
MEM_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.RE=
MOTE_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MI=
SS_RETIRED.REMOTE_FWD))) / CPU_CLK_UNHALTED.THREAD, 1)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "200 * (MEM_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM * (=
1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOA=
D_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UO=
PS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_=
LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE=
_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS_R=
ETIRED.REMOTE_FWD))) / tma_info_clks",
         "MetricGroup": "Server;TopdownL5;tma_L5_group;tma_mem_latency_grou=
p",
         "MetricName": "tma_local_dram",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from local memory. Caching will =
improve the latency and increase performance.",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote memory",
-        "MetricExpr": "min(310 * (MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_DRA=
M * (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + ME=
M_LOAD_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LO=
AD_UOPS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS +=
 MEM_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.R=
EMOTE_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_M=
ISS_RETIRED.REMOTE_FWD))) / CPU_CLK_UNHALTED.THREAD, 1)",
-        "MetricGroup": "Server;Snoop;TopdownL5;tma_L5_group;tma_mem_latenc=
y_group",
-        "MetricName": "tma_remote_dram",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote memory. This is caus=
ed often due to non-optimal NUMA allocations. #link to NUMA article",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote cache in other socket=
s including synchronizations issues",
-        "MetricExpr": "min((200 * (MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HI=
TM * (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + M=
EM_LOAD_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_L=
OAD_UOPS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS =
+ MEM_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.=
REMOTE_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_=
MISS_RETIRED.REMOTE_FWD))) + 180 * (MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_FW=
D * (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + ME=
M_LOAD_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LO=
AD_UOPS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS +=
 MEM_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.R=
EMOTE_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_M=
ISS_RETIRED.REMOTE_FWD)))) / CPU_CLK_UNHALTED.THREAD, 1)",
-        "MetricGroup": "Offcore;Server;Snoop;TopdownL5;tma_L5_group;tma_me=
m_latency_group",
-        "MetricName": "tma_remote_cache",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote cache in other socke=
ts including synchronizations issues. This is caused often due to non-optim=
al NUMA allocations. #link to NUMA article",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to RFO store memory accesses; RFO store issue a read-for-ownership =
request before the write",
-        "MetricExpr": "RESOURCE_STALLS.SB / CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
-        "MetricName": "tma_store_bound",
-        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to RFO store memory accesses; RFO store issue a read-for-ownership=
 request before the write. Even though store accesses do not typically stal=
l out-of-order CPUs; there are few cases where stores can lead to actual st=
alls. This metric will be flagged should RFO stores be a bottleneck.",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
-        "MetricExpr": "(L2_RQSTS.RFO_HIT * 9 * (1 - MEM_UOPS_RETIRED.LOCK_=
LOADS / MEM_UOPS_RETIRED.ALL_STORES) + (1 - MEM_UOPS_RETIRED.LOCK_LOADS / M=
EM_UOPS_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS=
_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_store=
_bound_group",
-        "MetricName": "tma_store_latency",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full)",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
-        "MetricExpr": "min((200 * OFFCORE_RESPONSE.DEMAND_RFO.LLC_MISS.REM=
OTE_HITM + 60 * OFFCORE_RESPONSE.DEMAND_RFO.LLC_HIT.HITM_OTHER_CORE) / CPU_=
CLK_UNHALTED.THREAD, 1)",
-        "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_store_bound_group",
-        "MetricName": "tma_false_sharing",
-        "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line. ",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "This metric represents rate of split store ac=
cesses",
-        "MetricExpr": "2 * MEM_UOPS_RETIRED.SPLIT_STORES / CORE_CLKS",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_store_bound_group",
-        "MetricName": "tma_split_stores",
-        "PublicDescription": "This metric represents rate of split store a=
ccesses.  Consider aligning your data to the 64-byte cache line granularity=
.",
+        "MetricThreshold": "tma_local_dram > 0.1 & (tma_mem_latency > 0.1 =
& (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2=
)))",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from local memory. Caching will =
improve the latency and increase performance. Sample with: MEM_LOAD_UOPS_L3=
_MISS_RETIRED.LOCAL_DRAM_PS",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
-        "MetricExpr": "min((8 * DTLB_STORE_MISSES.STLB_HIT + cpu@DTLB_STOR=
E_MISSES.WALK_DURATION\\,cmask\\=3D0x1@ + 7 * DTLB_STORE_MISSES.WALK_COMPLE=
TED) / CPU_CLK_UNHALTED.THREAD, 1)",
-        "MetricGroup": "MemoryTLB;TopdownL4;tma_L4_group;tma_store_bound_g=
roup",
-        "MetricName": "tma_dtlb_store",
-        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data.",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "MEM_UOPS_RETIRED.LOCK_LOADS / MEM_UOPS_RETIRED.ALL_=
STORES * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTANDING.CYCLES_W=
ITH_DEMAND_RFO) / tma_info_clks",
+        "MetricGroup": "Offcore;TopdownL4;tma_L4_group;tma_issueRFO;tma_l1=
_bound_group",
+        "MetricName": "tma_lock_latency",
+        "MetricThreshold": "tma_lock_latency > 0.2 & (tma_l1_bound > 0.1 &=
 (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them. Sample with: MEM_UOPS_RETIRED.LOCK_LOA=
DS_PS. Related metrics: tma_store_latency",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e Core non-memory issues were of a bottleneck",
-        "MetricExpr": "tma_backend_bound - tma_memory_bound",
-        "MetricGroup": "Backend;Compute;TopdownL2;tma_L2_group;tma_L2_grou=
p;tma_backend_bound_group",
-        "MetricName": "tma_core_bound",
-        "PublicDescription": "This metric represents fraction of slots whe=
re Core non-memory issues were of a bottleneck.  Shortage in hardware compu=
te resources; or dependencies in software's instructions are both categoriz=
ed under Core Bound. Hence it may indicate the machine ran out of an out-of=
-order resource; certain execution units are overloaded or dependencies in =
program's data- or instruction-flow are limiting the performance (e.g. FP-c=
hained long-latency arithmetic operations).",
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
tma_clears_resteers, tma_contested_accesses, tma_data_sharing, tma_false_sh=
aring, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_remote_c=
ache",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles whe=
re the Divider unit was active",
-        "MetricExpr": "ARITH.FPU_DIV_ACTIVE / CORE_CLKS",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_core_bound_group",
-        "MetricName": "tma_divider",
-        "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication.",
+        "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory (DRAM)",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_clks",
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
ated metrics: tma_fb_full, tma_info_dram_bw_use, tma_sq_full",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
-        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_TOTAL + UOPS_EXECUTED.CYCLES=
_GE_1_UOP_EXEC - (UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC if INST_RETIRED.ANY /=
 CPU_CLK_UNHALTED.THREAD > 1.8 else UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC) - =
(RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else 0) + RESOURCE_STALL=
S.SB - RESOURCE_STALLS.SB - CYCLE_ACTIVITY.STALLS_MEM_ANY) / CPU_CLK_UNHALT=
ED.THREAD",
-        "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
-        "MetricName": "tma_ports_utilization",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations.",
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
_l3_hit_latency",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
-        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,inv\\=3D0x1\\,cmask\\=3D0=
x1@ / 2 if #SMT_on else CYCLE_ACTIVITY.STALLS_TOTAL - (RS_EVENTS.EMPTY_CYCL=
ES if tma_fetch_latency > 0.1 else 0)) / CORE_CLKS",
-        "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
-        "MetricName": "tma_ports_utilized_0",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U executed no uops on any execution port (Logical Processor cycles since IC=
L, Physical Core cycles otherwise). Long-latency instructions like divides =
may contribute to this metric.",
+        "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_MEM_ANY + RESOURCE_STALLS.SB=
) / (CYCLE_ACTIVITY.STALLS_TOTAL + UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC - (UO=
PS_EXECUTED.CYCLES_GE_3_UOPS_EXEC if tma_info_ipc > 1.8 else UOPS_EXECUTED.=
CYCLES_GE_2_UOPS_EXEC) - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1=
 else 0) + RESOURCE_STALLS.SB) * tma_backend_bound",
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
-        "BriefDescription": "This metric represents fraction of cycles whe=
re the CPU executed total of 1 uop per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x1@ - cpu@UOP=
S_EXECUTED.CORE\\,cmask\\=3D0x2@) / 2 if #SMT_on else UOPS_EXECUTED.CYCLES_=
GE_1_UOP_EXEC - UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC) / CORE_CLKS",
-        "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
-        "MetricName": "tma_ports_utilized_1",
-        "PublicDescription": "This metric represents fraction of cycles wh=
ere the CPU executed total of 1 uop per cycle on all execution ports (Logic=
al Processor cycles since ICL, Physical Core cycles otherwise). This can be=
 due to heavy data-dependency among software instructions; or over oversubs=
cribing a particular hardware resource. In some other cases with high 1_Por=
t_Utilized and L1_Bound; this metric can point to L1 data-cache latency bot=
tleneck that may not necessarily manifest with complete execution starvatio=
n (due to the short L1 latency e.g. walking a linked list) - looking at the=
 assembly can be helpful.",
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
-        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 2 uops per cycle on all execution ports (Logical Process=
or cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x2@ - cpu@UOP=
S_EXECUTED.CORE\\,cmask\\=3D0x3@) / 2 if #SMT_on else UOPS_EXECUTED.CYCLES_=
GE_2_UOPS_EXEC - UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / CORE_CLKS",
-        "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
-        "MetricName": "tma_ports_utilized_2",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop.",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Branch Misprediction=
 at execution stage",
+        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES * tma_branch_resteers =
/ (BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + BACLEARS.ANY)",
+        "MetricGroup": "BadSpec;BrMispredicts;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group;tma_issueBM",
+        "MetricName": "tma_mispredicts_resteers",
+        "MetricThreshold": "tma_mispredicts_resteers > 0.05 & (tma_branch_=
resteers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage. Related metrics: tma_branch_mispredicts, tma_info_bra=
nch_misprediction_cost",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise).",
-        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x3@ / 2 if #SM=
T_on else UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / CORE_CLKS",
-        "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
-        "MetricName": "tma_ports_utilized_3m",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the MITE pipeline (the legacy deco=
de pipeline)",
+        "MetricExpr": "(IDQ.ALL_MITE_CYCLES_ANY_UOPS - IDQ.ALL_MITE_CYCLES=
_4_UOPS) / tma_info_core_clks / 2",
+        "MetricGroup": "DSBmiss;FetchBW;TopdownL3;tma_L3_group;tma_fetch_b=
andwidth_group",
+        "MetricName": "tma_mite",
+        "MetricThreshold": "tma_mite > 0.1 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_ipc / 4 > 0.35)",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to the MITE pipeline (the legacy dec=
ode pipeline). This pipeline is used for code that was not pre-cached in th=
e DSB or LSD. For example; inefficiencies due to asymmetric decoders; use o=
f long immediate or LCP can manifest as MITE fetch bandwidth bottleneck.",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
-        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_0 + UOPS_DISPATCHED_PORT=
.PORT_1 + UOPS_DISPATCHED_PORT.PORT_5 + UOPS_DISPATCHED_PORT.PORT_6) / SLOT=
S",
-        "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
-        "MetricName": "tma_alu_op_utilization",
+        "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS)",
+        "MetricExpr": "2 * IDQ.MS_SWITCHES / tma_info_clks",
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
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd b=
ranch)",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_0 / CORE_CLKS",
-        "MetricGroup": "Compute;TopdownL6;tma_L6_group;tma_alu_op_utilizat=
ion_group",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_0 / tma_info_core_clks",
+        "MetricGroup": "Compute;TopdownL6;tma_L6_group;tma_alu_op_utilizat=
ion_group;tma_issue2P",
         "MetricName": "tma_port_0",
+        "MetricThreshold": "tma_port_0 > 0.6",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd =
branch). Sample with: UOPS_DISPATCHED_PORT.PORT_0. Related metrics: tma_fp_=
scalar, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vecto=
r_512b, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 1 (ALU)",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_1 / CORE_CLKS",
-        "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_1 / tma_info_core_clks",
+        "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_1",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 5 ([SNB+] Branches and ALU; [HSW+] =
ALU)",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_5 / CORE_CLKS",
-        "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p",
-        "MetricName": "tma_port_5",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 6 ([HSW+]Primary Branch and simple =
ALU)",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_6 / CORE_CLKS",
-        "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p",
-        "MetricName": "tma_port_6",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Load operations",
-        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_2 + UOPS_DISPATCHED_PORT=
.PORT_3 + UOPS_DISPATCHED_PORT.PORT_7 - UOPS_DISPATCHED_PORT.PORT_4) / (2 *=
 CORE_CLKS)",
-        "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
-        "MetricName": "tma_load_op_utilization",
+        "MetricThreshold": "tma_port_1 > 0.6",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 1 (ALU). Sample with: UOPS_DISPATC=
HED_PORT.PORT_1. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vect=
or_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_port_0, tma_port_5, tm=
a_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 2 ([SNB+]Loads and Store-address; [=
ICL+] Loads)",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_2 / CORE_CLKS",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_2 / tma_info_core_clks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_load_op_utilization_gro=
up",
         "MetricName": "tma_port_2",
+        "MetricThreshold": "tma_port_2 > 0.6",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 2 ([SNB+]Loads and Store-address; =
[ICL+] Loads). Sample with: UOPS_DISPATCHED_PORT.PORT_2",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 3 ([SNB+]Loads and Store-address; [=
ICL+] Loads)",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_3 / CORE_CLKS",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_3 / tma_info_core_clks",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_load_op_utilization_gro=
up",
         "MetricName": "tma_port_3",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Store operations",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_4 / CORE_CLKS",
-        "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
-        "MetricName": "tma_store_op_utilization",
+        "MetricThreshold": "tma_port_3 > 0.6",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 3 ([SNB+]Loads and Store-address; =
[ICL+] Loads). Sample with: UOPS_DISPATCHED_PORT.PORT_3",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 4 (Store-data)",
         "MetricExpr": "tma_store_op_utilization",
-        "MetricGroup": "TopdownL6;tma_L6_group;tma_store_op_utilization_gr=
oup",
+        "MetricGroup": "TopdownL6;tma_L6_group;tma_issueSpSt;tma_store_op_=
utilization_group",
         "MetricName": "tma_port_4",
+        "MetricThreshold": "tma_port_4 > 0.6",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 4 (Store-data). Sample with: UOPS_=
DISPATCHED_PORT.PORT_4. Related metrics: tma_split_stores",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 7 ([HSW+]simple Store-address)",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_7 / CORE_CLKS",
-        "MetricGroup": "TopdownL6;tma_L6_group;tma_store_op_utilization_gr=
oup",
-        "MetricName": "tma_port_7",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 5 ([SNB+] Branches and ALU; [HSW+] =
ALU)",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_5 / tma_info_core_clks",
+        "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
+        "MetricName": "tma_port_5",
+        "MetricThreshold": "tma_port_5 > 0.6",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 5 ([SNB+] Branches and ALU; [HSW+]=
 ALU). Sample with: UOPS_DISPATCHED.PORT_5. Related metrics: tma_fp_scalar,=
 tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b,=
 tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / SLOTS",
-        "MetricGroup": "TopdownL1;tma_L1_group;tma_L1_group",
-        "MetricName": "tma_retiring",
-        "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided. ",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 6 ([HSW+]Primary Branch and simple =
ALU)",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_6 / tma_info_core_clks",
+        "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
+        "MetricName": "tma_port_6",
+        "MetricThreshold": "tma_port_6 > 0.6",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 6 ([HSW+]Primary Branch and simple=
 ALU). Sample with: UOPS_DISPATCHED_PORT.PORT_6. Related metrics: tma_fp_sc=
alar, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_=
512b, tma_port_0, tma_port_1, tma_port_5, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations -- instructions that require=
 no more than one uop (micro-operation)",
-        "MetricExpr": "tma_retiring - UOPS_RETIRED.RETIRE_SLOTS / UOPS_ISS=
UED.ANY * IDQ.MS_UOPS / SLOTS",
-        "MetricGroup": "Retire;TopdownL2;tma_L2_group;tma_L2_group;tma_ret=
iring_group",
-        "MetricName": "tma_light_operations",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring light-weight operations -- instructions that requir=
e no more than one uop (micro-operation). This correlates with total number=
 of instructions used by the program. A uops-per-instruction (see UPI metri=
c) ratio of 1 or less should be expected for decently optimized software ru=
nning on Intel Core/Xeon products. While this often indicates efficient X86=
 instructions were executed; high value does not necessarily mean better pe=
rformance cannot be achieved.",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 7 ([HSW+]simple Store-address)",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_7 / tma_info_core_clks",
+        "MetricGroup": "TopdownL6;tma_L6_group;tma_store_op_utilization_gr=
oup",
+        "MetricName": "tma_port_7",
+        "MetricThreshold": "tma_port_7 > 0.6",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 7 ([HSW+]simple Store-address). Sa=
mple with: UOPS_DISPATCHED_PORT.PORT_7",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents overall arithmetic flo=
ating-point (FP) operations fraction the CPU has executed (retired)",
-        "MetricExpr": "INST_RETIRED.X87 * UPI / UOPS_RETIRED.RETIRE_SLOTS =
+ tma_fp_scalar + tma_fp_vector",
-        "MetricGroup": "HPC;TopdownL3;tma_L3_group;tma_light_operations_gr=
oup",
-        "MetricName": "tma_fp_arith",
-        "PublicDescription": "This metric represents overall arithmetic fl=
oating-point (FP) operations fraction the CPU has executed (retired). Note =
this metric's value may exceed its parent due to use of \"Uops\" CountDomai=
n and FMA double-counting.",
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_TOTAL + UOPS_EXECUTED.CYCLES=
_GE_1_UOP_EXEC - (UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC if tma_info_ipc > 1.8=
 else UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC) - (RS_EVENTS.EMPTY_CYCLES if tma=
_fetch_latency > 0.1 else 0) + RESOURCE_STALLS.SB - RESOURCE_STALLS.SB - CY=
CLE_ACTIVITY.STALLS_MEM_ANY) / tma_info_clks",
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
-        "BriefDescription": "This metric serves as an approximation of leg=
acy x87 usage",
-        "MetricExpr": "INST_RETIRED.X87 * UPI / UOPS_RETIRED.RETIRE_SLOTS"=
,
-        "MetricGroup": "Compute;TopdownL4;tma_L4_group;tma_fp_arith_group"=
,
-        "MetricName": "tma_x87_use",
-        "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint.",
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
+        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,inv\\,cmask\\=3D1@ / 2 if=
 #SMT_on else (CYCLE_ACTIVITY.STALLS_TOTAL - (RS_EVENTS.EMPTY_CYCLES if tma=
_fetch_latency > 0.1 else 0)) / tma_info_core_clks)",
+        "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
+        "MetricName": "tma_ports_utilized_0",
+        "MetricThreshold": "tma_ports_utilized_0 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed no uops on any execution port (Logical Processor cycles since IC=
L, Physical Core cycles otherwise). Long-latency instructions like divides =
may contribute to this metric.",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) scalar uops fraction the CPU has retired",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE) / UOPS_RETIRED.RETIRE_SLOTS",
-        "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group",
-        "MetricName": "tma_fp_scalar",
-        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting.",
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the CPU executed total of 1 uop per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise)",
+        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D2@) / 2 if #SMT_on else (UOPS_EXECUTED.CYCLES_GE_=
1_UOP_EXEC - UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC) / tma_info_core_clks)",
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
 assembly can be helpful. Related metrics: tma_l1_bound",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) vector uops fraction the CPU has retired aggregated across all v=
ector widths",
-        "MetricExpr": "min((FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_=
ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_D=
OUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) / UOPS_RETIRED.RETIRE_SLO=
TS, 1)",
-        "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group",
-        "MetricName": "tma_fp_vector",
-        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting.",
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 2 uops per cycle on all execution ports (Logical Process=
or cycles since ICL, Physical Core cycles otherwise)",
+        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D3@) / 2 if #SMT_on else (UOPS_EXECUTED.CYCLES_GE_=
2_UOPS_EXEC - UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / tma_info_core_clks)",
+        "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issue2P;tma_p=
orts_utilization_group",
+        "MetricName": "tma_ports_utilized_2",
+        "MetricThreshold": "tma_ports_utilized_2 > 0.15 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop. R=
elated metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_128b, tma_fp_ve=
ctor_256b, tma_fp_vector_512b, tma_port_0, tma_port_1, tma_port_5, tma_port=
_6",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 128-bit wide vectors",
-        "MetricExpr": "min((FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_=
ARITH_INST_RETIRED.128B_PACKED_SINGLE) / UOPS_RETIRED.RETIRE_SLOTS, 1)",
-        "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group",
-        "MetricName": "tma_fp_vector_128b",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting.",
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise).",
+        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ / 2 if #SMT_=
on else UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / tma_info_core_clks",
+        "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
+        "MetricName": "tma_ports_utilized_3m",
+        "MetricThreshold": "tma_ports_utilized_3m > 0.7 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 256-bit wide vectors",
-        "MetricExpr": "min((FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_=
ARITH_INST_RETIRED.256B_PACKED_SINGLE) / UOPS_RETIRED.RETIRE_SLOTS, 1)",
-        "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group",
-        "MetricName": "tma_fp_vector_256b",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting.",
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote cache in other socket=
s including synchronizations issues",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(200 * (MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM *=
 (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_L=
OAD_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_=
UOPS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + ME=
M_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMO=
TE_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS=
_RETIRED.REMOTE_FWD))) + 180 * (MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_FWD * =
(1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LO=
AD_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_U=
OPS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM=
_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOT=
E_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS_=
RETIRED.REMOTE_FWD)))) / tma_info_clks",
+        "MetricGroup": "Offcore;Server;Snoop;TopdownL5;tma_L5_group;tma_is=
sueSyncxn;tma_mem_latency_group",
+        "MetricName": "tma_remote_cache",
+        "MetricThreshold": "tma_remote_cache > 0.05 & (tma_mem_latency > 0=
.1 & (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > =
0.2)))",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote cache in other socke=
ts including synchronizations issues. This is caused often due to non-optim=
al NUMA allocations. #link to NUMA article. Sample with: MEM_LOAD_UOPS_L3_M=
ISS_RETIRED.REMOTE_HITM_PS;MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_FWD_PS. Rel=
ated metrics: tma_contested_accesses, tma_data_sharing, tma_false_sharing, =
tma_machine_clears",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or microcoded sequences",
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / UOPS_ISSUED.ANY * IDQ.M=
S_UOPS / SLOTS",
-        "MetricGroup": "Retire;TopdownL2;tma_L2_group;tma_L2_group;tma_ret=
iring_group",
-        "MetricName": "tma_heavy_operations",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or microcoded sequences. This highly-correlates with the=
 uop length of these instructions/sequences.",
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote memory",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "310 * (MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_DRAM * =
(1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LO=
AD_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_U=
OPS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM=
_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOT=
E_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS_=
RETIRED.REMOTE_FWD))) / tma_info_clks",
+        "MetricGroup": "Server;Snoop;TopdownL5;tma_L5_group;tma_mem_latenc=
y_group",
+        "MetricName": "tma_remote_dram",
+        "MetricThreshold": "tma_remote_dram > 0.1 & (tma_mem_latency > 0.1=
 & (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.=
2)))",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote memory. This is caus=
ed often due to non-optimal NUMA allocations. #link to NUMA article. Sample=
 with: MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_DRAM_PS",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU was retiring uops fetched by the Microcode Sequencer (MS) unit",
-        "MetricExpr": "tma_heavy_operations",
-        "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_heavy_operatio=
ns_group",
-        "MetricName": "tma_microcode_sequencer",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The M=
S is used for CISC instructions not supported by the default decoders (like=
 repeat move strings; or CPUID); or by microcode assists used to address so=
me operation modes (like in Floating Point assists). These cases can often =
be avoided.",
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
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops delivered by the Microcode_Sequencer as a result of Assists=
",
-        "MetricExpr": "min(100 * OTHER_ASSISTS.ANY_WB_ASSIST / SLOTS, 1)",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
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
rmance and they can be avoided in many cases.",
+        "BriefDescription": "This metric estimates fraction of cycles hand=
ling memory load split accesses - load that cross 64-byte cache line bounda=
ry",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "tma_info_load_miss_real_latency * LD_BLOCKS.NO_SR /=
 tma_info_clks",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
+        "MetricName": "tma_split_loads",
+        "MetricThreshold": "tma_split_loads > 0.2 & (tma_l1_bound > 0.1 & =
(tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric estimates fraction of cycles han=
dling memory load split accesses - load that cross 64-byte cache line bound=
ary. Sample with: MEM_UOPS_RETIRED.SPLIT_LOADS_PS",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles the =
CPU retired uops originated from CISC (complex instruction set computer) in=
struction",
-        "MetricExpr": "max(0, tma_heavy_operations - tma_assists)",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
-        "MetricName": "tma_cisc",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU retired uops originated from CISC (complex instruction set computer) i=
nstruction. A CISC instruction has multiple uops that are required to perfo=
rm the instruction's functionality as in the case of read-modify-write as a=
n example. Since these instructions require multiple uops they may or may n=
ot imply sub-optimal use of machine resources.",
+        "BriefDescription": "This metric represents rate of split store ac=
cesses",
+        "MetricExpr": "2 * MEM_UOPS_RETIRED.SPLIT_STORES / tma_info_core_c=
lks",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_issueSpSt;tma_store_bou=
nd_group",
+        "MetricName": "tma_split_stores",
+        "MetricThreshold": "tma_split_stores > 0.2 & (tma_store_bound > 0.=
2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric represents rate of split store a=
ccesses.  Consider aligning your data to the 64-byte cache line granularity=
. Sample with: MEM_UOPS_RETIRED.SPLIT_STORES_PS. Related metrics: tma_port_=
4",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C3 residency percent per core",
-        "MetricExpr": "cstate_core@c3\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C3_Core_Residency",
+        "BriefDescription": "This metric measures fraction of cycles where=
 the Super Queue (SQ) was full taking into account all request-types and bo=
th hardware SMT threads (Logical Processors)",
+        "MetricExpr": "(OFFCORE_REQUESTS_BUFFER.SQ_FULL / 2 if #SMT_on els=
e OFFCORE_REQUESTS_BUFFER.SQ_FULL) / tma_info_core_clks",
+        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_issueB=
W;tma_l3_bound_group",
+        "MetricName": "tma_sq_full",
+        "MetricThreshold": "tma_sq_full > 0.3 & (tma_l3_bound > 0.05 & (tm=
a_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_fb_full=
, tma_info_dram_bw_use, tma_mem_bandwidth",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C6 residency percent per core",
-        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C6_Core_Residency",
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
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C7 residency percent per core",
-        "MetricExpr": "cstate_core@c7\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C7_Core_Residency",
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
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C2 residency percent per package",
-        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C2_Pkg_Residency",
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(L2_RQSTS.RFO_HIT * 9 * (1 - MEM_UOPS_RETIRED.LOCK_=
LOADS / MEM_UOPS_RETIRED.ALL_STORES) + (1 - MEM_UOPS_RETIRED.LOCK_LOADS / M=
EM_UOPS_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS=
_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / tma_info_clks",
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
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C3 residency percent per package",
-        "MetricExpr": "cstate_pkg@c3\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C3_Pkg_Residency",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Store operations",
+        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_4 / tma_info_core_clks",
+        "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
+        "MetricName": "tma_store_op_utilization",
+        "MetricThreshold": "tma_store_op_utilization > 0.6",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C6 residency percent per package",
-        "MetricExpr": "cstate_pkg@c6\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C6_Pkg_Residency",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to new branch address clears",
+        "MetricExpr": "tma_branch_resteers - tma_mispredicts_resteers - tm=
a_clears_resteers",
+        "MetricGroup": "BigFoot;FetchLat;TopdownL4;tma_L4_group;tma_branch=
_resteers_group",
+        "MetricName": "tma_unknown_branches",
+        "MetricThreshold": "tma_unknown_branches > 0.05 & (tma_branch_rest=
eers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to new branch address clears. These are fetched branc=
hes the Branch Prediction Unit was unable to recognize (e.g. first time the=
 branch is fetched or hitting BTB capacity limit). Sample with: BACLEARS.AN=
Y",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C7 residency percent per package",
-        "MetricExpr": "cstate_pkg@c7\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C7_Pkg_Residency",
+        "BriefDescription": "This metric serves as an approximation of leg=
acy x87 usage",
+        "MetricExpr": "INST_RETIRED.X87 * tma_info_uoppi / UOPS_RETIRED.RE=
TIRE_SLOTS",
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
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json b/=
tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
index 38eaac5afd4b..746954775437 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
@@ -5,7 +5,7 @@
         "EventName": "LLC_MISSES.CODE_LLC_PREFETCH",
         "Filter": "filter_opc=3D0x191",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -16,7 +16,7 @@
         "EventName": "LLC_MISSES.DATA_LLC_PREFETCH",
         "Filter": "filter_opc=3D0x192",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -27,7 +27,7 @@
         "EventName": "LLC_MISSES.DATA_READ",
         "Filter": "filter_opc=3D0x182",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -38,7 +38,7 @@
         "EventName": "LLC_MISSES.MMIO_READ",
         "Filter": "filter_opc=3D0x187,filter_nc=3D1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -49,7 +49,7 @@
         "EventName": "LLC_MISSES.MMIO_WRITE",
         "Filter": "filter_opc=3D0x18f,filter_nc=3D1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -60,7 +60,7 @@
         "EventName": "LLC_MISSES.PCIE_NON_SNOOP_WRITE",
         "Filter": "filter_opc=3D0x1c8,filter_tid=3D0x3e",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -71,7 +71,7 @@
         "EventName": "LLC_MISSES.PCIE_READ",
         "Filter": "filter_opc=3D0x19e",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -82,7 +82,7 @@
         "EventName": "LLC_MISSES.PCIE_WRITE",
         "Filter": "filter_opc=3D0x1c8",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -93,7 +93,7 @@
         "EventName": "LLC_MISSES.RFO_LLC_PREFETCH",
         "Filter": "filter_opc=3D0x190",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -104,7 +104,7 @@
         "EventName": "LLC_MISSES.UNCACHEABLE",
         "Filter": "filter_opc=3D0x187",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -115,7 +115,7 @@
         "EventName": "LLC_REFERENCES.CODE_LLC_PREFETCH",
         "Filter": "filter_opc=3D0x181",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted int=
o the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -126,7 +126,7 @@
         "EventName": "LLC_REFERENCES.PCIE_NS_PARTIAL_WRITE",
         "Filter": "filter_opc=3D0x180,filter_tid=3D0x3e",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted int=
o the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
         "UMask": "0x1",
         "Unit": "CBO"
     },
@@ -136,7 +136,7 @@
         "EventName": "LLC_REFERENCES.PCIE_READ",
         "Filter": "filter_opc=3D0x19e",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted int=
o the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -147,7 +147,7 @@
         "EventName": "LLC_REFERENCES.PCIE_WRITE",
         "Filter": "filter_opc=3D0x1c8,filter_tid=3D0x3e",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted int=
o the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -158,7 +158,7 @@
         "EventName": "LLC_REFERENCES.STREAMING_FULL",
         "Filter": "filter_opc=3D0x18c",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted int=
o the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -169,7 +169,7 @@
         "EventName": "LLC_REFERENCES.STREAMING_PARTIAL",
         "Filter": "filter_opc=3D0x18d",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted int=
o the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -1157,7 +1157,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.ALL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserte=
d into the TOR.    This includes requests that reside in the TOR for a shor=
t time, such as LLC Hits that do not need to snoop cores or requests that g=
et rejected and have to be retried through one of the ingress queues.  The =
TOR is more commonly a bottleneck in skews with smaller core counts, where =
the ratio of RTIDs to TOR entries is larger.  Note that there are reserved =
TOR entries for various request types, so it is possible that a given reque=
st type be blocked with an occupancy that is less than 20.  Also note that =
generally requests will not be able to arbitrate into the TOR pipeline if t=
here are no available TOR slots.",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserted=
 into the TOR.    This includes requests that reside in the TOR for a short=
 time, such as LLC Hits that do not need to snoop cores or requests that ge=
t rejected and have to be retried through one of the ingress queues.  The T=
OR is more commonly a bottleneck in skews with smaller core counts, where t=
he ratio of RTIDs to TOR entries is larger.  Note that there are reserved T=
OR entries for various request types, so it is possible that a given reques=
t type be blocked with an occupancy that is less than 20.  Also note that g=
enerally requests will not be able to arbitrate into the TOR pipeline if th=
ere are no available TOR slots.",
         "UMask": "0x8",
         "Unit": "CBO"
     },
@@ -1166,7 +1166,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.EVICTION",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Eviction transactions in=
serted into the TOR.  Evictions can be quick, such as when the line is in t=
he F, S, or E states and no core valid bits are set.  They can also be long=
er if either CV bits are set (so the cores need to be snooped) and/or if th=
ere is a HitM (in which case it is necessary to write the request out to me=
mory).",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Eviction transactions ins=
erted into the TOR.  Evictions can be quick, such as when the line is in th=
e F, S, or E states and no core valid bits are set.  They can also be longe=
r if either CV bits are set (so the cores need to be snooped) and/or if the=
re is a HitM (in which case it is necessary to write the request out to mem=
ory).",
         "UMask": "0x4",
         "Unit": "CBO"
     },
@@ -1175,7 +1175,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.LOCAL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserte=
d into the TOR that are satisifed by locally HOMed memory.",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserted=
 into the TOR that are satisifed by locally HOMed memory.",
         "UMask": "0x28",
         "Unit": "CBO"
     },
@@ -1184,7 +1184,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.LOCAL_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisi=
fed by an opcode,  inserted into the TOR that are satisifed by locally HOMe=
d memory.",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisif=
ed by an opcode,  inserted into the TOR that are satisifed by locally HOMed=
 memory.",
         "UMask": "0x21",
         "Unit": "CBO"
     },
@@ -1193,7 +1193,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_LOCAL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that are satisifed by locally HOMed memory.",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that are satisifed by locally HOMed memory.",
         "UMask": "0x2a",
         "Unit": "CBO"
     },
@@ -1202,7 +1202,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satis=
ifed by an opcode, inserted into the TOR that are satisifed by locally HOMe=
d memory.",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satisi=
fed by an opcode, inserted into the TOR that are satisifed by locally HOMed=
 memory.",
         "UMask": "0x23",
         "Unit": "CBO"
     },
@@ -1211,7 +1211,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match an opcode.",
         "UMask": "0x3",
         "Unit": "CBO"
     },
@@ -1220,7 +1220,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_REMOTE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that are satisifed by remote caches or remote memory.",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that are satisifed by remote caches or remote memory.",
         "UMask": "0x8a",
         "Unit": "CBO"
     },
@@ -1229,7 +1229,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satis=
ifed by an opcode,  inserted into the TOR that are satisifed by remote cach=
es or remote memory.",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satisi=
fed by an opcode,  inserted into the TOR that are satisifed by remote cache=
s or remote memory.",
         "UMask": "0x83",
         "Unit": "CBO"
     },
@@ -1238,7 +1238,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_ALL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched (matches=
 an RTID destination) transactions inserted into the TOR.  The NID is progr=
ammed in Cn_MSR_PMON_BOX_FILTER.nid.  In conjunction with STATE =3D I, it i=
s possible to monitor misses to specific NIDs in the system.",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched (matches =
an RTID destination) transactions inserted into the TOR.  The NID is progra=
mmed in Cn_MSR_PMON_BOX_FILTER.nid.  In conjunction with STATE =3D I, it is=
 possible to monitor misses to specific NIDs in the system.",
         "UMask": "0x48",
         "Unit": "CBO"
     },
@@ -1247,7 +1247,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_EVICTION",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched eviction tra=
nsactions inserted into the TOR.",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched eviction tran=
sactions inserted into the TOR.",
         "UMask": "0x44",
         "Unit": "CBO"
     },
@@ -1256,7 +1256,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_MISS_ALL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched miss req=
uests that were inserted into the TOR.",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched miss requ=
ests that were inserted into the TOR.",
         "UMask": "0x4a",
         "Unit": "CBO"
     },
@@ -1265,7 +1265,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_MISS_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match a NID and an opcode.",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match a NID and an opcode.",
         "UMask": "0x43",
         "Unit": "CBO"
     },
@@ -1274,7 +1274,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match a NID and an opcode.",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted int=
o the TOR that match a NID and an opcode.",
         "UMask": "0x41",
         "Unit": "CBO"
     },
@@ -1283,7 +1283,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_WB",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched write transa=
ctions inserted into the TOR.",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched write transac=
tions inserted into the TOR.",
         "UMask": "0x50",
         "Unit": "CBO"
     },
@@ -1292,7 +1292,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted int=
o the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
         "UMask": "0x1",
         "Unit": "CBO"
     },
@@ -1301,7 +1301,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.REMOTE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserte=
d into the TOR that are satisifed by remote caches or remote memory.",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserted=
 into the TOR that are satisifed by remote caches or remote memory.",
         "UMask": "0x88",
         "Unit": "CBO"
     },
@@ -1310,7 +1310,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.REMOTE_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisi=
fed by an opcode,  inserted into the TOR that are satisifed by remote cache=
s or remote memory.",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisif=
ed by an opcode,  inserted into the TOR that are satisifed by remote caches=
 or remote memory.",
         "UMask": "0x81",
         "Unit": "CBO"
     },
@@ -1319,7 +1319,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.WB",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Write transactions inser=
ted into the TOR.   This does not include RFO, but actual operations that c=
ontain data being sent from the core.",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Write transactions insert=
ed into the TOR.   This does not include RFO, but actual operations that co=
ntain data being sent from the core.",
         "UMask": "0x10",
         "Unit": "CBO"
     },
@@ -1590,7 +1590,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_C_TxR_INSERTS.BL_CORE",
         "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Corebo destined for the BL ring.  This is commonly used for=
 transferring writeback data to the cache.",
+        "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Corebo destined for the BL ring.  This is commonly used for=
 transfering writeback data to the cache.",
         "UMask": "0x40",
         "Unit": "CBO"
     },
@@ -1737,7 +1737,7 @@
         "EventCode": "0x41",
         "EventName": "UNC_H_DIRECTORY_LAT_OPT",
         "PerPkg": "1",
-        "PublicDescription": "Directory Latency Optimization Data Return P=
ath Taken. When directory mode is enabled and the directory returned for a =
read is Dir=3DI, then data can be returned using a faster path if certain c=
onditions are met (credits, free pipeline, etc).",
+        "PublicDescription": "Directory Latency Optimization Data Return P=
ath Taken. When directory mode is enabled and the directory retuned for a r=
ead is Dir=3DI, then data can be returned using a faster path if certain co=
nditions are met (credits, free pipeline, etc).",
         "Unit": "HA"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.=
json b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
index a5457c7ba58b..489a3673323d 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
@@ -3,7 +3,7 @@
         "BriefDescription": "Number of non data (control) flits transmitte=
d . Derived from unc_q_txl_flits_g0.non_data",
         "EventName": "QPI_CTL_BANDWIDTH_TX",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach flit is made up of 80 bits of information (in addition to some ECC data=
).  In full-width (L0) mode, flits are made up of four fits, each of which =
contains 20 bits of data (along with some additional ECC data).   In half-w=
idth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as=
 many fits to transmit a flit.  When one talks about QPI speed (for example=
, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the syste=
m will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as data bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual data and an additional 16 bits of othe=
r information.  To calculate data bandwidth, one should therefore do: data =
flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NULL=
 non-data flits transmitted across QPI.  This basically tracks the protocol=
 overhead on the QPI link.  One can get a good picture of the QPI-link char=
acteristics by evaluating the protocol flits, data flits, and idle/null fli=
ts.  This includes the header flits for data packets.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach flit is made up of 80 bits of information (in addition to some ECC data=
).  In full-width (L0) mode, flits are made up of four fits, each of which =
contains 20 bits of data (along with some additional ECC data).   In half-w=
idth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as=
 many fits to transmit a flit.  When one talks about QPI speed (for example=
, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the syste=
m will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as data bandwidth.  For example, when we are transfering a 64B=
 cacheline across QPI, we will break it into 9 flits -- 1 with header infor=
mation and 8 with 64 bits of actual data and an additional 16 bits of other=
 information.  To calculate data bandwidth, one should therefore do: data f=
lits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NULL =
non-data flits transmitted across QPI.  This basically tracks the protocol =
overhead on the QPI link.  One can get a good picture of the QPI-link chara=
cteristics by evaluating the protocol flits, data flits, and idle/null flit=
s.  This includes the header flits for data packets.",
         "ScaleUnit": "8Bytes",
         "UMask": "0x4",
         "Unit": "QPI LL"
@@ -12,7 +12,7 @@
         "BriefDescription": "Number of data flits transmitted . Derived fr=
om unc_q_txl_flits_g0.data",
         "EventName": "QPI_DATA_BANDWIDTH_TX",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach flit is made up of 80 bits of information (in addition to some ECC data=
).  In full-width (L0) mode, flits are made up of four fits, each of which =
contains 20 bits of data (along with some additional ECC data).   In half-w=
idth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as=
 many fits to transmit a flit.  When one talks about QPI speed (for example=
, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the syste=
m will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as data bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual data and an additional 16 bits of othe=
r information.  To calculate data bandwidth, one should therefore do: data =
flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of data fli=
ts transmitted over QPI.  Each flit contains 64b of data.  This includes bo=
th DRS and NCB data flits (coherent and non-coherent).  This can be used to=
 calculate the data bandwidth of the QPI link.  One can get a good picture =
of the QPI-link characteristics by evaluating the protocol flits, data flit=
s, and idle/null flits.  This does not include the header flits that go in =
data packets.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach flit is made up of 80 bits of information (in addition to some ECC data=
).  In full-width (L0) mode, flits are made up of four fits, each of which =
contains 20 bits of data (along with some additional ECC data).   In half-w=
idth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as=
 many fits to transmit a flit.  When one talks about QPI speed (for example=
, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the syste=
m will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as data bandwidth.  For example, when we are transfering a 64B=
 cacheline across QPI, we will break it into 9 flits -- 1 with header infor=
mation and 8 with 64 bits of actual data and an additional 16 bits of other=
 information.  To calculate data bandwidth, one should therefore do: data f=
lits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of data flit=
s transmitted over QPI.  Each flit contains 64b of data.  This includes bot=
h DRS and NCB data flits (coherent and non-coherent).  This can be used to =
calculate the data bandwidth of the QPI link.  One can get a good picture o=
f the QPI-link characteristics by evaluating the protocol flits, data flits=
, and idle/null flits.  This does not include the header flits that go in d=
ata packets.",
         "ScaleUnit": "8Bytes",
         "UMask": "0x2",
         "Unit": "QPI LL"
@@ -134,7 +134,7 @@
         "EventCode": "0x9",
         "EventName": "UNC_Q_RxL_BYPASSED",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that an incoming =
flit was able to bypass the flit buffer and pass directly across the BGF an=
d into the Egress.  This is a latency optimization, and should generally be=
 the common case.  If this value is less than the number of flits transferr=
ed, it implies that there was queueing getting onto the ring, and thus the =
transactions saw higher latency.",
+        "PublicDescription": "Counts the number of times that an incoming =
flit was able to bypass the flit buffer and pass directly across the BGF an=
d into the Egress.  This is a latency optimization, and should generally be=
 the common case.  If this value is less than the number of flits transfere=
d, it implies that there was queueing getting onto the ring, and thus the t=
ransactions saw higher latency.",
         "Unit": "QPI LL"
     },
     {
@@ -391,7 +391,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_Q_RxL_FLITS_G0.IDLE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each f=
lit is made up of 80 bits of information (in addition to some ECC data).  I=
n full-width (L0) mode, flits are made up of four fits, each of which conta=
ins 20 bits of data (along with some additional ECC data).   In half-width =
(L0p) mode, the fits are only 10 bits, and therefore it takes twice as many=
 fits to transmit a flit.  When one talks about QPI speed (for example, 8.0=
 GT/s), the transfers here refer to fits.  Therefore, in L0, the system wil=
l transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate th=
e bandwidth of the link by taking: flits*80b/time.  Note that this is not t=
he same as data bandwidth.  For example, when we are transferring a 64B cac=
heline across QPI, we will break it into 9 flits -- 1 with header informati=
on and 8 with 64 bits of actual data and an additional 16 bits of other inf=
ormation.  To calculate data bandwidth, one should therefore do: data flits=
 * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of flits receive=
d over QPI that do not hold protocol payload.  When QPI is not in a power s=
aving state, it continuously transmits flits across the link.  When there a=
re no protocol flits to send, it will send IDLE and NULL flits  across.  Th=
ese flits sometimes do carry a payload, such as credit returns, but are gen=
erall not considered part of the QPI bandwidth.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each f=
lit is made up of 80 bits of information (in addition to some ECC data).  I=
n full-width (L0) mode, flits are made up of four fits, each of which conta=
ins 20 bits of data (along with some additional ECC data).   In half-width =
(L0p) mode, the fits are only 10 bits, and therefore it takes twice as many=
 fits to transmit a flit.  When one talks about QPI speed (for example, 8.0=
 GT/s), the transfers here refer to fits.  Therefore, in L0, the system wil=
l transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate th=
e bandwidth of the link by taking: flits*80b/time.  Note that this is not t=
he same as data bandwidth.  For example, when we are transfering a 64B cach=
eline across QPI, we will break it into 9 flits -- 1 with header informatio=
n and 8 with 64 bits of actual data and an additional 16 bits of other info=
rmation.  To calculate data bandwidth, one should therefore do: data flits =
* 8B / time (for L0) or 4B instead of 8B for L0p.; Number of flits received=
 over QPI that do not hold protocol payload.  When QPI is not in a power sa=
ving state, it continuously transmits flits across the link.  When there ar=
e no protocol flits to send, it will send IDLE and NULL flits  across.  The=
se flits sometimes do carry a payload, such as credit returns, but are gene=
rall not considered part of the QPI bandwidth.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
@@ -400,7 +400,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.DRS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of flits received over QPI on the DRS (Data Respo=
nse) channel.  DRS flits are used to transmit data with coherency.  This do=
es not count data flits received over the NCB channel which transmits non-c=
oherent data.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the total number of flits received over QPI on the DRS (Data Respon=
se) channel.  DRS flits are used to transmit data with coherency.  This doe=
s not count data flits received over the NCB channel which transmits non-co=
herent data.",
         "UMask": "0x18",
         "Unit": "QPI LL"
     },
@@ -409,7 +409,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.DRS_DATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of data flits received over QPI on the DRS (Data =
Response) channel.  DRS flits are used to transmit data with coherency.  Th=
is does not count data flits received over the NCB channel which transmits =
non-coherent data.  This includes only the data flits (not the header).",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the total number of data flits received over QPI on the DRS (Data R=
esponse) channel.  DRS flits are used to transmit data with coherency.  Thi=
s does not count data flits received over the NCB channel which transmits n=
on-coherent data.  This includes only the data flits (not the header).",
         "UMask": "0x8",
         "Unit": "QPI LL"
     },
@@ -418,7 +418,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.DRS_NONDATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of protocol flits received over QPI on the DRS (D=
ata Response) channel.  DRS flits are used to transmit data with coherency.=
  This does not count data flits received over the NCB channel which transm=
its non-coherent data.  This includes only the header flits (not the data).=
  This includes extended headers.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the total number of protocol flits received over QPI on the DRS (Da=
ta Response) channel.  DRS flits are used to transmit data with coherency. =
 This does not count data flits received over the NCB channel which transmi=
ts non-coherent data.  This includes only the header flits (not the data). =
 This includes extended headers.",
         "UMask": "0x10",
         "Unit": "QPI LL"
     },
@@ -427,7 +427,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.HOM",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the number of flits received over QPI on the home channel.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the number of flits received over QPI on the home channel.",
         "UMask": "0x6",
         "Unit": "QPI LL"
     },
@@ -436,7 +436,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.HOM_NONREQ",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the number of non-request flits received over QPI on the home chan=
nel.  These are most commonly snoop responses, and this event can be used a=
s a proxy for that.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the number of non-request flits received over QPI on the home chann=
el.  These are most commonly snoop responses, and this event can be used as=
 a proxy for that.",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
@@ -445,7 +445,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.HOM_REQ",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the number of data request received over QPI on the home channel. =
 This basically counts the number of remote memory requests received over Q=
PI.  In conjunction with the local read count in the Home Agent, one can ca=
lculate the number of LLC Misses.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the number of data request received over QPI on the home channel.  =
This basically counts the number of remote memory requests received over QP=
I.  In conjunction with the local read count in the Home Agent, one can cal=
culate the number of LLC Misses.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
@@ -454,7 +454,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.SNP",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the number of snoop request flits received over QPI.  These reques=
ts are contained in the snoop channel.  This does not include snoop respons=
es, which are received on the home channel.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the number of snoop request flits received over QPI.  These request=
s are contained in the snoop channel.  This does not include snoop response=
s, which are received on the home channel.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
@@ -463,7 +463,7 @@
         "EventCode": "0x3",
         "EventName": "UNC_Q_RxL_FLITS_G2.NCB",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Number of Non-Coherent Bypass flits.  These packets are generally used to=
 transmit non-coherent data across QPI.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Number of Non-Coherent Bypass flits.  These packets are generally used to =
transmit non-coherent data across QPI.",
         "UMask": "0xc",
         "Unit": "QPI LL"
     },
@@ -472,7 +472,7 @@
         "EventCode": "0x3",
         "EventName": "UNC_Q_RxL_FLITS_G2.NCB_DATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Number of Non-Coherent Bypass data flits.  These flits are generally used=
 to transmit non-coherent data across QPI.  This does not include a count o=
f the DRS (coherent) data flits.  This only counts the data flits, not the =
NCB headers.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Number of Non-Coherent Bypass data flits.  These flits are generally used =
to transmit non-coherent data across QPI.  This does not include a count of=
 the DRS (coherent) data flits.  This only counts the data flits, not the N=
CB headers.",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
@@ -481,7 +481,7 @@
         "EventCode": "0x3",
         "EventName": "UNC_Q_RxL_FLITS_G2.NCB_NONDATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Number of Non-Coherent Bypass non-data flits.  These packets are generall=
y used to transmit non-coherent data across QPI, and the flits counted here=
 are for headers and other non-data flits.  This includes extended headers.=
",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Number of Non-Coherent Bypass non-data flits.  These packets are generally=
 used to transmit non-coherent data across QPI, and the flits counted here =
are for headers and other non-data flits.  This includes extended headers."=
,
         "UMask": "0x8",
         "Unit": "QPI LL"
     },
@@ -490,7 +490,7 @@
         "EventCode": "0x3",
         "EventName": "UNC_Q_RxL_FLITS_G2.NCS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Number of NCS (non-coherent standard) flits received over QPI.    This in=
cludes extended headers.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Number of NCS (non-coherent standard) flits received over QPI.    This inc=
ludes extended headers.",
         "UMask": "0x10",
         "Unit": "QPI LL"
     },
@@ -499,7 +499,7 @@
         "EventCode": "0x3",
         "EventName": "UNC_Q_RxL_FLITS_G2.NDR_AD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of flits received over the NDR (Non-Data Response=
) channel.  This channel is used to send a variety of protocol flits includ=
ing grants and completions.  This is only for NDR packets to the local sock=
et which use the AK ring.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the total number of flits received over the NDR (Non-Data Response)=
 channel.  This channel is used to send a variety of protocol flits includi=
ng grants and completions.  This is only for NDR packets to the local socke=
t which use the AK ring.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
@@ -508,7 +508,7 @@
         "EventCode": "0x3",
         "EventName": "UNC_Q_RxL_FLITS_G2.NDR_AK",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of flits received over the NDR (Non-Data Response=
) channel.  This channel is used to send a variety of protocol flits includ=
ing grants and completions.  This is only for NDR packets destined for Rout=
e-thru to a remote socket.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the total number of flits received over the NDR (Non-Data Response)=
 channel.  This channel is used to send a variety of protocol flits includi=
ng grants and completions.  This is only for NDR packets destined for Route=
-thru to a remote socket.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
@@ -924,7 +924,7 @@
         "BriefDescription": "Flits Transferred - Group 0; Data Tx Flits",
         "EventName": "UNC_Q_TxL_FLITS_G0.DATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach flit is made up of 80 bits of information (in addition to some ECC data=
).  In full-width (L0) mode, flits are made up of four fits, each of which =
contains 20 bits of data (along with some additional ECC data).   In half-w=
idth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as=
 many fits to transmit a flit.  When one talks about QPI speed (for example=
, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the syste=
m will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as data bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual data and an additional 16 bits of othe=
r information.  To calculate data bandwidth, one should therefore do: data =
flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of data fli=
ts transmitted over QPI.  Each flit contains 64b of data.  This includes bo=
th DRS and NCB data flits (coherent and non-coherent).  This can be used to=
 calculate the data bandwidth of the QPI link.  One can get a good picture =
of the QPI-link characteristics by evaluating the protocol flits, data flit=
s, and idle/null flits.  This does not include the header flits that go in =
data packets.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach flit is made up of 80 bits of information (in addition to some ECC data=
).  In full-width (L0) mode, flits are made up of four fits, each of which =
contains 20 bits of data (along with some additional ECC data).   In half-w=
idth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as=
 many fits to transmit a flit.  When one talks about QPI speed (for example=
, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the syste=
m will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as data bandwidth.  For example, when we are transfering a 64B=
 cacheline across QPI, we will break it into 9 flits -- 1 with header infor=
mation and 8 with 64 bits of actual data and an additional 16 bits of other=
 information.  To calculate data bandwidth, one should therefore do: data f=
lits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of data flit=
s transmitted over QPI.  Each flit contains 64b of data.  This includes bot=
h DRS and NCB data flits (coherent and non-coherent).  This can be used to =
calculate the data bandwidth of the QPI link.  One can get a good picture o=
f the QPI-link characteristics by evaluating the protocol flits, data flits=
, and idle/null flits.  This does not include the header flits that go in d=
ata packets.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
@@ -932,7 +932,7 @@
         "BriefDescription": "Flits Transferred - Group 0; Non-Data protoco=
l Tx Flits",
         "EventName": "UNC_Q_TxL_FLITS_G0.NON_DATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach flit is made up of 80 bits of information (in addition to some ECC data=
).  In full-width (L0) mode, flits are made up of four fits, each of which =
contains 20 bits of data (along with some additional ECC data).   In half-w=
idth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as=
 many fits to transmit a flit.  When one talks about QPI speed (for example=
, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the syste=
m will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as data bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual data and an additional 16 bits of othe=
r information.  To calculate data bandwidth, one should therefore do: data =
flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NULL=
 non-data flits transmitted across QPI.  This basically tracks the protocol=
 overhead on the QPI link.  One can get a good picture of the QPI-link char=
acteristics by evaluating the protocol flits, data flits, and idle/null fli=
ts.  This includes the header flits for data packets.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach flit is made up of 80 bits of information (in addition to some ECC data=
).  In full-width (L0) mode, flits are made up of four fits, each of which =
contains 20 bits of data (along with some additional ECC data).   In half-w=
idth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as=
 many fits to transmit a flit.  When one talks about QPI speed (for example=
, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the syste=
m will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as data bandwidth.  For example, when we are transfering a 64B=
 cacheline across QPI, we will break it into 9 flits -- 1 with header infor=
mation and 8 with 64 bits of actual data and an additional 16 bits of other=
 information.  To calculate data bandwidth, one should therefore do: data f=
lits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NULL =
non-data flits transmitted across QPI.  This basically tracks the protocol =
overhead on the QPI link.  One can get a good picture of the QPI-link chara=
cteristics by evaluating the protocol flits, data flits, and idle/null flit=
s.  This includes the header flits for data packets.",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
@@ -940,7 +940,7 @@
         "BriefDescription": "Flits Transferred - Group 1; DRS Flits (both =
Header and Data)",
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transferring a 64B cacheline ac=
ross QPI, we will break it into 9 flits -- 1 with header information and 8 =
with 64 bits of actual data and an additional 16 bits of other information.=
  To calculate data bandwidth, one should therefore do: data flits * 8B / t=
ime.; Counts the total number of flits transmitted over QPI on the DRS (Dat=
a Response) channel.  DRS flits are used to transmit data with coherency.",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the total number of flits transmitted over QPI on the DRS (Data=
 Response) channel.  DRS flits are used to transmit data with coherency.",
         "UMask": "0x18",
         "Unit": "QPI LL"
     },
@@ -948,7 +948,7 @@
         "BriefDescription": "Flits Transferred - Group 1; DRS Data Flits",
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS_DATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transferring a 64B cacheline ac=
ross QPI, we will break it into 9 flits -- 1 with header information and 8 =
with 64 bits of actual data and an additional 16 bits of other information.=
  To calculate data bandwidth, one should therefore do: data flits * 8B / t=
ime.; Counts the total number of data flits transmitted over QPI on the DRS=
 (Data Response) channel.  DRS flits are used to transmit data with coheren=
cy.  This does not count data flits transmitted over the NCB channel which =
transmits non-coherent data.  This includes only the data flits (not the he=
ader).",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the total number of data flits transmitted over QPI on the DRS =
(Data Response) channel.  DRS flits are used to transmit data with coherenc=
y.  This does not count data flits transmitted over the NCB channel which t=
ransmits non-coherent data.  This includes only the data flits (not the hea=
der).",
         "UMask": "0x8",
         "Unit": "QPI LL"
     },
@@ -956,7 +956,7 @@
         "BriefDescription": "Flits Transferred - Group 1; DRS Header Flits=
",
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS_NONDATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transferring a 64B cacheline ac=
ross QPI, we will break it into 9 flits -- 1 with header information and 8 =
with 64 bits of actual data and an additional 16 bits of other information.=
  To calculate data bandwidth, one should therefore do: data flits * 8B / t=
ime.; Counts the total number of protocol flits transmitted over QPI on the=
 DRS (Data Response) channel.  DRS flits are used to transmit data with coh=
erency.  This does not count data flits transmitted over the NCB channel wh=
ich transmits non-coherent data.  This includes only the header flits (not =
the data).  This includes extended headers.",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the total number of protocol flits transmitted over QPI on the =
DRS (Data Response) channel.  DRS flits are used to transmit data with cohe=
rency.  This does not count data flits transmitted over the NCB channel whi=
ch transmits non-coherent data.  This includes only the header flits (not t=
he data).  This includes extended headers.",
         "UMask": "0x10",
         "Unit": "QPI LL"
     },
@@ -964,7 +964,7 @@
         "BriefDescription": "Flits Transferred - Group 1; HOM Flits",
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transferring a 64B cacheline ac=
ross QPI, we will break it into 9 flits -- 1 with header information and 8 =
with 64 bits of actual data and an additional 16 bits of other information.=
  To calculate data bandwidth, one should therefore do: data flits * 8B / t=
ime.; Counts the number of flits transmitted over QPI on the home channel."=
,
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the number of flits transmitted over QPI on the home channel.",
         "UMask": "0x6",
         "Unit": "QPI LL"
     },
@@ -972,7 +972,7 @@
         "BriefDescription": "Flits Transferred - Group 1; HOM Non-Request =
Flits",
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM_NONREQ",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transferring a 64B cacheline ac=
ross QPI, we will break it into 9 flits -- 1 with header information and 8 =
with 64 bits of actual data and an additional 16 bits of other information.=
  To calculate data bandwidth, one should therefore do: data flits * 8B / t=
ime.; Counts the number of non-request flits transmitted over QPI on the ho=
me channel.  These are most commonly snoop responses, and this event can be=
 used as a proxy for that.",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the number of non-request flits transmitted over QPI on the hom=
e channel.  These are most commonly snoop responses, and this event can be =
used as a proxy for that.",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
@@ -980,7 +980,7 @@
         "BriefDescription": "Flits Transferred - Group 1; HOM Request Flit=
s",
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM_REQ",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transferring a 64B cacheline ac=
ross QPI, we will break it into 9 flits -- 1 with header information and 8 =
with 64 bits of actual data and an additional 16 bits of other information.=
  To calculate data bandwidth, one should therefore do: data flits * 8B / t=
ime.; Counts the number of data request transmitted over QPI on the home ch=
annel.  This basically counts the number of remote memory requests transmit=
ted over QPI.  In conjunction with the local read count in the Home Agent, =
one can calculate the number of LLC Misses.",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the number of data request transmitted over QPI on the home cha=
nnel.  This basically counts the number of remote memory requests transmitt=
ed over QPI.  In conjunction with the local read count in the Home Agent, o=
ne can calculate the number of LLC Misses.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
@@ -988,7 +988,7 @@
         "BriefDescription": "Flits Transferred - Group 1; SNP Flits",
         "EventName": "UNC_Q_TxL_FLITS_G1.SNP",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transferring a 64B cacheline ac=
ross QPI, we will break it into 9 flits -- 1 with header information and 8 =
with 64 bits of actual data and an additional 16 bits of other information.=
  To calculate data bandwidth, one should therefore do: data flits * 8B / t=
ime.; Counts the number of snoop request flits transmitted over QPI.  These=
 requests are contained in the snoop channel.  This does not include snoop =
responses, which are transmitted on the home channel.",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the number of snoop request flits transmitted over QPI.  These =
requests are contained in the snoop channel.  This does not include snoop r=
esponses, which are transmitted on the home channel.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
@@ -997,7 +997,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NCB",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transferring a 64B cacheline ac=
ross QPI, we will break it into 9 flits -- 1 with header information and 8 =
with 64 bits of actual data and an additional 16 bits of other information.=
  To calculate data bandwidth, one should therefore do: data flits * 8B / t=
ime.; Number of Non-Coherent Bypass flits.  These packets are generally use=
d to transmit non-coherent data across QPI.",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Number of Non-Coherent Bypass flits.  These packets are generally used=
 to transmit non-coherent data across QPI.",
         "UMask": "0xc",
         "Unit": "QPI LL"
     },
@@ -1006,7 +1006,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NCB_DATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transferring a 64B cacheline ac=
ross QPI, we will break it into 9 flits -- 1 with header information and 8 =
with 64 bits of actual data and an additional 16 bits of other information.=
  To calculate data bandwidth, one should therefore do: data flits * 8B / t=
ime.; Number of Non-Coherent Bypass data flits.  These flits are generally =
used to transmit non-coherent data across QPI.  This does not include a cou=
nt of the DRS (coherent) data flits.  This only counts the data flits, not =
te NCB headers.",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Number of Non-Coherent Bypass data flits.  These flits are generally u=
sed to transmit non-coherent data across QPI.  This does not include a coun=
t of the DRS (coherent) data flits.  This only counts the data flits, not t=
e NCB headers.",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
@@ -1015,7 +1015,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NCB_NONDATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transferring a 64B cacheline ac=
ross QPI, we will break it into 9 flits -- 1 with header information and 8 =
with 64 bits of actual data and an additional 16 bits of other information.=
  To calculate data bandwidth, one should therefore do: data flits * 8B / t=
ime.; Number of Non-Coherent Bypass non-data flits.  These packets are gene=
rally used to transmit non-coherent data across QPI, and the flits counted =
here are for headers and other non-data flits.  This includes extended head=
ers.",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Number of Non-Coherent Bypass non-data flits.  These packets are gener=
ally used to transmit non-coherent data across QPI, and the flits counted h=
ere are for headers and other non-data flits.  This includes extended heade=
rs.",
         "UMask": "0x8",
         "Unit": "QPI LL"
     },
@@ -1024,7 +1024,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NCS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transferring a 64B cacheline ac=
ross QPI, we will break it into 9 flits -- 1 with header information and 8 =
with 64 bits of actual data and an additional 16 bits of other information.=
  To calculate data bandwidth, one should therefore do: data flits * 8B / t=
ime.; Number of NCS (non-coherent standard) flits transmitted over QPI.    =
This includes extended headers.",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Number of NCS (non-coherent standard) flits transmitted over QPI.    T=
his includes extended headers.",
         "UMask": "0x10",
         "Unit": "QPI LL"
     },
@@ -1033,7 +1033,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NDR_AD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transferring a 64B cacheline ac=
ross QPI, we will break it into 9 flits -- 1 with header information and 8 =
with 64 bits of actual data and an additional 16 bits of other information.=
  To calculate data bandwidth, one should therefore do: data flits * 8B / t=
ime.; Counts the total number of flits transmitted over the NDR (Non-Data R=
esponse) channel.  This channel is used to send a variety of protocol flits=
 including grants and completions.  This is only for NDR packets to the loc=
al socket which use the AK ring.",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the total number of flits transmitted over the NDR (Non-Data Re=
sponse) channel.  This channel is used to send a variety of protocol flits =
including grants and completions.  This is only for NDR packets to the loca=
l socket which use the AK ring.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
@@ -1042,7 +1042,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NDR_AK",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transferring a 64B cacheline ac=
ross QPI, we will break it into 9 flits -- 1 with header information and 8 =
with 64 bits of actual data and an additional 16 bits of other information.=
  To calculate data bandwidth, one should therefore do: data flits * 8B / t=
ime.; Counts the total number of flits transmitted over the NDR (Non-Data R=
esponse) channel.  This channel is used to send a variety of protocol flits=
 including grants and completions.  This is only for NDR packets destined f=
or Route-thru to a remote socket.",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the total number of flits transmitted over the NDR (Non-Data Re=
sponse) channel.  This channel is used to send a variety of protocol flits =
including grants and completions.  This is only for NDR packets destined fo=
r Route-thru to a remote socket.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-other.json b/=
tools/perf/pmu-events/arch/x86/broadwellx/uncore-other.json
index 495e34ee5bfb..a80d931dc3d5 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-other.json
@@ -2312,7 +2312,7 @@
         "EventCode": "0x33",
         "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED.AD",
         "PerPkg": "1",
-        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credts from the VN0 pool.  N=
ote that a single packet may require multiple flit buffers (i.e. when data =
is being transferred).  Therefore, this event will increment by the number =
of credits acquired in each cycle.  Filtering based on message class is not=
 provided.  One can count the number of packets transferred in a given mess=
age class using an qfclk event.; Filter for the Home (HOM) message class.  =
HOM is generally used to send requests, request responses, and snoop respon=
ses.",
+        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credts from the VN0 pool.  N=
ote that a single packet may require multiple flit buffers (i.e. when data =
is being transfered).  Therefore, this event will increment by the number o=
f credits acquired in each cycle.  Filtering based on message class is not =
provided.  One can count the number of packets transfered in a given messag=
e class using an qfclk event.; Filter for the Home (HOM) message class.  HO=
M is generally used to send requests, request responses, and snoop response=
s.",
         "UMask": "0x1",
         "Unit": "R3QPI"
     },
@@ -2321,7 +2321,7 @@
         "EventCode": "0x33",
         "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED.BL",
         "PerPkg": "1",
-        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credts from the VN0 pool.  N=
ote that a single packet may require multiple flit buffers (i.e. when data =
is being transferred).  Therefore, this event will increment by the number =
of credits acquired in each cycle.  Filtering based on message class is not=
 provided.  One can count the number of packets transferred in a given mess=
age class using an qfclk event.; Filter for the Home (HOM) message class.  =
HOM is generally used to send requests, request responses, and snoop respon=
ses.",
+        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credts from the VN0 pool.  N=
ote that a single packet may require multiple flit buffers (i.e. when data =
is being transfered).  Therefore, this event will increment by the number o=
f credits acquired in each cycle.  Filtering based on message class is not =
provided.  One can count the number of packets transfered in a given messag=
e class using an qfclk event.; Filter for the Home (HOM) message class.  HO=
M is generally used to send requests, request responses, and snoop response=
s.",
         "UMask": "0x4",
         "Unit": "R3QPI"
     },
--=20
2.39.2.637.g21b0678d19-goog

