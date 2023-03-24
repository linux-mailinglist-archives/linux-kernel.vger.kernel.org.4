Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666096C78B7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjCXHWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjCXHWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:22:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155145FD9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:22:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z4-20020a25bb04000000b00b392ae70300so1058848ybg.21
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679642563;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvDr5CEJpQ99Dan5HvL5Ea44JGN1C0/OsUkKnt1/keo=;
        b=DsAW3oDnKZ+CFl6aO2JnqUBPCB+WkGsES+psNvUn+2/uKqMNF36yI8rukfcL+cI0j9
         zYk8BvadL+wsBCR0dUartiiRI73wwk/HpcRRecGdzOKmjLS39NWf8sqZFP7iyO3SZKzH
         C6zhMFc88zyC7RrWBHNfoWuzkWCQYTCSTKDfKSNuhD6Bhnpp5mKWjqKksvLsvqCfUXwE
         KCiHT3GaieoTpPwbihyA9t0thy0YMUPZwEVvA7gjBo+fkAnVYIBpzvf8c+EML1EJyOI+
         zGqaPsiwiOK/GCaf6HfKc95BF1RJJnCgG/IA5znsmdQSHpquHAF760gBV7RFN7wHY0b2
         c6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679642563;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nvDr5CEJpQ99Dan5HvL5Ea44JGN1C0/OsUkKnt1/keo=;
        b=U8uPnkTRP5hdK/SE7ETrSnq488rU/Rake9VMet+RbWGyKA3NbDAVTYBRFlek7iyVYQ
         OVJwUOFLDjFFdxGdvSbvug/z17KoUwLIJ9Z1frNe8Uv7NmN2rLflMO1TepIKerF0EtlJ
         rhlQgpVH8DR9VUorWsgzamq/u7ueehNc1mkQL/v8IlFP56OS0Mx0Dfq9yeJwopiH87R6
         79Ll4IYhwZgmWAh+bFic1+sRtRqHv7Wt8RiWskIL8+6b6PeKHE18g4rCOjZGs9ufO5HC
         GwBqhAv9OG3VPlDTa1NBHuGnWPlBzTzggBkCcH2Fu1oeURqDDXAjSudsYSq3nIaI4pp6
         8h7Q==
X-Gm-Message-State: AAQBX9eMAd/H01sYftYVvJLteih3Z74JD2RGhpKPBnag2haRwkZ0Gnym
        kK/XcsFw7SPKvUGXlfduhMuSnK3BcRhP
X-Google-Smtp-Source: AKy350ZYJ7euO8qgtxgyOrpDiC/huG/3yO24nRfkON4RWwj6tXgIT8WGC+fq6QrW9OL0I4UbLp9zDfNEkPES
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e705:3a3d:46e5:fb50])
 (user=irogers job=sendgmr) by 2002:a05:6902:18c9:b0:b75:760a:964e with SMTP
 id ck9-20020a05690218c900b00b75760a964emr598241ybb.13.1679642563304; Fri, 24
 Mar 2023 00:22:43 -0700 (PDT)
Date:   Fri, 24 Mar 2023 00:22:10 -0700
In-Reply-To: <20230324072218.181880-1-irogers@google.com>
Message-Id: <20230324072218.181880-2-irogers@google.com>
Mime-Version: 1.0
References: <20230324072218.181880-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v3 1/9] perf vendor events: Broadwell v27 events
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

Description updates and formatting changes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/broadwell/cache.json  | 296 +++++++++---------
 .../arch/x86/broadwell/floating-point.json    |   7 +
 .../arch/x86/broadwell/frontend.json          |  18 +-
 .../pmu-events/arch/x86/broadwell/memory.json | 248 +++++++--------
 .../arch/x86/broadwell/pipeline.json          |  22 +-
 .../arch/x86/broadwell/uncore-other.json      |   2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 7 files changed, 305 insertions(+), 290 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwell/cache.json b/tools/pe=
