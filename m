Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BB56F4D1C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjEBWqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjEBWpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:45:35 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C8340E3
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 15:45:13 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-55a40d32a6bso32977657b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 15:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683067439; x=1685659439;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdzKhr+YXtuoJzMV7YR4Ngtu/fNDqpDHPWq8uJ6vwU0=;
        b=43DYgG4VyI9y02nPjuqQkfO8zgPWD+/a+TrIsKMyiFjADVIICPlCbfcKYTaMpgn4N6
         FXxUJnIVnJAZqZYS6WM7+jc2toWprD+Wi3bztuBcTsIS/11xjKr8IlcE7Vf7GKI3XbSe
         y0YaI+DlfGAvOMMo26/szJ98D20h1xQm3VuB52LecKPW1V741NbqREi9fgTgyqdikOUp
         cOj59bWRL46pMcOe8Fx6rIGoJtCmap4WGon7GC9s5jHEtgr4HVpRAd2VoUrBSQjYzXOU
         vnvJi/V5k5Q8nC/x7WvlkRBplmV/+Pz1wvlN+khU+yYIReu4IeY1cL2qVkybRoELhHvZ
         660w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067440; x=1685659440;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FdzKhr+YXtuoJzMV7YR4Ngtu/fNDqpDHPWq8uJ6vwU0=;
        b=TSSvuMqAu2Ckq+cd468HSQLgmP/7jr4QhZdDutLAhedOuDJX+PuRVR1MkNd1tlNM5O
         +TRi4atiNMASZJ6bHIhGo8CemqaHcgQKypOeFTXbNNn41O9oITQDCxCvTzWfC4+SSJTn
         1aN71HX0Ebj4QBKFXuI+XZ1QC0IfoJkRFlPEU141vDVg3N5aR4zrIDbDl+TdaJs+Tmsu
         5xh6PbPHFwdtAezSrM3m+k+x8HxgKtmeIm74ZRWYGIIN6/kbqoK6fd5npd/mRwsN1RIR
         5MM9AuHf6812Ak2Fe91mQwR9EiRZFgn7Z2DNp+3M7X6Ne2l7CfUW5ZMVWsbjKV5E9eEA
         R+IA==
X-Gm-Message-State: AC+VfDzrpsSNK/iXAlLyhiT1tJiQOUJAWsJwrrTA7XDCuJohGF8v3BE7
        epnRtvpBD2gbeD2tPFxyMSFNsaqHADmk
X-Google-Smtp-Source: ACHHUZ5VDYBRqCpE+7NDQ4G2ZEezbOMBcHh+Ir9TRExIY49glMjSshqvWNyYOckRMiIyd5cc6/xCdM7zUbaI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a81:bd0a:0:b0:54e:8b9a:65be with SMTP id
 b10-20020a81bd0a000000b0054e8b9a65bemr11452036ywi.6.1683067439742; Tue, 02
 May 2023 15:43:59 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:47 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-41-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 40/44] perf vendor events intel: Correct alderlake metrics
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the metrics tma_memory_bound on alderlake cpu_core and
tma_microcode_sequencer on alderlake cpu_atom, where metrics had be
rewritten across PMUs. Fix MEM_BOUND_STALLS_AT_RET_CORRECTION which is
an aux metric but lacks a hash prefix. Add PMU prefixes for
cpu_core/cpu_atom events to avoid wildcard opening the events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/alderlake/adl-metrics.json       | 238 +++++++++---------
 .../arch/x86/alderlaken/adln-metrics.json     |   6 +-
 2 files changed, 122 insertions(+), 122 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/to=
ols/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
index 4c2a14ea5a1c..840f6f6fc8c5 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
@@ -151,7 +151,7 @@
     },
     {
         "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a misp=
redicted jump or a machine clear",
-        "MetricExpr": "(tma_info_slots - (TOPDOWN_FE_BOUND.ALL + TOPDOWN_B=
E_BOUND.ALL + TOPDOWN_RETIRING.ALL)) / tma_info_slots",
+        "MetricExpr": "(tma_info_slots - (cpu_atom@TOPDOWN_FE_BOUND.ALL@ +=
 cpu_atom@TOPDOWN_BE_BOUND.ALL@ + cpu_atom@TOPDOWN_RETIRING.ALL@)) / tma_in=
fo_slots",
         "MetricGroup": "TopdownL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
@@ -162,7 +162,7 @@
     },
     {
         "BriefDescription": "Counts the number of uops that are not from t=
he microsequencer.",
-        "MetricExpr": "(TOPDOWN_RETIRING.ALL - UOPS_RETIRED.MS) / tma_info=
_slots",
+        "MetricExpr": "(cpu_atom@TOPDOWN_RETIRING.ALL@ - cpu_atom@UOPS_RET=
IRED.MS@) / tma_info_slots",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_retiring_group",
         "MetricName": "tma_base",
         "MetricThreshold": "tma_base > 0.6",
@@ -229,7 +229,7 @@
     },
     {
         "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to memory disambiguation.",
-        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.DISAMBIGUATION / MACHINE=
_CLEARS.SLOW)",
+        "MetricExpr": "tma_nuke * (cpu_atom@MACHINE_CLEARS.DISAMBIGUATION@=
 / cpu_atom@MACHINE_CLEARS.SLOW@)",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
         "MetricName": "tma_disambiguation",
         "MetricThreshold": "tma_disambiguation > 0.02",
@@ -239,7 +239,7 @@
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load miss which hit in DRAM or MMIO (Non-DRAM).",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_DRAM_HIT / tma_info_clks - ME=
M_BOUND_STALLS_AT_RET_CORRECTION * MEM_BOUND_STALLS.LOAD_DRAM_HIT / MEM_BOU=
ND_STALLS.LOAD",
+        "MetricExpr": "cpu_atom@MEM_BOUND_STALLS.LOAD_DRAM_HIT@ / tma_info=
_clks - max((cpu_atom@MEM_BOUND_STALLS.LOAD@ - cpu_atom@LD_HEAD.L1_MISS_AT_=
RET@) / tma_info_clks, 0) * cpu_atom@MEM_BOUND_STALLS.LOAD_DRAM_HIT@ / cpu_=
atom@MEM_BOUND_STALLS.LOAD@",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
         "MetricName": "tma_dram_bound",
         "MetricThreshold": "tma_dram_bound > 0.1",
@@ -277,7 +277,7 @@
     },
     {
         "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to FP assists.",
-        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.FP_ASSIST / MACHINE_CLEA=
RS.SLOW)",
+        "MetricExpr": "tma_nuke * (cpu_atom@MACHINE_CLEARS.FP_ASSIST@ / cp=
u_atom@MACHINE_CLEARS.SLOW@)",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
         "MetricName": "tma_fp_assist",
         "MetricThreshold": "tma_fp_assist > 0.02",
@@ -314,7 +314,7 @@
     },
     {
         "BriefDescription": "Percentage of total non-speculative loads wit=
h a address aliasing block",
-        "MetricExpr": "100 * LD_BLOCKS.4K_ALIAS / MEM_UOPS_RETIRED.ALL_LOA=
DS",
+        "MetricExpr": "100 * cpu_atom@LD_BLOCKS.4K_ALIAS@ / MEM_UOPS_RETIR=
ED.ALL_LOADS",
         "MetricName": "tma_info_address_alias_blocks",
         "Unit": "cpu_atom"
     },
@@ -334,14 +334,14 @@
     },
     {
         "BriefDescription": "",
-        "MetricExpr": "CPU_CLK_UNHALTED.CORE",
+        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE@",
         "MetricGroup": " ",
         "MetricName": "tma_info_clks",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "",
-        "MetricExpr": "CPU_CLK_UNHALTED.CORE_P",
+        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE_P@",
         "MetricGroup": " ",
         "MetricName": "tma_info_clks_p",
         "Unit": "cpu_atom"
@@ -383,35 +383,35 @@
     },
     {
         "BriefDescription": "Percentage of all uops which are FPDiv uops",
-        "MetricExpr": "100 * UOPS_RETIRED.FPDIV / UOPS_RETIRED.ALL",
+        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.FPDIV@ / UOPS_RETIRED.A=
LL",
         "MetricGroup": " ",
         "MetricName": "tma_info_fpdiv_uop_ratio",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Percentage of all uops which are IDiv uops",
-        "MetricExpr": "100 * UOPS_RETIRED.IDIV / UOPS_RETIRED.ALL",
+        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.IDIV@ / UOPS_RETIRED.AL=
L",
         "MetricGroup": " ",
         "MetricName": "tma_info_idiv_uop_ratio",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Percent of instruction miss cost that hit in =
DRAM",
-        "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_DRAM_HIT / MEM_BOUND_=
STALLS.IFETCH",
+        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.IFETCH_DRAM_HIT@ / =
cpu_atom@MEM_BOUND_STALLS.IFETCH@",
         "MetricGroup": " ",
         "MetricName": "tma_info_inst_miss_cost_dramhit_percent",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Percent of instruction miss cost that hit in =
the L2",
-        "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_L2_HIT / MEM_BOUND_ST=
ALLS.IFETCH",
+        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.IFETCH_L2_HIT@ / cp=
u_atom@MEM_BOUND_STALLS.IFETCH@",
         "MetricGroup": " ",
         "MetricName": "tma_info_inst_miss_cost_l2hit_percent",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Percent of instruction miss cost that hit in =
the L3",
-        "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_LLC_HIT / MEM_BOUND_S=
TALLS.IFETCH",
+        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.IFETCH_LLC_HIT@ / c=
pu_atom@MEM_BOUND_STALLS.IFETCH@",
         "MetricGroup": " ",
         "MetricName": "tma_info_inst_miss_cost_l3hit_percent",
         "Unit": "cpu_atom"
@@ -439,7 +439,7 @@
     },
     {
         "BriefDescription": "Instructions per Far Branch",
-        "MetricExpr": "INST_RETIRED.ANY / (BR_INST_RETIRED.FAR_BRANCH / 2)=
",
+        "MetricExpr": "INST_RETIRED.ANY / (cpu_atom@BR_INST_RETIRED.FAR_BR=
ANCH@ / 2)",
         "MetricGroup": " ",
         "MetricName": "tma_info_ipfarbranch",
         "Unit": "cpu_atom"
