Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7418464D6A6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 07:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiLOGth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 01:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiLOGtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:49:15 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799775FBBC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:48:52 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id v16-20020a17090a899000b00219b1f0ddebso1238508pjn.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLHmcuoLii4HJca89xHrM0zlFkLEO5w2fJUYiES+v+I=;
        b=Xjiz8EzYPD14GLXnd8zYct9e421Ne5CQlutsAAD/PtJsK9tmAwwgY+ZaM4I6kYg/Tf
         3gq/MFdUlZwfDB22QVWjFNF/1qEfQZBWk5nwOU3ndWA5QM26WevSAPG4GMPAI7EQisjV
         1K46dCWY8J6+xw38TJD40fKleZTMHgaAcMKSWPlvEWWCQqfHQoM0LEXwxzabPwQ88cZF
         RqZHdt2dMPm8yyaesSvQJMSn7fs76gibwvGhQWS7gHsifN/PEalQKFWYxH6SQiq/2gNZ
         6ZqUaNQJpkVIiVuKgJ2eavYOTBo0FTWgrMC4cRP5x0hFuSK3bJM9NBaKAGNquLYxzIq2
         ejSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oLHmcuoLii4HJca89xHrM0zlFkLEO5w2fJUYiES+v+I=;
        b=qiProWRk6nBDFu6I/mCzm9wsis9BOH/BwhcB2r07RrDBKg5PR5lSOYaJ5ZGdHWAHMr
         ofaNhvF2V7fu1GJszGoXDV24HmB9+eemSPE1+vwjq8TDMce7ZPfEw7s47M899pUa87S7
         YpjKrO/Qn/BQMZ5wS+ilSpBAhzOesPsii8HZCYbK7LCKcHA05iy9DuscTIcc0ehGwkpz
         9J3k4t/kMqZviYqWa0kBB7hUalQtEBikDMiisMnIpOYs641Hmy1UvB12vG7HcOrohVL9
         WIn6BSp5mLepeuvvAPZia18AccMpKnye6i0+9wWGuSYyYUMcQffv/9/Pb2/YyBuqmJDI
         2dsw==
X-Gm-Message-State: AFqh2kp67K6ZCK74TAoL8CiXtjuTP6zEGx5Ix4z7w4KW8LjPGEYLLbmH
        +ehf/AJ7G3OE9Cvz8YHAcgWuJcZL8jly
X-Google-Smtp-Source: AMrXdXvw0l85ZNFj4SFpwRnArVZD/BYQ4C+ftsObX/H00I4oeFMa7frszMnSpua4wKiMWgzrDsSlSCCuiBkA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c7dc:d96f:4f9:f59d])
 (user=irogers job=sendgmr) by 2002:a17:90a:d318:b0:220:1f03:129b with SMTP id
 p24-20020a17090ad31800b002201f03129bmr12279pju.0.1671086931398; Wed, 14 Dec
 2022 22:48:51 -0800 (PST)
Date:   Wed, 14 Dec 2022 22:47:28 -0800
In-Reply-To: <20221215064755.1620246-1-irogers@google.com>
Message-Id: <20221215064755.1620246-6-irogers@google.com>
Mime-Version: 1.0
References: <20221215064755.1620246-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 05/32] perf vendor events intel: Refresh broadwell metrics
 and events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Garry <john.g.garry@oracle.com>,
        Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
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

Update the broadwell metrics and events using the new tooling from:
https://github.com/intel/perfmon
The metrics are unchanged but the formulas differ due to parentheses,
use of exponents and removal of redundant operations like "* 1".  The
events are unchanged but unused json values are removed, implicit
umasks of 0 are dropped and duplicate short and long descriptions have
the long one dropped. This increases consistency across the json
files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/broadwell/bdw-metrics.json       | 137 +--
 .../pmu-events/arch/x86/broadwell/cache.json  | 957 ------------------
 .../arch/x86/broadwell/floating-point.json    |  40 -
 .../arch/x86/broadwell/frontend.json          |  56 -
 .../pmu-events/arch/x86/broadwell/memory.json | 890 ----------------
 .../pmu-events/arch/x86/broadwell/other.json  |   8 -
 .../arch/x86/broadwell/pipeline.json          | 272 -----
 .../arch/x86/broadwell/uncore-cache.json      |  19 -
 .../arch/x86/broadwell/uncore-other.json      |  25 +-
 .../arch/x86/broadwell/virtual-memory.json    |  76 --
 10 files changed, 84 insertions(+), 2396 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json b/to=
ols/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
index c220b1cf1740..c3ea39d6c944 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
@@ -110,7 +110,7 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
-        "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * =
((INT_MISC.RECOVERY_CYCLES_ANY / 2) if #SMT_on else INT_MISC.RECOVERY_CYCLE=
S)) / SLOTS",
+        "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * =
(INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)=
) / SLOTS",
         "MetricGroup": "TopdownL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
@@ -118,7 +118,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction",
-        "MetricExpr": "(BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRED.AL=
L_BRANCHES + MACHINE_CLEARS.COUNT)) * tma_bad_speculation",
+        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRED.ALL=
_BRANCHES + MACHINE_CLEARS.COUNT) * tma_bad_speculation",
         "MetricGroup": "BadSpec;BrMispredicts;TopdownL2;tma_L2_group;tma_b=
ad_speculation_group",
         "MetricName": "tma_branch_mispredicts",
         "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES",
@@ -142,7 +142,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
-        "MetricExpr": "((CYCLE_ACTIVITY.STALLS_MEM_ANY + RESOURCE_STALLS.S=
B) / (CYCLE_ACTIVITY.STALLS_TOTAL + UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC - UO=
PS_EXECUTED.CYCLES_GE_3_UOPS_EXEC if (IPC > 1.8) else UOPS_EXECUTED.CYCLES_=
GE_2_UOPS_EXEC - RS_EVENTS.EMPTY_CYCLES if (tma_fetch_latency > 0.1) else R=
ESOURCE_STALLS.SB)) * tma_backend_bound",
+        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_MEM_ANY + RESOURCE_STALLS.SB=
) / (CYCLE_ACTIVITY.STALLS_TOTAL + UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC - UOP=
S_EXECUTED.CYCLES_GE_3_UOPS_EXEC if IPC > 1.8 else (UOPS_EXECUTED.CYCLES_GE=
_2_UOPS_EXEC - RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else RESOU=
RCE_STALLS.SB)) * tma_backend_bound",
         "MetricGroup": "Backend;TopdownL2;tma_L2_group;tma_backend_bound_g=
roup",
         "MetricName": "tma_memory_bound",
         "PublicDescription": "This metric represents fraction of slots the=
 Memory subsystem within the Backend was a bottleneck.  Memory Bound estima=
tes fraction of slots where pipeline is likely stalled due to demand load o=
r store instructions. This accounts mainly for (1) non-completed in-flight =
memory demand loads which coincides with execution units starvation; in add=
ition to (2) cases where stores could impose backpressure on the pipeline w=
hen many of them get buffered at the same time (less common out of the two)=
.",
@@ -174,7 +174,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
-        "MetricExpr": "(MEM_UOPS_RETIRED.LOCK_LOADS / MEM_UOPS_RETIRED.ALL=
_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTANDING.CYCLES=
_WITH_DEMAND_RFO) / CLKS",
+        "MetricExpr": "MEM_UOPS_RETIRED.LOCK_LOADS / MEM_UOPS_RETIRED.ALL_=
STORES * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTANDING.CYCLES_W=
ITH_DEMAND_RFO) / CLKS",
         "MetricGroup": "Offcore;TopdownL4;tma_l1_bound_group",
         "MetricName": "tma_lock_latency",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them. Sample with: MEM_UOPS_RETIRED.LOCK_LOA=
DS_PS",
@@ -214,7 +214,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
-        "MetricExpr": "(MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD_UOPS_RETI=
RED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS)) * CYCLE_ACTIVITY.STALLS_L2=
_MISS / CLKS",
+        "MetricExpr": "MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD_UOPS_RETIR=
ED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS) * CYCLE_ACTIVITY.STALLS_L2_M=
ISS / CLKS",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_mem=
ory_bound_group",
         "MetricName": "tma_l3_bound",
         "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT_PS",
@@ -222,7 +222,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
-        "MetricExpr": "(60 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HITM * (1 =
+ mem_load_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD=
_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOP=
S_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS) + MEM_=
LOAD_UOPS_RETIRED.L3_MISS))) + 43 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS=
 * (1 + mem_load_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + ME=
M_LOAD_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LO=
AD_UOPS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS) =
+ MEM_LOAD_UOPS_RETIRED.L3_MISS)))) / CLKS",
+        "MetricExpr": "(60 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HITM * (1 =
+ MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_=
UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS=
_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_LO=
AD_UOPS_RETIRED.L3_MISS))) + 43 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS *=
 (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_L=
OAD_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_=
UOPS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + ME=
M_LOAD_UOPS_RETIRED.L3_MISS)))) / CLKS",
         "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_l3_bound_g=
roup",
         "MetricName": "tma_contested_accesses",
         "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS",
@@ -230,7 +230,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
-        "MetricExpr": "43 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT * (1 + =
mem_load_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_U=
OPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_=
L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS) + MEM_LO=
AD_UOPS_RETIRED.L3_MISS))) / CLKS",
+        "MetricExpr": "43 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT * (1 + =
MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UO=
PS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_L=
3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_LOAD=
_UOPS_RETIRED.L3_MISS))) / CLKS",
         "MetricGroup": "Offcore;Snoop;TopdownL4;tma_l3_bound_group",
         "MetricName": "tma_data_sharing",
         "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_L3_HIT_RETIRED.XSNP_HIT_PS",
@@ -238,7 +238,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited)",
-        "MetricExpr": "29 * (MEM_LOAD_UOPS_RETIRED.L3_HIT * (1 + mem_load_=
uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UOPS_RETIR=
ED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_L3_HIT_RE=
TIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS) + MEM_LOAD_UOPS_R=
ETIRED.L3_MISS))) / CLKS",
+        "MetricExpr": "29 * (MEM_LOAD_UOPS_RETIRED.L3_HIT * (1 + MEM_LOAD_=
UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UOPS_RETIRE=
D.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_L3_HIT_RET=
IRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_LOAD_UOPS_RET=
IRED.L3_MISS))) / CLKS",
         "MetricGroup": "MemoryLat;TopdownL4;tma_l3_bound_group",
         "MetricName": "tma_l3_hit_latency",
         "PublicDescription": "This metric represents fraction of cycles wi=
th demand load accesses that hit the L3 cache under unloaded scenarios (pos=
sibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L=
3 hits) will improve the latency; reduce contention with sibling physical c=
ores and increase performance.  Note the value of this node may overlap wit=
h its siblings. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT_PS",
@@ -246,7 +246,7 @@
     },
     {
         "BriefDescription": "This metric measures fraction of cycles where=
 the Super Queue (SQ) was full taking into account all request-types and bo=
th hardware SMT threads (Logical Processors)",
-        "MetricExpr": "((OFFCORE_REQUESTS_BUFFER.SQ_FULL / 2) if #SMT_on e=
lse OFFCORE_REQUESTS_BUFFER.SQ_FULL) / CORE_CLKS",
+        "MetricExpr": "(OFFCORE_REQUESTS_BUFFER.SQ_FULL / 2 if #SMT_on els=
e OFFCORE_REQUESTS_BUFFER.SQ_FULL) / CORE_CLKS",
         "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_l3_bound_group",
         "MetricName": "tma_sq_full",
         "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). The Super Queue is used for =
requests to access the L2 cache or to go out to the Uncore.",
@@ -254,7 +254,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
-        "MetricExpr": "(1 - (MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD_UOPS=
_RETIRED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS))) * CYCLE_ACTIVITY.STA=
LLS_L2_MISS / CLKS",
+        "MetricExpr": "(1 - MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD_UOPS_=
RETIRED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS)) * CYCLE_ACTIVITY.STALL=
S_L2_MISS / CLKS",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_memory_bound_gr=
oup",
         "MetricName": "tma_dram_bound",
         "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_UOPS_RE=
TIRED.L3_MISS_PS",
@@ -286,7 +286,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
-        "MetricExpr": "((L2_RQSTS.RFO_HIT * 9 * (1 - (MEM_UOPS_RETIRED.LOC=
K_LOADS / MEM_UOPS_RETIRED.ALL_STORES))) + (1 - (MEM_UOPS_RETIRED.LOCK_LOAD=
S / MEM_UOPS_RETIRED.ALL_STORES)) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_RE=
QUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / CLKS",
+        "MetricExpr": "(L2_RQSTS.RFO_HIT * 9 * (1 - MEM_UOPS_RETIRED.LOCK_=
LOADS / MEM_UOPS_RETIRED.ALL_STORES) + (1 - MEM_UOPS_RETIRED.LOCK_LOADS / M=
EM_UOPS_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS=
_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / CLKS",
         "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_store_bound_group"=
,
         "MetricName": "tma_store_latency",
         "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full)",
@@ -334,7 +334,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
-        "MetricExpr": "((CYCLE_ACTIVITY.STALLS_TOTAL + UOPS_EXECUTED.CYCLE=
S_GE_1_UOP_EXEC - UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC if (IPC > 1.8) else U=
OPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC - RS_EVENTS.EMPTY_CYCLES if (tma_fetch_l=
atency > 0.1) else RESOURCE_STALLS.SB) - RESOURCE_STALLS.SB - CYCLE_ACTIVIT=
Y.STALLS_MEM_ANY) / CLKS",
+        "MetricExpr": "((CYCLE_ACTIVITY.STALLS_TOTAL + UOPS_EXECUTED.CYCLE=
S_GE_1_UOP_EXEC - UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC if IPC > 1.8 else (UO=
PS_EXECUTED.CYCLES_GE_2_UOPS_EXEC - RS_EVENTS.EMPTY_CYCLES if tma_fetch_lat=
ency > 0.1 else RESOURCE_STALLS.SB)) - RESOURCE_STALLS.SB - CYCLE_ACTIVITY.=
STALLS_MEM_ANY) / CLKS",
         "MetricGroup": "PortsUtil;TopdownL3;tma_core_bound_group",
         "MetricName": "tma_ports_utilization",
         "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations.",
@@ -342,7 +342,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
-        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,inv\\,cmask\\=3D1@) / 2 i=
f #SMT_on else (CYCLE_ACTIVITY.STALLS_TOTAL - RS_EVENTS.EMPTY_CYCLES if (tm=
a_fetch_latency > 0.1) else 0) / CORE_CLKS",
+        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,inv\\,cmask\\=3D1@ / 2 if=
 #SMT_on else (CYCLE_ACTIVITY.STALLS_TOTAL - RS_EVENTS.EMPTY_CYCLES if tma_=
fetch_latency > 0.1 else 0) / CORE_CLKS)",
         "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
         "MetricName": "tma_ports_utilized_0",
         "PublicDescription": "This metric represents fraction of cycles CP=
U executed no uops on any execution port (Logical Processor cycles since IC=
L, Physical Core cycles otherwise). Long-latency instructions like divides =
may contribute to this metric.",
@@ -350,7 +350,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re the CPU executed total of 1 uop per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UOPS_E=
XECUTED.CORE\\,cmask\\=3D2@) / 2 if #SMT_on else (UOPS_EXECUTED.CYCLES_GE_1=
_UOP_EXEC - UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC) / CORE_CLKS",
+        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D2@) / 2 if #SMT_on else (UOPS_EXECUTED.CYCLES_GE_=
1_UOP_EXEC - UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC) / CORE_CLKS)",
         "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
         "MetricName": "tma_ports_utilized_1",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere the CPU executed total of 1 uop per cycle on all execution ports (Logic=
al Processor cycles since ICL, Physical Core cycles otherwise). This can be=
 due to heavy data-dependency among software instructions; or over oversubs=
cribing a particular hardware resource. In some other cases with high 1_Por=
t_Utilized and L1_Bound; this metric can point to L1 data-cache latency bot=
tleneck that may not necessarily manifest with complete execution starvatio=
n (due to the short L1 latency e.g. walking a linked list) - looking at the=
 assembly can be helpful.",
@@ -358,7 +358,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 2 uops per cycle on all execution ports (Logical Process=
or cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@ - cpu@UOPS_E=
XECUTED.CORE\\,cmask\\=3D3@) / 2 if #SMT_on else (UOPS_EXECUTED.CYCLES_GE_2=
_UOPS_EXEC - UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / CORE_CLKS",
+        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D3@) / 2 if #SMT_on else (UOPS_EXECUTED.CYCLES_GE_=
2_UOPS_EXEC - UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / CORE_CLKS)",
         "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
         "MetricName": "tma_ports_utilized_2",
         "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop.",
@@ -366,14 +366,14 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise).",
-        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ / 2) if #SM=
T_on else UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / CORE_CLKS",
+        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ / 2 if #SMT_=
on else UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / CORE_CLKS",
         "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
         "MetricName": "tma_ports_utilized_3m",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
-        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_0 + UOPS_DISPATCHED_PORT=
.PORT_1 + UOPS_DISPATCHED_PORT.PORT_5 + UOPS_DISPATCHED_PORT.PORT_6) / (4 *=
 CORE_CLKS)",
+        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_0 + UOPS_DISPATCHED_PORT=
.PORT_1 + UOPS_DISPATCHED_PORT.PORT_5 + UOPS_DISPATCHED_PORT.PORT_6) / SLOT=
S",
         "MetricGroup": "TopdownL5;tma_ports_utilized_3m_group",
         "MetricName": "tma_alu_op_utilization",
         "ScaleUnit": "100%"
@@ -429,7 +429,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Store operations",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_4 / CORE_CLKS",
+        "MetricExpr": "tma_port_4",
         "MetricGroup": "TopdownL5;tma_ports_utilized_3m_group",
         "MetricName": "tma_store_op_utilization",
         "ScaleUnit": "100%"
@@ -522,7 +522,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU was retiring uops fetched by the Microcode Sequencer (MS) unit",
-        "MetricExpr": "(UOPS_RETIRED.RETIRE_SLOTS / UOPS_ISSUED.ANY) * IDQ=
.MS_UOPS / SLOTS",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / UOPS_ISSUED.ANY * IDQ.M=
S_UOPS / SLOTS",
         "MetricGroup": "MicroSeq;TopdownL3;tma_heavy_operations_group",
         "MetricName": "tma_microcode_sequencer",
         "PublicDescription": "This metric represents fraction of slots the=
 CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The M=
S is used for CISC instructions not supported by the default decoders (like=
 repeat move strings; or CPUID); or by microcode assists used to address so=
