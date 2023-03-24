Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B9C6C78BD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjCXHXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjCXHXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:23:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DB92684E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:23:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e129-20020a251e87000000b00b56598237f5so1067903ybe.16
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679642580;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htXY5sGJDItXY75tNu49iHBFf3vGbWbJLizWWx2z1Vo=;
        b=G75cuWLpBQVqkqeORpmF1gl1bLJSr+LjHw4taR632UiEvTHsCN2x30sTNHVFu5oq/c
         0t1sTrhgRQ3pouTPMjArJTEYptORSopUz4esvhIfWcH9i2IAX52c2dmun4KFE4dkoatj
         JtraQHCCHaCLYO45ctAaJVzt7xPiTqTrLkW0FYxnDEHCdP3RSt23QuLfT7LmAXQjA3zr
         wlz3XcFu8Vi+j34IjMtgfhCOMdt+Pj8XMtHXKw0t/Gvw5DcbG0fl/CcNijswqHgt37ZM
         DQcsSBq7iPbplIzGE3SNIUviDN3yDVEVp406EwK14KR7CTZMX7deye9l3cp+ftYihXyF
         Un5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679642580;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=htXY5sGJDItXY75tNu49iHBFf3vGbWbJLizWWx2z1Vo=;
        b=eOCD1i4+vSktySUpCCWi2qm0GgfwTgBbjjpg6slVmOeTCeFK27LPis1Le1cb/iNxBP
         l58zTqCdIkKL9eRupI8aXtjgEdasyZcOoISNAi0oice6qxlSv3w256MuL9HMH1iUR2aj
         qdKWHK5r5ik9kpTQyMJFrwUSDjFNZpIaoIge2qo75UiUgLfnwC+GXchARUetLfC47JsY
         timZK7YDVwBDqwuB4iLmcZTdKAClb6gqIbLowbbPeCf1xDzXbyw175vvAN9fpHCksSJZ
         Wb3QDOGKnj/sPafnarN7L/1WK+u4ufvhyWIkkuU/Y/In5Yn4FjPl3DpBdCzWHOzK8+Pu
         r8Fw==
X-Gm-Message-State: AAQBX9feWMh3ssSJ1KqA+ncDWWcMnC8vfIGjzDw76Us0x4qaaTBUcGZg
        WJpe5Lw4p0Tlkjuf90wvtzl+CK+yNnnX
X-Google-Smtp-Source: AKy350ZTu+izpRI2TndhaB1k3Td/CooOIsmIhnMH2evhrd+WzhxckiB6NXoCKoYUyAnbCHWtFkJ5KTpGd6G1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e705:3a3d:46e5:fb50])
 (user=irogers job=sendgmr) by 2002:a05:6902:140e:b0:b76:126b:5aa4 with SMTP
 id z14-20020a056902140e00b00b76126b5aa4mr779610ybu.9.1679642580364; Fri, 24
 Mar 2023 00:23:00 -0700 (PDT)
Date:   Fri, 24 Mar 2023 00:22:12 -0700
In-Reply-To: <20230324072218.181880-1-irogers@google.com>
Message-Id: <20230324072218.181880-4-irogers@google.com>
Mime-Version: 1.0
References: <20230324072218.181880-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v3 3/9] perf vendor events: Broadwellx v20 events
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
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates descriptions and encodings. Adds BR_MISP_EXEC.INDIRECT events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/broadwellx/cache.json |  16 +-
 .../arch/x86/broadwellx/frontend.json         |  18 +-
 .../arch/x86/broadwellx/pipeline.json         |  20 +-
 .../arch/x86/broadwellx/uncore-cache.json     | 156 ++----
 .../x86/broadwellx/uncore-interconnect.json   |  84 +--
 .../arch/x86/broadwellx/uncore-memory.json    | 522 +++++++++---------
 .../arch/x86/broadwellx/uncore-other.json     |  44 +-
 .../arch/x86/broadwellx/uncore-power.json     |  10 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 9 files changed, 403 insertions(+), 469 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/cache.json b/tools/p=
erf/pmu-events/arch/x86/broadwellx/cache.json
index 6a134928b3f0..781e7c64e71f 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/cache.json
@@ -8,7 +8,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Cycles a demand request was blocked due to Fi=
ll Buffers inavailability.",
+        "BriefDescription": "Cycles a demand request was blocked due to Fi=
ll Buffers unavailability.",
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL",
@@ -16,7 +16,7 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "L1D miss oustandings duration in cycles",
+        "BriefDescription": "L1D miss outstandings duration in cycles",
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
@@ -454,22 +454,22 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "All retired load uops.",
+        "BriefDescription": "Retired load uops.",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
         "PEBS": "1",
-        "PublicDescription": "This event counts load uops retired to the a=
rchitected path with a filter on bits 0 and 1 applied.\nNote: This event co=
unts AVX-256bit load/store double-pump memory uops as a single uop at retir=
ement. This event also counts SW prefetches.",
+        "PublicDescription": "Counts all retired load uops. This event acc=
ounts for SW prefetch uops of PREFETCHNTA or PREFETCHT0/1/2 or PREFETCHW.",
         "SampleAfterValue": "2000003",
         "UMask": "0x81"
     },
     {
-        "BriefDescription": "All retired store uops.",
+        "BriefDescription": "Retired store uops.",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
         "PEBS": "1",
-        "PublicDescription": "This event counts store uops retired to the =
architected path with a filter on bits 0 and 1 applied.\nNote: This event c=
ounts AVX-256bit load/store double-pump memory uops as a single uop at reti=
rement.",
+        "PublicDescription": "Counts all retired store uops.",
         "SampleAfterValue": "2000003",
         "UMask": "0x82"
     },
@@ -541,10 +541,10 @@
         "UMask": "0x80"
     },
     {
-        "BriefDescription": "Cacheable and noncachaeble code read requests=
",
+        "BriefDescription": "Cacheable and non-cacheable code read request=
s",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.DEMAND_CODE_RD",
-        "PublicDescription": "This event counts both cacheable and noncach=
aeble code read requests.",
+        "PublicDescription": "This event counts both cacheable and non-cac=
heable code read requests.",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/frontend.json b/tool=
s/perf/pmu-events/arch/x86/broadwellx/frontend.json
index d0f6678609ae..bd5da39564e1 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/frontend.json
@@ -125,16 +125,16 @@
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "Cycles when uops are being delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy",
+        "BriefDescription": "Cycles when uops are being delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequencer (MS) is busy",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_CYCLES",
-        "PublicDescription": "This event counts cycles during which uops a=
re being delivered to Instruction Decode Queue (IDQ) while the Microcode Se=
quenser (MS) is busy. Counting includes uops that may bypass the IDQ. Uops =
maybe initiated by Decode Stream Buffer (DSB) or MITE.",
+        "PublicDescription": "This event counts cycles during which uops a=
re being delivered to Instruction Decode Queue (IDQ) while the Microcode Se=
quencer (MS) is busy. Counting includes uops that may bypass the IDQ. Uops =
maybe initiated by Decode Stream Buffer (DSB) or MITE.",
         "SampleAfterValue": "2000003",
         "UMask": "0x30"
     },
     {
-        "BriefDescription": "Cycles when uops initiated by Decode Stream B=
uffer (DSB) are being delivered to Instruction Decode Queue (IDQ) while Mic=
rocode Sequenser (MS) is busy",
+        "BriefDescription": "Cycles when uops initiated by Decode Stream B=
uffer (DSB) are being delivered to Instruction Decode Queue (IDQ) while Mic=
rocode Sequencer (MS) is busy",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_DSB_CYCLES",
@@ -143,7 +143,7 @@
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "Deliveries to Instruction Decode Queue (IDQ) =
initiated by Decode Stream Buffer (DSB) while Microcode Sequenser (MS) is b=
usy",
+        "BriefDescription": "Deliveries to Instruction Decode Queue (IDQ) =
initiated by Decode Stream Buffer (DSB) while Microcode Sequencer (MS) is b=
usy",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x79",
@@ -153,7 +153,7 @@
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "Uops initiated by Decode Stream Buffer (DSB) =
that are being delivered to Instruction Decode Queue (IDQ) while Microcode =
Sequenser (MS) is busy",
+        "BriefDescription": "Uops initiated by Decode Stream Buffer (DSB) =
that are being delivered to Instruction Decode Queue (IDQ) while Microcode =
Sequencer (MS) is busy",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_DSB_UOPS",
         "PublicDescription": "This event counts the number of uops initiat=
ed by Decode Stream Buffer (DSB) that are being delivered to Instruction De=
code Queue (IDQ) while the Microcode Sequencer (MS) is busy. Counting inclu=
des uops that may bypass the IDQ.",
@@ -161,10 +161,10 @@
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "Uops initiated by MITE and delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy",
+        "BriefDescription": "Uops initiated by MITE and delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequencer (MS) is busy",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_MITE_UOPS",
-        "PublicDescription": "This event counts the number of uops initiat=
ed by MITE and delivered to Instruction Decode Queue (IDQ) while the Microc=
ode Sequenser (MS) is busy. Counting includes uops that may bypass the IDQ.=
",
+        "PublicDescription": "This event counts the number of uops initiat=
ed by MITE and delivered to Instruction Decode Queue (IDQ) while the Microc=
ode Sequencer (MS) is busy. Counting includes uops that may bypass the IDQ.=
",
         "SampleAfterValue": "2000003",
         "UMask": "0x20"
     },
@@ -178,10 +178,10 @@
         "UMask": "0x30"
     },
     {
-        "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) while Microcode Sequenser (MS) is busy",
+        "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) while Microcode Sequencer (MS) is busy",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_UOPS",
-        "PublicDescription": "This event counts the total number of uops d=
elivered to Instruction Decode Queue (IDQ) while the Microcode Sequenser (M=
S) is busy. Counting includes uops that may bypass the IDQ. Uops maybe init=
iated by Decode Stream Buffer (DSB) or MITE.",
+        "PublicDescription": "This event counts the total number of uops d=
elivered to Instruction Decode Queue (IDQ) while the Microcode Sequencer (M=
S) is busy. Counting includes uops that may bypass the IDQ. Uops maybe init=
iated by Decode Stream Buffer (DSB) or MITE.",
         "SampleAfterValue": "2000003",
         "UMask": "0x30"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/broadwellx/pipeline.json
index 75233316640b..9a902d2160e6 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
@@ -214,6 +214,14 @@
         "SampleAfterValue": "200003",
         "UMask": "0xc4"
     },
+    {
+        "BriefDescription": "Speculative mispredicted indirect branches",
+        "EventCode": "0x89",
+        "EventName": "BR_MISP_EXEC.INDIRECT",
+        "PublicDescription": "Counts speculatively miss-predicted indirect=
 branches at execution time. Counts for indirect near CALL or JMP instructi=
ons (RET excluded).",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe4"
+    },
     {
         "BriefDescription": "Not taken speculative and retired mispredicte=
d macro conditional branches",
         "EventCode": "0x89",
@@ -500,7 +508,7 @@
         "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction.",
         "EventCode": "0x87",
         "EventName": "ILD_STALL.LCP",
-        "PublicDescription": "This event counts stalls occured due to chan=
ging prefix length (66, 67 or REX.W when they change the length of the deco=
ded instruction). Occurrences counting is proportional to the number of pre=
fixes in a 16B-line. This may result in the following penalties: three-cycl=
e penalty for each LCP in a 16-byte chunk.",
+        "PublicDescription": "This event counts stalls occurred due to cha=
nging prefix length (66, 67 or REX.W when they change the length of the dec=
oded instruction). Occurrences counting is proportional to the number of pr=
efixes in a 16B-line. This may result in the following penalties: three-cyc=
le penalty for each LCP in a 16-byte chunk.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -909,7 +917,7 @@
     },
     {
         "AnyThread": "1",
-        "BriefDescription": "Cycles per core when uops are exectuted in po=
rt 0.",
+        "BriefDescription": "Cycles per core when uops are executed in por=
t 0.",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_0_CORE",
         "SampleAfterValue": "2000003",
@@ -925,7 +933,7 @@
     },
     {
         "AnyThread": "1",
-        "BriefDescription": "Cycles per core when uops are exectuted in po=
rt 1.",
+        "BriefDescription": "Cycles per core when uops are executed in por=
t 1.",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_1_CORE",
         "SampleAfterValue": "2000003",
@@ -973,7 +981,7 @@
     },
     {
         "AnyThread": "1",
-        "BriefDescription": "Cycles per core when uops are exectuted in po=
rt 4.",
+        "BriefDescription": "Cycles per core when uops are executed in por=
t 4.",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_4_CORE",
         "SampleAfterValue": "2000003",
@@ -989,7 +997,7 @@
     },
     {
         "AnyThread": "1",
-        "BriefDescription": "Cycles per core when uops are exectuted in po=
rt 5.",
+        "BriefDescription": "Cycles per core when uops are executed in por=
t 5.",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_5_CORE",
         "SampleAfterValue": "2000003",
@@ -1005,7 +1013,7 @@
     },
     {
         "AnyThread": "1",
-        "BriefDescription": "Cycles per core when uops are exectuted in po=
rt 6.",
+        "BriefDescription": "Cycles per core when uops are executed in por=
t 6.",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_6_CORE",
         "SampleAfterValue": "2000003",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json b/=
tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
index 746954775437..f794d2992323 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
@@ -5,7 +5,7 @@
         "EventName": "LLC_MISSES.CODE_LLC_PREFETCH",
         "Filter": "filter_opc=3D0x191",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match an opcode.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -16,7 +16,7 @@
         "EventName": "LLC_MISSES.DATA_LLC_PREFETCH",
         "Filter": "filter_opc=3D0x192",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match an opcode.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -27,7 +27,7 @@
         "EventName": "LLC_MISSES.DATA_READ",
         "Filter": "filter_opc=3D0x182",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match an opcode.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -38,7 +38,7 @@
         "EventName": "LLC_MISSES.MMIO_READ",
         "Filter": "filter_opc=3D0x187,filter_nc=3D1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match an opcode.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -49,7 +49,7 @@
         "EventName": "LLC_MISSES.MMIO_WRITE",
         "Filter": "filter_opc=3D0x18f,filter_nc=3D1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match an opcode.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -60,7 +60,7 @@
         "EventName": "LLC_MISSES.PCIE_NON_SNOOP_WRITE",
         "Filter": "filter_opc=3D0x1c8,filter_tid=3D0x3e",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match an opcode.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -71,7 +71,7 @@
         "EventName": "LLC_MISSES.PCIE_READ",
         "Filter": "filter_opc=3D0x19e",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match an opcode.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -82,7 +82,7 @@
         "EventName": "LLC_MISSES.PCIE_WRITE",
         "Filter": "filter_opc=3D0x1c8",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match an opcode.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -93,7 +93,7 @@
         "EventName": "LLC_MISSES.RFO_LLC_PREFETCH",
         "Filter": "filter_opc=3D0x190",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match an opcode.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -104,7 +104,7 @@
         "EventName": "LLC_MISSES.UNCACHEABLE",
         "Filter": "filter_opc=3D0x187",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match an opcode.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -115,7 +115,7 @@
         "EventName": "LLC_REFERENCES.CODE_LLC_PREFETCH",
         "Filter": "filter_opc=3D0x181",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted int=
o the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -126,7 +126,7 @@
         "EventName": "LLC_REFERENCES.PCIE_NS_PARTIAL_WRITE",
         "Filter": "filter_opc=3D0x180,filter_tid=3D0x3e",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted int=
o the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
         "UMask": "0x1",
         "Unit": "CBO"
     },
