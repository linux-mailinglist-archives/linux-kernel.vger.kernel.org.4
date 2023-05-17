Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BAB706FA9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjEQRjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjEQRjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:39:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2B66A65
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:38:33 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba83fed50e1so1205994276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684345112; x=1686937112;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3O7hJ+fy8dZObxxDfcr/C0blUoJ6ZEQPSexRilXRyM=;
        b=qbwY/ndtML4yzkPkjWQgz7BPn4jt5Ke79cSloX2uKzukeyA0eCPZXNWm+YY67boP4E
         a/rXS2qyrFwkv5YZHRLr/QK8GYNQpEQfXuy6Kja1g4/W9kOz5e6OroYCVNDACOlzDLCE
         V+IxUOs9gydM75NBoxk3465XePNE2GQ9xqZ8fyZ/+WfWHcB5CUBvjXCAAcs9KAz9XHar
         ZG3eE4AptzOmUpRffEH64XnU34otzRyYowlzJEDerfiM+6o2uWbrhAcX+oHzvTmtdNrT
         gobdFW53wDBls/8FNojL3B0qwNwRUlpfMuV58Hpx8v96dx4bAc1br4aam5CWRbkWYU7C
         O8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684345112; x=1686937112;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z3O7hJ+fy8dZObxxDfcr/C0blUoJ6ZEQPSexRilXRyM=;
        b=LceKujyXmYLSqcs5IQdrzJgke2ZbgREWxubtE+XK9qXb+iVdr4ZMkHHxlvIDg2ycpb
         6t+Id0STHiKueGJctMK5ZTyHKy/7SeMat3kn3Q4JZQUvS6uQcS06YbyqaH2N0aj+u/K9
         Vtp5iICWHkv8n45wDzSgd+GLRlVtUM7BpnhiotLDKDYQB4ZEoKbmoQoXjXgKXbzIY1cF
         6XjlDOi99HUrvKEpTkH6XF6Q4UWSAuK5mpcvnZ8Y2lWVrnqfYhOj11lkGglSQz5o0J+f
         JSclnCHBTZ7Cgm5OQA5ymOtP2+9/e+RjD3sgtm1c5VNWbIjAoKB93UE/TQn+SuQmqYR2
         xWlw==
X-Gm-Message-State: AC+VfDz0EkLRfNEm58pv5Noy3jVGS2AaHbG8t2v9hCcxPCOnZVmqeObI
        PQ+eta/shSdxpnK96BPq3CpJAVBFuHUR
X-Google-Smtp-Source: ACHHUZ6wr/c4d5PoDxxReBE3+rxOo2FcCWRb1rWA9sj3nvkfHtXX6gEbK8daPgilC+DZHY3ZUqNTJadQPQuP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:eb06:5af6:40f:47ca])
 (user=irogers job=sendgmr) by 2002:a25:26d1:0:b0:ba2:2d0e:a752 with SMTP id
 m200-20020a2526d1000000b00ba22d0ea752mr1922085ybm.6.1684345112688; Wed, 17
 May 2023 10:38:32 -0700 (PDT)
Date:   Wed, 17 May 2023 10:37:56 -0700
In-Reply-To: <20230517173805.602113-1-irogers@google.com>
Message-Id: <20230517173805.602113-8-irogers@google.com>
Mime-Version: 1.0
References: <20230517173805.602113-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v3 07/15] perf vendor events intel: Update ivybridge/ivytown metrics
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

Metrics are updated to make TMA info metric names
synchronized. Metrics were generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/ivybridge/ivb-metrics.json       | 526 ++++++++---------
 .../arch/x86/ivytown/ivt-metrics.json         | 534 +++++++++---------
 2 files changed, 530 insertions(+), 530 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json b/to=
ols/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
index 11080ccffd51..33fe555252b2 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
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
@@ -81,7 +81,7 @@
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
-        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_0 + UOPS_DISPATCHED_PORT=
.PORT_1 + UOPS_DISPATCHED_PORT.PORT_5) / (3 * tma_info_core_clks)",
+        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_0 + UOPS_DISPATCHED_PORT=
.PORT_1 + UOPS_DISPATCHED_PORT.PORT_5) / (3 * tma_info_core_core_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_alu_op_utilization",
         "MetricThreshold": "tma_alu_op_utilization > 0.6",
@@ -89,7 +89,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops delivered by the Microcode_Sequencer as a result of Assists=
",
-        "MetricExpr": "100 * OTHER_ASSISTS.ANY_WB_ASSIST / tma_info_slots"=
,
+        "MetricExpr": "100 * OTHER_ASSISTS.ANY_WB_ASSIST / tma_info_thread=
_slots",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
         "MetricName": "tma_assists",
         "MetricThreshold": "tma_assists > 0.1 & (tma_microcode_sequencer >=
 0.05 & tma_heavy_operations > 0.1)",
@@ -109,7 +109,7 @@
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
@@ -125,12 +125,12 @@
         "MetricName": "tma_branch_mispredicts",
         "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specula=
tion > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics:=
 tma_info_branch_misprediction_cost, tma_mispredicts_resteers",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics:=
 tma_info_bad_spec_branch_misprediction_cost, tma_mispredicts_resteers",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers",
-        "MetricExpr": "12 * (BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS=
.COUNT + BACLEARS.ANY) / tma_info_clks",
+        "MetricExpr": "12 * (BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS=
.COUNT + BACLEARS.ANY) / tma_info_thread_clks",
         "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group",
         "MetricName": "tma_branch_resteers",
         "MetricThreshold": "tma_branch_resteers > 0.05 & (tma_fetch_latenc=
y > 0.1 & tma_frontend_bound > 0.15)",
@@ -150,7 +150,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(60 * (MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM * (1=
 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD=
_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD_U=
OPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS + M=
EM_LOAD_UOPS_RETIRED.LLC_MISS))) + 43 * (MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP=
_MISS * (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT =
+ MEM_LOAD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + =
MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSN=
P_MISS + MEM_LOAD_UOPS_RETIRED.LLC_MISS)))) / tma_info_clks",
+        "MetricExpr": "(60 * (MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM * (1=
 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD=
_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD_U=
OPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS + M=
EM_LOAD_UOPS_RETIRED.LLC_MISS))) + 43 * (MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP=
_MISS * (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT =
+ MEM_LOAD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + =
MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSN=
P_MISS + MEM_LOAD_UOPS_RETIRED.LLC_MISS)))) / tma_info_thread_clks",
         "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_l3_bound_group",
         "MetricName": "tma_contested_accesses",
         "MetricThreshold": "tma_contested_accesses > 0.05 & (tma_l3_bound =
> 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -171,7 +171,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "43 * (MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT * (1 +=
 MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_U=
OPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOP=
S_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS + MEM=
_LOAD_UOPS_RETIRED.LLC_MISS))) / tma_info_clks",
+        "MetricExpr": "43 * (MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT * (1 +=
 MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_U=
OPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOP=
S_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS + MEM=
_LOAD_UOPS_RETIRED.LLC_MISS))) / tma_info_thread_clks",
         "MetricGroup": "Offcore;Snoop;TopdownL4;tma_L4_group;tma_issueSync=
xn;tma_l3_bound_group",
         "MetricName": "tma_data_sharing",
         "MetricThreshold": "tma_data_sharing > 0.05 & (tma_l3_bound > 0.05=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -180,7 +180,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re the Divider unit was active",
-        "MetricExpr": "ARITH.FPU_DIV_ACTIVE / tma_info_core_clks",
+        "MetricExpr": "ARITH.FPU_DIV_ACTIVE / tma_info_core_core_clks",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_core_bound_group",
         "MetricName": "tma_divider",
         "MetricThreshold": "tma_divider > 0.2 & (tma_core_bound > 0.1 & tm=
a_backend_bound > 0.2)",
@@ -190,7 +190,7 @@
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
         "MetricConstraint": "NO_GROUP_EVENTS_SMT",
-        "MetricExpr": "(1 - MEM_LOAD_UOPS_RETIRED.LLC_HIT / (MEM_LOAD_UOPS=
_RETIRED.LLC_HIT + 7 * MEM_LOAD_UOPS_RETIRED.LLC_MISS)) * CYCLE_ACTIVITY.ST=
ALLS_L2_PENDING / tma_info_clks",
+        "MetricExpr": "(1 - MEM_LOAD_UOPS_RETIRED.LLC_HIT / (MEM_LOAD_UOPS=
_RETIRED.LLC_HIT + 7 * MEM_LOAD_UOPS_RETIRED.LLC_MISS)) * CYCLE_ACTIVITY.ST=
ALLS_L2_PENDING / tma_info_thread_clks",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_dram_bound",
         "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2)",
@@ -199,25 +199,25 @@
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
 this metric measures the exposed penalty. Related metrics: tma_fetch_bandw=
idth, tma_info_dsb_coverage, tma_info_iptb, tma_lcp",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Related metrics: tma_fetch_bandw=
idth, tma_info_frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
-        "MetricExpr": "(7 * DTLB_LOAD_MISSES.STLB_HIT + DTLB_LOAD_MISSES.W=
ALK_DURATION) / tma_info_clks",
+        "MetricExpr": "(7 * DTLB_LOAD_MISSES.STLB_HIT + DTLB_LOAD_MISSES.W=
ALK_DURATION) / tma_info_thread_clks",
         "MetricGroup": "MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB;tma_=
l1_bound_group",
         "MetricName": "tma_dtlb_load",
         "MetricThreshold": "tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & (t=
ma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -226,7 +226,7 @@
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
-        "MetricExpr": "(7 * DTLB_STORE_MISSES.STLB_HIT + DTLB_STORE_MISSES=
.WALK_DURATION) / tma_info_clks",
+        "MetricExpr": "(7 * DTLB_STORE_MISSES.STLB_HIT + DTLB_STORE_MISSES=
.WALK_DURATION) / tma_info_thread_clks",
         "MetricGroup": "MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB;tma_=
