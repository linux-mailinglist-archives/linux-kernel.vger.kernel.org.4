Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21686C7103
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjCWTWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjCWTWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:22:21 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C443310AA3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:21:51 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e129-20020a251e87000000b00b56598237f5so23558754ybe.16
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679599311;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xenl8HbHjUOf1l2xXBD3eq9W8bip5/6Vr49GtQAmSTQ=;
        b=GYyJYDk0YxeqZPC1RN3dC9Qzrn54iYhm4wCV71+kMQLu2+C/4UaISZq+YwUPt5iynR
         IbTjyiozMlt6NLPWGxOHdw1Tm6N7gjQqvmsPmUZd4GurzGxVsBzkYBfX3L7n5wyPE7er
         Bq6bxvbams+/ZumKRm1acxO6X+EV3YDdnMXXU3PXumrlEMO4k9LXkxR+6RXUls8C7Yxj
         cmcMu/rQCU4cezwUd+Cg2qv64h8v4pdomH4xkDyKZaD54d23fSUO6KOUPQmONXTaVm6p
         WVsayfJ0RIH7nqPxBkeje2LbJnfC04hB8b9ert1cEQM45k6hojotjyF+M0CbAgIwHW3O
         +58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679599311;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xenl8HbHjUOf1l2xXBD3eq9W8bip5/6Vr49GtQAmSTQ=;
        b=MgfnvF0te0HElV/EfLvl1KLzuN2/Ja1UEUWJ6BS6RmDENIJzL+GIxJWLrNIPKtwYnj
         jmuWqsl2uMctUBJwqiEYznJdIff4/e1nKH9Ne2TeI/1gMd4tfynMx38jxkqgHEyNsEXD
         u/PAm9BFx9GhlJ/zYwMvsJut/Eo3tAjeVUSbrzPxDp7u9XB3ysapVjvy/0cGZKOWDRuV
         2xpC/Q9YiDAPqyrTNmCsClemlc7+CGuRBR58B2h4m0Rfh8HBi22BcbNuZ0L7W77uczLs
         JajmfQ0UXnTuf4pxa1+Df+BZauYi6CIZ2RhNYPR680kuEXvBJ4a6Z00We1D/opVTTuip
         GcHA==
X-Gm-Message-State: AAQBX9dBcP5UX60jG0atBVyrRLYUcxeU+JP4VuVrsEgPlvklwXetZB43
        Pll/VHGsg1CrgcSwNG01e7dA4ZOIHved
X-Google-Smtp-Source: AKy350bbUx56bdqhOHu+iALCV7RX7M705+rFo0Dv0Q7pH81pp9rKoPmhYmsJTqjAhiPmlGPuVnbWv7CfIby4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e705:3a3d:46e5:fb50])
 (user=irogers job=sendgmr) by 2002:a05:6902:1083:b0:98e:6280:74ca with SMTP
 id v3-20020a056902108300b0098e628074camr3104022ybu.1.1679599310975; Thu, 23
 Mar 2023 12:21:50 -0700 (PDT)
Date:   Thu, 23 Mar 2023 12:20:28 -0700
In-Reply-To: <20230323192028.135759-1-irogers@google.com>
Message-Id: <20230323192028.135759-10-irogers@google.com>
Mime-Version: 1.0
References: <20230323192028.135759-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v2 9/9] perf vendor events: Update metrics to detect optane
 memory at runtime
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

By detecting whether optane memory is installed at runtime the number
of events can be reduced if it isn't. These changes come from this PR:
https://github.com/intel/perfmon/pull/63

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/cascadelakex/clx-metrics.json  | 10 +++++-----
 .../perf/pmu-events/arch/x86/icelakex/icx-metrics.json | 10 +++++-----
 .../arch/x86/sapphirerapids/spr-metrics.json           | 10 +++++-----
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b=
/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
index 4e993a3220e3..903f19ea1696 100644
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
lks - tma_l2_bound - tma_pmm_bound if #has_optane > 0 else CYCLE_ACTIVITY.S=
TALLS_L3_MISS / tma_info_clks + (CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACT=
IVITY.STALLS_L2_MISS) / tma_info_clks - tma_l2_bound)",
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
_INSERTS) / imc_0@event\\=3D0x0@ if #has_optane > 0 else 0)",
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
f #has_optane > 0 else 0)",
         "MetricGroup": "Mem;MemoryBW;Server;SoC",
         "MetricName": "tma_info_pmm_read_bw"
     },
     {
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for Writes =
[GB / sec]",
-        "MetricExpr": "64 * UNC_M_PMM_WPQ_INSERTS / 1e9 / duration_time",
+        "MetricExpr": "(64 * UNC_M_PMM_WPQ_INSERTS / 1e9 / duration_time i=
f #has_optane > 0 else 0)",
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
.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) if #has_optane > 0 else 0) + 33 * (MEM_=
LOAD_L3_MISS_RETIRED.REMOTE_PMM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_R=
ETIRED.L1_MISS) if #has_optane > 0 else 0))) if #has_optane > 0 else 0)) * =
(CYCLE_ACTIVITY.STALLS_L3_MISS / tma_info_clks + (CYCLE_ACTIVITY.STALLS_L1D=
_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_info_clks - tma_l2_bound) if 1=
e6 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM + MEM_LOAD_RETIRED.LOCAL_PMM) > M=
EM_LOAD_RETIRED.L1_MISS else 0) if #has_optane > 0 else 0)",
         "MetricGroup": "MemoryBound;Server;TmaL3mem;TopdownL3;tma_L3_group=