@@ -136,7 +136,7 @@
         "EventName": "LLC_REFERENCES.PCIE_READ",
         "Filter": "filter_opc=3D0x19e",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted int=
o the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -147,7 +147,7 @@
         "EventName": "LLC_REFERENCES.PCIE_WRITE",
         "Filter": "filter_opc=3D0x1c8,filter_tid=3D0x3e",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted int=
o the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -158,7 +158,7 @@
         "EventName": "LLC_REFERENCES.STREAMING_FULL",
         "Filter": "filter_opc=3D0x18c",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted int=
o the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -169,7 +169,7 @@
         "EventName": "LLC_REFERENCES.STREAMING_PARTIAL",
         "Filter": "filter_opc=3D0x18d",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted int=
o the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -179,14 +179,12 @@
         "EventCode": "0xA",
         "EventName": "UNC_C_BOUNCE_CONTROL",
         "PerPkg": "1",
-        "PublicDescription": "UNC_C_BOUNCE_CONTROL",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "Uncore Clocks",
         "EventName": "UNC_C_CLOCKTICKS",
         "PerPkg": "1",
-        "PublicDescription": "UNC_C_CLOCKTICKS",
         "Unit": "CBO"
     },
     {
@@ -257,7 +255,7 @@
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.WRITE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Writeback transactions from L2 to the=
 LLC  This includes all write transactions -- both Cachable and UC.",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Writeback transactions from L2 to the=
 LLC  This includes all write transactions -- both Cacheable and UC.",
         "UMask": "0x5",
         "Unit": "CBO"
     },
@@ -618,7 +616,6 @@
         "EventCode": "0x5",
         "EventName": "UNC_C_RING_BOUNCES.AD",
         "PerPkg": "1",
-        "PublicDescription": "UNC_C_RING_BOUNCES.AD",
         "UMask": "0x1",
         "Unit": "CBO"
     },
@@ -627,7 +624,6 @@
         "EventCode": "0x5",
         "EventName": "UNC_C_RING_BOUNCES.AK",
         "PerPkg": "1",
-        "PublicDescription": "UNC_C_RING_BOUNCES.AK",
         "UMask": "0x2",
         "Unit": "CBO"
     },
@@ -636,7 +632,6 @@
         "EventCode": "0x5",
         "EventName": "UNC_C_RING_BOUNCES.BL",
         "PerPkg": "1",
-        "PublicDescription": "UNC_C_RING_BOUNCES.BL",
         "UMask": "0x4",
         "Unit": "CBO"
     },
@@ -645,7 +640,6 @@
         "EventCode": "0x5",
         "EventName": "UNC_C_RING_BOUNCES.IV",
         "PerPkg": "1",
-        "PublicDescription": "UNC_C_RING_BOUNCES.IV",
         "UMask": "0x10",
         "Unit": "CBO"
     },
@@ -690,7 +684,6 @@
         "EventCode": "0x6",
         "EventName": "UNC_C_RING_SINK_STARVED.AD",
         "PerPkg": "1",
-        "PublicDescription": "UNC_C_RING_SINK_STARVED.AD",
         "UMask": "0x1",
         "Unit": "CBO"
     },
@@ -699,7 +692,6 @@
         "EventCode": "0x6",
         "EventName": "UNC_C_RING_SINK_STARVED.AK",
         "PerPkg": "1",
-        "PublicDescription": "UNC_C_RING_SINK_STARVED.AK",
         "UMask": "0x2",
         "Unit": "CBO"
     },
@@ -708,7 +700,6 @@
         "EventCode": "0x6",
         "EventName": "UNC_C_RING_SINK_STARVED.BL",
         "PerPkg": "1",
-        "PublicDescription": "UNC_C_RING_SINK_STARVED.BL",
         "UMask": "0x4",
         "Unit": "CBO"
     },
@@ -717,7 +708,6 @@
         "EventCode": "0x6",
         "EventName": "UNC_C_RING_SINK_STARVED.IV",
         "PerPkg": "1",
-        "PublicDescription": "UNC_C_RING_SINK_STARVED.IV",
         "UMask": "0x8",
         "Unit": "CBO"
     },
@@ -726,7 +716,6 @@
         "EventCode": "0x7",
         "EventName": "UNC_C_RING_SRC_THRTL",
         "PerPkg": "1",
-        "PublicDescription": "UNC_C_RING_SRC_THRTL",
         "Unit": "CBO"
     },
     {
@@ -1157,7 +1146,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.ALL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
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
+        "PublicDescription": "Counts the number of entries successfully in=
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
         "UMask": "0x8",
         "Unit": "CBO"
     },
@@ -1166,7 +1155,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.EVICTION",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
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
+        "PublicDescription": "Counts the number of entries successfully in=
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
         "UMask": "0x4",
         "Unit": "CBO"
     },
@@ -1175,7 +1164,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.LOCAL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserted=
 into the TOR that are satisifed by locally HOMed memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserte=
d into the TOR that are satisfied by locally HOMed memory.",
         "UMask": "0x28",
         "Unit": "CBO"
     },
@@ -1184,7 +1173,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.LOCAL_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisif=
ed by an opcode,  inserted into the TOR that are satisifed by locally HOMed=
 memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisf=
ied by an opcode,  inserted into the TOR that are satisfied by locally HOMe=
d memory.",
         "UMask": "0x21",
         "Unit": "CBO"
     },
@@ -1193,7 +1182,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_LOCAL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that are satisifed by locally HOMed memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that are satisfied by locally HOMed memory.",
         "UMask": "0x2a",
         "Unit": "CBO"
     },
@@ -1202,7 +1191,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satisi=
fed by an opcode, inserted into the TOR that are satisifed by locally HOMed=
 memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satis=
fied by an opcode, inserted into the TOR that are satisfied by locally HOMe=
d memory.",
         "UMask": "0x23",
         "Unit": "CBO"
     },
@@ -1211,7 +1200,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match an opcode.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
         "UMask": "0x3",
         "Unit": "CBO"
     },
@@ -1220,7 +1209,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_REMOTE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that are satisifed by remote caches or remote memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that are satisfied by remote caches or remote memory.",
         "UMask": "0x8a",
         "Unit": "CBO"
     },
@@ -1229,7 +1218,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satisi=
fed by an opcode,  inserted into the TOR that are satisifed by remote cache=
s or remote memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satis=
fied by an opcode,  inserted into the TOR that are satisfied by remote cach=
es or remote memory.",
         "UMask": "0x83",
         "Unit": "CBO"
     },
@@ -1238,7 +1227,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_ALL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched (matches =
an RTID destination) transactions inserted into the TOR.  The NID is progra=
mmed in Cn_MSR_PMON_BOX_FILTER.nid.  In conjunction with STATE =3D I, it is=
 possible to monitor misses to specific NIDs in the system.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched (matches=
 an RTID destination) transactions inserted into the TOR.  The NID is progr=
ammed in Cn_MSR_PMON_BOX_FILTER.nid.  In conjunction with STATE =3D I, it i=
s possible to monitor misses to specific NIDs in the system.",
         "UMask": "0x48",
         "Unit": "CBO"
     },
@@ -1247,7 +1236,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_EVICTION",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched eviction tran=
sactions inserted into the TOR.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched eviction tra=
nsactions inserted into the TOR.",
         "UMask": "0x44",
         "Unit": "CBO"
     },
@@ -1256,7 +1245,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_MISS_ALL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched miss requ=
ests that were inserted into the TOR.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched miss req=
uests that were inserted into the TOR.",
         "UMask": "0x4a",
         "Unit": "CBO"
     },
@@ -1265,7 +1254,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_MISS_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match a NID and an opcode.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match a NID and an opcode.",
         "UMask": "0x43",
         "Unit": "CBO"
     },
@@ -1274,7 +1263,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted int=
o the TOR that match a NID and an opcode.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match a NID and an opcode.",
         "UMask": "0x41",
         "Unit": "CBO"
     },
@@ -1283,7 +1272,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_WB",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched write transac=
tions inserted into the TOR.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched write transa=
ctions inserted into the TOR.",
         "UMask": "0x50",
         "Unit": "CBO"
     },
@@ -1292,7 +1281,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted int=
o the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
         "UMask": "0x1",
         "Unit": "CBO"
     },
@@ -1301,7 +1290,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.REMOTE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserted=
 into the TOR that are satisifed by remote caches or remote memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserte=
d into the TOR that are satisfied by remote caches or remote memory.",
         "UMask": "0x88",
         "Unit": "CBO"
     },
@@ -1310,7 +1299,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.REMOTE_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisif=
ed by an opcode,  inserted into the TOR that are satisifed by remote caches=
 or remote memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisf=
ied by an opcode,  inserted into the TOR that are satisfied by remote cache=
s or remote memory.",
         "UMask": "0x81",
         "Unit": "CBO"
     },
@@ -1319,7 +1308,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.WB",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Write transactions insert=
ed into the TOR.   This does not include RFO, but actual operations that co=
ntain data being sent from the core.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Write transactions inser=
ted into the TOR.   This does not include RFO, but actual operations that c=
ontain data being sent from the core.",
         "UMask": "0x10",
         "Unit": "CBO"
     },
@@ -1365,7 +1354,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.LOCAL_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisifed by an opcode,  in the TOR that are satis=
ifed by locally HOMed memory.",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisfied by an opcode,  in the TOR that are satis=
fied by locally HOMed memory.",
         "UMask": "0x21",
         "Unit": "CBO"
     },
@@ -1392,7 +1381,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.MISS_LOCAL_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisifed by an opcode, in the TOR that are sa=
tisifed by locally HOMed memory.",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisfied by an opcode, in the TOR that are sa=
tisfied by locally HOMed memory.",
         "UMask": "0x23",
         "Unit": "CBO"
     },
@@ -1419,7 +1408,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.MISS_REMOTE_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisifed by an opcode, in the TOR that are sa=
tisifed by remote caches or remote memory.",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisfied by an opcode, in the TOR that are sa=
tisfied by remote caches or remote memory.",
         "UMask": "0x83",
         "Unit": "CBO"
     },
@@ -1500,7 +1489,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.REMOTE_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisifed by an opcode,  in the TOR that are satis=
ifed by remote caches or remote memory.",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisfied by an opcode,  in the TOR that are satis=
fied by remote caches or remote memory.",
         "UMask": "0x81",
         "Unit": "CBO"
     },
@@ -1518,7 +1507,6 @@
         "EventCode": "0x4",
         "EventName": "UNC_C_TxR_ADS_USED.AD",
         "PerPkg": "1",
-        "PublicDescription": "UNC_C_TxR_ADS_USED.AD",
         "UMask": "0x1",
         "Unit": "CBO"
     },
@@ -1527,7 +1515,6 @@
         "EventCode": "0x4",
         "EventName": "UNC_C_TxR_ADS_USED.AK",
         "PerPkg": "1",
-        "PublicDescription": "UNC_C_TxR_ADS_USED.AK",
         "UMask": "0x2",
         "Unit": "CBO"
     },
@@ -1536,7 +1523,6 @@
         "EventCode": "0x4",
         "EventName": "UNC_C_TxR_ADS_USED.BL",
         "PerPkg": "1",
-        "PublicDescription": "UNC_C_TxR_ADS_USED.BL",
         "UMask": "0x4",
         "Unit": "CBO"
     },
@@ -1590,7 +1576,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_C_TxR_INSERTS.BL_CORE",
         "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Corebo destined for the BL ring.  This is commonly used for=
 transfering writeback data to the cache.",
+        "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Corebo destined for the BL ring.  This is commonly used for=
 transferring writeback data to the cache.",
         "UMask": "0x40",
         "Unit": "CBO"
     },
@@ -1737,7 +1723,7 @@
         "EventCode": "0x41",
         "EventName": "UNC_H_DIRECTORY_LAT_OPT",
         "PerPkg": "1",
