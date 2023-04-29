Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824E96F2321
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 07:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjD2FhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 01:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjD2FhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 01:37:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB68444BE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:36:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b8f6bef3d4aso1048057276.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682746601; x=1685338601;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmL6hSbfwKLQ2Rkdau58A867nnjWXNzjuwqbLX3orRI=;
        b=asTFCiB8Njtd45FaWY4wl0Tfe5Lws15zWaYdKH0hxSmpPIty3ug15xrSawTCRvNWu4
         Y5wHM40ZZyOl/m1q0ptQMsISBSO9vk2uJowg+hzllNQ7vA0k6gc30GBTMtpGcAOpNDxh
         AutbE2B3oMTbdcpV71Wjv6Ktmq1HPt9V4k9VqLh67JtG4zK1wmXNfb0kJVNBhaFTeMcE
         1ugv7QrcJchgrj3yGlNrwAc8s+El3J8PaxYbca/PbquM4VZ2lQGq9XV0fYo7N92dvC/A
         rsAzgP3u9dFqKhnuaiYUcaIpihPZi/EclOeq/leBo+BIw4KYcfco1bFgAJOFlo4ZJL82
         Pf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682746601; x=1685338601;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JmL6hSbfwKLQ2Rkdau58A867nnjWXNzjuwqbLX3orRI=;
        b=cJWfVhc11SeBxckjVZMDEp0KSFOZYaz/qy7+DUegfMWJm5MHNrK3bBFi2gcgtwwz7I
         jSHh8xnAhk1P1EQjjsdgVv5V4RGbb6eqqtYfnBz3xfxUYPpwjDk78vy5rHtf1ismeSDC
         jL3+9BNpI2pN8mRLtzzuRrgSS656sE90u6yaIdyWD/yq9z4RxOwk9G0VHJa6FHlZ+ro8
         mDm001Y6q4oLJmggKcdE6qW9rv8DSigovk0H3P5ugILh//rV4lLP3uVZNMlhnv8iM6bw
         XFQpUtMewyBaVedmb/gLu1BPBWOb5OEBft9peu6uOfJnGU+uWZ/U7DeQ4kN6di+ZA2kz
         9jQQ==
X-Gm-Message-State: AC+VfDxo0gBqAX0P/Z9ot+le+MzZaProERMSVhze5sYcf/HXb25y3387
        EDD98kQAFIjpem8ZlcvEL/u6DXk7SiEs
X-Google-Smtp-Source: ACHHUZ4NMa1jGjB9p1VHjw+V96hyWcTmpRYnCiapFknw3bkbwBwH1JBj55Yl3CfVI2X4/k/RY/d2rbCWyOnn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c563:7e28:fb7c:bce3])
 (user=irogers job=sendgmr) by 2002:a25:1542:0:b0:b9a:7088:d95 with SMTP id
 63-20020a251542000000b00b9a70880d95mr4079097ybv.0.1682746601210; Fri, 28 Apr
 2023 22:36:41 -0700 (PDT)
Date:   Fri, 28 Apr 2023 22:34:30 -0700
In-Reply-To: <20230429053506.1962559-1-irogers@google.com>
Message-Id: <20230429053506.1962559-11-irogers@google.com>
Mime-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v3 10/46] perf vendor events intel: Add tigerlake metric constraints
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

Previously these constraints were disabled as they contained topdown
events. Since:
https://lore.kernel.org/all/20230312021543.3060328-9-irogers@google.com/
the topdown events are correctly grouped even if no group exists.

