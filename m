Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305F76C78C6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjCXHYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjCXHYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:24:08 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A35B26C1D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:23:51 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5425c04765dso11108167b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679642630;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5Z122RDPqXRQ6Oec6E8jLwYOltYMIYDwRTVWNtdnf8=;
        b=VK6qlIRkD3tn1LQknMkyIegUkNT6GYKk5yQcvA5QGsv1js7kc96UlfLpgLOaXfbHsX
         rE+Pkkrz1dV9h6wENc1/JdbHHd5pord643VNv/T6EvkXO51tmCOTMGiDE51KCT0zY4/M
         k6VAyxXXQhRdGl0ji1WIX3BYcZ9DLYCrtQoBdeaUWkWlu132BthOZpaCxa3hTL8cZnL4
         KqyHk1XppajFwQwQ9LmvRimtwViGZCmrZ3mx4r0PtGP2ElCP05fQse3w6YyOLGoVSJBs
         L3Ysz2/rLfM+axX1qZxZOaVrWzLYv1naswl//oWiUGN871NMNIv86a32pymXQkFGgKQy
         bOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679642630;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J5Z122RDPqXRQ6Oec6E8jLwYOltYMIYDwRTVWNtdnf8=;
        b=grNNox6G/eXHxxQuhdJHTM01j9HobhCoX4zk1H2bfGaj3sQ8PKmfwkpt/I6zG2hj/N
         QdMi3SlrZvu/J7dxWZcXCgZ9SXg9Yd17qt8w/3ZddlT277Ck20EkDEwQL+dzmpri+/Fl
         LLoknsWnDkVDiRBevTk8at3FGasbMpMs7EQkYfoR9qZQhhkafkJtNR2TYFjgw5cHwx2E
         JVCdpe+ERGQEbPTIuFJ46Eu8qB37q4FcX2hLpPfFNM1iK1tijICq0X0pLDDfPh8RcuzR
         Q3kfR4fLqAPy5MQbnOpNT/w9DTP97QFl9Ywk4Se0Bsw4QMpFSBceBOQlee7Z8Nmm4bJF
         HuKg==
X-Gm-Message-State: AAQBX9fgq5GFkmGSdGXCBKqdN025oYuwCv//gHL5FG45xqyafTQxIpcs
        s/mdmWP70VQCzjIB1jqlPZYRzFkZfxw6
X-Google-Smtp-Source: AKy350bsAnCynSBcmk+trlP+DcgJwe1lLJPRbGzk3y8KVvx3abYG8lK+yVGRxkXhjkdIrQlyee6Yls4+VBBl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e705:3a3d:46e5:fb50])
 (user=irogers job=sendgmr) by 2002:a25:b001:0:b0:b70:ad30:dacc with SMTP id
 q1-20020a25b001000000b00b70ad30daccmr563816ybf.2.1679642630755; Fri, 24 Mar
 2023 00:23:50 -0700 (PDT)
Date:   Fri, 24 Mar 2023 00:22:18 -0700
In-Reply-To: <20230324072218.181880-1-irogers@google.com>
Message-Id: <20230324072218.181880-10-irogers@google.com>
Mime-Version: 1.0
References: <20230324072218.181880-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v3 9/9] perf vendor events: Update metrics to detect pmem at runtime
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        samantha.alt@intel.com, weilin.wang@intel.com
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.9 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By detecting whether nvdimms are installed at runtime the number of
events can be reduced if it isn't. These changes come from this PR:
https://github.com/intel/perfmon/pull/63

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/cascadelakex/clx-metrics.json  | 10 +++++-----
 .../perf/pmu-events/arch/x86/icelakex/icx-metrics.json | 10 +++++-----
 .../arch/x86/sapphirerapids/spr-metrics.json           | 10 +++++-----
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b=
/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
index 4e993a3220e3..8f7dc72accd0 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
@@ -201,7 +201,7 @@
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "CYCLE_ACTIVITY.STALLS_L3_MISS / tma_info_clks + (CY=
CLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_info_cl=
ks - tma_l2_bound - tma_pmm_bound",
+        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L3_MISS / tma_info_clks + (C=
YCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_info_c=
lks - tma_l2_bound - tma_pmm_bound if #has_pmem > 0 else CYCLE_ACTIVITY.STA=
LLS_L3_MISS / tma_info_clks + (CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIV=
ITY.STALLS_L2_MISS) / tma_info_clks - tma_l2_bound)",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_dram_bound",
         "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2)",
