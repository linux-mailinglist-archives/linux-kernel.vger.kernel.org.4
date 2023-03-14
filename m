Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105EE6B8A6C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 06:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjCNFeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 01:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjCNFd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 01:33:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBA3173C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 22:33:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m6-20020a056902118600b00aeb1e3dbd1bso15693183ybu.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 22:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678772020;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tQ9A6PjbSjoYdhZNuSslLUv5kUzm/UQWl6XkFQU3hU=;
        b=msHsXmVAq6PnyCfO15bk8DSybCeKD3RKkDMUpMO4Ycwia+/TcOryhSkRq9Fa3zupr+
         xRQKjefPLnZtwsr8OR6f/4I5unpsONZboDfD3QxBcS1sJ1kAKA+60vMNWY0Knf4Ra2UX
         F1YPjyPoeBazvw3bUQr39nOMwvTFlNtFATP8c3OlSUnzhjqeUFMI0ii8t8zpeudG94uQ
         IKUD8TI9UqtjNv9X/XgnAkUfaz303ZcrPc7BsN63/22lgXeYogNw4hNTEvbfOqljkeJR
         yR/Vc8JJfFr7p5gIPwj+UsTdpCeyvpJW0fuANcvG5qAwqk2hPzN72Ohz6qmXOPdguAYr
         5rFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678772020;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+tQ9A6PjbSjoYdhZNuSslLUv5kUzm/UQWl6XkFQU3hU=;
        b=sFTfge2o93ts6KDix6Se+bkOOXggWlEpXLo81w3+dszO9E2IytZL56s6hjPFs5+j/M
         wIFsitvWenOjlS9e3e/UFKOCXeu09RkCnC0Svht+E5sz1tNkvutf0I/Bx07/yKPgHm4O
         fe36R/gVwB/KSjE7iJdtrMLYzc8CuVGb4FutBD7tNck8JCovzNKCQ0HATTLosP2LaW8b
         GPEFMntQL9KWR8o5rue4XQi7ICVc/5IoWcVQYaPfWCb2QFWA2tBdawBANtdKTt+n2X51
         5ouYTQmPu/jbgZ9p5LJk2ItmfyonpWBVcX+XBbdEXDi5lvtOF5fNHyhrhXQXjQEUaoF0
         Tx/w==
X-Gm-Message-State: AO0yUKW9qGkvQROIghyg68PBvNtvZ2O1jsEMx8Itqa9bkiaDjF+oz5R2
        vwxpvRjyWzB4pKlwDXot594OCeigwba+
X-Google-Smtp-Source: AK7set+jFCi1gcJ4Qgy02aIQSCMCdWkQAXP/BD0e2gLAnguIisjlPqw92mDezV42O62WG24KCVUsl+n8IcQF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:adc3:d11e:dcd7:fd4e])
 (user=irogers job=sendgmr) by 2002:a81:af48:0:b0:541:9b14:949e with SMTP id
 x8-20020a81af48000000b005419b14949emr4298116ywj.4.1678772020341; Mon, 13 Mar
 2023 22:33:40 -0700 (PDT)
Date:   Mon, 13 Mar 2023 22:33:11 -0700
In-Reply-To: <20230314053312.3237390-1-irogers@google.com>
Message-Id: <20230314053312.3237390-3-irogers@google.com>
Mime-Version: 1.0
References: <20230314053312.3237390-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v1 2/3] perf vendor events intel: Update meteorlake events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>
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