-        "PublicDescription": "Directory Latency Optimization Data Return P=
ath Taken. When directory mode is enabled and the directory retuned for a r=
ead is Dir=3DI, then data can be returned using a faster path if certain co=
nditions are met (credits, free pipeline, etc).",
+        "PublicDescription": "Directory Latency Optimization Data Return P=
ath Taken. When directory mode is enabled and the directory returned for a =
read is Dir=3DI, then data can be returned using a faster path if certain c=
onditions are met (credits, free pipeline, etc).",
         "Unit": "HA"
     },
     {
@@ -1790,7 +1776,6 @@
         "EventCode": "0x71",
         "EventName": "UNC_H_HITME_HIT.ACKCNFLTWBI",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_HIT.ACKCNFLTWBI",
         "UMask": "0x4",
         "Unit": "HA"
     },
@@ -1799,7 +1784,6 @@
         "EventCode": "0x71",
         "EventName": "UNC_H_HITME_HIT.ALL",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_HIT.ALL",
         "UMask": "0xff",
         "Unit": "HA"
     },
@@ -1808,7 +1792,6 @@
         "EventCode": "0x71",
         "EventName": "UNC_H_HITME_HIT.ALLOCS",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_HIT.ALLOCS",
         "UMask": "0x70",
         "Unit": "HA"
     },
@@ -1817,7 +1800,6 @@
         "EventCode": "0x71",
         "EventName": "UNC_H_HITME_HIT.EVICTS",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_HIT.EVICTS",
         "UMask": "0x42",
         "Unit": "HA"
     },
@@ -1826,7 +1808,6 @@
         "EventCode": "0x71",
         "EventName": "UNC_H_HITME_HIT.HOM",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_HIT.HOM",
         "UMask": "0xf",
         "Unit": "HA"
     },
@@ -1835,7 +1816,6 @@
         "EventCode": "0x71",
         "EventName": "UNC_H_HITME_HIT.INVALS",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_HIT.INVALS",
         "UMask": "0x26",
         "Unit": "HA"
     },
@@ -1844,7 +1824,6 @@
         "EventCode": "0x71",
         "EventName": "UNC_H_HITME_HIT.READ_OR_INVITOE",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_HIT.READ_OR_INVITOE",
         "UMask": "0x1",
         "Unit": "HA"
     },
@@ -1853,7 +1832,6 @@
         "EventCode": "0x71",
         "EventName": "UNC_H_HITME_HIT.RSP",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_HIT.RSP",
         "UMask": "0x80",
         "Unit": "HA"
     },
@@ -1862,7 +1840,6 @@
         "EventCode": "0x71",
         "EventName": "UNC_H_HITME_HIT.RSPFWDI_LOCAL",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_HIT.RSPFWDI_LOCAL",
         "UMask": "0x20",
         "Unit": "HA"
     },
@@ -1871,7 +1848,6 @@
         "EventCode": "0x71",
         "EventName": "UNC_H_HITME_HIT.RSPFWDI_REMOTE",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_HIT.RSPFWDI_REMOTE",
         "UMask": "0x10",
         "Unit": "HA"
     },
@@ -1880,7 +1856,6 @@
         "EventCode": "0x71",
         "EventName": "UNC_H_HITME_HIT.RSPFWDS",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_HIT.RSPFWDS",
         "UMask": "0x40",
         "Unit": "HA"
     },
@@ -1889,7 +1864,6 @@
         "EventCode": "0x71",
         "EventName": "UNC_H_HITME_HIT.WBMTOE_OR_S",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_HIT.WBMTOE_OR_S",
         "UMask": "0x8",
         "Unit": "HA"
     },
@@ -1898,7 +1872,6 @@
         "EventCode": "0x71",
         "EventName": "UNC_H_HITME_HIT.WBMTOI",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_HIT.WBMTOI",
         "UMask": "0x2",
         "Unit": "HA"
     },
@@ -1907,7 +1880,6 @@
         "EventCode": "0x72",
         "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.ACKCNFLTWBI",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_HIT_PV_BITS_SET.ACKCNFLTWBI",
         "UMask": "0x4",
         "Unit": "HA"
     },
@@ -1916,7 +1888,6 @@
         "EventCode": "0x72",
         "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.ALL",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_HIT_PV_BITS_SET.ALL",
         "UMask": "0xff",
         "Unit": "HA"
     },
@@ -1925,7 +1896,6 @@
         "EventCode": "0x72",
         "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.HOM",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_HIT_PV_BITS_SET.HOM",
         "UMask": "0xf",
         "Unit": "HA"
     },
@@ -1934,7 +1904,6 @@
         "EventCode": "0x72",
         "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.READ_OR_INVITOE",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_HIT_PV_BITS_SET.READ_OR_INVITOE"=
,
         "UMask": "0x1",
         "Unit": "HA"
     },
@@ -1943,7 +1912,6 @@
         "EventCode": "0x72",
         "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.RSP",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_HIT_PV_BITS_SET.RSP",
         "UMask": "0x80",
         "Unit": "HA"
     },
@@ -1952,7 +1920,6 @@
         "EventCode": "0x72",
         "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.RSPFWDI_LOCAL",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_HIT_PV_BITS_SET.RSPFWDI_LOCAL",
         "UMask": "0x20",
         "Unit": "HA"
     },
@@ -1961,7 +1928,6 @@
         "EventCode": "0x72",
         "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.RSPFWDI_REMOTE",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_HIT_PV_BITS_SET.RSPFWDI_REMOTE",
         "UMask": "0x10",
         "Unit": "HA"
     },
@@ -1970,7 +1936,6 @@
         "EventCode": "0x72",
         "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.RSPFWDS",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_HIT_PV_BITS_SET.RSPFWDS",
         "UMask": "0x40",
         "Unit": "HA"
     },
@@ -1979,7 +1944,6 @@
         "EventCode": "0x72",
         "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.WBMTOE_OR_S",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_HIT_PV_BITS_SET.WBMTOE_OR_S",
         "UMask": "0x8",
         "Unit": "HA"
     },
@@ -1988,7 +1952,6 @@
         "EventCode": "0x72",
         "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.WBMTOI",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_HIT_PV_BITS_SET.WBMTOI",
         "UMask": "0x2",
         "Unit": "HA"
     },
@@ -1997,7 +1960,6 @@
         "EventCode": "0x70",
         "EventName": "UNC_H_HITME_LOOKUP.ACKCNFLTWBI",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_LOOKUP.ACKCNFLTWBI",
         "UMask": "0x4",
         "Unit": "HA"
     },
@@ -2006,7 +1968,6 @@
         "EventCode": "0x70",
         "EventName": "UNC_H_HITME_LOOKUP.ALL",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_LOOKUP.ALL",
         "UMask": "0xff",
         "Unit": "HA"
     },
@@ -2015,7 +1976,6 @@
         "EventCode": "0x70",
         "EventName": "UNC_H_HITME_LOOKUP.ALLOCS",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_LOOKUP.ALLOCS",
         "UMask": "0x70",
         "Unit": "HA"
     },
@@ -2024,7 +1984,6 @@
         "EventCode": "0x70",
         "EventName": "UNC_H_HITME_LOOKUP.HOM",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_LOOKUP.HOM",
         "UMask": "0xf",
         "Unit": "HA"
     },
@@ -2033,7 +1992,6 @@
         "EventCode": "0x70",
         "EventName": "UNC_H_HITME_LOOKUP.INVALS",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_LOOKUP.INVALS",
         "UMask": "0x26",
         "Unit": "HA"
     },
@@ -2042,7 +2000,6 @@
         "EventCode": "0x70",
         "EventName": "UNC_H_HITME_LOOKUP.READ_OR_INVITOE",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_LOOKUP.READ_OR_INVITOE",
         "UMask": "0x1",
         "Unit": "HA"
     },
@@ -2051,7 +2008,6 @@
         "EventCode": "0x70",
         "EventName": "UNC_H_HITME_LOOKUP.RSP",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_LOOKUP.RSP",
         "UMask": "0x80",
         "Unit": "HA"
     },
@@ -2060,7 +2016,6 @@
         "EventCode": "0x70",
         "EventName": "UNC_H_HITME_LOOKUP.RSPFWDI_LOCAL",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_LOOKUP.RSPFWDI_LOCAL",
         "UMask": "0x20",
         "Unit": "HA"
     },
@@ -2069,7 +2024,6 @@
         "EventCode": "0x70",
         "EventName": "UNC_H_HITME_LOOKUP.RSPFWDI_REMOTE",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_LOOKUP.RSPFWDI_REMOTE",
         "UMask": "0x10",
         "Unit": "HA"
     },
@@ -2078,7 +2032,6 @@
         "EventCode": "0x70",
         "EventName": "UNC_H_HITME_LOOKUP.RSPFWDS",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_LOOKUP.RSPFWDS",
         "UMask": "0x40",
         "Unit": "HA"
     },
@@ -2087,7 +2040,6 @@
         "EventCode": "0x70",
         "EventName": "UNC_H_HITME_LOOKUP.WBMTOE_OR_S",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_LOOKUP.WBMTOE_OR_S",
         "UMask": "0x8",
         "Unit": "HA"
     },
@@ -2096,7 +2048,6 @@
         "EventCode": "0x70",
         "EventName": "UNC_H_HITME_LOOKUP.WBMTOI",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_HITME_LOOKUP.WBMTOI",
         "UMask": "0x2",
         "Unit": "HA"
     },
@@ -2168,7 +2119,6 @@
         "EventCode": "0x1E",
         "EventName": "UNC_H_IMC_RETRY",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_IMC_RETRY",
         "Unit": "HA"
     },
     {
@@ -2221,7 +2171,6 @@
         "EventCode": "0x61",
         "EventName": "UNC_H_IOT_BACKPRESSURE.HUB",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_IOT_BACKPRESSURE.HUB",
         "UMask": "0x2",
         "Unit": "HA"
     },
@@ -2230,7 +2179,6 @@
         "EventCode": "0x61",
         "EventName": "UNC_H_IOT_BACKPRESSURE.SAT",
         "PerPkg": "1",
-        "PublicDescription": "UNC_H_IOT_BACKPRESSURE.SAT",
         "UMask": "0x1",
         "Unit": "HA"
     },
@@ -2889,7 +2837,7 @@
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSPSFWD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the total number of RspI snoop respon=
ses received.  Whenever a snoops are issued, one or more snoop responses wi=
ll be returned depending on the topology of the system.   In systems larger=
 than 2s, when multiple snoops are returned this will count all the snoops =
that are received.  For example, if 3 snoops were issued and returned RspI,=
 RspS, and RspSFwd; then each of these sub-events would increment by 1.; Fi=
lters for a snoop response of RspSFwd.  This is returned when a remote cach=
ing agent forwards data but holds on to its currentl copy.  This is common =
for data and code reads that hit in a remote socket in E or F state.",
+        "PublicDescription": "Counts the total number of RspI snoop respon=
ses received.  Whenever a snoops are issued, one or more snoop responses wi=
ll be returned depending on the topology of the system.   In systems larger=
 than 2s, when multiple snoops are returned this will count all the snoops =
that are received.  For example, if 3 snoops were issued and returned RspI,=
 RspS, and RspSFwd; then each of these sub-events would increment by 1.; Fi=
lters for a snoop response of RspSFwd.  This is returned when a remote cach=
ing agent forwards data but holds on to its current copy.  This is common f=
or data and code reads that hit in a remote socket in E or F state.",
         "ScaleUnit": "64Bytes",
         "UMask": "0x8",
         "Unit": "HA"
@@ -2963,7 +2911,7 @@
         "EventCode": "0x60",
         "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPSFWD",
         "PerPkg": "1",
-        "PublicDescription": "Number of snoop responses received for a Loc=
al  request; Filters for a snoop response of RspSFwd.  This is returned whe=
n a remote caching agent forwards data but holds on to its currentl copy.  =
This is common for data and code reads that hit in a remote socket in E or =
F state.",
+        "PublicDescription": "Number of snoop responses received for a Loc=
al  request; Filters for a snoop response of RspSFwd.  This is returned whe=
n a remote caching agent forwards data but holds on to its current copy.  T=
his is common for data and code reads that hit in a remote socket in E or F=
 state.",
         "UMask": "0x8",
         "Unit": "HA"
     },