me operation modes (like in Floating Point assists). These cases can often =
be avoided. Sample with: IDQ.MS_UOPS",
@@ -595,26 +595,26 @@
     },
     {
         "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricExpr": "(1 * (FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARIT=
H_INST_RETIRED.SCALAR_DOUBLE) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBL=
E + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.2=
56B_PACKED_DOUBLE) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) / CORE_C=
LKS",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 =
* (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PA=
CKED_DOUBLE) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) / CORE_CLKS",
         "MetricGroup": "Flops;Ret",
         "MetricName": "FLOPc"
     },
     {
         "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
-        "MetricExpr": "((FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_IN=
ST_RETIRED.SCALAR_DOUBLE) + (FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_=
ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_D=
OUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE)) / (2 * CORE_CLKS)",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE + (FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_AR=
ITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOU=
BLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE)) / (2 * CORE_CLKS)",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "FP_Arith_Utilization",
         "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)."
     },
     {
         "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / ((cpu@UOPS_EXECUTED.CORE\\,c=
mask\\=3D1@ / 2) if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (cpu@UOPS_EXECUTED.CORE\\,cm=
ask\\=3D1@ / 2 if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
         "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
         "MetricName": "ILP"
     },
     {
         "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
-        "MetricExpr": "((CPU_CLK_UNHALTED.THREAD / 2) * (1 + CPU_CLK_UNHAL=
TED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK)) if #core_wide < 1 else =
(CPU_CLK_UNHALTED.THREAD_ANY / 2) if #SMT_on else CLKS",
+        "MetricExpr": "(CPU_CLK_UNHALTED.THREAD / 2 * (1 + CPU_CLK_UNHALTE=
D.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK) if #core_wide < 1 else (CP=
U_CLK_UNHALTED.THREAD_ANY / 2 if #SMT_on else CLKS))",
         "MetricGroup": "SMT",
         "MetricName": "CORE_CLKS"
     },
@@ -656,13 +656,13 @@
     },
     {
         "BriefDescription": "Instructions per Floating Point (FP) Operatio=
n (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / (1 * (FP_ARITH_INST_RETIRED.SCAL=
AR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE) + 2 * FP_ARITH_INST_RETIRE=
D.128B_PACKED_DOUBLE + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_A=
RITH_INST_RETIRED.256B_PACKED_DOUBLE) + 8 * FP_ARITH_INST_RETIRED.256B_PACK=
ED_SINGLE)",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR_SI=
NGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE + 2 * FP_ARITH_INST_RETIRED.128B=
_PACKED_DOUBLE + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_I=
NST_RETIRED.256B_PACKED_DOUBLE) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SIN=
GLE)",
         "MetricGroup": "Flops;InsType",
         "MetricName": "IpFLOP"
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic instruction (l=
ower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / ((FP_ARITH_INST_RETIRED.SCALAR_S=
INGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE) + (FP_ARITH_INST_RETIRED.128B_=
PACKED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RE=
TIRED.256B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE))",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR_SI=
NGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE + (FP_ARITH_INST_RETIRED.128B_PA=
CKED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETI=
RED.256B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE))",
         "MetricGroup": "Flops;InsType",
         "MetricName": "IpArith",
         "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). May undercount due to FMA doubl=
e counting. Approximated prior to BDW."
@@ -715,7 +715,7 @@
     },
     {
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
-        "MetricExpr": "IDQ.DSB_UOPS / ((IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE=
_UOPS + IDQ.MS_UOPS))",
+        "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_=
UOPS + IDQ.MS_UOPS)",
         "MetricGroup": "DSB;Fed;FetchBW",
         "MetricName": "DSB_Coverage"
     },
@@ -727,13 +727,13 @@
     },
     {
         "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
-        "MetricExpr": " (tma_branch_mispredicts + tma_fetch_latency * tma_=
mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icache=
_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) * SLOTS / BR_MISP_R=
ETIRED.ALL_BRANCHES",
+        "MetricExpr": "(tma_branch_mispredicts + tma_fetch_latency * tma_m=
ispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icache_=
misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) * SLOTS / BR_MISP_RE=
TIRED.ALL_BRANCHES",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "Branch_Misprediction_Cost"
     },
     {
         "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / (MEM_LOAD_UOPS_RETIRED.L1_M=
ISS + mem_load_uops_retired.hit_lfb)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / (MEM_LOAD_UOPS_RETIRED.L1_M=
ISS + MEM_LOAD_UOPS_RETIRED.HIT_LFB)",
         "MetricGroup": "Mem;MemoryBound;MemoryLat",
         "MetricName": "Load_Miss_Real_Latency"
     },
@@ -745,43 +745,43 @@
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED=
.ANY",
+        "MetricExpr": "1e3 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED.=
ANY",
         "MetricGroup": "CacheMisses;Mem",
         "MetricName": "L1MPKI"
     },
     {
         "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED=
.ANY",
+        "MetricExpr": "1e3 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.=
ANY",
         "MetricGroup": "Backend;CacheMisses;Mem",
         "MetricName": "L2MPKI"
     },
     {
         "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all request types (including speculative)",
-        "MetricExpr": "1000 * L2_RQSTS.MISS / INST_RETIRED.ANY",
+        "MetricExpr": "1e3 * L2_RQSTS.MISS / INST_RETIRED.ANY",
         "MetricGroup": "CacheMisses;Mem;Offcore",
         "MetricName": "L2MPKI_All"
     },
     {
         "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all demand loads  (including speculative)",
-        "MetricExpr": "1000 * L2_RQSTS.DEMAND_DATA_RD_MISS / INST_RETIRED.=
ANY",
+        "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_MISS / INST_RETIRED.A=
NY",
         "MetricGroup": "CacheMisses;Mem",
         "MetricName": "L2MPKI_Load"
     },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all re=
quest types (including speculative)",
-        "MetricExpr": "1000 * (L2_RQSTS.REFERENCES - L2_RQSTS.MISS) / INST=
_RETIRED.ANY",
+        "MetricExpr": "1e3 * (L2_RQSTS.REFERENCES - L2_RQSTS.MISS) / INST_=
RETIRED.ANY",
         "MetricGroup": "CacheMisses;Mem",
         "MetricName": "L2HPKI_All"
     },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all de=
mand loads  (including speculative)",
-        "MetricExpr": "1000 * L2_RQSTS.DEMAND_DATA_RD_HIT / INST_RETIRED.A=
NY",
+        "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_HIT / INST_RETIRED.AN=
Y",
         "MetricGroup": "CacheMisses;Mem",
         "MetricName": "L2HPKI_Load"
     },
     {
         "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L3_MISS / INST_RETIRED=
.ANY",
+        "MetricExpr": "1e3 * MEM_LOAD_UOPS_RETIRED.L3_MISS / INST_RETIRED.=
ANY",
         "MetricGroup": "CacheMisses;Mem",
         "MetricName": "L3MPKI"
     },
@@ -794,19 +794,19 @@
     },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / duration_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "L1D_Cache_Fill_BW"
     },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / duration_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "L2_Cache_Fill_BW"
     },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration=
_time",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / duration_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "L3_Cache_Fill_BW"
     },
@@ -836,19 +836,19 @@
     },
     {
         "BriefDescription": "Average CPU Utilization",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
         "MetricGroup": "HPC;Summary",
         "MetricName": "CPU_Utilization"
     },
     {
         "BriefDescription": "Measured Average Frequency for unhalted proce=
ssors [GHz]",
-        "MetricExpr": "Turbo_Utilization * msr@tsc@ / 1000000000 / duratio=
n_time",
+        "MetricExpr": "Turbo_Utilization * TSC / 1e9 / duration_time",
         "MetricGroup": "Power;Summary",
         "MetricName": "Average_Frequency"
     },
     {
         "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "((1 * (FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARI=
TH_INST_RETIRED.SCALAR_DOUBLE) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUB=
LE + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.=
256B_PACKED_DOUBLE) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) / 10000=
00000) / duration_time",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 =
* (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PA=
CKED_DOUBLE) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) / 1e9 / durati=
on_time",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "GFLOPs",
         "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine."
@@ -861,7 +861,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
-        "MetricExpr": "1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / (CPU_CLK_U=
NHALTED.REF_XCLK_ANY / 2) if #SMT_on else 0",
+        "MetricExpr": "(1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / (CPU_CLK_=
UNHALTED.REF_XCLK_ANY / 2) if #SMT_on else 0)",
         "MetricGroup": "SMT",
         "MetricName": "SMT_2T_Utilization"
     },
@@ -879,68 +879,87 @@
     },
     {
         "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
-        "MetricExpr": "64 * (arb@event\\=3D0x81\\,umask\\=3D0x1@ + arb@eve=
nt\\=3D0x84\\,umask\\=3D0x1@) / 1000000 / duration_time / 1000",
+        "MetricExpr": "64 * (UNC_ARB_TRK_REQUESTS.ALL + UNC_ARB_COH_TRK_RE=
QUESTS.ALL) / 1e6 / duration_time / 1e3",
         "MetricGroup": "HPC;Mem;MemoryBW;SoC",
         "MetricName": "DRAM_BW_Use"
     },
     {
         "BriefDescription": "Average latency of all requests to external m=
emory (in Uncore cycles)",
-        "MetricExpr": "UNC_ARB_TRK_OCCUPANCY.ALL / arb@event\\=3D0x81\\,um=
ask\\=3D0x1@",
+        "MetricExpr": "MEM_Parallel_Requests",
         "MetricGroup": "Mem;SoC",
         "MetricName": "MEM_Request_Latency"
     },
     {
         "BriefDescription": "Average number of parallel requests to extern=
al memory. Accounts for all requests",
-        "MetricExpr": "UNC_ARB_TRK_OCCUPANCY.ALL / arb@event\\=3D0x81\\,um=
ask\\=3D0x1@",
+        "MetricExpr": "UNC_ARB_TRK_OCCUPANCY.ALL / UNC_ARB_TRK_REQUESTS.AL=
L",
         "MetricGroup": "Mem;SoC",
         "MetricName": "MEM_Parallel_Requests"
     },
+    {
+        "BriefDescription": "Socket actual clocks when any core is active =
on that socket",
+        "MetricExpr": "UNC_CLOCK.SOCKET",
+        "MetricGroup": "SoC",
+        "MetricName": "Socket_CLKS"
+    },
     {
         "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
         "MetricGroup": "Branches;OS",
         "MetricName": "IpFarBranch"
     },