Update from 1.00 to 1.01. Event description updates. Addition of
IDQ_BUBBLES.CORE, TOPDOWN.BACKEND_BOUND_SLOTS, UOPS_RETIRED.SLOTS.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 .../pmu-events/arch/x86/meteorlake/cache.json |  8 +++++
 .../arch/x86/meteorlake/frontend.json         |  9 +++++
 .../arch/x86/meteorlake/memory.json           | 13 +++++--
 .../pmu-events/arch/x86/meteorlake/other.json |  4 +--
 .../arch/x86/meteorlake/pipeline.json         | 36 +++++++++++++++++--
 .../arch/x86/meteorlake/virtual-memory.json   |  4 +++
 7 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 210dd9b2004f..34431709f7d0 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -18,7 +18,7 @@ GenuineIntel-6-3A,v23,ivybridge,core
 GenuineIntel-6-3E,v22,ivytown,core
 GenuineIntel-6-2D,v22,jaketown,core
 GenuineIntel-6-(57|85),v10,knightslanding,core
-GenuineIntel-6-A[AC],v1.00,meteorlake,core
+GenuineIntel-6-A[AC],v1.01,meteorlake,core
 GenuineIntel-6-1[AEF],v3,nehalemep,core
 GenuineIntel-6-2E,v3,nehalemex,core
 GenuineIntel-6-2A,v18,sandybridge,core
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json b/tools/p=
erf/pmu-events/arch/x86/meteorlake/cache.json
index 0970724a2984..bf24d3f25a3d 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
@@ -3,6 +3,7 @@
         "BriefDescription": "L2 code requests",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_CODE_RD",
+        "PublicDescription": "Counts the total number of L2 code requests.=
",
         "SampleAfterValue": "200003",
         "UMask": "0xe4",
         "Unit": "cpu_core"
@@ -11,6 +12,7 @@
         "BriefDescription": "Demand Data Read access L2 cache",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
+        "PublicDescription": "Counts Demand Data Read requests accessing t=
he L2 cache. These requests may hit or miss L2 cache. True-miss exclude mis=
ses that were merged with ongoing L2 misses. An access is counted once.",
         "SampleAfterValue": "200003",
         "UMask": "0xe1",
         "Unit": "cpu_core"
@@ -19,6 +21,7 @@
         "BriefDescription": "Counts the number of cacheable memory request=
s that miss in the LLC. Counts on a per core basis.",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.MISS",
+        "PublicDescription": "Counts the number of cacheable memory reques=
ts that miss in the Last Level Cache (LLC). Requests include demand loads, =
reads for ownership (RFO), instruction fetches and L1 HW prefetches. If the=
 platform has an L3 cache, the LLC is the L3 cache, otherwise it is the L2 =
cache. Counts on a per core basis.",
         "SampleAfterValue": "200003",
         "UMask": "0x41",
         "Unit": "cpu_atom"
@@ -27,6 +30,7 @@
         "BriefDescription": "Core-originated cacheable requests that misse=
d L3  (Except hardware prefetches to the L3)",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.MISS",
+        "PublicDescription": "Counts core-originated cacheable requests th=
at miss the L3 cache (Longest Latency cache). Requests include data and cod=
e reads, Reads-for-Ownership (RFOs), speculative accesses and hardware pref=
etches to the L1 and L2.  It does not include hardware prefetches to the L3=
, and may not count other types of requests to the L3.",
         "SampleAfterValue": "100003",
         "UMask": "0x41",
         "Unit": "cpu_core"
@@ -35,6 +39,7 @@
         "BriefDescription": "Counts the number of cacheable memory request=
s that access the LLC. Counts on a per core basis.",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
+        "PublicDescription": "Counts the number of cacheable memory reques=
ts that access the Last Level Cache (LLC). Requests include demand loads, r=
eads for ownership (RFO), instruction fetches and L1 HW prefetches. If the =
platform has an L3 cache, the LLC is the L3 cache, otherwise it is the L2 c=
ache. Counts on a per core basis.",
         "SampleAfterValue": "200003",
         "UMask": "0x4f",
         "Unit": "cpu_atom"
@@ -43,6 +48,7 @@
         "BriefDescription": "Core-originated cacheable requests that refer=
 to L3 (Except hardware prefetches to the L3)",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
+        "PublicDescription": "Counts core-originated cacheable requests to=
 the L3 cache (Longest Latency cache). Requests include data and code reads=