store_bound_group",
         "MetricName": "tma_dtlb_store",
         "MetricThreshold": "tma_dtlb_store > 0.05 & (tma_store_bound > 0.2=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -235,7 +235,7 @@
     },
     {
         "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
-        "MetricExpr": "60 * OFFCORE_RESPONSE.DEMAND_RFO.LLC_HIT.HITM_OTHER=
_CORE / tma_info_clks",
+        "MetricExpr": "60 * OFFCORE_RESPONSE.DEMAND_RFO.LLC_HIT.HITM_OTHER=
_CORE / tma_info_thread_clks",
         "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_store_bound_group",
         "MetricName": "tma_false_sharing",
         "MetricThreshold": "tma_false_sharing > 0.05 & (tma_store_bound > =
0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -245,11 +245,11 @@
     {
         "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
         "MetricConstraint": "NO_GROUP_EVENTS",
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
 external memory). Related metrics: tma_info_dram_bw_use, tma_mem_bandwidth=
, tma_sq_full, tma_store_latency, tma_streaming_stores",
+        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_info_system_dram_bw_use, tma_mem_ba=
ndwidth, tma_sq_full, tma_store_latency, tma_streaming_stores",
         "ScaleUnit": "100%"
     },
     {
@@ -257,14 +257,14 @@
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
e Frontend typically delivers suboptimal amount of uops to the Backend. Rel=
ated metrics: tma_dsb_switches, tma_info_dsb_coverage, tma_info_iptb, tma_l=
cp",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Rel=
ated metrics: tma_dsb_switches, tma_info_frontend_dsb_coverage, tma_info_in=
st_mix_iptb, tma_lcp",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues",
-        "MetricExpr": "4 * min(CPU_CLK_UNHALTED.THREAD, IDQ_UOPS_NOT_DELIV=
ERED.CYCLES_0_UOPS_DELIV.CORE) / tma_info_slots",
+        "MetricExpr": "4 * min(CPU_CLK_UNHALTED.THREAD, IDQ_UOPS_NOT_DELIV=
ERED.CYCLES_0_UOPS_DELIV.CORE) / tma_info_thread_slots",
         "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend=
_bound_group",
         "MetricName": "tma_fetch_latency",
         "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound >=
 0.15",
@@ -301,7 +301,7 @@
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
@@ -321,358 +321,358 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses.",
-        "MetricExpr": "ICACHE.IFETCH_STALL / tma_info_clks - tma_itlb_miss=
es",
+        "MetricExpr": "ICACHE.IFETCH_STALL / tma_info_thread_clks - tma_it=
lb_misses",
         "MetricGroup": "BigFoot;FetchLat;IcMiss;TopdownL3;tma_L3_group;tma=
_fetch_latency_group",
         "MetricName": "tma_icache_misses",
         "MetricThreshold": "tma_icache_misses > 0.05 & (tma_fetch_latency =
> 0.1 & tma_frontend_bound > 0.15)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Measured Average Frequency for unhalted proce=
ssors [GHz]",
-        "MetricExpr": "tma_info_turbo_utilization * TSC / 1e9 / duration_t=
ime",
-        "MetricGroup": "Power;Summary",
-        "MetricName": "tma_info_average_frequency"
-    },
-    {
-        "BriefDescription": "Branch instructions per taken branch.",
-        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
-        "MetricGroup": "Branches;Fed;PGO",
-        "MetricName": "tma_info_bptkbranch"
+        "BriefDescription": "Instructions per retired mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
+        "MetricExpr": "tma_info_inst_mix_instructions / (UOPS_RETIRED.RETI=
RE_SLOTS / UOPS_ISSUED.ANY * cpu@BR_MISP_EXEC.ALL_BRANCHES\\,umask\\=3D0xE4=
@)",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "tma_info_bad_spec_ipmisp_indirect",
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1e3"
     },
     {
-        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "Pipeline",
-        "MetricName": "tma_info_clks"
+        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts",
+        "MetricName": "tma_info_bad_spec_ipmispredict",
+        "MetricThreshold": "tma_info_bad_spec_ipmispredict < 200"
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
-    },
-    {
-        "BriefDescription": "Average Parallel L2 cache miss data reads",
-        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD / OFFCORE_=
REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
-        "MetricGroup": "Memory_BW;Offcore",
-        "MetricName": "tma_info_data_l2_mlp"
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricExpr": "(FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EX=
E.SSE_SCALAR_DOUBLE + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * (FP_COMP_=
OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE) + 8 * SIMD_FP_256.PA=
CKED_SINGLE) / tma_info_core_core_clks",
+        "MetricGroup": "Flops;Ret",
+        "MetricName": "tma_info_core_flopc"
     },
     {
-        "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
-        "MetricExpr": "64 * (UNC_ARB_TRK_REQUESTS.ALL + UNC_ARB_COH_TRK_RE=
QUESTS.ALL) / 1e6 / duration_time / 1e3",
-        "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
-        "MetricName": "tma_info_dram_bw_use",
-        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_fb_full, tma_mem_bandwidth,=
 tma_sq_full"
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (cpu@UOPS_EXECUTED.CORE\\,cm=
ask\\=3D1@ / 2 if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
+        "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
+        "MetricName": "tma_info_core_ilp"
     },
     {
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
         "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_=
UOPS + IDQ.MS_UOPS)",
         "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
-        "MetricName": "tma_info_dsb_coverage",
-        "MetricThreshold": "tma_info_dsb_coverage < 0.7 & tma_info_ipc / 4=
 > 0.35",
-        "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_iptb, tma_lcp"
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
-        "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricExpr": "(FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EX=
E.SSE_SCALAR_DOUBLE + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * (FP_COMP_=
OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE) + 8 * SIMD_FP_256.PA=
CKED_SINGLE) / tma_info_core_clks",
-        "MetricGroup": "Flops;Ret",
-        "MetricName": "tma_info_flopc"
+        "MetricName": "tma_info_frontend_dsb_coverage",
+        "MetricThreshold": "tma_info_frontend_dsb_coverage < 0.7 & tma_inf=
o_thread_ipc / 4 > 0.35",
+        "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_inst_mix_iptb, tma_lcp"
     },
     {
-        "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "(FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EX=
E.SSE_SCALAR_DOUBLE + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * (FP_COMP_=
OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE) + 8 * SIMD_FP_256.PA=
CKED_SINGLE) / 1e9 / duration_time",
-        "MetricGroup": "Cor;Flops;HPC",
-        "MetricName": "tma_info_gflops",
-        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine."
+        "BriefDescription": "Instructions per speculative Unknown Branch M=
isprediction (BAClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "tma_info_inst_mix_instructions / BACLEARS.ANY",
+        "MetricGroup": "Fed",
+        "MetricName": "tma_info_frontend_ipunknown_branch"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (cpu@UOPS_EXECUTED.CORE\\,cm=
ask\\=3D1@ / 2 if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
-        "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
-        "MetricName": "tma_info_ilp"
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
         "BriefDescription": "Instructions per FP Arithmetic instruction (l=
ower number means higher occurrence rate)",
         "MetricExpr": "1 / (tma_fp_scalar + tma_fp_vector)",
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
         "BriefDescription": "Instructions per Load (lower number means hig=
her occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_LOADS",
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
         "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_STORES",
         "MetricGroup": "InsType",
-        "MetricName": "tma_info_ipstore",
-        "MetricThreshold": "tma_info_ipstore < 8"
+        "MetricName": "tma_info_inst_mix_ipstore",
+        "MetricThreshold": "tma_info_inst_mix_ipstore < 8"
     },
     {
         "BriefDescription": "Instruction per taken branch",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
         "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO;tma_issueFB",
-        "MetricName": "tma_info_iptb",
-        "MetricThreshold": "tma_info_iptb < 9",
-        "PublicDescription": "Instruction per taken branch. Related metric=
s: tma_dsb_switches, tma_fetch_bandwidth, tma_info_dsb_coverage, tma_lcp"
-    },
-    {
-        "BriefDescription": "Instructions per speculative Unknown Branch M=
isprediction (BAClear) (lower number means higher occurrence rate)",
-        "MetricExpr": "tma_info_instructions / BACLEARS.ANY",
-        "MetricGroup": "Fed",
-        "MetricName": "tma_info_ipunknown_branch"
-    },
-    {
-        "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
-        "MetricGroup": "OS",
-        "MetricName": "tma_info_kernel_cpi"
-    },
-    {
-        "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.THRE=
AD",
-        "MetricGroup": "OS",
-        "MetricName": "tma_info_kernel_utilization",
-        "MetricThreshold": "tma_info_kernel_utilization > 0.05"
+        "MetricName": "tma_info_inst_mix_iptb",
+        "MetricThreshold": "tma_info_inst_mix_iptb < 9",
+        "PublicDescription": "Instruction per taken branch. Related metric=
s: tma_dsb_switches, tma_fetch_bandwidth, tma_info_frontend_dsb_coverage, t=
ma_lcp"
     },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
         "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / duration_time",
         "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l1d_cache_fill_bw"
-    },
-    {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
-        "MetricExpr": "tma_info_l1d_cache_fill_bw",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l1d_cache_fill_bw_1t"
-    },
-    {
-        "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1e3 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED.=
ANY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l1mpki"
+        "MetricName": "tma_info_memory_core_l1d_cache_fill_bw"
     },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
         "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / duration_time",
         "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l2_cache_fill_bw"