@@ -3175,7 +3123,7 @@
         "Unit": "HA"
     },
     {
-        "BriefDescription": "Tracker Occupancy Accumultor; Local InvItoE R=
equests",
+        "BriefDescription": "Tracker Occupancy Accumulator; Local InvItoE =
Requests",
         "EventCode": "0x4",
         "EventName": "UNC_H_TRACKER_OCCUPANCY.INVITOE_LOCAL",
         "PerPkg": "1",
@@ -3184,7 +3132,7 @@
         "Unit": "HA"
     },
     {
-        "BriefDescription": "Tracker Occupancy Accumultor; Remote InvItoE =
Requests",
+        "BriefDescription": "Tracker Occupancy Accumulator; Remote InvItoE=
 Requests",
         "EventCode": "0x4",
         "EventName": "UNC_H_TRACKER_OCCUPANCY.INVITOE_REMOTE",
         "PerPkg": "1",
@@ -3193,7 +3141,7 @@
         "Unit": "HA"
     },
     {
-        "BriefDescription": "Tracker Occupancy Accumultor; Local Read Requ=
ests",
+        "BriefDescription": "Tracker Occupancy Accumulator; Local Read Req=
uests",
         "EventCode": "0x4",
         "EventName": "UNC_H_TRACKER_OCCUPANCY.READS_LOCAL",
         "PerPkg": "1",
@@ -3202,7 +3150,7 @@
         "Unit": "HA"
     },
     {
-        "BriefDescription": "Tracker Occupancy Accumultor; Remote Read Req=
uests",
+        "BriefDescription": "Tracker Occupancy Accumulator; Remote Read Re=
quests",
         "EventCode": "0x4",
         "EventName": "UNC_H_TRACKER_OCCUPANCY.READS_REMOTE",
         "PerPkg": "1",
@@ -3211,7 +3159,7 @@
         "Unit": "HA"
     },
     {
-        "BriefDescription": "Tracker Occupancy Accumultor; Local Write Req=
uests",
+        "BriefDescription": "Tracker Occupancy Accumulator; Local Write Re=
quests",
         "EventCode": "0x4",
         "EventName": "UNC_H_TRACKER_OCCUPANCY.WRITES_LOCAL",
         "PerPkg": "1",
@@ -3220,7 +3168,7 @@
         "Unit": "HA"
     },
     {
-        "BriefDescription": "Tracker Occupancy Accumultor; Remote Write Re=
quests",
+        "BriefDescription": "Tracker Occupancy Accumulator; Remote Write R=
equests",
         "EventCode": "0x4",
         "EventName": "UNC_H_TRACKER_OCCUPANCY.WRITES_REMOTE",
         "PerPkg": "1",
@@ -3229,7 +3177,7 @@
         "Unit": "HA"
     },
     {
-        "BriefDescription": "Data Pending Occupancy Accumultor; Local Requ=
ests",
+        "BriefDescription": "Data Pending Occupancy Accumulator; Local Req=
uests",
         "EventCode": "0x5",
         "EventName": "UNC_H_TRACKER_PENDING_OCCUPANCY.LOCAL",
         "PerPkg": "1",
@@ -3238,7 +3186,7 @@
         "Unit": "HA"
     },
     {
-        "BriefDescription": "Data Pending Occupancy Accumultor; Remote Req=
uests",
+        "BriefDescription": "Data Pending Occupancy Accumulator; Remote Re=
quests",
         "EventCode": "0x5",
         "EventName": "UNC_H_TRACKER_PENDING_OCCUPANCY.REMOTE",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.=
json b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
index 489a3673323d..2819c6621089 100644
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
not the same as data bandwidth.  For example, when we are transfering a 64B=
 cacheline across QPI, we will break it into 9 flits -- 1 with header infor=
mation and 8 with 64 bits of actual data and an additional 16 bits of other=
 information.  To calculate data bandwidth, one should therefore do: data f=
lits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NULL =
non-data flits transmitted across QPI.  This basically tracks the protocol =
overhead on the QPI link.  One can get a good picture of the QPI-link chara=
cteristics by evaluating the protocol flits, data flits, and idle/null flit=
s.  This includes the header flits for data packets.",
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
not the same as data bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual data and an additional 16 bits of othe=
r information.  To calculate data bandwidth, one should therefore do: data =
flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NULL=
 non-data flits transmitted across QPI.  This basically tracks the protocol=
 overhead on the QPI link.  One can get a good picture of the QPI-link char=
acteristics by evaluating the protocol flits, data flits, and idle/null fli=
ts.  This includes the header flits for data packets.",
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
         "ScaleUnit": "8Bytes",
         "UMask": "0x2",
         "Unit": "QPI LL"
@@ -38,7 +38,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn failed because there were not enough Egress =
credits.  Had there been enough credits, the spawn would have worked as the=
 RBT bit was set and the RBT tag matched.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because there were not enough Egress=
 credits.  Had there been enough credits, the spawn would have worked as th=
e RBT bit was set and the RBT tag matched.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
@@ -47,7 +47,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_MISS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn failed because the RBT tag did not match and=
 there weren't enough Egress credits.   The valid bit was set.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the RBT tag did not match an=
d there weren't enough Egress credits.   The valid bit was set.",
         "UMask": "0x20",
         "Unit": "QPI LL"
     },
@@ -56,7 +56,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_RBT",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn failed because there were not enough Egress =
credits AND the RBT bit was not set, but the RBT tag matched.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because there were not enough Egress=
 credits AND the RBT bit was not set, but the RBT tag matched.",
         "UMask": "0x8",
         "Unit": "QPI LL"
     },
@@ -65,7 +65,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_RBT_MISS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn failed because the RBT tag did not match, th=
e valid bit was not set and there weren't enough Egress credits.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the RBT tag did not match, t=
he valid bit was not set and there weren't enough Egress credits.",
         "UMask": "0x80",
         "Unit": "QPI LL"
     },
@@ -74,7 +74,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_MISS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn failed because the RBT tag did not match alt=
hough the valid bit was set and there were enough Egress credits.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the RBT tag did not match al=
though the valid bit was set and there were enough Egress credits.",
         "UMask": "0x10",
         "Unit": "QPI LL"
     },
@@ -83,7 +83,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_RBT_HIT",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn failed because the route-back table (RBT) sp=
ecified that the transaction should not trigger a direct2core tranaction.  =
This is common for IO transactions.  There were enough Egress credits and t=
he RBT tag matched but the valid bit was not set.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the route-back table (RBT) s=
pecified that the transaction should not trigger a direct2core transaction.=
  This is common for IO transactions.  There were enough Egress credits and=
 the RBT tag matched but the valid bit was not set.",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
@@ -92,7 +92,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_RBT_MISS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn failed because the RBT tag did not match and=
 the valid bit was not set although there were enough Egress credits.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the RBT tag did not match an=
d the valid bit was not set although there were enough Egress credits.",
         "UMask": "0x40",
         "Unit": "QPI LL"
     },
@@ -101,7 +101,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.SUCCESS_RBT_HIT",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn was successful.  There were sufficient credi=
ts, the RBT valid bit was set and there was an RBT tag match.  The message =
was marked to spawn direct2core.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn was successful.  There were sufficient cred=
its, the RBT valid bit was set and there was an RBT tag match.  The message=
 was marked to spawn direct2core.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
@@ -134,7 +134,7 @@
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
he same as data bandwidth.  For example, when we are transferring a 64B cac=
heline across QPI, we will break it into 9 flits -- 1 with header informati=
on and 8 with 64 bits of actual data and an additional 16 bits of other inf=
ormation.  To calculate data bandwidth, one should therefore do: data flits=
 * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of flits receive=
d over QPI that do not hold protocol payload.  When QPI is not in a power s=
aving state, it continuously transmits flits across the link.  When there a=
re no protocol flits to send, it will send IDLE and NULL flits  across.  Th=
ese flits sometimes do carry a payload, such as credit returns, but are gen=
erally not considered part of the QPI bandwidth.",
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
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the total number of flits received over QPI on the DRS (Data Respon=
se) channel.  DRS flits are used to transmit data with coherency.  This doe=
s not count data flits received over the NCB channel which transmits non-co=
herent data.",
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
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of flits received over QPI on the DRS (Data Respo=
nse) channel.  DRS flits are used to transmit data with coherency.  This do=
es not count data flits received over the NCB channel which transmits non-c=
oherent data.",
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
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the total number of data flits received over QPI on the DRS (Data R=
esponse) channel.  DRS flits are used to transmit data with coherency.  Thi=
s does not count data flits received over the NCB channel which transmits n=
on-coherent data.  This includes only the data flits (not the header).",
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
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of data flits received over QPI on the DRS (Data =
Response) channel.  DRS flits are used to transmit data with coherency.  Th=
is does not count data flits received over the NCB channel which transmits =
non-coherent data.  This includes only the data flits (not the header).",
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
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the total number of protocol flits received over QPI on the DRS (Da=
ta Response) channel.  DRS flits are used to transmit data with coherency. =
 This does not count data flits received over the NCB channel which transmi=
ts non-coherent data.  This includes only the header flits (not the data). =
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
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of protocol flits received over QPI on the DRS (D=
ata Response) channel.  DRS flits are used to transmit data with coherency.=
  This does not count data flits received over the NCB channel which transm=
its non-coherent data.  This includes only the header flits (not the data).=
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
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the number of flits received over QPI on the home channel.",
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
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the number of flits received over QPI on the home channel.",
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
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the number of non-request flits received over QPI on the home chann=
el.  These are most commonly snoop responses, and this event can be used as=
 a proxy for that.",
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
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the number of non-request flits received over QPI on the home chan=
nel.  These are most commonly snoop responses, and this event can be used a=
s a proxy for that.",
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
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the number of data request received over QPI on the home channel.  =
This basically counts the number of remote memory requests received over QP=
I.  In conjunction with the local read count in the Home Agent, one can cal=
culate the number of LLC Misses.",
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
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the number of data request received over QPI on the home channel. =
 This basically counts the number of remote memory requests received over Q=
PI.  In conjunction with the local read count in the Home Agent, one can ca=
lculate the number of LLC Misses.",
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
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the number of snoop request flits received over QPI.  These request=
s are contained in the snoop channel.  This does not include snoop response=
s, which are received on the home channel.",
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
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the number of snoop request flits received over QPI.  These reques=
ts are contained in the snoop channel.  This does not include snoop respons=
es, which are received on the home channel.",
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
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Number of Non-Coherent Bypass flits.  These packets are generally used to =
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
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Number of Non-Coherent Bypass flits.  These packets are generally used to=
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
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Number of Non-Coherent Bypass data flits.  These flits are generally used =
to transmit non-coherent data across QPI.  This does not include a count of=
 the DRS (coherent) data flits.  This only counts the data flits, not the N=
CB headers.",
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
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Number of Non-Coherent Bypass data flits.  These flits are generally used=
 to transmit non-coherent data across QPI.  This does not include a count o=
f the DRS (coherent) data flits.  This only counts the data flits, not the =
NCB headers.",
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
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Number of Non-Coherent Bypass non-data flits.  These packets are generally=
 used to transmit non-coherent data across QPI, and the flits counted here =
are for headers and other non-data flits.  This includes extended headers."=
,
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
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Number of Non-Coherent Bypass non-data flits.  These packets are generall=
y used to transmit non-coherent data across QPI, and the flits counted here=
 are for headers and other non-data flits.  This includes extended headers.=
",
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
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Number of NCS (non-coherent standard) flits received over QPI.    This inc=
ludes extended headers.",
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
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Number of NCS (non-coherent standard) flits received over QPI.    This in=
cludes extended headers.",
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
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the total number of flits received over the NDR (Non-Data Response)=
 channel.  This channel is used to send a variety of protocol flits includi=
ng grants and completions.  This is only for NDR packets to the local socke=
t which use the AK ring.",
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
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of flits received over the NDR (Non-Data Response=
) channel.  This channel is used to send a variety of protocol flits includ=
ing grants and completions.  This is only for NDR packets to the local sock=
et which use the AK ring.",
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
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the total number of flits received over the NDR (Non-Data Response)=
 channel.  This channel is used to send a variety of protocol flits includi=
ng grants and completions.  This is only for NDR packets destined for Route=
-thru to a remote socket.",
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
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of flits received over the NDR (Non-Data Response=
) channel.  This channel is used to send a variety of protocol flits includ=
ing grants and completions.  This is only for NDR packets destined for Rout=
e-thru to a remote socket.",
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
not the same as data bandwidth.  For example, when we are transfering a 64B=
 cacheline across QPI, we will break it into 9 flits -- 1 with header infor=
mation and 8 with 64 bits of actual data and an additional 16 bits of other=
 information.  To calculate data bandwidth, one should therefore do: data f=
lits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NULL =
non-data flits transmitted across QPI.  This basically tracks the protocol =
overhead on the QPI link.  One can get a good picture of the QPI-link chara=
cteristics by evaluating the protocol flits, data flits, and idle/null flit=
s.  This includes the header flits for data packets.",
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
not the same as data bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual data and an additional 16 bits of othe=
r information.  To calculate data bandwidth, one should therefore do: data =
flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NULL=
 non-data flits transmitted across QPI.  This basically tracks the protocol=
 overhead on the QPI link.  One can get a good picture of the QPI-link char=
acteristics by evaluating the protocol flits, data flits, and idle/null fli=
ts.  This includes the header flits for data packets.",
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
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the total number of flits transmitted over QPI on the DRS (Data=
 Response) channel.  DRS flits are used to transmit data with coherency.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of flits transmitted over QPI on the DRS (Da=
ta Response) channel.  DRS flits are used to transmit data with coherency."=
,
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
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the total number of data flits transmitted over QPI on the DRS =
(Data Response) channel.  DRS flits are used to transmit data with coherenc=
y.  This does not count data flits transmitted over the NCB channel which t=
ransmits non-coherent data.  This includes only the data flits (not the hea=
der).",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of data flits transmitted over QPI on the DR=
S (Data Response) channel.  DRS flits are used to transmit data with cohere=
ncy.  This does not count data flits transmitted over the NCB channel which=
 transmits non-coherent data.  This includes only the data flits (not the h=
eader).",
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
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the total number of protocol flits transmitted over QPI on the =
DRS (Data Response) channel.  DRS flits are used to transmit data with cohe=
rency.  This does not count data flits transmitted over the NCB channel whi=
ch transmits non-coherent data.  This includes only the header flits (not t=
he data).  This includes extended headers.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of protocol flits transmitted over QPI on th=
e DRS (Data Response) channel.  DRS flits are used to transmit data with co=
herency.  This does not count data flits transmitted over the NCB channel w=
hich transmits non-coherent data.  This includes only the header flits (not=
 the data).  This includes extended headers.",
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
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the number of flits transmitted over QPI on the home channel.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the number of flits transmitted over QPI on the home channel.=
",
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
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the number of non-request flits transmitted over QPI on the hom=
e channel.  These are most commonly snoop responses, and this event can be =
used as a proxy for that.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the number of non-request flits transmitted over QPI on the h=
ome channel.  These are most commonly snoop responses, and this event can b=
e used as a proxy for that.",
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
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the number of data request transmitted over QPI on the home cha=
nnel.  This basically counts the number of remote memory requests transmitt=
ed over QPI.  In conjunction with the local read count in the Home Agent, o=
ne can calculate the number of LLC Misses.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the number of data request transmitted over QPI on the home c=
hannel.  This basically counts the number of remote memory requests transmi=
tted over QPI.  In conjunction with the local read count in the Home Agent,=
 one can calculate the number of LLC Misses.",
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
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the number of snoop request flits transmitted over QPI.  These =
requests are contained in the snoop channel.  This does not include snoop r=
esponses, which are transmitted on the home channel.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the number of snoop request flits transmitted over QPI.  Thes=
e requests are contained in the snoop channel.  This does not include snoop=
 responses, which are transmitted on the home channel.",
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
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Number of Non-Coherent Bypass flits.  These packets are generally used=
 to transmit non-coherent data across QPI.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Number of Non-Coherent Bypass flits.  These packets are generally us=
