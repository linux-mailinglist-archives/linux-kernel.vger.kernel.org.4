Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545E264D6CD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 07:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiLOG7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 01:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiLOG5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:57:16 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019CE5D69A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:56:45 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id h67-20020a25d046000000b00729876d3b2bso2649005ybg.17
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1E4WfVJ84gnM4qtjeqQirf6a30vXdbKzgzZ9Mlrfq5k=;
        b=dKCxJVf/1ya9rdvSW/Q4x4rfb51N+aiNi0q6ctt+jGGsoqPATNiF+Mr4maF1VoG8M8
         EDfotQWJEE6fxcT8iaqHH2afkKz7AY/9ZEU2wUIqCRumhcaZPzjA/jAZLqmUrE450u9M
         1LelJ4qpmPDmR4r2hBMtCqZ+PmnTNSw1NwuueqLcmXQAvjK4k+Z5vEooGLNmRoOdbjtV
         aw2vv1tCn99ixfiMhIhJqd3g74AShD/u7hysSeeOi4exRzYYCgA9pLq6r/24SBUls7Jh
         pjVyzzLfK5LkDCCaDKcLsh1H/3oBvwPEMnlU5yVEP0bXW3CRu59bWIwUcp8HeY/VLoPu
         TxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1E4WfVJ84gnM4qtjeqQirf6a30vXdbKzgzZ9Mlrfq5k=;
        b=Pydtmi0FOW5WVniJJpNGgdovNsFn3xPIN6y6X7x8DfUy9xwIByBAz6pYlPLDCyeQv2
         n7XhehY+IKq3Ol8TCTXG67Q3m8hnb+rgGGgpgxqG4PAwgWWvxffvH7/PWuVeCxzBhzxy
         wTpzEjoERmvvj6M6NssnYzQJLXOabO+0fT0cLqqRdBnXurhhyRvYX4lz086YU1AIQCKE
         2PiIe/hVH1OsrEZm9cOv0GF4x8KfJtb43wMg2NtViiLFVdgwQ4sVn0lJmie8ylsXUo2G
         iSGZ41VG9RyGUrc849Q1d8EffgJ7wyIlKx/7vozZSxln6d9GJSBSPMJVYZov2nmDa5RD
         U1IQ==
X-Gm-Message-State: ANoB5plCFX3v70XJHeB6+uU/olFQ2tqhJOEDFcJy1yeAYIMN36OJF8xu
        0AtSdKyOIgid/6we2Hr8+sp4UP52ERqw
X-Google-Smtp-Source: AA0mqf5QjIMQ5YI12awTFv1h1t+ADXw3gdVXD2xObmRwq8fL3kkrGVICo4Q/u4ApWyBAoQnjx4bT1g1xLcIf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c7dc:d96f:4f9:f59d])
 (user=irogers job=sendgmr) by 2002:a5b:8cf:0:b0:6f8:92de:92e3 with SMTP id
 w15-20020a5b08cf000000b006f892de92e3mr42647896ybq.105.1671087404198; Wed, 14
 Dec 2022 22:56:44 -0800 (PST)
Date:   Wed, 14 Dec 2022 22:54:56 -0800
In-Reply-To: <20221215065510.1621979-1-irogers@google.com>
Message-Id: <20221215065510.1621979-10-irogers@google.com>
Mime-Version: 1.0
References: <20221215065510.1621979-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 18/32] perf vendor events intel: Refresh jaketown metrics
 and events
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the jaketown metrics and events using the new tooling from:
https://github.com/intel/perfmon

The metrics are unchanged but the formulas differ due to parentheses,
use of exponents and removal of redundant operations like "* 1".  The
events are unchanged but unused json values are removed. The
formatting changes increase consistency across the json files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/jaketown/cache.json   | 289 ------------------
 .../arch/x86/jaketown/floating-point.json     |  30 --
 .../arch/x86/jaketown/frontend.json           |  64 ----
 .../arch/x86/jaketown/jkt-metrics.json        |  91 +++---
 .../pmu-events/arch/x86/jaketown/memory.json  | 103 -------
 .../pmu-events/arch/x86/jaketown/other.json   |  12 -
 .../arch/x86/jaketown/pipeline.json           | 255 ----------------
 .../arch/x86/jaketown/uncore-cache.json       | 266 +++-------------
 .../x86/jaketown/uncore-interconnect.json     | 132 --------
 .../arch/x86/jaketown/uncore-memory.json      |  58 ----
 .../arch/x86/jaketown/uncore-other.json       | 155 +---------
 .../arch/x86/jaketown/uncore-power.json       |  51 ----
 .../arch/x86/jaketown/virtual-memory.json     |  32 --
 13 files changed, 106 insertions(+), 1432 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/jaketown/cache.json b/tools/per=
f/pmu-events/arch/x86/jaketown/cache.json
index f98649fb92b4..f1271039b6b2 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/cache.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/cache.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Allocated L1D data cache lines in M state.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x51",
         "EventName": "L1D.ALLOCATED_IN_M",
         "SampleAfterValue": "2000003",
@@ -10,8 +8,6 @@
     },
     {
         "BriefDescription": "Cache lines in M state evicted out of L1D due=
 to Snoop HitM or dirty line replacement.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x51",
         "EventName": "L1D.ALL_M_REPLACEMENT",
         "SampleAfterValue": "2000003",
@@ -19,8 +15,6 @@
     },
     {
         "BriefDescription": "L1D data cache lines in M state evicted due t=
o replacement.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x51",
         "EventName": "L1D.EVICTION",
         "SampleAfterValue": "2000003",
@@ -28,8 +22,6 @@
     },
     {
         "BriefDescription": "L1D data line replacements.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x51",
         "EventName": "L1D.REPLACEMENT",
         "PublicDescription": "This event counts L1D data line replacements=
.  Replacements occur when a new line is brought into the cache, causing ev=
iction of a line loaded earlier.",
@@ -38,8 +30,6 @@
     },
     {
         "BriefDescription": "Cycles when dispatched loads are cancelled du=
e to L1D bank conflicts with other load ports.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xBF",
         "EventName": "L1D_BLOCKS.BANK_CONFLICT_CYCLES",
@@ -48,8 +38,6 @@
     },
     {
         "BriefDescription": "Cycles a demand request was blocked due to Fi=
ll Buffers inavailability.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL",
@@ -58,8 +46,6 @@
     },
     {
         "BriefDescription": "L1D miss oustandings duration in cycles.",
-        "Counter": "2",
-        "CounterHTOff": "2",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING",
         "SampleAfterValue": "2000003",
@@ -67,8 +53,6 @@
     },
     {
         "BriefDescription": "Cycles with L1D load Misses outstanding.",
-        "Counter": "2",
-        "CounterHTOff": "2",
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING_CYCLES",
@@ -78,8 +62,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles with L1D load Misses outstanding from =
any thread on physical core.",
-        "Counter": "2",
-        "CounterHTOff": "2",
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING_CYCLES_ANY",
@@ -88,8 +70,6 @@
     },
     {
         "BriefDescription": "Not rejected writebacks from L1D to L2 cache =
lines in any state.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x28",
         "EventName": "L2_L1D_WB_RQSTS.ALL",
         "SampleAfterValue": "200003",
@@ -97,8 +77,6 @@
     },
     {
         "BriefDescription": "Not rejected writebacks from L1D to L2 cache =
lines in E state.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x28",
         "EventName": "L2_L1D_WB_RQSTS.HIT_E",
         "SampleAfterValue": "200003",
@@ -106,8 +84,6 @@
     },
     {
         "BriefDescription": "Not rejected writebacks from L1D to L2 cache =
lines in M state.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x28",
         "EventName": "L2_L1D_WB_RQSTS.HIT_M",
         "SampleAfterValue": "200003",
@@ -115,8 +91,6 @@
     },
     {
         "BriefDescription": "Not rejected writebacks from L1D to L2 cache =
lines in S state.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x28",
         "EventName": "L2_L1D_WB_RQSTS.HIT_S",
         "SampleAfterValue": "200003",
@@ -124,8 +98,6 @@
     },
     {
         "BriefDescription": "Count the number of modified Lines evicted fr=
om L1 and missed L2. (Non-rejected WBs from the DCU.).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x28",
         "EventName": "L2_L1D_WB_RQSTS.MISS",
         "SampleAfterValue": "200003",
@@ -133,8 +105,6 @@
     },
     {
         "BriefDescription": "L2 cache lines filling L2.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.ALL",
         "PublicDescription": "This event counts the number of L2 cache lin=
es brought into the L2 cache.  Lines are filled into the L2 cache when ther=
e was an L2 miss.",
@@ -143,8 +113,6 @@
     },
     {
         "BriefDescription": "L2 cache lines in E state filling L2.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.E",
         "SampleAfterValue": "100003",
@@ -152,8 +120,6 @@
     },
     {
         "BriefDescription": "L2 cache lines in I state filling L2.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.I",
         "SampleAfterValue": "100003",
@@ -161,8 +127,6 @@
     },
     {
         "BriefDescription": "L2 cache lines in S state filling L2.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.S",
         "SampleAfterValue": "100003",
@@ -170,8 +134,6 @@
     },
     {
         "BriefDescription": "Clean L2 cache lines evicted by demand.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.DEMAND_CLEAN",
         "SampleAfterValue": "100003",
@@ -179,8 +141,6 @@
     },
     {
         "BriefDescription": "Dirty L2 cache lines evicted by demand.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.DEMAND_DIRTY",
         "SampleAfterValue": "100003",
@@ -188,8 +148,6 @@
     },
     {
         "BriefDescription": "Dirty L2 cache lines filling the L2.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.DIRTY_ALL",
         "SampleAfterValue": "100003",
@@ -197,8 +155,6 @@
     },
     {
         "BriefDescription": "Clean L2 cache lines evicted by L2 prefetch."=
,
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.PF_CLEAN",
         "SampleAfterValue": "100003",
@@ -206,8 +162,6 @@
     },
     {
         "BriefDescription": "Dirty L2 cache lines evicted by L2 prefetch."=
,
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.PF_DIRTY",
         "SampleAfterValue": "100003",
@@ -215,8 +169,6 @@
     },
     {
         "BriefDescription": "L2 code requests.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_CODE_RD",
         "SampleAfterValue": "200003",
@@ -224,8 +176,6 @@
     },
     {
         "BriefDescription": "Demand Data Read requests.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
         "SampleAfterValue": "200003",
@@ -233,8 +183,6 @@
     },
     {
         "BriefDescription": "Requests from L2 hardware prefetchers.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_PF",
         "SampleAfterValue": "200003",
@@ -242,8 +190,6 @@
     },
     {
         "BriefDescription": "RFO requests to L2 cache.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_RFO",
         "SampleAfterValue": "200003",
@@ -251,8 +197,6 @@
     },
     {
         "BriefDescription": "L2 cache hits when fetching instructions, cod=
e reads.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_HIT",
         "SampleAfterValue": "200003",
@@ -260,8 +204,6 @@
     },
     {
         "BriefDescription": "L2 cache misses when fetching instructions.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_MISS",
         "SampleAfterValue": "200003",
@@ -269,8 +211,6 @@
     },
     {
         "BriefDescription": "Demand Data Read requests that hit L2 cache."=
,
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
         "SampleAfterValue": "200003",
@@ -278,8 +218,6 @@
     },
     {
         "BriefDescription": "Requests from the L2 hardware prefetchers tha=
t hit L2 cache.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.PF_HIT",
         "SampleAfterValue": "200003",
@@ -287,8 +225,6 @@
     },
     {
         "BriefDescription": "Requests from the L2 hardware prefetchers tha=
t miss L2 cache.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.PF_MISS",
         "SampleAfterValue": "200003",
@@ -296,8 +232,6 @@
     },
     {
         "BriefDescription": "RFO requests that hit L2 cache.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_HIT",
         "SampleAfterValue": "200003",
@@ -305,8 +239,6 @@
     },
     {
         "BriefDescription": "RFO requests that miss L2 cache.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_MISS",
         "SampleAfterValue": "200003",
@@ -314,8 +246,6 @@
     },
     {
         "BriefDescription": "RFOs that access cache lines in any state.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x27",
         "EventName": "L2_STORE_LOCK_RQSTS.ALL",
         "SampleAfterValue": "200003",
@@ -323,8 +253,6 @@
     },
     {
         "BriefDescription": "RFOs that hit cache lines in E state.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x27",
         "EventName": "L2_STORE_LOCK_RQSTS.HIT_E",
         "SampleAfterValue": "200003",
@@ -332,8 +260,6 @@
     },
     {
         "BriefDescription": "RFOs that hit cache lines in M state.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x27",
         "EventName": "L2_STORE_LOCK_RQSTS.HIT_M",
         "SampleAfterValue": "200003",
@@ -341,8 +267,6 @@
     },
     {
         "BriefDescription": "RFOs that miss cache lines.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x27",
         "EventName": "L2_STORE_LOCK_RQSTS.MISS",
         "SampleAfterValue": "200003",
@@ -350,8 +274,6 @@
     },
     {
         "BriefDescription": "L2 or LLC HW prefetches that access L2 cache.=
",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF0",
         "EventName": "L2_TRANS.ALL_PF",
         "SampleAfterValue": "200003",
@@ -359,8 +281,6 @@
     },
     {
         "BriefDescription": "Transactions accessing L2 pipe.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF0",
         "EventName": "L2_TRANS.ALL_REQUESTS",
         "SampleAfterValue": "200003",
@@ -368,8 +288,6 @@
     },
     {
         "BriefDescription": "L2 cache accesses when fetching instructions.=
",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF0",
         "EventName": "L2_TRANS.CODE_RD",
         "SampleAfterValue": "200003",
@@ -377,8 +295,6 @@
     },
     {
         "BriefDescription": "Demand Data Read requests that access L2 cach=
e.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF0",
         "EventName": "L2_TRANS.DEMAND_DATA_RD",
         "SampleAfterValue": "200003",
@@ -386,8 +302,6 @@
     },
     {
         "BriefDescription": "L1D writebacks that access L2 cache.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF0",
         "EventName": "L2_TRANS.L1D_WB",
         "SampleAfterValue": "200003",
@@ -395,8 +309,6 @@
     },
     {
         "BriefDescription": "L2 fill requests that access L2 cache.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF0",
         "EventName": "L2_TRANS.L2_FILL",
         "SampleAfterValue": "200003",
@@ -404,8 +316,6 @@
     },
     {
         "BriefDescription": "L2 writebacks that access L2 cache.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF0",
         "EventName": "L2_TRANS.L2_WB",
         "SampleAfterValue": "200003",
@@ -413,8 +323,6 @@
     },
     {
         "BriefDescription": "RFO requests that access L2 cache.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF0",
         "EventName": "L2_TRANS.RFO",
         "SampleAfterValue": "200003",
@@ -422,8 +330,6 @@
     },
     {
         "BriefDescription": "Cycles when L1D is locked.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x63",
         "EventName": "LOCK_CYCLES.CACHE_LOCK_DURATION",
         "SampleAfterValue": "2000003",
@@ -431,8 +337,6 @@
     },
     {
         "BriefDescription": "Core-originated cacheable demand requests mis=
sed LLC.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2E",
         "EventName": "LONGEST_LAT_CACHE.MISS",
         "SampleAfterValue": "100003",
@@ -440,8 +344,6 @@
     },
     {
         "BriefDescription": "Core-originated cacheable demand requests tha=
t refer to LLC.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2E",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
         "SampleAfterValue": "100003",
@@ -449,8 +351,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were LLC=
 and cross-core snoop hits in on-pkg core cache.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT",
         "PublicDescription": "This event counts retired load uops that hit=
 in the last-level cache (L3) and were found in a non-modified state in a n=
eighboring core's private cache (same package).  Since the last level cache=
 is inclusive, hits to the L3 may require snooping the private L2 caches of=
 any cores on the same socket that have the line.  In this case, a snoop wa=
s required, and another L2 had the line in a non-modified state.",
@@ -459,8 +359,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were Hit=
M responses from shared LLC.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM",
         "PublicDescription": "This event counts retired load uops that hit=
 in the last-level cache (L3) and were found in a non-modified state in a n=
eighboring core's private cache (same package).  Since the last level cache=
 is inclusive, hits to the L3 may require snooping the private L2 caches of=
 any cores on the same socket that have the line.  In this case, a snoop wa=
s required, and another L2 had the line in a modified state, so the line ha=
d to be invalidated in that L2 cache and transferred to the requesting L2."=
,
@@ -469,8 +367,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were LLC=
 hit and cross-core snoop missed in on-pkg core cache.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS",
         "SampleAfterValue": "20011",
@@ -478,8 +374,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were hit=
s in LLC without snoops required.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_NONE",
         "SampleAfterValue": "100003",
@@ -487,8 +381,6 @@
     },
     {
         "BriefDescription": "Data from local DRAM either Snoop not needed =
or Snoop Miss (RspI)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD3",
         "EventName": "MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM",
         "SampleAfterValue": "100007",
@@ -496,8 +388,6 @@
     },
     {
         "BriefDescription": "Data from remote DRAM either Snoop not needed=
 or Snoop Miss (RspI)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD3",
         "EventName": "MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_DRAM",
         "SampleAfterValue": "100007",
@@ -505,8 +395,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were loa=
d uops missed L1 but hit FB due to preceding miss to the same cache line wi=
th data not ready.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.HIT_LFB",
         "PEBS": "1",
@@ -515,8 +403,6 @@
     },
     {
         "BriefDescription": "Retired load uops with L1 cache hits as data =
sources.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_HIT",
         "PEBS": "1",
@@ -525,8 +411,6 @@
     },
     {
         "BriefDescription": "Retired load uops with L2 cache hits as data =
sources.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
         "PEBS": "1",
@@ -535,8 +419,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were dat=
a hits in LLC without snoops required.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.LLC_HIT",
         "PublicDescription": "This event counts retired load uops that hit=
 in the last-level (L3) cache without snoops required.",
@@ -545,8 +427,6 @@
     },
     {
         "BriefDescription": "Miss in last-level (L3) cache. Excludes Unkno=
wn data-source.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.LLC_MISS",
         "SampleAfterValue": "100007",
@@ -554,8 +434,6 @@
     },
     {
         "BriefDescription": "All retired load uops.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
         "PEBS": "1",
@@ -565,8 +443,6 @@
     },
     {
         "BriefDescription": "All retired store uops.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
         "PEBS": "1",
@@ -576,8 +452,6 @@
     },
     {
         "BriefDescription": "Retired load uops with locked access.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.LOCK_LOADS",
         "PEBS": "1",
@@ -586,8 +460,6 @@
     },
     {
         "BriefDescription": "Retired load uops that split across a cacheli=
ne boundary.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
         "PEBS": "1",
@@ -597,8 +469,6 @@
     },
     {
         "BriefDescription": "Retired store uops that split across a cachel=
ine boundary.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
         "PEBS": "1",
@@ -608,8 +478,6 @@
     },
     {
         "BriefDescription": "Retired load uops that miss the STLB.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.STLB_MISS_LOADS",
         "PEBS": "1",
@@ -618,8 +486,6 @@
     },
     {
         "BriefDescription": "Retired store uops that miss the STLB.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.STLB_MISS_STORES",
         "PEBS": "1",
@@ -628,8 +494,6 @@
     },
     {
         "BriefDescription": "Demand and prefetch data reads.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.ALL_DATA_RD",
         "SampleAfterValue": "100003",
@@ -637,8 +501,6 @@
     },
     {
         "BriefDescription": "Cacheable and noncachaeble code read requests=
.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.DEMAND_CODE_RD",
         "SampleAfterValue": "100003",
@@ -646,8 +508,6 @@
     },
     {
         "BriefDescription": "Demand Data Read requests sent to uncore.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.DEMAND_DATA_RD",
         "SampleAfterValue": "100003",
@@ -655,8 +515,6 @@
     },
     {
         "BriefDescription": "Demand RFO requests including regular RFOs, l=
ocks, ItoM.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.DEMAND_RFO",
         "SampleAfterValue": "100003",
@@ -664,8 +522,6 @@
     },
     {
         "BriefDescription": "Cases when offcore requests buffer cannot tak=
e more entries for core.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB2",
         "EventName": "OFFCORE_REQUESTS_BUFFER.SQ_FULL",
         "SampleAfterValue": "2000003",
@@ -673,8 +529,6 @@
     },
     {
         "BriefDescription": "Offcore outstanding cacheable Core Data Read =
transactions in SuperQueue (SQ), queue to uncore.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD",
         "SampleAfterValue": "2000003",
@@ -682,8 +536,6 @@
     },
     {
         "BriefDescription": "Cycles when offcore outstanding cacheable Cor=
e Data Read transactions are present in SuperQueue (SQ), queue to uncore.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
@@ -692,8 +544,6 @@
     },
     {
         "BriefDescription": "Cycles when offcore outstanding Demand Data R=
ead transactions are present in SuperQueue (SQ), queue to uncore.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_DATA=
_RD",
@@ -702,8 +552,6 @@
     },
     {
         "BriefDescription": "Offcore outstanding demand rfo reads transact=
ions in SuperQueue (SQ), queue to uncore, every cycle.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO"=
,
@@ -712,8 +560,6 @@
     },
     {
         "BriefDescription": "Offcore outstanding Demand Data Read transact=
ions in uncore queue.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD",
         "SampleAfterValue": "2000003",
@@ -721,8 +567,6 @@
     },
     {
         "BriefDescription": "Cycles with at least 6 offcore outstanding De=
mand Data Read transactions in uncore queue.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "6",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD_C6",
@@ -731,8 +575,6 @@
     },
     {
         "BriefDescription": "Offcore outstanding RFO store transactions in=
 SuperQueue (SQ), queue to uncore.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_RFO",
         "SampleAfterValue": "2000003",
@@ -740,524 +582,393 @@
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x000105B3",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand & prefetch data reads that hit =
in the LLC and the snoop to one of the sibling cores hits the line in M sta=
te and the line is forwarded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_HIT.HITM_OTHER_CORE=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003c0091",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand & prefetch data reads that hit =
in the LLC and the snoops to sibling cores hit in either E/S state and the =
line is not forwarded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_HIT.HIT_OTHER_CORE_=
NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003c0091",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand & prefetch data reads that hit =
in the LLC and sibling core snoops are not needed as either the core-valid =
bit is not set or the shared line is present in multiple cores",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_HIT.NO_SNOOP_NEEDED=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003c0091",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand & prefetch data reads that hit =
in the LLC and sibling core snoop returned a clean response",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003c0091",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch data reads that hit the L=
LC",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.LLC_HIT.ANY_RESPONSE=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3f803c0090",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch data reads that hit in the LL=
C and the snoop to one of the sibling cores hits the line in M state and th=
e line is forwarded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.LLC_HIT.HITM_OTHER_C=
ORE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003c0090",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch data reads that hit in the LL=
C and the snoops to sibling cores hit in either E/S state and the line is n=
ot forwarded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.LLC_HIT.HIT_OTHER_CO=
RE_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003c0090",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch data reads that hit in the LL=
C and sibling core snoops are not needed as either the core-valid bit is no=
t set or the shared line is present in multiple cores",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.LLC_HIT.NO_SNOOP_NEE=
DED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003c0090",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch data reads that hit in the LL=
C and sibling core snoop returned a clean response",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.LLC_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003c0090",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all data/code/rfo references (demand &=
 prefetch)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x000107F7",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all data/code/rfo reads (demand & pref=
etch) that hit in the LLC",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3f803c03f7",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all data/code/rfo reads (demand & pref=
etch) that hit in the LLC and the snoop to one of the sibling cores hits th=
e line in M state and the line is forwarded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_HIT.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003c03f7",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all data/code/rfo reads (demand & pref=
etch) that hit in the LLC and the snoops to sibling cores hit in either E/S=
 state and the line is not forwarded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_HIT.HIT_OTHER_CORE_NO=
_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003c03f7",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all data/code/rfo reads (demand & pref=
etch) that hit in the LLC and sibling core snoops are not needed as either =
the core-valid bit is not set or the shared line is present in multiple cor=
es",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_HIT.NO_SNOOP_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003c03f7",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all data/code/rfo reads (demand & pref=
etch) that hit in the LLC and sibling core snoop returned a clean response"=
,
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003c03f7",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch prefetch RFOs",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00010122",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all writebacks from the core to the LL=
C",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.COREWB.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10008",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00010004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads that hit in the =
LLC",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.LLC_HIT.ANY_RESPONSE=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3f803c0004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00010001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand data reads that hit in the =
LLC",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_HIT.ANY_RESPONSE=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3f803c0001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that hit in the LLC =
and the snoop to one of the sibling cores hits the line in M state and the =
line is forwarded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_HIT.HITM_OTHER_C=
ORE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003c0001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that hit in the LLC =
and the snoops to sibling cores hit in either E/S state and the line is not=
 forwarded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_HIT.HIT_OTHER_CO=
RE_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003c0001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that hit in the LLC =
and sibling core snoops are not needed as either the core-valid bit is not =
set or the shared line is present in multiple cores",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_HIT.NO_SNOOP_NEE=
DED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003c0001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that hit in the LLC =
and sibling core snoop returned a clean response",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003c0001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand rfo's",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00010002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 hints sent to LLC to keep a line fr=
om being evicted out of the core caches",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.LRU_HINTS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803c8000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts miscellaneous accesses that include po=
rt i/o, MMIO and uncacheable memory accesses",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.PORTIO_MMIO_UC",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23ffc08000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) c=
ode reads that hit in the LLC",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.LLC_HIT.ANY_RESPONSE"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3f803c0040",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads that hit in the LLC",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.LLC_HIT.ANY_RESPONSE"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3f803c0010",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads that hit in the LLC and the snoop to one of the sibling cores hits th=
e line in M state and the line is forwarded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.LLC_HIT.HITM_OTHER_CO=
RE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003c0010",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads that hit in the LLC and the snoops to sibling cores hit in either E/S=
 state and the line is not forwarded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.LLC_HIT.HIT_OTHER_COR=
E_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003c0010",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads that hit in the LLC and sibling core snoops are not needed as either =
the core-valid bit is not set or the shared line is present in multiple cor=
es",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.LLC_HIT.NO_SNOOP_NEED=
ED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003c0010",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads that hit in the LLC and the snoops sent to sibling cores return clean=
 response",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.LLC_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003c0010",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads that hit in the LLC",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_LLC_CODE_RD.LLC_HIT.ANY_RESPONSE=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3f803c0200",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 data reads that hit in the LLC",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_LLC_DATA_RD.LLC_HIT.ANY_RESPONSE=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3f803c0080",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 data reads that hit in the LLC and the snoop to one of the sibling cores h=