@@ -933,7 +933,7 @@
     },
     {
         "BriefDescription": "Average latency of data read request to exter=
nal 3D X-Point memory [in nanoseconds]",
-        "MetricExpr": "1e9 * (UNC_M_PMM_RPQ_OCCUPANCY.ALL / UNC_M_PMM_RPQ_=
INSERTS) / imc_0@event\\=3D0x0@",
+        "MetricExpr": "(1e9 * (UNC_M_PMM_RPQ_OCCUPANCY.ALL / UNC_M_PMM_RPQ=
_INSERTS) / imc_0@event\\=3D0x0@ if #has_pmem > 0 else 0)",
         "MetricGroup": "Mem;MemoryLat;Server;SoC",
         "MetricName": "tma_info_mem_pmm_read_latency",
         "PublicDescription": "Average latency of data read request to exte=
rnal 3D X-Point memory [in nanoseconds]. Accounts for demand loads and L1/L=
2 data-read prefetches"
@@ -998,13 +998,13 @@
     },
     {
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for reads [=
GB / sec]",
-        "MetricExpr": "64 * UNC_M_PMM_RPQ_INSERTS / 1e9 / duration_time",
+        "MetricExpr": "(64 * UNC_M_PMM_RPQ_INSERTS / 1e9 / duration_time i=
f #has_pmem > 0 else 0)",
         "MetricGroup": "Mem;MemoryBW;Server;SoC",
         "MetricName": "tma_info_pmm_read_bw"
     },
     {
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for Writes =
[GB / sec]",
-        "MetricExpr": "64 * UNC_M_PMM_WPQ_INSERTS / 1e9 / duration_time",
+        "MetricExpr": "(64 * UNC_M_PMM_WPQ_INSERTS / 1e9 / duration_time i=
f #has_pmem > 0 else 0)",
         "MetricGroup": "Mem;MemoryBW;Server;SoC",
         "MetricName": "tma_info_pmm_write_bw"
     },
@@ -1310,7 +1310,7 @@
     {
         "BriefDescription": "This metric roughly estimates (based on idle =
latencies) how often the CPU was stalled on accesses to external 3D-Xpoint =
(Crystal Ridge, a.k.a",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "((1 - (19 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM *=
 (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS)) + 10 * (MEM_LOAD=
_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIR=
ED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * (1 + MEM_LOAD_RETIRED.F=
B_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM * =
(1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))) / (19 * (MEM_LOA=
D_L3_MISS_RETIRED.REMOTE_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RET=
IRED.L1_MISS)) + 10 * (MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOAD_=
RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMOT=
E_FWD * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOAD=
_L3_MISS_RETIRED.REMOTE_HITM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETI=
RED.L1_MISS)) + (25 * (MEM_LOAD_RETIRED.LOCAL_PMM * (1 + MEM_LOAD_RETIRED.F=
B_HIT / MEM_LOAD_RETIRED.L1_MISS)) + 33 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_=
PMM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))))) * (CYCLE=
_ACTIVITY.STALLS_L3_MISS / tma_info_clks + (CYCLE_ACTIVITY.STALLS_L1D_MISS =
- CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_info_clks - tma_l2_bound) if 1e6 * (=
MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM + MEM_LOAD_RETIRED.LOCAL_PMM) > MEM_LOA=
D_RETIRED.L1_MISS else 0)",
+        "MetricExpr": "(((1 - ((19 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM=
 * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS)) + 10 * (MEM_LO=
AD_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RET=
IRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * (1 + MEM_LOAD_RETIRED=
.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM =
* (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))) / (19 * (MEM_L=
OAD_L3_MISS_RETIRED.REMOTE_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_R=
ETIRED.L1_MISS)) + 10 * (MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOA=
D_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REM=
OTE_FWD * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LO=
AD_L3_MISS_RETIRED.REMOTE_HITM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RE=
TIRED.L1_MISS)) + (25 * (MEM_LOAD_RETIRED.LOCAL_PMM * (1 + MEM_LOAD_RETIRED=
.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) if #has_pmem > 0 else 0) + 33 * (MEM_LO=
AD_L3_MISS_RETIRED.REMOTE_PMM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RET=
IRED.L1_MISS) if #has_pmem > 0 else 0))) if #has_pmem > 0 else 0)) * (CYCLE=
_ACTIVITY.STALLS_L3_MISS / tma_info_clks + (CYCLE_ACTIVITY.STALLS_L1D_MISS =
- CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_info_clks - tma_l2_bound) if 1e6 * (=
MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM + MEM_LOAD_RETIRED.LOCAL_PMM) > MEM_LOA=
D_RETIRED.L1_MISS else 0) if #has_pmem > 0 else 0)",
         "MetricGroup": "MemoryBound;Server;TmaL3mem;TopdownL3;tma_L3_group=