@@ -453,7 +453,7 @@
     },
     {
         "BriefDescription": "Instructions per retired conditional Branch M=
isprediction where the branch was not taken",
-        "MetricExpr": "INST_RETIRED.ANY / (BR_MISP_RETIRED.COND - BR_MISP_=
RETIRED.COND_TAKEN)",
+        "MetricExpr": "INST_RETIRED.ANY / (cpu_atom@BR_MISP_RETIRED.COND@ =
- cpu_atom@BR_MISP_RETIRED.COND_TAKEN@)",
         "MetricName": "tma_info_ipmisp_cond_ntaken",
         "Unit": "cpu_atom"
     },
@@ -498,20 +498,20 @@
     },
     {
         "BriefDescription": "Percentage of total non-speculative loads tha=
t are splits",
-        "MetricExpr": "100 * MEM_UOPS_RETIRED.SPLIT_LOADS / MEM_UOPS_RETIR=
ED.ALL_LOADS",
+        "MetricExpr": "100 * cpu_atom@MEM_UOPS_RETIRED.SPLIT_LOADS@ / MEM_=
UOPS_RETIRED.ALL_LOADS",
         "MetricName": "tma_info_load_splits",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "load ops retired per 1000 instruction",
-        "MetricExpr": "1e3 * MEM_UOPS_RETIRED.ALL_LOADS / INST_RETIRED.ANY=
",
+        "MetricExpr": "1e3 * cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@ / INST_R=
ETIRED.ANY",
         "MetricGroup": " ",
         "MetricName": "tma_info_memloadpki",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Percentage of all uops which are ucode ops",
-        "MetricExpr": "100 * UOPS_RETIRED.MS / UOPS_RETIRED.ALL",
+        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.MS@ / UOPS_RETIRED.ALL"=
,
         "MetricGroup": " ",
         "MetricName": "tma_info_microcode_uop_ratio",
         "Unit": "cpu_atom"
@@ -525,7 +525,7 @@
     },
     {
         "BriefDescription": "Percentage of total non-speculative loads wit=
h a store forward or unknown store address block",
-        "MetricExpr": "100 * LD_BLOCKS.DATA_UNKNOWN / MEM_UOPS_RETIRED.ALL=
_LOADS",
+        "MetricExpr": "100 * cpu_atom@LD_BLOCKS.DATA_UNKNOWN@ / MEM_UOPS_R=
ETIRED.ALL_LOADS",
         "MetricName": "tma_info_store_fwd_blocks",
         "Unit": "cpu_atom"
     },
@@ -545,7 +545,7 @@
     },
     {
         "BriefDescription": "Percentage of all uops which are x87 uops",
-        "MetricExpr": "100 * UOPS_RETIRED.X87 / UOPS_RETIRED.ALL",
+        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.X87@ / UOPS_RETIRED.ALL=
",
         "MetricGroup": " ",
         "MetricName": "tma_info_x87_uop_ratio",
         "Unit": "cpu_atom"
@@ -571,7 +571,7 @@
     {
         "BriefDescription": "Counts the number of cycles a core is stalled=
 due to a demand load which hit in the L2 Cache.",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_L2_HIT / tma_info_clks - MEM_=
BOUND_STALLS_AT_RET_CORRECTION * MEM_BOUND_STALLS.LOAD_L2_HIT / MEM_BOUND_S=
TALLS.LOAD",
+        "MetricExpr": "cpu_atom@MEM_BOUND_STALLS.LOAD_L2_HIT@ / tma_info_c=
lks - max((cpu_atom@MEM_BOUND_STALLS.LOAD@ - cpu_atom@LD_HEAD.L1_MISS_AT_RE=
T@) / tma_info_clks, 0) * cpu_atom@MEM_BOUND_STALLS.LOAD_L2_HIT@ / cpu_atom=
@MEM_BOUND_STALLS.LOAD@",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
         "MetricName": "tma_l2_bound",
         "MetricThreshold": "tma_l2_bound > 0.1",
@@ -580,7 +580,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles a core is stalled=
 due to a demand load which hit in the Last Level Cache (LLC) or other core=
 with HITE/F/M.",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_LLC_HIT / tma_info_clks - MEM=
_BOUND_STALLS_AT_RET_CORRECTION * MEM_BOUND_STALLS.LOAD_LLC_HIT / MEM_BOUND=
_STALLS.LOAD",
+        "MetricExpr": "cpu_atom@MEM_BOUND_STALLS.LOAD_LLC_HIT@ / tma_info_=
clks - max((cpu_atom@MEM_BOUND_STALLS.LOAD@ - cpu_atom@LD_HEAD.L1_MISS_AT_R=
ET@) / tma_info_clks, 0) * cpu_atom@MEM_BOUND_STALLS.LOAD_LLC_HIT@ / cpu_at=
om@MEM_BOUND_STALLS.LOAD@",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
         "MetricThreshold": "tma_l3_bound > 0.1",
@@ -589,7 +589,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles, relative to the =
number of mem_scheduler slots, in which uops are blocked due to load buffer=
 full",
-        "MetricExpr": "tma_mem_scheduler * MEM_SCHEDULER_BLOCK.LD_BUF / ME=
M_SCHEDULER_BLOCK.ALL",
+        "MetricExpr": "tma_mem_scheduler * cpu_atom@MEM_SCHEDULER_BLOCK.LD=
_BUF@ / MEM_SCHEDULER_BLOCK.ALL",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_mem_scheduler_group",
         "MetricName": "tma_ld_buffer",
         "MetricThreshold": "tma_ld_buffer > 0.05",
@@ -617,7 +617,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to stores or loads.",
-        "MetricExpr": "min(tma_backend_bound, LD_HEAD.ANY_AT_RET / tma_inf=
o_clks + tma_store_bound)",
+        "MetricExpr": "min(cpu_atom@TOPDOWN_BE_BOUND.ALL@ / tma_info_slots=
, cpu_atom@LD_HEAD.ANY_AT_RET@ / tma_info_clks + tma_store_bound)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
         "MetricName": "tma_memory_bound",
         "MetricThreshold": "tma_memory_bound > 0.2",
@@ -627,7 +627,7 @@
     },
     {
         "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to memory ordering.",
-        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.MEMORY_ORDERING / MACHIN=
E_CLEARS.SLOW)",
+        "MetricExpr": "tma_nuke * (cpu_atom@MACHINE_CLEARS.MEMORY_ORDERING=
@ / cpu_atom@MACHINE_CLEARS.SLOW@)",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
         "MetricName": "tma_memory_ordering",
         "MetricThreshold": "tma_memory_ordering > 0.02",
@@ -636,7 +636,7 @@
     },
     {
         "BriefDescription": "Counts the number of uops that are from the c=
omplex flows issued by the micro-sequencer (MS)",
-        "MetricExpr": "tma_microcode_sequencer",
+        "MetricExpr": "UOPS_RETIRED.MS / tma_info_slots",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_retiring_group",
         "MetricName": "tma_ms_uops",
         "MetricThreshold": "tma_ms_uops > 0.05",
@@ -692,7 +692,7 @@
     },
     {
         "BriefDescription": "Counts the number of uops retired excluding m=
s and fp div uops.",
-        "MetricExpr": "(TOPDOWN_RETIRING.ALL - UOPS_RETIRED.MS - UOPS_RETI=
RED.FPDIV) / tma_info_slots",
+        "MetricExpr": "(cpu_atom@TOPDOWN_RETIRING.ALL@ - cpu_atom@UOPS_RET=
IRED.MS@ - cpu_atom@UOPS_RETIRED.FPDIV@) / tma_info_slots",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_base_group",
         "MetricName": "tma_other_ret",
         "MetricThreshold": "tma_other_ret > 0.3",