its the line in M state and the line is forwarded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_LLC_DATA_RD.LLC_HIT.HITM_OTHER_C=
ORE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003c0080",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 data reads that hit in the LLC and the snoops to sibling cores hit in eith=
er E/S state and the line is not forwarded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_LLC_DATA_RD.LLC_HIT.HIT_OTHER_CO=
RE_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003c0080",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 data reads that hit in the LLC and sibling core snoops are not needed as e=
ither the core-valid bit is not set or the shared line is present in multip=
le cores",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_LLC_DATA_RD.LLC_HIT.NO_SNOOP_NEE=
DED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003c0080",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 data reads that hit in the LLC and the snoops sent to sibling cores return=
 clean response",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_LLC_DATA_RD.LLC_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003c0080",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts requests where the address of an atomi=
c lock instruction spans a cache line boundary or the lock instruction is e=
xecuted on uncacheable address",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.SPLIT_LOCK_UC_LOCK.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10400",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts non-temporal stores",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.STREAMING_STORES.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10800",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Split locks in SQ.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF4",
         "EventName": "SQ_MISC.SPLIT_LOCK",
         "SampleAfterValue": "100003",
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/floating-point.json b/=
tools/perf/pmu-events/arch/x86/jaketown/floating-point.json
index eb2ff2cfdf6b..8c2a246adef9 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/floating-point.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Cycles with any input/output SSE or FP assist=
.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xCA",
         "EventName": "FP_ASSIST.ANY",
@@ -11,8 +9,6 @@
     },
     {
         "BriefDescription": "Number of SIMD FP assists due to input values=
.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xCA",
         "EventName": "FP_ASSIST.SIMD_INPUT",
         "SampleAfterValue": "100003",
@@ -20,8 +16,6 @@
     },
     {
         "BriefDescription": "Number of SIMD FP assists due to Output value=
s.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xCA",
         "EventName": "FP_ASSIST.SIMD_OUTPUT",
         "SampleAfterValue": "100003",
@@ -29,8 +23,6 @@
     },
     {
         "BriefDescription": "Number of X87 assists due to input value.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xCA",
         "EventName": "FP_ASSIST.X87_INPUT",
         "SampleAfterValue": "100003",
@@ -38,8 +30,6 @@
     },
     {
         "BriefDescription": "Number of X87 assists due to output value.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xCA",
         "EventName": "FP_ASSIST.X87_OUTPUT",
         "SampleAfterValue": "100003",
@@ -47,8 +37,6 @@
     },
     {
         "BriefDescription": "Number of SSE* or AVX-128 FP Computational pa=
cked double-precision uops issued this cycle.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x10",
         "EventName": "FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE",
         "SampleAfterValue": "2000003",
@@ -56,8 +44,6 @@
     },
     {
         "BriefDescription": "Number of SSE* or AVX-128 FP Computational pa=
cked single-precision uops issued this cycle.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x10",
         "EventName": "FP_COMP_OPS_EXE.SSE_PACKED_SINGLE",
         "SampleAfterValue": "2000003",
@@ -65,8 +51,6 @@
     },
     {
         "BriefDescription": "Number of SSE* or AVX-128 FP Computational sc=
alar double-precision uops issued this cycle.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x10",
         "EventName": "FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE",
         "SampleAfterValue": "2000003",
@@ -74,8 +58,6 @@
     },
     {
         "BriefDescription": "Number of SSE* or AVX-128 FP Computational sc=
alar single-precision uops issued this cycle.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x10",
         "EventName": "FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE",
         "SampleAfterValue": "2000003",
@@ -83,8 +65,6 @@
     },
     {
         "BriefDescription": "Number of FP Computational Uops Executed this=
 cycle. The number of FADD, FSUB, FCOM, FMULs, integer MULsand IMULs, FDIVs=
, FPREMs, FSQRTS, integer DIVs, and IDIVs. This event does not distinguish =
an FADD used in the middle of a transcendental flow from a s.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x10",
         "EventName": "FP_COMP_OPS_EXE.X87",
         "SampleAfterValue": "2000003",
@@ -92,8 +72,6 @@
     },
     {
         "BriefDescription": "Number of GSSE memory assist for stores. GSSE=
 microcode assist is being invoked whenever the hardware is unable to prope=
rly handle GSSE-256b operations.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC1",
         "EventName": "OTHER_ASSISTS.AVX_STORE",
         "SampleAfterValue": "100003",
@@ -101,8 +79,6 @@
     },
     {
         "BriefDescription": "Number of transitions from AVX-256 to legacy =
SSE when penalty applicable.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC1",
         "EventName": "OTHER_ASSISTS.AVX_TO_SSE",
         "SampleAfterValue": "100003",
@@ -110,8 +86,6 @@
     },
     {
         "BriefDescription": "Number of transitions from SSE to AVX-256 whe=
n penalty applicable.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC1",
         "EventName": "OTHER_ASSISTS.SSE_TO_AVX",
         "SampleAfterValue": "100003",
@@ -119,8 +93,6 @@
     },
     {
         "BriefDescription": "Number of AVX-256 Computational FP double pre=
cision uops issued this cycle.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x11",
         "EventName": "SIMD_FP_256.PACKED_DOUBLE",
         "SampleAfterValue": "2000003",
@@ -128,8 +100,6 @@
     },
     {
         "BriefDescription": "Number of GSSE-256 Computational FP single pr=
ecision uops issued this cycle.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x11",
         "EventName": "SIMD_FP_256.PACKED_SINGLE",
         "SampleAfterValue": "2000003",
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/frontend.json b/tools/=
perf/pmu-events/arch/x86/jaketown/frontend.json
index 0b4dbce2f1c0..3f4fc3481112 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/frontend.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Counts the total number when the front end is=
 resteered, mainly when the BPU cannot provide a correct prediction and thi=
s is corrected by other branch handling mechanisms at the front end.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xE6",
         "EventName": "BACLEARS.ANY",
         "SampleAfterValue": "100003",
@@ -10,8 +8,6 @@
     },
     {
         "BriefDescription": "Decode Stream Buffer (DSB)-to-MITE switches."=
,
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xAB",
         "EventName": "DSB2MITE_SWITCHES.COUNT",
         "SampleAfterValue": "2000003",
@@ -19,8 +15,6 @@
     },
     {
         "BriefDescription": "Decode Stream Buffer (DSB)-to-MITE switch tru=
e penalty cycles.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xAB",
         "EventName": "DSB2MITE_SWITCHES.PENALTY_CYCLES",
         "PublicDescription": "This event counts the cycles attributed to a=
 switch from the Decoded Stream Buffer (DSB), which holds decoded instructi=
ons, to the legacy decode pipeline.  It excludes cycles when the back-end c=
annot  accept new micro-ops.  The penalty for these switches is potentially=
 several cycles of instruction starvation, where no micro-ops are delivered=
 to the back-end.",
@@ -29,8 +23,6 @@
     },
     {
         "BriefDescription": "Cases of cancelling valid Decode Stream Buffe=
r (DSB) fill not because of exceeding way limit.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xAC",
         "EventName": "DSB_FILL.ALL_CANCEL",
         "SampleAfterValue": "2000003",
@@ -38,8 +30,6 @@
     },
     {
         "BriefDescription": "Cycles when Decode Stream Buffer (DSB) fill e=
ncounter more than 3 Decode Stream Buffer (DSB) lines.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xAC",
         "EventName": "DSB_FILL.EXCEED_DSB_LINES",
         "SampleAfterValue": "2000003",
@@ -47,8 +37,6 @@
     },
     {
         "BriefDescription": "Cases of cancelling valid DSB fill not becaus=
e of exceeding way limit.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xAC",
         "EventName": "DSB_FILL.OTHER_CANCEL",
         "SampleAfterValue": "2000003",
@@ -56,8 +44,6 @@
     },
     {
         "BriefDescription": "Number of Instruction Cache, Streaming Buffer=
 and Victim Cache Reads. both cacheable and noncacheable, including UC fetc=
hes.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x80",
         "EventName": "ICACHE.HIT",
         "SampleAfterValue": "2000003",
@@ -65,8 +51,6 @@
     },
     {
         "BriefDescription": "Instruction cache, streaming buffer and victi=
m cache misses.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x80",
         "EventName": "ICACHE.MISSES",
         "PublicDescription": "This event counts the number of instruction =
cache, streaming buffer and victim cache misses. Counting includes unchache=
able accesses.",
@@ -75,8 +59,6 @@
     },
     {
         "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng 4 Uops.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_DSB_CYCLES_4_UOPS",
@@ -85,8 +67,6 @@
     },
     {
         "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng any Uop.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_DSB_CYCLES_ANY_UOPS",
@@ -95,8 +75,6 @@
     },
     {
         "BriefDescription": "Cycles MITE is delivering 4 Uops.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_MITE_CYCLES_4_UOPS",
@@ -105,8 +83,6 @@
     },
     {
         "BriefDescription": "Cycles MITE is delivering any Uop.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_MITE_CYCLES_ANY_UOPS",
@@ -115,8 +91,6 @@
     },
     {
         "BriefDescription": "Cycles when uops are being delivered to Instr=
uction Decode Queue (IDQ) from Decode Stream Buffer (DSB) path.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES",
@@ -125,8 +99,6 @@
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from the Decode Stream Buffer (DSB) path.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_UOPS",
         "SampleAfterValue": "2000003",
@@ -134,8 +106,6 @@
     },
     {
         "BriefDescription": "Instruction Decode Queue (IDQ) empty cycles."=
,
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.EMPTY",
         "SampleAfterValue": "2000003",
@@ -143,8 +113,6 @@
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from MITE path.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_ALL_UOPS",
         "SampleAfterValue": "2000003",
@@ -152,8 +120,6 @@
     },
     {
         "BriefDescription": "Cycles when uops are being delivered to Instr=
uction Decode Queue (IDQ) from MITE path.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_CYCLES",
@@ -162,8 +128,6 @@
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from MITE path.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_UOPS",
         "SampleAfterValue": "2000003",
@@ -171,8 +135,6 @@
     },
     {
         "BriefDescription": "Cycles when uops are being delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_CYCLES",
@@ -182,8 +144,6 @@
     },
     {
         "BriefDescription": "Cycles when uops initiated by Decode Stream B=
uffer (DSB) are being delivered to Instruction Decode Queue (IDQ) while Mic=
rocode Sequenser (MS) is busy.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_DSB_CYCLES",
@@ -192,8 +152,6 @@
     },
     {
         "BriefDescription": "Deliveries to Instruction Decode Queue (IDQ) =
initiated by Decode Stream Buffer (DSB) while Microcode Sequenser (MS) is b=
usy.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x79",
@@ -203,8 +161,6 @@
     },
     {
         "BriefDescription": "Uops initiated by Decode Stream Buffer (DSB) =
that are being delivered to Instruction Decode Queue (IDQ) while Microcode =
Sequenser (MS) is busy.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_DSB_UOPS",
         "SampleAfterValue": "2000003",
@@ -212,8 +168,6 @@
     },
     {
         "BriefDescription": "Uops initiated by MITE and delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_MITE_UOPS",
         "SampleAfterValue": "2000003",
@@ -221,8 +175,6 @@
     },
     {
         "BriefDescription": "Number of switches from DSB (Decode Stream Bu=
ffer) or MITE (legacy decode pipeline) to the Microcode Sequencer.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x79",
@@ -232,8 +184,6 @@
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) while Microcode Sequenser (MS) is busy.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_UOPS",
         "SampleAfterValue": "2000003",
@@ -241,8 +191,6 @@
     },
     {
         "BriefDescription": "Uops not delivered to Resource Allocation Tab=
le (RAT) per thread when backend of the machine is not stalled .",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0x9C",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
         "PublicDescription": "This event counts the number of uops not del=
ivered to the back-end per cycle, per thread, when the back-end was not sta=
lled.  In the ideal case 4 uops can be delivered each cycle.  The event cou=
nts the undelivered uops - so if 3 were delivered in one cycle, the counter=
 would be incremented by 1 for that cycle (4 - 3). If the back-end is stall=
ed, the count for this event is not incremented even when uops were not del=
ivered, because the back-end would not have been able to accept them.  This=
 event is used in determining the front-end bound category of the top-down =
pipeline slots characterization.",
@@ -251,8 +199,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when 4 or more uops are not=
 delivered to Resource Allocation Table (RAT) when backend of the machine i=
s not stalled.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "4",
         "EventCode": "0x9C",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE",
@@ -261,8 +207,6 @@
     },
     {
         "BriefDescription": "Counts cycles FE delivered 4 uops or Resource=
 Allocation Table (RAT) was stalling FE.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x9C",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK",
@@ -272,8 +216,6 @@
     },
     {
         "BriefDescription": "Cycles when 1 or more uops were delivered to =
the by the front end.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "4",
         "EventCode": "0x9C",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_GE_1_UOP_DELIV.CORE",
@@ -283,8 +225,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when 3 or more uops are not=
 delivered to Resource Allocation Table (RAT) when backend of the machine i=
s not stalled.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "3",
         "EventCode": "0x9C",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_LE_1_UOP_DELIV.CORE",
@@ -293,8 +233,6 @@
     },
     {
         "BriefDescription": "Cycles with less than 2 uops delivered by the=
 front end.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "2",
         "EventCode": "0x9C",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_LE_2_UOP_DELIV.CORE",
@@ -303,8 +241,6 @@
     },
     {
         "BriefDescription": "Cycles with less than 3 uops delivered by the=
 front end.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x9C",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_LE_3_UOP_DELIV.CORE",
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json b/too=
ls/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
index 554f87c03c05..cb1420df3768 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
@@ -65,7 +65,7 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
-        "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * =
((INT_MISC.RECOVERY_CYCLES_ANY / 2) if #SMT_on else INT_MISC.RECOVERY_CYCLE=
S)) / SLOTS",
+        "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * =
(INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)=
) / SLOTS",
         "MetricGroup": "TopdownL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
@@ -73,7 +73,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction",
-        "MetricExpr": "(BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRED.AL=
L_BRANCHES + MACHINE_CLEARS.COUNT)) * tma_bad_speculation",
+        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRED.ALL=
_BRANCHES + MACHINE_CLEARS.COUNT) * tma_bad_speculation",
         "MetricGroup": "BadSpec;BrMispredicts;TopdownL2;tma_L2_group;tma_b=
ad_speculation_group",
         "MetricName": "tma_branch_mispredicts",
         "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES",
@@ -97,7 +97,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
-        "MetricExpr": "((min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.STALL=
S_L1D_PENDING) + RESOURCE_STALLS.SB) / (min(CPU_CLK_UNHALTED.THREAD, CYCLE_=
ACTIVITY.CYCLES_NO_DISPATCH) + cpu@UOPS_DISPATCHED.THREAD\\,cmask\\=3D1@ - =
cpu@UOPS_DISPATCHED.THREAD\\,cmask\\=3D3@ if (IPC > 1.8) else cpu@UOPS_DISP=
ATCHED.THREAD\\,cmask\\=3D2@ - RS_EVENTS.EMPTY_CYCLES if (tma_fetch_latency=
 > 0.1) else RESOURCE_STALLS.SB)) * tma_backend_bound",
+        "MetricExpr": "(min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.STALLS=
_L1D_PENDING) + RESOURCE_STALLS.SB) / (min(CPU_CLK_UNHALTED.THREAD, CYCLE_A=
CTIVITY.CYCLES_NO_DISPATCH) + cpu@UOPS_DISPATCHED.THREAD\\,cmask\\=3D1@ - c=
pu@UOPS_DISPATCHED.THREAD\\,cmask\\=3D3@ if IPC > 1.8 else (cpu@UOPS_DISPAT=
CHED.THREAD\\,cmask\\=3D2@ - RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > =
0.1 else RESOURCE_STALLS.SB)) * tma_backend_bound",
         "MetricGroup": "Backend;TopdownL2;tma_L2_group;tma_backend_bound_g=
roup",
         "MetricName": "tma_memory_bound",
         "PublicDescription": "This metric represents fraction of slots the=
 Memory subsystem within the Backend was a bottleneck.  Memory Bound estima=
tes fraction of slots where pipeline is likely stalled due to demand load o=
r store instructions. This accounts mainly for (1) non-completed in-flight =
memory demand loads which coincides with execution units starvation; in add=
ition to (2) cases where stores could impose backpressure on the pipeline w=
hen many of them get buffered at the same time (less common out of the two)=
.",
@@ -113,7 +113,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
-        "MetricExpr": "(MEM_LOAD_UOPS_RETIRED.LLC_HIT / (MEM_LOAD_UOPS_RET=
IRED.LLC_HIT + 7 * MEM_LOAD_UOPS_RETIRED.LLC_MISS)) * CYCLE_ACTIVITY.STALLS=
_L2_PENDING / CLKS",
+        "MetricExpr": "MEM_LOAD_UOPS_RETIRED.LLC_HIT / (MEM_LOAD_UOPS_RETI=
RED.LLC_HIT + 7 * MEM_LOAD_UOPS_RETIRED.LLC_MISS) * CYCLE_ACTIVITY.STALLS_L=
2_PENDING / CLKS",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_mem=
ory_bound_group",
         "MetricName": "tma_l3_bound",
         "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT_PS",
@@ -121,7 +121,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
-        "MetricExpr": "(1 - (MEM_LOAD_UOPS_RETIRED.LLC_HIT / (MEM_LOAD_UOP=
S_RETIRED.LLC_HIT + 7 * MEM_LOAD_UOPS_RETIRED.LLC_MISS))) * CYCLE_ACTIVITY.=
STALLS_L2_PENDING / CLKS",
+        "MetricExpr": "(1 - MEM_LOAD_UOPS_RETIRED.LLC_HIT / (MEM_LOAD_UOPS=
_RETIRED.LLC_HIT + 7 * MEM_LOAD_UOPS_RETIRED.LLC_MISS)) * CYCLE_ACTIVITY.ST=
ALLS_L2_PENDING / CLKS",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_memory_bound_gr=
oup",
         "MetricName": "tma_dram_bound",
         "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_UOPS_RE=
TIRED.L3_MISS_PS",
@@ -169,7 +169,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
-        "MetricExpr": "((min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLE=
S_NO_DISPATCH) + cpu@UOPS_DISPATCHED.THREAD\\,cmask\\=3D1@ - cpu@UOPS_DISPA=
TCHED.THREAD\\,cmask\\=3D3@ if (IPC > 1.8) else cpu@UOPS_DISPATCHED.THREAD\=
\,cmask\\=3D2@ - RS_EVENTS.EMPTY_CYCLES if (tma_fetch_latency > 0.1) else R=
ESOURCE_STALLS.SB) - RESOURCE_STALLS.SB - min(CPU_CLK_UNHALTED.THREAD, CYCL=
E_ACTIVITY.STALLS_L1D_PENDING)) / CLKS",
+        "MetricExpr": "((min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLE=
S_NO_DISPATCH) + cpu@UOPS_DISPATCHED.THREAD\\,cmask\\=3D1@ - cpu@UOPS_DISPA=
TCHED.THREAD\\,cmask\\=3D3@ if IPC > 1.8 else (cpu@UOPS_DISPATCHED.THREAD\\=
,cmask\\=3D2@ - RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else RESO=
URCE_STALLS.SB)) - RESOURCE_STALLS.SB - min(CPU_CLK_UNHALTED.THREAD, CYCLE_=
ACTIVITY.STALLS_L1D_PENDING)) / CLKS",
         "MetricGroup": "PortsUtil;TopdownL3;tma_core_bound_group",
         "MetricName": "tma_ports_utilization",
         "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations.",
@@ -233,7 +233,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU was retiring uops fetched by the Microcode Sequencer (MS) unit",
-        "MetricExpr": "(UOPS_RETIRED.RETIRE_SLOTS / UOPS_ISSUED.ANY) * IDQ=
.MS_UOPS / SLOTS",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / UOPS_ISSUED.ANY * IDQ.M=
S_UOPS / SLOTS",
         "MetricGroup": "MicroSeq;TopdownL3;tma_heavy_operations_group",
         "MetricName": "tma_microcode_sequencer",
         "PublicDescription": "This metric represents fraction of slots the=
 CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The M=
S is used for CISC instructions not supported by the default decoders (like=
 repeat move strings; or CPUID); or by microcode assists used to address so=
me operation modes (like in Floating Point assists). These cases can often =
be avoided. Sample with: IDQ.MS_UOPS",
@@ -284,19 +284,19 @@
     },
     {
         "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricExpr": "(1 * (FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_O=
PS_EXE.SSE_SCALAR_DOUBLE) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * (FP=
_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE) + 8 * SIMD_FP_=
256.PACKED_SINGLE) / CORE_CLKS",
+        "MetricExpr": "(FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EX=
E.SSE_SCALAR_DOUBLE + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * (FP_COMP_=
OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE) + 8 * SIMD_FP_256.PA=
CKED_SINGLE) / CORE_CLKS",
         "MetricGroup": "Flops;Ret",
         "MetricName": "FLOPc"
     },
     {
         "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
-        "MetricExpr": "UOPS_DISPATCHED.THREAD / ((cpu@UOPS_DISPATCHED.CORE=
\\,cmask\\=3D1@ / 2) if #SMT_on else cpu@UOPS_DISPATCHED.CORE\\,cmask\\=3D1=
@)",
+        "MetricExpr": "UOPS_DISPATCHED.THREAD / (cpu@UOPS_DISPATCHED.CORE\=
\,cmask\\=3D1@ / 2 if #SMT_on else cpu@UOPS_DISPATCHED.CORE\\,cmask\\=3D1@)=
",
         "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
         "MetricName": "ILP"
     },
     {
         "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
-        "MetricExpr": "((CPU_CLK_UNHALTED.THREAD / 2) * (1 + CPU_CLK_UNHAL=
TED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK)) if #core_wide < 1 else =
(CPU_CLK_UNHALTED.THREAD_ANY / 2) if #SMT_on else CLKS",
+        "MetricExpr": "(CPU_CLK_UNHALTED.THREAD / 2 * (1 + CPU_CLK_UNHALTE=
D.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK) if #core_wide < 1 else (CP=
U_CLK_UNHALTED.THREAD_ANY / 2 if #SMT_on else CLKS))",
         "MetricGroup": "SMT",
         "MetricName": "CORE_CLKS"
     },
@@ -314,25 +314,25 @@
     },
     {
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
-        "MetricExpr": "IDQ.DSB_UOPS / ((IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE=
_UOPS + IDQ.MS_UOPS))",
+        "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_=
UOPS + IDQ.MS_UOPS)",
         "MetricGroup": "DSB;Fed;FetchBW",
         "MetricName": "DSB_Coverage"
     },
     {
         "BriefDescription": "Average CPU Utilization",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
         "MetricGroup": "HPC;Summary",
         "MetricName": "CPU_Utilization"
     },
     {
         "BriefDescription": "Measured Average Frequency for unhalted proce=
ssors [GHz]",
-        "MetricExpr": "Turbo_Utilization * msr@tsc@ / 1000000000 / duratio=
n_time",
+        "MetricExpr": "Turbo_Utilization * TSC / 1e9 / duration_time",
         "MetricGroup": "Power;Summary",
         "MetricName": "Average_Frequency"
     },
     {
         "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "((1 * (FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_=
OPS_EXE.SSE_SCALAR_DOUBLE) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * (F=
P_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE) + 8 * SIMD_FP=
_256.PACKED_SINGLE) / 1000000000) / duration_time",
+        "MetricExpr": "(FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EX=
E.SSE_SCALAR_DOUBLE + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * (FP_COMP_=
OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE) + 8 * SIMD_FP_256.PA=
CKED_SINGLE) / 1e9 / duration_time",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "GFLOPs",
         "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine."
@@ -345,7 +345,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
-        "MetricExpr": "1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / (CPU_CLK_U=
NHALTED.REF_XCLK_ANY / 2) if #SMT_on else 0",
+        "MetricExpr": "(1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / (CPU_CLK_=
UNHALTED.REF_XCLK_ANY / 2) if #SMT_on else 0)",
         "MetricGroup": "SMT",
         "MetricName": "SMT_2T_Utilization"
     },
@@ -363,10 +363,22 @@
     },
     {
         "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
-        "MetricExpr": "(64 * (uncore_imc@cas_count_read@ + uncore_imc@cas_=
count_write@) / 1000000000) / duration_time",
+        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e=
9 / duration_time",
         "MetricGroup": "HPC;Mem;MemoryBW;SoC",
         "MetricName": "DRAM_BW_Use"
     },
+    {
+        "BriefDescription": "Average latency of data read request to exter=
nal memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetches=
",
+        "MetricExpr": "1e9 * (UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=
=3D0x182@ / UNC_C_TOR_INSERTS.MISS_OPCODE@filter_opc\\=3D0x182@) / (Socket_=
CLKS / duration_time)",
+        "MetricGroup": "Mem;MemoryLat;SoC",
+        "MetricName": "MEM_Read_Latency"
+    },
+    {
+        "BriefDescription": "Average number of parallel data read requests=
 to external memory. Accounts for demand loads and L1/L2 prefetches",
+        "MetricExpr": "UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=3D0x18=
2@ / UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=3D0x182\\,thresh\\=3D1@",
+        "MetricGroup": "Mem;MemoryBW;SoC",
+        "MetricName": "MEM_Parallel_Reads"
+    },
     {
         "BriefDescription": "Socket actual clocks when any core is active =
on that socket",
         "MetricExpr": "cbox_0@event\\=3D0x0@",
@@ -379,52 +391,59 @@
         "MetricGroup": "Branches;OS",
         "MetricName": "IpFarBranch"
     },
