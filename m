Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB30964D6AB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 07:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiLOGuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 01:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiLOGui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:50:38 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2C65D6B4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:50:32 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b4-20020a253404000000b006fad1bb09f4so2672763yba.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6/8wMUX2QjpngNGG6D7SSP24AXagamu9614bOPdZyV4=;
        b=LHtqeKSS3sVxwaEO181Z43Z9iFnsEqhL6JsNCZMMHpbY/DNYNWbaJ/kkPJAJ2Se/OX
         mox6cnjWSBeTgOv+zYMaRQuIgoYHcYwb6zFnMSo+GFQ7luIc9hXWJHBgylbr/9u50Z1D
         YFHObYcvGBw56xBskaq4r/SNKGKyyY/dZIsU2Aj927TOcKoNATzvreoWzQ0z4xBe2jXD
         lfoA7EDL6RKze6zYHs95DTRiXO+Q6a/tHXoQHH63EYJ6xx5SPJOwRvGKunJt8RBldkUN
         1IQgeWUzLZmxMawcYP6cb3ZbNpk0pOJBngB0osAvrJV076bJ8UMPIDzCViZsp8zCE/An
         i6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/8wMUX2QjpngNGG6D7SSP24AXagamu9614bOPdZyV4=;
        b=HmZEuxagAwMtU1WZVpo1Pxpp0uWuiFTJgHCkwkwctTxU6n/U9fJ95sy8YQmIfFzW/e
         jpJibobePA5B1DpRKSSxoUAutKGE91UmW230qzo10i9hdTc0p8WHnCBYipqUstekx7Bo
         +A3X5eDNvoNzuzMRc+Sdiwg4ynWGBVGELQRkR0sOVhwDY4IGtMrdih3uBLXJFhtEUvqH
         CDJPjljhojS4dlWNJKHbnCtAKepIT7rKtWXyKmi74LRcYitvZ2/1Ib3vqY2dd4bm6Xfp
         Z6wNxd7yFzVwkcVWAt8uoKLE4o/jwfUvURQzIxU62p1Uf16M9pkdJOe5dhT0gda8FdRC
         tuDQ==
X-Gm-Message-State: ANoB5plWFWvr47tr83J0ui1ZCk2LRCny0qAuJsbHedG5H2zBr8jfnWPl
        3gyZ3Tzw8of7MRtEmHk8JIDZLjbNFN0P
X-Google-Smtp-Source: AA0mqf5pJtdCvZ7GkDwbb1uXQ1We6qNC3lT/JPqa2lgr/iF2C1zGIJzfIZEeUcI4yyfZ58k20s5p1cqvh0kh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c7dc:d96f:4f9:f59d])
 (user=irogers job=sendgmr) by 2002:a25:397:0:b0:728:996d:7d9a with SMTP id
 145-20020a250397000000b00728996d7d9amr2014670ybd.518.1671087031562; Wed, 14
 Dec 2022 22:50:31 -0800 (PST)
Date:   Wed, 14 Dec 2022 22:49:51 -0800
Message-Id: <20221215065017.1621020-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 06/32] perf vendor events intel: Refresh broadwellde
 metrics and events
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

Update the broadwellde metrics and events using the new tooling from:
https://github.com/intel/perfmon
The metrics vary as tma_false_sharing, MEM_Parallel_Requests and
MEM_Request_Latency are explicitly dropped from having missing events:
https://github.com/captain5050/perfmon/blob/main/scripts/create_perf_json.p=
y#L934
The formulas also differ due to parentheses, use of exponents and
removal of redundant operations like "* 1".  The events are unchanged
but unused json values are removed and implicit umasks of 0 are
dropped. This increases consistency across the json files.

mapfile.csv's version number is set to match that in the perfmon
repository.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/broadwellde/bdwde-metrics.json   | 143 +++---
 .../arch/x86/broadwellde/cache.json           | 153 ------
 .../arch/x86/broadwellde/floating-point.json  |  40 --
 .../arch/x86/broadwellde/frontend.json        |  56 --
 .../arch/x86/broadwellde/memory.json          |  86 ----
 .../arch/x86/broadwellde/other.json           |   8 -
 .../arch/x86/broadwellde/pipeline.json        | 272 ----------
 .../arch/x86/broadwellde/uncore-cache.json    | 414 ++-------------
 .../arch/x86/broadwellde/uncore-memory.json   | 477 +++---------------
 .../arch/x86/broadwellde/uncore-other.json    | 163 ++----
 .../arch/x86/broadwellde/uncore-power.json    |  57 ---
 .../arch/x86/broadwellde/virtual-memory.json  |  76 ---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 13 files changed, 211 insertions(+), 1736 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json =
b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
index 5a074cf7c77d..d35d30932b68 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
@@ -113,7 +113,7 @@
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
@@ -121,7 +121,7 @@
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
eculative path. Sample with: TOPDOWN.BR_MISPREDICT_SLOTS",
@@ -145,7 +145,7 @@
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
@@ -177,7 +177,7 @@
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
f what memory source satisfied them. Sample with: MEM_INST_RETIRED.LOCK_LOA=
DS_PS",
@@ -217,7 +217,7 @@
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
d increase performance. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS",
@@ -225,7 +225,7 @@
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
M_LOAD_L3_HIT_RETIRED.XSNP_FWD;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS",
@@ -233,7 +233,7 @@
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
AD_L3_HIT_RETIRED.XSNP_NO_FWD",
@@ -241,7 +241,7 @@
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
h its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS",
@@ -249,7 +249,7 @@
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
@@ -257,7 +257,7 @@
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
improve the latency and increase performance. Sample with: MEM_LOAD_RETIRED=
.L3_MISS_PS",
@@ -289,20 +289,12 @@
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
         "ScaleUnit": "100%"
     },
-    {
-        "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
-        "MetricExpr": "60 * OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_HITM =
/ CLKS",
-        "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_store_boun=
d_group",
-        "MetricName": "tma_false_sharing",
-        "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line.  Sample with: OCR.DEMAND_RFO.=
L3_HIT.SNOOP_HITM",
-        "ScaleUnit": "100%"
-    },
     {
         "BriefDescription": "This metric represents rate of split store ac=
cesses",
         "MetricExpr": "2 * MEM_UOPS_RETIRED.SPLIT_STORES / CORE_CLKS",
@@ -337,7 +329,7 @@
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
@@ -345,7 +337,7 @@
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
@@ -353,7 +345,7 @@
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
 assembly can be helpful. Sample with: EXE_ACTIVITY.1_PORTS_UTIL",
@@ -361,7 +353,7 @@
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
on the execution ports as multiple elements are calculated with same uop. S=
ample with: EXE_ACTIVITY.2_PORTS_UTIL",
@@ -369,7 +361,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ / 2) if #SM=
T_on else UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / CORE_CLKS",
+        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ / 2 if #SMT_=
on else UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / CORE_CLKS",
         "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
         "MetricName": "tma_ports_utilized_3m",
         "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 3 or more uops per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise). Sample with:=
 UOPS_EXECUTED.CYCLES_GE_3",
@@ -377,7 +369,7 @@
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
@@ -433,7 +425,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Store operations Sample with: U=
OPS_DISPATCHED.PORT_7_8",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_4 / CORE_CLKS",
+        "MetricExpr": "tma_port_4",
         "MetricGroup": "TopdownL5;tma_ports_utilized_3m_group",
         "MetricName": "tma_store_op_utilization",
         "ScaleUnit": "100%"
@@ -526,7 +518,7 @@
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
be avoided. Sample with: UOPS_RETIRED.MS",
@@ -599,26 +591,26 @@
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
@@ -660,13 +652,13 @@
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
@@ -719,7 +711,7 @@
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
@@ -731,13 +723,13 @@
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
@@ -749,68 +741,68 @@
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
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
         "MetricConstraint": "NO_NMI_WATCHDOG",
-        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK=
_DURATION + DTLB_STORE_MISSES.WALK_DURATION + 7 * ( DTLB_STORE_MISSES.WALK_=
COMPLETED + DTLB_LOAD_MISSES.WALK_COMPLETED + ITLB_MISSES.WALK_COMPLETED ) =
) / ( 2 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_T=
HREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ) if #core_wide < 1 else ( CPU_C=
LK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else CPU_CLK_UNHALTED.THREAD) )",
+        "MetricExpr": "(ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_=
DURATION + DTLB_STORE_MISSES.WALK_DURATION + 7 * (DTLB_STORE_MISSES.WALK_CO=
MPLETED + DTLB_LOAD_MISSES.WALK_COMPLETED + ITLB_MISSES.WALK_COMPLETED)) / =
(2 * CORE_CLKS)",
         "MetricGroup": "Mem;MemoryTLB",
         "MetricName": "Page_Walks_Utilization"
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
@@ -840,19 +832,19 @@
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
@@ -865,7 +857,7 @@
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
@@ -883,22 +875,10 @@
     },
     {
         "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
-        "MetricExpr": "64 * (arb@event\\=3D0x81\\,umask\\=3D0x1@ + arb@eve=
nt\\=3D0x84\\,umask\\=3D0x1@) / 1000000 / duration_time / 1000",
+        "MetricExpr": "64 * (arb@event\\=3D0x81\\,umask\\=3D0x1@ + arb@eve=
nt\\=3D0x84\\,umask\\=3D0x1@) / 1e6 / duration_time / 1e3",
         "MetricGroup": "HPC;Mem;MemoryBW;SoC",
         "MetricName": "DRAM_BW_Use"
     },
-    {
-        "BriefDescription": "Average latency of all requests to external m=
emory (in Uncore cycles)",
-        "MetricExpr": "UNC_ARB_TRK_OCCUPANCY.ALL / arb@event\\=3D0x81\\,um=
ask\\=3D0x1@",
-        "MetricGroup": "Mem;SoC",
-        "MetricName": "MEM_Request_Latency"
-    },
-    {
-        "BriefDescription": "Average number of parallel requests to extern=
al memory. Accounts for all requests",
-        "MetricExpr": "UNC_ARB_TRK_OCCUPANCY.ALL / arb@event\\=3D0x81\\,um=
ask\\=3D0x1@",
-        "MetricGroup": "Mem;SoC",
-        "MetricName": "MEM_Parallel_Requests"
-    },
     {
         "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
@@ -907,44 +887,51 @@
     },
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
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/cache.json b/tools/=
perf/pmu-events/arch/x86/broadwellde/cache.json
index 4b77181b2c53..fcc99fd22b0a 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/cache.json
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
         "PublicDescription": "This event counts the number of demand Data =
Read requests that hit L2 cache. Only not rejected loads are counted.",
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
and cross-core snoop hits in on-pkg core cache. (Precise Event - PEBS)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "BDM100",
         "EventCode": "0xD2",
@@ -387,8 +309,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were Hit=
M responses from shared L3. (Precise Event - PEBS)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "BDM100",
         "EventCode": "0xD2",
@@ -400,8 +320,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were L3 =
hit and cross-core snoop missed in on-pkg core cache. (Precise Event - PEBS=
)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "BDM100",
         "EventCode": "0xD2",
@@ -413,8 +331,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were hit=
s in L3 without snoops required. (Precise Event - PEBS)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "BDM100",
         "EventCode": "0xD2",
@@ -425,8 +341,6 @@
         "UMask": "0x8"
     },
     {
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "BDE70, BDM100",
         "EventCode": "0xD3",
@@ -438,8 +352,6 @@
     },
     {
         "BriefDescription": "Retired load uop whose Data Source was: remot=
e DRAM either Snoop not needed or Snoop Miss (RspI) (Precise Event)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "BDE70",
         "EventCode": "0xD3",
@@ -450,8 +362,6 @@
     },
     {
         "BriefDescription": "Retired load uop whose Data Source was: forwa=
rded from remote cache (Precise Event)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "BDE70",
         "EventCode": "0xD3",
@@ -462,8 +372,6 @@
     },
     {
         "BriefDescription": "Retired load uop whose Data Source was: Remot=
e cache HITM (Precise Event)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "BDE70",
         "EventCode": "0xD3",
@@ -474,8 +382,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were loa=
d uops missed L1 but hit FB due to preceding miss to the same cache line wi=
th data not ready. (Precise Event - PEBS)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.HIT_LFB",
@@ -486,8 +392,6 @@
     },
     {
         "BriefDescription": "Retired load uops with L1 cache hits as data =
sources. (Precise Event - PEBS)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_HIT",
@@ -498,8 +402,6 @@
     },
     {
         "BriefDescription": "Retired load uops misses in L1 cache as data =
sources. Uses PEBS.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_MISS",
@@ -510,8 +412,6 @@
     },
     {
         "BriefDescription": "Retired load uops with L2 cache hits as data =
sources. (Precise Event - PEBS)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "BDM35",
         "EventCode": "0xD1",
@@ -523,8 +423,6 @@
     },
     {
         "BriefDescription": "Retired load uops with L2 cache misses as dat=
a sources. Uses PEBS.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_MISS",
@@ -535,8 +433,6 @@
     },
     {
         "BriefDescription": "Hit in last-level (L3) cache. Excludes Unknow=
n data-source. (Precise Event - PEBS)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "BDM100",
         "EventCode": "0xD1",
@@ -548,8 +444,6 @@
     },
     {
         "BriefDescription": "Miss in last-level (L3) cache. Excludes Unkno=
wn data-source. (Precise Event - PEBS).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "BDM100, BDE70",
         "EventCode": "0xD1",
@@ -560,8 +454,6 @@
     },
     {
         "BriefDescription": "All retired load uops. (Precise Event - PEBS)=
",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
@@ -572,12 +464,9 @@
     },
     {
         "BriefDescription": "Retired store uops that split across a cachel=
ine boundary. (Precise Event - PEBS)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
-        "L1_Hit_Indication": "1",
         "PEBS": "1",
         "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts store uops retired to the architected path with=
 a filter on bits 0 and 1 applied.\nNote: This event ?ounts AVX-256bit load=
/store double-pump memory uops as a single uop at retirement.",
         "SampleAfterValue": "2000003",
@@ -585,8 +474,6 @@
     },
     {
         "BriefDescription": "Retired load uops with locked access. (Precis=
e Event - PEBS)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "BDM35",
         "EventCode": "0xD0",
@@ -598,8 +485,6 @@
     },
     {
         "BriefDescription": "Retired load uops that split across a cacheli=
ne boundary.(Precise Event - PEBS)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
@@ -610,12 +495,9 @@
     },
     {
         "BriefDescription": "Retired store uops that split across a cachel=
ine boundary. (Precise Event - PEBS)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
-        "L1_Hit_Indication": "1",
         "PEBS": "1",
         "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts line-splitted store uops retired to the archite=
cted path. A line split is across 64B cache-line which includes a page spli=
t (4K).",
         "SampleAfterValue": "100003",
@@ -623,8 +505,6 @@
     },
     {
         "BriefDescription": "Retired load uops that miss the STLB. (Precis=
e Event - PEBS)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.STLB_MISS_LOADS",
@@ -635,12 +515,9 @@
     },
     {
         "BriefDescription": "Retired store uops that miss the STLB. (Preci=
se Event - PEBS)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.STLB_MISS_STORES",
-        "L1_Hit_Indication": "1",
         "PEBS": "1",
         "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts store uops true STLB miss retired to the archit=
ected path. True STLB miss is an uop triggering page walk that gets complet=
ed without blocks, and later gets retired. This page walk can end up with o=
r without a fault.",
         "SampleAfterValue": "100003",
@@ -648,8 +525,6 @@
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
@@ -658,8 +533,6 @@
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
@@ -668,8 +541,6 @@
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
@@ -678,8 +549,6 @@
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
@@ -688,8 +557,6 @@
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
@@ -698,8 +565,6 @@
     },
     {
         "BriefDescription": "Offcore outstanding cacheable Core Data Read =
transactions in SuperQueue (SQ), queue to uncore",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM76",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD",
@@ -709,8 +574,6 @@
     },
     {
         "BriefDescription": "Cycles when offcore outstanding cacheable Cor=
e Data Read transactions are present in SuperQueue (SQ), queue to uncore",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "Errata": "BDM76",
         "EventCode": "0x60",
@@ -721,8 +584,6 @@
     },
     {
         "BriefDescription": "Cycles when offcore outstanding Demand Data R=
ead transactions are present in SuperQueue (SQ), queue to uncore",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "Errata": "BDM76",
         "EventCode": "0x60",
@@ -733,8 +594,6 @@
     },
     {
         "BriefDescription": "Offcore outstanding demand rfo reads transact=
ions in SuperQueue (SQ), queue to uncore, every cycle",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "Errata": "BDM76",
         "EventCode": "0x60",
@@ -745,8 +604,6 @@
     },
     {
         "BriefDescription": "Offcore outstanding code reads transactions i=
n SuperQueue (SQ), queue to uncore, every cycle",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM76",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_CODE_RD",
@@ -756,8 +613,6 @@
     },
     {
         "BriefDescription": "Offcore outstanding Demand Data Read transact=
ions in uncore queue.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM76",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD",
@@ -767,8 +622,6 @@
     },
     {
         "BriefDescription": "Cycles with at least 6 offcore outstanding De=
mand Data Read transactions in uncore queue.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "6",
         "Errata": "BDM76",
         "EventCode": "0x60",
@@ -778,8 +631,6 @@
     },
     {
         "BriefDescription": "Offcore outstanding RFO store transactions in=
 SuperQueue (SQ), queue to uncore",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "BDM76",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_RFO",
@@ -789,8 +640,6 @@
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
@@ -798,8 +647,6 @@
     },
     {
         "BriefDescription": "Split locks in SQ",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xf4",
         "EventName": "SQ_MISC.SPLIT_LOCK",
         "PublicDescription": "This event counts the number of split locks =
in the super queue.",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/floating-point.json=
 b/tools/perf/pmu-events/arch/x86/broadwellde/floating-point.json
index 46cf18490140..0b3f026158e2 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/floating-point.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d double precision floating-point instructions retired.  Each count represe=
nts 2 computations. Applies to SSE* and AVX* packed double precision floati=
ng-point instructions: ADD SUB MUL DIV MIN MAX SQRT DPP FM(N)ADD/SUB.  DPP =
and FM(N)ADD/SUB instructions count twice as they perform multiple calculat=
ions per element.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xC7",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE",
         "SampleAfterValue": "2000003",
@@ -10,8 +8,6 @@
     },
     {
         "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d single precision floating-point instructions retired.  Each count represe=
nts 4 computations. Applies to SSE* and AVX* packed single precision floati=
ng-point instructions: ADD SUB MUL DIV MIN MAX RCP RSQRT SQRT DPP FM(N)ADD/=
SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform multipl=
e calculations per element.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xC7",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE",
         "SampleAfterValue": "2000003",
@@ -19,8 +15,6 @@
     },
     {
         "BriefDescription": "Number of SSE/AVX computational 256-bit packe=
d double precision floating-point instructions retired.  Each count represe=
nts 4 computations. Applies to SSE* and AVX* packed double precision floati=
ng-point instructions: ADD SUB MUL DIV MIN MAX SQRT DPP FM(N)ADD/SUB.  DPP =
and FM(N)ADD/SUB instructions count twice as they perform multiple calculat=
ions per element.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xC7",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE",
         "SampleAfterValue": "2000003",
@@ -28,8 +22,6 @@
     },
     {
         "BriefDescription": "Number of SSE/AVX computational 256-bit packe=
d single precision floating-point instructions retired.  Each count represe=
nts 8 computations. Applies to SSE* and AVX* packed single precision floati=
ng-point instructions: ADD SUB MUL DIV MIN MAX RCP RSQRT SQRT DPP FM(N)ADD/=
SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform multipl=
e calculations per element.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE",
         "SampleAfterValue": "2000003",
@@ -37,8 +29,6 @@
     },
     {
         "BriefDescription": "Number of SSE/AVX computational double precis=
ion floating-point instructions retired. Applies to SSE* and AVX*scalar, do=
uble and single precision floating-point: ADD SUB MUL DIV MIN MAX SQRT DPP =
FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perfor=
m multiple calculations per element.  ?.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xC7",
         "EventName": "FP_ARITH_INST_RETIRED.DOUBLE",
         "SampleAfterValue": "2000006",
@@ -46,8 +36,6 @@
     },
     {
         "BriefDescription": "Number of SSE/AVX computational packed floati=
ng-point instructions retired. Applies to SSE* and AVX*, packed, double and=
 single precision floating-point: ADD SUB MUL DIV MIN MAX RSQRT RCP SQRT DP=
P FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perf=
orm multiple calculations per element.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xC7",
         "EventName": "FP_ARITH_INST_RETIRED.PACKED",
         "SampleAfterValue": "2000004",
@@ -55,8 +43,6 @@
     },
     {
         "BriefDescription": "Number of SSE/AVX computational scalar floati=
ng-point instructions retired. Applies to SSE* and AVX* scalar, double and =
single precision floating-point: ADD SUB MUL DIV MIN MAX RSQRT RCP SQRT FM(=
N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform multiple c=
alculations per element.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xC7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR",
         "SampleAfterValue": "2000003",
@@ -64,8 +50,6 @@
     },
     {
         "BriefDescription": "Number of SSE/AVX computational scalar double=
 precision floating-point instructions retired.  Each count represents 1 co=
mputation. Applies to SSE* and AVX* scalar double precision floating-point =
instructions: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB inst=
ructions count twice as they perform multiple calculations per element.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xC7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR_DOUBLE",
         "SampleAfterValue": "2000003",
@@ -73,8 +57,6 @@
     },
     {
         "BriefDescription": "Number of SSE/AVX computational scalar single=
 precision floating-point instructions retired.  Each count represents 1 co=
mputation. Applies to SSE* and AVX* scalar single precision floating-point =
instructions: ADD SUB MUL DIV MIN MAX RCP RSQRT SQRT FM(N)ADD/SUB.  FM(N)AD=
D/SUB instructions count twice as they perform multiple calculations per el=
ement.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xC7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR_SINGLE",
         "SampleAfterValue": "2000003",
@@ -82,8 +64,6 @@
     },
     {
         "BriefDescription": "Number of SSE/AVX computational single precis=
ion floating-point instructions retired. Applies to SSE* and AVX*scalar, do=
uble and single precision floating-point: ADD SUB MUL DIV MIN MAX RCP RSQRT=
 SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as t=
hey perform multiple calculations per element. ?.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xC7",
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
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/frontend.json b/too=
ls/perf/pmu-events/arch/x86/broadwellde/frontend.json
index 37ce8034b2ed..d0f6678609ae 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/frontend.json
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
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/memory.json b/tools=
/perf/pmu-events/arch/x86/broadwellde/memory.json
index a3a5cc6dab42..12cc384d7f18 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/memory.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/memory.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Number of times HLE abort was triggered (PEBS=
)",
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
         "BriefDescription": "Loads with latency value being above 128",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "Errata": "BDM100, BDM35",
         "EventCode": "0xCD",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
@@ -102,13 +82,10 @@
         "PEBS": "2",
         "PublicDescription": "This event counts loads with latency value b=
eing above 128.",
         "SampleAfterValue": "1009",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Loads with latency value being above 16",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "Errata": "BDM100, BDM35",
         "EventCode": "0xCD",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
@@ -117,13 +94,10 @@
         "PEBS": "2",
         "PublicDescription": "This event counts loads with latency value b=
eing above 16.",
         "SampleAfterValue": "20011",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Loads with latency value being above 256",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "Errata": "BDM100, BDM35",
         "EventCode": "0xCD",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
@@ -132,13 +106,10 @@
         "PEBS": "2",
         "PublicDescription": "This event counts loads with latency value b=
eing above 256.",
         "SampleAfterValue": "503",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Loads with latency value being above 32",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "Errata": "BDM100, BDM35",
         "EventCode": "0xCD",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
@@ -147,13 +118,10 @@
         "PEBS": "2",
         "PublicDescription": "This event counts loads with latency value b=
eing above 32.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Loads with latency value being above 4",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "Errata": "BDM100, BDM35",
         "EventCode": "0xCD",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
@@ -162,13 +130,10 @@
         "PEBS": "2",
         "PublicDescription": "This event counts loads with latency value b=
eing above four.",
         "SampleAfterValue": "100003",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Loads with latency value being above 512",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "Errata": "BDM100, BDM35",
         "EventCode": "0xCD",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
@@ -177,13 +142,10 @@
         "PEBS": "2",
         "PublicDescription": "This event counts loads with latency value b=
eing above 512.",
         "SampleAfterValue": "101",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Loads with latency value being above 64",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "Errata": "BDM100, BDM35",
         "EventCode": "0xCD",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
@@ -192,13 +154,10 @@
         "PEBS": "2",
         "PublicDescription": "This event counts loads with latency value b=
eing above 64.",
         "SampleAfterValue": "2003",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Loads with latency value being above 8",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "Errata": "BDM100, BDM35",
         "EventCode": "0xCD",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
@@ -207,13 +166,10 @@
         "PEBS": "2",
         "PublicDescription": "This event counts loads with latency value b=
eing above eight.",
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
@@ -222,8 +178,6 @@
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
@@ -232,8 +186,6 @@
     },
     {
         "BriefDescription": "Number of times RTM abort was triggered (PEBS=
)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED",
         "PEBS": "1",
@@ -243,8 +195,6 @@
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
@@ -253,8 +203,6 @@
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
@@ -263,8 +211,6 @@
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
@@ -273,8 +219,6 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to incompatible memory type",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_MISC4",
         "PublicDescription": "Number of times a RTM caused a fault.",
@@ -283,8 +227,6 @@
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
@@ -293,8 +235,6 @@
     },
     {
         "BriefDescription": "Number of times RTM commit succeeded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.COMMIT",
         "PublicDescription": "Number of times RTM commit succeeded.",
@@ -303,8 +243,6 @@
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
@@ -313,8 +251,6 @@
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
@@ -322,8 +258,6 @@
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
@@ -332,8 +266,6 @@
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
@@ -342,8 +274,6 @@
     },
     {
         "BriefDescription": "Counts the number of times a XBEGIN instructi=
on was executed inside an HLE transactional region.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5d",
         "EventName": "TX_EXEC.MISC4",
         "PublicDescription": "RTM region detected inside HLE.",
@@ -352,8 +282,6 @@
     },
     {
         "BriefDescription": "Counts the number of times an HLE XACQUIRE in=
struction was executed inside an RTM transactional region.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5d",
         "EventName": "TX_EXEC.MISC5",
         "SampleAfterValue": "2000003",
@@ -361,8 +289,6 @@
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
@@ -371,8 +297,6 @@
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
@@ -381,8 +305,6 @@
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
@@ -391,8 +313,6 @@
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
@@ -401,8 +321,6 @@
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
@@ -411,8 +329,6 @@
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
@@ -421,8 +337,6 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/other.json b/tools/=
perf/pmu-events/arch/x86/broadwellde/other.json
index 917d145d5227..1c2a5b001949 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/other.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/other.json
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
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/broadwellde/pipeline.json
index 85654037b768..9e7d66b07f01 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
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
         "BriefDescription": "Conditional branch instructions retired. (Pre=
cise Event - PEBS)",
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
tired. (Precise Event - PEBS)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
         "PEBS": "1",
