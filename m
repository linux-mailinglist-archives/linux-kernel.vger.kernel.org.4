Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0061664D6DB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 08:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiLOHBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 02:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiLOHAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 02:00:00 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A571654C8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:57:44 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v195-20020a252fcc000000b007125383fe0dso2634165ybv.23
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eERp481G91d5uQLxQo1YisJJuTjXaDjqLfn0H+waYPg=;
        b=BLHEEKiEnggsZtFYZWPBjXIx6STV2DHHoDw+mfHE5ZaxBM6G0ZaI8uR0/QeMPAgZBm
         9GPbs+Kp+J9EeBiIczT94WKc+1XqWoMWcMuU9zHQD1L6EmDRICq+mAX9XL7wdchz3gwl
         prTmFLdszGLZPHp06kS8Hbvcc2kR5cwJ4uTi+qXdeBAphq7g9udfD0tTVj7UmNKJbpXN
         A3s6DP4fC+Tn4FtQRfwIFGVehKhfBkhBNnr2odxoIcpVV50Efa55lGJiWm/g25+75bfj
         HrQqw0+kcDSQRjHPoHfcl51sSC86Q3m8Mrxr0ML5g9O/Q1PckKmfw17DXF22Vgw3xd6g
         5Z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eERp481G91d5uQLxQo1YisJJuTjXaDjqLfn0H+waYPg=;
        b=sy/fum198HGRgzdf68G4rd62vWwcrV8c+zbmkMbX6zg/KiMcFsgAl+Jk1DYOidiczN
         baU8XKF0ZoB2sNPQDKohCFoygpDQj5b8tCcj1qU2thce5Jj69rqbPlvNuCFEYC1spKtm
         o4OPxsp7qUIboEngd9grRYjvv3zKbGzq1BqksSlxq8dcwqOonPCjghbRMY0Po2HgFdHd
         hPtdBchMMpNPSlA4AIJ0hEP5Fkfz+2O3DlSx7V/XkqEO0PPgUlikVUOU1RjAteWesJ31
         8gLT/aU9CtVOFvJY/tqZaOLHiLESXyNLt80aYFJvbv9X2f41n8FvoqTKQ4wHm5/Tmtuf
         Mv5Q==
X-Gm-Message-State: ANoB5pkgbGH9AuiKG07GVbjX0NLuUeQS35nrzaIpSNjqUJnwfR0OGsuk
        1VTSKl3C8xfPg6M2RISRxSwYWoxog3e/
X-Google-Smtp-Source: AA0mqf5fB9JzstcC1/uhl9cNKQ/gMbfdowyQu6ODFa+uaGtvB8Dlp4p273f9931cm2Q+AYvd8ELYGQPcT9do
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c7dc:d96f:4f9:f59d])
 (user=irogers job=sendgmr) by 2002:a25:8052:0:b0:6fa:d6ec:1558 with SMTP id
 a18-20020a258052000000b006fad6ec1558mr39243549ybn.298.1671087463321; Wed, 14
 Dec 2022 22:57:43 -0800 (PST)
Date:   Wed, 14 Dec 2022 22:55:03 -0800
In-Reply-To: <20221215065510.1621979-1-irogers@google.com>
Message-Id: <20221215065510.1621979-17-irogers@google.com>
Mime-Version: 1.0
References: <20221215065510.1621979-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 25/32] perf vendor events intel: Refresh silvermont events
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the silvermont events using the new tooling from:
https://github.com/intel/perfmon

The events are unchanged but unused json values are removed. This
increases consistency across the json files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/silvermont/cache.json | 133 ------------------
 .../arch/x86/silvermont/floating-point.json   |   1 -
 .../arch/x86/silvermont/frontend.json         |   8 --
 .../arch/x86/silvermont/memory.json           |   1 -
 .../pmu-events/arch/x86/silvermont/other.json |   2 -
 .../arch/x86/silvermont/pipeline.json         |  35 -----
 .../arch/x86/silvermont/virtual-memory.json   |   7 -
 7 files changed, 187 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/silvermont/cache.json b/tools/p=
erf/pmu-events/arch/x86/silvermont/cache.json
index 7959504dff29..818e0664a3a6 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/cache.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/cache.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "Counts the number of request that were not ac=
cepted into the L2Q because the L2Q is FULL.",
-        "Counter": "0,1",
         "EventCode": "0x31",
         "EventName": "CORE_REJECT_L2Q.ALL",
         "PublicDescription": "Counts the number of (demand and L1 prefetch=
