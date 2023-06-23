Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F3573ADDE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjFWAfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjFWAex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:34:53 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C7E2D4A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:34:04 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-568ae92e492so93310067b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687480441; x=1690072441;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWdLHEd/YivuvSTeVJWgp5BCZMhtIbKvRifpfShVHCI=;
        b=yHfevFOoPit2HnqBAfUqA3usl8wAzLgSAtOLk5FF4WucszOL5z10z4Hzt8JTXcWwEe
         f98tXJuwCKpnpA4u0taAL2wJIvtjwxsmRSMM60BlSWl56UVT8Sc62ztJfvOvslK+rD8f
         AMtf9x0ovvhox/1tBONAuTSoRu9zJok7Il2EEnhKrlEAyMA0O5dnQx77FKCNI6iOpgE8
         8sNcLqDl2jOxojO2F/bCFQLcUsFPnRnLiNKR3xxK6FK55RlXaGZj3vKE42nX3zpnLV5k
         KjuFo2iTiqu3CeBkXsoLjsSZd91hdycrLnxZuJoFueP2uCYW5bw7aNqziKyy1iAq4smJ
         wzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687480441; x=1690072441;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XWdLHEd/YivuvSTeVJWgp5BCZMhtIbKvRifpfShVHCI=;
        b=HdlZfjiHMZSgUMi2N6cVU2x8ruPd2QQjoWTxbCC3KZ1Re4INaUcjtaR5fYd1XSkW+i
         O80XlU00TsOnsYmUVZjOnG205a0zQGGCVTDsivSguxgIt/0evgNh/I47iKRy+64Z3fzi
         aklpOH09lhiN8IR9Xl0jKMFqOSvTfIO3zDRJ874B6AL3YHdF5Th/MPS2FaGF8q3fEZ2E
         1ndE9Iw3AwIgqOJhS2+69GWmBKpYK5koSY0kuTGAu3XjH8oIEWOhVlWlUUmhMLW+Go+o
         MXOpCWO9Wwz3cm1Rx7B+wBomefnKGb6ZjEdfq/xKZrSUl6RuWLy7iKSxNyu5UE8YVops
         Aiqw==
X-Gm-Message-State: AC+VfDzLgo4Vvm5B9lKa5GVFfyH7npEmClGjIcpe9YmbDnZdE1xae1mi
        N670ScZFgG/vx/dORHwOOGnWqUmW4oR9
X-Google-Smtp-Source: ACHHUZ54uE1/LWByu/X3ivefYyhhSlUawbwo92IzFUaSmBwQh1CWavo/TogIO/XZE9eb76vEv+KJcSJVRQax
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a81:7e4f:0:b0:56c:f4ee:92f with SMTP id
 p15-20020a817e4f000000b0056cf4ee092fmr7288701ywn.1.1687480441560; Thu, 22 Jun
 2023 17:34:01 -0700 (PDT)
Date:   Thu, 22 Jun 2023 17:33:11 -0700
In-Reply-To: <20230623003312.3981075-1-irogers@google.com>
Message-Id: <20230623003312.3981075-12-irogers@google.com>
Mime-Version: 1.0
References: <20230623003312.3981075-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 11/12] perf vendor events intel: Update skylakex to 1.31
From:   Ian Rogers <irogers@google.com>
To:     eter Zijlstra <peterz@infradead.org>,
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
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>
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

Updates were released in:
https://github.com/intel/perfmon/commit/cdaa69afe7a48a217b1d89320a27efc6e65=
0cec3
Adds the events IDQ.DSB_CYCLES_OK, IDQ.DSB_CYCLES_ANY,
ICACHE_TAG.STALLS, DECODE.LCP, LSD.CYCLES_OK. Descriptions are also
updated.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 .../arch/x86/skylakex/frontend.json           | 43 ++++++++++++++++---
 .../arch/x86/skylakex/pipeline.json           | 17 ++++++--
 .../x86/skylakex/uncore-interconnect.json     |  2 +-
 .../arch/x86/skylakex/uncore-memory.json      |  2 +-
 5 files changed, 54 insertions(+), 12 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 5104b93d57ab..7c6598a9b240 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -28,7 +28,7 @@ GenuineIntel-6-(8F|CF),v1.14,sapphirerapids,core
 GenuineIntel-6-AF,v1.00,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v57,skylake,core