+    {
+        "BriefDescription": "Uncore frequency per die [GHZ]",
+        "MetricExpr": "Socket_CLKS / #num_dies / duration_time / 1e9",
+        "MetricGroup": "SoC",
+        "MetricName": "UNCORE_FREQ"
+    },
     {
         "BriefDescription": "C3 residency percent per core",
-        "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
+        "MetricExpr": "cstate_core@c3\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C3_Core_Residency"
+        "MetricName": "C3_Core_Residency",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C6 residency percent per core",
-        "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
+        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C6_Core_Residency"
+        "MetricName": "C6_Core_Residency",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C7 residency percent per core",
-        "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
+        "MetricExpr": "cstate_core@c7\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C7_Core_Residency"
+        "MetricName": "C7_Core_Residency",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C2 residency percent per package",
-        "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
+        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C2_Pkg_Residency"
+        "MetricName": "C2_Pkg_Residency",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C3 residency percent per package",
-        "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
+        "MetricExpr": "cstate_pkg@c3\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C3_Pkg_Residency"
+        "MetricName": "C3_Pkg_Residency",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C6 residency percent per package",
-        "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
+        "MetricExpr": "cstate_pkg@c6\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C6_Pkg_Residency"
+        "MetricName": "C6_Pkg_Residency",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C7 residency percent per package",
-        "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
+        "MetricExpr": "cstate_pkg@c7\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C7_Pkg_Residency"
-    },
-    {
-        "BriefDescription": "Uncore frequency per die [GHZ]",
-        "MetricExpr": "Socket_CLKS / #num_dies / duration_time / 100000000=
0",
-        "MetricGroup": "SoC",
-        "MetricName": "UNCORE_FREQ"
+        "MetricName": "C7_Pkg_Residency",
+        "ScaleUnit": "100%"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/memory.json b/tools/pe=
rf/pmu-events/arch/x86/jaketown/memory.json
index 23756ca9b7da..a71e630fd030 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/memory.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/memory.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Counts the number of machine clears due to me=
mory order conflicts.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
         "PublicDescription": "This event counts the number of memory order=
ing Machine Clears detected. Memory Ordering Machine Clears can result from=
 memory disambiguation, external snoops, or cross SMT-HW-thread snoop (stor=
es) hitting load buffers.  Machine clears can have a significant performanc=
e impact if they are happening frequently.",
@@ -11,124 +9,94 @@
     },
     {
         "BriefDescription": "Loads with latency value being above 128.",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "EventCode": "0xCD",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x80",
         "PEBS": "2",
         "SampleAfterValue": "1009",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Loads with latency value being above 16.",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "EventCode": "0xCD",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x10",
         "PEBS": "2",
         "SampleAfterValue": "20011",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Loads with latency value being above 256.",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "EventCode": "0xCD",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x100",
         "PEBS": "2",
         "SampleAfterValue": "503",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Loads with latency value being above 32.",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "EventCode": "0xCD",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x20",
         "PEBS": "2",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Loads with latency value being above 4 .",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "EventCode": "0xCD",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x4",
         "PEBS": "2",
         "SampleAfterValue": "100003",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Loads with latency value being above 512.",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "EventCode": "0xCD",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x200",
         "PEBS": "2",
         "SampleAfterValue": "101",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Loads with latency value being above 64.",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "EventCode": "0xCD",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x40",
         "PEBS": "2",
         "SampleAfterValue": "2003",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Loads with latency value being above 8.",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "EventCode": "0xCD",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x8",
         "PEBS": "2",
         "SampleAfterValue": "50021",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Sample stores and collect precise store opera=
tion via PEBS record. PMC3 only. (Precise Event - PEBS).",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "EventCode": "0xCD",
         "EventName": "MEM_TRANS_RETIRED.PRECISE_STORE",
         "PEBS": "2",
-        "PRECISE_STORE": "1",
         "SampleAfterValue": "2000003",
-        "TakenAlone": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Speculative cache line split load uops dispat=
ched to L1 cache.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x05",
         "EventName": "MISALIGN_MEM_REF.LOADS",
         "SampleAfterValue": "2000003",
@@ -136,8 +104,6 @@
     },
     {
         "BriefDescription": "Speculative cache line split STA uops dispatc=
hed to L1 cache.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x05",
         "EventName": "MISALIGN_MEM_REF.STORES",
         "SampleAfterValue": "2000003",
@@ -145,277 +111,208 @@
     },
     {
         "BriefDescription": "This event counts all LLC misses for all dema=
nd and L2 prefetches. LLC prefetches are excluded.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DEMAND_MLC_PREF_READS.LLC_MISS.=
ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC20077",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all local dram accesses for all demand=
 and L2 prefetches. LLC prefetches are excluded.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DEMAND_MLC_PREF_READS.LLC_MISS.=
LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x600400077",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "This event counts all remote cache-to-cache t=
ransfers (includes HITM and HIT-Forward) for all demand and L2 prefetches. =
LLC prefetches are excluded.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DEMAND_MLC_PREF_READS.LLC_MISS.=
REMOTE_HITM_HIT_FORWARD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x187FC20077",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads that miss the LL=
C",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.LLC_MISS.ANY_RESPONS=
E",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3fffc20004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads that miss the LL=
C  and the data returned from local dram",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.LLC_MISS.LOCAL_DRAM"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x600400004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads that miss the LL=
C  and the data returned from remote dram",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.LLC_MISS.REMOTE_DRAM=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x67f800004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads that miss the LL=
C  the data is found in M state in remote cache and forwarded from there",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.LLC_MISS.REMOTE_HITM=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x107fc00004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code reads that miss the LL=
C  and the data forwarded from remote cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.LLC_MISS.REMOTE_HIT_=
FORWARD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x87f820004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that miss the LLC  a=
nd the data returned from remote & local dram",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_MISS.ANY_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x67fc00001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that miss in the LLC=
",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_MISS.ANY_RESPONS=
E",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3fffc20001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that miss the LLC  a=
nd the data returned from local dram",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_MISS.LOCAL_DRAM"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x600400001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that miss the LLC  a=
nd the data returned from remote dram",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_MISS.REMOTE_DRAM=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x67f800001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that miss the LLC  t=
he data is found in M state in remote cache and forwarded from there",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_MISS.REMOTE_HITM=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x107fc00001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that miss the LLC  a=
nd the data forwarded from remote cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_MISS.REMOTE_HIT_=
FORWARD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x87f820001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) c=
ode reads that miss the LLC  and the data returned from remote & local dram=
",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.LLC_MISS.ANY_RESPONSE=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3fffc20040",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads that miss the LLC  and the data returned from remote & local dram",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.LLC_MISS.ANY_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x67fc00010",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads that miss in the LLC",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.LLC_MISS.ANY_RESPONSE=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3fffc20010",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads that miss the LLC  and the data returned from local dram",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.LLC_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x600400010",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads  that miss the LLC  and the data returned from remote dram",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.LLC_MISS.REMOTE_DRAM"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x67f800010",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads that miss the LLC  the data is found in M state in remote cache and f=
orwarded from there",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.LLC_MISS.REMOTE_HITM"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x107fc00010",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads that miss the LLC  and the data forwarded from remote cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.LLC_MISS.REMOTE_HIT_F=
ORWARD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x87f820010",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads that miss in the LLC",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_LLC_CODE_RD.LLC_MISS.ANY_RESPONS=
E",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3fffc20200",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 data reads that hit in the LLC and the snoops sent to sibling cores return=
 clean response",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_LLC_DATA_RD.LLC_MISS.ANY_RESPONS=
E",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3fffc20080",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     }
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/other.json b/tools/per=
f/pmu-events/arch/x86/jaketown/other.json
index 2f873ab14156..9f96121baef8 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/other.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/other.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Unhalted core cycles when the thread is in ri=
ng 0.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5C",
         "EventName": "CPL_CYCLES.RING0",
         "SampleAfterValue": "2000003",
@@ -10,8 +8,6 @@
     },
     {
         "BriefDescription": "Number of intervals between processor halts w=
hile thread is in ring 0.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x5C",
@@ -21,8 +17,6 @@
     },
     {
         "BriefDescription": "Unhalted core cycles when thread is in rings =
1, 2, or 3.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5C",
         "EventName": "CPL_CYCLES.RING123",
         "SampleAfterValue": "2000003",
@@ -30,8 +24,6 @@
     },
     {
         "BriefDescription": "Hardware Prefetch requests that miss the L1D =
cache. This accounts for both L1 streamer and IP-based (IPP) HW prefetchers=
. A request is being counted each time it access the cache & miss it, inclu=
ding if a block is applicable or if hit the Fill Buffer for .",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x4E",
         "EventName": "HW_PRE_REQ.DL1_MISS",
         "SampleAfterValue": "2000003",
@@ -39,8 +31,6 @@
     },
     {
         "BriefDescription": "Valid instructions written to IQ per cycle.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x17",
         "EventName": "INSTS_WRITTEN_TO_IQ.INSTS",
         "SampleAfterValue": "2000003",
@@ -48,8 +38,6 @@
     },
     {
         "BriefDescription": "Cycles when L1 and L2 are locked due to UC or=
 split lock.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x63",
         "EventName": "LOCK_CYCLES.SPLIT_LOCK_UC_LOCK_DURATION",
         "SampleAfterValue": "2000003",
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json b/tools/=
perf/pmu-events/arch/x86/jaketown/pipeline.json
index 61a3db4d67d5..11d41ce8c922 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "This event counts executed load operations wi=
th all the following traits: 1. addressing of the format [base + offset], 2=
. the offset is between 1 and 2047, 3. the address specified in the base re=
gister is in one page and the address [base+offset] is in an.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB6",
         "EventName": "AGU_BYPASS_CANCEL.COUNT",
         "SampleAfterValue": "100003",
@@ -10,8 +8,6 @@
     },
     {
         "BriefDescription": "Divide operations executed.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x14",
@@ -22,8 +18,6 @@
     },
     {
         "BriefDescription": "Cycles when divider is busy executing divide =
operations.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x14",
         "EventName": "ARITH.FPU_DIV_ACTIVE",
         "SampleAfterValue": "2000003",
@@ -31,8 +25,6 @@
     },
     {
         "BriefDescription": "Speculative and retired  branches.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_BRANCHES",
         "SampleAfterValue": "200003",
@@ -40,8 +32,6 @@
     },
     {
         "BriefDescription": "Speculative and retired macro-conditional bra=
nches.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_CONDITIONAL",
         "SampleAfterValue": "200003",
@@ -49,8 +39,6 @@
     },
     {
         "BriefDescription": "Speculative and retired macro-unconditional b=
ranches excluding calls and indirects.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_DIRECT_JMP",
         "SampleAfterValue": "200003",
@@ -58,8 +46,6 @@
     },
     {
         "BriefDescription": "Speculative and retired direct near calls.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_DIRECT_NEAR_CALL",
         "SampleAfterValue": "200003",
@@ -67,8 +53,6 @@
     },
     {
         "BriefDescription": "Speculative and retired indirect branches exc=
luding calls and returns.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_INDIRECT_JUMP_NON_CALL_RET",
         "SampleAfterValue": "200003",
@@ -76,8 +60,6 @@
     },
     {
         "BriefDescription": "Speculative and retired indirect return branc=
hes.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_INDIRECT_NEAR_RETURN",
         "SampleAfterValue": "200003",
@@ -85,8 +67,6 @@
     },
     {
         "BriefDescription": "Not taken macro-conditional branches.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.NONTAKEN_CONDITIONAL",
         "SampleAfterValue": "200003",
@@ -94,8 +74,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired macro-condition=
al branches.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_CONDITIONAL",
         "SampleAfterValue": "200003",
@@ -103,8 +81,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired macro-condition=
al branch instructions excluding calls and indirects.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_DIRECT_JUMP",
         "SampleAfterValue": "200003",
@@ -112,8 +88,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired direct near cal=
ls.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_DIRECT_NEAR_CALL",
         "SampleAfterValue": "200003",
@@ -121,8 +95,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired indirect branch=
es excluding calls and returns.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_INDIRECT_JUMP_NON_CALL_RET",
         "SampleAfterValue": "200003",
@@ -130,8 +102,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired indirect calls.=
",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_INDIRECT_NEAR_CALL",
         "SampleAfterValue": "200003",
@@ -139,8 +109,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired indirect branch=
es with return mnemonic.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_INDIRECT_NEAR_RETURN",
         "SampleAfterValue": "200003",
@@ -148,16 +116,12 @@
     },
     {
         "BriefDescription": "All (macro) branch instructions retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "SampleAfterValue": "400009"
     },
     {
         "BriefDescription": "All (macro) branch instructions retired. (Pre=
cise Event - PEBS).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES_PEBS",
         "PEBS": "2",