+        "MetricName": "tma_info_memory_core_l2_cache_fill_bw"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
-        "MetricExpr": "tma_info_l2_cache_fill_bw",
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / duration_time",
         "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l2_cache_fill_bw_1t"
+        "MetricName": "tma_info_memory_core_l3_cache_fill_bw"
+    },
+    {
+        "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1e3 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED.=
ANY",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "tma_info_memory_l1mpki"
     },
     {
         "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1e3 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.=
ANY",
         "MetricGroup": "Backend;CacheMisses;Mem",
-        "MetricName": "tma_info_l2mpki"
+        "MetricName": "tma_info_memory_l2mpki"
     },
     {
-        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
-        "MetricExpr": "0",
-        "MetricGroup": "Mem;MemoryBW;Offcore",
-        "MetricName": "tma_info_l3_cache_access_bw_1t"
+        "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1e3 * MEM_LOAD_UOPS_RETIRED.LLC_MISS / INST_RETIRED=
.ANY",
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
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / (MEM_LOAD_UOPS_RETIRED.L1_M=
ISS + MEM_LOAD_UOPS_RETIRED.HIT_LFB)",
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
+        "MetricConstraint": "NO_GROUP_EVENTS",
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
-        "MetricExpr": "1e3 * MEM_LOAD_UOPS_RETIRED.LLC_MISS / INST_RETIRED=
.ANY",
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
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / (MEM_LOAD_UOPS_RETIRED.L1_M=
ISS + MEM_LOAD_UOPS_RETIRED.HIT_LFB)",
-        "MetricGroup": "Mem;MemoryBound;MemoryLat",
-        "MetricName": "tma_info_load_miss_real_latency"
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_core_l1d_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_thread_l1d_cache_fill_bw_1t"
     },
     {
-        "BriefDescription": "Average number of parallel requests to extern=
al memory",
-        "MetricExpr": "UNC_ARB_TRK_OCCUPANCY.ALL / UNC_ARB_TRK_OCCUPANCY.C=
YCLES_WITH_ANY_REQUEST",
-        "MetricGroup": "Mem;SoC",
-        "MetricName": "tma_info_mem_parallel_requests",
-        "PublicDescription": "Average number of parallel requests to exter=
nal memory. Accounts for all requests"
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_core_l2_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_thread_l2_cache_fill_bw_1t"
     },
     {
-        "BriefDescription": "Average latency of all requests to external m=
emory (in Uncore cycles)",
-        "MetricExpr": "UNC_ARB_TRK_OCCUPANCY.ALL / UNC_ARB_TRK_REQUESTS.AL=
L",
-        "MetricGroup": "Mem;SoC",
-        "MetricName": "tma_info_mem_request_latency"
+        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
+        "MetricExpr": "0",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "tma_info_memory_thread_l3_cache_access_bw_1t"
     },
     {
-        "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLE=
S",
-        "MetricGroup": "Mem;MemoryBW;MemoryBound",
-        "MetricName": "tma_info_mlp",
-        "PublicDescription": "Memory-Level-Parallelism (average number of =
L1 miss demand load when there is at least one such miss. Per-Logical Proce=
ssor)"
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_core_l3_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_thread_l3_cache_fill_bw_1t"
     },
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
-        "MetricExpr": "(ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_=
DURATION + DTLB_STORE_MISSES.WALK_DURATION) / tma_info_core_clks",
+        "MetricExpr": "(ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_=
DURATION + DTLB_STORE_MISSES.WALK_DURATION) / tma_info_core_core_clks",
         "MetricGroup": "Mem;MemoryTLB",
-        "MetricName": "tma_info_page_walks_utilization",
-        "MetricThreshold": "tma_info_page_walks_utilization > 0.5"
+        "MetricName": "tma_info_memory_tlb_page_walks_utilization",
+        "MetricThreshold": "tma_info_memory_tlb_page_walks_utilization > 0=
.5"
+    },
+    {
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-thread",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D1@",
+        "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
+        "MetricName": "tma_info_pipeline_execute"
     },
     {
         "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / cpu@UOPS_RETIRED.RETIRE=
_SLOTS\\,cmask\\=3D1@",
         "MetricGroup": "Pipeline;Ret",
-        "MetricName": "tma_info_retire"
+        "MetricName": "tma_info_pipeline_retire"
     },
     {
-        "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
-        "MetricExpr": "4 * tma_info_core_clks",
-        "MetricGroup": "TmaL1;tma_L1_group",
-        "MetricName": "tma_info_slots"
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
ads and writes [GB / sec]. Related metrics: tma_fb_full, tma_mem_bandwidth,=
 tma_sq_full"
+    },
+    {
+        "BriefDescription": "Giga Floating Point Operations Per Second",
+        "MetricExpr": "(FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EX=
E.SSE_SCALAR_DOUBLE + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * (FP_COMP_=
OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE) + 8 * SIMD_FP_256.PA=
CKED_SINGLE) / 1e9 / duration_time",
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
+    },
+    {
+        "BriefDescription": "Average number of parallel requests to extern=
al memory",
+        "MetricExpr": "UNC_ARB_TRK_OCCUPANCY.ALL / UNC_ARB_TRK_OCCUPANCY.C=
YCLES_WITH_ANY_REQUEST",
+        "MetricGroup": "Mem;SoC",
+        "MetricName": "tma_info_system_mem_parallel_requests",
+        "PublicDescription": "Average number of parallel requests to exter=
nal memory. Accounts for all requests"
+    },
+    {
+        "BriefDescription": "Average latency of all requests to external m=
emory (in Uncore cycles)",
+        "MetricExpr": "UNC_ARB_TRK_OCCUPANCY.ALL / UNC_ARB_TRK_REQUESTS.AL=
L",
+        "MetricGroup": "Mem;SoC",
+        "MetricName": "tma_info_system_mem_request_latency"
     },
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
         "MetricExpr": "UNC_CLOCK.SOCKET",
         "MetricGroup": "SoC",
-        "MetricName": "tma_info_socket_clks"
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
-        "MetricExpr": "(12 * ITLB_MISSES.STLB_HIT + ITLB_MISSES.WALK_DURAT=
ION) / tma_info_clks",
+        "MetricExpr": "(12 * ITLB_MISSES.STLB_HIT + ITLB_MISSES.WALK_DURAT=
ION) / tma_info_thread_clks",
         "MetricGroup": "BigFoot;FetchLat;MemoryTLB;TopdownL3;tma_L3_group;=
tma_fetch_latency_group",
         "MetricName": "tma_itlb_misses",
         "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
@@ -681,7 +681,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache",
-        "MetricExpr": "max((min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.ST=
ALLS_LDM_PENDING) - CYCLE_ACTIVITY.STALLS_L1D_PENDING) / tma_info_clks, 0)"=
,
+        "MetricExpr": "max((min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.ST=
ALLS_LDM_PENDING) - CYCLE_ACTIVITY.STALLS_L1D_PENDING) / tma_info_thread_cl=
ks, 0)",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_issueL1;tma_issueMC;tma_memory_bound_group",
         "MetricName": "tma_l1_bound",
         "MetricThreshold": "tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2)",
@@ -690,7 +690,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads",
-        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L1D_PENDING - CYCLE_ACTIVITY=
.STALLS_L2_PENDING) / tma_info_clks",
+        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L1D_PENDING - CYCLE_ACTIVITY=
.STALLS_L2_PENDING) / tma_info_thread_clks",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
         "MetricName": "tma_l2_bound",
         "MetricThreshold": "tma_l2_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
@@ -700,7 +700,7 @@
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
         "MetricConstraint": "NO_GROUP_EVENTS_SMT",
-        "MetricExpr": "MEM_LOAD_UOPS_RETIRED.LLC_HIT / (MEM_LOAD_UOPS_RETI=
RED.LLC_HIT + 7 * MEM_LOAD_UOPS_RETIRED.LLC_MISS) * CYCLE_ACTIVITY.STALLS_L=
2_PENDING / tma_info_clks",
+        "MetricExpr": "MEM_LOAD_UOPS_RETIRED.LLC_HIT / (MEM_LOAD_UOPS_RETI=
RED.LLC_HIT + 7 * MEM_LOAD_UOPS_RETIRED.LLC_MISS) * CYCLE_ACTIVITY.STALLS_L=
2_PENDING / tma_info_thread_clks",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
         "MetricThreshold": "tma_l3_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
@@ -710,7 +710,7 @@
     {
         "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited)",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "29 * (MEM_LOAD_UOPS_RETIRED.LLC_HIT * (1 + MEM_LOAD=
_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UOPS_RETIR=
ED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_LLC_HIT=
_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS + MEM_LOAD_UOP=
S_RETIRED.LLC_MISS))) / tma_info_clks",
+        "MetricExpr": "29 * (MEM_LOAD_UOPS_RETIRED.LLC_HIT * (1 + MEM_LOAD=
_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UOPS_RETIR=
ED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_LLC_HIT=
_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS + MEM_LOAD_UOP=
S_RETIRED.LLC_MISS))) / tma_info_thread_clks",
         "MetricGroup": "MemoryLat;TopdownL4;tma_L4_group;tma_issueLat;tma_=
l3_bound_group",
         "MetricName": "tma_l3_hit_latency",
         "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound > 0.0=
