Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604786E065E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 07:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjDMFPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 01:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDMFO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 01:14:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DEBA25D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:13:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 186-20020a2510c3000000b00b880000325bso31051769ybq.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681362782; x=1683954782;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DjePygWNzjikF1/0wL8IG/xpima8j1eK/Y93rEybJLQ=;
        b=tkkuQHndybtpVY5tg4WkL+WrifKDH/8s+Ef8jA6/Qi3Ae5CuYqGodKX6+UYat52Sgt
         4mcx7K49st8GUWTjf4OdSu/vcZ6FYUEm39z5hDIZ1GFtztgiO0X9qmnicrRsLT9DfMGz
         wE9dw83hupAF61H561CrBXjB7Bi+fM1+N9a/vOXTTF5FAcHVSIGdgeYKYzU6U0hZ/hRq
         N7tOLBnAaeNm17Jg7mKgOfdxPMUZC/OIDEvVT91ajunB8psyoqRvrDcpIO0q2ZiMUltU
         8fu6pRk8A2Xr2G9ERrYyart6h7CBxryLQH4kRvrIoK/pcuKcZDpuyN9LDNBjT/EgCr2d
         g7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681362782; x=1683954782;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DjePygWNzjikF1/0wL8IG/xpima8j1eK/Y93rEybJLQ=;
        b=MNr3+n+yRAqsph6+Ngyyq4KpxcbLgPNDqN9uXihzZZlhFjPy4T1UtLXHH5qqI2trOl
         RhY9eTESd5zsMetKsEC0KpUmPVh2+ZHWLn/nX4leGbEncSXH7q+bfrpE1IienTLxQ7OM
         Yig982E1Pth0x7FwkVBdPGgNGEAjTyM9uBq9/QhLx1WA8sOt47x8Ke5Qi9f9qZ6h2O/B
         hF3iKUYSB+uLp3nR+3ToLzwj651cDqdLNZpJmSTNmyv3KB5Xo7SYhc/xYGMQGSs+4uDx
         N7vavvzIXW8+btDu/aLPDldQWQpGQWnpm5NR4bQIof7QzB6CLcJD7zid+3tXBWK6K51p
         eN7A==
X-Gm-Message-State: AAQBX9eVBLi4o2DrIaIymwrDjMTLUNxLpwfQj1NQq8OvvrCztjXioNjV
        AttdJbCYZ2NODu7ivNy7g8n1/hSQD0rI
X-Google-Smtp-Source: AKy350bfTcyoVn2LViITcx7aVMJsMjlhtgrBwmaCI1tzy3+05fVv/E0d2UORKY/Q1DvX0DgYDuGLKyVMVvQR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c8fe:b894:ec92:d5cd])
 (user=irogers job=sendgmr) by 2002:a25:d10e:0:b0:b8f:3881:1638 with SMTP id
 i14-20020a25d10e000000b00b8f38811638mr522589ybg.7.1681362782729; Wed, 12 Apr
 2023 22:13:02 -0700 (PDT)
Date:   Wed, 12 Apr 2023 22:10:07 -0700
In-Reply-To: <20230413051011.3440849-1-irogers@google.com>
Message-Id: <20230413051011.3440849-18-irogers@google.com>
Mime-Version: 1.0
References: <20230413051011.3440849-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v2 17/21] perf vendor events intel: Fix uncore topics for sandybridge
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

Remove 'uncore-other' topic classification, move to cache and
interconnect.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/sandybridge/uncore-cache.json    | 50 +++++++++----------
 ...re-other.json => uncore-interconnect.json} |  0
 2 files changed, 25 insertions(+), 25 deletions(-)
 rename tools/perf/pmu-events/arch/x86/sandybridge/{uncore-other.json => uncore-interconnect.json} (100%)

diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/uncore-cache.json b/tools/perf/pmu-events/arch/x86/sandybridge/uncore-cache.json
index c538557ba4c0..be9a3ed1a940 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/uncore-cache.json
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
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/uncore-other.json b/tools/perf/pmu-events/arch/x86/sandybridge/uncore-interconnect.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/sandybridge/uncore-other.json
rename to tools/perf/pmu-events/arch/x86/sandybridge/uncore-interconnect.json
-- 
2.40.0.577.gac1e443424-goog