@@ -701,7 +701,7 @@
     },
     {
         "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to page faults.",
-        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.PAGE_FAULT / MACHINE_CLE=
ARS.SLOW)",
+        "MetricExpr": "tma_nuke * (cpu_atom@MACHINE_CLEARS.PAGE_FAULT@ / c=
pu_atom@MACHINE_CLEARS.SLOW@)",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
         "MetricName": "tma_page_fault",
         "MetricThreshold": "tma_page_fault > 0.02",
@@ -758,7 +758,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles, relative to the =
number of mem_scheduler slots, in which uops are blocked due to RSV full re=
lative",
-        "MetricExpr": "tma_mem_scheduler * MEM_SCHEDULER_BLOCK.RSV / MEM_S=
CHEDULER_BLOCK.ALL",
+        "MetricExpr": "tma_mem_scheduler * cpu_atom@MEM_SCHEDULER_BLOCK.RS=
V@ / MEM_SCHEDULER_BLOCK.ALL",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_mem_scheduler_group",
         "MetricName": "tma_rsv",
         "MetricThreshold": "tma_rsv > 0.05",
@@ -776,7 +776,7 @@
     },
     {
         "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to SMC.",
-        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.SMC / MACHINE_CLEARS.SLO=
W)",
+        "MetricExpr": "tma_nuke * (cpu_atom@MACHINE_CLEARS.SMC@ / cpu_atom=
@MACHINE_CLEARS.SLOW@)",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
         "MetricName": "tma_smc",
         "MetricThreshold": "tma_smc > 0.02",
@@ -812,7 +812,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to store buffer full.",
-        "MetricExpr": "tma_mem_scheduler * (MEM_SCHEDULER_BLOCK.ST_BUF / M=
EM_SCHEDULER_BLOCK.ALL)",
+        "MetricExpr": "tma_mem_scheduler * (cpu_atom@MEM_SCHEDULER_BLOCK.S=
T_BUF@ / cpu_atom@MEM_SCHEDULER_BLOCK.ALL@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
         "MetricName": "tma_store_bound",
         "MetricThreshold": "tma_store_bound > 0.1",
@@ -830,7 +830,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
-        "MetricExpr": "(UOPS_DISPATCHED.PORT_0 + UOPS_DISPATCHED.PORT_1 + =
UOPS_DISPATCHED.PORT_5_11 + UOPS_DISPATCHED.PORT_6) / (5 * tma_info_core_cl=
ks)",
+        "MetricExpr": "(cpu_core@UOPS_DISPATCHED.PORT_0@ + cpu_core@UOPS_D=
ISPATCHED.PORT_1@ + cpu_core@UOPS_DISPATCHED.PORT_5_11@ + cpu_core@UOPS_DIS=
PATCHED.PORT_6@) / (5 * tma_info_core_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_alu_op_utilization",
         "MetricThreshold": "tma_alu_op_utilization > 0.6",
@@ -849,7 +849,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops as a result of handing SSE to AVX* or AVX* to SSE transitio=
n Assists.",
-        "MetricExpr": "63 * ASSISTS.SSE_AVX_MIX / tma_info_slots",
+        "MetricExpr": "63 * cpu_core@ASSISTS.SSE_AVX_MIX@ / tma_info_slots=
",
         "MetricGroup": "HPC;TopdownL5;tma_L5_group;tma_assists_group",
         "MetricName": "tma_avx_assists",
         "MetricThreshold": "tma_avx_assists > 0.1",
@@ -858,7 +858,7 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
-        "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_inf=
o_slots",
+        "MetricExpr": "cpu_core@topdown\\-be\\-bound@ / (cpu_core@topdown\=
\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retirin=
g@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_slots",
         "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
@@ -880,7 +880,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction",
-        "MetricExpr": "topdown\\-br\\-mispredict / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tm=
a_info_slots",
+        "MetricExpr": "cpu_core@topdown\\-br\\-mispredict@ / (cpu_core@top=
down\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-re=
tiring@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_slots",
         "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_group=
;tma_bad_speculation_group;tma_issueBM",
         "MetricName": "tma_branch_mispredicts",
         "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specula=
tion > 0.15",
@@ -911,7 +911,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Machine Clears",
-        "MetricExpr": "(1 - tma_branch_mispredicts / tma_bad_speculation) =
* INT_MISC.CLEAR_RESTEER_CYCLES / tma_info_clks",
+        "MetricExpr": "(1 - tma_branch_mispredicts / tma_bad_speculation) =
* cpu_core@INT_MISC.CLEAR_RESTEER_CYCLES@ / tma_info_clks",
         "MetricGroup": "BadSpec;MachineClears;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group;tma_issueMC",
         "MetricName": "tma_clears_resteers",
         "MetricThreshold": "tma_clears_resteers > 0.05 & (tma_branch_reste=
ers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
@@ -922,7 +922,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(25 * tma_info_average_frequency * (MEM_LOAD_L3_HIT=
_RETIRED.XSNP_FWD * (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM / (OCR.DEMAND_DAT=
A_RD.L3_HIT.SNOOP_HITM + OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) + =
24 * tma_info_average_frequency * MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS) * (1 +=
 MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_info_clks",
+        "MetricExpr": "(25 * tma_info_average_frequency * (cpu_core@MEM_LO=
AD_L3_HIT_RETIRED.XSNP_FWD@ * (cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT=
M@ / (cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ + cpu_core@OCR.DEMAND_=
DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD@))) + 24 * tma_info_average_frequency * c=
pu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS@) * (1 + cpu_core@MEM_LOAD_RETIRE=
D.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_MISS@ / 2) / tma_info_clks",
         "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_l3_bound_group",
         "MetricName": "tma_contested_accesses",
         "MetricThreshold": "tma_contested_accesses > 0.05 & (tma_l3_bound =
> 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -944,7 +944,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "24 * tma_info_average_frequency * (MEM_LOAD_L3_HIT_=
RETIRED.XSNP_NO_FWD + MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD * (1 - OCR.DEMAND_DA=
TA_RD.L3_HIT.SNOOP_HITM / (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM + OCR.DEMAN=
D_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM=
_LOAD_RETIRED.L1_MISS / 2) / tma_info_clks",
+        "MetricExpr": "24 * tma_info_average_frequency * (cpu_core@MEM_LOA=
D_L3_HIT_RETIRED.XSNP_NO_FWD@ + cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ =
* (1 - cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ / (cpu_core@OCR.DEMAN=
D_DATA_RD.L3_HIT.SNOOP_HITM@ + cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT=
_WITH_FWD@))) * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_=
RETIRED.L1_MISS@ / 2) / tma_info_clks",
         "MetricGroup": "Offcore;Snoop;TopdownL4;tma_L4_group;tma_issueSync=
xn;tma_l3_bound_group",
         "MetricName": "tma_data_sharing",
         "MetricThreshold": "tma_data_sharing > 0.05 & (tma_l3_bound > 0.05=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -975,7 +975,7 @@
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "MEMORY_ACTIVITY.STALLS_L3_MISS / tma_info_clks",
+        "MetricExpr": "cpu_core@MEMORY_ACTIVITY.STALLS_L3_MISS@ / tma_info=
_clks",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_dram_bound",
         "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2)",
@@ -985,7 +985,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to DSB (decoded uop cache) fetch pipe=
line",
-        "MetricExpr": "(IDQ.DSB_CYCLES_ANY - IDQ.DSB_CYCLES_OK) / tma_info=
_core_clks / 2",
+        "MetricExpr": "(cpu_core@IDQ.DSB_CYCLES_ANY@ - cpu_core@IDQ.DSB_CY=
CLES_OK@) / tma_info_core_clks / 2",
         "MetricGroup": "DSB;FetchBW;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
         "MetricName": "tma_dsb",
         "MetricThreshold": "tma_dsb > 0.15 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_ipc / 6 > 0.35)",
@@ -1005,7 +1005,7 @@
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
-        "MetricExpr": "min(7 * cpu_core@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\=
\=3D1@ + DTLB_LOAD_MISSES.WALK_ACTIVE, max(CYCLE_ACTIVITY.CYCLES_MEM_ANY - =
MEMORY_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_clks",
+        "MetricExpr": "min(7 * cpu_core@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\=
\=3D1@ + cpu_core@DTLB_LOAD_MISSES.WALK_ACTIVE@, max(cpu_core@CYCLE_ACTIVIT=
Y.CYCLES_MEM_ANY@ - cpu_core@MEMORY_ACTIVITY.CYCLES_L1D_MISS@, 0)) / tma_in=
fo_clks",
         "MetricGroup": "MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB;tma_=
l1_bound_group",
         "MetricName": "tma_dtlb_load",
         "MetricThreshold": "tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & (t=