5 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -719,11 +719,11 @@
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
bandwidth, tma_info_dsb_coverage, tma_info_iptb",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs. Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_frontend_dsb_coverage, tma_info_inst_mix_iptb",
         "ScaleUnit": "100%"
     },
     {
@@ -739,7 +739,7 @@
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Load operations",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
-        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_2 + UOPS_DISPATCHED_PORT=
.PORT_3 - UOPS_DISPATCHED_PORT.PORT_4) / (2 * tma_info_core_clks)",
+        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_2 + UOPS_DISPATCHED_PORT=
.PORT_3 - UOPS_DISPATCHED_PORT.PORT_4) / (2 * tma_info_core_core_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_load_op_utilization",
         "MetricThreshold": "tma_load_op_utilization > 0.6",
@@ -749,7 +749,7 @@
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "MEM_UOPS_RETIRED.LOCK_LOADS / MEM_UOPS_RETIRED.ALL_=
STORES * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTANDING.CYCLES_W=
ITH_DEMAND_RFO) / tma_info_clks",
+        "MetricExpr": "MEM_UOPS_RETIRED.LOCK_LOADS / MEM_UOPS_RETIRED.ALL_=
STORES * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTANDING.CYCLES_W=
ITH_DEMAND_RFO) / tma_info_thread_clks",
         "MetricGroup": "Offcore;TopdownL4;tma_L4_group;tma_issueRFO;tma_l1=
_bound_group",
         "MetricName": "tma_lock_latency",
         "MetricThreshold": "tma_lock_latency > 0.2 & (tma_l1_bound > 0.1 &=
 (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -769,16 +769,16 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory (DRAM)",
-        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D6@) / tma_info_clks",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D6@) / tma_info_thread_clks",
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
ated metrics: tma_fb_full, tma_info_dram_bw_use, tma_sq_full",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory (DRAM).  The underlying heuristic assumes that a simi=
lar off-core traffic is generated by all IA cores. This metric does not agg=
regate non-data-read requests by this logical processor; requests from othe=
r IA Logical Processors/Physical Cores/sockets; or other non-IA devices lik=
e GPU; hence the maximum external memory bandwidth limits may or may not be=
 approached when this metric is flagged (see Uncore counters for that). Rel=
ated metrics: tma_fb_full, tma_info_system_dram_bw_use, tma_sq_full",
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
@@ -788,7 +788,7 @@
     {
         "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.STALLS=
_LDM_PENDING) + RESOURCE_STALLS.SB) / (min(CPU_CLK_UNHALTED.THREAD, CYCLE_A=
CTIVITY.CYCLES_NO_EXECUTE) + UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC - (UOPS_EXE=
CUTED.CYCLES_GE_3_UOPS_EXEC if tma_info_ipc > 1.8 else UOPS_EXECUTED.CYCLES=
_GE_2_UOPS_EXEC) - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else =
0) + RESOURCE_STALLS.SB) * tma_backend_bound",
+        "MetricExpr": "(min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.STALLS=
_LDM_PENDING) + RESOURCE_STALLS.SB) / (min(CPU_CLK_UNHALTED.THREAD, CYCLE_A=
CTIVITY.CYCLES_NO_EXECUTE) + UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC - (UOPS_EXE=
CUTED.CYCLES_GE_3_UOPS_EXEC if tma_info_thread_ipc > 1.8 else UOPS_EXECUTED=
.CYCLES_GE_2_UOPS_EXEC) - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.=
1 else 0) + RESOURCE_STALLS.SB) * tma_backend_bound",
         "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_b=
ound_group",
         "MetricName": "tma_memory_bound",
         "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0=
.2",
@@ -798,7 +798,7 @@
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
@@ -807,16 +807,16 @@
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
f long immediate or LCP can manifest as MITE fetch bandwidth bottleneck.",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS)",
-        "MetricExpr": "3 * IDQ.MS_SWITCHES / tma_info_clks",
+        "MetricExpr": "3 * IDQ.MS_SWITCHES / tma_info_thread_clks",
         "MetricGroup": "FetchLat;MicroSeq;TopdownL3;tma_L3_group;tma_fetch=
_latency_group;tma_issueMC;tma_issueMS;tma_issueMV;tma_issueSO",
         "MetricName": "tma_ms_switches",
         "MetricThreshold": "tma_ms_switches > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
@@ -825,7 +825,7 @@
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
@@ -834,7 +834,7 @@
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
@@ -843,7 +843,7 @@
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
@@ -852,7 +852,7 @@
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
@@ -870,7 +870,7 @@
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
@@ -880,7 +880,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLES=
_NO_EXECUTE) + UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC - (UOPS_EXECUTED.CYCLES_G=
E_3_UOPS_EXEC if tma_info_ipc > 1.8 else UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXE=
C) - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else 0) + RESOURCE_=
STALLS.SB - RESOURCE_STALLS.SB - min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVIT=
Y.STALLS_LDM_PENDING)) / tma_info_clks",
+        "MetricExpr": "(min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLES=
_NO_EXECUTE) + UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC - (UOPS_EXECUTED.CYCLES_G=
E_3_UOPS_EXEC if tma_info_thread_ipc > 1.8 else UOPS_EXECUTED.CYCLES_GE_2_U=
OPS_EXEC) - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else 0) + RE=
SOURCE_STALLS.SB - RESOURCE_STALLS.SB - min(CPU_CLK_UNHALTED.THREAD, CYCLE_=
ACTIVITY.STALLS_LDM_PENDING)) / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
         "MetricName": "tma_ports_utilization",
         "MetricThreshold": "tma_ports_utilization > 0.15 & (tma_core_bound=
 > 0.1 & tma_backend_bound > 0.2)",
@@ -889,7 +889,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
-        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,inv\\,cmask\\=3D1@ / 2 if=
 #SMT_on else (min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLES_NO_EXECUT=
E) - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else 0)) / tma_info=
_core_clks)",
+        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,inv\\,cmask\\=3D1@ / 2 if=
 #SMT_on else (min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLES_NO_EXECUT=
E) - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else 0)) / tma_info=
_core_core_clks)",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_0",
         "MetricThreshold": "tma_ports_utilized_0 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -898,7 +898,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re the CPU executed total of 1 uop per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D2@) / 2 if #SMT_on else (UOPS_EXECUTED.CYCLES_GE_=
1_UOP_EXEC - UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC) / tma_info_core_clks)",
+        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D2@) / 2 if #SMT_on else (UOPS_EXECUTED.CYCLES_GE_=
1_UOP_EXEC - UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC) / tma_info_core_core_clks=
)",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issueL1;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_1",
         "MetricThreshold": "tma_ports_utilized_1 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -907,7 +907,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 2 uops per cycle on all execution ports (Logical Process=
or cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D3@) / 2 if #SMT_on else (UOPS_EXECUTED.CYCLES_GE_=
2_UOPS_EXEC - UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / tma_info_core_clks)",
+        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D3@) / 2 if #SMT_on else (UOPS_EXECUTED.CYCLES_GE_=
2_UOPS_EXEC - UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / tma_info_core_core_clk=
s)",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issue2P;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_2",
         "MetricThreshold": "tma_ports_utilized_2 > 0.15 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -916,7 +916,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise).",
-        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ / 2 if #SMT_=
on else UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / tma_info_core_clks",
+        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ / 2 if #SMT_=
on else UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / tma_info_core_core_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_3m",
         "MetricThreshold": "tma_ports_utilized_3m > 0.7 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -924,7 +924,7 @@
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
@@ -935,7 +935,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles hand=
ling memory load split accesses - load that cross 64-byte cache line bounda=
ry",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "13 * LD_BLOCKS.NO_SR / tma_info_clks",
+        "MetricExpr": "13 * LD_BLOCKS.NO_SR / tma_info_thread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_split_loads",
         "MetricThreshold": "tma_split_loads > 0.2 & (tma_l1_bound > 0.1 & =
(tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -944,7 +944,7 @@
     },
     {
         "BriefDescription": "This metric represents rate of split store ac=
cesses",
-        "MetricExpr": "2 * MEM_UOPS_RETIRED.SPLIT_STORES / tma_info_core_c=
lks",
+        "MetricExpr": "2 * MEM_UOPS_RETIRED.SPLIT_STORES / tma_info_core_c=
ore_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_issueSpSt;tma_store_bou=
nd_group",
         "MetricName": "tma_split_stores",
         "MetricThreshold": "tma_split_stores > 0.2 & (tma_store_bound > 0.=
2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -953,16 +953,16 @@
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
, tma_info_dram_bw_use, tma_mem_bandwidth",
+        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_fb_full=
, tma_info_system_dram_bw_use, tma_mem_bandwidth",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to RFO store memory accesses; RFO store issue a read-for-ownership =
request before the write",
-        "MetricExpr": "RESOURCE_STALLS.SB / tma_info_clks",
+        "MetricExpr": "RESOURCE_STALLS.SB / tma_info_thread_clks",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_store_bound",
         "MetricThreshold": "tma_store_bound > 0.2 & (tma_memory_bound > 0.=
2 & tma_backend_bound > 0.2)",
@@ -971,7 +971,7 @@
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
@@ -981,7 +981,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(L2_RQSTS.RFO_HIT * 9 * (1 - MEM_UOPS_RETIRED.LOCK_=
LOADS / MEM_UOPS_RETIRED.ALL_STORES) + (1 - MEM_UOPS_RETIRED.LOCK_LOADS / M=
EM_UOPS_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS=
_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / tma_info_clks",
+        "MetricExpr": "(L2_RQSTS.RFO_HIT * 9 * (1 - MEM_UOPS_RETIRED.LOCK_=
LOADS / MEM_UOPS_RETIRED.ALL_STORES) + (1 - MEM_UOPS_RETIRED.LOCK_LOADS / M=
EM_UOPS_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS=
_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / tma_info_thread_clks",
         "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_issue=
RFO;tma_issueSL;tma_store_bound_group",
         "MetricName": "tma_store_latency",
         "MetricThreshold": "tma_store_latency > 0.1 & (tma_store_bound > 0=
.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -990,7 +990,7 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json b/tool=
s/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
index 65a46d659c0a..f5e46a768fdd 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
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
@@ -81,7 +81,7 @@
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
-        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_0 + UOPS_DISPATCHED_PORT=
.PORT_1 + UOPS_DISPATCHED_PORT.PORT_5) / (3 * tma_info_core_clks)",
+        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_0 + UOPS_DISPATCHED_PORT=
.PORT_1 + UOPS_DISPATCHED_PORT.PORT_5) / (3 * tma_info_core_core_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_alu_op_utilization",
         "MetricThreshold": "tma_alu_op_utilization > 0.6",
@@ -89,7 +89,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops delivered by the Microcode_Sequencer as a result of Assists=
",
-        "MetricExpr": "100 * OTHER_ASSISTS.ANY_WB_ASSIST / tma_info_slots"=
,
+        "MetricExpr": "100 * OTHER_ASSISTS.ANY_WB_ASSIST / tma_info_thread=
_slots",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
         "MetricName": "tma_assists",
         "MetricThreshold": "tma_assists > 0.1 & (tma_microcode_sequencer >=
 0.05 & tma_heavy_operations > 0.1)",