@@ -195,8 +157,6 @@
     },
     {
         "BriefDescription": "Direct and indirect macro near call instructi=
ons retired (captured in ring 3). (Precise Event - PEBS)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL_R3",
         "PEBS": "1",
@@ -206,8 +166,6 @@
     },
     {
         "BriefDescription": "Return instructions retired. (Precise Event -=
 PEBS)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
         "PEBS": "1",
@@ -217,8 +175,6 @@
     },
     {
         "BriefDescription": "Taken branch instructions retired. (Precise E=
vent - PEBS)",
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
retired. (Precise Event - PEBS)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.CONDITIONAL",
         "PEBS": "1",
@@ -348,8 +280,6 @@
     },
     {
         "BriefDescription": "number of near branch instructions retired th=
at were mispredicted and taken. (Precise Event - PEBS).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
         "PEBS": "1",
@@ -359,8 +289,6 @@
     },
     {
         "BriefDescription": "This event counts the number of mispredicted =
ret instructions retired.(Precise Event)",
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
         "SampleAfterValue": "2000003",
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
         "SampleAfterValue": "2000003",
@@ -399,8 +321,6 @@
     },
     {
         "BriefDescription": "Count XClk pulses when this thread is unhalte=
d and the other thread is halted.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
         "SampleAfterValue": "2000003",
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
         "SampleAfterValue": "2000003",
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
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.ANY",
         "PublicDescription": "This event counts resource-related stall cyc=
les. Reasons for stalls can be as follows:\n - *any* u-arch structure got f=
ull (LB, SB, RS, ROB, BOB, LM, Physical Register Reclaim Table (PRRT), or P=
hysical History Table (PHT) slots)\n - *any* u-arch structure got empty (li=
ke INT/SIMD FreeLists)\n - FPU control word (FPCW), MXCSR\nand others. This=
 counts cycles that the pipeline backend blocked uop delivery from the fron=
t end.",
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
         "BriefDescription": "Actually retired uops. (Precise Event - PEBS)=
",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.ALL",
@@ -1345,8 +1079,6 @@
     },
     {
         "BriefDescription": "Retirement slots used. (Precise Event - PEBS)=
",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.RETIRE_SLOTS",
         "PEBS": "1",
@@ -1356,8 +1088,6 @@
     },
     {
         "BriefDescription": "Cycles without actually retired uops.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.STALL_CYCLES",
@@ -1368,8 +1098,6 @@
     },
     {
         "BriefDescription": "Cycles with less than 10 actually retired uop=
s.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "10",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.TOTAL_CYCLES",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json b=
/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
index c4d154944ab6..b8c9845308b2 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "Bounce Control",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA",
         "EventName": "UNC_C_BOUNCE_CONTROL",
         "PerPkg": "1",
@@ -9,14 +8,12 @@
     },
     {
         "BriefDescription": "Uncore Clocks",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_C_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "Counter 0 Occupancy",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1F",
         "EventName": "UNC_C_COUNTER0_OCCUPANCY",
         "PerPkg": "1",
@@ -25,7 +22,6 @@
     },
     {
         "BriefDescription": "FaST wire asserted",
-        "Counter": "0,1",
         "EventCode": "0x9",
         "EventName": "UNC_C_FAST_ASSERTED",
         "PerPkg": "1",
@@ -34,7 +30,6 @@
     },
     {
         "BriefDescription": "Cache Lookups; Any Request",
-        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.ANY",
         "PerPkg": "1",
@@ -44,7 +39,6 @@
     },
     {
         "BriefDescription": "Cache Lookups; Data Read Request",
-        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.DATA_READ",
         "PerPkg": "1",
@@ -54,7 +48,6 @@
     },
     {
         "BriefDescription": "Cache Lookups; Lookups that Match NID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.NID",
         "PerPkg": "1",
@@ -64,7 +57,6 @@
     },
     {
         "BriefDescription": "Cache Lookups; Any Read Request",
-        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.READ",
         "PerPkg": "1",
@@ -74,7 +66,6 @@
     },
     {
         "BriefDescription": "Cache Lookups; External Snoop Request",
-        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.REMOTE_SNOOP",
         "PerPkg": "1",
@@ -84,7 +75,6 @@
     },
     {
         "BriefDescription": "Cache Lookups; Write Requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.WRITE",
         "PerPkg": "1",
@@ -94,7 +84,6 @@
     },
     {
         "BriefDescription": "Lines Victimized; Lines in E state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_C_LLC_VICTIMS.E_STATE",
         "PerPkg": "1",
@@ -104,7 +93,6 @@
     },
     {
         "BriefDescription": "Lines Victimized",
-        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_C_LLC_VICTIMS.F_STATE",
         "PerPkg": "1",
@@ -114,7 +102,6 @@
     },
     {
         "BriefDescription": "Lines Victimized; Lines in S State",
-        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_C_LLC_VICTIMS.I_STATE",
         "PerPkg": "1",
@@ -124,7 +111,6 @@
     },
     {
         "BriefDescription": "Lines Victimized",
-        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_C_LLC_VICTIMS.MISS",
         "PerPkg": "1",
@@ -134,7 +120,6 @@
     },
     {
         "BriefDescription": "Lines Victimized; Lines in M state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_C_LLC_VICTIMS.M_STATE",
         "PerPkg": "1",
@@ -144,7 +129,6 @@
     },
     {
         "BriefDescription": "Lines Victimized; Victimized Lines that Match=
 NID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_C_LLC_VICTIMS.NID",
         "PerPkg": "1",
@@ -154,7 +138,6 @@
     },
     {
         "BriefDescription": "Cbo Misc; DRd hitting non-M with raw CV=3D0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_C_MISC.CVZERO_PREFETCH_MISS",
         "PerPkg": "1",
@@ -164,7 +147,6 @@
     },
     {
         "BriefDescription": "Cbo Misc; Clean Victim with raw CV=3D0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_C_MISC.CVZERO_PREFETCH_VICTIM",
         "PerPkg": "1",
@@ -174,7 +156,6 @@
     },
     {
         "BriefDescription": "Cbo Misc; RFO HitS",
-        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_C_MISC.RFO_HIT_S",
         "PerPkg": "1",
@@ -184,7 +165,6 @@
     },
     {
         "BriefDescription": "Cbo Misc; Silent Snoop Eviction",
-        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_C_MISC.RSPI_WAS_FSE",
         "PerPkg": "1",
@@ -194,7 +174,6 @@
     },
     {
         "BriefDescription": "Cbo Misc",
-        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_C_MISC.STARTED",
         "PerPkg": "1",
@@ -204,7 +183,6 @@
     },
     {
         "BriefDescription": "Cbo Misc; Write Combining Aliasing",
-        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_C_MISC.WC_ALIASING",
         "PerPkg": "1",
@@ -214,7 +192,6 @@
     },
     {
         "BriefDescription": "LRU Queue; LRU Age 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "UNC_C_QLRU.AGE0",
         "PerPkg": "1",
@@ -224,7 +201,6 @@
     },
     {
         "BriefDescription": "LRU Queue; LRU Age 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "UNC_C_QLRU.AGE1",
         "PerPkg": "1",
@@ -234,7 +210,6 @@
     },
     {
         "BriefDescription": "LRU Queue; LRU Age 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "UNC_C_QLRU.AGE2",
         "PerPkg": "1",
@@ -244,7 +219,6 @@
     },
     {
         "BriefDescription": "LRU Queue; LRU Age 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "UNC_C_QLRU.AGE3",
         "PerPkg": "1",
@@ -254,7 +228,6 @@
     },
     {
         "BriefDescription": "LRU Queue; LRU Bits Decremented",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "UNC_C_QLRU.LRU_DECREMENT",
         "PerPkg": "1",
@@ -264,7 +237,6 @@
     },
     {
         "BriefDescription": "LRU Queue; Non-0 Aged Victim",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "UNC_C_QLRU.VICTIM_NON_ZERO",
         "PerPkg": "1",
@@ -274,27 +246,24 @@
     },
     {
         "BriefDescription": "AD Ring In Use; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1B",
         "EventName": "UNC_C_RING_AD_USED.ALL",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "AD Ring In Use; Down",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1B",
         "EventName": "UNC_C_RING_AD_USED.CCW",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "AD Ring In Use; Up",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1B",
         "EventName": "UNC_C_RING_AD_USED.CW",
         "PerPkg": "1",
@@ -304,7 +273,6 @@
     },
     {
         "BriefDescription": "AD Ring In Use; Down and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1B",
         "EventName": "UNC_C_RING_AD_USED.DOWN_EVEN",
         "PerPkg": "1",
@@ -314,7 +282,6 @@
     },
     {
         "BriefDescription": "AD Ring In Use; Down and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1B",
         "EventName": "UNC_C_RING_AD_USED.DOWN_ODD",
         "PerPkg": "1",
@@ -324,7 +291,6 @@
     },
     {
         "BriefDescription": "AD Ring In Use; Up and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1B",
         "EventName": "UNC_C_RING_AD_USED.UP_EVEN",
         "PerPkg": "1",
@@ -334,7 +300,6 @@
     },
     {
         "BriefDescription": "AD Ring In Use; Up and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1B",
         "EventName": "UNC_C_RING_AD_USED.UP_ODD",
         "PerPkg": "1",
@@ -344,27 +309,24 @@
     },
     {
         "BriefDescription": "AK Ring In Use; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_C_RING_AK_USED.ALL",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "AK Ring In Use; Down",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_C_RING_AK_USED.CCW",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "AK Ring In Use; Up",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_C_RING_AK_USED.CW",
         "PerPkg": "1",
@@ -374,7 +336,6 @@
     },
     {
         "BriefDescription": "AK Ring In Use; Down and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_C_RING_AK_USED.DOWN_EVEN",
         "PerPkg": "1",
@@ -384,7 +345,6 @@
     },
     {
         "BriefDescription": "AK Ring In Use; Down and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_C_RING_AK_USED.DOWN_ODD",
         "PerPkg": "1",
@@ -394,7 +354,6 @@
     },
     {
         "BriefDescription": "AK Ring In Use; Up and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_C_RING_AK_USED.UP_EVEN",
         "PerPkg": "1",
@@ -404,7 +363,6 @@
     },
     {
         "BriefDescription": "AK Ring In Use; Up and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_C_RING_AK_USED.UP_ODD",
         "PerPkg": "1",
@@ -414,27 +372,24 @@
     },
     {
         "BriefDescription": "BL Ring in Use; Down",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1D",
         "EventName": "UNC_C_RING_BL_USED.ALL",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "BL Ring in Use; Down",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1D",
         "EventName": "UNC_C_RING_BL_USED.CCW",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "BL Ring in Use; Up",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1D",
         "EventName": "UNC_C_RING_BL_USED.CW",
         "PerPkg": "1",
@@ -444,7 +399,6 @@
     },
     {
         "BriefDescription": "BL Ring in Use; Down and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1D",
         "EventName": "UNC_C_RING_BL_USED.DOWN_EVEN",
         "PerPkg": "1",
@@ -454,7 +408,6 @@
     },
     {
         "BriefDescription": "BL Ring in Use; Down and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1D",
         "EventName": "UNC_C_RING_BL_USED.DOWN_ODD",
         "PerPkg": "1",
@@ -464,7 +417,6 @@
     },
     {
         "BriefDescription": "BL Ring in Use; Up and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1D",
         "EventName": "UNC_C_RING_BL_USED.UP_EVEN",
         "PerPkg": "1",
@@ -474,7 +426,6 @@
     },
     {
         "BriefDescription": "BL Ring in Use; Up and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1D",
         "EventName": "UNC_C_RING_BL_USED.UP_ODD",
         "PerPkg": "1",
@@ -484,7 +435,6 @@
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; AD",
-        "Counter": "0,1,2,3",
         "EventCode": "0x5",
         "EventName": "UNC_C_RING_BOUNCES.AD",
         "PerPkg": "1",
@@ -493,7 +443,6 @@
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; AK",
-        "Counter": "0,1,2,3",
         "EventCode": "0x5",
         "EventName": "UNC_C_RING_BOUNCES.AK",
         "PerPkg": "1",
@@ -502,7 +451,6 @@
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; BL",
-        "Counter": "0,1,2,3",
         "EventCode": "0x5",
         "EventName": "UNC_C_RING_BOUNCES.BL",
         "PerPkg": "1",
@@ -511,7 +459,6 @@
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Snoops of processor's cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x5",
         "EventName": "UNC_C_RING_BOUNCES.IV",
         "PerPkg": "1",
@@ -520,37 +467,33 @@
     },
     {
         "BriefDescription": "BL Ring in Use; Any",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1E",
         "EventName": "UNC_C_RING_IV_USED.ANY",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  There is only 1 IV ring in BDX  Therefore, if=
 one wants to monitor the Even ring, they should select both UP_EVEN and DN=
_EVEN.  To monitor the Odd ring, they should select both UP_ODD and DN_ODD.=
; Filters any polarity",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "BL Ring in Use; Any",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1E",
         "EventName": "UNC_C_RING_IV_USED.DN",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  There is only 1 IV ring in BDX  Therefore, if=
 one wants to monitor the Even ring, they should select both UP_EVEN and DN=
_EVEN.  To monitor the Odd ring, they should select both UP_ODD and DN_ODD.=
; Filters any polarity",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "BL Ring in Use; Down",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1E",
         "EventName": "UNC_C_RING_IV_USED.DOWN",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  There is only 1 IV ring in BDX  Therefore, if=
 one wants to monitor the Even ring, they should select both UP_EVEN and DN=
_EVEN.  To monitor the Odd ring, they should select both UP_ODD and DN_ODD.=
; Filters for Down polarity",
-        "UMask": "0xCC",
+        "UMask": "0xcc",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "BL Ring in Use; Any",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1E",
         "EventName": "UNC_C_RING_IV_USED.UP",
         "PerPkg": "1",
@@ -560,7 +503,6 @@
     },
     {
         "BriefDescription": "AD",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6",
         "EventName": "UNC_C_RING_SINK_STARVED.AD",
         "PerPkg": "1",
@@ -569,7 +511,6 @@
     },
     {
         "BriefDescription": "AK",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6",
         "EventName": "UNC_C_RING_SINK_STARVED.AK",
         "PerPkg": "1",
@@ -578,7 +519,6 @@
     },
     {
         "BriefDescription": "BL",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6",
         "EventName": "UNC_C_RING_SINK_STARVED.BL",
         "PerPkg": "1",
@@ -587,7 +527,6 @@
     },
     {
         "BriefDescription": "IV",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6",
         "EventName": "UNC_C_RING_SINK_STARVED.IV",
         "PerPkg": "1",
@@ -596,7 +535,6 @@
     },
     {
         "BriefDescription": "Number of cycles the Cbo is actively throttli=
ng traffic onto the Ring in order to limit bounce traffic.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_C_RING_SRC_THRTL",
         "PerPkg": "1",
@@ -604,7 +542,6 @@
     },
     {
         "BriefDescription": "Ingress Arbiter Blocking Cycles; IRQ",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "UNC_C_RxR_EXT_STARVED.IPQ",
         "PerPkg": "1",
@@ -614,7 +551,6 @@
     },
     {
         "BriefDescription": "Ingress Arbiter Blocking Cycles; IPQ",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "UNC_C_RxR_EXT_STARVED.IRQ",
         "PerPkg": "1",
@@ -624,7 +560,6 @@
     },
     {
         "BriefDescription": "Ingress Arbiter Blocking Cycles; ISMQ_BID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "UNC_C_RxR_EXT_STARVED.ISMQ_BIDS",
         "PerPkg": "1",
@@ -634,7 +569,6 @@
     },
     {
         "BriefDescription": "Ingress Arbiter Blocking Cycles; PRQ",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "UNC_C_RxR_EXT_STARVED.PRQ",
         "PerPkg": "1",
@@ -644,7 +578,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; IPQ",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_C_RxR_INSERTS.IPQ",
         "PerPkg": "1",
@@ -654,7 +587,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; IRQ",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_C_RxR_INSERTS.IRQ",
         "PerPkg": "1",
@@ -664,7 +596,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; IRQ Rejected",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_C_RxR_INSERTS.IRQ_REJ",
         "PerPkg": "1",
@@ -674,7 +605,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; PRQ",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_C_RxR_INSERTS.PRQ",
         "PerPkg": "1",
@@ -684,7 +614,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; PRQ",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_C_RxR_INSERTS.PRQ_REJ",
         "PerPkg": "1",
@@ -694,7 +623,6 @@
     },
     {
         "BriefDescription": "Ingress Internal Starvation Cycles; IPQ",
-        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_C_RxR_INT_STARVED.IPQ",
         "PerPkg": "1",
@@ -704,7 +632,6 @@
     },
     {
         "BriefDescription": "Ingress Internal Starvation Cycles; IRQ",
-        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_C_RxR_INT_STARVED.IRQ",
         "PerPkg": "1",
@@ -714,7 +641,6 @@
     },
     {
         "BriefDescription": "Ingress Internal Starvation Cycles; ISMQ",
-        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_C_RxR_INT_STARVED.ISMQ",
         "PerPkg": "1",
@@ -724,7 +650,6 @@
     },
     {
         "BriefDescription": "Ingress Internal Starvation Cycles; PRQ",
-        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_C_RxR_INT_STARVED.PRQ",
         "PerPkg": "1",
@@ -734,7 +659,6 @@
     },
     {
         "BriefDescription": "Probe Queue Retries; Address Conflict",
-        "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "UNC_C_RxR_IPQ_RETRY.ADDR_CONFLICT",
         "PerPkg": "1",
@@ -744,7 +668,6 @@
     },
     {
         "BriefDescription": "Probe Queue Retries; Any Reject",
-        "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "UNC_C_RxR_IPQ_RETRY.ANY",
         "PerPkg": "1",
@@ -754,7 +677,6 @@
     },
     {
         "BriefDescription": "Probe Queue Retries; No Egress Credits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "UNC_C_RxR_IPQ_RETRY.FULL",
         "PerPkg": "1",
@@ -764,7 +686,6 @@
     },
     {
         "BriefDescription": "Probe Queue Retries; No QPI Credits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "UNC_C_RxR_IPQ_RETRY.QPI_CREDITS",
         "PerPkg": "1",
@@ -774,7 +695,6 @@
     },
     {
         "BriefDescription": "Probe Queue Retries; No AD Sbo Credits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_C_RxR_IPQ_RETRY2.AD_SBO",
         "PerPkg": "1",
@@ -784,7 +704,6 @@
     },
     {
         "BriefDescription": "Probe Queue Retries; Target Node Filter",
-        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_C_RxR_IPQ_RETRY2.TARGET",
         "PerPkg": "1",
@@ -794,7 +713,6 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; Address Confli=
ct",
-        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_C_RxR_IRQ_RETRY.ADDR_CONFLICT",
         "PerPkg": "1",
@@ -804,7 +722,6 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; Any Reject",
-        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_C_RxR_IRQ_RETRY.ANY",
         "PerPkg": "1",
@@ -814,7 +731,6 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No Egress Cred=
its",
-        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_C_RxR_IRQ_RETRY.FULL",
         "PerPkg": "1",
@@ -824,7 +740,6 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No IIO Credits=
",
-        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_C_RxR_IRQ_RETRY.IIO_CREDITS",
         "PerPkg": "1",
@@ -834,7 +749,6 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_C_RxR_IRQ_RETRY.NID",
         "PerPkg": "1",
@@ -844,7 +758,6 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No QPI Credits=
",
-        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_C_RxR_IRQ_RETRY.QPI_CREDITS",
         "PerPkg": "1",
@@ -854,7 +767,6 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No RTIDs",
-        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_C_RxR_IRQ_RETRY.RTID",
         "PerPkg": "1",
@@ -864,7 +776,6 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No AD Sbo Cred=
its",
-        "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_C_RxR_IRQ_RETRY2.AD_SBO",
         "PerPkg": "1",
@@ -874,7 +785,6 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No BL Sbo Cred=
its",
-        "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_C_RxR_IRQ_RETRY2.BL_SBO",
         "PerPkg": "1",
@@ -884,7 +794,6 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; Target Node Fi=
lter",
-        "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_C_RxR_IRQ_RETRY2.TARGET",
         "PerPkg": "1",
@@ -894,7 +803,6 @@
     },
     {
         "BriefDescription": "ISMQ Retries; Any Reject",
-        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_C_RxR_ISMQ_RETRY.ANY",
         "PerPkg": "1",
@@ -904,7 +812,6 @@
     },
     {
         "BriefDescription": "ISMQ Retries; No Egress Credits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_C_RxR_ISMQ_RETRY.FULL",
         "PerPkg": "1",
@@ -914,7 +821,6 @@
     },
     {
         "BriefDescription": "ISMQ Retries; No IIO Credits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_C_RxR_ISMQ_RETRY.IIO_CREDITS",
         "PerPkg": "1",
@@ -924,7 +830,6 @@
     },
     {
         "BriefDescription": "ISMQ Retries",
-        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_C_RxR_ISMQ_RETRY.NID",
         "PerPkg": "1",
@@ -934,7 +839,6 @@
     },
     {
         "BriefDescription": "ISMQ Retries; No QPI Credits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_C_RxR_ISMQ_RETRY.QPI_CREDITS",
         "PerPkg": "1",
@@ -944,7 +848,6 @@
     },
     {
         "BriefDescription": "ISMQ Retries; No RTIDs",
-        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_C_RxR_ISMQ_RETRY.RTID",
         "PerPkg": "1",
@@ -954,7 +857,6 @@
     },
     {
         "BriefDescription": "ISMQ Retries",
-        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_C_RxR_ISMQ_RETRY.WB_CREDITS",
         "PerPkg": "1",
@@ -964,7 +866,6 @@
     },
     {
         "BriefDescription": "ISMQ Request Queue Rejects; No AD Sbo Credits=
",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A",
         "EventName": "UNC_C_RxR_ISMQ_RETRY2.AD_SBO",
         "PerPkg": "1",
@@ -974,7 +875,6 @@
     },
     {
         "BriefDescription": "ISMQ Request Queue Rejects; No BL Sbo Credits=
",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A",
         "EventName": "UNC_C_RxR_ISMQ_RETRY2.BL_SBO",
         "PerPkg": "1",
@@ -984,7 +884,6 @@
     },
     {
         "BriefDescription": "ISMQ Request Queue Rejects; Target Node Filte=
r",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A",
         "EventName": "UNC_C_RxR_ISMQ_RETRY2.TARGET",
         "PerPkg": "1",
@@ -1030,7 +929,6 @@
     },
     {
         "BriefDescription": "SBo Credits Acquired; For AD Ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3D",
         "EventName": "UNC_C_SBO_CREDITS_ACQUIRED.AD",
         "PerPkg": "1",
@@ -1040,7 +938,6 @@
     },
     {
         "BriefDescription": "SBo Credits Acquired; For BL Ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3D",
         "EventName": "UNC_C_SBO_CREDITS_ACQUIRED.BL",
         "PerPkg": "1",
@@ -1068,7 +965,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.ALL",
         "PerPkg": "1",
@@ -1078,7 +974,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; Evictions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.EVICTION",
         "PerPkg": "1",
@@ -1088,7 +983,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; Local Memory",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.LOCAL",
         "PerPkg": "1",
@@ -1098,7 +992,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; Local Memory - Opcode Matched",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.LOCAL_OPCODE",
         "PerPkg": "1",
@@ -1108,17 +1001,15 @@
     },
     {
         "BriefDescription": "TOR Inserts; Misses to Local Memory",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_LOCAL",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that are satisifed by locally HOMed memory.",
-        "UMask": "0x2A",
+        "UMask": "0x2a",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "TOR Inserts; Misses to Local Memory - Opcode =
Matched",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE",
         "PerPkg": "1",
@@ -1128,7 +1019,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; Miss Opcode Match",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
         "PerPkg": "1",
@@ -1138,17 +1028,15 @@
     },
     {
         "BriefDescription": "TOR Inserts; Misses to Remote Memory",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_REMOTE",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that are satisifed by remote caches or remote memory.",
-        "UMask": "0x8A",
+        "UMask": "0x8a",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "TOR Inserts; Misses to Remote Memory - Opcode=
 Matched",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE",
         "PerPkg": "1",
@@ -1158,7 +1046,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; NID Matched",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_ALL",
         "PerPkg": "1",
@@ -1168,7 +1055,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; NID Matched Evictions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_EVICTION",
         "PerPkg": "1",
@@ -1178,17 +1064,15 @@
     },
     {
         "BriefDescription": "TOR Inserts; NID Matched Miss All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_MISS_ALL",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched miss requ=
ests that were inserted into the TOR.",
-        "UMask": "0x4A",
+        "UMask": "0x4a",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "TOR Inserts; NID and Opcode Matched Miss",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_MISS_OPCODE",
         "PerPkg": "1",
@@ -1198,7 +1082,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; NID and Opcode Matched",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_OPCODE",
         "PerPkg": "1",
@@ -1208,7 +1091,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; NID Matched Writebacks",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_WB",
         "PerPkg": "1",
@@ -1218,7 +1100,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; Opcode Match",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.OPCODE",
         "PerPkg": "1",
@@ -1228,7 +1109,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; Remote Memory",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.REMOTE",
         "PerPkg": "1",
@@ -1238,7 +1118,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; Remote Memory - Opcode Matched",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.REMOTE_OPCODE",
         "PerPkg": "1",
@@ -1248,7 +1127,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; Writebacks",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.WB",
         "PerPkg": "1",
@@ -1298,7 +1176,7 @@
         "EventName": "UNC_C_TOR_OCCUPANCY.MISS_ALL",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding miss requests in the TOR.  'Miss' means the allocation requires a=
n RTID.  This generally means that the request was sent to memory or MMIO."=
,
-        "UMask": "0xA",
+        "UMask": "0xa",
         "Unit": "CBO"
     },
     {
@@ -1307,7 +1185,7 @@
         "EventName": "UNC_C_TOR_OCCUPANCY.MISS_LOCAL",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
-        "UMask": "0x2A",
+        "UMask": "0x2a",
         "Unit": "CBO"
     },
     {
@@ -1334,7 +1212,7 @@
         "EventName": "UNC_C_TOR_OCCUPANCY.MISS_REMOTE",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
-        "UMask": "0x8A",
+        "UMask": "0x8a",
         "Unit": "CBO"
     },
     {
@@ -1370,7 +1248,7 @@
         "EventName": "UNC_C_TOR_OCCUPANCY.NID_MISS_ALL",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss requests in the TOR that match a NID.",
-        "UMask": "0x4A",
+        "UMask": "0x4a",
         "Unit": "CBO"
     },
     {
@@ -1438,7 +1316,6 @@
     },
     {
         "BriefDescription": "Onto AD Ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_C_TxR_ADS_USED.AD",
         "PerPkg": "1",
@@ -1447,7 +1324,6 @@
     },
     {
         "BriefDescription": "Onto AK Ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_C_TxR_ADS_USED.AK",
         "PerPkg": "1",
@@ -1456,7 +1332,6 @@
     },
     {
         "BriefDescription": "Onto BL Ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_C_TxR_ADS_USED.BL",
         "PerPkg": "1",
@@ -1465,7 +1340,6 @@
     },
     {
         "BriefDescription": "Egress Allocations; AD - Cachebo",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_C_TxR_INSERTS.AD_CACHE",
         "PerPkg": "1",
@@ -1475,7 +1349,6 @@
     },
     {
         "BriefDescription": "Egress Allocations; AD - Corebo",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_C_TxR_INSERTS.AD_CORE",
         "PerPkg": "1",
@@ -1485,7 +1358,6 @@
     },
     {
         "BriefDescription": "Egress Allocations; AK - Cachebo",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_C_TxR_INSERTS.AK_CACHE",
         "PerPkg": "1",
@@ -1495,7 +1367,6 @@
     },
     {
         "BriefDescription": "Egress Allocations; AK - Corebo",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_C_TxR_INSERTS.AK_CORE",
         "PerPkg": "1",
@@ -1505,7 +1376,6 @@
     },
     {
         "BriefDescription": "Egress Allocations; BL - Cacheno",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_C_TxR_INSERTS.BL_CACHE",
         "PerPkg": "1",
@@ -1515,7 +1385,6 @@
     },
     {
         "BriefDescription": "Egress Allocations; BL - Corebo",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_C_TxR_INSERTS.BL_CORE",
         "PerPkg": "1",
@@ -1525,7 +1394,6 @@
     },
     {
         "BriefDescription": "Egress Allocations; IV - Cachebo",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_C_TxR_INSERTS.IV_CACHE",
         "PerPkg": "1",
@@ -1535,7 +1403,6 @@
     },
     {
         "BriefDescription": "Injection Starvation; Onto AD Ring (to core)"=
,
-        "Counter": "0,1,2,3",
         "EventCode": "0x3",
         "EventName": "UNC_C_TxR_STARVED.AD_CORE",
         "PerPkg": "1",
@@ -1545,7 +1412,6 @@
     },
     {
         "BriefDescription": "Injection Starvation; Onto AK Ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3",
         "EventName": "UNC_C_TxR_STARVED.AK_BOTH",
         "PerPkg": "1",
@@ -1555,7 +1421,6 @@
     },
     {
         "BriefDescription": "Injection Starvation; Onto BL Ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3",
         "EventName": "UNC_C_TxR_STARVED.BL_BOTH",
         "PerPkg": "1",
@@ -1565,7 +1430,6 @@
     },
     {
         "BriefDescription": "Injection Starvation; Onto IV Ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3",
         "EventName": "UNC_C_TxR_STARVED.IV",
         "PerPkg": "1",
@@ -1575,7 +1439,6 @@
     },
     {
         "BriefDescription": "BT Cycles Not Empty",
-        "Counter": "0,1,2,3",
         "EventCode": "0x42",
         "EventName": "UNC_H_BT_CYCLES_NE",
         "PerPkg": "1",
@@ -1584,7 +1447,6 @@
     },
     {
         "BriefDescription": "BT to HT Not Issued; Incoming Data Hazard",
-        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "UNC_H_BT_TO_HT_NOT_ISSUED.INCOMING_BL_HAZARD",
         "PerPkg": "1",
@@ -1594,7 +1456,6 @@
     },
     {
         "BriefDescription": "BT to HT Not Issued; Incoming Snoop Hazard",
-        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "UNC_H_BT_TO_HT_NOT_ISSUED.INCOMING_SNP_HAZARD",
         "PerPkg": "1",
@@ -1604,7 +1465,6 @@
     },
     {
         "BriefDescription": "BT to HT Not Issued; Incoming Data Hazard",
-        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "UNC_H_BT_TO_HT_NOT_ISSUED.RSPACKCFLT_HAZARD",
         "PerPkg": "1",
@@ -1614,7 +1474,6 @@
     },
     {
         "BriefDescription": "BT to HT Not Issued; Incoming Data Hazard",
-        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "UNC_H_BT_TO_HT_NOT_ISSUED.WBMDATA_HAZARD",
         "PerPkg": "1",
@@ -1624,7 +1483,6 @@
     },
     {
         "BriefDescription": "HA to iMC Bypass; Not Taken",
-        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_H_BYPASS_IMC.NOT_TAKEN",
         "PerPkg": "1",
@@ -1634,7 +1492,6 @@
     },
     {
         "BriefDescription": "HA to iMC Bypass; Taken",
-        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_H_BYPASS_IMC.TAKEN",
         "PerPkg": "1",
@@ -1644,7 +1501,6 @@
     },
     {
         "BriefDescription": "uclks",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_H_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of uclks in the HA.  This =
will be slightly different than the count in the Ubox because of enable/fre=
eze delays.  The HA is on the other side of the die from the fixed Ubox ucl=
k counter, so the drift could be somewhat larger than in units that are clo=
ser like the QPI Agent.",
@@ -1652,7 +1508,6 @@
     },
     {
         "BriefDescription": "Direct2Core Messages Sent",
-        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "UNC_H_DIRECT2CORE_COUNT",
         "PerPkg": "1",
@@ -1661,7 +1516,6 @@
     },
     {
         "BriefDescription": "Cycles when Direct2Core was Disabled",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "UNC_H_DIRECT2CORE_CYCLES_DISABLED",
         "PerPkg": "1",
@@ -1670,7 +1524,6 @@
     },
     {
         "BriefDescription": "Number of Reads that had Direct2Core Overridd=
en",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_H_DIRECT2CORE_TXN_OVERRIDE",
         "PerPkg": "1",
@@ -1679,7 +1532,6 @@
     },
     {
         "BriefDescription": "Directory Lat Opt Return",
-        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_H_DIRECTORY_LAT_OPT",
         "PerPkg": "1",
@@ -1688,7 +1540,6 @@
     },
     {
         "BriefDescription": "Directory Lookups; Snoop Not Needed",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC",
         "EventName": "UNC_H_DIRECTORY_LOOKUP.NO_SNP",
         "PerPkg": "1",
@@ -1698,7 +1549,6 @@
     },
     {
         "BriefDescription": "Directory Lookups; Snoop Needed",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC",
         "EventName": "UNC_H_DIRECTORY_LOOKUP.SNP",
         "PerPkg": "1",
@@ -1708,7 +1558,6 @@
     },
     {
         "BriefDescription": "Directory Updates; Any Directory Update",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD",
         "EventName": "UNC_H_DIRECTORY_UPDATE.ANY",
         "PerPkg": "1",
@@ -1718,7 +1567,6 @@
     },
     {
         "BriefDescription": "Directory Updates; Directory Clear",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD",
         "EventName": "UNC_H_DIRECTORY_UPDATE.CLEAR",
         "PerPkg": "1",
@@ -1728,7 +1576,6 @@
     },
     {
         "BriefDescription": "Directory Updates; Directory Set",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD",
         "EventName": "UNC_H_DIRECTORY_UPDATE.SET",
         "PerPkg": "1",
@@ -1738,7 +1585,6 @@
     },
     {
         "BriefDescription": "Counts Number of Hits in HitMe Cache; op is A=
ckCnfltWbI",
-        "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "UNC_H_HITME_HIT.ACKCNFLTWBI",
         "PerPkg": "1",
@@ -1747,16 +1593,14 @@
     },
     {
         "BriefDescription": "Counts Number of Hits in HitMe Cache; All Req=
uests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "UNC_H_HITME_HIT.ALL",
         "PerPkg": "1",
-        "UMask": "0xFF",
+        "UMask": "0xff",
         "Unit": "HA"
     },
     {
         "BriefDescription": "Counts Number of Hits in HitMe Cache; Allocat=
ions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "UNC_H_HITME_HIT.ALLOCS",
         "PerPkg": "1",
@@ -1765,7 +1609,6 @@
     },
     {
         "BriefDescription": "Counts Number of Hits in HitMe Cache; Allocat=
ions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "UNC_H_HITME_HIT.EVICTS",
         "PerPkg": "1",
@@ -1774,16 +1617,14 @@
     },
     {
         "BriefDescription": "Counts Number of Hits in HitMe Cache; HOM Req=
uests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "UNC_H_HITME_HIT.HOM",
         "PerPkg": "1",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "HA"
     },
     {
         "BriefDescription": "Counts Number of Hits in HitMe Cache; Invalid=
ations",
-        "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "UNC_H_HITME_HIT.INVALS",
         "PerPkg": "1",
@@ -1792,7 +1633,6 @@
     },
     {
         "BriefDescription": "Counts Number of Hits in HitMe Cache; op is R=
dCode, RdData, RdDataMigratory, RdInvOwn, RdCur or InvItoE",
-        "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "UNC_H_HITME_HIT.READ_OR_INVITOE",
         "PerPkg": "1",
@@ -1801,7 +1641,6 @@
     },
     {
         "BriefDescription": "Counts Number of Hits in HitMe Cache; op is R=
spI, RspIWb, RspS, RspSWb, RspCnflt or RspCnfltWbI",
-        "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "UNC_H_HITME_HIT.RSP",
         "PerPkg": "1",
@@ -1810,7 +1649,6 @@
     },
     {
         "BriefDescription": "Counts Number of Hits in HitMe Cache; op is R=
spIFwd or RspIFwdWb for a local request",
-        "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "UNC_H_HITME_HIT.RSPFWDI_LOCAL",
         "PerPkg": "1",
@@ -1819,7 +1657,6 @@
     },
     {
         "BriefDescription": "Counts Number of Hits in HitMe Cache; op is R=
spIFwd or RspIFwdWb for a remote request",
-        "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "UNC_H_HITME_HIT.RSPFWDI_REMOTE",
         "PerPkg": "1",
@@ -1828,7 +1665,6 @@
     },
     {
         "BriefDescription": "Counts Number of Hits in HitMe Cache; op is R=
sSFwd or RspSFwdWb",
-        "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "UNC_H_HITME_HIT.RSPFWDS",
         "PerPkg": "1",
@@ -1837,7 +1673,6 @@
     },
     {
         "BriefDescription": "Counts Number of Hits in HitMe Cache; op is W=
bMtoE or WbMtoS",
-        "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "UNC_H_HITME_HIT.WBMTOE_OR_S",
         "PerPkg": "1",
@@ -1846,7 +1681,6 @@
     },
     {
         "BriefDescription": "Counts Number of Hits in HitMe Cache; op is W=
bMtoI",
-        "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "UNC_H_HITME_HIT.WBMTOI",
         "PerPkg": "1",
@@ -1855,7 +1689,6 @@
     },
     {
         "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; op is AckCnfltWbI",
-        "Counter": "0,1,2,3",
         "EventCode": "0x72",
         "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.ACKCNFLTWBI",
         "PerPkg": "1",
@@ -1864,25 +1697,22 @@
     },
     {
         "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; All Requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x72",
         "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.ALL",
         "PerPkg": "1",
-        "UMask": "0xFF",
+        "UMask": "0xff",
         "Unit": "HA"
     },
     {
         "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; HOM Requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x72",
         "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.HOM",
         "PerPkg": "1",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "HA"
     },
     {
         "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; op is RdCode, RdData, RdDataMigratory, RdInvOwn, RdCur or InvItoE=
",
-        "Counter": "0,1,2,3",
         "EventCode": "0x72",
         "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.READ_OR_INVITOE",
         "PerPkg": "1",
@@ -1891,7 +1721,6 @@
     },
     {
         "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; op is RspI, RspIWb, RspS, RspSWb, RspCnflt or RspCnfltWbI",
-        "Counter": "0,1,2,3",
         "EventCode": "0x72",
         "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.RSP",
         "PerPkg": "1",
@@ -1900,7 +1729,6 @@
     },
     {
         "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; op is RspIFwd or RspIFwdWb for a local request",
-        "Counter": "0,1,2,3",
         "EventCode": "0x72",
         "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.RSPFWDI_LOCAL",
         "PerPkg": "1",
@@ -1909,7 +1737,6 @@
     },
     {
         "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; op is RspIFwd or RspIFwdWb for a remote request",
-        "Counter": "0,1,2,3",
         "EventCode": "0x72",
         "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.RSPFWDI_REMOTE",
         "PerPkg": "1",
@@ -1918,7 +1745,6 @@
     },
     {
         "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; op is RsSFwd or RspSFwdWb",
-        "Counter": "0,1,2,3",
         "EventCode": "0x72",
         "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.RSPFWDS",
         "PerPkg": "1",
@@ -1927,7 +1753,6 @@
     },
     {
         "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; op is WbMtoE or WbMtoS",
-        "Counter": "0,1,2,3",
         "EventCode": "0x72",
         "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.WBMTOE_OR_S",
         "PerPkg": "1",
@@ -1936,7 +1761,6 @@
     },
     {
         "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; op is WbMtoI",
-        "Counter": "0,1,2,3",
         "EventCode": "0x72",
         "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.WBMTOI",
         "PerPkg": "1",
@@ -1945,7 +1769,6 @@
     },
     {
         "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; op is AckCnfltWbI",
-        "Counter": "0,1,2,3",
         "EventCode": "0x70",
         "EventName": "UNC_H_HITME_LOOKUP.ACKCNFLTWBI",
         "PerPkg": "1",
@@ -1954,16 +1777,14 @@
     },
     {
         "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; All Requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x70",
         "EventName": "UNC_H_HITME_LOOKUP.ALL",
         "PerPkg": "1",
-        "UMask": "0xFF",
+        "UMask": "0xff",
         "Unit": "HA"
     },
     {
         "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; Allocations",
-        "Counter": "0,1,2,3",
         "EventCode": "0x70",
         "EventName": "UNC_H_HITME_LOOKUP.ALLOCS",
         "PerPkg": "1",
@@ -1972,16 +1793,14 @@
     },
     {
         "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; HOM Requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x70",
         "EventName": "UNC_H_HITME_LOOKUP.HOM",
         "PerPkg": "1",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "HA"
     },
     {
         "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; Invalidations",
-        "Counter": "0,1,2,3",
         "EventCode": "0x70",
         "EventName": "UNC_H_HITME_LOOKUP.INVALS",
         "PerPkg": "1",
@@ -1990,7 +1809,6 @@
     },
     {
         "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; op is RdCode, RdData, RdDataMigratory, RdInvOwn, RdCur or InvItoE",
-        "Counter": "0,1,2,3",
         "EventCode": "0x70",
         "EventName": "UNC_H_HITME_LOOKUP.READ_OR_INVITOE",
         "PerPkg": "1",
@@ -1999,7 +1817,6 @@
     },
     {
         "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; op is RspI, RspIWb, RspS, RspSWb, RspCnflt or RspCnfltWbI",
-        "Counter": "0,1,2,3",
         "EventCode": "0x70",
         "EventName": "UNC_H_HITME_LOOKUP.RSP",
         "PerPkg": "1",
@@ -2008,7 +1825,6 @@
     },
     {
         "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; op is RspIFwd or RspIFwdWb for a local request",
-        "Counter": "0,1,2,3",
         "EventCode": "0x70",
         "EventName": "UNC_H_HITME_LOOKUP.RSPFWDI_LOCAL",
         "PerPkg": "1",
@@ -2017,7 +1833,6 @@
     },
     {
         "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; op is RspIFwd or RspIFwdWb for a remote request",
-        "Counter": "0,1,2,3",
         "EventCode": "0x70",
         "EventName": "UNC_H_HITME_LOOKUP.RSPFWDI_REMOTE",
         "PerPkg": "1",
@@ -2026,7 +1841,6 @@
     },
     {
         "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; op is RsSFwd or RspSFwdWb",
-        "Counter": "0,1,2,3",
         "EventCode": "0x70",
         "EventName": "UNC_H_HITME_LOOKUP.RSPFWDS",
         "PerPkg": "1",
@@ -2035,7 +1849,6 @@
     },
     {
         "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; op is WbMtoE or WbMtoS",
-        "Counter": "0,1,2,3",
         "EventCode": "0x70",
         "EventName": "UNC_H_HITME_LOOKUP.WBMTOE_OR_S",
         "PerPkg": "1",
@@ -2044,7 +1857,6 @@
     },
     {
         "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; op is WbMtoI",
-        "Counter": "0,1,2,3",
         "EventCode": "0x70",
         "EventName": "UNC_H_HITME_LOOKUP.WBMTOI",
         "PerPkg": "1",
@@ -2053,7 +1865,6 @@
     },
     {
         "BriefDescription": "Cycles without QPI Ingress Credits; AD to QPI=
 Link 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_IGR_NO_CREDIT_CYCLES.AD_QPI0",
         "PerPkg": "1",
@@ -2063,7 +1874,6 @@
     },
     {
         "BriefDescription": "Cycles without QPI Ingress Credits; AD to QPI=
 Link 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_IGR_NO_CREDIT_CYCLES.AD_QPI1",
         "PerPkg": "1",
@@ -2073,7 +1883,6 @@
     },
     {
         "BriefDescription": "Cycles without QPI Ingress Credits; BL to QPI=
 Link 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_IGR_NO_CREDIT_CYCLES.AD_QPI2",
         "PerPkg": "1",
@@ -2083,7 +1892,6 @@
     },
     {
         "BriefDescription": "Cycles without QPI Ingress Credits; BL to QPI=
 Link 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_IGR_NO_CREDIT_CYCLES.BL_QPI0",
         "PerPkg": "1",
@@ -2093,7 +1901,6 @@
     },
     {
         "BriefDescription": "Cycles without QPI Ingress Credits; BL to QPI=
 Link 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_IGR_NO_CREDIT_CYCLES.BL_QPI1",
         "PerPkg": "1",
@@ -2103,7 +1910,6 @@
     },
     {
         "BriefDescription": "Cycles without QPI Ingress Credits; BL to QPI=
 Link 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_IGR_NO_CREDIT_CYCLES.BL_QPI2",
         "PerPkg": "1",
@@ -2113,7 +1919,6 @@
     },
     {
         "BriefDescription": "HA to iMC Normal Priority Reads Issued; Norma=
l Priority",
-        "Counter": "0,1,2,3",
         "EventCode": "0x17",
         "EventName": "UNC_H_IMC_READS.NORMAL",
         "PerPkg": "1",
@@ -2123,7 +1928,6 @@
     },
     {
         "BriefDescription": "Retry Events",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1E",
         "EventName": "UNC_H_IMC_RETRY",
         "PerPkg": "1",
@@ -2131,17 +1935,15 @@
     },
     {
         "BriefDescription": "HA to iMC Full Line Writes Issued; All Writes=
",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1A",
         "EventName": "UNC_H_IMC_WRITES.ALL",
         "PerPkg": "1",
         "PublicDescription": "Counts the total number of full line writes =
issued from the HA into the memory controller.  This counts for all four ch=
annels.  It can be filtered by full/partial and ISOCH/non-ISOCH.",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "HA"
     },
     {
         "BriefDescription": "HA to iMC Full Line Writes Issued; Full Line =
Non-ISOCH",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1A",
         "EventName": "UNC_H_IMC_WRITES.FULL",
         "PerPkg": "1",
@@ -2151,7 +1953,6 @@
     },
     {
         "BriefDescription": "HA to iMC Full Line Writes Issued; ISOCH Full=
 Line",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1A",
         "EventName": "UNC_H_IMC_WRITES.FULL_ISOCH",
         "PerPkg": "1",
@@ -2161,7 +1962,6 @@
     },
     {
         "BriefDescription": "HA to iMC Full Line Writes Issued; Partial No=
n-ISOCH",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1A",
         "EventName": "UNC_H_IMC_WRITES.PARTIAL",
         "PerPkg": "1",
@@ -2171,7 +1971,6 @@
     },
     {
         "BriefDescription": "HA to iMC Full Line Writes Issued; ISOCH Part=
ial",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1A",
         "EventName": "UNC_H_IMC_WRITES.PARTIAL_ISOCH",
         "PerPkg": "1",
@@ -2181,7 +1980,6 @@
     },
     {
         "BriefDescription": "IOT Backpressure",
-        "Counter": "0,1,2",
         "EventCode": "0x61",
         "EventName": "UNC_H_IOT_BACKPRESSURE.HUB",
         "PerPkg": "1",
@@ -2190,7 +1988,6 @@
     },
     {
         "BriefDescription": "IOT Backpressure",
-        "Counter": "0,1,2",
         "EventCode": "0x61",
         "EventName": "UNC_H_IOT_BACKPRESSURE.SAT",
         "PerPkg": "1",
@@ -2199,7 +1996,6 @@
     },
     {
         "BriefDescription": "IOT Common Trigger Sequencer - Lo",
-        "Counter": "0,1,2",
         "EventCode": "0x64",
         "EventName": "UNC_H_IOT_CTS_EAST_LO.CTS0",
         "PerPkg": "1",
@@ -2209,7 +2005,6 @@
     },
     {
         "BriefDescription": "IOT Common Trigger Sequencer - Lo",
-        "Counter": "0,1,2",
         "EventCode": "0x64",
         "EventName": "UNC_H_IOT_CTS_EAST_LO.CTS1",
         "PerPkg": "1",
@@ -2219,7 +2014,6 @@
     },
     {
         "BriefDescription": "IOT Common Trigger Sequencer - Hi",
-        "Counter": "0,1,2",
         "EventCode": "0x65",
         "EventName": "UNC_H_IOT_CTS_HI.CTS2",
         "PerPkg": "1",
@@ -2229,7 +2023,6 @@
     },
     {
         "BriefDescription": "IOT Common Trigger Sequencer - Hi",
-        "Counter": "0,1,2",
         "EventCode": "0x65",
         "EventName": "UNC_H_IOT_CTS_HI.CTS3",
         "PerPkg": "1",
@@ -2239,7 +2032,6 @@
     },
     {
         "BriefDescription": "IOT Common Trigger Sequencer - Lo",
-        "Counter": "0,1,2",
         "EventCode": "0x62",
         "EventName": "UNC_H_IOT_CTS_WEST_LO.CTS0",
         "PerPkg": "1",
@@ -2249,7 +2041,6 @@
     },
     {
         "BriefDescription": "IOT Common Trigger Sequencer - Lo",
-        "Counter": "0,1,2",
         "EventCode": "0x62",
         "EventName": "UNC_H_IOT_CTS_WEST_LO.CTS1",
         "PerPkg": "1",
@@ -2259,7 +2050,6 @@
     },
     {
         "BriefDescription": "OSB Snoop Broadcast; Cancelled",
-        "Counter": "0,1,2,3",
         "EventCode": "0x53",
         "EventName": "UNC_H_OSB.CANCELLED",
         "PerPkg": "1",
@@ -2269,7 +2059,6 @@
     },
     {
         "BriefDescription": "OSB Snoop Broadcast; Local InvItoE",
-        "Counter": "0,1,2,3",
         "EventCode": "0x53",
         "EventName": "UNC_H_OSB.INVITOE_LOCAL",
         "PerPkg": "1",
@@ -2279,7 +2068,6 @@
     },
     {
         "BriefDescription": "OSB Snoop Broadcast; Local Reads",
-        "Counter": "0,1,2,3",
         "EventCode": "0x53",
         "EventName": "UNC_H_OSB.READS_LOCAL",
         "PerPkg": "1",
@@ -2289,7 +2077,6 @@
     },
     {
         "BriefDescription": "OSB Snoop Broadcast; Reads Local -  Useful",
-        "Counter": "0,1,2,3",
         "EventCode": "0x53",
         "EventName": "UNC_H_OSB.READS_LOCAL_USEFUL",
         "PerPkg": "1",
@@ -2299,7 +2086,6 @@
     },
     {
         "BriefDescription": "OSB Snoop Broadcast; Remote",
-        "Counter": "0,1,2,3",
         "EventCode": "0x53",
         "EventName": "UNC_H_OSB.REMOTE",
         "PerPkg": "1",
@@ -2309,7 +2095,6 @@
     },
     {
         "BriefDescription": "OSB Snoop Broadcast; Remote - Useful",
-        "Counter": "0,1,2,3",
         "EventCode": "0x53",
         "EventName": "UNC_H_OSB.REMOTE_USEFUL",
         "PerPkg": "1",
@@ -2319,7 +2104,6 @@
     },
     {
         "BriefDescription": "OSB Early Data Return; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "UNC_H_OSB_EDR.ALL",
         "PerPkg": "1",
@@ -2329,7 +2113,6 @@
     },
     {
         "BriefDescription": "OSB Early Data Return; Reads to Local  I",
-        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "UNC_H_OSB_EDR.READS_LOCAL_I",
         "PerPkg": "1",
@@ -2339,7 +2122,6 @@
     },
     {
         "BriefDescription": "OSB Early Data Return; Reads to Local S",
-        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "UNC_H_OSB_EDR.READS_LOCAL_S",
         "PerPkg": "1",
@@ -2349,7 +2131,6 @@
     },
     {
         "BriefDescription": "OSB Early Data Return; Reads to Remote I",
-        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "UNC_H_OSB_EDR.READS_REMOTE_I",
         "PerPkg": "1",
@@ -2359,7 +2140,6 @@
     },
     {
         "BriefDescription": "OSB Early Data Return; Reads to Remote S",
-        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "UNC_H_OSB_EDR.READS_REMOTE_S",
         "PerPkg": "1",
@@ -2369,7 +2149,6 @@
     },
     {
         "BriefDescription": "Read and Write Requests; Local InvItoEs",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.INVITOE_LOCAL",
         "PerPkg": "1",
@@ -2379,7 +2158,6 @@
     },
     {
         "BriefDescription": "Read and Write Requests; Remote InvItoEs",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.INVITOE_REMOTE",
         "PerPkg": "1",
@@ -2389,7 +2167,6 @@
     },
     {
         "BriefDescription": "Read and Write Requests; Reads",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.READS",
         "PerPkg": "1",
@@ -2399,7 +2176,6 @@
     },
     {
         "BriefDescription": "Read and Write Requests; Local Reads",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.READS_LOCAL",
         "PerPkg": "1",
@@ -2409,7 +2185,6 @@
     },
     {
         "BriefDescription": "Read and Write Requests; Remote Reads",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.READS_REMOTE",
         "PerPkg": "1",
@@ -2419,17 +2194,15 @@
     },
     {
         "BriefDescription": "Read and Write Requests; Writes",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.WRITES",
         "PerPkg": "1",
         "PublicDescription": "Counts the total number of read requests mad=
e into the Home Agent. Reads include all read opcodes (including RFO).  Wri=
tes include all writes (streaming, evictions, HitM, etc).; Incoming write r=
equests.",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "HA"
     },
     {
         "BriefDescription": "Read and Write Requests; Local Writes",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.WRITES_LOCAL",
         "PerPkg": "1",
@@ -2439,7 +2212,6 @@
     },
     {
         "BriefDescription": "Read and Write Requests; Remote Writes",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.WRITES_REMOTE",
         "PerPkg": "1",
@@ -2449,17 +2221,15 @@
     },
     {
         "BriefDescription": "HA AD Ring in Use; Counterclockwise",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3E",
         "EventName": "UNC_H_RING_AD_USED.CCW",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "HA"
     },
     {
         "BriefDescription": "HA AD Ring in Use; Counterclockwise and Even"=
,
-        "Counter": "0,1,2,3",
         "EventCode": "0x3E",
         "EventName": "UNC_H_RING_AD_USED.CCW_EVEN",
         "PerPkg": "1",
@@ -2469,7 +2239,6 @@
     },
     {
         "BriefDescription": "HA AD Ring in Use; Counterclockwise and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3E",
         "EventName": "UNC_H_RING_AD_USED.CCW_ODD",
         "PerPkg": "1",
@@ -2479,7 +2248,6 @@
     },
     {
         "BriefDescription": "HA AD Ring in Use; Clockwise",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3E",
         "EventName": "UNC_H_RING_AD_USED.CW",
         "PerPkg": "1",
@@ -2489,7 +2257,6 @@
     },
     {
         "BriefDescription": "HA AD Ring in Use; Clockwise and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3E",
         "EventName": "UNC_H_RING_AD_USED.CW_EVEN",
         "PerPkg": "1",
@@ -2499,7 +2266,6 @@
     },
     {
         "BriefDescription": "HA AD Ring in Use; Clockwise and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3E",
         "EventName": "UNC_H_RING_AD_USED.CW_ODD",
         "PerPkg": "1",
@@ -2509,27 +2275,24 @@
     },
     {
         "BriefDescription": "HA AK Ring in Use; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3F",
         "EventName": "UNC_H_RING_AK_USED.ALL",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "HA"
     },
     {
         "BriefDescription": "HA AK Ring in Use; Counterclockwise",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3F",
         "EventName": "UNC_H_RING_AK_USED.CCW",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "HA"
     },
     {
         "BriefDescription": "HA AK Ring in Use; Counterclockwise and Even"=
,
-        "Counter": "0,1,2,3",
         "EventCode": "0x3F",
         "EventName": "UNC_H_RING_AK_USED.CCW_EVEN",
         "PerPkg": "1",
@@ -2539,7 +2302,6 @@
     },
     {
         "BriefDescription": "HA AK Ring in Use; Counterclockwise and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3F",
         "EventName": "UNC_H_RING_AK_USED.CCW_ODD",
         "PerPkg": "1",
@@ -2549,7 +2311,6 @@
     },
     {
         "BriefDescription": "HA AK Ring in Use; Clockwise",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3F",
         "EventName": "UNC_H_RING_AK_USED.CW",
         "PerPkg": "1",
@@ -2559,7 +2320,6 @@
     },
     {
         "BriefDescription": "HA AK Ring in Use; Clockwise and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3F",
         "EventName": "UNC_H_RING_AK_USED.CW_EVEN",
         "PerPkg": "1",
@@ -2569,7 +2329,6 @@
     },
     {
         "BriefDescription": "HA AK Ring in Use; Clockwise and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3F",
         "EventName": "UNC_H_RING_AK_USED.CW_ODD",
         "PerPkg": "1",
@@ -2579,27 +2338,24 @@
     },
     {
         "BriefDescription": "HA BL Ring in Use; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_H_RING_BL_USED.ALL",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "HA"
     },
     {
         "BriefDescription": "HA BL Ring in Use; Counterclockwise",
-        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_H_RING_BL_USED.CCW",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "HA"
     },
     {
         "BriefDescription": "HA BL Ring in Use; Counterclockwise and Even"=
,
-        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_H_RING_BL_USED.CCW_EVEN",
         "PerPkg": "1",
@@ -2609,7 +2365,6 @@
     },
     {
         "BriefDescription": "HA BL Ring in Use; Counterclockwise and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_H_RING_BL_USED.CCW_ODD",
         "PerPkg": "1",
@@ -2619,7 +2374,6 @@
     },
     {
         "BriefDescription": "HA BL Ring in Use; Clockwise",
-        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_H_RING_BL_USED.CW",
         "PerPkg": "1",
@@ -2629,7 +2383,6 @@
     },
     {
         "BriefDescription": "HA BL Ring in Use; Clockwise and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_H_RING_BL_USED.CW_EVEN",
         "PerPkg": "1",
@@ -2639,7 +2392,6 @@
     },
     {
         "BriefDescription": "HA BL Ring in Use; Clockwise and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_H_RING_BL_USED.CW_ODD",
         "PerPkg": "1",
@@ -2649,7 +2401,6 @@
     },
     {
         "BriefDescription": "iMC RPQ Credits Empty - Regular; Channel 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN0",
         "PerPkg": "1",
@@ -2659,7 +2410,6 @@
     },
     {
         "BriefDescription": "iMC RPQ Credits Empty - Regular; Channel 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN1",
         "PerPkg": "1",
@@ -2669,7 +2419,6 @@
     },
     {
         "BriefDescription": "iMC RPQ Credits Empty - Regular; Channel 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN2",
         "PerPkg": "1",
@@ -2679,7 +2428,6 @@
     },
     {
         "BriefDescription": "iMC RPQ Credits Empty - Regular; Channel 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN3",
         "PerPkg": "1",
@@ -2689,7 +2437,6 @@
     },
     {
         "BriefDescription": "iMC RPQ Credits Empty - Special; Channel 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x16",
         "EventName": "UNC_H_RPQ_CYCLES_NO_SPEC_CREDITS.CHN0",
         "PerPkg": "1",
@@ -2699,7 +2446,6 @@
     },
     {
         "BriefDescription": "iMC RPQ Credits Empty - Special; Channel 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x16",
         "EventName": "UNC_H_RPQ_CYCLES_NO_SPEC_CREDITS.CHN1",
         "PerPkg": "1",
@@ -2709,7 +2455,6 @@
     },
     {
         "BriefDescription": "iMC RPQ Credits Empty - Special; Channel 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x16",
         "EventName": "UNC_H_RPQ_CYCLES_NO_SPEC_CREDITS.CHN2",
         "PerPkg": "1",
@@ -2719,7 +2464,6 @@
     },
     {
         "BriefDescription": "iMC RPQ Credits Empty - Special; Channel 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x16",
         "EventName": "UNC_H_RPQ_CYCLES_NO_SPEC_CREDITS.CHN3",
         "PerPkg": "1",
@@ -2729,7 +2473,6 @@
     },
     {
         "BriefDescription": "SBo0 Credits Acquired; For AD Ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x68",
         "EventName": "UNC_H_SBO0_CREDITS_ACQUIRED.AD",
         "PerPkg": "1",
@@ -2739,7 +2482,6 @@
     },
     {
         "BriefDescription": "SBo0 Credits Acquired; For BL Ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x68",
         "EventName": "UNC_H_SBO0_CREDITS_ACQUIRED.BL",
         "PerPkg": "1",
@@ -2749,7 +2491,6 @@
     },
     {
         "BriefDescription": "SBo0 Credits Occupancy; For AD Ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6A",
         "EventName": "UNC_H_SBO0_CREDIT_OCCUPANCY.AD",
         "PerPkg": "1",
@@ -2759,7 +2500,6 @@
     },
     {
         "BriefDescription": "SBo0 Credits Occupancy; For BL Ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6A",
         "EventName": "UNC_H_SBO0_CREDIT_OCCUPANCY.BL",
         "PerPkg": "1",
@@ -2769,7 +2509,6 @@
     },
     {
         "BriefDescription": "SBo1 Credits Acquired; For AD Ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x69",
         "EventName": "UNC_H_SBO1_CREDITS_ACQUIRED.AD",
         "PerPkg": "1",
@@ -2779,7 +2518,6 @@
     },
     {
         "BriefDescription": "SBo1 Credits Acquired; For BL Ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x69",
         "EventName": "UNC_H_SBO1_CREDITS_ACQUIRED.BL",
         "PerPkg": "1",
@@ -2789,7 +2527,6 @@
     },
     {
         "BriefDescription": "SBo1 Credits Occupancy; For AD Ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6B",
         "EventName": "UNC_H_SBO1_CREDIT_OCCUPANCY.AD",
         "PerPkg": "1",
@@ -2799,7 +2536,6 @@
     },
     {
         "BriefDescription": "SBo1 Credits Occupancy; For BL Ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6B",
         "EventName": "UNC_H_SBO1_CREDIT_OCCUPANCY.BL",
         "PerPkg": "1",
@@ -2809,7 +2545,6 @@
     },
     {
         "BriefDescription": "Data beat the Snoop Responses; Local Requests=
",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA",
         "EventName": "UNC_H_SNOOPS_RSP_AFTER_DATA.LOCAL",
         "PerPkg": "1",
@@ -2819,7 +2554,6 @@
     },
     {
         "BriefDescription": "Data beat the Snoop Responses; Remote Request=
s",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA",
         "EventName": "UNC_H_SNOOPS_RSP_AFTER_DATA.REMOTE",
         "PerPkg": "1",
@@ -2829,7 +2563,6 @@
     },
     {
         "BriefDescription": "Cycles with Snoops Outstanding; All Requests"=
,
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_H_SNOOP_CYCLES_NE.ALL",
         "PerPkg": "1",
@@ -2839,7 +2572,6 @@
     },
     {
         "BriefDescription": "Cycles with Snoops Outstanding; Local Request=
s",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_H_SNOOP_CYCLES_NE.LOCAL",
         "PerPkg": "1",
@@ -2849,7 +2581,6 @@
     },
     {
         "BriefDescription": "Cycles with Snoops Outstanding; Remote Reques=
ts",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_H_SNOOP_CYCLES_NE.REMOTE",
         "PerPkg": "1",
@@ -2859,7 +2590,6 @@
     },
     {
         "BriefDescription": "Tracker Snoops Outstanding Accumulator; Local=
 Requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_H_SNOOP_OCCUPANCY.LOCAL",
         "PerPkg": "1",
@@ -2869,7 +2599,6 @@
     },
     {
         "BriefDescription": "Tracker Snoops Outstanding Accumulator; Remot=
e Requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_H_SNOOP_OCCUPANCY.REMOTE",
         "PerPkg": "1",
@@ -2879,7 +2608,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received; RSPCNFLCT*",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSPCNFLCT",
         "PerPkg": "1",
@@ -2889,7 +2617,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received; RspI",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSPI",
         "PerPkg": "1",
@@ -2899,7 +2626,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received; RspIFwd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSPIFWD",
         "PerPkg": "1",
@@ -2909,7 +2635,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received; RspS",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSPS",
         "PerPkg": "1",
@@ -2919,7 +2644,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received; RspSFwd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSPSFWD",
         "PerPkg": "1",
@@ -2929,7 +2653,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received; Rsp*Fwd*WB",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSP_FWD_WB",
         "PerPkg": "1",
@@ -2939,7 +2662,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received; Rsp*WB",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSP_WB",
         "PerPkg": "1",
@@ -2949,7 +2671,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received Local; Other",
-        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.OTHER",
         "PerPkg": "1",
@@ -2959,7 +2680,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received Local; RspCnflct",
-        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPCNFLCT",
         "PerPkg": "1",
@@ -2969,7 +2689,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received Local; RspI",
-        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPI",
         "PerPkg": "1",
@@ -2979,7 +2698,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received Local; RspIFwd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPIFWD",
         "PerPkg": "1",
@@ -2989,7 +2707,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received Local; RspS",
-        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPS",
         "PerPkg": "1",
@@ -2999,7 +2716,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received Local; RspSFwd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPSFWD",
         "PerPkg": "1",
@@ -3009,7 +2725,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received Local; Rsp*FWD*WB",
-        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPxFWDxWB",
         "PerPkg": "1",
@@ -3019,7 +2734,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received Local; Rsp*WB",
-        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPxWB",
         "PerPkg": "1",
@@ -3029,7 +2743,6 @@
     },
     {
         "BriefDescription": "Stall on No Sbo Credits; For SBo0, AD Ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6C",
         "EventName": "UNC_H_STALL_NO_SBO_CREDIT.SBO0_AD",
         "PerPkg": "1",
@@ -3039,7 +2752,6 @@
     },
     {
         "BriefDescription": "Stall on No Sbo Credits; For SBo0, BL Ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6C",
         "EventName": "UNC_H_STALL_NO_SBO_CREDIT.SBO0_BL",
         "PerPkg": "1",
@@ -3049,7 +2761,6 @@
     },
     {
         "BriefDescription": "Stall on No Sbo Credits; For SBo1, AD Ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6C",
         "EventName": "UNC_H_STALL_NO_SBO_CREDIT.SBO1_AD",
         "PerPkg": "1",
@@ -3059,7 +2770,6 @@
     },
     {
         "BriefDescription": "Stall on No Sbo Credits; For SBo1, BL Ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6C",
         "EventName": "UNC_H_STALL_NO_SBO_CREDIT.SBO1_BL",
         "PerPkg": "1",
@@ -3069,7 +2779,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1B",
         "EventName": "UNC_H_TAD_REQUESTS_G0.REGION0",
         "PerPkg": "1",
@@ -3079,7 +2788,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1B",
         "EventName": "UNC_H_TAD_REQUESTS_G0.REGION1",
         "PerPkg": "1",
@@ -3089,7 +2797,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1B",
         "EventName": "UNC_H_TAD_REQUESTS_G0.REGION2",
         "PerPkg": "1",
@@ -3099,7 +2806,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1B",
         "EventName": "UNC_H_TAD_REQUESTS_G0.REGION3",
         "PerPkg": "1",
@@ -3109,7 +2815,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1B",
         "EventName": "UNC_H_TAD_REQUESTS_G0.REGION4",
         "PerPkg": "1",
@@ -3119,7 +2824,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1B",
         "EventName": "UNC_H_TAD_REQUESTS_G0.REGION5",
         "PerPkg": "1",
@@ -3129,7 +2833,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1B",
         "EventName": "UNC_H_TAD_REQUESTS_G0.REGION6",
         "PerPkg": "1",
@@ -3139,7 +2842,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1B",
         "EventName": "UNC_H_TAD_REQUESTS_G0.REGION7",
         "PerPkg": "1",
@@ -3149,7 +2851,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 1; TAD Re=
gion 10",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_H_TAD_REQUESTS_G1.REGION10",
         "PerPkg": "1",
@@ -3159,7 +2860,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 1; TAD Re=
gion 11",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_H_TAD_REQUESTS_G1.REGION11",
         "PerPkg": "1",
@@ -3169,7 +2869,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 1; TAD Re=
gion 8",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_H_TAD_REQUESTS_G1.REGION8",
         "PerPkg": "1",
@@ -3179,7 +2878,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 1; TAD Re=
gion 9",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_H_TAD_REQUESTS_G1.REGION9",
         "PerPkg": "1",
@@ -3189,7 +2887,6 @@
     },
     {
         "BriefDescription": "Tracker Cycles Full; Cycles Completely Used",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_H_TRACKER_CYCLES_FULL.ALL",
         "PerPkg": "1",
@@ -3199,7 +2896,6 @@
     },
     {
         "BriefDescription": "Tracker Cycles Full; Cycles GP Completely Use=
d",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_H_TRACKER_CYCLES_FULL.GP",
         "PerPkg": "1",
@@ -3209,7 +2905,6 @@
     },
     {
         "BriefDescription": "Tracker Cycles Not Empty; All Requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3",
         "EventName": "UNC_H_TRACKER_CYCLES_NE.ALL",
         "PerPkg": "1",
@@ -3219,7 +2914,6 @@
     },
     {
         "BriefDescription": "Tracker Cycles Not Empty; Local Requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3",
         "EventName": "UNC_H_TRACKER_CYCLES_NE.LOCAL",
         "PerPkg": "1",
@@ -3229,7 +2923,6 @@
     },
     {
         "BriefDescription": "Tracker Cycles Not Empty; Remote Requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3",
         "EventName": "UNC_H_TRACKER_CYCLES_NE.REMOTE",
         "PerPkg": "1",
@@ -3239,7 +2932,6 @@
     },
     {
         "BriefDescription": "Tracker Occupancy Accumultor; Local InvItoE R=
equests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_H_TRACKER_OCCUPANCY.INVITOE_LOCAL",
         "PerPkg": "1",
@@ -3249,7 +2941,6 @@
     },
     {
         "BriefDescription": "Tracker Occupancy Accumultor; Remote InvItoE =
Requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_H_TRACKER_OCCUPANCY.INVITOE_REMOTE",
         "PerPkg": "1",
@@ -3259,7 +2950,6 @@
     },
     {
         "BriefDescription": "Tracker Occupancy Accumultor; Local Read Requ=
ests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_H_TRACKER_OCCUPANCY.READS_LOCAL",
         "PerPkg": "1",
@@ -3269,7 +2959,6 @@
     },
     {
         "BriefDescription": "Tracker Occupancy Accumultor; Remote Read Req=
uests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_H_TRACKER_OCCUPANCY.READS_REMOTE",
         "PerPkg": "1",
@@ -3279,7 +2968,6 @@
     },
     {
         "BriefDescription": "Tracker Occupancy Accumultor; Local Write Req=
uests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_H_TRACKER_OCCUPANCY.WRITES_LOCAL",
         "PerPkg": "1",
@@ -3289,7 +2977,6 @@
     },
     {
         "BriefDescription": "Tracker Occupancy Accumultor; Remote Write Re=
quests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_H_TRACKER_OCCUPANCY.WRITES_REMOTE",
         "PerPkg": "1",
@@ -3299,7 +2986,6 @@
     },
     {
         "BriefDescription": "Data Pending Occupancy Accumultor; Local Requ=
ests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x5",
         "EventName": "UNC_H_TRACKER_PENDING_OCCUPANCY.LOCAL",
         "PerPkg": "1",
@@ -3309,7 +2995,6 @@
     },
     {
         "BriefDescription": "Data Pending Occupancy Accumultor; Remote Req=
uests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x5",
         "EventName": "UNC_H_TRACKER_PENDING_OCCUPANCY.REMOTE",
         "PerPkg": "1",
@@ -3319,7 +3004,6 @@
     },
     {
         "BriefDescription": "Outbound NDR Ring Transactions; Non-data Resp=
onses",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF",
         "EventName": "UNC_H_TxR_AD.HOM",
         "PerPkg": "1",
@@ -3329,7 +3013,6 @@
     },
     {
         "BriefDescription": "AD Egress Full; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A",
         "EventName": "UNC_H_TxR_AD_CYCLES_FULL.ALL",
         "PerPkg": "1",
@@ -3339,7 +3022,6 @@
     },
     {
         "BriefDescription": "AD Egress Full; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A",
         "EventName": "UNC_H_TxR_AD_CYCLES_FULL.SCHED0",
         "PerPkg": "1",
@@ -3349,7 +3031,6 @@
     },
     {
         "BriefDescription": "AD Egress Full; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A",
         "EventName": "UNC_H_TxR_AD_CYCLES_FULL.SCHED1",
         "PerPkg": "1",
@@ -3359,7 +3040,6 @@
     },
     {
         "BriefDescription": "AD Egress Not Empty; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_H_TxR_AD_CYCLES_NE.ALL",
         "PerPkg": "1",
@@ -3369,7 +3049,6 @@
     },
     {
         "BriefDescription": "AD Egress Not Empty; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_H_TxR_AD_CYCLES_NE.SCHED0",
         "PerPkg": "1",
@@ -3379,7 +3058,6 @@
     },
     {
         "BriefDescription": "AD Egress Not Empty; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_H_TxR_AD_CYCLES_NE.SCHED1",
         "PerPkg": "1",
@@ -3389,7 +3067,6 @@
     },
     {
         "BriefDescription": "AD Egress Allocations; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_H_TxR_AD_INSERTS.ALL",
         "PerPkg": "1",
@@ -3399,7 +3076,6 @@
     },
     {
         "BriefDescription": "AD Egress Allocations; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_H_TxR_AD_INSERTS.SCHED0",
         "PerPkg": "1",
@@ -3409,7 +3085,6 @@
     },
     {
         "BriefDescription": "AD Egress Allocations; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_H_TxR_AD_INSERTS.SCHED1",
         "PerPkg": "1",
@@ -3419,7 +3094,6 @@
     },
     {
         "BriefDescription": "AK Egress Full; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_H_TxR_AK_CYCLES_FULL.ALL",
         "PerPkg": "1",
@@ -3429,7 +3103,6 @@
     },
     {
         "BriefDescription": "AK Egress Full; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_H_TxR_AK_CYCLES_FULL.SCHED0",
         "PerPkg": "1",
@@ -3439,7 +3112,6 @@
     },
     {
         "BriefDescription": "AK Egress Full; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_H_TxR_AK_CYCLES_FULL.SCHED1",
         "PerPkg": "1",
@@ -3449,7 +3121,6 @@
     },
     {
         "BriefDescription": "AK Egress Not Empty; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "UNC_H_TxR_AK_CYCLES_NE.ALL",
         "PerPkg": "1",
@@ -3459,7 +3130,6 @@
     },
     {
         "BriefDescription": "AK Egress Not Empty; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "UNC_H_TxR_AK_CYCLES_NE.SCHED0",
         "PerPkg": "1",
@@ -3469,7 +3139,6 @@
     },
     {
         "BriefDescription": "AK Egress Not Empty; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "UNC_H_TxR_AK_CYCLES_NE.SCHED1",
         "PerPkg": "1",
@@ -3479,7 +3148,6 @@
     },
     {
         "BriefDescription": "AK Egress Allocations; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2F",
         "EventName": "UNC_H_TxR_AK_INSERTS.ALL",
         "PerPkg": "1",
@@ -3489,7 +3157,6 @@
     },
     {
         "BriefDescription": "AK Egress Allocations; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2F",
         "EventName": "UNC_H_TxR_AK_INSERTS.SCHED0",
         "PerPkg": "1",
@@ -3499,7 +3166,6 @@
     },
     {
         "BriefDescription": "AK Egress Allocations; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2F",
         "EventName": "UNC_H_TxR_AK_INSERTS.SCHED1",
         "PerPkg": "1",
@@ -3509,7 +3175,6 @@
     },
     {
         "BriefDescription": "Outbound DRS Ring Transactions to Cache; Data=
 to Cache",
-        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_H_TxR_BL.DRS_CACHE",
         "PerPkg": "1",
@@ -3519,7 +3184,6 @@
     },
     {
         "BriefDescription": "Outbound DRS Ring Transactions to Cache; Data=
 to Core",
-        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_H_TxR_BL.DRS_CORE",
         "PerPkg": "1",
@@ -3529,7 +3193,6 @@
     },
     {
         "BriefDescription": "Outbound DRS Ring Transactions to Cache; Data=
 to QPI",
-        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_H_TxR_BL.DRS_QPI",
         "PerPkg": "1",
@@ -3539,7 +3202,6 @@
     },
     {
         "BriefDescription": "BL Egress Full; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x36",
         "EventName": "UNC_H_TxR_BL_CYCLES_FULL.ALL",
         "PerPkg": "1",
@@ -3549,7 +3211,6 @@
     },
     {
         "BriefDescription": "BL Egress Full; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x36",
         "EventName": "UNC_H_TxR_BL_CYCLES_FULL.SCHED0",
         "PerPkg": "1",
@@ -3559,7 +3220,6 @@
     },
     {
         "BriefDescription": "BL Egress Full; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x36",
         "EventName": "UNC_H_TxR_BL_CYCLES_FULL.SCHED1",
         "PerPkg": "1",
@@ -3569,7 +3229,6 @@
     },
     {
         "BriefDescription": "BL Egress Not Empty; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_H_TxR_BL_CYCLES_NE.ALL",
         "PerPkg": "1",
@@ -3579,7 +3238,6 @@
     },
     {
         "BriefDescription": "BL Egress Not Empty; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_H_TxR_BL_CYCLES_NE.SCHED0",
         "PerPkg": "1",
@@ -3589,7 +3247,6 @@
     },
     {
         "BriefDescription": "BL Egress Not Empty; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_H_TxR_BL_CYCLES_NE.SCHED1",
         "PerPkg": "1",
@@ -3599,7 +3256,6 @@
     },
     {
         "BriefDescription": "BL Egress Allocations; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_H_TxR_BL_INSERTS.ALL",
         "PerPkg": "1",
@@ -3609,7 +3265,6 @@
     },
     {
         "BriefDescription": "BL Egress Allocations; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_H_TxR_BL_INSERTS.SCHED0",
         "PerPkg": "1",
@@ -3619,7 +3274,6 @@
     },
     {
         "BriefDescription": "BL Egress Allocations; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_H_TxR_BL_INSERTS.SCHED1",
         "PerPkg": "1",
@@ -3629,7 +3283,6 @@
     },
     {
         "BriefDescription": "Injection Starvation; For AK Ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6D",
         "EventName": "UNC_H_TxR_STARVED.AK",
         "PerPkg": "1",
@@ -3639,7 +3292,6 @@
     },
     {
         "BriefDescription": "Injection Starvation; For BL Ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6D",
         "EventName": "UNC_H_TxR_STARVED.BL",
         "PerPkg": "1",
@@ -3649,7 +3301,6 @@
     },
     {
         "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Regular; Chan=
nel 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_H_WPQ_CYCLES_NO_REG_CREDITS.CHN0",
         "PerPkg": "1",
@@ -3659,7 +3310,6 @@
     },
     {
         "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Regular; Chan=
nel 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_H_WPQ_CYCLES_NO_REG_CREDITS.CHN1",
         "PerPkg": "1",
@@ -3669,7 +3319,6 @@
     },
     {
         "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Regular; Chan=
nel 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_H_WPQ_CYCLES_NO_REG_CREDITS.CHN2",
         "PerPkg": "1",
@@ -3679,7 +3328,6 @@
     },
     {
         "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Regular; Chan=
nel 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_H_WPQ_CYCLES_NO_REG_CREDITS.CHN3",
         "PerPkg": "1",
@@ -3689,7 +3337,6 @@
     },
     {
         "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Special; Chan=
nel 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_H_WPQ_CYCLES_NO_SPEC_CREDITS.CHN0",
         "PerPkg": "1",
@@ -3699,7 +3346,6 @@
     },
     {
         "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Special; Chan=
nel 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_H_WPQ_CYCLES_NO_SPEC_CREDITS.CHN1",
         "PerPkg": "1",
@@ -3709,7 +3355,6 @@
     },
     {
         "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Special; Chan=
nel 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_H_WPQ_CYCLES_NO_SPEC_CREDITS.CHN2",
         "PerPkg": "1",
@@ -3719,7 +3364,6 @@
     },
     {
         "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Special; Chan=
nel 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_H_WPQ_CYCLES_NO_SPEC_CREDITS.CHN3",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-memory.json =
b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-memory.json
index 83ff0542dbc0..c3f2f6c2ac74 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-memory.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "DRAM Activate Count; Activate due to Write",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_M_ACT_COUNT.BYP",
         "PerPkg": "1",
@@ -11,7 +10,6 @@
     },
     {
         "BriefDescription": "DRAM Activate Count; Activate due to Read",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_M_ACT_COUNT.RD",
         "PerPkg": "1",
@@ -21,7 +19,6 @@
     },
     {
         "BriefDescription": "DRAM Activate Count; Activate due to Write",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_M_ACT_COUNT.WR",
         "PerPkg": "1",
@@ -31,7 +28,6 @@
     },
     {
         "BriefDescription": "ACT command issued by 2 cycle bypass",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UNC_M_BYP_CMDS.ACT",
         "PerPkg": "1",
@@ -40,7 +36,6 @@
     },
     {
         "BriefDescription": "CAS command issued by 2 cycle bypass",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UNC_M_BYP_CMDS.CAS",
         "PerPkg": "1",
@@ -49,7 +44,6 @@
     },
     {
         "BriefDescription": "PRE command issued by 2 cycle bypass",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UNC_M_BYP_CMDS.PRE",
         "PerPkg": "1",
@@ -58,17 +52,15 @@
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; All DRAM WR=
_CAS (w/ and w/out auto-pre)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.ALL",
         "PerPkg": "1",
         "PublicDescription": "DRAM RD_CAS and WR_CAS Commands; Counts the =
total number of DRAM CAS commands issued on this channel.",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; All DRAM Re=
ads (RD_CAS + Underfills)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.RD",
         "PerPkg": "1",
@@ -78,7 +70,6 @@
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; All DRAM RD=
_CAS (w/ and w/out auto-pre)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.RD_REG",
         "PerPkg": "1",
@@ -88,17 +79,14 @@
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; Read CAS is=
sued in RMM",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.RD_RMM",
         "PerPkg": "1",
-        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands",
         "UMask": "0x20",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; Underfill R=
ead Issued",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.RD_UNDERFILL",
         "PerPkg": "1",
@@ -108,27 +96,23 @@
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; Read CAS is=
sued in WMM",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.RD_WMM",
         "PerPkg": "1",
-        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands",
         "UMask": "0x10",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; All DRAM WR=
_CAS (both Modes)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.WR",
         "PerPkg": "1",
         "PublicDescription": "DRAM RD_CAS and WR_CAS Commands; Counts the =
total number of DRAM Write CAS commands issued on this channel.",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; DRAM WR_CAS=
 (w/ and w/out auto-pre) in Read Major Mode",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.WR_RMM",
         "PerPkg": "1",
@@ -138,7 +122,6 @@
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; DRAM WR_CAS=
 (w/ and w/out auto-pre) in Write Major Mode",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.WR_WMM",
         "PerPkg": "1",
@@ -148,14 +131,12 @@
     },
     {
         "BriefDescription": "DRAM Clockticks",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_M_DCLOCKTICKS",
         "PerPkg": "1",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "DRAM Precharge All Commands",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6",
         "EventName": "UNC_M_DRAM_PRE_ALL",
         "PerPkg": "1",
@@ -164,7 +145,6 @@
     },
     {
         "BriefDescription": "Number of DRAM Refreshes Issued",
-        "Counter": "0,1,2,3",
         "EventCode": "0x5",
         "EventName": "UNC_M_DRAM_REFRESH.HIGH",
         "PerPkg": "1",
@@ -174,7 +154,6 @@
     },
     {
         "BriefDescription": "Number of DRAM Refreshes Issued",
-        "Counter": "0,1,2,3",
         "EventCode": "0x5",
         "EventName": "UNC_M_DRAM_REFRESH.PANIC",
         "PerPkg": "1",
@@ -184,7 +163,6 @@
     },
     {
         "BriefDescription": "ECC Correctable Errors",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_M_ECC_CORRECTABLE_ERRORS",
         "PerPkg": "1",
@@ -193,7 +171,6 @@
     },
     {
         "BriefDescription": "Cycles in a Major Mode; Isoch Major Mode",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_M_MAJOR_MODES.ISOCH",
         "PerPkg": "1",
@@ -203,7 +180,6 @@
     },
     {
         "BriefDescription": "Cycles in a Major Mode; Partial Major Mode",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_M_MAJOR_MODES.PARTIAL",
         "PerPkg": "1",
@@ -213,7 +189,6 @@
     },
     {
         "BriefDescription": "Cycles in a Major Mode; Read Major Mode",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_M_MAJOR_MODES.READ",
         "PerPkg": "1",
@@ -223,7 +198,6 @@
     },
     {
         "BriefDescription": "Cycles in a Major Mode; Write Major Mode",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_M_MAJOR_MODES.WRITE",
         "PerPkg": "1",
@@ -233,7 +207,6 @@
     },
     {
         "BriefDescription": "Channel DLLOFF Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_M_POWER_CHANNEL_DLLOFF",
         "PerPkg": "1",
@@ -242,7 +215,6 @@
     },
     {
         "BriefDescription": "Channel PPD Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "UNC_M_POWER_CHANNEL_PPD",
         "PerPkg": "1",
@@ -251,7 +223,6 @@
     },
     {
         "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_M_POWER_CKE_CYCLES.RANK0",
         "PerPkg": "1",
@@ -261,7 +232,6 @@
     },
     {
         "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_M_POWER_CKE_CYCLES.RANK1",
         "PerPkg": "1",
@@ -271,7 +241,6 @@
     },
     {
         "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_M_POWER_CKE_CYCLES.RANK2",
         "PerPkg": "1",
@@ -281,7 +250,6 @@
     },
     {
         "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_M_POWER_CKE_CYCLES.RANK3",
         "PerPkg": "1",
@@ -291,7 +259,6 @@
     },
     {
         "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_M_POWER_CKE_CYCLES.RANK4",
         "PerPkg": "1",
@@ -301,7 +268,6 @@
     },
     {
         "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_M_POWER_CKE_CYCLES.RANK5",
         "PerPkg": "1",
@@ -311,7 +277,6 @@
     },
     {
         "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_M_POWER_CKE_CYCLES.RANK6",
         "PerPkg": "1",
@@ -321,7 +286,6 @@
     },
     {
         "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_M_POWER_CKE_CYCLES.RANK7",
         "PerPkg": "1",
@@ -331,16 +295,20 @@
     },
     {
         "BriefDescription": "Critical Throttle Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_M_POWER_CRITICAL_THROTTLE_CYCLES",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles when the iMC is =
in critical thermal throttling.  When this happens, all traffic is blocked.=
  This should be rare unless something bad is going on in the platform.  Th=
ere is no filtering by rank for this event.",
         "Unit": "iMC"
     },