ers) core requests rejected by the L2Q due to a full or nearly full w condi=
tion which likely indicates back pressure from L2Q.  It also counts request=
s that would have gone directly to the XQ, but are rejected due to a full o=
r nearly full condition, indicating back pressure from the IDI link.  The L=
2Q may also reject transactions  from a core to insure fairness between cor=
es, or to delay a core?s dirty eviction when the address conflicts incoming=
 external snoops.  (Note that L2 prefetcher requests that are dropped are n=
ot counted by this event.)",
@@ -9,7 +8,6 @@
     },
     {
         "BriefDescription": "Cycles code-fetch stalled due to an outstandi=
ng ICache miss.",
-        "Counter": "0,1",
         "EventCode": "0x86",
         "EventName": "FETCH_STALL.ICACHE_FILL_PENDING_CYCLES",
         "PublicDescription": "Counts cycles that fetch is stalled due to a=
n outstanding ICache miss. That is, the decoder queue is able to accept byt=
es, but the fetch unit is unable to provide bytes due to an ICache miss.  N=
ote: this event is not the same as the total number of cycles spent retriev=
ing instruction cache lines from the memory hierarchy.\r\nCounts cycles tha=
t fetch is stalled due to any reason. That is, the decoder queue is able to=
 accept bytes, but the fetch unit is unable to provide bytes.  This will in=
clude cycles due to an ITLB miss, ICache miss and other events.",
@@ -18,7 +16,6 @@
     },
     {
         "BriefDescription": "Counts the number of request from the L2 that=
 were not accepted into the XQ",
-        "Counter": "0,1",
         "EventCode": "0x30",
         "EventName": "L2_REJECT_XQ.ALL",
         "PublicDescription": "This event counts the number of demand and p=
refetch transactions that the L2 XQ rejects due to a full or near full cond=
ition which likely indicates back pressure from the IDI link. The XQ may re=
ject transactions from the L2Q (non-cacheable requests), BBS (L2 misses) an=
d WOB (L2 write-back victims).",
@@ -26,7 +23,6 @@
     },
     {
         "BriefDescription": "L2 cache request misses",
-        "Counter": "0,1",
         "EventCode": "0x2E",
         "EventName": "LONGEST_LAT_CACHE.MISS",
         "PublicDescription": "This event counts the total number of L2 cac=
he references and the number of L2 cache misses respectively.",
@@ -35,7 +31,6 @@
     },
     {
         "BriefDescription": "L2 cache requests from this core",
-        "Counter": "0,1",
         "EventCode": "0x2E",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
         "PublicDescription": "This event counts requests originating from =
the core that references a cache line in the L2 cache.",
@@ -44,7 +39,6 @@
     },
     {
         "BriefDescription": "All Loads",
-        "Counter": "0,1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
         "PublicDescription": "This event counts the number of load ops ret=
ired.",
@@ -53,7 +47,6 @@
     },
     {
         "BriefDescription": "All Stores",
-        "Counter": "0,1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
         "PublicDescription": "This event counts the number of store ops re=
tired.",
@@ -62,7 +55,6 @@
     },
     {
         "BriefDescription": "Cross core or cross module hitm",
-        "Counter": "0,1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.HITM",
         "PEBS": "1",
@@ -72,7 +64,6 @@
     },
     {
         "BriefDescription": "Loads missed L1",
-        "Counter": "0,1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.L1_MISS_LOADS",
         "PublicDescription": "This event counts the number of load ops ret=
ired that miss in L1 Data cache. Note that prefetch misses will not be coun=
ted.",
@@ -81,7 +72,6 @@
     },
     {
         "BriefDescription": "Loads hit L2",
-        "Counter": "0,1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.L2_HIT_LOADS",
         "PEBS": "1",
@@ -91,7 +81,6 @@
     },
     {
         "BriefDescription": "Loads missed L2",
-        "Counter": "0,1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.L2_MISS_LOADS",
         "PEBS": "1",
@@ -101,7 +90,6 @@
     },
     {
         "BriefDescription": "Loads missed UTLB",
-        "Counter": "0,1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.UTLB_MISS",
         "PublicDescription": "This event counts the number of load ops ret=
ired that had UTLB miss.",
@@ -110,7 +98,6 @@
     },
     {
         "BriefDescription": "Offcore response can be programmed only with =
a specific pair of event select and counter MSR, and with specific event co=
des and predefine mask bit value in a dedicated MSR to specify attributes o=
f the offcore transaction",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE",
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
@@ -119,623 +106,510 @@
     },
     {
         "BriefDescription": "Counts any code reads (demand & prefetch) tha=
t have any response type.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010044",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any code reads (demand & prefetch) tha=
t miss L2.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1680000044",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any code reads (demand & prefetch) tha=
t hit in the other module where modified copies were found in other core's =
L1 cache.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_MISS.HITM_OTHER_CORE=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000000044",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any code reads (demand & prefetch) tha=
t miss L2 and the snoops to sibling cores hit in either E/S state and the l=
ine is not forwarded.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_MISS.HIT_OTHER_CORE_=
NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400000044",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any code reads (demand & prefetch) tha=
t miss L2 with a snoop miss response.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200000044",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any data read (demand & prefetch) that=
 have any response type.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000013091",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any data read (demand & prefetch) that=
 miss L2.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1680003091",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any data read (demand & prefetch) that=
 hit in the other module where modified copies were found in other core's L=
1 cache.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_MISS.HITM_OTHER_CORE=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000003091",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any data read (demand & prefetch) that=
 miss L2 and the snoops to sibling cores hit in either E/S state and the li=
ne is not forwarded.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_MISS.HIT_OTHER_CORE_=
NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400003091",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any data read (demand & prefetch) that=
 miss L2 with a snoop miss response.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200003091",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any request that have any response typ=
e.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000018008",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any request that hit in the other modu=
le where modified copies were found in other core's L1 cache.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_MISS.HITM_OTHER_CORE=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000008008",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any request that miss L2 and the snoop=
s to sibling cores hit in either E/S state and the line is not forwarded.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_MISS.HIT_OTHER_CORE_=
NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400008008",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any request that miss L2 with a snoop =
miss response.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200008008",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any rfo reads (demand & prefetch) that=
 have any response type.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010022",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any rfo reads (demand & prefetch) that=
 miss L2.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1680000022",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any rfo reads (demand & prefetch) that=
 hit in the other module where modified copies were found in other core's L=
1 cache.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_MISS.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000000022",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any rfo reads (demand & prefetch) that=
 miss L2 and the snoops to sibling cores hit in either E/S state and the li=
ne is not forwarded.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_MISS.HIT_OTHER_CORE_NO_F=
WD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400000022",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any rfo reads (demand & prefetch) that=
 miss L2 with a snoop miss response.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200000022",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writeback (modified to exclusive) that=
 miss L2.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1680000008",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writeback (modified to exclusive) that=
 miss L2 with no details on snoop-related information.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.L2_MISS.NO_SNOOP_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080000008",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch instruction ca=
cheline that have any response type.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010004",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch instruction ca=
cheline that miss L2.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1680000004",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch instruction ca=
cheline that miss L2 and the snoops to sibling cores hit in either E/S stat=
e and the line is not forwarded.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_MISS.HIT_OTHER_CO=
RE_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400000004",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch instruction ca=
cheline that miss L2 with a snoop miss response.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200000004",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch instruction ca=
cheline that are are outstanding, per cycle, from the time of the L2 miss t=
o when any response is received.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000000004",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch data read that=
 have any response type.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010001",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch data read that=
 miss L2.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1680000001",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch data read that=
 hit in the other module where modified copies were found in other core's L=
1 cache.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_MISS.HITM_OTHER_C=
ORE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000000001",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch data read that=
 miss L2 and the snoops to sibling cores hit in either E/S state and the li=
ne is not forwarded.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_MISS.HIT_OTHER_CO=
RE_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400000001",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch data read that=
 miss L2 with a snoop miss response.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200000001",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch data read that=
 are are outstanding, per cycle, from the time of the L2 miss to when any r=
esponse is received.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000000001",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch RFOs that miss=
 L2.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1680000002",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch RFOs that hit =
in the other module where modified copies were found in other core's L1 cac=
he.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_MISS.HITM_OTHER_CORE"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000000002",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch RFOs that miss=
 L2 and the snoops to sibling cores hit in either E/S state and the line is=
 not forwarded.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_MISS.HIT_OTHER_CORE_N=
O_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400000002",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch RFOs that miss=
 L2 with a snoop miss response.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200000002",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand and DCU prefetch RFOs that are =
are outstanding, per cycle, from the time of the L2 miss to when any respon=
se is received.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000000002",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads of partial cache lines (i=
ncluding UC and WC) that miss L2.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1680000080",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Countsof demand RFO requests to write to part=
ial cache lines that miss L2.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1680000100",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts DCU hardware prefetcher data read that=
 have any response type.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000012000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts DCU hardware prefetcher data read that=
 miss L2.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1680002000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts DCU hardware prefetcher data read that=
 hit in the other module where modified copies were found in other core's L=