+    {
+        "BriefDescription": "Uncore frequency per die [GHZ]",
+        "MetricExpr": "Socket_CLKS / #num_dies / duration_time / 1e9",
+        "MetricGroup": "SoC",
+        "MetricName": "UNCORE_FREQ"
+    },
     {
         "BriefDescription": "C3 residency percent per core",
-        "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
+        "MetricExpr": "cstate_core@c3\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C3_Core_Residency"
+        "MetricName": "C3_Core_Residency",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C6 residency percent per core",
-        "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
+        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C6_Core_Residency"
+        "MetricName": "C6_Core_Residency",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C7 residency percent per core",
-        "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
+        "MetricExpr": "cstate_core@c7\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C7_Core_Residency"
+        "MetricName": "C7_Core_Residency",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C2 residency percent per package",
-        "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
+        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C2_Pkg_Residency"
+        "MetricName": "C2_Pkg_Residency",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C3 residency percent per package",
-        "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
+        "MetricExpr": "cstate_pkg@c3\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C3_Pkg_Residency"
+        "MetricName": "C3_Pkg_Residency",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C6 residency percent per package",
-        "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
+        "MetricExpr": "cstate_pkg@c6\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C6_Pkg_Residency"
+        "MetricName": "C6_Pkg_Residency",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C7 residency percent per package",
-        "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
+        "MetricExpr": "cstate_pkg@c7\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C7_Pkg_Residency"
+        "MetricName": "C7_Pkg_Residency",
+        "ScaleUnit": "100%"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/cache.json b/tools/pe=
rf/pmu-events/arch/x86/broadwell/cache.json
index f3d7fced28b6..26199d3ebb25 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/cache.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "L1D data line replacements",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x51",
         "EventName": "L1D.REPLACEMENT",
         "PublicDescription": "This event counts L1D data line replacements=
 including opportunistic replacements, and replacements that require stall-=
for-replace or block-for-replace.",
@@ -11,8 +9,6 @@
     },
     {
         "BriefDescription": "Cycles a demand request was blocked due to Fi=
ll Buffers inavailability.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL",
@@ -21,8 +17,6 @@
     },
     {
         "BriefDescription": "L1D miss oustandings duration in cycles",
-        "Counter": "2",
-        "CounterHTOff": "2",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING",
         "PublicDescription": "This event counts duration of L1D miss outst=
anding, that is each cycle number of Fill Buffers (FB) outstanding required=
 by Demand Reads. FB either is held by demand loads, or it is held by non-d=
emand loads and gets hit at least once by demand. The valid outstanding int=
erval is defined until the FB deallocation by one of the following ways: fr=
om FB allocation, if FB is allocated by demand; from the demand Hit FB, if =
it is allocated by hardware or software prefetch.\nNote: In the L1D, a Dema=
nd Read contains cacheable or noncacheable demand loads, including ones cau=
sing cache-line splits and reads due to page walks resulted from any reques=
t type.",
@@ -31,8 +25,6 @@
     },
     {
         "BriefDescription": "Cycles with L1D load Misses outstanding.",
-        "Counter": "2",
-        "CounterHTOff": "2",
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING_CYCLES",
@@ -43,8 +35,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles with L1D load Misses outstanding from =
any thread on physical core.",
-        "Counter": "2",
-        "CounterHTOff": "2",
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING_CYCLES_ANY",
@@ -53,8 +43,6 @@
     },
     {
         "BriefDescription": "Not rejected writebacks that hit L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x27",
         "EventName": "L2_DEMAND_RQSTS.WB_HIT",
         "PublicDescription": "This event counts the number of WB requests =
that hit L2 cache.",
@@ -63,8 +51,6 @@
     },
     {
         "BriefDescription": "L2 cache lines filling L2",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.ALL",
         "PublicDescription": "This event counts the number of L2 cache lin=
es filling the L2. Counting does not cover rejects.",
@@ -73,8 +59,6 @@
     },
     {
         "BriefDescription": "L2 cache lines in E state filling L2",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.E",
         "PublicDescription": "This event counts the number of L2 cache lin=
es in the Exclusive state filling the L2. Counting does not cover rejects."=
,
@@ -83,8 +67,6 @@
     },
     {
         "BriefDescription": "L2 cache lines in I state filling L2",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.I",
         "PublicDescription": "This event counts the number of L2 cache lin=
es in the Invalidate state filling the L2. Counting does not cover rejects.=
",
@@ -93,8 +75,6 @@
     },
     {
         "BriefDescription": "L2 cache lines in S state filling L2",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.S",
         "PublicDescription": "This event counts the number of L2 cache lin=
es in the Shared state filling the L2. Counting does not cover rejects.",
@@ -103,8 +83,6 @@
     },
     {
         "BriefDescription": "Clean L2 cache lines evicted by demand.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.DEMAND_CLEAN",
         "SampleAfterValue": "100003",
@@ -112,8 +90,6 @@
     },
     {
         "BriefDescription": "L2 code requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_CODE_RD",
         "PublicDescription": "This event counts the total number of L2 cod=
e requests.",
@@ -122,8 +98,6 @@
     },
     {
         "BriefDescription": "Demand Data Read requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
         "PublicDescription": "This event counts the number of demand Data =
Read requests (including requests from L1D hardware prefetchers). These loa=
ds may hit or miss L2 cache. Only non rejected loads are counted.",
@@ -132,8 +106,6 @@
     },
     {
         "BriefDescription": "Demand requests that miss L2 cache.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_MISS",
         "SampleAfterValue": "200003",
@@ -141,8 +113,6 @@
     },
     {
         "BriefDescription": "Demand requests to L2 cache.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_REFERENCES",
         "SampleAfterValue": "200003",
@@ -150,8 +120,6 @@
     },
     {
         "BriefDescription": "Requests from L2 hardware prefetchers",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_PF",
         "PublicDescription": "This event counts the total number of reques=
ts from the L2 hardware prefetchers.",
@@ -160,8 +128,6 @@
     },
     {
         "BriefDescription": "RFO requests to L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_RFO",
         "PublicDescription": "This event counts the total number of RFO (r=
ead for ownership) requests to L2 cache. L2 RFO requests include both L1D d=
emand RFO misses as well as L1D RFO prefetches.",
@@ -170,8 +136,6 @@
     },
     {
         "BriefDescription": "L2 cache hits when fetching instructions, cod=
e reads.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_HIT",
         "SampleAfterValue": "200003",
@@ -179,8 +143,6 @@
     },
     {
         "BriefDescription": "L2 cache misses when fetching instructions.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_MISS",
         "SampleAfterValue": "200003",
@@ -188,8 +150,6 @@
     },
     {
         "BriefDescription": "Demand Data Read requests that hit L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
         "PublicDescription": "Counts the number of demand Data Read reques=
ts, initiated by load instructions, that hit L2 cache.",
@@ -198,8 +158,6 @@
     },
     {
         "BriefDescription": "Demand Data Read miss L2, no rejects",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
         "PublicDescription": "This event counts the number of demand Data =
Read requests that miss L2 cache. Only not rejected loads are counted.",
@@ -208,8 +166,6 @@
     },
     {
         "BriefDescription": "L2 prefetch requests that hit L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.L2_PF_HIT",
         "PublicDescription": "This event counts the number of requests fro=
m the L2 hardware prefetchers that hit L2 cache. L3 prefetch new types.",
@@ -218,8 +174,6 @@
     },
     {
         "BriefDescription": "L2 prefetch requests that miss L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.L2_PF_MISS",
         "PublicDescription": "This event counts the number of requests fro=
m the L2 hardware prefetchers that miss L2 cache.",
@@ -228,8 +182,6 @@
     },
     {
         "BriefDescription": "All requests that miss L2 cache.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.MISS",
         "SampleAfterValue": "200003",
@@ -237,8 +189,6 @@
     },
     {
         "BriefDescription": "All L2 requests.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.REFERENCES",
         "SampleAfterValue": "200003",
@@ -246,8 +196,6 @@
     },
     {
         "BriefDescription": "RFO requests that hit L2 cache.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_HIT",
         "SampleAfterValue": "200003",
@@ -255,8 +203,6 @@
     },
     {
         "BriefDescription": "RFO requests that miss L2 cache.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_MISS",
         "SampleAfterValue": "200003",
@@ -264,8 +210,6 @@
     },
     {
         "BriefDescription": "L2 or L3 HW prefetches that access L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF0",
         "EventName": "L2_TRANS.ALL_PF",
         "PublicDescription": "This event counts L2 or L3 HW prefetches tha=
t access L2 cache including rejects.",
@@ -274,8 +218,6 @@
     },
     {
         "BriefDescription": "Transactions accessing L2 pipe",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF0",
         "EventName": "L2_TRANS.ALL_REQUESTS",
         "PublicDescription": "This event counts transactions that access t=
he L2 pipe including snoops, pagewalks, and so on.",
@@ -284,8 +226,6 @@
     },
     {
         "BriefDescription": "L2 cache accesses when fetching instructions"=
,
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF0",
         "EventName": "L2_TRANS.CODE_RD",
         "PublicDescription": "This event counts the number of L2 cache acc=
esses when fetching instructions.",
@@ -294,8 +234,6 @@
     },
     {
         "BriefDescription": "Demand Data Read requests that access L2 cach=
e",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF0",
         "EventName": "L2_TRANS.DEMAND_DATA_RD",
         "PublicDescription": "This event counts Demand Data Read requests =
that access L2 cache, including rejects.",
@@ -304,8 +242,6 @@
     },
     {
         "BriefDescription": "L1D writebacks that access L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF0",
         "EventName": "L2_TRANS.L1D_WB",
         "PublicDescription": "This event counts L1D writebacks that access=
 L2 cache.",
@@ -314,8 +250,6 @@
     },
     {
         "BriefDescription": "L2 fill requests that access L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF0",
         "EventName": "L2_TRANS.L2_FILL",
         "PublicDescription": "This event counts L2 fill requests that acce=
ss L2 cache.",
@@ -324,8 +258,6 @@
     },
     {
         "BriefDescription": "L2 writebacks that access L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF0",
         "EventName": "L2_TRANS.L2_WB",
         "PublicDescription": "This event counts L2 writebacks that access =
L2 cache.",
@@ -334,8 +266,6 @@
     },
     {
         "BriefDescription": "RFO requests that access L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF0",
         "EventName": "L2_TRANS.RFO",
         "PublicDescription": "This event counts Read for Ownership (RFO) r=
equests that access L2 cache.",
@@ -344,8 +274,6 @@
     },
     {
         "BriefDescription": "Cycles when L1D is locked",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x63",
         "EventName": "LOCK_CYCLES.CACHE_LOCK_DURATION",
         "PublicDescription": "This event counts the number of cycles when =
the L1D is locked. It is a superset of the 0x1 mask (BUS_LOCK_CLOCKS.BUS_LO=
CK_DURATION).",
@@ -354,8 +282,6 @@
     },
     {
         "BriefDescription": "Core-originated cacheable demand requests mis=
sed L3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2E",
         "EventName": "LONGEST_LAT_CACHE.MISS",
         "PublicDescription": "This event counts core-originated cacheable =
demand requests that miss the last level cache (LLC). Demand requests inclu=
de loads, RFOs, and hardware prefetches from L1D, and instruction fetches f=
rom IFU.",
@@ -364,8 +290,6 @@
     },
     {
         "BriefDescription": "Core-originated cacheable demand requests tha=
t refer to L3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2E",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
         "PublicDescription": "This event counts core-originated cacheable =
demand requests that refer to the last level cache (LLC). Demand requests i=
nclude loads, RFOs, and hardware prefetches from L1D, and instruction fetch=
es from IFU.",
@@ -374,8 +298,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were L3 =
and cross-core snoop hits in on-pkg core cache.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "BDM100",
         "EventCode": "0xD2",
@@ -387,8 +309,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were Hit=
M responses from shared L3.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "BDM100",
         "EventCode": "0xD2",
@@ -400,8 +320,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were L3 =
hit and cross-core snoop missed in on-pkg core cache.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "BDM100",
         "EventCode": "0xD2",
@@ -413,8 +331,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were hit=
s in L3 without snoops required.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "BDM100",
         "EventCode": "0xD2",
@@ -426,8 +342,6 @@
     },
     {
         "BriefDescription": "Data from local DRAM either Snoop not needed =
or Snoop Miss (RspI)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "BDE70, BDM100",
         "EventCode": "0xD3",
@@ -439,8 +353,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were loa=
d uops missed L1 but hit FB due to preceding miss to the same cache line wi=
th data not ready.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.HIT_LFB",
@@ -451,8 +363,6 @@
     },
     {
         "BriefDescription": "Retired load uops with L1 cache hits as data =
sources.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_HIT",
@@ -463,8 +373,6 @@
     },
     {
         "BriefDescription": "Retired load uops misses in L1 cache as data =
sources.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_MISS",
@@ -475,8 +383,6 @@
     },
     {
         "BriefDescription": "Retired load uops with L2 cache hits as data =
sources.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "BDM35",
         "EventCode": "0xD1",
@@ -488,8 +394,6 @@
     },
     {
         "BriefDescription": "Miss in mid-level (L2) cache. Excludes Unknow=
n data-source.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_MISS",
@@ -500,8 +404,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were dat=
a hits in L3 without snoops required.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "BDM100",
         "EventCode": "0xD1",
@@ -513,8 +415,6 @@
     },
     {
         "BriefDescription": "Miss in last-level (L3) cache. Excludes Unkno=
wn data-source.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "BDM100, BDE70",
         "EventCode": "0xD1",
@@ -525,8 +425,6 @@
     },
     {
         "BriefDescription": "All retired load uops.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
@@ -537,12 +435,9 @@
     },
     {
         "BriefDescription": "All retired store uops.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
-        "L1_Hit_Indication": "1",
         "PEBS": "1",
         "PublicDescription": "This event counts store uops retired to the =
architected path with a filter on bits 0 and 1 applied.\nNote: This event c=
ounts AVX-256bit load/store double-pump memory uops as a single uop at reti=
rement.",
         "SampleAfterValue": "2000003",
@@ -550,8 +445,6 @@
     },
     {
         "BriefDescription": "Retired load uops with locked access.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "BDM35",
         "EventCode": "0xD0",
@@ -563,8 +456,6 @@
     },
     {
         "BriefDescription": "Retired load uops that split across a cacheli=
ne boundary.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
@@ -575,12 +466,9 @@
     },
     {
         "BriefDescription": "Retired store uops that split across a cachel=
ine boundary.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
-        "L1_Hit_Indication": "1",
         "PEBS": "1",
         "PublicDescription": "This event counts line-splitted store uops r=
etired to the architected path. A line split is across 64B cache-line which=
 includes a page split (4K).",
         "SampleAfterValue": "100003",
@@ -588,8 +476,6 @@
     },
     {
         "BriefDescription": "Retired load uops that miss the STLB.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.STLB_MISS_LOADS",
@@ -600,12 +486,9 @@
     },
     {
         "BriefDescription": "Retired store uops that miss the STLB.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.STLB_MISS_STORES",
-        "L1_Hit_Indication": "1",
         "PEBS": "1",
         "PublicDescription": "This event counts store uops with true STLB =
miss retired to the architected path. True STLB miss is an uop triggering p=
age walk that gets completed without blocks, and later gets retired. This p=
age walk can end up with or without a fault.",
         "SampleAfterValue": "100003",
@@ -613,8 +496,6 @@
     },
     {
         "BriefDescription": "Demand and prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.ALL_DATA_RD",
         "PublicDescription": "This event counts the demand and prefetch da=
ta reads. All Core Data Reads include cacheable Demands and L2 prefetchers =
(not L3 prefetchers). Counting also covers reads due to page walks resulted=
 from any request type.",
@@ -623,8 +504,6 @@
     },
     {
         "BriefDescription": "Any memory transaction that reached the SQ.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb0",
         "EventName": "OFFCORE_REQUESTS.ALL_REQUESTS",
         "PublicDescription": "This event counts memory transactions reache=
d the super queue including requests initiated by the core, all L3 prefetch=
es, page walks, and so on.",
@@ -633,8 +512,6 @@
     },
     {
         "BriefDescription": "Cacheable and noncachaeble code read requests=
",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.DEMAND_CODE_RD",
         "PublicDescription": "This event counts both cacheable and noncach=
aeble code read requests.",
@@ -643,8 +520,6 @@
     },
     {
         "BriefDescription": "Demand Data Read requests sent to uncore",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.DEMAND_DATA_RD",
         "PublicDescription": "This event counts the Demand Data Read reque=
sts sent to uncore. Use it in conjunction with OFFCORE_REQUESTS_OUTSTANDING=
 to determine average latency in the uncore.",
@@ -653,8 +528,6 @@
     },
     {
         "BriefDescription": "Demand RFO requests including regular RFOs, l=
ocks, ItoM",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.DEMAND_RFO",
         "PublicDescription": "This event counts the demand RFO (read for o=
wnership) requests including regular RFOs, locks, ItoM.",
@@ -663,8 +536,6 @@
     },
     {
         "BriefDescription": "Offcore requests buffer cannot take more entr=
ies for this thread core.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "OFFCORE_REQUESTS_BUFFER.SQ_FULL",
         "PublicDescription": "This event counts the number of cases when t=
he offcore requests buffer cannot take more entries for the core. This can =
happen when the superqueue does not contain eligible entries, or when L1D w=
riteback pending FIFO requests is full.\nNote: Writeback pending FIFO has s=
ix entries.",
@@ -673,8 +544,6 @@
     },
     {
         "BriefDescription": "Offcore outstanding cacheable Core Data Read =
transactions in SuperQueue (SQ), queue to uncore",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM76",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD",
@@ -684,8 +553,6 @@
     },
     {
         "BriefDescription": "Cycles when offcore outstanding cacheable Cor=
e Data Read transactions are present in SuperQueue (SQ), queue to uncore",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "Errata": "BDM76",
         "EventCode": "0x60",
@@ -696,8 +563,6 @@
     },
     {
         "BriefDescription": "Cycles when offcore outstanding Demand Data R=
ead transactions are present in SuperQueue (SQ), queue to uncore",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "Errata": "BDM76",
         "EventCode": "0x60",
@@ -708,8 +573,6 @@
     },
     {
         "BriefDescription": "Offcore outstanding demand rfo reads transact=
ions in SuperQueue (SQ), queue to uncore, every cycle",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "Errata": "BDM76",
         "EventCode": "0x60",
@@ -720,8 +583,6 @@
     },
     {
         "BriefDescription": "Offcore outstanding code reads transactions i=
n SuperQueue (SQ), queue to uncore, every cycle",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM76",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_CODE_RD",
@@ -731,8 +592,6 @@
     },
     {
         "BriefDescription": "Offcore outstanding Demand Data Read transact=
ions in uncore queue.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM76",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD",
@@ -742,8 +601,6 @@
     },
     {
         "BriefDescription": "Cycles with at least 6 offcore outstanding De=
mand Data Read transactions in uncore queue.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "6",
         "Errata": "BDM76",
         "EventCode": "0x60",
@@ -753,8 +610,6 @@
     },
     {
         "BriefDescription": "Offcore outstanding RFO store transactions in=
 SuperQueue (SQ), queue to uncore",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM76",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_RFO",
@@ -764,8 +619,6 @@
     },
     {
         "BriefDescription": "Offcore response can be programmed only with =
a specific pair of event select and counter MSR, and with specific event co=
des and predefine mask bit value in a dedicated MSR to specify attributes o=
f the offcore transaction.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE",
         "SampleAfterValue": "100003",
@@ -773,2634 +626,1824 @@
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads have =
any response type.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010091",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads have=
 any response type.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_HIT.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0091",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0091",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x04003C0091",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x02003C0091",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00803C0091",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_HIT.SNOOP_NOT_NEEDED=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x01003C0091",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.SUPPLIER_NONE.ANY_SNOOP=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020091",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.SUPPLIER_NONE.SNOOP_HIT=
M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020091",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.SUPPLIER_NONE.SNOOP_HIT=
_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400020091",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.SUPPLIER_NONE.SNOOP_MIS=
S",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200020091",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.SUPPLIER_NONE.SNOOP_NON=
E",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080020091",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.SUPPLIER_NONE.SNOOP_NOT=
_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100020091",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch code reads have any respo=
nse type.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010240",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch code reads have any resp=
onse type.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_HIT.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0240",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0240",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_HIT.SNOOP_HIT_NO_=
FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x04003C0240",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x02003C0240",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00803C0240",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_HIT.SNOOP_NOT_NEE=
DED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x01003C0240",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.SUPPLIER_NONE.ANY_SN=
OOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020240",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.SUPPLIER_NONE.SNOOP_=
HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020240",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.SUPPLIER_NONE.SNOOP_=
HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400020240",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.SUPPLIER_NONE.SNOOP_=
MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200020240",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.SUPPLIER_NONE.SNOOP_=
NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080020240",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.SUPPLIER_NONE.SNOOP_=
NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100020240",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch data reads have any respo=
nse type.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010090",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch data reads have any resp=
onse type.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_HIT.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0090",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0090",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_HIT.SNOOP_HIT_NO_=
FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x04003C0090",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x02003C0090",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00803C0090",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_HIT.SNOOP_NOT_NEE=
DED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x01003C0090",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.SUPPLIER_NONE.ANY_SN=
OOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020090",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.SUPPLIER_NONE.SNOOP_=
HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020090",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.SUPPLIER_NONE.SNOOP_=
HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400020090",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.SUPPLIER_NONE.SNOOP_=
MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200020090",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.SUPPLIER_NONE.SNOOP_=
NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080020090",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.SUPPLIER_NONE.SNOOP_=
NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100020090",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch RFOs have any response type."=
,
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010120",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch RFOs have any response type.=
",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_HIT.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0120",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0120",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_HIT.SNOOP_HIT_NO_FWD"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x04003C0120",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x02003C0120",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00803C0120",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_HIT.SNOOP_NOT_NEEDED"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x01003C0120",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.SUPPLIER_NONE.ANY_SNOOP"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020120",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.SUPPLIER_NONE.SNOOP_HITM=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020120",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.SUPPLIER_NONE.SNOOP_HIT_=
NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400020120",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.SUPPLIER_NONE.SNOOP_MISS=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200020120",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.SUPPLIER_NONE.SNOOP_NONE=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080020120",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.SUPPLIER_NONE.SNOOP_NOT_=
NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100020120",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs have any re=
sponse type.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010122",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs have any r=
esponse type.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_HIT.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0122",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0122",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x04003C0122",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x02003C0122",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00803C0122",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x01003C0122",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.SUPPLIER_NONE.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020122",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.SUPPLIER_NONE.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020122",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.SUPPLIER_NONE.SNOOP_HIT_NO_=
FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400020122",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.SUPPLIER_NONE.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200020122",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.SUPPLIER_NONE.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080020122",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.SUPPLIER_NONE.SNOOP_NOT_NEE=
DED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100020122",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writebacks (modified to exclusive) hav=
e any response type.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010008",
-        "Offcore": "1",
-        "PublicDescription": "Counts writebacks (modified to exclusive) ha=
ve any response type.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writebacks (modified to exclusive)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_HIT.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0008",
-        "Offcore": "1",
-        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writebacks (modified to exclusive)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0008",
-        "Offcore": "1",
-        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writebacks (modified to exclusive)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x04003C0008",
-        "Offcore": "1",
-        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writebacks (modified to exclusive)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x02003C0008",
-        "Offcore": "1",
-        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writebacks (modified to exclusive)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00803C0008",
-        "Offcore": "1",
-        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writebacks (modified to exclusive)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x01003C0008",
-        "Offcore": "1",
-        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writebacks (modified to exclusive)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.SUPPLIER_NONE.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020008",
-        "Offcore": "1",
-        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writebacks (modified to exclusive)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.SUPPLIER_NONE.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020008",
-        "Offcore": "1",
-        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writebacks (modified to exclusive)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.SUPPLIER_NONE.SNOOP_HIT_NO_F=
WD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400020008",
-        "Offcore": "1",
-        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writebacks (modified to exclusive)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.SUPPLIER_NONE.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200020008",
-        "Offcore": "1",
-        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writebacks (modified to exclusive)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.SUPPLIER_NONE.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080020008",
-        "Offcore": "1",
-        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writebacks (modified to exclusive)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.SUPPLIER_NONE.SNOOP_NOT_NEED=
ED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100020008",
-        "Offcore": "1",
-        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads have any respons=
e type.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010004",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads have any respon=
se type.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0004",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0004",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_NO_=
FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x04003C0004",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x02003C0004",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00803C0004",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SNOOP_NOT_NEE=
DED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x01003C0004",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.ANY_SN=
OOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020004",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SNOOP_=
HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020004",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SNOOP_=
HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400020004",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SNOOP_=
MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200020004",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SNOOP_=
NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080020004",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SNOOP_=
NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100020004",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads have any response ty=
pe.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010001",
-        "Offcore": "1",
-        "PublicDescription": "Counts demand data reads have any response t=
ype.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0001",
-        "Offcore": "1",
-        "PublicDescription": "Counts demand data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0001",
-        "Offcore": "1",
-        "PublicDescription": "Counts demand data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_=
FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x04003C0001",
-        "Offcore": "1",
-        "PublicDescription": "Counts demand data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x02003C0001",
-        "Offcore": "1",
-        "PublicDescription": "Counts demand data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00803C0001",
-        "Offcore": "1",
-        "PublicDescription": "Counts demand data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_NOT_NEE=
DED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x01003C0001",
-        "Offcore": "1",
-        "PublicDescription": "Counts demand data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.ANY_SN=
OOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020001",
-        "Offcore": "1",
-        "PublicDescription": "Counts demand data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020001",
-        "Offcore": "1",
-        "PublicDescription": "Counts demand data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400020001",
-        "Offcore": "1",
-        "PublicDescription": "Counts demand data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200020001",
-        "Offcore": "1",
-        "PublicDescription": "Counts demand data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080020001",
-        "Offcore": "1",
-        "PublicDescription": "Counts demand data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100020001",
-        "Offcore": "1",
-        "PublicDescription": "Counts demand data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs) have any=
 response type.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010002",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand data writes (RFOs) have an=
y response type.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0002",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand data writes (RFOs)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0002",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand data writes (RFOs)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_HIT_NO_FWD"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x04003C0002",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand data writes (RFOs)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x02003C0002",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand data writes (RFOs)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00803C0002",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand data writes (RFOs)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_NOT_NEEDED"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x01003C0002",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand data writes (RFOs)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any other requests have any response t=
ype.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000018000",
-        "Offcore": "1",
-        "PublicDescription": "Counts any other requests have any response =
type.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any other requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C8000",
-        "Offcore": "1",
-        "PublicDescription": "Counts any other requests",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any other requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C8000",
-        "Offcore": "1",
-        "PublicDescription": "Counts any other requests",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any other requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x04003C8000",
-        "Offcore": "1",
-        "PublicDescription": "Counts any other requests",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any other requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x02003C8000",
-        "Offcore": "1",
-        "PublicDescription": "Counts any other requests",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any other requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00803C8000",
-        "Offcore": "1",
-        "PublicDescription": "Counts any other requests",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any other requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x01003C8000",
-        "Offcore": "1",
-        "PublicDescription": "Counts any other requests",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any other requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80028000",
-        "Offcore": "1",
-        "PublicDescription": "Counts any other requests",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any other requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000028000",
-        "Offcore": "1",
-        "PublicDescription": "Counts any other requests",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any other requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SNOOP_HIT_NO_FW=
D",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400028000",
-        "Offcore": "1",
-        "PublicDescription": "Counts any other requests",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any other requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200028000",
-        "Offcore": "1",
-        "PublicDescription": "Counts any other requests",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any other requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080028000",
-        "Offcore": "1",
-        "PublicDescription": "Counts any other requests",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any other requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SNOOP_NOT_NEEDE=
D",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100028000",
-        "Offcore": "1",
-        "PublicDescription": "Counts any other requests",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads have any response type.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010040",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads have any response type.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_HIT.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0040",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0040",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_HIT.SNOOP_HIT_NO_F=
WD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x04003C0040",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x02003C0040",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00803C0040",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_HIT.SNOOP_NOT_NEED=
ED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x01003C0040",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.SUPPLIER_NONE.ANY_SNO=
OP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020040",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.SUPPLIER_NONE.SNOOP_H=
ITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020040",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.SUPPLIER_NONE.SNOOP_H=
IT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400020040",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.SUPPLIER_NONE.SNOOP_M=
ISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200020040",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.SUPPLIER_NONE.SNOOP_N=
ONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080020040",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.SUPPLIER_NONE.SNOOP_N=
OT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100020040",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads have any response type.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010010",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads have any response type.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_HIT.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0010",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0010",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_HIT.SNOOP_HIT_NO_F=
WD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x04003C0010",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x02003C0010",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00803C0010",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_HIT.SNOOP_NOT_NEED=
ED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x01003C0010",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.SUPPLIER_NONE.ANY_SNO=
OP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020010",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.SUPPLIER_NONE.SNOOP_H=
ITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020010",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.SUPPLIER_NONE.SNOOP_H=
IT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400020010",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.SUPPLIER_NONE.SNOOP_M=
ISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200020010",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.SUPPLIER_NONE.SNOOP_N=
ONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080020010",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.SUPPLIER_NONE.SNOOP_N=
OT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100020010",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs have any response type.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010020",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs have any response type.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_HIT.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0020",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0020",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x04003C0020",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x02003C0020",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00803C0020",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x01003C0020",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.SUPPLIER_NONE.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020020",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.SUPPLIER_NONE.SNOOP_HITM"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020020",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.SUPPLIER_NONE.SNOOP_HIT_N=
O_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400020020",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.SUPPLIER_NONE.SNOOP_MISS"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200020020",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.SUPPLIER_NONE.SNOOP_NONE"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080020020",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.SUPPLIER_NONE.SNOOP_NOT_N=
EEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100020020",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads have any response type.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010200",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads have any response type.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_HIT.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0200",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0200",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_HIT.SNOOP_HIT_NO_F=
WD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x04003C0200",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x02003C0200",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00803C0200",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_HIT.SNOOP_NOT_NEED=
ED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x01003C0200",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.SUPPLIER_NONE.ANY_SNO=
OP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020200",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.SUPPLIER_NONE.SNOOP_H=
ITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020200",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.SUPPLIER_NONE.SNOOP_H=
IT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400020200",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.SUPPLIER_NONE.SNOOP_M=
ISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200020200",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.SUPPLIER_NONE.SNOOP_N=
ONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080020200",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.SUPPLIER_NONE.SNOOP_N=
OT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100020200",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads have any response type.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010080",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads have any response type.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_HIT.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0080",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0080",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_HIT.SNOOP_HIT_NO_F=
WD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x04003C0080",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x02003C0080",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00803C0080",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_HIT.SNOOP_NOT_NEED=
ED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x01003C0080",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.SUPPLIER_NONE.ANY_SNO=
OP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020080",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.SUPPLIER_NONE.SNOOP_H=
ITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020080",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.SUPPLIER_NONE.SNOOP_H=
IT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400020080",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.SUPPLIER_NONE.SNOOP_M=
ISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200020080",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.SUPPLIER_NONE.SNOOP_N=
ONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080020080",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.SUPPLIER_NONE.SNOOP_N=
OT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100020080",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs have any response type.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010100",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs have any response type.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_HIT.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0100",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0100",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x04003C0100",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x02003C0100",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00803C0100",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x01003C0100",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.SUPPLIER_NONE.ANY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020100",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.SUPPLIER_NONE.SNOOP_HITM"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020100",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.SUPPLIER_NONE.SNOOP_HIT_N=
O_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400020100",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.SUPPLIER_NONE.SNOOP_MISS"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200020100",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.SUPPLIER_NONE.SNOOP_NONE"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080020100",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.SUPPLIER_NONE.SNOOP_NOT_N=
EEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100020100",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Split locks in SQ",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xf4",
         "EventName": "SQ_MISC.SPLIT_LOCK",
         "PublicDescription": "This event counts the number of split locks =
in the super queue.",
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/floating-point.json b=
/tools/perf/pmu-events/arch/x86/broadwell/floating-point.json
index 6322116d0d46..0de16d9a80da 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/floating-point.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d double precision floating-point instructions retired; some instructions w=
ill count twice as noted below.  Each count represents 2 computation operat=
ions, one for each element.  Applies to SSE* and AVX* packed double precisi=
on floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQ=
RT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they=
 perform 2 calculations per element.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE",
         "SampleAfterValue": "2000003",
@@ -10,8 +8,6 @@
     },
     {
         "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d single precision floating-point instructions retired; some instructions w=
ill count twice as noted below.  Each count represents 4 computation operat=
ions, one for each element.  Applies to SSE* and AVX* packed single precisi=
on floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQ=
RT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twi=
ce as they perform 4 calculations per element.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE",
         "SampleAfterValue": "2000003",
@@ -19,8 +15,6 @@
     },
     {
         "BriefDescription": "Number of SSE/AVX computational 256-bit packe=
d double precision floating-point instructions retired; some instructions w=
ill count twice as noted below.  Each count represents 4 computation operat=
ions, one for each element.  Applies to SSE* and AVX* packed double precisi=
on floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQ=
RT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perform 4 c=
alculations per element.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE",
         "SampleAfterValue": "2000003",
@@ -28,8 +22,6 @@
     },
     {
         "BriefDescription": "Number of SSE/AVX computational 256-bit packe=
d single precision floating-point instructions retired; some instructions w=
ill count twice as noted below.  Each count represents 8 computation operat=
ions, one for each element.  Applies to SSE* and AVX* packed single precisi=
on floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQ=
RT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twi=
ce as they perform 8 calculations per element.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE",
         "SampleAfterValue": "2000003",
@@ -37,8 +29,6 @@
     },
     {
         "BriefDescription": "Number of SSE/AVX computational double precis=
ion floating-point instructions retired; some instructions will count twice=
 as noted below. Applies to SSE* and AVX* scalar and packed double precisio=
n floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQR=
T DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they =
perform multiple calculations per element.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.DOUBLE",
         "SampleAfterValue": "2000006",
@@ -46,8 +36,6 @@
     },
     {
         "BriefDescription": "Number of SSE/AVX computational packed floati=
ng-point instructions retired; some instructions will count twice as noted =
below. Applies to SSE* and AVX* packed double and single precision floating=
-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT RSQRT RC=
P DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they =
perform multiple calculations per element.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.PACKED",
         "SampleAfterValue": "2000004",
@@ -55,8 +43,6 @@
     },
     {
         "BriefDescription": "Number of SSE/AVX computational scalar floati=
ng-point instructions retired; some instructions will count twice as noted =
below. Each count represents 1 computation operation.   Applies to SSE* and=
 AVX* scalar double and single precision floating-point instructions: ADD S=
UB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB. FM(N)ADD/SUB instructions c=
ount twice as they perform multiple calculations per element.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR",
         "SampleAfterValue": "2000003",
@@ -64,8 +50,6 @@
     },
     {
         "BriefDescription": "Number of SSE/AVX computational scalar double=
 precision floating-point instructions retired; some instructions will coun=
t twice as noted below.  Each count represents 1 computational operation. A=
pplies to SSE* and AVX* scalar double precision floating-point instructions=
: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions cou=
nt twice as they perform multiple calculations per element.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR_DOUBLE",
         "SampleAfterValue": "2000003",
@@ -73,8 +57,6 @@
     },
     {
         "BriefDescription": "Number of SSE/AVX computational scalar single=
 precision floating-point instructions retired; some instructions will coun=
t twice as noted below.  Each count represents 1 computational operation. A=
pplies to SSE* and AVX* scalar single precision floating-point instructions=
: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB instru=
ctions count twice as they perform multiple calculations per element.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR_SINGLE",
         "SampleAfterValue": "2000003",
@@ -82,8 +64,6 @@
     },
     {
         "BriefDescription": "Number of SSE/AVX computational single precis=
ion floating-point instructions retired; some instructions will count twice=
 as noted below. Applies to SSE* and AVX* scalar and packed single precisio=
n floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQR=
T RSQRT RCP SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count=
 twice as they perform multiple calculations per element.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SINGLE",
         "SampleAfterValue": "2000005",
@@ -91,8 +71,6 @@
     },
     {
         "BriefDescription": "Cycles with any input/output SSE or FP assist=
",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xCA",
         "EventName": "FP_ASSIST.ANY",
@@ -102,8 +80,6 @@
     },
     {
         "BriefDescription": "Number of SIMD FP assists due to input values=
",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xCA",
         "EventName": "FP_ASSIST.SIMD_INPUT",
         "PublicDescription": "This event counts any input SSE* FP assist -=
 invalid operation, denormal operand, dividing by zero, SNaN operand. Count=
ing includes only cases involving penalties that required micro-code assist=
 intervention.",
@@ -112,8 +88,6 @@
     },
     {
         "BriefDescription": "Number of SIMD FP assists due to Output value=
s",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xCA",
         "EventName": "FP_ASSIST.SIMD_OUTPUT",
         "PublicDescription": "This event counts the number of SSE* floatin=
g point (FP) micro-code assist (numeric overflow/underflow) when the output=
 value (destination register) is invalid. Counting covers only cases involv=
ing penalties that require micro-code assist intervention.",
@@ -122,8 +96,6 @@
     },
     {
         "BriefDescription": "Number of X87 assists due to input value.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xCA",
         "EventName": "FP_ASSIST.X87_INPUT",
         "PublicDescription": "This event counts x87 floating point (FP) mi=
cro-code assist (invalid operation, denormal operand, SNaN operand) when th=
e input value (one of the source operands to an FP instruction) is invalid.=
",
@@ -132,8 +104,6 @@
     },
     {
         "BriefDescription": "Number of X87 assists due to output value.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xCA",
         "EventName": "FP_ASSIST.X87_OUTPUT",
         "PublicDescription": "This event counts the number of x87 floating=
 point (FP) micro-code assist (numeric overflow/underflow, inexact result) =
when the output value (destination register) is invalid.",
@@ -142,8 +112,6 @@
     },
     {
         "BriefDescription": "Number of SIMD Move Elimination candidate uop=
s that were eliminated.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x58",
         "EventName": "MOVE_ELIMINATION.SIMD_ELIMINATED",
         "SampleAfterValue": "1000003",
@@ -151,8 +119,6 @@
     },
     {
         "BriefDescription": "Number of SIMD Move Elimination candidate uop=
s that were not eliminated.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x58",
         "EventName": "MOVE_ELIMINATION.SIMD_NOT_ELIMINATED",
         "SampleAfterValue": "1000003",
@@ -160,8 +126,6 @@
     },
     {
         "BriefDescription": "Number of transitions from AVX-256 to legacy =
SSE when penalty applicable.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM30",
         "EventCode": "0xC1",
         "EventName": "OTHER_ASSISTS.AVX_TO_SSE",
@@ -171,8 +135,6 @@
     },
     {
         "BriefDescription": "Number of transitions from SSE to AVX-256 whe=
n penalty applicable.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM30",
         "EventCode": "0xC1",
         "EventName": "OTHER_ASSISTS.SSE_TO_AVX",
@@ -182,8 +144,6 @@
     },
     {
         "BriefDescription": "Micro-op dispatches cancelled due to insuffic=
ient SIMD physical register file read ports",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xA0",
         "EventName": "UOP_DISPATCHES_CANCELLED.SIMD_PRF",
         "PublicDescription": "This event counts the number of micro-operat=
ions cancelled after they were dispatched from the scheduler to the executi=
on units when the total number of physical register read ports across all d=
ispatch ports exceeds the read bandwidth of the physical register file.  Th=
e SIMD_PRF subevent applies to the following instructions: VDPPS, DPPS, VPC=
MPESTRI, PCMPESTRI, VPCMPESTRM, PCMPESTRM, VFMADD*, VFMADDSUB*, VFMSUB*, VM=
SUBADD*, VFNMADD*, VFNMSUB*.  See the Broadwell Optimization Guide for more=
 information.",
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/frontend.json b/tools=
/perf/pmu-events/arch/x86/broadwell/frontend.json
index 37ce8034b2ed..d0f6678609ae 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/frontend.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Counts the total number when the front end is=
 resteered, mainly when the BPU cannot provide a correct prediction and thi=
s is corrected by other branch handling mechanisms at the front end.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe6",
         "EventName": "BACLEARS.ANY",
         "SampleAfterValue": "100003",
@@ -10,8 +8,6 @@
     },
     {
         "BriefDescription": "Decode Stream Buffer (DSB)-to-MITE switch tru=
e penalty cycles.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xAB",
         "EventName": "DSB2MITE_SWITCHES.PENALTY_CYCLES",
         "PublicDescription": "This event counts Decode Stream Buffer (DSB)=
-to-MITE switch true penalty cycles. These cycles do not include uops route=
d through because of the switch itself, for example, when Instruction Decod=
e Queue (IDQ) pre-allocation is unavailable, or Instruction Decode Queue (I=
DQ) is full. SBD-to-MITE switch true penalty cycles happen after the merge =
mux (MM) receives Decode Stream Buffer (DSB) Sync-indication until receivin=
g the first MITE uop. \nMM is placed before Instruction Decode Queue (IDQ) =
to merge uops being fed from the MITE and Decode Stream Buffer (DSB) paths.=
 Decode Stream Buffer (DSB) inserts the Sync-indication whenever a Decode S=
tream Buffer (DSB)-to-MITE switch occurs.\nPenalty: A Decode Stream Buffer =
(DSB) hit followed by a Decode Stream Buffer (DSB) miss can cost up to six =
cycles in which no uops are delivered to the IDQ. Most often, such switches=
 from the Decode Stream Buffer (DSB) to the legacy pipeline cost 02 cycles.=
",
@@ -20,8 +16,6 @@
     },
     {
         "BriefDescription": "Number of Instruction Cache, Streaming Buffer=
 and Victim Cache Reads. both cacheable and noncacheable, including UC fetc=
hes",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x80",
         "EventName": "ICACHE.HIT",
         "PublicDescription": "This event counts the number of both cacheab=
le and noncacheable Instruction Cache, Streaming Buffer and Victim Cache Re=
ads including UC fetches.",
@@ -30,8 +24,6 @@
     },
     {
         "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction-cache miss.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x80",
         "EventName": "ICACHE.IFDATA_STALL",
         "PublicDescription": "This event counts cycles during which the de=
mand fetch waits for data (wfdM104H) from L2 or iSB (opportunistic hit).",
@@ -40,8 +32,6 @@
     },
     {
         "BriefDescription": "Number of Instruction Cache, Streaming Buffer=
 and Victim Cache Misses. Includes Uncacheable accesses.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x80",
         "EventName": "ICACHE.MISSES",
         "PublicDescription": "This event counts the number of instruction =
cache, streaming buffer and victim cache misses. Counting includes UC acces=
ses.",
@@ -50,8 +40,6 @@
     },
     {
         "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng 4 Uops",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_DSB_CYCLES_4_UOPS",
@@ -61,8 +49,6 @@
     },
     {
         "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng any Uop",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_DSB_CYCLES_ANY_UOPS",
@@ -72,8 +58,6 @@
     },
     {
         "BriefDescription": "Cycles MITE is delivering 4 Uops",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_MITE_CYCLES_4_UOPS",
@@ -83,8 +67,6 @@
     },
     {
         "BriefDescription": "Cycles MITE is delivering any Uop",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_MITE_CYCLES_ANY_UOPS",
@@ -94,8 +76,6 @@
     },
     {
         "BriefDescription": "Cycles when uops are being delivered to Instr=
uction Decode Queue (IDQ) from Decode Stream Buffer (DSB) path",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES",
@@ -105,8 +85,6 @@
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from the Decode Stream Buffer (DSB) path",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_UOPS",
         "PublicDescription": "This event counts the number of uops deliver=
ed to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) pa=
th. Counting includes uops that may bypass the IDQ.",
@@ -115,8 +93,6 @@
     },
     {
         "BriefDescription": "Instruction Decode Queue (IDQ) empty cycles",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.EMPTY",
         "PublicDescription": "This counts the number of cycles that the in=
struction decoder queue is empty and can indicate that the application may =
be bound in the front end.  It does not determine whether there are uops be=
ing delivered to the Alloc stage since uops can be delivered by bypass skip=
ping the Instruction Decode Queue (IDQ) when it is empty.",
@@ -125,8 +101,6 @@
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from MITE path",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_ALL_UOPS",
         "PublicDescription": "This event counts the number of uops deliver=
ed to Instruction Decode Queue (IDQ) from the MITE path. Counting includes =
uops that may bypass the IDQ. This also means that uops are not being deliv=
ered from the Decode Stream Buffer (DSB).",
@@ -135,8 +109,6 @@
     },
     {
         "BriefDescription": "Cycles when uops are being delivered to Instr=
uction Decode Queue (IDQ) from MITE path",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_CYCLES",
@@ -146,8 +118,6 @@
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from MITE path",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_UOPS",
         "PublicDescription": "This event counts the number of uops deliver=
ed to Instruction Decode Queue (IDQ) from the MITE path. Counting includes =
uops that may bypass the IDQ. This also means that uops are not being deliv=
ered from the Decode Stream Buffer (DSB).",
@@ -156,8 +126,6 @@
     },
     {
         "BriefDescription": "Cycles when uops are being delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_CYCLES",
@@ -167,8 +135,6 @@
     },
     {
         "BriefDescription": "Cycles when uops initiated by Decode Stream B=
uffer (DSB) are being delivered to Instruction Decode Queue (IDQ) while Mic=
rocode Sequenser (MS) is busy",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_DSB_CYCLES",
@@ -178,8 +144,6 @@
     },
     {
         "BriefDescription": "Deliveries to Instruction Decode Queue (IDQ) =
initiated by Decode Stream Buffer (DSB) while Microcode Sequenser (MS) is b=
usy",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x79",
@@ -190,8 +154,6 @@
     },
     {
         "BriefDescription": "Uops initiated by Decode Stream Buffer (DSB) =
that are being delivered to Instruction Decode Queue (IDQ) while Microcode =
Sequenser (MS) is busy",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_DSB_UOPS",
         "PublicDescription": "This event counts the number of uops initiat=
ed by Decode Stream Buffer (DSB) that are being delivered to Instruction De=
code Queue (IDQ) while the Microcode Sequencer (MS) is busy. Counting inclu=
des uops that may bypass the IDQ.",
@@ -200,8 +162,6 @@
     },
     {
         "BriefDescription": "Uops initiated by MITE and delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_MITE_UOPS",
         "PublicDescription": "This event counts the number of uops initiat=
ed by MITE and delivered to Instruction Decode Queue (IDQ) while the Microc=
ode Sequenser (MS) is busy. Counting includes uops that may bypass the IDQ.=
",
@@ -210,8 +170,6 @@
     },
     {
         "BriefDescription": "Number of switches from DSB (Decode Stream Bu=
ffer) or MITE (legacy decode pipeline) to the Microcode Sequencer.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x79",
@@ -221,8 +179,6 @@
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) while Microcode Sequenser (MS) is busy",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_UOPS",
         "PublicDescription": "This event counts the total number of uops d=
