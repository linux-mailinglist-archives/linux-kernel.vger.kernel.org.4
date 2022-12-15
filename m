Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9409164D6C7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 07:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiLOG6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 01:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiLOG4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:56:39 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417D637207
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:56:29 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3d0465d32deso25382987b3.20
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2rKcx8l0qFugLuTC3+RLhiJQNIujEi4+JJvj8wwF3g=;
        b=aD+3/eQT3r2nP+gzWSY8zTEzAOG1GIP5zKFCtrewrWsYvQSCVcy5ZO1d+fc7Fv1cD0
         SZSAqJJJfVeKnu1hvSptxURlkVNOLFq9SBh2SAAVgz8pIbZ4vwGrsuFFRYMqh6DaUF7d
         Q8ah42DFDtf8+plvJRK9ef0vHSW3eqUqvyjta0heSx3zucFMHiO0s+F3T8OhAgvHqYtr
         kQq2S3z97iGTX3lag9kK5MuoB6TBGbbl8GDfwKejwZiCG5b+7tad7tWFGa1HnegF736k
         hLm9wPCNG1q81yny1H6nctBfQJZzxRlAOkMIP6eOzdfP1+rqJ+XQYPQ9Xv9DTZ5u1Zx7
         bYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H2rKcx8l0qFugLuTC3+RLhiJQNIujEi4+JJvj8wwF3g=;
        b=ckWpurP49KiP93NWRhq9CWKY3BvpxepSBHdIb6JgPwsfzbfarcQ+1IwLHIn/eApGpJ
         N08qrR6T/q6/aarJFw8PpdnT9uDs5NO07YalVNJxsSSjNR+iy8Apkqell6DY3EYzpOJW
         vsAlmqxE/zfBQMVZxupUVbf0UT/Ma8eCBSSA+M1Y2PLzkPgyZqi2489L8C6QuZjdKS+w
         ba7x5ivA+5mbss9N7o5JXKsyB04LEctSJ1bjyyEJxb5ysuHU6qaeefQYdoBs8fFTMVBx
         jkC4nJdpNrCaM5N3RgcnKxE9EGtlkIFOM3m2VQvCbD7LMxgm82HjzOvMPVN0dW1J92/k
         /KhA==
X-Gm-Message-State: ANoB5pkgntKvNzrxsBUQDO9M73njqyN44lnVrldHRFhXBXITW4PDAWmQ
        +3WlCx8dyEDL4VGmHvxoC0GQa6eftvhr
X-Google-Smtp-Source: AA0mqf4xGFszyXfwGOi8cpove0h7PP5FmTzAWtfa7QBXy72rKQFIOrY33GBAqvoeyEP5tRUIajauhdWKMiBI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c7dc:d96f:4f9:f59d])
 (user=irogers job=sendgmr) by 2002:a81:3c7:0:b0:3eb:447b:56cc with SMTP id
 190-20020a8103c7000000b003eb447b56ccmr21987552ywd.296.1671087388512; Wed, 14
 Dec 2022 22:56:28 -0800 (PST)
Date:   Wed, 14 Dec 2022 22:54:54 -0800
In-Reply-To: <20221215065510.1621979-1-irogers@google.com>
Message-Id: <20221215065510.1621979-8-irogers@google.com>
Mime-Version: 1.0
References: <20221215065510.1621979-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 16/32] perf vendor events intel: Refresh ivybridge metrics
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the ivybridge metrics and events using the new tooling from:
https://github.com/intel/perfmon

The metrics are unchanged but the formulas differ due to parentheses,
use of exponents and removal of redundant operations like "* 1".  The
events are unchanged but the version number is 23 to match the perfmon
version. In the events unused json values are removed. The formatting
changes increase consistency across the json files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/ivybridge/cache.json  | 235 ----------------
 .../arch/x86/ivybridge/floating-point.json    |  34 ---
 .../arch/x86/ivybridge/frontend.json          |  60 -----
 .../arch/x86/ivybridge/ivb-metrics.json       | 119 +++++----
 .../pmu-events/arch/x86/ivybridge/memory.json |  54 ----
 .../pmu-events/arch/x86/ivybridge/other.json  |   8 -
 .../arch/x86/ivybridge/pipeline.json          | 250 ------------------
 .../arch/x86/ivybridge/uncore-cache.json      |  50 ----
 .../arch/x86/ivybridge/uncore-other.json      |  28 +-
 .../arch/x86/ivybridge/virtual-memory.json    |  36 ---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 11 files changed, 76 insertions(+), 800 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/cache.json b/tools/pe=
rf/pmu-events/arch/x86/ivybridge/cache.json
index 8adb2e45e23d..6ddc7d1c61d5 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/cache.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/cache.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "L1D data line replacements",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x51",
         "EventName": "L1D.REPLACEMENT",
         "PublicDescription": "Counts the number of lines brought into the =
L1 data cache.",
@@ -11,8 +9,6 @@
     },
     {
         "BriefDescription": "Cycles a demand request was blocked due to Fi=
ll Buffers inavailability",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL",
@@ -22,8 +18,6 @@
     },
     {
         "BriefDescription": "L1D miss oustandings duration in cycles",
-        "Counter": "2",
-        "CounterHTOff": "2",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING",
         "PublicDescription": "Increments the number of outstanding L1D mis=
ses every cycle. Set Cmask =3D 1 and Edge =3D1 to count occurrences.",
@@ -32,8 +26,6 @@
     },
     {
         "BriefDescription": "Cycles with L1D load Misses outstanding.",
-        "Counter": "2",
-        "CounterHTOff": "2",
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING_CYCLES",
@@ -43,8 +35,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles with L1D load Misses outstanding from =
any thread on physical core",
-        "Counter": "2",
-        "CounterHTOff": "2",
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING_CYCLES_ANY",
@@ -54,8 +44,6 @@
     },
     {
         "BriefDescription": "Not rejected writebacks from L1D to L2 cache =
lines in any state.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x28",
         "EventName": "L2_L1D_WB_RQSTS.ALL",
         "SampleAfterValue": "200003",
@@ -63,8 +51,6 @@
     },
     {
         "BriefDescription": "Not rejected writebacks from L1D to L2 cache =
lines in E state",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x28",
         "EventName": "L2_L1D_WB_RQSTS.HIT_E",
         "PublicDescription": "Not rejected writebacks from L1D to L2 cache=
 lines in E state.",
@@ -73,8 +59,6 @@
     },
     {
         "BriefDescription": "Not rejected writebacks from L1D to L2 cache =
lines in M state",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x28",
         "EventName": "L2_L1D_WB_RQSTS.HIT_M",
         "PublicDescription": "Not rejected writebacks from L1D to L2 cache=
 lines in M state.",
@@ -83,8 +67,6 @@
     },
     {
         "BriefDescription": "Count the number of modified Lines evicted fr=
om L1 and missed L2. (Non-rejected WBs from the DCU.)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x28",
         "EventName": "L2_L1D_WB_RQSTS.MISS",
         "PublicDescription": "Not rejected writebacks that missed LLC.",
@@ -93,8 +75,6 @@
     },
     {
         "BriefDescription": "L2 cache lines filling L2",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.ALL",
         "PublicDescription": "L2 cache lines filling L2.",
@@ -103,8 +83,6 @@
     },
     {
         "BriefDescription": "L2 cache lines in E state filling L2",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.E",
         "PublicDescription": "L2 cache lines in E state filling L2.",
@@ -113,8 +91,6 @@
     },
     {
         "BriefDescription": "L2 cache lines in I state filling L2",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.I",
         "PublicDescription": "L2 cache lines in I state filling L2.",
@@ -123,8 +99,6 @@
     },
     {
         "BriefDescription": "L2 cache lines in S state filling L2",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.S",
         "PublicDescription": "L2 cache lines in S state filling L2.",
@@ -133,8 +107,6 @@
     },
     {
         "BriefDescription": "Clean L2 cache lines evicted by demand",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.DEMAND_CLEAN",
         "PublicDescription": "Clean L2 cache lines evicted by demand.",
@@ -143,8 +115,6 @@
     },
     {
         "BriefDescription": "Dirty L2 cache lines evicted by demand",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.DEMAND_DIRTY",
         "PublicDescription": "Dirty L2 cache lines evicted by demand.",
@@ -153,8 +123,6 @@
     },
     {
         "BriefDescription": "Dirty L2 cache lines filling the L2",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.DIRTY_ALL",
         "PublicDescription": "Dirty L2 cache lines filling the L2.",
@@ -163,8 +131,6 @@
     },
     {
         "BriefDescription": "Clean L2 cache lines evicted by L2 prefetch",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.PF_CLEAN",
         "PublicDescription": "Clean L2 cache lines evicted by the MLC pref=
etcher.",
@@ -173,8 +139,6 @@
     },
     {
         "BriefDescription": "Dirty L2 cache lines evicted by L2 prefetch",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.PF_DIRTY",
         "PublicDescription": "Dirty L2 cache lines evicted by the MLC pref=
etcher.",
@@ -183,8 +147,6 @@
     },
     {
         "BriefDescription": "L2 code requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_CODE_RD",
         "PublicDescription": "Counts all L2 code requests.",
@@ -193,8 +155,6 @@
     },
     {
         "BriefDescription": "Demand Data Read requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
         "PublicDescription": "Counts any demand and L1 HW prefetch data lo=
ad requests to L2.",
@@ -203,8 +163,6 @@
     },
     {
         "BriefDescription": "Requests from L2 hardware prefetchers",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_PF",
         "PublicDescription": "Counts all L2 HW prefetcher requests.",
@@ -213,8 +171,6 @@
     },
     {
         "BriefDescription": "RFO requests to L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_RFO",
         "PublicDescription": "Counts all L2 store RFO requests.",
@@ -223,8 +179,6 @@
     },
     {
         "BriefDescription": "L2 cache hits when fetching instructions, cod=
e reads.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_HIT",
         "PublicDescription": "Number of instruction fetches that hit the L=
2 cache.",
@@ -233,8 +187,6 @@
     },
     {
         "BriefDescription": "L2 cache misses when fetching instructions",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_MISS",
         "PublicDescription": "Number of instruction fetches that missed th=
e L2 cache.",
@@ -243,8 +195,6 @@
     },
     {
         "BriefDescription": "Demand Data Read requests that hit L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
         "PublicDescription": "Demand Data Read requests that hit L2 cache.=
",
@@ -253,8 +203,6 @@
     },
     {
         "BriefDescription": "Requests from the L2 hardware prefetchers tha=
t hit L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.PF_HIT",
         "PublicDescription": "Counts all L2 HW prefetcher requests that hi=
t L2.",
@@ -263,8 +211,6 @@
     },
     {
         "BriefDescription": "Requests from the L2 hardware prefetchers tha=
t miss L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.PF_MISS",
         "PublicDescription": "Counts all L2 HW prefetcher requests that mi=
ssed L2.",
@@ -273,8 +219,6 @@
     },
     {
         "BriefDescription": "RFO requests that hit L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_HIT",
         "PublicDescription": "RFO requests that hit L2 cache.",
@@ -283,8 +227,6 @@
     },
     {
         "BriefDescription": "RFO requests that miss L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_MISS",
         "PublicDescription": "Counts the number of store RFO requests that=
 miss the L2 cache.",
@@ -293,8 +235,6 @@
     },
     {
         "BriefDescription": "RFOs that access cache lines in any state",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x27",
         "EventName": "L2_STORE_LOCK_RQSTS.ALL",
         "PublicDescription": "RFOs that access cache lines in any state.",
@@ -303,8 +243,6 @@
     },
     {
         "BriefDescription": "RFOs that hit cache lines in M state",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x27",
         "EventName": "L2_STORE_LOCK_RQSTS.HIT_M",
         "PublicDescription": "RFOs that hit cache lines in M state.",
@@ -313,8 +251,6 @@
     },
     {
         "BriefDescription": "RFOs that miss cache lines",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x27",
         "EventName": "L2_STORE_LOCK_RQSTS.MISS",
         "PublicDescription": "RFOs that miss cache lines.",
@@ -323,8 +259,6 @@
     },
     {
         "BriefDescription": "L2 or LLC HW prefetches that access L2 cache"=
,
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF0",
         "EventName": "L2_TRANS.ALL_PF",
         "PublicDescription": "Any MLC or LLC HW prefetch accessing L2, inc=
luding rejects.",
@@ -333,8 +267,6 @@
     },
     {
         "BriefDescription": "Transactions accessing L2 pipe",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF0",
         "EventName": "L2_TRANS.ALL_REQUESTS",
         "PublicDescription": "Transactions accessing L2 pipe.",
@@ -343,8 +275,6 @@
     },
     {
         "BriefDescription": "L2 cache accesses when fetching instructions"=
,
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF0",
         "EventName": "L2_TRANS.CODE_RD",
         "PublicDescription": "L2 cache accesses when fetching instructions=
.",
@@ -353,8 +283,6 @@
     },
     {
         "BriefDescription": "Demand Data Read requests that access L2 cach=
e",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF0",
         "EventName": "L2_TRANS.DEMAND_DATA_RD",
         "PublicDescription": "Demand Data Read requests that access L2 cac=
he.",
@@ -363,8 +291,6 @@
     },
     {
         "BriefDescription": "L1D writebacks that access L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF0",
         "EventName": "L2_TRANS.L1D_WB",
         "PublicDescription": "L1D writebacks that access L2 cache.",
@@ -373,8 +299,6 @@
     },
     {
         "BriefDescription": "L2 fill requests that access L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF0",
         "EventName": "L2_TRANS.L2_FILL",
         "PublicDescription": "L2 fill requests that access L2 cache.",
@@ -383,8 +307,6 @@
     },
     {
         "BriefDescription": "L2 writebacks that access L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF0",
         "EventName": "L2_TRANS.L2_WB",
         "PublicDescription": "L2 writebacks that access L2 cache.",
@@ -393,8 +315,6 @@
     },
     {
         "BriefDescription": "RFO requests that access L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF0",
         "EventName": "L2_TRANS.RFO",
         "PublicDescription": "RFO requests that access L2 cache.",
@@ -403,8 +323,6 @@
     },
     {
         "BriefDescription": "Cycles when L1D is locked",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x63",
         "EventName": "LOCK_CYCLES.CACHE_LOCK_DURATION",
         "PublicDescription": "Cycles in which the L1D is locked.",
@@ -413,8 +331,6 @@
     },
     {
         "BriefDescription": "Core-originated cacheable demand requests mis=
sed LLC",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2E",
         "EventName": "LONGEST_LAT_CACHE.MISS",
         "PublicDescription": "This event counts each cache miss condition =
for references to the last level cache.",
@@ -423,8 +339,6 @@
     },
     {
         "BriefDescription": "Core-originated cacheable demand requests tha=
t refer to LLC",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2E",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
         "PublicDescription": "This event counts requests originating from =
the core that reference a cache line in the last level cache.",
@@ -433,8 +347,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were LLC=
 and cross-core snoop hits in on-pkg core cache.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT",
         "PEBS": "1",
@@ -443,8 +355,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were Hit=
M responses from shared LLC.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM",
         "PEBS": "1",
@@ -453,8 +363,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were LLC=
 hit and cross-core snoop missed in on-pkg core cache.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS",
         "PEBS": "1",
@@ -463,8 +371,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were hit=
s in LLC without snoops required.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_NONE",
         "PEBS": "1",
@@ -473,8 +379,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources missed L=
LC but serviced from local dram.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD3",
         "EventName": "MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM",
         "PublicDescription": "Retired load uops whose data source was loca=
l memory (cross-socket snoop not needed or missed).",
@@ -483,8 +387,6 @@
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
@@ -493,8 +395,6 @@
     },
     {
         "BriefDescription": "Retired load uops with L1 cache hits as data =
sources.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_HIT",
         "PEBS": "1",
@@ -503,8 +403,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources followin=
g L1 data-cache miss.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_MISS",
         "PEBS": "1",
@@ -513,8 +411,6 @@
     },
     {
         "BriefDescription": "Retired load uops with L2 cache hits as data =
sources.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
         "PEBS": "1",
@@ -523,8 +419,6 @@
     },
     {
         "BriefDescription": "Retired load uops with L2 cache misses as dat=
a sources.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_MISS",
         "PEBS": "1",
@@ -533,8 +427,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were dat=
a hits in LLC without snoops required.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.LLC_HIT",
         "PEBS": "1",
@@ -543,8 +435,6 @@
     },
     {
         "BriefDescription": "Miss in last-level (L3) cache. Excludes Unkno=
wn data-source.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.LLC_MISS",
         "PEBS": "1",
@@ -553,8 +443,6 @@
     },
     {
         "BriefDescription": "All retired load uops. (Precise Event)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
         "PEBS": "1",
@@ -563,8 +451,6 @@
     },
     {
         "BriefDescription": "All retired store uops. (Precise Event)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
         "PEBS": "1",
@@ -573,8 +459,6 @@
     },
     {
         "BriefDescription": "Retired load uops with locked access. (Precis=
e Event)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.LOCK_LOADS",
         "PEBS": "1",
