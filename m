Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F05E6E0EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjDMNct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjDMNc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:32:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B260DAD0F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:31:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 65-20020a250244000000b00b8f53d3e51cso3134745ybc.20
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681392675; x=1683984675;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MTujeIVW3qNu49IoS2ASCZLHq+tQ4PP2gRP1Vzk9GeA=;
        b=il/drKWXouoBio4xeL9GT1eSg69bvx5xJa1ZAm1KR4zHcMzINHwA5b8QtFOIv/kvTC
         3f6I5Kr4UX+tc2+UQE+3HFGTY1UqJFTm6b9vkoP5VW5SYzK6l7Fo3xBHvHcg+TLl3iya
         +cxEtCqDXhvtEsDQ+D7AJaF6Y5GGMMbihuN6fRdg5u+di/C9l9E4yQnfFVn0HSIy9vAn
         lUflrzBwRajMbSqtqT+aEUGdY/N2LsNAK16ov5P2t1FoDH9dkSmMp0iQ/MYO5fwwFJGQ
         49NNGwz05mylDeQguD6Bqxmu11jGEsM7/eeJe3ExdsXpc2sCmQoqniK0vmreuusQwb2z
         darA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681392675; x=1683984675;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MTujeIVW3qNu49IoS2ASCZLHq+tQ4PP2gRP1Vzk9GeA=;
        b=cX+yFZhkIJ+HEmr6GmUy3/BN8trYZswe3BenUJiEWeCfY69c17TJSmhMcoKUESOGnR
         tGktzHj9PH0alDrrY4Y2jMrv3JiybF6dQaVRkpIyq3xP7aDUfhtVfw8fGKiKm3QWTWVx
         DGvoXGQHb3OkPzS+UvhjMOA9OY4Z4kfyT9bJZdrVpClrP+XSJk0jmhzHYQ3lZ8BZte4/
         axskxFlbZQgD/xN8avpqn5gwbafhojlH3PLGSTNnlecUV4fnnJo1QCIUgpbS+yB/DOby
         NlW6MINq6AFaXQJhePtrhq3DvvVvE6o54fVQGIg3iq/7YYPCJZO04I36RVpoizFO5+6G
         ic8Q==
X-Gm-Message-State: AAQBX9fcpKONEnU7jQU1azy69j25DqS/z9SSVhzU0xkHPjxrvdAorZGF
        c2KzX16s3mxHlrzlBlH/YnEDA5NYhGYQ
X-Google-Smtp-Source: AKy350ZsepcaRBhWxx72ggZoQHaAJsCIKnAOi71K2ZgWwjzc01dlwTR9ZJuakItIWqewUfKpoFSnkgoP7RGT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c8fe:b894:ec92:d5cd])
 (user=irogers job=sendgmr) by 2002:a81:8b4f:0:b0:54f:68a1:b406 with SMTP id
 e15-20020a818b4f000000b0054f68a1b406mr1405664ywk.2.1681392675493; Thu, 13 Apr
 2023 06:31:15 -0700 (PDT)
Date:   Thu, 13 Apr 2023 06:29:37 -0700
In-Reply-To: <20230413132949.3487664-1-irogers@google.com>
Message-Id: <20230413132949.3487664-10-irogers@google.com>
Mime-Version: 1.0
References: <20230413132949.3487664-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v3 09/21] perf vendor events intel: Fix uncore topics for haswell
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
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move events from 'uncore-other' topic classification to cache and
interconnect.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/haswell/uncore-cache.json        | 50 +++++++++---------
 .../arch/x86/haswell/uncore-interconnect.json | 52 +++++++++++++++++++
 .../arch/x86/haswell/uncore-other.json        | 50 ------------------
 3 files changed, 77 insertions(+), 75 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/haswell/uncore-interconnect.json

diff --git a/tools/perf/pmu-events/arch/x86/haswell/uncore-cache.json b/tools/perf/pmu-events/arch/x86/haswell/uncore-cache.json
index c538557ba4c0..be9a3ed1a940 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/uncore-cache.json
@@ -5,7 +5,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_ES",
         "PerPkg": "1",
         "UMask": "0x86",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup any request that access cache and found line in I-state.",