ma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -1015,7 +1015,7 @@
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
-        "MetricExpr": "(7 * cpu_core@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=
=3D1@ + DTLB_STORE_MISSES.WALK_ACTIVE) / tma_info_core_clks",
+        "MetricExpr": "(7 * cpu_core@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=
=3D1@ + cpu_core@DTLB_STORE_MISSES.WALK_ACTIVE@) / tma_info_core_clks",
         "MetricGroup": "MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB;tma_=
store_bound_group",
         "MetricName": "tma_dtlb_store",
         "MetricThreshold": "tma_dtlb_store > 0.05 & (tma_store_bound > 0.2=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -1025,7 +1025,7 @@
     },
     {
         "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
-        "MetricExpr": "28 * tma_info_average_frequency * OCR.DEMAND_RFO.L3=
_HIT.SNOOP_HITM / tma_info_clks",
+        "MetricExpr": "28 * tma_info_average_frequency * cpu_core@OCR.DEMA=
ND_RFO.L3_HIT.SNOOP_HITM@ / tma_info_clks",
         "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_store_bound_group",
         "MetricName": "tma_false_sharing",
         "MetricThreshold": "tma_false_sharing > 0.05 & (tma_store_bound > =
0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -1056,7 +1056,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues",
-        "MetricExpr": "topdown\\-fetch\\-lat / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.U=
OP_DROPPING / tma_info_slots",
+        "MetricExpr": "cpu_core@topdown\\-fetch\\-lat@ / (cpu_core@topdown=
\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiri=
ng@ + cpu_core@topdown\\-be\\-bound@) - cpu_core@INT_MISC.UOP_DROPPING@ / t=
ma_info_slots",
         "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend=
_bound_group",
         "MetricName": "tma_fetch_latency",
         "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound >=
 0.15",
@@ -1088,7 +1088,7 @@
     },
     {
         "BriefDescription": "This metric roughly estimates fraction of slo=
ts the CPU retired uops as a result of handing Floating Point (FP) Assists"=
,
-        "MetricExpr": "30 * ASSISTS.FP / tma_info_slots",
+        "MetricExpr": "30 * cpu_core@ASSISTS.FP@ / tma_info_slots",
         "MetricGroup": "HPC;TopdownL5;tma_L5_group;tma_assists_group",
         "MetricName": "tma_fp_assists",
         "MetricThreshold": "tma_fp_assists > 0.1",
@@ -1118,7 +1118,7 @@
     },
     {
         "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 128-bit wide vectors",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.128B_PACKED_SINGLE) / (tma_retiring * tma_info_slots)",
+        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@=
 + cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE@) / (tma_retiring * tm=
a_info_slots)",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_128b",
         "MetricThreshold": "tma_fp_vector_128b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
@@ -1128,7 +1128,7 @@
     },
     {
         "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 256-bit wide vectors",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.256B_PACKED_SINGLE) / (tma_retiring * tma_info_slots)",
+        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE@=
 + cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@) / (tma_retiring * tm=
a_info_slots)",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_256b",
         "MetricThreshold": "tma_fp_vector_256b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
@@ -1138,7 +1138,7 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
-        "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.UO=
P_DROPPING / tma_info_slots",
+        "MetricExpr": "cpu_core@topdown\\-fe\\-bound@ / (cpu_core@topdown\=
\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retirin=
g@ + cpu_core@topdown\\-be\\-bound@) - cpu_core@INT_MISC.UOP_DROPPING@ / tm=
a_info_slots",
         "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
@@ -1149,7 +1149,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions -- where one uop can represent mu=
ltiple contiguous instructions",
-        "MetricExpr": "tma_light_operations * INST_RETIRED.MACRO_FUSED / (=
tma_retiring * tma_info_slots)",
+        "MetricExpr": "tma_light_operations * cpu_core@INST_RETIRED.MACRO_=
FUSED@ / (tma_retiring * tma_info_slots)",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_fused_instructions",
         "MetricThreshold": "tma_fused_instructions > 0.1 & tma_light_opera=
tions > 0.6",
@@ -1159,7 +1159,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or micro-coded sequences",
-        "MetricExpr": "topdown\\-heavy\\-ops / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_in=
fo_slots",
+        "MetricExpr": "cpu_core@topdown\\-heavy\\-ops@ / (cpu_core@topdown=
\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiri=
ng@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_slots",
         "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_g=
roup",
         "MetricName": "tma_heavy_operations",
         "MetricThreshold": "tma_heavy_operations > 0.1",
@@ -1213,7 +1213,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of branch related instruc=
tions (used for program control-flow including function calls)",
-        "MetricExpr": "100 * ((BR_INST_RETIRED.COND + 3 * BR_INST_RETIRED.=
NEAR_CALL + (BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.COND_TAKEN - 2 * =
BR_INST_RETIRED.NEAR_CALL)) / tma_info_slots)",
+        "MetricExpr": "100 * ((cpu_core@BR_INST_RETIRED.COND@ + 3 * cpu_co=
re@BR_INST_RETIRED.NEAR_CALL@ + (cpu_core@BR_INST_RETIRED.NEAR_TAKEN@ - cpu=
_core@BR_INST_RETIRED.COND_TAKEN@ - 2 * cpu_core@BR_INST_RETIRED.NEAR_CALL@=
)) / tma_info_slots)",
         "MetricGroup": "Ret;tma_issueBC",
         "MetricName": "tma_info_branching_overhead",
         "MetricThreshold": "tma_info_branching_overhead > 10",
@@ -1222,21 +1222,21 @@
     },
     {
         "BriefDescription": "Fraction of branches that are CALL or RET",
-        "MetricExpr": "(BR_INST_RETIRED.NEAR_CALL + BR_INST_RETIRED.NEAR_R=
ETURN) / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricExpr": "(cpu_core@BR_INST_RETIRED.NEAR_CALL@ + cpu_core@BR_=
INST_RETIRED.NEAR_RETURN@) / BR_INST_RETIRED.ALL_BRANCHES",
         "MetricGroup": "Bad;Branches",
         "MetricName": "tma_info_callret",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
+        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.THREAD@",
         "MetricGroup": "Pipeline",
         "MetricName": "tma_info_clks",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
-        "MetricExpr": "1e3 * ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.ANY=
",
+        "MetricExpr": "1e3 * cpu_core@ITLB_MISSES.WALK_COMPLETED@ / INST_R=
ETIRED.ANY",
         "MetricGroup": "Fed;MemoryTLB",
         "MetricName": "tma_info_code_stlb_mpki",
         "Unit": "cpu_core"
@@ -1266,7 +1266,7 @@
     },
     {
         "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
-        "MetricExpr": "CPU_CLK_UNHALTED.DISTRIBUTED",
+        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.DISTRIBUTED@",
         "MetricGroup": "SMT",
         "MetricName": "tma_info_core_clks",
         "Unit": "cpu_core"
@@ -1309,7 +1309,7 @@
     },
     {
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
-        "MetricExpr": "IDQ.DSB_UOPS / UOPS_ISSUED.ANY",
+        "MetricExpr": "IDQ.DSB_UOPS / cpu_core@UOPS_ISSUED.ANY@",
         "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
         "MetricName": "tma_info_dsb_coverage",
         "MetricThreshold": "tma_info_dsb_coverage < 0.7 & tma_info_ipc / 6=
 > 0.35",
@@ -1350,7 +1350,7 @@
     },
     {
         "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
-        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.FB_HIT / INST_RETIRED.ANY",
+        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / INST_RETI=
RED.ANY",
         "MetricGroup": "CacheMisses;Mem",
         "MetricName": "tma_info_fb_hpki",
         "Unit": "cpu_core"
@@ -1365,7 +1365,7 @@
     {
         "BriefDescription": "Floating Point Operations Per Cycle",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 =
* (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PA=
CKED_DOUBLE) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) / tma_info_cor=
e_clks",
+        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.SCALAR_SINGLE@ + cp=
u_core@FP_ARITH_INST_RETIRED.SCALAR_DOUBLE@ + 2 * cpu_core@FP_ARITH_INST_RE=
TIRED.128B_PACKED_DOUBLE@ + 4 * (cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED=
_SINGLE@ + cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE@) + 8 * cpu_co=
re@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@) / tma_info_core_clks",
         "MetricGroup": "Flops;Ret",
         "MetricName": "tma_info_flopc",
         "Unit": "cpu_core"
@@ -1373,7 +1373,7 @@
     {
         "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(FP_ARITH_DISPATCHED.PORT_0 + FP_ARITH_DISPATCHED.P=
ORT_1 + FP_ARITH_DISPATCHED.PORT_5) / (2 * tma_info_core_clks)",
+        "MetricExpr": "(cpu_core@FP_ARITH_DISPATCHED.PORT_0@ + cpu_core@FP=
_ARITH_DISPATCHED.PORT_1@ + cpu_core@FP_ARITH_DISPATCHED.PORT_5@) / (2 * tm=
a_info_core_clks)",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "tma_info_fp_arith_utilization",
         "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n).",