@@ -583,8 +467,6 @@
     },
     {
         "BriefDescription": "Retired load uops that split across a cacheli=
ne boundary. (Precise Event)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
         "PEBS": "1",
@@ -593,8 +475,6 @@
     },
     {
         "BriefDescription": "Retired store uops that split across a cachel=
ine boundary. (Precise Event)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
         "PEBS": "1",
@@ -603,8 +483,6 @@
     },
     {
         "BriefDescription": "Retired load uops that miss the STLB. (Precis=
e Event)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.STLB_MISS_LOADS",
         "PEBS": "1",
@@ -613,8 +491,6 @@
     },
     {
         "BriefDescription": "Retired store uops that miss the STLB. (Preci=
se Event)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.STLB_MISS_STORES",
         "PEBS": "1",
@@ -623,8 +499,6 @@
     },
     {
         "BriefDescription": "Demand and prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.ALL_DATA_RD",
         "PublicDescription": "Data read requests sent to uncore (demand an=
d prefetch).",
@@ -633,8 +507,6 @@
     },
     {
         "BriefDescription": "Cacheable and noncachaeble code read requests=
",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.DEMAND_CODE_RD",
         "PublicDescription": "Demand code read requests sent to uncore.",
@@ -643,8 +515,6 @@
     },
     {
         "BriefDescription": "Demand Data Read requests sent to uncore",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.DEMAND_DATA_RD",
         "PublicDescription": "Demand data read requests sent to uncore.",
@@ -653,8 +523,6 @@
     },
     {
         "BriefDescription": "Demand RFO requests including regular RFOs, l=
ocks, ItoM",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.DEMAND_RFO",
         "PublicDescription": "Demand RFO read requests sent to uncore, inc=
luding regular RFOs, locks, ItoM.",
@@ -663,8 +531,6 @@
     },
     {
         "BriefDescription": "Cases when offcore requests buffer cannot tak=
e more entries for core",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB2",
         "EventName": "OFFCORE_REQUESTS_BUFFER.SQ_FULL",
         "PublicDescription": "Cases when offcore requests buffer cannot ta=
ke more entries for core.",
@@ -673,8 +539,6 @@
     },
     {
         "BriefDescription": "Offcore outstanding cacheable Core Data Read =
transactions in SuperQueue (SQ), queue to uncore",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD",
         "PublicDescription": "Offcore outstanding cacheable data read tran=
sactions in SQ to uncore. Set Cmask=3D1 to count cycles.",
@@ -683,8 +547,6 @@
     },
     {
         "BriefDescription": "Cycles when offcore outstanding cacheable Cor=
e Data Read transactions are present in SuperQueue (SQ), queue to uncore",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
@@ -694,8 +556,6 @@
     },
     {
         "BriefDescription": "Offcore outstanding code reads transactions i=
n SuperQueue (SQ), queue to uncore, every cycle",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_CODE=
_RD",
@@ -705,8 +565,6 @@
     },
     {
         "BriefDescription": "Cycles when offcore outstanding Demand Data R=
ead transactions are present in SuperQueue (SQ), queue to uncore",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_DATA=
_RD",
@@ -716,8 +574,6 @@
     },
     {
         "BriefDescription": "Offcore outstanding demand rfo reads transact=
ions in SuperQueue (SQ), queue to uncore, every cycle",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO"=
,
@@ -727,8 +583,6 @@
     },
     {
         "BriefDescription": "Offcore outstanding code reads transactions i=
n SuperQueue (SQ), queue to uncore, every cycle",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_CODE_RD",
         "PublicDescription": "Offcore outstanding Demand Code Read transac=
tions in SQ to uncore. Set Cmask=3D1 to count cycles.",
@@ -737,8 +591,6 @@
     },
     {
         "BriefDescription": "Offcore outstanding Demand Data Read transact=
ions in uncore queue.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD",
         "PublicDescription": "Offcore outstanding Demand Data Read transac=
tions in SQ to uncore. Set Cmask=3D1 to count cycles.",
@@ -747,8 +599,6 @@
     },
     {
         "BriefDescription": "Cycles with at least 6 offcore outstanding De=
mand Data Read transactions in uncore queue",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "6",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD_GE_6",
@@ -758,8 +608,6 @@
     },
     {
         "BriefDescription": "Offcore outstanding RFO store transactions in=
 SuperQueue (SQ), queue to uncore",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_RFO",
         "PublicDescription": "Offcore outstanding RFO store transactions i=
n SQ to uncore. Set Cmask=3D1 to count cycles.",
@@ -768,332 +616,249 @@
     },
     {
         "BriefDescription": "Counts all demand & prefetch code reads that =
hit in the LLC",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.LLC_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3f803c0244",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand & prefetch code reads that hit =
in the LLC and sibling core snoops are not needed as either the core-valid =
bit is not set or the shared line is present in multiple cores",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.LLC_HIT.NO_SNOOP_NEEDED=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003c0244",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
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
         "BriefDescription": "Counts all demand & prefetch data reads that =
hit in the LLC",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3f803c0091",
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
         "BriefDescription": "Counts all demand & prefetch RFOs that hit in=
 the LLC",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.LLC_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3f803c0122",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand & prefetch RFOs that hit in the=
 LLC and sibling core snoops are not needed as either the core-valid bit is=
 not set or the shared line is present in multiple cores",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.LLC_HIT.NO_SNOOP_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003c0122",
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
         "BriefDescription": "Counts demand code reads that hit in the LLC =
and sibling core snoops are not needed as either the core-valid bit is not =
set or the shared line is present in multiple cores",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.LLC_HIT.NO_SNOOP_NEE=
DED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003c0004",
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
         "BriefDescription": "Counts all demand data writes (RFOs) that hit=
 in the LLC",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LLC_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3f803c0002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data writes (RFOs) that hit in =
the LLC and the snoop to one of the sibling cores hits the line in M state =
and the line is forwarded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LLC_HIT.HITM_OTHER_CORE"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003c0002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data writes (RFOs) that hit in =
the LLC and sibling core snoops are not needed as either the core-valid bit=
 is not set or the shared line is present in multiple cores",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LLC_HIT.NO_SNOOP_NEEDED"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003c0002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts miscellaneous accesses that include po=
rt i/o, MMIO and uncacheable memory accesses. It also includes L2 hints sen=
t to LLC to keep a line from being evicted out of the core caches",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.OTHER.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x18000",
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
         "BriefDescription": "Split locks in SQ",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF4",
         "EventName": "SQ_MISC.SPLIT_LOCK",
         "SampleAfterValue": "100003",
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json b=
/tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json
index 4c2ac010cf55..87c958213c7a 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Cycles with any input/output SSE or FP assist=
",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xCA",
         "EventName": "FP_ASSIST.ANY",
@@ -12,8 +10,6 @@
     },
     {
         "BriefDescription": "Number of SIMD FP assists due to input values=
",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xCA",
         "EventName": "FP_ASSIST.SIMD_INPUT",
         "PublicDescription": "Number of SIMD FP assists due to input value=
s.",
@@ -22,8 +18,6 @@
     },
     {
         "BriefDescription": "Number of SIMD FP assists due to Output value=
s",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xCA",
         "EventName": "FP_ASSIST.SIMD_OUTPUT",
         "PublicDescription": "Number of SIMD FP assists due to output valu=
es.",
@@ -32,8 +26,6 @@
     },
     {
         "BriefDescription": "Number of X87 assists due to input value.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xCA",
         "EventName": "FP_ASSIST.X87_INPUT",
         "PublicDescription": "Number of X87 FP assists due to input values=
.",
@@ -42,8 +34,6 @@
     },
     {
         "BriefDescription": "Number of X87 assists due to output value.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xCA",
         "EventName": "FP_ASSIST.X87_OUTPUT",
         "PublicDescription": "Number of X87 FP assists due to output value=
s.",
@@ -52,8 +42,6 @@
     },
     {
         "BriefDescription": "Number of SSE* or AVX-128 FP Computational pa=
cked double-precision uops issued this cycle",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x10",
         "EventName": "FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE",
         "PublicDescription": "Number of SSE* or AVX-128 FP Computational p=
acked double-precision uops issued this cycle.",
@@ -62,8 +50,6 @@
     },
     {
         "BriefDescription": "Number of SSE* or AVX-128 FP Computational pa=
cked single-precision uops issued this cycle",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x10",
         "EventName": "FP_COMP_OPS_EXE.SSE_PACKED_SINGLE",
         "PublicDescription": "Number of SSE* or AVX-128 FP Computational p=
acked single-precision uops issued this cycle.",
@@ -72,8 +58,6 @@
     },
     {
         "BriefDescription": "Number of SSE* or AVX-128 FP Computational sc=
alar double-precision uops issued this cycle",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x10",
         "EventName": "FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE",
         "PublicDescription": "Counts number of SSE* or AVX-128 double prec=
ision FP scalar uops executed.",
@@ -82,8 +66,6 @@
     },
     {
         "BriefDescription": "Number of SSE* or AVX-128 FP Computational sc=
alar single-precision uops issued this cycle",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x10",
         "EventName": "FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE",
         "PublicDescription": "Number of SSE* or AVX-128 FP Computational s=
calar single-precision uops issued this cycle.",
@@ -92,8 +74,6 @@
     },
     {
         "BriefDescription": "Number of FP Computational Uops Executed this=
 cycle. The number of FADD, FSUB, FCOM, FMULs, integer MULsand IMULs, FDIVs=
, FPREMs, FSQRTS, integer DIVs, and IDIVs. This event does not distinguish =
an FADD used in the middle of a transcendental flow from a s",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x10",
         "EventName": "FP_COMP_OPS_EXE.X87",
         "PublicDescription": "Counts number of X87 uops executed.",
@@ -102,8 +82,6 @@
     },
     {
         "BriefDescription": "Number of SIMD Move Elimination candidate uop=
s that were eliminated.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x58",
         "EventName": "MOVE_ELIMINATION.SIMD_ELIMINATED",
         "SampleAfterValue": "1000003",
@@ -111,8 +89,6 @@
     },
     {
         "BriefDescription": "Number of SIMD Move Elimination candidate uop=
s that were not eliminated.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x58",
         "EventName": "MOVE_ELIMINATION.SIMD_NOT_ELIMINATED",
         "SampleAfterValue": "1000003",
@@ -120,8 +96,6 @@
     },
     {
         "BriefDescription": "Number of GSSE memory assist for stores. GSSE=
 microcode assist is being invoked whenever the hardware is unable to prope=
rly handle GSSE-256b operations.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC1",
         "EventName": "OTHER_ASSISTS.AVX_STORE",
         "PublicDescription": "Number of assists associated with 256-bit AV=
X store operations.",
@@ -130,8 +104,6 @@
     },
     {
         "BriefDescription": "Number of transitions from AVX-256 to legacy =
SSE when penalty applicable.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC1",
         "EventName": "OTHER_ASSISTS.AVX_TO_SSE",
         "SampleAfterValue": "100003",
@@ -139,8 +111,6 @@
     },
     {
         "BriefDescription": "Number of transitions from SSE to AVX-256 whe=
n penalty applicable.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC1",
         "EventName": "OTHER_ASSISTS.SSE_TO_AVX",
         "SampleAfterValue": "100003",
@@ -148,8 +118,6 @@
     },
     {
         "BriefDescription": "number of AVX-256 Computational FP double pre=
cision uops issued this cycle",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x11",
         "EventName": "SIMD_FP_256.PACKED_DOUBLE",
         "PublicDescription": "Counts 256-bit packed double-precision float=
ing-point instructions.",
@@ -158,8 +126,6 @@
     },
     {
         "BriefDescription": "number of GSSE-256 Computational FP single pr=
ecision uops issued this cycle",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x11",
         "EventName": "SIMD_FP_256.PACKED_SINGLE",
         "PublicDescription": "Counts 256-bit packed single-precision float=
ing-point instructions.",
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/frontend.json b/tools=
/perf/pmu-events/arch/x86/ivybridge/frontend.json
index 2b1a82dd86ab..89004a6c9ed1 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/frontend.json
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
         "PublicDescription": "Number of front end re-steers due to BPU mis=
prediction.",
@@ -11,8 +9,6 @@
     },
     {
         "BriefDescription": "Decode Stream Buffer (DSB)-to-MITE switches",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xAB",
         "EventName": "DSB2MITE_SWITCHES.COUNT",
         "PublicDescription": "Number of DSB to MITE switches.",
@@ -21,8 +17,6 @@
     },
     {
         "BriefDescription": "Decode Stream Buffer (DSB)-to-MITE switch tru=
e penalty cycles",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xAB",
         "EventName": "DSB2MITE_SWITCHES.PENALTY_CYCLES",
         "PublicDescription": "Cycles DSB to MITE switches caused delay.",
@@ -31,8 +25,6 @@
     },
     {
         "BriefDescription": "Cycles when Decode Stream Buffer (DSB) fill e=
ncounter more than 3 Decode Stream Buffer (DSB) lines",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xAC",
         "EventName": "DSB_FILL.EXCEED_DSB_LINES",
         "PublicDescription": "DSB Fill encountered > 3 DSB lines.",
@@ -41,8 +33,6 @@
     },
     {
         "BriefDescription": "Number of Instruction Cache, Streaming Buffer=
 and Victim Cache Reads. both cacheable and noncacheable, including UC fetc=
hes",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x80",
         "EventName": "ICACHE.HIT",
         "PublicDescription": "Number of Instruction Cache, Streaming Buffe=
r and Victim Cache Reads. both cacheable and noncacheable, including UC fet=
ches.",
@@ -51,8 +41,6 @@
     },
     {
         "BriefDescription": "Cycles where a code-fetch stalled due to L1 i=
nstruction-cache miss or an iTLB miss",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x80",
         "EventName": "ICACHE.IFETCH_STALL",
         "PublicDescription": "Cycles where a code-fetch stalled due to L1 =
instruction-cache miss or an iTLB miss.",
@@ -61,8 +49,6 @@
     },
     {
         "BriefDescription": "Instruction cache, streaming buffer and victi=
m cache misses",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x80",
         "EventName": "ICACHE.MISSES",
         "PublicDescription": "Number of Instruction Cache, Streaming Buffe=
r and Victim Cache Misses. Includes UC accesses.",
@@ -71,8 +57,6 @@
     },
     {
         "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng 4 Uops",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_DSB_CYCLES_4_UOPS",
@@ -82,8 +66,6 @@
     },
     {
         "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng any Uop",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_DSB_CYCLES_ANY_UOPS",
@@ -93,8 +75,6 @@
     },
     {
         "BriefDescription": "Cycles MITE is delivering 4 Uops",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_MITE_CYCLES_4_UOPS",
@@ -104,8 +84,6 @@
     },
     {
         "BriefDescription": "Cycles MITE is delivering any Uop",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_MITE_CYCLES_ANY_UOPS",
@@ -115,8 +93,6 @@
     },
     {
         "BriefDescription": "Cycles when uops are being delivered to Instr=
uction Decode Queue (IDQ) from Decode Stream Buffer (DSB) path",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES",
@@ -126,8 +102,6 @@
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from the Decode Stream Buffer (DSB) path",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_UOPS",
         "PublicDescription": "Increment each cycle. # of uops delivered to=
 IDQ from DSB path. Set Cmask =3D 1 to count cycles.",
@@ -136,8 +110,6 @@
     },
     {
         "BriefDescription": "Instruction Decode Queue (IDQ) empty cycles",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.EMPTY",
         "PublicDescription": "Counts cycles the IDQ is empty.",
@@ -146,8 +118,6 @@
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from MITE path",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_ALL_UOPS",
         "PublicDescription": "Number of uops delivered to IDQ from any pat=
h.",
@@ -156,8 +126,6 @@
     },
     {
         "BriefDescription": "Cycles when uops are being delivered to Instr=
uction Decode Queue (IDQ) from MITE path",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_CYCLES",
@@ -167,8 +135,6 @@
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from MITE path",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_UOPS",
         "PublicDescription": "Increment each cycle # of uops delivered to =
IDQ from MITE path. Set Cmask =3D 1 to count cycles.",
@@ -177,8 +143,6 @@
     },
     {
         "BriefDescription": "Cycles when uops are being delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_CYCLES",
@@ -188,8 +152,6 @@
     },
     {
         "BriefDescription": "Cycles when uops initiated by Decode Stream B=
uffer (DSB) are being delivered to Instruction Decode Queue (IDQ) while Mic=
rocode Sequenser (MS) is busy",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_DSB_CYCLES",
@@ -199,8 +161,6 @@
     },
     {
         "BriefDescription": "Deliveries to Instruction Decode Queue (IDQ) =
initiated by Decode Stream Buffer (DSB) while Microcode Sequenser (MS) is b=
usy",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x79",
@@ -211,8 +171,6 @@
     },
     {
         "BriefDescription": "Uops initiated by Decode Stream Buffer (DSB) =
that are being delivered to Instruction Decode Queue (IDQ) while Microcode =
Sequenser (MS) is busy",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_DSB_UOPS",
         "PublicDescription": "Increment each cycle # of uops delivered to =
IDQ when MS_busy by DSB. Set Cmask =3D 1 to count cycles. Add Edge=3D1 to c=
ount # of delivery.",
@@ -221,8 +179,6 @@
     },
     {
         "BriefDescription": "Uops initiated by MITE and delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_MITE_UOPS",
         "PublicDescription": "Increment each cycle # of uops delivered to =
IDQ when MS_busy by MITE. Set Cmask =3D 1 to count cycles.",
@@ -231,8 +187,6 @@
     },
     {
         "BriefDescription": "Number of switches from DSB (Decode Stream Bu=
ffer) or MITE (legacy decode pipeline) to the Microcode Sequencer",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x79",
@@ -243,8 +197,6 @@
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) while Microcode Sequenser (MS) is busy",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_UOPS",
         "PublicDescription": "Increment each cycle # of uops delivered to =
