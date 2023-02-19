Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326CD69BF86
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjBSJcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBSJby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:31:54 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B72CDF0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:31:16 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k2-20020a056902070200b007eba3f8e3baso279243ybt.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiAycDrybveoMuJFEB+r5dLTNOyKRMMZ7bT1bkVL/x4=;
        b=mAGNMChIxmCLNL67y+hstMcY9oXuPTwb2KsmXQc1lkpPbxb+zHBfH+Visl9kjNSuSh
         wX1Z7ZX062igns/0RVUrhLbGGAog8e6kKBKbUTxV/xW3AfTK0T93XWMO/RfNP6DqI2oe
         vyrPpPeGUg5U3OkeT/X5v4XKwr08PlzWm6SUW/2xKwkgFutbxQ/hpiKmh5PUfMniw6yC
         L2pItgOROrWWhX3BVpGABcNH6gBD6qpnu19VQGXlhj4V1/O6TFK5/bco3NXfaIAO87q2
         V7LOi/WUATuoO9aAwd0Q0QdbEpOmnQYO9Vt31PcprgN2Z2X5Spx9WVMCgXzZ3O+dZpYO
         BSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AiAycDrybveoMuJFEB+r5dLTNOyKRMMZ7bT1bkVL/x4=;
        b=Bbl3pdgiBym+p6V9ZsGd04TgSStGlUEHDCGaS8mieyC0ShkVk4Zc8+vj8eQAyM5Na5
         q1RcQsJwuOVF7C5KKsHuZiE0ko3w33071dTomY+5oB/xTIH4E/6Rym6n3QXsurAlR+6r
         FBgiqx7o7Y2cjXmMM+HylfHt35FfU6MimZBmevqbvCu7EiD2ereCj2EGfQKxKFb1jdsP
         fSyh6S7x5tTBEoG0VPzXm5vx1eEUgJff5q/TU1oEOUXK94F2Qn9bsRYuDaNCGG02I8Fd
         xx6GhGGTmXxvezMFx9ohrdCkAMiKEJKIJmZAGiDfYucxE+6BJicgvJuaHAdtiQWcq9As
         LqHg==
X-Gm-Message-State: AO0yUKXwwfA/lGpUIMFbh9mnHamQJb3Bb5jcaB4TvUm4Xah3jmE6ww+F
        /yT+bgDxiIth1TVMDM4Fa+dM4VUcWWfH
X-Google-Smtp-Source: AK7set9IgB0DC1xtM8FHHexh2+omWFeYd4xPfiQJDL4uQcLTHNS60bCNetPqI8ejH4DScPcC9wHXMLC4bqUk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a05:6902:351:b0:8ac:72e3:c743 with SMTP id
 e17-20020a056902035100b008ac72e3c743mr14973ybs.9.1676799074539; Sun, 19 Feb
 2023 01:31:14 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:13 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-17-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 16/51] perf vendor events intel: Add graniterapids events
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

Add version 1.00 of the graniterapids events from
https://github.com/intel/perfmon.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/graniterapids/cache.json         |  54 ++++++
 .../arch/x86/graniterapids/frontend.json      |  10 +
 .../arch/x86/graniterapids/memory.json        | 174 ++++++++++++++++++
 .../arch/x86/graniterapids/other.json         |  29 +++
 .../arch/x86/graniterapids/pipeline.json      | 102 ++++++++++
 .../x86/graniterapids/virtual-memory.json     |  26 +++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   1 +
 7 files changed, 396 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/frontend.j=
son
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/memory.jso=
n
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/pipeline.j=
son
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/virtual-me=
mory.json

diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/cache.json b/tool=
s/perf/pmu-events/arch/x86/graniterapids/cache.json
new file mode 100644
index 000000000000..56212827870c
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/cache.json
@@ -0,0 +1,54 @@
+[
+    {
+        "BriefDescription": "L2 code requests",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.ALL_CODE_RD",
+        "PublicDescription": "Counts the total number of L2 code requests.=
",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe4"
+    },
+    {
+        "BriefDescription": "Demand Data Read access L2 cache",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
+        "PublicDescription": "Counts Demand Data Read requests accessing t=
he L2 cache. These requests may hit or miss L2 cache. True-miss exclude mis=
ses that were merged with ongoing L2 misses. An access is counted once.",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe1"
+    },
+    {
+        "BriefDescription": "Core-originated cacheable requests that misse=
d L3  (Except hardware prefetches to the L3)",
+        "EventCode": "0x2e",
+        "EventName": "LONGEST_LAT_CACHE.MISS",
+        "PublicDescription": "Counts core-originated cacheable requests th=
at miss the L3 cache (Longest Latency cache). Requests include data and cod=
e reads, Reads-for-Ownership (RFOs), speculative accesses and hardware pref=
etches to the L1 and L2.  It does not include hardware prefetches to the L3=
, and may not count other types of requests to the L3.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x41"
+    },
+    {
+        "BriefDescription": "Core-originated cacheable requests that refer=
 to L3 (Except hardware prefetches to the L3)",
+        "EventCode": "0x2e",
+        "EventName": "LONGEST_LAT_CACHE.REFERENCE",
+        "PublicDescription": "Counts core-originated cacheable requests to=
 the L3 cache (Longest Latency cache). Requests include data and code reads=
, Reads-for-Ownership (RFOs), speculative accesses and hardware prefetches =
to the L1 and L2.  It does not include hardware prefetches to the L3, and m=
ay not count other types of requests to the L3.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4f"
+    },
+    {
+        "BriefDescription": "Retired load instructions.",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.ALL_LOADS",
+        "PEBS": "1",
+        "PublicDescription": "Counts all retired load instructions. This e=
vent accounts for SW prefetch instructions of PREFETCHNTA or PREFETCHT0/1/2=
 or PREFETCHW.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x81"
+    },
+    {
+        "BriefDescription": "Retired store instructions.",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.ALL_STORES",
+        "PEBS": "1",
+        "PublicDescription": "Counts all retired store instructions.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x82"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/frontend.json b/t=
ools/perf/pmu-events/arch/x86/graniterapids/frontend.json
new file mode 100644
index 000000000000..dfd9c5ea1584
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/frontend.json
@@ -0,0 +1,10 @@
+[
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
vent as the nominator for the Frontend Bound metric (or top-level category)=
 of the Top-down Microarchitecture Analysis method.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/memory.json b/too=
ls/perf/pmu-events/arch/x86/graniterapids/memory.json
new file mode 100644
index 000000000000..1c0e0e86e58e
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/memory.json
@@ -0,0 +1,174 @@
+[
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 128 cycles.",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x80",
+        "PEBS": "2",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 128 cycles.  Reported=
 latency may be longer than just the memory latency.",
+        "SampleAfterValue": "1009",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 16 cycles.",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x10",
+        "PEBS": "2",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 16 cycles.  Reported =
latency may be longer than just the memory latency.",
+        "SampleAfterValue": "20011",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 256 cycles.",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x100",
+        "PEBS": "2",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 256 cycles.  Reported=
 latency may be longer than just the memory latency.",
+        "SampleAfterValue": "503",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 32 cycles.",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x20",
+        "PEBS": "2",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 32 cycles.  Reported =
latency may be longer than just the memory latency.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 4 cycles.",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x4",
+        "PEBS": "2",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 4 cycles.  Reported l=
atency may be longer than just the memory latency.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 512 cycles.",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x200",
+        "PEBS": "2",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 512 cycles.  Reported=
 latency may be longer than just the memory latency.",
+        "SampleAfterValue": "101",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 64 cycles.",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x40",
+        "PEBS": "2",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 64 cycles.  Reported =
latency may be longer than just the memory latency.",
+        "SampleAfterValue": "2003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 8 cycles.",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x8",
+        "PEBS": "2",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 8 cycles.  Reported l=
atency may be longer than just the memory latency.",
+        "SampleAfterValue": "50021",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired memory store access operations. A PDi=
st event for PEBS Store Latency Facility.",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.STORE_SAMPLE",
+        "PEBS": "2",
+        "PublicDescription": "Counts Retired memory accesses with at least=
 1 store operation. This PEBS event is the precisely-distributed (PDist) tr=
igger covering all stores uops for sampling by the PEBS Store Latency Facil=
ity. The facility is described in Intel SDM Volume 3 section 19.9.8",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were not suppli=
ed by the local socket's L1, L2, or L3 caches.",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3FBFC00001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were n=
ot supplied by the local socket's L1, L2, or L3 caches.",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F3FC00002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of times an RTM execution aborted.",
+        "EventCode": "0xc9",
+        "EventName": "RTM_RETIRED.ABORTED",
+        "PublicDescription": "Counts the number of times RTM abort was tri=
ggered.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Number of times an RTM execution successfully=
 committed",
+        "EventCode": "0xc9",
+        "EventName": "RTM_RETIRED.COMMIT",
+        "PublicDescription": "Counts the number of times RTM commit succee=
ded.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of times an RTM execution started.",
+        "EventCode": "0xc9",
+        "EventName": "RTM_RETIRED.START",
+        "PublicDescription": "Counts the number of times we entered an RTM=
 region. Does not count nested transactions.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Speculatively counts the number of TSX aborts=
 due to a data capacity limitation for transactional reads",
+        "EventCode": "0x54",
+        "EventName": "TX_MEM.ABORT_CAPACITY_READ",
+        "PublicDescription": "Speculatively counts the number of Transacti=
onal Synchronization Extensions (TSX) aborts due to a data capacity limitat=
ion for transactional reads",
+        "SampleAfterValue": "100003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Speculatively counts the number of TSX aborts=
 due to a data capacity limitation for transactional writes.",
+        "EventCode": "0x54",
+        "EventName": "TX_MEM.ABORT_CAPACITY_WRITE",
+        "PublicDescription": "Speculatively counts the number of Transacti=
onal Synchronization Extensions (TSX) aborts due to a data capacity limitat=
ion for transactional writes.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of times a transactional abort was sig=
naled due to a data conflict on a transactionally accessed address",
+        "EventCode": "0x54",
+        "EventName": "TX_MEM.ABORT_CONFLICT",
+        "PublicDescription": "Counts the number of times a TSX line had a =
cache conflict.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/other.json b/tool=
s/perf/pmu-events/arch/x86/graniterapids/other.json
new file mode 100644
index 000000000000..5e799bae03ea
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/other.json
@@ -0,0 +1,29 @@
+[
+    {
+        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) Mode.  In S=
NC Mode counts only those DRAM accesses that are controlled by the close SN=
C Cluster.",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x104000001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that have a=
ny type of response.",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F3FFC0002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json b/t=
ools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
new file mode 100644
index 000000000000..d6aafb258708
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
@@ -0,0 +1,102 @@
+[
+    {
+        "BriefDescription": "All branch instructions retired.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
+        "PEBS": "1",
+        "PublicDescription": "Counts all branch instructions retired.",
+        "SampleAfterValue": "400009"
+    },
+    {
+        "BriefDescription": "All mispredicted branch instructions retired.=
",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
+        "PEBS": "1",
+        "PublicDescription": "Counts all the retired branch instructions t=
hat were mispredicted by the processor. A branch misprediction occurs when =
the processor incorrectly predicts the destination of the branch.  When the=
 misprediction is discovered at execution, all the instructions executed in=
 the wrong (speculative) path must be discarded, and the processor must sta=
rt fetching from the correct path.",
+        "SampleAfterValue": "400009"
+    },
+    {
+        "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
+        "EventName": "CPU_CLK_UNHALTED.REF_TSC",
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
+        "SampleAfterValue": "2000003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
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
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Core cycles when the thread is not in halt st=
ate",
+        "EventName": "CPU_CLK_UNHALTED.THREAD",
+        "PublicDescription": "Counts the number of core cycles while the t=
hread is not in a halt state. The thread enters the halt state when it is r=
unning the HLT instruction. This event is a component in many key event rat=
ios. The core frequency may change from time to time due to transitions ass=
ociated with Enhanced Intel SpeedStep Technology or TM2. For this reason th=
is event may have a changing ratio with regards to time. When the core freq=
uency is constant, this event can approximate elapsed time while the core w=
as not in the halt state. It is counted on a dedicated fixed counter, leavi=
ng the eight programmable counters available for other events.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Thread cycles when thread is not in halt stat=
e",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.THREAD_P",
+        "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time.",
+        "SampleAfterValue": "2000003"
+    },
+    {
+        "BriefDescription": "Number of instructions retired. Fixed Counter=
 - architectural event",
+        "EventName": "INST_RETIRED.ANY",
+        "PEBS": "1",
+        "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of instructions retired. General Count=
er - architectural event",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.ANY_P",
+        "PEBS": "1",
+        "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
+        "SampleAfterValue": "2000003"
+    },
+    {
+        "BriefDescription": "Loads blocked due to overlapping with a prece=
ding store that cannot be forwarded.",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.STORE_FORWARD",
+        "PublicDescription": "Counts the number of times where store forwa=
rding was prevented for a load operation. The most common case is a load bl=
ocked due to the address of memory access (partially) overlapping with a pr=
eceding uncompleted store. Note: See the table of not supported store forwa=
rds in the Optimization Guide.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x82"
+    },
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
 event as the nominator for the Backend Bound metric (or top-level category=
) of the Top-down Microarchitecture Analysis method.",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "TMA slots available for an unhalted logical p=
rocessor. Fixed counter - architectural event",
+        "EventName": "TOPDOWN.SLOTS",
+        "PublicDescription": "Number of available slots for an unhalted lo=
gical processor. The event increments by machine-width of the narrowest pip=
eline as employed by the Top-down Microarchitecture Analysis method (TMA). =
The count is distributed among unhalted logical processors (hyper-threads) =
who share the same physical core. Software can use this event as the denomi=
nator for the top-level metrics of the TMA method. This architectural event=
 is counted on a designated fixed counter (Fixed Counter 3).",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "TMA slots available for an unhalted logical p=
rocessor. General counter - architectural event",
+        "EventCode": "0xa4",
+        "EventName": "TOPDOWN.SLOTS_P",
+        "PublicDescription": "Counts the number of available slots for an =
unhalted logical processor. The event increments by machine-width of the na=
rrowest pipeline as employed by the Top-down Microarchitecture Analysis met=
hod. The count is distributed among unhalted logical processors (hyper-thre=
ads) who share the same physical core.",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x1"
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
cycle metric.\nSoftware can use this event as the nominator for the Retirin=
g metric (or top-level category) of the Top-down Microarchitecture Analysis=
 method.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/virtual-memory.js=
on b/tools/perf/pmu-events/arch/x86/graniterapids/virtual-memory.json
new file mode 100644
index 000000000000..8784c97b7534
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/virtual-memory.json
@@ -0,0 +1,26 @@
+[
+    {
+        "BriefDescription": "Load miss in all TLB levels causes a page wal=
k that completes. (All page sizes)",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
+        "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data loads. This implies it missed in the DTLB and furth=
er levels of TLB. The page walk can end with or without a fault.",
+        "SampleAfterValue": "100003",
+        "UMask": "0xe"
+    },
+    {
+        "BriefDescription": "Store misses in all TLB levels causes a page =
walk that completes. (All page sizes)",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
+        "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data stores. This implies it missed in the DTLB and furt=
her levels of TLB. The page walk can end with or without a fault.",
+        "SampleAfterValue": "100003",
+        "UMask": "0xe"
+    },
+    {
+        "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (All page sizes)",
+        "EventCode": "0x11",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED",
+        "PublicDescription": "Counts completed page walks (all page sizes)=
 caused by a code fetch. This implies it missed in the ITLB (Instruction TL=
B) and further levels of TLB. The page walk can end with or without a fault=
.",
+        "SampleAfterValue": "100003",
+        "UMask": "0xe"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 793076e00188..1677ec22e2e3 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -9,6 +9,7 @@ GenuineIntel-6-55-[56789ABCDEF],v1.17,cascadelakex,core
 GenuineIntel-6-9[6C],v1.03,elkhartlake,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
+GenuineIntel-6-A[DE],v1.00,graniterapids,core
 GenuineIntel-6-(3C|45|46),v32,haswell,core
 GenuineIntel-6-3F,v26,haswellx,core
 GenuineIntel-6-(7D|7E|A7),v1.15,icelake,core
--=20
2.39.2.637.g21b0678d19-goog