This change was created by PR:
https://github.com/intel/perfmon/pull/71

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/tigerlake/tgl-metrics.json    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json b/to=
ols/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
index b442ed4acfbb..ae62bacf9f5e 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
@@ -311,6 +311,7 @@
     },
     {
         "BriefDescription": "This metric represents overall arithmetic flo=
ating-point (FP) operations fraction the CPU has executed (retired)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "tma_x87_use + tma_fp_scalar + tma_fp_vector",
         "MetricGroup": "HPC;TopdownL3;tma_L3_group;tma_light_operations_gr=
oup",
         "MetricName": "tma_fp_arith",
@@ -415,6 +416,7 @@
     },
     {
         "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(tma_branch_mispredicts + tma_fetch_latency * tma_m=
ispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icache_=
misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) * tma_info_slots / B=
R_MISP_RETIRED.ALL_BRANCHES",
         "MetricGroup": "Bad;BrMispredicts;tma_issueBM",
         "MetricName": "tma_info_branch_misprediction_cost",
@@ -460,6 +462,7 @@
     },
     {
         "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(100 * (1 - tma_core_bound / tma_ports_utilization =
if tma_core_bound < tma_ports_utilization else 1) if tma_info_smt_2t_utiliz=
ation > 0.5 else 0)",
         "MetricGroup": "Cor;SMT",
         "MetricName": "tma_info_core_bound_likely",
@@ -512,6 +515,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + =
tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb + tm=
a_lsd + tma_mite))",
         "MetricGroup": "DSBmiss;Fed;tma_issueFB",
         "MetricName": "tma_info_dsb_misses",
@@ -593,6 +597,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_frontend_bound - tma_fetch_latency * tma=
_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icach=
e_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) - tma_info_big_cod=
e",
         "MetricGroup": "Fed;FetchBW;Frontend",
         "MetricName": "tma_info_instruction_fetch_bw",
@@ -957,6 +962,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * tma_memory_bound * (tma_l1_bound / max(tma_me=
mory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + t=
ma_store_bound) * (tma_dtlb_load / max(tma_l1_bound, tma_4k_aliasing + tma_=
dtlb_load + tma_fb_full + tma_lock_latency + tma_split_loads + tma_store_fw=
d_blk)) + tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound +=
 tma_l3_bound + tma_store_bound) * (tma_dtlb_store / (tma_dtlb_store + tma_=
false_sharing + tma_split_stores + tma_store_latency + tma_streaming_stores=
)))",
         "MetricGroup": "Mem;MemoryTLB;Offcore;tma_issueTLB",
         "MetricName": "tma_info_memory_data_tlbs",
@@ -965,6 +971,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Latency related=
 bottlenecks (external memory and off-core caches)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (=
tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_l3_bound / (=
tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bou=
nd) * (tma_l3_hit_latency / (tma_contested_accesses + tma_data_sharing + tm=
a_l3_hit_latency + tma_sq_full)) + tma_l2_bound / (tma_dram_bound + tma_l1_=
bound + tma_l2_bound + tma_l3_bound + tma_store_bound))",
         "MetricGroup": "Mem;MemoryLat;Offcore;tma_issueLat",
         "MetricName": "tma_info_memory_latency",
@@ -973,6 +980,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_branch_mispredicts + tma_fetch_latency *=
 tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_i=
cache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
         "MetricGroup": "Bad;BadSpec;BrMispredicts;tma_issueBM",
         "MetricName": "tma_info_mispredictions",
@@ -1024,6 +1032,7 @@
     },
     {
         "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "tma_retiring * tma_info_slots / cpu@UOPS_RETIRED.SL=
OTS\\,cmask\\=3D1@",
         "MetricGroup": "Pipeline;Ret",
         "MetricName": "tma_info_retire"
@@ -1221,6 +1230,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations -- uops for memory load or store a=
ccesses.",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "tma_light_operations * MEM_INST_RETIRED.ANY / INST_=
RETIRED.ANY",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_memory_operations",
@@ -1291,6 +1301,7 @@
     },
     {
         "BriefDescription": "This metric represents the remaining light uo=
ps fraction the CPU has executed - remaining means not covered by other sib=
ling nodes",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "max(0, tma_light_operations - (tma_fp_arith + tma_m=
emory_operations + tma_branch_instructions + tma_nop_instructions))",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_other_light_ops",
--=20
2.40.1.495.gc816e09b53d-goog