@@ -109,7 +109,7 @@
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
@@ -125,12 +125,12 @@
         "MetricName": "tma_branch_mispredicts",
         "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specula=
tion > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics:=
 tma_info_branch_misprediction_cost, tma_mispredicts_resteers",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics:=
 tma_info_bad_spec_branch_misprediction_cost, tma_mispredicts_resteers",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers",
-        "MetricExpr": "12 * (BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS=
.COUNT + BACLEARS.ANY) / tma_info_clks",
+        "MetricExpr": "12 * (BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS=
.COUNT + BACLEARS.ANY) / tma_info_thread_clks",
         "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group",
         "MetricName": "tma_branch_resteers",
         "MetricThreshold": "tma_branch_resteers > 0.05 & (tma_fetch_latenc=
y > 0.1 & tma_frontend_bound > 0.15)",
@@ -150,7 +150,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(60 * (MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM * (1=
 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD=
_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD_U=
OPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS + M=
EM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.R=
EMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_LLC=
_MISS_RETIRED.REMOTE_FWD))) + 43 * (MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS=
 * (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM=
_LOAD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_L=
OAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MIS=
S + MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETI=
RED.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOP=
S_LLC_MISS_RETIRED.REMOTE_FWD)))) / tma_info_clks",
+        "MetricExpr": "(60 * (MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM * (1=
 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD=
_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD_U=
OPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS + M=
EM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.R=
EMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_LLC=
_MISS_RETIRED.REMOTE_FWD))) + 43 * (MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS=
 * (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM=
_LOAD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_L=
OAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MIS=
S + MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETI=
RED.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOP=
S_LLC_MISS_RETIRED.REMOTE_FWD)))) / tma_info_thread_clks",
         "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_l3_bound_group",
         "MetricName": "tma_contested_accesses",
         "MetricThreshold": "tma_contested_accesses > 0.05 & (tma_l3_bound =
> 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -171,7 +171,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "43 * (MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT * (1 +=
 MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_U=
OPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOP=
S_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS + MEM=
_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REM=
OTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_LLC_M=
ISS_RETIRED.REMOTE_FWD))) / tma_info_clks",
+        "MetricExpr": "43 * (MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT * (1 +=
 MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_U=
OPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOP=
S_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS + MEM=
_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REM=
OTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_LLC_M=
ISS_RETIRED.REMOTE_FWD))) / tma_info_thread_clks",
         "MetricGroup": "Offcore;Snoop;TopdownL4;tma_L4_group;tma_issueSync=
xn;tma_l3_bound_group",
         "MetricName": "tma_data_sharing",
         "MetricThreshold": "tma_data_sharing > 0.05 & (tma_l3_bound > 0.05=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -180,7 +180,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re the Divider unit was active",
-        "MetricExpr": "ARITH.FPU_DIV_ACTIVE / tma_info_core_clks",
+        "MetricExpr": "ARITH.FPU_DIV_ACTIVE / tma_info_core_core_clks",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_core_bound_group",
         "MetricName": "tma_divider",
         "MetricThreshold": "tma_divider > 0.2 & (tma_core_bound > 0.1 & tm=
a_backend_bound > 0.2)",
@@ -190,7 +190,7 @@
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
         "MetricConstraint": "NO_GROUP_EVENTS_SMT",
-        "MetricExpr": "(1 - MEM_LOAD_UOPS_RETIRED.LLC_HIT / (MEM_LOAD_UOPS=
_RETIRED.LLC_HIT + 7 * MEM_LOAD_UOPS_RETIRED.LLC_MISS)) * CYCLE_ACTIVITY.ST=
ALLS_L2_PENDING / tma_info_clks",
+        "MetricExpr": "(1 - MEM_LOAD_UOPS_RETIRED.LLC_HIT / (MEM_LOAD_UOPS=
_RETIRED.LLC_HIT + 7 * MEM_LOAD_UOPS_RETIRED.LLC_MISS)) * CYCLE_ACTIVITY.ST=
ALLS_L2_PENDING / tma_info_thread_clks",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_dram_bound",
         "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2)",
@@ -199,25 +199,25 @@
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
 this metric measures the exposed penalty. Related metrics: tma_fetch_bandw=
idth, tma_info_dsb_coverage, tma_info_iptb, tma_lcp",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Related metrics: tma_fetch_bandw=
idth, tma_info_frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
-        "MetricExpr": "(7 * DTLB_LOAD_MISSES.STLB_HIT + DTLB_LOAD_MISSES.W=
ALK_DURATION) / tma_info_clks",
+        "MetricExpr": "(7 * DTLB_LOAD_MISSES.STLB_HIT + DTLB_LOAD_MISSES.W=
ALK_DURATION) / tma_info_thread_clks",
         "MetricGroup": "MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB;tma_=
l1_bound_group",
         "MetricName": "tma_dtlb_load",
         "MetricThreshold": "tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & (t=
ma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -226,7 +226,7 @@
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
-        "MetricExpr": "(7 * DTLB_STORE_MISSES.STLB_HIT + DTLB_STORE_MISSES=
.WALK_DURATION) / tma_info_clks",
+        "MetricExpr": "(7 * DTLB_STORE_MISSES.STLB_HIT + DTLB_STORE_MISSES=
.WALK_DURATION) / tma_info_thread_clks",
         "MetricGroup": "MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB;tma_=
store_bound_group",
         "MetricName": "tma_dtlb_store",
         "MetricThreshold": "tma_dtlb_store > 0.05 & (tma_store_bound > 0.2=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -235,7 +235,7 @@
     },
     {
         "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
-        "MetricExpr": "(200 * OFFCORE_RESPONSE.DEMAND_RFO.LLC_MISS.REMOTE_=
HITM + 60 * OFFCORE_RESPONSE.DEMAND_RFO.LLC_HIT.HITM_OTHER_CORE) / tma_info=
_clks",
+        "MetricExpr": "(200 * OFFCORE_RESPONSE.DEMAND_RFO.LLC_MISS.REMOTE_=
HITM + 60 * OFFCORE_RESPONSE.DEMAND_RFO.LLC_HIT.HITM_OTHER_CORE) / tma_info=
_thread_clks",
         "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_store_bound_group",
         "MetricName": "tma_false_sharing",
         "MetricThreshold": "tma_false_sharing > 0.05 & (tma_store_bound > =
0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -245,11 +245,11 @@
     {
         "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
         "MetricConstraint": "NO_GROUP_EVENTS",
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
 external memory). Related metrics: tma_info_dram_bw_use, tma_mem_bandwidth=
, tma_sq_full, tma_store_latency, tma_streaming_stores",
+        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_info_system_dram_bw_use, tma_mem_ba=
ndwidth, tma_sq_full, tma_store_latency, tma_streaming_stores",
         "ScaleUnit": "100%"
     },
     {
@@ -257,14 +257,14 @@
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
e Frontend typically delivers suboptimal amount of uops to the Backend. Rel=
ated metrics: tma_dsb_switches, tma_info_dsb_coverage, tma_info_iptb, tma_l=
cp",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Rel=
ated metrics: tma_dsb_switches, tma_info_frontend_dsb_coverage, tma_info_in=
st_mix_iptb, tma_lcp",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues",
-        "MetricExpr": "4 * min(CPU_CLK_UNHALTED.THREAD, IDQ_UOPS_NOT_DELIV=
ERED.CYCLES_0_UOPS_DELIV.CORE) / tma_info_slots",
+        "MetricExpr": "4 * min(CPU_CLK_UNHALTED.THREAD, IDQ_UOPS_NOT_DELIV=
ERED.CYCLES_0_UOPS_DELIV.CORE) / tma_info_thread_slots",
         "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend=
_bound_group",
         "MetricName": "tma_fetch_latency",
         "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound >=
 0.15",
@@ -301,7 +301,7 @@
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
@@ -321,359 +321,359 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses.",
-        "MetricExpr": "ICACHE.IFETCH_STALL / tma_info_clks - tma_itlb_miss=
es",
+        "MetricExpr": "ICACHE.IFETCH_STALL / tma_info_thread_clks - tma_it=
lb_misses",
         "MetricGroup": "BigFoot;FetchLat;IcMiss;TopdownL3;tma_L3_group;tma=
_fetch_latency_group",
         "MetricName": "tma_icache_misses",
         "MetricThreshold": "tma_icache_misses > 0.05 & (tma_fetch_latency =