IDQ from MS by either DSB or MITE. Set Cmask =3D 1 to count cycles.",
@@ -253,8 +205,6 @@
     },
     {
         "BriefDescription": "Uops not delivered to Resource Allocation Tab=
le (RAT) per thread when backend of the machine is not stalled",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0x9C",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
         "PublicDescription": "Count issue pipeline slots where no uop was =
delivered from the front end to the back end when there is no back-end stal=
l.",
@@ -263,8 +213,6 @@
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
@@ -273,8 +221,6 @@
     },
     {
         "BriefDescription": "Counts cycles FE delivered 4 uops or Resource=
 Allocation Table (RAT) was stalling FE.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x9C",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK",
@@ -284,8 +230,6 @@
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
@@ -294,8 +238,6 @@
     },
     {
         "BriefDescription": "Cycles with less than 2 uops delivered by the=
 front end.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "2",
         "EventCode": "0x9C",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_LE_2_UOP_DELIV.CORE",
@@ -304,8 +246,6 @@
     },
     {
         "BriefDescription": "Cycles with less than 3 uops delivered by the=
 front end.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x9C",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_LE_3_UOP_DELIV.CORE",
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json b/to=
ols/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
index 63db3397af0f..88980c1a3a64 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
@@ -88,7 +88,7 @@
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
@@ -96,7 +96,7 @@
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
@@ -120,7 +120,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
-        "MetricExpr": "((min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.STALL=
S_LDM_PENDING) + RESOURCE_STALLS.SB) / (min(CPU_CLK_UNHALTED.THREAD, CYCLE_=
ACTIVITY.CYCLES_NO_EXECUTE) + UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC - UOPS_EXE=
CUTED.CYCLES_GE_3_UOPS_EXEC if (IPC > 1.8) else UOPS_EXECUTED.CYCLES_GE_2_U=
OPS_EXEC - RS_EVENTS.EMPTY_CYCLES if (tma_fetch_latency > 0.1) else RESOURC=
E_STALLS.SB)) * tma_backend_bound",
+        "MetricExpr": "(min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.STALLS=
_LDM_PENDING) + RESOURCE_STALLS.SB) / (min(CPU_CLK_UNHALTED.THREAD, CYCLE_A=
CTIVITY.CYCLES_NO_EXECUTE) + UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC - UOPS_EXEC=
UTED.CYCLES_GE_3_UOPS_EXEC if IPC > 1.8 else (UOPS_EXECUTED.CYCLES_GE_2_UOP=
S_EXEC - RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else RESOURCE_ST=
ALLS.SB)) * tma_backend_bound",
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
@@ -152,7 +152,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
-        "MetricExpr": "(MEM_UOPS_RETIRED.LOCK_LOADS / MEM_UOPS_RETIRED.ALL=
_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTANDING.CYCLES=
_WITH_DEMAND_RFO) / CLKS",
+        "MetricExpr": "MEM_UOPS_RETIRED.LOCK_LOADS / MEM_UOPS_RETIRED.ALL_=
STORES * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTANDING.CYCLES_W=
ITH_DEMAND_RFO) / CLKS",
         "MetricGroup": "Offcore;TopdownL4;tma_l1_bound_group",
         "MetricName": "tma_lock_latency",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them. Sample with: MEM_UOPS_RETIRED.LOCK_LOA=