;tma_memory_bound_group",
         "MetricName": "tma_pmm_bound",
         "MetricThreshold": "tma_pmm_bound > 0.1 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json b/too=
ls/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
index 8109088a4df7..0f9b174dfc22 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
@@ -186,7 +186,7 @@
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "CYCLE_ACTIVITY.STALLS_L3_MISS / tma_info_clks + (CY=
CLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_info_cl=
ks - tma_l2_bound - tma_pmm_bound",
+        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L3_MISS / tma_info_clks + (C=
YCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_info_c=
lks - tma_l2_bound - tma_pmm_bound if #has_pmem > 0 else CYCLE_ACTIVITY.STA=
LLS_L3_MISS / tma_info_clks + (CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIV=
ITY.STALLS_L2_MISS) / tma_info_clks - tma_l2_bound)",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_dram_bound",
         "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2)",
@@ -918,7 +918,7 @@
     },
     {
         "BriefDescription": "Average latency of data read request to exter=
nal 3D X-Point memory [in nanoseconds]",
-        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PMM / UNC_=
CHA_TOR_INSERTS.IA_MISS_DRD_PMM) / cha_0@event\\=3D0x0@",
+        "MetricExpr": "(1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PMM / UNC=
_CHA_TOR_INSERTS.IA_MISS_DRD_PMM) / cha_0@event\\=3D0x0@ if #has_pmem > 0 e=
lse 0)",
         "MetricGroup": "Mem;MemoryLat;Server;SoC",
         "MetricName": "tma_info_mem_pmm_read_latency",
         "PublicDescription": "Average latency of data read request to exte=
rnal 3D X-Point memory [in nanoseconds]. Accounts for demand loads and L1/L=
2 data-read prefetches"
@@ -984,13 +984,13 @@
     },
     {
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for reads [=
GB / sec]",
-        "MetricExpr": "64 * UNC_M_PMM_RPQ_INSERTS / 1e9 / duration_time",
+        "MetricExpr": "(64 * UNC_M_PMM_RPQ_INSERTS / 1e9 / duration_time i=
f #has_pmem > 0 else 0)",
         "MetricGroup": "Mem;MemoryBW;Server;SoC",
         "MetricName": "tma_info_pmm_read_bw"
     },
     {
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for Writes =
[GB / sec]",
-        "MetricExpr": "64 * UNC_M_PMM_WPQ_INSERTS / 1e9 / duration_time",
+        "MetricExpr": "(64 * UNC_M_PMM_WPQ_INSERTS / 1e9 / duration_time i=
f #has_pmem > 0 else 0)",
         "MetricGroup": "Mem;MemoryBW;Server;SoC",
         "MetricName": "tma_info_pmm_write_bw"
     },