> 0.1 & tma_frontend_bound > 0.15)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Measured Average Frequency for unhalted proce=
ssors [GHz]",
-        "MetricExpr": "tma_info_turbo_utilization * TSC / 1e9 / duration_t=
ime",
-        "MetricGroup": "Power;Summary",
-        "MetricName": "tma_info_average_frequency"
-    },
-    {
-        "BriefDescription": "Branch instructions per taken branch.",
-        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
-        "MetricGroup": "Branches;Fed;PGO",
-        "MetricName": "tma_info_bptkbranch"
+        "BriefDescription": "Instructions per retired mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
+        "MetricExpr": "tma_info_inst_mix_instructions / (UOPS_RETIRED.RETI=
RE_SLOTS / UOPS_ISSUED.ANY * cpu@BR_MISP_EXEC.ALL_BRANCHES\\,umask\\=3D0xE4=
@)",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "tma_info_bad_spec_ipmisp_indirect",
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1e3"
     },
     {
-        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "Pipeline",
-        "MetricName": "tma_info_clks"
+        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts",
+        "MetricName": "tma_info_bad_spec_ipmispredict",
+        "MetricThreshold": "tma_info_bad_spec_ipmispredict < 200"
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
-    },
-    {
-        "BriefDescription": "Average Parallel L2 cache miss data reads",
-        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD / OFFCORE_=
REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
-        "MetricGroup": "Memory_BW;Offcore",
-        "MetricName": "tma_info_data_l2_mlp"
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricExpr": "(FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EX=
E.SSE_SCALAR_DOUBLE + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * (FP_COMP_=
OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE) + 8 * SIMD_FP_256.PA=
CKED_SINGLE) / tma_info_core_core_clks",
+        "MetricGroup": "Flops;Ret",
+        "MetricName": "tma_info_core_flopc"
     },
     {
-        "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
-        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e=
9 / duration_time",
-        "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
-        "MetricName": "tma_info_dram_bw_use",
-        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_fb_full, tma_mem_bandwidth,=
 tma_sq_full"
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (cpu@UOPS_EXECUTED.CORE\\,cm=
ask\\=3D1@ / 2 if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
+        "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
+        "MetricName": "tma_info_core_ilp"
     },
     {
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
         "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_=
UOPS + IDQ.MS_UOPS)",
         "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
-        "MetricName": "tma_info_dsb_coverage",
-        "MetricThreshold": "tma_info_dsb_coverage < 0.7 & tma_info_ipc / 4=
 > 0.35",
-        "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_iptb, tma_lcp"
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
-        "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricExpr": "(FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EX=
E.SSE_SCALAR_DOUBLE + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * (FP_COMP_=
OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE) + 8 * SIMD_FP_256.PA=
CKED_SINGLE) / tma_info_core_clks",
-        "MetricGroup": "Flops;Ret",
-        "MetricName": "tma_info_flopc"
+        "MetricName": "tma_info_frontend_dsb_coverage",
+        "MetricThreshold": "tma_info_frontend_dsb_coverage < 0.7 & tma_inf=
o_thread_ipc / 4 > 0.35",
+        "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_inst_mix_iptb, tma_lcp"
     },
     {
-        "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "(FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EX=
E.SSE_SCALAR_DOUBLE + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * (FP_COMP_=
OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE) + 8 * SIMD_FP_256.PA=
CKED_SINGLE) / 1e9 / duration_time",
-        "MetricGroup": "Cor;Flops;HPC",
-        "MetricName": "tma_info_gflops",
-        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine."
+        "BriefDescription": "Instructions per speculative Unknown Branch M=
isprediction (BAClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "tma_info_inst_mix_instructions / BACLEARS.ANY",
+        "MetricGroup": "Fed",
+        "MetricName": "tma_info_frontend_ipunknown_branch"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (cpu@UOPS_EXECUTED.CORE\\,cm=
ask\\=3D1@ / 2 if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
-        "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
-        "MetricName": "tma_info_ilp"
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
         "BriefDescription": "Instructions per FP Arithmetic instruction (l=
ower number means higher occurrence rate)",
         "MetricExpr": "1 / (tma_fp_scalar + tma_fp_vector)",
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
         "BriefDescription": "Instructions per Load (lower number means hig=
her occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_LOADS",
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
         "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_STORES",
         "MetricGroup": "InsType",
-        "MetricName": "tma_info_ipstore",
-        "MetricThreshold": "tma_info_ipstore < 8"
+        "MetricName": "tma_info_inst_mix_ipstore",
+        "MetricThreshold": "tma_info_inst_mix_ipstore < 8"
     },
     {
         "BriefDescription": "Instruction per taken branch",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
         "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO;tma_issueFB",
-        "MetricName": "tma_info_iptb",
-        "MetricThreshold": "tma_info_iptb < 9",
-        "PublicDescription": "Instruction per taken branch. Related metric=
s: tma_dsb_switches, tma_fetch_bandwidth, tma_info_dsb_coverage, tma_lcp"
-    },
-    {
-        "BriefDescription": "Instructions per speculative Unknown Branch M=
isprediction (BAClear) (lower number means higher occurrence rate)",
-        "MetricExpr": "tma_info_instructions / BACLEARS.ANY",
-        "MetricGroup": "Fed",
-        "MetricName": "tma_info_ipunknown_branch"
-    },
-    {
-        "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
-        "MetricGroup": "OS",
-        "MetricName": "tma_info_kernel_cpi"
-    },
-    {
-        "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.THRE=
AD",
-        "MetricGroup": "OS",
-        "MetricName": "tma_info_kernel_utilization",
-        "MetricThreshold": "tma_info_kernel_utilization > 0.05"
+        "MetricName": "tma_info_inst_mix_iptb",
+        "MetricThreshold": "tma_info_inst_mix_iptb < 9",
+        "PublicDescription": "Instruction per taken branch. Related metric=
s: tma_dsb_switches, tma_fetch_bandwidth, tma_info_frontend_dsb_coverage, t=
ma_lcp"
     },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
         "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / duration_time",
         "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l1d_cache_fill_bw"
-    },
-    {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
-        "MetricExpr": "tma_info_l1d_cache_fill_bw",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l1d_cache_fill_bw_1t"
-    },
-    {
-        "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1e3 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED.=
ANY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "tma_info_l1mpki"
+        "MetricName": "tma_info_memory_core_l1d_cache_fill_bw"
     },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
         "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / duration_time",
         "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l2_cache_fill_bw"
+        "MetricName": "tma_info_memory_core_l2_cache_fill_bw"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
-        "MetricExpr": "tma_info_l2_cache_fill_bw",
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / duration_time",
         "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "tma_info_l2_cache_fill_bw_1t"
+        "MetricName": "tma_info_memory_core_l3_cache_fill_bw"
+    },
+    {
+        "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1e3 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED.=
ANY",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "tma_info_memory_l1mpki"
     },
     {
         "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1e3 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.=
ANY",
         "MetricGroup": "Backend;CacheMisses;Mem",
-        "MetricName": "tma_info_l2mpki"
+        "MetricName": "tma_info_memory_l2mpki"
     },
     {
-        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
-        "MetricExpr": "0",
-        "MetricGroup": "Mem;MemoryBW;Offcore",
-        "MetricName": "tma_info_l3_cache_access_bw_1t"
+        "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1e3 * MEM_LOAD_UOPS_RETIRED.LLC_MISS / INST_RETIRED=
.ANY",
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
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / (MEM_LOAD_UOPS_RETIRED.L1_M=
ISS + MEM_LOAD_UOPS_RETIRED.HIT_LFB)",
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
+        "MetricConstraint": "NO_GROUP_EVENTS",
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
-        "MetricExpr": "1e3 * MEM_LOAD_UOPS_RETIRED.LLC_MISS / INST_RETIRED=
.ANY",
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
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / (MEM_LOAD_UOPS_RETIRED.L1_M=
ISS + MEM_LOAD_UOPS_RETIRED.HIT_LFB)",
-        "MetricGroup": "Mem;MemoryBound;MemoryLat",
-        "MetricName": "tma_info_load_miss_real_latency"
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_core_l1d_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_thread_l1d_cache_fill_bw_1t"
     },
     {
-        "BriefDescription": "Average number of parallel data read requests=
 to external memory",
-        "MetricExpr": "UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=3D0x18=
2@ / UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=3D0x182\\,thresh\\=3D1@",
-        "MetricGroup": "Mem;MemoryBW;SoC",
-        "MetricName": "tma_info_mem_parallel_reads",
-        "PublicDescription": "Average number of parallel data read request=
s to external memory. Accounts for demand loads and L1/L2 prefetches"
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_core_l2_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_thread_l2_cache_fill_bw_1t"
     },
     {
-        "BriefDescription": "Average latency of data read request to exter=
nal memory (in nanoseconds)",
-        "MetricExpr": "1e9 * (UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=
=3D0x182@ / UNC_C_TOR_INSERTS.MISS_OPCODE@filter_opc\\=3D0x182@) / (tma_inf=
o_socket_clks / duration_time)",
-        "MetricGroup": "Mem;MemoryLat;SoC",
-        "MetricName": "tma_info_mem_read_latency",
-        "PublicDescription": "Average latency of data read request to exte=
rnal memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetche=
s. ([RKL+]memory-controller only)"
+        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
+        "MetricExpr": "0",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "tma_info_memory_thread_l3_cache_access_bw_1t"
     },
     {
-        "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLE=
S",
-        "MetricGroup": "Mem;MemoryBW;MemoryBound",
-        "MetricName": "tma_info_mlp",
-        "PublicDescription": "Memory-Level-Parallelism (average number of =
L1 miss demand load when there is at least one such miss. Per-Logical Proce=
ssor)"
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_core_l3_cache_fill_bw",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "tma_info_memory_thread_l3_cache_fill_bw_1t"
     },
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
-        "MetricExpr": "(ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_=
DURATION + DTLB_STORE_MISSES.WALK_DURATION) / tma_info_core_clks",
+        "MetricExpr": "(ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_=
DURATION + DTLB_STORE_MISSES.WALK_DURATION) / tma_info_core_core_clks",
         "MetricGroup": "Mem;MemoryTLB",
