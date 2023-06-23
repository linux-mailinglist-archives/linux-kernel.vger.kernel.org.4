Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2B773ADDC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjFWAfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjFWAef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:34:35 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1838297B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:34:00 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-561eb6c66f6so10737b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687480439; x=1690072439;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jhkdSyMhMNyUWrs1ZBCpoFwWPpdU98HpFzjjfUuXr6w=;
        b=33ZmOVR3//JDk3AA1FWVyVUurqLMoSNYmw55tVPUj5tRc5X5lyO+uOQiM8Dd0e3Wwr
         g0eZqRDZjBhV2U3lexNvVRjmXPCU5ICDKxe85PtBflTPl09kFCiu4fra+i6p7DYNzQ3p
         n2f6lChudUCUNB6IOwHt9tnlVY1A1QWLjdzwwEKlb/wfvWdOAggn3Ze5U5kQHL1TChed
         VGdbZFkWLnVV0j6uYEEjIMZvPHSuoq6CPcPkqCPwkAp79irPOn7mD6kj7B8GLAVxrPHn
         xYUXVw3I90OlUn6t+Fg6boUhUXD9+S2HCkurNmYozoylrw1nZ8DmBhQQ//uEJQP2goNl
         COMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687480439; x=1690072439;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jhkdSyMhMNyUWrs1ZBCpoFwWPpdU98HpFzjjfUuXr6w=;
        b=H9U7w5zOR+RTM1uO03fL9kExskVbZFG5L0Qp8uFQqAp9OCdPQDSbTV2rFEIGwGSSdS
         RlnhAdKulfbtPfr93FSgJ43gni0PEpgZGdR/U8YjFRQ6W58UtULX30yzOicYOwp+0Ix7
         xr93WfzfhcIlYoLP4wL3PC7K4UoEGl3dcvVoe2M9hKLv+KKhFFeg4V57EVAQiX6PQACU
         VcjrVLkBDnWnLIvbBD+UgEOvB2a7rvgX/MqbK7uWAi85CRBJn9PFQ4ywF4NHJUdEaspW
         RTw4r2Ya/H2kLcmt11sCS0wdfMezBe+BuXemxHe42kTurYAE0U51aSi/kyiayTleiAb7
         hkpQ==
X-Gm-Message-State: AC+VfDxiSyKUjPBpfIzzbT2j8kSyMN45OOOX7lox3pdkfKc2GISrfdqk
        fsLSLds3nlohGUR0kqifJet43qmjtYu8
X-Google-Smtp-Source: ACHHUZ7JeoXVqmENMrloV9JvDYDoBPA6z20pBfUJ3CKwrk16mxUoGuF+tRlloAIepdhjg71V9YNXdH3hb+5I
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a81:4507:0:b0:568:c4ea:ce66 with SMTP id
 s7-20020a814507000000b00568c4eace66mr8675640ywa.5.1687480439449; Thu, 22 Jun
 2023 17:33:59 -0700 (PDT)
Date:   Thu, 22 Jun 2023 17:33:10 -0700
In-Reply-To: <20230623003312.3981075-1-irogers@google.com>
Message-Id: <20230623003312.3981075-11-irogers@google.com>
Mime-Version: 1.0
References: <20230623003312.3981075-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 10/12] perf vendor events intel: Update skylake to 57
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates were released in:
https://github.com/intel/perfmon/commit/1c3042c13bbfea05abe1ebb6910ae58b217=
2e9ef
Adds the events IDQ.DSB_CYCLES_OK, IDQ.DSB_CYCLES_ANY,
ICACHE_TAG.STALLS, DECODE.LCP, LSD.CYCLES_OK. Descriptions are also
updated.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 .../pmu-events/arch/x86/skylake/frontend.json | 43 ++++++++++++++++---
 .../pmu-events/arch/x86/skylake/pipeline.json | 17 ++++++--
 3 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index f321b2cd83da..5104b93d57ab 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -27,7 +27,7 @@ GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-(8F|CF),v1.14,sapphirerapids,core
 GenuineIntel-6-AF,v1.00,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
-GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v56,skylake,core
+GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v57,skylake,core
 GenuineIntel-6-55-[01234],v1.30,skylakex,core
 GenuineIntel-6-86,v1.21,snowridgex,core
 GenuineIntel-6-8[CD],v1.12,tigerlake,core
diff --git a/tools/perf/pmu-events/arch/x86/skylake/frontend.json b/tools/p=
erf/pmu-events/arch/x86/skylake/frontend.json
index 04f08e4d2402..095904c77001 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/frontend.json
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
diff --git a/tools/perf/pmu-events/arch/x86/skylake/pipeline.json b/tools/p=
erf/pmu-events/arch/x86/skylake/pipeline.json
index cc800fb8180a..cd3e737bf4a1 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/pipeline.json
@@ -352,10 +352,10 @@
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
@@ -479,11 +479,11 @@
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
@@ -496,6 +496,15 @@
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
--=20
2.41.0.162.gfafddb0af9-goog