@@ -1381,7 +1381,7 @@
     },
     {
         "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 =
* (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PA=
CKED_DOUBLE) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) / 1e9 / durati=
on_time",
+        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.SCALAR_SINGLE@ + cp=
u_core@FP_ARITH_INST_RETIRED.SCALAR_DOUBLE@ + 2 * cpu_core@FP_ARITH_INST_RE=
TIRED.128B_PACKED_DOUBLE@ + 4 * (cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED=
_SINGLE@ + cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE@) + 8 * cpu_co=
re@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@) / 1e9 / duration_time",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "tma_info_gflops",
         "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine.",
@@ -1405,7 +1405,7 @@
     },
     {
         "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (cpu_core@UOPS_EXECUTED.CORE=
_CYCLES_GE_1@ / 2 if #SMT_on else cpu_core@UOPS_EXECUTED.CORE_CYCLES_GE_1@)=
",
         "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
         "MetricName": "tma_info_ilp",
         "Unit": "cpu_core"
@@ -1421,7 +1421,7 @@
     },
     {
         "BriefDescription": "Total number of retired Instructions",
-        "MetricExpr": "INST_RETIRED.ANY",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@",
         "MetricGroup": "Summary;TmaL1;tma_L1_group",
         "MetricName": "tma_info_instructions",
         "PublicDescription": "Total number of retired Instructions. Sample=
 with: INST_RETIRED.PREC_DIST",
@@ -1438,7 +1438,7 @@
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-bi=
t instruction (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.128B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE)",
+        "MetricExpr": "INST_RETIRED.ANY / (cpu_core@FP_ARITH_INST_RETIRED.=
128B_PACKED_DOUBLE@ + cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE@)",
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_iparith_avx128",
         "MetricThreshold": "tma_info_iparith_avx128 < 10",
@@ -1447,7 +1447,7 @@
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX* 256-bit i=
nstruction (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.256B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE)",
+        "MetricExpr": "INST_RETIRED.ANY / (cpu_core@FP_ARITH_INST_RETIRED.=
256B_PACKED_DOUBLE@ + cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@)",
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_iparith_avx256",
         "MetricThreshold": "tma_info_iparith_avx256 < 10",
@@ -1514,7 +1514,7 @@
     },
     {
         "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
+        "MetricExpr": "INST_RETIRED.ANY / cpu_core@BR_INST_RETIRED.FAR_BRA=
NCH@u",
         "MetricGroup": "Branches;OS",
         "MetricName": "tma_info_ipfarbranch",
         "MetricThreshold": "tma_info_ipfarbranch < 1e6",
@@ -1522,7 +1522,7 @@
     },
     {
         "BriefDescription": "Instructions per Floating Point (FP) Operatio=
n (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR_SI=
NGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE + 2 * FP_ARITH_INST_RETIRED.128B=
_PACKED_DOUBLE + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_I=
NST_RETIRED.256B_PACKED_DOUBLE) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SIN=
GLE)",
+        "MetricExpr": "INST_RETIRED.ANY / (cpu_core@FP_ARITH_INST_RETIRED.=
SCALAR_SINGLE@ + cpu_core@FP_ARITH_INST_RETIRED.SCALAR_DOUBLE@ + 2 * cpu_co=
re@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@ + 4 * (cpu_core@FP_ARITH_INST_=
RETIRED.128B_PACKED_SINGLE@ + cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_DO=
UBLE@) + 8 * cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@)",
         "MetricGroup": "Flops;InsType",
         "MetricName": "tma_info_ipflop",
         "MetricThreshold": "tma_info_ipflop < 10",
@@ -1610,14 +1610,14 @@
     },
     {
         "BriefDescription": "Fraction of branches that are unconditional (=
direct or indirect) jumps",
-        "MetricExpr": "(BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.COND_=
TAKEN - 2 * BR_INST_RETIRED.NEAR_CALL) / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricExpr": "(cpu_core@BR_INST_RETIRED.NEAR_TAKEN@ - cpu_core@BR=
_INST_RETIRED.COND_TAKEN@ - 2 * cpu_core@BR_INST_RETIRED.NEAR_CALL@) / BR_I=
NST_RETIRED.ALL_BRANCHES",
         "MetricGroup": "Bad;Branches",
         "MetricName": "tma_info_jump",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / cpu_core@INST_RETIRED=
.ANY_P@k",
         "MetricGroup": "OS",
         "MetricName": "tma_info_kernel_cpi",
         "Unit": "cpu_core"
@@ -1632,7 +1632,7 @@
     },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / duration_time",
+        "MetricExpr": "64 * cpu_core@L1D.REPLACEMENT@ / 1e9 / duration_tim=
e",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_l1d_cache_fill_bw",
         "Unit": "cpu_core"
@@ -1646,21 +1646,21 @@
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY",
+        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.L1_MISS@ / INST_RET=
IRED.ANY",
         "MetricGroup": "CacheMisses;Mem",
         "MetricName": "tma_info_l1mpki",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 all demand loads (including speculative)",
-        "MetricExpr": "1e3 * L2_RQSTS.ALL_DEMAND_DATA_RD / INST_RETIRED.AN=
Y",
+        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.ALL_DEMAND_DATA_RD@ / INST_=
RETIRED.ANY",
         "MetricGroup": "CacheMisses;Mem",
         "MetricName": "tma_info_l1mpki_load",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / duration_time",
+        "MetricExpr": "64 * cpu_core@L2_LINES_IN.ALL@ / 1e9 / duration_tim=
e",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_l2_cache_fill_bw",
         "Unit": "cpu_core"
@@ -1674,56 +1674,56 @@
     },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all re=
quest types (including speculative)",
-        "MetricExpr": "1e3 * (L2_RQSTS.REFERENCES - L2_RQSTS.MISS) / INST_=
RETIRED.ANY",
+        "MetricExpr": "1e3 * (cpu_core@L2_RQSTS.REFERENCES@ - cpu_core@L2_=
RQSTS.MISS@) / INST_RETIRED.ANY",
         "MetricGroup": "CacheMisses;Mem",
         "MetricName": "tma_info_l2hpki_all",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all de=
mand loads  (including speculative)",
-        "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_HIT / INST_RETIRED.AN=
Y",
+        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.DEMAND_DATA_RD_HIT@ / INST_=
RETIRED.ANY",
         "MetricGroup": "CacheMisses;Mem",
         "MetricName": "tma_info_l2hpki_load",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.L2_MISS@ / INST_RET=
IRED.ANY",
         "MetricGroup": "Backend;CacheMisses;Mem",
         "MetricName": "tma_info_l2mpki",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all request types (including speculative)",
-        "MetricExpr": "1e3 * L2_RQSTS.MISS / INST_RETIRED.ANY",
+        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.MISS@ / INST_RETIRED.ANY",
         "MetricGroup": "CacheMisses;Mem;Offcore",
         "MetricName": "tma_info_l2mpki_all",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L2 cache true code cacheline misses per kilo =
instruction",
-        "MetricExpr": "1e3 * FRONTEND_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricExpr": "1e3 * cpu_core@FRONTEND_RETIRED.L2_MISS@ / INST_RET=
IRED.ANY",
         "MetricGroup": "IcMiss",
         "MetricName": "tma_info_l2mpki_code",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L2 cache speculative code cacheline misses pe=
r kilo instruction",
-        "MetricExpr": "1e3 * L2_RQSTS.CODE_RD_MISS / INST_RETIRED.ANY",
+        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.CODE_RD_MISS@ / INST_RETIRE=
D.ANY",
         "MetricGroup": "IcMiss",
         "MetricName": "tma_info_l2mpki_code_all",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all demand loads  (including speculative)",
-        "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_MISS / INST_RETIRED.A=
NY",
+        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.DEMAND_DATA_RD_MISS@ / INST=
_RETIRED.ANY",
         "MetricGroup": "CacheMisses;Mem",
         "MetricName": "tma_info_l2mpki_load",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1e9 / duration=
_time",
+        "MetricExpr": "64 * cpu_core@OFFCORE_REQUESTS.ALL_REQUESTS@ / 1e9 =
/ duration_time",
         "MetricGroup": "Mem;MemoryBW;Offcore",
         "MetricName": "tma_info_l3_cache_access_bw",
         "Unit": "cpu_core"
@@ -1737,7 +1737,7 @@
     },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / duration_time",
+        "MetricExpr": "64 * cpu_core@LONGEST_LAT_CACHE.MISS@ / 1e9 / durat=
ion_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_l3_cache_fill_bw",
         "Unit": "cpu_core"