-GenuineIntel-6-55-[01234],v1.30,skylakex,core
+GenuineIntel-6-55-[01234],v1.31,skylakex,core
 GenuineIntel-6-86,v1.21,snowridgex,core
 GenuineIntel-6-8[CD],v1.12,tigerlake,core
 GenuineIntel-6-2C,v4,westmereep-dp,core
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/frontend.json b/tools/=
perf/pmu-events/arch/x86/skylakex/frontend.json
index 04f08e4d2402..095904c77001 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/frontend.json
@@ -7,6 +7,14 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction. [This event is alias to ILD_STALL.LCP]",
+        "EventCode": "0x87",
+        "EventName": "DECODE.LCP",
+        "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk. [This event is=
 alias to ILD_STALL.LCP]",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Decode Stream Buffer (DSB)-to-MITE switches",
         "EventCode": "0xAB",
@@ -245,27 +253,34 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache tag miss.",
+        "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache tag miss. [This event is alias to ICACHE_TAG.STALLS]",
         "EventCode": "0x83",
         "EventName": "ICACHE_64B.IFTAG_STALL",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng 4 Uops",
+        "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache tag miss. [This event is alias to ICACHE_64B.IFTAG_STAL=
L]",
+        "EventCode": "0x83",
+        "EventName": "ICACHE_TAG.STALLS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng 4 Uops [This event is alias to IDQ.DSB_CYCLES_OK]",
         "CounterMask": "4",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_DSB_CYCLES_4_UOPS",
-        "PublicDescription": "Counts the number of cycles 4 uops were deli=
vered to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB)=
 path. Count includes uops that may 'bypass' the IDQ.",
+        "PublicDescription": "Counts the number of cycles 4 uops were deli=
vered to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB)=
 path. Count includes uops that may 'bypass' the IDQ. [This event is alias =
to IDQ.DSB_CYCLES_OK]",
         "SampleAfterValue": "2000003",
         "UMask": "0x18"
     },
     {
-        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng any Uop",
+        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng any Uop [This event is alias to IDQ.DSB_CYCLES_ANY]",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_DSB_CYCLES_ANY_UOPS",
-        "PublicDescription": "Counts the number of cycles uops were delive=
red to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) p=
ath. Count includes uops that may 'bypass' the IDQ.",
+        "PublicDescription": "Counts the number of cycles uops were delive=
red to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) p=
ath. Count includes uops that may 'bypass' the IDQ. [This event is alias to=
 IDQ.DSB_CYCLES_ANY]",
         "SampleAfterValue": "2000003",
         "UMask": "0x18"
     },
@@ -296,6 +311,24 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     },
+    {
+        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng any Uop [This event is alias to IDQ.ALL_DSB_CYCLES_ANY_UOPS]",
+        "CounterMask": "1",
+        "EventCode": "0x79",
+        "EventName": "IDQ.DSB_CYCLES_ANY",
+        "PublicDescription": "Counts the number of cycles uops were delive=
red to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) p=
ath. Count includes uops that may 'bypass' the IDQ. [This event is alias to=
 IDQ.ALL_DSB_CYCLES_ANY_UOPS]",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x18"
+    },
+    {
+        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng 4 Uops [This event is alias to IDQ.ALL_DSB_CYCLES_4_UOPS]",
+        "CounterMask": "4",
+        "EventCode": "0x79",
+        "EventName": "IDQ.DSB_CYCLES_OK",
+        "PublicDescription": "Counts the number of cycles 4 uops were deli=
vered to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB)=
 path. Count includes uops that may 'bypass' the IDQ. [This event is alias =
to IDQ.ALL_DSB_CYCLES_4_UOPS]",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x18"
+    },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from the Decode Stream Buffer (DSB) path",
         "EventCode": "0x79",
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json b/tools/=
perf/pmu-events/arch/x86/skylakex/pipeline.json
index 31a1663d57f8..66d686cc933e 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json
@@ -361,10 +361,10 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction.",
+        "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction. [This event is alias to DECODE.LCP]",
         "EventCode": "0x87",
         "EventName": "ILD_STALL.LCP",
-        "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk.",
+        "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk. [This event is=
 alias to DECODE.LCP]",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -488,11 +488,11 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Cycles 4 Uops delivered by the LSD, but didn'=
t come from the decoder.",
+        "BriefDescription": "Cycles 4 Uops delivered by the LSD, but didn'=
t come from the decoder. [This event is alias to LSD.CYCLES_OK]",
         "CounterMask": "4",
         "EventCode": "0xA8",
         "EventName": "LSD.CYCLES_4_UOPS",