rf/pmu-events/arch/x86/broadwell/cache.json
index 26199d3ebb25..f8ee5aefccea 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/cache.json
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
@@ -424,22 +424,22 @@
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
@@ -511,10 +511,10 @@
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
@@ -629,7 +629,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0000010091",
+        "MSRValue": "0x10091",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -656,7 +656,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD=
",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C0091",
+        "MSRValue": "0x4003C0091",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -665,7 +665,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x02003C0091",
+        "MSRValue": "0x2003C0091",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -674,7 +674,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00803C0091",
+        "MSRValue": "0x803C0091",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -683,7 +683,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_HIT.SNOOP_NOT_NEEDED=
",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x01003C0091",
+        "MSRValue": "0x1003C0091",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -710,7 +710,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.SUPPLIER_NONE.SNOOP_HIT=
_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0400020091",
+        "MSRValue": "0x400020091",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -719,7 +719,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.SUPPLIER_NONE.SNOOP_MIS=
S",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0200020091",
+        "MSRValue": "0x200020091",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -728,7 +728,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.SUPPLIER_NONE.SNOOP_NON=
E",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0080020091",
+        "MSRValue": "0x80020091",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -737,7 +737,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.SUPPLIER_NONE.SNOOP_NOT=
_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0100020091",
+        "MSRValue": "0x100020091",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -746,7 +746,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0000010240",
+        "MSRValue": "0x10240",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -773,7 +773,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_HIT.SNOOP_HIT_NO_=
FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C0240",
+        "MSRValue": "0x4003C0240",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -782,7 +782,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x02003C0240",
+        "MSRValue": "0x2003C0240",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -791,7 +791,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00803C0240",
+        "MSRValue": "0x803C0240",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -800,7 +800,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_HIT.SNOOP_NOT_NEE=
DED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x01003C0240",
+        "MSRValue": "0x1003C0240",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -827,7 +827,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.SUPPLIER_NONE.SNOOP_=
HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0400020240",
+        "MSRValue": "0x400020240",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -836,7 +836,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.SUPPLIER_NONE.SNOOP_=
MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0200020240",
+        "MSRValue": "0x200020240",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -845,7 +845,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.SUPPLIER_NONE.SNOOP_=
NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0080020240",
+        "MSRValue": "0x80020240",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -854,7 +854,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.SUPPLIER_NONE.SNOOP_=
NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0100020240",
+        "MSRValue": "0x100020240",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -863,7 +863,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0000010090",
+        "MSRValue": "0x10090",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -890,7 +890,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_HIT.SNOOP_HIT_NO_=
FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C0090",
+        "MSRValue": "0x4003C0090",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -899,7 +899,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x02003C0090",
+        "MSRValue": "0x2003C0090",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -908,7 +908,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00803C0090",
+        "MSRValue": "0x803C0090",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -917,7 +917,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_HIT.SNOOP_NOT_NEE=
DED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x01003C0090",
+        "MSRValue": "0x1003C0090",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -944,7 +944,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.SUPPLIER_NONE.SNOOP_=
HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0400020090",
+        "MSRValue": "0x400020090",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -953,7 +953,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.SUPPLIER_NONE.SNOOP_=
MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0200020090",
+        "MSRValue": "0x200020090",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -962,7 +962,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.SUPPLIER_NONE.SNOOP_=
NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0080020090",
+        "MSRValue": "0x80020090",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -971,7 +971,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.SUPPLIER_NONE.SNOOP_=
NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0100020090",
+        "MSRValue": "0x100020090",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -980,7 +980,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0000010120",
+        "MSRValue": "0x10120",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1007,7 +1007,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_HIT.SNOOP_HIT_NO_FWD"=
,
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C0120",
+        "MSRValue": "0x4003C0120",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1016,7 +1016,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x02003C0120",
+        "MSRValue": "0x2003C0120",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1025,7 +1025,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00803C0120",
+        "MSRValue": "0x803C0120",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1034,7 +1034,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_HIT.SNOOP_NOT_NEEDED"=
,
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x01003C0120",
+        "MSRValue": "0x1003C0120",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1061,7 +1061,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.SUPPLIER_NONE.SNOOP_HIT_=
NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0400020120",
+        "MSRValue": "0x400020120",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1070,7 +1070,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.SUPPLIER_NONE.SNOOP_MISS=
",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0200020120",
+        "MSRValue": "0x200020120",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1079,7 +1079,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.SUPPLIER_NONE.SNOOP_NONE=
",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0080020120",
+        "MSRValue": "0x80020120",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1088,7 +1088,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.SUPPLIER_NONE.SNOOP_NOT_=
NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0100020120",
+        "MSRValue": "0x100020120",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1097,7 +1097,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0000010122",
+        "MSRValue": "0x10122",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1124,7 +1124,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C0122",
+        "MSRValue": "0x4003C0122",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1133,7 +1133,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x02003C0122",
+        "MSRValue": "0x2003C0122",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1142,7 +1142,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00803C0122",
+        "MSRValue": "0x803C0122",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1151,7 +1151,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x01003C0122",
+        "MSRValue": "0x1003C0122",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1178,7 +1178,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.SUPPLIER_NONE.SNOOP_HIT_NO_=
FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0400020122",
+        "MSRValue": "0x400020122",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1187,7 +1187,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.SUPPLIER_NONE.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0200020122",
+        "MSRValue": "0x200020122",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1196,7 +1196,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.SUPPLIER_NONE.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0080020122",
+        "MSRValue": "0x80020122",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1205,7 +1205,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.SUPPLIER_NONE.SNOOP_NOT_NEE=
DED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0100020122",
+        "MSRValue": "0x100020122",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1214,7 +1214,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0000010008",
+        "MSRValue": "0x10008",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1241,7 +1241,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C0008",
+        "MSRValue": "0x4003C0008",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1250,7 +1250,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x02003C0008",
+        "MSRValue": "0x2003C0008",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1259,7 +1259,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00803C0008",
+        "MSRValue": "0x803C0008",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1268,7 +1268,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x01003C0008",
+        "MSRValue": "0x1003C0008",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1295,7 +1295,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.SUPPLIER_NONE.SNOOP_HIT_NO_F=
WD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0400020008",
+        "MSRValue": "0x400020008",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1304,7 +1304,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.SUPPLIER_NONE.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0200020008",
+        "MSRValue": "0x200020008",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1313,7 +1313,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.SUPPLIER_NONE.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0080020008",
+        "MSRValue": "0x80020008",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1322,7 +1322,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.SUPPLIER_NONE.SNOOP_NOT_NEED=
ED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0100020008",
+        "MSRValue": "0x100020008",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1331,7 +1331,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0000010004",
+        "MSRValue": "0x10004",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1358,7 +1358,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_NO_=
FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C0004",
+        "MSRValue": "0x4003C0004",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1367,7 +1367,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x02003C0004",
+        "MSRValue": "0x2003C0004",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1376,7 +1376,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00803C0004",
+        "MSRValue": "0x803C0004",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1385,7 +1385,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SNOOP_NOT_NEE=
DED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x01003C0004",
+        "MSRValue": "0x1003C0004",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1412,7 +1412,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SNOOP_=
HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0400020004",
+        "MSRValue": "0x400020004",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1421,7 +1421,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SNOOP_=
MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0200020004",
+        "MSRValue": "0x200020004",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1430,7 +1430,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SNOOP_=
NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0080020004",
+        "MSRValue": "0x80020004",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1439,7 +1439,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SNOOP_=
NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0100020004",
+        "MSRValue": "0x100020004",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1448,7 +1448,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0000010001",
+        "MSRValue": "0x10001",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1475,7 +1475,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_=
FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C0001",
+        "MSRValue": "0x4003C0001",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1484,7 +1484,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x02003C0001",
+        "MSRValue": "0x2003C0001",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1493,7 +1493,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00803C0001",
+        "MSRValue": "0x803C0001",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1502,7 +1502,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_NOT_NEE=
DED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x01003C0001",
+        "MSRValue": "0x1003C0001",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1529,7 +1529,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0400020001",
+        "MSRValue": "0x400020001",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1538,7 +1538,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0200020001",
+        "MSRValue": "0x200020001",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1547,7 +1547,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0080020001",
+        "MSRValue": "0x80020001",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1556,7 +1556,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0100020001",
+        "MSRValue": "0x100020001",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1565,7 +1565,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0000010002",
+        "MSRValue": "0x10002",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1592,7 +1592,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_HIT_NO_FWD"=
,
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C0002",
+        "MSRValue": "0x4003C0002",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1601,7 +1601,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x02003C0002",
+        "MSRValue": "0x2003C0002",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1610,7 +1610,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00803C0002",
+        "MSRValue": "0x803C0002",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1619,7 +1619,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_NOT_NEEDED"=
,
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x01003C0002",
+        "MSRValue": "0x1003C0002",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1628,7 +1628,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0000018000",
+        "MSRValue": "0x18000",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1655,7 +1655,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C8000",
+        "MSRValue": "0x4003C8000",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1664,7 +1664,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x02003C8000",
+        "MSRValue": "0x2003C8000",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1673,7 +1673,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00803C8000",
+        "MSRValue": "0x803C8000",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1682,7 +1682,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x01003C8000",
+        "MSRValue": "0x1003C8000",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1709,7 +1709,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SNOOP_HIT_NO_FW=
D",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0400028000",
+        "MSRValue": "0x400028000",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1718,7 +1718,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0200028000",
+        "MSRValue": "0x200028000",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1727,7 +1727,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0080028000",
+        "MSRValue": "0x80028000",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1736,7 +1736,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SNOOP_NOT_NEEDE=
D",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0100028000",
+        "MSRValue": "0x100028000",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1745,7 +1745,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0000010040",
+        "MSRValue": "0x10040",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1772,7 +1772,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_HIT.SNOOP_HIT_NO_F=
WD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C0040",
+        "MSRValue": "0x4003C0040",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1781,7 +1781,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x02003C0040",
+        "MSRValue": "0x2003C0040",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1790,7 +1790,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00803C0040",
+        "MSRValue": "0x803C0040",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1799,7 +1799,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_HIT.SNOOP_NOT_NEED=
ED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x01003C0040",
+        "MSRValue": "0x1003C0040",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1826,7 +1826,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.SUPPLIER_NONE.SNOOP_H=
IT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0400020040",
+        "MSRValue": "0x400020040",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1835,7 +1835,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.SUPPLIER_NONE.SNOOP_M=
ISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0200020040",
+        "MSRValue": "0x200020040",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1844,7 +1844,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.SUPPLIER_NONE.SNOOP_N=
ONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0080020040",
+        "MSRValue": "0x80020040",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1853,7 +1853,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.SUPPLIER_NONE.SNOOP_N=
OT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0100020040",
+        "MSRValue": "0x100020040",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1862,7 +1862,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0000010010",
+        "MSRValue": "0x10010",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1889,7 +1889,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_HIT.SNOOP_HIT_NO_F=
WD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C0010",
+        "MSRValue": "0x4003C0010",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1898,7 +1898,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x02003C0010",
+        "MSRValue": "0x2003C0010",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1907,7 +1907,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00803C0010",
+        "MSRValue": "0x803C0010",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1916,7 +1916,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_HIT.SNOOP_NOT_NEED=
ED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x01003C0010",
+        "MSRValue": "0x1003C0010",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1943,7 +1943,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.SUPPLIER_NONE.SNOOP_H=
IT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0400020010",
+        "MSRValue": "0x400020010",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1952,7 +1952,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.SUPPLIER_NONE.SNOOP_M=
ISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0200020010",
+        "MSRValue": "0x200020010",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1961,7 +1961,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.SUPPLIER_NONE.SNOOP_N=
ONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0080020010",
+        "MSRValue": "0x80020010",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1970,7 +1970,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.SUPPLIER_NONE.SNOOP_N=
OT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0100020010",
+        "MSRValue": "0x100020010",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1979,7 +1979,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0000010020",
+        "MSRValue": "0x10020",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2006,7 +2006,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C0020",
+        "MSRValue": "0x4003C0020",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2015,7 +2015,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x02003C0020",
+        "MSRValue": "0x2003C0020",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2024,7 +2024,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00803C0020",
+        "MSRValue": "0x803C0020",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2033,7 +2033,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x01003C0020",
+        "MSRValue": "0x1003C0020",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2060,7 +2060,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.SUPPLIER_NONE.SNOOP_HIT_N=
O_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0400020020",
+        "MSRValue": "0x400020020",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2069,7 +2069,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.SUPPLIER_NONE.SNOOP_MISS"=
,
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0200020020",
+        "MSRValue": "0x200020020",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2078,7 +2078,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.SUPPLIER_NONE.SNOOP_NONE"=
,
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0080020020",
+        "MSRValue": "0x80020020",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2087,7 +2087,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.SUPPLIER_NONE.SNOOP_NOT_N=
EEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0100020020",
+        "MSRValue": "0x100020020",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2096,7 +2096,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0000010200",
+        "MSRValue": "0x10200",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2123,7 +2123,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_HIT.SNOOP_HIT_NO_F=
WD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C0200",
+        "MSRValue": "0x4003C0200",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2132,7 +2132,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x02003C0200",
+        "MSRValue": "0x2003C0200",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2141,7 +2141,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00803C0200",
+        "MSRValue": "0x803C0200",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2150,7 +2150,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_HIT.SNOOP_NOT_NEED=
ED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x01003C0200",
+        "MSRValue": "0x1003C0200",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2177,7 +2177,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.SUPPLIER_NONE.SNOOP_H=
IT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0400020200",
+        "MSRValue": "0x400020200",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2186,7 +2186,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.SUPPLIER_NONE.SNOOP_M=
ISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0200020200",
+        "MSRValue": "0x200020200",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2195,7 +2195,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.SUPPLIER_NONE.SNOOP_N=
ONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0080020200",
+        "MSRValue": "0x80020200",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2204,7 +2204,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.SUPPLIER_NONE.SNOOP_N=
OT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0100020200",
+        "MSRValue": "0x100020200",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2213,7 +2213,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0000010080",
+        "MSRValue": "0x10080",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2240,7 +2240,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_HIT.SNOOP_HIT_NO_F=
WD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C0080",
+        "MSRValue": "0x4003C0080",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2249,7 +2249,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x02003C0080",
+        "MSRValue": "0x2003C0080",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2258,7 +2258,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00803C0080",
+        "MSRValue": "0x803C0080",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2267,7 +2267,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_HIT.SNOOP_NOT_NEED=
ED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x01003C0080",
+        "MSRValue": "0x1003C0080",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2294,7 +2294,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.SUPPLIER_NONE.SNOOP_H=
IT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0400020080",
+        "MSRValue": "0x400020080",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2303,7 +2303,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.SUPPLIER_NONE.SNOOP_M=
ISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0200020080",
+        "MSRValue": "0x200020080",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2312,7 +2312,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.SUPPLIER_NONE.SNOOP_N=
ONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0080020080",
+        "MSRValue": "0x80020080",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2321,7 +2321,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.SUPPLIER_NONE.SNOOP_N=
OT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0100020080",
+        "MSRValue": "0x100020080",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2330,7 +2330,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0000010100",
+        "MSRValue": "0x10100",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2357,7 +2357,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C0100",
+        "MSRValue": "0x4003C0100",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2366,7 +2366,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x02003C0100",
+        "MSRValue": "0x2003C0100",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2375,7 +2375,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_HIT.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00803C0100",
+        "MSRValue": "0x803C0100",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2384,7 +2384,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x01003C0100",
+        "MSRValue": "0x1003C0100",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2411,7 +2411,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.SUPPLIER_NONE.SNOOP_HIT_N=
O_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0400020100",
+        "MSRValue": "0x400020100",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2420,7 +2420,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.SUPPLIER_NONE.SNOOP_MISS"=
,
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0200020100",
+        "MSRValue": "0x200020100",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2429,7 +2429,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.SUPPLIER_NONE.SNOOP_NONE"=
,
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0080020100",
+        "MSRValue": "0x80020100",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2438,7 +2438,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.SUPPLIER_NONE.SNOOP_NOT_N=
EEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0100020100",
+        "MSRValue": "0x100020100",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/floating-point.json b=
/tools/perf/pmu-events/arch/x86/broadwell/floating-point.json
index 0de16d9a80da..e4826dc7f797 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/floating-point.json
@@ -3,6 +3,7 @@
         "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d double precision floating-point instructions retired; some instructions w=