DS_PS",
@@ -192,7 +192,7 @@
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
@@ -200,7 +200,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
-        "MetricExpr": "(60 * (MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM * (1=
 + mem_load_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOA=
D_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD_=
UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS) +=
 MEM_LOAD_UOPS_RETIRED.LLC_MISS))) + 43 * (MEM_LOAD_UOPS_LLC_HIT_RETIRED.XS=
NP_MISS * (1 + mem_load_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_H=
IT + MEM_LOAD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT=
 + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.=
XSNP_MISS) + MEM_LOAD_UOPS_RETIRED.LLC_MISS)))) / CLKS",
+        "MetricExpr": "(60 * (MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM * (1=
 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD=
_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD_U=
OPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS + M=
EM_LOAD_UOPS_RETIRED.LLC_MISS))) + 43 * (MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP=
_MISS * (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT =
+ MEM_LOAD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + =
MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSN=
P_MISS + MEM_LOAD_UOPS_RETIRED.LLC_MISS)))) / CLKS",
         "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_l3_bound_g=
roup",
         "MetricName": "tma_contested_accesses",
         "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS",
@@ -208,7 +208,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
-        "MetricExpr": "43 * (MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT * (1 +=
 mem_load_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_=
UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UO=
PS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS) + M=
EM_LOAD_UOPS_RETIRED.LLC_MISS))) / CLKS",
+        "MetricExpr": "43 * (MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT * (1 +=
 MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_U=
OPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOP=
S_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS + MEM=
_LOAD_UOPS_RETIRED.LLC_MISS))) / CLKS",
         "MetricGroup": "Offcore;Snoop;TopdownL4;tma_l3_bound_group",
         "MetricName": "tma_data_sharing",
         "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_L3_HIT_RETIRED.XSNP_HIT_PS",
@@ -216,7 +216,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited)",
-        "MetricExpr": "29 * (MEM_LOAD_UOPS_RETIRED.LLC_HIT * (1 + mem_load=
_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UOPS_RETI=
RED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_LLC_HI=
T_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS) + MEM_LOAD_U=
OPS_RETIRED.LLC_MISS))) / CLKS",
+        "MetricExpr": "29 * (MEM_LOAD_UOPS_RETIRED.LLC_HIT * (1 + MEM_LOAD=
_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UOPS_RETIR=
ED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_LLC_HIT=
_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS + MEM_LOAD_UOP=
S_RETIRED.LLC_MISS))) / CLKS",
         "MetricGroup": "MemoryLat;TopdownL4;tma_l3_bound_group",
         "MetricName": "tma_l3_hit_latency",
         "PublicDescription": "This metric represents fraction of cycles wi=
th demand load accesses that hit the L3 cache under unloaded scenarios (pos=
sibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L=
3 hits) will improve the latency; reduce contention with sibling physical c=
ores and increase performance.  Note the value of this node may overlap wit=
h its siblings. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT_PS",
@@ -224,7 +224,7 @@
     },
     {
         "BriefDescription": "This metric measures fraction of cycles where=
 the Super Queue (SQ) was full taking into account all request-types and bo=
th hardware SMT threads (Logical Processors)",
-        "MetricExpr": "((OFFCORE_REQUESTS_BUFFER.SQ_FULL / 2) if #SMT_on e=
lse OFFCORE_REQUESTS_BUFFER.SQ_FULL) / CORE_CLKS",
+        "MetricExpr": "(OFFCORE_REQUESTS_BUFFER.SQ_FULL / 2 if #SMT_on els=
e OFFCORE_REQUESTS_BUFFER.SQ_FULL) / CORE_CLKS",
         "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_l3_bound_group",
         "MetricName": "tma_sq_full",
         "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). The Super Queue is used for =
requests to access the L2 cache or to go out to the Uncore.",
@@ -232,7 +232,7 @@
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
@@ -264,7 +264,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
-        "MetricExpr": "((L2_RQSTS.RFO_HIT * 9 * (1 - (MEM_UOPS_RETIRED.LOC=
K_LOADS / MEM_UOPS_RETIRED.ALL_STORES))) + (1 - (MEM_UOPS_RETIRED.LOCK_LOAD=
S / MEM_UOPS_RETIRED.ALL_STORES)) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_RE=
QUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / CLKS",
+        "MetricExpr": "(L2_RQSTS.RFO_HIT * 9 * (1 - MEM_UOPS_RETIRED.LOCK_=
LOADS / MEM_UOPS_RETIRED.ALL_STORES) + (1 - MEM_UOPS_RETIRED.LOCK_LOADS / M=
EM_UOPS_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS=
_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / CLKS",
         "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_store_bound_group"=
,
         "MetricName": "tma_store_latency",
         "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full)",
@@ -312,7 +312,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
-        "MetricExpr": "((min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLE=
S_NO_EXECUTE) + UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC - UOPS_EXECUTED.CYCLES_G=
E_3_UOPS_EXEC if (IPC > 1.8) else UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC - RS_=
EVENTS.EMPTY_CYCLES if (tma_fetch_latency > 0.1) else RESOURCE_STALLS.SB) -=
 RESOURCE_STALLS.SB - min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.STALLS_LD=
M_PENDING)) / CLKS",
+        "MetricExpr": "((min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLE=
S_NO_EXECUTE) + UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC - UOPS_EXECUTED.CYCLES_G=
E_3_UOPS_EXEC if IPC > 1.8 else (UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC - RS_E=
VENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else RESOURCE_STALLS.SB)) - R=
ESOURCE_STALLS.SB - min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.STALLS_LDM_=
PENDING)) / CLKS",
         "MetricGroup": "PortsUtil;TopdownL3;tma_core_bound_group",
         "MetricName": "tma_ports_utilization",
         "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations.",
@@ -320,7 +320,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
-        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,inv\\,cmask\\=3D1@) / 2 i=
f #SMT_on else (min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLES_NO_EXECU=
TE) - RS_EVENTS.EMPTY_CYCLES if (tma_fetch_latency > 0.1) else 0) / CORE_CL=
KS",
+        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,inv\\,cmask\\=3D1@ / 2 if=
 #SMT_on else (min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLES_NO_EXECUT=
E) - RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else 0) / CORE_CLKS)=
",
         "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
         "MetricName": "tma_ports_utilized_0",
         "PublicDescription": "This metric represents fraction of cycles CP=
U executed no uops on any execution port (Logical Processor cycles since IC=
L, Physical Core cycles otherwise). Long-latency instructions like divides =
may contribute to this metric.",
@@ -328,7 +328,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re the CPU executed total of 1 uop per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UOPS_E=
XECUTED.CORE\\,cmask\\=3D2@) / 2 if #SMT_on else (UOPS_EXECUTED.CYCLES_GE_1=
_UOP_EXEC - UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC) / CORE_CLKS",
+        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D2@) / 2 if #SMT_on else (UOPS_EXECUTED.CYCLES_GE_=
1_UOP_EXEC - UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC) / CORE_CLKS)",
         "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
         "MetricName": "tma_ports_utilized_1",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere the CPU executed total of 1 uop per cycle on all execution ports (Logic=
al Processor cycles since ICL, Physical Core cycles otherwise). This can be=
 due to heavy data-dependency among software instructions; or over oversubs=
cribing a particular hardware resource. In some other cases with high 1_Por=
t_Utilized and L1_Bound; this metric can point to L1 data-cache latency bot=
tleneck that may not necessarily manifest with complete execution starvatio=
n (due to the short L1 latency e.g. walking a linked list) - looking at the=
 assembly can be helpful.",
@@ -336,7 +336,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 2 uops per cycle on all execution ports (Logical Process=
or cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@ - cpu@UOPS_E=
XECUTED.CORE\\,cmask\\=3D3@) / 2 if #SMT_on else (UOPS_EXECUTED.CYCLES_GE_2=
_UOPS_EXEC - UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / CORE_CLKS",
+        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D3@) / 2 if #SMT_on else (UOPS_EXECUTED.CYCLES_GE_=
2_UOPS_EXEC - UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / CORE_CLKS)",
         "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
         "MetricName": "tma_ports_utilized_2",
         "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop.",
@@ -344,7 +344,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise).",
-        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ / 2) if #SM=
T_on else UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / CORE_CLKS",
+        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ / 2 if #SMT_=
on else UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC) / CORE_CLKS",
         "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
         "MetricName": "tma_ports_utilized_3m",
         "ScaleUnit": "100%"
@@ -400,7 +400,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Store operations",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_4 / CORE_CLKS",
+        "MetricExpr": "tma_port_4",
         "MetricGroup": "TopdownL5;tma_ports_utilized_3m_group",
         "MetricName": "tma_store_op_utilization",
         "ScaleUnit": "100%"
@@ -470,7 +470,7 @@
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
@@ -543,19 +543,19 @@
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
-        "MetricExpr": "UOPS_EXECUTED.THREAD / ((cpu@UOPS_EXECUTED.CORE\\,c=
mask\\=3D1@ / 2) if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (cpu@UOPS_EXECUTED.CORE\\,cm=
ask\\=3D1@ / 2 if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
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
@@ -622,7 +622,7 @@
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
@@ -634,7 +634,7 @@
     },
     {
         "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / (MEM_LOAD_UOPS_RETIRED.L1_M=
ISS + mem_load_uops_retired.hit_lfb)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / (MEM_LOAD_UOPS_RETIRED.L1_M=
ISS + MEM_LOAD_UOPS_RETIRED.HIT_LFB)",
         "MetricGroup": "Mem;MemoryBound;MemoryLat",
         "MetricName": "Load_Miss_Real_Latency"
     },
@@ -646,19 +646,19 @@
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED=
.ANY",
+        "MetricExpr": "1e3 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED.=
ANY",
         "MetricGroup": "CacheMisses;Mem",
         "MetricName": "L1MPKI"
     },
     {
         "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED=
.ANY",
+        "MetricExpr": "1e3 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.=
ANY",
         "MetricGroup": "Backend;CacheMisses;Mem",
         "MetricName": "L2MPKI"
     },
     {
         "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.LLC_MISS / INST_RETIRE=
D.ANY",
+        "MetricExpr": "1e3 * MEM_LOAD_UOPS_RETIRED.LLC_MISS / INST_RETIRED=
.ANY",
         "MetricGroup": "CacheMisses;Mem",
         "MetricName": "L3MPKI"
     },
@@ -671,19 +671,19 @@
     },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / duration_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "L1D_Cache_Fill_BW"
     },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / duration_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "L2_Cache_Fill_BW"
     },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration=
_time",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / duration_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "L3_Cache_Fill_BW"
     },