;tma_memory_bound_group",
         "MetricName": "tma_pmm_bound",
         "MetricThreshold": "tma_pmm_bound > 0.1 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json b/too=
ls/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
index 8109088a4df7..e5fba27dfe80 100644
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
lks - tma_l2_bound - tma_pmm_bound if #has_optane > 0 else CYCLE_ACTIVITY.S=
TALLS_L3_MISS / tma_info_clks + (CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACT=
IVITY.STALLS_L2_MISS) / tma_info_clks - tma_l2_bound)",
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
_CHA_TOR_INSERTS.IA_MISS_DRD_PMM) / cha_0@event\\=3D0x0@ if #has_optane > 0=
 else 0)",
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
f #has_optane > 0 else 0)",
         "MetricGroup": "Mem;MemoryBW;Server;SoC",
         "MetricName": "tma_info_pmm_read_bw"
     },
     {
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for Writes =
[GB / sec]",
-        "MetricExpr": "64 * UNC_M_PMM_WPQ_INSERTS / 1e9 / duration_time",
+        "MetricExpr": "(64 * UNC_M_PMM_WPQ_INSERTS / 1e9 / duration_time i=
f #has_optane > 0 else 0)",
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
.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) if #has_optane > 0 else 0) + 33 * (MEM_=
LOAD_L3_MISS_RETIRED.REMOTE_PMM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_R=
ETIRED.L1_MISS) if #has_optane > 0 else 0))) if #has_optane > 0 else 0)) * =
(CYCLE_ACTIVITY.STALLS_L3_MISS / tma_info_clks + (CYCLE_ACTIVITY.STALLS_L1D=
_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_info_clks - tma_l2_bound) if 1=
e6 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM + MEM_LOAD_RETIRED.LOCAL_PMM) > M=
EM_LOAD_RETIRED.L1_MISS else 0) if #has_optane > 0 else 0)",
         "MetricGroup": "MemoryBound;Server;TmaL3mem;TopdownL3;tma_L3_group=
;tma_memory_bound_group",
         "MetricName": "tma_pmm_bound",
         "MetricThreshold": "tma_pmm_bound > 0.1 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json=
 b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
index 149cc4c07fb5..d23fd6921a7f 100644
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
ma_pmm_bound if #has_optane > 0 else MEMORY_ACTIVITY.STALLS_L3_MISS / tma_i=
nfo_clks)",
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
_CHA_TOR_INSERTS.IA_MISS_DRD_PMM) / uncore_cha_0@event\\=3D0x1@ if #has_opt=
ane > 0 else 0)",
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
f #has_optane > 0 else 0)",
         "MetricGroup": "Mem;MemoryBW;Server;SoC",
         "MetricName": "tma_info_pmm_read_bw"
     },
     {
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for Writes =
[GB / sec]",
-        "MetricExpr": "64 * UNC_M_PMM_WPQ_INSERTS / 1e9 / duration_time",
+        "MetricExpr": "(64 * UNC_M_PMM_WPQ_INSERTS / 1e9 / duration_time i=
f #has_optane > 0 else 0)",
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
.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) if #has_optane > 0 else 0) + 33 * (MEM_=
LOAD_L3_MISS_RETIRED.REMOTE_PMM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_R=
ETIRED.L1_MISS) if #has_optane > 0 else 0))) if #has_optane > 0 else 0)) * =
(MEMORY_ACTIVITY.STALLS_L3_MISS / tma_info_clks) if 1e6 * (MEM_LOAD_L3_MISS=
_RETIRED.REMOTE_PMM + MEM_LOAD_RETIRED.LOCAL_PMM) > MEM_LOAD_RETIRED.L1_MIS=
S else 0) if #has_optane > 0 else 0)",
         "MetricGroup": "MemoryBound;Server;TmaL3mem;TopdownL3;tma_L3_group=
;tma_memory_bound_group",
         "MetricName": "tma_pmm_bound",
         "MetricThreshold": "tma_pmm_bound > 0.1 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
--=20
2.40.0.348.gf938b09366-goog