ill count twice as noted below.  Each count represents 2 computation operat=
ions, one for each element.  Applies to SSE* and AVX* packed double precisi=
on floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQ=
RT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they=
 perform 2 calculations per element.",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 2 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as the=
y perform 2 calculations per element. The DAZ and FTZ flags in the MXCSR re=
gister need to be set when using these events.",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
@@ -10,6 +11,7 @@
         "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d single precision floating-point instructions retired; some instructions w=
ill count twice as noted below.  Each count represents 4 computation operat=
ions, one for each element.  Applies to SSE* and AVX* packed single precisi=
on floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQ=
RT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twi=
ce as they perform 4 calculations per element.",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     },
@@ -17,6 +19,7 @@
         "BriefDescription": "Number of SSE/AVX computational 256-bit packe=
d double precision floating-point instructions retired; some instructions w=
ill count twice as noted below.  Each count represents 4 computation operat=
ions, one for each element.  Applies to SSE* and AVX* packed double precisi=
on floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQ=
RT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perform 4 c=
alculations per element.",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perform 2 =
calculations per element. The DAZ and FTZ flags in the MXCSR register need =
to be set when using these events.",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
@@ -24,6 +27,7 @@
         "BriefDescription": "Number of SSE/AVX computational 256-bit packe=