@@ -1298,7 +1298,7 @@
     },
     {
         "BriefDescription": "This metric roughly estimates (based on idle =
latencies) how often the CPU was stalled on accesses to external 3D-Xpoint =
(Crystal Ridge, a.k.a",
-        "MetricExpr": "((1 - (19 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM *=
 (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS)) + 10 * (MEM_LOAD=
_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIR=
ED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * (1 + MEM_LOAD_RETIRED.F=
B_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM * =
(1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))) / (19 * (MEM_LOA=
D_L3_MISS_RETIRED.REMOTE_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RET=
IRED.L1_MISS)) + 10 * (MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOAD_=
RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMOT=
E_FWD * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOAD=
_L3_MISS_RETIRED.REMOTE_HITM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETI=
RED.L1_MISS)) + (25 * (MEM_LOAD_RETIRED.LOCAL_PMM * (1 + MEM_LOAD_RETIRED.F=
B_HIT / MEM_LOAD_RETIRED.L1_MISS)) + 33 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_=
PMM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))))) * (CYCLE=
_ACTIVITY.STALLS_L3_MISS / tma_info_clks + (CYCLE_ACTIVITY.STALLS_L1D_MISS =
- CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_info_clks - tma_l2_bound) if 1e6 * (=
MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM + MEM_LOAD_RETIRED.LOCAL_PMM) > MEM_LOA=
D_RETIRED.L1_MISS else 0)",
+        "MetricExpr": "(((1 - ((19 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM=
 * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS)) + 10 * (MEM_LO=
AD_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RET=
IRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * (1 + MEM_LOAD_RETIRED=
.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM =
* (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))) / (19 * (MEM_L=
OAD_L3_MISS_RETIRED.REMOTE_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_R=
ETIRED.L1_MISS)) + 10 * (MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOA=
D_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REM=
OTE_FWD * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LO=
AD_L3_MISS_RETIRED.REMOTE_HITM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RE=
TIRED.L1_MISS)) + (25 * (MEM_LOAD_RETIRED.LOCAL_PMM * (1 + MEM_LOAD_RETIRED=
.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) if #has_pmem > 0 else 0) + 33 * (MEM_LO=
AD_L3_MISS_RETIRED.REMOTE_PMM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RET=
IRED.L1_MISS) if #has_pmem > 0 else 0))) if #has_pmem > 0 else 0)) * (CYCLE=
_ACTIVITY.STALLS_L3_MISS / tma_info_clks + (CYCLE_ACTIVITY.STALLS_L1D_MISS =
- CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_info_clks - tma_l2_bound) if 1e6 * (=
MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM + MEM_LOAD_RETIRED.LOCAL_PMM) > MEM_LOA=
D_RETIRED.L1_MISS else 0) if #has_pmem > 0 else 0)",
         "MetricGroup": "MemoryBound;Server;TmaL3mem;TopdownL3;tma_L3_group=
;tma_memory_bound_group",
         "MetricName": "tma_pmm_bound",
         "MetricThreshold": "tma_pmm_bound > 0.1 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json=
 b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
index 149cc4c07fb5..126300b7ae77 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
@@ -185,7 +185,7 @@
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "MEMORY_ACTIVITY.STALLS_L3_MISS / tma_info_clks - tm=
a_pmm_bound",
+        "MetricExpr": "(MEMORY_ACTIVITY.STALLS_L3_MISS / tma_info_clks - t=
ma_pmm_bound if #has_pmem > 0 else MEMORY_ACTIVITY.STALLS_L3_MISS / tma_inf=
o_clks)",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_dram_bound",
         "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2)",
@@ -968,7 +968,7 @@
     },
     {
         "BriefDescription": "Average latency of data read request to exter=
nal 3D X-Point memory [in nanoseconds]",
-        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PMM / UNC_=
CHA_TOR_INSERTS.IA_MISS_DRD_PMM) / uncore_cha_0@event\\=3D0x1@",
+        "MetricExpr": "(1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PMM / UNC=
_CHA_TOR_INSERTS.IA_MISS_DRD_PMM) / uncore_cha_0@event\\=3D0x1@ if #has_pme=
m > 0 else 0)",
         "MetricGroup": "Mem;MemoryLat;Server;SoC",
         "MetricName": "tma_info_mem_pmm_read_latency",
         "PublicDescription": "Average latency of data read request to exte=