1 cache.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_MISS.HITM_OTHER_CO=
RE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000002000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts DCU hardware prefetcher data read that=
 miss L2 and the snoops to sibling cores hit in either E/S state and the li=
ne is not forwarded.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_MISS.HIT_OTHER_COR=
E_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400002000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts DCU hardware prefetcher data read that=
 miss L2 with a snoop miss response.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200002000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts code reads generated by L2 prefetchers=
 that miss L2.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1680000040",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts code reads generated by L2 prefetchers=
 that miss L2 and the snoops to sibling cores hit in either E/S state and t=
he line is not forwarded.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_MISS.HIT_OTHER_COR=
E_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400000040",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts code reads generated by L2 prefetchers=
 that miss L2 with a snoop miss response.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200000040",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cacheline reads generated by L2 p=
refetchers that miss L2.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1680000010",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cacheline reads generated by L2 p=
refetchers that hit in the other module where modified copies were found in=
 other core's L1 cache.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L2_MISS.HITM_OTHER_CO=
RE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000000010",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cacheline reads generated by L2 p=
refetchers that miss L2 and the snoops to sibling cores hit in either E/S s=
tate and the line is not forwarded.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L2_MISS.HIT_OTHER_COR=
E_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400000010",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cacheline reads generated by L2 p=
refetchers that miss L2 with a snoop miss response.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L2_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200000010",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts RFO requests generated by L2 prefetche=
rs that miss L2.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1680000020",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts RFO requests generated by L2 prefetche=
rs that hit in the other module where modified copies were found in other c=
ore's L1 cache.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_MISS.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000000020",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts RFO requests generated by L2 prefetche=
rs that miss L2 and the snoops to sibling cores hit in either E/S state and=
 the line is not forwarded.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_MISS.HIT_OTHER_CORE_NO=
_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400000020",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts RFO requests generated by L2 prefetche=
rs that miss L2 with a snoop miss response.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200000020",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts streaming store that miss L2.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.STREAMING_STORES.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1680004800",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Any reissued load uops",
-        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "REHABQ.ANY_LD",
         "PublicDescription": "This event counts the number of load uops re=