elivered to Instruction Decode Queue (IDQ) while the Microcode Sequenser (M=
S) is busy. Counting includes uops that may bypass the IDQ. Uops maybe init=
iated by Decode Stream Buffer (DSB) or MITE.",
@@ -231,8 +187,6 @@
     },
     {
         "BriefDescription": "Uops not delivered to Resource Allocation Tab=
le (RAT) per thread when backend of the machine is not stalled",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0x9C",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
         "PublicDescription": "This event counts the number of uops not del=
ivered to Resource Allocation Table (RAT) per thread adding 4  x when Resou=
rce Allocation Table (RAT) is not stalled and Instruction Decode Queue (IDQ=
) delivers x uops to Resource Allocation Table (RAT) (where x belongs to {0=
,1,2,3}). Counting does not cover cases when:\n a. IDQ-Resource Allocation =
Table (RAT) pipe serves the other thread;\n b. Resource Allocation Table (R=
AT) is stalled for the thread (including uop drops and clear BE conditions)=
; \n c. Instruction Decode Queue (IDQ) delivers four uops.",
@@ -241,8 +195,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when 4 or more uops are not=
 delivered to Resource Allocation Table (RAT) when backend of the machine i=
s not stalled",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "4",
         "EventCode": "0x9C",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE",
@@ -252,8 +204,6 @@
     },
     {
         "BriefDescription": "Counts cycles FE delivered 4 uops or Resource=
 Allocation Table (RAT) was stalling FE.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x9C",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK",
@@ -263,8 +213,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when 3 or more uops are not=
 delivered to Resource Allocation Table (RAT) when backend of the machine i=
s not stalled",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "3",
         "EventCode": "0x9C",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_LE_1_UOP_DELIV.CORE",
@@ -274,8 +222,6 @@
     },
     {
         "BriefDescription": "Cycles with less than 2 uops delivered by the=
 front end.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "2",
         "EventCode": "0x9C",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_LE_2_UOP_DELIV.CORE",
@@ -284,8 +230,6 @@
     },
     {
         "BriefDescription": "Cycles with less than 3 uops delivered by the=
 front end.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x9C",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_LE_3_UOP_DELIV.CORE",
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/memory.json b/tools/p=
erf/pmu-events/arch/x86/broadwell/memory.json
index 2a7797738159..394ed602fcb1 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/memory.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/memory.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Number of times HLE abort was triggered",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.ABORTED",
         "PEBS": "1",
@@ -12,8 +10,6 @@
     },
     {
         "BriefDescription": "Number of times an HLE execution aborted due =
to various memory events (e.g., read/write capacity and conflicts).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.ABORTED_MISC1",
         "PublicDescription": "Number of times an HLE abort was attributed =
to a Memory condition (See TSX_Memory event for additional details).",
@@ -22,8 +18,6 @@
     },
     {
         "BriefDescription": "Number of times an HLE execution aborted due =
to uncommon conditions",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.ABORTED_MISC2",
         "PublicDescription": "Number of times the TSX watchdog signaled an=
 HLE abort.",
@@ -32,8 +26,6 @@
     },
     {
         "BriefDescription": "Number of times an HLE execution aborted due =
to HLE-unfriendly instructions",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.ABORTED_MISC3",
         "PublicDescription": "Number of times a disallowed operation cause=
d an HLE abort.",
@@ -42,8 +34,6 @@
     },
     {
         "BriefDescription": "Number of times an HLE execution aborted due =
to incompatible memory type",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.ABORTED_MISC4",
         "PublicDescription": "Number of times HLE caused a fault.",
@@ -52,8 +42,6 @@
     },
     {
         "BriefDescription": "Number of times an HLE execution aborted due =
to none of the previous 4 categories (e.g. interrupts)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.ABORTED_MISC5",
         "PublicDescription": "Number of times HLE aborted and was not due =
to the abort conditions in subevents 3-6.",
@@ -62,8 +50,6 @@
     },
     {
         "BriefDescription": "Number of times HLE commit succeeded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.COMMIT",
         "PublicDescription": "Number of times HLE commit succeeded.",
@@ -72,8 +58,6 @@
     },
     {
         "BriefDescription": "Number of times we entered an HLE region; doe=
s not count nested transactions",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.START",
         "PublicDescription": "Number of times we entered an HLE region\n d=
oes not count nested transactions.",
@@ -82,8 +66,6 @@
     },
     {
         "BriefDescription": "Counts the number of machine clears due to me=
mory order conflicts.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
         "PublicDescription": "This event counts the number of memory order=
ing Machine Clears detected. Memory Ordering Machine Clears can result from=
 one of the following:\n1. memory disambiguation,\n2. external snoop, or\n3=
. cross SMT-HW-thread snoop (stores) hitting load buffer.",
@@ -92,8 +74,6 @@
     },
     {
         "BriefDescription": "Randomly selected loads with latency value be=
ing above 128",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "Data_LA": "1",
         "Errata": "BDM100, BDM35",
         "EventCode": "0xcd",
@@ -103,13 +83,10 @@
         "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads with latency =
value being above 128.",
         "SampleAfterValue": "1009",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Randomly selected loads with latency value be=
ing above 16",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "Data_LA": "1",
         "Errata": "BDM100, BDM35",
         "EventCode": "0xcd",
@@ -119,13 +96,10 @@
         "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads with latency =
value being above 16.",
         "SampleAfterValue": "20011",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Randomly selected loads with latency value be=
ing above 256",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "Data_LA": "1",
         "Errata": "BDM100, BDM35",
         "EventCode": "0xcd",
@@ -135,13 +109,10 @@
         "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads with latency =
value being above 256.",
         "SampleAfterValue": "503",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Randomly selected loads with latency value be=
ing above 32",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "Data_LA": "1",
         "Errata": "BDM100, BDM35",
         "EventCode": "0xcd",
@@ -151,13 +122,10 @@
         "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads with latency =
value being above 32.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Randomly selected loads with latency value be=
ing above 4",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "Data_LA": "1",
         "Errata": "BDM100, BDM35",
         "EventCode": "0xcd",
@@ -167,13 +135,10 @@
         "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads with latency =
value being above four.",
         "SampleAfterValue": "100003",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Randomly selected loads with latency value be=
ing above 512",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "Data_LA": "1",
         "Errata": "BDM100, BDM35",
         "EventCode": "0xcd",
@@ -183,13 +148,10 @@
         "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads with latency =
value being above 512.",
         "SampleAfterValue": "101",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Randomly selected loads with latency value be=
ing above 64",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "Data_LA": "1",
         "Errata": "BDM100, BDM35",
         "EventCode": "0xcd",
@@ -199,13 +161,10 @@
         "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads with latency =
value being above 64.",
         "SampleAfterValue": "2003",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Randomly selected loads with latency value be=
ing above 8",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "Data_LA": "1",
         "Errata": "BDM100, BDM35",
         "EventCode": "0xcd",
@@ -215,13 +174,10 @@
         "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads with latency =
value being above eight.",
         "SampleAfterValue": "50021",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Speculative cache line split load uops dispat=
ched to L1 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x05",
         "EventName": "MISALIGN_MEM_REF.LOADS",
         "PublicDescription": "This event counts speculative cache-line spl=
it load uops dispatched to the L1 cache.",
@@ -230,8 +186,6 @@
     },
     {
         "BriefDescription": "Speculative cache line split STA uops dispatc=
hed to L1 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x05",
         "EventName": "MISALIGN_MEM_REF.STORES",
         "PublicDescription": "This event counts speculative cache line spl=
it store-address (STA) uops dispatched to the L1 cache.",
@@ -240,2621 +194,1815 @@
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_HIT.SNOOP_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x20003C0091",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS.SNOOP_HIT_NO_FW=
D",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x043C000091",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x023C000091",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00BC000091",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS.SNOOP_NOT_NEEDE=
D",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x013C000091",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.ANY_=
SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000091",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.SNOO=
P_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000091",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.SNOO=
P_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0404000091",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.SNOO=
P_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0204000091",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.SNOO=
P_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0084000091",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.SNOO=
P_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2004000091",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.SNOO=
P_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0104000091",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.SUPPLIER_NONE.SNOOP_NON=
_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000020091",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_HIT.SNOOP_NON_DRA=
M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x20003C0240",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS.SNOOP_HIT_NO=
_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x043C000240",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x023C000240",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00BC000240",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS.SNOOP_NOT_NE=
EDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x013C000240",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS_LOCAL_DRAM.A=
NY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000240",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000240",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0404000240",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0204000240",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0084000240",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2004000240",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0104000240",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.SUPPLIER_NONE.SNOOP_=
NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000020240",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_HIT.SNOOP_NON_DRA=
M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x20003C0090",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS.SNOOP_HIT_NO=
_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x043C000090",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x023C000090",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00BC000090",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS.SNOOP_NOT_NE=
EDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x013C000090",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.A=
NY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000090",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000090",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0404000090",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0204000090",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0084000090",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2004000090",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0104000090",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.SUPPLIER_NONE.SNOOP_=
NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000020090",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_HIT.SNOOP_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x20003C0120",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS.SNOOP_HIT_NO_FWD=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x043C000120",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x023C000120",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00BC000120",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS.SNOOP_NOT_NEEDED=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x013C000120",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.ANY_S=
NOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000120",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.SNOOP=
_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000120",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.SNOOP=
_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0404000120",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.SNOOP=
_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0204000120",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.SNOOP=
_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0084000120",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.SNOOP=
_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2004000120",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.SNOOP=
_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0104000120",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.SUPPLIER_NONE.SNOOP_NON_=
DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000020120",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_HIT.SNOOP_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x20003C0122",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x043C000122",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x023C000122",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00BC000122",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x013C000122",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS_LOCAL_DRAM.ANY_SNOO=
P",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000122",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS_LOCAL_DRAM.SNOOP_HI=
TM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000122",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS_LOCAL_DRAM.SNOOP_HI=
T_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0404000122",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS_LOCAL_DRAM.SNOOP_MI=
SS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0204000122",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS_LOCAL_DRAM.SNOOP_NO=
NE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0084000122",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS_LOCAL_DRAM.SNOOP_NO=
N_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2004000122",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS_LOCAL_DRAM.SNOOP_NO=
T_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0104000122",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.SUPPLIER_NONE.SNOOP_NON_DRA=
M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000020122",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writebacks (modified to exclusive)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_HIT.SNOOP_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x20003C0008",
-        "Offcore": "1",
-        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writebacks (modified to exclusive)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x043C000008",
-        "Offcore": "1",
-        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writebacks (modified to exclusive)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x023C000008",
-        "Offcore": "1",
-        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writebacks (modified to exclusive)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00BC000008",
-        "Offcore": "1",
-        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writebacks (modified to exclusive)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x013C000008",
-        "Offcore": "1",
-        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writebacks (modified to exclusive)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS_LOCAL_DRAM.ANY_SNOOP=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000008",
-        "Offcore": "1",
-        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writebacks (modified to exclusive)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS_LOCAL_DRAM.SNOOP_HIT=
M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000008",
-        "Offcore": "1",
-        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writebacks (modified to exclusive)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS_LOCAL_DRAM.SNOOP_HIT=
_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0404000008",
-        "Offcore": "1",
-        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writebacks (modified to exclusive)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS_LOCAL_DRAM.SNOOP_MIS=
S",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0204000008",
-        "Offcore": "1",
-        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writebacks (modified to exclusive)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS_LOCAL_DRAM.SNOOP_NON=
E",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0084000008",
-        "Offcore": "1",
-        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writebacks (modified to exclusive)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS_LOCAL_DRAM.SNOOP_NON=
_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2004000008",
-        "Offcore": "1",
-        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writebacks (modified to exclusive)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS_LOCAL_DRAM.SNOOP_NOT=
_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0104000008",
-        "Offcore": "1",
-        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writebacks (modified to exclusive)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.SUPPLIER_NONE.SNOOP_NON_DRAM=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000020008",
-        "Offcore": "1",
-        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SNOOP_NON_DRA=
M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x20003C0004",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.SNOOP_HIT_NO=
_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x043C000004",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x023C000004",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00BC000004",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.SNOOP_NOT_NE=
EDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x013C000004",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.A=
NY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000004",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000004",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0404000004",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0204000004",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0084000004",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2004000004",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0104000004",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SNOOP_=
NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000020004",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_NON_DRA=
M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x20003C0001",
-        "Offcore": "1",
-        "PublicDescription": "Counts demand data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.SNOOP_HIT_NO=
_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x043C000001",
-        "Offcore": "1",
-        "PublicDescription": "Counts demand data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x023C000001",
-        "Offcore": "1",
-        "PublicDescription": "Counts demand data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00BC000001",
-        "Offcore": "1",
-        "PublicDescription": "Counts demand data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.SNOOP_NOT_NE=
EDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x013C000001",
-        "Offcore": "1",
-        "PublicDescription": "Counts demand data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.A=
NY_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000001",
-        "Offcore": "1",
-        "PublicDescription": "Counts demand data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000001",
-        "Offcore": "1",
-        "PublicDescription": "Counts demand data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0404000001",
-        "Offcore": "1",
-        "PublicDescription": "Counts demand data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0204000001",
-        "Offcore": "1",
-        "PublicDescription": "Counts demand data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0084000001",
-        "Offcore": "1",
-        "PublicDescription": "Counts demand data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2004000001",
-        "Offcore": "1",
-        "PublicDescription": "Counts demand data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0104000001",
-        "Offcore": "1",
-        "PublicDescription": "Counts demand data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000020001",
-        "Offcore": "1",
-        "PublicDescription": "Counts demand data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x20003C0002",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand data writes (RFOs)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.SNOOP_HIT_NO_FWD=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x043C000002",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand data writes (RFOs)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x023C000002",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand data writes (RFOs)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00BC000002",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand data writes (RFOs)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.SNOOP_NOT_NEEDED=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x013C000002",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand data writes (RFOs)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS_LOCAL_DRAM.ANY_S=
NOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000002",
-        "Offcore": "1",
-        "PublicDescription": "Counts all demand data writes (RFOs)",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any other requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SNOOP_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x20003C8000",
-        "Offcore": "1",
-        "PublicDescription": "Counts any other requests",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any other requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x043C008000",
-        "Offcore": "1",
-        "PublicDescription": "Counts any other requests",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any other requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x023C008000",
-        "Offcore": "1",
-        "PublicDescription": "Counts any other requests",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any other requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00BC008000",
-        "Offcore": "1",
-        "PublicDescription": "Counts any other requests",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any other requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x013C008000",
-        "Offcore": "1",
-        "PublicDescription": "Counts any other requests",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any other requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.ANY_SNOOP"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84008000",
-        "Offcore": "1",
-        "PublicDescription": "Counts any other requests",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any other requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_HITM=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004008000",
-        "Offcore": "1",
-        "PublicDescription": "Counts any other requests",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any other requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_HIT_=
NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0404008000",
-        "Offcore": "1",
-        "PublicDescription": "Counts any other requests",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any other requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_MISS=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0204008000",
-        "Offcore": "1",
-        "PublicDescription": "Counts any other requests",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any other requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_NONE=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0084008000",
-        "Offcore": "1",
-        "PublicDescription": "Counts any other requests",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any other requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_NON_=
DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2004008000",
-        "Offcore": "1",
-        "PublicDescription": "Counts any other requests",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any other requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_NOT_=
NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0104008000",
-        "Offcore": "1",
-        "PublicDescription": "Counts any other requests",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any other requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SNOOP_NON_DRAM"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000028000",
-        "Offcore": "1",
-        "PublicDescription": "Counts any other requests",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_HIT.SNOOP_NON_DRAM=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x20003C0040",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS.SNOOP_HIT_NO_=
FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x043C000040",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x023C000040",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00BC000040",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS.SNOOP_NOT_NEE=
DED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x013C000040",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS_LOCAL_DRAM.AN=
Y_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000040",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000040",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0404000040",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0204000040",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0084000040",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2004000040",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0104000040",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.SUPPLIER_NONE.SNOOP_N=
ON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000020040",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_HIT.SNOOP_NON_DRAM=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x20003C0010",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS.SNOOP_HIT_NO_=
FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x043C000010",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x023C000010",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00BC000010",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS.SNOOP_NOT_NEE=
DED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x013C000010",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS_LOCAL_DRAM.AN=
Y_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000010",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000010",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0404000010",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0204000010",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0084000010",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2004000010",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0104000010",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.SUPPLIER_NONE.SNOOP_N=
ON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000020010",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_HIT.SNOOP_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x20003C0020",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS.SNOOP_HIT_NO_FWD"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x043C000020",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x023C000020",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00BC000020",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS.SNOOP_NOT_NEEDED"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x013C000020",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS_LOCAL_DRAM.ANY_SN=
OOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000020",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000020",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0404000020",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0204000020",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0084000020",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2004000020",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0104000020",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.SUPPLIER_NONE.SNOOP_NON_D=
RAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000020020",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_HIT.SNOOP_NON_DRAM=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x20003C0200",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS.SNOOP_HIT_NO_=
FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x043C000200",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x023C000200",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00BC000200",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS.SNOOP_NOT_NEE=
DED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x013C000200",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS_LOCAL_DRAM.AN=
Y_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000200",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000200",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0404000200",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0204000200",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0084000200",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2004000200",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0104000200",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.SUPPLIER_NONE.SNOOP_N=
ON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000020200",
-        "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_HIT.SNOOP_NON_DRAM=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x20003C0080",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS.SNOOP_HIT_NO_=
FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x043C000080",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x023C000080",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00BC000080",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS.SNOOP_NOT_NEE=
DED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x013C000080",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS_LOCAL_DRAM.AN=
Y_SNOOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000080",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000080",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0404000080",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0204000080",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0084000080",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2004000080",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0104000080",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.SUPPLIER_NONE.SNOOP_N=
ON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000020080",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_HIT.SNOOP_NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x20003C0100",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS.SNOOP_HIT_NO_FWD"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x043C000100",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x023C000100",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00BC000100",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS.SNOOP_NOT_NEEDED"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x013C000100",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS_LOCAL_DRAM.ANY_SN=
OOP",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000100",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000100",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0404000100",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0204000100",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0084000100",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2004000100",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0104000100",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.SUPPLIER_NONE.SNOOP_NON_D=
RAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000020100",
-        "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Number of times RTM abort was triggered",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED",
         "PEBS": "1",
@@ -2864,8 +2012,6 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to various memory events (e.g. read/write capacity and conflicts)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_MISC1",
         "PublicDescription": "Number of times an RTM abort was attributed =
to a Memory condition (See TSX_Memory event for additional details).",
@@ -2874,8 +2020,6 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to various memory events (e.g., read/write capacity and conflicts).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_MISC2",
         "PublicDescription": "Number of times the TSX watchdog signaled an=
 RTM abort.",
@@ -2884,8 +2028,6 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to HLE-unfriendly instructions",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_MISC3",
         "PublicDescription": "Number of times a disallowed operation cause=
d an RTM abort.",
@@ -2894,8 +2036,6 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to incompatible memory type",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_MISC4",
         "PublicDescription": "Number of times a RTM caused a fault.",
@@ -2904,8 +2044,6 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to none of the previous 4 categories (e.g. interrupt)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_MISC5",
         "PublicDescription": "Number of times RTM aborted and was not due =
to the abort conditions in subevents 3-6.",
@@ -2914,8 +2052,6 @@
     },
     {
         "BriefDescription": "Number of times RTM commit succeeded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.COMMIT",
         "PublicDescription": "Number of times RTM commit succeeded.",
@@ -2924,8 +2060,6 @@
     },
     {
         "BriefDescription": "Number of times we entered an RTM region; doe=
s not count nested transactions",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.START",
         "PublicDescription": "Number of times we entered an RTM region\n d=
oes not count nested transactions.",
@@ -2934,8 +2068,6 @@
     },
     {
         "BriefDescription": "Counts the number of times a class of instruc=
tions that may cause a transactional abort was executed. Since this is the =
count of execution, it may not always cause a transactional abort.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5d",
         "EventName": "TX_EXEC.MISC1",
         "SampleAfterValue": "2000003",
@@ -2943,8 +2075,6 @@
     },
     {
         "BriefDescription": "Counts the number of times a class of instruc=
tions (e.g., vzeroupper) that may cause a transactional abort was executed =
inside a transactional region",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5d",
         "EventName": "TX_EXEC.MISC2",
         "PublicDescription": "Unfriendly TSX abort triggered by  a vzeroup=
per instruction.",
@@ -2953,8 +2083,6 @@
     },
     {
         "BriefDescription": "Counts the number of times an instruction exe=
cution caused the transactional nest count supported to be exceeded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5d",
         "EventName": "TX_EXEC.MISC3",
         "PublicDescription": "Unfriendly TSX abort triggered by a nest cou=
nt that is too deep.",
@@ -2963,8 +2091,6 @@
     },
     {
         "BriefDescription": "Counts the number of times a XBEGIN instructi=
on was executed inside an HLE transactional region.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5d",
         "EventName": "TX_EXEC.MISC4",
         "PublicDescription": "RTM region detected inside HLE.",
@@ -2973,8 +2099,6 @@
     },
     {
         "BriefDescription": "Counts the number of times an HLE XACQUIRE in=
struction was executed inside an RTM transactional region.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5d",
         "EventName": "TX_EXEC.MISC5",
         "SampleAfterValue": "2000003",
@@ -2982,8 +2106,6 @@
     },
     {
         "BriefDescription": "Number of times a TSX Abort was triggered due=
 to an evicted line caused by a transaction overflow",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_CAPACITY_WRITE",
         "PublicDescription": "Number of times a TSX Abort was triggered du=
e to an evicted line caused by a transaction overflow.",
@@ -2992,8 +2114,6 @@
     },
     {
         "BriefDescription": "Number of times a TSX line had a cache confli=
ct",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_CONFLICT",
         "PublicDescription": "Number of times a TSX line had a cache confl=
ict.",
@@ -3002,8 +2122,6 @@
     },
     {
         "BriefDescription": "Number of times a TSX Abort was triggered due=
 to release/commit but data and address mismatch",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_HLE_ELISION_BUFFER_MISMATCH",
         "PublicDescription": "Number of times a TSX Abort was triggered du=
e to release/commit but data and address mismatch.",
@@ -3012,8 +2130,6 @@
     },
     {
         "BriefDescription": "Number of times a TSX Abort was triggered due=
 to commit but Lock Buffer not empty",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_HLE_ELISION_BUFFER_NOT_EMPTY",
         "PublicDescription": "Number of times a TSX Abort was triggered du=
e to commit but Lock Buffer not empty.",
@@ -3022,8 +2138,6 @@
     },
     {
         "BriefDescription": "Number of times a TSX Abort was triggered due=
 to attempting an unsupported alignment from Lock Buffer",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_HLE_ELISION_BUFFER_UNSUPPORTED_ALIGNMEN=
T",
         "PublicDescription": "Number of times a TSX Abort was triggered du=
e to attempting an unsupported alignment from Lock Buffer.",
@@ -3032,8 +2146,6 @@
     },
     {
         "BriefDescription": "Number of times a TSX Abort was triggered due=
 to a non-release/commit store to lock",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_HLE_STORE_TO_ELIDED_LOCK",
         "PublicDescription": "Number of times a TSX Abort was triggered du=
e to a non-release/commit store to lock.",
@@ -3042,8 +2154,6 @@
     },
     {
         "BriefDescription": "Number of times we could not allocate Lock Bu=
ffer",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x54",
         "EventName": "TX_MEM.HLE_ELISION_BUFFER_FULL",
         "PublicDescription": "Number of times we could not allocate Lock B=
uffer.",
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/other.json b/tools/pe=
rf/pmu-events/arch/x86/broadwell/other.json
index 917d145d5227..1c2a5b001949 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/other.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/other.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Unhalted core cycles when the thread is in ri=
ng 0",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5C",
         "EventName": "CPL_CYCLES.RING0",
         "PublicDescription": "This event counts the unhalted core cycles d=
uring which the thread is in the ring 0 privileged mode.",
@@ -11,8 +9,6 @@
     },
     {
         "BriefDescription": "Number of intervals between processor halts w=
hile thread is in ring 0",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x5C",
@@ -23,8 +19,6 @@
     },
     {
         "BriefDescription": "Unhalted core cycles when thread is in rings =
1, 2, or 3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5C",
         "EventName": "CPL_CYCLES.RING123",
         "PublicDescription": "This event counts unhalted core cycles durin=
g which the thread is in rings 1, 2, or 3.",
@@ -33,8 +27,6 @@
     },
     {
         "BriefDescription": "Cycles when L1 and L2 are locked due to UC or=
 split lock",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x63",
         "EventName": "LOCK_CYCLES.SPLIT_LOCK_UC_LOCK_DURATION",
         "PublicDescription": "This event counts cycles in which the L1 and=
 L2 are locked due to a UC lock or split lock. A lock is asserted in case o=
f locked memory access, due to noncacheable memory, locked operation that s=
pans two cache lines, or a page walk from the noncacheable page table. L1D =
and L2 locks have a very high performance penalty and it is highly recommen=
ded to avoid such access.",
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json b/tools=
/perf/pmu-events/arch/x86/broadwell/pipeline.json
index e9a604e2d67c..2f0fe6b35334 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Cycles when divider is busy executing divide =
operations",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x14",
         "EventName": "ARITH.FPU_DIV_ACTIVE",
         "PublicDescription": "This event counts the number of the divide o=
perations executed. Uses edge-detect and a cmask value of 1 on ARITH.FPU_DI=
V_ACTIVE to get the number of the divide operations executed.",
@@ -11,8 +9,6 @@
     },
     {
         "BriefDescription": "Speculative and retired  branches",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_BRANCHES",
         "PublicDescription": "This event counts both taken and not taken s=
peculative and retired branch instructions.",
@@ -21,8 +17,6 @@
     },
     {
         "BriefDescription": "Speculative and retired macro-conditional bra=
nches",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_CONDITIONAL",
         "PublicDescription": "This event counts both taken and not taken s=
peculative and retired macro-conditional branch instructions.",
@@ -31,8 +25,6 @@
     },
     {
         "BriefDescription": "Speculative and retired macro-unconditional b=
ranches excluding calls and indirects",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_DIRECT_JMP",
         "PublicDescription": "This event counts both taken and not taken s=
peculative and retired macro-unconditional branch instructions, excluding c=
alls and indirects.",
@@ -41,8 +33,6 @@
     },
     {
         "BriefDescription": "Speculative and retired direct near calls",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_DIRECT_NEAR_CALL",
         "PublicDescription": "This event counts both taken and not taken s=
peculative and retired direct near calls.",
@@ -51,8 +41,6 @@
     },
     {
         "BriefDescription": "Speculative and retired indirect branches exc=
luding calls and returns",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_INDIRECT_JUMP_NON_CALL_RET",
         "PublicDescription": "This event counts both taken and not taken s=
peculative and retired indirect branches excluding calls and return branche=
s.",
@@ -61,8 +49,6 @@
     },
     {
         "BriefDescription": "Speculative and retired indirect return branc=
hes.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_INDIRECT_NEAR_RETURN",
         "PublicDescription": "This event counts both taken and not taken s=
peculative and retired indirect branches that have a return mnemonic.",
@@ -71,8 +57,6 @@
     },
     {
         "BriefDescription": "Not taken macro-conditional branches",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.NONTAKEN_CONDITIONAL",
         "PublicDescription": "This event counts not taken macro-conditiona=
l branch instructions.",
@@ -81,8 +65,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired macro-condition=
al branches",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_CONDITIONAL",
         "PublicDescription": "This event counts taken speculative and reti=
red macro-conditional branch instructions.",
@@ -91,8 +73,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired macro-condition=
al branch instructions excluding calls and indirects",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_DIRECT_JUMP",
         "PublicDescription": "This event counts taken speculative and reti=
red macro-conditional branch instructions excluding calls and indirect bran=
ches.",
@@ -101,8 +81,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired direct near cal=
ls",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_DIRECT_NEAR_CALL",
         "PublicDescription": "This event counts taken speculative and reti=
red direct near calls.",
@@ -111,8 +89,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired indirect branch=
es excluding calls and returns",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_INDIRECT_JUMP_NON_CALL_RET",
         "PublicDescription": "This event counts taken speculative and reti=
red indirect branches excluding calls and return branches.",
@@ -121,8 +97,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired indirect calls"=
,
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_INDIRECT_NEAR_CALL",
         "PublicDescription": "This event counts taken speculative and reti=
red indirect calls including both register and memory indirect.",
@@ -131,8 +105,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired indirect branch=
es with return mnemonic",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_INDIRECT_NEAR_RETURN",
         "PublicDescription": "This event counts taken speculative and reti=
red indirect branches that have a return mnemonic.",
@@ -141,8 +113,6 @@
     },
     {
         "BriefDescription": "All (macro) branch instructions retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PublicDescription": "This event counts all (macro) branch instruc=
tions retired.",
@@ -150,8 +120,6 @@
     },
     {
         "BriefDescription": "All (macro) branch instructions retired. (Pre=
cise Event - PEBS)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Errata": "BDW98",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES_PEBS",
@@ -162,8 +130,6 @@
     },
     {
         "BriefDescription": "Conditional branch instructions retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.CONDITIONAL",
         "PEBS": "1",
@@ -173,8 +139,6 @@
     },
     {
         "BriefDescription": "Far branch instructions retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDW98",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
@@ -184,8 +148,6 @@
     },
     {
         "BriefDescription": "Direct and indirect near call instructions re=
tired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
         "PEBS": "1",
@@ -195,8 +157,6 @@
     },
     {
         "BriefDescription": "Direct and indirect macro near call instructi=
ons retired (captured in ring 3).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL_R3",
         "PEBS": "1",
@@ -206,8 +166,6 @@
     },
     {
         "BriefDescription": "Return instructions retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
         "PEBS": "1",
@@ -217,8 +175,6 @@
     },
     {
         "BriefDescription": "Taken branch instructions retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
         "PEBS": "1",
@@ -228,8 +184,6 @@
     },
     {
         "BriefDescription": "Not taken branch instructions retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NOT_TAKEN",
         "PublicDescription": "This event counts not taken branch instructi=
ons retired.",
@@ -238,8 +192,6 @@
     },
     {
         "BriefDescription": "Speculative and retired mispredicted macro co=
nditional branches",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.ALL_BRANCHES",
         "PublicDescription": "This event counts both taken and not taken s=
peculative and retired mispredicted branch instructions.",
@@ -248,8 +200,6 @@
     },
     {
         "BriefDescription": "Speculative and retired mispredicted macro co=
nditional branches",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.ALL_CONDITIONAL",
         "PublicDescription": "This event counts both taken and not taken s=
peculative and retired mispredicted macro conditional branch instructions."=
,
@@ -258,8 +208,6 @@
     },
     {
         "BriefDescription": "Mispredicted indirect branches excluding call=
s and returns",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.ALL_INDIRECT_JUMP_NON_CALL_RET",
         "PublicDescription": "This event counts both taken and not taken m=
ispredicted indirect branches excluding calls and returns.",
@@ -268,8 +216,6 @@
     },
     {
         "BriefDescription": "Not taken speculative and retired mispredicte=
d macro conditional branches",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.NONTAKEN_CONDITIONAL",
         "PublicDescription": "This event counts not taken speculative and =
retired mispredicted macro conditional branch instructions.",
@@ -278,8 +224,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired mispredicted ma=
cro conditional branches",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.TAKEN_CONDITIONAL",
         "PublicDescription": "This event counts taken speculative and reti=
red mispredicted macro conditional branch instructions.",
@@ -288,8 +232,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired mispredicted in=
direct branches excluding calls and returns",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.TAKEN_INDIRECT_JUMP_NON_CALL_RET",
         "PublicDescription": "This event counts taken speculative and reti=
red mispredicted indirect branches excluding calls and returns.",
@@ -298,8 +240,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired mispredicted in=
direct calls.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.TAKEN_INDIRECT_NEAR_CALL",
         "SampleAfterValue": "200003",
@@ -307,8 +247,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired mispredicted in=
direct branches with return mnemonic",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.TAKEN_RETURN_NEAR",
         "PublicDescription": "This event counts taken speculative and reti=
red mispredicted indirect branches that have a return mnemonic.",
@@ -317,8 +255,6 @@
     },
     {
         "BriefDescription": "All mispredicted macro branch instructions re=
tired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PublicDescription": "This event counts all mispredicted macro bra=
nch instructions retired.",
@@ -326,8 +262,6 @@
     },
     {
         "BriefDescription": "Mispredicted macro branch instructions retire=
d. (Precise Event - PEBS)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES_PEBS",
         "PEBS": "2",
@@ -337,8 +271,6 @@
     },
     {
         "BriefDescription": "Mispredicted conditional branch instructions =
retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.CONDITIONAL",
         "PEBS": "1",
@@ -348,8 +280,6 @@
     },
     {
         "BriefDescription": "number of near branch instructions retired th=
at were mispredicted and taken.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
         "PEBS": "1",
@@ -359,8 +289,6 @@
     },
     {
         "BriefDescription": "This event counts the number of mispredicted =
ret instructions retired. Non PEBS",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.RET",
         "PEBS": "1",
@@ -370,8 +298,6 @@
     },
     {
         "BriefDescription": "Count XClk pulses when this thread is unhalte=
d and the other thread is halted.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE",
         "SampleAfterValue": "100003",
@@ -379,8 +305,6 @@
     },
     {
         "BriefDescription": "Reference cycles when the thread is unhalted =
(counts at 100 MHz rate)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_THREAD_UNHALTED.REF_XCLK",
         "PublicDescription": "This is a fixed-frequency event programmed t=
o general counters. It counts when the core is unhalted at 100 Mhz.",
@@ -390,8 +314,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Reference cycles when the at least one thread=
 on the physical core is unhalted (counts at 100 MHz rate).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY",
         "SampleAfterValue": "100003",
@@ -399,8 +321,6 @@
     },
     {
         "BriefDescription": "Count XClk pulses when this thread is unhalte=
d and the other thread is halted.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
         "SampleAfterValue": "100003",
@@ -408,8 +328,6 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
-        "Counter": "Fixed counter 2",
-        "CounterHTOff": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "This event counts the number of reference cy=
cles when the core is not in a halt state. The core enters the halt state w=
hen it is running the HLT instruction or the MWAIT instruction. This event =
is not affected by core frequency changes (for example, P states, TM2 trans=
itions) but has the same incrementing frequency as the time stamp counter. =
This event can approximate elapsed time while the core was not in a halt st=
ate. This event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK eve=
nt. It is counted on a dedicated fixed counter, leaving the four (eight whe=
n Hyperthreading is disabled) programmable counters available for other eve=
nts. \nNote: On all current platforms this event stops counting during 'thr=
ottling (TM)' states duty off periods the processor is 'halted'.  This even=
t is clocked by base clock (100 Mhz) on Sandy Bridge. The counter update is=
 done at a lower clock rate then the core clock the overflow status bit for=
 this counter may appear 'sticky'.  After the counter has overflowed and so=
ftware clears the overflow status bit and resets the counter to less than M=
AX. The reset value to the counter is not clocked immediately so the overfl=
ow status bit will flip 'high (1)' and generate another PMI (if enabled) af=
ter which the reset value gets clocked into the counter. Therefore, softwar=
e will get the interrupt, read the overflow status bit '1 for bit 34 while =
the counter value is less than MAX. Software should ignore this case.",
         "SampleAfterValue": "2000003",
@@ -417,8 +335,6 @@
     },
     {
         "BriefDescription": "Reference cycles when the thread is unhalted =
(counts at 100 MHz rate)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.REF_XCLK",
         "PublicDescription": "Reference cycles when the thread is unhalted=
 (counts at 100 MHz rate).",
@@ -428,8 +344,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Reference cycles when the at least one thread=
 on the physical core is unhalted (counts at 100 MHz rate).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.REF_XCLK_ANY",
         "SampleAfterValue": "100003",
@@ -437,8 +351,6 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt st=
ate",
-        "Counter": "Fixed counter 1",
-        "CounterHTOff": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "This event counts the number of core cycles =
while the thread is not in a halt state. The thread enters the halt state w=
hen it is running the HLT instruction. This event is a component in many ke=
y event ratios. The core frequency may change from time to time due to tran=
sitions associated with Enhanced Intel SpeedStep Technology or TM2. For thi=
s reason this event may have a changing ratio with regards to time. When th=
e core frequency is constant, this event can approximate elapsed time while=
 the core was not in the halt state. It is counted on a dedicated fixed cou=
nter, leaving the four (eight when Hyperthreading is disabled) programmable=
 counters available for other events.",
         "SampleAfterValue": "2000003",
@@ -447,16 +359,12 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core cycles when at least one thread on the p=
hysical core is not in halt state.",
-        "Counter": "Fixed counter 1",
-        "CounterHTOff": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Thread cycles when thread is not in halt stat=
e",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
         "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time.",
@@ -465,16 +373,12 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core cycles when at least one thread on the p=
hysical core is not in halt state.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P_ANY",
         "SampleAfterValue": "2000003"
     },
     {
         "BriefDescription": "Cycles while L1 cache miss demand load is out=
standing.",
-        "Counter": "2",
-        "CounterHTOff": "2",
         "CounterMask": "8",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_MISS",
@@ -483,8 +387,6 @@
     },
     {
         "BriefDescription": "Cycles while L1 cache miss demand load is out=
standing.",
-        "Counter": "2",
-        "CounterHTOff": "2",
         "CounterMask": "8",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_PENDING",
@@ -494,8 +396,6 @@
     },
     {
         "BriefDescription": "Cycles while L2 cache miss demand load is out=
standing.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L2_MISS",
@@ -504,8 +404,6 @@
     },
     {
         "BriefDescription": "Cycles while L2 cache miss demand load is out=
standing.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L2_PENDING",
@@ -515,8 +413,6 @@
     },
     {
         "BriefDescription": "Cycles while memory subsystem has an outstand=
ing load.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "2",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_LDM_PENDING",
@@ -526,8 +422,6 @@
     },
     {
         "BriefDescription": "Cycles while memory subsystem has an outstand=
ing load.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "2",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_MEM_ANY",
@@ -536,8 +430,6 @@
     },
     {
         "BriefDescription": "This event increments by 1 for every cycle wh=
ere there was no execute for this thread.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "4",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_NO_EXECUTE",
@@ -547,8 +439,6 @@
     },
     {
         "BriefDescription": "Execution stalls while L1 cache miss demand l=
oad is outstanding.",
-        "Counter": "2",
-        "CounterHTOff": "2",
         "CounterMask": "12",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L1D_MISS",
@@ -557,8 +447,6 @@
     },
     {
         "BriefDescription": "Execution stalls while L1 cache miss demand l=
oad is outstanding.",
-        "Counter": "2",
-        "CounterHTOff": "2",
         "CounterMask": "12",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L1D_PENDING",
@@ -568,8 +456,6 @@
     },
     {
         "BriefDescription": "Execution stalls while L2 cache miss demand l=
oad is outstanding.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "5",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L2_MISS",
@@ -578,8 +464,6 @@
     },
     {
         "BriefDescription": "Execution stalls while L2 cache miss demand l=
oad is outstanding.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "5",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L2_PENDING",
@@ -589,8 +473,6 @@
     },
     {
         "BriefDescription": "Execution stalls while memory subsystem has a=
n outstanding load.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "6",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.STALLS_LDM_PENDING",
@@ -600,8 +482,6 @@
     },
     {
         "BriefDescription": "Execution stalls while memory subsystem has a=
n outstanding load.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "6",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.STALLS_MEM_ANY",
@@ -610,8 +490,6 @@
     },
     {
         "BriefDescription": "Total execution stalls.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.STALLS_TOTAL",
@@ -620,8 +498,6 @@
     },
     {
         "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x87",
         "EventName": "ILD_STALL.LCP",
         "PublicDescription": "This event counts stalls occured due to chan=
ging prefix length (66, 67 or REX.W when they change the length of the deco=
ded instruction). Occurrences counting is proportional to the number of pre=
fixes in a 16B-line. This may result in the following penalties: three-cycl=
e penalty for each LCP in a 16-byte chunk.",
@@ -630,8 +506,6 @@
     },
     {
         "BriefDescription": "Instructions retired from execution.",
-        "Counter": "Fixed counter 0",
-        "CounterHTOff": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
         "PublicDescription": "This event counts the number of instructions=
 retired from execution. For instructions that consist of multiple micro-op=
s, this event counts the retirement of the last micro-op of the instruction=
. Counting continues during hardware interrupts, traps, and inside interrup=
t handlers. \nNotes: INST_RETIRED.ANY is counted by a designated fixed coun=
ter, leaving the four (eight when Hyperthreading is disabled) programmable =
counters available for other events. INST_RETIRED.ANY_P is counted by a pro=
grammable counter and it is an architectural performance event. \nCounting:=
 Faulting executions of GETSEC/VM entry/VM Exit/MWait will not count as ret=
ired instructions.",
         "SampleAfterValue": "2000003",
@@ -639,8 +513,6 @@
     },
     {
         "BriefDescription": "Number of instructions retired. General Count=
er   - architectural event",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM61",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.ANY_P",
@@ -649,8 +521,6 @@
     },
     {
         "BriefDescription": "Precise instruction retired event with HW to =
reduce effect of PEBS shadow in IP distribution",
-        "Counter": "1",
-        "CounterHTOff": "1",
         "Errata": "BDM11, BDM55",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.PREC_DIST",
@@ -661,8 +531,6 @@
     },
     {
         "BriefDescription": "FP operations  retired. X87 FP operations tha=
t have no exceptions:",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.X87",
         "PublicDescription": "This event counts FP operations retired. For=
 X87 FP operations that have no exceptions counting also includes flows tha=
t have several X87, or flows that use X87 uops in the exception handling.",
@@ -671,8 +539,6 @@
     },
     {
         "BriefDescription": "Cycles when Resource Allocation Table (RAT) e=
xternal stall is sent to Instruction Decode Queue (IDQ) for the thread",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x0D",
         "EventName": "INT_MISC.RAT_STALL_CYCLES",
         "PublicDescription": "This event counts the number of cycles durin=
g which Resource Allocation Table (RAT) external stall is sent to Instructi=
on Decode Queue (IDQ) for the current thread. This also includes the cycles=
 during which the Allocator is serving another thread.",
@@ -681,8 +547,6 @@
     },
     {
         "BriefDescription": "Core cycles the allocator was stalled due to =
recovery from earlier clear event for this thread (e.g. misprediction or me=
mory nuke)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x0D",
         "EventName": "INT_MISC.RECOVERY_CYCLES",
@@ -693,8 +557,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core cycles the allocator was stalled due to =
recovery from earlier clear event for any thread running on the physical co=
re (e.g. misprediction or memory nuke).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x0D",
         "EventName": "INT_MISC.RECOVERY_CYCLES_ANY",
@@ -703,8 +565,6 @@
     },
     {
         "BriefDescription": "This event counts the number of times that sp=
lit load operations are temporarily blocked because all resources for handl=
ing the split accesses are in use.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.NO_SR",
         "SampleAfterValue": "100003",
@@ -712,8 +572,6 @@
     },
     {
         "BriefDescription": "Cases when loads get true Block-on-Store bloc=
king code preventing store forwarding",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
         "PublicDescription": "This event counts how many times the load op=
eration got the true Block-on-Store blocking code preventing store forwardi=
ng. This includes cases when:\n - preceding store conflicts with the load (=
incomplete overlap);\n - store forwarding is impossible due to u-arch limit=
ations;\n - preceding lock RMW operations are not forwarded;\n - store has =
the no-forward bit set (uncacheable/page-split/masked stores);\n - all-bloc=
king stores are used (mostly, fences and port I/O);\nand others.\nThe most =
common case is a load blocked due to its address range overlapping with a p=
receding smaller uncompleted store. Note: This event does not take into acc=
ount cases of out-of-SW-control (for example, SbTailHit), unknown physical =
STA, and cases of blocking loads on store due to being non-WB memory type o=
r a lock. These cases are covered by other events.\nSee the table of not su=
pported store forwards in the Optimization Guide.",
@@ -722,8 +580,6 @@
     },
     {
         "BriefDescription": "False dependencies in MOB due to partial comp=
are",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x07",
         "EventName": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS",
         "PublicDescription": "This event counts false dependencies in MOB =
when the partial comparison upon loose net check and dependency was resolve=
d by the Enhanced Loose net mechanism. This may not result in high performa=
nce penalties. Loose net checks can fail when loads and stores are 4k alias=
ed.",
@@ -732,8 +588,6 @@
     },
     {
         "BriefDescription": "Not software-prefetch load dispatches that hi=
t FB allocated for hardware prefetch",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x4C",
         "EventName": "LOAD_HIT_PRE.HW_PF",
         "PublicDescription": "This event counts all not software-prefetch =
load dispatches that hit the fill buffer (FB) allocated for the hardware pr=
efetch.",
@@ -742,8 +596,6 @@
     },
     {
         "BriefDescription": "Not software-prefetch load dispatches that hi=
t FB allocated for software prefetch",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x4c",
         "EventName": "LOAD_HIT_PRE.SW_PF",
         "PublicDescription": "This event counts all not software-prefetch =
load dispatches that hit the fill buffer (FB) allocated for the software pr=
efetch. It can also be incremented by some lock instructions. So it should =
only be used with profiling so that the locks can be excluded by asm inspec=
tion of the nearby instructions.",
@@ -752,8 +604,6 @@
     },
     {
         "BriefDescription": "Cycles 4 Uops delivered by the LSD, but didn'=
t come from the decoder.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0xA8",
         "EventName": "LSD.CYCLES_4_UOPS",
@@ -762,8 +612,6 @@
     },
     {
         "BriefDescription": "Cycles Uops delivered by the LSD, but didn't =
come from the decoder.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xA8",
         "EventName": "LSD.CYCLES_ACTIVE",
@@ -772,8 +620,6 @@
     },
     {
         "BriefDescription": "Number of Uops delivered by the LSD.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA8",
         "EventName": "LSD.UOPS",
         "SampleAfterValue": "2000003",
@@ -781,8 +627,6 @@
     },
     {
         "BriefDescription": "Number of machine clears (nukes) of any type.=
",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0xC3",
@@ -792,8 +636,6 @@
     },
     {
         "BriefDescription": "Cycles there was a Nuke. Account for both thr=
ead-specific and All Thread Nukes.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.CYCLES",
         "PublicDescription": "This event counts both thread-specific (TS) =
and all-thread (AT) nukes.",
@@ -802,8 +644,6 @@
     },
     {
         "BriefDescription": "This event counts the number of executed Inte=
l AVX masked load operations that refer to an illegal address range with th=
e mask bits set to 0.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MASKMOV",
         "PublicDescription": "Maskmov false fault - counts number of time =
ucode passes through Maskmov flow due to instruction's mask being 0 while t=
he flow was completed without raising a fault.",
@@ -812,8 +652,6 @@
     },
     {
         "BriefDescription": "Self-modifying code (SMC) detected.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.SMC",
         "PublicDescription": "This event counts self-modifying code (SMC) =
detected, which causes a machine clear.",
@@ -822,8 +660,6 @@
     },
     {
         "BriefDescription": "Number of integer Move Elimination candidate =
uops that were eliminated.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x58",
         "EventName": "MOVE_ELIMINATION.INT_ELIMINATED",
         "SampleAfterValue": "1000003",
@@ -831,8 +667,6 @@
     },
     {
         "BriefDescription": "Number of integer Move Elimination candidate =
uops that were not eliminated.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x58",
         "EventName": "MOVE_ELIMINATION.INT_NOT_ELIMINATED",
         "SampleAfterValue": "1000003",
@@ -840,8 +674,6 @@
     },
     {
         "BriefDescription": "Number of times any microcode assist is invok=
ed by HW upon uop writeback.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC1",
         "EventName": "OTHER_ASSISTS.ANY_WB_ASSIST",
         "SampleAfterValue": "100003",
@@ -849,8 +681,6 @@
     },
     {
         "BriefDescription": "Resource-related stall cycles",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa2",
         "EventName": "RESOURCE_STALLS.ANY",
         "PublicDescription": "This event counts resource-related stall cyc=
les.",
@@ -859,8 +689,6 @@
     },
     {
         "BriefDescription": "Cycles stalled due to re-order buffer full.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.ROB",
         "PublicDescription": "This event counts ROB full stall cycles. Thi=
s counts cycles that the pipeline backend blocked uop delivery from the fro=
nt end.",
@@ -869,8 +697,6 @@
     },
     {
         "BriefDescription": "Cycles stalled due to no eligible RS entry av=
ailable.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.RS",
         "PublicDescription": "This event counts stall cycles caused by abs=
ence of eligible entries in the reservation station (RS). This may result f=
rom RS overflow, or from RS deallocation because of the RS array Write Port=
 allocation scheme (each RS entry has two write ports instead of four. As a=
 result, empty entries could not be used, although RS is not really full). =
This counts cycles that the pipeline backend blocked uop delivery from the =
front end.",
@@ -879,8 +705,6 @@
     },
     {
         "BriefDescription": "Cycles stalled due to no store buffers availa=
ble. (not including draining form sync).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.SB",
         "PublicDescription": "This event counts stall cycles caused by the=
 store buffer (SB) overflow (excluding draining from synch). This counts cy=
cles that the pipeline backend blocked uop delivery from the front end.",
@@ -889,8 +713,6 @@
     },
     {
         "BriefDescription": "Count cases of saving new LBR",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xCC",
         "EventName": "ROB_MISC_EVENTS.LBR_INSERTS",
         "PublicDescription": "This event counts cases of saving new LBR re=
cords by hardware. This assumes proper enabling of LBRs and takes into acco=
unt LBR filtering done by the LBR_SELECT register.",
@@ -899,8 +721,6 @@
     },
     {
         "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 for the thread",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5E",
         "EventName": "RS_EVENTS.EMPTY_CYCLES",
         "PublicDescription": "This event counts cycles during which the re=
servation station (RS) is empty for the thread.\nNote: In ST-mode, not acti=
ve thread should drive 0. This is usually caused by severely costly branch =
mispredictions, or allocator/FE issues.",
@@ -909,8 +729,6 @@
     },
     {
         "BriefDescription": "Counts end of periods where the Reservation S=
tation (RS) was empty. Could be useful to precisely locate Frontend Latency=
 Bound issues.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x5E",
@@ -921,8 +739,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 0",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_0",
         "PublicDescription": "This event counts, on the per-thread basis, =
cycles during which uops are dispatched from the Reservation Station (RS) t=
o port 0.",
@@ -931,8 +747,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 1",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_1",
         "PublicDescription": "This event counts, on the per-thread basis, =
cycles during which uops are dispatched from the Reservation Station (RS) t=
o port 1.",
@@ -941,8 +755,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 2",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_2",
         "PublicDescription": "This event counts, on the per-thread basis, =
cycles during which uops are dispatched from the Reservation Station (RS) t=
o port 2.",
@@ -951,8 +763,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_3",
         "PublicDescription": "This event counts, on the per-thread basis, =
cycles during which uops are dispatched from the Reservation Station (RS) t=
o port 3.",
@@ -961,8 +771,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 4",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_4",
         "PublicDescription": "This event counts, on the per-thread basis, =
cycles during which uops are dispatched from the Reservation Station (RS) t=
o port 4.",
@@ -971,8 +779,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 5",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_5",
         "PublicDescription": "This event counts, on the per-thread basis, =
cycles during which uops are dispatched from the Reservation Station (RS) t=
o port 5.",
@@ -981,8 +787,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 6",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_6",
         "PublicDescription": "This event counts, on the per-thread basis, =
cycles during which uops are dispatched from the Reservation Station (RS) t=
o port 6.",
@@ -991,8 +795,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 7",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_7",
         "PublicDescription": "This event counts, on the per-thread basis, =
cycles during which uops are dispatched from the Reservation Station (RS) t=
o port 7.",
@@ -1001,8 +803,6 @@
     },
     {
         "BriefDescription": "Number of uops executed on the core.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE",
         "PublicDescription": "Number of uops executed from any thread.",
@@ -1011,8 +811,6 @@
     },
     {
         "BriefDescription": "Cycles at least 1 micro-op is executed from a=
ny thread on physical core.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_1",
@@ -1021,8 +819,6 @@
     },
     {
         "BriefDescription": "Cycles at least 2 micro-op is executed from a=
ny thread on physical core.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "2",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_2",
@@ -1031,8 +827,6 @@
     },
     {
         "BriefDescription": "Cycles at least 3 micro-op is executed from a=
ny thread on physical core.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "3",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_3",
@@ -1041,8 +835,6 @@
     },
     {
         "BriefDescription": "Cycles at least 4 micro-op is executed from a=
ny thread on physical core.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_4",
@@ -1051,8 +843,6 @@
     },
     {
         "BriefDescription": "Cycles with no micro-ops executed from any th=
read on physical core.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_NONE",
         "Invert": "1",
@@ -1061,8 +851,6 @@
     },
     {
         "BriefDescription": "Cycles where at least 1 uop was executed per-=
thread.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC",
@@ -1071,8 +859,6 @@
     },
     {
         "BriefDescription": "Cycles where at least 2 uops were executed pe=
r-thread.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "2",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC",
@@ -1081,8 +867,6 @@
     },
     {
         "BriefDescription": "Cycles where at least 3 uops were executed pe=
r-thread.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "3",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC",
@@ -1091,8 +875,6 @@
     },
     {
         "BriefDescription": "Cycles where at least 4 uops were executed pe=
r-thread.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "4",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_4_UOPS_EXEC",
@@ -1101,8 +883,6 @@
     },
     {
         "BriefDescription": "Counts number of cycles no uops were dispatch=
ed to be executed on this thread.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.STALL_CYCLES",
@@ -1113,8 +893,6 @@
     },
     {
         "BriefDescription": "Counts the number of uops to be executed per-=
thread each cycle.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.THREAD",
         "PublicDescription": "Number of uops to be executed per-thread eac=
h cycle.",
@@ -1123,8 +901,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 0",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_0",
         "PublicDescription": "This event counts, on the per-thread basis, =
cycles during which uops are dispatched from the Reservation Station (RS) t=
o port 0.",
@@ -1134,8 +910,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are exectuted in po=
rt 0.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_0_CORE",
         "SampleAfterValue": "2000003",
@@ -1143,8 +917,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 1",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_1",
         "PublicDescription": "This event counts, on the per-thread basis, =
cycles during which uops are dispatched from the Reservation Station (RS) t=
o port 1.",
@@ -1154,8 +926,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are exectuted in po=
rt 1.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_1_CORE",
         "SampleAfterValue": "2000003",
@@ -1163,8 +933,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 2",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_2",
         "PublicDescription": "This event counts, on the per-thread basis, =
cycles during which uops are dispatched from the Reservation Station (RS) t=
o port 2.",
@@ -1174,8 +942,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are dispatched to p=
ort 2.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_2_CORE",
         "SampleAfterValue": "2000003",
@@ -1183,8 +949,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_3",
         "PublicDescription": "This event counts, on the per-thread basis, =
cycles during which uops are dispatched from the Reservation Station (RS) t=
o port 3.",
@@ -1194,8 +958,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are dispatched to p=
ort 3.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_3_CORE",
         "SampleAfterValue": "2000003",
@@ -1203,8 +965,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 4",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_4",
         "PublicDescription": "This event counts, on the per-thread basis, =
cycles during which uops are dispatched from the Reservation Station (RS) t=
o port 4.",
@@ -1214,8 +974,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are exectuted in po=
rt 4.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_4_CORE",
         "SampleAfterValue": "2000003",
@@ -1223,8 +981,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 5",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_5",
         "PublicDescription": "This event counts, on the per-thread basis, =
cycles during which uops are dispatched from the Reservation Station (RS) t=
o port 5.",
@@ -1234,8 +990,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are exectuted in po=
rt 5.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_5_CORE",
         "SampleAfterValue": "2000003",
@@ -1243,8 +997,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 6",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_6",
         "PublicDescription": "This event counts, on the per-thread basis, =
cycles during which uops are dispatched from the Reservation Station (RS) t=
o port 6.",
@@ -1254,8 +1006,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are exectuted in po=
rt 6.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_6_CORE",
         "SampleAfterValue": "2000003",
@@ -1263,8 +1013,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 7",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_7",
         "PublicDescription": "This event counts, on the per-thread basis, =
cycles during which uops are dispatched from the Reservation Station (RS) t=
o port 7.",
@@ -1274,8 +1022,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are dispatched to p=
ort 7.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_7_CORE",
         "SampleAfterValue": "2000003",
@@ -1283,8 +1029,6 @@
     },
     {
         "BriefDescription": "Uops that Resource Allocation Table (RAT) iss=
ues to Reservation Station (RS)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.ANY",
         "PublicDescription": "This event counts the number of Uops issued =
by the Resource Allocation Table (RAT) to the reservation station (RS).",
@@ -1293,8 +1037,6 @@
     },
     {
         "BriefDescription": "Number of flags-merge uops being allocated. S=
uch uops considered perf sensitive; added by GSR u-arch.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.FLAGS_MERGE",
         "PublicDescription": "Number of flags-merge uops being allocated. =
Such uops considered perf sensitive\n added by GSR u-arch.",
@@ -1303,8 +1045,6 @@
     },
     {
         "BriefDescription": "Number of Multiply packed/scalar single preci=
sion uops allocated.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.SINGLE_MUL",
         "SampleAfterValue": "2000003",
@@ -1312,8 +1052,6 @@
     },
     {
         "BriefDescription": "Number of slow LEA uops being allocated. A uo=
p is generally considered SlowLea if it has 3 sources (e.g. 2 sources + imm=
ediate) regardless if as a result of LEA instruction or not.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.SLOW_LEA",
         "SampleAfterValue": "2000003",
@@ -1321,8 +1059,6 @@
     },
     {
         "BriefDescription": "Cycles when Resource Allocation Table (RAT) d=
oes not issue Uops to Reservation Station (RS) for the thread",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.STALL_CYCLES",
@@ -1333,8 +1069,6 @@
     },
     {
         "BriefDescription": "Actually retired uops.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.ALL",
         "PEBS": "1",
@@ -1344,8 +1078,6 @@
     },
     {
         "BriefDescription": "Retirement slots used.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.RETIRE_SLOTS",
         "PEBS": "1",
@@ -1355,8 +1087,6 @@
     },
     {
         "BriefDescription": "Cycles without actually retired uops.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.STALL_CYCLES",
@@ -1367,8 +1097,6 @@
     },
     {
         "BriefDescription": "Cycles with less than 10 actually retired uop=
s.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "10",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.TOTAL_CYCLES",
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/uncore-cache.json b/t=
ools/perf/pmu-events/arch/x86/broadwell/uncore-cache.json
index d1805b3a5e3d..fcb15b880bad 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/uncore-cache.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "L3 Lookup any request that access cache and f=
ound line in E or S-state",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_ES",
         "PerPkg": "1",
@@ -11,7 +10,6 @@
     },
     {
         "BriefDescription": "L3 Lookup any request that access cache and f=
ound line in I-state",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_I",
         "PerPkg": "1",
@@ -21,7 +19,6 @@
     },
     {
         "BriefDescription": "L3 Lookup any request that access cache and f=
ound line in M-state",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_M",
         "PerPkg": "1",
@@ -31,7 +28,6 @@
     },
     {
         "BriefDescription": "L3 Lookup any request that access cache and f=
ound line in MESI-state",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_MESI",
         "PerPkg": "1",
@@ -41,7 +37,6 @@
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and =
found line in E or S-state",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.READ_ES",
         "PerPkg": "1",
@@ -51,7 +46,6 @@
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and =
found line in I-state",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.READ_I",
         "PerPkg": "1",
@@ -61,7 +55,6 @@
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and =
found line in M-state",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.READ_M",
         "PerPkg": "1",
@@ -71,7 +64,6 @@
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and =
found line in any MESI-state",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.READ_MESI",
         "PerPkg": "1",
@@ -81,7 +73,6 @@
     },
     {
         "BriefDescription": "L3 Lookup write request that access cache and=
 found line in E or S-state",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.WRITE_ES",
         "PerPkg": "1",
@@ -91,7 +82,6 @@
     },
     {
         "BriefDescription": "L3 Lookup write request that access cache and=
 found line in M-state",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.WRITE_M",
         "PerPkg": "1",
@@ -101,7 +91,6 @@
     },
     {
         "BriefDescription": "L3 Lookup write request that access cache and=
 found line in MESI-state",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.WRITE_MESI",
         "PerPkg": "1",
@@ -111,41 +100,33 @@
     },
     {
         "BriefDescription": "A cross-core snoop initiated by this Cbox due=
 to processor core memory request which hits a modified line in some proces=
sor core.",
-        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_CBO_XSNP_RESPONSE.HITM_XCORE",
         "PerPkg": "1",
-        "PublicDescription": "A cross-core snoop initiated by this Cbox du=
e to processor core memory request which hits a modified line in some proce=
ssor core.",
         "UMask": "0x48",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "A cross-core snoop initiated by this Cbox due=
 to processor core memory request which hits a non-modified line in some pr=
ocessor core.",
-        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_CBO_XSNP_RESPONSE.HIT_XCORE",
         "PerPkg": "1",
-        "PublicDescription": "A cross-core snoop initiated by this Cbox du=
e to processor core memory request which hits a non-modified line in some p=
rocessor core.",
         "UMask": "0x44",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "A cross-core snoop resulted from L3 Eviction =
which misses in some processor core.",
-        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_CBO_XSNP_RESPONSE.MISS_EVICTION",
         "PerPkg": "1",
-        "PublicDescription": "A cross-core snoop resulted from L3 Eviction=
 which misses in some processor core.",
         "UMask": "0x81",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "A cross-core snoop initiated by this Cbox due=
 to processor core memory request which misses in some processor core.",
-        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_CBO_XSNP_RESPONSE.MISS_XCORE",
         "PerPkg": "1",
-        "PublicDescription": "A cross-core snoop initiated by this Cbox du=
e to processor core memory request which misses in some processor core.",
         "UMask": "0x41",
         "Unit": "CBO"
     }
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/uncore-other.json b/t=
ools/perf/pmu-events/arch/x86/broadwell/uncore-other.json
index 73c2261e1e94..ddcf7faa9d10 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/uncore-other.json
@@ -1,78 +1,65 @@
 [
     {
         "BriefDescription": "Number of entries allocated. Account for Any =
type: e.g. Snoop, Core aperture, etc.",
-        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
         "PerPkg": "1",
-        "PublicDescription": "Number of entries allocated. Account for Any=
 type: e.g. Snoop, Core aperture, etc.",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "ARB"
     },
     {
         "BriefDescription": "Each cycle count number of all Core outgoing =
valid entries. Such entry is defined as valid from it's allocation till fir=
st of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-cohe=
rent traffic.",
-        "Counter": "0,",
         "EventCode": "0x80",
         "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
         "PerPkg": "1",
-        "PublicDescription": "Each cycle count number of all Core outgoing=
 valid entries. Such entry is defined as valid from it's allocation till fi=
rst of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coh=
erent traffic.",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "ARB"
     },
     {
         "BriefDescription": "Cycles with at least one request outstanding =
is waiting for data return from memory controller. Account for coherent and=
 non-coherent requests initiated by IA Cores, Processor Graphics Unit, or L=
LC.;",
-        "Counter": "0,",
         "CounterMask": "1",
         "EventCode": "0x80",
         "EventName": "UNC_ARB_TRK_OCCUPANCY.CYCLES_WITH_ANY_REQUEST",
         "PerPkg": "1",
-        "PublicDescription": "Cycles with at least one request outstanding=
 is waiting for data return from memory controller. Account for coherent an=
d non-coherent requests initiated by IA Cores, Processor Graphics Unit, or =
LLC.",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "ARB"
     },
     {
         "BriefDescription": "Each cycle count number of 'valid' coherent D=
ata Read entries that are in DirectData mode. Such entry is defined as vali=
d when it is allocated till data sent to Core (first chunk, IDI0). Applicab=
le for IA Cores' requests in normal case.",
-        "Counter": "0,",
         "EventCode": "0x80",
         "EventName": "UNC_ARB_TRK_OCCUPANCY.DRD_DIRECT",
         "PerPkg": "1",
         "PublicDescription": "Each cycle count number of valid coherent Da=
ta Read entries that are in DirectData mode. Such entry is defined as valid=
 when it is allocated till data sent to Core (first chunk, IDI0). Applicabl=
e for IA Cores' requests in normal case.",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "ARB"
     },
     {
         "BriefDescription": "Total number of Core outgoing entries allocat=
ed. Accounts for Coherent and non-coherent traffic.",
-        "Counter": "0,1",
         "EventCode": "0x81",
         "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
         "PerPkg": "1",
-        "PublicDescription": "Total number of Core outgoing entries alloca=
ted. Accounts for Coherent and non-coherent traffic.",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "ARB"
     },
     {
         "BriefDescription": "Number of Core coherent Data Read entries all=
ocated in DirectData mode",
-        "Counter": "0,1",
         "EventCode": "0x81",
         "EventName": "UNC_ARB_TRK_REQUESTS.DRD_DIRECT",
         "PerPkg": "1",
         "PublicDescription": "Number of Core coherent Data Read entries al=
located in DirectData mode.",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "ARB"
     },
     {
         "BriefDescription": "Number of Writes allocated - any write transa=
ctions: full/partials writes and evictions.",
-        "Counter": "0,1",
         "EventCode": "0x81",
         "EventName": "UNC_ARB_TRK_REQUESTS.WRITES",
         "PerPkg": "1",
-        "PublicDescription": "Number of Writes allocated - any write trans=
actions: full/partials writes and evictions.",
         "UMask": "0x20",
         "Unit": "ARB"
     },
     {
         "BriefDescription": "This 48-bit fixed counter counts the UCLK cyc=
les",
-        "Counter": "FIXED",
         "EventCode": "0xff",
         "EventName": "UNC_CLOCK.SOCKET",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/virtual-memory.json b=
/tools/perf/pmu-events/arch/x86/broadwell/virtual-memory.json
index 6a6de8790f25..93621e004d88 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/virtual-memory.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Load misses in all DTLB levels that cause pag=
e walks",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM69",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.MISS_CAUSES_A_WALK",
@@ -12,8 +10,6 @@
     },
     {
         "BriefDescription": "Load operations that miss the first DTLB leve=
l but hit the second and do not cause page walks.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
         "SampleAfterValue": "2000003",
@@ -21,8 +17,6 @@
     },
     {
         "BriefDescription": "Load misses that miss the  DTLB and hit the S=
TLB (2M).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.STLB_HIT_2M",
         "SampleAfterValue": "2000003",
@@ -30,8 +24,6 @@
     },
     {
         "BriefDescription": "Load misses that miss the  DTLB and hit the S=
TLB (4K).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.STLB_HIT_4K",
         "SampleAfterValue": "2000003",
@@ -39,8 +31,6 @@
     },
     {
         "BriefDescription": "Demand load Miss in all translation lookaside=
 buffer (TLB) levels causes a page walk that completes of any page size.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM69",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
@@ -49,8 +39,6 @@
     },
     {
         "BriefDescription": "Load miss in all TLB levels causes a page wal=
k that completes. (1G)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM69",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_1G",
@@ -60,8 +48,6 @@
     },
     {
         "BriefDescription": "Demand load Miss in all translation lookaside=
 buffer (TLB) levels causes a page walk that completes (2M/4M).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM69",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
@@ -71,8 +57,6 @@
     },
     {
         "BriefDescription": "Demand load Miss in all translation lookaside=
 buffer (TLB) levels causes a page walk that completes (4K).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM69",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
@@ -82,8 +66,6 @@
     },
     {
         "BriefDescription": "Cycles when PMH is busy with page walks",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM69",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_DURATION",
@@ -93,8 +75,6 @@
     },
     {
         "BriefDescription": "Store misses in all DTLB levels that cause pa=
ge walks",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM69",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.MISS_CAUSES_A_WALK",
@@ -104,8 +84,6 @@
     },
     {
         "BriefDescription": "Store operations that miss the first TLB leve=
l but hit the second and do not cause page walks.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.STLB_HIT",
         "SampleAfterValue": "100003",
@@ -113,8 +91,6 @@
     },
     {
         "BriefDescription": "Store misses that miss the  DTLB and hit the =
STLB (2M).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.STLB_HIT_2M",
         "SampleAfterValue": "100003",
@@ -122,8 +98,6 @@
     },
     {
         "BriefDescription": "Store misses that miss the  DTLB and hit the =
STLB (4K).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.STLB_HIT_4K",
         "SampleAfterValue": "100003",
@@ -131,8 +105,6 @@
     },
     {
         "BriefDescription": "Store misses in all DTLB levels that cause co=
mpleted page walks.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM69",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
@@ -141,8 +113,6 @@
     },
     {
         "BriefDescription": "Store misses in all DTLB levels that cause co=
mpleted page walks (1G)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM69",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_1G",
@@ -152,8 +122,6 @@
     },
     {
         "BriefDescription": "Store misses in all DTLB levels that cause co=
mpleted page walks (2M/4M)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM69",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
@@ -163,8 +131,6 @@
     },
     {
         "BriefDescription": "Store miss in all TLB levels causes a page wa=
lk that completes. (4K)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM69",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
@@ -174,8 +140,6 @@
     },
     {
         "BriefDescription": "Cycles when PMH is busy with page walks",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM69",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_DURATION",
@@ -185,8 +149,6 @@
     },
     {
         "BriefDescription": "Cycle count for an Extended Page table walk."=
,
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x4F",
         "EventName": "EPT.WALK_CYCLES",
         "PublicDescription": "This event counts cycles for an extended pag=
e table walk. The Extended Page directory cache differs from standard TLB c=
aches by the operating system that use it. Virtual machine operating system=
s use the extended page directory cache, while guest operating systems use =
the standard TLB caches.",
@@ -195,8 +157,6 @@
     },
     {
         "BriefDescription": "Flushing of the Instruction TLB (ITLB) pages,=
 includes 4k/2M/4M pages.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xAE",
         "EventName": "ITLB.ITLB_FLUSH",
         "PublicDescription": "This event counts the number of flushes of t=
he big or small ITLB pages. Counting include both TLB Flush (covering all s=
ets) and TLB Set Clear (set-specific).",
@@ -205,8 +165,6 @@
     },
     {
         "BriefDescription": "Misses at all ITLB levels that cause page wal=
ks",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM69",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.MISS_CAUSES_A_WALK",
@@ -216,8 +174,6 @@
     },
     {
         "BriefDescription": "Operations that miss the first ITLB level but=
 hit the second and do not cause any page walks.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.STLB_HIT",
         "SampleAfterValue": "100003",
@@ -225,8 +181,6 @@
     },
     {
         "BriefDescription": "Code misses that miss the  DTLB and hit the S=
TLB (2M).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.STLB_HIT_2M",
         "SampleAfterValue": "100003",
@@ -234,8 +188,6 @@
     },
     {
         "BriefDescription": "Core misses that miss the  DTLB and hit the S=
TLB (4K).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.STLB_HIT_4K",
         "SampleAfterValue": "100003",
@@ -243,8 +195,6 @@
     },
     {
         "BriefDescription": "Misses in all ITLB levels that cause complete=
d page walks.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM69",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
@@ -253,8 +203,6 @@
     },
     {
         "BriefDescription": "Store miss in all TLB levels causes a page wa=
lk that completes. (1G)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM69",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_1G",
@@ -264,8 +212,6 @@
     },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (2M/4M)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM69",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
@@ -275,8 +221,6 @@
     },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (4K)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM69",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