@@ -1751,7 +1751,7 @@
     },
     {
         "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY",
+        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.L3_MISS@ / INST_RET=
IRED.ANY",
         "MetricGroup": "CacheMisses;Mem",
         "MetricName": "tma_info_l3mpki",
         "Unit": "cpu_core"
@@ -1786,14 +1786,14 @@
     },
     {
         "BriefDescription": "STLB (2nd level TLB) data load speculative mi=
sses per kilo instruction (misses of any page-size that complete the page w=
alk)",
-        "MetricExpr": "1e3 * DTLB_LOAD_MISSES.WALK_COMPLETED / INST_RETIRE=
D.ANY",
+        "MetricExpr": "1e3 * cpu_core@DTLB_LOAD_MISSES.WALK_COMPLETED@ / I=
NST_RETIRED.ANY",
         "MetricGroup": "Mem;MemoryTLB",
         "MetricName": "tma_info_load_stlb_mpki",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Fraction of Uops delivered by the LSD (Loop S=
tream Detector; aka Loop Cache)",
-        "MetricExpr": "LSD.UOPS / UOPS_ISSUED.ANY",
+        "MetricExpr": "LSD.UOPS / cpu_core@UOPS_ISSUED.ANY@",
         "MetricGroup": "Fed;LSD",
         "MetricName": "tma_info_lsd_coverage",
         "Unit": "cpu_core"
@@ -1877,7 +1877,7 @@
     },
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
-        "MetricExpr": "(ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_P=
ENDING + DTLB_STORE_MISSES.WALK_PENDING) / (4 * tma_info_core_clks)",
+        "MetricExpr": "(cpu_core@ITLB_MISSES.WALK_PENDING@ + cpu_core@DTLB=
_LOAD_MISSES.WALK_PENDING@ + cpu_core@DTLB_STORE_MISSES.WALK_PENDING@) / (4=
 * tma_info_core_clks)",
         "MetricGroup": "Mem;MemoryTLB",
         "MetricName": "tma_info_page_walks_utilization",
         "MetricThreshold": "tma_info_page_walks_utilization > 0.5",
@@ -1893,21 +1893,21 @@
     },
     {
         "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
-        "MetricExpr": "TOPDOWN.SLOTS",
+        "MetricExpr": "cpu_core@TOPDOWN.SLOTS@",
         "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_info_slots",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Fraction of Physical Core issue-slots utilize=
d by this Logical Processor",
-        "MetricExpr": "(tma_info_slots / (TOPDOWN.SLOTS / 2) if #SMT_on el=
se 1)",
+        "MetricExpr": "(tma_info_slots / (cpu_core@TOPDOWN.SLOTS@ / 2) if =
#SMT_on else 1)",
         "MetricGroup": "SMT;TmaL1;tma_L1_group",
         "MetricName": "tma_info_slots_utilization",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
-        "MetricExpr": "(1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_U=
NHALTED.REF_DISTRIBUTED if #SMT_on else 0)",
+        "MetricExpr": "(1 - cpu_core@CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE@ /=
 cpu_core@CPU_CLK_UNHALTED.REF_DISTRIBUTED@ if #SMT_on else 0)",
         "MetricGroup": "SMT",
         "MetricName": "tma_info_smt_2t_utilization",
         "Unit": "cpu_core"
@@ -1921,7 +1921,7 @@
     },
     {
         "BriefDescription": "STLB (2nd level TLB) data store speculative m=
isses per kilo instruction (misses of any page-size that complete the page =
walk)",
-        "MetricExpr": "1e3 * DTLB_STORE_MISSES.WALK_COMPLETED / INST_RETIR=
ED.ANY",
+        "MetricExpr": "1e3 * cpu_core@DTLB_STORE_MISSES.WALK_COMPLETED@ / =
INST_RETIRED.ANY",
         "MetricGroup": "Mem;MemoryTLB",
         "MetricName": "tma_info_store_stlb_mpki",
         "Unit": "cpu_core"
@@ -1969,7 +1969,7 @@
     },
     {
         "BriefDescription": "This metric represents 128-bit vector Integer=
 ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction the=
 CPU has retired",
-        "MetricExpr": "(INT_VEC_RETIRED.ADD_128 + INT_VEC_RETIRED.VNNI_128=
) / (tma_retiring * tma_info_slots)",
+        "MetricExpr": "(cpu_core@INT_VEC_RETIRED.ADD_128@ + cpu_core@INT_V=
EC_RETIRED.VNNI_128@) / (tma_retiring * tma_info_slots)",
         "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_L4_group;=
tma_int_operations_group;tma_issue2P",
         "MetricName": "tma_int_vector_128b",
         "MetricThreshold": "tma_int_vector_128b > 0.1 & (tma_int_operation=
s > 0.1 & tma_light_operations > 0.6)",
@@ -1979,7 +1979,7 @@
     },
     {
         "BriefDescription": "This metric represents 256-bit vector Integer=
 ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction the=
 CPU has retired",
-        "MetricExpr": "(INT_VEC_RETIRED.ADD_256 + INT_VEC_RETIRED.MUL_256 =
+ INT_VEC_RETIRED.VNNI_256) / (tma_retiring * tma_info_slots)",
+        "MetricExpr": "(cpu_core@INT_VEC_RETIRED.ADD_256@ + cpu_core@INT_V=
EC_RETIRED.MUL_256@ + cpu_core@INT_VEC_RETIRED.VNNI_256@) / (tma_retiring *=
 tma_info_slots)",
         "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_L4_group;=
tma_int_operations_group;tma_issue2P",
         "MetricName": "tma_int_vector_256b",
         "MetricThreshold": "tma_int_vector_256b > 0.1 & (tma_int_operation=
s > 0.1 & tma_light_operations > 0.6)",
@@ -1999,7 +1999,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache",
-        "MetricExpr": "max((EXE_ACTIVITY.BOUND_ON_LOADS - MEMORY_ACTIVITY.=
STALLS_L1D_MISS) / tma_info_clks, 0)",
+        "MetricExpr": "max((cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@ - cpu_co=
re@MEMORY_ACTIVITY.STALLS_L1D_MISS@) / tma_info_clks, 0)",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_issueL1;tma_issueMC;tma_memory_bound_group",
         "MetricName": "tma_l1_bound",
         "MetricThreshold": "tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2)",
@@ -2010,7 +2010,7 @@
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(MEMORY_ACTIVITY.STALLS_L1D_MISS - MEMORY_ACTIVITY.=
STALLS_L2_MISS) / tma_info_clks",
+        "MetricExpr": "(cpu_core@MEMORY_ACTIVITY.STALLS_L1D_MISS@ - cpu_co=
re@MEMORY_ACTIVITY.STALLS_L2_MISS@) / tma_info_clks",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
         "MetricName": "tma_l2_bound",
         "MetricThreshold": "tma_l2_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
@@ -2020,7 +2020,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
-        "MetricExpr": "(MEMORY_ACTIVITY.STALLS_L2_MISS - MEMORY_ACTIVITY.S=
TALLS_L3_MISS) / tma_info_clks",
+        "MetricExpr": "(cpu_core@MEMORY_ACTIVITY.STALLS_L2_MISS@ - cpu_cor=
e@MEMORY_ACTIVITY.STALLS_L3_MISS@) / tma_info_clks",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
         "MetricThreshold": "tma_l3_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
@@ -2030,7 +2030,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited)",
-        "MetricExpr": "9 * tma_info_average_frequency * MEM_LOAD_RETIRED.L=
3_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_=
info_clks",
+        "MetricExpr": "9 * tma_info_average_frequency * cpu_core@MEM_LOAD_=
RETIRED.L3_HIT@ * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOA=
D_RETIRED.L1_MISS@ / 2) / tma_info_clks",
         "MetricGroup": "MemoryLat;TopdownL4;tma_L4_group;tma_issueLat;tma_=
l3_bound_group",
         "MetricName": "tma_l3_hit_latency",
         "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound > 0.0=
5 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -2090,7 +2090,7 @@
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(16 * max(0, MEM_INST_RETIRED.LOCK_LOADS - L2_RQSTS=
.ALL_RFO) + MEM_INST_RETIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES * (10=
 * L2_RQSTS.RFO_HIT + min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTAN=
DING.CYCLES_WITH_DEMAND_RFO))) / tma_info_clks",
+        "MetricExpr": "(16 * max(0, cpu_core@MEM_INST_RETIRED.LOCK_LOADS@ =
- cpu_core@L2_RQSTS.ALL_RFO@) + cpu_core@MEM_INST_RETIRED.LOCK_LOADS@ / cpu=
_core@MEM_INST_RETIRED.ALL_STORES@ * (10 * cpu_core@L2_RQSTS.RFO_HIT@ + min=
(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFFCORE_REQUESTS_OUTSTANDING.C=
YCLES_WITH_DEMAND_RFO@))) / tma_info_clks",
         "MetricGroup": "Offcore;TopdownL4;tma_L4_group;tma_issueRFO;tma_l1=