, Reads-for-Ownership (RFOs), speculative accesses and hardware prefetches =
to the L1 and L2.  It does not include hardware prefetches to the L3, and m=
ay not count other types of requests to the L3.",
         "SampleAfterValue": "100003",
         "UMask": "0x4f",
         "Unit": "cpu_core"
@@ -53,6 +59,7 @@
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_LOADS",
         "PEBS": "1",
+        "PublicDescription": "Counts all retired load instructions. This e=
vent accounts for SW prefetch instructions of PREFETCHNTA or PREFETCHT0/1/2=
 or PREFETCHW.",
         "SampleAfterValue": "1000003",
         "UMask": "0x81",
         "Unit": "cpu_core"
@@ -63,6 +70,7 @@
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_STORES",
         "PEBS": "1",
+        "PublicDescription": "Counts all retired store instructions.",
         "SampleAfterValue": "1000003",
         "UMask": "0x82",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json b/tool=
s/perf/pmu-events/arch/x86/meteorlake/frontend.json
index 7de11819dd0d..66e5609699ea 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
@@ -14,5 +14,14 @@
         "SampleAfterValue": "200003",
         "UMask": "0x2",
         "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that were no operation was delivered to the back-end pipeline due =
to instruction fetch limitations when the back-end could have accepted more=
 operations. Common examples include instruction cache misses or x86 instru=
ction decode limitations.",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_BUBBLES.CORE",
+        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that were no operation was delivered to the back-end pipeline due=
 to instruction fetch limitations when the back-end could have accepted mor=
e operations. Common examples include instruction cache misses or x86 instr=
uction decode limitations.\nThe count may be distributed among unhalted log=
ical processors (hyper-threads) who share the same physical core, in proces=
sors that support Intel Hyper-Threading Technology. Software can use this e=
vent as the numerator for the Frontend Bound metric (or top-level category)=
 of the Top-down Microarchitecture Analysis method.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/memory.json b/tools/=
perf/pmu-events/arch/x86/meteorlake/memory.json
index b7715cec1dbc..20c2efe70eeb 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/memory.json
@@ -7,6 +7,7 @@
         "MSRIndex": "0x3F6",
         "MSRValue": "0x80",
         "PEBS": "2",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 128 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "1009",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -19,6 +20,7 @@
         "MSRIndex": "0x3F6",
         "MSRValue": "0x10",
         "PEBS": "2",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 16 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "20011",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -31,6 +33,7 @@
         "MSRIndex": "0x3F6",
         "MSRValue": "0x100",
         "PEBS": "2",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 256 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "503",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -43,6 +46,7 @@
         "MSRIndex": "0x3F6",
         "MSRValue": "0x20",
         "PEBS": "2",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 32 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -55,6 +59,7 @@
         "MSRIndex": "0x3F6",
         "MSRValue": "0x4",
         "PEBS": "2",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 4 cycles.  Reported l=
atency may be longer than just the memory latency.",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -67,6 +72,7 @@
         "MSRIndex": "0x3F6",
         "MSRValue": "0x200",
         "PEBS": "2",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 512 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "101",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -79,6 +85,7 @@
         "MSRIndex": "0x3F6",
         "MSRValue": "0x40",
         "PEBS": "2",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 64 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "2003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -91,6 +98,7 @@
         "MSRIndex": "0x3F6",
         "MSRValue": "0x8",
         "PEBS": "2",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 8 cycles.  Reported l=
atency may be longer than just the memory latency.",
         "SampleAfterValue": "50021",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -101,12 +109,13 @@
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.STORE_SAMPLE",
         "PEBS": "2",
+        "PublicDescription": "Counts Retired memory accesses with at least=
 1 store operation. This PEBS event is the precisely-distributed (PDist) tr=