@@ -713,19 +713,19 @@
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
@@ -738,7 +738,7 @@
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
@@ -756,68 +756,87 @@
     },
     {
         "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
-        "MetricExpr": "64 * (arb@event\\=3D0x81\\,umask\\=3D0x1@ + arb@eve=
nt\\=3D0x84\\,umask\\=3D0x1@) / 1000000 / duration_time / 1000",
+        "MetricExpr": "64 * (UNC_ARB_TRK_REQUESTS.ALL + UNC_ARB_COH_TRK_RE=
QUESTS.ALL) / 1e6 / duration_time / 1e3",
         "MetricGroup": "HPC;Mem;MemoryBW;SoC",
         "MetricName": "DRAM_BW_Use"
     },
     {
         "BriefDescription": "Average latency of all requests to external m=
emory (in Uncore cycles)",
-        "MetricExpr": "UNC_ARB_TRK_OCCUPANCY.ALL / arb@event\\=3D0x81\\,um=
ask\\=3D0x1@",
+        "MetricExpr": "MEM_Parallel_Requests",
         "MetricGroup": "Mem;SoC",
         "MetricName": "MEM_Request_Latency"
     },
     {
         "BriefDescription": "Average number of parallel requests to extern=
al memory. Accounts for all requests",
-        "MetricExpr": "UNC_ARB_TRK_OCCUPANCY.ALL / arb@event\\=3D0x81\\,um=
ask\\=3D0x1@",
+        "MetricExpr": "UNC_ARB_TRK_OCCUPANCY.ALL / UNC_ARB_TRK_REQUESTS.AL=
L",
         "MetricGroup": "Mem;SoC",
         "MetricName": "MEM_Parallel_Requests"
     },
+    {
+        "BriefDescription": "Socket actual clocks when any core is active =
on that socket",
+        "MetricExpr": "UNC_CLOCK.SOCKET",
+        "MetricGroup": "SoC",
+        "MetricName": "Socket_CLKS"
+    },
     {
         "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
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
+        "MetricName": "C7_Pkg_Residency",
+        "ScaleUnit": "100%"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/memory.json b/tools/p=
erf/pmu-events/arch/x86/ivybridge/memory.json
index 30fc0af61eb3..fd1fe491c577 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/memory.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/memory.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Counts the number of machine clears due to me=
mory order conflicts.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
         "SampleAfterValue": "100003",
@@ -10,8 +8,6 @@
     },
     {
         "BriefDescription": "Loads with latency value being above 128",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "EventCode": "0xCD",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
         "MSRIndex": "0x3F6",
@@ -19,13 +15,10 @@
         "PEBS": "2",
         "PublicDescription": "Loads with latency value being above 128.",
         "SampleAfterValue": "1009",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Loads with latency value being above 16",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "EventCode": "0xCD",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
         "MSRIndex": "0x3F6",
@@ -33,13 +26,10 @@
         "PEBS": "2",
         "PublicDescription": "Loads with latency value being above 16.",
         "SampleAfterValue": "20011",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Loads with latency value being above 256",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "EventCode": "0xCD",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
         "MSRIndex": "0x3F6",
@@ -47,13 +37,10 @@
         "PEBS": "2",
         "PublicDescription": "Loads with latency value being above 256.",
         "SampleAfterValue": "503",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Loads with latency value being above 32",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "EventCode": "0xCD",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
         "MSRIndex": "0x3F6",
@@ -61,13 +48,10 @@
         "PEBS": "2",
         "PublicDescription": "Loads with latency value being above 32.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Loads with latency value being above 4",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "EventCode": "0xCD",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
         "MSRIndex": "0x3F6",
@@ -75,13 +59,10 @@
         "PEBS": "2",
         "PublicDescription": "Loads with latency value being above 4.",
         "SampleAfterValue": "100003",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Loads with latency value being above 512",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "EventCode": "0xCD",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
         "MSRIndex": "0x3F6",
@@ -89,13 +70,10 @@
         "PEBS": "2",
         "PublicDescription": "Loads with latency value being above 512.",
         "SampleAfterValue": "101",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Loads with latency value being above 64",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "EventCode": "0xCD",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
         "MSRIndex": "0x3F6",
@@ -103,13 +81,10 @@
         "PEBS": "2",
         "PublicDescription": "Loads with latency value being above 64.",
         "SampleAfterValue": "2003",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Loads with latency value being above 8",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "EventCode": "0xCD",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
         "MSRIndex": "0x3F6",
@@ -117,25 +92,18 @@
         "PEBS": "2",
         "PublicDescription": "Loads with latency value being above 8.",
         "SampleAfterValue": "50021",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Sample stores and collect precise store opera=
tion via PEBS record. PMC3 only.",
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
ched to L1 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x05",
         "EventName": "MISALIGN_MEM_REF.LOADS",
         "PublicDescription": "Speculative cache-line split load uops dispa=
tched to L1D.",
@@ -144,8 +112,6 @@
     },
     {
         "BriefDescription": "Speculative cache line split STA uops dispatc=
hed to L1 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x05",
         "EventName": "MISALIGN_MEM_REF.STORES",
         "PublicDescription": "Speculative cache-line split Store-address u=
ops dispatched to L1D.",
@@ -154,80 +120,60 @@
     },
     {
         "BriefDescription": "Counts all demand & prefetch code reads that =
miss the LLC  and the data returned from dram",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.LLC_MISS.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x300400244",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads that =
miss the LLC  and the data returned from dram",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_MISS.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x300400091",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all data/code/rfo reads (demand & pref=
etch) that miss the LLC  and the data returned from dram",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_MISS.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3004003f7",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts LLC replacements",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DATA_IN_SOCKET.LLC_MISS.LOCAL_DRAM"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x6004001b3",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand code reads that miss the LLC an=
d the data returned from dram",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.LLC_MISS.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x300400004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that miss the LLC an=
d the data returned from dram",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_MISS.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x300400001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Number of any page walk that had a miss in LL=
C.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xBE",
         "EventName": "PAGE_WALKS.LLC_MISS",
         "SampleAfterValue": "100003",
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/other.json b/tools/pe=
rf/pmu-events/arch/x86/ivybridge/other.json
index 2d62521791d8..e80e99d064ba 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/other.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/other.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Unhalted core cycles when the thread is in ri=
ng 0",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5C",
         "EventName": "CPL_CYCLES.RING0",
         "PublicDescription": "Unhalted core cycles when the thread is in r=
ing 0.",
@@ -11,8 +9,6 @@
     },
     {
         "BriefDescription": "Number of intervals between processor halts w=
hile thread is in ring 0",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x5C",
@@ -23,8 +19,6 @@
     },
     {
         "BriefDescription": "Unhalted core cycles when thread is in rings =
1, 2, or 3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5C",
         "EventName": "CPL_CYCLES.RING123",
         "PublicDescription": "Unhalted core cycles when the thread is not =
in ring 0.",
@@ -33,8 +27,6 @@
     },
     {
         "BriefDescription": "Cycles when L1 and L2 are locked due to UC or=
 split lock",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x63",
         "EventName": "LOCK_CYCLES.SPLIT_LOCK_UC_LOCK_DURATION",
         "PublicDescription": "Cycles in which the L1D and L2 are locked, d=
ue to a UC lock or split lock.",
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json b/tools=
/perf/pmu-events/arch/x86/ivybridge/pipeline.json
index d89d3f8db190..d1e64e0d683e 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Divide operations executed",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x14",
@@ -13,8 +11,6 @@
     },
     {
         "BriefDescription": "Cycles when divider is busy executing divide =
operations",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x14",
         "EventName": "ARITH.FPU_DIV_ACTIVE",
         "PublicDescription": "Cycles that the divider is active, includes =
INT and FP. Set 'edge =3D1, cmask=3D1' to count the number of divides.",
@@ -23,8 +19,6 @@
     },
     {
         "BriefDescription": "Speculative and retired  branches",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_BRANCHES",
         "PublicDescription": "Counts all near executed branches (not neces=
sarily retired).",
@@ -33,8 +27,6 @@
     },
     {
         "BriefDescription": "Speculative and retired macro-conditional bra=
nches",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_CONDITIONAL",
         "PublicDescription": "Speculative and retired macro-conditional br=
anches.",
@@ -43,8 +35,6 @@
     },
     {
         "BriefDescription": "Speculative and retired macro-unconditional b=
ranches excluding calls and indirects",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_DIRECT_JMP",
         "PublicDescription": "Speculative and retired macro-unconditional =
branches excluding calls and indirects.",
@@ -53,8 +43,6 @@
     },
     {
         "BriefDescription": "Speculative and retired direct near calls",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_DIRECT_NEAR_CALL",
         "PublicDescription": "Speculative and retired direct near calls.",
@@ -63,8 +51,6 @@
     },
     {
         "BriefDescription": "Speculative and retired indirect branches exc=
luding calls and returns",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_INDIRECT_JUMP_NON_CALL_RET",
         "PublicDescription": "Speculative and retired indirect branches ex=
cluding calls and returns.",
@@ -73,8 +59,6 @@
     },
     {
         "BriefDescription": "Speculative and retired indirect return branc=
hes.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_INDIRECT_NEAR_RETURN",
         "SampleAfterValue": "200003",
@@ -82,8 +66,6 @@
     },
     {
         "BriefDescription": "Not taken macro-conditional branches",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.NONTAKEN_CONDITIONAL",
         "PublicDescription": "Not taken macro-conditional branches.",
@@ -92,8 +74,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired macro-condition=
al branches",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_CONDITIONAL",
         "PublicDescription": "Taken speculative and retired macro-conditio=
nal branches.",
@@ -102,8 +82,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired macro-condition=
al branch instructions excluding calls and indirects",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_DIRECT_JUMP",
         "PublicDescription": "Taken speculative and retired macro-conditio=
nal branch instructions excluding calls and indirects.",
@@ -112,8 +90,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired direct near cal=
ls",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_DIRECT_NEAR_CALL",
         "PublicDescription": "Taken speculative and retired direct near ca=
lls.",
@@ -122,8 +98,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired indirect branch=
es excluding calls and returns",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_INDIRECT_JUMP_NON_CALL_RET",
         "PublicDescription": "Taken speculative and retired indirect branc=
hes excluding calls and returns.",
@@ -132,8 +106,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired indirect calls"=
,
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_INDIRECT_NEAR_CALL",
         "PublicDescription": "Taken speculative and retired indirect calls=
.",
@@ -142,8 +114,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired indirect branch=
es with return mnemonic",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_INDIRECT_NEAR_RETURN",
         "PublicDescription": "Taken speculative and retired indirect branc=
hes with return mnemonic.",
@@ -152,8 +122,6 @@
     },
     {
         "BriefDescription": "All (macro) branch instructions retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PublicDescription": "Branch instructions at retirement.",
@@ -161,8 +129,6 @@
     },
     {
         "BriefDescription": "All (macro) branch instructions retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES_PEBS",
         "PEBS": "2",
@@ -171,8 +137,6 @@
     },
     {
         "BriefDescription": "Conditional branch instructions retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.CONDITIONAL",
         "PEBS": "1",
@@ -181,8 +145,6 @@
     },
     {
         "BriefDescription": "Far branch instructions retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
         "PublicDescription": "Number of far branches retired.",
@@ -191,8 +153,6 @@
     },
     {
         "BriefDescription": "Direct and indirect near call instructions re=
tired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
         "PEBS": "1",
@@ -201,8 +161,6 @@
     },
     {
         "BriefDescription": "Direct and indirect macro near call instructi=
ons retired (captured in ring 3).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL_R3",
         "PEBS": "1",
@@ -211,8 +169,6 @@
     },
     {
         "BriefDescription": "Return instructions retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
         "PEBS": "1",
@@ -221,8 +177,6 @@
     },
     {
         "BriefDescription": "Taken branch instructions retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
         "PEBS": "1",
@@ -231,8 +185,6 @@
     },
     {
         "BriefDescription": "Not taken branch instructions retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NOT_TAKEN",
         "PublicDescription": "Counts the number of not taken branch instru=
ctions retired.",
@@ -241,8 +193,6 @@
     },
     {
         "BriefDescription": "Speculative and retired mispredicted macro co=
nditional branches",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.ALL_BRANCHES",
         "PublicDescription": "Counts all near executed branches (not neces=
sarily retired).",
@@ -251,8 +201,6 @@
     },
     {
         "BriefDescription": "Speculative and retired mispredicted macro co=
nditional branches",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.ALL_CONDITIONAL",
         "PublicDescription": "Speculative and retired mispredicted macro c=
onditional branches.",
@@ -261,8 +209,6 @@
     },
     {
         "BriefDescription": "Mispredicted indirect branches excluding call=
s and returns",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.ALL_INDIRECT_JUMP_NON_CALL_RET",
         "PublicDescription": "Mispredicted indirect branches excluding cal=
ls and returns.",
@@ -271,8 +217,6 @@
     },
     {
         "BriefDescription": "Not taken speculative and retired mispredicte=
d macro conditional branches",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.NONTAKEN_CONDITIONAL",
         "PublicDescription": "Not taken speculative and retired mispredict=
ed macro conditional branches.",
@@ -281,8 +225,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired mispredicted ma=
cro conditional branches",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.TAKEN_CONDITIONAL",
         "PublicDescription": "Taken speculative and retired mispredicted m=
acro conditional branches.",
@@ -291,8 +233,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired mispredicted in=
direct branches excluding calls and returns",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.TAKEN_INDIRECT_JUMP_NON_CALL_RET",
         "PublicDescription": "Taken speculative and retired mispredicted i=
ndirect branches excluding calls and returns.",
@@ -301,8 +241,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired mispredicted in=
direct calls",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.TAKEN_INDIRECT_NEAR_CALL",
         "PublicDescription": "Taken speculative and retired mispredicted i=
ndirect calls.",
@@ -311,8 +249,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired mispredicted in=
direct branches with return mnemonic",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.TAKEN_RETURN_NEAR",
         "PublicDescription": "Taken speculative and retired mispredicted i=
ndirect branches with return mnemonic.",
@@ -321,8 +257,6 @@
     },
     {
         "BriefDescription": "All mispredicted macro branch instructions re=
tired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PublicDescription": "Mispredicted branch instructions at retireme=
nt.",
@@ -330,8 +264,6 @@
     },
     {
         "BriefDescription": "Mispredicted macro branch instructions retire=
d.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES_PEBS",
         "PEBS": "2",
@@ -340,8 +272,6 @@
     },
     {
         "BriefDescription": "Mispredicted conditional branch instructions =
retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.CONDITIONAL",
         "PEBS": "1",
@@ -350,8 +280,6 @@
     },
     {
         "BriefDescription": "number of near branch instructions retired th=
at were mispredicted and taken.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
         "PEBS": "1",
@@ -360,8 +288,6 @@
     },
     {
         "BriefDescription": "Count XClk pulses when this thread is unhalte=
d and the other is halted.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE",
         "SampleAfterValue": "2000003",
@@ -369,8 +295,6 @@
     },
     {
         "BriefDescription": "Reference cycles when the thread is unhalted =
(counts at 100 MHz rate)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_THREAD_UNHALTED.REF_XCLK",
         "PublicDescription": "Increments at the frequency of XCLK (100 MHz=
) when not halted.",
@@ -380,8 +304,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Reference cycles when the at least one thread=
 on the physical core is unhalted. (counts at 100 MHz rate)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY",
         "SampleAfterValue": "2000003",