@@ -13,7 +13,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_I",
         "PerPkg": "1",
         "UMask": "0x88",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup any request that access cache and found line in M-state.",
@@ -21,7 +21,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_M",
         "PerPkg": "1",
         "UMask": "0x81",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup any request that access cache and found line in MESI-state.",
@@ -29,7 +29,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_MESI",
         "PerPkg": "1",
         "UMask": "0x8f",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup external snoop request that access cache and found line in E or S-state.",
@@ -37,7 +37,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.EXTSNP_ES",
         "PerPkg": "1",
         "UMask": "0x46",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup external snoop request that access cache and found line in I-state.",
@@ -45,7 +45,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.EXTSNP_I",
         "PerPkg": "1",
         "UMask": "0x48",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup external snoop request that access cache and found line in M-state.",
@@ -53,7 +53,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.EXTSNP_M",
         "PerPkg": "1",
         "UMask": "0x41",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup external snoop request that access cache and found line in MESI-state.",
@@ -61,7 +61,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.EXTSNP_MESI",
         "PerPkg": "1",
         "UMask": "0x4f",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and found line in E or S-state.",
@@ -69,7 +69,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.READ_ES",
         "PerPkg": "1",
         "UMask": "0x16",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and found line in I-state.",
@@ -77,7 +77,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.READ_I",
         "PerPkg": "1",
         "UMask": "0x18",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and found line in M-state.",
@@ -85,7 +85,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.READ_M",
         "PerPkg": "1",
         "UMask": "0x11",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and found line in any MESI-state.",
@@ -93,7 +93,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.READ_MESI",
         "PerPkg": "1",
         "UMask": "0x1f",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup write request that access cache and found line in E or S-state.",
@@ -101,7 +101,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.WRITE_ES",
         "PerPkg": "1",
         "UMask": "0x26",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup write request that access cache and found line in I-state.",
@@ -109,7 +109,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.WRITE_I",
         "PerPkg": "1",
         "UMask": "0x28",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup write request that access cache and found line in M-state.",
@@ -117,7 +117,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.WRITE_M",
         "PerPkg": "1",
         "UMask": "0x21",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup write request that access cache and found line in MESI-state.",
@@ -125,7 +125,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.WRITE_MESI",
         "PerPkg": "1",
         "UMask": "0x2f",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "A cross-core snoop resulted from L3 Eviction which hits a modified line in some processor core.",
@@ -133,7 +133,7 @@
         "EventName": "UNC_CBO_XSNP_RESPONSE.HITM_EVICTION",
         "PerPkg": "1",
         "UMask": "0x88",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "An external snoop hits a modified line in some processor core.",
@@ -141,7 +141,7 @@
         "EventName": "UNC_CBO_XSNP_RESPONSE.HITM_EXTERNAL",
         "PerPkg": "1",
         "UMask": "0x28",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "A cross-core snoop initiated by this Cbox due to processor core memory request which hits a modified line in some processor core.",
@@ -149,7 +149,7 @@
         "EventName": "UNC_CBO_XSNP_RESPONSE.HITM_XCORE",
         "PerPkg": "1",
         "UMask": "0x48",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "A cross-core snoop resulted from L3 Eviction which hits a non-modified line in some processor core.",
@@ -157,7 +157,7 @@
         "EventName": "UNC_CBO_XSNP_RESPONSE.HIT_EVICTION",
         "PerPkg": "1",
         "UMask": "0x84",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "An external snoop hits a non-modified line in some processor core.",
@@ -165,7 +165,7 @@
         "EventName": "UNC_CBO_XSNP_RESPONSE.HIT_EXTERNAL",
         "PerPkg": "1",
         "UMask": "0x24",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "A cross-core snoop initiated by this Cbox due to processor core memory request which hits a non-modified line in some processor core.",
@@ -173,7 +173,7 @@
         "EventName": "UNC_CBO_XSNP_RESPONSE.HIT_XCORE",
         "PerPkg": "1",
         "UMask": "0x44",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "A cross-core snoop resulted from L3 Eviction which misses in some processor core.",