igger covering all stores uops for sampling by the PEBS Store Latency Facil=
ity. The facility is described in Intel SDM Volume 3 section 19.9.8",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts cacheable demand data reads were not s=
upplied by the L3 cache.",
+        "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -126,7 +135,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts demand reads for ownership, including =
SWPREFETCHW which is an RFO were not supplied by the L3 cache.",
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were not suppli=
ed by the L3 cache.",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/other.json b/tools/p=
erf/pmu-events/arch/x86/meteorlake/other.json
index ae98e3d0e149..14e648bf11c5 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/other.json
@@ -1,6 +1,6 @@
 [
     {
-        "BriefDescription": "Counts cacheable demand data reads Catch all =
value for any response types - this includes response types not define in t=
he OCR.  If this is set all other response types will be ignored",
+        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -20,7 +20,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts demand reads for ownership, including =
SWPREFETCHW which is an RFO Catch all value for any response types - this i=
ncludes response types not define in the OCR.  If this is set all other res=
ponse types will be ignored",
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have any type o=
f response.",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/meteorlake/pipeline.json
index 7be7e40c03ac..639789478073 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
@@ -4,6 +4,7 @@
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
+        "PublicDescription": "Counts the total number of instructions in w=
hich the instruction pointer (IP) of the processor is resteered due to a br=
anch instruction and the branch instruction successfully retires.  All bran=
ch type instructions are accounted for.",
         "SampleAfterValue": "200003",
         "Unit": "cpu_atom"
     },
@@ -12,6 +13,7 @@
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
+        "PublicDescription": "Counts all branch instructions retired.",
         "SampleAfterValue": "400009",
         "Unit": "cpu_core"
     },
@@ -20,6 +22,7 @@
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
+        "PublicDescription": "Counts the total number of mispredicted bran=
ch instructions retired.  All branch type instructions are accounted for.  =
Prediction of the branch target address enables the processor to begin exec=
uting instructions before the non-speculative execution path is known. The =
branch prediction unit (BPU) predicts the target address based on the instr=
uction pointer (IP) of the branch and on the execution path through which e=
xecution reached this IP.    A branch misprediction occurs when the predict=
ion is wrong, and results in discarding all instructions executed in the sp=
eculative path and re-fetching from the correct path.",
         "SampleAfterValue": "200003",
         "Unit": "cpu_atom"
     },
@@ -28,6 +31,7 @@
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
+        "PublicDescription": "Counts all the retired branch instructions t=
hat were mispredicted by the processor. A branch misprediction occurs when =
the processor incorrectly predicts the destination of the branch.  When the=
 misprediction is discovered at execution, all the instructions executed in=
 the wrong (speculative) path must be discarded, and the processor must sta=
rt fetching from the correct path.",
         "SampleAfterValue": "400009",
         "Unit": "cpu_core"
     },
@@ -39,7 +43,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of unhalted core clock cycl=
es[This event is alias to CPU_CLK_UNHALTED.THREAD_P]",
+        "BriefDescription": "Counts the number of unhalted core clock cycl=
es [This event is alias to CPU_CLK_UNHALTED.THREAD_P]",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.CORE_P",
         "SampleAfterValue": "2000003",