_bound_group",
         "MetricName": "tma_lock_latency",
         "MetricThreshold": "tma_lock_latency > 0.2 & (tma_l1_bound > 0.1 &=
 (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -2100,7 +2100,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to LSD (Loop Stream Detector) unit",
-        "MetricExpr": "(LSD.CYCLES_ACTIVE - LSD.CYCLES_OK) / tma_info_core=
_clks / 2",
+        "MetricExpr": "(cpu_core@LSD.CYCLES_ACTIVE@ - cpu_core@LSD.CYCLES_=
OK@) / tma_info_core_clks / 2",
         "MetricGroup": "FetchBW;LSD;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
         "MetricName": "tma_lsd",
         "MetricThreshold": "tma_lsd > 0.15 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_ipc / 6 > 0.35)",
@@ -2121,7 +2121,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory (DRAM)",
-        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu_core@OFFCORE_REQUE=
STS_OUTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_clks",
+        "MetricExpr": "min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFF=
CORE_REQUESTS_OUTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_clks",
         "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_dram_b=
ound_group;tma_issueBW",
         "MetricName": "tma_mem_bandwidth",
         "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_dram_bound > 0.=
1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -2131,7 +2131,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the performance was likely hurt due to latency from external memory (DRAM=
)",
-        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DATA_RD) / tma_info_clks - tma_mem_bandwidth",
+        "MetricExpr": "min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFF=
CORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD@) / tma_info_clks - tma_mem_b=
andwidth",
         "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_dram_=
bound_group;tma_issueLat",
         "MetricName": "tma_mem_latency",
         "MetricThreshold": "tma_mem_latency > 0.1 & (tma_dram_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -2141,7 +2141,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
-        "MetricExpr": "min(tma_backend_bound, LD_HEAD.ANY_AT_RET / tma_inf=
o_clks + tma_store_bound)",
+        "MetricExpr": "cpu_core@topdown\\-mem\\-bound@ / (cpu_core@topdown=
\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiri=
ng@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_slots",
         "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_b=
ound_group",
         "MetricName": "tma_memory_bound",
         "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0=
.2",
@@ -2152,7 +2152,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to LFENCE Instructions.",
-        "MetricExpr": "13 * MISC2_RETIRED.LFENCE / tma_info_clks",
+        "MetricExpr": "13 * cpu_core@MISC2_RETIRED.LFENCE@ / tma_info_clks=
",
         "MetricGroup": "TopdownL6;tma_L6_group;tma_serializing_operation_g=
roup",
         "MetricName": "tma_memory_fence",
         "MetricThreshold": "tma_memory_fence > 0.05 & (tma_serializing_ope=
ration > 0.1 & (tma_ports_utilized_0 > 0.2 & (tma_ports_utilization > 0.15 =
& (tma_core_bound > 0.1 & tma_backend_bound > 0.2))))",
@@ -2162,7 +2162,7 @@
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations -- uops for memory load or store a=
ccesses.",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "tma_light_operations * MEM_UOP_RETIRED.ANY / (tma_r=
etiring * tma_info_slots)",
+        "MetricExpr": "tma_light_operations * cpu_core@MEM_UOP_RETIRED.ANY=
@ / (tma_retiring * tma_info_slots)",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_memory_operations",
         "MetricThreshold": "tma_memory_operations > 0.1 & tma_light_operat=
ions > 0.6",
@@ -2181,7 +2181,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Branch Misprediction=
 at execution stage",
-        "MetricExpr": "tma_branch_mispredicts / tma_bad_speculation * INT_=
MISC.CLEAR_RESTEER_CYCLES / tma_info_clks",
+        "MetricExpr": "tma_branch_mispredicts / tma_bad_speculation * cpu_=
core@INT_MISC.CLEAR_RESTEER_CYCLES@ / tma_info_clks",
         "MetricGroup": "BadSpec;BrMispredicts;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group;tma_issueBM",
         "MetricName": "tma_mispredicts_resteers",
         "MetricThreshold": "tma_mispredicts_resteers > 0.05 & (tma_branch_=
resteers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
@@ -2191,7 +2191,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the MITE pipeline (the legacy deco=
de pipeline)",
-        "MetricExpr": "(IDQ.MITE_CYCLES_ANY - IDQ.MITE_CYCLES_OK) / tma_in=
fo_core_clks / 2",
+        "MetricExpr": "(cpu_core@IDQ.MITE_CYCLES_ANY@ - cpu_core@IDQ.MITE_=
CYCLES_OK@) / tma_info_core_clks / 2",
         "MetricGroup": "DSBmiss;FetchBW;TopdownL3;tma_L3_group;tma_fetch_b=
andwidth_group",
         "MetricName": "tma_mite",
         "MetricThreshold": "tma_mite > 0.1 & (tma_fetch_bandwidth > 0.1 & =
tma_frontend_bound > 0.15 & tma_info_ipc / 6 > 0.35)",
@@ -2201,7 +2201,7 @@
     },
     {
         "BriefDescription": "The Mixing_Vectors metric gives the percentag=
e of injected blend uops out of all uops issued",
-        "MetricExpr": "160 * ASSISTS.SSE_AVX_MIX / tma_info_clks",
+        "MetricExpr": "160 * cpu_core@ASSISTS.SSE_AVX_MIX@ / tma_info_clks=
",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_issueMV;tma_ports_utili=
zed_0_group",
         "MetricName": "tma_mixing_vectors",
         "MetricThreshold": "tma_mixing_vectors > 0.05",
@@ -2211,7 +2211,7 @@
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS)",
-        "MetricExpr": "3 * cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D1\\,edge@ =
/ (tma_retiring * tma_info_slots / UOPS_ISSUED.ANY) / tma_info_clks",
+        "MetricExpr": "3 * cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D1\\,edge@ =
/ (tma_retiring * tma_info_slots / cpu_core@UOPS_ISSUED.ANY@) / tma_info_cl=
ks",
         "MetricGroup": "FetchLat;MicroSeq;TopdownL3;tma_L3_group;tma_fetch=
_latency_group;tma_issueMC;tma_issueMS;tma_issueMV;tma_issueSO",
         "MetricName": "tma_ms_switches",
         "MetricThreshold": "tma_ms_switches > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
@@ -2221,7 +2221,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring branch instructions that were not fused",
-        "MetricExpr": "tma_light_operations * (BR_INST_RETIRED.ALL_BRANCHE=
S - INST_RETIRED.MACRO_FUSED) / (tma_retiring * tma_info_slots)",
+        "MetricExpr": "tma_light_operations * (cpu_core@BR_INST_RETIRED.AL=
L_BRANCHES@ - cpu_core@INST_RETIRED.MACRO_FUSED@) / (tma_retiring * tma_inf=
o_slots)",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_non_fused_branches",
         "MetricThreshold": "tma_non_fused_branches > 0.1 & tma_light_opera=
tions > 0.6",
@@ -2231,7 +2231,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring NOP (no op) instructions",
-        "MetricExpr": "tma_light_operations * INST_RETIRED.NOP / (tma_reti=
ring * tma_info_slots)",
+        "MetricExpr": "tma_light_operations * cpu_core@INST_RETIRED.NOP@ /=
 (tma_retiring * tma_info_slots)",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_nop_instructions",
         "MetricThreshold": "tma_nop_instructions > 0.1 & tma_light_operati=
ons > 0.6",
@@ -2252,7 +2252,7 @@
     },
     {
         "BriefDescription": "This metric roughly estimates fraction of slo=
ts the CPU retired uops as a result of handing Page Faults",
-        "MetricExpr": "99 * ASSISTS.PAGE_FAULT / tma_info_slots",
+        "MetricExpr": "99 * cpu_core@ASSISTS.PAGE_FAULT@ / tma_info_slots"=
,
         "MetricGroup": "TopdownL5;tma_L5_group;tma_assists_group",
         "MetricName": "tma_page_faults",
         "MetricThreshold": "tma_page_faults > 0.05",
@@ -2292,7 +2292,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
-        "MetricExpr": "((cpu_core@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x=
80@ + tma_serializing_operation * (CYCLE_ACTIVITY.STALLS_TOTAL - EXE_ACTIVI=
TY.BOUND_ON_LOADS) + (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * cpu_core@E=
XE_ACTIVITY.2_PORTS_UTIL\\,umask\\=3D0xc@)) / tma_info_clks if ARITH.DIV_AC=
TIVE < CYCLE_ACTIVITY.STALLS_TOTAL - EXE_ACTIVITY.BOUND_ON_LOADS else (EXE_=
ACTIVITY.1_PORTS_UTIL + tma_retiring * cpu_core@EXE_ACTIVITY.2_PORTS_UTIL\\=
,umask\\=3D0xc@) / tma_info_clks)",
+        "MetricExpr": "((cpu_core@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x=
80@ + tma_serializing_operation * (cpu_core@CYCLE_ACTIVITY.STALLS_TOTAL@ - =
cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@) + (cpu_core@EXE_ACTIVITY.1_PORTS_UTI=
L@ + tma_retiring * cpu_core@EXE_ACTIVITY.2_PORTS_UTIL\\,umask\\=3D0xc@)) /=
 tma_info_clks if cpu_core@ARITH.DIV_ACTIVE@ < cpu_core@CYCLE_ACTIVITY.STAL=