d single precision floating-point instructions retired; some instructions w=
ill count twice as noted below.  Each count represents 8 computation operat=
ions, one for each element.  Applies to SSE* and AVX* packed single precisi=
on floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQ=
RT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twi=
ce as they perform 8 calculations per element.",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 8 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
         "SampleAfterValue": "2000003",
         "UMask": "0x20"
     },
@@ -45,6 +49,7 @@
         "BriefDescription": "Number of SSE/AVX computational scalar floati=
ng-point instructions retired; some instructions will count twice as noted =
below. Each count represents 1 computation operation.   Applies to SSE* and=
 AVX* scalar double and single precision floating-point instructions: ADD S=
UB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB. FM(N)ADD/SUB instructions c=
ount twice as they perform multiple calculations per element.",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR",
+        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision and double precision floating-point instructions retired; some =
instructions will count twice as noted below.  Each count represents 1 comp=
utational operation. Applies to SSE* and AVX* scalar single precision float=
ing-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB=
.  FM(N)ADD/SUB instructions count twice as they perform 2 calculations per=
 element. The DAZ and FTZ flags in the MXCSR register need to be set when u=
sing these events.",
         "SampleAfterValue": "2000003",
         "UMask": "0x3"
     },
@@ -52,6 +57,7 @@
         "BriefDescription": "Number of SSE/AVX computational scalar double=
 precision floating-point instructions retired; some instructions will coun=