ed to transmit non-coherent data across QPI.",
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
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Number of Non-Coherent Bypass data flits.  These flits are generally u=
sed to transmit non-coherent data across QPI.  This does not include a coun=
t of the DRS (coherent) data flits.  This only counts the data flits, not t=
e NCB headers.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Number of Non-Coherent Bypass data flits.  These flits are generally=
 used to transmit non-coherent data across QPI.  This does not include a co=
unt of the DRS (coherent) data flits.  This only counts the data flits, not=
 the NCB headers.",
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
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Number of Non-Coherent Bypass non-data flits.  These packets are gener=
ally used to transmit non-coherent data across QPI, and the flits counted h=
ere are for headers and other non-data flits.  This includes extended heade=
rs.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Number of Non-Coherent Bypass non-data flits.  These packets are gen=
erally used to transmit non-coherent data across QPI, and the flits counted=
 here are for headers and other non-data flits.  This includes extended hea=
ders.",
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
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Number of NCS (non-coherent standard) flits transmitted over QPI.    T=
his includes extended headers.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Number of NCS (non-coherent standard) flits transmitted over QPI.   =
 This includes extended headers.",
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
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the total number of flits transmitted over the NDR (Non-Data Re=
sponse) channel.  This channel is used to send a variety of protocol flits =
including grants and completions.  This is only for NDR packets to the loca=
l socket which use the AK ring.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of flits transmitted over the NDR (Non-Data =
Response) channel.  This channel is used to send a variety of protocol flit=
s including grants and completions.  This is only for NDR packets to the lo=
cal socket which use the AK ring.",
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
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the total number of flits transmitted over the NDR (Non-Data Re=
sponse) channel.  This channel is used to send a variety of protocol flits =
including grants and completions.  This is only for NDR packets destined fo=
r Route-thru to a remote socket.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of flits transmitted over the NDR (Non-Data =
Response) channel.  This channel is used to send a variety of protocol flit=
s including grants and completions.  This is only for NDR packets destined =
for Route-thru to a remote socket.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
@@ -1157,7 +1157,7 @@
         "EventCode": "0x23",
         "EventName": "UNC_Q_TxR_AD_SNP_CREDIT_OCCUPANCY.VN0",
         "PerPkg": "1",
-        "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle.  Flow Control FIFO fro Snoop messages on AD.",
+        "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle.  Flow Control FIFO for Snoop messages on AD.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
@@ -1166,7 +1166,7 @@
         "EventCode": "0x23",
         "EventName": "UNC_Q_TxR_AD_SNP_CREDIT_OCCUPANCY.VN1",
         "PerPkg": "1",
-        "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle.  Flow Control FIFO fro Snoop messages on AD.",
+        "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle.  Flow Control FIFO for Snoop messages on AD.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-memory.json b=
/tools/perf/pmu-events/arch/x86/broadwellx/uncore-memory.json
index 34dfc3cf22ef..b5a33e7a68c6 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-memory.json
@@ -51,7 +51,6 @@
         "EventCode": "0xA1",
         "EventName": "UNC_M_BYP_CMDS.ACT",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_BYP_CMDS.ACT",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -60,7 +59,6 @@
         "EventCode": "0xA1",
         "EventName": "UNC_M_BYP_CMDS.CAS",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_BYP_CMDS.CAS",
         "UMask": "0x2",
         "Unit": "iMC"
     },
@@ -69,7 +67,6 @@
         "EventCode": "0xA1",
         "EventName": "UNC_M_BYP_CMDS.PRE",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_BYP_CMDS.PRE",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -202,7 +199,7 @@
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
@@ -492,7 +489,6 @@
         "EventCode": "0xA0",
         "EventName": "UNC_M_RD_CAS_PRIO.HIGH",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_PRIO.HIGH",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -501,7 +497,6 @@
         "EventCode": "0xA0",
         "EventName": "UNC_M_RD_CAS_PRIO.LOW",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_PRIO.LOW",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -510,7 +505,6 @@
         "EventCode": "0xA0",
         "EventName": "UNC_M_RD_CAS_PRIO.MED",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_PRIO.MED",
         "UMask": "0x2",
         "Unit": "iMC"
     },
@@ -519,7 +513,6 @@
         "EventCode": "0xA0",
         "EventName": "UNC_M_RD_CAS_PRIO.PANIC",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_PRIO.PANIC",
         "UMask": "0x8",
         "Unit": "iMC"
     },
@@ -528,7 +521,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.ALLBANKS",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK0.ALLBANKS",
+        "PublicDescription": "RD_CAS Access to Rank 0 : All Banks",
         "UMask": "0x10",
         "Unit": "iMC"
     },
@@ -537,7 +530,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK0",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK0.BANK0",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 0",
         "Unit": "iMC"
     },
     {
@@ -545,7 +538,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK1",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK0.BANK1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 1",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -554,7 +547,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK10",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK0.BANK10",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 10",
         "UMask": "0xa",
         "Unit": "iMC"
     },
@@ -563,7 +556,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK11",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK0.BANK11",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 11",
         "UMask": "0xb",
         "Unit": "iMC"
     },
@@ -572,7 +565,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK12",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK0.BANK12",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 12",
         "UMask": "0xc",
         "Unit": "iMC"
     },
@@ -581,7 +574,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK13",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK0.BANK13",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 13",
         "UMask": "0xd",
         "Unit": "iMC"
     },
@@ -590,7 +583,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK14",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK0.BANK14",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 14",
         "UMask": "0xe",
         "Unit": "iMC"
     },
@@ -599,7 +592,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK15",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK0.BANK15",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 15",
         "UMask": "0xf",
         "Unit": "iMC"
     },
@@ -608,7 +601,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK2",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK0.BANK2",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 2",
         "UMask": "0x2",
         "Unit": "iMC"
     },
@@ -617,7 +610,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK3",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK0.BANK3",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 3",
         "UMask": "0x3",
         "Unit": "iMC"
     },
@@ -626,7 +619,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK4",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK0.BANK4",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 4",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -635,7 +628,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK5",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK0.BANK5",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 5",
         "UMask": "0x5",
         "Unit": "iMC"
     },
@@ -644,7 +637,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK6",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK0.BANK6",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 6",
         "UMask": "0x6",
         "Unit": "iMC"
     },
@@ -653,7 +646,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK7",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK0.BANK7",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 7",
         "UMask": "0x7",
         "Unit": "iMC"
     },
@@ -662,7 +655,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK8",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK0.BANK8",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 8",
         "UMask": "0x8",
         "Unit": "iMC"
     },
@@ -671,7 +664,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK9",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK0.BANK9",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 9",
         "UMask": "0x9",
         "Unit": "iMC"
     },
@@ -680,7 +673,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANKG0",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK0.BANKG0",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 0 (Bank=
s 0-3)",
         "UMask": "0x11",
         "Unit": "iMC"
     },
@@ -689,7 +682,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANKG1",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK0.BANKG1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 1 (Bank=
s 4-7)",
         "UMask": "0x12",
         "Unit": "iMC"
     },
@@ -698,7 +691,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANKG2",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK0.BANKG2",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 2 (Bank=
s 8-11)",
         "UMask": "0x13",
         "Unit": "iMC"
     },
@@ -707,7 +700,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANKG3",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK0.BANKG3",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 3 (Bank=
s 12-15)",
         "UMask": "0x14",
         "Unit": "iMC"
     },
@@ -716,7 +709,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.ALLBANKS",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK1.ALLBANKS",
+        "PublicDescription": "RD_CAS Access to Rank 0 : All Banks",
         "UMask": "0x10",
         "Unit": "iMC"
     },
@@ -725,7 +718,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK0",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK1.BANK0",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 0",
         "Unit": "iMC"
     },
     {
@@ -733,7 +726,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK1",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK1.BANK1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 1",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -742,7 +735,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK10",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK1.BANK10",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 10",
         "UMask": "0xa",
         "Unit": "iMC"
     },
@@ -751,7 +744,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK11",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK1.BANK11",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 11",
         "UMask": "0xb",
         "Unit": "iMC"
     },
@@ -760,7 +753,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK12",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK1.BANK12",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 12",
         "UMask": "0xc",
         "Unit": "iMC"
     },
@@ -769,7 +762,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK13",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK1.BANK13",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 13",
         "UMask": "0xd",
         "Unit": "iMC"
     },
@@ -778,7 +771,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK14",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK1.BANK14",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 14",
         "UMask": "0xe",
         "Unit": "iMC"
     },
@@ -787,7 +780,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK15",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK1.BANK15",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 15",
         "UMask": "0xf",
         "Unit": "iMC"
     },
@@ -796,7 +789,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK2",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK1.BANK2",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 2",
         "UMask": "0x2",
         "Unit": "iMC"
     },
@@ -805,7 +798,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK3",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK1.BANK3",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 3",
         "UMask": "0x3",
         "Unit": "iMC"
     },
@@ -814,7 +807,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK4",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK1.BANK4",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 4",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -823,7 +816,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK5",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK1.BANK5",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 5",
         "UMask": "0x5",
         "Unit": "iMC"
     },
@@ -832,7 +825,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK6",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK1.BANK6",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 6",
         "UMask": "0x6",
         "Unit": "iMC"
     },
@@ -841,7 +834,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK7",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK1.BANK7",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 7",
         "UMask": "0x7",
         "Unit": "iMC"
     },
@@ -850,7 +843,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK8",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK1.BANK8",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 8",
         "UMask": "0x8",
         "Unit": "iMC"
     },
@@ -859,7 +852,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK9",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK1.BANK9",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 9",
         "UMask": "0x9",
         "Unit": "iMC"
     },
@@ -868,7 +861,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANKG0",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK1.BANKG0",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 0 (Bank=
s 0-3)",
         "UMask": "0x11",
         "Unit": "iMC"
     },
@@ -877,7 +870,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANKG1",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK1.BANKG1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 1 (Bank=
s 4-7)",
         "UMask": "0x12",
         "Unit": "iMC"
     },
@@ -886,7 +879,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANKG2",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK1.BANKG2",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 2 (Bank=
s 8-11)",
         "UMask": "0x13",
         "Unit": "iMC"
     },
@@ -895,7 +888,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANKG3",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK1.BANKG3",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 3 (Bank=
s 12-15)",
         "UMask": "0x14",
         "Unit": "iMC"
     },
@@ -904,7 +897,7 @@
         "EventCode": "0xB2",
         "EventName": "UNC_M_RD_CAS_RANK2.BANK0",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK2.BANK0",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 0",
         "Unit": "iMC"
     },
     {
@@ -912,7 +905,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.ALLBANKS",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK4.ALLBANKS",
+        "PublicDescription": "RD_CAS Access to Rank 0 : All Banks",
         "UMask": "0x10",
         "Unit": "iMC"
     },
@@ -921,7 +914,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK0",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK4.BANK0",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 0",
         "Unit": "iMC"
     },
     {
@@ -929,7 +922,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK1",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK4.BANK1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 1",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -938,7 +931,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK10",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK4.BANK10",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 10",
         "UMask": "0xa",
         "Unit": "iMC"
     },
@@ -947,7 +940,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK11",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK4.BANK11",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 11",
         "UMask": "0xb",
         "Unit": "iMC"
     },
@@ -956,7 +949,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK12",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK4.BANK12",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 12",
         "UMask": "0xc",
         "Unit": "iMC"
     },
@@ -965,7 +958,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK13",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK4.BANK13",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 13",
         "UMask": "0xd",
         "Unit": "iMC"
     },
@@ -974,7 +967,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK14",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK4.BANK14",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 14",
         "UMask": "0xe",
         "Unit": "iMC"
     },
@@ -983,7 +976,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK15",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK4.BANK15",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 15",
         "UMask": "0xf",
         "Unit": "iMC"
     },
@@ -992,7 +985,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK2",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK4.BANK2",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 2",
         "UMask": "0x2",
         "Unit": "iMC"
     },
@@ -1001,7 +994,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK3",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK4.BANK3",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 3",
         "UMask": "0x3",
         "Unit": "iMC"
     },
@@ -1010,7 +1003,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK4",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK4.BANK4",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 4",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -1019,7 +1012,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK5",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK4.BANK5",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 5",
         "UMask": "0x5",
         "Unit": "iMC"
     },
@@ -1028,7 +1021,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK6",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK4.BANK6",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 6",
         "UMask": "0x6",
         "Unit": "iMC"
     },
@@ -1037,7 +1030,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK7",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK4.BANK7",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 7",
         "UMask": "0x7",
         "Unit": "iMC"
     },
@@ -1046,7 +1039,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK8",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK4.BANK8",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 8",
         "UMask": "0x8",
         "Unit": "iMC"
     },
@@ -1055,7 +1048,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK9",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK4.BANK9",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 9",
         "UMask": "0x9",
         "Unit": "iMC"
     },
@@ -1064,7 +1057,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANKG0",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK4.BANKG0",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 0 (Bank=
s 0-3)",
         "UMask": "0x11",
         "Unit": "iMC"
     },
@@ -1073,7 +1066,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANKG1",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK4.BANKG1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 1 (Bank=
s 4-7)",
         "UMask": "0x12",
         "Unit": "iMC"
     },
@@ -1082,7 +1075,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANKG2",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK4.BANKG2",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 2 (Bank=
s 8-11)",
         "UMask": "0x13",
         "Unit": "iMC"
     },
@@ -1091,7 +1084,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANKG3",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK4.BANKG3",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 3 (Bank=
s 12-15)",
         "UMask": "0x14",
         "Unit": "iMC"
     },
@@ -1100,7 +1093,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.ALLBANKS",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK5.ALLBANKS",
+        "PublicDescription": "RD_CAS Access to Rank 0 : All Banks",
         "UMask": "0x10",
         "Unit": "iMC"
     },