@@ -166,8 +130,6 @@
     },
     {
         "BriefDescription": "Conditional branch instructions retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.CONDITIONAL",
         "PEBS": "1",
@@ -176,8 +138,6 @@
     },
     {
         "BriefDescription": "Far branch instructions retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
         "SampleAfterValue": "100007",
@@ -185,8 +145,6 @@
     },
     {
         "BriefDescription": "Direct and indirect near call instructions re=
tired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
         "PEBS": "1",
@@ -195,8 +153,6 @@
     },
     {
         "BriefDescription": "Return instructions retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
         "PEBS": "1",
@@ -205,8 +161,6 @@
     },
     {
         "BriefDescription": "Taken branch instructions retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
         "PEBS": "1",
@@ -215,8 +169,6 @@
     },
     {
         "BriefDescription": "Not taken branch instructions retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NOT_TAKEN",
         "SampleAfterValue": "400009",
@@ -224,8 +176,6 @@
     },
     {
         "BriefDescription": "Speculative and retired mispredicted macro co=
nditional branches.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.ALL_BRANCHES",
         "SampleAfterValue": "200003",
@@ -233,8 +183,6 @@
     },
     {
         "BriefDescription": "Speculative and retired mispredicted macro co=
nditional branches.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.ALL_CONDITIONAL",
         "SampleAfterValue": "200003",
@@ -242,8 +190,6 @@
     },
     {
         "BriefDescription": "Speculative and retired mispredicted direct n=
ear calls.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.ALL_DIRECT_NEAR_CALL",
         "SampleAfterValue": "200003",
@@ -251,8 +197,6 @@
     },
     {
         "BriefDescription": "Mispredicted indirect branches excluding call=
s and returns.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.ALL_INDIRECT_JUMP_NON_CALL_RET",
         "SampleAfterValue": "200003",
@@ -260,8 +204,6 @@
     },
     {
         "BriefDescription": "Not taken speculative and retired mispredicte=
d macro conditional branches.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.NONTAKEN_CONDITIONAL",
         "SampleAfterValue": "200003",
@@ -269,8 +211,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired mispredicted ma=
cro conditional branches.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.TAKEN_CONDITIONAL",
         "SampleAfterValue": "200003",
@@ -278,8 +218,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired mispredicted di=
rect near calls.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.TAKEN_DIRECT_NEAR_CALL",
         "SampleAfterValue": "200003",
@@ -287,8 +225,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired mispredicted in=
direct branches excluding calls and returns.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.TAKEN_INDIRECT_JUMP_NON_CALL_RET",
         "SampleAfterValue": "200003",
@@ -296,8 +232,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired mispredicted in=
direct calls.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.TAKEN_INDIRECT_NEAR_CALL",
         "SampleAfterValue": "200003",
@@ -305,8 +239,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired mispredicted in=
direct branches with return mnemonic.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.TAKEN_RETURN_NEAR",
         "SampleAfterValue": "200003",
@@ -314,27 +246,20 @@
     },
     {
         "BriefDescription": "All mispredicted macro branch instructions re=
tired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "SampleAfterValue": "400009"
     },
     {
         "BriefDescription": "Mispredicted macro branch instructions retire=
d. (Precise Event - PEBS).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES_PEBS",
         "PEBS": "2",
-        "PublicDescription": "Mispredicted macro branch instructions retir=
ed. (Precise Event - PEBS)",
         "SampleAfterValue": "400009",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Mispredicted conditional branch instructions =
retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.CONDITIONAL",
         "PEBS": "1",
@@ -343,8 +268,6 @@
     },
     {
         "BriefDescription": "Direct and indirect mispredicted near call in=
structions retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.NEAR_CALL",
         "PEBS": "1",
@@ -353,8 +276,6 @@
     },
     {
         "BriefDescription": "Mispredicted not taken branch instructions re=
tired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.NOT_TAKEN",
         "PEBS": "1",
@@ -363,8 +284,6 @@
     },
     {
         "BriefDescription": "Mispredicted taken branch instructions retire=
d.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.TAKEN",
         "PEBS": "1",
@@ -373,8 +292,6 @@
     },
     {
         "BriefDescription": "Count XClk pulses when this thread is unhalte=
d and the other is halted.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE",
         "SampleAfterValue": "2000003",
@@ -382,8 +299,6 @@
     },
     {
         "BriefDescription": "Reference cycles when the thread is unhalted =
(counts at 100 MHz rate).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_THREAD_UNHALTED.REF_XCLK",
         "SampleAfterValue": "2000003",
@@ -392,8 +307,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Reference cycles when the at least one thread=
 on the physical core is unhalted (counts at 100 MHz rate).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY",
         "SampleAfterValue": "2000003",
@@ -401,8 +314,6 @@
     },
     {
         "BriefDescription": "Count XClk pulses when this thread is unhalte=
d and the other thread is halted.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
         "SampleAfterValue": "2000003",
@@ -410,8 +321,6 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
-        "Counter": "Fixed counter 2",
-        "CounterHTOff": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "This event counts the number of reference cy=
cles when the core is not in a halt state. The core enters the halt state w=
hen it is running the HLT instruction or the MWAIT instruction. This event =
is not affected by core frequency changes (for example, P states, TM2 trans=
itions) but has the same incrementing frequency as the time stamp counter. =
This event can approximate elapsed time while the core was not in a halt st=
ate. This event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK eve=
nt. It is counted on a dedicated fixed counter, leaving the four (eight whe=
n Hyperthreading is disabled) programmable counters available for other eve=
nts.",
         "SampleAfterValue": "2000003",
@@ -419,19 +328,14 @@
     },
     {
         "BriefDescription": "Reference cycles when the thread is unhalted =
(counts at 100 MHz rate).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.REF_XCLK",
-        "PublicDescription": "Reference cycles when the thread is unhalted=
 (counts at 100 MHz rate)",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
     {
         "AnyThread": "1",
         "BriefDescription": "Reference cycles when the at least one thread=
 on the physical core is unhalted (counts at 100 MHz rate).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.REF_XCLK_ANY",
         "SampleAfterValue": "2000003",
@@ -439,8 +343,6 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt st=
ate.",
-        "Counter": "Fixed counter 1",
-        "CounterHTOff": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "This event counts the number of core cycles =
while the thread is not in a halt state. The thread enters the halt state w=
hen it is running the HLT instruction. This event is a component in many ke=
y event ratios. The core frequency may change from time to time due to tran=
sitions associated with Enhanced Intel SpeedStep Technology or TM2. For thi=
s reason this event may have a changing ratio with regards to time. When th=
e core frequency is constant, this event can approximate elapsed time while=
 the core was not in the halt state. It is counted on a dedicated fixed cou=
nter, leaving the four (eight when Hyperthreading is disabled) programmable=
 counters available for other events.",
         "SampleAfterValue": "2000003",
@@ -449,16 +351,12 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core cycles when at least one thread on the p=
hysical core is not in halt state.",
-        "Counter": "Fixed counter 2",
-        "CounterHTOff": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Thread cycles when thread is not in halt stat=
e.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
         "SampleAfterValue": "2000003"
@@ -466,16 +364,12 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core cycles when at least one thread on the p=
hysical core is not in halt state.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P_ANY",
         "SampleAfterValue": "2000003"
     },
     {
         "BriefDescription": "Each cycle there was a miss-pending demand lo=
ad this thread, increment by 1. Note this is in DCU and connected to Umask =
1. Miss Pending demand load should be deduced by OR-ing increment bits of D=
CACHE_MISS_PEND.PENDING.",
-        "Counter": "2",
-        "CounterHTOff": "2",
         "CounterMask": "2",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_PENDING",
@@ -484,8 +378,6 @@
     },
     {
         "BriefDescription": "Each cycle there was a MLC-miss pending deman=
d load this thread (i.e. Non-completed valid SQ entry allocated for demand =
load and waiting for Uncore), increment by 1. Note this is in MLC and conne=
cted to Umask 0.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L2_PENDING",
@@ -494,8 +386,6 @@
     },
     {
         "BriefDescription": "Each cycle there was no dispatch for this thr=
ead, increment by 1. Note this is connect to Umask 2. No dispatch can be de=
duced from the UOPS_EXECUTED event.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "4",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_NO_DISPATCH",
@@ -504,8 +394,6 @@
     },
     {
         "BriefDescription": "Each cycle there was a miss-pending demand lo=
ad this thread and no uops dispatched, increment by 1. Note this is in DCU =
and connected to Umask 1 and 2. Miss Pending demand load should be deduced =
by OR-ing increment bits of DCACHE_MISS_PEND.PENDING.",
-        "Counter": "2",
-        "CounterHTOff": "2",
         "CounterMask": "6",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L1D_PENDING",
@@ -514,8 +402,6 @@
     },
     {
         "BriefDescription": "Each cycle there was a MLC-miss pending deman=
d load and no uops dispatched on this thread (i.e. Non-completed valid SQ e=
ntry allocated for demand load and waiting for Uncore), increment by 1. Not=
e this is in MLC and connected to Umask 0 and 2.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "5",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L2_PENDING",
@@ -524,8 +410,6 @@
     },
     {
         "BriefDescription": "Stall cycles because IQ is full.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x87",
         "EventName": "ILD_STALL.IQ_FULL",
         "SampleAfterValue": "2000003",
@@ -533,8 +417,6 @@
     },
     {
         "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x87",
         "EventName": "ILD_STALL.LCP",
         "SampleAfterValue": "2000003",
@@ -542,8 +424,6 @@
     },
     {
         "BriefDescription": "Instructions retired from execution.",
-        "Counter": "Fixed counter 0",
-        "CounterHTOff": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
         "PublicDescription": "This event counts the number of instructions=
 retired from execution. For instructions that consist of multiple micro-op=
s, this event counts the retirement of the last micro-op of the instruction=
. Counting continues during hardware interrupts, traps, and inside interrup=
t handlers.",
         "SampleAfterValue": "2000003",
@@ -551,27 +431,20 @@
     },
     {
         "BriefDescription": "Number of instructions retired. General Count=
er   - architectural event.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.ANY_P",
         "SampleAfterValue": "2000003"
     },
     {
         "BriefDescription": "Instructions retired. (Precise Event - PEBS).=
",
-        "Counter": "1",
-        "CounterHTOff": "1",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.PREC_DIST",
         "PEBS": "2",
         "SampleAfterValue": "2000003",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Cycles when Resource Allocation Table (RAT) e=
xternal stall is sent to Instruction Decode Queue (IDQ) for the thread.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x0D",
         "EventName": "INT_MISC.RAT_STALL_CYCLES",
         "SampleAfterValue": "2000003",
@@ -579,8 +452,6 @@
     },
     {
         "BriefDescription": "Number of cycles waiting for the checkpoints =
in Resource Allocation Table (RAT) to be recovered after Nuke due to all ot=
her cases except JEClear (e.g. whenever a ucode assist is needed like SSE e=
xception, memory disambiguation, etc...).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x0D",
         "EventName": "INT_MISC.RECOVERY_CYCLES",
@@ -590,8 +461,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core cycles the allocator was stalled due to =
recovery from earlier clear event for any thread running on the physical co=
re (e.g. misprediction or memory nuke).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x0D",
         "EventName": "INT_MISC.RECOVERY_CYCLES_ANY",
@@ -600,8 +469,6 @@
     },
     {
         "BriefDescription": "Number of occurrences waiting for the checkpo=
ints in Resource Allocation Table (RAT) to be recovered after Nuke due to a=
ll other cases except JEClear (e.g. whenever a ucode assist is needed like =
SSE exception, memory disambiguation, etc...).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x0D",
@@ -611,8 +478,6 @@
     },
     {
         "BriefDescription": "Number of cases where any load ends up with a=
 valid block-code written to the load buffer (including blocks due to Memor=
y Order Buffer (MOB), Data Cache Unit (DCU), TLB, but load has no DCU miss)=
.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.ALL_BLOCK",
         "SampleAfterValue": "100003",
@@ -620,8 +485,6 @@
     },
     {
         "BriefDescription": "Loads delayed due to SB blocks, preceding sto=
re operations with known addresses but unknown data.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.DATA_UNKNOWN",
         "SampleAfterValue": "100003",
@@ -629,8 +492,6 @@
     },
     {
         "BriefDescription": "This event counts the number of times that sp=
lit load operations are temporarily blocked because all resources for handl=
ing the split accesses are in use.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.NO_SR",
         "SampleAfterValue": "100003",
@@ -638,8 +499,6 @@
     },
     {
         "BriefDescription": "Cases when loads get true Block-on-Store bloc=
king code preventing store forwarding.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
         "PublicDescription": "This event counts loads that followed a stor=
e to the same address, where the data could not be forwarded inside the pip=
eline from the store to the load.  The most common reason why store forward=
ing would be blocked is when a load's address range overlaps with a preceed=
ing smaller uncompleted store.  See the table of not supported store forwar=
ds in the Intel? 64 and IA-32 Architectures Optimization Reference Manual. =
 The penalty for blocked store forwarding is that the load must wait for th=
e store to complete before it can be issued.",
@@ -648,8 +507,6 @@
     },
     {
         "BriefDescription": "False dependencies in MOB due to partial comp=
are.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x07",
         "EventName": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS",
         "PublicDescription": "Aliasing occurs when a load is issued after =
a store and their memory addresses are offset by 4K.  This event counts the=
 number of loads that aliased with a preceding store, resulting in an exten=
ded address check in the pipeline.  The enhanced address check typically ha=
s a performance penalty of 5 cycles.",
@@ -658,8 +515,6 @@
     },
     {
         "BriefDescription": "This event counts the number of times that lo=
ad operations are temporarily blocked because of older stores, with address=
es that are not yet known. A load operation may incur more than one block o=
f this type.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x07",
         "EventName": "LD_BLOCKS_PARTIAL.ALL_STA_BLOCK",
         "SampleAfterValue": "100003",
@@ -667,8 +522,6 @@
     },
     {
         "BriefDescription": "Not software-prefetch load dispatches that hi=
t FB allocated for hardware prefetch.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x4C",
         "EventName": "LOAD_HIT_PRE.HW_PF",
         "SampleAfterValue": "100003",
@@ -676,8 +529,6 @@
     },
     {
         "BriefDescription": "Not software-prefetch load dispatches that hi=
t FB allocated for software prefetch.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x4C",
         "EventName": "LOAD_HIT_PRE.SW_PF",
         "SampleAfterValue": "100003",
@@ -685,8 +536,6 @@
     },
     {
         "BriefDescription": "Cycles 4 Uops delivered by the LSD, but didn'=
t come from the decoder.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0xA8",
         "EventName": "LSD.CYCLES_4_UOPS",
@@ -695,8 +544,6 @@
     },
     {
         "BriefDescription": "Cycles Uops delivered by the LSD, but didn't =
come from the decoder.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xA8",
         "EventName": "LSD.CYCLES_ACTIVE",
@@ -705,8 +552,6 @@
     },
     {
         "BriefDescription": "Number of Uops delivered by the LSD.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA8",
         "EventName": "LSD.UOPS",
         "SampleAfterValue": "2000003",
@@ -714,8 +559,6 @@
     },
     {
         "BriefDescription": "Number of machine clears (nukes) of any type.=
",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0xc3",
@@ -725,8 +568,6 @@
     },
     {
         "BriefDescription": "This event counts the number of executed Inte=
l AVX masked load operations that refer to an illegal address range with th=
e mask bits set to 0.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MASKMOV",
         "PublicDescription": "Maskmov false fault - counts number of time =
ucode passes through Maskmov flow due to instruction's mask being 0 while t=
he flow was completed without raising a fault.",
@@ -735,8 +576,6 @@
     },
     {
         "BriefDescription": "Self-modifying code (SMC) detected.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.SMC",
         "PublicDescription": "This event is incremented when self-modifyin=
g code (SMC) is detected, which causes a machine clear.  Machine clears can=
 have a significant performance impact if they are happening frequently.",
@@ -745,8 +584,6 @@
     },
     {
         "BriefDescription": "Retired instructions experiencing ITLB misses=
.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC1",
         "EventName": "OTHER_ASSISTS.ITLB_MISS_RETIRED",
         "SampleAfterValue": "100003",
@@ -754,8 +591,6 @@
     },
     {
         "BriefDescription": "Increments the number of flags-merge uops in =
flight each cycle.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x59",
         "EventName": "PARTIAL_RAT_STALLS.FLAGS_MERGE_UOP",
         "SampleAfterValue": "2000003",
@@ -763,8 +598,6 @@
     },
     {
         "BriefDescription": "Performance sensitive flags-merging uops adde=
d by Sandy Bridge u-arch.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x59",
         "EventName": "PARTIAL_RAT_STALLS.FLAGS_MERGE_UOP_CYCLES",
@@ -774,8 +607,6 @@
     },
     {
         "BriefDescription": "Multiply packed/scalar single precision uops =
allocated.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x59",
         "EventName": "PARTIAL_RAT_STALLS.MUL_SINGLE_UOP",
         "SampleAfterValue": "2000003",
@@ -783,8 +614,6 @@
     },
     {
         "BriefDescription": "Cycles with at least one slow LEA uop being a=
llocated.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x59",
         "EventName": "PARTIAL_RAT_STALLS.SLOW_LEA_WINDOW",
         "PublicDescription": "This event counts the number of cycles with =
at least one slow LEA uop being allocated. A uop is generally considered as=
 slow LEA if it has three sources (for example, two sources and immediate) =
regardless of whether it is a result of LEA instruction or not. Examples of=
 the slow LEA uop are or uops with base, index, and offset source operands =
using base and index reqisters, where base is EBR/RBP/R13, using RIP relati=
ve or 16-bit addressing modes. See the Intel? 64 and IA-32 Architectures Op=
timization Reference Manual for more details about slow LEA instructions.",
@@ -793,8 +622,6 @@
     },
     {
         "BriefDescription": "Resource-related stall cycles.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.ANY",
         "SampleAfterValue": "2000003",
@@ -802,8 +629,6 @@
     },
     {
         "BriefDescription": "Counts the cycles of stall due to lack of loa=
d buffers.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.LB",
         "SampleAfterValue": "2000003",
@@ -811,8 +636,6 @@
     },
     {
         "BriefDescription": "Resource stalls due to load or store buffers =
all being in use.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.LB_SB",
         "SampleAfterValue": "2000003",
@@ -820,8 +643,6 @@
     },
     {
         "BriefDescription": "Resource stalls due to memory buffers or Rese=
rvation Station (RS) being fully utilized.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.MEM_RS",
         "SampleAfterValue": "2000003",
@@ -829,8 +650,6 @@
     },
     {
         "BriefDescription": "Resource stalls due to Rob being full, FCSW, =
MXCSR and OTHER.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.OOO_RSRC",
         "SampleAfterValue": "2000003",
@@ -838,8 +657,6 @@
     },
     {
         "BriefDescription": "Cycles stalled due to re-order buffer full.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.ROB",
         "SampleAfterValue": "2000003",
@@ -847,8 +664,6 @@
     },
     {
         "BriefDescription": "Cycles stalled due to no eligible RS entry av=
ailable.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.RS",
         "SampleAfterValue": "2000003",
@@ -856,8 +671,6 @@
     },
     {
         "BriefDescription": "Cycles stalled due to no store buffers availa=
ble. (not including draining form sync).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.SB",
         "SampleAfterValue": "2000003",
@@ -865,8 +678,6 @@
     },
     {
         "BriefDescription": "Cycles with either free list is empty.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5B",
         "EventName": "RESOURCE_STALLS2.ALL_FL_EMPTY",
         "SampleAfterValue": "2000003",
@@ -874,8 +685,6 @@
     },
     {
         "BriefDescription": "Resource stalls2 control structures full for =
physical registers.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5B",
         "EventName": "RESOURCE_STALLS2.ALL_PRF_CONTROL",
         "SampleAfterValue": "2000003",
@@ -883,8 +692,6 @@
     },
     {
         "BriefDescription": "Cycles when Allocator is stalled if BOB is fu=
ll and new branch needs it.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5B",
         "EventName": "RESOURCE_STALLS2.BOB_FULL",
         "SampleAfterValue": "2000003",
@@ -892,8 +699,6 @@
     },
     {
         "BriefDescription": "Resource stalls out of order resources full."=
,
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5B",
         "EventName": "RESOURCE_STALLS2.OOO_RSRC",
         "SampleAfterValue": "2000003",
@@ -901,8 +706,6 @@
     },
     {
         "BriefDescription": "Count cases of saving new LBR.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xCC",
         "EventName": "ROB_MISC_EVENTS.LBR_INSERTS",
         "SampleAfterValue": "2000003",
@@ -910,8 +713,6 @@
     },
     {
         "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 for the thread.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5E",
         "EventName": "RS_EVENTS.EMPTY_CYCLES",
         "SampleAfterValue": "2000003",
@@ -919,8 +720,6 @@
     },
     {
         "BriefDescription": "Counts end of periods where the Reservation S=
tation (RS) was empty. Could be useful to precisely locate Frontend Latency=
 Bound issues.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x5E",
@@ -931,8 +730,6 @@
     },
     {
         "BriefDescription": "Uops dispatched from any thread.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB1",
         "EventName": "UOPS_DISPATCHED.CORE",
         "SampleAfterValue": "2000003",
@@ -940,8 +737,6 @@
     },
     {
         "BriefDescription": "Uops dispatched per thread.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB1",
         "EventName": "UOPS_DISPATCHED.THREAD",
         "SampleAfterValue": "2000003",
@@ -949,8 +744,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are dispatched to=
 port 0.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_0",
         "SampleAfterValue": "2000003",
@@ -959,8 +752,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are dispatched to p=
ort 0.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_0_CORE",
         "SampleAfterValue": "2000003",
@@ -968,8 +759,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are dispatched to=
 port 1.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_1",
         "SampleAfterValue": "2000003",
@@ -978,8 +767,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are dispatched to p=
ort 1.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_1_CORE",
         "SampleAfterValue": "2000003",
@@ -987,8 +774,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when load or STA uops are d=
ispatched to port 2.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_2",
         "SampleAfterValue": "2000003",
@@ -997,8 +782,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when load or STA uops are dis=
patched to port 2.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_2_CORE",
         "SampleAfterValue": "2000003",
@@ -1006,8 +789,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when load or STA uops are d=
ispatched to port 3.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_3",
         "SampleAfterValue": "2000003",
@@ -1016,8 +797,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when load or STA uops are dis=
patched to port 3.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_3_CORE",
         "SampleAfterValue": "2000003",
@@ -1025,8 +804,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are dispatched to=
 port 4.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_4",
         "SampleAfterValue": "2000003",
@@ -1035,8 +812,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are dispatched to p=
ort 4.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_4_CORE",
         "SampleAfterValue": "2000003",
@@ -1044,8 +819,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are dispatched to=
 port 5.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_5",
         "SampleAfterValue": "2000003",
@@ -1054,8 +827,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are dispatched to p=
ort 5.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_5_CORE",
         "SampleAfterValue": "2000003",
@@ -1063,8 +834,6 @@
     },
     {
         "BriefDescription": "Cycles at least 1 micro-op is executed from a=
ny thread on physical core.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_1",
@@ -1073,8 +842,6 @@
     },
     {
         "BriefDescription": "Cycles at least 2 micro-op is executed from a=
ny thread on physical core.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "2",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_2",
@@ -1083,8 +850,6 @@
     },
     {
         "BriefDescription": "Cycles at least 3 micro-op is executed from a=
ny thread on physical core.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "3",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_3",
@@ -1093,8 +858,6 @@
     },
     {
         "BriefDescription": "Cycles at least 4 micro-op is executed from a=
ny thread on physical core.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_4",
@@ -1103,8 +866,6 @@
     },
     {
         "BriefDescription": "Cycles with no micro-ops executed from any th=
read on physical core.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_NONE",
         "Invert": "1",
@@ -1113,8 +874,6 @@
     },
     {
         "BriefDescription": "Uops that Resource Allocation Table (RAT) iss=
ues to Reservation Station (RS).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.ANY",
         "PublicDescription": "This event counts the number of Uops issued =
by the front-end of the pipeilne to the back-end.",
@@ -1124,8 +883,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles when Resource Allocation Table (RAT) d=
oes not issue Uops to Reservation Station (RS) for all threads.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.CORE_STALL_CYCLES",
@@ -1135,8 +892,6 @@
     },
     {
         "BriefDescription": "Cycles when Resource Allocation Table (RAT) d=
oes not issue Uops to Reservation Station (RS) for the thread.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.STALL_CYCLES",
@@ -1146,8 +901,6 @@
     },
     {
         "BriefDescription": "Actually retired uops.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.ALL",
         "PEBS": "1",
@@ -1157,8 +910,6 @@
     },
     {
         "BriefDescription": "Cycles without actually retired uops.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.CORE_STALL_CYCLES",
@@ -1168,8 +919,6 @@
     },
     {
         "BriefDescription": "Retirement slots used.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.RETIRE_SLOTS",
         "PEBS": "1",
@@ -1179,8 +928,6 @@
     },
     {
         "BriefDescription": "Cycles without actually retired uops.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.STALL_CYCLES",
@@ -1190,8 +937,6 @@
     },
     {
         "BriefDescription": "Cycles with less than 10 actually retired uop=
s.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "10",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.TOTAL_CYCLES",
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json b/to=
ols/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
index 351f8b040ed1..b9e68f9f33ea 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
@@ -1,23 +1,26 @@
 [
     {
         "BriefDescription": "Uncore Clocks",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_C_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "Counter 0 Occupancy",
-        "Counter": "1,2,3",
         "EventCode": "0x1f",
         "EventName": "UNC_C_COUNTER0_OCCUPANCY",
         "PerPkg": "1",
         "PublicDescription": "Since occupancy counts can only be captured =
in the Cbo's 0 counter, this event allows a user to capture occupancy relat=
ed information by filtering the Cb0 occupancy count captured in Counter 0. =
  The filtering available is found in the control register - threshold, inv=
ert and edge detect.   E.g. setting threshold to 1 can effectively monitor =
how many cycles the monitored queue has an entry.",
         "Unit": "CBO"
     },
+    {
+        "EventCode": "0x21",
+        "EventName": "UNC_C_ISMQ_DRD_MISS_OCC",
+        "PerPkg": "1",
+        "Unit": "CBO"
+    },
     {
         "BriefDescription": "Cache Lookups; Data Read Request",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.DATA_READ",
         "PerPkg": "1",
@@ -27,7 +30,6 @@
     },
     {
         "BriefDescription": "Cache Lookups; RTID",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.NID",
         "PerPkg": "1",
@@ -37,7 +39,6 @@
     },
     {
         "BriefDescription": "Cache Lookups; External Snoop Request",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.REMOTE_SNOOP",
         "PerPkg": "1",
@@ -47,7 +48,6 @@
     },
     {
         "BriefDescription": "Cache Lookups; Write Requests",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.WRITE",
         "PerPkg": "1",
@@ -57,7 +57,6 @@
     },
     {
         "BriefDescription": "Lines Victimized; Lines in E state",
-        "Counter": "0,1",
         "EventCode": "0x37",
         "EventName": "UNC_C_LLC_VICTIMS.E_STATE",
         "PerPkg": "1",
@@ -67,7 +66,6 @@
     },
     {
         "BriefDescription": "Lines Victimized",
-        "Counter": "0,1",
         "EventCode": "0x37",
         "EventName": "UNC_C_LLC_VICTIMS.MISS",
         "PerPkg": "1",
@@ -77,7 +75,6 @@
     },
     {
         "BriefDescription": "Lines Victimized; Lines in M state",
-        "Counter": "0,1",
         "EventCode": "0x37",
         "EventName": "UNC_C_LLC_VICTIMS.M_STATE",
         "PerPkg": "1",
@@ -87,7 +84,6 @@
     },
     {
         "BriefDescription": "Lines Victimized; Victimized Lines that Match=
 NID",
-        "Counter": "0,1",
         "EventCode": "0x37",
         "EventName": "UNC_C_LLC_VICTIMS.NID",
         "PerPkg": "1",
@@ -97,7 +93,6 @@
     },
     {
         "BriefDescription": "Lines Victimized; Lines in S State",
-        "Counter": "0,1",
         "EventCode": "0x37",
         "EventName": "UNC_C_LLC_VICTIMS.S_STATE",
         "PerPkg": "1",
@@ -107,7 +102,6 @@
     },
     {
         "BriefDescription": "Cbo Misc; RFO HitS",
-        "Counter": "0,1",
         "EventCode": "0x39",
         "EventName": "UNC_C_MISC.RFO_HIT_S",
         "PerPkg": "1",
@@ -117,7 +111,6 @@
     },
     {
         "BriefDescription": "Cbo Misc; Silent Snoop Eviction",
-        "Counter": "0,1",
         "EventCode": "0x39",
         "EventName": "UNC_C_MISC.RSPI_WAS_FSE",
         "PerPkg": "1",
@@ -127,7 +120,6 @@
     },
     {
         "BriefDescription": "Cbo Misc",
-        "Counter": "0,1",
         "EventCode": "0x39",
         "EventName": "UNC_C_MISC.STARTED",
         "PerPkg": "1",
@@ -137,7 +129,6 @@
     },
     {
         "BriefDescription": "Cbo Misc; Write Combining Aliasing",
-        "Counter": "0,1",
         "EventCode": "0x39",
         "EventName": "UNC_C_MISC.WC_ALIASING",
         "PerPkg": "1",
@@ -147,7 +138,6 @@
     },
     {
         "BriefDescription": "AD Ring In Use; Down and Even",
-        "Counter": "2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_C_RING_AD_USED.DOWN_EVEN",
         "PerPkg": "1",
@@ -157,7 +147,6 @@
     },
     {
         "BriefDescription": "AD Ring In Use; Down and Odd",
-        "Counter": "2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_C_RING_AD_USED.DOWN_ODD",
         "PerPkg": "1",
@@ -167,7 +156,6 @@
     },
     {
         "BriefDescription": "AD Ring In Use; Up and Even",
-        "Counter": "2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_C_RING_AD_USED.UP_EVEN",
         "PerPkg": "1",
@@ -177,7 +165,6 @@
     },
     {
         "BriefDescription": "AD Ring In Use; Up and Odd",
-        "Counter": "2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_C_RING_AD_USED.UP_ODD",
         "PerPkg": "1",
@@ -187,7 +174,6 @@
     },
     {
         "BriefDescription": "AK Ring In Use; Down and Even",
-        "Counter": "2,3",
         "EventCode": "0x1c",
         "EventName": "UNC_C_RING_AK_USED.DOWN_EVEN",
         "PerPkg": "1",
@@ -197,7 +183,6 @@
     },
     {
         "BriefDescription": "AK Ring In Use; Down and Odd",
-        "Counter": "2,3",
         "EventCode": "0x1c",
         "EventName": "UNC_C_RING_AK_USED.DOWN_ODD",
         "PerPkg": "1",
@@ -207,7 +192,6 @@
     },
     {
         "BriefDescription": "AK Ring In Use; Up and Even",
-        "Counter": "2,3",
         "EventCode": "0x1c",
         "EventName": "UNC_C_RING_AK_USED.UP_EVEN",
         "PerPkg": "1",
@@ -217,7 +201,6 @@
     },
     {
         "BriefDescription": "AK Ring In Use; Up and Odd",
-        "Counter": "2,3",
         "EventCode": "0x1c",
         "EventName": "UNC_C_RING_AK_USED.UP_ODD",
         "PerPkg": "1",
@@ -227,7 +210,6 @@
     },
     {
         "BriefDescription": "BL Ring in Use; Down and Even",
-        "Counter": "2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_C_RING_BL_USED.DOWN_EVEN",
         "PerPkg": "1",
@@ -237,7 +219,6 @@
     },
     {
         "BriefDescription": "BL Ring in Use; Down and Odd",
-        "Counter": "2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_C_RING_BL_USED.DOWN_ODD",
         "PerPkg": "1",
@@ -247,7 +228,6 @@
     },
     {
         "BriefDescription": "BL Ring in Use; Up and Even",
-        "Counter": "2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_C_RING_BL_USED.UP_EVEN",
         "PerPkg": "1",
@@ -257,7 +237,6 @@
     },
     {
         "BriefDescription": "BL Ring in Use; Up and Odd",
-        "Counter": "2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_C_RING_BL_USED.UP_ODD",
         "PerPkg": "1",
@@ -267,7 +246,6 @@
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Acknowledgements to core",
-        "Counter": "0,1",
         "EventCode": "0x5",
         "EventName": "UNC_C_RING_BOUNCES.AK_CORE",
         "PerPkg": "1",
@@ -276,7 +254,6 @@
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Data Responses to core",
-        "Counter": "0,1",
         "EventCode": "0x5",
         "EventName": "UNC_C_RING_BOUNCES.BL_CORE",
         "PerPkg": "1",
@@ -285,7 +262,6 @@
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Snoops of processor's cache.",
-        "Counter": "0,1",
         "EventCode": "0x5",
         "EventName": "UNC_C_RING_BOUNCES.IV_CORE",
         "PerPkg": "1",
@@ -294,7 +270,6 @@
     },
     {
         "BriefDescription": "BL Ring in Use; Any",
-        "Counter": "2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_C_RING_IV_USED.ANY",
         "PerPkg": "1",
@@ -302,9 +277,42 @@
         "UMask": "0xf",
         "Unit": "CBO"
     },
+    {
+        "EventCode": "0x6",
+        "EventName": "UNC_C_RING_SINK_STARVED.AD_CACHE",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "EventCode": "0x6",
+        "EventName": "UNC_C_RING_SINK_STARVED.AK_CORE",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "EventCode": "0x6",
+        "EventName": "UNC_C_RING_SINK_STARVED.BL_CORE",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "EventCode": "0x6",
+        "EventName": "UNC_C_RING_SINK_STARVED.IV_CORE",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "EventCode": "0x7",
+        "EventName": "UNC_C_RING_SRC_THRTL",
+        "PerPkg": "1",
+        "Unit": "CBO"
+    },
     {
         "BriefDescription": "Ingress Arbiter Blocking Cycles; IRQ",
-        "Counter": "0,1",
         "EventCode": "0x12",
         "EventName": "UNC_C_RxR_EXT_STARVED.IPQ",
         "PerPkg": "1",
@@ -314,7 +322,6 @@
     },
     {
         "BriefDescription": "Ingress Arbiter Blocking Cycles; IPQ",
-        "Counter": "0,1",
         "EventCode": "0x12",
         "EventName": "UNC_C_RxR_EXT_STARVED.IRQ",
         "PerPkg": "1",
@@ -324,7 +331,6 @@
     },
     {
         "BriefDescription": "Ingress Arbiter Blocking Cycles; ISMQ",
-        "Counter": "0,1",
         "EventCode": "0x12",
         "EventName": "UNC_C_RxR_EXT_STARVED.ISMQ",
         "PerPkg": "1",
@@ -334,7 +340,6 @@
     },
     {
         "BriefDescription": "Ingress Arbiter Blocking Cycles; ISMQ_BID",
-        "Counter": "0,1",
         "EventCode": "0x12",
         "EventName": "UNC_C_RxR_EXT_STARVED.ISMQ_BIDS",
         "PerPkg": "1",
@@ -344,7 +349,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; IPQ",
-        "Counter": "0,1",
         "EventCode": "0x13",
         "EventName": "UNC_C_RxR_INSERTS.IPQ",
         "PerPkg": "1",
@@ -354,7 +358,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; IRQ",
-        "Counter": "0,1",
         "EventCode": "0x13",
         "EventName": "UNC_C_RxR_INSERTS.IRQ",
         "PerPkg": "1",
@@ -364,7 +367,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; IRQ Rejected",
-        "Counter": "0,1",
         "EventCode": "0x13",
         "EventName": "UNC_C_RxR_INSERTS.IRQ_REJECTED",
         "PerPkg": "1",
@@ -374,7 +376,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; VFIFO",
-        "Counter": "0,1",
         "EventCode": "0x13",
         "EventName": "UNC_C_RxR_INSERTS.VFIFO",
         "PerPkg": "1",
@@ -384,7 +385,6 @@
     },
     {
         "BriefDescription": "Ingress Internal Starvation Cycles; IPQ",
-        "Counter": "0,1",
         "EventCode": "0x14",
         "EventName": "UNC_C_RxR_INT_STARVED.IPQ",
         "PerPkg": "1",
@@ -394,7 +394,6 @@
     },
     {
         "BriefDescription": "Ingress Internal Starvation Cycles; IRQ",
-        "Counter": "0,1",
         "EventCode": "0x14",
         "EventName": "UNC_C_RxR_INT_STARVED.IRQ",
         "PerPkg": "1",
@@ -404,7 +403,6 @@
     },
     {
         "BriefDescription": "Ingress Internal Starvation Cycles; ISMQ",
-        "Counter": "0,1",
         "EventCode": "0x14",
         "EventName": "UNC_C_RxR_INT_STARVED.ISMQ",
         "PerPkg": "1",
@@ -414,7 +412,6 @@
     },
     {
         "BriefDescription": "Probe Queue Retries; Address Conflict",
-        "Counter": "0,1",
         "EventCode": "0x31",
         "EventName": "UNC_C_RxR_IPQ_RETRY.ADDR_CONFLICT",
         "PerPkg": "1",
@@ -424,7 +421,6 @@
     },
     {
         "BriefDescription": "Probe Queue Retries; Any Reject",
-        "Counter": "0,1",
         "EventCode": "0x31",
         "EventName": "UNC_C_RxR_IPQ_RETRY.ANY",
         "PerPkg": "1",
@@ -434,7 +430,6 @@
     },
     {
         "BriefDescription": "Probe Queue Retries; No Egress Credits",
-        "Counter": "0,1",
         "EventCode": "0x31",
         "EventName": "UNC_C_RxR_IPQ_RETRY.FULL",
         "PerPkg": "1",
@@ -444,7 +439,6 @@
     },
     {
         "BriefDescription": "Probe Queue Retries; No QPI Credits",
-        "Counter": "0,1",
         "EventCode": "0x31",
         "EventName": "UNC_C_RxR_IPQ_RETRY.QPI_CREDITS",
         "PerPkg": "1",
@@ -454,7 +448,6 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; Address Confli=
ct",
-        "Counter": "0,1",
         "EventCode": "0x32",
         "EventName": "UNC_C_RxR_IRQ_RETRY.ADDR_CONFLICT",
         "PerPkg": "1",
@@ -463,7 +456,6 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; Any Reject",
-        "Counter": "0,1",
         "EventCode": "0x32",
         "EventName": "UNC_C_RxR_IRQ_RETRY.ANY",
         "PerPkg": "1",
@@ -472,7 +464,6 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No Egress Cred=
its",
-        "Counter": "0,1",
         "EventCode": "0x32",
         "EventName": "UNC_C_RxR_IRQ_RETRY.FULL",
         "PerPkg": "1",
@@ -481,7 +472,6 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No QPI Credits=
",
-        "Counter": "0,1",
         "EventCode": "0x32",
         "EventName": "UNC_C_RxR_IRQ_RETRY.QPI_CREDITS",
         "PerPkg": "1",
@@ -490,7 +480,6 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No RTIDs",
-        "Counter": "0,1",
         "EventCode": "0x32",
         "EventName": "UNC_C_RxR_IRQ_RETRY.RTID",
         "PerPkg": "1",
@@ -499,7 +488,6 @@
     },
     {
         "BriefDescription": "ISMQ Retries; Any Reject",
-        "Counter": "0,1",
         "EventCode": "0x33",
         "EventName": "UNC_C_RxR_ISMQ_RETRY.ANY",
         "PerPkg": "1",
@@ -509,7 +497,6 @@
     },
     {
         "BriefDescription": "ISMQ Retries; No Egress Credits",
-        "Counter": "0,1",
         "EventCode": "0x33",
         "EventName": "UNC_C_RxR_ISMQ_RETRY.FULL",
         "PerPkg": "1",
@@ -519,7 +506,6 @@
     },
     {
         "BriefDescription": "ISMQ Retries; No IIO Credits",
-        "Counter": "0,1",
         "EventCode": "0x33",
         "EventName": "UNC_C_RxR_ISMQ_RETRY.IIO_CREDITS",
         "PerPkg": "1",
@@ -529,7 +515,6 @@
     },
     {
         "BriefDescription": "ISMQ Retries; No QPI Credits",
-        "Counter": "0,1",
         "EventCode": "0x33",
         "EventName": "UNC_C_RxR_ISMQ_RETRY.QPI_CREDITS",
         "PerPkg": "1",
@@ -539,7 +524,6 @@
     },
     {
         "BriefDescription": "ISMQ Retries; No RTIDs",
-        "Counter": "0,1",
         "EventCode": "0x33",
         "EventName": "UNC_C_RxR_ISMQ_RETRY.RTID",
         "PerPkg": "1",
@@ -585,7 +569,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; Evictions",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.EVICTION",
         "PerPkg": "1",
@@ -595,7 +578,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; Miss All",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_ALL",
         "PerPkg": "1",
@@ -605,7 +587,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; Miss Opcode Match",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
         "PerPkg": "1",
@@ -615,7 +596,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; NID Matched",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_ALL",
         "PerPkg": "1",
@@ -625,7 +605,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; NID Matched Evictions",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_EVICTION",
         "PerPkg": "1",
@@ -635,7 +614,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; NID Matched Miss All",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_MISS_ALL",
         "PerPkg": "1",
@@ -645,7 +623,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; NID and Opcode Matched Miss",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_MISS_OPCODE",
         "PerPkg": "1",
@@ -655,7 +632,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; NID and Opcode Matched",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_OPCODE",
         "PerPkg": "1",
@@ -665,7 +641,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; NID Matched Writebacks",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_WB",
         "PerPkg": "1",
@@ -675,7 +650,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; Opcode Match",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.OPCODE",
         "PerPkg": "1",
@@ -685,7 +659,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; Writebacks",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.WB",
         "PerPkg": "1",
@@ -783,9 +756,14 @@
         "UMask": "0x1",
         "Unit": "CBO"
     },
+    {
+        "EventCode": "0x4",
+        "EventName": "UNC_C_TxR_ADS_USED",
+        "PerPkg": "1",
+        "Unit": "CBO"
+    },
     {
         "BriefDescription": "Egress Allocations; AD - Cachebo",
-        "Counter": "0,1",
         "EventCode": "0x2",
         "EventName": "UNC_C_TxR_INSERTS.AD_CACHE",
         "PerPkg": "1",
@@ -795,7 +773,6 @@
     },
     {
         "BriefDescription": "Egress Allocations; AD - Corebo",
-        "Counter": "0,1",
         "EventCode": "0x2",
         "EventName": "UNC_C_TxR_INSERTS.AD_CORE",
         "PerPkg": "1",
@@ -805,7 +782,6 @@
     },
     {
         "BriefDescription": "Egress Allocations; AK - Cachebo",
-        "Counter": "0,1",
         "EventCode": "0x2",
         "EventName": "UNC_C_TxR_INSERTS.AK_CACHE",
         "PerPkg": "1",
@@ -815,7 +791,6 @@
     },
     {
         "BriefDescription": "Egress Allocations; AK - Corebo",
-        "Counter": "0,1",
         "EventCode": "0x2",
         "EventName": "UNC_C_TxR_INSERTS.AK_CORE",
         "PerPkg": "1",
@@ -825,7 +800,6 @@
     },
     {
         "BriefDescription": "Egress Allocations; BL - Cacheno",
-        "Counter": "0,1",
         "EventCode": "0x2",
         "EventName": "UNC_C_TxR_INSERTS.BL_CACHE",
         "PerPkg": "1",
@@ -835,7 +809,6 @@
     },
     {
         "BriefDescription": "Egress Allocations; BL - Corebo",
-        "Counter": "0,1",
         "EventCode": "0x2",
         "EventName": "UNC_C_TxR_INSERTS.BL_CORE",
         "PerPkg": "1",
@@ -845,7 +818,6 @@
     },
     {
         "BriefDescription": "Egress Allocations; IV - Cachebo",
-        "Counter": "0,1",
         "EventCode": "0x2",
         "EventName": "UNC_C_TxR_INSERTS.IV_CACHE",
         "PerPkg": "1",
@@ -855,7 +827,6 @@
     },
     {
         "BriefDescription": "Injection Starvation; Onto AK Ring",
-        "Counter": "0,1",
         "EventCode": "0x3",
         "EventName": "UNC_C_TxR_STARVED.AK",
         "PerPkg": "1",
@@ -865,7 +836,6 @@
     },
     {
         "BriefDescription": "Injection Starvation; Onto BL Ring",
-        "Counter": "0,1",
         "EventCode": "0x3",
         "EventName": "UNC_C_TxR_STARVED.BL",
         "PerPkg": "1",
@@ -875,7 +845,6 @@
     },
     {
         "BriefDescription": "HA to iMC Bypass; Not Taken",
-        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_H_BYPASS_IMC.NOT_TAKEN",
         "PerPkg": "1",
@@ -885,7 +854,6 @@
     },
     {
         "BriefDescription": "HA to iMC Bypass; Taken",
-        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_H_BYPASS_IMC.TAKEN",
         "PerPkg": "1",
@@ -895,7 +863,6 @@
     },
     {
         "BriefDescription": "uclks",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_H_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of uclks in the HA.  This =
will be slightly different than the count in the Ubox because of enable/fre=
eze delays.  The HA is on the other side of the die from the fixed Ubox ucl=
k counter, so the drift could be somewhat larger than in units that are clo=
ser like the QPI Agent.",
@@ -903,7 +870,6 @@
     },
     {
         "BriefDescription": "Conflict Checks; Conflict Detected",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb",
         "EventName": "UNC_H_CONFLICT_CYCLES.CONFLICT",
         "PerPkg": "1",
@@ -912,7 +878,6 @@
     },
     {
         "BriefDescription": "Conflict Checks; No Conflict",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb",
         "EventName": "UNC_H_CONFLICT_CYCLES.NO_CONFLICT",
         "PerPkg": "1",
@@ -921,7 +886,6 @@
     },
     {
         "BriefDescription": "Direct2Core Messages Sent",
-        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "UNC_H_DIRECT2CORE_COUNT",
         "PerPkg": "1",
@@ -930,7 +894,6 @@
     },
     {
         "BriefDescription": "Cycles when Direct2Core was Disabled",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "UNC_H_DIRECT2CORE_CYCLES_DISABLED",
         "PerPkg": "1",
@@ -939,7 +902,6 @@
     },
     {
         "BriefDescription": "Number of Reads that had Direct2Core Overridd=
en",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_H_DIRECT2CORE_TXN_OVERRIDE",
         "PerPkg": "1",
@@ -948,7 +910,6 @@
     },
     {
         "BriefDescription": "Directory Lookups; Snoop Not Needed",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc",
         "EventName": "UNC_H_DIRECTORY_LOOKUP.NO_SNP",
         "PerPkg": "1",
@@ -958,7 +919,6 @@
     },
     {
         "BriefDescription": "Directory Lookups; Snoop Needed",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc",
         "EventName": "UNC_H_DIRECTORY_LOOKUP.SNP",
         "PerPkg": "1",
@@ -968,7 +928,6 @@
     },
     {
         "BriefDescription": "Directory Updates; Any Directory Update",
-        "Counter": "0,1,2,3",
         "EventCode": "0xd",
         "EventName": "UNC_H_DIRECTORY_UPDATE.ANY",
         "PerPkg": "1",
@@ -978,7 +937,6 @@
     },
     {
         "BriefDescription": "Directory Updates; Directory Clear",
-        "Counter": "0,1,2,3",
         "EventCode": "0xd",
         "EventName": "UNC_H_DIRECTORY_UPDATE.CLEAR",
         "PerPkg": "1",
@@ -988,7 +946,6 @@
     },
     {
         "BriefDescription": "Directory Updates; Directory Set",
-        "Counter": "0,1,2,3",
         "EventCode": "0xd",
         "EventName": "UNC_H_DIRECTORY_UPDATE.SET",
         "PerPkg": "1",
@@ -998,7 +955,6 @@
     },
     {
         "BriefDescription": "Cycles without QPI Ingress Credits; AD to QPI=
 Link 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_IGR_NO_CREDIT_CYCLES.AD_QPI0",
         "PerPkg": "1",
@@ -1008,7 +964,6 @@
     },
     {
         "BriefDescription": "Cycles without QPI Ingress Credits; AD to QPI=
 Link 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_IGR_NO_CREDIT_CYCLES.AD_QPI1",
         "PerPkg": "1",
@@ -1018,7 +973,6 @@
     },
     {
         "BriefDescription": "Cycles without QPI Ingress Credits; BL to QPI=
 Link 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_IGR_NO_CREDIT_CYCLES.BL_QPI0",
         "PerPkg": "1",
@@ -1028,7 +982,6 @@
     },
     {
         "BriefDescription": "Cycles without QPI Ingress Credits; BL to QPI=
 Link 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_IGR_NO_CREDIT_CYCLES.BL_QPI1",
         "PerPkg": "1",
@@ -1038,7 +991,6 @@
     },
     {
         "BriefDescription": "Retry Events",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_H_IMC_RETRY",
         "PerPkg": "1",
@@ -1046,7 +998,6 @@
     },
     {
         "BriefDescription": "HA to iMC Full Line Writes Issued; All Writes=
",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1a",
         "EventName": "UNC_H_IMC_WRITES.ALL",
         "PerPkg": "1",
@@ -1056,7 +1007,6 @@
     },
     {
         "BriefDescription": "HA to iMC Full Line Writes Issued; Full Line =
Non-ISOCH",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1a",
         "EventName": "UNC_H_IMC_WRITES.FULL",
         "PerPkg": "1",
@@ -1066,7 +1016,6 @@
     },
     {
         "BriefDescription": "HA to iMC Full Line Writes Issued; ISOCH Full=
 Line",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1a",
         "EventName": "UNC_H_IMC_WRITES.FULL_ISOCH",
         "PerPkg": "1",
@@ -1076,7 +1025,6 @@
     },
     {
         "BriefDescription": "HA to iMC Full Line Writes Issued; Partial No=
n-ISOCH",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1a",
         "EventName": "UNC_H_IMC_WRITES.PARTIAL",
         "PerPkg": "1",
@@ -1086,7 +1034,6 @@
     },
     {
         "BriefDescription": "HA to iMC Full Line Writes Issued; ISOCH Part=
ial",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1a",
         "EventName": "UNC_H_IMC_WRITES.PARTIAL_ISOCH",
         "PerPkg": "1",
@@ -1096,7 +1043,6 @@
     },
     {
         "BriefDescription": "Read and Write Requests; Reads",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.READS",
         "PerPkg": "1",
@@ -1106,7 +1052,6 @@
     },
     {
         "BriefDescription": "Read and Write Requests; Writes",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.WRITES",
         "PerPkg": "1",
@@ -1116,7 +1061,6 @@
     },
     {
         "BriefDescription": "HA AD Ring in Use; Counterclockwise and Even"=
,
-        "Counter": "0,1,2,3",
         "EventCode": "0x3e",
         "EventName": "UNC_H_RING_AD_USED.CCW_EVEN",
         "PerPkg": "1",
@@ -1126,7 +1070,6 @@
     },
     {
         "BriefDescription": "HA AD Ring in Use; Counterclockwise and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3e",
         "EventName": "UNC_H_RING_AD_USED.CCW_ODD",
         "PerPkg": "1",
@@ -1136,7 +1079,6 @@
     },
     {
         "BriefDescription": "HA AD Ring in Use; Clockwise and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3e",
         "EventName": "UNC_H_RING_AD_USED.CW_EVEN",
         "PerPkg": "1",
@@ -1146,7 +1088,6 @@
     },
     {
         "BriefDescription": "HA AD Ring in Use; Clockwise and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3e",
         "EventName": "UNC_H_RING_AD_USED.CW_ODD",
         "PerPkg": "1",
@@ -1156,7 +1097,6 @@
     },
     {
         "BriefDescription": "HA AK Ring in Use; Counterclockwise and Even"=
,
-        "Counter": "0,1,2,3",
         "EventCode": "0x3f",
         "EventName": "UNC_H_RING_AK_USED.CCW_EVEN",
         "PerPkg": "1",
@@ -1166,7 +1106,6 @@
     },
     {
         "BriefDescription": "HA AK Ring in Use; Counterclockwise and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3f",
         "EventName": "UNC_H_RING_AK_USED.CCW_ODD",
         "PerPkg": "1",
@@ -1176,7 +1115,6 @@
     },
     {
         "BriefDescription": "HA AK Ring in Use; Clockwise and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3f",
         "EventName": "UNC_H_RING_AK_USED.CW_EVEN",
         "PerPkg": "1",
@@ -1186,7 +1124,6 @@
     },
     {
         "BriefDescription": "HA AK Ring in Use; Clockwise and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3f",
         "EventName": "UNC_H_RING_AK_USED.CW_ODD",
         "PerPkg": "1",
@@ -1196,7 +1133,6 @@
     },
     {
         "BriefDescription": "HA BL Ring in Use; Counterclockwise and Even"=
,
-        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_H_RING_BL_USED.CCW_EVEN",
         "PerPkg": "1",
@@ -1206,7 +1142,6 @@
     },
     {
         "BriefDescription": "HA BL Ring in Use; Counterclockwise and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_H_RING_BL_USED.CCW_ODD",
         "PerPkg": "1",
@@ -1216,7 +1151,6 @@
     },
     {
         "BriefDescription": "HA BL Ring in Use; Clockwise and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_H_RING_BL_USED.CW_EVEN",
         "PerPkg": "1",
@@ -1226,7 +1160,6 @@
     },
     {
         "BriefDescription": "HA BL Ring in Use; Clockwise and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_H_RING_BL_USED.CW_ODD",
         "PerPkg": "1",
@@ -1236,7 +1169,6 @@
     },
     {
         "BriefDescription": "iMC RPQ Credits Empty - Regular; Channel 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN0",
         "PerPkg": "1",
@@ -1246,7 +1178,6 @@
     },
     {
         "BriefDescription": "iMC RPQ Credits Empty - Regular; Channel 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN1",
         "PerPkg": "1",
@@ -1256,7 +1187,6 @@
     },
     {
         "BriefDescription": "iMC RPQ Credits Empty - Regular; Channel 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN2",
         "PerPkg": "1",
@@ -1266,7 +1196,6 @@
     },
     {
         "BriefDescription": "iMC RPQ Credits Empty - Regular; Channel 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN3",
         "PerPkg": "1",
@@ -1276,7 +1205,6 @@
     },
     {
         "BriefDescription": "iMC RPQ Credits Empty - Special; Channel 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x16",
         "EventName": "UNC_H_RPQ_CYCLES_NO_SPEC_CREDITS.CHN0",
         "PerPkg": "1",
@@ -1286,7 +1214,6 @@
     },
     {
         "BriefDescription": "iMC RPQ Credits Empty - Special; Channel 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x16",
         "EventName": "UNC_H_RPQ_CYCLES_NO_SPEC_CREDITS.CHN1",
         "PerPkg": "1",
@@ -1296,7 +1223,6 @@
     },
     {
         "BriefDescription": "iMC RPQ Credits Empty - Special; Channel 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x16",
         "EventName": "UNC_H_RPQ_CYCLES_NO_SPEC_CREDITS.CHN2",
         "PerPkg": "1",
@@ -1306,7 +1232,6 @@
     },
     {
         "BriefDescription": "iMC RPQ Credits Empty - Special; Channel 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x16",
         "EventName": "UNC_H_RPQ_CYCLES_NO_SPEC_CREDITS.CHN3",
         "PerPkg": "1",
@@ -1316,7 +1241,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_H_TAD_REQUESTS_G0.REGION0",
         "PerPkg": "1",
@@ -1326,7 +1250,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_H_TAD_REQUESTS_G0.REGION1",
         "PerPkg": "1",
@@ -1336,7 +1259,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_H_TAD_REQUESTS_G0.REGION2",
         "PerPkg": "1",
@@ -1346,7 +1268,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_H_TAD_REQUESTS_G0.REGION3",
         "PerPkg": "1",
@@ -1356,7 +1277,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_H_TAD_REQUESTS_G0.REGION4",
         "PerPkg": "1",
@@ -1366,7 +1286,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_H_TAD_REQUESTS_G0.REGION5",
         "PerPkg": "1",
@@ -1376,7 +1295,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_H_TAD_REQUESTS_G0.REGION6",
         "PerPkg": "1",
@@ -1386,7 +1304,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_H_TAD_REQUESTS_G0.REGION7",
         "PerPkg": "1",
@@ -1396,7 +1313,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 1; TAD Re=
gion 10",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1c",
         "EventName": "UNC_H_TAD_REQUESTS_G1.REGION10",
         "PerPkg": "1",
@@ -1406,7 +1322,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 1; TAD Re=
gion 11",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1c",
         "EventName": "UNC_H_TAD_REQUESTS_G1.REGION11",
         "PerPkg": "1",
@@ -1416,7 +1331,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 1; TAD Re=
gion 8",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1c",
         "EventName": "UNC_H_TAD_REQUESTS_G1.REGION8",
         "PerPkg": "1",
@@ -1426,7 +1340,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 1; TAD Re=
gion 9",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1c",
         "EventName": "UNC_H_TAD_REQUESTS_G1.REGION9",
         "PerPkg": "1",
@@ -1436,7 +1349,6 @@
     },
     {
         "BriefDescription": "Tracker Allocations; All Requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6",
         "EventName": "UNC_H_TRACKER_INSERTS.ALL",
         "PerPkg": "1",
@@ -1446,7 +1358,6 @@
     },
     {
         "BriefDescription": "Outbound NDR Ring Transactions; Non-data Resp=
onses",
-        "Counter": "0,1,2,3",
         "EventCode": "0xf",
         "EventName": "UNC_H_TxR_AD.NDR",
         "PerPkg": "1",
@@ -1456,7 +1367,6 @@
     },
     {
         "BriefDescription": "Outbound NDR Ring Transactions; Snoops",
-        "Counter": "0,1,2,3",
         "EventCode": "0xf",
         "EventName": "UNC_H_TxR_AD.SNP",
         "PerPkg": "1",
@@ -1466,217 +1376,174 @@
     },
     {
         "BriefDescription": "AD Egress Full; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2a",
         "EventName": "UNC_H_TxR_AD_CYCLES_FULL.ALL",
         "PerPkg": "1",
-        "PublicDescription": "AD Egress Full",
         "UMask": "0x3",
         "Unit": "HA"
     },
     {
         "BriefDescription": "AD Egress Full; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2a",
         "EventName": "UNC_H_TxR_AD_CYCLES_FULL.SCHED0",
         "PerPkg": "1",
-        "PublicDescription": "AD Egress Full",
         "UMask": "0x1",
         "Unit": "HA"
     },
     {
         "BriefDescription": "AD Egress Full; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2a",
         "EventName": "UNC_H_TxR_AD_CYCLES_FULL.SCHED1",
         "PerPkg": "1",
-        "PublicDescription": "AD Egress Full",
         "UMask": "0x2",
         "Unit": "HA"
     },
     {
         "BriefDescription": "AD Egress Not Empty; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_H_TxR_AD_CYCLES_NE.ALL",
         "PerPkg": "1",
-        "PublicDescription": "AD Egress Not Empty",
         "UMask": "0x3",
         "Unit": "HA"
     },
     {
         "BriefDescription": "AD Egress Not Empty; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_H_TxR_AD_CYCLES_NE.SCHED0",
         "PerPkg": "1",
-        "PublicDescription": "AD Egress Not Empty",
         "UMask": "0x1",
         "Unit": "HA"
     },
     {
         "BriefDescription": "AD Egress Not Empty; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_H_TxR_AD_CYCLES_NE.SCHED1",
         "PerPkg": "1",
-        "PublicDescription": "AD Egress Not Empty",
         "UMask": "0x2",
         "Unit": "HA"
     },
     {
         "BriefDescription": "AD Egress Allocations; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_H_TxR_AD_INSERTS.ALL",
         "PerPkg": "1",
-        "PublicDescription": "AD Egress Allocations",
         "UMask": "0x3",
         "Unit": "HA"
     },
     {
         "BriefDescription": "AD Egress Allocations; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_H_TxR_AD_INSERTS.SCHED0",
         "PerPkg": "1",
-        "PublicDescription": "AD Egress Allocations",
         "UMask": "0x1",
         "Unit": "HA"
     },
     {
         "BriefDescription": "AD Egress Allocations; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_H_TxR_AD_INSERTS.SCHED1",
         "PerPkg": "1",
-        "PublicDescription": "AD Egress Allocations",
         "UMask": "0x2",
         "Unit": "HA"
     },
     {
         "BriefDescription": "AD Egress Occupancy; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_H_TxR_AD_OCCUPANCY.ALL",
         "PerPkg": "1",
-        "PublicDescription": "AD Egress Occupancy",
         "UMask": "0x3",
         "Unit": "HA"
     },
     {
         "BriefDescription": "AD Egress Occupancy; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_H_TxR_AD_OCCUPANCY.SCHED0",
         "PerPkg": "1",
-        "PublicDescription": "AD Egress Occupancy",
         "UMask": "0x1",
         "Unit": "HA"
     },
     {
         "BriefDescription": "AD Egress Occupancy; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_H_TxR_AD_OCCUPANCY.SCHED1",
         "PerPkg": "1",
-        "PublicDescription": "AD Egress Occupancy",
         "UMask": "0x2",
         "Unit": "HA"
     },
     {
         "BriefDescription": "AK Egress Full; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_H_TxR_AK_CYCLES_FULL.ALL",
         "PerPkg": "1",
-        "PublicDescription": "AK Egress Full",
         "UMask": "0x3",
         "Unit": "HA"
     },
     {
         "BriefDescription": "AK Egress Full; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_H_TxR_AK_CYCLES_FULL.SCHED0",
         "PerPkg": "1",
-        "PublicDescription": "AK Egress Full",
         "UMask": "0x1",
         "Unit": "HA"
     },
     {
         "BriefDescription": "AK Egress Full; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_H_TxR_AK_CYCLES_FULL.SCHED1",
         "PerPkg": "1",
-        "PublicDescription": "AK Egress Full",
         "UMask": "0x2",
         "Unit": "HA"
     },
     {
         "BriefDescription": "AK Egress Not Empty; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "UNC_H_TxR_AK_CYCLES_NE.ALL",
         "PerPkg": "1",
-        "PublicDescription": "AK Egress Not Empty",
         "UMask": "0x3",
         "Unit": "HA"
     },
     {
         "BriefDescription": "AK Egress Not Empty; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "UNC_H_TxR_AK_CYCLES_NE.SCHED0",
         "PerPkg": "1",
-        "PublicDescription": "AK Egress Not Empty",
         "UMask": "0x1",
         "Unit": "HA"
     },
     {
         "BriefDescription": "AK Egress Not Empty; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "UNC_H_TxR_AK_CYCLES_NE.SCHED1",
         "PerPkg": "1",
-        "PublicDescription": "AK Egress Not Empty",
         "UMask": "0x2",
         "Unit": "HA"
     },
     {
         "BriefDescription": "AK Egress Allocations; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2f",
         "EventName": "UNC_H_TxR_AK_INSERTS.ALL",
         "PerPkg": "1",
-        "PublicDescription": "AK Egress Allocations",
         "UMask": "0x3",
         "Unit": "HA"
     },
     {
         "BriefDescription": "AK Egress Allocations; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2f",
         "EventName": "UNC_H_TxR_AK_INSERTS.SCHED0",
         "PerPkg": "1",
-        "PublicDescription": "AK Egress Allocations",
         "UMask": "0x1",
         "Unit": "HA"
     },
     {
         "BriefDescription": "AK Egress Allocations; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2f",
         "EventName": "UNC_H_TxR_AK_INSERTS.SCHED1",
         "PerPkg": "1",
-        "PublicDescription": "AK Egress Allocations",
         "UMask": "0x2",
         "Unit": "HA"
     },
     {
         "BriefDescription": "Outbound NDR Ring Transactions",
-        "Counter": "0,1,2,3",
         "EventCode": "0xe",
         "EventName": "UNC_H_TxR_AK_NDR",
         "PerPkg": "1",
@@ -1685,37 +1552,30 @@
     },
     {
         "BriefDescription": "AK Egress Occupancy; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x30",
         "EventName": "UNC_H_TxR_AK_OCCUPANCY.ALL",
         "PerPkg": "1",
-        "PublicDescription": "AK Egress Occupancy",
         "UMask": "0x3",
         "Unit": "HA"
     },
     {
         "BriefDescription": "AK Egress Occupancy; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x30",
         "EventName": "UNC_H_TxR_AK_OCCUPANCY.SCHED0",
         "PerPkg": "1",
-        "PublicDescription": "AK Egress Occupancy",
         "UMask": "0x1",
         "Unit": "HA"
     },
     {
         "BriefDescription": "AK Egress Occupancy; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x30",
         "EventName": "UNC_H_TxR_AK_OCCUPANCY.SCHED1",
         "PerPkg": "1",
-        "PublicDescription": "AK Egress Occupancy",
         "UMask": "0x2",
         "Unit": "HA"
     },
     {
         "BriefDescription": "Outbound DRS Ring Transactions to Cache; Data=
 to Cache",
-        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_H_TxR_BL.DRS_CACHE",
         "PerPkg": "1",
@@ -1725,7 +1585,6 @@
     },
     {
         "BriefDescription": "Outbound DRS Ring Transactions to Cache; Data=
 to Core",
-        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_H_TxR_BL.DRS_CORE",
         "PerPkg": "1",
@@ -1735,7 +1594,6 @@
     },
     {
         "BriefDescription": "Outbound DRS Ring Transactions to Cache; Data=
 to QPI",
-        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_H_TxR_BL.DRS_QPI",
         "PerPkg": "1",
@@ -1745,127 +1603,102 @@
     },
     {
         "BriefDescription": "BL Egress Full; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x36",
         "EventName": "UNC_H_TxR_BL_CYCLES_FULL.ALL",
         "PerPkg": "1",
-        "PublicDescription": "BL Egress Full",
         "UMask": "0x3",
         "Unit": "HA"
     },
     {
         "BriefDescription": "BL Egress Full; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x36",
         "EventName": "UNC_H_TxR_BL_CYCLES_FULL.SCHED0",
         "PerPkg": "1",
-        "PublicDescription": "BL Egress Full",
         "UMask": "0x1",
         "Unit": "HA"
     },
     {
         "BriefDescription": "BL Egress Full; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x36",
         "EventName": "UNC_H_TxR_BL_CYCLES_FULL.SCHED1",
         "PerPkg": "1",
-        "PublicDescription": "BL Egress Full",
         "UMask": "0x2",
         "Unit": "HA"
     },
     {
         "BriefDescription": "BL Egress Not Empty; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_H_TxR_BL_CYCLES_NE.ALL",
         "PerPkg": "1",
-        "PublicDescription": "BL Egress Not Empty",
         "UMask": "0x3",
         "Unit": "HA"
     },
     {
         "BriefDescription": "BL Egress Not Empty; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_H_TxR_BL_CYCLES_NE.SCHED0",
         "PerPkg": "1",
-        "PublicDescription": "BL Egress Not Empty",
         "UMask": "0x1",
         "Unit": "HA"
     },
     {
         "BriefDescription": "BL Egress Not Empty; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_H_TxR_BL_CYCLES_NE.SCHED1",
         "PerPkg": "1",
-        "PublicDescription": "BL Egress Not Empty",
         "UMask": "0x2",
         "Unit": "HA"
     },
     {
         "BriefDescription": "BL Egress Allocations; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_H_TxR_BL_INSERTS.ALL",
         "PerPkg": "1",
-        "PublicDescription": "BL Egress Allocations",
         "UMask": "0x3",
         "Unit": "HA"
     },
     {
         "BriefDescription": "BL Egress Allocations; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_H_TxR_BL_INSERTS.SCHED0",
         "PerPkg": "1",
-        "PublicDescription": "BL Egress Allocations",
         "UMask": "0x1",
         "Unit": "HA"
     },
     {
         "BriefDescription": "BL Egress Allocations; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_H_TxR_BL_INSERTS.SCHED1",
         "PerPkg": "1",
-        "PublicDescription": "BL Egress Allocations",
         "UMask": "0x2",
         "Unit": "HA"
     },
     {
         "BriefDescription": "BL Egress Occupancy; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_H_TxR_BL_OCCUPANCY.ALL",
         "PerPkg": "1",
-        "PublicDescription": "BL Egress Occupancy",
         "UMask": "0x3",
         "Unit": "HA"
     },
     {
         "BriefDescription": "BL Egress Occupancy; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_H_TxR_BL_OCCUPANCY.SCHED0",
         "PerPkg": "1",
-        "PublicDescription": "BL Egress Occupancy",
         "UMask": "0x1",
         "Unit": "HA"
     },
     {
         "BriefDescription": "BL Egress Occupancy; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_H_TxR_BL_OCCUPANCY.SCHED1",
         "PerPkg": "1",
-        "PublicDescription": "BL Egress Occupancy",
         "UMask": "0x2",
         "Unit": "HA"
     },
     {
         "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Regular; Chan=
nel 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_H_WPQ_CYCLES_NO_REG_CREDITS.CHN0",
         "PerPkg": "1",
@@ -1875,7 +1708,6 @@
     },
     {
         "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Regular; Chan=
nel 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_H_WPQ_CYCLES_NO_REG_CREDITS.CHN1",
         "PerPkg": "1",
@@ -1885,7 +1717,6 @@
     },
     {
         "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Regular; Chan=
nel 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_H_WPQ_CYCLES_NO_REG_CREDITS.CHN2",
         "PerPkg": "1",
@@ -1895,7 +1726,6 @@
     },
     {
         "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Regular; Chan=
nel 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_H_WPQ_CYCLES_NO_REG_CREDITS.CHN3",
         "PerPkg": "1",
@@ -1905,7 +1735,6 @@
     },
     {
         "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Special; Chan=
nel 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_H_WPQ_CYCLES_NO_SPEC_CREDITS.CHN0",
         "PerPkg": "1",
@@ -1915,7 +1744,6 @@
     },
     {
         "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Special; Chan=
nel 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_H_WPQ_CYCLES_NO_SPEC_CREDITS.CHN1",
         "PerPkg": "1",
@@ -1925,7 +1753,6 @@
     },
     {
         "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Special; Chan=
nel 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_H_WPQ_CYCLES_NO_SPEC_CREDITS.CHN2",
         "PerPkg": "1",
@@ -1935,7 +1762,6 @@
     },
     {
         "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Special; Chan=
nel 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_H_WPQ_CYCLES_NO_SPEC_CREDITS.CHN3",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.js=
on b/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
index 750870fd1cb1..1c2cf94889a1 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "Number of qfclks",
-        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_Q_CLOCKTICKS",
         "PerPkg": "1",
@@ -10,17 +9,14 @@
     },
     {
         "BriefDescription": "Count of CTO Events",
-        "Counter": "0,1,2,3",
         "EventCode": "0x38",
         "EventName": "UNC_Q_CTO_COUNT",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of CTO (cluster trigger ou=
ts) events that were asserted across the two slots.  If both slots trigger =
in a given cycle, the event will increment by 2.  You can use edge detect t=
o count the number of cases when both events triggered.",
         "Unit": "QPI LL"
     },
     {
         "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egres=
s Credits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS",
         "PerPkg": "1",
@@ -30,7 +26,6 @@
     },
     {
         "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egres=
s and RBT",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_RBT",
         "PerPkg": "1",
@@ -40,7 +35,6 @@
     },
     {
         "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - RBT N=
ot Set",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_RBT",
         "PerPkg": "1",
@@ -50,7 +44,6 @@
     },
     {
         "BriefDescription": "Direct 2 Core Spawning; Spawn Success",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.SUCCESS",
         "PerPkg": "1",
@@ -60,7 +53,6 @@
     },
     {
         "BriefDescription": "Cycles in L1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "UNC_Q_L1_POWER_CYCLES",
         "PerPkg": "1",
@@ -69,7 +61,6 @@
     },
     {
         "BriefDescription": "Cycles in L0p",
-        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_Q_RxL0P_POWER_CYCLES",
         "PerPkg": "1",
@@ -78,7 +69,6 @@
     },
     {
         "BriefDescription": "Cycles in L0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xf",
         "EventName": "UNC_Q_RxL0_POWER_CYCLES",
         "PerPkg": "1",
@@ -87,7 +77,6 @@
     },
     {
         "BriefDescription": "Rx Flit Buffer Bypassed",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_Q_RxL_BYPASSED",
         "PerPkg": "1",
@@ -96,7 +85,6 @@
     },
     {
         "BriefDescription": "CRC Errors Detected; LinkInit",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3",
         "EventName": "UNC_Q_RxL_CRC_ERRORS.LINK_INIT",
         "PerPkg": "1",
@@ -106,7 +94,6 @@
     },
     {
         "BriefDescription": "CRC Errors Detected; Normal Operations",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3",
         "EventName": "UNC_Q_RxL_CRC_ERRORS.NORMAL_OP",
         "PerPkg": "1",
@@ -116,10 +103,8 @@
     },
     {
         "BriefDescription": "VN0 Credit Consumed; DRS",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.DRS",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
",
         "UMask": "0x1",
@@ -127,10 +112,8 @@
     },
     {
         "BriefDescription": "VN0 Credit Consumed; HOM",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.HOM",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
",
         "UMask": "0x8",
@@ -138,10 +121,8 @@
     },
     {
         "BriefDescription": "VN0 Credit Consumed; NCB",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.NCB",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
",
         "UMask": "0x2",
@@ -149,10 +130,8 @@
     },
     {
         "BriefDescription": "VN0 Credit Consumed; NCS",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.NCS",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
",
         "UMask": "0x4",
@@ -160,10 +139,8 @@
     },
     {
         "BriefDescription": "VN0 Credit Consumed; NDR",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.NDR",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
",
         "UMask": "0x20",
@@ -171,10 +148,8 @@
     },
     {
         "BriefDescription": "VN0 Credit Consumed; SNP",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.SNP",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
",
         "UMask": "0x10",
@@ -182,17 +157,14 @@
     },
     {
         "BriefDescription": "VNA Credit Consumed",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VNA",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VNA c=
redit was consumed (i.e. message uses a VNA credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
",
         "Unit": "QPI LL"
     },
     {
         "BriefDescription": "RxQ Cycles Not Empty",
-        "Counter": "0,1,2,3",
         "EventCode": "0xa",
         "EventName": "UNC_Q_RxL_CYCLES_NE",
         "PerPkg": "1",
@@ -201,7 +173,6 @@
     },
     {
         "BriefDescription": "Flits Received - Group 0; Data Tx Flits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_Q_RxL_FLITS_G0.DATA",
         "PerPkg": "1",
@@ -211,7 +182,6 @@
     },
     {
         "BriefDescription": "Flits Received - Group 0; Idle and Null Flits=
",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_Q_RxL_FLITS_G0.IDLE",
         "PerPkg": "1",
@@ -221,7 +191,6 @@
     },
     {
         "BriefDescription": "Flits Received - Group 0; Non-Data protocol T=
x Flits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_Q_RxL_FLITS_G0.NON_DATA",
         "PerPkg": "1",
@@ -231,10 +200,8 @@
     },
     {
         "BriefDescription": "Flits Received - Group 1; DRS Flits (both Hea=
der and Data)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.DRS",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
         "UMask": "0x18",
@@ -242,10 +209,8 @@
     },
     {
         "BriefDescription": "Flits Received - Group 1; DRS Data Flits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.DRS_DATA",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
         "UMask": "0x8",
@@ -253,10 +218,8 @@
     },
     {
         "BriefDescription": "Flits Received - Group 1; DRS Header Flits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.DRS_NONDATA",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
         "UMask": "0x10",
@@ -264,10 +227,8 @@
     },
     {
         "BriefDescription": "Flits Received - Group 1; HOM Flits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.HOM",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
         "UMask": "0x6",
@@ -275,10 +236,8 @@
     },
     {
         "BriefDescription": "Flits Received - Group 1; HOM Non-Request Fli=
ts",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.HOM_NONREQ",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
         "UMask": "0x4",
@@ -286,10 +245,8 @@
     },
     {
         "BriefDescription": "Flits Received - Group 1; HOM Request Flits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.HOM_REQ",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
         "UMask": "0x2",
@@ -297,10 +254,8 @@
     },
     {
         "BriefDescription": "Flits Received - Group 1; SNP Flits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.SNP",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
         "UMask": "0x1",
@@ -308,10 +263,8 @@
     },
     {
         "BriefDescription": "Flits Received - Group 2; Non-Coherent Rx Fli=
ts",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3",
         "EventName": "UNC_Q_RxL_FLITS_G2.NCB",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
         "UMask": "0xc",
@@ -319,10 +272,8 @@
     },
     {
         "BriefDescription": "Flits Received - Group 2; Non-Coherent data R=
x Flits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3",
         "EventName": "UNC_Q_RxL_FLITS_G2.NCB_DATA",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
         "UMask": "0x4",
@@ -330,10 +281,8 @@
     },
     {
         "BriefDescription": "Flits Received - Group 2; Non-Coherent non-da=
ta Rx Flits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3",
         "EventName": "UNC_Q_RxL_FLITS_G2.NCB_NONDATA",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
         "UMask": "0x8",
@@ -341,10 +290,8 @@
     },
     {
         "BriefDescription": "Flits Received - Group 2; Non-Coherent standa=
rd Rx Flits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3",
         "EventName": "UNC_Q_RxL_FLITS_G2.NCS",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
         "UMask": "0x10",
@@ -352,10 +299,8 @@
     },
     {
         "BriefDescription": "Flits Received - Group 2; Non-Data Response R=
x Flits - AD",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3",
         "EventName": "UNC_Q_RxL_FLITS_G2.NDR_AD",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
         "UMask": "0x1",
@@ -363,10 +308,8 @@
     },
     {
         "BriefDescription": "Flits Received - Group 2; Non-Data Response R=
x Flits - AK",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3",
         "EventName": "UNC_Q_RxL_FLITS_G2.NDR_AK",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
         "UMask": "0x2",
@@ -374,7 +317,6 @@
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_Q_RxL_INSERTS",
         "PerPkg": "1",
@@ -383,67 +325,54 @@
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - DRS",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_Q_RxL_INSERTS_DRS",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only DRS flits.",
         "Unit": "QPI LL"
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - HOM",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc",
         "EventName": "UNC_Q_RxL_INSERTS_HOM",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only HOM flits.",
         "Unit": "QPI LL"
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - NCB",
-        "Counter": "0,1,2,3",
         "EventCode": "0xa",
         "EventName": "UNC_Q_RxL_INSERTS_NCB",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NCB flits.",
         "Unit": "QPI LL"
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - NCS",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb",
         "EventName": "UNC_Q_RxL_INSERTS_NCS",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NCS flits.",
         "Unit": "QPI LL"
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - NDR",
-        "Counter": "0,1,2,3",
         "EventCode": "0xe",
         "EventName": "UNC_Q_RxL_INSERTS_NDR",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NDR flits.",
         "Unit": "QPI LL"
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - SNP",
-        "Counter": "0,1,2,3",
         "EventCode": "0xd",
         "EventName": "UNC_Q_RxL_INSERTS_SNP",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only SNP flits.",
         "Unit": "QPI LL"
     },
     {
         "BriefDescription": "RxQ Occupancy - All Packets",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb",
         "EventName": "UNC_Q_RxL_OCCUPANCY",
         "PerPkg": "1",
@@ -452,67 +381,54 @@
     },
     {
         "BriefDescription": "RxQ Occupancy - DRS",
-        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_Q_RxL_OCCUPANCY_DRS",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors DRS flits only.",
         "Unit": "QPI LL"
     },
     {
         "BriefDescription": "RxQ Occupancy - HOM",
-        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_Q_RxL_OCCUPANCY_HOM",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors HOM flits only.",
         "Unit": "QPI LL"
     },
     {
         "BriefDescription": "RxQ Occupancy - NCB",
-        "Counter": "0,1,2,3",
         "EventCode": "0x16",
         "EventName": "UNC_Q_RxL_OCCUPANCY_NCB",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NCB flits only.",
         "Unit": "QPI LL"
     },
     {
         "BriefDescription": "RxQ Occupancy - NCS",
-        "Counter": "0,1,2,3",
         "EventCode": "0x17",
         "EventName": "UNC_Q_RxL_OCCUPANCY_NCS",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NCS flits only.",
         "Unit": "QPI LL"
     },
     {
         "BriefDescription": "RxQ Occupancy - NDR",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1a",
         "EventName": "UNC_Q_RxL_OCCUPANCY_NDR",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NDR flits only.",
         "Unit": "QPI LL"
     },
     {
         "BriefDescription": "RxQ Occupancy - SNP",
-        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_Q_RxL_OCCUPANCY_SNP",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors SNP flits only.",
         "Unit": "QPI LL"
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI; BGF Stall - HOM",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_Q_RxL_STALLS.BGF_DRS",
         "PerPkg": "1",
@@ -522,7 +438,6 @@
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI; BGF Stall - DRS",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_Q_RxL_STALLS.BGF_HOM",
         "PerPkg": "1",
@@ -532,7 +447,6 @@
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI; BGF Stall - SNP",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_Q_RxL_STALLS.BGF_NCB",
         "PerPkg": "1",
@@ -542,7 +456,6 @@
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI; BGF Stall - NDR",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_Q_RxL_STALLS.BGF_NCS",
         "PerPkg": "1",
@@ -552,7 +465,6 @@
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI; BGF Stall - NCS",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_Q_RxL_STALLS.BGF_NDR",
         "PerPkg": "1",
@@ -562,7 +474,6 @@
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI; BGF Stall - NCB",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_Q_RxL_STALLS.BGF_SNP",
         "PerPkg": "1",
@@ -572,7 +483,6 @@
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI; Egress Credits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_Q_RxL_STALLS.EGRESS_CREDITS",
         "PerPkg": "1",
@@ -582,7 +492,6 @@
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI; GV",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_Q_RxL_STALLS.GV",
         "PerPkg": "1",
@@ -592,7 +501,6 @@
     },
     {
         "BriefDescription": "Cycles in L0p",
-        "Counter": "0,1,2,3",
         "EventCode": "0xd",
         "EventName": "UNC_Q_TxL0P_POWER_CYCLES",
         "PerPkg": "1",
@@ -601,7 +509,6 @@
     },
     {
         "BriefDescription": "Cycles in L0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc",
         "EventName": "UNC_Q_TxL0_POWER_CYCLES",
         "PerPkg": "1",
@@ -610,7 +517,6 @@
     },
     {
         "BriefDescription": "Tx Flit Buffer Bypassed",
-        "Counter": "0,1,2,3",
         "EventCode": "0x5",
         "EventName": "UNC_Q_TxL_BYPASSED",
         "PerPkg": "1",
@@ -619,7 +525,6 @@
     },
     {
         "BriefDescription": "Cycles Stalled with no LLR Credits; LLR is al=
most full",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_Q_TxL_CRC_NO_CREDITS.ALMOST_FULL",
         "PerPkg": "1",
@@ -629,7 +534,6 @@
     },
     {
         "BriefDescription": "Cycles Stalled with no LLR Credits; LLR is fu=
ll",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_Q_TxL_CRC_NO_CREDITS.FULL",
         "PerPkg": "1",
@@ -639,7 +543,6 @@
     },
     {
         "BriefDescription": "Tx Flit Buffer Cycles not Empty",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6",
         "EventName": "UNC_Q_TxL_CYCLES_NE",
         "PerPkg": "1",
@@ -648,7 +551,6 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 0; Data Tx Flits",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_Q_TxL_FLITS_G0.DATA",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach 'flit' is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four 'fits', each of wh=
ich contains 20 bits of data (along with some additional ECC data).   In ha=
lf-width (L0p) mode, the fits are only 10 bits, and therefore it takes twic=
e as many fits to transmit a flit.  When one talks about QPI 'speed' (for e=
xample, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0,=
 the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One=
 can calculate the bandwidth of the link by taking: flits*80b/time.  Note t=
hat this is not the same as 'data' bandwidth.  For example, when we are tra=
nsfering a 64B cacheline across QPI, we will break it into 9 flits -- 1 wit=
h header information and 8 with 64 bits of actual 'data' and an additional =
16 bits of other information.  To calculate 'data' bandwidth, one should th=
erefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
@@ -657,7 +559,6 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 0; Idle and Null Fl=
its",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_Q_TxL_FLITS_G0.IDLE",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach 'flit' is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four 'fits', each of wh=
ich contains 20 bits of data (along with some additional ECC data).   In ha=
lf-width (L0p) mode, the fits are only 10 bits, and therefore it takes twic=
e as many fits to transmit a flit.  When one talks about QPI 'speed' (for e=
xample, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0,=
 the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One=
 can calculate the bandwidth of the link by taking: flits*80b/time.  Note t=
hat this is not the same as 'data' bandwidth.  For example, when we are tra=
nsfering a 64B cacheline across QPI, we will break it into 9 flits -- 1 wit=
h header information and 8 with 64 bits of actual 'data' and an additional =
16 bits of other information.  To calculate 'data' bandwidth, one should th=
erefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
@@ -666,7 +567,6 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 0; Non-Data protoco=
l Tx Flits",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_Q_TxL_FLITS_G0.NON_DATA",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach 'flit' is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four 'fits', each of wh=
ich contains 20 bits of data (along with some additional ECC data).   In ha=
lf-width (L0p) mode, the fits are only 10 bits, and therefore it takes twic=
e as many fits to transmit a flit.  When one talks about QPI 'speed' (for e=
xample, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0,=
 the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One=
 can calculate the bandwidth of the link by taking: flits*80b/time.  Note t=
hat this is not the same as 'data' bandwidth.  For example, when we are tra=
nsfering a 64B cacheline across QPI, we will break it into 9 flits -- 1 wit=
h header information and 8 with 64 bits of actual 'data' and an additional =
16 bits of other information.  To calculate 'data' bandwidth, one should th=
erefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
@@ -675,9 +575,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; DRS Flits (both =
Header and Data)",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
         "UMask": "0x18",
@@ -685,9 +583,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; DRS Data Flits",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS_DATA",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
         "UMask": "0x8",
@@ -695,9 +591,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; DRS Header Flits=
",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS_NONDATA",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
         "UMask": "0x10",
@@ -705,9 +599,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; HOM Flits",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
         "UMask": "0x6",
@@ -715,9 +607,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; HOM Non-Request =
Flits",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM_NONREQ",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
         "UMask": "0x4",
@@ -725,9 +615,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; HOM Request Flit=
s",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM_REQ",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
         "UMask": "0x2",
@@ -735,9 +623,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; SNP Flits",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_Q_TxL_FLITS_G1.SNP",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
         "UMask": "0x1",
@@ -745,10 +631,8 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 2; Non-Coherent Byp=
ass Tx Flits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NCB",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
         "UMask": "0xc",
@@ -756,10 +640,8 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 2; Non-Coherent dat=
a Tx Flits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NCB_DATA",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
         "UMask": "0x4",
@@ -767,10 +649,8 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 2; Non-Coherent non=
-data Tx Flits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NCB_NONDATA",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
         "UMask": "0x8",
@@ -778,10 +658,8 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 2; Non-Coherent sta=
ndard Tx Flits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NCS",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
         "UMask": "0x10",
@@ -789,10 +667,8 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 2; Non-Data Respons=
e Tx Flits - AD",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NDR_AD",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
         "UMask": "0x1",
@@ -800,10 +676,8 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 2; Non-Data Respons=
e Tx Flits - AK",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NDR_AK",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
         "UMask": "0x2",
@@ -811,7 +685,6 @@
     },
     {
         "BriefDescription": "Tx Flit Buffer Allocations",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_Q_TxL_INSERTS",
         "PerPkg": "1",
@@ -820,7 +693,6 @@
     },
     {
         "BriefDescription": "Tx Flit Buffer Occupancy",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_Q_TxL_OCCUPANCY",
         "PerPkg": "1",
@@ -829,20 +701,16 @@
     },
     {
         "BriefDescription": "VNA Credits Returned",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1c",
         "EventName": "UNC_Q_VNA_CREDIT_RETURNS",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of VNA credits returned.",
         "Unit": "QPI LL"
     },
     {
         "BriefDescription": "VNA Credits Pending Return - Occupancy",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_Q_VNA_CREDIT_RETURN_OCCUPANCY",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of VNA credits in the Rx side that ar=
e waitng to be returned back across the link.",
         "Unit": "QPI LL"
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-memory.json b/t=
ools/perf/pmu-events/arch/x86/jaketown/uncore-memory.json
index a165a77947a0..2faf0dc6675d 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-memory.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "DRAM Activate Count",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_M_ACT_COUNT",
         "PerPkg": "1",
@@ -10,77 +9,62 @@
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; All DRAM WR=
_CAS (w/ and w/out auto-pre)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.ALL",
         "PerPkg": "1",
-        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands",
         "UMask": "0xf",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; All DRAM Re=
ads (RD_CAS + Underfills)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.RD",
         "PerPkg": "1",
-        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands",
         "UMask": "0x3",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; All DRAM RD=
_CAS (w/ and w/out auto-pre)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.RD_REG",
         "PerPkg": "1",
-        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands",
         "UMask": "0x1",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; Underfill R=
ead Issued",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.RD_UNDERFILL",
         "PerPkg": "1",
-        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands",
         "UMask": "0x2",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; All DRAM WR=
_CAS (both Modes)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.WR",
         "PerPkg": "1",
-        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands",
         "UMask": "0xc",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; DRAM WR_CAS=
 (w/ and w/out auto-pre) in Read Major Mode",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.WR_RMM",
         "PerPkg": "1",
-        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands",
         "UMask": "0x8",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; DRAM WR_CAS=
 (w/ and w/out auto-pre) in Write Major Mode",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.WR_WMM",
         "PerPkg": "1",
-        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands",
         "UMask": "0x4",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "uclks",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_M_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "Uncore Fixed Counter - uclks",
@@ -88,7 +72,6 @@
     },
     {
         "BriefDescription": "DRAM Precharge All Commands",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6",
         "EventName": "UNC_M_DRAM_PRE_ALL",
         "PerPkg": "1",
@@ -97,7 +80,6 @@
     },
     {
         "BriefDescription": "Number of DRAM Refreshes Issued",
-        "Counter": "0,1,2,3",
         "EventCode": "0x5",
         "EventName": "UNC_M_DRAM_REFRESH.HIGH",
         "PerPkg": "1",
@@ -107,7 +89,6 @@
     },
     {
         "BriefDescription": "Number of DRAM Refreshes Issued",
-        "Counter": "0,1,2,3",
         "EventCode": "0x5",
         "EventName": "UNC_M_DRAM_REFRESH.PANIC",
         "PerPkg": "1",
@@ -117,7 +98,6 @@
     },
     {
         "BriefDescription": "ECC Correctable Errors",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_M_ECC_CORRECTABLE_ERRORS",
         "PerPkg": "1",
@@ -126,7 +106,6 @@
     },
     {
         "BriefDescription": "Cycles in a Major Mode; Isoch Major Mode",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_M_MAJOR_MODES.ISOCH",
         "PerPkg": "1",
@@ -136,7 +115,6 @@
     },
     {
         "BriefDescription": "Cycles in a Major Mode; Partial Major Mode",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_M_MAJOR_MODES.PARTIAL",
         "PerPkg": "1",
@@ -146,7 +124,6 @@
     },
     {
         "BriefDescription": "Cycles in a Major Mode; Read Major Mode",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_M_MAJOR_MODES.READ",
         "PerPkg": "1",
@@ -156,7 +133,6 @@
     },
     {
         "BriefDescription": "Cycles in a Major Mode; Write Major Mode",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_M_MAJOR_MODES.WRITE",
         "PerPkg": "1",
@@ -166,7 +142,6 @@
     },
     {
         "BriefDescription": "Channel DLLOFF Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_M_POWER_CHANNEL_DLLOFF",
         "PerPkg": "1",
@@ -175,7 +150,6 @@
     },
     {
         "BriefDescription": "Channel PPD Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "UNC_M_POWER_CHANNEL_PPD",
         "PerPkg": "1",
@@ -184,7 +158,6 @@
     },
     {
         "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_M_POWER_CKE_CYCLES.RANK0",
         "PerPkg": "1",
@@ -194,7 +167,6 @@
     },
     {
         "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_M_POWER_CKE_CYCLES.RANK1",
         "PerPkg": "1",
@@ -204,7 +176,6 @@
     },
     {
         "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_M_POWER_CKE_CYCLES.RANK2",
         "PerPkg": "1",
@@ -214,7 +185,6 @@
     },
     {
         "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_M_POWER_CKE_CYCLES.RANK3",
         "PerPkg": "1",
@@ -224,7 +194,6 @@
     },
     {
         "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_M_POWER_CKE_CYCLES.RANK4",
         "PerPkg": "1",
@@ -234,7 +203,6 @@
     },
     {
         "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_M_POWER_CKE_CYCLES.RANK5",
         "PerPkg": "1",
@@ -244,7 +212,6 @@
     },
     {
         "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_M_POWER_CKE_CYCLES.RANK6",
         "PerPkg": "1",
@@ -254,7 +221,6 @@
     },
     {
         "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_M_POWER_CKE_CYCLES.RANK7",
         "PerPkg": "1",
@@ -264,7 +230,6 @@
     },
     {
         "BriefDescription": "Critical Throttle Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_M_POWER_CRITICAL_THROTTLE_CYCLES",
         "PerPkg": "1",
@@ -273,7 +238,6 @@
     },
     {
         "BriefDescription": "Clock-Enabled Self-Refresh",
-        "Counter": "0,1,2,3",
         "EventCode": "0x43",
         "EventName": "UNC_M_POWER_SELF_REFRESH",
         "PerPkg": "1",
@@ -282,7 +246,6 @@
     },
     {
         "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK0",
         "PerPkg": "1",
@@ -292,7 +255,6 @@
     },
     {
         "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK1",
         "PerPkg": "1",
@@ -302,7 +264,6 @@
     },
     {
         "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK2",
         "PerPkg": "1",
@@ -312,7 +273,6 @@
     },
     {
         "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK3",
         "PerPkg": "1",
@@ -322,7 +282,6 @@
     },
     {
         "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK4",
         "PerPkg": "1",
@@ -332,7 +291,6 @@
     },
     {
         "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK5",
         "PerPkg": "1",
@@ -342,7 +300,6 @@
     },
     {
         "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK6",
         "PerPkg": "1",
@@ -352,7 +309,6 @@
     },
     {
         "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK7",
         "PerPkg": "1",
@@ -362,7 +318,6 @@
     },
     {
         "BriefDescription": "Read Preemption Count; Read over Read Preempt=
ion",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_M_PREEMPTION.RD_PREEMPT_RD",
         "PerPkg": "1",
@@ -372,7 +327,6 @@
     },
     {
         "BriefDescription": "Read Preemption Count; Read over Write Preemp=
tion",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_M_PREEMPTION.RD_PREEMPT_WR",
         "PerPkg": "1",
@@ -382,7 +336,6 @@
     },
     {
         "BriefDescription": "DRAM Precharge commands.; Precharge due to ti=
mer expiration",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.PAGE_CLOSE",
         "PerPkg": "1",
@@ -392,7 +345,6 @@
     },
     {
         "BriefDescription": "DRAM Precharge commands.; Precharges due to p=
age miss",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.PAGE_MISS",
         "PerPkg": "1",
@@ -402,7 +354,6 @@
     },
     {
         "BriefDescription": "Read Pending Queue Full Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "UNC_M_RPQ_CYCLES_FULL",
         "PerPkg": "1",
@@ -411,7 +362,6 @@
     },
     {
         "BriefDescription": "Read Pending Queue Not Empty",
-        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "UNC_M_RPQ_CYCLES_NE",
         "PerPkg": "1",
@@ -420,7 +370,6 @@
     },
     {
         "BriefDescription": "Read Pending Queue Allocations",
-        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M_RPQ_INSERTS",
         "PerPkg": "1",
@@ -429,7 +378,6 @@
     },
     {
         "BriefDescription": "Read Pending Queue Occupancy",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_M_RPQ_OCCUPANCY",
         "PerPkg": "1",
@@ -438,7 +386,6 @@
     },
     {
         "BriefDescription": "Write Pending Queue Full Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_M_WPQ_CYCLES_FULL",
         "PerPkg": "1",
@@ -447,7 +394,6 @@
     },
     {
         "BriefDescription": "Write Pending Queue Not Empty",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M_WPQ_CYCLES_NE",
         "PerPkg": "1",
@@ -456,7 +402,6 @@
     },
     {
         "BriefDescription": "Write Pending Queue Allocations",
-        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_M_WPQ_INSERTS",
         "PerPkg": "1",
@@ -465,7 +410,6 @@
     },
     {
         "BriefDescription": "Write Pending Queue Occupancy",
-        "Counter": "0,1,2,3",
         "EventCode": "0x81",
         "EventName": "UNC_M_WPQ_OCCUPANCY",
         "PerPkg": "1",
@@ -474,7 +418,6 @@
     },
     {
         "BriefDescription": "Write Pending Queue CAM Match",
-        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_M_WPQ_READ_HIT",
         "PerPkg": "1",
@@ -483,7 +426,6 @@
     },
     {
         "BriefDescription": "Write Pending Queue CAM Match",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M_WPQ_WRITE_HIT",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-other.json b/to=
ols/perf/pmu-events/arch/x86/jaketown/uncore-other.json
index 588549a668bd..51a9a4e81046 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-other.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "Address Match (Conflict) Count; Conflict Merg=
es",
-        "Counter": "0,1",
         "EventCode": "0x17",
         "EventName": "UNC_I_ADDRESS_MATCH.MERGE_COUNT",
         "PerPkg": "1",
@@ -11,7 +10,6 @@
     },
     {
         "BriefDescription": "Address Match (Conflict) Count; Conflict Stal=
ls",
-        "Counter": "0,1",
         "EventCode": "0x17",
         "EventName": "UNC_I_ADDRESS_MATCH.STALL_COUNT",
         "PerPkg": "1",
@@ -21,7 +19,6 @@
     },
     {
         "BriefDescription": "Write Ack Pending Occupancy; Any Source",
-        "Counter": "0,1",
         "EventCode": "0x14",
         "EventName": "UNC_I_CACHE_ACK_PENDING_OCCUPANCY.ANY",
         "PerPkg": "1",
@@ -31,7 +28,6 @@
     },
     {
         "BriefDescription": "Write Ack Pending Occupancy; Select Source",
-        "Counter": "0,1",
         "EventCode": "0x14",
         "EventName": "UNC_I_CACHE_ACK_PENDING_OCCUPANCY.SOURCE",
         "PerPkg": "1",
@@ -41,7 +37,6 @@
     },
     {
         "BriefDescription": "Outstanding Write Ownership Occupancy; Any So=
urce",
-        "Counter": "0,1",
         "EventCode": "0x13",
         "EventName": "UNC_I_CACHE_OWN_OCCUPANCY.ANY",
         "PerPkg": "1",
@@ -51,7 +46,6 @@
     },
     {
         "BriefDescription": "Outstanding Write Ownership Occupancy; Select=
 Source",
-        "Counter": "0,1",
         "EventCode": "0x13",
         "EventName": "UNC_I_CACHE_OWN_OCCUPANCY.SOURCE",
         "PerPkg": "1",
@@ -61,7 +55,6 @@
     },
     {
         "BriefDescription": "Outstanding Read Occupancy; Any Source",
-        "Counter": "0,1",
         "EventCode": "0x10",
         "EventName": "UNC_I_CACHE_READ_OCCUPANCY.ANY",
         "PerPkg": "1",
@@ -71,7 +64,6 @@
     },
     {
         "BriefDescription": "Outstanding Read Occupancy; Select Source",
-        "Counter": "0,1",
         "EventCode": "0x10",
         "EventName": "UNC_I_CACHE_READ_OCCUPANCY.SOURCE",
         "PerPkg": "1",
@@ -81,7 +73,6 @@
     },
     {
         "BriefDescription": "Total Write Cache Occupancy; Any Source",
-        "Counter": "0,1",
         "EventCode": "0x12",
         "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.ANY",
         "PerPkg": "1",
@@ -91,7 +82,6 @@
     },
     {
         "BriefDescription": "Total Write Cache Occupancy; Select Source",
-        "Counter": "0,1",
         "EventCode": "0x12",
         "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.SOURCE",
         "PerPkg": "1",
@@ -101,7 +91,6 @@
     },
     {
         "BriefDescription": "Outstanding Write Occupancy; Any Source",
-        "Counter": "0,1",
         "EventCode": "0x11",
         "EventName": "UNC_I_CACHE_WRITE_OCCUPANCY.ANY",
         "PerPkg": "1",
@@ -111,7 +100,6 @@
     },
     {
         "BriefDescription": "Outstanding Write Occupancy; Select Source",
-        "Counter": "0,1",
         "EventCode": "0x11",
         "EventName": "UNC_I_CACHE_WRITE_OCCUPANCY.SOURCE",
         "PerPkg": "1",
@@ -121,14 +109,12 @@
     },
     {
         "BriefDescription": "Clocks in the IRP",
-        "Counter": "0,1",
         "EventName": "UNC_I_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "Number of clocks in the IRP.",
         "Unit": "IRP"
     },
     {
-        "Counter": "0,1",
         "EventCode": "0xB",
         "EventName": "UNC_I_RxR_AK_CYCLES_FULL",
         "PerPkg": "1",
@@ -137,7 +123,6 @@
     },
     {
         "BriefDescription": "AK Ingress Occupancy",
-        "Counter": "0,1",
         "EventCode": "0xA",
         "EventName": "UNC_I_RxR_AK_INSERTS",
         "PerPkg": "1",
@@ -145,7 +130,6 @@
         "Unit": "IRP"
     },
     {
-        "Counter": "0,1",
         "EventCode": "0xC",
         "EventName": "UNC_I_RxR_AK_OCCUPANCY",
         "PerPkg": "1",
@@ -153,7 +137,6 @@
         "Unit": "IRP"
     },
     {
-        "Counter": "0,1",
         "EventCode": "0x4",
         "EventName": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
         "PerPkg": "1",
@@ -162,7 +145,6 @@
     },
     {
         "BriefDescription": "BL Ingress Occupancy - DRS",
-        "Counter": "0,1",
         "EventCode": "0x1",
         "EventName": "UNC_I_RxR_BL_DRS_INSERTS",
         "PerPkg": "1",
@@ -170,7 +152,6 @@
         "Unit": "IRP"
     },
     {
-        "Counter": "0,1",
         "EventCode": "0x7",
         "EventName": "UNC_I_RxR_BL_DRS_OCCUPANCY",
         "PerPkg": "1",
@@ -178,7 +159,6 @@
         "Unit": "IRP"
     },
     {
-        "Counter": "0,1",
         "EventCode": "0x5",
         "EventName": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
         "PerPkg": "1",
@@ -187,7 +167,6 @@
     },
     {
         "BriefDescription": "BL Ingress Occupancy - NCB",
-        "Counter": "0,1",
         "EventCode": "0x2",
         "EventName": "UNC_I_RxR_BL_NCB_INSERTS",
         "PerPkg": "1",
@@ -195,7 +174,6 @@
         "Unit": "IRP"
     },
     {
-        "Counter": "0,1",
         "EventCode": "0x8",
         "EventName": "UNC_I_RxR_BL_NCB_OCCUPANCY",
         "PerPkg": "1",
@@ -203,7 +181,6 @@
         "Unit": "IRP"
     },
     {
-        "Counter": "0,1",
         "EventCode": "0x6",
         "EventName": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
         "PerPkg": "1",
@@ -212,7 +189,6 @@
     },
     {
         "BriefDescription": "BL Ingress Occupancy - NCS",
-        "Counter": "0,1",
         "EventCode": "0x3",
         "EventName": "UNC_I_RxR_BL_NCS_INSERTS",
         "PerPkg": "1",
@@ -220,7 +196,6 @@
         "Unit": "IRP"
     },
     {
-        "Counter": "0,1",
         "EventCode": "0x9",
         "EventName": "UNC_I_RxR_BL_NCS_OCCUPANCY",
         "PerPkg": "1",
@@ -229,7 +204,6 @@
     },
     {
         "BriefDescription": "Tickle Count; Ownership Lost",
-        "Counter": "0,1",
         "EventCode": "0x16",
         "EventName": "UNC_I_TICKLES.LOST_OWNERSHIP",
         "PerPkg": "1",
@@ -239,7 +213,6 @@
     },
     {
         "BriefDescription": "Tickle Count; Data Returned",
-        "Counter": "0,1",
         "EventCode": "0x16",
         "EventName": "UNC_I_TICKLES.TOP_OF_QUEUE",
         "PerPkg": "1",
@@ -249,7 +222,6 @@
     },
     {
         "BriefDescription": "Inbound Transaction Count; Read Prefetches",
-        "Counter": "0,1",
         "EventCode": "0x15",
         "EventName": "UNC_I_TRANSACTIONS.PD_PREFETCHES",
         "PerPkg": "1",
@@ -259,7 +231,6 @@
     },
     {
         "BriefDescription": "Inbound Transaction Count; Reads",
-        "Counter": "0,1",
         "EventCode": "0x15",
         "EventName": "UNC_I_TRANSACTIONS.READS",
         "PerPkg": "1",
@@ -269,7 +240,6 @@
     },
     {
         "BriefDescription": "Inbound Transaction Count; Writes",
-        "Counter": "0,1",
         "EventCode": "0x15",
         "EventName": "UNC_I_TRANSACTIONS.WRITES",
         "PerPkg": "1",
@@ -279,7 +249,6 @@
     },
     {
         "BriefDescription": "No AD Egress Credit Stalls",
-        "Counter": "0,1",
         "EventCode": "0x18",
         "EventName": "UNC_I_TxR_AD_STALL_CREDIT_CYCLES",
         "PerPkg": "1",
@@ -288,7 +257,6 @@
     },
     {
         "BriefDescription": "No BL Egress Credit Stalls",
-        "Counter": "0,1",
         "EventCode": "0x19",
         "EventName": "UNC_I_TxR_BL_STALL_CREDIT_CYCLES",
         "PerPkg": "1",
@@ -297,7 +265,6 @@
     },
     {
         "BriefDescription": "Outbound Read Requests",
-        "Counter": "0,1",
         "EventCode": "0xE",
         "EventName": "UNC_I_TxR_DATA_INSERTS_NCB",
         "PerPkg": "1",
@@ -306,7 +273,6 @@
     },
     {
         "BriefDescription": "Outbound Read Requests",
-        "Counter": "0,1",
         "EventCode": "0xF",
         "EventName": "UNC_I_TxR_DATA_INSERTS_NCS",
         "PerPkg": "1",
@@ -315,7 +281,6 @@
     },
     {
         "BriefDescription": "Outbound Request Queue Occupancy",
-        "Counter": "0,1",
         "EventCode": "0xD",
         "EventName": "UNC_I_TxR_REQUEST_OCCUPANCY",
         "PerPkg": "1",
@@ -324,7 +289,6 @@
     },
     {
         "BriefDescription": "Write Ordering Stalls",
-        "Counter": "0,1",
         "EventCode": "0x1A",
         "EventName": "UNC_I_WRITE_ORDERING_STALL_CYCLES",
         "PerPkg": "1",
@@ -333,7 +297,6 @@
     },
     {
         "BriefDescription": "Number of uclks in domain",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_R2_CLOCKTICKS",
         "PerPkg": "1",
@@ -342,7 +305,6 @@
     },
     {
         "BriefDescription": "R2PCIe IIO Credit Acquired; DRS",
-        "Counter": "0,1",
         "EventCode": "0x33",
         "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.DRS",
         "PerPkg": "1",
@@ -352,7 +314,6 @@
     },
     {
         "BriefDescription": "R2PCIe IIO Credit Acquired; NCB",
-        "Counter": "0,1",
         "EventCode": "0x33",
         "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.NCB",
         "PerPkg": "1",
@@ -362,7 +323,6 @@
     },
     {
         "BriefDescription": "R2PCIe IIO Credit Acquired; NCS",
-        "Counter": "0,1",
         "EventCode": "0x33",
         "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.NCS",
         "PerPkg": "1",
@@ -372,7 +332,6 @@
     },
     {
         "BriefDescription": "R2PCIe IIO Failed to Acquire a Credit; DRS",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_R2_IIO_CREDITS_REJECT.DRS",
         "PerPkg": "1",
@@ -382,7 +341,6 @@
     },
     {
         "BriefDescription": "R2PCIe IIO Failed to Acquire a Credit; NCB",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_R2_IIO_CREDITS_REJECT.NCB",
         "PerPkg": "1",
@@ -392,7 +350,6 @@
     },
     {
         "BriefDescription": "R2PCIe IIO Failed to Acquire a Credit; NCS",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_R2_IIO_CREDITS_REJECT.NCS",
         "PerPkg": "1",
@@ -402,7 +359,6 @@
     },
     {
         "BriefDescription": "R2PCIe IIO Credits in Use; DRS",
-        "Counter": "0,1",
         "EventCode": "0x32",
         "EventName": "UNC_R2_IIO_CREDITS_USED.DRS",
         "PerPkg": "1",
@@ -412,7 +368,6 @@
     },
     {
         "BriefDescription": "R2PCIe IIO Credits in Use; NCB",
-        "Counter": "0,1",
         "EventCode": "0x32",
         "EventName": "UNC_R2_IIO_CREDITS_USED.NCB",
         "PerPkg": "1",
@@ -422,7 +377,6 @@
     },
     {
         "BriefDescription": "R2PCIe IIO Credits in Use; NCS",
-        "Counter": "0,1",
         "EventCode": "0x32",
         "EventName": "UNC_R2_IIO_CREDITS_USED.NCS",
         "PerPkg": "1",
@@ -432,7 +386,6 @@
     },
     {
         "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Even"=
,
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_R2_RING_AD_USED.CCW_EVEN",
         "PerPkg": "1",
@@ -442,7 +395,6 @@
     },
     {
         "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_R2_RING_AD_USED.CCW_ODD",
         "PerPkg": "1",
@@ -452,7 +404,6 @@
     },
     {
         "BriefDescription": "R2 AD Ring in Use; Clockwise and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_R2_RING_AD_USED.CW_EVEN",
         "PerPkg": "1",
@@ -462,7 +413,6 @@
     },
     {
         "BriefDescription": "R2 AD Ring in Use; Clockwise and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_R2_RING_AD_USED.CW_ODD",
         "PerPkg": "1",
@@ -472,7 +422,6 @@
     },
     {
         "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Even"=
,
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_R2_RING_AK_USED.CCW_EVEN",
         "PerPkg": "1",
@@ -482,7 +431,6 @@
     },
     {
         "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_R2_RING_AK_USED.CCW_ODD",
         "PerPkg": "1",
@@ -492,7 +440,6 @@
     },
     {
         "BriefDescription": "R2 AK Ring in Use; Clockwise and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_R2_RING_AK_USED.CW_EVEN",
         "PerPkg": "1",
@@ -502,7 +449,6 @@
     },
     {
         "BriefDescription": "R2 AK Ring in Use; Clockwise and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_R2_RING_AK_USED.CW_ODD",
         "PerPkg": "1",
@@ -512,7 +458,6 @@
     },
     {
         "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Even"=
,
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_R2_RING_BL_USED.CCW_EVEN",
         "PerPkg": "1",
@@ -522,7 +467,6 @@
     },
     {
         "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_R2_RING_BL_USED.CCW_ODD",
         "PerPkg": "1",
@@ -532,7 +476,6 @@
     },
     {
         "BriefDescription": "R2 BL Ring in Use; Clockwise and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_R2_RING_BL_USED.CW_EVEN",
         "PerPkg": "1",
@@ -542,7 +485,6 @@
     },
     {
         "BriefDescription": "R2 BL Ring in Use; Clockwise and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_R2_RING_BL_USED.CW_ODD",
         "PerPkg": "1",
@@ -552,7 +494,6 @@
     },
     {
         "BriefDescription": "R2 IV Ring in Use; Any",
-        "Counter": "0,1,2,3",
         "EventCode": "0xa",
         "EventName": "UNC_R2_RING_IV_USED.ANY",
         "PerPkg": "1",
@@ -570,7 +511,6 @@
     },
     {
         "BriefDescription": "Ingress Cycles Not Empty; DRS",
-        "Counter": "0,1",
         "EventCode": "0x10",
         "EventName": "UNC_R2_RxR_CYCLES_NE.DRS",
         "PerPkg": "1",
@@ -580,7 +520,6 @@
     },
     {
         "BriefDescription": "Ingress Cycles Not Empty; NCB",
-        "Counter": "0,1",
         "EventCode": "0x10",
         "EventName": "UNC_R2_RxR_CYCLES_NE.NCB",
         "PerPkg": "1",
@@ -590,7 +529,6 @@
     },
     {
         "BriefDescription": "Ingress Cycles Not Empty; NCS",
-        "Counter": "0,1",
         "EventCode": "0x10",
         "EventName": "UNC_R2_RxR_CYCLES_NE.NCS",
         "PerPkg": "1",
@@ -654,7 +592,6 @@
     },
     {
         "BriefDescription": "Egress NACK; AD",
-        "Counter": "0,1",
         "EventCode": "0x26",
         "EventName": "UNC_R2_TxR_NACKS.AD",
         "PerPkg": "1",
@@ -664,7 +601,6 @@
     },
     {
         "BriefDescription": "Egress NACK; AK",
-        "Counter": "0,1",
         "EventCode": "0x26",
         "EventName": "UNC_R2_TxR_NACKS.AK",
         "PerPkg": "1",
@@ -674,7 +610,6 @@
     },
     {
         "BriefDescription": "Egress NACK; BL",
-        "Counter": "0,1",
         "EventCode": "0x26",
         "EventName": "UNC_R2_TxR_NACKS.BL",
         "PerPkg": "1",
@@ -684,7 +619,6 @@
     },
     {
         "BriefDescription": "Number of uclks in domain",
-        "Counter": "0,1,2",
         "EventCode": "0x1",
         "EventName": "UNC_R3_CLOCKTICKS",
         "PerPkg": "1",
@@ -693,7 +627,6 @@
     },
     {
         "BriefDescription": "to IIO BL Credit Acquired",
-        "Counter": "0,1",
         "EventCode": "0x20",
         "EventName": "UNC_R3_IIO_CREDITS_ACQUIRED.DRS",
         "PerPkg": "1",
@@ -703,7 +636,6 @@
     },
     {
         "BriefDescription": "to IIO BL Credit Acquired",
-        "Counter": "0,1",
         "EventCode": "0x20",
         "EventName": "UNC_R3_IIO_CREDITS_ACQUIRED.NCB",
         "PerPkg": "1",
@@ -713,7 +645,6 @@
     },
     {
         "BriefDescription": "to IIO BL Credit Acquired",
-        "Counter": "0,1",
         "EventCode": "0x20",
         "EventName": "UNC_R3_IIO_CREDITS_ACQUIRED.NCS",
         "PerPkg": "1",
@@ -723,7 +654,6 @@
     },
     {
         "BriefDescription": "to IIO BL Credit Rejected",
-        "Counter": "0,1",
         "EventCode": "0x21",
         "EventName": "UNC_R3_IIO_CREDITS_REJECT.DRS",
         "PerPkg": "1",
@@ -733,7 +663,6 @@
     },
     {
         "BriefDescription": "to IIO BL Credit Rejected",
-        "Counter": "0,1",
         "EventCode": "0x21",
         "EventName": "UNC_R3_IIO_CREDITS_REJECT.NCB",
         "PerPkg": "1",
@@ -743,7 +672,6 @@
     },
     {
         "BriefDescription": "to IIO BL Credit Rejected",
-        "Counter": "0,1",
         "EventCode": "0x21",
         "EventName": "UNC_R3_IIO_CREDITS_REJECT.NCS",
         "PerPkg": "1",
@@ -753,7 +681,6 @@
     },
     {
         "BriefDescription": "to IIO BL Credit In Use",
-        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_R3_IIO_CREDITS_USED.DRS",
         "PerPkg": "1",
@@ -763,7 +690,6 @@
     },
     {
         "BriefDescription": "to IIO BL Credit In Use",
-        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_R3_IIO_CREDITS_USED.NCB",
         "PerPkg": "1",
@@ -773,7 +699,6 @@
     },
     {
         "BriefDescription": "to IIO BL Credit In Use",
-        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_R3_IIO_CREDITS_USED.NCS",
         "PerPkg": "1",
@@ -783,7 +708,6 @@
     },
     {
         "BriefDescription": "R3 AD Ring in Use; Counterclockwise and Even"=
,
-        "Counter": "0,1,2",
         "EventCode": "0x7",
         "EventName": "UNC_R3_RING_AD_USED.CCW_EVEN",
         "PerPkg": "1",
@@ -793,7 +717,6 @@
     },
     {
         "BriefDescription": "R3 AD Ring in Use; Counterclockwise and Odd",
-        "Counter": "0,1,2",
         "EventCode": "0x7",
         "EventName": "UNC_R3_RING_AD_USED.CCW_ODD",
         "PerPkg": "1",
@@ -803,7 +726,6 @@
     },
     {
         "BriefDescription": "R3 AD Ring in Use; Clockwise and Even",
-        "Counter": "0,1,2",
         "EventCode": "0x7",
         "EventName": "UNC_R3_RING_AD_USED.CW_EVEN",
         "PerPkg": "1",
@@ -813,7 +735,6 @@
     },
     {
         "BriefDescription": "R3 AD Ring in Use; Clockwise and Odd",
-        "Counter": "0,1,2",
         "EventCode": "0x7",
         "EventName": "UNC_R3_RING_AD_USED.CW_ODD",
         "PerPkg": "1",
@@ -823,7 +744,6 @@
     },
     {
         "BriefDescription": "R3 AK Ring in Use; Counterclockwise and Even"=
,
-        "Counter": "0,1,2",
         "EventCode": "0x8",
         "EventName": "UNC_R3_RING_AK_USED.CCW_EVEN",
         "PerPkg": "1",
@@ -833,7 +753,6 @@
     },
     {
         "BriefDescription": "R3 AK Ring in Use; Counterclockwise and Odd",
-        "Counter": "0,1,2",
         "EventCode": "0x8",
         "EventName": "UNC_R3_RING_AK_USED.CCW_ODD",
         "PerPkg": "1",
@@ -843,7 +762,6 @@
     },
     {
         "BriefDescription": "R3 AK Ring in Use; Clockwise and Even",
-        "Counter": "0,1,2",
         "EventCode": "0x8",
         "EventName": "UNC_R3_RING_AK_USED.CW_EVEN",
         "PerPkg": "1",
@@ -853,7 +771,6 @@
     },
     {
         "BriefDescription": "R3 AK Ring in Use; Clockwise and Odd",
-        "Counter": "0,1,2",
         "EventCode": "0x8",
         "EventName": "UNC_R3_RING_AK_USED.CW_ODD",
         "PerPkg": "1",
@@ -863,7 +780,6 @@
     },
     {
         "BriefDescription": "R3 BL Ring in Use; Counterclockwise and Even"=
,
-        "Counter": "0,1,2",
         "EventCode": "0x9",
         "EventName": "UNC_R3_RING_BL_USED.CCW_EVEN",
         "PerPkg": "1",
@@ -873,7 +789,6 @@
     },
     {
         "BriefDescription": "R3 BL Ring in Use; Counterclockwise and Odd",
-        "Counter": "0,1,2",
         "EventCode": "0x9",
         "EventName": "UNC_R3_RING_BL_USED.CCW_ODD",
         "PerPkg": "1",
@@ -883,7 +798,6 @@
     },
     {
         "BriefDescription": "R3 BL Ring in Use; Clockwise and Even",
-        "Counter": "0,1,2",
         "EventCode": "0x9",
         "EventName": "UNC_R3_RING_BL_USED.CW_EVEN",
         "PerPkg": "1",
@@ -893,7 +807,6 @@
     },
     {
         "BriefDescription": "R3 BL Ring in Use; Clockwise and Odd",
-        "Counter": "0,1,2",
         "EventCode": "0x9",
         "EventName": "UNC_R3_RING_BL_USED.CW_ODD",
         "PerPkg": "1",
@@ -903,7 +816,6 @@
     },
     {
         "BriefDescription": "R3 IV Ring in Use; Any",
-        "Counter": "0,1,2",
         "EventCode": "0xa",
         "EventName": "UNC_R3_RING_IV_USED.ANY",
         "PerPkg": "1",
@@ -913,7 +825,6 @@
     },
     {
         "BriefDescription": "Ingress Bypassed",
-        "Counter": "0,1",
         "EventCode": "0x12",
         "EventName": "UNC_R3_RxR_BYPASSED.AD",
         "PerPkg": "1",
@@ -923,7 +834,6 @@
     },
     {
         "BriefDescription": "Ingress Cycles Not Empty; DRS",
-        "Counter": "0,1",
         "EventCode": "0x10",
         "EventName": "UNC_R3_RxR_CYCLES_NE.DRS",
         "PerPkg": "1",
@@ -933,7 +843,6 @@
     },
     {
         "BriefDescription": "Ingress Cycles Not Empty; HOM",
-        "Counter": "0,1",
         "EventCode": "0x10",
         "EventName": "UNC_R3_RxR_CYCLES_NE.HOM",
         "PerPkg": "1",
@@ -943,7 +852,6 @@
     },
     {
         "BriefDescription": "Ingress Cycles Not Empty; NCB",
-        "Counter": "0,1",
         "EventCode": "0x10",
         "EventName": "UNC_R3_RxR_CYCLES_NE.NCB",
         "PerPkg": "1",
@@ -953,7 +861,6 @@
     },
     {
         "BriefDescription": "Ingress Cycles Not Empty; NCS",
-        "Counter": "0,1",
         "EventCode": "0x10",
         "EventName": "UNC_R3_RxR_CYCLES_NE.NCS",
         "PerPkg": "1",
@@ -963,7 +870,6 @@
     },
     {
         "BriefDescription": "Ingress Cycles Not Empty; NDR",
-        "Counter": "0,1",
         "EventCode": "0x10",
         "EventName": "UNC_R3_RxR_CYCLES_NE.NDR",
         "PerPkg": "1",
@@ -973,7 +879,6 @@
     },
     {
         "BriefDescription": "Ingress Cycles Not Empty; SNP",
-        "Counter": "0,1",
         "EventCode": "0x10",
         "EventName": "UNC_R3_RxR_CYCLES_NE.SNP",
         "PerPkg": "1",
@@ -983,7 +888,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; DRS",
-        "Counter": "0,1",
         "EventCode": "0x11",
         "EventName": "UNC_R3_RxR_INSERTS.DRS",
         "PerPkg": "1",
@@ -993,7 +897,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; HOM",
-        "Counter": "0,1",
         "EventCode": "0x11",
         "EventName": "UNC_R3_RxR_INSERTS.HOM",
         "PerPkg": "1",
@@ -1003,7 +906,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; NCB",
-        "Counter": "0,1",
         "EventCode": "0x11",
         "EventName": "UNC_R3_RxR_INSERTS.NCB",
         "PerPkg": "1",
@@ -1013,7 +915,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; NCS",
-        "Counter": "0,1",
         "EventCode": "0x11",
         "EventName": "UNC_R3_RxR_INSERTS.NCS",
         "PerPkg": "1",
@@ -1023,7 +924,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; NDR",
-        "Counter": "0,1",
         "EventCode": "0x11",
         "EventName": "UNC_R3_RxR_INSERTS.NDR",
         "PerPkg": "1",
@@ -1033,7 +933,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; SNP",
-        "Counter": "0,1",
         "EventCode": "0x11",
         "EventName": "UNC_R3_RxR_INSERTS.SNP",
         "PerPkg": "1",
@@ -1097,7 +996,6 @@
     },
     {
         "BriefDescription": "VN0 Credit Acquisition Failed on DRS; DRS Mes=
sage Class",
-        "Counter": "0,1",
         "EventCode": "0x37",
         "EventName": "UNC_R3_VN0_CREDITS_REJECT.DRS",
         "PerPkg": "1",
@@ -1107,7 +1005,6 @@
     },
     {
         "BriefDescription": "VN0 Credit Acquisition Failed on DRS; HOM Mes=
sage Class",
-        "Counter": "0,1",
         "EventCode": "0x37",
         "EventName": "UNC_R3_VN0_CREDITS_REJECT.HOM",
         "PerPkg": "1",
@@ -1117,7 +1014,6 @@
     },
     {
         "BriefDescription": "VN0 Credit Acquisition Failed on DRS; NCB Mes=
sage Class",
-        "Counter": "0,1",
         "EventCode": "0x37",
         "EventName": "UNC_R3_VN0_CREDITS_REJECT.NCB",
         "PerPkg": "1",
@@ -1127,7 +1023,6 @@
     },
     {
         "BriefDescription": "VN0 Credit Acquisition Failed on DRS; NCS Mes=
sage Class",
-        "Counter": "0,1",
         "EventCode": "0x37",
         "EventName": "UNC_R3_VN0_CREDITS_REJECT.NCS",
         "PerPkg": "1",
@@ -1137,7 +1032,6 @@
     },
     {
         "BriefDescription": "VN0 Credit Acquisition Failed on DRS; NDR Mes=
sage Class",
-        "Counter": "0,1",
         "EventCode": "0x37",
         "EventName": "UNC_R3_VN0_CREDITS_REJECT.NDR",
         "PerPkg": "1",
@@ -1147,7 +1041,6 @@
     },
     {
         "BriefDescription": "VN0 Credit Acquisition Failed on DRS; SNP Mes=
sage Class",
-        "Counter": "0,1",
         "EventCode": "0x37",
         "EventName": "UNC_R3_VN0_CREDITS_REJECT.SNP",
         "PerPkg": "1",
@@ -1157,7 +1050,6 @@
     },
     {
         "BriefDescription": "VN0 Credit Used; DRS Message Class",
-        "Counter": "0,1",
         "EventCode": "0x36",
         "EventName": "UNC_R3_VN0_CREDITS_USED.DRS",
         "PerPkg": "1",
@@ -1167,7 +1059,6 @@
     },
     {
         "BriefDescription": "VN0 Credit Used; HOM Message Class",
-        "Counter": "0,1",
         "EventCode": "0x36",
         "EventName": "UNC_R3_VN0_CREDITS_USED.HOM",
         "PerPkg": "1",
@@ -1177,7 +1068,6 @@
     },
     {
         "BriefDescription": "VN0 Credit Used; NCB Message Class",
-        "Counter": "0,1",
         "EventCode": "0x36",
         "EventName": "UNC_R3_VN0_CREDITS_USED.NCB",
         "PerPkg": "1",
@@ -1187,7 +1077,6 @@
     },
     {
         "BriefDescription": "VN0 Credit Used; NCS Message Class",
-        "Counter": "0,1",
         "EventCode": "0x36",
         "EventName": "UNC_R3_VN0_CREDITS_USED.NCS",
         "PerPkg": "1",
@@ -1197,7 +1086,6 @@
     },
     {
         "BriefDescription": "VN0 Credit Used; NDR Message Class",
-        "Counter": "0,1",
         "EventCode": "0x36",
         "EventName": "UNC_R3_VN0_CREDITS_USED.NDR",
         "PerPkg": "1",
@@ -1207,7 +1095,6 @@
     },
     {
         "BriefDescription": "VN0 Credit Used; SNP Message Class",
-        "Counter": "0,1",
         "EventCode": "0x36",
         "EventName": "UNC_R3_VN0_CREDITS_USED.SNP",
         "PerPkg": "1",
@@ -1217,7 +1104,6 @@
     },
     {
         "BriefDescription": "VNA credit Acquisitions",
-        "Counter": "0,1",
         "EventCode": "0x33",
         "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED",
         "PerPkg": "1",
@@ -1226,7 +1112,6 @@
     },
     {
         "BriefDescription": "VNA Credit Reject; DRS Message Class",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_R3_VNA_CREDITS_REJECT.DRS",
         "PerPkg": "1",
@@ -1236,7 +1121,6 @@
     },
     {
         "BriefDescription": "VNA Credit Reject; HOM Message Class",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_R3_VNA_CREDITS_REJECT.HOM",
         "PerPkg": "1",
@@ -1246,7 +1130,6 @@
     },
     {
         "BriefDescription": "VNA Credit Reject; NCB Message Class",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_R3_VNA_CREDITS_REJECT.NCB",
         "PerPkg": "1",
@@ -1256,7 +1139,6 @@
     },
     {
         "BriefDescription": "VNA Credit Reject; NCS Message Class",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_R3_VNA_CREDITS_REJECT.NCS",
         "PerPkg": "1",
@@ -1266,7 +1148,6 @@
     },
     {
         "BriefDescription": "VNA Credit Reject; NDR Message Class",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_R3_VNA_CREDITS_REJECT.NDR",
         "PerPkg": "1",
@@ -1276,7 +1157,6 @@
     },
     {
         "BriefDescription": "VNA Credit Reject; SNP Message Class",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_R3_VNA_CREDITS_REJECT.SNP",
         "PerPkg": "1",
@@ -1286,7 +1166,6 @@
     },
     {
         "BriefDescription": "Cycles with no VNA credits available",
-        "Counter": "0,1",
         "EventCode": "0x31",
         "EventName": "UNC_R3_VNA_CREDIT_CYCLES_OUT",
         "PerPkg": "1",
@@ -1295,16 +1174,19 @@
     },
     {
         "BriefDescription": "Cycles with 1 or more VNA credits in use",
-        "Counter": "0,1",
         "EventCode": "0x32",
         "EventName": "UNC_R3_VNA_CREDIT_CYCLES_USED",
         "PerPkg": "1",
         "PublicDescription": "Number of QPI uclk cycles with one or more V=
NA credits in use.  This event can be used in conjunction with the VNA In-U=
se Accumulator to calculate the average number of used VNA credits.",
         "Unit": "R3QPI"
     },
+    {
+        "EventName": "UNC_U_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "UBOX"
+    },
     {
         "BriefDescription": "VLW Received",
-        "Counter": "0,1",
         "EventCode": "0x42",
         "EventName": "UNC_U_EVENT_MSG.DOORBELL_RCVD",
         "PerPkg": "1",
@@ -1314,7 +1196,6 @@
     },
     {
         "BriefDescription": "VLW Received",
-        "Counter": "0,1",
         "EventCode": "0x42",
         "EventName": "UNC_U_EVENT_MSG.INT_PRIO",
         "PerPkg": "1",
@@ -1324,7 +1205,6 @@
     },
     {
         "BriefDescription": "VLW Received",
-        "Counter": "0,1",
         "EventCode": "0x42",
         "EventName": "UNC_U_EVENT_MSG.IPI_RCVD",
         "PerPkg": "1",
@@ -1334,7 +1214,6 @@
     },
     {
         "BriefDescription": "VLW Received",
-        "Counter": "0,1",
         "EventCode": "0x42",
         "EventName": "UNC_U_EVENT_MSG.MSI_RCVD",
         "PerPkg": "1",
@@ -1344,7 +1223,6 @@
     },
     {
         "BriefDescription": "VLW Received",
-        "Counter": "0,1",
         "EventCode": "0x42",
         "EventName": "UNC_U_EVENT_MSG.VLW_RCVD",
         "PerPkg": "1",
@@ -1354,7 +1232,6 @@
     },
     {
         "BriefDescription": "Filter Match",
-        "Counter": "0,1",
         "EventCode": "0x41",
         "EventName": "UNC_U_FILTER_MATCH.DISABLE",
         "PerPkg": "1",
@@ -1364,7 +1241,6 @@
     },
     {
         "BriefDescription": "Filter Match",
-        "Counter": "0,1",
         "EventCode": "0x41",
         "EventName": "UNC_U_FILTER_MATCH.ENABLE",
         "PerPkg": "1",
@@ -1374,7 +1250,6 @@
     },
     {
         "BriefDescription": "Filter Match",
-        "Counter": "0,1",
         "EventCode": "0x41",
         "EventName": "UNC_U_FILTER_MATCH.U2C_DISABLE",
         "PerPkg": "1",
@@ -1384,7 +1259,6 @@
     },
     {
         "BriefDescription": "Filter Match",
-        "Counter": "0,1",
         "EventCode": "0x41",
         "EventName": "UNC_U_FILTER_MATCH.U2C_ENABLE",
         "PerPkg": "1",
@@ -1394,7 +1268,6 @@
     },
     {
         "BriefDescription": "IDI Lock/SplitLock Cycles",
-        "Counter": "0,1",
         "EventCode": "0x44",
         "EventName": "UNC_U_LOCK_CYCLES",
         "PerPkg": "1",
@@ -1403,10 +1276,8 @@
     },
     {
         "BriefDescription": "MsgCh Requests by Size; 4B Requests",
-        "Counter": "0,1",
         "EventCode": "0x47",
         "EventName": "UNC_U_MSG_CHNL_SIZE_COUNT.4B",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of transactions on the message channe=
l filtered by request size.  This includes both reads and writes.",
         "UMask": "0x1",
@@ -1414,10 +1285,8 @@
     },
     {
         "BriefDescription": "MsgCh Requests by Size; 8B Requests",
-        "Counter": "0,1",
         "EventCode": "0x47",
         "EventName": "UNC_U_MSG_CHNL_SIZE_COUNT.8B",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of transactions on the message channe=
l filtered by request size.  This includes both reads and writes.",
         "UMask": "0x2",
@@ -1425,10 +1294,8 @@
     },
     {
         "BriefDescription": "Cycles PHOLD Assert to Ack; ACK to Deassert",
-        "Counter": "0,1",
         "EventCode": "0x45",
         "EventName": "UNC_U_PHOLD_CYCLES.ACK_TO_DEASSERT",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "PHOLD cycles.  Filter from source CoreID.",
         "UMask": "0x2",
@@ -1436,10 +1303,8 @@
     },
     {
         "BriefDescription": "Cycles PHOLD Assert to Ack; Assert to ACK",
-        "Counter": "0,1",
         "EventCode": "0x45",
         "EventName": "UNC_U_PHOLD_CYCLES.ASSERT_TO_ACK",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "PHOLD cycles.  Filter from source CoreID.",
         "UMask": "0x1",
@@ -1447,17 +1312,14 @@
     },
     {
         "BriefDescription": "RACU Request",
-        "Counter": "0,1",
         "EventCode": "0x46",
         "EventName": "UNC_U_RACU_REQUESTS.COUNT",
-        "ExtSel": "1",
         "PerPkg": "1",
         "UMask": "0x1",
         "Unit": "UBOX"
     },
     {
         "BriefDescription": "Monitor Sent to T0; Correctable Machine Check=
",
-        "Counter": "0,1",
         "EventCode": "0x43",
         "EventName": "UNC_U_U2C_EVENTS.CMC",
         "PerPkg": "1",
@@ -1467,7 +1329,6 @@
     },
     {
         "BriefDescription": "Monitor Sent to T0; Livelock",
-        "Counter": "0,1",
         "EventCode": "0x43",
         "EventName": "UNC_U_U2C_EVENTS.LIVELOCK",
         "PerPkg": "1",
@@ -1477,7 +1338,6 @@
     },
     {
         "BriefDescription": "Monitor Sent to T0; LTError",
-        "Counter": "0,1",
         "EventCode": "0x43",
         "EventName": "UNC_U_U2C_EVENTS.LTERROR",
         "PerPkg": "1",
@@ -1487,7 +1347,6 @@
     },
     {
         "BriefDescription": "Monitor Sent to T0; Monitor T0",
-        "Counter": "0,1",
         "EventCode": "0x43",
         "EventName": "UNC_U_U2C_EVENTS.MONITOR_T0",
         "PerPkg": "1",
@@ -1497,7 +1356,6 @@
     },
     {
         "BriefDescription": "Monitor Sent to T0; Monitor T1",
-        "Counter": "0,1",
         "EventCode": "0x43",
         "EventName": "UNC_U_U2C_EVENTS.MONITOR_T1",
         "PerPkg": "1",
@@ -1507,7 +1365,6 @@
     },
     {
         "BriefDescription": "Monitor Sent to T0; Other",
-        "Counter": "0,1",
         "EventCode": "0x43",
         "EventName": "UNC_U_U2C_EVENTS.OTHER",
         "PerPkg": "1",
@@ -1517,7 +1374,6 @@
     },
     {
         "BriefDescription": "Monitor Sent to T0; Trap",
-        "Counter": "0,1",
         "EventCode": "0x43",
         "EventName": "UNC_U_U2C_EVENTS.TRAP",
         "PerPkg": "1",
@@ -1527,7 +1383,6 @@
     },
     {
         "BriefDescription": "Monitor Sent to T0; Uncorrectable Machine Che=
ck",
-        "Counter": "0,1",
         "EventCode": "0x43",
         "EventName": "UNC_U_U2C_EVENTS.UMC",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json b/to=
ols/perf/pmu-events/arch/x86/jaketown/uncore-power.json
index 817ea6d7f785..638aa8a35cdb 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "pclk Cycles",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_P_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "The PCU runs off a fixed 800 MHz clock.  Thi=
s event counts the number of pclk cycles measured while the counter was ena=
bled.  The pclk, like the Memory Controller's dclk, counts at a constant ra=
te making it a good measure of actual wall time.",
@@ -9,87 +8,70 @@
     },
     {
         "BriefDescription": "Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3",
         "EventName": "UNC_P_CORE0_TRANSITION_CYCLES",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_P_CORE1_TRANSITION_CYCLES",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x5",
         "EventName": "UNC_P_CORE2_TRANSITION_CYCLES",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6",
         "EventName": "UNC_P_CORE3_TRANSITION_CYCLES",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_P_CORE4_TRANSITION_CYCLES",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_P_CORE5_TRANSITION_CYCLES",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_P_CORE6_TRANSITION_CYCLES",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xa",
         "EventName": "UNC_P_CORE7_TRANSITION_CYCLES",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Core C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_P_DEMOTIONS_CORE0",
         "PerPkg": "1",
@@ -98,7 +80,6 @@
     },
     {
         "BriefDescription": "Core C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1f",
         "EventName": "UNC_P_DEMOTIONS_CORE1",
         "PerPkg": "1",
@@ -107,7 +88,6 @@
     },
     {
         "BriefDescription": "Core C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_P_DEMOTIONS_CORE2",
         "PerPkg": "1",
@@ -116,7 +96,6 @@
     },
     {
         "BriefDescription": "Core C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_P_DEMOTIONS_CORE3",
         "PerPkg": "1",
@@ -125,7 +104,6 @@
     },
     {
         "BriefDescription": "Core C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_P_DEMOTIONS_CORE4",
         "PerPkg": "1",
@@ -134,7 +112,6 @@
     },
     {
         "BriefDescription": "Core C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_P_DEMOTIONS_CORE5",
         "PerPkg": "1",
@@ -143,7 +120,6 @@
     },
     {
         "BriefDescription": "Core C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_P_DEMOTIONS_CORE6",
         "PerPkg": "1",
@@ -152,7 +128,6 @@
     },
     {
         "BriefDescription": "Core C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_P_DEMOTIONS_CORE7",
         "PerPkg": "1",
@@ -161,7 +136,6 @@
     },
     {
         "BriefDescription": "Frequency Residency",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb",
         "EventName": "UNC_P_FREQ_BAND0_CYCLES",
         "PerPkg": "1",
@@ -170,7 +144,6 @@
     },
     {
         "BriefDescription": "Frequency Residency",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc",
         "EventName": "UNC_P_FREQ_BAND1_CYCLES",
         "PerPkg": "1",
@@ -179,7 +152,6 @@
     },
     {
         "BriefDescription": "Frequency Residency",
-        "Counter": "0,1,2,3",
         "EventCode": "0xd",
         "EventName": "UNC_P_FREQ_BAND2_CYCLES",
         "PerPkg": "1",
@@ -188,7 +160,6 @@
     },
     {
         "BriefDescription": "Frequency Residency",
-        "Counter": "0,1,2,3",
         "EventCode": "0xe",
         "EventName": "UNC_P_FREQ_BAND3_CYCLES",
         "PerPkg": "1",
@@ -197,7 +168,6 @@
     },
     {
         "BriefDescription": "Current Strongest Upper Limit Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_P_FREQ_MAX_CURRENT_CYCLES",
         "PerPkg": "1",
@@ -206,7 +176,6 @@
     },
     {
         "BriefDescription": "Thermal Strongest Upper Limit Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_P_FREQ_MAX_LIMIT_THERMAL_CYCLES",
         "PerPkg": "1",
@@ -215,7 +184,6 @@
     },
     {
         "BriefDescription": "OS Strongest Upper Limit Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6",
         "EventName": "UNC_P_FREQ_MAX_OS_CYCLES",
         "PerPkg": "1",
@@ -224,7 +192,6 @@
     },
     {
         "BriefDescription": "Power Strongest Upper Limit Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x5",
         "EventName": "UNC_P_FREQ_MAX_POWER_CYCLES",
         "PerPkg": "1",
@@ -233,36 +200,29 @@
     },
     {
         "BriefDescription": "IO P Limit Strongest Lower Limit Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_P_FREQ_MIN_IO_P_CYCLES",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles when IO P Limit =
is preventing us from dropping the frequency lower.  This algorithm monitor=
s the needs to the IO subsystem on both local and remote sockets and will m=
aintain a frequency high enough to maintain good IO BW.  This is necessary =
for when all the IA cores on a socket are idle but a user still would like =
to maintain high IO Bandwidth.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Perf P Limit Strongest Lower Limit Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_P_FREQ_MIN_PERF_P_CYCLES",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles when Perf P Limi=
t is preventing us from dropping the frequency lower.  Perf P Limit is an a=
lgorithm that takes input from remote sockets when determining if a socket =
should drop it's frequency down.  This is largely to minimize increases in =
snoop and remote read latencies.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Cycles spent changing Frequency",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_P_FREQ_TRANS_CYCLES",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles when the system =
is changing frequency.  This can not be filtered by thread ID.  One can als=
o use it with the occupancy counter that monitors number of threads in C0 t=
o estimate the performance impact that frequency transitions had on the sys=
tem.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Memory Phase Shedding Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2f",
         "EventName": "UNC_P_MEMORY_PHASE_SHEDDING_CYCLES",
         "PerPkg": "1",
@@ -271,7 +231,6 @@
     },
     {
         "BriefDescription": "Number of cores in C0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
         "PerPkg": "1",
@@ -280,7 +239,6 @@
     },
     {
         "BriefDescription": "Number of cores in C0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
         "PerPkg": "1",
@@ -289,7 +247,6 @@
     },
     {
         "BriefDescription": "Number of cores in C0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
         "PerPkg": "1",
@@ -298,7 +255,6 @@
     },
     {
         "BriefDescription": "External Prochot",
-        "Counter": "0,1,2,3",
         "EventCode": "0xa",
         "EventName": "UNC_P_PROCHOT_EXTERNAL_CYCLES",
         "PerPkg": "1",
@@ -307,7 +263,6 @@
     },
     {
         "BriefDescription": "Internal Prochot",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_P_PROCHOT_INTERNAL_CYCLES",
         "PerPkg": "1",
@@ -316,17 +271,14 @@
     },
     {
         "BriefDescription": "Total Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb",
         "EventName": "UNC_P_TOTAL_TRANSITION_CYCLES",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of cycles spent performing core C sta=
te transitions across all cores.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Cycles Changing Voltage",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3",
         "EventName": "UNC_P_VOLT_TRANS_CYCLES_CHANGE",
         "PerPkg": "1",
@@ -335,7 +287,6 @@
     },
     {
         "BriefDescription": "Cycles Decreasing Voltage",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_P_VOLT_TRANS_CYCLES_DECREASE",
         "PerPkg": "1",
@@ -344,7 +295,6 @@
     },
     {
         "BriefDescription": "Cycles Increasing Voltage",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_P_VOLT_TRANS_CYCLES_INCREASE",
         "PerPkg": "1",
@@ -353,7 +303,6 @@
     },
     {
         "BriefDescription": "VR Hot",
-        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_P_VR_HOT_CYCLES",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/virtual-memory.json b/=
tools/perf/pmu-events/arch/x86/jaketown/virtual-memory.json
index 98362abba1a7..fa08d355b97e 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/virtual-memory.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Load misses in all DTLB levels that cause pag=
e walks.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.MISS_CAUSES_A_WALK",
         "SampleAfterValue": "100003",
@@ -10,8 +8,6 @@
     },
     {
         "BriefDescription": "Load operations that miss the first DTLB leve=
l but hit the second and do not cause page walks.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
         "PublicDescription": "This event counts load operations that miss =
the first DTLB level but hit the second and do not cause any page walks. Th=
e penalty in this case is approximately 7 cycles.",
@@ -20,8 +16,6 @@
     },
     {
         "BriefDescription": "Load misses at all DTLB levels that cause com=
pleted page walks.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
         "SampleAfterValue": "100003",
@@ -29,8 +23,6 @@
     },
     {
         "BriefDescription": "Cycles when PMH is busy with page walks.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_DURATION",
         "PublicDescription": "This event counts cycles when the  page miss=
 handler (PMH) is servicing page walks caused by DTLB load misses.",
@@ -39,8 +31,6 @@
     },
     {
         "BriefDescription": "Store misses in all DTLB levels that cause pa=
ge walks.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.MISS_CAUSES_A_WALK",
         "SampleAfterValue": "100003",
@@ -48,8 +38,6 @@
     },
     {
         "BriefDescription": "Store operations that miss the first TLB leve=
l but hit the second and do not cause page walks.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.STLB_HIT",
         "SampleAfterValue": "100003",
@@ -57,8 +45,6 @@
     },
     {
         "BriefDescription": "Store misses in all DTLB levels that cause co=
mpleted page walks.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
         "SampleAfterValue": "100003",
@@ -66,8 +52,6 @@
     },
     {
         "BriefDescription": "Cycles when PMH is busy with page walks.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_DURATION",
         "SampleAfterValue": "2000003",
@@ -75,8 +59,6 @@
     },
     {
         "BriefDescription": "Cycle count for an Extended Page table walk. =
 The Extended Page Directory cache is used by Virtual Machine operating sys=
tems while the guest operating systems use the standard TLB caches.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x4F",
         "EventName": "EPT.WALK_CYCLES",
         "SampleAfterValue": "2000003",
@@ -84,8 +66,6 @@
     },
     {
         "BriefDescription": "Flushing of the Instruction TLB (ITLB) pages,=
 includes 4k/2M/4M pages.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xAE",
         "EventName": "ITLB.ITLB_FLUSH",
         "SampleAfterValue": "100007",
@@ -93,8 +73,6 @@
     },
     {
         "BriefDescription": "Misses at all ITLB levels that cause page wal=
ks.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.MISS_CAUSES_A_WALK",
         "SampleAfterValue": "100003",
@@ -102,8 +80,6 @@
     },
     {
         "BriefDescription": "Operations that miss the first ITLB level but=
 hit the second and do not cause any page walks.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.STLB_HIT",
         "SampleAfterValue": "100003",
@@ -111,8 +87,6 @@
     },
     {
         "BriefDescription": "Misses in all ITLB levels that cause complete=
d page walks.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
         "SampleAfterValue": "100003",
@@ -120,8 +94,6 @@
     },
     {
         "BriefDescription": "Cycles when PMH is busy with page walks.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_DURATION",
         "PublicDescription": "This event count cycles when Page Miss Handl=
er (PMH) is servicing page walks caused by ITLB misses.",
@@ -130,8 +102,6 @@
     },
     {
         "BriefDescription": "DTLB flush attempts of the thread-specific en=
tries.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xBD",
         "EventName": "TLB_FLUSH.DTLB_THREAD",
         "SampleAfterValue": "100007",
@@ -139,8 +109,6 @@
     },
     {
         "BriefDescription": "STLB flush attempts.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xBD",
         "EventName": "TLB_FLUSH.STLB_ANY",
         "SampleAfterValue": "100007",
--=20
2.39.0.314.g84b9a713c41-goog