@@ -55,6 +59,7 @@
     {
         "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
+        "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. It is =
counted on a dedicated fixed counter, leaving the eight programmable counte=
rs available for other events. Note: On all current platforms this event st=
ops counting during 'throttling (TM)' states duty off periods the processor=
 is 'halted'.  The counter update is done at a lower clock rate then the co=
re clock the overflow status bit for this counter may appear 'sticky'.  Aft=
er the counter has overflowed and software clears the overflow status bit a=
nd resets the counter to less than MAX. The reset value to the counter is n=
ot clocked immediately so the overflow status bit will flip 'high (1)' and =
generate another PMI (if enabled) after which the reset value gets clocked =
into the counter. Therefore, software will get the interrupt, read the over=
flow status bit '1 for bit 34 while the counter value is less than MAX. Sof=
tware should ignore this case.",
         "SampleAfterValue": "2000003",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -63,6 +68,7 @@
         "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
+        "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. It is =
counted on a dedicated fixed counter, leaving the four (eight when Hyperthr=
eading is disabled) programmable counters available for other events. Note:=
 On all current platforms this event stops counting during 'throttling (TM)=
' states duty off periods the processor is 'halted'.  The counter update is=
 done at a lower clock rate then the core clock the overflow status bit for=
 this counter may appear 'sticky'.  After the counter has overflowed and so=
ftware clears the overflow status bit and resets the counter to less than M=
AX. The reset value to the counter is not clocked immediately so the overfl=
ow status bit will flip 'high (1)' and generate another PMI (if enabled) af=
ter which the reset value gets clocked into the counter. Therefore, softwar=
e will get the interrupt, read the overflow status bit '1 for bit 34 while =
the counter value is less than MAX. Software should ignore this case.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -77,12 +83,13 @@
     {
         "BriefDescription": "Core cycles when the thread is not in halt st=
ate",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
+        "PublicDescription": "Counts the number of core cycles while the t=
hread is not in a halt state. The thread enters the halt state when it is r=
unning the HLT instruction. This event is a component in many key event rat=
ios. The core frequency may change from time to time due to transitions ass=
ociated with Enhanced Intel SpeedStep Technology or TM2. For this reason th=
is event may have a changing ratio with regards to time. When the core freq=
uency is constant, this event can approximate elapsed time while the core w=
as not in the halt state. It is counted on a dedicated fixed counter, leavi=
ng the eight programmable counters available for other events.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of unhalted core clock cycl=
es[This event is alias to CPU_CLK_UNHALTED.CORE_P]",
+        "BriefDescription": "Counts the number of unhalted core clock cycl=
es [This event is alias to CPU_CLK_UNHALTED.CORE_P]",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
         "SampleAfterValue": "2000003",
@@ -92,6 +99,7 @@
         "BriefDescription": "Thread cycles when thread is not in halt stat=
e",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
+        "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time.",
         "SampleAfterValue": "2000003",
         "Unit": "cpu_core"
     },
@@ -107,6 +115,7 @@
         "BriefDescription": "Number of instructions retired. Fixed Counter=
 - architectural event",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -124,6 +133,7 @@
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.ANY_P",
         "PEBS": "1",
+        "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
         "SampleAfterValue": "2000003",
         "Unit": "cpu_core"
     },
@@ -131,13 +141,24 @@
         "BriefDescription": "Loads blocked due to overlapping with a prece=
ding store that cannot be forwarded.",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
+        "PublicDescription": "Counts the number of times where store forwa=
rding was prevented for a load operation. The most common case is a load bl=
ocked due to the address of memory access (partially) overlapping with a pr=
eceding uncompleted store. Note: See the table of not supported store forwa=
rds in the Optimization Guide.",
         "SampleAfterValue": "100003",
         "UMask": "0x82",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that were not consumed by the back-end pipeline due to lack of bac=
k-end resources, as a result of memory subsystem delays, execution units li=
mitations, or other conditions.",
+        "EventCode": "0xa4",
+        "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
+        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that were not consumed by the back-end pipeline due to lack of ba=
ck-end resources, as a result of memory subsystem delays, execution units l=
imitations, or other conditions.\nThe count is distributed among unhalted l=
ogical processors (hyper-threads) who share the same physical core, in proc=
essors that support Intel Hyper-Threading Technology. Software can use this=
 event as the numerator for the Backend Bound metric (or top-level category=
) of the Top-down Microarchitecture Analysis method.",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "TMA slots available for an unhalted logical p=
rocessor. Fixed counter - architectural event",
         "EventName": "TOPDOWN.SLOTS",