@@ -1109,7 +1102,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK0",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK5.BANK0",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 0",
         "Unit": "iMC"
     },
     {
@@ -1117,7 +1110,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK1",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK5.BANK1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 1",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -1126,7 +1119,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK10",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK5.BANK10",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 10",
         "UMask": "0xa",
         "Unit": "iMC"
     },
@@ -1135,7 +1128,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK11",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK5.BANK11",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 11",
         "UMask": "0xb",
         "Unit": "iMC"
     },
@@ -1144,7 +1137,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK12",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK5.BANK12",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 12",
         "UMask": "0xc",
         "Unit": "iMC"
     },
@@ -1153,7 +1146,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK13",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK5.BANK13",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 13",
         "UMask": "0xd",
         "Unit": "iMC"
     },
@@ -1162,7 +1155,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK14",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK5.BANK14",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 14",
         "UMask": "0xe",
         "Unit": "iMC"
     },
@@ -1171,7 +1164,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK15",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK5.BANK15",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 15",
         "UMask": "0xf",
         "Unit": "iMC"
     },
@@ -1180,7 +1173,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK2",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK5.BANK2",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 2",
         "UMask": "0x2",
         "Unit": "iMC"
     },
@@ -1189,7 +1182,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK3",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK5.BANK3",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 3",
         "UMask": "0x3",
         "Unit": "iMC"
     },
@@ -1198,7 +1191,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK4",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK5.BANK4",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 4",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -1207,7 +1200,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK5",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK5.BANK5",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 5",
         "UMask": "0x5",
         "Unit": "iMC"
     },
@@ -1216,7 +1209,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK6",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK5.BANK6",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 6",
         "UMask": "0x6",
         "Unit": "iMC"
     },
@@ -1225,7 +1218,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK7",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK5.BANK7",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 7",
         "UMask": "0x7",
         "Unit": "iMC"
     },
@@ -1234,7 +1227,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK8",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK5.BANK8",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 8",
         "UMask": "0x8",
         "Unit": "iMC"
     },
@@ -1243,7 +1236,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK9",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK5.BANK9",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 9",
         "UMask": "0x9",
         "Unit": "iMC"
     },
@@ -1252,7 +1245,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANKG0",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK5.BANKG0",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 0 (Bank=
s 0-3)",
         "UMask": "0x11",
         "Unit": "iMC"
     },
@@ -1261,7 +1254,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANKG1",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK5.BANKG1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 1 (Bank=
s 4-7)",
         "UMask": "0x12",
         "Unit": "iMC"
     },
@@ -1270,7 +1263,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANKG2",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK5.BANKG2",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 2 (Bank=
s 8-11)",
         "UMask": "0x13",
         "Unit": "iMC"
     },
@@ -1279,7 +1272,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANKG3",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK5.BANKG3",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 3 (Bank=
s 12-15)",
         "UMask": "0x14",
         "Unit": "iMC"
     },
@@ -1288,7 +1281,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.ALLBANKS",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK6.ALLBANKS",
+        "PublicDescription": "RD_CAS Access to Rank 0 : All Banks",
         "UMask": "0x10",
         "Unit": "iMC"
     },
@@ -1297,7 +1290,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK0",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK6.BANK0",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 0",
         "Unit": "iMC"
     },
     {
@@ -1305,7 +1298,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK1",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK6.BANK1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 1",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -1314,7 +1307,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK10",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK6.BANK10",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 10",
         "UMask": "0xa",
         "Unit": "iMC"
     },
@@ -1323,7 +1316,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK11",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK6.BANK11",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 11",
         "UMask": "0xb",
         "Unit": "iMC"
     },
@@ -1332,7 +1325,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK12",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK6.BANK12",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 12",
         "UMask": "0xc",
         "Unit": "iMC"
     },
@@ -1341,7 +1334,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK13",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK6.BANK13",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 13",
         "UMask": "0xd",
         "Unit": "iMC"
     },
@@ -1350,7 +1343,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK14",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK6.BANK14",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 14",
         "UMask": "0xe",
         "Unit": "iMC"
     },
@@ -1359,7 +1352,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK15",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK6.BANK15",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 15",
         "UMask": "0xf",
         "Unit": "iMC"
     },
@@ -1368,7 +1361,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK2",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK6.BANK2",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 2",
         "UMask": "0x2",
         "Unit": "iMC"
     },
@@ -1377,7 +1370,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK3",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK6.BANK3",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 3",
         "UMask": "0x3",
         "Unit": "iMC"
     },
@@ -1386,7 +1379,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK4",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK6.BANK4",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 4",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -1395,7 +1388,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK5",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK6.BANK5",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 5",
         "UMask": "0x5",
         "Unit": "iMC"
     },
@@ -1404,7 +1397,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK6",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK6.BANK6",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 6",
         "UMask": "0x6",
         "Unit": "iMC"
     },
@@ -1413,7 +1406,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK7",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK6.BANK7",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 7",
         "UMask": "0x7",
         "Unit": "iMC"
     },
@@ -1422,7 +1415,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK8",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK6.BANK8",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 8",
         "UMask": "0x8",
         "Unit": "iMC"
     },
@@ -1431,7 +1424,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK9",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK6.BANK9",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 9",
         "UMask": "0x9",
         "Unit": "iMC"
     },
@@ -1440,7 +1433,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANKG0",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK6.BANKG0",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 0 (Bank=
s 0-3)",
         "UMask": "0x11",
         "Unit": "iMC"
     },
@@ -1449,7 +1442,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANKG1",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK6.BANKG1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 1 (Bank=
s 4-7)",
         "UMask": "0x12",
         "Unit": "iMC"
     },
@@ -1458,7 +1451,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANKG2",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK6.BANKG2",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 2 (Bank=
s 8-11)",
         "UMask": "0x13",
         "Unit": "iMC"
     },
@@ -1467,7 +1460,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANKG3",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK6.BANKG3",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 3 (Bank=
s 12-15)",
         "UMask": "0x14",
         "Unit": "iMC"
     },
@@ -1476,7 +1469,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.ALLBANKS",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK7.ALLBANKS",
+        "PublicDescription": "RD_CAS Access to Rank 0 : All Banks",
         "UMask": "0x10",
         "Unit": "iMC"
     },
@@ -1485,7 +1478,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK0",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK7.BANK0",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 0",
         "Unit": "iMC"
     },
     {
@@ -1493,7 +1486,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK1",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK7.BANK1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 1",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -1502,7 +1495,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK10",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK7.BANK10",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 10",
         "UMask": "0xa",
         "Unit": "iMC"
     },
@@ -1511,7 +1504,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK11",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK7.BANK11",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 11",
         "UMask": "0xb",
         "Unit": "iMC"
     },
@@ -1520,7 +1513,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK12",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK7.BANK12",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 12",
         "UMask": "0xc",
         "Unit": "iMC"
     },
@@ -1529,7 +1522,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK13",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK7.BANK13",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 13",
         "UMask": "0xd",
         "Unit": "iMC"
     },
@@ -1538,7 +1531,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK14",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK7.BANK14",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 14",
         "UMask": "0xe",
         "Unit": "iMC"
     },
@@ -1547,7 +1540,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK15",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK7.BANK15",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 15",
         "UMask": "0xf",
         "Unit": "iMC"
     },
@@ -1556,7 +1549,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK2",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK7.BANK2",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 2",
         "UMask": "0x2",
         "Unit": "iMC"
     },
@@ -1565,7 +1558,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK3",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK7.BANK3",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 3",
         "UMask": "0x3",
         "Unit": "iMC"
     },
@@ -1574,7 +1567,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK4",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK7.BANK4",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 4",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -1583,7 +1576,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK5",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK7.BANK5",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 5",
         "UMask": "0x5",
         "Unit": "iMC"
     },
@@ -1592,7 +1585,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK6",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK7.BANK6",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 6",
         "UMask": "0x6",
         "Unit": "iMC"
     },
@@ -1601,7 +1594,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK7",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK7.BANK7",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 7",
         "UMask": "0x7",
         "Unit": "iMC"
     },
@@ -1610,7 +1603,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK8",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK7.BANK8",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 8",
         "UMask": "0x8",
         "Unit": "iMC"
     },
@@ -1619,7 +1612,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK9",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK7.BANK9",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 9",
         "UMask": "0x9",
         "Unit": "iMC"
     },
@@ -1628,7 +1621,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANKG0",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK7.BANKG0",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 0 (Bank=
s 0-3)",
         "UMask": "0x11",
         "Unit": "iMC"
     },
@@ -1637,7 +1630,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANKG1",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK7.BANKG1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 1 (Bank=
s 4-7)",
         "UMask": "0x12",
         "Unit": "iMC"
     },
@@ -1646,7 +1639,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANKG2",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK7.BANKG2",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 2 (Bank=
s 8-11)",
         "UMask": "0x13",
         "Unit": "iMC"
     },
@@ -1655,7 +1648,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANKG3",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_RD_CAS_RANK7.BANKG3",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 3 (Bank=
s 12-15)",
         "UMask": "0x14",
         "Unit": "iMC"
     },
@@ -1680,7 +1673,6 @@
         "EventCode": "0x91",
         "EventName": "UNC_M_VMSE_MXB_WR_OCCUPANCY",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_VMSE_MXB_WR_OCCUPANCY",
         "Unit": "iMC"
     },
     {
@@ -1688,7 +1680,6 @@
         "EventCode": "0x90",
         "EventName": "UNC_M_VMSE_WR_PUSH.RMM",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_VMSE_WR_PUSH.RMM",
         "UMask": "0x2",
         "Unit": "iMC"
     },
@@ -1697,7 +1688,6 @@
         "EventCode": "0x90",
         "EventName": "UNC_M_VMSE_WR_PUSH.WMM",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_VMSE_WR_PUSH.WMM",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -1706,7 +1696,6 @@
         "EventCode": "0xC0",
         "EventName": "UNC_M_WMM_TO_RMM.LOW_THRESH",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WMM_TO_RMM.LOW_THRESH",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -1715,7 +1704,6 @@
         "EventCode": "0xC0",
         "EventName": "UNC_M_WMM_TO_RMM.STARVE",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WMM_TO_RMM.STARVE",
         "UMask": "0x2",
         "Unit": "iMC"
     },
@@ -1724,7 +1712,6 @@
         "EventCode": "0xC0",
         "EventName": "UNC_M_WMM_TO_RMM.VMSE_RETRY",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WMM_TO_RMM.VMSE_RETRY",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -1765,7 +1752,6 @@
         "EventCode": "0xC1",
         "EventName": "UNC_M_WRONG_MM",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WRONG_MM",
         "Unit": "iMC"
     },
     {
@@ -1773,7 +1759,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.ALLBANKS",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK0.ALLBANKS",
+        "PublicDescription": "WR_CAS Access to Rank 0 : All Banks",
         "UMask": "0x10",
         "Unit": "iMC"
     },
@@ -1782,7 +1768,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK0",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK0.BANK0",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 0",
         "Unit": "iMC"
     },
     {
@@ -1790,7 +1776,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK1",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK0.BANK1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 1",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -1799,7 +1785,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK10",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK0.BANK10",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 10",
         "UMask": "0xa",
         "Unit": "iMC"
     },
@@ -1808,7 +1794,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK11",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK0.BANK11",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 11",
         "UMask": "0xb",
         "Unit": "iMC"
     },
@@ -1817,7 +1803,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK12",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK0.BANK12",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 12",
         "UMask": "0xc",
         "Unit": "iMC"
     },
@@ -1826,7 +1812,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK13",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK0.BANK13",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 13",
         "UMask": "0xd",
         "Unit": "iMC"
     },
@@ -1835,7 +1821,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK14",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK0.BANK14",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 14",
         "UMask": "0xe",
         "Unit": "iMC"
     },
@@ -1844,7 +1830,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK15",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK0.BANK15",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 15",
         "UMask": "0xf",
         "Unit": "iMC"
     },
@@ -1853,7 +1839,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK2",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK0.BANK2",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 2",
         "UMask": "0x2",
         "Unit": "iMC"
     },
@@ -1862,7 +1848,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK3",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK0.BANK3",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 3",
         "UMask": "0x3",
         "Unit": "iMC"
     },
@@ -1871,7 +1857,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK4",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK0.BANK4",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 4",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -1880,7 +1866,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK5",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK0.BANK5",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 5",
         "UMask": "0x5",
         "Unit": "iMC"
     },
@@ -1889,7 +1875,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK6",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK0.BANK6",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 6",
         "UMask": "0x6",
         "Unit": "iMC"
     },
@@ -1898,7 +1884,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK7",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK0.BANK7",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 7",
         "UMask": "0x7",
         "Unit": "iMC"
     },
@@ -1907,7 +1893,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK8",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK0.BANK8",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 8",
         "UMask": "0x8",
         "Unit": "iMC"
     },
@@ -1916,7 +1902,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK9",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK0.BANK9",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 9",
         "UMask": "0x9",
         "Unit": "iMC"
     },
@@ -1925,7 +1911,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANKG0",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK0.BANKG0",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 0 (Bank=
s 0-3)",
         "UMask": "0x11",
         "Unit": "iMC"
     },
@@ -1934,7 +1920,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANKG1",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK0.BANKG1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 1 (Bank=
s 4-7)",
         "UMask": "0x12",
         "Unit": "iMC"
     },
@@ -1943,7 +1929,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANKG2",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK0.BANKG2",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 2 (Bank=
s 8-11)",
         "UMask": "0x13",
         "Unit": "iMC"
     },
@@ -1952,7 +1938,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANKG3",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK0.BANKG3",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 3 (Bank=
s 12-15)",
         "UMask": "0x14",
         "Unit": "iMC"
     },
@@ -1961,7 +1947,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.ALLBANKS",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK1.ALLBANKS",
+        "PublicDescription": "WR_CAS Access to Rank 0 : All Banks",
         "UMask": "0x10",
         "Unit": "iMC"
     },