@@ -181,7 +181,7 @@
         "EventName": "UNC_CBO_XSNP_RESPONSE.MISS_EVICTION",
         "PerPkg": "1",
         "UMask": "0x81",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "An external snoop misses in some processor core.",
@@ -189,7 +189,7 @@
         "EventName": "UNC_CBO_XSNP_RESPONSE.MISS_EXTERNAL",
         "PerPkg": "1",
         "UMask": "0x21",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "A cross-core snoop initiated by this Cbox due to processor core memory request which misses in some processor core.",
@@ -197,6 +197,6 @@
         "EventName": "UNC_CBO_XSNP_RESPONSE.MISS_XCORE",
         "PerPkg": "1",
         "UMask": "0x41",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/haswell/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/haswell/uncore-interconnect.json
new file mode 100644
index 000000000000..8da28239ebf9
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/haswell/uncore-interconnect.json
@@ -0,0 +1,52 @@
+[
+    {
+        "BriefDescription": "Each cycle count number of valid entries in Coherency Tracker queue from allocation till deallocation. Aperture requests (snoops) appear as NC decoded internally and become coherent (snoop L3, access memory)",
+        "EventCode": "0x83",
+        "EventName": "UNC_ARB_COH_TRK_OCCUPANCY.All",
+        "PerPkg": "1",
+        "PublicDescription": "Each cycle count number of valid entries in Coherency Tracker queue from allocation till deallocation. Aperture requests (snoops) appear as NC decoded internally and become coherent (snoop L3, access memory).",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of entries allocated. Account for Any type: e.g. Snoop, Core aperture, etc.",
+        "EventCode": "0x84",
+        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle counts number of all Core outgoing valid entries. Such entry is defined as valid from its allocation till first of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent traffic.",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Cycles with at least one request outstanding is waiting for data return from memory controller. Account for coherent and non-coherent requests initiated by IA Cores, Processor Graphics Unit, or LLC.",
+        "CounterMask": "1",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.CYCLES_WITH_ANY_REQUEST",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Total number of Core outgoing entries allocated. Accounts for Coherent and non-coherent traffic.",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of Writes allocated - any write transactions: full/partials writes and evictions.",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.WRITES",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "ARB"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/haswell/uncore-other.json b/tools/perf/pmu-events/arch/x86/haswell/uncore-other.json
index 84cc2536de69..2af92e43b28a 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/uncore-other.json
@@ -1,54 +1,4 @@
 [
-    {
-        "BriefDescription": "Each cycle count number of valid entries in Coherency Tracker queue from allocation till deallocation. Aperture requests (snoops) appear as NC decoded internally and become coherent (snoop L3, access memory)",
-        "EventCode": "0x83",
-        "EventName": "UNC_ARB_COH_TRK_OCCUPANCY.All",
-        "PerPkg": "1",
-        "PublicDescription": "Each cycle count number of valid entries in Coherency Tracker queue from allocation till deallocation. Aperture requests (snoops) appear as NC decoded internally and become coherent (snoop L3, access memory).",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Number of entries allocated. Account for Any type: e.g. Snoop, Core aperture, etc.",
-        "EventCode": "0x84",
-        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle counts number of all Core outgoing valid entries. Such entry is defined as valid from its allocation till first of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent traffic.",
-        "EventCode": "0x80",
-        "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Cycles with at least one request outstanding is waiting for data return from memory controller. Account for coherent and non-coherent requests initiated by IA Cores, Processor Graphics Unit, or LLC.",
-        "CounterMask": "1",
-        "EventCode": "0x80",
-        "EventName": "UNC_ARB_TRK_OCCUPANCY.CYCLES_WITH_ANY_REQUEST",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Total number of Core outgoing entries allocated. Accounts for Coherent and non-coherent traffic.",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Number of Writes allocated - any write transactions: full/partials writes and evictions.",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_TRK_REQUESTS.WRITES",
-        "PerPkg": "1",
-        "UMask": "0x20",
-        "Unit": "ARB"
-    },
     {
         "BriefDescription": "This 48-bit fixed counter counts the UCLK cycles.",
         "EventCode": "0xff",
-- 
2.40.0.577.gac1e443424-goog