LS_TOTAL@ - cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@ else (cpu_core@EXE_ACTIVI=
TY.1_PORTS_UTIL@ + tma_retiring * cpu_core@EXE_ACTIVITY.2_PORTS_UTIL\\,umas=
k\\=3D0xc@) / tma_info_clks)",
         "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
         "MetricName": "tma_ports_utilization",
         "MetricThreshold": "tma_ports_utilization > 0.15 & (tma_core_bound=
 > 0.1 & tma_backend_bound > 0.2)",
@@ -2302,7 +2302,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
-        "MetricExpr": "cpu_core@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x80=
@ / tma_info_clks + tma_serializing_operation * (CYCLE_ACTIVITY.STALLS_TOTA=
L - EXE_ACTIVITY.BOUND_ON_LOADS) / tma_info_clks",
+        "MetricExpr": "cpu_core@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x80=
@ / tma_info_clks + tma_serializing_operation * (cpu_core@CYCLE_ACTIVITY.ST=
ALLS_TOTAL@ - cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@) / tma_info_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_0",
         "MetricThreshold": "tma_ports_utilized_0 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -2342,7 +2342,7 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
-        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_info_=
slots",
+        "MetricExpr": "cpu_core@topdown\\-retiring@ / (cpu_core@topdown\\-=
fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiring@=
 + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_slots",
         "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
@@ -2382,7 +2382,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles hand=
ling memory load split accesses - load that cross 64-byte cache line bounda=
ry",
-        "MetricExpr": "tma_info_load_miss_real_latency * LD_BLOCKS.NO_SR /=
 tma_info_clks",
+        "MetricExpr": "tma_info_load_miss_real_latency * cpu_core@LD_BLOCK=
S.NO_SR@ / tma_info_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_split_loads",
         "MetricThreshold": "tma_split_loads > 0.2 & (tma_l1_bound > 0.1 & =
(tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -2402,7 +2402,7 @@
     },
     {
         "BriefDescription": "This metric measures fraction of cycles where=
 the Super Queue (SQ) was full taking into account all request-types and bo=
th hardware SMT threads (Logical Processors)",
-        "MetricExpr": "(XQ.FULL_CYCLES + L1D_PEND_MISS.L2_STALLS) / tma_in=
fo_clks",
+        "MetricExpr": "(cpu_core@XQ.FULL_CYCLES@ + cpu_core@L1D_PEND_MISS.=
L2_STALLS@) / tma_info_clks",
         "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_issueB=
W;tma_l3_bound_group",
         "MetricName": "tma_sq_full",
         "MetricThreshold": "tma_sq_full > 0.3 & (tma_l3_bound > 0.05 & (tm=
a_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -2422,7 +2422,7 @@
     },
     {
         "BriefDescription": "This metric roughly estimates fraction of cyc=
les when the memory subsystem had loads blocked since they could not forwar=
d data from earlier (in program order) overlapping stores",
-        "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / tma_info_clks",
+        "MetricExpr": "13 * cpu_core@LD_BLOCKS.STORE_FORWARD@ / tma_info_c=
lks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_store_fwd_blk",
         "MetricThreshold": "tma_store_fwd_blk > 0.1 & (tma_l1_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -2432,7 +2432,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
-        "MetricExpr": "(MEM_STORE_RETIRED.L2_HIT * 10 * (1 - MEM_INST_RETI=
RED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES) + (1 - MEM_INST_RETIRED.LOCK_=
LOADS / MEM_INST_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE=
_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / tma_info_clks",
+        "MetricExpr": "(cpu_core@MEM_STORE_RETIRED.L2_HIT@ * 10 * (1 - cpu=
_core@MEM_INST_RETIRED.LOCK_LOADS@ / cpu_core@MEM_INST_RETIRED.ALL_STORES@)=
 + (1 - cpu_core@MEM_INST_RETIRED.LOCK_LOADS@ / cpu_core@MEM_INST_RETIRED.A=
LL_STORES@) * min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFFCORE_REQUE=
STS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO@)) / tma_info_clks",
         "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_issue=
RFO;tma_issueSL;tma_store_bound_group",
         "MetricName": "tma_store_latency",
         "MetricThreshold": "tma_store_latency > 0.1 & (tma_store_bound > 0=
.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -2442,7 +2442,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Store operations",
-        "MetricExpr": "(UOPS_DISPATCHED.PORT_4_9 + UOPS_DISPATCHED.PORT_7_=
8) / (4 * tma_info_core_clks)",
+        "MetricExpr": "(cpu_core@UOPS_DISPATCHED.PORT_4_9@ + cpu_core@UOPS=
_DISPATCHED.PORT_7_8@) / (4 * tma_info_core_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_store_op_utilization",
         "MetricThreshold": "tma_store_op_utilization > 0.6",
@@ -2470,7 +2470,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to Streaming store memory accesses; Streaming store optimize out a =
read request required by RFO stores",
-        "MetricExpr": "9 * OCR.STREAMING_WR.ANY_RESPONSE / tma_info_clks",
+        "MetricExpr": "9 * cpu_core@OCR.STREAMING_WR.ANY_RESPONSE@ / tma_i=
nfo_clks",
         "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_issueS=
mSt;tma_store_bound_group",
         "MetricName": "tma_streaming_stores",
         "MetricThreshold": "tma_streaming_stores > 0.2 & (tma_store_bound =
> 0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -2490,7 +2490,7 @@
     },
     {
         "BriefDescription": "This metric serves as an approximation of leg=
acy x87 usage",
-        "MetricExpr": "tma_retiring * UOPS_EXECUTED.X87 / UOPS_EXECUTED.TH=
READ",
+        "MetricExpr": "tma_retiring * cpu_core@UOPS_EXECUTED.X87@ / UOPS_E=
XECUTED.THREAD",
         "MetricGroup": "Compute;TopdownL4;tma_L4_group;tma_fp_arith_group"=
,
         "MetricName": "tma_x87_use",
         "MetricThreshold": "tma_x87_use > 0.1 & (tma_fp_arith > 0.2 & tma_=
light_operations > 0.6)",
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json b/=
tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
index 0402adbf7d92..f4b3c3883643 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
@@ -193,7 +193,7 @@
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load miss which hit in DRAM or MMIO (Non-DRAM).",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_DRAM_HIT / tma_info_clks - ME=
M_BOUND_STALLS_AT_RET_CORRECTION * MEM_BOUND_STALLS.LOAD_DRAM_HIT / MEM_BOU=
ND_STALLS.LOAD",
+        "MetricExpr": "MEM_BOUND_STALLS.LOAD_DRAM_HIT / tma_info_clks - ma=
x((MEM_BOUND_STALLS.LOAD - LD_HEAD.L1_MISS_AT_RET) / tma_info_clks, 0) * ME=
M_BOUND_STALLS.LOAD_DRAM_HIT / MEM_BOUND_STALLS.LOAD",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
         "MetricName": "tma_dram_bound",
         "MetricThreshold": "tma_dram_bound > 0.1",
@@ -480,7 +480,7 @@
     {
         "BriefDescription": "Counts the number of cycles a core is stalled=
 due to a demand load which hit in the L2 Cache.",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_L2_HIT / tma_info_clks - MEM_=
BOUND_STALLS_AT_RET_CORRECTION * MEM_BOUND_STALLS.LOAD_L2_HIT / MEM_BOUND_S=
TALLS.LOAD",
+        "MetricExpr": "MEM_BOUND_STALLS.LOAD_L2_HIT / tma_info_clks - max(=
(MEM_BOUND_STALLS.LOAD - LD_HEAD.L1_MISS_AT_RET) / tma_info_clks, 0) * MEM_=
BOUND_STALLS.LOAD_L2_HIT / MEM_BOUND_STALLS.LOAD",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
         "MetricName": "tma_l2_bound",
         "MetricThreshold": "tma_l2_bound > 0.1",
@@ -488,7 +488,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles a core is stalled=
 due to a demand load which hit in the Last Level Cache (LLC) or other core=
 with HITE/F/M.",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_LLC_HIT / tma_info_clks - MEM=
_BOUND_STALLS_AT_RET_CORRECTION * MEM_BOUND_STALLS.LOAD_LLC_HIT / MEM_BOUND=
_STALLS.LOAD",
+        "MetricExpr": "MEM_BOUND_STALLS.LOAD_LLC_HIT / tma_info_clks - max=
((MEM_BOUND_STALLS.LOAD - LD_HEAD.L1_MISS_AT_RET) / tma_info_clks, 0) * MEM=
_BOUND_STALLS.LOAD_LLC_HIT / MEM_BOUND_STALLS.LOAD",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
         "MetricThreshold": "tma_l3_bound > 0.1",
--=20
2.40.1.495.gc816e09b53d-goog