@@ -1970,7 +1956,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK0",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK1.BANK0",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 0",
         "Unit": "iMC"
     },
     {
@@ -1978,7 +1964,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK1",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK1.BANK1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 1",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -1987,7 +1973,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK10",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK1.BANK10",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 10",
         "UMask": "0xa",
         "Unit": "iMC"
     },
@@ -1996,7 +1982,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK11",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK1.BANK11",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 11",
         "UMask": "0xb",
         "Unit": "iMC"
     },
@@ -2005,7 +1991,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK12",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK1.BANK12",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 12",
         "UMask": "0xc",
         "Unit": "iMC"
     },
@@ -2014,7 +2000,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK13",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK1.BANK13",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 13",
         "UMask": "0xd",
         "Unit": "iMC"
     },
@@ -2023,7 +2009,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK14",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK1.BANK14",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 14",
         "UMask": "0xe",
         "Unit": "iMC"
     },
@@ -2032,7 +2018,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK15",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK1.BANK15",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 15",
         "UMask": "0xf",
         "Unit": "iMC"
     },
@@ -2041,7 +2027,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK2",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK1.BANK2",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 2",
         "UMask": "0x2",
         "Unit": "iMC"
     },
@@ -2050,7 +2036,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK3",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK1.BANK3",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 3",
         "UMask": "0x3",
         "Unit": "iMC"
     },
@@ -2059,7 +2045,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK4",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK1.BANK4",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 4",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -2068,7 +2054,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK5",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK1.BANK5",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 5",
         "UMask": "0x5",
         "Unit": "iMC"
     },
@@ -2077,7 +2063,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK6",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK1.BANK6",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 6",
         "UMask": "0x6",
         "Unit": "iMC"
     },
@@ -2086,7 +2072,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK7",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK1.BANK7",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 7",
         "UMask": "0x7",
         "Unit": "iMC"
     },
@@ -2095,7 +2081,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK8",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK1.BANK8",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 8",
         "UMask": "0x8",
         "Unit": "iMC"
     },
@@ -2104,7 +2090,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK9",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK1.BANK9",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 9",
         "UMask": "0x9",
         "Unit": "iMC"
     },
@@ -2113,7 +2099,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANKG0",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK1.BANKG0",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 0 (Bank=
s 0-3)",
         "UMask": "0x11",
         "Unit": "iMC"
     },
@@ -2122,7 +2108,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANKG1",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK1.BANKG1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 1 (Bank=
s 4-7)",
         "UMask": "0x12",
         "Unit": "iMC"
     },
@@ -2131,7 +2117,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANKG2",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK1.BANKG2",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 2 (Bank=
s 8-11)",
         "UMask": "0x13",
         "Unit": "iMC"
     },
@@ -2140,7 +2126,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANKG3",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK1.BANKG3",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 3 (Bank=
s 12-15)",
         "UMask": "0x14",
         "Unit": "iMC"
     },
@@ -2149,7 +2135,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.ALLBANKS",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK4.ALLBANKS",
+        "PublicDescription": "WR_CAS Access to Rank 0 : All Banks",
         "UMask": "0x10",
         "Unit": "iMC"
     },
@@ -2158,7 +2144,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK0",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK4.BANK0",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 0",
         "Unit": "iMC"
     },
     {
@@ -2166,7 +2152,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK1",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK4.BANK1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 1",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -2175,7 +2161,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK10",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK4.BANK10",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 10",
         "UMask": "0xa",
         "Unit": "iMC"
     },
@@ -2184,7 +2170,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK11",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK4.BANK11",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 11",
         "UMask": "0xb",
         "Unit": "iMC"
     },
@@ -2193,7 +2179,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK12",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK4.BANK12",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 12",
         "UMask": "0xc",
         "Unit": "iMC"
     },
@@ -2202,7 +2188,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK13",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK4.BANK13",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 13",
         "UMask": "0xd",
         "Unit": "iMC"
     },
@@ -2211,7 +2197,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK14",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK4.BANK14",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 14",
         "UMask": "0xe",
         "Unit": "iMC"
     },
@@ -2220,7 +2206,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK15",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK4.BANK15",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 15",
         "UMask": "0xf",
         "Unit": "iMC"
     },
@@ -2229,7 +2215,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK2",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK4.BANK2",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 2",
         "UMask": "0x2",
         "Unit": "iMC"
     },
@@ -2238,7 +2224,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK3",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK4.BANK3",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 3",
         "UMask": "0x3",
         "Unit": "iMC"
     },
@@ -2247,7 +2233,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK4",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK4.BANK4",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 4",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -2256,7 +2242,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK5",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK4.BANK5",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 5",
         "UMask": "0x5",
         "Unit": "iMC"
     },
@@ -2265,7 +2251,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK6",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK4.BANK6",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 6",
         "UMask": "0x6",
         "Unit": "iMC"
     },
@@ -2274,7 +2260,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK7",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK4.BANK7",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 7",
         "UMask": "0x7",
         "Unit": "iMC"
     },
@@ -2283,7 +2269,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK8",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK4.BANK8",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 8",
         "UMask": "0x8",
         "Unit": "iMC"
     },
@@ -2292,7 +2278,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK9",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK4.BANK9",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 9",
         "UMask": "0x9",
         "Unit": "iMC"
     },
@@ -2301,7 +2287,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANKG0",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK4.BANKG0",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 0 (Bank=
s 0-3)",
         "UMask": "0x11",
         "Unit": "iMC"
     },
@@ -2310,7 +2296,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANKG1",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK4.BANKG1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 1 (Bank=
s 4-7)",
         "UMask": "0x12",
         "Unit": "iMC"
     },
@@ -2319,7 +2305,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANKG2",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK4.BANKG2",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 2 (Bank=
s 8-11)",
         "UMask": "0x13",
         "Unit": "iMC"
     },
@@ -2328,7 +2314,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANKG3",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK4.BANKG3",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 3 (Bank=
s 12-15)",
         "UMask": "0x14",
         "Unit": "iMC"
     },
@@ -2337,7 +2323,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.ALLBANKS",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK5.ALLBANKS",
+        "PublicDescription": "WR_CAS Access to Rank 0 : All Banks",
         "UMask": "0x10",
         "Unit": "iMC"
     },
@@ -2346,7 +2332,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK0",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK5.BANK0",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 0",
         "Unit": "iMC"
     },
     {
@@ -2354,7 +2340,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK1",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK5.BANK1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 1",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -2363,7 +2349,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK10",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK5.BANK10",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 10",
         "UMask": "0xa",
         "Unit": "iMC"
     },
@@ -2372,7 +2358,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK11",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK5.BANK11",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 11",
         "UMask": "0xb",
         "Unit": "iMC"
     },
@@ -2381,7 +2367,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK12",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK5.BANK12",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 12",
         "UMask": "0xc",
         "Unit": "iMC"
     },
@@ -2390,7 +2376,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK13",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK5.BANK13",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 13",
         "UMask": "0xd",
         "Unit": "iMC"
     },
@@ -2399,7 +2385,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK14",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK5.BANK14",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 14",
         "UMask": "0xe",
         "Unit": "iMC"
     },
@@ -2408,7 +2394,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK15",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK5.BANK15",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 15",
         "UMask": "0xf",
         "Unit": "iMC"
     },
@@ -2417,7 +2403,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK2",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK5.BANK2",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 2",
         "UMask": "0x2",
         "Unit": "iMC"
     },
@@ -2426,7 +2412,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK3",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK5.BANK3",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 3",
         "UMask": "0x3",
         "Unit": "iMC"
     },
@@ -2435,7 +2421,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK4",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK5.BANK4",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 4",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -2444,7 +2430,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK5",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK5.BANK5",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 5",
         "UMask": "0x5",
         "Unit": "iMC"
     },
@@ -2453,7 +2439,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK6",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK5.BANK6",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 6",
         "UMask": "0x6",
         "Unit": "iMC"
     },
@@ -2462,7 +2448,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK7",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK5.BANK7",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 7",
         "UMask": "0x7",
         "Unit": "iMC"
     },
@@ -2471,7 +2457,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK8",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK5.BANK8",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 8",
         "UMask": "0x8",
         "Unit": "iMC"
     },
@@ -2480,7 +2466,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK9",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK5.BANK9",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 9",
         "UMask": "0x9",
         "Unit": "iMC"
     },
@@ -2489,7 +2475,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANKG0",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK5.BANKG0",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 0 (Bank=
s 0-3)",
         "UMask": "0x11",
         "Unit": "iMC"
     },
@@ -2498,7 +2484,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANKG1",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK5.BANKG1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 1 (Bank=
s 4-7)",
         "UMask": "0x12",
         "Unit": "iMC"
     },
@@ -2507,7 +2493,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANKG2",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK5.BANKG2",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 2 (Bank=
s 8-11)",
         "UMask": "0x13",
         "Unit": "iMC"
     },
@@ -2516,7 +2502,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANKG3",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK5.BANKG3",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 3 (Bank=
s 12-15)",
         "UMask": "0x14",
         "Unit": "iMC"
     },
@@ -2525,7 +2511,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.ALLBANKS",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK6.ALLBANKS",
+        "PublicDescription": "WR_CAS Access to Rank 0 : All Banks",
         "UMask": "0x10",
         "Unit": "iMC"
     },
@@ -2534,7 +2520,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK0",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK6.BANK0",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 0",
         "Unit": "iMC"
     },
     {
@@ -2542,7 +2528,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK1",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK6.BANK1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 1",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -2551,7 +2537,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK10",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK6.BANK10",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 10",
         "UMask": "0xa",
         "Unit": "iMC"
     },
@@ -2560,7 +2546,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK11",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK6.BANK11",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 11",
         "UMask": "0xb",
         "Unit": "iMC"
     },
@@ -2569,7 +2555,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK12",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK6.BANK12",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 12",
         "UMask": "0xc",
         "Unit": "iMC"
     },
@@ -2578,7 +2564,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK13",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK6.BANK13",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 13",
         "UMask": "0xd",
         "Unit": "iMC"
     },
@@ -2587,7 +2573,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK14",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK6.BANK14",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 14",
         "UMask": "0xe",
         "Unit": "iMC"
     },
@@ -2596,7 +2582,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK15",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK6.BANK15",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 15",
         "UMask": "0xf",
         "Unit": "iMC"
     },
@@ -2605,7 +2591,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK2",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK6.BANK2",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 2",
         "UMask": "0x2",
         "Unit": "iMC"
     },
@@ -2614,7 +2600,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK3",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK6.BANK3",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 3",
         "UMask": "0x3",
         "Unit": "iMC"
     },
@@ -2623,7 +2609,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK4",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK6.BANK4",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 4",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -2632,7 +2618,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK5",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK6.BANK5",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 5",
         "UMask": "0x5",
         "Unit": "iMC"
     },
@@ -2641,7 +2627,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK6",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK6.BANK6",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 6",
         "UMask": "0x6",
         "Unit": "iMC"
     },
@@ -2650,7 +2636,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK7",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK6.BANK7",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 7",
         "UMask": "0x7",
         "Unit": "iMC"
     },
@@ -2659,7 +2645,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK8",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK6.BANK8",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 8",
         "UMask": "0x8",
         "Unit": "iMC"
     },
@@ -2668,7 +2654,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK9",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK6.BANK9",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 9",
         "UMask": "0x9",
         "Unit": "iMC"
     },
@@ -2677,7 +2663,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANKG0",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK6.BANKG0",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 0 (Bank=
s 0-3)",
         "UMask": "0x11",
         "Unit": "iMC"
     },
@@ -2686,7 +2672,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANKG1",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK6.BANKG1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 1 (Bank=
s 4-7)",
         "UMask": "0x12",
         "Unit": "iMC"
     },
@@ -2695,7 +2681,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANKG2",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK6.BANKG2",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 2 (Bank=
s 8-11)",
         "UMask": "0x13",
         "Unit": "iMC"
     },
@@ -2704,7 +2690,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANKG3",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK6.BANKG3",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 3 (Bank=
s 12-15)",
         "UMask": "0x14",
         "Unit": "iMC"
     },
@@ -2713,7 +2699,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.ALLBANKS",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK7.ALLBANKS",
+        "PublicDescription": "WR_CAS Access to Rank 0 : All Banks",
         "UMask": "0x10",
         "Unit": "iMC"
     },
@@ -2722,7 +2708,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK0",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK7.BANK0",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 0",
         "Unit": "iMC"
     },
     {
@@ -2730,7 +2716,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK1",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK7.BANK1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 1",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -2739,7 +2725,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK10",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK7.BANK10",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 10",
         "UMask": "0xa",
         "Unit": "iMC"
     },
@@ -2748,7 +2734,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK11",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK7.BANK11",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 11",
         "UMask": "0xb",
         "Unit": "iMC"
     },
@@ -2757,7 +2743,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK12",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK7.BANK12",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 12",
         "UMask": "0xc",
         "Unit": "iMC"
     },
@@ -2766,7 +2752,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK13",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK7.BANK13",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 13",
         "UMask": "0xd",
         "Unit": "iMC"
     },
@@ -2775,7 +2761,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK14",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK7.BANK14",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 14",
         "UMask": "0xe",
         "Unit": "iMC"
     },
@@ -2784,7 +2770,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK15",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK7.BANK15",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 15",
         "UMask": "0xf",
         "Unit": "iMC"
     },
@@ -2793,7 +2779,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK2",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK7.BANK2",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 2",
         "UMask": "0x2",
         "Unit": "iMC"
     },
@@ -2802,7 +2788,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK3",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK7.BANK3",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 3",
         "UMask": "0x3",
         "Unit": "iMC"
     },
@@ -2811,7 +2797,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK4",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK7.BANK4",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 4",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -2820,7 +2806,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK5",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK7.BANK5",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 5",
         "UMask": "0x5",
         "Unit": "iMC"
     },