+    {
+        "EventCode": "0x42",
+        "EventName": "UNC_M_POWER_PCU_THROTTLING",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
     {
         "BriefDescription": "Clock-Enabled Self-Refresh",
-        "Counter": "0,1,2,3",
         "EventCode": "0x43",
         "EventName": "UNC_M_POWER_SELF_REFRESH",
         "PerPkg": "1",
@@ -349,7 +317,6 @@
     },
     {
         "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK0",
         "PerPkg": "1",
@@ -359,7 +326,6 @@
     },
     {
         "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK1",
         "PerPkg": "1",
@@ -369,7 +335,6 @@
     },
     {
         "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK2",
         "PerPkg": "1",
@@ -379,7 +344,6 @@
     },
     {
         "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK3",
         "PerPkg": "1",
@@ -389,7 +353,6 @@
     },
     {
         "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK4",
         "PerPkg": "1",
@@ -399,7 +362,6 @@
     },
     {
         "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK5",
         "PerPkg": "1",
@@ -409,7 +371,6 @@
     },
     {
         "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK6",
         "PerPkg": "1",
@@ -419,7 +380,6 @@
     },
     {
         "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK7",
         "PerPkg": "1",
@@ -429,7 +389,6 @@
     },
     {
         "BriefDescription": "Read Preemption Count; Read over Read Preempt=
ion",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_M_PREEMPTION.RD_PREEMPT_RD",
         "PerPkg": "1",
@@ -439,7 +398,6 @@
     },
     {
         "BriefDescription": "Read Preemption Count; Read over Write Preemp=
tion",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_M_PREEMPTION.RD_PREEMPT_WR",
         "PerPkg": "1",
@@ -449,7 +407,6 @@
     },
     {
         "BriefDescription": "DRAM Precharge commands.; Precharge due to by=
pass",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.BYP",
         "PerPkg": "1",
@@ -459,7 +416,6 @@
     },
     {
         "BriefDescription": "DRAM Precharge commands.; Precharge due to ti=
mer expiration",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.PAGE_CLOSE",
         "PerPkg": "1",
@@ -469,7 +425,6 @@
     },
     {
         "BriefDescription": "DRAM Precharge commands.; Precharges due to p=
age miss",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.PAGE_MISS",
         "PerPkg": "1",
@@ -479,7 +434,6 @@
     },
     {
         "BriefDescription": "DRAM Precharge commands.; Precharge due to re=
ad",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.RD",
         "PerPkg": "1",
@@ -489,7 +443,6 @@
     },
     {
         "BriefDescription": "DRAM Precharge commands.; Precharge due to wr=
ite",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.WR",
         "PerPkg": "1",
@@ -499,7 +452,6 @@
     },
     {
         "BriefDescription": "Read CAS issued with HIGH priority",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA0",
         "EventName": "UNC_M_RD_CAS_PRIO.HIGH",
         "PerPkg": "1",
@@ -508,7 +460,6 @@
     },
     {
         "BriefDescription": "Read CAS issued with LOW priority",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA0",
         "EventName": "UNC_M_RD_CAS_PRIO.LOW",
         "PerPkg": "1",
@@ -517,7 +468,6 @@
     },
     {
         "BriefDescription": "Read CAS issued with MEDIUM priority",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA0",
         "EventName": "UNC_M_RD_CAS_PRIO.MED",
         "PerPkg": "1",
@@ -526,7 +476,6 @@
     },
     {
         "BriefDescription": "Read CAS issued with PANIC NON ISOCH priority=
 (starved)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA0",
         "EventName": "UNC_M_RD_CAS_PRIO.PANIC",
         "PerPkg": "1",
@@ -535,7 +484,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; All Banks",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.ALLBANKS",
         "PerPkg": "1",
@@ -544,7 +492,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK0",
         "PerPkg": "1",
@@ -552,7 +499,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; Bank 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK1",
         "PerPkg": "1",
@@ -561,61 +507,54 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; Bank 10",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK10",
         "PerPkg": "1",
-        "UMask": "0xA",
+        "UMask": "0xa",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; Bank 11",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK11",
         "PerPkg": "1",
-        "UMask": "0xB",
+        "UMask": "0xb",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; Bank 12",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK12",
         "PerPkg": "1",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; Bank 13",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK13",
         "PerPkg": "1",
-        "UMask": "0xD",
+        "UMask": "0xd",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; Bank 14",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK14",
         "PerPkg": "1",
-        "UMask": "0xE",
+        "UMask": "0xe",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; Bank 15",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK15",
         "PerPkg": "1",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; Bank 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK2",
         "PerPkg": "1",
@@ -624,7 +563,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; Bank 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK3",
         "PerPkg": "1",
@@ -633,7 +571,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; Bank 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK4",
         "PerPkg": "1",
@@ -642,7 +579,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; Bank 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK5",
         "PerPkg": "1",
@@ -651,7 +587,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; Bank 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK6",
         "PerPkg": "1",
@@ -660,7 +595,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; Bank 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK7",
         "PerPkg": "1",
@@ -669,7 +603,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; Bank 8",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK8",
         "PerPkg": "1",
@@ -678,7 +611,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; Bank 9",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK9",
         "PerPkg": "1",
@@ -687,7 +619,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; Bank Group 0 (Banks =
0-3)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANKG0",
         "PerPkg": "1",
@@ -696,7 +627,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; Bank Group 1 (Banks =
4-7)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANKG1",
         "PerPkg": "1",
@@ -705,7 +635,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; Bank Group 2 (Banks =
8-11)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANKG2",
         "PerPkg": "1",
@@ -714,7 +643,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; Bank Group 3 (Banks =
12-15)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANKG3",
         "PerPkg": "1",
@@ -723,7 +651,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; All Banks",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.ALLBANKS",
         "PerPkg": "1",
@@ -732,7 +659,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK0",
         "PerPkg": "1",
@@ -740,7 +666,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; Bank 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK1",
         "PerPkg": "1",
@@ -749,61 +674,54 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; Bank 10",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK10",
         "PerPkg": "1",
-        "UMask": "0xA",
+        "UMask": "0xa",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; Bank 11",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK11",
         "PerPkg": "1",
-        "UMask": "0xB",
+        "UMask": "0xb",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; Bank 12",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK12",
         "PerPkg": "1",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; Bank 13",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK13",
         "PerPkg": "1",
-        "UMask": "0xD",
+        "UMask": "0xd",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; Bank 14",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK14",
         "PerPkg": "1",
-        "UMask": "0xE",
+        "UMask": "0xe",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; Bank 15",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK15",
         "PerPkg": "1",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; Bank 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK2",
         "PerPkg": "1",
@@ -812,7 +730,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; Bank 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK3",
         "PerPkg": "1",
@@ -821,7 +738,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; Bank 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK4",
         "PerPkg": "1",
@@ -830,7 +746,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; Bank 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK5",
         "PerPkg": "1",
@@ -839,7 +754,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; Bank 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK6",
         "PerPkg": "1",
@@ -848,7 +762,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; Bank 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK7",
         "PerPkg": "1",
@@ -857,7 +770,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; Bank 8",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK8",
         "PerPkg": "1",
@@ -866,7 +778,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; Bank 9",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK9",
         "PerPkg": "1",
@@ -875,7 +786,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; Bank Group 0 (Banks =
0-3)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANKG0",
         "PerPkg": "1",
@@ -884,7 +794,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; Bank Group 1 (Banks =
4-7)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANKG1",
         "PerPkg": "1",
@@ -893,7 +802,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; Bank Group 2 (Banks =
8-11)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANKG2",
         "PerPkg": "1",
@@ -902,7 +810,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; Bank Group 3 (Banks =
12-15)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANKG3",
         "PerPkg": "1",
@@ -911,7 +818,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 2; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB2",
         "EventName": "UNC_M_RD_CAS_RANK2.BANK0",
         "PerPkg": "1",
@@ -919,7 +825,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; All Banks",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.ALLBANKS",
         "PerPkg": "1",
@@ -928,7 +833,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK0",
         "PerPkg": "1",
@@ -936,7 +840,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; Bank 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK1",
         "PerPkg": "1",
@@ -945,61 +848,54 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; Bank 10",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK10",
         "PerPkg": "1",
-        "UMask": "0xA",
+        "UMask": "0xa",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; Bank 11",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK11",
         "PerPkg": "1",
-        "UMask": "0xB",
+        "UMask": "0xb",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; Bank 12",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK12",
         "PerPkg": "1",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; Bank 13",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK13",
         "PerPkg": "1",
-        "UMask": "0xD",
+        "UMask": "0xd",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; Bank 14",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK14",
         "PerPkg": "1",
-        "UMask": "0xE",
+        "UMask": "0xe",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; Bank 15",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK15",
         "PerPkg": "1",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; Bank 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK2",
         "PerPkg": "1",
@@ -1008,7 +904,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; Bank 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK3",
         "PerPkg": "1",
@@ -1017,7 +912,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; Bank 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK4",
         "PerPkg": "1",
@@ -1026,7 +920,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; Bank 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK5",
         "PerPkg": "1",
@@ -1035,7 +928,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; Bank 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK6",
         "PerPkg": "1",
@@ -1044,7 +936,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; Bank 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK7",
         "PerPkg": "1",
@@ -1053,7 +944,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; Bank 8",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK8",
         "PerPkg": "1",
@@ -1062,7 +952,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; Bank 9",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK9",
         "PerPkg": "1",
@@ -1071,7 +960,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; Bank Group 0 (Banks =
0-3)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANKG0",
         "PerPkg": "1",
@@ -1080,7 +968,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; Bank Group 1 (Banks =
4-7)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANKG1",
         "PerPkg": "1",
@@ -1089,7 +976,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; Bank Group 2 (Banks =
8-11)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANKG2",
         "PerPkg": "1",
@@ -1098,7 +984,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; Bank Group 3 (Banks =
12-15)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANKG3",
         "PerPkg": "1",
@@ -1107,7 +992,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; All Banks",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.ALLBANKS",
         "PerPkg": "1",
@@ -1116,7 +1000,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK0",
         "PerPkg": "1",
@@ -1124,7 +1007,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; Bank 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK1",
         "PerPkg": "1",
@@ -1133,61 +1015,54 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; Bank 10",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK10",
         "PerPkg": "1",
-        "UMask": "0xA",
+        "UMask": "0xa",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; Bank 11",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK11",
         "PerPkg": "1",
-        "UMask": "0xB",
+        "UMask": "0xb",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; Bank 12",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK12",
         "PerPkg": "1",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; Bank 13",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK13",
         "PerPkg": "1",
-        "UMask": "0xD",
+        "UMask": "0xd",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; Bank 14",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK14",
         "PerPkg": "1",
-        "UMask": "0xE",
+        "UMask": "0xe",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; Bank 15",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK15",
         "PerPkg": "1",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; Bank 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK2",
         "PerPkg": "1",
@@ -1196,7 +1071,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; Bank 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK3",
         "PerPkg": "1",
@@ -1205,7 +1079,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; Bank 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK4",
         "PerPkg": "1",
@@ -1214,7 +1087,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; Bank 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK5",
         "PerPkg": "1",
@@ -1223,7 +1095,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; Bank 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK6",
         "PerPkg": "1",
@@ -1232,7 +1103,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; Bank 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK7",
         "PerPkg": "1",
@@ -1241,7 +1111,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; Bank 8",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK8",
         "PerPkg": "1",
@@ -1250,7 +1119,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; Bank 9",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK9",
         "PerPkg": "1",
@@ -1259,7 +1127,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; Bank Group 0 (Banks =
0-3)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANKG0",
         "PerPkg": "1",
@@ -1268,7 +1135,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; Bank Group 1 (Banks =
4-7)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANKG1",
         "PerPkg": "1",
@@ -1277,7 +1143,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; Bank Group 2 (Banks =
8-11)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANKG2",
         "PerPkg": "1",
@@ -1286,7 +1151,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; Bank Group 3 (Banks =
12-15)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANKG3",
         "PerPkg": "1",
@@ -1295,7 +1159,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; All Banks",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.ALLBANKS",
         "PerPkg": "1",
@@ -1304,7 +1167,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK0",
         "PerPkg": "1",
@@ -1312,7 +1174,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; Bank 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK1",
         "PerPkg": "1",
@@ -1321,61 +1182,54 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; Bank 10",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK10",
         "PerPkg": "1",
-        "UMask": "0xA",
+        "UMask": "0xa",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; Bank 11",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK11",
         "PerPkg": "1",
-        "UMask": "0xB",
+        "UMask": "0xb",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; Bank 12",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK12",
         "PerPkg": "1",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; Bank 13",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK13",
         "PerPkg": "1",
-        "UMask": "0xD",
+        "UMask": "0xd",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; Bank 14",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK14",
         "PerPkg": "1",
-        "UMask": "0xE",
+        "UMask": "0xe",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; Bank 15",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK15",
         "PerPkg": "1",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; Bank 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK2",
         "PerPkg": "1",
@@ -1384,7 +1238,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; Bank 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK3",
         "PerPkg": "1",
@@ -1393,7 +1246,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; Bank 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK4",
         "PerPkg": "1",
@@ -1402,7 +1254,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; Bank 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK5",
         "PerPkg": "1",
@@ -1411,7 +1262,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; Bank 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK6",
         "PerPkg": "1",
@@ -1420,7 +1270,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; Bank 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK7",
         "PerPkg": "1",
@@ -1429,7 +1278,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; Bank 8",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK8",
         "PerPkg": "1",
@@ -1438,7 +1286,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; Bank 9",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK9",
         "PerPkg": "1",
@@ -1447,7 +1294,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; Bank Group 0 (Banks =
0-3)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANKG0",
         "PerPkg": "1",
@@ -1456,7 +1302,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; Bank Group 1 (Banks =
4-7)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANKG1",
         "PerPkg": "1",
@@ -1465,7 +1310,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; Bank Group 2 (Banks =
8-11)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANKG2",
         "PerPkg": "1",
@@ -1474,7 +1318,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; Bank Group 3 (Banks =
12-15)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANKG3",
         "PerPkg": "1",
@@ -1483,7 +1326,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; All Banks",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.ALLBANKS",
         "PerPkg": "1",
@@ -1492,7 +1334,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK0",
         "PerPkg": "1",
@@ -1500,7 +1341,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; Bank 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK1",
         "PerPkg": "1",
@@ -1509,61 +1349,54 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; Bank 10",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK10",
         "PerPkg": "1",
-        "UMask": "0xA",
+        "UMask": "0xa",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; Bank 11",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK11",
         "PerPkg": "1",
-        "UMask": "0xB",
+        "UMask": "0xb",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; Bank 12",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK12",
         "PerPkg": "1",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; Bank 13",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK13",
         "PerPkg": "1",
-        "UMask": "0xD",
+        "UMask": "0xd",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; Bank 14",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK14",
         "PerPkg": "1",
-        "UMask": "0xE",
+        "UMask": "0xe",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; Bank 15",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK15",
         "PerPkg": "1",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; Bank 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK2",
         "PerPkg": "1",
@@ -1572,7 +1405,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; Bank 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK3",
         "PerPkg": "1",
@@ -1581,7 +1413,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; Bank 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK4",
         "PerPkg": "1",
@@ -1590,7 +1421,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; Bank 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK5",
         "PerPkg": "1",
@@ -1599,7 +1429,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; Bank 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK6",
         "PerPkg": "1",
@@ -1608,7 +1437,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; Bank 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK7",
         "PerPkg": "1",
@@ -1617,7 +1445,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; Bank 8",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK8",
         "PerPkg": "1",
@@ -1626,7 +1453,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; Bank 9",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK9",
         "PerPkg": "1",
@@ -1635,7 +1461,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; Bank Group 0 (Banks =
0-3)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANKG0",
         "PerPkg": "1",
@@ -1644,7 +1469,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; Bank Group 1 (Banks =
4-7)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANKG1",
         "PerPkg": "1",
@@ -1653,7 +1477,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; Bank Group 2 (Banks =
8-11)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANKG2",
         "PerPkg": "1",
@@ -1662,7 +1485,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; Bank Group 3 (Banks =
12-15)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANKG3",
         "PerPkg": "1",
@@ -1671,7 +1493,6 @@
     },
     {
         "BriefDescription": "Read Pending Queue Not Empty",
-        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "UNC_M_RPQ_CYCLES_NE",
         "PerPkg": "1",
@@ -1680,7 +1501,6 @@
     },
     {
         "BriefDescription": "Read Pending Queue Allocations",
-        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M_RPQ_INSERTS",
         "PerPkg": "1",
@@ -1689,7 +1509,6 @@
     },
     {
         "BriefDescription": "VMSE MXB write buffer occupancy",
-        "Counter": "0,1,2,3",
         "EventCode": "0x91",
         "EventName": "UNC_M_VMSE_MXB_WR_OCCUPANCY",
         "PerPkg": "1",
@@ -1697,7 +1516,6 @@
     },
     {
         "BriefDescription": "VMSE WR PUSH issued; VMSE write PUSH issued i=
n RMM",
-        "Counter": "0,1,2,3",
         "EventCode": "0x90",
         "EventName": "UNC_M_VMSE_WR_PUSH.RMM",
         "PerPkg": "1",
@@ -1706,7 +1524,6 @@
     },
     {
         "BriefDescription": "VMSE WR PUSH issued; VMSE write PUSH issued i=
n WMM",
-        "Counter": "0,1,2,3",
         "EventCode": "0x90",
         "EventName": "UNC_M_VMSE_WR_PUSH.WMM",
         "PerPkg": "1",
@@ -1715,7 +1532,6 @@
     },
     {
         "BriefDescription": "Transition from WMM to RMM because of low thr=
eshold; Transition from WMM to RMM because of starve counter",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC0",
         "EventName": "UNC_M_WMM_TO_RMM.LOW_THRESH",
         "PerPkg": "1",
@@ -1724,7 +1540,6 @@
     },
     {
         "BriefDescription": "Transition from WMM to RMM because of low thr=
eshold",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC0",
         "EventName": "UNC_M_WMM_TO_RMM.STARVE",
         "PerPkg": "1",
@@ -1733,7 +1548,6 @@
     },
     {
         "BriefDescription": "Transition from WMM to RMM because of low thr=
eshold",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC0",
         "EventName": "UNC_M_WMM_TO_RMM.VMSE_RETRY",
         "PerPkg": "1",
@@ -1742,7 +1556,6 @@
     },
     {
         "BriefDescription": "Write Pending Queue Full Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_M_WPQ_CYCLES_FULL",
         "PerPkg": "1",
@@ -1751,7 +1564,6 @@
     },
     {
         "BriefDescription": "Write Pending Queue Not Empty",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M_WPQ_CYCLES_NE",
         "PerPkg": "1",
@@ -1760,7 +1572,6 @@
     },
     {
         "BriefDescription": "Write Pending Queue CAM Match",
-        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_M_WPQ_READ_HIT",
         "PerPkg": "1",
@@ -1769,7 +1580,6 @@
     },
     {
         "BriefDescription": "Write Pending Queue CAM Match",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M_WPQ_WRITE_HIT",
         "PerPkg": "1",
@@ -1778,7 +1588,6 @@
     },
     {
         "BriefDescription": "Not getting the requested Major Mode",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC1",
         "EventName": "UNC_M_WRONG_MM",
         "PerPkg": "1",
@@ -1786,7 +1595,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; All Banks",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.ALLBANKS",
         "PerPkg": "1",
@@ -1795,7 +1603,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK0",
         "PerPkg": "1",
@@ -1803,7 +1610,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; Bank 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK1",
         "PerPkg": "1",
@@ -1812,61 +1618,54 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; Bank 10",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK10",
         "PerPkg": "1",
-        "UMask": "0xA",
+        "UMask": "0xa",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; Bank 11",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK11",
         "PerPkg": "1",
-        "UMask": "0xB",
+        "UMask": "0xb",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; Bank 12",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK12",
         "PerPkg": "1",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; Bank 13",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK13",
         "PerPkg": "1",
-        "UMask": "0xD",
+        "UMask": "0xd",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; Bank 14",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK14",
         "PerPkg": "1",
-        "UMask": "0xE",
+        "UMask": "0xe",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; Bank 15",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK15",
         "PerPkg": "1",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; Bank 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK2",
         "PerPkg": "1",
@@ -1875,7 +1674,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; Bank 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK3",
         "PerPkg": "1",
@@ -1884,7 +1682,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; Bank 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK4",
         "PerPkg": "1",
@@ -1893,7 +1690,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; Bank 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK5",
         "PerPkg": "1",
@@ -1902,7 +1698,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; Bank 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK6",
         "PerPkg": "1",
@@ -1911,7 +1706,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; Bank 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK7",
         "PerPkg": "1",
@@ -1920,7 +1714,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; Bank 8",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK8",
         "PerPkg": "1",
@@ -1929,7 +1722,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; Bank 9",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK9",
         "PerPkg": "1",
@@ -1938,7 +1730,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; Bank Group 0 (Banks =
0-3)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANKG0",
         "PerPkg": "1",
@@ -1947,7 +1738,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; Bank Group 1 (Banks =
4-7)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANKG1",
         "PerPkg": "1",
@@ -1956,7 +1746,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; Bank Group 2 (Banks =
8-11)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANKG2",
         "PerPkg": "1",
@@ -1965,7 +1754,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; Bank Group 3 (Banks =
12-15)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANKG3",
         "PerPkg": "1",
@@ -1974,7 +1762,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; All Banks",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.ALLBANKS",
         "PerPkg": "1",
@@ -1983,7 +1770,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK0",
         "PerPkg": "1",
@@ -1991,7 +1777,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; Bank 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK1",
         "PerPkg": "1",
@@ -2000,61 +1785,54 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; Bank 10",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK10",
         "PerPkg": "1",
-        "UMask": "0xA",
+        "UMask": "0xa",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; Bank 11",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK11",
         "PerPkg": "1",
-        "UMask": "0xB",
+        "UMask": "0xb",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; Bank 12",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK12",
         "PerPkg": "1",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; Bank 13",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK13",
         "PerPkg": "1",
-        "UMask": "0xD",
+        "UMask": "0xd",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; Bank 14",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK14",
         "PerPkg": "1",
-        "UMask": "0xE",
+        "UMask": "0xe",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; Bank 15",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK15",
         "PerPkg": "1",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; Bank 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK2",
         "PerPkg": "1",
@@ -2063,7 +1841,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; Bank 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK3",
         "PerPkg": "1",
@@ -2072,7 +1849,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; Bank 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK4",
         "PerPkg": "1",
@@ -2081,7 +1857,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; Bank 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK5",
         "PerPkg": "1",
@@ -2090,7 +1865,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; Bank 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK6",
         "PerPkg": "1",
@@ -2099,7 +1873,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; Bank 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK7",
         "PerPkg": "1",
@@ -2108,7 +1881,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; Bank 8",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK8",
         "PerPkg": "1",
@@ -2117,7 +1889,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; Bank 9",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK9",
         "PerPkg": "1",
@@ -2126,7 +1897,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; Bank Group 0 (Banks =
0-3)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANKG0",
         "PerPkg": "1",
@@ -2135,7 +1905,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; Bank Group 1 (Banks =
4-7)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANKG1",
         "PerPkg": "1",
@@ -2144,7 +1913,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; Bank Group 2 (Banks =
8-11)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANKG2",
         "PerPkg": "1",
@@ -2153,7 +1921,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; Bank Group 3 (Banks =
12-15)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANKG3",
         "PerPkg": "1",
@@ -2162,7 +1929,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; All Banks",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.ALLBANKS",
         "PerPkg": "1",
@@ -2171,7 +1937,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK0",
         "PerPkg": "1",
@@ -2179,7 +1944,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; Bank 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK1",
         "PerPkg": "1",
@@ -2188,61 +1952,54 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; Bank 10",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK10",
         "PerPkg": "1",
-        "UMask": "0xA",
+        "UMask": "0xa",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; Bank 11",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK11",
         "PerPkg": "1",
-        "UMask": "0xB",
+        "UMask": "0xb",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; Bank 12",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK12",
         "PerPkg": "1",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; Bank 13",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK13",
         "PerPkg": "1",
-        "UMask": "0xD",
+        "UMask": "0xd",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; Bank 14",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK14",
         "PerPkg": "1",
-        "UMask": "0xE",
+        "UMask": "0xe",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; Bank 15",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK15",
         "PerPkg": "1",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; Bank 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK2",
         "PerPkg": "1",
@@ -2251,7 +2008,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; Bank 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK3",
         "PerPkg": "1",
@@ -2260,7 +2016,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; Bank 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK4",
         "PerPkg": "1",
@@ -2269,7 +2024,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; Bank 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK5",
         "PerPkg": "1",
@@ -2278,7 +2032,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; Bank 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK6",
         "PerPkg": "1",
@@ -2287,7 +2040,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; Bank 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK7",
         "PerPkg": "1",
@@ -2296,7 +2048,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; Bank 8",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK8",
         "PerPkg": "1",
@@ -2305,7 +2056,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; Bank 9",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK9",
         "PerPkg": "1",
@@ -2314,7 +2064,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; Bank Group 0 (Banks =
0-3)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANKG0",
         "PerPkg": "1",
@@ -2323,7 +2072,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; Bank Group 1 (Banks =
4-7)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANKG1",
         "PerPkg": "1",
@@ -2332,7 +2080,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; Bank Group 2 (Banks =
8-11)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANKG2",
         "PerPkg": "1",
@@ -2341,7 +2088,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; Bank Group 3 (Banks =
12-15)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANKG3",
         "PerPkg": "1",
@@ -2350,7 +2096,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; All Banks",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.ALLBANKS",
         "PerPkg": "1",
@@ -2359,7 +2104,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK0",
         "PerPkg": "1",
@@ -2367,7 +2111,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; Bank 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK1",
         "PerPkg": "1",
@@ -2376,61 +2119,54 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; Bank 10",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK10",
         "PerPkg": "1",
-        "UMask": "0xA",
+        "UMask": "0xa",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; Bank 11",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK11",
         "PerPkg": "1",
-        "UMask": "0xB",
+        "UMask": "0xb",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; Bank 12",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK12",
         "PerPkg": "1",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; Bank 13",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK13",
         "PerPkg": "1",
-        "UMask": "0xD",
+        "UMask": "0xd",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; Bank 14",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK14",
         "PerPkg": "1",
-        "UMask": "0xE",
+        "UMask": "0xe",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; Bank 15",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK15",
         "PerPkg": "1",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; Bank 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK2",
         "PerPkg": "1",
@@ -2439,7 +2175,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; Bank 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK3",
         "PerPkg": "1",
@@ -2448,7 +2183,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; Bank 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK4",
         "PerPkg": "1",
@@ -2457,7 +2191,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; Bank 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK5",
         "PerPkg": "1",
@@ -2466,7 +2199,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; Bank 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK6",
         "PerPkg": "1",
@@ -2475,7 +2207,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; Bank 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK7",
         "PerPkg": "1",
@@ -2484,7 +2215,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; Bank 8",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK8",
         "PerPkg": "1",
@@ -2493,7 +2223,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; Bank 9",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK9",
         "PerPkg": "1",
@@ -2502,7 +2231,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; Bank Group 0 (Banks =
0-3)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANKG0",
         "PerPkg": "1",
@@ -2511,7 +2239,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; Bank Group 1 (Banks =
4-7)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANKG1",
         "PerPkg": "1",
@@ -2520,7 +2247,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; Bank Group 2 (Banks =
8-11)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANKG2",
         "PerPkg": "1",
@@ -2529,7 +2255,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; Bank Group 3 (Banks =
12-15)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANKG3",
         "PerPkg": "1",
@@ -2538,7 +2263,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; All Banks",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.ALLBANKS",
         "PerPkg": "1",
@@ -2547,7 +2271,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK0",
         "PerPkg": "1",
@@ -2555,7 +2278,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; Bank 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK1",
         "PerPkg": "1",
@@ -2564,61 +2286,54 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; Bank 10",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK10",
         "PerPkg": "1",
-        "UMask": "0xA",
+        "UMask": "0xa",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; Bank 11",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK11",
         "PerPkg": "1",
-        "UMask": "0xB",
+        "UMask": "0xb",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; Bank 12",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK12",
         "PerPkg": "1",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; Bank 13",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK13",
         "PerPkg": "1",
-        "UMask": "0xD",
+        "UMask": "0xd",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; Bank 14",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK14",
         "PerPkg": "1",
-        "UMask": "0xE",
+        "UMask": "0xe",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; Bank 15",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK15",
         "PerPkg": "1",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; Bank 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK2",
         "PerPkg": "1",
@@ -2627,7 +2342,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; Bank 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK3",
         "PerPkg": "1",
@@ -2636,7 +2350,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; Bank 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK4",
         "PerPkg": "1",
@@ -2645,7 +2358,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; Bank 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK5",
         "PerPkg": "1",
@@ -2654,7 +2366,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; Bank 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK6",
         "PerPkg": "1",
@@ -2663,7 +2374,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; Bank 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK7",
         "PerPkg": "1",
@@ -2672,7 +2382,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; Bank 8",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK8",
         "PerPkg": "1",
@@ -2681,7 +2390,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; Bank 9",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK9",
         "PerPkg": "1",
@@ -2690,7 +2398,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; Bank Group 0 (Banks =
0-3)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANKG0",
         "PerPkg": "1",
@@ -2699,7 +2406,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; Bank Group 1 (Banks =
4-7)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANKG1",
         "PerPkg": "1",
@@ -2708,7 +2414,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; Bank Group 2 (Banks =
8-11)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANKG2",
         "PerPkg": "1",
@@ -2717,7 +2422,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; Bank Group 3 (Banks =
12-15)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANKG3",
         "PerPkg": "1",
@@ -2726,7 +2430,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; All Banks",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.ALLBANKS",
         "PerPkg": "1",
@@ -2735,7 +2438,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK0",
         "PerPkg": "1",
@@ -2743,7 +2445,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; Bank 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK1",
         "PerPkg": "1",
@@ -2752,61 +2453,54 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; Bank 10",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK10",
         "PerPkg": "1",
-        "UMask": "0xA",
+        "UMask": "0xa",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; Bank 11",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK11",
         "PerPkg": "1",
-        "UMask": "0xB",
+        "UMask": "0xb",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; Bank 12",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK12",
         "PerPkg": "1",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; Bank 13",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK13",
         "PerPkg": "1",
-        "UMask": "0xD",
+        "UMask": "0xd",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; Bank 14",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK14",
         "PerPkg": "1",
-        "UMask": "0xE",
+        "UMask": "0xe",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; Bank 15",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK15",
         "PerPkg": "1",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; Bank 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK2",
         "PerPkg": "1",
@@ -2815,7 +2509,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; Bank 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK3",
         "PerPkg": "1",
@@ -2824,7 +2517,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; Bank 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK4",
         "PerPkg": "1",
@@ -2833,7 +2525,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; Bank 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK5",
         "PerPkg": "1",
@@ -2842,7 +2533,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; Bank 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK6",
         "PerPkg": "1",
@@ -2851,7 +2541,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; Bank 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK7",
         "PerPkg": "1",
@@ -2860,7 +2549,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; Bank 8",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK8",
         "PerPkg": "1",
@@ -2869,7 +2557,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; Bank 9",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK9",
         "PerPkg": "1",
@@ -2878,7 +2565,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; Bank Group 0 (Banks =
0-3)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANKG0",
         "PerPkg": "1",
@@ -2887,7 +2573,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; Bank Group 1 (Banks =
4-7)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANKG1",
         "PerPkg": "1",
@@ -2896,7 +2581,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; Bank Group 2 (Banks =
8-11)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANKG2",
         "PerPkg": "1",
@@ -2905,7 +2589,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; Bank Group 3 (Banks =
12-15)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANKG3",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-other.json b=
/tools/perf/pmu-events/arch/x86/broadwellde/uncore-other.json
index fc7e0867fcc5..753b381b77fe 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-other.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "Total Write Cache Occupancy; Any Source",
-        "Counter": "0,1",
         "EventCode": "0x12",
         "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.ANY",
         "PerPkg": "1",
@@ -11,7 +10,6 @@
     },
     {
         "BriefDescription": "Total Write Cache Occupancy; Select Source",
-        "Counter": "0,1",
         "EventCode": "0x12",
         "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.SOURCE",
         "PerPkg": "1",
@@ -21,7 +19,6 @@
     },
     {
         "BriefDescription": "Clocks in the IRP",
-        "Counter": "0,1",
         "EventName": "UNC_I_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "Number of clocks in the IRP.",
@@ -29,7 +26,6 @@
     },
     {
         "BriefDescription": "Coherent Ops; CLFlush",
-        "Counter": "0,1",
         "EventCode": "0x13",
         "EventName": "UNC_I_COHERENT_OPS.CLFLUSH",
         "PerPkg": "1",
@@ -39,7 +35,6 @@
     },
     {
         "BriefDescription": "Coherent Ops; CRd",
-        "Counter": "0,1",
         "EventCode": "0x13",
         "EventName": "UNC_I_COHERENT_OPS.CRD",
         "PerPkg": "1",
@@ -49,7 +44,6 @@
     },
     {
         "BriefDescription": "Coherent Ops; DRd",
-        "Counter": "0,1",
         "EventCode": "0x13",
         "EventName": "UNC_I_COHERENT_OPS.DRD",
         "PerPkg": "1",
@@ -59,7 +53,6 @@
     },
     {
         "BriefDescription": "Coherent Ops; PCIDCAHin5t",
-        "Counter": "0,1",
         "EventCode": "0x13",
         "EventName": "UNC_I_COHERENT_OPS.PCIDCAHINT",
         "PerPkg": "1",
@@ -69,7 +62,6 @@
     },
     {
         "BriefDescription": "Coherent Ops; PCIRdCur",
-        "Counter": "0,1",
         "EventCode": "0x13",
         "EventName": "UNC_I_COHERENT_OPS.PCIRDCUR",
         "PerPkg": "1",
@@ -79,7 +71,6 @@
     },
     {
         "BriefDescription": "Coherent Ops; PCIItoM",
-        "Counter": "0,1",
         "EventCode": "0x13",
         "EventName": "UNC_I_COHERENT_OPS.PCITOM",
         "PerPkg": "1",
@@ -89,7 +80,6 @@
     },
     {
         "BriefDescription": "Coherent Ops; RFO",
-        "Counter": "0,1",
         "EventCode": "0x13",
         "EventName": "UNC_I_COHERENT_OPS.RFO",
         "PerPkg": "1",
@@ -99,7 +89,6 @@
     },
     {
         "BriefDescription": "Coherent Ops; WbMtoI",
-        "Counter": "0,1",
         "EventCode": "0x13",
         "EventName": "UNC_I_COHERENT_OPS.WBMTOI",
         "PerPkg": "1",
@@ -109,7 +98,6 @@
     },
     {
         "BriefDescription": "Misc Events - Set 0; Cache Inserts of Atomic =
Transactions as Secondary",
-        "Counter": "0,1",
         "EventCode": "0x14",
         "EventName": "UNC_I_MISC0.2ND_ATOMIC_INSERT",
         "PerPkg": "1",
@@ -118,7 +106,6 @@
     },
     {
         "BriefDescription": "Misc Events - Set 0; Cache Inserts of Read Tr=
ansactions as Secondary",
-        "Counter": "0,1",
         "EventCode": "0x14",
         "EventName": "UNC_I_MISC0.2ND_RD_INSERT",
         "PerPkg": "1",
@@ -127,7 +114,6 @@
     },
     {
         "BriefDescription": "Misc Events - Set 0; Cache Inserts of Write T=
ransactions as Secondary",
-        "Counter": "0,1",
         "EventCode": "0x14",
         "EventName": "UNC_I_MISC0.2ND_WR_INSERT",
         "PerPkg": "1",
@@ -136,7 +122,6 @@
     },
     {
         "BriefDescription": "Misc Events - Set 0; Fastpath Rejects",
-        "Counter": "0,1",
         "EventCode": "0x14",
         "EventName": "UNC_I_MISC0.FAST_REJ",
         "PerPkg": "1",
@@ -145,7 +130,6 @@
     },
     {
         "BriefDescription": "Misc Events - Set 0; Fastpath Requests",
-        "Counter": "0,1",
         "EventCode": "0x14",
         "EventName": "UNC_I_MISC0.FAST_REQ",
         "PerPkg": "1",
@@ -154,7 +138,6 @@
     },
     {
         "BriefDescription": "Misc Events - Set 0; Fastpath Transfers From =
Primary to Secondary",
-        "Counter": "0,1",
         "EventCode": "0x14",
         "EventName": "UNC_I_MISC0.FAST_XFER",
         "PerPkg": "1",
@@ -163,7 +146,6 @@
     },
     {
         "BriefDescription": "Misc Events - Set 0; Prefetch Ack Hints From =
Primary to Secondary",
-        "Counter": "0,1",
         "EventCode": "0x14",
         "EventName": "UNC_I_MISC0.PF_ACK_HINT",
         "PerPkg": "1",
@@ -172,7 +154,6 @@
     },
     {
         "BriefDescription": "Misc Events - Set 0; Prefetch TimeOut",
-        "Counter": "0,1",
         "EventCode": "0x14",
         "EventName": "UNC_I_MISC0.PF_TIMEOUT",
         "PerPkg": "1",
@@ -182,7 +163,6 @@
     },
     {
         "BriefDescription": "Misc Events - Set 1; Data Throttled",
-        "Counter": "0,1",
         "EventCode": "0x15",
         "EventName": "UNC_I_MISC1.DATA_THROTTLE",
         "PerPkg": "1",
@@ -192,7 +172,6 @@
     },
     {
         "BriefDescription": "Misc Events - Set 1",
-        "Counter": "0,1",
         "EventCode": "0x15",
         "EventName": "UNC_I_MISC1.LOST_FWD",
         "PerPkg": "1",
@@ -201,7 +180,6 @@
     },
     {
         "BriefDescription": "Misc Events - Set 1; Received Invalid",
-        "Counter": "0,1",
         "EventCode": "0x15",
         "EventName": "UNC_I_MISC1.SEC_RCVD_INVLD",
         "PerPkg": "1",
@@ -211,7 +189,6 @@
     },
     {
         "BriefDescription": "Misc Events - Set 1; Received Valid",
-        "Counter": "0,1",
         "EventCode": "0x15",
         "EventName": "UNC_I_MISC1.SEC_RCVD_VLD",
         "PerPkg": "1",
@@ -221,7 +198,6 @@
     },
     {
         "BriefDescription": "Misc Events - Set 1; Slow Transfer of E Line"=
,
-        "Counter": "0,1",
         "EventCode": "0x15",
         "EventName": "UNC_I_MISC1.SLOW_E",
         "PerPkg": "1",
@@ -231,7 +207,6 @@
     },
     {
         "BriefDescription": "Misc Events - Set 1; Slow Transfer of I Line"=
,
-        "Counter": "0,1",
         "EventCode": "0x15",
         "EventName": "UNC_I_MISC1.SLOW_I",
         "PerPkg": "1",
@@ -241,7 +216,6 @@
     },
     {
         "BriefDescription": "Misc Events - Set 1; Slow Transfer of M Line"=
,
-        "Counter": "0,1",
         "EventCode": "0x15",
         "EventName": "UNC_I_MISC1.SLOW_M",
         "PerPkg": "1",
@@ -251,7 +225,6 @@
     },
     {
         "BriefDescription": "Misc Events - Set 1; Slow Transfer of S Line"=
,
-        "Counter": "0,1",
         "EventCode": "0x15",
         "EventName": "UNC_I_MISC1.SLOW_S",
         "PerPkg": "1",
@@ -261,7 +234,6 @@
     },
     {
         "BriefDescription": "AK Ingress Occupancy",
-        "Counter": "0,1",
         "EventCode": "0xA",
         "EventName": "UNC_I_RxR_AK_INSERTS",
         "PerPkg": "1",
@@ -269,7 +241,6 @@
         "Unit": "IRP"
     },
     {
-        "Counter": "0,1",
         "EventCode": "0x4",
         "EventName": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
         "PerPkg": "1",
@@ -278,7 +249,6 @@
     },
     {
         "BriefDescription": "BL Ingress Occupancy - DRS",
-        "Counter": "0,1",
         "EventCode": "0x1",
         "EventName": "UNC_I_RxR_BL_DRS_INSERTS",
         "PerPkg": "1",
@@ -286,7 +256,6 @@
         "Unit": "IRP"
     },
     {
-        "Counter": "0,1",
         "EventCode": "0x7",
         "EventName": "UNC_I_RxR_BL_DRS_OCCUPANCY",
         "PerPkg": "1",
@@ -294,7 +263,6 @@
         "Unit": "IRP"
     },
     {
-        "Counter": "0,1",
         "EventCode": "0x5",
         "EventName": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
         "PerPkg": "1",
@@ -303,7 +271,6 @@
     },
     {
         "BriefDescription": "BL Ingress Occupancy - NCB",
-        "Counter": "0,1",
         "EventCode": "0x2",
         "EventName": "UNC_I_RxR_BL_NCB_INSERTS",
         "PerPkg": "1",
@@ -311,7 +278,6 @@
         "Unit": "IRP"
     },
     {
-        "Counter": "0,1",
         "EventCode": "0x8",
         "EventName": "UNC_I_RxR_BL_NCB_OCCUPANCY",
         "PerPkg": "1",
@@ -319,7 +285,6 @@
         "Unit": "IRP"
     },
     {
-        "Counter": "0,1",
         "EventCode": "0x6",
         "EventName": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
         "PerPkg": "1",
@@ -328,7 +293,6 @@
     },
     {
         "BriefDescription": "BL Ingress Occupancy - NCS",
-        "Counter": "0,1",
         "EventCode": "0x3",
         "EventName": "UNC_I_RxR_BL_NCS_INSERTS",
         "PerPkg": "1",
@@ -336,7 +300,6 @@
         "Unit": "IRP"
     },
     {
-        "Counter": "0,1",
         "EventCode": "0x9",
         "EventName": "UNC_I_RxR_BL_NCS_OCCUPANCY",
         "PerPkg": "1",
@@ -345,7 +308,6 @@
     },
     {
         "BriefDescription": "Snoop Responses; Hit E or S",
-        "Counter": "0,1",
         "EventCode": "0x17",
         "EventName": "UNC_I_SNOOP_RESP.HIT_ES",
         "PerPkg": "1",
@@ -354,7 +316,6 @@
     },
     {
         "BriefDescription": "Snoop Responses; Hit I",
-        "Counter": "0,1",
         "EventCode": "0x17",
         "EventName": "UNC_I_SNOOP_RESP.HIT_I",
         "PerPkg": "1",
@@ -363,7 +324,6 @@
     },
     {
         "BriefDescription": "Snoop Responses; Hit M",
-        "Counter": "0,1",
         "EventCode": "0x17",
         "EventName": "UNC_I_SNOOP_RESP.HIT_M",
         "PerPkg": "1",
@@ -372,7 +332,6 @@
     },
     {
         "BriefDescription": "Snoop Responses; Miss",
-        "Counter": "0,1",
         "EventCode": "0x17",
         "EventName": "UNC_I_SNOOP_RESP.MISS",
         "PerPkg": "1",
@@ -381,7 +340,6 @@
     },
     {
         "BriefDescription": "Snoop Responses; SnpCode",
-        "Counter": "0,1",
         "EventCode": "0x17",
         "EventName": "UNC_I_SNOOP_RESP.SNPCODE",
         "PerPkg": "1",
@@ -390,7 +348,6 @@
     },
     {
         "BriefDescription": "Snoop Responses; SnpData",
-        "Counter": "0,1",
         "EventCode": "0x17",
         "EventName": "UNC_I_SNOOP_RESP.SNPDATA",
         "PerPkg": "1",
@@ -399,7 +356,6 @@
     },
     {
         "BriefDescription": "Snoop Responses; SnpInv",
-        "Counter": "0,1",
         "EventCode": "0x17",
         "EventName": "UNC_I_SNOOP_RESP.SNPINV",
         "PerPkg": "1",
@@ -408,7 +364,6 @@
     },
     {
         "BriefDescription": "Inbound Transaction Count; Atomic",
-        "Counter": "0,1",
         "EventCode": "0x16",
         "EventName": "UNC_I_TRANSACTIONS.ATOMIC",
         "PerPkg": "1",
@@ -418,7 +373,6 @@
     },
     {
         "BriefDescription": "Inbound Transaction Count; Other",
-        "Counter": "0,1",
         "EventCode": "0x16",
         "EventName": "UNC_I_TRANSACTIONS.OTHER",
         "PerPkg": "1",
@@ -428,7 +382,6 @@
     },
     {
         "BriefDescription": "Inbound Transaction Count; Read Prefetches",
-        "Counter": "0,1",
         "EventCode": "0x16",
         "EventName": "UNC_I_TRANSACTIONS.RD_PREF",
         "PerPkg": "1",
@@ -438,7 +391,6 @@
     },
     {
         "BriefDescription": "Inbound Transaction Count; Reads",
-        "Counter": "0,1",
         "EventCode": "0x16",
         "EventName": "UNC_I_TRANSACTIONS.READS",
         "PerPkg": "1",
@@ -448,7 +400,6 @@
     },
     {
         "BriefDescription": "Inbound Transaction Count; Writes",
-        "Counter": "0,1",
         "EventCode": "0x16",
         "EventName": "UNC_I_TRANSACTIONS.WRITES",
         "PerPkg": "1",
@@ -458,7 +409,6 @@
     },
     {
         "BriefDescription": "Inbound Transaction Count; Write Prefetches",
-        "Counter": "0,1",
         "EventCode": "0x16",
         "EventName": "UNC_I_TRANSACTIONS.WR_PREF",
         "PerPkg": "1",
@@ -468,7 +418,6 @@
     },
     {
         "BriefDescription": "No AD Egress Credit Stalls",
-        "Counter": "0,1",
         "EventCode": "0x18",
         "EventName": "UNC_I_TxR_AD_STALL_CREDIT_CYCLES",
         "PerPkg": "1",
@@ -477,7 +426,6 @@
     },
     {
         "BriefDescription": "No BL Egress Credit Stalls",
-        "Counter": "0,1",
         "EventCode": "0x19",
         "EventName": "UNC_I_TxR_BL_STALL_CREDIT_CYCLES",
         "PerPkg": "1",
@@ -486,7 +434,6 @@
     },
     {
         "BriefDescription": "Outbound Read Requests",
-        "Counter": "0,1",
         "EventCode": "0xE",
         "EventName": "UNC_I_TxR_DATA_INSERTS_NCB",
         "PerPkg": "1",
@@ -495,7 +442,6 @@
     },
     {
         "BriefDescription": "Outbound Read Requests",
-        "Counter": "0,1",
         "EventCode": "0xF",
         "EventName": "UNC_I_TxR_DATA_INSERTS_NCS",
         "PerPkg": "1",
@@ -504,7 +450,6 @@
     },
     {
         "BriefDescription": "Outbound Request Queue Occupancy",
-        "Counter": "0,1",
         "EventCode": "0xD",
         "EventName": "UNC_I_TxR_REQUEST_OCCUPANCY",
         "PerPkg": "1",
@@ -513,16 +458,42 @@
     },
     {
         "BriefDescription": "Number of uclks in domain",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_R2_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of uclks in the R2PCIe ucl=
k domain.  This could be slightly different than the count in the Ubox beca=
use of enable/freeze delays.  However, because the R2PCIe is close to the U=
box, they generally should not diverge by more than a handful of cycles.",
         "Unit": "R2PCIe"
     },
+    {
+        "EventCode": "0x2D",
+        "EventName": "UNC_R2_IIO_CREDIT.ISOCH_QPI0",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "EventCode": "0x2D",
+        "EventName": "UNC_R2_IIO_CREDIT.ISOCH_QPI1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "EventCode": "0x2D",
+        "EventName": "UNC_R2_IIO_CREDIT.PRQ_QPI0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "EventCode": "0x2D",
+        "EventName": "UNC_R2_IIO_CREDIT.PRQ_QPI1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
     {
         "BriefDescription": "R2PCIe IIO Credit Acquired; DRS",
-        "Counter": "0,1",
         "EventCode": "0x33",
         "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.DRS",
         "PerPkg": "1",
@@ -532,7 +503,6 @@
     },
     {
         "BriefDescription": "R2PCIe IIO Credit Acquired; NCB",
-        "Counter": "0,1",
         "EventCode": "0x33",
         "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.NCB",
         "PerPkg": "1",
@@ -542,7 +512,6 @@
     },
     {
         "BriefDescription": "R2PCIe IIO Credit Acquired; NCS",
-        "Counter": "0,1",
         "EventCode": "0x33",
         "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.NCS",
         "PerPkg": "1",
@@ -552,7 +521,6 @@
     },
     {
         "BriefDescription": "R2PCIe IIO Credits in Use; DRS",
-        "Counter": "0,1",
         "EventCode": "0x32",
         "EventName": "UNC_R2_IIO_CREDITS_USED.DRS",
         "PerPkg": "1",
@@ -562,7 +530,6 @@
     },
     {
         "BriefDescription": "R2PCIe IIO Credits in Use; NCB",
-        "Counter": "0,1",
         "EventCode": "0x32",
         "EventName": "UNC_R2_IIO_CREDITS_USED.NCB",
         "PerPkg": "1",
@@ -572,7 +539,6 @@
     },
     {
         "BriefDescription": "R2PCIe IIO Credits in Use; NCS",
-        "Counter": "0,1",
         "EventCode": "0x32",
         "EventName": "UNC_R2_IIO_CREDITS_USED.NCS",
         "PerPkg": "1",
@@ -582,27 +548,24 @@
     },
     {
         "BriefDescription": "R2 AD Ring in Use; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_R2_RING_AD_USED.ALL",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "R2PCIe"
     },
     {
         "BriefDescription": "R2 AD Ring in Use; Counterclockwise",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_R2_RING_AD_USED.CCW",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "R2PCIe"
     },
     {
         "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Even"=
,
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_R2_RING_AD_USED.CCW_EVEN",
         "PerPkg": "1",
@@ -612,7 +575,6 @@
     },
     {
         "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_R2_RING_AD_USED.CCW_ODD",
         "PerPkg": "1",
@@ -622,7 +584,6 @@
     },
     {
         "BriefDescription": "R2 AD Ring in Use; Clockwise",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_R2_RING_AD_USED.CW",
         "PerPkg": "1",
@@ -632,7 +593,6 @@
     },
     {
         "BriefDescription": "R2 AD Ring in Use; Clockwise and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_R2_RING_AD_USED.CW_EVEN",
         "PerPkg": "1",
@@ -642,7 +602,6 @@
     },
     {
         "BriefDescription": "R2 AD Ring in Use; Clockwise and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_R2_RING_AD_USED.CW_ODD",
         "PerPkg": "1",
@@ -652,7 +611,6 @@
     },
     {
         "BriefDescription": "AK Ingress Bounced; Dn",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "UNC_R2_RING_AK_BOUNCES.DN",
         "PerPkg": "1",
@@ -662,7 +620,6 @@
     },
     {
         "BriefDescription": "AK Ingress Bounced; Up",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "UNC_R2_RING_AK_BOUNCES.UP",
         "PerPkg": "1",
@@ -672,27 +629,24 @@
     },
     {
         "BriefDescription": "R2 AK Ring in Use; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_R2_RING_AK_USED.ALL",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "R2PCIe"
     },
     {
         "BriefDescription": "R2 AK Ring in Use; Counterclockwise",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_R2_RING_AK_USED.CCW",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "R2PCIe"
     },
     {
         "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Even"=
,
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_R2_RING_AK_USED.CCW_EVEN",
         "PerPkg": "1",
@@ -702,7 +656,6 @@
     },
     {
         "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_R2_RING_AK_USED.CCW_ODD",
         "PerPkg": "1",
@@ -712,7 +665,6 @@
     },
     {
         "BriefDescription": "R2 AK Ring in Use; Clockwise",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_R2_RING_AK_USED.CW",
         "PerPkg": "1",
@@ -722,7 +674,6 @@
     },
     {
         "BriefDescription": "R2 AK Ring in Use; Clockwise and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_R2_RING_AK_USED.CW_EVEN",
         "PerPkg": "1",
@@ -732,7 +683,6 @@
     },
     {
         "BriefDescription": "R2 AK Ring in Use; Clockwise and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_R2_RING_AK_USED.CW_ODD",
         "PerPkg": "1",
@@ -742,27 +692,24 @@
     },
     {
         "BriefDescription": "R2 BL Ring in Use; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_R2_RING_BL_USED.ALL",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "R2PCIe"
     },
     {
         "BriefDescription": "R2 BL Ring in Use; Counterclockwise",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_R2_RING_BL_USED.CCW",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "R2PCIe"
     },
     {
         "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Even"=
,
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_R2_RING_BL_USED.CCW_EVEN",
         "PerPkg": "1",
@@ -772,7 +719,6 @@
     },
     {
         "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_R2_RING_BL_USED.CCW_ODD",
         "PerPkg": "1",
@@ -782,7 +728,6 @@
     },
     {
         "BriefDescription": "R2 BL Ring in Use; Clockwise",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_R2_RING_BL_USED.CW",
         "PerPkg": "1",
@@ -792,7 +737,6 @@
     },
     {
         "BriefDescription": "R2 BL Ring in Use; Clockwise and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_R2_RING_BL_USED.CW_EVEN",
         "PerPkg": "1",
@@ -802,7 +746,6 @@
     },
     {
         "BriefDescription": "R2 BL Ring in Use; Clockwise and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_R2_RING_BL_USED.CW_ODD",
         "PerPkg": "1",
@@ -812,27 +755,24 @@
     },
     {
         "BriefDescription": "R2 IV Ring in Use; Any",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA",
         "EventName": "UNC_R2_RING_IV_USED.ANY",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "R2PCIe"
     },
     {
         "BriefDescription": "R2 IV Ring in Use; Counterclockwise",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA",
         "EventName": "UNC_R2_RING_IV_USED.CCW",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "R2PCIe"
     },
     {
         "BriefDescription": "R2 IV Ring in Use; Clockwise",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA",
         "EventName": "UNC_R2_RING_IV_USED.CW",
         "PerPkg": "1",
@@ -842,7 +782,6 @@
     },
     {
         "BriefDescription": "Ingress Cycles Not Empty; NCB",
-        "Counter": "0,1",
         "EventCode": "0x10",
         "EventName": "UNC_R2_RxR_CYCLES_NE.NCB",
         "PerPkg": "1",
@@ -852,7 +791,6 @@
     },
     {
         "BriefDescription": "Ingress Cycles Not Empty; NCS",
-        "Counter": "0,1",
         "EventCode": "0x10",
         "EventName": "UNC_R2_RxR_CYCLES_NE.NCS",
         "PerPkg": "1",
@@ -862,7 +800,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; NCB",
-        "Counter": "0,1",
         "EventCode": "0x11",
         "EventName": "UNC_R2_RxR_INSERTS.NCB",
         "PerPkg": "1",
@@ -872,7 +809,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; NCS",
-        "Counter": "0,1",
         "EventCode": "0x11",
         "EventName": "UNC_R2_RxR_INSERTS.NCS",
         "PerPkg": "1",
@@ -891,7 +827,6 @@
     },
     {
         "BriefDescription": "SBo0 Credits Acquired; For AD Ring",
-        "Counter": "0,1",
         "EventCode": "0x28",
         "EventName": "UNC_R2_SBO0_CREDITS_ACQUIRED.AD",
         "PerPkg": "1",
@@ -901,7 +836,6 @@
     },
     {
         "BriefDescription": "SBo0 Credits Acquired; For BL Ring",
-        "Counter": "0,1",
         "EventCode": "0x28",
         "EventName": "UNC_R2_SBO0_CREDITS_ACQUIRED.BL",
         "PerPkg": "1",
@@ -929,7 +863,6 @@
     },
     {
         "BriefDescription": "Stall on No Sbo Credits; For SBo0, AD Ring",
-        "Counter": "0,1",
         "EventCode": "0x2C",
         "EventName": "UNC_R2_STALL_NO_SBO_CREDIT.SBO0_AD",
         "PerPkg": "1",
@@ -939,7 +872,6 @@
     },
     {
         "BriefDescription": "Stall on No Sbo Credits; For SBo0, BL Ring",
-        "Counter": "0,1",
         "EventCode": "0x2C",
         "EventName": "UNC_R2_STALL_NO_SBO_CREDIT.SBO0_BL",
         "PerPkg": "1",
@@ -949,7 +881,6 @@
     },
     {
         "BriefDescription": "Stall on No Sbo Credits; For SBo1, AD Ring",
-        "Counter": "0,1",
         "EventCode": "0x2C",
         "EventName": "UNC_R2_STALL_NO_SBO_CREDIT.SBO1_AD",
         "PerPkg": "1",
@@ -959,7 +890,6 @@
     },
     {
         "BriefDescription": "Stall on No Sbo Credits; For SBo1, BL Ring",
-        "Counter": "0,1",
         "EventCode": "0x2C",
         "EventName": "UNC_R2_STALL_NO_SBO_CREDIT.SBO1_BL",
         "PerPkg": "1",
@@ -1023,7 +953,6 @@
     },
     {
         "BriefDescription": "Egress CCW NACK; AD CCW",
-        "Counter": "0,1",
         "EventCode": "0x26",
         "EventName": "UNC_R2_TxR_NACK_CW.DN_AD",
         "PerPkg": "1",
@@ -1033,7 +962,6 @@
     },
     {
         "BriefDescription": "Egress CCW NACK; AK CCW",
-        "Counter": "0,1",
         "EventCode": "0x26",
         "EventName": "UNC_R2_TxR_NACK_CW.DN_AK",
         "PerPkg": "1",
@@ -1043,7 +971,6 @@
     },
     {
         "BriefDescription": "Egress CCW NACK; BL CCW",
-        "Counter": "0,1",
         "EventCode": "0x26",
         "EventName": "UNC_R2_TxR_NACK_CW.DN_BL",
         "PerPkg": "1",
@@ -1053,7 +980,6 @@
     },
     {
         "BriefDescription": "Egress CCW NACK; AK CCW",
-        "Counter": "0,1",
         "EventCode": "0x26",
         "EventName": "UNC_R2_TxR_NACK_CW.UP_AD",
         "PerPkg": "1",
@@ -1063,7 +989,6 @@
     },
     {
         "BriefDescription": "Egress CCW NACK; BL CW",
-        "Counter": "0,1",
         "EventCode": "0x26",
         "EventName": "UNC_R2_TxR_NACK_CW.UP_AK",
         "PerPkg": "1",
@@ -1073,7 +998,6 @@
     },
     {
         "BriefDescription": "Egress CCW NACK; BL CCW",
-        "Counter": "0,1",
         "EventCode": "0x26",
         "EventName": "UNC_R2_TxR_NACK_CW.UP_BL",
         "PerPkg": "1",
@@ -1083,7 +1007,6 @@
     },
     {
         "BriefDescription": "VLW Received",
-        "Counter": "0,1",
         "EventCode": "0x42",
         "EventName": "UNC_U_EVENT_MSG.DOORBELL_RCVD",
         "PerPkg": "1",
@@ -1093,7 +1016,6 @@
     },
     {
         "BriefDescription": "Filter Match",
-        "Counter": "0,1",
         "EventCode": "0x41",
         "EventName": "UNC_U_FILTER_MATCH.DISABLE",
         "PerPkg": "1",
@@ -1103,7 +1025,6 @@
     },
     {
         "BriefDescription": "Filter Match",
-        "Counter": "0,1",
         "EventCode": "0x41",
         "EventName": "UNC_U_FILTER_MATCH.ENABLE",
         "PerPkg": "1",
@@ -1113,7 +1034,6 @@
     },
     {
         "BriefDescription": "Filter Match",
-        "Counter": "0,1",
         "EventCode": "0x41",
         "EventName": "UNC_U_FILTER_MATCH.U2C_DISABLE",
         "PerPkg": "1",
@@ -1123,7 +1043,6 @@
     },
     {
         "BriefDescription": "Filter Match",
-        "Counter": "0,1",
         "EventCode": "0x41",
         "EventName": "UNC_U_FILTER_MATCH.U2C_ENABLE",
         "PerPkg": "1",
@@ -1133,7 +1052,6 @@
     },
     {
         "BriefDescription": "Cycles PHOLD Assert to Ack; Assert to ACK",
-        "Counter": "0,1",
         "EventCode": "0x45",
         "EventName": "UNC_U_PHOLD_CYCLES.ASSERT_TO_ACK",
         "PerPkg": "1",
@@ -1143,7 +1061,6 @@
     },
     {
         "BriefDescription": "RACU Request",
-        "Counter": "0,1",
         "EventCode": "0x46",
         "EventName": "UNC_U_RACU_REQUESTS",
         "PerPkg": "1",
@@ -1152,7 +1069,6 @@
     },
     {
         "BriefDescription": "Monitor Sent to T0; Correctable Machine Check=
",
-        "Counter": "0,1",
         "EventCode": "0x43",
         "EventName": "UNC_U_U2C_EVENTS.CMC",
         "PerPkg": "1",
@@ -1162,7 +1078,6 @@
     },
     {
         "BriefDescription": "Monitor Sent to T0; Livelock",
-        "Counter": "0,1",
         "EventCode": "0x43",
         "EventName": "UNC_U_U2C_EVENTS.LIVELOCK",
         "PerPkg": "1",
@@ -1172,7 +1087,6 @@
     },
     {
         "BriefDescription": "Monitor Sent to T0; LTError",
-        "Counter": "0,1",
         "EventCode": "0x43",
         "EventName": "UNC_U_U2C_EVENTS.LTERROR",
         "PerPkg": "1",
@@ -1182,7 +1096,6 @@
     },
     {
         "BriefDescription": "Monitor Sent to T0; Monitor T0",
-        "Counter": "0,1",
         "EventCode": "0x43",
         "EventName": "UNC_U_U2C_EVENTS.MONITOR_T0",
         "PerPkg": "1",
@@ -1192,7 +1105,6 @@
     },
     {
         "BriefDescription": "Monitor Sent to T0; Monitor T1",
-        "Counter": "0,1",
         "EventCode": "0x43",
         "EventName": "UNC_U_U2C_EVENTS.MONITOR_T1",
         "PerPkg": "1",
@@ -1202,7 +1114,6 @@
     },
     {
         "BriefDescription": "Monitor Sent to T0; Other",
-        "Counter": "0,1",
         "EventCode": "0x43",
         "EventName": "UNC_U_U2C_EVENTS.OTHER",
         "PerPkg": "1",
@@ -1212,7 +1123,6 @@
     },
     {
         "BriefDescription": "Monitor Sent to T0; Trap",
-        "Counter": "0,1",
         "EventCode": "0x43",
         "EventName": "UNC_U_U2C_EVENTS.TRAP",
         "PerPkg": "1",
@@ -1222,7 +1132,6 @@
     },
     {
         "BriefDescription": "Monitor Sent to T0; Uncorrectable Machine Che=
ck",
-        "Counter": "0,1",
         "EventCode": "0x43",
         "EventName": "UNC_U_U2C_EVENTS.UMC",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json b=
/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
index c3325dd61202..124b3fe2e0e1 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "pclk Cycles",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_P_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "The PCU runs off a fixed 1 GHz clock.  This =
event counts the number of pclk cycles measured while the counter was enabl=
ed.  The pclk, like the Memory Controller's dclk, counts at a constant rate=
 making it a good measure of actual wall time.",
@@ -9,7 +8,6 @@
     },
     {
         "BriefDescription": "Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "UNC_P_CORE0_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -18,7 +16,6 @@
     },
     {
         "BriefDescription": "Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6A",
         "EventName": "UNC_P_CORE10_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -27,7 +24,6 @@
     },
     {
         "BriefDescription": "Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6B",
         "EventName": "UNC_P_CORE11_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -36,7 +32,6 @@
     },
     {
         "BriefDescription": "Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6C",
         "EventName": "UNC_P_CORE12_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -45,7 +40,6 @@
     },
     {
         "BriefDescription": "Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6D",
         "EventName": "UNC_P_CORE13_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -54,7 +48,6 @@
     },
     {
         "BriefDescription": "Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6E",
         "EventName": "UNC_P_CORE14_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -63,7 +56,6 @@
     },
     {
         "BriefDescription": "Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6F",
         "EventName": "UNC_P_CORE15_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -72,7 +64,6 @@
     },
     {
         "BriefDescription": "Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x70",
         "EventName": "UNC_P_CORE16_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -81,7 +72,6 @@
     },
     {
         "BriefDescription": "Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "UNC_P_CORE17_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -90,7 +80,6 @@
     },
     {
         "BriefDescription": "Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x61",
         "EventName": "UNC_P_CORE1_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -99,7 +88,6 @@
     },
     {
         "BriefDescription": "Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x62",
         "EventName": "UNC_P_CORE2_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -108,7 +96,6 @@
     },
     {
         "BriefDescription": "Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x63",
         "EventName": "UNC_P_CORE3_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -117,7 +104,6 @@
     },
     {
         "BriefDescription": "Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x64",
         "EventName": "UNC_P_CORE4_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -126,7 +112,6 @@
     },
     {
         "BriefDescription": "Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x65",
         "EventName": "UNC_P_CORE5_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -135,7 +120,6 @@
     },
     {
         "BriefDescription": "Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x66",
         "EventName": "UNC_P_CORE6_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -144,7 +128,6 @@
     },
     {
         "BriefDescription": "Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x67",
         "EventName": "UNC_P_CORE7_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -153,7 +136,6 @@
     },
     {
         "BriefDescription": "Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x68",
         "EventName": "UNC_P_CORE8_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -162,7 +144,6 @@
     },
     {
         "BriefDescription": "Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x69",
         "EventName": "UNC_P_CORE9_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -171,7 +152,6 @@
     },
     {
         "BriefDescription": "Core C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x30",
         "EventName": "UNC_P_DEMOTIONS_CORE0",
         "PerPkg": "1",
@@ -180,7 +160,6 @@
     },
     {
         "BriefDescription": "Core C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "UNC_P_DEMOTIONS_CORE1",
         "PerPkg": "1",
@@ -189,7 +168,6 @@
     },
     {
         "BriefDescription": "Core C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3A",
         "EventName": "UNC_P_DEMOTIONS_CORE10",
         "PerPkg": "1",
@@ -198,7 +176,6 @@
     },
     {
         "BriefDescription": "Core C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3B",
         "EventName": "UNC_P_DEMOTIONS_CORE11",
         "PerPkg": "1",
@@ -207,7 +184,6 @@
     },
     {
         "BriefDescription": "Core C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "UNC_P_DEMOTIONS_CORE12",
         "PerPkg": "1",
@@ -216,7 +192,6 @@
     },
     {
         "BriefDescription": "Core C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3D",
         "EventName": "UNC_P_DEMOTIONS_CORE13",
         "PerPkg": "1",
@@ -225,7 +200,6 @@
     },
     {
         "BriefDescription": "Core C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3E",
         "EventName": "UNC_P_DEMOTIONS_CORE14",
         "PerPkg": "1",
@@ -234,7 +208,6 @@
     },
     {
         "BriefDescription": "Core C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3F",
         "EventName": "UNC_P_DEMOTIONS_CORE15",
         "PerPkg": "1",
@@ -243,7 +216,6 @@
     },
     {
         "BriefDescription": "Core C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_P_DEMOTIONS_CORE16",
         "PerPkg": "1",
@@ -252,7 +224,6 @@
     },
     {
         "BriefDescription": "Core C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_P_DEMOTIONS_CORE17",
         "PerPkg": "1",
@@ -261,7 +232,6 @@
     },
     {
         "BriefDescription": "Core C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_P_DEMOTIONS_CORE2",
         "PerPkg": "1",
@@ -270,7 +240,6 @@
     },
     {
         "BriefDescription": "Core C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_P_DEMOTIONS_CORE3",
         "PerPkg": "1",
@@ -279,7 +248,6 @@
     },
     {
         "BriefDescription": "Core C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_P_DEMOTIONS_CORE4",
         "PerPkg": "1",
@@ -288,7 +256,6 @@
     },
     {
         "BriefDescription": "Core C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_P_DEMOTIONS_CORE5",
         "PerPkg": "1",
@@ -297,7 +264,6 @@
     },
     {
         "BriefDescription": "Core C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x36",
         "EventName": "UNC_P_DEMOTIONS_CORE6",
         "PerPkg": "1",
@@ -306,7 +272,6 @@
     },
     {
         "BriefDescription": "Core C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_P_DEMOTIONS_CORE7",
         "PerPkg": "1",
@@ -315,7 +280,6 @@
     },
     {
         "BriefDescription": "Core C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x38",
         "EventName": "UNC_P_DEMOTIONS_CORE8",
         "PerPkg": "1",
@@ -324,7 +288,6 @@
     },
     {
         "BriefDescription": "Core C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_P_DEMOTIONS_CORE9",
         "PerPkg": "1",
@@ -333,7 +296,6 @@
     },
     {
         "BriefDescription": "Thermal Strongest Upper Limit Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_P_FREQ_MAX_LIMIT_THERMAL_CYCLES",
         "PerPkg": "1",
@@ -342,7 +304,6 @@
     },
     {
         "BriefDescription": "OS Strongest Upper Limit Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6",
         "EventName": "UNC_P_FREQ_MAX_OS_CYCLES",
         "PerPkg": "1",
@@ -351,7 +312,6 @@
     },
     {
         "BriefDescription": "Power Strongest Upper Limit Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x5",
         "EventName": "UNC_P_FREQ_MAX_POWER_CYCLES",
         "PerPkg": "1",
@@ -360,7 +320,6 @@
     },
     {
         "BriefDescription": "IO P Limit Strongest Lower Limit Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x73",
         "EventName": "UNC_P_FREQ_MIN_IO_P_CYCLES",
         "PerPkg": "1",
@@ -369,7 +328,6 @@
     },
     {
         "BriefDescription": "Cycles spent changing Frequency",
-        "Counter": "0,1,2,3",
         "EventCode": "0x74",
         "EventName": "UNC_P_FREQ_TRANS_CYCLES",
         "PerPkg": "1",
@@ -378,7 +336,6 @@
     },
     {
         "BriefDescription": "Memory Phase Shedding Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2F",
         "EventName": "UNC_P_MEMORY_PHASE_SHEDDING_CYCLES",
         "PerPkg": "1",
@@ -387,7 +344,6 @@
     },
     {
         "BriefDescription": "Package C State Residency - C0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A",
         "EventName": "UNC_P_PKG_RESIDENCY_C0_CYCLES",
         "PerPkg": "1",
@@ -396,7 +352,6 @@
     },
     {
         "BriefDescription": "Package C State Residency - C1E",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4E",
         "EventName": "UNC_P_PKG_RESIDENCY_C1E_CYCLES",
         "PerPkg": "1",
@@ -405,7 +360,6 @@
     },
     {
         "BriefDescription": "Package C State Residency - C2E",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2B",
         "EventName": "UNC_P_PKG_RESIDENCY_C2E_CYCLES",
         "PerPkg": "1",
@@ -414,7 +368,6 @@
     },
     {
         "BriefDescription": "Package C State Residency - C3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2C",
         "EventName": "UNC_P_PKG_RESIDENCY_C3_CYCLES",
         "PerPkg": "1",
@@ -423,7 +376,6 @@
     },
     {
         "BriefDescription": "Package C State Residency - C6",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2D",
         "EventName": "UNC_P_PKG_RESIDENCY_C6_CYCLES",
         "PerPkg": "1",
@@ -432,7 +384,6 @@
     },
     {
         "BriefDescription": "Package C7 State Residency",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_P_PKG_RESIDENCY_C7_CYCLES",
         "PerPkg": "1",
@@ -441,7 +392,6 @@
     },
     {
         "BriefDescription": "Number of cores in C-State; C0 and C1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
         "PerPkg": "1",
@@ -450,7 +400,6 @@
     },
     {
         "BriefDescription": "Number of cores in C-State; C3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
         "PerPkg": "1",
@@ -459,7 +408,6 @@
     },
     {
         "BriefDescription": "Number of cores in C-State; C6 and C7",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
         "PerPkg": "1",
@@ -468,7 +416,6 @@
     },
     {
         "BriefDescription": "External Prochot",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA",
         "EventName": "UNC_P_PROCHOT_EXTERNAL_CYCLES",
         "PerPkg": "1",
@@ -477,7 +424,6 @@
     },
     {
         "BriefDescription": "Internal Prochot",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_P_PROCHOT_INTERNAL_CYCLES",
         "PerPkg": "1",
@@ -486,7 +432,6 @@
     },
     {
         "BriefDescription": "Total Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x72",
         "EventName": "UNC_P_TOTAL_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -494,7 +439,6 @@
         "Unit": "PCU"
     },
     {
-        "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "UNC_P_UFS_TRANSITIONS_RING_GV",
         "PerPkg": "1",
@@ -503,7 +447,6 @@
     },
     {
         "BriefDescription": "VR Hot",
-        "Counter": "0,1,2,3",
         "EventCode": "0x42",
         "EventName": "UNC_P_VR_HOT_CYCLES",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/virtual-memory.json=
 b/tools/perf/pmu-events/arch/x86/broadwellde/virtual-memory.json
index 6a6de8790f25..93621e004d88 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/virtual-memory.json
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
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index df47462a125f..8949b58f89be 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -3,7 +3,7 @@ GenuineIntel-6-(97|9A|B7|BA|BF),v1.16,alderlake,core
 GenuineIntel-6-BE,v1.16,alderlaken,core
 GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
 GenuineIntel-6-(3D|47),v26,broadwell,core
-GenuineIntel-6-56,v23,broadwellde,core
+GenuineIntel-6-56,v7,broadwellde,core
 GenuineIntel-6-4F,v19,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.16,cascadelakex,core
 GenuineIntel-6-9[6C],v1.03,elkhartlake,core
--=20
2.39.0.314.g84b9a713c41-goog