rnal 3D X-Point memory [in nanoseconds]. Accounts for demand loads and L1/L=
2 data-read prefetches"
@@ -1034,13 +1034,13 @@
     },
     {
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for reads [=
GB / sec]",
-        "MetricExpr": "64 * UNC_M_PMM_RPQ_INSERTS / 1e9 / duration_time",
+        "MetricExpr": "(64 * UNC_M_PMM_RPQ_INSERTS / 1e9 / duration_time i=
f #has_pmem > 0 else 0)",
         "MetricGroup": "Mem;MemoryBW;Server;SoC",
         "MetricName": "tma_info_pmm_read_bw"
     },
     {
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for Writes =
[GB / sec]",
-        "MetricExpr": "64 * UNC_M_PMM_WPQ_INSERTS / 1e9 / duration_time",
+        "MetricExpr": "(64 * UNC_M_PMM_WPQ_INSERTS / 1e9 / duration_time i=
f #has_pmem > 0 else 0)",
         "MetricGroup": "Mem;MemoryBW;Server;SoC",
         "MetricName": "tma_info_pmm_write_bw"
     },
@@ -1406,7 +1406,7 @@
     },
     {
         "BriefDescription": "This metric roughly estimates (based on idle =
latencies) how often the CPU was stalled on accesses to external 3D-Xpoint =
(Crystal Ridge, a.k.a",
-        "MetricExpr": "((1 - (19 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM *=
 (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS)) + 10 * (MEM_LOAD=
_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIR=
ED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * (1 + MEM_LOAD_RETIRED.F=
B_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM * =
(1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))) / (19 * (MEM_LOA=
D_L3_MISS_RETIRED.REMOTE_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RET=
IRED.L1_MISS)) + 10 * (MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOAD_=
RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMOT=
E_FWD * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOAD=
_L3_MISS_RETIRED.REMOTE_HITM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETI=
RED.L1_MISS)) + (25 * (MEM_LOAD_RETIRED.LOCAL_PMM * (1 + MEM_LOAD_RETIRED.F=
B_HIT / MEM_LOAD_RETIRED.L1_MISS)) + 33 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_=
PMM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))))) * (MEMOR=
Y_ACTIVITY.STALLS_L3_MISS / tma_info_clks) if 1e6 * (MEM_LOAD_L3_MISS_RETIR=
ED.REMOTE_PMM + MEM_LOAD_RETIRED.LOCAL_PMM) > MEM_LOAD_RETIRED.L1_MISS else=
 0)",
+        "MetricExpr": "(((1 - ((19 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM=
 * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS)) + 10 * (MEM_LO=
AD_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RET=
IRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * (1 + MEM_LOAD_RETIRED=
.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM =
* (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))) / (19 * (MEM_L=
OAD_L3_MISS_RETIRED.REMOTE_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_R=
ETIRED.L1_MISS)) + 10 * (MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOA=
D_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REM=
OTE_FWD * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LO=
AD_L3_MISS_RETIRED.REMOTE_HITM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RE=
TIRED.L1_MISS)) + (25 * (MEM_LOAD_RETIRED.LOCAL_PMM * (1 + MEM_LOAD_RETIRED=
.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) if #has_pmem > 0 else 0) + 33 * (MEM_LO=
AD_L3_MISS_RETIRED.REMOTE_PMM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RET=
IRED.L1_MISS) if #has_pmem > 0 else 0))) if #has_pmem > 0 else 0)) * (MEMOR=
Y_ACTIVITY.STALLS_L3_MISS / tma_info_clks) if 1e6 * (MEM_LOAD_L3_MISS_RETIR=
ED.REMOTE_PMM + MEM_LOAD_RETIRED.LOCAL_PMM) > MEM_LOAD_RETIRED.L1_MISS else=
 0) if #has_pmem > 0 else 0)",
         "MetricGroup": "MemoryBound;Server;TmaL3mem;TopdownL3;tma_L3_group=
;tma_memory_bound_group",
         "MetricName": "tma_pmm_bound",
         "MetricThreshold": "tma_pmm_bound > 0.1 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
--=20
2.40.0.348.gf938b09366-goog