-        "PublicDescription": "Counts the cycles when 4 uops are delivered =
by the LSD (Loop-stream detector).",
+        "PublicDescription": "Counts the cycles when 4 uops are delivered =
by the LSD (Loop-stream detector). [This event is alias to LSD.CYCLES_OK]",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -505,6 +505,15 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Cycles 4 Uops delivered by the LSD, but didn'=
t come from the decoder. [This event is alias to LSD.CYCLES_4_UOPS]",
+        "CounterMask": "4",
+        "EventCode": "0xA8",
+        "EventName": "LSD.CYCLES_OK",
+        "PublicDescription": "Counts the cycles when 4 uops are delivered =
by the LSD (Loop-stream detector). [This event is alias to LSD.CYCLES_4_UOP=
S]",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Number of Uops delivered by the LSD.",
         "EventCode": "0xA8",
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.js=
on b/tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.json
index 26a5a20bf37a..3eece8a728b5 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.json
@@ -6504,7 +6504,7 @@
         "EventCode": "0x52",
         "EventName": "UNC_M3UPI_RxC_HELD.PARALLEL_SUCCESS",
         "PerPkg": "1",
-        "PublicDescription": "ad and bl messages were actually slotted int=
o the same flit in paralle",
+        "PublicDescription": "ad and bl messages were actually slotted int=
o the same flit in parallel",
         "UMask": "0x8",
         "Unit": "M3UPI"
     },
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-memory.json b/t=
ools/perf/pmu-events/arch/x86/skylakex/uncore-memory.json
index 6f8ff2262ce7..7a40aa0f1018 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-memory.json
@@ -1952,7 +1952,7 @@
         "EventCode": "0x81",
         "EventName": "UNC_M_WPQ_OCCUPANCY",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries in the Write Pe=
nding Queue (WPQ) at each cycle.  This can then be used to calculate both t=
he average queue occupancy (in conjunction with the number of cycles not em=
pty) and the average latency (in conjunction with the number of allocations=
).  The WPQ is used to schedule writes out to the memory controller and to =
track the requests.  Requests allocate into the WPQ soon after they enter t=
he memory controller, and need credits for an entry in this buffer before b=
eing sent from the CHA to the iMC (memory controller).  They deallocate aft=
er being issued to DRAM.  Write requests themselves are able to complete (f=
rom the perspective of the rest of the system) as soon they have 'posted' t=
o the iMC.  This is not to be confused with actually performing the write t=
o DRAM.  Therefore, the average latency for this queue is actually not usef=
ul for deconstruction intermediate write latencies.  So, we provide filteri=
ng based on if the request has posted or not.  By using the 'not posted' fi=
lter, we can track how long writes spent in the iMC before completions were=
 sent to the HA.  The 'posted' filter, on the other hand, provides informat=
ion about how much queueing is actually happening in the iMC for writes bef=
ore they are actually issued to memory.  High average occupancies will gene=
rally coincide with high write major mode counts. Is there a filter of sort=
s?",
+        "PublicDescription": "Counts the number of entries in the Write Pe=
nding Queue (WPQ) at each cycle.  This can then be used to calculate both t=
he average queue occupancy (in conjunction with the number of cycles not em=
pty) and the average latency (in conjunction with the number of allocations=
).  The WPQ is used to schedule writes out to the memory controller and to =
track the requests.  Requests allocate into the WPQ soon after they enter t=
he memory controller, and need credits for an entry in this buffer before b=
eing sent from the CHA to the iMC (memory controller).  They deallocate aft=
er being issued to DRAM.  Write requests themselves are able to complete (f=
rom the perspective of the rest of the system) as soon they have 'posted' t=
o the iMC.  This is not to be confused with actually performing the write t=
o DRAM.  Therefore, the average latency for this queue is actually not usef=
ul for deconstruction intermediate write latencies.  So, we provide filteri=
ng based on if the request has posted or not.  By using the 'not posted' fi=
lter, we can track how long writes spent in the iMC before completions were=
 sent to the HA.  The 'posted' filter, on the other hand, provides informat=
ion about how much queueing is actually happening in the iMC for writes bef=
ore they are actually issued to memory.  High average occupancies will gene=
rally coincide with high write major mode counts.",
         "Unit": "iMC"
     },
     {
--=20
2.41.0.162.gfafddb0af9-goog