@@ -389,8 +311,6 @@
     },
     {
         "BriefDescription": "Count XClk pulses when this thread is unhalte=
d and the other thread is halted.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
         "SampleAfterValue": "2000003",
@@ -398,16 +318,12 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
-        "Counter": "Fixed counter 2",
-        "CounterHTOff": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "SampleAfterValue": "2000003",
         "UMask": "0x3"
     },
     {
         "BriefDescription": "Reference cycles when the thread is unhalted =
(counts at 100 MHz rate)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.REF_XCLK",
         "PublicDescription": "Reference cycles when the thread is unhalted=
. (counts at 100 MHz rate)",
@@ -417,8 +333,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Reference cycles when the at least one thread=
 on the physical core is unhalted. (counts at 100 MHz rate)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.REF_XCLK_ANY",
         "SampleAfterValue": "2000003",
@@ -426,8 +340,6 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt st=
ate.",
-        "Counter": "Fixed counter 1",
-        "CounterHTOff": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
@@ -435,8 +347,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core cycles when at least one thread on the p=
hysical core is not in halt state",
-        "Counter": "Fixed counter 1",
-        "CounterHTOff": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
         "PublicDescription": "Core cycles when at least one thread on the =
physical core is not in halt state.",
         "SampleAfterValue": "2000003",
@@ -444,8 +354,6 @@
     },
     {
         "BriefDescription": "Thread cycles when thread is not in halt stat=
e",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
         "PublicDescription": "Counts the number of thread cycles while the=
 thread is not in a halt state. The thread enters the halt state when it is=
 running the HLT instruction. The core frequency may change from time to ti=
me due to power or thermal throttling.",
@@ -454,8 +362,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core cycles when at least one thread on the p=
hysical core is not in halt state",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P_ANY",
         "PublicDescription": "Core cycles when at least one thread on the =
physical core is not in halt state.",
@@ -463,8 +369,6 @@
     },
     {
         "BriefDescription": "Cycles while L1 cache miss demand load is out=
standing.",
-        "Counter": "2",
-        "CounterHTOff": "2",
         "CounterMask": "8",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_MISS",
@@ -473,8 +377,6 @@
     },
     {
         "BriefDescription": "Cycles with pending L1 cache miss loads.",
-        "Counter": "2",
-        "CounterHTOff": "2",
         "CounterMask": "8",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_PENDING",
@@ -484,8 +386,6 @@
     },
     {
         "BriefDescription": "Cycles while L2 cache miss load* is outstandi=
ng.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L2_MISS",
@@ -494,8 +394,6 @@
     },
     {
         "BriefDescription": "Cycles with pending L2 cache miss loads.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L2_PENDING",
@@ -505,8 +403,6 @@
     },
     {
         "BriefDescription": "Cycles with pending memory loads.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "2",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_LDM_PENDING",
@@ -516,8 +412,6 @@
     },
     {
         "BriefDescription": "Cycles while memory subsystem has an outstand=
ing load.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "2",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_MEM_ANY",
@@ -526,8 +420,6 @@
     },
     {
         "BriefDescription": "This event increments by 1 for every cycle wh=
ere there was no execute for this thread.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "4",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_NO_EXECUTE",
@@ -537,8 +429,6 @@
     },
     {
         "BriefDescription": "Execution stalls while L1 cache miss demand l=
oad is outstanding.",
-        "Counter": "2",
-        "CounterHTOff": "2",
         "CounterMask": "12",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L1D_MISS",
@@ -547,8 +437,6 @@
     },
     {
         "BriefDescription": "Execution stalls due to L1 data cache misses"=
,
-        "Counter": "2",
-        "CounterHTOff": "2",
         "CounterMask": "12",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L1D_PENDING",
@@ -558,8 +446,6 @@
     },
     {
         "BriefDescription": "Execution stalls while L2 cache miss load* is=
 outstanding.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "5",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L2_MISS",
@@ -568,8 +454,6 @@
     },
     {
         "BriefDescription": "Execution stalls due to L2 cache misses.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "5",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L2_PENDING",
@@ -579,8 +463,6 @@
     },
     {
         "BriefDescription": "Execution stalls due to memory subsystem.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "6",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.STALLS_LDM_PENDING",
@@ -589,8 +471,6 @@
     },
     {
         "BriefDescription": "Execution stalls while memory subsystem has a=
n outstanding load.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "6",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.STALLS_MEM_ANY",
@@ -599,8 +479,6 @@
     },
     {
         "BriefDescription": "Total execution stalls.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "4",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.STALLS_TOTAL",
@@ -609,8 +487,6 @@
     },
     {
         "BriefDescription": "Stall cycles because IQ is full",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x87",
         "EventName": "ILD_STALL.IQ_FULL",
         "PublicDescription": "Stall cycles due to IQ is full.",
@@ -619,8 +495,6 @@
     },
     {
         "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x87",
         "EventName": "ILD_STALL.LCP",
         "SampleAfterValue": "2000003",
@@ -628,16 +502,12 @@
     },
     {
         "BriefDescription": "Instructions retired from execution.",
-        "Counter": "Fixed counter 0",
-        "CounterHTOff": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Number of instructions retired. General Count=
er   - architectural event",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.ANY_P",
         "PublicDescription": "Number of instructions at retirement.",
@@ -645,8 +515,6 @@
     },
     {
         "BriefDescription": "Precise instruction retired event with HW to =
reduce effect of PEBS shadow in IP distribution",
-        "Counter": "1",
-        "CounterHTOff": "1",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.PREC_DIST",
         "PEBS": "2",
@@ -656,8 +524,6 @@
     },
     {
         "BriefDescription": "Number of cycles waiting for the checkpoints =
in Resource Allocation Table (RAT) to be recovered after Nuke due to all ot=
her cases except JEClear (e.g. whenever a ucode assist is needed like SSE e=
xception, memory disambiguation, etc.)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x0D",
         "EventName": "INT_MISC.RECOVERY_CYCLES",
@@ -667,8 +533,6 @@
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
@@ -677,8 +541,6 @@
     },
     {
         "BriefDescription": "Number of occurrences waiting for the checkpo=
ints in Resource Allocation Table (RAT) to be recovered after Nuke due to a=
ll other cases except JEClear (e.g. whenever a ucode assist is needed like =
SSE exception, memory disambiguation, etc.)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x0D",
@@ -688,8 +550,6 @@
     },
     {
         "BriefDescription": "This event counts the number of times that sp=
lit load operations are temporarily blocked because all resources for handl=
ing the split accesses are in use.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.NO_SR",
         "PublicDescription": "The number of times that split load operatio=
ns are temporarily blocked because all resources for handling the split acc=
esses are in use.",
@@ -698,8 +558,6 @@
     },
     {
         "BriefDescription": "Cases when loads get true Block-on-Store bloc=
king code preventing store forwarding",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
         "PublicDescription": "Loads blocked by overlapping with store buff=
er that cannot be forwarded.",
@@ -708,8 +566,6 @@
     },
     {
         "BriefDescription": "False dependencies in MOB due to partial comp=
are on address",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x07",
         "EventName": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS",
         "PublicDescription": "False dependencies in MOB due to partial com=
pare on address.",
@@ -718,8 +574,6 @@
     },
     {
         "BriefDescription": "Not software-prefetch load dispatches that hi=
t FB allocated for hardware prefetch",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x4C",
         "EventName": "LOAD_HIT_PRE.HW_PF",
         "PublicDescription": "Non-SW-prefetch load dispatches that hit fil=
l buffer allocated for H/W prefetch.",
@@ -728,8 +582,6 @@
     },
     {
         "BriefDescription": "Not software-prefetch load dispatches that hi=
t FB allocated for software prefetch",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x4C",
         "EventName": "LOAD_HIT_PRE.SW_PF",
         "PublicDescription": "Non-SW-prefetch load dispatches that hit fil=
l buffer allocated for S/W prefetch.",
@@ -738,8 +590,6 @@
     },
     {
         "BriefDescription": "Cycles 4 Uops delivered by the LSD, but didn'=
t come from the decoder",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0xA8",
         "EventName": "LSD.CYCLES_4_UOPS",
@@ -749,8 +599,6 @@
     },
     {
         "BriefDescription": "Cycles Uops delivered by the LSD, but didn't =
come from the decoder",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xA8",
         "EventName": "LSD.CYCLES_ACTIVE",
@@ -760,8 +608,6 @@
     },
     {
         "BriefDescription": "Number of Uops delivered by the LSD.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA8",
         "EventName": "LSD.UOPS",
         "SampleAfterValue": "2000003",
@@ -769,8 +615,6 @@
     },
     {
         "BriefDescription": "Number of machine clears (nukes) of any type.=
",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0xC3",
@@ -780,8 +624,6 @@
     },
     {
         "BriefDescription": "This event counts the number of executed Inte=
l AVX masked load operations that refer to an illegal address range with th=
e mask bits set to 0.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MASKMOV",
         "PublicDescription": "Counts the number of executed AVX masked loa=
d operations that refer to an illegal address range with the mask bits set =
to 0.",
@@ -790,8 +632,6 @@
     },
     {
         "BriefDescription": "Self-modifying code (SMC) detected.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.SMC",
         "PublicDescription": "Number of self-modifying-code machine clears=
 detected.",
@@ -800,8 +640,6 @@
     },
     {
         "BriefDescription": "Number of integer Move Elimination candidate =
uops that were eliminated.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x58",
         "EventName": "MOVE_ELIMINATION.INT_ELIMINATED",
         "SampleAfterValue": "1000003",
@@ -809,8 +647,6 @@
     },
     {
         "BriefDescription": "Number of integer Move Elimination candidate =
uops that were not eliminated.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x58",
         "EventName": "MOVE_ELIMINATION.INT_NOT_ELIMINATED",
         "SampleAfterValue": "1000003",
@@ -818,8 +654,6 @@
     },
     {
         "BriefDescription": "Number of times any microcode assist is invok=
ed by HW upon uop writeback.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC1",
         "EventName": "OTHER_ASSISTS.ANY_WB_ASSIST",
         "SampleAfterValue": "100003",
@@ -827,8 +661,6 @@
     },
     {
         "BriefDescription": "Resource-related stall cycles",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.ANY",
         "PublicDescription": "Cycles Allocation is stalled due to Resource=
 Related reason.",
@@ -837,8 +669,6 @@
     },
     {
         "BriefDescription": "Cycles stalled due to re-order buffer full.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.ROB",
         "SampleAfterValue": "2000003",
@@ -846,8 +676,6 @@
     },
     {
         "BriefDescription": "Cycles stalled due to no eligible RS entry av=
ailable.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.RS",
         "SampleAfterValue": "2000003",
@@ -855,8 +683,6 @@
     },
     {
         "BriefDescription": "Cycles stalled due to no store buffers availa=
ble. (not including draining form sync).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.SB",
         "PublicDescription": "Cycles stalled due to no store buffers avail=
able (not including draining form sync).",
@@ -865,8 +691,6 @@
     },
     {
         "BriefDescription": "Count cases of saving new LBR",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xCC",
         "EventName": "ROB_MISC_EVENTS.LBR_INSERTS",
         "PublicDescription": "Count cases of saving new LBR records by har=
dware.",
@@ -875,8 +699,6 @@
     },
     {
         "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 for the thread",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5E",
         "EventName": "RS_EVENTS.EMPTY_CYCLES",
         "PublicDescription": "Cycles the RS is empty for the thread.",
@@ -885,8 +707,6 @@
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
@@ -897,8 +717,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are dispatched to=
 port 0",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_0",
         "PublicDescription": "Cycles which a Uop is dispatched on port 0."=
,
@@ -908,8 +726,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are dispatched to p=
ort 0",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_0_CORE",
         "PublicDescription": "Cycles per core when uops are dispatched to =
port 0.",
@@ -918,8 +734,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are dispatched to=
 port 1",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_1",
         "PublicDescription": "Cycles which a Uop is dispatched on port 1."=
,
@@ -929,8 +743,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are dispatched to p=
ort 1",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_1_CORE",
         "PublicDescription": "Cycles per core when uops are dispatched to =
port 1.",
@@ -939,8 +751,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when load or STA uops are d=
ispatched to port 2",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_2",
         "PublicDescription": "Cycles which a Uop is dispatched on port 2."=
,
@@ -950,8 +760,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Uops dispatched to port 2, loads and stores p=
er core (speculative and retired).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_2_CORE",
         "SampleAfterValue": "2000003",
@@ -959,8 +767,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when load or STA uops are d=
ispatched to port 3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_3",
         "PublicDescription": "Cycles which a Uop is dispatched on port 3."=
,
@@ -970,8 +776,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when load or STA uops are dis=
patched to port 3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_3_CORE",
         "PublicDescription": "Cycles per core when load or STA uops are di=
spatched to port 3.",
@@ -980,8 +784,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are dispatched to=
 port 4",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_4",
         "PublicDescription": "Cycles which a Uop is dispatched on port 4."=
,
@@ -991,8 +793,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are dispatched to p=
ort 4",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_4_CORE",
         "PublicDescription": "Cycles per core when uops are dispatched to =
port 4.",
@@ -1001,8 +801,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are dispatched to=
 port 5",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_5",
         "PublicDescription": "Cycles which a Uop is dispatched on port 5."=
,
@@ -1012,8 +810,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are dispatched to p=
ort 5",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_5_CORE",
         "PublicDescription": "Cycles per core when uops are dispatched to =
port 5.",
@@ -1022,8 +818,6 @@
     },
     {
         "BriefDescription": "Number of uops executed on the core.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE",
         "PublicDescription": "Counts total number of uops to be executed p=
er-core each cycle.",
@@ -1032,8 +826,6 @@
     },
     {
         "BriefDescription": "Cycles at least 1 micro-op is executed from a=
ny thread on physical core",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_1",
@@ -1043,8 +835,6 @@
     },
     {
         "BriefDescription": "Cycles at least 2 micro-op is executed from a=
ny thread on physical core",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "2",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_2",
@@ -1054,8 +844,6 @@
     },
     {
         "BriefDescription": "Cycles at least 3 micro-op is executed from a=
ny thread on physical core",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "3",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_3",
@@ -1065,8 +853,6 @@
     },
     {
         "BriefDescription": "Cycles at least 4 micro-op is executed from a=
ny thread on physical core",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_4",
@@ -1076,8 +862,6 @@
     },
     {
         "BriefDescription": "Cycles with no micro-ops executed from any th=
read on physical core",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_NONE",
         "Invert": "1",
@@ -1087,8 +871,6 @@
     },
     {
         "BriefDescription": "Cycles where at least 1 uop was executed per-=
thread",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC",
@@ -1098,8 +880,6 @@
     },
     {
         "BriefDescription": "Cycles where at least 2 uops were executed pe=
r-thread",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "2",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC",
@@ -1109,8 +889,6 @@
     },
     {
         "BriefDescription": "Cycles where at least 3 uops were executed pe=
r-thread",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "3",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC",
@@ -1120,8 +898,6 @@
     },
     {
         "BriefDescription": "Cycles where at least 4 uops were executed pe=
r-thread",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_4_UOPS_EXEC",
@@ -1131,8 +907,6 @@
     },
     {
         "BriefDescription": "Counts number of cycles no uops were dispatch=
ed to be executed on this thread.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.STALL_CYCLES",
@@ -1142,8 +916,6 @@
     },
     {
         "BriefDescription": "Counts the number of uops to be executed per-=
thread each cycle.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.THREAD",
         "PublicDescription": "Counts total number of uops to be executed p=
er-thread each cycle. Set Cmask =3D 1, INV =3D1 to count stall cycles.",
@@ -1152,8 +924,6 @@
     },
     {
         "BriefDescription": "Uops that Resource Allocation Table (RAT) iss=
ues to Reservation Station (RS)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.ANY",
         "PublicDescription": "Increments each cycle the # of Uops issued b=
y the RAT to RS. Set Cmask =3D 1, Inv =3D 1, Any=3D 1to count stalled cycle=
s of this core.",
@@ -1163,8 +933,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles when Resource Allocation Table (RAT) d=
oes not issue Uops to Reservation Station (RS) for all threads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.CORE_STALL_CYCLES",
@@ -1175,8 +943,6 @@
     },
     {
         "BriefDescription": "Number of flags-merge uops being allocated.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.FLAGS_MERGE",
         "PublicDescription": "Number of flags-merge uops allocated. Such u=
ops adds delay.",
@@ -1185,8 +951,6 @@
     },
     {
         "BriefDescription": "Number of Multiply packed/scalar single preci=
sion uops allocated",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.SINGLE_MUL",
         "PublicDescription": "Number of multiply packed/scalar single prec=
ision uops allocated.",
@@ -1195,8 +959,6 @@
     },
     {
         "BriefDescription": "Number of slow LEA uops being allocated. A uo=
p is generally considered SlowLea if it has 3 sources (e.g. 2 sources + imm=
ediate) regardless if as a result of LEA instruction or not.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.SLOW_LEA",
         "PublicDescription": "Number of slow LEA or similar uops allocated=
. Such uop has 3 sources (e.g. 2 sources + immediate) regardless if as a re=
sult of LEA instruction or not.",
@@ -1205,8 +967,6 @@
     },
     {
         "BriefDescription": "Cycles when Resource Allocation Table (RAT) d=
oes not issue Uops to Reservation Station (RS) for the thread",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.STALL_CYCLES",
@@ -1217,8 +977,6 @@
     },
     {
         "BriefDescription": "Retired uops.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.ALL",
         "PEBS": "1",
@@ -1228,8 +986,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles without actually retired uops.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.CORE_STALL_CYCLES",
@@ -1239,8 +995,6 @@
     },
     {
         "BriefDescription": "Retirement slots used.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.RETIRE_SLOTS",
         "PEBS": "1",
@@ -1249,8 +1003,6 @@
     },
     {
         "BriefDescription": "Cycles without actually retired uops.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.STALL_CYCLES",
@@ -1260,8 +1012,6 @@
     },
     {
         "BriefDescription": "Cycles with less than 10 actually retired uop=
s.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "10",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.TOTAL_CYCLES",
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/uncore-cache.json b/t=
ools/perf/pmu-events/arch/x86/ivybridge/uncore-cache.json
index 6b0639944d78..c538557ba4c0 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/uncore-cache.json
@@ -1,251 +1,201 @@
 [
     {
         "BriefDescription": "L3 Lookup any request that access cache and f=
ound line in E or S-state.",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_ES",
         "PerPkg": "1",
-        "PublicDescription": "L3 Lookup any request that access cache and =
found line in E or S-state.",
         "UMask": "0x86",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "L3 Lookup any request that access cache and f=
ound line in I-state.",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_I",
         "PerPkg": "1",
-        "PublicDescription": "L3 Lookup any request that access cache and =
found line in I-state.",
         "UMask": "0x88",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "L3 Lookup any request that access cache and f=
ound line in M-state.",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_M",
         "PerPkg": "1",
-        "PublicDescription": "L3 Lookup any request that access cache and =
found line in M-state.",
         "UMask": "0x81",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "L3 Lookup any request that access cache and f=
ound line in MESI-state.",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_MESI",
         "PerPkg": "1",
-        "PublicDescription": "L3 Lookup any request that access cache and =
found line in MESI-state.",
         "UMask": "0x8f",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "L3 Lookup external snoop request that access =
cache and found line in E or S-state.",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.EXTSNP_ES",
         "PerPkg": "1",
-        "PublicDescription": "L3 Lookup external snoop request that access=
 cache and found line in E or S-state.",
         "UMask": "0x46",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "L3 Lookup external snoop request that access =
cache and found line in I-state.",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.EXTSNP_I",
         "PerPkg": "1",
-        "PublicDescription": "L3 Lookup external snoop request that access=
 cache and found line in I-state.",
         "UMask": "0x48",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "L3 Lookup external snoop request that access =
cache and found line in M-state.",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.EXTSNP_M",
         "PerPkg": "1",
-        "PublicDescription": "L3 Lookup external snoop request that access=
 cache and found line in M-state.",
         "UMask": "0x41",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "L3 Lookup external snoop request that access =
cache and found line in MESI-state.",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.EXTSNP_MESI",
         "PerPkg": "1",
-        "PublicDescription": "L3 Lookup external snoop request that access=
 cache and found line in MESI-state.",
         "UMask": "0x4f",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and =
found line in E or S-state.",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.READ_ES",
         "PerPkg": "1",
-        "PublicDescription": "L3 Lookup read request that access cache and=
 found line in E or S-state.",
         "UMask": "0x16",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and =
found line in I-state.",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.READ_I",
         "PerPkg": "1",
-        "PublicDescription": "L3 Lookup read request that access cache and=
 found line in I-state.",
         "UMask": "0x18",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and =
found line in M-state.",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.READ_M",
         "PerPkg": "1",
-        "PublicDescription": "L3 Lookup read request that access cache and=
 found line in M-state.",
         "UMask": "0x11",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and =
found line in any MESI-state.",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.READ_MESI",
         "PerPkg": "1",
-        "PublicDescription": "L3 Lookup read request that access cache and=
 found line in any MESI-state.",
         "UMask": "0x1f",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "L3 Lookup write request that access cache and=
 found line in E or S-state.",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.WRITE_ES",
         "PerPkg": "1",
-        "PublicDescription": "L3 Lookup write request that access cache an=
d found line in E or S-state.",
         "UMask": "0x26",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "L3 Lookup write request that access cache and=
 found line in I-state.",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.WRITE_I",
         "PerPkg": "1",
-        "PublicDescription": "L3 Lookup write request that access cache an=
d found line in I-state.",
         "UMask": "0x28",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "L3 Lookup write request that access cache and=
 found line in M-state.",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.WRITE_M",
         "PerPkg": "1",
-        "PublicDescription": "L3 Lookup write request that access cache an=
d found line in M-state.",
         "UMask": "0x21",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "L3 Lookup write request that access cache and=
 found line in MESI-state.",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_CBO_CACHE_LOOKUP.WRITE_MESI",
         "PerPkg": "1",
-        "PublicDescription": "L3 Lookup write request that access cache an=
d found line in MESI-state.",
         "UMask": "0x2f",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "A cross-core snoop resulted from L3 Eviction =
which hits a modified line in some processor core.",
-        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_CBO_XSNP_RESPONSE.HITM_EVICTION",
         "PerPkg": "1",
-        "PublicDescription": "A cross-core snoop resulted from L3 Eviction=
 which hits a modified line in some processor core.",
         "UMask": "0x88",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "An external snoop hits a modified line in som=
e processor core.",
-        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_CBO_XSNP_RESPONSE.HITM_EXTERNAL",
         "PerPkg": "1",
-        "PublicDescription": "An external snoop hits a modified line in so=
me processor core.",
         "UMask": "0x28",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "A cross-core snoop initiated by this Cbox due=
 to processor core memory request which hits a modified line in some proces=
sor core.",
-        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_CBO_XSNP_RESPONSE.HITM_XCORE",
         "PerPkg": "1",
-        "PublicDescription": "A cross-core snoop initiated by this Cbox du=
e to processor core memory request which hits a modified line in some proce=
ssor core.",
         "UMask": "0x48",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "A cross-core snoop resulted from L3 Eviction =
which hits a non-modified line in some processor core.",
-        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_CBO_XSNP_RESPONSE.HIT_EVICTION",
         "PerPkg": "1",
-        "PublicDescription": "A cross-core snoop resulted from L3 Eviction=
 which hits a non-modified line in some processor core.",
         "UMask": "0x84",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "An external snoop hits a non-modified line in=
 some processor core.",
-        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_CBO_XSNP_RESPONSE.HIT_EXTERNAL",
         "PerPkg": "1",
-        "PublicDescription": "An external snoop hits a non-modified line i=
n some processor core.",
         "UMask": "0x24",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "A cross-core snoop initiated by this Cbox due=
 to processor core memory request which hits a non-modified line in some pr=
ocessor core.",
-        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_CBO_XSNP_RESPONSE.HIT_XCORE",
         "PerPkg": "1",
-        "PublicDescription": "A cross-core snoop initiated by this Cbox du=
e to processor core memory request which hits a non-modified line in some p=
rocessor core.",
         "UMask": "0x44",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "A cross-core snoop resulted from L3 Eviction =
which misses in some processor core.",
-        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_CBO_XSNP_RESPONSE.MISS_EVICTION",
         "PerPkg": "1",
-        "PublicDescription": "A cross-core snoop resulted from L3 Eviction=
 which misses in some processor core.",
         "UMask": "0x81",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "An external snoop misses in some processor co=
re.",
-        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_CBO_XSNP_RESPONSE.MISS_EXTERNAL",
         "PerPkg": "1",
-        "PublicDescription": "An external snoop misses in some processor c=
ore.",
         "UMask": "0x21",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "A cross-core snoop initiated by this Cbox due=
 to processor core memory request which misses in some processor core.",
-        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "UNC_CBO_XSNP_RESPONSE.MISS_XCORE",
         "PerPkg": "1",
-        "PublicDescription": "A cross-core snoop initiated by this Cbox du=
e to processor core memory request which misses in some processor core.",
         "UMask": "0x41",
         "Unit": "CBO"
     }
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/uncore-other.json b/t=
ools/perf/pmu-events/arch/x86/ivybridge/uncore-other.json
index 88f1e326205f..c3252c094a9c 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/uncore-other.json
@@ -4,18 +4,15 @@
         "EventCode": "0x83",
         "EventName": "UNC_ARB_COH_TRK_OCCUPANCY.ALL",
         "PerPkg": "1",
-        "PublicDescription": "Cycles weighted by number of requests pendin=
g in Coherency Tracker.",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "ARB"
     },
     {
         "BriefDescription": "Number of requests allocated in Coherency Tra=
cker.",
-        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
         "PerPkg": "1",
-        "PublicDescription": "Number of requests allocated in Coherency Tr=
acker.",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "ARB"
     },
     {
@@ -23,69 +20,56 @@
         "EventCode": "0x80",
         "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
         "PerPkg": "1",
-        "PublicDescription": "Counts cycles weighted by the number of requ=
ests waiting for data returning from the memory controller. Accounts for co=
herent and non-coherent requests initiated by IA cores, processor graphic u=
nits, or LLC.",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "ARB"
     },
     {
         "BriefDescription": "Cycles with at least half of the requests out=
standing are waiting for data return from memory controller. Account for co=
herent and non-coherent requests initiated by IA Cores, Processor Graphics =
Unit, or LLC.",
-        "Counter": "0,1",
         "CounterMask": "10",
         "EventCode": "0x80",
         "EventName": "UNC_ARB_TRK_OCCUPANCY.CYCLES_OVER_HALF_FULL",
         "PerPkg": "1",
-        "PublicDescription": "Cycles with at least half of the requests ou=
tstanding are waiting for data return from memory controller. Account for c=
oherent and non-coherent requests initiated by IA Cores, Processor Graphics=
 Unit, or LLC.",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "ARB"
     },
     {
         "BriefDescription": "Cycles with at least one request outstanding =
is waiting for data return from memory controller. Account for coherent and=
 non-coherent requests initiated by IA Cores, Processor Graphics Unit, or L=
LC.",
-        "Counter": "0,1",
         "CounterMask": "1",
         "EventCode": "0x80",
         "EventName": "UNC_ARB_TRK_OCCUPANCY.CYCLES_WITH_ANY_REQUEST",
         "PerPkg": "1",
-        "PublicDescription": "Cycles with at least one request outstanding=
 is waiting for data return from memory controller. Account for coherent an=
d non-coherent requests initiated by IA Cores, Processor Graphics Unit, or =
LLC.",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "ARB"
     },
     {
         "BriefDescription": "Counts the number of coherent and in-coherent=
 requests initiated by IA cores, processor graphic units, or LLC.",
-        "Counter": "0,1",
         "EventCode": "0x81",
         "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherent and in-coheren=
t requests initiated by IA cores, processor graphic units, or LLC.",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "ARB"
     },
     {
         "BriefDescription": "Counts the number of LLC evictions allocated.=
",
-        "Counter": "0,1",
         "EventCode": "0x81",
         "EventName": "UNC_ARB_TRK_REQUESTS.EVICTIONS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of LLC evictions allocated=
.",
         "UMask": "0x80",
         "Unit": "ARB"
     },
     {
         "BriefDescription": "Counts the number of allocated write entries,=
 include full, partial, and LLC evictions.",
-        "Counter": "0,1",
         "EventCode": "0x81",
         "EventName": "UNC_ARB_TRK_REQUESTS.WRITES",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocated write entries=
, include full, partial, and LLC evictions.",
         "UMask": "0x20",
         "Unit": "ARB"
     },
     {
         "BriefDescription": "This 48-bit fixed counter counts the UCLK cyc=
les.",
-        "Counter": "Fixed",
         "EventCode": "0xff",
         "EventName": "UNC_CLOCK.SOCKET",
         "PerPkg": "1",
-        "PublicDescription": "This 48-bit fixed counter counts the UCLK cy=
cles.",
         "Unit": "ARB"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/virtual-memory.json b=
/tools/perf/pmu-events/arch/x86/ivybridge/virtual-memory.json
index a5e387bbb134..b97f15cb20fc 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/virtual-memory.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Page walk for a large page completed for Dema=
nd load.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.LARGE_PAGE_WALK_COMPLETED",
         "SampleAfterValue": "100003",
@@ -10,8 +8,6 @@
     },
     {
         "BriefDescription": "Demand load Miss in all translation lookaside=
 buffer (TLB) levels causes an page walk of any page size.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.MISS_CAUSES_A_WALK",
         "PublicDescription": "Misses in all TLB levels that cause a page w=
alk of any page size from demand loads.",
@@ -20,8 +16,6 @@
     },
     {
         "BriefDescription": "Load operations that miss the first DTLB leve=
l but hit the second and do not cause page walks",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5F",
         "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
         "PublicDescription": "Counts load operations that missed 1st level=
 DTLB but hit the 2nd level.",
@@ -30,8 +24,6 @@
     },
     {
         "BriefDescription": "Demand load Miss in all translation lookaside=
 buffer (TLB) levels causes a page walk that completes of any page size.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
         "PublicDescription": "Misses in all TLB levels that caused page wa=
lk completed of any size by demand loads.",
@@ -40,8 +32,6 @@
     },
     {
         "BriefDescription": "Demand load cycles page miss handler (PMH) is=
 busy with this walk.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_DURATION",
         "PublicDescription": "Cycle PMH is busy with a walk due to demand =
loads.",
@@ -50,8 +40,6 @@
     },
     {
         "BriefDescription": "Store misses in all DTLB levels that cause pa=
ge walks",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.MISS_CAUSES_A_WALK",
         "PublicDescription": "Miss in all TLB levels causes a page walk of=
 any page size (4K/2M/4M/1G).",
@@ -60,8 +48,6 @@
     },
     {
         "BriefDescription": "Store operations that miss the first TLB leve=
l but hit the second and do not cause page walks",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.STLB_HIT",
         "PublicDescription": "Store operations that miss the first TLB lev=
el but hit the second and do not cause page walks.",
@@ -70,8 +56,6 @@
     },
     {
         "BriefDescription": "Store misses in all DTLB levels that cause co=
mpleted page walks",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
         "PublicDescription": "Miss in all TLB levels causes a page walk th=
at completes of any page size (4K/2M/4M/1G).",
@@ -80,8 +64,6 @@
     },
     {
         "BriefDescription": "Cycles when PMH is busy with page walks",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_DURATION",
         "PublicDescription": "Cycles PMH is busy with this walk.",
@@ -90,8 +72,6 @@
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
@@ -99,8 +79,6 @@
     },
     {
         "BriefDescription": "Flushing of the Instruction TLB (ITLB) pages,=
 includes 4k/2M/4M pages.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xAE",
         "EventName": "ITLB.ITLB_FLUSH",
         "PublicDescription": "Counts the number of ITLB flushes, includes =
4k/2M/4M pages.",
@@ -109,8 +87,6 @@
     },
     {
         "BriefDescription": "Completed page walks in ITLB due to STLB load=
 misses for large pages",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.LARGE_PAGE_WALK_COMPLETED",
         "PublicDescription": "Completed page walks in ITLB due to STLB loa=
d misses for large pages.",
@@ -119,8 +95,6 @@
     },
     {
         "BriefDescription": "Misses at all ITLB levels that cause page wal=
ks",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.MISS_CAUSES_A_WALK",
         "PublicDescription": "Misses in all ITLB levels that cause page wa=
lks.",
@@ -129,8 +103,6 @@
     },
     {
         "BriefDescription": "Operations that miss the first ITLB level but=
 hit the second and do not cause any page walks",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.STLB_HIT",
         "PublicDescription": "Number of cache load STLB hits. No page walk=
.",
@@ -139,8 +111,6 @@
     },
     {
         "BriefDescription": "Misses in all ITLB levels that cause complete=
d page walks",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
         "PublicDescription": "Misses in all ITLB levels that cause complet=
ed page walks.",
@@ -149,8 +119,6 @@
     },
     {
         "BriefDescription": "Cycles when PMH is busy with page walks",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_DURATION",
         "PublicDescription": "Cycle PMH is busy with a walk.",
@@ -159,8 +127,6 @@
     },
     {
         "BriefDescription": "DTLB flush attempts of the thread-specific en=
tries",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xBD",
         "EventName": "TLB_FLUSH.DTLB_THREAD",
         "PublicDescription": "DTLB flush attempts of the thread-specific e=
ntries.",
@@ -169,8 +135,6 @@
     },
     {
         "BriefDescription": "STLB flush attempts",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xBD",
         "EventName": "TLB_FLUSH.STLB_ANY",
         "PublicDescription": "Count number of STLB flush attempts.",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 7e489749a0d4..de3f9dd4e6f7 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -13,7 +13,7 @@ GenuineIntel-6-(3C|45|46),v32,haswell,core
 GenuineIntel-6-3F,v26,haswellx,core
 GenuineIntel-6-(7D|7E|A7),v1.15,icelake,core
 GenuineIntel-6-6[AC],v1.17,icelakex,core
-GenuineIntel-6-3A,v22,ivybridge,core
+GenuineIntel-6-3A,v23,ivybridge,core
 GenuineIntel-6-3E,v22,ivytown,core
 GenuineIntel-6-2D,v21,jaketown,core
 GenuineIntel-6-(57|85),v9,knightslanding,core
--=20
2.39.0.314.g84b9a713c41-goog

