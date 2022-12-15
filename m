Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB94F64D6D2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 08:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiLOHAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 02:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiLOG6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:58:34 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDCA6037B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:57:01 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 195-20020a2505cc000000b0071163981d18so2655405ybf.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tMne9KBPN2d0XDgJJ4QOAR473CAsfPhwcLPKhO1anVA=;
        b=SeGJttkEr3qUNDBuJO75gqwQ/2TJbgctbY5lBMuLftVrOPKoWEOQ/etXSSGPjzn7m0
         vOHJxKDb8V6ebq+ai86ssVOpE8qKS/NVXq3z4y9moSrm3EbFChckwZ+ooqam+3dZwLNI
         O2igqM5EFL2T+6/tY3w2BbydKWAMGVy6gz5EsKimhR6uTErzBLifuPMF4lRQUHfZsDFt
         v6Mt5vukcE47MHSAAUtcetBtvC1gyVUl/g+z1Oh6VodgVwFowYlgfeQHRhhLSLE3F4sd
         8rSmnta+KxSo/glVuffMS5xwwndmHdMdOpASkCXGGW8vx+6XLuq3qxHBlHCxKMmd2U86
         uxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tMne9KBPN2d0XDgJJ4QOAR473CAsfPhwcLPKhO1anVA=;
        b=WPX8g+NurMkyKcwLPVRskHX+9FviCF6QKtQSKptn3+vjwrGCz5IMQjrOyQPfuMbcJU
         V11lon5Ii9blN6eEGtYXJruWhisU+3v/aus4EclD1ebTfyvBFJdZYCvFdhH//xI9+2SP
         6j+2NO0Tmob8AUdty5XocW2WMFpTATC3UAT0HxwGOZwIjDMcTyU7lICCYyXEg7PJL5TK
         GK0eHH15YtnTigXex/dcekp07jJN/A0B3z/yK8n82v8AaMgWrcEYLwlO5IXgRH+z3i35
         hS151cN0xX+C7I7AfS11WmcrS6nDqfjou0vbl+j2m72TtFI8QaiU78p4NVLd3wrFh9IS
         36Jg==
X-Gm-Message-State: ANoB5pkfkaScLUKG00V/k9mA3SMIfd9++RShvDKtVNY+Lz4MmjP2BcWg
        BOOyIwLoaliP6KXEYaZeL3IgJplTHKCu
X-Google-Smtp-Source: AA0mqf42m60rTwvJr6xmmQYPAV9+/1MPYcUWHHQdyinqN3QsWO/YUUNx0pxmRotX4UHUYoZUujwwVBB0BFVj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c7dc:d96f:4f9:f59d])
 (user=irogers job=sendgmr) by 2002:a25:9c87:0:b0:6f1:62cf:1530 with SMTP id
 y7-20020a259c87000000b006f162cf1530mr63331189ybo.442.1671087420575; Wed, 14
 Dec 2022 22:57:00 -0800 (PST)
Date:   Wed, 14 Dec 2022 22:54:58 -0800
In-Reply-To: <20221215065510.1621979-1-irogers@google.com>
Message-Id: <20221215065510.1621979-12-irogers@google.com>
Mime-Version: 1.0
References: <20221215065510.1621979-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 20/32] perf vendor events intel: Refresh meteorlake events
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the meteorlake events using the new tooling from:
https://github.com/intel/perfmon

The events are unchanged but they are sorted and unused json values
are removed. This increases consistency across the json files. The
CPUID matching regular expression is updated to match the perfmon one.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 .../pmu-events/arch/x86/meteorlake/cache.json | 170 ++++----------
 .../arch/x86/meteorlake/frontend.json         |   6 -
 .../arch/x86/meteorlake/memory.json           |  77 ++----
 .../pmu-events/arch/x86/meteorlake/other.json |  24 +-
 .../arch/x86/meteorlake/pipeline.json         | 222 ++++++------------
 .../arch/x86/meteorlake/virtual-memory.json   |  28 +--
 7 files changed, 166 insertions(+), 363 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index de3f9dd4e6f7..84f74acf91d9 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -17,7 +17,7 @@ GenuineIntel-6-3A,v23,ivybridge,core
 GenuineIntel-6-3E,v22,ivytown,core
 GenuineIntel-6-2D,v21,jaketown,core
 GenuineIntel-6-(57|85),v9,knightslanding,core