t twice as noted below.  Each count represents 1 computational operation. A=
pplies to SSE* and AVX* scalar double precision floating-point instructions=
: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions cou=
nt twice as they perform multiple calculations per element.",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR_DOUBLE",
+        "PublicDescription": "Number of SSE/AVX computational scalar doubl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar double precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions co=
unt twice as they perform 2 calculations per element. The DAZ and FTZ flags=
 in the MXCSR register need to be set when using these events.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -59,6 +65,7 @@
         "BriefDescription": "Number of SSE/AVX computational scalar single=
 precision floating-point instructions retired; some instructions will coun=
t twice as noted below.  Each count represents 1 computational operation. A=
pplies to SSE* and AVX* scalar single precision floating-point instructions=
: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB instru=
ctions count twice as they perform multiple calculations per element.",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR_SINGLE",
+        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar single precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB instr=
uctions count twice as they perform 2 calculations per element. The DAZ and=
 FTZ flags in the MXCSR register need to be set when using these events.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/frontend.json b/tools=
/perf/pmu-events/arch/x86/broadwell/frontend.json
index d0f6678609ae..bd5da39564e1 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/frontend.json
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
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/memory.json b/tools/p=
erf/pmu-events/arch/x86/broadwell/memory.json
index 394ed602fcb1..ac7cdb831960 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/memory.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/memory.json
@@ -206,7 +206,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS.SNOOP_HIT_NO_FW=
D",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x043C000091",
+        "MSRValue": "0x43C000091",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -215,7 +215,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x023C000091",
+        "MSRValue": "0x23C000091",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -224,7 +224,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00BC000091",
+        "MSRValue": "0xBC000091",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -233,7 +233,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS.SNOOP_NOT_NEEDE=
D",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x013C000091",
+        "MSRValue": "0x13C000091",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -260,7 +260,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.SNOO=
P_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0404000091",
+        "MSRValue": "0x404000091",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -269,7 +269,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.SNOO=
P_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0204000091",
+        "MSRValue": "0x204000091",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -278,7 +278,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.SNOO=
P_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0084000091",
+        "MSRValue": "0x84000091",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -296,7 +296,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.SNOO=
P_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0104000091",
+        "MSRValue": "0x104000091",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -323,7 +323,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS.SNOOP_HIT_NO=
_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x043C000240",
+        "MSRValue": "0x43C000240",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -332,7 +332,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x023C000240",
+        "MSRValue": "0x23C000240",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -341,7 +341,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00BC000240",
+        "MSRValue": "0xBC000240",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -350,7 +350,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS.SNOOP_NOT_NE=
EDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x013C000240",
+        "MSRValue": "0x13C000240",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -377,7 +377,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0404000240",
+        "MSRValue": "0x404000240",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -386,7 +386,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0204000240",
+        "MSRValue": "0x204000240",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -395,7 +395,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0084000240",
+        "MSRValue": "0x84000240",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -413,7 +413,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0104000240",
+        "MSRValue": "0x104000240",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -440,7 +440,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS.SNOOP_HIT_NO=
_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x043C000090",
+        "MSRValue": "0x43C000090",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -449,7 +449,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x023C000090",
+        "MSRValue": "0x23C000090",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -458,7 +458,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00BC000090",
+        "MSRValue": "0xBC000090",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -467,7 +467,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS.SNOOP_NOT_NE=
EDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x013C000090",
+        "MSRValue": "0x13C000090",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -494,7 +494,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0404000090",
+        "MSRValue": "0x404000090",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -503,7 +503,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0204000090",
+        "MSRValue": "0x204000090",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -512,7 +512,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0084000090",
+        "MSRValue": "0x84000090",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -530,7 +530,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0104000090",
+        "MSRValue": "0x104000090",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -557,7 +557,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS.SNOOP_HIT_NO_FWD=
",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x043C000120",
+        "MSRValue": "0x43C000120",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -566,7 +566,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x023C000120",
+        "MSRValue": "0x23C000120",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -575,7 +575,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00BC000120",
+        "MSRValue": "0xBC000120",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -584,7 +584,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS.SNOOP_NOT_NEEDED=
",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x013C000120",
+        "MSRValue": "0x13C000120",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -611,7 +611,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.SNOOP=
_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0404000120",
+        "MSRValue": "0x404000120",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -620,7 +620,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.SNOOP=
_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0204000120",
+        "MSRValue": "0x204000120",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -629,7 +629,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.SNOOP=
_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0084000120",
+        "MSRValue": "0x84000120",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -647,7 +647,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.SNOOP=
_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0104000120",
+        "MSRValue": "0x104000120",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -674,7 +674,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x043C000122",
+        "MSRValue": "0x43C000122",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -683,7 +683,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x023C000122",
+        "MSRValue": "0x23C000122",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -692,7 +692,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00BC000122",
+        "MSRValue": "0xBC000122",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -701,7 +701,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x013C000122",
+        "MSRValue": "0x13C000122",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -728,7 +728,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS_LOCAL_DRAM.SNOOP_HI=
T_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0404000122",
+        "MSRValue": "0x404000122",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -737,7 +737,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS_LOCAL_DRAM.SNOOP_MI=
SS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0204000122",
+        "MSRValue": "0x204000122",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -746,7 +746,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS_LOCAL_DRAM.SNOOP_NO=
NE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0084000122",
+        "MSRValue": "0x84000122",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -764,7 +764,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS_LOCAL_DRAM.SNOOP_NO=
T_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0104000122",
+        "MSRValue": "0x104000122",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -791,7 +791,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x043C000008",
+        "MSRValue": "0x43C000008",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -800,7 +800,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x023C000008",
+        "MSRValue": "0x23C000008",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -809,7 +809,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00BC000008",
+        "MSRValue": "0xBC000008",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -818,7 +818,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x013C000008",
+        "MSRValue": "0x13C000008",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -845,7 +845,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS_LOCAL_DRAM.SNOOP_HIT=
_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0404000008",
+        "MSRValue": "0x404000008",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -854,7 +854,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS_LOCAL_DRAM.SNOOP_MIS=
S",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0204000008",
+        "MSRValue": "0x204000008",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -863,7 +863,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS_LOCAL_DRAM.SNOOP_NON=
E",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0084000008",
+        "MSRValue": "0x84000008",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -881,7 +881,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS_LOCAL_DRAM.SNOOP_NOT=
_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0104000008",
+        "MSRValue": "0x104000008",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -908,7 +908,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.SNOOP_HIT_NO=
_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x043C000004",
+        "MSRValue": "0x43C000004",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -917,7 +917,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x023C000004",
+        "MSRValue": "0x23C000004",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -926,7 +926,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00BC000004",
+        "MSRValue": "0xBC000004",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -935,7 +935,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.SNOOP_NOT_NE=
EDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x013C000004",
+        "MSRValue": "0x13C000004",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -962,7 +962,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0404000004",
+        "MSRValue": "0x404000004",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -971,7 +971,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0204000004",
+        "MSRValue": "0x204000004",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -980,7 +980,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0084000004",
+        "MSRValue": "0x84000004",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -998,7 +998,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0104000004",
+        "MSRValue": "0x104000004",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1025,7 +1025,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.SNOOP_HIT_NO=
_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x043C000001",
+        "MSRValue": "0x43C000001",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1034,7 +1034,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x023C000001",
+        "MSRValue": "0x23C000001",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1043,7 +1043,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00BC000001",
+        "MSRValue": "0xBC000001",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1052,7 +1052,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.SNOOP_NOT_NE=
EDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x013C000001",
+        "MSRValue": "0x13C000001",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1079,7 +1079,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0404000001",
+        "MSRValue": "0x404000001",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1088,7 +1088,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0204000001",
+        "MSRValue": "0x204000001",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1097,7 +1097,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0084000001",
+        "MSRValue": "0x84000001",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1115,7 +1115,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0104000001",
+        "MSRValue": "0x104000001",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1142,7 +1142,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.SNOOP_HIT_NO_FWD=
",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x043C000002",
+        "MSRValue": "0x43C000002",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1151,7 +1151,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x023C000002",
+        "MSRValue": "0x23C000002",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1160,7 +1160,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00BC000002",
+        "MSRValue": "0xBC000002",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1169,7 +1169,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.SNOOP_NOT_NEEDED=
",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x013C000002",
+        "MSRValue": "0x13C000002",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1196,7 +1196,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x043C008000",
+        "MSRValue": "0x43C008000",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1205,7 +1205,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x023C008000",
+        "MSRValue": "0x23C008000",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1214,7 +1214,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00BC008000",
+        "MSRValue": "0xBC008000",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1223,7 +1223,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x013C008000",
+        "MSRValue": "0x13C008000",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1250,7 +1250,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_HIT_=
NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0404008000",
+        "MSRValue": "0x404008000",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1259,7 +1259,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_MISS=
",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0204008000",
+        "MSRValue": "0x204008000",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1268,7 +1268,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_NONE=
",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0084008000",
+        "MSRValue": "0x84008000",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1286,7 +1286,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_NOT_=
NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0104008000",
+        "MSRValue": "0x104008000",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1313,7 +1313,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS.SNOOP_HIT_NO_=
FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x043C000040",
+        "MSRValue": "0x43C000040",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1322,7 +1322,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x023C000040",
+        "MSRValue": "0x23C000040",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1331,7 +1331,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00BC000040",
+        "MSRValue": "0xBC000040",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1340,7 +1340,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS.SNOOP_NOT_NEE=
DED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x013C000040",
+        "MSRValue": "0x13C000040",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1367,7 +1367,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0404000040",
+        "MSRValue": "0x404000040",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1376,7 +1376,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0204000040",
+        "MSRValue": "0x204000040",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1385,7 +1385,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0084000040",
+        "MSRValue": "0x84000040",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1403,7 +1403,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0104000040",
+        "MSRValue": "0x104000040",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1430,7 +1430,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS.SNOOP_HIT_NO_=
FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x043C000010",
+        "MSRValue": "0x43C000010",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1439,7 +1439,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x023C000010",
+        "MSRValue": "0x23C000010",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1448,7 +1448,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00BC000010",
+        "MSRValue": "0xBC000010",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1457,7 +1457,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS.SNOOP_NOT_NEE=
DED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x013C000010",
+        "MSRValue": "0x13C000010",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1484,7 +1484,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0404000010",
+        "MSRValue": "0x404000010",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1493,7 +1493,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0204000010",
+        "MSRValue": "0x204000010",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1502,7 +1502,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0084000010",
+        "MSRValue": "0x84000010",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1520,7 +1520,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0104000010",
+        "MSRValue": "0x104000010",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1547,7 +1547,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS.SNOOP_HIT_NO_FWD"=
,
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x043C000020",
+        "MSRValue": "0x43C000020",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1556,7 +1556,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x023C000020",
+        "MSRValue": "0x23C000020",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1565,7 +1565,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00BC000020",
+        "MSRValue": "0xBC000020",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1574,7 +1574,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS.SNOOP_NOT_NEEDED"=
,
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x013C000020",
+        "MSRValue": "0x13C000020",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1601,7 +1601,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0404000020",
+        "MSRValue": "0x404000020",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1610,7 +1610,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0204000020",
+        "MSRValue": "0x204000020",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1619,7 +1619,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0084000020",
+        "MSRValue": "0x84000020",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1637,7 +1637,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0104000020",
+        "MSRValue": "0x104000020",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1664,7 +1664,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS.SNOOP_HIT_NO_=
FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x043C000200",
+        "MSRValue": "0x43C000200",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1673,7 +1673,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x023C000200",
+        "MSRValue": "0x23C000200",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1682,7 +1682,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00BC000200",
+        "MSRValue": "0xBC000200",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1691,7 +1691,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS.SNOOP_NOT_NEE=
DED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x013C000200",
+        "MSRValue": "0x13C000200",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1718,7 +1718,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0404000200",
+        "MSRValue": "0x404000200",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1727,7 +1727,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0204000200",
+        "MSRValue": "0x204000200",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1736,7 +1736,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0084000200",
+        "MSRValue": "0x84000200",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1754,7 +1754,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0104000200",
+        "MSRValue": "0x104000200",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1781,7 +1781,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS.SNOOP_HIT_NO_=
FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x043C000080",
+        "MSRValue": "0x43C000080",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1790,7 +1790,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x023C000080",
+        "MSRValue": "0x23C000080",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1799,7 +1799,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00BC000080",
+        "MSRValue": "0xBC000080",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1808,7 +1808,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS.SNOOP_NOT_NEE=
DED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x013C000080",
+        "MSRValue": "0x13C000080",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1835,7 +1835,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0404000080",
+        "MSRValue": "0x404000080",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1844,7 +1844,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0204000080",
+        "MSRValue": "0x204000080",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1853,7 +1853,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0084000080",
+        "MSRValue": "0x84000080",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1871,7 +1871,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0104000080",
+        "MSRValue": "0x104000080",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1898,7 +1898,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS.SNOOP_HIT_NO_FWD"=
,
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x043C000100",
+        "MSRValue": "0x43C000100",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1907,7 +1907,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x023C000100",
+        "MSRValue": "0x23C000100",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1916,7 +1916,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS.SNOOP_NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x00BC000100",
+        "MSRValue": "0xBC000100",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1925,7 +1925,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS.SNOOP_NOT_NEEDED"=
,
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x013C000100",
+        "MSRValue": "0x13C000100",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1952,7 +1952,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0404000100",
+        "MSRValue": "0x404000100",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1961,7 +1961,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0204000100",
+        "MSRValue": "0x204000100",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1970,7 +1970,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
NONE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0084000100",
+        "MSRValue": "0x84000100",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1988,7 +1988,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0104000100",
+        "MSRValue": "0x104000100",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json b/tools=
/perf/pmu-events/arch/x86/broadwell/pipeline.json
index 2f0fe6b35334..9a902d2160e6 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
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
@@ -1097,7 +1105,7 @@
     },
     {
         "BriefDescription": "Cycles with less than 10 actually retired uop=
s.",
-        "CounterMask": "10",
+        "CounterMask": "16",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.TOTAL_CYCLES",
         "Invert": "1",
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/uncore-other.json b/t=
ools/perf/pmu-events/arch/x86/broadwell/uncore-other.json
index ddcf7faa9d10..368a958a18a0 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/uncore-other.json
@@ -8,7 +8,7 @@
         "Unit": "ARB"
     },
     {
-        "BriefDescription": "Each cycle count number of all Core outgoing =
valid entries. Such entry is defined as valid from it's allocation till fir=
st of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-cohe=
rent traffic.",
+        "BriefDescription": "Each cycle counts number of all Core outgoing=
 valid entries. Such entry is defined as valid from its allocation till fir=
st of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-cohe=
rent traffic.",
         "EventCode": "0x80",
         "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 9abebe50ae0d..70be860bcb53 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -2,7 +2,7 @@ Family-model,Version,Filename,EventType
 GenuineIntel-6-(97|9A|B7|BA|BF),v1.19,alderlake,core
 GenuineIntel-6-BE,v1.19,alderlaken,core
 GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
-GenuineIntel-6-(3D|47),v26,broadwell,core
+GenuineIntel-6-(3D|47),v27,broadwell,core
 GenuineIntel-6-56,v7,broadwellde,core
 GenuineIntel-6-4F,v19,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.17,cascadelakex,core
--=20
2.40.0.348.gf938b09366-goog