@@ -286,8 +230,6 @@
     },
     {
         "BriefDescription": "Cycles when PMH is busy with page walks",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM69",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_DURATION",
@@ -297,8 +239,6 @@
     },
     {
         "BriefDescription": "Number of DTLB page walker hits in the L1+FB.=
",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Errata": "BDM69, BDM98",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.DTLB_L1",
@@ -307,8 +247,6 @@
     },
     {
         "BriefDescription": "Number of DTLB page walker hits in the L2.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Errata": "BDM69, BDM98",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.DTLB_L2",
@@ -317,8 +255,6 @@
     },
     {
         "BriefDescription": "Number of DTLB page walker hits in the L3 + X=
SNP.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Errata": "BDM69, BDM98",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.DTLB_L3",
@@ -327,8 +263,6 @@
     },
     {
         "BriefDescription": "Number of DTLB page walker hits in Memory.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Errata": "BDM69, BDM98",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.DTLB_MEMORY",
@@ -337,8 +271,6 @@
     },
     {
         "BriefDescription": "Number of ITLB page walker hits in the L1+FB.=
",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Errata": "BDM69, BDM98",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.ITLB_L1",
@@ -347,8 +279,6 @@
     },
     {
         "BriefDescription": "Number of ITLB page walker hits in the L2.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Errata": "BDM69, BDM98",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.ITLB_L2",
@@ -357,8 +287,6 @@
     },
     {
         "BriefDescription": "Number of ITLB page walker hits in the L3 + X=
SNP.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Errata": "BDM69, BDM98",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.ITLB_L3",
@@ -367,8 +295,6 @@
     },
     {
         "BriefDescription": "DTLB flush attempts of the thread-specific en=
tries",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xBD",
         "EventName": "TLB_FLUSH.DTLB_THREAD",
         "PublicDescription": "This event counts the number of DTLB flush a=
ttempts of the thread-specific entries.",
@@ -377,8 +303,6 @@
     },
     {
         "BriefDescription": "STLB flush attempts",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xBD",
         "EventName": "TLB_FLUSH.STLB_ANY",
         "PublicDescription": "This event counts the number of any STLB flu=
sh attempts (such as entire, VPID, PCID, InvPage, CR3 write, and so on).",
--=20
2.39.0.314.g84b9a713c41-goog