-GenuineIntel-6-AA,v1.00,meteorlake,core
+GenuineIntel-6-A[AC],v1.00,meteorlake,core
 GenuineIntel-6-1[AEF],v3,nehalemep,core
 GenuineIntel-6-2E,v3,nehalemex,core
 GenuineIntel-6-2A,v17,sandybridge,core
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json b/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
index 32b2aa9b1475..0970724a2984 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
@@ -1,262 +1,196 @@
 [
+    {
+        "BriefDescription": "L2 code requests",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.ALL_CODE_RD",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Demand Data Read access L2 cache",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of cacheable memory requests that miss in the LLC. Counts on a per core basis.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.MISS",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "200003",
         "UMask": "0x41",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Core-originated cacheable requests that missed L3  (Except hardware prefetches to the L3)",
+        "EventCode": "0x2e",
+        "EventName": "LONGEST_LAT_CACHE.MISS",
+        "SampleAfterValue": "100003",
+        "UMask": "0x41",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of cacheable memory requests that access the LLC. Counts on a per core basis.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "200003",
         "UMask": "0x4f",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Core-originated cacheable requests that refer to L3 (Except hardware prefetches to the L3)",
+        "EventCode": "0x2e",
+        "EventName": "LONGEST_LAT_CACHE.REFERENCE",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4f",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired load instructions.",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.ALL_LOADS",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x81",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired store instructions.",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.ALL_STORES",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x82",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of load ops retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "200003",
         "UMask": "0x81",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of store ops retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "200003",
         "UMask": "0x82",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "CollectPEBSRecord": "3",
-        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x80",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "TakenAlone": "1",
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "CollectPEBSRecord": "3",
-        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x10",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "TakenAlone": "1",
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "CollectPEBSRecord": "3",
-        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x100",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "TakenAlone": "1",
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "CollectPEBSRecord": "3",
-        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x20",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "TakenAlone": "1",
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "CollectPEBSRecord": "3",
-        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x4",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "TakenAlone": "1",
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "CollectPEBSRecord": "3",
-        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x200",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "TakenAlone": "1",
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "CollectPEBSRecord": "3",
-        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x40",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "TakenAlone": "1",
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "CollectPEBSRecord": "3",
-        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x8",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "TakenAlone": "1",
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of  stores uops retired same as MEM_UOPS_RETIRED.ALL_STORES",
-        "CollectPEBSRecord": "3",
-        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
         "UMask": "0x6",
         "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "L2 code requests",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x24",
-        "EventName": "L2_RQSTS.ALL_CODE_RD",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "200003",
-        "UMask": "0xe4",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Demand Data Read access L2 cache",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x24",
-        "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "200003",
-        "UMask": "0xe1",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Core-originated cacheable requests that missed L3  (Except hardware prefetches to the L3)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x2e",
-        "EventName": "LONGEST_LAT_CACHE.MISS",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
-        "SampleAfterValue": "100003",
-        "UMask": "0x41",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Core-originated cacheable requests that refer to L3 (Except hardware prefetches to the L3)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x2e",
-        "EventName": "LONGEST_LAT_CACHE.REFERENCE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
-        "SampleAfterValue": "100003",
-        "UMask": "0x4f",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Retired load instructions.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "Data_LA": "1",
-        "EventCode": "0xd0",
-        "EventName": "MEM_INST_RETIRED.ALL_LOADS",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x81",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Retired store instructions.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "Data_LA": "1",
-        "EventCode": "0xd0",
-        "EventName": "MEM_INST_RETIRED.ALL_STORES",
-        "L1_Hit_Indication": "1",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x82",
-        "Unit": "cpu_core"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json b/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
index 9657768fc95a..7de11819dd0d 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
@@ -1,22 +1,16 @@
 [
     {
         "BriefDescription": "Counts every time the code stream enters into a new cache line by walking sequential from the previous line or being redirected by a jump.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x80",
         "EventName": "ICACHE.ACCESSES",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "200003",
         "UMask": "0x3",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts every time the code stream enters into a new cache line by walking sequential from the previous line or being redirected by a jump and the instruction cache registers bytes are not present. -",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x80",
         "EventName": "ICACHE.MISSES",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "200003",
         "UMask": "0x2",
         "Unit": "cpu_atom"
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/memory.json b/tools/perf/pmu-events/arch/x86/meteorlake/memory.json
index 15b2294a8ae7..b7715cec1dbc 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/memory.json
@@ -1,157 +1,102 @@
 [
-    {
-        "BriefDescription": "Counts cacheable demand data reads were not supplied by the L3 cache.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3FBFC00001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership, including SWPREFETCHW which is an RFO were not supplied by the L3 cache.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_RFO.L3_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3FBFC00002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
     {
         "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 128 cycles.",
-        "CollectPEBSRecord": "2",
-        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x80",
         "PEBS": "2",
-        "PEBScounters": "1,2,3,4,5,6,7",
         "SampleAfterValue": "1009",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 16 cycles.",
-        "CollectPEBSRecord": "2",
-        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x10",
         "PEBS": "2",
-        "PEBScounters": "1,2,3,4,5,6,7",
         "SampleAfterValue": "20011",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 256 cycles.",
-        "CollectPEBSRecord": "2",
-        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x100",
         "PEBS": "2",
-        "PEBScounters": "1,2,3,4,5,6,7",
         "SampleAfterValue": "503",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 32 cycles.",
-        "CollectPEBSRecord": "2",
-        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x20",
         "PEBS": "2",
-        "PEBScounters": "1,2,3,4,5,6,7",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 4 cycles.",
-        "CollectPEBSRecord": "2",
-        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x4",
         "PEBS": "2",
-        "PEBScounters": "1,2,3,4,5,6,7",
         "SampleAfterValue": "100003",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 512 cycles.",
-        "CollectPEBSRecord": "2",
-        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x200",
         "PEBS": "2",
-        "PEBScounters": "1,2,3,4,5,6,7",
         "SampleAfterValue": "101",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 64 cycles.",
-        "CollectPEBSRecord": "2",
-        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x40",
         "PEBS": "2",
-        "PEBScounters": "1,2,3,4,5,6,7",
         "SampleAfterValue": "2003",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 8 cycles.",
-        "CollectPEBSRecord": "2",
-        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x8",
         "PEBS": "2",
-        "PEBScounters": "1,2,3,4,5,6,7",
         "SampleAfterValue": "50021",
-        "TakenAlone": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Retired memory store access operations. A PDist event for PEBS Store Latency Facility.",
-        "CollectPEBSRecord": "2",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.STORE_SAMPLE",
@@ -160,9 +105,18 @@
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts cacheable demand data reads were not supplied by the L3 cache.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3FBFC00001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand data reads that were not supplied by the L3 cache.",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -171,9 +125,18 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand reads for ownership, including SWPREFETCHW which is an RFO were not supplied by the L3 cache.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3FBFC00002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand read for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that were not supplied by the L3 cache.",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/other.json b/tools/perf/pmu-events/arch/x86/meteorlake/other.json
index 14273ac54d2c..ae98e3d0e149 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/other.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "Counts cacheable demand data reads Catch all value for any response types - this includes response types not define in the OCR.  If this is set all other response types will be ignored",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -10,20 +9,8 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
-    {
-        "BriefDescription": "Counts demand reads for ownership, including SWPREFETCHW which is an RFO Catch all value for any response types - this includes response types not define in the OCR.  If this is set all other response types will be ignored",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
     {
         "BriefDescription": "Counts demand data reads that have any type of response.",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -32,9 +19,18 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand reads for ownership, including SWPREFETCHW which is an RFO Catch all value for any response types - this includes response types not define in the OCR.  If this is set all other response types will be ignored",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand read for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that have any type of response.",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json b/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
index 0a7981675b6c..7be7e40c03ac 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
@@ -1,254 +1,182 @@
 [
     {
         "BriefDescription": "Counts the total number of branch instructions retired for all branch types.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "200003",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "All branch instructions retired.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
+        "PEBS": "1",
+        "SampleAfterValue": "400009",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the total number of mispredicted branch instructions retired for all branch types.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "200003",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "All mispredicted branch instructions retired.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
+        "PEBS": "1",
+        "SampleAfterValue": "400009",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted core clock cycles",
-        "CollectPEBSRecord": "2",
-        "Counter": "33",
         "EventName": "CPU_CLK_UNHALTED.CORE",
-        "PEBScounters": "33",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of unhalted core clock cycles[This event is alias to CPU_CLK_UNHALTED.THREAD_P]",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.CORE_P",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted reference clock cycles",
-        "CollectPEBSRecord": "2",
-        "Counter": "34",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
-        "PEBScounters": "34",
         "SampleAfterValue": "2000003",
         "UMask": "0x3",
         "Unit": "cpu_atom"
     },
-    {
-        "BriefDescription": "Fixed Counter: Counts the number of unhalted core clock cycles",
-        "CollectPEBSRecord": "2",
-        "Counter": "33",
-        "EventName": "CPU_CLK_UNHALTED.THREAD",
-        "PEBScounters": "33",
-        "SampleAfterValue": "2000003",
-        "UMask": "0x2",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of unhalted core clock cycles[This event is alias to CPU_CLK_UNHALTED.CORE_P]",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x3c",
-        "EventName": "CPU_CLK_UNHALTED.THREAD_P",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
-        "SampleAfterValue": "2000003",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Fixed Counter: Counts the number of instructions retired",
-        "CollectPEBSRecord": "2",
-        "Counter": "32",
-        "EventName": "INST_RETIRED.ANY",
-        "PEBS": "1",
-        "PEBScounters": "32",
-        "SampleAfterValue": "2000003",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of instructions retired",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xc0",
-        "EventName": "INST_RETIRED.ANY_P",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
-        "SampleAfterValue": "2000003",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots that were not consumed by the backend because allocation is stalled due to a mispredicted jump or a machine clear.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x73",
-        "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
-        "SampleAfterValue": "1000003",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of retirement slots not consumed due to backend stalls",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x74",
-        "EventName": "TOPDOWN_BE_BOUND.ALL",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
-        "SampleAfterValue": "1000003",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of retirement slots not consumed due to front end stalls",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x71",
-        "EventName": "TOPDOWN_FE_BOUND.ALL",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
-        "SampleAfterValue": "1000003",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of consumed retirement slots.  Similar to UOPS_RETIRED.ALL",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x72",
-        "EventName": "TOPDOWN_RETIRING.ALL",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
-        "SampleAfterValue": "1000003",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "All branch instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xc4",
-        "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
-        "SampleAfterValue": "400009",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "All mispredicted branch instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xc5",
-        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
-        "SampleAfterValue": "400009",
-        "Unit": "cpu_core"
-    },
     {
         "BriefDescription": "Reference cycles when the core is not in halt state.",
-        "CollectPEBSRecord": "2",
-        "Counter": "34",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
-        "PEBScounters": "34",
         "SampleAfterValue": "2000003",
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt state.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Fixed Counter: Counts the number of unhalted core clock cycles",
+        "EventName": "CPU_CLK_UNHALTED.THREAD",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Core cycles when the thread is not in halt state",
-        "CollectPEBSRecord": "2",
-        "Counter": "33",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
-        "PEBScounters": "33",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of unhalted core clock cycles[This event is alias to CPU_CLK_UNHALTED.CORE_P]",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.THREAD_P",
+        "SampleAfterValue": "2000003",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Thread cycles when thread is not in halt state",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Fixed Counter: Counts the number of instructions retired",
+        "EventName": "INST_RETIRED.ANY",
+        "PEBS": "1",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Number of instructions retired. Fixed Counter - architectural event",
-        "CollectPEBSRecord": "2",
-        "Counter": "32",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
-        "PEBScounters": "32",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of instructions retired",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.ANY_P",
+        "PEBS": "1",
+        "SampleAfterValue": "2000003",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Number of instructions retired. General Counter - architectural event",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.ANY_P",
         "PEBS": "1",
-        "PEBScounters": "1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Loads blocked due to overlapping with a preceding store that cannot be forwarded.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
         "UMask": "0x82",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "TMA slots available for an unhalted logical processor. Fixed counter - architectural event",
-        "CollectPEBSRecord": "2",
-        "Counter": "35",
         "EventName": "TOPDOWN.SLOTS",
-        "PEBScounters": "35",
         "SampleAfterValue": "10000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "TMA slots available for an unhalted logical processor. General counter - architectural event",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.SLOTS_P",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "10000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were not consumed by the backend because allocation is stalled due to a mispredicted jump or a machine clear.",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retirement slots not consumed due to backend stalls",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.ALL",
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retirement slots not consumed due to front end stalls",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.ALL",
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of consumed retirement slots.  Similar to UOPS_RETIRED.ALL",
+        "EventCode": "0x72",
+        "EventName": "TOPDOWN_RETIRING.ALL",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_atom"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/virtual-memory.json b/tools/perf/pmu-events/arch/x86/meteorlake/virtual-memory.json
index 3087730cca7b..0ee62378bf22 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/virtual-memory.json
@@ -1,44 +1,32 @@
 [
-    {
-        "BriefDescription": "Counts the number of page walks completed due to instruction fetch misses to any page size.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x85",
-        "EventName": "ITLB_MISSES.WALK_COMPLETED",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
-        "SampleAfterValue": "200003",
-        "UMask": "0xe",
-        "Unit": "cpu_atom"
-    },
     {
         "BriefDescription": "Load miss in all TLB levels causes a page walk that completes. (All page sizes)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
         "UMask": "0xe",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Store misses in all TLB levels causes a page walk that completes. (All page sizes)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
         "UMask": "0xe",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of page walks completed due to instruction fetch misses to any page size.",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page walk that completes. (All page sizes)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
         "UMask": "0xe",
         "Unit": "cpu_core"
-- 
2.39.0.314.g84b9a713c41-goog