@@ -2829,7 +2815,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK6",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK7.BANK6",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 6",
         "UMask": "0x6",
         "Unit": "iMC"
     },
@@ -2838,7 +2824,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK7",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK7.BANK7",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 7",
         "UMask": "0x7",
         "Unit": "iMC"
     },
@@ -2847,7 +2833,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK8",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK7.BANK8",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 8",
         "UMask": "0x8",
         "Unit": "iMC"
     },
@@ -2856,7 +2842,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK9",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK7.BANK9",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 9",
         "UMask": "0x9",
         "Unit": "iMC"
     },
@@ -2865,7 +2851,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANKG0",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK7.BANKG0",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 0 (Bank=
s 0-3)",
         "UMask": "0x11",
         "Unit": "iMC"
     },
@@ -2874,7 +2860,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANKG1",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK7.BANKG1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 1 (Bank=
s 4-7)",
         "UMask": "0x12",
         "Unit": "iMC"
     },
@@ -2883,7 +2869,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANKG2",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK7.BANKG2",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 2 (Bank=
s 8-11)",
         "UMask": "0x13",
         "Unit": "iMC"
     },
@@ -2892,7 +2878,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANKG3",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_WR_CAS_RANK7.BANKG3",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 3 (Bank=
s 12-15)",
         "UMask": "0x14",
         "Unit": "iMC"
     }
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-other.json b/=
tools/perf/pmu-events/arch/x86/broadwellx/uncore-other.json
index a80d931dc3d5..43def2582617 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-other.json
@@ -101,7 +101,7 @@
         "EventCode": "0x14",
         "EventName": "UNC_I_MISC0.2ND_ATOMIC_INSERT",
         "PerPkg": "1",
-        "PublicDescription": "UNC_I_MISC0.2ND_ATOMIC_INSERT",
+        "PublicDescription": "Counts Timeouts - Set 0 : Cache Inserts of A=
tomic Transactions as Secondary",
         "UMask": "0x10",
         "Unit": "IRP"
     },
@@ -110,7 +110,7 @@
         "EventCode": "0x14",
         "EventName": "UNC_I_MISC0.2ND_RD_INSERT",
         "PerPkg": "1",
-        "PublicDescription": "UNC_I_MISC0.2ND_RD_INSERT",
+        "PublicDescription": "Counts Timeouts - Set 0 : Cache Inserts of R=
ead Transactions as Secondary",
         "UMask": "0x4",
         "Unit": "IRP"
     },
@@ -119,7 +119,7 @@
         "EventCode": "0x14",
         "EventName": "UNC_I_MISC0.2ND_WR_INSERT",
         "PerPkg": "1",
-        "PublicDescription": "UNC_I_MISC0.2ND_WR_INSERT",
+        "PublicDescription": "Counts Timeouts - Set 0 : Cache Inserts of W=
rite Transactions as Secondary",
         "UMask": "0x8",
         "Unit": "IRP"
     },
@@ -128,7 +128,7 @@
         "EventCode": "0x14",
         "EventName": "UNC_I_MISC0.FAST_REJ",
         "PerPkg": "1",
-        "PublicDescription": "UNC_I_MISC0.FAST_REJ",
+        "PublicDescription": "Counts Timeouts - Set 0 : Fastpath Rejects",
         "UMask": "0x2",
         "Unit": "IRP"
     },
@@ -137,7 +137,7 @@
         "EventCode": "0x14",
         "EventName": "UNC_I_MISC0.FAST_REQ",
         "PerPkg": "1",
-        "PublicDescription": "UNC_I_MISC0.FAST_REQ",
+        "PublicDescription": "Counts Timeouts - Set 0 : Fastpath Requests"=
,
         "UMask": "0x1",
         "Unit": "IRP"
     },
@@ -146,7 +146,7 @@
         "EventCode": "0x14",
         "EventName": "UNC_I_MISC0.FAST_XFER",
         "PerPkg": "1",
-        "PublicDescription": "UNC_I_MISC0.FAST_XFER",
+        "PublicDescription": "Counts Timeouts - Set 0 : Fastpath Transfers=
 From Primary to Secondary",
         "UMask": "0x20",
         "Unit": "IRP"
     },
@@ -155,7 +155,7 @@
         "EventCode": "0x14",
         "EventName": "UNC_I_MISC0.PF_ACK_HINT",
         "PerPkg": "1",
-        "PublicDescription": "UNC_I_MISC0.PF_ACK_HINT",
+        "PublicDescription": "Counts Timeouts - Set 0 : Prefetch Ack Hints=
 From Primary to Secondary",
         "UMask": "0x40",
         "Unit": "IRP"
     },
@@ -182,7 +182,7 @@
         "EventCode": "0x15",
         "EventName": "UNC_I_MISC1.LOST_FWD",
         "PerPkg": "1",
-        "PublicDescription": "UNC_I_MISC1.LOST_FWD",
+        "PublicDescription": "Misc Events - Set 1 : Lost Forward : Snoop p=
ulled away ownership before a write was committed",
         "UMask": "0x10",
         "Unit": "IRP"
     },
@@ -325,7 +325,7 @@
         "EventCode": "0x17",
         "EventName": "UNC_I_SNOOP_RESP.HIT_ES",
         "PerPkg": "1",
-        "PublicDescription": "UNC_I_SNOOP_RESP.HIT_ES",
+        "PublicDescription": "Snoop Responses : Hit E or S",
         "UMask": "0x4",
         "Unit": "IRP"
     },
@@ -334,7 +334,7 @@
         "EventCode": "0x17",
         "EventName": "UNC_I_SNOOP_RESP.HIT_I",
         "PerPkg": "1",
-        "PublicDescription": "UNC_I_SNOOP_RESP.HIT_I",
+        "PublicDescription": "Snoop Responses : Hit I",
         "UMask": "0x2",
         "Unit": "IRP"
     },
@@ -343,7 +343,7 @@
         "EventCode": "0x17",
         "EventName": "UNC_I_SNOOP_RESP.HIT_M",
         "PerPkg": "1",
-        "PublicDescription": "UNC_I_SNOOP_RESP.HIT_M",
+        "PublicDescription": "Snoop Responses : Hit M",
         "UMask": "0x8",
         "Unit": "IRP"
     },
@@ -352,7 +352,7 @@
         "EventCode": "0x17",
         "EventName": "UNC_I_SNOOP_RESP.MISS",
         "PerPkg": "1",
-        "PublicDescription": "UNC_I_SNOOP_RESP.MISS",
+        "PublicDescription": "Snoop Responses : Miss",
         "UMask": "0x1",
         "Unit": "IRP"
     },
@@ -361,7 +361,7 @@
         "EventCode": "0x17",
         "EventName": "UNC_I_SNOOP_RESP.SNPCODE",
         "PerPkg": "1",
-        "PublicDescription": "UNC_I_SNOOP_RESP.SNPCODE",
+        "PublicDescription": "Snoop Responses : SnpCode",
         "UMask": "0x10",
         "Unit": "IRP"
     },
@@ -370,7 +370,7 @@
         "EventCode": "0x17",
         "EventName": "UNC_I_SNOOP_RESP.SNPDATA",
         "PerPkg": "1",
-        "PublicDescription": "UNC_I_SNOOP_RESP.SNPDATA",
+        "PublicDescription": "Snoop Responses : SnpData",
         "UMask": "0x20",
         "Unit": "IRP"
     },
@@ -379,7 +379,7 @@
         "EventCode": "0x17",
         "EventName": "UNC_I_SNOOP_RESP.SNPINV",
         "PerPkg": "1",
-        "PublicDescription": "UNC_I_SNOOP_RESP.SNPINV",
+        "PublicDescription": "Snoop Responses : SnpInv",
         "UMask": "0x40",
         "Unit": "IRP"
     },
@@ -474,7 +474,7 @@
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
@@ -1223,7 +1223,6 @@
         "EventCode": "0xB",
         "EventName": "UNC_R3_IOT_BACKPRESSURE.HUB",
         "PerPkg": "1",
-        "PublicDescription": "UNC_R3_IOT_BACKPRESSURE.HUB",
         "UMask": "0x2",
         "Unit": "R3QPI"
     },
@@ -1232,7 +1231,6 @@
         "EventCode": "0xB",
         "EventName": "UNC_R3_IOT_BACKPRESSURE.SAT",
         "PerPkg": "1",
-        "PublicDescription": "UNC_R3_IOT_BACKPRESSURE.SAT",
         "UMask": "0x1",
         "Unit": "R3QPI"
     },
@@ -2312,7 +2310,7 @@
         "EventCode": "0x33",
         "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED.AD",
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
e class using an qfclk event.; Filter for the Home (HOM) message class.  HO=
M is generally used to send requests, request responses, and snoop response=
s.",
+        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credits from the VN0 pool.  =
Note that a single packet may require multiple flit buffers (i.e. when data=
 is being transferred).  Therefore, this event will increment by the number=
 of credits acquired in each cycle.  Filtering based on message class is no=
t provided.  One can count the number of packets transferred in a given mes=
sage class using an qfclk event.; Filter for the Home (HOM) message class. =
 HOM is generally used to send requests, request responses, and snoop respo=
nses.",
         "UMask": "0x1",
         "Unit": "R3QPI"
     },
@@ -2321,7 +2319,7 @@
         "EventCode": "0x33",
         "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED.BL",
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
e class using an qfclk event.; Filter for the Home (HOM) message class.  HO=
M is generally used to send requests, request responses, and snoop response=
s.",
+        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credits from the VN0 pool.  =
Note that a single packet may require multiple flit buffers (i.e. when data=
 is being transferred).  Therefore, this event will increment by the number=
 of credits acquired in each cycle.  Filtering based on message class is no=
t provided.  One can count the number of packets transferred in a given mes=
sage class using an qfclk event.; Filter for the Home (HOM) message class. =
 HOM is generally used to send requests, request responses, and snoop respo=
nses.",
         "UMask": "0x4",
         "Unit": "R3QPI"
     },
@@ -2384,14 +2382,12 @@
         "EventCode": "0xA",
         "EventName": "UNC_S_BOUNCE_CONTROL",
         "PerPkg": "1",
-        "PublicDescription": "UNC_S_BOUNCE_CONTROL",
         "Unit": "SBO"
     },
     {
         "BriefDescription": "Uncore Clocks",
         "EventName": "UNC_S_CLOCKTICKS",
         "PerPkg": "1",
-        "PublicDescription": "UNC_S_CLOCKTICKS",
         "Unit": "SBO"
     },
     {
@@ -2596,7 +2592,6 @@
         "EventCode": "0x5",
         "EventName": "UNC_S_RING_BOUNCES.AD_CACHE",
         "PerPkg": "1",
-        "PublicDescription": "UNC_S_RING_BOUNCES.AD_CACHE",
         "UMask": "0x1",
         "Unit": "SBO"
     },
@@ -2605,7 +2600,6 @@
         "EventCode": "0x5",
         "EventName": "UNC_S_RING_BOUNCES.AK_CORE",
         "PerPkg": "1",
-        "PublicDescription": "UNC_S_RING_BOUNCES.AK_CORE",
         "UMask": "0x2",
         "Unit": "SBO"
     },
@@ -2614,7 +2608,6 @@
         "EventCode": "0x5",
         "EventName": "UNC_S_RING_BOUNCES.BL_CORE",
         "PerPkg": "1",
-        "PublicDescription": "UNC_S_RING_BOUNCES.BL_CORE",
         "UMask": "0x4",
         "Unit": "SBO"
     },
@@ -2623,7 +2616,6 @@
         "EventCode": "0x5",
         "EventName": "UNC_S_RING_BOUNCES.IV_CORE",
         "PerPkg": "1",
-        "PublicDescription": "UNC_S_RING_BOUNCES.IV_CORE",
         "UMask": "0x8",
         "Unit": "SBO"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json b/=
tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
index e682eedf644a..83d20130c217 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
@@ -395,7 +395,7 @@
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
         "PerPkg": "1",
-        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with threshholding to gene=
rate histograms, or with other PCU events and occupancy triggering to captu=
re other details.",
+        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with thresholding to gener=
ate histograms, or with other PCU events and occupancy triggering to captur=
e other details.",
         "Unit": "PCU"
     },
     {
@@ -403,7 +403,7 @@
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
         "PerPkg": "1",
-        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with threshholding to gene=
rate histograms, or with other PCU events and occupancy triggering to captu=
re other details.",
+        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with thresholding to gener=
ate histograms, or with other PCU events and occupancy triggering to captur=
e other details.",
         "Unit": "PCU"
     },
     {
@@ -411,7 +411,7 @@
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
         "PerPkg": "1",
-        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with threshholding to gene=
rate histograms, or with other PCU events and occupancy triggering to captu=
re other details.",
+        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with thresholding to gener=
ate histograms, or with other PCU events and occupancy triggering to captur=
e other details.",
         "Unit": "PCU"
     },
     {
@@ -427,7 +427,7 @@
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
@@ -451,7 +451,7 @@
         "EventCode": "0x42",
         "EventName": "UNC_P_VR_HOT_CYCLES",
         "PerPkg": "1",
-        "PublicDescription": "UNC_P_VR_HOT_CYCLES",
+        "PublicDescription": "VR Hot : Number of cycles that a CPU SVID VR=
 is hot.  Does not cover DRAM VRs",
         "Unit": "PCU"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 4fa827c7f719..dfed265c95ab 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -4,7 +4,7 @@ GenuineIntel-6-BE,v1.19,alderlaken,core
 GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
 GenuineIntel-6-(3D|47),v27,broadwell,core
 GenuineIntel-6-56,v9,broadwellde,core
-GenuineIntel-6-4F,v19,broadwellx,core
+GenuineIntel-6-4F,v20,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.17,cascadelakex,core
 GenuineIntel-6-9[6C],v1.03,elkhartlake,core
 GenuineIntel-6-5[CF],v13,goldmont,core
--=20
2.40.0.348.gf938b09366-goog