-        "MetricName": "tma_info_page_walks_utilization",
-        "MetricThreshold": "tma_info_page_walks_utilization > 0.5"
+        "MetricName": "tma_info_memory_tlb_page_walks_utilization",
+        "MetricThreshold": "tma_info_memory_tlb_page_walks_utilization > 0=
.5"
+    },
+    {
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-thread",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D1@",
+        "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
+        "MetricName": "tma_info_pipeline_execute"
     },
     {
         "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / cpu@UOPS_RETIRED.RETIRE=
_SLOTS\\,cmask\\=3D1@",
         "MetricGroup": "Pipeline;Ret",
-        "MetricName": "tma_info_retire"
+        "MetricName": "tma_info_pipeline_retire"
     },
     {
-        "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
-        "MetricExpr": "4 * tma_info_core_clks",
-        "MetricGroup": "TmaL1;tma_L1_group",
-        "MetricName": "tma_info_slots"
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
+        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e=
9 / duration_time",
+        "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
+        "MetricName": "tma_info_system_dram_bw_use",
+        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_fb_full, tma_mem_bandwidth,=
 tma_sq_full"
+    },
+    {
+        "BriefDescription": "Giga Floating Point Operations Per Second",
+        "MetricExpr": "(FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EX=
E.SSE_SCALAR_DOUBLE + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * (FP_COMP_=
OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE) + 8 * SIMD_FP_256.PA=
CKED_SINGLE) / 1e9 / duration_time",
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
+    },
+    {
+        "BriefDescription": "Average number of parallel data read requests=
 to external memory",
+        "MetricExpr": "UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=3D0x18=
2@ / UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=3D0x182\\,thresh\\=3D1@",
+        "MetricGroup": "Mem;MemoryBW;SoC",
+        "MetricName": "tma_info_system_mem_parallel_reads",
+        "PublicDescription": "Average number of parallel data read request=
s to external memory. Accounts for demand loads and L1/L2 prefetches"
+    },
+    {
+        "BriefDescription": "Average latency of data read request to exter=
nal memory (in nanoseconds)",
+        "MetricExpr": "1e9 * (UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=
=3D0x182@ / UNC_C_TOR_INSERTS.MISS_OPCODE@filter_opc\\=3D0x182@) / (tma_inf=
o_system_socket_clks / duration_time)",
+        "MetricGroup": "Mem;MemoryLat;SoC",
+        "MetricName": "tma_info_system_mem_read_latency",
+        "PublicDescription": "Average latency of data read request to exte=
rnal memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetche=
s. ([RKL+]memory-controller only)"
     },
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
         "MetricExpr": "cbox_0@event\\=3D0x0@",
         "MetricGroup": "SoC",
-        "MetricName": "tma_info_socket_clks"
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
-        "MetricExpr": "(12 * ITLB_MISSES.STLB_HIT + ITLB_MISSES.WALK_DURAT=
ION) / tma_info_clks",
+        "MetricExpr": "(12 * ITLB_MISSES.STLB_HIT + ITLB_MISSES.WALK_DURAT=
ION) / tma_info_thread_clks",
         "MetricGroup": "BigFoot;FetchLat;MemoryTLB;TopdownL3;tma_L3_group;=
tma_fetch_latency_group",
         "MetricName": "tma_itlb_misses",
         "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
@@ -682,7 +682,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache",
-        "MetricExpr": "max((min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.ST=
ALLS_LDM_PENDING) - CYCLE_ACTIVITY.STALLS_L1D_PENDING) / tma_info_clks, 0)"=
,
+        "MetricExpr": "max((min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.ST=
ALLS_LDM_PENDING) - CYCLE_ACTIVITY.STALLS_L1D_PENDING) / tma_info_thread_cl=
ks, 0)",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_issueL1;tma_issueMC;tma_memory_bound_group",
         "MetricName": "tma_l1_bound",
         "MetricThreshold": "tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2)",
@@ -691,7 +691,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads",
-        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L1D_PENDING - CYCLE_ACTIVITY=
.STALLS_L2_PENDING) / tma_info_clks",
+        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L1D_PENDING - CYCLE_ACTIVITY=
.STALLS_L2_PENDING) / tma_info_thread_clks",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
         "MetricName": "tma_l2_bound",
         "MetricThreshold": "tma_l2_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
@@ -701,7 +701,7 @@
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
         "MetricConstraint": "NO_GROUP_EVENTS_SMT",
-        "MetricExpr": "MEM_LOAD_UOPS_RETIRED.LLC_HIT / (MEM_LOAD_UOPS_RETI=
RED.LLC_HIT + 7 * MEM_LOAD_UOPS_RETIRED.LLC_MISS) * CYCLE_ACTIVITY.STALLS_L=
2_PENDING / tma_info_clks",
+        "MetricExpr": "MEM_LOAD_UOPS_RETIRED.LLC_HIT / (MEM_LOAD_UOPS_RETI=
RED.LLC_HIT + 7 * MEM_LOAD_UOPS_RETIRED.LLC_MISS) * CYCLE_ACTIVITY.STALLS_L=
2_PENDING / tma_info_thread_clks",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
         "MetricThreshold": "tma_l3_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
@@ -711,7 +711,7 @@
     {
         "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited)",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "41 * (MEM_LOAD_UOPS_RETIRED.LLC_HIT * (1 + MEM_LOAD=
_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UOPS_RETIR=
ED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_LLC_HIT=
_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS + MEM_LOAD_UOP=
S_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_DRAM =
+ MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_LLC_MISS_RETIR=
ED.REMOTE_FWD))) / tma_info_clks",
+        "MetricExpr": "41 * (MEM_LOAD_UOPS_RETIRED.LLC_HIT * (1 + MEM_LOAD=
_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UOPS_RETIR=
ED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_LLC_HIT=
_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS + MEM_LOAD_UOP=
S_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_DRAM =
+ MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_LLC_MISS_RETIR=
ED.REMOTE_FWD))) / tma_info_thread_clks",
         "MetricGroup": "MemoryLat;TopdownL4;tma_L4_group;tma_issueLat;tma_=
l3_bound_group",
         "MetricName": "tma_l3_hit_latency",
         "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound > 0.0=
5 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -720,11 +720,11 @@
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
bandwidth, tma_info_dsb_coverage, tma_info_iptb",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs. Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_frontend_dsb_coverage, tma_info_inst_mix_iptb",
         "ScaleUnit": "100%"
     },
     {
@@ -740,7 +740,7 @@
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Load operations",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
-        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_2 + UOPS_DISPATCHED_PORT=
.PORT_3 - UOPS_DISPATCHED_PORT.PORT_4) / (2 * tma_info_core_clks)",
+        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_2 + UOPS_DISPATCHED_PORT=
.PORT_3 - UOPS_DISPATCHED_PORT.PORT_4) / (2 * tma_info_core_core_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_load_op_utilization",
         "MetricThreshold": "tma_load_op_utilization > 0.6",
@@ -750,7 +750,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from local memory",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "200 * (MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM * =
(1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LO=
AD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD=
_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS +=
 MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED=
.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L=
LC_MISS_RETIRED.REMOTE_FWD))) / tma_info_clks",
+        "MetricExpr": "200 * (MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM * =
(1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LO=
AD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD=
_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS +=
 MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED=
.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L=
LC_MISS_RETIRED.REMOTE_FWD))) / tma_info_thread_clks",
         "MetricGroup": "Server;TopdownL5;tma_L5_group;tma_mem_latency_grou=
p",
         "MetricName": "tma_local_dram",
         "MetricThreshold": "tma_local_dram > 0.1 & (tma_mem_latency > 0.1 =
& (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2=
)))",
@@ -760,7 +760,7 @@
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "MEM_UOPS_RETIRED.LOCK_LOADS / MEM_UOPS_RETIRED.ALL_=
STORES * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTANDING.CYCLES_W=
ITH_DEMAND_RFO) / tma_info_clks",
+        "MetricExpr": "MEM_UOPS_RETIRED.LOCK_LOADS / MEM_UOPS_RETIRED.ALL_=
STORES * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTANDING.CYCLES_W=
ITH_DEMAND_RFO) / tma_info_thread_clks",
         "MetricGroup": "Offcore;TopdownL4;tma_L4_group;tma_issueRFO;tma_l1=
_bound_group",
         "MetricName": "tma_lock_latency",
         "MetricThreshold": "tma_lock_latency > 0.2 & (tma_l1_bound > 0.1 &=
 (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -780,16 +780,16 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory (DRAM)",
-        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D6@) / tma_info_clks",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D6@) / tma_info_thread_clks",
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
ated metrics: tma_fb_full, tma_info_dram_bw_use, tma_sq_full",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory (DRAM).  The underlying heuristic assumes that a simi=
lar off-core traffic is generated by all IA cores. This metric does not agg=
regate non-data-read requests by this logical processor; requests from othe=
r IA Logical Processors/Physical Cores/sockets; or other non-IA devices lik=
e GPU; hence the maximum external memory bandwidth limits may or may not be=
 approached when this metric is flagged (see Uncore counters for that). Rel=