issued from Rehabq.",
@@ -744,7 +618,6 @@
     },
     {
         "BriefDescription": "Any reissued store uops",
-        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "REHABQ.ANY_ST",
         "PublicDescription": "This event counts the number of store uops r=
eissued from Rehabq.",
@@ -753,7 +626,6 @@
     },
     {
         "BriefDescription": "Loads blocked due to store data not ready",
-        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "REHABQ.LD_BLOCK_STD_NOTREADY",
         "PublicDescription": "This event counts the cases where a forward =
was technically possible, but did not occur because the store data was not =
available at the right time.",
@@ -762,7 +634,6 @@
     },
     {
         "BriefDescription": "Loads blocked due to store forward restrictio=
n",
-        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "REHABQ.LD_BLOCK_ST_FORWARD",
         "PEBS": "1",
@@ -772,7 +643,6 @@
     },
     {
         "BriefDescription": "Load uops that split cache line boundary",
-        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "REHABQ.LD_SPLITS",
         "PEBS": "1",
@@ -782,7 +652,6 @@
     },
     {
         "BriefDescription": "Uops with lock semantics",
-        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "REHABQ.LOCK",
         "PublicDescription": "This event counts the number of retired memo=
ry operations with lock semantics. These are either implicit locked instruc=
tions such as the XCHG instruction or instructions with an explicit LOCK pr=
efix (0xF0).",
@@ -791,7 +660,6 @@
     },
     {
         "BriefDescription": "Store address buffer full",
-        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "REHABQ.STA_FULL",
         "PublicDescription": "This event counts the number of retired stor=
es that are delayed because there is not a store address buffer available."=
,
@@ -800,7 +668,6 @@
     },
     {
         "BriefDescription": "Store uops that split cache line boundary",
-        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "REHABQ.ST_SPLITS",
         "PublicDescription": "This event counts the number of retire store=
s that experienced cache line boundary splits.",
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/floating-point.json =
b/tools/perf/pmu-events/arch/x86/silvermont/floating-point.json
index aa4faf110512..f2b1e8f08d68 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/floating-point.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "Stalls due to FP assists",
-        "Counter": "0,1",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.FP_ASSIST",
         "PublicDescription": "This event counts the number of times that p=
ipeline stalled due to FP operations needing assists.",
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/frontend.json b/tool=
s/perf/pmu-events/arch/x86/silvermont/frontend.json
index 43e5e48f7212..c35da10f7133 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/frontend.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "Counts the number of baclears",
-        "Counter": "0,1",
         "EventCode": "0xE6",
         "EventName": "BACLEARS.ALL",
         "PublicDescription": "The BACLEARS event counts the number of time=
s the front end is resteered, mainly when the Branch Prediction Unit cannot=
 provide a correct prediction and this is corrected by the Branch Address C=
alculator at the front end.  The BACLEARS.ANY event counts the number of ba=
clears for any type of branch.",
@@ -10,7 +9,6 @@
     },
     {
         "BriefDescription": "Counts the number of JCC baclears",
-        "Counter": "0,1",
         "EventCode": "0xE6",
         "EventName": "BACLEARS.COND",
         "PublicDescription": "The BACLEARS event counts the number of time=
s the front end is resteered, mainly when the Branch Prediction Unit cannot=
 provide a correct prediction and this is corrected by the Branch Address C=
alculator at the front end.  The BACLEARS.COND event counts the number of J=
CC (Jump on Condtional Code) baclears.",
@@ -19,7 +17,6 @@
     },
     {
         "BriefDescription": "Counts the number of RETURN baclears",
-        "Counter": "0,1",
         "EventCode": "0xE6",
         "EventName": "BACLEARS.RETURN",
         "PublicDescription": "The BACLEARS event counts the number of time=
s the front end is resteered, mainly when the Branch Prediction Unit cannot=
 provide a correct prediction and this is corrected by the Branch Address C=
alculator at the front end.  The BACLEARS.RETURN event counts the number of=
 RETURN baclears.",
@@ -28,7 +25,6 @@
     },
     {
         "BriefDescription": "Counts the number of times a decode restricti=
on reduced the decode throughput due to wrong instruction length prediction=
",
-        "Counter": "0,1",
         "EventCode": "0xE9",
         "EventName": "DECODE_RESTRICTION.PREDECODE_WRONG",
         "PublicDescription": "Counts the number of times a decode restrict=
ion reduced the decode throughput due to wrong instruction length predictio=
n.",
@@ -37,7 +33,6 @@
     },
     {
         "BriefDescription": "Instruction fetches",
-        "Counter": "0,1",
         "EventCode": "0x80",
         "EventName": "ICACHE.ACCESSES",
         "PublicDescription": "This event counts all instruction fetches, n=
ot including most uncacheable\r\nfetches.",
@@ -46,7 +41,6 @@
     },
     {
         "BriefDescription": "Instruction fetches from Icache",
-        "Counter": "0,1",
         "EventCode": "0x80",
         "EventName": "ICACHE.HIT",
         "PublicDescription": "This event counts all instruction fetches fr=
om the instruction cache.",
@@ -55,7 +49,6 @@
     },
     {
         "BriefDescription": "Icache miss",
-        "Counter": "0,1",
         "EventCode": "0x80",
         "EventName": "ICACHE.MISSES",
         "PublicDescription": "This event counts all instruction fetches th=
at miss the Instruction cache or produce memory requests. This includes unc=
acheable fetches. An instruction fetch miss is counted only once and not on=
ce for every cycle it is outstanding.",
@@ -64,7 +57,6 @@
     },
     {
         "BriefDescription": "Counts the number of times entered into a uco=
de flow in the FEC.  Includes inserted flows due to front-end detected faul=
ts or assists.  Speculative count.",
-        "Counter": "0,1",
         "EventCode": "0xE7",
         "EventName": "MS_DECODED.MS_ENTRY",
         "PublicDescription": "Counts the number of times the MSROM starts =
a flow of UOPS. It does not count every time a UOP is read from the microco=
de ROM.  The most common case that this counts is when a micro-coded instru=
ction is encountered by the front end of the machine.  Other cases include =
when an instruction encounters a fault, trap, or microcode assist of any so=
rt.  The event will count MSROM startups for UOPS that are speculative, and=
 subsequently cleared by branch mispredict or machine clear.  Background: U=
OPS are produced by two mechanisms.  Either they are generated by hardware =
that decodes instructions into UOPS, or they are delivered by a ROM (called=
 the MSROM) that holds UOPS associated with a specific instruction.  MSROM =
UOPS might also be delivered in response to some condition such as a fault =
or other exceptional condition.  This event is an excellent mechanism for d=
etecting instructions that require the use of MSROM instructions.",
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/memory.json b/tools/=
perf/pmu-events/arch/x86/silvermont/memory.json
index 0f5fba43da4c..15ea45187210 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/memory.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/memory.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "Stalls due to Memory ordering",
-        "Counter": "0,1",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
         "PublicDescription": "This event counts the number of times that p=
ipeline was cleared due to memory ordering issues.",
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/other.json b/tools/p=
erf/pmu-events/arch/x86/silvermont/other.json
index 4db59d84c144..cff113adb823 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/other.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/other.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "Cycles code-fetch stalled due to any reason."=
,
-        "Counter": "0,1",
         "EventCode": "0x86",
         "EventName": "FETCH_STALL.ALL",
         "PublicDescription": "Counts cycles that fetch is stalled due to a=
ny reason. That is, the decoder queue is able to accept bytes, but the fetc=
h unit is unable to provide bytes.  This will include cycles due to an ITLB=
 miss, ICache miss and other events.",
@@ -10,7 +9,6 @@
     },
     {
         "BriefDescription": "Cycles code-fetch stalled due to an outstandi=
ng ITLB miss.",
-        "Counter": "0,1",
         "EventCode": "0x86",
         "EventName": "FETCH_STALL.ITLB_FILL_PENDING_CYCLES",
         "PublicDescription": "Counts cycles that fetch is stalled due to a=
n outstanding ITLB miss. That is, the decoder queue is able to accept bytes=
, but the fetch unit is unable to provide bytes due to an ITLB miss.  Note:=
 this event is not the same as page walk cycles to retrieve an instruction =
translation.",
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/silvermont/pipeline.json
index e42a37eabc17..59f6116a7eae 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "Counts the number of branch instructions reti=
red...",
-        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
@@ -10,18 +9,15 @@
     },
     {
         "BriefDescription": "Counts the number of taken branch instruction=
s retired",
-        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ALL_TAKEN_BRANCHES",
         "PEBS": "2",
-        "PEBScounters": "0,1",
         "PublicDescription": "ALL_TAKEN_BRANCHES counts the number of all =
taken branch instructions retired.  Branch prediction predicts the branch t=
arget and enables the processor to begin executing instructions long before=
 the branch true execution path is known. All branches utilize the branch p=
rediction unit (BPU) for prediction. This unit predicts the target address =
not only based on the EIP of the branch but also based on the execution pat=
h through which execution reached this EIP. The BPU can efficiently predict=
 the following branch types: conditional branches, direct calls and jumps, =
indirect calls and jumps, returns.",
         "SampleAfterValue": "200003",
         "UMask": "0x80"
     },
     {
         "BriefDescription": "Counts the number of near CALL branch instruc=
tions retired",
-        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.CALL",
         "PEBS": "1",
@@ -31,7 +27,6 @@
     },
     {
         "BriefDescription": "Counts the number of far branch instructions =
retired",
-        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
         "PEBS": "1",
@@ -41,7 +36,6 @@
     },
     {
         "BriefDescription": "Counts the number of near indirect CALL branc=
h instructions retired",
-        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.IND_CALL",
         "PEBS": "1",
@@ -51,7 +45,6 @@
     },
     {
         "BriefDescription": "Counts the number of JCC branch instructions =
retired",
-        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.JCC",
         "PEBS": "1",
@@ -61,7 +54,6 @@
     },
     {
         "BriefDescription": "Counts the number of near indirect JMP and ne=
ar indirect CALL branch instructions retired",
-        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NON_RETURN_IND",
         "PEBS": "1",
@@ -71,7 +63,6 @@
     },
     {
         "BriefDescription": "Counts the number of near relative CALL branc=
h instructions retired",
-        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.REL_CALL",
         "PEBS": "1",
@@ -81,7 +72,6 @@
     },
     {
         "BriefDescription": "Counts the number of near RET branch instruct=
ions retired",
-        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.RETURN",
         "PEBS": "1",
@@ -91,7 +81,6 @@
     },
     {
         "BriefDescription": "Counts the number of taken JCC branch instruc=
tions retired",
-        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.TAKEN_JCC",
         "PEBS": "1",
@@ -101,7 +90,6 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted branch inst=
ructions retired",
-        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
@@ -110,7 +98,6 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted near indire=
ct CALL branch instructions retired",
-        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.IND_CALL",
         "PEBS": "1",
@@ -120,7 +107,6 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted JCC branch =
instructions retired",
-        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.JCC",
         "PEBS": "1",
@@ -130,7 +116,6 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted near indire=
ct JMP and near indirect CALL branch instructions retired",
-        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.NON_RETURN_IND",
         "PEBS": "1",
@@ -140,7 +125,6 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted near RET br=
anch instructions retired",
-        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.RETURN",
         "PEBS": "1",
@@ -150,7 +134,6 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted taken JCC b=
ranch instructions retired",
-        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.TAKEN_JCC",
         "PEBS": "1",
@@ -160,7 +143,6 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles",
-        "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.CORE",
         "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state. The core enters the halt state when it is runni=
ng the HLT instruction. This event is a component in many key event ratios.=
  The core frequency may change from time to time. For this reason this eve=
nt may have a changing ratio with regards to time. In systems with a consta=
nt core frequency, this event can give you a measurement of the elapsed tim=
e while the core was not in halt state by dividing the event count by the c=
ore frequency. This event is architecturally defined and is a designated fi=
xed counter.  CPU_CLK_UNHALTED.CORE and CPU_CLK_UNHALTED.CORE_P use the cor=
e frequency which may change from time to time.  CPU_CLK_UNHALTE.REF_TSC an=
d CPU_CLK_UNHALTED.REF are not affected by core frequency changes but count=
s as if the core is running at the maximum frequency all the time.  The fix=
ed events are CPU_CLK_UNHALTED.CORE and CPU_CLK_UNHALTED.REF_TSC and the pr=
ogrammable events are CPU_CLK_UNHALTED.CORE_P and CPU_CLK_UNHALTED.REF.",
         "SampleAfterValue": "2000003",
@@ -168,7 +150,6 @@
     },
     {
         "BriefDescription": "Core cycles when core is not halted",
-        "Counter": "0,1",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.CORE_P",
         "PublicDescription": "This event counts the number of core cycles =
while the core is not in a halt state. The core enters the halt state when =
it is running the HLT instruction. In mobile systems the core frequency may=
 change from time to time. For this reason this event may have a changing r=
atio with regards to time.",
@@ -176,7 +157,6 @@
     },
     {
         "BriefDescription": "Reference cycles when core is not halted",
-        "Counter": "0,1",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.REF",
         "PublicDescription": "This event counts the number of reference cy=
cles that the core is not in a halt state. The core enters the halt state w=
hen it is running the HLT instruction. In mobile systems the core frequency=
 may change from time. This event is not affected by core frequency changes=
 but counts as if the core is running at the maximum frequency all the time=
.",
@@ -185,7 +165,6 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted =
reference clock cycles",
-        "Counter": "Fixed counter 3",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "Counts the number of reference cycles while =
the core is not in a halt state. The core enters the halt state when it is =
running the HLT instruction. This event is a component in many key event ra=
tios.  The core frequency may change from time. This event is not affected =
by core frequency changes but counts as if the core is running at the maxim=
um frequency all the time.  Divide this event count by core frequency to de=
termine the elapsed time while the core was not in halt state.  Divide this=
 event count by core frequency to determine the elapsed time while the core=
 was not in halt state.  This event is architecturally defined and is a des=
ignated fixed counter.  CPU_CLK_UNHALTED.CORE and CPU_CLK_UNHALTED.CORE_P u=
se the core frequency which may change from time to time.  CPU_CLK_UNHALTE.=
REF_TSC and CPU_CLK_UNHALTED.REF are not affected by core frequency changes=
 but counts as if the core is running at the maximum frequency all the time=
.  The fixed events are CPU_CLK_UNHALTED.CORE and CPU_CLK_UNHALTED.REF_TSC =
and the programmable events are CPU_CLK_UNHALTED.CORE_P and CPU_CLK_UNHALTE=
D.REF.",
         "SampleAfterValue": "2000003",
@@ -193,7 +172,6 @@
     },
     {
         "BriefDescription": "Cycles the divider is busy.  Does not imply a=
 stall waiting for the divider.",
-        "Counter": "0,1",
         "EventCode": "0xCD",
         "EventName": "CYCLES_DIV_BUSY.ALL",
         "PublicDescription": "Cycles the divider is busy.This event counts=
 the cycles when the divide unit is unable to accept a new divide UOP becau=
se it is busy processing a previously dispatched UOP. The cycles will be co=
unted irrespective of whether or not another divide UOP is waiting to enter=
 the divide unit (from the RS). This event might count cycles while a divid=
e is in progress even if the RS is empty.  The divide instruction is one of=
 the longest latency instructions in the machine.  Hence, it has a special =
event associated with it to help determine if divides are delaying the reti=
rement of instructions.",
@@ -202,7 +180,6 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of instructi=
ons retired",
-        "Counter": "Fixed counter 1",
         "EventName": "INST_RETIRED.ANY",
         "PublicDescription": "This event counts the number of instructions=
 that retire.  For instructions that consist of multiple micro-ops, this ev=
ent counts exactly once, as the last micro-op of the instruction retires.  =
The event continues counting while instructions retire, including during in=
terrupt service routines caused by hardware interrupts, faults or traps.  B=
ackground: Modern microprocessors employ extensive pipelining and speculati=
ve techniques.  Since sometimes an instruction is started but never complet=
ed, the notion of \"retirement\" is introduced.  A retired instruction is o=
ne that commits its states. Or stated differently, an instruction might be =
abandoned at some point. No instruction is truly finished until it retires.=
  This counter measures the number of completed instructions.  The fixed ev=
ent is INST_RETIRED.ANY and the programmable event is INST_RETIRED.ANY_P.",
         "SampleAfterValue": "2000003",
@@ -210,7 +187,6 @@
     },
     {
         "BriefDescription": "Instructions retired",
-        "Counter": "0,1",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.ANY_P",
         "PublicDescription": "This event counts the number of instructions=
 that retire execution. For instructions that consist of multiple micro-ops=
, this event counts the retirement of the last micro-op of the instruction.=
 The counter continues counting during hardware interrupts, traps, and insi=
de interrupt handlers.",
@@ -218,7 +194,6 @@
     },
     {
         "BriefDescription": "Counts all machine clears",
-        "Counter": "0,1",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.ALL",
         "PublicDescription": "Machine clears happen when something happens=
 in the machine that causes the hardware to need to take special care to ge=
t the right answer. When such a condition is signaled on an instruction, th=
e front end of the machine is notified that it must restart, so no more ins=
tructions will be decoded from the current path.  All instructions \"older\=
" than this one will be allowed to finish.  This instruction and all \"youn=
ger\" instructions must be cleared, since they must not be allowed to compl=
ete.  Essentially, the hardware waits until the problematic instruction is =
the oldest instruction in the machine.  This means all older instructions a=
re retired, and all pending stores (from older instructions) are completed.=
  Then the new path of instructions from the front end are allowed to start=
 into the machine.  There are many conditions that might cause a machine cl=
ear (including the receipt of an interrupt, or a trap or a fault).  All tho=
se conditions (including but not limited to MACHINE_CLEARS.MEMORY_ORDERING,=
 MACHINE_CLEARS.SMC, and MACHINE_CLEARS.FP_ASSIST) are captured in the ANY =
event. In addition, some conditions can be specifically counted (i.e. SMC, =
MEMORY_ORDERING, FP_ASSIST).  However, the sum of SMC, MEMORY_ORDERING, and=
 FP_ASSIST machine clears will not necessarily equal the number of ANY.",
@@ -227,7 +202,6 @@
     },
     {
         "BriefDescription": "Self-Modifying Code detected",
-        "Counter": "0,1",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.SMC",
         "PublicDescription": "This event counts the number of times that a=
 program writes to a code section. Self-modifying code causes a severe pena=
lty in all Intel? architecture processors.",
@@ -236,7 +210,6 @@
     },
     {
         "BriefDescription": "Counts the number of cycles when no uops are =
allocated for any reason.",
-        "Counter": "0,1",
         "EventCode": "0xCA",
         "EventName": "NO_ALLOC_CYCLES.ALL",
         "PublicDescription": "The NO_ALLOC_CYCLES.ALL event counts the num=
ber of cycles when the front-end does not provide any instructions to be al=
located for any reason. This event indicates the cycles where an allocation=
 stalls occurs, and no UOPS are allocated in that cycle.",
@@ -245,7 +218,6 @@
     },
     {
         "BriefDescription": "Counts the number of cycles when no uops are =
allocated and the alloc pipe is stalled waiting for a mispredicted jump to =
retire.  After the misprediction is detected, the front end will start imme=
diately but the allocate pipe stalls until the mispredicted",
-        "Counter": "0,1",
         "EventCode": "0xCA",
         "EventName": "NO_ALLOC_CYCLES.MISPREDICTS",
         "PublicDescription": "Counts the number of cycles when no uops are=
 allocated and the alloc pipe is stalled waiting for a mispredicted jump to=
 retire.  After the misprediction is detected, the front end will start imm=
ediately but the allocate pipe stalls until the mispredicted.",
@@ -254,7 +226,6 @@
     },
     {
         "BriefDescription": "Counts the number of cycles when no uops are =
allocated, the IQ is empty, and no other condition is blocking allocation."=
,
-        "Counter": "0,1",
         "EventCode": "0xCA",
         "EventName": "NO_ALLOC_CYCLES.NOT_DELIVERED",
         "PublicDescription": "The NO_ALLOC_CYCLES.NOT_DELIVERED event is u=
sed to measure front-end inefficiencies, i.e. when front-end of the machine=
 is not delivering micro-ops to the back-end and the back-end is not stalle=
d. This event can be used to identify if the machine is truly front-end bou=
nd.  When this event occurs, it is an indication that the front-end of the =
machine is operating at less than its theoretical peak performance.  Backgr=
ound: We can think of the processor pipeline as being divided into 2 broade=
r parts: Front-end and Back-end. Front-end is responsible for fetching the =
instruction, decoding into micro-ops (uops) in machine understandable forma=
t and putting them into a micro-op queue to be consumed by back end. The ba=
ck-end then takes these micro-ops, allocates the required resources.  When =
all resources are ready, micro-ops are executed. If the back-end is not rea=
dy to accept micro-ops from the front-end, then we do not want to count the=
se as front-end bottlenecks.  However, whenever we have bottlenecks in the =
back-end, we will have allocation unit stalls and eventually forcing the fr=
ont-end to wait until the back-end is ready to receive more UOPS. This even=
t counts the cycles only when back-end is requesting more uops and front-en=
d is not able to provide them. Some examples of conditions that cause front=
-end efficiencies are: Icache misses, ITLB misses, and decoder restrictions=
 that limit the the front-end bandwidth.",
@@ -263,7 +234,6 @@
     },
     {
         "BriefDescription": "Counts the number of cycles when no uops are =
allocated and a RATstall is asserted.",
-        "Counter": "0,1",
         "EventCode": "0xCA",
         "EventName": "NO_ALLOC_CYCLES.RAT_STALL",
         "SampleAfterValue": "200003",
@@ -271,7 +241,6 @@
     },
     {
         "BriefDescription": "Counts the number of cycles when no uops are =
allocated and the ROB is full (less than 2 entries available)",
-        "Counter": "0,1",
         "EventCode": "0xCA",
         "EventName": "NO_ALLOC_CYCLES.ROB_FULL",
         "PublicDescription": "Counts the number of cycles when no uops are=
 allocated and the ROB is full (less than 2 entries available).",
@@ -280,7 +249,6 @@
     },
     {
         "BriefDescription": "Counts the number of cycles the Alloc pipelin=
e is stalled when any one of the RSs (IEC, FPC and MEC) is full. This event=
 is a superset of all the individual RS stall event counts.",
-        "Counter": "0,1",
         "EventCode": "0xCB",
         "EventName": "RS_FULL_STALL.ALL",
         "SampleAfterValue": "200003",
@@ -288,7 +256,6 @@
     },
     {
         "BriefDescription": "Counts the number of cycles and allocation pi=
peline is stalled and is waiting for a free MEC reservation station entry. =
 The cycles should be appropriately counted in case of the cracked ops e.g.=
 In case of a cracked load-op, the load portion is sent to M",
-        "Counter": "0,1",
         "EventCode": "0xCB",
         "EventName": "RS_FULL_STALL.MEC",
         "PublicDescription": "Counts the number of cycles and allocation p=
ipeline is stalled and is waiting for a free MEC reservation station entry.=
  The cycles should be appropriately counted in case of the cracked ops e.g=
. In case of a cracked load-op, the load portion is sent to M.",
@@ -297,7 +264,6 @@
     },
     {
         "BriefDescription": "Micro-ops retired",
-        "Counter": "0,1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.ALL",
         "PublicDescription": "This event counts the number of micro-ops re=
tired. The processor decodes complex macro instructions into a sequence of =
simpler micro-ops. Most instructions are composed of one or two micro-ops. =
Some instructions are decoded into longer sequences such as repeat instruct=
ions, floating point transcendental instructions, and assists. In some case=
s micro-op sequences are fused or whole instructions are fused into one mic=
ro-op. See other UOPS_RETIRED events for differentiating retired fused and =
non-fused micro-ops.",
@@ -306,7 +272,6 @@
     },
     {
         "BriefDescription": "MSROM micro-ops retired",
-        "Counter": "0,1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.MS",
         "PublicDescription": "This event counts the number of micro-ops re=
tired that were supplied from MSROM.",
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json =
b/tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json
index b50cee3a5e4c..1be3fa5c4ad3 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "Loads missed DTLB",
-        "Counter": "0,1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS_LOADS",
         "PEBS": "1",
@@ -11,7 +10,6 @@
     },
     {
         "BriefDescription": "Total cycles for all the page walks. (I-side =
and D-side)",
-        "Counter": "0,1",
         "EventCode": "0x05",
         "EventName": "PAGE_WALKS.CYCLES",
         "PublicDescription": "This event counts every cycle when a data (D=
) page walk or instruction (I) page walk is in progress.  Since a pagewalk =
implies a TLB miss, the approximate cost of a TLB miss can be determined fr=
om this event.",
@@ -20,7 +18,6 @@
     },
     {
         "BriefDescription": "Duration of D-side page-walks in core cycles"=
,
-        "Counter": "0,1",
         "EventCode": "0x05",
         "EventName": "PAGE_WALKS.D_SIDE_CYCLES",
         "PublicDescription": "This event counts every cycle when a D-side =
(walks due to a load) page walk is in progress. Page walk duration divided =
by number of page walks is the average duration of page-walks.",
@@ -29,7 +26,6 @@
     },
     {
         "BriefDescription": "D-side page-walks",
-        "Counter": "0,1",
         "EdgeDetect": "1",
         "EventCode": "0x05",
         "EventName": "PAGE_WALKS.D_SIDE_WALKS",
@@ -39,7 +35,6 @@
     },
     {
         "BriefDescription": "Duration of I-side page-walks in core cycles"=
,
-        "Counter": "0,1",
         "EventCode": "0x05",
         "EventName": "PAGE_WALKS.I_SIDE_CYCLES",
         "PublicDescription": "This event counts every cycle when a I-side =
(walks due to an instruction fetch) page walk is in progress. Page walk dur=
ation divided by number of page walks is the average duration of page-walks=
.",
@@ -48,7 +43,6 @@
     },
     {
         "BriefDescription": "I-side page-walks",
-        "Counter": "0,1",
         "EdgeDetect": "1",
         "EventCode": "0x05",
         "EventName": "PAGE_WALKS.I_SIDE_WALKS",
@@ -58,7 +52,6 @@
     },
     {
         "BriefDescription": "Total page walks that are completed (I-side a=
nd D-side)",
-        "Counter": "0,1",
         "EdgeDetect": "1",
         "EventCode": "0x05",
         "EventName": "PAGE_WALKS.WALKS",
--=20
2.39.0.314.g84b9a713c41-goog