+        "PublicDescription": "Number of available slots for an unhalted lo=
gical processor. The event increments by machine-width of the narrowest pip=
eline as employed by the Top-down Microarchitecture Analysis method (TMA). =
The count is distributed among unhalted logical processors (hyper-threads) =
who share the same physical core. Software can use this event as the denomi=
nator for the top-level metrics of the TMA method. This architectural event=
 is counted on a designated fixed counter (Fixed Counter 3).",
         "SampleAfterValue": "10000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -146,6 +167,7 @@
         "BriefDescription": "TMA slots available for an unhalted logical p=
rocessor. General counter - architectural event",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.SLOTS_P",
+        "PublicDescription": "Counts the number of available slots for an =
unhalted logical processor. The event increments by machine-width of the na=
rrowest pipeline as employed by the Top-down Microarchitecture Analysis met=
hod. The count is distributed among unhalted logical processors (hyper-thre=
ads) who share the same physical core.",
         "SampleAfterValue": "10000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -154,6 +176,7 @@
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend because allocation is stalled due to a mispredict=
ed jump or a machine clear.",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
+        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window, including =
relevant microcode flows, and while uops are not yet available in the instr=
uction queue (IQ) or until an FE_BOUND event occurs besides OTHER and CISC.=
 Also includes the issue slots that were consumed by the backend but were t=
hrown away because they were younger than the mispredict or machine clear."=
,
         "SampleAfterValue": "1000003",
         "Unit": "cpu_atom"
     },
@@ -178,5 +201,14 @@
         "PEBS": "1",
         "SampleAfterValue": "1000003",
         "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that are utilized by operations that eventually get retired (commi=
tted) by the processor pipeline. Usually, this event positively correlates =
with higher performance  for example, as measured by the instructions-per-c=
ycle metric.",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.SLOTS",
+        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that are utilized by operations that eventually get retired (comm=
itted) by the processor pipeline. Usually, this event positively correlates=
 with higher performance  for example, as measured by the instructions-per-=
cycle metric.\nSoftware can use this event as the numerator for the Retirin=
g metric (or top-level category) of the Top-down Microarchitecture Analysis=
 method.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/virtual-memory.json =
b/tools/perf/pmu-events/arch/x86/meteorlake/virtual-memory.json
index 0ee62378bf22..556e4292fcc8 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/virtual-memory.json
@@ -3,6 +3,7 @@
         "BriefDescription": "Load miss in all TLB levels causes a page wal=
k that completes. (All page sizes)",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
+        "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data loads. This implies it missed in the DTLB and furth=
er levels of TLB. The page walk can end with or without a fault.",
         "SampleAfterValue": "100003",
         "UMask": "0xe",
         "Unit": "cpu_core"
@@ -11,6 +12,7 @@
         "BriefDescription": "Store misses in all TLB levels causes a page =
walk that completes. (All page sizes)",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
+        "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data stores. This implies it missed in the DTLB and furt=
her levels of TLB. The page walk can end with or without a fault.",
         "SampleAfterValue": "100003",
         "UMask": "0xe",
         "Unit": "cpu_core"
@@ -19,6 +21,7 @@
         "BriefDescription": "Counts the number of page walks completed due=
 to instruction fetch misses to any page size.",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
+        "PublicDescription": "Counts the number of page walks completed du=
e to instruction fetches whose address translations missed in all Translati=
on Lookaside Buffer (TLB) levels and were mapped to any page size.  Include=
s page walks that page fault.",
         "SampleAfterValue": "200003",
         "UMask": "0xe",
         "Unit": "cpu_atom"
@@ -27,6 +30,7 @@
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (All page sizes)",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
+        "PublicDescription": "Counts completed page walks (all page sizes)=
 caused by a code fetch. This implies it missed in the ITLB (Instruction TL=
B) and further levels of TLB. The page walk can end with or without a fault=
.",
         "SampleAfterValue": "100003",
         "UMask": "0xe",
         "Unit": "cpu_core"
--=20
2.40.0.rc1.284.g88254d51c5-goog