ated metrics: tma_fb_full, tma_info_system_dram_bw_use, tma_sq_full",
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
@@ -799,7 +799,7 @@
     {
         "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.STALLS=
_LDM_PENDING) + RESOURCE_STALLS.SB) / (min(CPU_CLK_UNHALTED.THREAD, CYCLE_A=
CTIVITY.CYCLES_NO_EXECUTE) + UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC - (UOPS_EXE=
CUTED.CYCLES_GE_3_UOPS_EXEC if tma_info_ipc > 1.8 else UOPS_EXECUTED.CYCLES=
_GE_2_UOPS_EXEC) - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else =
0) + RESOURCE_STALLS.SB) * tma_backend_bound",
+        "MetricExpr": "(min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.STALLS=
_LDM_PENDING) + RESOURCE_STALLS.SB) / (min(CPU_CLK_UNHALTED.THREAD, CYCLE_A=
CTIVITY.CYCLES_NO_EXECUTE) + UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC - (UOPS_EXE=
CUTED.CYCLES_GE_3_UOPS_EXEC if tma_info_thread_ipc > 1.8 else UOPS_EXECUTED=
.CYCLES_GE_2_UOPS_EXEC) - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.=
1 else 0) + RESOURCE_STALLS.SB) * tma_backend_bound",
         "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_b=
ound_group",
         "MetricName": "tma_memory_bound",
         "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0=
.2",
@@ -809,7 +809,7 @@
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
@@ -818,16 +818,16 @@
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
f long immediate or LCP can manifest as MITE fetch bandwidth bottleneck.",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS)",
-        "MetricExpr": "3 * IDQ.MS_SWITCHES / tma_info_clks",
+        "MetricExpr": "3 * IDQ.MS_SWITCHES / tma_info_thread_clks",
         "MetricGroup": "FetchLat;MicroSeq;TopdownL3;tma_L3_group;tma_fetch=
_latency_group;tma_issueMC;tma_issueMS;tma_issueMV;tma_issueSO",
         "MetricName": "tma_ms_switches",
         "MetricThreshold": "tma_ms_switches > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
@@ -836,7 +836,7 @@
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
@@ -845,7 +845,7 @@
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
@@ -854,7 +854,7 @@
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
@@ -863,7 +863,7 @@
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
@@ -881,7 +881,7 @@
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
@@ -891,7 +891,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLES=
_NO_EXECUTE) + UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC - (UOPS_EXECUTED.CYCLES_G=
E_3_UOPS_EXEC if tma_info_ipc > 1.8 else UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXE=
C) - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else 0) + RESOURCE_=
STALLS.SB - RESOURCE_STALLS.SB - min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVIT=
Y.STALLS_LDM_PENDING)) / tma_info_clks",
+        "MetricExpr": "(min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLES=
_NO_EXECUTE) + UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC - (UOPS_EXECUTED.CYCLES_G=
E_3_UOPS_EXEC if tma_info_thread_ipc > 1.8 else UOPS_EXECUTED.CYCLES_GE_2_U=
OPS_EXEC) - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else 0) + RE=
SOURCE_STALLS.SB - RESOURCE_STALLS.SB - min(CPU_CLK_UNHALTED.THREAD, CYCLE_=
ACTIVITY.STALLS_LDM_PENDING)) / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
         "MetricName": "tma_ports_utilization",
         "MetricThreshold": "tma_ports_utilization > 0.15 & (tma_core_bound=
 > 0.1 & tma_backend_bound > 0.2)",
@@ -900,7 +900,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
-        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,inv\\,cmask\\=3D1@ / 2 if=
 #SMT_on else (min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLES_NO_EXECUT=
E) - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else 0)) / tma_info=
_core_clks)",
+        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,inv\\,cmask\\=3D1@ / 2 if=
 #SMT_on else (min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLES_NO_EXECUT=
E) - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else 0)) / tma_info=
_core_core_clks)",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_0",
         "MetricThreshold": "tma_ports_utilized_0 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -909,7 +909,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re the CPU executed total of 1 uop per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D2@) / 2 if #SMT_on else (UOPS_EXECUTED.CYCLES_GE_=
1_UOP_EXEC - UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC) / tma_info_core_clks)",
+        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D2@) / 2 if #SMT_on else (UOPS_EXECUTED.CYCLES_GE_=
1_UOP_EXEC - UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC) / tma_info_core_core_clks=
)",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issueL1;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_1",
         "MetricThreshold": "tma_ports_utilized_1 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -918,7 +918,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 2 uops per cycle on all execution ports (Logical Process=
or cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D3@) / 2 if #SMT_on else (UOPS_EXECUTED.CYCLES_GE_=
2_UOPS_EXEC - UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / tma_info_core_clks)",
+        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D3@) / 2 if #SMT_on else (UOPS_EXECUTED.CYCLES_GE_=
2_UOPS_EXEC - UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / tma_info_core_core_clk=
s)",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issue2P;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_2",
         "MetricThreshold": "tma_ports_utilized_2 > 0.15 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -927,7 +927,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise).",
-        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ / 2 if #SMT_=
on else UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / tma_info_core_clks",
+        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ / 2 if #SMT_=
on else UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / tma_info_core_core_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_3m",
         "MetricThreshold": "tma_ports_utilized_3m > 0.7 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -936,7 +936,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote cache in other socket=
s including synchronizations issues",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(200 * (MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM =
* (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_=
LOAD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LO=
AD_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS=
 + MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIR=
ED.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS=
_LLC_MISS_RETIRED.REMOTE_FWD))) + 180 * (MEM_LOAD_UOPS_LLC_MISS_RETIRED.REM=
OTE_FWD * (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HI=
T + MEM_LOAD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT =
+ MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.X=
SNP_MISS + MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MI=
SS_RETIRED.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_L=
OAD_UOPS_LLC_MISS_RETIRED.REMOTE_FWD)))) / tma_info_clks",
+        "MetricExpr": "(200 * (MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM =
* (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_=
LOAD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LO=
AD_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS=
 + MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIR=
ED.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS=
_LLC_MISS_RETIRED.REMOTE_FWD))) + 180 * (MEM_LOAD_UOPS_LLC_MISS_RETIRED.REM=
OTE_FWD * (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HI=
T + MEM_LOAD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT =
+ MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.X=
SNP_MISS + MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MI=
SS_RETIRED.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_L=
OAD_UOPS_LLC_MISS_RETIRED.REMOTE_FWD)))) / tma_info_thread_clks",
         "MetricGroup": "Offcore;Server;Snoop;TopdownL5;tma_L5_group;tma_is=
sueSyncxn;tma_mem_latency_group",
         "MetricName": "tma_remote_cache",
         "MetricThreshold": "tma_remote_cache > 0.05 & (tma_mem_latency > 0=
.1 & (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > =
0.2)))",
@@ -946,7 +946,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote memory",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "310 * (MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_DRAM *=
 (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_L=
OAD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOA=
D_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS =
+ MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRE=
D.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_=
LLC_MISS_RETIRED.REMOTE_FWD))) / tma_info_clks",
+        "MetricExpr": "310 * (MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_DRAM *=
 (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_L=
OAD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOA=
D_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS =
+ MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRE=
D.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_=
LLC_MISS_RETIRED.REMOTE_FWD))) / tma_info_thread_clks",
         "MetricGroup": "Server;Snoop;TopdownL5;tma_L5_group;tma_mem_latenc=
y_group",
         "MetricName": "tma_remote_dram",
         "MetricThreshold": "tma_remote_dram > 0.1 & (tma_mem_latency > 0.1=
 & (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.=
2)))",
@@ -955,7 +955,7 @@
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
@@ -966,7 +966,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles hand=
ling memory load split accesses - load that cross 64-byte cache line bounda=
ry",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "13 * LD_BLOCKS.NO_SR / tma_info_clks",
+        "MetricExpr": "13 * LD_BLOCKS.NO_SR / tma_info_thread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_split_loads",
         "MetricThreshold": "tma_split_loads > 0.2 & (tma_l1_bound > 0.1 & =
(tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -975,7 +975,7 @@
     },
     {
         "BriefDescription": "This metric represents rate of split store ac=
cesses",
-        "MetricExpr": "2 * MEM_UOPS_RETIRED.SPLIT_STORES / tma_info_core_c=
lks",
+        "MetricExpr": "2 * MEM_UOPS_RETIRED.SPLIT_STORES / tma_info_core_c=
ore_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_issueSpSt;tma_store_bou=
nd_group",
         "MetricName": "tma_split_stores",
         "MetricThreshold": "tma_split_stores > 0.2 & (tma_store_bound > 0.=
2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -984,16 +984,16 @@
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
, tma_info_dram_bw_use, tma_mem_bandwidth",
+        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_fb_full=
, tma_info_system_dram_bw_use, tma_mem_bandwidth",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to RFO store memory accesses; RFO store issue a read-for-ownership =
request before the write",
-        "MetricExpr": "RESOURCE_STALLS.SB / tma_info_clks",
+        "MetricExpr": "RESOURCE_STALLS.SB / tma_info_thread_clks",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_store_bound",
         "MetricThreshold": "tma_store_bound > 0.2 & (tma_memory_bound > 0.=
2 & tma_backend_bound > 0.2)",
@@ -1002,7 +1002,7 @@
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
@@ -1012,7 +1012,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(L2_RQSTS.RFO_HIT * 9 * (1 - MEM_UOPS_RETIRED.LOCK_=
LOADS / MEM_UOPS_RETIRED.ALL_STORES) + (1 - MEM_UOPS_RETIRED.LOCK_LOADS / M=
EM_UOPS_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS=
_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / tma_info_clks",
+        "MetricExpr": "(L2_RQSTS.RFO_HIT * 9 * (1 - MEM_UOPS_RETIRED.LOCK_=
LOADS / MEM_UOPS_RETIRED.ALL_STORES) + (1 - MEM_UOPS_RETIRED.LOCK_LOADS / M=
EM_UOPS_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS=
_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / tma_info_thread_clks",
         "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_issue=
RFO;tma_issueSL;tma_store_bound_group",
         "MetricName": "tma_store_latency",
         "MetricThreshold": "tma_store_latency > 0.1 & (tma_store_bound > 0=
.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -1021,7 +1021,7 @@
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
--=20
2.40.1.606.ga4b1b128d6-goog

