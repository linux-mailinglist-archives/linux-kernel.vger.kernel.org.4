Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B45A64D6C9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 07:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiLOG6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 01:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiLOG4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:56:41 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780EF3D3AE
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:56:37 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 195-20020a2505cc000000b0071163981d18so2654572ybf.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FheVetiCVQsUTC+U0ZqL4bGSFdq9U4jIikDRNGvS+H8=;
        b=fojmRQKhwWYSHvb+YkCQafJMZMiwhaZvimKQtnbW9VSVmXjZiX+OkE5fbEmoeSgo/d
         0PVOw8TXAS4B3ABXXhyM+kjK0EAnDsD0G28L2p5t09vCoEAlo7Re3rqPKitzq2+Spbuy
         4Hvni/vxr2Np0gzN0wyqFooMa9SVj5M68R1TJIVocPD12DPRqu1AYOEnJgNtpzPuDUm1
         HDBLkSpYLGFOlF/mpdwP2yKBg9zekf6rzO+8IMtOoJJupBEcXaVzPAhTX4CIs/SJTrhr
         Yiy01D5mjWyuNdWF3x/fEr7Y/tMk1Xkw+CwIV2Tb5BJVC5b4wL2T4QK59w9iEE5xf6dB
         pjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FheVetiCVQsUTC+U0ZqL4bGSFdq9U4jIikDRNGvS+H8=;
        b=3EPlMxHTJT7fyCrCTnXt8jyyWA+4omson6KA8QjfzNGvYHQ1RTFn9eMeV2uw57HM2G
         tK5LJvCixnMfvoKjlA/a3jEF5C13SmN5FIlimn54RGrX7Jp6o9FTLaf/HLseBR0Krmts
         jpuFhmd4koDfYuUP1XnzLeq/nplG/0Yql8FbQ1YulkhXUYH+1n13foL70TP2YOhP8Xg+
         DNqrdhRvYGkyPyJX+v3ckOckUf8sulKao1ymSpNvZDKkCZXkkPV3+lsdGUvhdW+F3yil
         00W78O8tSxhAYC7XJjs+TOq/yALuEJ8BUJAK3FalyEmxYbxDE3oHd7G/1mIlfWKa1kvY
         3mZQ==
X-Gm-Message-State: ANoB5plxFCZAhrwcOb5mgcvLq01xiOqhKZvoUjkbN2AW1Qs/qbi+qGPK
        t9B2JpQWBTd1ZsvKGXge3+phAHAne6tz
X-Google-Smtp-Source: AA0mqf5qA9h6zlqO08snwRgSg7izBclWtc56oP36YQPBKcL1QdWPkfu89hTwn/adjQnPq74hU3hfbrltq9tZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c7dc:d96f:4f9:f59d])
 (user=irogers job=sendgmr) by 2002:a25:b03:0:b0:6f3:eaf5:4da3 with SMTP id
 3-20020a250b03000000b006f3eaf54da3mr62858035ybl.193.1671087397121; Wed, 14
 Dec 2022 22:56:37 -0800 (PST)
Date:   Wed, 14 Dec 2022 22:54:55 -0800
In-Reply-To: <20221215065510.1621979-1-irogers@google.com>
Message-Id: <20221215065510.1621979-9-irogers@google.com>
Mime-Version: 1.0
References: <20221215065510.1621979-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 17/32] perf vendor events intel: Refresh ivytown metrics
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the ivytown metrics and events using the new tooling from:
https://github.com/intel/perfmon

The metrics are unchanged but the formulas differ due to parentheses,
use of exponents and removal of redundant operations like "* 1".  The
events are unchanged but unused json values are removed. The
formatting changes increase consistency across the json files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/ivytown/cache.json    | 274 ----------
 .../arch/x86/ivytown/floating-point.json      |  34 --
 .../pmu-events/arch/x86/ivytown/frontend.json |  60 ---
 .../arch/x86/ivytown/ivt-metrics.json         | 133 +++--
 .../pmu-events/arch/x86/ivytown/memory.json   | 121 -----
 .../pmu-events/arch/x86/ivytown/other.json    |   8 -
 .../pmu-events/arch/x86/ivytown/pipeline.json | 250 ---------
 .../arch/x86/ivytown/uncore-cache.json        | 388 ++------------
 .../arch/x86/ivytown/uncore-interconnect.json | 505 +++++++-----------
 .../arch/x86/ivytown/uncore-memory.json       | 209 +-------
 .../arch/x86/ivytown/uncore-other.json        | 254 +--------
 .../arch/x86/ivytown/uncore-power.json        |  95 ----
 .../arch/x86/ivytown/virtual-memory.json      |  40 --
 13 files changed, 346 insertions(+), 2025 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/ivytown/cache.json b/tools/perf=
/pmu-events/arch/x86/ivytown/cache.json
index d95b98c83914..c8f7d5e66504 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/cache.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/cache.json
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
         "BriefDescription": "L1D miss outstanding duration in cycles",
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
         "BriefDescription": "Retired load uops whose data source was local=
 DRAM (Snoop not needed, Snoop Miss, or Snoop Hit data not forwarded).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD3",
         "EventName": "MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM",
         "SampleAfterValue": "100007",
@@ -482,8 +386,6 @@
     },
     {
         "BriefDescription": "Retired load uops whose data source was remot=
e DRAM (Snoop not needed, Snoop Miss, or Snoop Hit data not forwarded).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD3",
         "EventName": "MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_DRAM",
         "SampleAfterValue": "100007",
@@ -491,8 +393,6 @@
     },
     {
         "BriefDescription": "Data forwarded from remote cache.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD3",
         "EventName": "MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_FWD",
         "SampleAfterValue": "100007",
@@ -500,8 +400,6 @@
     },
     {
         "BriefDescription": "Remote cache HITM.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD3",
         "EventName": "MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM",
         "SampleAfterValue": "100007",
@@ -509,8 +407,6 @@
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
@@ -519,8 +415,6 @@
     },
     {
         "BriefDescription": "Retired load uops with L1 cache hits as data =
sources.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_HIT",
         "PEBS": "1",
@@ -529,8 +423,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources followin=
g L1 data-cache miss.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_MISS",
         "PEBS": "1",
@@ -539,8 +431,6 @@
     },
     {
         "BriefDescription": "Retired load uops with L2 cache hits as data =
sources.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
         "PEBS": "1",
@@ -549,8 +439,6 @@
     },
     {
         "BriefDescription": "Retired load uops with L2 cache misses as dat=
a sources.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_MISS",
         "PEBS": "1",
@@ -559,8 +447,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were dat=
a hits in LLC without snoops required.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.LLC_HIT",
         "PEBS": "1",
@@ -569,8 +455,6 @@
     },
     {
         "BriefDescription": "Miss in last-level (L3) cache. Excludes Unkno=
wn data-source.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.LLC_MISS",
         "PEBS": "1",
@@ -579,8 +463,6 @@
     },
     {
         "BriefDescription": "All retired load uops. (Precise Event)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
         "PEBS": "1",
@@ -589,8 +471,6 @@
     },
     {
         "BriefDescription": "All retired store uops. (Precise Event)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
         "PEBS": "1",
@@ -599,8 +479,6 @@
     },
     {
         "BriefDescription": "Retired load uops with locked access. (Precis=
e Event)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.LOCK_LOADS",
         "PEBS": "1",
@@ -609,8 +487,6 @@
     },
     {
         "BriefDescription": "Retired load uops that split across a cacheli=
ne boundary. (Precise Event)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
         "PEBS": "1",
@@ -619,8 +495,6 @@
     },
     {
         "BriefDescription": "Retired store uops that split across a cachel=
ine boundary. (Precise Event)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
         "PEBS": "1",
@@ -629,8 +503,6 @@
     },
     {
         "BriefDescription": "Retired load uops that miss the STLB. (Precis=
e Event)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.STLB_MISS_LOADS",
         "PEBS": "1",
@@ -639,8 +511,6 @@
     },
     {
         "BriefDescription": "Retired store uops that miss the STLB. (Preci=
se Event)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.STLB_MISS_STORES",
         "PEBS": "1",
@@ -649,8 +519,6 @@
     },
     {
         "BriefDescription": "Demand and prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.ALL_DATA_RD",
         "PublicDescription": "Data read requests sent to uncore (demand an=
d prefetch).",
@@ -659,8 +527,6 @@
     },
     {
         "BriefDescription": "Cacheable and noncacheable code read requests=
",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.DEMAND_CODE_RD",
         "PublicDescription": "Demand code read requests sent to uncore.",
@@ -669,8 +535,6 @@
     },
     {
         "BriefDescription": "Demand Data Read requests sent to uncore",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.DEMAND_DATA_RD",
         "PublicDescription": "Demand data read requests sent to uncore.",
@@ -679,8 +543,6 @@
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
@@ -689,8 +551,6 @@
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
@@ -699,8 +559,6 @@
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
@@ -709,8 +567,6 @@
     },
     {
         "BriefDescription": "Cycles when offcore outstanding cacheable Cor=
e Data Read transactions are present in SuperQueue (SQ), queue to uncore",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
@@ -720,8 +576,6 @@
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
@@ -731,8 +585,6 @@
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
@@ -742,8 +594,6 @@
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
@@ -753,8 +603,6 @@
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
@@ -763,8 +611,6 @@
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
@@ -773,8 +619,6 @@
     },
     {
         "BriefDescription": "Cycles with at least 6 offcore outstanding De=
mand Data Read transactions in uncore queue",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "6",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD_GE_6",
@@ -784,8 +628,6 @@
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
@@ -794,464 +636,348 @@
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
         "BriefDescription": "Split locks in SQ",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF4",
         "EventName": "SQ_MISC.SPLIT_LOCK",
         "SampleAfterValue": "100003",
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/floating-point.json b/t=
ools/perf/pmu-events/arch/x86/ivytown/floating-point.json
index 88891cba54ec..89c6d47cc077 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/floating-point.json
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
 cycle. The number of FADD, FSUB, FCOM, FMULs, integer MULs and IMULs, FDIV=
s, FPREMs, FSQRTS, integer DIVs, and IDIVs. This event does not distinguish=
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
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/frontend.json b/tools/p=
erf/pmu-events/arch/x86/ivytown/frontend.json
index 0a295c4e093d..4ee100024ca9 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/frontend.json
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
uction Decode Queue (IDQ) while Microcode Sequencer (MS) is busy",
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
rocode Sequencer (MS) is busy",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_DSB_CYCLES",
@@ -199,8 +161,6 @@
     },
     {
         "BriefDescription": "Deliveries to Instruction Decode Queue (IDQ) =
initiated by Decode Stream Buffer (DSB) while Microcode Sequencer (MS) is b=
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
Sequencer (MS) is busy",
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
uction Decode Queue (IDQ) while Microcode Sequencer (MS) is busy",
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
DQ) while Microcode Sequencer (MS) is busy",
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
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json b/tool=
s/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
index 99a45c8d8cee..80444bc4e66e 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
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
 MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED=
.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L=
LC_MISS_RETIRED.REMOTE_FWD))) + 43 * (MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MI=
SS * (1 + mem_load_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + =
MEM_LOAD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + ME=
M_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_=
MISS) + MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_=
RETIRED.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD=
_UOPS_LLC_MISS_RETIRED.REMOTE_FWD)))) / CLKS",
+        "MetricExpr": "(60 * (MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM * (1=
 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD=
_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD_U=
OPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS + M=
EM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.R=
EMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_LLC=
_MISS_RETIRED.REMOTE_FWD))) + 43 * (MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS=
 * (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM=
_LOAD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_L=
OAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MIS=
S + MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETI=
RED.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOP=
S_LLC_MISS_RETIRED.REMOTE_FWD)))) / CLKS",
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
EM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.R=
EMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_LLC=
_MISS_RETIRED.REMOTE_FWD))) / CLKS",
+        "MetricExpr": "43 * (MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT * (1 +=
 MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_U=
OPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOP=
S_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS + MEM=
_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REM=
OTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_LLC_M=
ISS_RETIRED.REMOTE_FWD))) / CLKS",
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
-        "MetricExpr": "41 * (MEM_LOAD_UOPS_RETIRED.LLC_HIT * (1 + mem_load=
_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UOPS_RETI=
RED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_LLC_HI=
T_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS) + MEM_LOAD_U=
OPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_DRA=
M + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_LLC_MISS_RET=
IRED.REMOTE_FWD))) / CLKS",
+        "MetricExpr": "41 * (MEM_LOAD_UOPS_RETIRED.LLC_HIT * (1 + MEM_LOAD=
_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UOPS_RETIR=
ED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_LLC_HIT=
_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS + MEM_LOAD_UOP=
S_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_DRAM =
+ MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_LLC_MISS_RETIR=
ED.REMOTE_FWD))) / CLKS",
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
@@ -256,7 +256,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from local memory",
-        "MetricExpr": "200 * (MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM * =
(1 + mem_load_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_L=
OAD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOA=
D_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS)=
 + MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIR=
ED.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS=
_LLC_MISS_RETIRED.REMOTE_FWD))) / CLKS",
+        "MetricExpr": "200 * (MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM * =
(1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LO=
AD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD=
_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS +=
 MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED=
.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L=
LC_MISS_RETIRED.REMOTE_FWD))) / CLKS",
         "MetricGroup": "Server;TopdownL5;tma_mem_latency_group",
         "MetricName": "tma_local_dram",
         "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from local memory. Caching will =
improve the latency and increase performance. Sample with: MEM_LOAD_UOPS_L3=
_MISS_RETIRED.LOCAL_DRAM_PS",
@@ -264,7 +264,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote memory",
-        "MetricExpr": "310 * (MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_DRAM *=
 (1 + mem_load_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_=
LOAD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LO=
AD_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS=
) + MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETI=
RED.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOP=
S_LLC_MISS_RETIRED.REMOTE_FWD))) / CLKS",
+        "MetricExpr": "310 * (MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_DRAM *=
 (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_L=
OAD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOA=
D_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS =
+ MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRE=
D.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_=
LLC_MISS_RETIRED.REMOTE_FWD))) / CLKS",
         "MetricGroup": "Server;Snoop;TopdownL5;tma_mem_latency_group",
         "MetricName": "tma_remote_dram",
         "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote memory. This is caus=
ed often due to non-optimal NUMA allocations. #link to NUMA article Sample =
with: MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_DRAM_PS",
@@ -272,7 +272,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote cache in other socket=
s including synchronizations issues",
-        "MetricExpr": "(200 * (MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM =
* (1 + mem_load_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM=
_LOAD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_L=
OAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MIS=
S) + MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RET=
IRED.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UO=
PS_LLC_MISS_RETIRED.REMOTE_FWD))) + 180 * (MEM_LOAD_UOPS_LLC_MISS_RETIRED.R=
EMOTE_FWD * (1 + mem_load_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2=
_HIT + MEM_LOAD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_H=
IT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRE=
D.XSNP_MISS) + MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LL=
C_MISS_RETIRED.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + M=
EM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_FWD)))) / CLKS",
+        "MetricExpr": "(200 * (MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM =
* (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_=
LOAD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LO=
AD_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS=
 + MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIR=
ED.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS=
_LLC_MISS_RETIRED.REMOTE_FWD))) + 180 * (MEM_LOAD_UOPS_LLC_MISS_RETIRED.REM=
OTE_FWD * (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HI=
T + MEM_LOAD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT =
+ MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.X=
SNP_MISS + MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_LLC_MI=
SS_RETIRED.REMOTE_DRAM + MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM + MEM_L=
OAD_UOPS_LLC_MISS_RETIRED.REMOTE_FWD)))) / CLKS",
         "MetricGroup": "Offcore;Server;Snoop;TopdownL5;tma_mem_latency_gro=
up",
         "MetricName": "tma_remote_cache",
         "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote cache in other socke=
ts including synchronizations issues. This is caused often due to non-optim=
al NUMA allocations. #link to NUMA article Sample with: MEM_LOAD_UOPS_L3_MI=
SS_RETIRED.REMOTE_HITM_PS;MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_FWD_PS",
@@ -288,7 +288,7 @@
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
@@ -336,7 +336,7 @@
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
@@ -344,7 +344,7 @@
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
@@ -352,7 +352,7 @@
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
@@ -360,7 +360,7 @@
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
@@ -368,7 +368,7 @@
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
@@ -424,7 +424,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Store operations",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_4 / CORE_CLKS",
+        "MetricExpr": "tma_port_4",
         "MetricGroup": "TopdownL5;tma_ports_utilized_3m_group",
         "MetricName": "tma_store_op_utilization",
         "ScaleUnit": "100%"
@@ -494,7 +494,7 @@
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
@@ -567,19 +567,19 @@
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
@@ -646,7 +646,7 @@
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
@@ -658,7 +658,7 @@
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
@@ -670,19 +670,19 @@
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
@@ -695,19 +695,19 @@
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
@@ -737,19 +737,19 @@
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
@@ -762,7 +762,7 @@
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
@@ -780,10 +780,22 @@
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
@@ -796,52 +808,59 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/memory.json b/tools/per=
f/pmu-events/arch/x86/ivytown/memory.json
index 99b71e43acad..138d1aa0b32d 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/memory.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/memory.json
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
@@ -154,349 +120,262 @@
     },
     {
         "BriefDescription": "Counts all demand & prefetch code reads that =
miss the LLC",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.LLC_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3fffc00244",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch code reads that =
miss the LLC  and the data returned from remote dram",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.LLC_MISS.REMOTE_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x67f800244",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch code reads that =
miss the LLC  and the data forwarded from remote cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.LLC_MISS.REMOTE_HIT_FOR=
WARD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x87f800244",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data reads that =
hits the LLC",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3fffc20091",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all data/code/rfo reads (demand & pref=
etch) that hit the LLC",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3fffc203f7",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all data/code/rfo reads (demand & pref=
etch) that miss the LLC  and the data returned from local dram",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x6004003f7",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all data/code/rfo reads (demand & pref=
etch) that miss the LLC  the data is found in M state in remote cache and f=
orwarded from there",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_MISS.REMOTE_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x107fc003f7",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all data/code/rfo reads (demand & pref=
etch) that miss the LLC  and the data forwarded from remote cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_MISS.REMOTE_HIT_FORWA=
RD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x87f8203f7",
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
         "BriefDescription": "Counts all demand data writes (RFOs) that mis=
s the LLC and the data is found in M state in remote cache and forwarded fr=
om there.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LLC_MISS.REMOTE_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x107fc20002",
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
 data reads that miss in the LLC",
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
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/other.json b/tools/perf=
/pmu-events/arch/x86/ivytown/other.json
index 2d62521791d8..e80e99d064ba 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/other.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/other.json
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
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json b/tools/p=
erf/pmu-events/arch/x86/ivytown/pipeline.json
index d89d3f8db190..d1e64e0d683e 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
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
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json b/too=
ls/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
index c118ff54c30e..521175881173 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
@@ -1,14 +1,12 @@
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
@@ -17,7 +15,6 @@
     },
     {
         "BriefDescription": "Cache Lookups; Any Request",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.ANY",
         "PerPkg": "1",
@@ -27,7 +24,6 @@
     },
     {
         "BriefDescription": "Cache Lookups; Data Read Request",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.DATA_READ",
         "PerPkg": "1",
@@ -37,7 +33,6 @@
     },
     {
         "BriefDescription": "Cache Lookups; Lookups that Match NID",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.NID",
         "PerPkg": "1",
@@ -47,7 +42,6 @@
     },
     {
         "BriefDescription": "Cache Lookups; External Snoop Request",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.REMOTE_SNOOP",
         "PerPkg": "1",
@@ -57,7 +51,6 @@
     },
     {
         "BriefDescription": "Cache Lookups; Write Requests",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.WRITE",
         "PerPkg": "1",
@@ -67,7 +60,6 @@
     },
     {
         "BriefDescription": "Lines Victimized; Lines in E state",
-        "Counter": "0,1",
         "EventCode": "0x37",
         "EventName": "UNC_C_LLC_VICTIMS.E_STATE",
         "PerPkg": "1",
@@ -77,7 +69,6 @@
     },
     {
         "BriefDescription": "Lines Victimized",
-        "Counter": "0,1",
         "EventCode": "0x37",
         "EventName": "UNC_C_LLC_VICTIMS.MISS",
         "PerPkg": "1",
@@ -87,7 +78,6 @@
     },
     {
         "BriefDescription": "Lines Victimized; Lines in M state",
-        "Counter": "0,1",
         "EventCode": "0x37",
         "EventName": "UNC_C_LLC_VICTIMS.M_STATE",
         "PerPkg": "1",
@@ -97,7 +87,6 @@
     },
     {
         "BriefDescription": "Lines Victimized; Victimized Lines that Match=
 NID",
-        "Counter": "0,1",
         "EventCode": "0x37",
         "EventName": "UNC_C_LLC_VICTIMS.NID",
         "PerPkg": "1",
@@ -107,7 +96,6 @@
     },
     {
         "BriefDescription": "Lines Victimized; Lines in S State",
-        "Counter": "0,1",
         "EventCode": "0x37",
         "EventName": "UNC_C_LLC_VICTIMS.S_STATE",
         "PerPkg": "1",
@@ -117,7 +105,6 @@
     },
     {
         "BriefDescription": "Cbo Misc; RFO HitS",
-        "Counter": "0,1",
         "EventCode": "0x39",
         "EventName": "UNC_C_MISC.RFO_HIT_S",
         "PerPkg": "1",
@@ -127,7 +114,6 @@
     },
     {
         "BriefDescription": "Cbo Misc; Silent Snoop Eviction",
-        "Counter": "0,1",
         "EventCode": "0x39",
         "EventName": "UNC_C_MISC.RSPI_WAS_FSE",
         "PerPkg": "1",
@@ -137,7 +123,6 @@
     },
     {
         "BriefDescription": "Cbo Misc",
-        "Counter": "0,1",
         "EventCode": "0x39",
         "EventName": "UNC_C_MISC.STARTED",
         "PerPkg": "1",
@@ -147,7 +132,6 @@
     },
     {
         "BriefDescription": "Cbo Misc; Write Combining Aliasing",
-        "Counter": "0,1",
         "EventCode": "0x39",
         "EventName": "UNC_C_MISC.WC_ALIASING",
         "PerPkg": "1",
@@ -157,7 +141,6 @@
     },
     {
         "BriefDescription": "LRU Queue; LRU Age 0",
-        "Counter": "0,1",
         "EventCode": "0x3c",
         "EventName": "UNC_C_QLRU.AGE0",
         "PerPkg": "1",
@@ -167,7 +150,6 @@
     },
     {
         "BriefDescription": "LRU Queue; LRU Age 1",
-        "Counter": "0,1",
         "EventCode": "0x3c",
         "EventName": "UNC_C_QLRU.AGE1",
         "PerPkg": "1",
@@ -177,7 +159,6 @@
     },
     {
         "BriefDescription": "LRU Queue; LRU Age 2",
-        "Counter": "0,1",
         "EventCode": "0x3c",
         "EventName": "UNC_C_QLRU.AGE2",
         "PerPkg": "1",
@@ -187,7 +168,6 @@
     },
     {
         "BriefDescription": "LRU Queue; LRU Age 3",
-        "Counter": "0,1",
         "EventCode": "0x3c",
         "EventName": "UNC_C_QLRU.AGE3",
         "PerPkg": "1",
@@ -197,7 +177,6 @@
     },
     {
         "BriefDescription": "LRU Queue; LRU Bits Decremented",
-        "Counter": "0,1",
         "EventCode": "0x3c",
         "EventName": "UNC_C_QLRU.LRU_DECREMENT",
         "PerPkg": "1",
@@ -207,7 +186,6 @@
     },
     {
         "BriefDescription": "LRU Queue; Non-0 Aged Victim",
-        "Counter": "0,1",
         "EventCode": "0x3c",
         "EventName": "UNC_C_QLRU.VICTIM_NON_ZERO",
         "PerPkg": "1",
@@ -217,17 +195,15 @@
     },
     {
         "BriefDescription": "AD Ring In Use; Counterclockwise",
-        "Counter": "2,3",
         "EventCode": "0x1B",
         "EventName": "UNC_C_RING_AD_USED.CCW",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "AD Ring In Use; Clockwise",
-        "Counter": "2,3",
         "EventCode": "0x1B",
         "EventName": "UNC_C_RING_AD_USED.CW",
         "PerPkg": "1",
@@ -237,17 +213,15 @@
     },
     {
         "BriefDescription": "AD Ring In Use; Down",
-        "Counter": "2,3",
         "EventCode": "0x1B",
         "EventName": "UNC_C_RING_AD_USED.DOWN",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.",
-        "UMask": "0xCC",
+        "UMask": "0xcc",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "AD Ring In Use; Down and Even on Vring 0",
-        "Counter": "2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_C_RING_AD_USED.DOWN_VR0_EVEN",
         "PerPkg": "1",
@@ -257,7 +231,6 @@
     },
     {
         "BriefDescription": "AD Ring In Use; Down and Odd on Vring 0",
-        "Counter": "2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_C_RING_AD_USED.DOWN_VR0_ODD",
         "PerPkg": "1",
@@ -267,7 +240,6 @@
     },
     {
         "BriefDescription": "AD Ring In Use; Down and Even on VRing 1",
-        "Counter": "2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_C_RING_AD_USED.DOWN_VR1_EVEN",
         "PerPkg": "1",
@@ -277,7 +249,6 @@
     },
     {
         "BriefDescription": "AD Ring In Use; Down and Odd on VRing 1",
-        "Counter": "2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_C_RING_AD_USED.DOWN_VR1_ODD",
         "PerPkg": "1",
@@ -287,7 +258,6 @@
     },
     {
         "BriefDescription": "AD Ring In Use; Up",
-        "Counter": "2,3",
         "EventCode": "0x1B",
         "EventName": "UNC_C_RING_AD_USED.UP",
         "PerPkg": "1",
@@ -297,7 +267,6 @@
     },
     {
         "BriefDescription": "AD Ring In Use; Up and Even on Vring 0",
-        "Counter": "2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_C_RING_AD_USED.UP_VR0_EVEN",
         "PerPkg": "1",
@@ -307,7 +276,6 @@
     },
     {
         "BriefDescription": "AD Ring In Use; Up and Odd on Vring 0",
-        "Counter": "2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_C_RING_AD_USED.UP_VR0_ODD",
         "PerPkg": "1",
@@ -317,7 +285,6 @@
     },
     {
         "BriefDescription": "AD Ring In Use; Up and Even on VRing 1",
-        "Counter": "2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_C_RING_AD_USED.UP_VR1_EVEN",
         "PerPkg": "1",
@@ -327,7 +294,6 @@
     },
     {
         "BriefDescription": "AD Ring In Use; Up and Odd on VRing 1",
-        "Counter": "2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_C_RING_AD_USED.UP_VR1_ODD",
         "PerPkg": "1",
@@ -337,17 +303,15 @@
     },
     {
         "BriefDescription": "AK Ring In Use; Counterclockwise",
-        "Counter": "2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_C_RING_AK_USED.CCW",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "AK Ring In Use; Clockwise",
-        "Counter": "2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_C_RING_AK_USED.CW",
         "PerPkg": "1",
@@ -357,17 +321,15 @@
     },
     {
         "BriefDescription": "AK Ring In Use; Down",
-        "Counter": "2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_C_RING_AK_USED.DOWN",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
-        "UMask": "0xCC",
+        "UMask": "0xcc",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "AK Ring In Use; Down and Even on Vring 0",
-        "Counter": "2,3",
         "EventCode": "0x1c",
         "EventName": "UNC_C_RING_AK_USED.DOWN_VR0_EVEN",
         "PerPkg": "1",
@@ -377,7 +339,6 @@
     },
     {
         "BriefDescription": "AK Ring In Use; Down and Odd on Vring 0",
-        "Counter": "2,3",
         "EventCode": "0x1c",
         "EventName": "UNC_C_RING_AK_USED.DOWN_VR0_ODD",
         "PerPkg": "1",
@@ -387,7 +348,6 @@
     },
     {
         "BriefDescription": "AK Ring In Use; Down and Even on VRing 1",
-        "Counter": "2,3",
         "EventCode": "0x1c",
         "EventName": "UNC_C_RING_AK_USED.DOWN_VR1_EVEN",
         "PerPkg": "1",
@@ -397,7 +357,6 @@
     },
     {
         "BriefDescription": "AK Ring In Use; Down and Odd on VRing 1",
-        "Counter": "2,3",
         "EventCode": "0x1c",
         "EventName": "UNC_C_RING_AK_USED.DOWN_VR1_ODD",
         "PerPkg": "1",
@@ -407,7 +366,6 @@
     },
     {
         "BriefDescription": "AK Ring In Use; Up",
-        "Counter": "2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_C_RING_AK_USED.UP",
         "PerPkg": "1",
@@ -417,7 +375,6 @@
     },
     {
         "BriefDescription": "AK Ring In Use; Up and Even on Vring 0",
-        "Counter": "2,3",
         "EventCode": "0x1c",
         "EventName": "UNC_C_RING_AK_USED.UP_VR0_EVEN",
         "PerPkg": "1",
@@ -427,7 +384,6 @@
     },
     {
         "BriefDescription": "AK Ring In Use; Up and Odd on Vring 0",
-        "Counter": "2,3",
         "EventCode": "0x1c",
         "EventName": "UNC_C_RING_AK_USED.UP_VR0_ODD",
         "PerPkg": "1",
@@ -437,7 +393,6 @@
     },
     {
         "BriefDescription": "AK Ring In Use; Up and Even on VRing 1",
-        "Counter": "2,3",
         "EventCode": "0x1c",
         "EventName": "UNC_C_RING_AK_USED.UP_VR1_EVEN",
         "PerPkg": "1",
@@ -447,7 +402,6 @@
     },
     {
         "BriefDescription": "AK Ring In Use; Up and Odd on VRing 1",
-        "Counter": "2,3",
         "EventCode": "0x1c",
         "EventName": "UNC_C_RING_AK_USED.UP_VR1_ODD",
         "PerPkg": "1",
@@ -457,17 +411,15 @@
     },
     {
         "BriefDescription": "BL Ring in Use; Counterclockwise",
-        "Counter": "2,3",
         "EventCode": "0x1D",
         "EventName": "UNC_C_RING_BL_USED.CCW",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "BL Ring in Use; Clockwise",
-        "Counter": "2,3",
         "EventCode": "0x1D",
         "EventName": "UNC_C_RING_BL_USED.CW",
         "PerPkg": "1",
@@ -477,17 +429,15 @@
     },
     {
         "BriefDescription": "BL Ring in Use; Down",
-        "Counter": "2,3",
         "EventCode": "0x1D",
         "EventName": "UNC_C_RING_BL_USED.DOWN",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
-        "UMask": "0xCC",
+        "UMask": "0xcc",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "BL Ring in Use; Down and Even on Vring 0",
-        "Counter": "2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_C_RING_BL_USED.DOWN_VR0_EVEN",
         "PerPkg": "1",
@@ -497,7 +447,6 @@
     },
     {
         "BriefDescription": "BL Ring in Use; Down and Odd on Vring 0",
-        "Counter": "2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_C_RING_BL_USED.DOWN_VR0_ODD",
         "PerPkg": "1",
@@ -507,7 +456,6 @@
     },
     {
         "BriefDescription": "BL Ring in Use; Down and Even on VRing 1",
-        "Counter": "2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_C_RING_BL_USED.DOWN_VR1_EVEN",
         "PerPkg": "1",
@@ -517,7 +465,6 @@
     },
     {
         "BriefDescription": "BL Ring in Use; Down and Odd on VRing 1",
-        "Counter": "2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_C_RING_BL_USED.DOWN_VR1_ODD",
         "PerPkg": "1",
@@ -527,7 +474,6 @@
     },
     {
         "BriefDescription": "BL Ring in Use; Up",
-        "Counter": "2,3",
         "EventCode": "0x1D",
         "EventName": "UNC_C_RING_BL_USED.UP",
         "PerPkg": "1",
@@ -537,7 +483,6 @@
     },
     {
         "BriefDescription": "BL Ring in Use; Up and Even on Vring 0",
-        "Counter": "2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_C_RING_BL_USED.UP_VR0_EVEN",
         "PerPkg": "1",
@@ -547,7 +492,6 @@
     },
     {
         "BriefDescription": "BL Ring in Use; Up and Odd on Vring 0",
-        "Counter": "2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_C_RING_BL_USED.UP_VR0_ODD",
         "PerPkg": "1",
@@ -557,7 +501,6 @@
     },
     {
         "BriefDescription": "BL Ring in Use; Up and Even on VRing 1",
-        "Counter": "2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_C_RING_BL_USED.UP_VR1_EVEN",
         "PerPkg": "1",
@@ -567,7 +510,6 @@
     },
     {
         "BriefDescription": "BL Ring in Use; Up and Odd on VRing 1",
-        "Counter": "2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_C_RING_BL_USED.UP_VR1_ODD",
         "PerPkg": "1",
@@ -577,7 +519,6 @@
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.",
-        "Counter": "0,1",
         "EventCode": "0x5",
         "EventName": "UNC_C_RING_BOUNCES.AD_IRQ",
         "PerPkg": "1",
@@ -586,7 +527,6 @@
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Acknowledgements to core",
-        "Counter": "0,1",
         "EventCode": "0x5",
         "EventName": "UNC_C_RING_BOUNCES.AK",
         "PerPkg": "1",
@@ -595,7 +535,6 @@
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.: Acknowledgements to core",
-        "Counter": "0,1",
         "EventCode": "0x5",
         "EventName": "UNC_C_RING_BOUNCES.AK_CORE",
         "PerPkg": "1",
@@ -604,7 +543,6 @@
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Data Responses to core",
-        "Counter": "0,1",
         "EventCode": "0x5",
         "EventName": "UNC_C_RING_BOUNCES.BL",
         "PerPkg": "1",
@@ -613,7 +551,6 @@
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.: Data Responses to core",
-        "Counter": "0,1",
         "EventCode": "0x5",
         "EventName": "UNC_C_RING_BOUNCES.BL_CORE",
         "PerPkg": "1",
@@ -622,7 +559,6 @@
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Snoops of processor's cache.",
-        "Counter": "0,1",
         "EventCode": "0x5",
         "EventName": "UNC_C_RING_BOUNCES.IV",
         "PerPkg": "1",
@@ -631,7 +567,6 @@
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.: Snoops of processor's cache.",
-        "Counter": "0,1",
         "EventCode": "0x5",
         "EventName": "UNC_C_RING_BOUNCES.IV_CORE",
         "PerPkg": "1",
@@ -640,27 +575,24 @@
     },
     {
         "BriefDescription": "IV Ring in Use; Any",
-        "Counter": "2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_C_RING_IV_USED.ANY",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters any polarity",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "IV Ring in Use; Down",
-        "Counter": "2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_C_RING_IV_USED.DOWN",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for Down polarity",
-        "UMask": "0xCC",
+        "UMask": "0xcc",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "IV Ring in Use; Up",
-        "Counter": "2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_C_RING_IV_USED.UP",
         "PerPkg": "1",
@@ -668,9 +600,35 @@
         "UMask": "0x33",
         "Unit": "CBO"
     },
+    {
+        "EventCode": "0x6",
+        "EventName": "UNC_C_RING_SINK_STARVED.AD_IPQ",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "EventCode": "0x6",
+        "EventName": "UNC_C_RING_SINK_STARVED.AD_IRQ",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "EventCode": "0x6",
+        "EventName": "UNC_C_RING_SINK_STARVED.IV",
+        "PerPkg": "1",
+        "UMask": "0x10",
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
@@ -680,7 +638,6 @@
     },
     {
         "BriefDescription": "Ingress Arbiter Blocking Cycles; IPQ",
-        "Counter": "0,1",
         "EventCode": "0x12",
         "EventName": "UNC_C_RxR_EXT_STARVED.IRQ",
         "PerPkg": "1",
@@ -690,7 +647,6 @@
     },
     {
         "BriefDescription": "Ingress Arbiter Blocking Cycles; ISMQ_BID",
-        "Counter": "0,1",
         "EventCode": "0x12",
         "EventName": "UNC_C_RxR_EXT_STARVED.ISMQ_BIDS",
         "PerPkg": "1",
@@ -700,7 +656,6 @@
     },
     {
         "BriefDescription": "Ingress Arbiter Blocking Cycles",
-        "Counter": "0,1",
         "EventCode": "0x12",
         "EventName": "UNC_C_RxR_EXT_STARVED.PRQ",
         "PerPkg": "1",
@@ -710,7 +665,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; IPQ",
-        "Counter": "0,1",
         "EventCode": "0x13",
         "EventName": "UNC_C_RxR_INSERTS.IPQ",
         "PerPkg": "1",
@@ -720,7 +674,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; IRQ",
-        "Counter": "0,1",
         "EventCode": "0x13",
         "EventName": "UNC_C_RxR_INSERTS.IRQ",
         "PerPkg": "1",
@@ -730,7 +683,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; IRQ Rejected",
-        "Counter": "0,1",
         "EventCode": "0x13",
         "EventName": "UNC_C_RxR_INSERTS.IRQ_REJ",
         "PerPkg": "1",
@@ -740,7 +692,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations: IRQ Rejected",
-        "Counter": "0,1",
         "EventCode": "0x13",
         "EventName": "UNC_C_RxR_INSERTS.IRQ_REJECTED",
         "PerPkg": "1",
@@ -750,7 +701,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; VFIFO",
-        "Counter": "0,1",
         "EventCode": "0x13",
         "EventName": "UNC_C_RxR_INSERTS.VFIFO",
         "PerPkg": "1",
@@ -760,7 +710,6 @@
     },
     {
         "BriefDescription": "Ingress Internal Starvation Cycles; IPQ",
-        "Counter": "0,1",
         "EventCode": "0x14",
         "EventName": "UNC_C_RxR_INT_STARVED.IPQ",
         "PerPkg": "1",
@@ -770,7 +719,6 @@
     },
     {
         "BriefDescription": "Ingress Internal Starvation Cycles; IRQ",
-        "Counter": "0,1",
         "EventCode": "0x14",
         "EventName": "UNC_C_RxR_INT_STARVED.IRQ",
         "PerPkg": "1",
@@ -780,7 +728,6 @@
     },
     {
         "BriefDescription": "Ingress Internal Starvation Cycles; ISMQ",
-        "Counter": "0,1",
         "EventCode": "0x14",
         "EventName": "UNC_C_RxR_INT_STARVED.ISMQ",
         "PerPkg": "1",
@@ -790,7 +737,6 @@
     },
     {
         "BriefDescription": "Probe Queue Retries; Address Conflict",
-        "Counter": "0,1",
         "EventCode": "0x31",
         "EventName": "UNC_C_RxR_IPQ_RETRY.ADDR_CONFLICT",
         "PerPkg": "1",
@@ -800,7 +746,6 @@
     },
     {
         "BriefDescription": "Probe Queue Retries; Any Reject",
-        "Counter": "0,1",
         "EventCode": "0x31",
         "EventName": "UNC_C_RxR_IPQ_RETRY.ANY",
         "PerPkg": "1",
@@ -810,7 +755,6 @@
     },
     {
         "BriefDescription": "Probe Queue Retries; No Egress Credits",
-        "Counter": "0,1",
         "EventCode": "0x31",
         "EventName": "UNC_C_RxR_IPQ_RETRY.FULL",
         "PerPkg": "1",
@@ -820,7 +764,6 @@
     },
     {
         "BriefDescription": "Probe Queue Retries; No QPI Credits",
-        "Counter": "0,1",
         "EventCode": "0x31",
         "EventName": "UNC_C_RxR_IPQ_RETRY.QPI_CREDITS",
         "PerPkg": "1",
@@ -830,7 +773,6 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; Address Confli=
ct",
-        "Counter": "0,1",
         "EventCode": "0x32",
         "EventName": "UNC_C_RxR_IRQ_RETRY.ADDR_CONFLICT",
         "PerPkg": "1",
@@ -840,7 +782,6 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; Any Reject",
-        "Counter": "0,1",
         "EventCode": "0x32",
         "EventName": "UNC_C_RxR_IRQ_RETRY.ANY",
         "PerPkg": "1",
@@ -850,7 +791,6 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No Egress Cred=
its",
-        "Counter": "0,1",
         "EventCode": "0x32",
         "EventName": "UNC_C_RxR_IRQ_RETRY.FULL",
         "PerPkg": "1",
@@ -860,7 +800,6 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No IIO Credits=
",
-        "Counter": "0,1",
         "EventCode": "0x32",
         "EventName": "UNC_C_RxR_IRQ_RETRY.IIO_CREDITS",
         "PerPkg": "1",
@@ -870,7 +809,6 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No QPI Credits=
",
-        "Counter": "0,1",
         "EventCode": "0x32",
         "EventName": "UNC_C_RxR_IRQ_RETRY.QPI_CREDITS",
         "PerPkg": "1",
@@ -880,7 +818,6 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No RTIDs",
-        "Counter": "0,1",
         "EventCode": "0x32",
         "EventName": "UNC_C_RxR_IRQ_RETRY.RTID",
         "PerPkg": "1",
@@ -890,7 +827,6 @@
     },
     {
         "BriefDescription": "ISMQ Retries; Any Reject",
-        "Counter": "0,1",
         "EventCode": "0x33",
         "EventName": "UNC_C_RxR_ISMQ_RETRY.ANY",
         "PerPkg": "1",
@@ -900,7 +836,6 @@
     },
     {
         "BriefDescription": "ISMQ Retries; No Egress Credits",
-        "Counter": "0,1",
         "EventCode": "0x33",
         "EventName": "UNC_C_RxR_ISMQ_RETRY.FULL",
         "PerPkg": "1",
@@ -910,7 +845,6 @@
     },
     {
         "BriefDescription": "ISMQ Retries; No IIO Credits",
-        "Counter": "0,1",
         "EventCode": "0x33",
         "EventName": "UNC_C_RxR_ISMQ_RETRY.IIO_CREDITS",
         "PerPkg": "1",
@@ -920,7 +854,6 @@
     },
     {
         "BriefDescription": "ISMQ Retries; No QPI Credits",
-        "Counter": "0,1",
         "EventCode": "0x33",
         "EventName": "UNC_C_RxR_ISMQ_RETRY.QPI_CREDITS",
         "PerPkg": "1",
@@ -930,7 +863,6 @@
     },
     {
         "BriefDescription": "ISMQ Retries; No RTIDs",
-        "Counter": "0,1",
         "EventCode": "0x33",
         "EventName": "UNC_C_RxR_ISMQ_RETRY.RTID",
         "PerPkg": "1",
@@ -940,7 +872,6 @@
     },
     {
         "BriefDescription": "ISMQ Retries; No WB Credits",
-        "Counter": "0,1",
         "EventCode": "0x33",
         "EventName": "UNC_C_RxR_ISMQ_RETRY.WB_CREDITS",
         "PerPkg": "1",
@@ -995,7 +926,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; All",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.ALL",
         "PerPkg": "1",
@@ -1005,7 +935,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; Evictions",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.EVICTION",
         "PerPkg": "1",
@@ -1015,7 +944,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; Local Memory",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.LOCAL",
         "PerPkg": "1",
@@ -1025,7 +953,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; Local Memory - Opcode Matched",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.LOCAL_OPCODE",
         "PerPkg": "1",
@@ -1035,17 +962,15 @@
     },
     {
         "BriefDescription": "TOR Inserts; Misses to Local Memory",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_LOCAL",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that are satisfied by locally HOMed memory.",
-        "UMask": "0x2A",
+        "UMask": "0x2a",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "TOR Inserts; Misses to Local Memory - Opcode =
Matched",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE",
         "PerPkg": "1",
@@ -1055,7 +980,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; Miss Opcode Match",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
         "PerPkg": "1",
@@ -1065,17 +989,15 @@
     },
     {
         "BriefDescription": "TOR Inserts; Misses to Remote Memory",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_REMOTE",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that are satisfied by remote caches or remote memory.",
-        "UMask": "0x8A",
+        "UMask": "0x8a",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "TOR Inserts; Misses to Remote Memory - Opcode=
 Matched",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE",
         "PerPkg": "1",
@@ -1085,7 +1007,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; NID Matched",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_ALL",
         "PerPkg": "1",
@@ -1095,7 +1016,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; NID Matched Evictions",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_EVICTION",
         "PerPkg": "1",
@@ -1105,17 +1025,15 @@
     },
     {
         "BriefDescription": "TOR Inserts; NID Matched Miss All",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_MISS_ALL",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched miss req=
uests that were inserted into the TOR.",
-        "UMask": "0x4A",
+        "UMask": "0x4a",
         "Unit": "CBO"
     },
     {
         "BriefDescription": "TOR Inserts; NID and Opcode Matched Miss",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_MISS_OPCODE",
         "PerPkg": "1",
@@ -1125,7 +1043,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; NID and Opcode Matched",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_OPCODE",
         "PerPkg": "1",
@@ -1135,7 +1052,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; NID Matched Writebacks",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_WB",
         "PerPkg": "1",
@@ -1145,7 +1061,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; Opcode Match",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.OPCODE",
         "PerPkg": "1",
@@ -1155,7 +1070,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; Remote Memory",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.REMOTE",
         "PerPkg": "1",
@@ -1165,7 +1079,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; Remote Memory - Opcode Matched",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.REMOTE_OPCODE",
         "PerPkg": "1",
@@ -1175,7 +1088,6 @@
     },
     {
         "BriefDescription": "TOR Inserts; Writebacks",
-        "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.WB",
         "PerPkg": "1",
@@ -1225,7 +1137,7 @@
         "EventName": "UNC_C_TOR_OCCUPANCY.MISS_ALL",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding miss requests in the TOR.  'Miss' means the allocation requires a=
n RTID.  This generally means that the request was sent to memory or MMIO."=
,
-        "UMask": "0xA",
+        "UMask": "0xa",
         "Unit": "CBO"
     },
     {
@@ -1234,7 +1146,7 @@
         "EventName": "UNC_C_TOR_OCCUPANCY.MISS_LOCAL",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
-        "UMask": "0x2A",
+        "UMask": "0x2a",
         "Unit": "CBO"
     },
     {
@@ -1261,7 +1173,7 @@
         "EventName": "UNC_C_TOR_OCCUPANCY.MISS_REMOTE",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
-        "UMask": "0x8A",
+        "UMask": "0x8a",
         "Unit": "CBO"
     },
     {
@@ -1297,7 +1209,7 @@
         "EventName": "UNC_C_TOR_OCCUPANCY.NID_MISS_ALL",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss requests in the TOR that match a NID.",
-        "UMask": "0x4A",
+        "UMask": "0x4a",
         "Unit": "CBO"
     },
     {
@@ -1365,7 +1277,6 @@
     },
     {
         "BriefDescription": "Onto AD Ring",
-        "Counter": "0,1",
         "EventCode": "0x4",
         "EventName": "UNC_C_TxR_ADS_USED.AD",
         "PerPkg": "1",
@@ -1374,7 +1285,6 @@
     },
     {
         "BriefDescription": "Onto AK Ring",
-        "Counter": "0,1",
         "EventCode": "0x4",
         "EventName": "UNC_C_TxR_ADS_USED.AK",
         "PerPkg": "1",
@@ -1383,7 +1293,6 @@
     },
     {
         "BriefDescription": "Onto BL Ring",
-        "Counter": "0,1",
         "EventCode": "0x4",
         "EventName": "UNC_C_TxR_ADS_USED.BL",
         "PerPkg": "1",
@@ -1392,7 +1301,6 @@
     },
     {
         "BriefDescription": "Egress Allocations; AD - Cachebo",
-        "Counter": "0,1",
         "EventCode": "0x2",
         "EventName": "UNC_C_TxR_INSERTS.AD_CACHE",
         "PerPkg": "1",
@@ -1402,7 +1310,6 @@
     },
     {
         "BriefDescription": "Egress Allocations; AD - Corebo",
-        "Counter": "0,1",
         "EventCode": "0x2",
         "EventName": "UNC_C_TxR_INSERTS.AD_CORE",
         "PerPkg": "1",
@@ -1412,7 +1319,6 @@
     },
     {
         "BriefDescription": "Egress Allocations; AK - Cachebo",
-        "Counter": "0,1",
         "EventCode": "0x2",
         "EventName": "UNC_C_TxR_INSERTS.AK_CACHE",
         "PerPkg": "1",
@@ -1422,7 +1328,6 @@
     },
     {
         "BriefDescription": "Egress Allocations; AK - Corebo",
-        "Counter": "0,1",
         "EventCode": "0x2",
         "EventName": "UNC_C_TxR_INSERTS.AK_CORE",
         "PerPkg": "1",
@@ -1432,7 +1337,6 @@
     },
     {
         "BriefDescription": "Egress Allocations; BL - Cacheno",
-        "Counter": "0,1",
         "EventCode": "0x2",
         "EventName": "UNC_C_TxR_INSERTS.BL_CACHE",
         "PerPkg": "1",
@@ -1442,7 +1346,6 @@
     },
     {
         "BriefDescription": "Egress Allocations; BL - Corebo",
-        "Counter": "0,1",
         "EventCode": "0x2",
         "EventName": "UNC_C_TxR_INSERTS.BL_CORE",
         "PerPkg": "1",
@@ -1452,7 +1355,6 @@
     },
     {
         "BriefDescription": "Egress Allocations; IV - Cachebo",
-        "Counter": "0,1",
         "EventCode": "0x2",
         "EventName": "UNC_C_TxR_INSERTS.IV_CACHE",
         "PerPkg": "1",
@@ -1462,7 +1364,6 @@
     },
     {
         "BriefDescription": "Injection Starvation; Onto AD Ring (to core)"=
,
-        "Counter": "0,1",
         "EventCode": "0x3",
         "EventName": "UNC_C_TxR_STARVED.AD_CORE",
         "PerPkg": "1",
@@ -1472,7 +1373,6 @@
     },
     {
         "BriefDescription": "Injection Starvation; Onto AK Ring",
-        "Counter": "0,1",
         "EventCode": "0x3",
         "EventName": "UNC_C_TxR_STARVED.AK_BOTH",
         "PerPkg": "1",
@@ -1482,7 +1382,6 @@
     },
     {
         "BriefDescription": "Injection Starvation; Onto IV Ring",
-        "Counter": "0,1",
         "EventCode": "0x3",
         "EventName": "UNC_C_TxR_STARVED.IV",
         "PerPkg": "1",
@@ -1492,7 +1391,6 @@
     },
     {
         "BriefDescription": "BT Bypass",
-        "Counter": "0,1,2,3",
         "EventCode": "0x52",
         "EventName": "UNC_H_BT_BYPASS",
         "PerPkg": "1",
@@ -1501,7 +1399,6 @@
     },
     {
         "BriefDescription": "BT Cycles Not Empty",
-        "Counter": "0,1,2,3",
         "EventCode": "0x42",
         "EventName": "UNC_H_BT_CYCLES_NE",
         "PerPkg": "1",
@@ -1510,7 +1407,6 @@
     },
     {
         "BriefDescription": "BT Cycles Not Empty: Local",
-        "Counter": "0,1,2,3",
         "EventCode": "0x42",
         "EventName": "UNC_H_BT_CYCLES_NE.LOCAL",
         "PerPkg": "1",
@@ -1520,7 +1416,6 @@
     },
     {
         "BriefDescription": "BT Cycles Not Empty: Remote",
-        "Counter": "0,1,2,3",
         "EventCode": "0x42",
         "EventName": "UNC_H_BT_CYCLES_NE.REMOTE",
         "PerPkg": "1",
@@ -1530,7 +1425,6 @@
     },
     {
         "BriefDescription": "BT Occupancy; Local",
-        "Counter": "0,1,2,3",
         "EventCode": "0x43",
         "EventName": "UNC_H_BT_OCCUPANCY.LOCAL",
         "PerPkg": "1",
@@ -1540,7 +1434,6 @@
     },
     {
         "BriefDescription": "BT Occupancy; Reads Local",
-        "Counter": "0,1,2,3",
         "EventCode": "0x43",
         "EventName": "UNC_H_BT_OCCUPANCY.READS_LOCAL",
         "PerPkg": "1",
@@ -1550,7 +1443,6 @@
     },
     {
         "BriefDescription": "BT Occupancy; Reads Remote",
-        "Counter": "0,1,2,3",
         "EventCode": "0x43",
         "EventName": "UNC_H_BT_OCCUPANCY.READS_REMOTE",
         "PerPkg": "1",
@@ -1560,7 +1452,6 @@
     },
     {
         "BriefDescription": "BT Occupancy; Remote",
-        "Counter": "0,1,2,3",
         "EventCode": "0x43",
         "EventName": "UNC_H_BT_OCCUPANCY.REMOTE",
         "PerPkg": "1",
@@ -1570,7 +1461,6 @@
     },
     {
         "BriefDescription": "BT Occupancy; Writes Local",
-        "Counter": "0,1,2,3",
         "EventCode": "0x43",
         "EventName": "UNC_H_BT_OCCUPANCY.WRITES_LOCAL",
         "PerPkg": "1",
@@ -1580,7 +1470,6 @@
     },
     {
         "BriefDescription": "BT Occupancy; Writes Remote",
-        "Counter": "0,1,2,3",
         "EventCode": "0x43",
         "EventName": "UNC_H_BT_OCCUPANCY.WRITES_REMOTE",
         "PerPkg": "1",
@@ -1590,7 +1479,6 @@
     },
     {
         "BriefDescription": "BT to HT Not Issued; Incoming Data Hazard",
-        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "UNC_H_BT_TO_HT_NOT_ISSUED.INCOMING_BL_HAZARD",
         "PerPkg": "1",
@@ -1600,7 +1488,6 @@
     },
     {
         "BriefDescription": "BT to HT Not Issued; Incoming Snoop Hazard",
-        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "UNC_H_BT_TO_HT_NOT_ISSUED.INCOMING_SNP_HAZARD",
         "PerPkg": "1",
@@ -1610,7 +1497,6 @@
     },
     {
         "BriefDescription": "BT to HT Not Issued; Incoming Data Hazard",
-        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "UNC_H_BT_TO_HT_NOT_ISSUED.RSPACKCFLT_HAZARD",
         "PerPkg": "1",
@@ -1620,7 +1506,6 @@
     },
     {
         "BriefDescription": "BT to HT Not Issued; Incoming Data Hazard",
-        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "UNC_H_BT_TO_HT_NOT_ISSUED.WBMDATA_HAZARD",
         "PerPkg": "1",
@@ -1630,7 +1515,6 @@
     },
     {
         "BriefDescription": "HA to iMC Bypass; Not Taken",
-        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_H_BYPASS_IMC.NOT_TAKEN",
         "PerPkg": "1",
@@ -1640,7 +1524,6 @@
     },
     {
         "BriefDescription": "HA to iMC Bypass; Taken",
-        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_H_BYPASS_IMC.TAKEN",
         "PerPkg": "1",
@@ -1650,7 +1533,6 @@
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
@@ -1658,7 +1540,6 @@
     },
     {
         "BriefDescription": "Conflict Checks; Acknowledge Conflicts",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb",
         "EventName": "UNC_H_CONFLICT_CYCLES.ACKCNFLTS",
         "PerPkg": "1",
@@ -1668,7 +1549,6 @@
     },
     {
         "BriefDescription": "Conflict Checks; Cmp Fwds",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb",
         "EventName": "UNC_H_CONFLICT_CYCLES.CMP_FWDS",
         "PerPkg": "1",
@@ -1678,7 +1558,6 @@
     },
     {
         "BriefDescription": "Conflict Checks; Conflict Detected",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb",
         "EventName": "UNC_H_CONFLICT_CYCLES.CONFLICT",
         "PerPkg": "1",
@@ -1688,7 +1567,6 @@
     },
     {
         "BriefDescription": "Conflict Checks; Last in conflict chain",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb",
         "EventName": "UNC_H_CONFLICT_CYCLES.LAST",
         "PerPkg": "1",
@@ -1698,7 +1576,6 @@
     },
     {
         "BriefDescription": "Direct2Core Messages Sent",
-        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "UNC_H_DIRECT2CORE_COUNT",
         "PerPkg": "1",
@@ -1707,7 +1584,6 @@
     },
     {
         "BriefDescription": "Cycles when Direct2Core was Disabled",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "UNC_H_DIRECT2CORE_CYCLES_DISABLED",
         "PerPkg": "1",
@@ -1716,7 +1592,6 @@
     },
     {
         "BriefDescription": "Number of Reads that had Direct2Core Overridd=
en",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_H_DIRECT2CORE_TXN_OVERRIDE",
         "PerPkg": "1",
@@ -1725,7 +1600,6 @@
     },
     {
         "BriefDescription": "Directory Lat Opt Return",
-        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_H_DIRECTORY_LAT_OPT",
         "PerPkg": "1",
@@ -1734,7 +1608,6 @@
     },
     {
         "BriefDescription": "Directory Lookups: Any state",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc",
         "EventName": "UNC_H_DIRECTORY_LOOKUP.ANY",
         "PerPkg": "1",
@@ -1744,7 +1617,6 @@
     },
     {
         "BriefDescription": "Directory Lookups; Snoop Not Needed",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc",
         "EventName": "UNC_H_DIRECTORY_LOOKUP.NO_SNP",
         "PerPkg": "1",
@@ -1754,7 +1626,6 @@
     },
     {
         "BriefDescription": "Directory Lookups: Snoop A",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc",
         "EventName": "UNC_H_DIRECTORY_LOOKUP.SNOOP_A",
         "PerPkg": "1",
@@ -1764,7 +1635,6 @@
     },
     {
         "BriefDescription": "Directory Lookups: Snoop S",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc",
         "EventName": "UNC_H_DIRECTORY_LOOKUP.SNOOP_S",
         "PerPkg": "1",
@@ -1774,7 +1644,6 @@
     },
     {
         "BriefDescription": "Directory Lookups; Snoop Needed",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc",
         "EventName": "UNC_H_DIRECTORY_LOOKUP.SNP",
         "PerPkg": "1",
@@ -1784,7 +1653,6 @@
     },
     {
         "BriefDescription": "Directory Lookups: A State",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc",
         "EventName": "UNC_H_DIRECTORY_LOOKUP.STATE_A",
         "PerPkg": "1",
@@ -1794,7 +1662,6 @@
     },
     {
         "BriefDescription": "Directory Lookups: I State",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc",
         "EventName": "UNC_H_DIRECTORY_LOOKUP.STATE_I",
         "PerPkg": "1",
@@ -1804,7 +1671,6 @@
     },
     {
         "BriefDescription": "Directory Lookups: S State",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc",
         "EventName": "UNC_H_DIRECTORY_LOOKUP.STATE_S",
         "PerPkg": "1",
@@ -1814,7 +1680,6 @@
     },
     {
         "BriefDescription": "Directory Updates: A2I",
-        "Counter": "0,1,2,3",
         "EventCode": "0xd",
         "EventName": "UNC_H_DIRECTORY_UPDATE.A2I",
         "PerPkg": "1",
@@ -1824,7 +1689,6 @@
     },
     {
         "BriefDescription": "Directory Updates: A2S",
-        "Counter": "0,1,2,3",
         "EventCode": "0xd",
         "EventName": "UNC_H_DIRECTORY_UPDATE.A2S",
         "PerPkg": "1",
@@ -1834,7 +1698,6 @@
     },
     {
         "BriefDescription": "Directory Updates; Any Directory Update",
-        "Counter": "0,1,2,3",
         "EventCode": "0xd",
         "EventName": "UNC_H_DIRECTORY_UPDATE.ANY",
         "PerPkg": "1",
@@ -1844,7 +1707,6 @@
     },
     {
         "BriefDescription": "Directory Updates; Directory Clear",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD",
         "EventName": "UNC_H_DIRECTORY_UPDATE.CLEAR",
         "PerPkg": "1",
@@ -1854,7 +1716,6 @@
     },
     {
         "BriefDescription": "Directory Updates: I2A",
-        "Counter": "0,1,2,3",
         "EventCode": "0xd",
         "EventName": "UNC_H_DIRECTORY_UPDATE.I2A",
         "PerPkg": "1",
@@ -1864,7 +1725,6 @@
     },
     {
         "BriefDescription": "Directory Updates: I2S",
-        "Counter": "0,1,2,3",
         "EventCode": "0xd",
         "EventName": "UNC_H_DIRECTORY_UPDATE.I2S",
         "PerPkg": "1",
@@ -1874,7 +1734,6 @@
     },
     {
         "BriefDescription": "Directory Updates: S2A",
-        "Counter": "0,1,2,3",
         "EventCode": "0xd",
         "EventName": "UNC_H_DIRECTORY_UPDATE.S2A",
         "PerPkg": "1",
@@ -1884,7 +1743,6 @@
     },
     {
         "BriefDescription": "Directory Updates: S2I",
-        "Counter": "0,1,2,3",
         "EventCode": "0xd",
         "EventName": "UNC_H_DIRECTORY_UPDATE.S2I",
         "PerPkg": "1",
@@ -1894,7 +1752,6 @@
     },
     {
         "BriefDescription": "Directory Updates; Directory Set",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD",
         "EventName": "UNC_H_DIRECTORY_UPDATE.SET",
         "PerPkg": "1",
@@ -1904,7 +1761,6 @@
     },
     {
         "BriefDescription": "AD QPI Link 2 Credit Accumulator",
-        "Counter": "0,1,2,3",
         "EventCode": "0x59",
         "EventName": "UNC_H_IGR_AD_QPI2_ACCUMULATOR",
         "PerPkg": "1",
@@ -1913,7 +1769,6 @@
     },
     {
         "BriefDescription": "BL QPI Link 2 Credit Accumulator",
-        "Counter": "0,1,2,3",
         "EventCode": "0x5a",
         "EventName": "UNC_H_IGR_BL_QPI2_ACCUMULATOR",
         "PerPkg": "1",
@@ -1922,7 +1777,6 @@
     },
     {
         "BriefDescription": "AD QPI Link 2 Credit Accumulator",
-        "Counter": "0,1,2,3",
         "EventCode": "0x59",
         "EventName": "UNC_H_IGR_CREDITS_AD_QPI2",
         "PerPkg": "1",
@@ -1931,7 +1785,6 @@
     },
     {
         "BriefDescription": "BL QPI Link 2 Credit Accumulator",
-        "Counter": "0,1,2,3",
         "EventCode": "0x5A",
         "EventName": "UNC_H_IGR_CREDITS_BL_QPI2",
         "PerPkg": "1",
@@ -1940,7 +1793,6 @@
     },
     {
         "BriefDescription": "Cycles without QPI Ingress Credits; AD to QPI=
 Link 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_IGR_NO_CREDIT_CYCLES.AD_QPI0",
         "PerPkg": "1",
@@ -1950,7 +1802,6 @@
     },
     {
         "BriefDescription": "Cycles without QPI Ingress Credits; AD to QPI=
 Link 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_IGR_NO_CREDIT_CYCLES.AD_QPI1",
         "PerPkg": "1",
@@ -1960,7 +1811,6 @@
     },
     {
         "BriefDescription": "Cycles without QPI Ingress Credits; BL to QPI=
 Link 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_IGR_NO_CREDIT_CYCLES.BL_QPI0",
         "PerPkg": "1",
@@ -1970,7 +1820,6 @@
     },
     {
         "BriefDescription": "Cycles without QPI Ingress Credits; BL to QPI=
 Link 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_IGR_NO_CREDIT_CYCLES.BL_QPI1",
         "PerPkg": "1",
@@ -1980,7 +1829,6 @@
     },
     {
         "BriefDescription": "HA to iMC Normal Priority Reads Issued; Norma=
l Priority",
-        "Counter": "0,1,2,3",
         "EventCode": "0x17",
         "EventName": "UNC_H_IMC_READS.NORMAL",
         "PerPkg": "1",
@@ -1990,7 +1838,6 @@
     },
     {
         "BriefDescription": "Retry Events",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_H_IMC_RETRY",
         "PerPkg": "1",
@@ -1998,17 +1845,15 @@
     },
     {
         "BriefDescription": "HA to iMC Full Line Writes Issued; All Writes=
",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1a",
         "EventName": "UNC_H_IMC_WRITES.ALL",
         "PerPkg": "1",
         "PublicDescription": "Counts the total number of full line writes =
issued from the HA into the memory controller.  This counts for all four ch=
annels.  It can be filtered by full/partial and ISOCH/non-ISOCH.",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "HA"
     },
     {
         "BriefDescription": "HA to iMC Full Line Writes Issued; Full Line =
Non-ISOCH",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1a",
         "EventName": "UNC_H_IMC_WRITES.FULL",
         "PerPkg": "1",
@@ -2018,7 +1863,6 @@
     },
     {
         "BriefDescription": "HA to iMC Full Line Writes Issued; ISOCH Full=
 Line",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1a",
         "EventName": "UNC_H_IMC_WRITES.FULL_ISOCH",
         "PerPkg": "1",
@@ -2028,7 +1872,6 @@
     },
     {
         "BriefDescription": "HA to iMC Full Line Writes Issued; Partial No=
n-ISOCH",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1a",
         "EventName": "UNC_H_IMC_WRITES.PARTIAL",
         "PerPkg": "1",
@@ -2038,7 +1881,6 @@
     },
     {
         "BriefDescription": "HA to iMC Full Line Writes Issued; ISOCH Part=
ial",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1a",
         "EventName": "UNC_H_IMC_WRITES.PARTIAL_ISOCH",
         "PerPkg": "1",
@@ -2048,7 +1890,6 @@
     },
     {
         "BriefDescription": "IODC Conflicts; Any Conflict",
-        "Counter": "0,1,2,3",
         "EventCode": "0x57",
         "EventName": "UNC_H_IODC_CONFLICTS.ANY",
         "PerPkg": "1",
@@ -2057,7 +1898,6 @@
     },
     {
         "BriefDescription": "IODC Conflicts; Last Conflict",
-        "Counter": "0,1,2,3",
         "EventCode": "0x57",
         "EventName": "UNC_H_IODC_CONFLICTS.LAST",
         "PerPkg": "1",
@@ -2066,7 +1906,6 @@
     },
     {
         "BriefDescription": "IODC Conflicts: Remote InvItoE - Same RTID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x57",
         "EventName": "UNC_H_IODC_CONFLICTS.REMOTE_INVI2E_SAME_RTID",
         "PerPkg": "1",
@@ -2075,7 +1914,6 @@
     },
     {
         "BriefDescription": "IODC Conflicts: Remote (Other) - Same Addr",
-        "Counter": "0,1,2,3",
         "EventCode": "0x57",
         "EventName": "UNC_H_IODC_CONFLICTS.REMOTE_OTHER_SAME_ADDR",
         "PerPkg": "1",
@@ -2084,7 +1922,6 @@
     },
     {
         "BriefDescription": "IODC Inserts",
-        "Counter": "0,1,2,3",
         "EventCode": "0x56",
         "EventName": "UNC_H_IODC_INSERTS",
         "PerPkg": "1",
@@ -2093,7 +1930,6 @@
     },
     {
         "BriefDescription": "Num IODC 0 Length Writes",
-        "Counter": "0,1,2,3",
         "EventCode": "0x58",
         "EventName": "UNC_H_IODC_OLEN_WBMTOI",
         "PerPkg": "1",
@@ -2102,7 +1938,6 @@
     },
     {
         "BriefDescription": "OSB Snoop Broadcast; Local InvItoE",
-        "Counter": "0,1,2,3",
         "EventCode": "0x53",
         "EventName": "UNC_H_OSB.INVITOE_LOCAL",
         "PerPkg": "1",
@@ -2112,7 +1947,6 @@
     },
     {
         "BriefDescription": "OSB Snoop Broadcast; Local Reads",
-        "Counter": "0,1,2,3",
         "EventCode": "0x53",
         "EventName": "UNC_H_OSB.READS_LOCAL",
         "PerPkg": "1",
@@ -2122,7 +1956,6 @@
     },
     {
         "BriefDescription": "OSB Snoop Broadcast; Remote",
-        "Counter": "0,1,2,3",
         "EventCode": "0x53",
         "EventName": "UNC_H_OSB.REMOTE",
         "PerPkg": "1",
@@ -2132,7 +1965,6 @@
     },
     {
         "BriefDescription": "OSB Early Data Return; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "UNC_H_OSB_EDR.ALL",
         "PerPkg": "1",
@@ -2142,7 +1974,6 @@
     },
     {
         "BriefDescription": "OSB Early Data Return; Reads to Local  I",
-        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "UNC_H_OSB_EDR.READS_LOCAL_I",
         "PerPkg": "1",
@@ -2152,7 +1983,6 @@
     },
     {
         "BriefDescription": "OSB Early Data Return; Reads to Local S",
-        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "UNC_H_OSB_EDR.READS_LOCAL_S",
         "PerPkg": "1",
@@ -2162,7 +1992,6 @@
     },
     {
         "BriefDescription": "OSB Early Data Return; Reads to Remote I",
-        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "UNC_H_OSB_EDR.READS_REMOTE_I",
         "PerPkg": "1",
@@ -2172,7 +2001,6 @@
     },
     {
         "BriefDescription": "OSB Early Data Return; Reads to Remote S",
-        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "UNC_H_OSB_EDR.READS_REMOTE_S",
         "PerPkg": "1",
@@ -2182,7 +2010,6 @@
     },
     {
         "BriefDescription": "Read and Write Requests; Local InvItoEs",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.INVITOE_LOCAL",
         "PerPkg": "1",
@@ -2192,7 +2019,6 @@
     },
     {
         "BriefDescription": "Read and Write Requests; Remote InvItoEs",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.INVITOE_REMOTE",
         "PerPkg": "1",
@@ -2202,7 +2028,6 @@
     },
     {
         "BriefDescription": "Read and Write Requests; Reads",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.READS",
         "PerPkg": "1",
@@ -2212,7 +2037,6 @@
     },
     {
         "BriefDescription": "Read and Write Requests; Local Reads",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.READS_LOCAL",
         "PerPkg": "1",
@@ -2222,7 +2046,6 @@
     },
     {
         "BriefDescription": "Read and Write Requests; Remote Reads",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.READS_REMOTE",
         "PerPkg": "1",
@@ -2232,17 +2055,15 @@
     },
     {
         "BriefDescription": "Read and Write Requests; Writes",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.WRITES",
         "PerPkg": "1",
         "PublicDescription": "Counts the total number of read requests mad=
e into the Home Agent. Reads include all read opcodes (including RFO).  Wri=
tes include all writes (streaming, evictions, HitM, etc).; Incoming write r=
equests.",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "HA"
     },
     {
         "BriefDescription": "Read and Write Requests; Local Writes",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.WRITES_LOCAL",
         "PerPkg": "1",
@@ -2252,7 +2073,6 @@
     },
     {
         "BriefDescription": "Read and Write Requests; Remote Writes",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.WRITES_REMOTE",
         "PerPkg": "1",
@@ -2262,17 +2082,15 @@
     },
     {
         "BriefDescription": "HA AD Ring in Use; Counterclockwise",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3E",
         "EventName": "UNC_H_RING_AD_USED.CCW",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xCC",
+        "UMask": "0xcc",
         "Unit": "HA"
     },
     {
         "BriefDescription": "HA AD Ring in Use; Counterclockwise and Even =
on VRing 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3e",
         "EventName": "UNC_H_RING_AD_USED.CCW_VR0_EVEN",
         "PerPkg": "1",
@@ -2282,7 +2100,6 @@
     },
     {
         "BriefDescription": "HA AD Ring in Use; Counterclockwise and Odd o=
n VRing 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3e",
         "EventName": "UNC_H_RING_AD_USED.CCW_VR0_ODD",
         "PerPkg": "1",
@@ -2292,7 +2109,6 @@
     },
     {
         "BriefDescription": "HA AD Ring in Use; Counterclockwise and Even =
on VRing 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3e",
         "EventName": "UNC_H_RING_AD_USED.CCW_VR1_EVEN",
         "PerPkg": "1",
@@ -2302,7 +2118,6 @@
     },
     {
         "BriefDescription": "HA AD Ring in Use; Counterclockwise and Odd o=
n VRing 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3e",
         "EventName": "UNC_H_RING_AD_USED.CCW_VR1_ODD",
         "PerPkg": "1",
@@ -2312,7 +2127,6 @@
     },
     {
         "BriefDescription": "HA AD Ring in Use; Clockwise",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3E",
         "EventName": "UNC_H_RING_AD_USED.CW",
         "PerPkg": "1",
@@ -2322,7 +2136,6 @@
     },
     {
         "BriefDescription": "HA AD Ring in Use; Clockwise and Even on VRin=
g 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3e",
         "EventName": "UNC_H_RING_AD_USED.CW_VR0_EVEN",
         "PerPkg": "1",
@@ -2332,7 +2145,6 @@
     },
     {
         "BriefDescription": "HA AD Ring in Use; Clockwise and Odd on VRing=
 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3e",
         "EventName": "UNC_H_RING_AD_USED.CW_VR0_ODD",
         "PerPkg": "1",
@@ -2342,7 +2154,6 @@
     },
     {
         "BriefDescription": "HA AD Ring in Use; Clockwise and Even on VRin=
g 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3e",
         "EventName": "UNC_H_RING_AD_USED.CW_VR1_EVEN",
         "PerPkg": "1",
@@ -2352,7 +2163,6 @@
     },
     {
         "BriefDescription": "HA AD Ring in Use; Clockwise and Odd on VRing=
 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3e",
         "EventName": "UNC_H_RING_AD_USED.CW_VR1_ODD",
         "PerPkg": "1",
@@ -2362,17 +2172,15 @@
     },
     {
         "BriefDescription": "HA AK Ring in Use; Counterclockwise",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3F",
         "EventName": "UNC_H_RING_AK_USED.CCW",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xCC",
+        "UMask": "0xcc",
         "Unit": "HA"
     },
     {
         "BriefDescription": "HA AK Ring in Use; Counterclockwise and Even =
on VRing 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3f",
         "EventName": "UNC_H_RING_AK_USED.CCW_VR0_EVEN",
         "PerPkg": "1",
@@ -2382,7 +2190,6 @@
     },
     {
         "BriefDescription": "HA AK Ring in Use; Counterclockwise and Odd o=
n VRing 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3f",
         "EventName": "UNC_H_RING_AK_USED.CCW_VR0_ODD",
         "PerPkg": "1",
@@ -2392,7 +2199,6 @@
     },
     {
         "BriefDescription": "HA AK Ring in Use; Counterclockwise and Even =
on VRing 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3f",
         "EventName": "UNC_H_RING_AK_USED.CCW_VR1_EVEN",
         "PerPkg": "1",
@@ -2402,7 +2208,6 @@
     },
     {
         "BriefDescription": "HA AK Ring in Use; Counterclockwise and Odd o=
n VRing 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3f",
         "EventName": "UNC_H_RING_AK_USED.CCW_VR1_ODD",
         "PerPkg": "1",
@@ -2412,7 +2217,6 @@
     },
     {
         "BriefDescription": "HA AK Ring in Use; Clockwise",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3F",
         "EventName": "UNC_H_RING_AK_USED.CW",
         "PerPkg": "1",
@@ -2422,7 +2226,6 @@
     },
     {
         "BriefDescription": "HA AK Ring in Use; Clockwise and Even on VRin=
g 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3f",
         "EventName": "UNC_H_RING_AK_USED.CW_VR0_EVEN",
         "PerPkg": "1",
@@ -2432,7 +2235,6 @@
     },
     {
         "BriefDescription": "HA AK Ring in Use; Clockwise and Odd on VRing=
 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3f",
         "EventName": "UNC_H_RING_AK_USED.CW_VR0_ODD",
         "PerPkg": "1",
@@ -2442,7 +2244,6 @@
     },
     {
         "BriefDescription": "HA AK Ring in Use; Clockwise and Even on VRin=
g 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3f",
         "EventName": "UNC_H_RING_AK_USED.CW_VR1_EVEN",
         "PerPkg": "1",
@@ -2452,7 +2253,6 @@
     },
     {
         "BriefDescription": "HA AK Ring in Use; Clockwise and Odd on VRing=
 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3f",
         "EventName": "UNC_H_RING_AK_USED.CW_VR1_ODD",
         "PerPkg": "1",
@@ -2462,17 +2262,15 @@
     },
     {
         "BriefDescription": "HA BL Ring in Use; Counterclockwise",
-        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_H_RING_BL_USED.CCW",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xCC",
+        "UMask": "0xcc",
         "Unit": "HA"
     },
     {
         "BriefDescription": "HA BL Ring in Use; Counterclockwise and Even =
on VRing 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_H_RING_BL_USED.CCW_VR0_EVEN",
         "PerPkg": "1",
@@ -2482,7 +2280,6 @@
     },
     {
         "BriefDescription": "HA BL Ring in Use; Counterclockwise and Odd o=
n VRing 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_H_RING_BL_USED.CCW_VR0_ODD",
         "PerPkg": "1",
@@ -2492,7 +2289,6 @@
     },
     {
         "BriefDescription": "HA BL Ring in Use; Counterclockwise and Even =
on VRing 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_H_RING_BL_USED.CCW_VR1_EVEN",
         "PerPkg": "1",
@@ -2502,7 +2298,6 @@
     },
     {
         "BriefDescription": "HA BL Ring in Use; Counterclockwise and Odd o=
n VRing 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_H_RING_BL_USED.CCW_VR1_ODD",
         "PerPkg": "1",
@@ -2512,7 +2307,6 @@
     },
     {
         "BriefDescription": "HA BL Ring in Use; Clockwise",
-        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_H_RING_BL_USED.CW",
         "PerPkg": "1",
@@ -2522,7 +2316,6 @@
     },
     {
         "BriefDescription": "HA BL Ring in Use; Clockwise and Even on VRin=
g 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_H_RING_BL_USED.CW_VR0_EVEN",
         "PerPkg": "1",
@@ -2532,7 +2325,6 @@
     },
     {
         "BriefDescription": "HA BL Ring in Use; Clockwise and Odd on VRing=
 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_H_RING_BL_USED.CW_VR0_ODD",
         "PerPkg": "1",
@@ -2542,7 +2334,6 @@
     },
     {
         "BriefDescription": "HA BL Ring in Use; Clockwise and Even on VRin=
g 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_H_RING_BL_USED.CW_VR1_EVEN",
         "PerPkg": "1",
@@ -2552,7 +2343,6 @@
     },
     {
         "BriefDescription": "HA BL Ring in Use; Clockwise and Odd on VRing=
 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_H_RING_BL_USED.CW_VR1_ODD",
         "PerPkg": "1",
@@ -2562,7 +2352,6 @@
     },
     {
         "BriefDescription": "iMC RPQ Credits Empty - Regular; Channel 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN0",
         "PerPkg": "1",
@@ -2572,7 +2361,6 @@
     },
     {
         "BriefDescription": "iMC RPQ Credits Empty - Regular; Channel 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN1",
         "PerPkg": "1",
@@ -2582,7 +2370,6 @@
     },
     {
         "BriefDescription": "iMC RPQ Credits Empty - Regular; Channel 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN2",
         "PerPkg": "1",
@@ -2592,7 +2379,6 @@
     },
     {
         "BriefDescription": "iMC RPQ Credits Empty - Regular; Channel 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN3",
         "PerPkg": "1",
@@ -2602,7 +2388,6 @@
     },
     {
         "BriefDescription": "iMC RPQ Credits Empty - Special; Channel 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x16",
         "EventName": "UNC_H_RPQ_CYCLES_NO_SPEC_CREDITS.CHN0",
         "PerPkg": "1",
@@ -2612,7 +2397,6 @@
     },
     {
         "BriefDescription": "iMC RPQ Credits Empty - Special; Channel 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x16",
         "EventName": "UNC_H_RPQ_CYCLES_NO_SPEC_CREDITS.CHN1",
         "PerPkg": "1",
@@ -2622,7 +2406,6 @@
     },
     {
         "BriefDescription": "iMC RPQ Credits Empty - Special; Channel 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x16",
         "EventName": "UNC_H_RPQ_CYCLES_NO_SPEC_CREDITS.CHN2",
         "PerPkg": "1",
@@ -2632,7 +2415,6 @@
     },
     {
         "BriefDescription": "iMC RPQ Credits Empty - Special; Channel 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x16",
         "EventName": "UNC_H_RPQ_CYCLES_NO_SPEC_CREDITS.CHN3",
         "PerPkg": "1",
@@ -2642,7 +2424,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received; RSPCNFLCT*",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSPCNFLCT",
         "PerPkg": "1",
@@ -2652,7 +2433,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received; RspI",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSPI",
         "PerPkg": "1",
@@ -2662,7 +2442,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received; RspIFwd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSPIFWD",
         "PerPkg": "1",
@@ -2672,7 +2451,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received; RspS",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSPS",
         "PerPkg": "1",
@@ -2682,7 +2460,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received; RspSFwd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSPSFWD",
         "PerPkg": "1",
@@ -2692,7 +2469,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received; Rsp*Fwd*WB",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSP_FWD_WB",
         "PerPkg": "1",
@@ -2702,7 +2478,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received; Rsp*WB",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSP_WB",
         "PerPkg": "1",
@@ -2712,7 +2487,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received Local; Other",
-        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.OTHER",
         "PerPkg": "1",
@@ -2722,7 +2496,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received Local; RspCnflct",
-        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPCNFLCT",
         "PerPkg": "1",
@@ -2732,7 +2505,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received Local; RspI",
-        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPI",
         "PerPkg": "1",
@@ -2742,7 +2514,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received Local; RspIFwd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPIFWD",
         "PerPkg": "1",
@@ -2752,7 +2523,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received Local; RspS",
-        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPS",
         "PerPkg": "1",
@@ -2762,7 +2532,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received Local; RspSFwd",
-        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPSFWD",
         "PerPkg": "1",
@@ -2772,7 +2541,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received Local; Rsp*FWD*WB",
-        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPxFWDxWB",
         "PerPkg": "1",
@@ -2782,7 +2550,6 @@
     },
     {
         "BriefDescription": "Snoop Responses Received Local; Rsp*WB",
-        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPxWB",
         "PerPkg": "1",
@@ -2792,7 +2559,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_H_TAD_REQUESTS_G0.REGION0",
         "PerPkg": "1",
@@ -2802,7 +2568,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_H_TAD_REQUESTS_G0.REGION1",
         "PerPkg": "1",
@@ -2812,7 +2577,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_H_TAD_REQUESTS_G0.REGION2",
         "PerPkg": "1",
@@ -2822,7 +2586,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_H_TAD_REQUESTS_G0.REGION3",
         "PerPkg": "1",
@@ -2832,7 +2595,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_H_TAD_REQUESTS_G0.REGION4",
         "PerPkg": "1",
@@ -2842,7 +2604,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_H_TAD_REQUESTS_G0.REGION5",
         "PerPkg": "1",
@@ -2852,7 +2613,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_H_TAD_REQUESTS_G0.REGION6",
         "PerPkg": "1",
@@ -2862,7 +2622,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_H_TAD_REQUESTS_G0.REGION7",
         "PerPkg": "1",
@@ -2872,7 +2631,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 1; TAD Re=
gion 10",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1c",
         "EventName": "UNC_H_TAD_REQUESTS_G1.REGION10",
         "PerPkg": "1",
@@ -2882,7 +2640,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 1; TAD Re=
gion 11",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1c",
         "EventName": "UNC_H_TAD_REQUESTS_G1.REGION11",
         "PerPkg": "1",
@@ -2892,7 +2649,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 1; TAD Re=
gion 8",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1c",
         "EventName": "UNC_H_TAD_REQUESTS_G1.REGION8",
         "PerPkg": "1",
@@ -2902,7 +2658,6 @@
     },
     {
         "BriefDescription": "HA Requests to a TAD Region - Group 1; TAD Re=
gion 9",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1c",
         "EventName": "UNC_H_TAD_REQUESTS_G1.REGION9",
         "PerPkg": "1",
@@ -2912,7 +2667,6 @@
     },
     {
         "BriefDescription": "Tracker Cycles Not Empty",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3",
         "EventName": "UNC_H_TRACKER_CYCLES_NE",
         "PerPkg": "1",
@@ -2921,7 +2675,6 @@
     },
     {
         "BriefDescription": "Outbound NDR Ring Transactions; Non-data Resp=
onses",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF",
         "EventName": "UNC_H_TxR_AD.HOM",
         "PerPkg": "1",
@@ -2931,7 +2684,6 @@
     },
     {
         "BriefDescription": "AD Egress Full; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2a",
         "EventName": "UNC_H_TxR_AD_CYCLES_FULL.ALL",
         "PerPkg": "1",
@@ -2941,7 +2693,6 @@
     },
     {
         "BriefDescription": "AD Egress Full; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2a",
         "EventName": "UNC_H_TxR_AD_CYCLES_FULL.SCHED0",
         "PerPkg": "1",
@@ -2951,7 +2702,6 @@
     },
     {
         "BriefDescription": "AD Egress Full; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2a",
         "EventName": "UNC_H_TxR_AD_CYCLES_FULL.SCHED1",
         "PerPkg": "1",
@@ -2961,7 +2711,6 @@
     },
     {
         "BriefDescription": "AD Egress Not Empty; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_H_TxR_AD_CYCLES_NE.ALL",
         "PerPkg": "1",
@@ -2971,7 +2720,6 @@
     },
     {
         "BriefDescription": "AD Egress Not Empty; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_H_TxR_AD_CYCLES_NE.SCHED0",
         "PerPkg": "1",
@@ -2981,7 +2729,6 @@
     },
     {
         "BriefDescription": "AD Egress Not Empty; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_H_TxR_AD_CYCLES_NE.SCHED1",
         "PerPkg": "1",
@@ -2991,7 +2738,6 @@
     },
     {
         "BriefDescription": "AD Egress Allocations; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_H_TxR_AD_INSERTS.ALL",
         "PerPkg": "1",
@@ -3001,7 +2747,6 @@
     },
     {
         "BriefDescription": "AD Egress Allocations; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_H_TxR_AD_INSERTS.SCHED0",
         "PerPkg": "1",
@@ -3011,7 +2756,6 @@
     },
     {
         "BriefDescription": "AD Egress Allocations; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_H_TxR_AD_INSERTS.SCHED1",
         "PerPkg": "1",
@@ -3021,7 +2765,6 @@
     },
     {
         "BriefDescription": "AD Egress Occupancy; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_H_TxR_AD_OCCUPANCY.SCHED0",
         "PerPkg": "1",
@@ -3031,7 +2774,6 @@
     },
     {
         "BriefDescription": "AD Egress Occupancy; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_H_TxR_AD_OCCUPANCY.SCHED1",
         "PerPkg": "1",
@@ -3041,7 +2783,6 @@
     },
     {
         "BriefDescription": "Outbound Ring Transactions on AK: CRD Transac=
tions to Cbo",
-        "Counter": "0,1,2,3",
         "EventCode": "0xe",
         "EventName": "UNC_H_TxR_AK.CRD_CBO",
         "PerPkg": "1",
@@ -3050,7 +2791,6 @@
     },
     {
         "BriefDescription": "AK Egress Full; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_H_TxR_AK_CYCLES_FULL.ALL",
         "PerPkg": "1",
@@ -3060,7 +2800,6 @@
     },
     {
         "BriefDescription": "AK Egress Full; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_H_TxR_AK_CYCLES_FULL.SCHED0",
         "PerPkg": "1",
@@ -3070,7 +2809,6 @@
     },
     {
         "BriefDescription": "AK Egress Full; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_H_TxR_AK_CYCLES_FULL.SCHED1",
         "PerPkg": "1",
@@ -3080,7 +2818,6 @@
     },
     {
         "BriefDescription": "AK Egress Not Empty; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "UNC_H_TxR_AK_CYCLES_NE.ALL",
         "PerPkg": "1",
@@ -3090,7 +2827,6 @@
     },
     {
         "BriefDescription": "AK Egress Not Empty; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "UNC_H_TxR_AK_CYCLES_NE.SCHED0",
         "PerPkg": "1",
@@ -3100,7 +2836,6 @@
     },
     {
         "BriefDescription": "AK Egress Not Empty; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "UNC_H_TxR_AK_CYCLES_NE.SCHED1",
         "PerPkg": "1",
@@ -3110,7 +2845,6 @@
     },
     {
         "BriefDescription": "AK Egress Allocations; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2f",
         "EventName": "UNC_H_TxR_AK_INSERTS.ALL",
         "PerPkg": "1",
@@ -3120,7 +2854,6 @@
     },
     {
         "BriefDescription": "AK Egress Allocations; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2f",
         "EventName": "UNC_H_TxR_AK_INSERTS.SCHED0",
         "PerPkg": "1",
@@ -3130,7 +2863,6 @@
     },
     {
         "BriefDescription": "AK Egress Allocations; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2f",
         "EventName": "UNC_H_TxR_AK_INSERTS.SCHED1",
         "PerPkg": "1",
@@ -3140,7 +2872,6 @@
     },
     {
         "BriefDescription": "AK Egress Occupancy; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x30",
         "EventName": "UNC_H_TxR_AK_OCCUPANCY.SCHED0",
         "PerPkg": "1",
@@ -3150,7 +2881,6 @@
     },
     {
         "BriefDescription": "AK Egress Occupancy; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x30",
         "EventName": "UNC_H_TxR_AK_OCCUPANCY.SCHED1",
         "PerPkg": "1",
@@ -3160,7 +2890,6 @@
     },
     {
         "BriefDescription": "Outbound DRS Ring Transactions to Cache; Data=
 to Cache",
-        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_H_TxR_BL.DRS_CACHE",
         "PerPkg": "1",
@@ -3170,7 +2899,6 @@
     },
     {
         "BriefDescription": "Outbound DRS Ring Transactions to Cache; Data=
 to Core",
-        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_H_TxR_BL.DRS_CORE",
         "PerPkg": "1",
@@ -3180,7 +2908,6 @@
     },
     {
         "BriefDescription": "Outbound DRS Ring Transactions to Cache; Data=
 to QPI",
-        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_H_TxR_BL.DRS_QPI",
         "PerPkg": "1",
@@ -3190,7 +2917,6 @@
     },
     {
         "BriefDescription": "BL Egress Full; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x36",
         "EventName": "UNC_H_TxR_BL_CYCLES_FULL.ALL",
         "PerPkg": "1",
@@ -3200,7 +2926,6 @@
     },
     {
         "BriefDescription": "BL Egress Full; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x36",
         "EventName": "UNC_H_TxR_BL_CYCLES_FULL.SCHED0",
         "PerPkg": "1",
@@ -3210,7 +2935,6 @@
     },
     {
         "BriefDescription": "BL Egress Full; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x36",
         "EventName": "UNC_H_TxR_BL_CYCLES_FULL.SCHED1",
         "PerPkg": "1",
@@ -3220,7 +2944,6 @@
     },
     {
         "BriefDescription": "BL Egress Not Empty; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_H_TxR_BL_CYCLES_NE.ALL",
         "PerPkg": "1",
@@ -3230,7 +2953,6 @@
     },
     {
         "BriefDescription": "BL Egress Not Empty; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_H_TxR_BL_CYCLES_NE.SCHED0",
         "PerPkg": "1",
@@ -3240,7 +2962,6 @@
     },
     {
         "BriefDescription": "BL Egress Not Empty; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_H_TxR_BL_CYCLES_NE.SCHED1",
         "PerPkg": "1",
@@ -3250,7 +2971,6 @@
     },
     {
         "BriefDescription": "BL Egress Allocations; All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_H_TxR_BL_INSERTS.ALL",
         "PerPkg": "1",
@@ -3260,7 +2980,6 @@
     },
     {
         "BriefDescription": "BL Egress Allocations; Scheduler 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_H_TxR_BL_INSERTS.SCHED0",
         "PerPkg": "1",
@@ -3270,7 +2989,6 @@
     },
     {
         "BriefDescription": "BL Egress Allocations; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_H_TxR_BL_INSERTS.SCHED1",
         "PerPkg": "1",
@@ -3280,17 +2998,14 @@
     },
     {
         "BriefDescription": "BL Egress Occupancy: All",
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
@@ -3300,7 +3015,6 @@
     },
     {
         "BriefDescription": "BL Egress Occupancy; Scheduler 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_H_TxR_BL_OCCUPANCY.SCHED1",
         "PerPkg": "1",
@@ -3310,7 +3024,6 @@
     },
     {
         "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Regular; Chan=
nel 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_H_WPQ_CYCLES_NO_REG_CREDITS.CHN0",
         "PerPkg": "1",
@@ -3320,7 +3033,6 @@
     },
     {
         "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Regular; Chan=
nel 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_H_WPQ_CYCLES_NO_REG_CREDITS.CHN1",
         "PerPkg": "1",
@@ -3330,7 +3042,6 @@
     },
     {
         "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Regular; Chan=
nel 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_H_WPQ_CYCLES_NO_REG_CREDITS.CHN2",
         "PerPkg": "1",
@@ -3340,7 +3051,6 @@
     },
     {
         "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Regular; Chan=
nel 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_H_WPQ_CYCLES_NO_REG_CREDITS.CHN3",
         "PerPkg": "1",
@@ -3350,7 +3060,6 @@
     },
     {
         "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Special; Chan=
nel 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_H_WPQ_CYCLES_NO_SPEC_CREDITS.CHN0",
         "PerPkg": "1",
@@ -3360,7 +3069,6 @@
     },
     {
         "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Special; Chan=
nel 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_H_WPQ_CYCLES_NO_SPEC_CREDITS.CHN1",
         "PerPkg": "1",
@@ -3370,7 +3078,6 @@
     },
     {
         "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Special; Chan=
nel 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_H_WPQ_CYCLES_NO_SPEC_CREDITS.CHN2",
         "PerPkg": "1",
@@ -3380,7 +3087,6 @@
     },
     {
         "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Special; Chan=
nel 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_H_WPQ_CYCLES_NO_SPEC_CREDITS.CHN3",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.jso=
n b/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
index 10ea4afeffc1..e1b9799e3036 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
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
s and RBT Miss",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_MISS",
         "PerPkg": "1",
@@ -40,7 +35,6 @@
     },
     {
         "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egres=
s and RBT Invalid",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_RBT",
         "PerPkg": "1",
@@ -50,7 +44,6 @@
     },
     {
         "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egres=
s and RBT Miss, Invalid",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_RBT_MISS",
         "PerPkg": "1",
@@ -60,7 +53,6 @@
     },
     {
         "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - RBT M=
iss",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_MISS",
         "PerPkg": "1",
@@ -70,7 +62,6 @@
     },
     {
         "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - RBT I=
nvalid",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_RBT_HIT",
         "PerPkg": "1",
@@ -80,7 +71,6 @@
     },
     {
         "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - RBT M=
iss and Invalid",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_RBT_MISS",
         "PerPkg": "1",
@@ -90,7 +80,6 @@
     },
     {
         "BriefDescription": "Direct 2 Core Spawning; Spawn Success",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.SUCCESS_RBT_HIT",
         "PerPkg": "1",
@@ -100,16 +89,212 @@
     },
     {
         "BriefDescription": "Cycles in L1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "UNC_Q_L1_POWER_CYCLES",
         "PerPkg": "1",
         "PublicDescription": "Number of QPI qfclk cycles spent in L1 power=
 mode.  L1 is a mode that totally shuts down a QPI link.  Use edge detect t=
o count the number of instances when the QPI link entered L1.  Link power s=
tates are per link and per direction, so for example the Tx direction could=
 be in one state while Rx was in another. Because L1 totally shuts down the=
 link, it takes a good amount of time to exit this mode.",
         "Unit": "QPI LL"
     },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MATCH_MASK",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.DRS.AnyDataC",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.DRS.AnyResp",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.DRS.AnyResp11flits",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.DRS.AnyResp9flits",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.DRS.DataC_E",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.DRS.DataC_E_Cmp",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.DRS.DataC_E_FrcAckCnflt",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.DRS.DataC_F",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.DRS.DataC_F_Cmp",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.DRS.DataC_F_FrcAckCnflt",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.DRS.DataC_M",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.DRS.WbEData",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.DRS.WbIData",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.DRS.WbSData",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.HOM.AnyReq",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.HOM.AnyResp",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.HOM.RespFwd",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.HOM.RespFwdI",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.HOM.RespFwdIWb",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.HOM.RespFwdS",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.HOM.RespFwdSWb",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.HOM.RespIWb",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.HOM.RespSWb",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.NCB.AnyInt",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.NCB.AnyMsg",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.NCB.AnyMsg11flits",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.NCB.AnyMsg9flits",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.NCS.AnyMsg1or2flits",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.NCS.AnyMsg3flits",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.NCS.NcRd",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.NDR.AnyCmp",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_MESSAGE.SNP.AnySnp",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
     {
         "BriefDescription": "Cycles in L0p",
-        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_Q_RxL0P_POWER_CYCLES",
         "PerPkg": "1",
@@ -118,7 +303,6 @@
     },
     {
         "BriefDescription": "Cycles in L0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xf",
         "EventName": "UNC_Q_RxL0_POWER_CYCLES",
         "PerPkg": "1",
@@ -127,7 +311,6 @@
     },
     {
         "BriefDescription": "Rx Flit Buffer Bypassed",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_Q_RxL_BYPASSED",
         "PerPkg": "1",
@@ -136,7 +319,6 @@
     },
     {
         "BriefDescription": "CRC Errors Detected; LinkInit",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3",
         "EventName": "UNC_Q_RxL_CRC_ERRORS.LINK_INIT",
         "PerPkg": "1",
@@ -146,7 +328,6 @@
     },
     {
         "BriefDescription": "CRC Errors Detected; Normal Operations",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3",
         "EventName": "UNC_Q_RxL_CRC_ERRORS.NORMAL_OP",
         "PerPkg": "1",
@@ -156,10 +337,8 @@
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
; VN0 credit for the DRS message class.",
         "UMask": "0x1",
@@ -167,10 +346,8 @@
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
; VN0 credit for the HOM message class.",
         "UMask": "0x8",
@@ -178,10 +355,8 @@
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
; VN0 credit for the NCB message class.",
         "UMask": "0x2",
@@ -189,10 +364,8 @@
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
; VN0 credit for the NCS message class.",
         "UMask": "0x4",
@@ -200,10 +373,8 @@
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
; VN0 credit for the NDR message class.",
         "UMask": "0x20",
@@ -211,10 +382,8 @@
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
; VN0 credit for the SNP message class.",
         "UMask": "0x10",
@@ -222,10 +391,8 @@
     },
     {
         "BriefDescription": "VN1 Credit Consumed; DRS",
-        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.DRS",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the DRS message class.",
         "UMask": "0x1",
@@ -233,10 +400,8 @@
     },
     {
         "BriefDescription": "VN1 Credit Consumed; HOM",
-        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.HOM",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the HOM message class.",
         "UMask": "0x8",
@@ -244,10 +409,8 @@
     },
     {
         "BriefDescription": "VN1 Credit Consumed; NCB",
-        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.NCB",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the NCB message class.",
         "UMask": "0x2",
@@ -255,10 +418,8 @@
     },
     {
         "BriefDescription": "VN1 Credit Consumed; NCS",
-        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.NCS",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the NCS message class.",
         "UMask": "0x4",
@@ -266,10 +427,8 @@
     },
     {
         "BriefDescription": "VN1 Credit Consumed; NDR",
-        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.NDR",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the NDR message class.",
         "UMask": "0x20",
@@ -277,10 +436,8 @@
     },
     {
         "BriefDescription": "VN1 Credit Consumed; SNP",
-        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.SNP",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the SNP message class.",
         "UMask": "0x10",
@@ -288,17 +445,14 @@
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
@@ -307,10 +461,8 @@
     },
     {
         "BriefDescription": "RxQ Cycles Not Empty - DRS; for VN0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF",
         "EventName": "UNC_Q_RxL_CYCLES_NE_DRS.VN0",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors DRS flits only.",
         "UMask": "0x1",
@@ -318,10 +470,8 @@
     },
     {
         "BriefDescription": "RxQ Cycles Not Empty - DRS; for VN1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF",
         "EventName": "UNC_Q_RxL_CYCLES_NE_DRS.VN1",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors DRS flits only.",
         "UMask": "0x2",
@@ -329,10 +479,8 @@
     },
     {
         "BriefDescription": "RxQ Cycles Not Empty - HOM; for VN0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "UNC_Q_RxL_CYCLES_NE_HOM.VN0",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors HOM flits only.",
         "UMask": "0x1",
@@ -340,10 +488,8 @@
     },
     {
         "BriefDescription": "RxQ Cycles Not Empty - HOM; for VN1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "UNC_Q_RxL_CYCLES_NE_HOM.VN1",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors HOM flits only.",
         "UMask": "0x2",
@@ -351,10 +497,8 @@
     },
     {
         "BriefDescription": "RxQ Cycles Not Empty - NCB; for VN0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_Q_RxL_CYCLES_NE_NCB.VN0",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NCB flits only.",
         "UMask": "0x1",
@@ -362,10 +506,8 @@
     },
     {
         "BriefDescription": "RxQ Cycles Not Empty - NCB; for VN1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_Q_RxL_CYCLES_NE_NCB.VN1",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NCB flits only.",
         "UMask": "0x2",
@@ -373,10 +515,8 @@
     },
     {
         "BriefDescription": "RxQ Cycles Not Empty - NCS; for VN0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "UNC_Q_RxL_CYCLES_NE_NCS.VN0",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NCS flits only.",
         "UMask": "0x1",
@@ -384,10 +524,8 @@
     },
     {
         "BriefDescription": "RxQ Cycles Not Empty - NCS; for VN1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "UNC_Q_RxL_CYCLES_NE_NCS.VN1",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NCS flits only.",
         "UMask": "0x2",
@@ -395,10 +533,8 @@
     },
     {
         "BriefDescription": "RxQ Cycles Not Empty - NDR; for VN0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_Q_RxL_CYCLES_NE_NDR.VN0",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NDR flits only.",
         "UMask": "0x1",
@@ -406,10 +542,8 @@
     },
     {
         "BriefDescription": "RxQ Cycles Not Empty - NDR; for VN1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_Q_RxL_CYCLES_NE_NDR.VN1",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NDR flits only.",
         "UMask": "0x2",
@@ -417,10 +551,8 @@
     },
     {
         "BriefDescription": "RxQ Cycles Not Empty - SNP; for VN0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_Q_RxL_CYCLES_NE_SNP.VN0",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors SNP flits only.",
         "UMask": "0x1",
@@ -428,10 +560,8 @@
     },
     {
         "BriefDescription": "RxQ Cycles Not Empty - SNP; for VN1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_Q_RxL_CYCLES_NE_SNP.VN1",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors SNP flits only.",
         "UMask": "0x2",
@@ -439,7 +569,6 @@
     },
     {
         "BriefDescription": "Flits Received - Group 0; Data Tx Flits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_Q_RxL_FLITS_G0.DATA",
         "PerPkg": "1",
@@ -449,7 +578,6 @@
     },
     {
         "BriefDescription": "Flits Received - Group 0; Idle and Null Flits=
",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_Q_RxL_FLITS_G0.IDLE",
         "PerPkg": "1",
@@ -459,7 +587,6 @@
     },
     {
         "BriefDescription": "Flits Received - Group 0; Non-Data protocol T=
x Flits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_Q_RxL_FLITS_G0.NON_DATA",
         "PerPkg": "1",
@@ -469,10 +596,8 @@
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
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of flits received over QPI on the DRS (Data Respo=
nse) channel.  DRS flits are used to transmit data with coherency.  This do=
es not count data flits received over the NCB channel which transmits non-c=
oherent data.",
         "UMask": "0x18",
@@ -480,10 +605,8 @@
     },
     {
         "BriefDescription": "Flits Received - Group 1; DRS Data Flits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.DRS_DATA",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of data flits received over QPI on the DRS (Data =
Response) channel.  DRS flits are used to transmit data with coherency.  Th=
is does not count data flits received over the NCB channel which transmits =
non-coherent data.  This includes only the data flits (not the header).",
         "UMask": "0x8",
@@ -491,10 +614,8 @@
     },
     {
         "BriefDescription": "Flits Received - Group 1; DRS Header Flits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.DRS_NONDATA",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of protocol flits received over QPI on the DRS (D=
ata Response) channel.  DRS flits are used to transmit data with coherency.=
  This does not count data flits received over the NCB channel which transm=
its non-coherent data.  This includes only the header flits (not the data).=
  This includes extended headers.",
         "UMask": "0x10",
@@ -502,10 +623,8 @@
     },
     {
         "BriefDescription": "Flits Received - Group 1; HOM Flits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.HOM",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the number of flits received over QPI on the home channel.",
         "UMask": "0x6",
@@ -513,10 +632,8 @@
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
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the number of non-request flits received over QPI on the home chan=
nel.  These are most commonly snoop responses, and this event can be used a=
s a proxy for that.",
         "UMask": "0x4",
@@ -524,10 +641,8 @@
     },
     {
         "BriefDescription": "Flits Received - Group 1; HOM Request Flits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.HOM_REQ",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the number of data request received over QPI on the home channel. =
 This basically counts the number of remote memory requests received over Q=
PI.  In conjunction with the local read count in the Home Agent, one can ca=
lculate the number of LLC Misses.",
         "UMask": "0x2",
@@ -535,10 +650,8 @@
     },
     {
         "BriefDescription": "Flits Received - Group 1; SNP Flits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.SNP",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the number of snoop request flits received over QPI.  These reques=
ts are contained in the snoop channel.  This does not include snoop respons=
es, which are received on the home channel.",
         "UMask": "0x1",
@@ -546,21 +659,17 @@
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
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Number of Non-Coherent Bypass flits.  These packets are generally used to=
 transmit non-coherent data across QPI.",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "QPI LL"
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
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Number of Non-Coherent Bypass data flits.  These flits are generally used=
 to transmit non-coherent data across QPI.  This does not include a count o=
f the DRS (coherent) data flits.  This only counts the data flits, not the =
NCB headers.",
         "UMask": "0x4",
@@ -568,10 +677,8 @@
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
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Number of Non-Coherent Bypass non-data flits.  These packets are generall=
y used to transmit non-coherent data across QPI, and the flits counted here=
 are for headers and other non-data flits.  This includes extended headers.=
",
         "UMask": "0x8",
@@ -579,10 +686,8 @@
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
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Number of NCS (non-coherent standard) flits received over QPI.    This in=
cludes extended headers.",
         "UMask": "0x10",
@@ -590,10 +695,8 @@
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
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of flits received over the NDR (Non-Data Response=
) channel.  This channel is used to send a variety of protocol flits includ=
ing grants and completions.  This is only for NDR packets to the local sock=
et which use the AK ring.",
         "UMask": "0x1",
@@ -601,10 +704,8 @@
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
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of flits received over the NDR (Non-Data Response=
) channel.  This channel is used to send a variety of protocol flits includ=
ing grants and completions.  This is only for NDR packets destined for Rout=
e-thru to a remote socket.",
         "UMask": "0x2",
@@ -612,7 +713,6 @@
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_Q_RxL_INSERTS",
         "PerPkg": "1",
@@ -621,20 +721,16 @@
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
         "BriefDescription": "Rx Flit Buffer Allocations - DRS; for VN0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_Q_RxL_INSERTS_DRS.VN0",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only DRS flits.",
         "UMask": "0x1",
@@ -642,10 +738,8 @@
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - DRS; for VN1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_Q_RxL_INSERTS_DRS.VN1",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only DRS flits.",
         "UMask": "0x2",
@@ -653,20 +747,16 @@
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
         "BriefDescription": "Rx Flit Buffer Allocations - HOM; for VN0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC",
         "EventName": "UNC_Q_RxL_INSERTS_HOM.VN0",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only HOM flits.",
         "UMask": "0x1",
@@ -674,10 +764,8 @@
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - HOM; for VN1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC",
         "EventName": "UNC_Q_RxL_INSERTS_HOM.VN1",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only HOM flits.",
         "UMask": "0x2",
@@ -685,20 +773,16 @@
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
         "BriefDescription": "Rx Flit Buffer Allocations - NCB; for VN0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA",
         "EventName": "UNC_Q_RxL_INSERTS_NCB.VN0",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NCB flits.",
         "UMask": "0x1",
@@ -706,10 +790,8 @@
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - NCB; for VN1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA",
         "EventName": "UNC_Q_RxL_INSERTS_NCB.VN1",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NCB flits.",
         "UMask": "0x2",
@@ -717,20 +799,16 @@
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
         "BriefDescription": "Rx Flit Buffer Allocations - NCS; for VN0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB",
         "EventName": "UNC_Q_RxL_INSERTS_NCS.VN0",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NCS flits.",
         "UMask": "0x1",
@@ -738,10 +816,8 @@
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - NCS; for VN1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB",
         "EventName": "UNC_Q_RxL_INSERTS_NCS.VN1",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NCS flits.",
         "UMask": "0x2",
@@ -749,20 +825,16 @@
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
         "BriefDescription": "Rx Flit Buffer Allocations - NDR; for VN0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xE",
         "EventName": "UNC_Q_RxL_INSERTS_NDR.VN0",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NDR flits.",
         "UMask": "0x1",
@@ -770,10 +842,8 @@
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - NDR; for VN1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xE",
         "EventName": "UNC_Q_RxL_INSERTS_NDR.VN1",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NDR flits.",
         "UMask": "0x2",
@@ -781,20 +851,16 @@
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
         "BriefDescription": "Rx Flit Buffer Allocations - SNP; for VN0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD",
         "EventName": "UNC_Q_RxL_INSERTS_SNP.VN0",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only SNP flits.",
         "UMask": "0x1",
@@ -802,10 +868,8 @@
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - SNP; for VN1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD",
         "EventName": "UNC_Q_RxL_INSERTS_SNP.VN1",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only SNP flits.",
         "UMask": "0x2",
@@ -813,7 +877,6 @@
     },
     {
         "BriefDescription": "RxQ Occupancy - All Packets",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb",
         "EventName": "UNC_Q_RxL_OCCUPANCY",
         "PerPkg": "1",
@@ -822,20 +885,16 @@
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
         "BriefDescription": "RxQ Occupancy - DRS; for VN0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_Q_RxL_OCCUPANCY_DRS.VN0",
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
         "UMask": "0x1",
@@ -843,10 +902,8 @@
     },
     {
         "BriefDescription": "RxQ Occupancy - DRS; for VN1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_Q_RxL_OCCUPANCY_DRS.VN1",
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
         "UMask": "0x2",
@@ -854,20 +911,16 @@
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
         "BriefDescription": "RxQ Occupancy - HOM; for VN0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_Q_RxL_OCCUPANCY_HOM.VN0",
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
         "UMask": "0x1",
@@ -875,10 +928,8 @@
     },
     {
         "BriefDescription": "RxQ Occupancy - HOM; for VN1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_Q_RxL_OCCUPANCY_HOM.VN1",
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
         "UMask": "0x2",
@@ -886,20 +937,16 @@
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
         "BriefDescription": "RxQ Occupancy - NCB; for VN0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x16",
         "EventName": "UNC_Q_RxL_OCCUPANCY_NCB.VN0",
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
         "UMask": "0x1",
@@ -907,10 +954,8 @@
     },
     {
         "BriefDescription": "RxQ Occupancy - NCB; for VN1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x16",
         "EventName": "UNC_Q_RxL_OCCUPANCY_NCB.VN1",
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
         "UMask": "0x2",
@@ -918,20 +963,16 @@
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
         "BriefDescription": "RxQ Occupancy - NCS; for VN0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x17",
         "EventName": "UNC_Q_RxL_OCCUPANCY_NCS.VN0",
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
         "UMask": "0x1",
@@ -939,10 +980,8 @@
     },
     {
         "BriefDescription": "RxQ Occupancy - NCS; for VN1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x17",
         "EventName": "UNC_Q_RxL_OCCUPANCY_NCS.VN1",
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
         "UMask": "0x2",
@@ -950,20 +989,16 @@
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
         "BriefDescription": "RxQ Occupancy - NDR; for VN0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1A",
         "EventName": "UNC_Q_RxL_OCCUPANCY_NDR.VN0",
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
         "UMask": "0x1",
@@ -971,10 +1006,8 @@
     },
     {
         "BriefDescription": "RxQ Occupancy - NDR; for VN1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1A",
         "EventName": "UNC_Q_RxL_OCCUPANCY_NDR.VN1",
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
         "UMask": "0x2",
@@ -982,20 +1015,16 @@
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
         "BriefDescription": "RxQ Occupancy - SNP; for VN0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_Q_RxL_OCCUPANCY_SNP.VN0",
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
         "UMask": "0x1",
@@ -1003,10 +1032,8 @@
     },
     {
         "BriefDescription": "RxQ Occupancy - SNP; for VN1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_Q_RxL_OCCUPANCY_SNP.VN1",
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
         "UMask": "0x2",
@@ -1014,10 +1041,8 @@
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - H=
OM",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_DRS",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the HOM message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
         "UMask": "0x1",
@@ -1025,10 +1050,8 @@
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - D=
RS",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_HOM",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the DRS message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
         "UMask": "0x8",
@@ -1036,10 +1059,8 @@
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - S=
NP",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_NCB",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the SNP message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
         "UMask": "0x2",
@@ -1047,10 +1068,8 @@
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - N=
DR",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_NCS",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the NDR message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
         "UMask": "0x4",
@@ -1058,10 +1077,8 @@
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - N=
CS",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_NDR",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the NCS message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
         "UMask": "0x20",
@@ -1069,10 +1086,8 @@
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - N=
CB",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_SNP",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the NCB message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
         "UMask": "0x10",
@@ -1080,10 +1095,8 @@
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI on VN0; Egress Credit=
s",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_Q_RxL_STALLS_VN0.EGRESS_CREDITS",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet because there were insufficient BGF cre=
dits.  For details on a message class granularity, use the Egress Credit Oc=
cupancy events.",
         "UMask": "0x40",
@@ -1091,10 +1104,8 @@
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI on VN0; GV",
-        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_Q_RxL_STALLS_VN0.GV",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled because a GV transition (frequency transition) w=
as taking place.",
         "UMask": "0x80",
@@ -1102,10 +1113,8 @@
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - H=
OM",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3a",
         "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_DRS",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the HOM message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
         "UMask": "0x1",
@@ -1113,10 +1122,8 @@
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - D=
RS",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3a",
         "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_HOM",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the DRS message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
         "UMask": "0x8",
@@ -1124,10 +1131,8 @@
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - S=
NP",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3a",
         "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_NCB",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the SNP message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
         "UMask": "0x2",
@@ -1135,10 +1140,8 @@
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - N=
DR",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3a",
         "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_NCS",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the NDR message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
         "UMask": "0x4",
@@ -1146,10 +1149,8 @@
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - N=
CS",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3a",
         "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_NDR",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the NCS message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
         "UMask": "0x20",
@@ -1157,10 +1158,8 @@
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - N=
CB",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3a",
         "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_SNP",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the NCB message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
         "UMask": "0x10",
@@ -1168,7 +1167,6 @@
     },
     {
         "BriefDescription": "Cycles in L0p",
-        "Counter": "0,1,2,3",
         "EventCode": "0xd",
         "EventName": "UNC_Q_TxL0P_POWER_CYCLES",
         "PerPkg": "1",
@@ -1177,7 +1175,6 @@
     },
     {
         "BriefDescription": "Cycles in L0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc",
         "EventName": "UNC_Q_TxL0_POWER_CYCLES",
         "PerPkg": "1",
@@ -1186,7 +1183,6 @@
     },
     {
         "BriefDescription": "Tx Flit Buffer Bypassed",
-        "Counter": "0,1,2,3",
         "EventCode": "0x5",
         "EventName": "UNC_Q_TxL_BYPASSED",
         "PerPkg": "1",
@@ -1195,7 +1191,6 @@
     },
     {
         "BriefDescription": "Cycles Stalled with no LLR Credits; LLR is al=
most full",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_Q_TxL_CRC_NO_CREDITS.ALMOST_FULL",
         "PerPkg": "1",
@@ -1205,7 +1200,6 @@
     },
     {
         "BriefDescription": "Cycles Stalled with no LLR Credits; LLR is fu=
ll",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_Q_TxL_CRC_NO_CREDITS.FULL",
         "PerPkg": "1",
@@ -1215,7 +1209,6 @@
     },
     {
         "BriefDescription": "Tx Flit Buffer Cycles not Empty",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6",
         "EventName": "UNC_Q_TxL_CYCLES_NE",
         "PerPkg": "1",
@@ -1224,7 +1217,6 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 0; Data Tx Flits",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_Q_TxL_FLITS_G0.DATA",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach flit is made up of 80 bits of information (in addition to some ECC data=
).  In full-width (L0) mode, flits are made up of four fits, each of which =
contains 20 bits of data (along with some additional ECC data).   In half-w=
idth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as=
 many fits to transmit a flit.  When one talks about QPI speed (for example=
, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the syste=
m will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as data bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual data and an additional 16 bits of othe=
r information.  To calculate data bandwidth, one should therefore do: data =
flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of data fli=
ts transmitted over QPI.  Each flit contains 64b of data.  This includes bo=
th DRS and NCB data flits (coherent and non-coherent).  This can be used to=
 calculate the data bandwidth of the QPI link.  One can get a good picture =
of the QPI-link characteristics by evaluating the protocol flits, data flit=
s, and idle/null flits.  This does not include the header flits that go in =
data packets.",
@@ -1233,7 +1225,6 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 0; Non-Data protoco=
l Tx Flits",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_Q_TxL_FLITS_G0.NON_DATA",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach flit is made up of 80 bits of information (in addition to some ECC data=
).  In full-width (L0) mode, flits are made up of four fits, each of which =
contains 20 bits of data (along with some additional ECC data).   In half-w=
idth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as=
 many fits to transmit a flit.  When one talks about QPI speed (for example=
, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the syste=
m will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as data bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual data and an additional 16 bits of othe=
r information.  To calculate data bandwidth, one should therefore do: data =
flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NULL=
 non-data flits transmitted across QPI.  This basically tracks the protocol=
 overhead on the QPI link.  One can get a good picture of the QPI-link char=
acteristics by evaluating the protocol flits, data flits, and idle/null fli=
ts.  This includes the header flits for data packets.",
@@ -1242,9 +1233,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; DRS Flits (both =
Header and Data)",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of flits transmitted over QPI on the DRS (Da=
ta Response) channel.  DRS flits are used to transmit data with coherency."=
,
         "UMask": "0x18",
@@ -1252,9 +1241,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; DRS Data Flits",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS_DATA",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of data flits transmitted over QPI on the DR=
S (Data Response) channel.  DRS flits are used to transmit data with cohere=
ncy.  This does not count data flits transmitted over the NCB channel which=
 transmits non-coherent data.  This includes only the data flits (not the h=
eader).",
         "UMask": "0x8",
@@ -1262,9 +1249,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; DRS Header Flits=
",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS_NONDATA",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of protocol flits transmitted over QPI on th=
e DRS (Data Response) channel.  DRS flits are used to transmit data with co=
herency.  This does not count data flits transmitted over the NCB channel w=
hich transmits non-coherent data.  This includes only the header flits (not=
 the data).  This includes extended headers.",
         "UMask": "0x10",
@@ -1272,9 +1257,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; HOM Flits",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the number of flits transmitted over QPI on the home channel.=
",
         "UMask": "0x6",
@@ -1282,9 +1265,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; HOM Non-Request =
Flits",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM_NONREQ",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the number of non-request flits transmitted over QPI on the h=
ome channel.  These are most commonly snoop responses, and this event can b=
e used as a proxy for that.",
         "UMask": "0x4",
@@ -1292,9 +1273,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; HOM Request Flit=
s",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM_REQ",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the number of data request transmitted over QPI on the home c=
hannel.  This basically counts the number of remote memory requests transmi=
tted over QPI.  In conjunction with the local read count in the Home Agent,=
 one can calculate the number of LLC Misses.",
         "UMask": "0x2",
@@ -1302,9 +1281,7 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; SNP Flits",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_Q_TxL_FLITS_G1.SNP",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the number of snoop request flits transmitted over QPI.  Thes=
e requests are contained in the snoop channel.  This does not include snoop=
 responses, which are transmitted on the home channel.",
         "UMask": "0x1",
@@ -1312,21 +1289,17 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 2; Non-Coherent Byp=
ass Tx Flits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NCB",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Number of Non-Coherent Bypass flits.  These packets are generally us=
ed to transmit non-coherent data across QPI.",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "QPI LL"
     },
     {
         "BriefDescription": "Flits Transferred - Group 2; Non-Coherent dat=
a Tx Flits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NCB_DATA",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Number of Non-Coherent Bypass data flits.  These flits are generally=
 used to transmit non-coherent data across QPI.  This does not include a co=
unt of the DRS (coherent) data flits.  This only counts the data flits, not=
 the NCB headers.",
         "UMask": "0x4",
@@ -1334,10 +1307,8 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 2; Non-Coherent non=
-data Tx Flits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NCB_NONDATA",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Number of Non-Coherent Bypass non-data flits.  These packets are gen=
erally used to transmit non-coherent data across QPI, and the flits counted=
 here are for headers and other non-data flits.  This includes extended hea=
ders.",
         "UMask": "0x8",
@@ -1345,10 +1316,8 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 2; Non-Coherent sta=
ndard Tx Flits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NCS",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Number of NCS (non-coherent standard) flits transmitted over QPI.   =
 This includes extended headers.",
         "UMask": "0x10",
@@ -1356,10 +1325,8 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 2; Non-Data Respons=
e Tx Flits - AD",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NDR_AD",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of flits transmitted over the NDR (Non-Data =
Response) channel.  This channel is used to send a variety of protocol flit=
s including grants and completions.  This is only for NDR packets to the lo=
cal socket which use the AK ring.",
         "UMask": "0x1",
@@ -1367,10 +1334,8 @@
     },
     {
         "BriefDescription": "Flits Transferred - Group 2; Non-Data Respons=
e Tx Flits - AK",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NDR_AK",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of flits transmitted over the NDR (Non-Data =
Response) channel.  This channel is used to send a variety of protocol flit=
s including grants and completions.  This is only for NDR packets destined =
for Route-thru to a remote socket.",
         "UMask": "0x2",
@@ -1378,7 +1343,6 @@
     },
     {
         "BriefDescription": "Tx Flit Buffer Allocations",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_Q_TxL_INSERTS",
         "PerPkg": "1",
@@ -1387,7 +1351,6 @@
     },
     {
         "BriefDescription": "Tx Flit Buffer Occupancy",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_Q_TxL_OCCUPANCY",
         "PerPkg": "1",
@@ -1396,10 +1359,8 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - HOM; for VN0"=
,
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "UNC_Q_TxR_AD_HOM_CREDIT_ACQUIRED.VN0",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle. Flow Control FIFO for H=
ome messages on AD.",
         "UMask": "0x1",
@@ -1407,10 +1368,8 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - HOM; for VN1"=
,
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "UNC_Q_TxR_AD_HOM_CREDIT_ACQUIRED.VN1",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle. Flow Control FIFO for H=
ome messages on AD.",
         "UMask": "0x2",
@@ -1418,10 +1377,8 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - AD HOM; for V=
N0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_Q_TxR_AD_HOM_CREDIT_OCCUPANCY.VN0",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle.  Flow Control FIFO for HOM messages on AD.",
         "UMask": "0x1",
@@ -1429,10 +1386,8 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - AD HOM; for V=
N1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_Q_TxR_AD_HOM_CREDIT_OCCUPANCY.VN1",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle.  Flow Control FIFO for HOM messages on AD.",
         "UMask": "0x2",
@@ -1440,10 +1395,8 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - AD NDR; for V=
N0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_Q_TxR_AD_NDR_CREDIT_ACQUIRED.VN0",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle.  Flow Control FIFO for =
NDR messages on AD.",
         "UMask": "0x1",
@@ -1451,10 +1404,8 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - AD NDR; for V=
N1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_Q_TxR_AD_NDR_CREDIT_ACQUIRED.VN1",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle.  Flow Control FIFO for =
NDR messages on AD.",
         "UMask": "0x2",
@@ -1462,10 +1413,8 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - AD NDR; for V=
N0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_Q_TxR_AD_NDR_CREDIT_OCCUPANCY.VN0",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle. Flow Control FIFO  for NDR messages on AD.",
         "UMask": "0x1",
@@ -1473,10 +1422,8 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - AD NDR; for V=
N1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_Q_TxR_AD_NDR_CREDIT_OCCUPANCY.VN1",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle. Flow Control FIFO  for NDR messages on AD.",
         "UMask": "0x2",
@@ -1484,10 +1431,8 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - SNP; for VN0"=
,
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_Q_TxR_AD_SNP_CREDIT_ACQUIRED.VN0",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle.  Flow Control FIFO for =
Snoop messages on AD.",
         "UMask": "0x1",
@@ -1495,10 +1440,8 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - SNP; for VN1"=
,
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_Q_TxR_AD_SNP_CREDIT_ACQUIRED.VN1",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle.  Flow Control FIFO for =
Snoop messages on AD.",
         "UMask": "0x2",
@@ -1506,10 +1449,8 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - AD SNP; for V=
N0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_Q_TxR_AD_SNP_CREDIT_OCCUPANCY.VN0",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle.  Flow Control FIFO for Snoop messages on AD.",
         "UMask": "0x1",
@@ -1517,10 +1458,8 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - AD SNP; for V=
N1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_Q_TxR_AD_SNP_CREDIT_OCCUPANCY.VN1",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle.  Flow Control FIFO for Snoop messages on AD.",
         "UMask": "0x2",
@@ -1528,20 +1467,16 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - AK NDR",
-        "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_Q_TxR_AK_NDR_CREDIT_ACQUIRED",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. Local NDR message class to AK Egre=
ss.",
         "Unit": "QPI LL"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - AK NDR: for V=
N0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_Q_TxR_AK_NDR_CREDIT_ACQUIRED.VN0",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. Local NDR message class to AK Egre=
ss.",
         "UMask": "0x1",
@@ -1549,10 +1484,8 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - AK NDR: for V=
N1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_Q_TxR_AK_NDR_CREDIT_ACQUIRED.VN1",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. Local NDR message class to AK Egre=
ss.",
         "UMask": "0x2",
@@ -1560,20 +1493,16 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - AK NDR",
-        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_Q_TxR_AK_NDR_CREDIT_OCCUPANCY",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  Local NDR message class to AK Egress.",
         "Unit": "QPI LL"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - AK NDR: for V=
N0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_Q_TxR_AK_NDR_CREDIT_OCCUPANCY.VN0",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  Local NDR message class to AK Egress.",
         "UMask": "0x1",
@@ -1581,10 +1510,8 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - AK NDR: for V=
N1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_Q_TxR_AK_NDR_CREDIT_OCCUPANCY.VN1",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  Local NDR message class to AK Egress.",
         "UMask": "0x2",
@@ -1592,10 +1519,8 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - DRS; for VN0"=
,
-        "Counter": "0,1,2,3",
         "EventCode": "0x2a",
         "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_ACQUIRED.VN0",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. DRS message class to BL Egress.",
         "UMask": "0x1",
@@ -1603,10 +1528,8 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - DRS; for VN1"=
,
-        "Counter": "0,1,2,3",
         "EventCode": "0x2a",
         "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_ACQUIRED.VN1",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. DRS message class to BL Egress.",
         "UMask": "0x2",
@@ -1614,10 +1537,8 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - DRS; for Shar=
ed VN",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2a",
         "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_ACQUIRED.VN_SHR",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. DRS message class to BL Egress.",
         "UMask": "0x4",
@@ -1625,10 +1546,8 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - BL DRS; for V=
N0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1f",
         "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_OCCUPANCY.VN0",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  DRS message class to BL Egress.",
         "UMask": "0x1",
@@ -1636,10 +1555,8 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - BL DRS; for V=
N1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1f",
         "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_OCCUPANCY.VN1",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  DRS message class to BL Egress.",
         "UMask": "0x2",
@@ -1647,10 +1564,8 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - BL DRS; for S=
hared VN",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1f",
         "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_OCCUPANCY.VN_SHR",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  DRS message class to BL Egress.",
         "UMask": "0x4",
@@ -1658,10 +1573,8 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - NCB; for VN0"=
,
-        "Counter": "0,1,2,3",
         "EventCode": "0x2b",
         "EventName": "UNC_Q_TxR_BL_NCB_CREDIT_ACQUIRED.VN0",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. NCB message class to BL Egress.",
         "UMask": "0x1",
@@ -1669,10 +1582,8 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - NCB; for VN1"=
,
-        "Counter": "0,1,2,3",
         "EventCode": "0x2b",
         "EventName": "UNC_Q_TxR_BL_NCB_CREDIT_ACQUIRED.VN1",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. NCB message class to BL Egress.",
         "UMask": "0x2",
@@ -1680,10 +1591,8 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - BL NCB; for V=
N0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_Q_TxR_BL_NCB_CREDIT_OCCUPANCY.VN0",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  NCB message class to BL Egress.",
         "UMask": "0x1",
@@ -1691,10 +1600,8 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - BL NCB; for V=
N1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_Q_TxR_BL_NCB_CREDIT_OCCUPANCY.VN1",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  NCB message class to BL Egress.",
         "UMask": "0x2",
@@ -1702,10 +1609,8 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - NCS; for VN0"=
,
-        "Counter": "0,1,2,3",
         "EventCode": "0x2c",
         "EventName": "UNC_Q_TxR_BL_NCS_CREDIT_ACQUIRED.VN0",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. NCS message class to BL Egress.",
         "UMask": "0x1",
@@ -1713,10 +1618,8 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - NCS; for VN1"=
,
-        "Counter": "0,1,2,3",
         "EventCode": "0x2c",
         "EventName": "UNC_Q_TxR_BL_NCS_CREDIT_ACQUIRED.VN1",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. NCS message class to BL Egress.",
         "UMask": "0x2",
@@ -1724,10 +1627,8 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - BL NCS; for V=
N0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_Q_TxR_BL_NCS_CREDIT_OCCUPANCY.VN0",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  NCS message class to BL Egress.",
         "UMask": "0x1",
@@ -1735,10 +1636,8 @@
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - BL NCS; for V=
N1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_Q_TxR_BL_NCS_CREDIT_OCCUPANCY.VN1",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  NCS message class to BL Egress.",
         "UMask": "0x2",
@@ -1746,20 +1645,16 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json b/to=
ols/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
index ed60ebca35cb..65509342d56a 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "DRAM Activate Count; Activate due to Write",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_M_ACT_COUNT.BYP",
         "PerPkg": "1",
@@ -11,7 +10,6 @@
     },
     {
         "BriefDescription": "DRAM Activate Count; Activate due to Read",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_M_ACT_COUNT.RD",
         "PerPkg": "1",
@@ -21,7 +19,6 @@
     },
     {
         "BriefDescription": "DRAM Activate Count; Activate due to Write",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_M_ACT_COUNT.WR",
         "PerPkg": "1",
@@ -31,7 +28,6 @@
     },
     {
         "BriefDescription": "ACT command issued by 2 cycle bypass",
-        "Counter": "0,1,2,3",
         "EventCode": "0xa1",
         "EventName": "UNC_M_BYP_CMDS.ACT",
         "PerPkg": "1",
@@ -40,7 +36,6 @@
     },
     {
         "BriefDescription": "CAS command issued by 2 cycle bypass",
-        "Counter": "0,1,2,3",
         "EventCode": "0xa1",
         "EventName": "UNC_M_BYP_CMDS.CAS",
         "PerPkg": "1",
@@ -49,7 +44,6 @@
     },
     {
         "BriefDescription": "PRE command issued by 2 cycle bypass",
-        "Counter": "0,1,2,3",
         "EventCode": "0xa1",
         "EventName": "UNC_M_BYP_CMDS.PRE",
         "PerPkg": "1",
@@ -58,17 +52,15 @@
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; All DRAM WR=
_CAS (w/ and w/out auto-pre)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.ALL",
         "PerPkg": "1",
         "PublicDescription": "DRAM RD_CAS and WR_CAS Commands; Counts the =
total number of DRAM CAS commands issued on this channel.",
-        "UMask": "0xF",
+        "UMask": "0xf",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; All DRAM Re=
ads (RD_CAS + Underfills)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.RD",
         "PerPkg": "1",
@@ -78,7 +70,6 @@
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; All DRAM RD=
_CAS (w/ and w/out auto-pre)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.RD_REG",
         "PerPkg": "1",
@@ -88,17 +79,14 @@
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; Read CAS is=
sued in RMM",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.RD_RMM",
         "PerPkg": "1",
-        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands",
         "UMask": "0x20",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; Underfill R=
ead Issued",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.RD_UNDERFILL",
         "PerPkg": "1",
@@ -108,27 +96,23 @@
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; Read CAS is=
sued in WMM",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.RD_WMM",
         "PerPkg": "1",
-        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands",
         "UMask": "0x10",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; All DRAM WR=
_CAS (both Modes)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.WR",
         "PerPkg": "1",
         "PublicDescription": "DRAM RD_CAS and WR_CAS Commands; Counts the =
total number of DRAM Write CAS commands issued on this channel.",
-        "UMask": "0xC",
+        "UMask": "0xc",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; DRAM WR_CAS=
 (w/ and w/out auto-pre) in Read Major Mode",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.WR_RMM",
         "PerPkg": "1",
@@ -138,7 +122,6 @@
     },
     {
         "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; DRAM WR_CAS=
 (w/ and w/out auto-pre) in Write Major Mode",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.WR_WMM",
         "PerPkg": "1",
@@ -148,14 +131,12 @@
     },
     {
         "BriefDescription": "DRAM Clockticks",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_M_DCLOCKTICKS",
         "PerPkg": "1",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "DRAM Precharge All Commands",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6",
         "EventName": "UNC_M_DRAM_PRE_ALL",
         "PerPkg": "1",
@@ -164,7 +145,6 @@
     },
     {
         "BriefDescription": "Number of DRAM Refreshes Issued",
-        "Counter": "0,1,2,3",
         "EventCode": "0x5",
         "EventName": "UNC_M_DRAM_REFRESH.HIGH",
         "PerPkg": "1",
@@ -174,7 +154,6 @@
     },
     {
         "BriefDescription": "Number of DRAM Refreshes Issued",
-        "Counter": "0,1,2,3",
         "EventCode": "0x5",
         "EventName": "UNC_M_DRAM_REFRESH.PANIC",
         "PerPkg": "1",
@@ -184,7 +163,6 @@
     },
     {
         "BriefDescription": "ECC Correctable Errors",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_M_ECC_CORRECTABLE_ERRORS",
         "PerPkg": "1",
@@ -193,7 +171,6 @@
     },
     {
         "BriefDescription": "Cycles in a Major Mode; Isoch Major Mode",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_M_MAJOR_MODES.ISOCH",
         "PerPkg": "1",
@@ -203,7 +180,6 @@
     },
     {
         "BriefDescription": "Cycles in a Major Mode; Partial Major Mode",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_M_MAJOR_MODES.PARTIAL",
         "PerPkg": "1",
@@ -213,7 +189,6 @@
     },
     {
         "BriefDescription": "Cycles in a Major Mode; Read Major Mode",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_M_MAJOR_MODES.READ",
         "PerPkg": "1",
@@ -223,7 +198,6 @@
     },
     {
         "BriefDescription": "Cycles in a Major Mode; Write Major Mode",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_M_MAJOR_MODES.WRITE",
         "PerPkg": "1",
@@ -233,7 +207,6 @@
     },
     {
         "BriefDescription": "Channel DLLOFF Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_M_POWER_CHANNEL_DLLOFF",
         "PerPkg": "1",
@@ -242,7 +215,6 @@
     },
     {
         "BriefDescription": "Channel PPD Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "UNC_M_POWER_CHANNEL_PPD",
         "PerPkg": "1",
@@ -251,7 +223,6 @@
     },
     {
         "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_M_POWER_CKE_CYCLES.RANK0",
         "PerPkg": "1",
@@ -261,7 +232,6 @@
     },
     {
         "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_M_POWER_CKE_CYCLES.RANK1",
         "PerPkg": "1",
@@ -271,7 +241,6 @@
     },
     {
         "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_M_POWER_CKE_CYCLES.RANK2",
         "PerPkg": "1",
@@ -281,7 +250,6 @@
     },
     {
         "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_M_POWER_CKE_CYCLES.RANK3",
         "PerPkg": "1",
@@ -291,7 +259,6 @@
     },
     {
         "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_M_POWER_CKE_CYCLES.RANK4",
         "PerPkg": "1",
@@ -301,7 +268,6 @@
     },
     {
         "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_M_POWER_CKE_CYCLES.RANK5",
         "PerPkg": "1",
@@ -311,7 +277,6 @@
     },
     {
         "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_M_POWER_CKE_CYCLES.RANK6",
         "PerPkg": "1",
@@ -321,7 +286,6 @@
     },
     {
         "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_M_POWER_CKE_CYCLES.RANK7",
         "PerPkg": "1",
@@ -331,16 +295,20 @@
     },
     {
         "BriefDescription": "Critical Throttle Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_M_POWER_CRITICAL_THROTTLE_CYCLES",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles when the iMC is =
in critical thermal throttling.  When this happens, all traffic is blocked.=
  This should be rare unless something bad is going on in the platform.  Th=
ere is no filtering by rank for this event.",
         "Unit": "iMC"
     },
+    {
+        "EventCode": "0x42",
+        "EventName": "UNC_M_POWER_PCU_THROTTLING",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
     {
         "BriefDescription": "Clock-Enabled Self-Refresh",
-        "Counter": "0,1,2,3",
         "EventCode": "0x43",
         "EventName": "UNC_M_POWER_SELF_REFRESH",
         "PerPkg": "1",
@@ -349,7 +317,6 @@
     },
     {
         "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK0",
         "PerPkg": "1",
@@ -359,7 +326,6 @@
     },
     {
         "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK1",
         "PerPkg": "1",
@@ -369,7 +335,6 @@
     },
     {
         "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK2",
         "PerPkg": "1",
@@ -379,7 +344,6 @@
     },
     {
         "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK3",
         "PerPkg": "1",
@@ -389,7 +353,6 @@
     },
     {
         "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK4",
         "PerPkg": "1",
@@ -399,7 +362,6 @@
     },
     {
         "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK5",
         "PerPkg": "1",
@@ -409,7 +371,6 @@
     },
     {
         "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK6",
         "PerPkg": "1",
@@ -419,7 +380,6 @@
     },
     {
         "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK7",
         "PerPkg": "1",
@@ -429,7 +389,6 @@
     },
     {
         "BriefDescription": "Read Preemption Count; Read over Read Preempt=
ion",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_M_PREEMPTION.RD_PREEMPT_RD",
         "PerPkg": "1",
@@ -439,7 +398,6 @@
     },
     {
         "BriefDescription": "Read Preemption Count; Read over Write Preemp=
tion",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_M_PREEMPTION.RD_PREEMPT_WR",
         "PerPkg": "1",
@@ -449,7 +407,6 @@
     },
     {
         "BriefDescription": "DRAM Precharge commands.; Precharge due to by=
pass",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.BYP",
         "PerPkg": "1",
@@ -459,7 +416,6 @@
     },
     {
         "BriefDescription": "DRAM Precharge commands.; Precharge due to ti=
mer expiration",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.PAGE_CLOSE",
         "PerPkg": "1",
@@ -469,7 +425,6 @@
     },
     {
         "BriefDescription": "DRAM Precharge commands.; Precharges due to p=
age miss",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.PAGE_MISS",
         "PerPkg": "1",
@@ -479,7 +434,6 @@
     },
     {
         "BriefDescription": "DRAM Precharge commands.; Precharge due to re=
ad",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.RD",
         "PerPkg": "1",
@@ -489,7 +443,6 @@
     },
     {
         "BriefDescription": "DRAM Precharge commands.; Precharge due to wr=
ite",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.WR",
         "PerPkg": "1",
@@ -499,7 +452,6 @@
     },
     {
         "BriefDescription": "Read CAS issued with HIGH priority",
-        "Counter": "0,1,2,3",
         "EventCode": "0xa0",
         "EventName": "UNC_M_RD_CAS_PRIO.HIGH",
         "PerPkg": "1",
@@ -508,7 +460,6 @@
     },
     {
         "BriefDescription": "Read CAS issued with LOW priority",
-        "Counter": "0,1,2,3",
         "EventCode": "0xa0",
         "EventName": "UNC_M_RD_CAS_PRIO.LOW",
         "PerPkg": "1",
@@ -517,7 +468,6 @@
     },
     {
         "BriefDescription": "Read CAS issued with MEDIUM priority",
-        "Counter": "0,1,2,3",
         "EventCode": "0xa0",
         "EventName": "UNC_M_RD_CAS_PRIO.MED",
         "PerPkg": "1",
@@ -526,7 +476,6 @@
     },
     {
         "BriefDescription": "Read CAS issued with PANIC NON ISOCH priority=
 (starved)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xa0",
         "EventName": "UNC_M_RD_CAS_PRIO.PANIC",
         "PerPkg": "1",
@@ -535,7 +484,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK0",
         "PerPkg": "1",
@@ -544,7 +492,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; Bank 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK1",
         "PerPkg": "1",
@@ -553,7 +500,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; Bank 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK2",
         "PerPkg": "1",
@@ -562,7 +508,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; Bank 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK3",
         "PerPkg": "1",
@@ -571,7 +516,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; Bank 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK4",
         "PerPkg": "1",
@@ -580,7 +524,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; Bank 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK5",
         "PerPkg": "1",
@@ -589,7 +532,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; Bank 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK6",
         "PerPkg": "1",
@@ -598,7 +540,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 0; Bank 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK7",
         "PerPkg": "1",
@@ -607,7 +548,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK0",
         "PerPkg": "1",
@@ -616,7 +556,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; Bank 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK1",
         "PerPkg": "1",
@@ -625,7 +564,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; Bank 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK2",
         "PerPkg": "1",
@@ -634,7 +572,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; Bank 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK3",
         "PerPkg": "1",
@@ -643,7 +580,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; Bank 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK4",
         "PerPkg": "1",
@@ -652,7 +588,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; Bank 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK5",
         "PerPkg": "1",
@@ -661,7 +596,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; Bank 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK6",
         "PerPkg": "1",
@@ -670,7 +604,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 1; Bank 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK7",
         "PerPkg": "1",
@@ -679,7 +612,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 2; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB2",
         "EventName": "UNC_M_RD_CAS_RANK2.BANK0",
         "PerPkg": "1",
@@ -688,7 +620,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 2; Bank 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB2",
         "EventName": "UNC_M_RD_CAS_RANK2.BANK1",
         "PerPkg": "1",
@@ -697,7 +628,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 2; Bank 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB2",
         "EventName": "UNC_M_RD_CAS_RANK2.BANK2",
         "PerPkg": "1",
@@ -706,7 +636,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 2; Bank 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB2",
         "EventName": "UNC_M_RD_CAS_RANK2.BANK3",
         "PerPkg": "1",
@@ -715,7 +644,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 2; Bank 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB2",
         "EventName": "UNC_M_RD_CAS_RANK2.BANK4",
         "PerPkg": "1",
@@ -724,7 +652,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 2; Bank 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB2",
         "EventName": "UNC_M_RD_CAS_RANK2.BANK5",
         "PerPkg": "1",
@@ -733,7 +660,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 2; Bank 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB2",
         "EventName": "UNC_M_RD_CAS_RANK2.BANK6",
         "PerPkg": "1",
@@ -742,7 +668,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 2; Bank 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB2",
         "EventName": "UNC_M_RD_CAS_RANK2.BANK7",
         "PerPkg": "1",
@@ -751,7 +676,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 3; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB3",
         "EventName": "UNC_M_RD_CAS_RANK3.BANK0",
         "PerPkg": "1",
@@ -760,7 +684,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 3; Bank 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB3",
         "EventName": "UNC_M_RD_CAS_RANK3.BANK1",
         "PerPkg": "1",
@@ -769,7 +692,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 3; Bank 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB3",
         "EventName": "UNC_M_RD_CAS_RANK3.BANK2",
         "PerPkg": "1",
@@ -778,7 +700,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 3; Bank 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB3",
         "EventName": "UNC_M_RD_CAS_RANK3.BANK3",
         "PerPkg": "1",
@@ -787,7 +708,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 3; Bank 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB3",
         "EventName": "UNC_M_RD_CAS_RANK3.BANK4",
         "PerPkg": "1",
@@ -796,7 +716,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 3; Bank 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB3",
         "EventName": "UNC_M_RD_CAS_RANK3.BANK5",
         "PerPkg": "1",
@@ -805,7 +724,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 3; Bank 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB3",
         "EventName": "UNC_M_RD_CAS_RANK3.BANK6",
         "PerPkg": "1",
@@ -814,7 +732,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 3; Bank 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB3",
         "EventName": "UNC_M_RD_CAS_RANK3.BANK7",
         "PerPkg": "1",
@@ -823,7 +740,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK0",
         "PerPkg": "1",
@@ -832,7 +748,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; Bank 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK1",
         "PerPkg": "1",
@@ -841,7 +756,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; Bank 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK2",
         "PerPkg": "1",
@@ -850,7 +764,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; Bank 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK3",
         "PerPkg": "1",
@@ -859,7 +772,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; Bank 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK4",
         "PerPkg": "1",
@@ -868,7 +780,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; Bank 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK5",
         "PerPkg": "1",
@@ -877,7 +788,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; Bank 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK6",
         "PerPkg": "1",
@@ -886,7 +796,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 4; Bank 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK7",
         "PerPkg": "1",
@@ -895,7 +804,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK0",
         "PerPkg": "1",
@@ -904,7 +812,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; Bank 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK1",
         "PerPkg": "1",
@@ -913,7 +820,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; Bank 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK2",
         "PerPkg": "1",
@@ -922,7 +828,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; Bank 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK3",
         "PerPkg": "1",
@@ -931,7 +836,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; Bank 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK4",
         "PerPkg": "1",
@@ -940,7 +844,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; Bank 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK5",
         "PerPkg": "1",
@@ -949,7 +852,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; Bank 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK6",
         "PerPkg": "1",
@@ -958,7 +860,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 5; Bank 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK7",
         "PerPkg": "1",
@@ -967,7 +868,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK0",
         "PerPkg": "1",
@@ -976,7 +876,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; Bank 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK1",
         "PerPkg": "1",
@@ -985,7 +884,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; Bank 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK2",
         "PerPkg": "1",
@@ -994,7 +892,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; Bank 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK3",
         "PerPkg": "1",
@@ -1003,7 +900,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; Bank 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK4",
         "PerPkg": "1",
@@ -1012,7 +908,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; Bank 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK5",
         "PerPkg": "1",
@@ -1021,7 +916,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; Bank 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK6",
         "PerPkg": "1",
@@ -1030,7 +924,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 6; Bank 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK7",
         "PerPkg": "1",
@@ -1039,7 +932,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK0",
         "PerPkg": "1",
@@ -1048,7 +940,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; Bank 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK1",
         "PerPkg": "1",
@@ -1057,7 +948,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; Bank 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK2",
         "PerPkg": "1",
@@ -1066,7 +956,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; Bank 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK3",
         "PerPkg": "1",
@@ -1075,7 +964,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; Bank 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK4",
         "PerPkg": "1",
@@ -1084,7 +972,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; Bank 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK5",
         "PerPkg": "1",
@@ -1093,7 +980,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; Bank 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK6",
         "PerPkg": "1",
@@ -1102,7 +988,6 @@
     },
     {
         "BriefDescription": "RD_CAS Access to Rank 7; Bank 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK7",
         "PerPkg": "1",
@@ -1111,7 +996,6 @@
     },
     {
         "BriefDescription": "Read Pending Queue Not Empty",
-        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "UNC_M_RPQ_CYCLES_NE",
         "PerPkg": "1",
@@ -1120,7 +1004,6 @@
     },
     {
         "BriefDescription": "Read Pending Queue Allocations",
-        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M_RPQ_INSERTS",
         "PerPkg": "1",
@@ -1129,7 +1012,6 @@
     },
     {
         "BriefDescription": "VMSE MXB write buffer occupancy",
-        "Counter": "0,1,2,3",
         "EventCode": "0x91",
         "EventName": "UNC_M_VMSE_MXB_WR_OCCUPANCY",
         "PerPkg": "1",
@@ -1137,7 +1019,6 @@
     },
     {
         "BriefDescription": "VMSE WR PUSH issued; VMSE write PUSH issued i=
n RMM",
-        "Counter": "0,1,2,3",
         "EventCode": "0x90",
         "EventName": "UNC_M_VMSE_WR_PUSH.RMM",
         "PerPkg": "1",
@@ -1146,7 +1027,6 @@
     },
     {
         "BriefDescription": "VMSE WR PUSH issued; VMSE write PUSH issued i=
n WMM",
-        "Counter": "0,1,2,3",
         "EventCode": "0x90",
         "EventName": "UNC_M_VMSE_WR_PUSH.WMM",
         "PerPkg": "1",
@@ -1155,7 +1035,6 @@
     },
     {
         "BriefDescription": "Transition from WMM to RMM because of low thr=
eshold; Transition from WMM to RMM because of starve counter",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_M_WMM_TO_RMM.LOW_THRESH",
         "PerPkg": "1",
@@ -1164,7 +1043,6 @@
     },
     {
         "BriefDescription": "Transition from WMM to RMM because of low thr=
eshold",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_M_WMM_TO_RMM.STARVE",
         "PerPkg": "1",
@@ -1173,7 +1051,6 @@
     },
     {
         "BriefDescription": "Transition from WMM to RMM because of low thr=
eshold",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc0",
         "EventName": "UNC_M_WMM_TO_RMM.VMSE_RETRY",
         "PerPkg": "1",
@@ -1182,7 +1059,6 @@
     },
     {
         "BriefDescription": "Write Pending Queue Full Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_M_WPQ_CYCLES_FULL",
         "PerPkg": "1",
@@ -1191,7 +1067,6 @@
     },
     {
         "BriefDescription": "Write Pending Queue Not Empty",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_M_WPQ_CYCLES_NE",
         "PerPkg": "1",
@@ -1200,7 +1075,6 @@
     },
     {
         "BriefDescription": "Write Pending Queue Allocations",
-        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_M_WPQ_INSERTS",
         "PerPkg": "1",
@@ -1209,7 +1083,6 @@
     },
     {
         "BriefDescription": "Write Pending Queue CAM Match",
-        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_M_WPQ_READ_HIT",
         "PerPkg": "1",
@@ -1218,7 +1091,6 @@
     },
     {
         "BriefDescription": "Write Pending Queue CAM Match",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M_WPQ_WRITE_HIT",
         "PerPkg": "1",
@@ -1227,7 +1099,6 @@
     },
     {
         "BriefDescription": "Not getting the requested Major Mode",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc1",
         "EventName": "UNC_M_WRONG_MM",
         "PerPkg": "1",
@@ -1235,7 +1106,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK0",
         "PerPkg": "1",
@@ -1244,7 +1114,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; Bank 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK1",
         "PerPkg": "1",
@@ -1253,7 +1122,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; Bank 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK2",
         "PerPkg": "1",
@@ -1262,7 +1130,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; Bank 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK3",
         "PerPkg": "1",
@@ -1271,7 +1138,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; Bank 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK4",
         "PerPkg": "1",
@@ -1280,7 +1146,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; Bank 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK5",
         "PerPkg": "1",
@@ -1289,7 +1154,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; Bank 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK6",
         "PerPkg": "1",
@@ -1298,7 +1162,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 0; Bank 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK7",
         "PerPkg": "1",
@@ -1307,7 +1170,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK0",
         "PerPkg": "1",
@@ -1316,7 +1178,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; Bank 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK1",
         "PerPkg": "1",
@@ -1325,7 +1186,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; Bank 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK2",
         "PerPkg": "1",
@@ -1334,7 +1194,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; Bank 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK3",
         "PerPkg": "1",
@@ -1343,7 +1202,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; Bank 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK4",
         "PerPkg": "1",
@@ -1352,7 +1210,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; Bank 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK5",
         "PerPkg": "1",
@@ -1361,7 +1218,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; Bank 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK6",
         "PerPkg": "1",
@@ -1370,7 +1226,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 1; Bank 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK7",
         "PerPkg": "1",
@@ -1379,7 +1234,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 2; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBA",
         "EventName": "UNC_M_WR_CAS_RANK2.BANK0",
         "PerPkg": "1",
@@ -1388,7 +1242,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 2; Bank 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBA",
         "EventName": "UNC_M_WR_CAS_RANK2.BANK1",
         "PerPkg": "1",
@@ -1397,7 +1250,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 2; Bank 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBA",
         "EventName": "UNC_M_WR_CAS_RANK2.BANK2",
         "PerPkg": "1",
@@ -1406,7 +1258,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 2; Bank 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBA",
         "EventName": "UNC_M_WR_CAS_RANK2.BANK3",
         "PerPkg": "1",
@@ -1415,7 +1266,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 2; Bank 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBA",
         "EventName": "UNC_M_WR_CAS_RANK2.BANK4",
         "PerPkg": "1",
@@ -1424,7 +1274,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 2; Bank 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBA",
         "EventName": "UNC_M_WR_CAS_RANK2.BANK5",
         "PerPkg": "1",
@@ -1433,7 +1282,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 2; Bank 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBA",
         "EventName": "UNC_M_WR_CAS_RANK2.BANK6",
         "PerPkg": "1",
@@ -1442,7 +1290,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 2; Bank 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBA",
         "EventName": "UNC_M_WR_CAS_RANK2.BANK7",
         "PerPkg": "1",
@@ -1451,7 +1298,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 3; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBB",
         "EventName": "UNC_M_WR_CAS_RANK3.BANK0",
         "PerPkg": "1",
@@ -1460,7 +1306,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 3; Bank 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBB",
         "EventName": "UNC_M_WR_CAS_RANK3.BANK1",
         "PerPkg": "1",
@@ -1469,7 +1314,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 3; Bank 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBB",
         "EventName": "UNC_M_WR_CAS_RANK3.BANK2",
         "PerPkg": "1",
@@ -1478,7 +1322,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 3; Bank 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBB",
         "EventName": "UNC_M_WR_CAS_RANK3.BANK3",
         "PerPkg": "1",
@@ -1487,7 +1330,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 3; Bank 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBB",
         "EventName": "UNC_M_WR_CAS_RANK3.BANK4",
         "PerPkg": "1",
@@ -1496,7 +1338,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 3; Bank 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBB",
         "EventName": "UNC_M_WR_CAS_RANK3.BANK5",
         "PerPkg": "1",
@@ -1505,7 +1346,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 3; Bank 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBB",
         "EventName": "UNC_M_WR_CAS_RANK3.BANK6",
         "PerPkg": "1",
@@ -1514,7 +1354,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 3; Bank 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBB",
         "EventName": "UNC_M_WR_CAS_RANK3.BANK7",
         "PerPkg": "1",
@@ -1523,7 +1362,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK0",
         "PerPkg": "1",
@@ -1532,7 +1370,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; Bank 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK1",
         "PerPkg": "1",
@@ -1541,7 +1378,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; Bank 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK2",
         "PerPkg": "1",
@@ -1550,7 +1386,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; Bank 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK3",
         "PerPkg": "1",
@@ -1559,7 +1394,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; Bank 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK4",
         "PerPkg": "1",
@@ -1568,7 +1402,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; Bank 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK5",
         "PerPkg": "1",
@@ -1577,7 +1410,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; Bank 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK6",
         "PerPkg": "1",
@@ -1586,7 +1418,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 4; Bank 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK7",
         "PerPkg": "1",
@@ -1595,7 +1426,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK0",
         "PerPkg": "1",
@@ -1604,7 +1434,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; Bank 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK1",
         "PerPkg": "1",
@@ -1613,7 +1442,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; Bank 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK2",
         "PerPkg": "1",
@@ -1622,7 +1450,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; Bank 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK3",
         "PerPkg": "1",
@@ -1631,7 +1458,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; Bank 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK4",
         "PerPkg": "1",
@@ -1640,7 +1466,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; Bank 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK5",
         "PerPkg": "1",
@@ -1649,7 +1474,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; Bank 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK6",
         "PerPkg": "1",
@@ -1658,7 +1482,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 5; Bank 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK7",
         "PerPkg": "1",
@@ -1667,7 +1490,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK0",
         "PerPkg": "1",
@@ -1676,7 +1498,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; Bank 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK1",
         "PerPkg": "1",
@@ -1685,7 +1506,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; Bank 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK2",
         "PerPkg": "1",
@@ -1694,7 +1514,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; Bank 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK3",
         "PerPkg": "1",
@@ -1703,7 +1522,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; Bank 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK4",
         "PerPkg": "1",
@@ -1712,7 +1530,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; Bank 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK5",
         "PerPkg": "1",
@@ -1721,7 +1538,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; Bank 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK6",
         "PerPkg": "1",
@@ -1730,7 +1546,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 6; Bank 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK7",
         "PerPkg": "1",
@@ -1739,7 +1554,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; Bank 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK0",
         "PerPkg": "1",
@@ -1748,7 +1562,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; Bank 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK1",
         "PerPkg": "1",
@@ -1757,7 +1570,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; Bank 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK2",
         "PerPkg": "1",
@@ -1766,7 +1578,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; Bank 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK3",
         "PerPkg": "1",
@@ -1775,7 +1586,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; Bank 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK4",
         "PerPkg": "1",
@@ -1784,7 +1594,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; Bank 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK5",
         "PerPkg": "1",
@@ -1793,7 +1602,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; Bank 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK6",
         "PerPkg": "1",
@@ -1802,7 +1610,6 @@
     },
     {
         "BriefDescription": "WR_CAS Access to Rank 7; Bank 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK7",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-other.json b/too=
ls/perf/pmu-events/arch/x86/ivytown/uncore-other.json
index 6c7ddf642fc3..af9d14a6d145 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-other.json
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
         "EventCode": "0xb",
         "EventName": "UNC_I_RxR_AK_CYCLES_FULL",
         "PerPkg": "1",
@@ -137,7 +123,6 @@
     },
     {
         "BriefDescription": "AK Ingress Occupancy",
-        "Counter": "0,1",
         "EventCode": "0xa",
         "EventName": "UNC_I_RxR_AK_INSERTS",
         "PerPkg": "1",
@@ -145,7 +130,6 @@
         "Unit": "IRP"
     },
     {
-        "Counter": "0,1",
         "EventCode": "0xc",
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
         "BriefDescription": "Inbound Transaction Count: Read Prefetches",
-        "Counter": "0,1",
         "EventCode": "0x15",
         "EventName": "UNC_I_TRANSACTIONS.PD_PREFETCHES",
         "PerPkg": "1",
@@ -259,7 +231,6 @@
     },
     {
         "BriefDescription": "Inbound Transaction Count; Read Prefetches",
-        "Counter": "0,1",
         "EventCode": "0x15",
         "EventName": "UNC_I_TRANSACTIONS.RD_PREFETCHES",
         "PerPkg": "1",
@@ -269,7 +240,6 @@
     },
     {
         "BriefDescription": "Inbound Transaction Count; Reads",
-        "Counter": "0,1",
         "EventCode": "0x15",
         "EventName": "UNC_I_TRANSACTIONS.READS",
         "PerPkg": "1",
@@ -279,7 +249,6 @@
     },
     {
         "BriefDescription": "Inbound Transaction Count; Writes",
-        "Counter": "0,1",
         "EventCode": "0x15",
         "EventName": "UNC_I_TRANSACTIONS.WRITES",
         "PerPkg": "1",
@@ -289,7 +258,6 @@
     },
     {
         "BriefDescription": "No AD Egress Credit Stalls",
-        "Counter": "0,1",
         "EventCode": "0x18",
         "EventName": "UNC_I_TxR_AD_STALL_CREDIT_CYCLES",
         "PerPkg": "1",
@@ -298,7 +266,6 @@
     },
     {
         "BriefDescription": "No BL Egress Credit Stalls",
-        "Counter": "0,1",
         "EventCode": "0x19",
         "EventName": "UNC_I_TxR_BL_STALL_CREDIT_CYCLES",
         "PerPkg": "1",
@@ -307,7 +274,6 @@
     },
     {
         "BriefDescription": "Outbound Read Requests",
-        "Counter": "0,1",
         "EventCode": "0xe",
         "EventName": "UNC_I_TxR_DATA_INSERTS_NCB",
         "PerPkg": "1",
@@ -316,7 +282,6 @@
     },
     {
         "BriefDescription": "Outbound Read Requests",
-        "Counter": "0,1",
         "EventCode": "0xf",
         "EventName": "UNC_I_TxR_DATA_INSERTS_NCS",
         "PerPkg": "1",
@@ -325,7 +290,6 @@
     },
     {
         "BriefDescription": "Outbound Request Queue Occupancy",
-        "Counter": "0,1",
         "EventCode": "0xd",
         "EventName": "UNC_I_TxR_REQUEST_OCCUPANCY",
         "PerPkg": "1",
@@ -334,7 +298,6 @@
     },
     {
         "BriefDescription": "Write Ordering Stalls",
-        "Counter": "0,1",
         "EventCode": "0x1a",
         "EventName": "UNC_I_WRITE_ORDERING_STALL_CYCLES",
         "PerPkg": "1",
@@ -343,7 +306,6 @@
     },
     {
         "BriefDescription": "Number of uclks in domain",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_R2_CLOCKTICKS",
         "PerPkg": "1",
@@ -352,7 +314,6 @@
     },
     {
         "BriefDescription": "R2PCIe IIO Credit Acquired; DRS",
-        "Counter": "0,1",
         "EventCode": "0x33",
         "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.DRS",
         "PerPkg": "1",
@@ -362,7 +323,6 @@
     },
     {
         "BriefDescription": "R2PCIe IIO Credit Acquired; NCB",
-        "Counter": "0,1",
         "EventCode": "0x33",
         "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.NCB",
         "PerPkg": "1",
@@ -372,7 +332,6 @@
     },
     {
         "BriefDescription": "R2PCIe IIO Credit Acquired; NCS",
-        "Counter": "0,1",
         "EventCode": "0x33",
         "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.NCS",
         "PerPkg": "1",
@@ -382,7 +341,6 @@
     },
     {
         "BriefDescription": "R2PCIe IIO Failed to Acquire a Credit; DRS",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_R2_IIO_CREDITS_REJECT.DRS",
         "PerPkg": "1",
@@ -392,7 +350,6 @@
     },
     {
         "BriefDescription": "R2PCIe IIO Credits in Use; DRS",
-        "Counter": "0,1",
         "EventCode": "0x32",
         "EventName": "UNC_R2_IIO_CREDITS_USED.DRS",
         "PerPkg": "1",
@@ -402,7 +359,6 @@
     },
     {
         "BriefDescription": "R2PCIe IIO Credits in Use; NCB",
-        "Counter": "0,1",
         "EventCode": "0x32",
         "EventName": "UNC_R2_IIO_CREDITS_USED.NCB",
         "PerPkg": "1",
@@ -412,7 +368,6 @@
     },
     {
         "BriefDescription": "R2PCIe IIO Credits in Use; NCS",
-        "Counter": "0,1",
         "EventCode": "0x32",
         "EventName": "UNC_R2_IIO_CREDITS_USED.NCS",
         "PerPkg": "1",
@@ -422,17 +377,15 @@
     },
     {
         "BriefDescription": "R2 AD Ring in Use; Counterclockwise",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_R2_RING_AD_USED.CCW",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xCC",
+        "UMask": "0xcc",
         "Unit": "R2PCIe"
     },
     {
         "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Even =
on VRing 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_R2_RING_AD_USED.CCW_VR0_EVEN",
         "PerPkg": "1",
@@ -442,7 +395,6 @@
     },
     {
         "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Odd o=
n VRing 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_R2_RING_AD_USED.CCW_VR0_ODD",
         "PerPkg": "1",
@@ -452,7 +404,6 @@
     },
     {
         "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Even =
on VRing 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_R2_RING_AD_USED.CCW_VR1_EVEN",
         "PerPkg": "1",
@@ -462,7 +413,6 @@
     },
     {
         "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Odd o=
n VRing 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_R2_RING_AD_USED.CCW_VR1_ODD",
         "PerPkg": "1",
@@ -472,7 +422,6 @@
     },
     {
         "BriefDescription": "R2 AD Ring in Use; Clockwise",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_R2_RING_AD_USED.CW",
         "PerPkg": "1",
@@ -482,7 +431,6 @@
     },
     {
         "BriefDescription": "R2 AD Ring in Use; Clockwise and Even on VRin=
g 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_R2_RING_AD_USED.CW_VR0_EVEN",
         "PerPkg": "1",
@@ -492,7 +440,6 @@
     },
     {
         "BriefDescription": "R2 AD Ring in Use; Clockwise and Odd on VRing=
 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_R2_RING_AD_USED.CW_VR0_ODD",
         "PerPkg": "1",
@@ -502,7 +449,6 @@
     },
     {
         "BriefDescription": "R2 AD Ring in Use; Clockwise and Even on VRin=
g 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_R2_RING_AD_USED.CW_VR1_EVEN",
         "PerPkg": "1",
@@ -512,7 +458,6 @@
     },
     {
         "BriefDescription": "R2 AD Ring in Use; Clockwise and Odd on VRing=
 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_R2_RING_AD_USED.CW_VR1_ODD",
         "PerPkg": "1",
@@ -522,17 +467,15 @@
     },
     {
         "BriefDescription": "R2 AK Ring in Use; Counterclockwise",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_R2_RING_AK_USED.CCW",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xCC",
+        "UMask": "0xcc",
         "Unit": "R2PCIe"
     },
     {
         "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Even =
on VRing 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_R2_RING_AK_USED.CCW_VR0_EVEN",
         "PerPkg": "1",
@@ -542,7 +485,6 @@
     },
     {
         "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Odd o=
n VRing 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_R2_RING_AK_USED.CCW_VR0_ODD",
         "PerPkg": "1",
@@ -552,7 +494,6 @@
     },
     {
         "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Even =
on VRing 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_R2_RING_AK_USED.CCW_VR1_EVEN",
         "PerPkg": "1",
@@ -562,7 +503,6 @@
     },
     {
         "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Odd o=
n VRing 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_R2_RING_AK_USED.CCW_VR1_ODD",
         "PerPkg": "1",
@@ -572,7 +512,6 @@
     },
     {
         "BriefDescription": "R2 AK Ring in Use; Clockwise",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_R2_RING_AK_USED.CW",
         "PerPkg": "1",
@@ -582,7 +521,6 @@
     },
     {
         "BriefDescription": "R2 AK Ring in Use; Clockwise and Even on VRin=
g 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_R2_RING_AK_USED.CW_VR0_EVEN",
         "PerPkg": "1",
@@ -592,7 +530,6 @@
     },
     {
         "BriefDescription": "R2 AK Ring in Use; Clockwise and Odd on VRing=
 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_R2_RING_AK_USED.CW_VR0_ODD",
         "PerPkg": "1",
@@ -602,7 +539,6 @@
     },
     {
         "BriefDescription": "R2 AK Ring in Use; Clockwise and Even on VRin=
g 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_R2_RING_AK_USED.CW_VR1_EVEN",
         "PerPkg": "1",
@@ -612,7 +548,6 @@
     },
     {
         "BriefDescription": "R2 AK Ring in Use; Clockwise and Odd on VRing=
 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "UNC_R2_RING_AK_USED.CW_VR1_ODD",
         "PerPkg": "1",
@@ -622,17 +557,15 @@
     },
     {
         "BriefDescription": "R2 BL Ring in Use; Counterclockwise",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_R2_RING_BL_USED.CCW",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xCC",
+        "UMask": "0xcc",
         "Unit": "R2PCIe"
     },
     {
         "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Even =
on VRing 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_R2_RING_BL_USED.CCW_VR0_EVEN",
         "PerPkg": "1",
@@ -642,7 +575,6 @@
     },
     {
         "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Odd o=
n VRing 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_R2_RING_BL_USED.CCW_VR0_ODD",
         "PerPkg": "1",
@@ -652,7 +584,6 @@
     },
     {
         "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Even =
on VRing 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_R2_RING_BL_USED.CCW_VR1_EVEN",
         "PerPkg": "1",
@@ -662,7 +593,6 @@
     },
     {
         "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Odd o=
n VRing 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_R2_RING_BL_USED.CCW_VR1_ODD",
         "PerPkg": "1",
@@ -672,7 +602,6 @@
     },
     {
         "BriefDescription": "R2 BL Ring in Use; Clockwise",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_R2_RING_BL_USED.CW",
         "PerPkg": "1",
@@ -682,7 +611,6 @@
     },
     {
         "BriefDescription": "R2 BL Ring in Use; Clockwise and Even on VRin=
g 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_R2_RING_BL_USED.CW_VR0_EVEN",
         "PerPkg": "1",
@@ -692,7 +620,6 @@
     },
     {
         "BriefDescription": "R2 BL Ring in Use; Clockwise and Odd on VRing=
 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_R2_RING_BL_USED.CW_VR0_ODD",
         "PerPkg": "1",
@@ -702,7 +629,6 @@
     },
     {
         "BriefDescription": "R2 BL Ring in Use; Clockwise and Even on VRin=
g 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_R2_RING_BL_USED.CW_VR1_EVEN",
         "PerPkg": "1",
@@ -712,7 +638,6 @@
     },
     {
         "BriefDescription": "R2 BL Ring in Use; Clockwise and Odd on VRing=
 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_R2_RING_BL_USED.CW_VR1_ODD",
         "PerPkg": "1",
@@ -722,27 +647,24 @@
     },
     {
         "BriefDescription": "R2 IV Ring in Use; Any",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA",
         "EventName": "UNC_R2_RING_IV_USED.ANY",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  The IV ring is unidirectional.  Whether UP or=
 DN is used is dependent on the system programming.  Thereofore, one should=
 generally set both the UP and DN bits for a given polarity (or both) at a =
given time.; Filters any polarity",
-        "UMask": "0xFF",
+        "UMask": "0xff",
         "Unit": "R2PCIe"
     },
     {
         "BriefDescription": "R2 IV Ring in Use; Counterclockwise",
-        "Counter": "0,1,2,3",
         "EventCode": "0xa",
         "EventName": "UNC_R2_RING_IV_USED.CCW",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  The IV ring is unidirectional.  Whether UP or=
 DN is used is dependent on the system programming.  Thereofore, one should=
 generally set both the UP and DN bits for a given polarity (or both) at a =
given time.; Filters for Counterclockwise polarity",
-        "UMask": "0xCC",
+        "UMask": "0xcc",
         "Unit": "R2PCIe"
     },
     {
         "BriefDescription": "R2 IV Ring in Use; Clockwise",
-        "Counter": "0,1,2,3",
         "EventCode": "0xa",
         "EventName": "UNC_R2_RING_IV_USED.CW",
         "PerPkg": "1",
@@ -778,7 +700,6 @@
     },
     {
         "BriefDescription": "Ingress Cycles Not Empty; NCB",
-        "Counter": "0,1",
         "EventCode": "0x10",
         "EventName": "UNC_R2_RxR_CYCLES_NE.NCB",
         "PerPkg": "1",
@@ -788,7 +709,6 @@
     },
     {
         "BriefDescription": "Ingress Cycles Not Empty; NCS",
-        "Counter": "0,1",
         "EventCode": "0x10",
         "EventName": "UNC_R2_RxR_CYCLES_NE.NCS",
         "PerPkg": "1",
@@ -798,7 +718,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; NCB",
-        "Counter": "0,1",
         "EventCode": "0x11",
         "EventName": "UNC_R2_RxR_INSERTS.NCB",
         "PerPkg": "1",
@@ -808,7 +727,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; NCS",
-        "Counter": "0,1",
         "EventCode": "0x11",
         "EventName": "UNC_R2_RxR_INSERTS.NCS",
         "PerPkg": "1",
@@ -881,7 +799,6 @@
     },
     {
         "BriefDescription": "Egress CCW NACK; AD CCW",
-        "Counter": "0,1",
         "EventCode": "0x28",
         "EventName": "UNC_R2_TxR_NACK_CCW.AD",
         "PerPkg": "1",
@@ -891,7 +808,6 @@
     },
     {
         "BriefDescription": "Egress CCW NACK; AK CCW",
-        "Counter": "0,1",
         "EventCode": "0x28",
         "EventName": "UNC_R2_TxR_NACK_CCW.AK",
         "PerPkg": "1",
@@ -901,7 +817,6 @@
     },
     {
         "BriefDescription": "Egress CCW NACK; BL CCW",
-        "Counter": "0,1",
         "EventCode": "0x28",
         "EventName": "UNC_R2_TxR_NACK_CCW.BL",
         "PerPkg": "1",
@@ -911,7 +826,6 @@
     },
     {
         "BriefDescription": "Egress CW NACK; AD CW",
-        "Counter": "0,1",
         "EventCode": "0x26",
         "EventName": "UNC_R2_TxR_NACK_CW.AD",
         "PerPkg": "1",
@@ -921,7 +835,6 @@
     },
     {
         "BriefDescription": "Egress CW NACK; AK CW",
-        "Counter": "0,1",
         "EventCode": "0x26",
         "EventName": "UNC_R2_TxR_NACK_CW.AK",
         "PerPkg": "1",
@@ -931,7 +844,6 @@
     },
     {
         "BriefDescription": "Egress CW NACK; BL CW",
-        "Counter": "0,1",
         "EventCode": "0x26",
         "EventName": "UNC_R2_TxR_NACK_CW.BL",
         "PerPkg": "1",
@@ -941,7 +853,6 @@
     },
     {
         "BriefDescription": "Number of uclks in domain",
-        "Counter": "0,1,2",
         "EventCode": "0x1",
         "EventName": "UNC_R3_CLOCKTICKS",
         "PerPkg": "1",
@@ -950,7 +861,6 @@
     },
     {
         "BriefDescription": "CBox AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2c",
         "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO10",
         "PerPkg": "1",
@@ -960,7 +870,6 @@
     },
     {
         "BriefDescription": "CBox AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2c",
         "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO11",
         "PerPkg": "1",
@@ -970,7 +879,6 @@
     },
     {
         "BriefDescription": "CBox AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2c",
         "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO12",
         "PerPkg": "1",
@@ -980,7 +888,6 @@
     },
     {
         "BriefDescription": "CBox AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2c",
         "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO13",
         "PerPkg": "1",
@@ -990,7 +897,6 @@
     },
     {
         "BriefDescription": "CBox AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2c",
         "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO14",
         "PerPkg": "1",
@@ -1000,7 +906,6 @@
     },
     {
         "BriefDescription": "CBox AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2c",
         "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO8",
         "PerPkg": "1",
@@ -1010,7 +915,6 @@
     },
     {
         "BriefDescription": "CBox AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2c",
         "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO9",
         "PerPkg": "1",
@@ -1020,7 +924,6 @@
     },
     {
         "BriefDescription": "CBox AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2b",
         "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO0",
         "PerPkg": "1",
@@ -1030,7 +933,6 @@
     },
     {
         "BriefDescription": "CBox AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2b",
         "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO1",
         "PerPkg": "1",
@@ -1040,7 +942,6 @@
     },
     {
         "BriefDescription": "CBox AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2b",
         "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO2",
         "PerPkg": "1",
@@ -1050,7 +951,6 @@
     },
     {
         "BriefDescription": "CBox AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2b",
         "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO3",
         "PerPkg": "1",
@@ -1060,7 +960,6 @@
     },
     {
         "BriefDescription": "CBox AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2b",
         "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO4",
         "PerPkg": "1",
@@ -1070,7 +969,6 @@
     },
     {
         "BriefDescription": "CBox AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2b",
         "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO5",
         "PerPkg": "1",
@@ -1080,7 +978,6 @@
     },
     {
         "BriefDescription": "CBox AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2b",
         "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO6",
         "PerPkg": "1",
@@ -1090,7 +987,6 @@
     },
     {
         "BriefDescription": "CBox AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2b",
         "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO7",
         "PerPkg": "1",
@@ -1100,7 +996,6 @@
     },
     {
         "BriefDescription": "HA/R2 AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2f",
         "EventName": "UNC_R3_HA_R2_BL_CREDITS_EMPTY.HA0",
         "PerPkg": "1",
@@ -1110,7 +1005,6 @@
     },
     {
         "BriefDescription": "HA/R2 AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2f",
         "EventName": "UNC_R3_HA_R2_BL_CREDITS_EMPTY.HA1",
         "PerPkg": "1",
@@ -1120,7 +1014,6 @@
     },
     {
         "BriefDescription": "HA/R2 AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2f",
         "EventName": "UNC_R3_HA_R2_BL_CREDITS_EMPTY.R2_NCB",
         "PerPkg": "1",
@@ -1130,7 +1023,6 @@
     },
     {
         "BriefDescription": "HA/R2 AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2f",
         "EventName": "UNC_R3_HA_R2_BL_CREDITS_EMPTY.R2_NCS",
         "PerPkg": "1",
@@ -1140,7 +1032,6 @@
     },
     {
         "BriefDescription": "QPI0 AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x29",
         "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN0_HOM",
         "PerPkg": "1",
@@ -1150,7 +1041,6 @@
     },
     {
         "BriefDescription": "QPI0 AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x29",
         "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN0_NDR",
         "PerPkg": "1",
@@ -1160,7 +1050,6 @@
     },
     {
         "BriefDescription": "QPI0 AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x29",
         "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN0_SNP",
         "PerPkg": "1",
@@ -1170,7 +1059,6 @@
     },
     {
         "BriefDescription": "QPI0 AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x29",
         "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN1_HOM",
         "PerPkg": "1",
@@ -1180,7 +1068,6 @@
     },
     {
         "BriefDescription": "QPI0 AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x29",
         "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN1_NDR",
         "PerPkg": "1",
@@ -1190,7 +1077,6 @@
     },
     {
         "BriefDescription": "QPI0 AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x29",
         "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN1_SNP",
         "PerPkg": "1",
@@ -1200,7 +1086,6 @@
     },
     {
         "BriefDescription": "QPI0 AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x29",
         "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VNA",
         "PerPkg": "1",
@@ -1210,7 +1095,6 @@
     },
     {
         "BriefDescription": "QPI0 BL Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2d",
         "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN0_HOM",
         "PerPkg": "1",
@@ -1220,7 +1104,6 @@
     },
     {
         "BriefDescription": "QPI0 BL Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2d",
         "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN0_NDR",
         "PerPkg": "1",
@@ -1230,7 +1113,6 @@
     },
     {
         "BriefDescription": "QPI0 BL Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2d",
         "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN0_SNP",
         "PerPkg": "1",
@@ -1240,7 +1122,6 @@
     },
     {
         "BriefDescription": "QPI0 BL Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2d",
         "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN1_HOM",
         "PerPkg": "1",
@@ -1250,7 +1131,6 @@
     },
     {
         "BriefDescription": "QPI0 BL Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2d",
         "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN1_NDR",
         "PerPkg": "1",
@@ -1260,7 +1140,6 @@
     },
     {
         "BriefDescription": "QPI0 BL Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2d",
         "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN1_SNP",
         "PerPkg": "1",
@@ -1270,7 +1149,6 @@
     },
     {
         "BriefDescription": "QPI0 BL Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2d",
         "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VNA",
         "PerPkg": "1",
@@ -1280,7 +1158,6 @@
     },
     {
         "BriefDescription": "QPI1 AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2a",
         "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN0_HOM",
         "PerPkg": "1",
@@ -1290,7 +1167,6 @@
     },
     {
         "BriefDescription": "QPI1 AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2a",
         "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN0_NDR",
         "PerPkg": "1",
@@ -1300,7 +1176,6 @@
     },
     {
         "BriefDescription": "QPI1 AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2a",
         "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN0_SNP",
         "PerPkg": "1",
@@ -1310,7 +1185,6 @@
     },
     {
         "BriefDescription": "QPI1 AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2a",
         "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN1_HOM",
         "PerPkg": "1",
@@ -1320,7 +1194,6 @@
     },
     {
         "BriefDescription": "QPI1 AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2a",
         "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN1_NDR",
         "PerPkg": "1",
@@ -1330,7 +1203,6 @@
     },
     {
         "BriefDescription": "QPI1 AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2a",
         "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN1_SNP",
         "PerPkg": "1",
@@ -1340,7 +1212,6 @@
     },
     {
         "BriefDescription": "QPI1 AD Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2a",
         "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VNA",
         "PerPkg": "1",
@@ -1350,7 +1221,6 @@
     },
     {
         "BriefDescription": "QPI1 BL Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2e",
         "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN0_HOM",
         "PerPkg": "1",
@@ -1360,7 +1230,6 @@
     },
     {
         "BriefDescription": "QPI1 BL Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2e",
         "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN0_NDR",
         "PerPkg": "1",
@@ -1370,7 +1239,6 @@
     },
     {
         "BriefDescription": "QPI1 BL Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2e",
         "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN0_SNP",
         "PerPkg": "1",
@@ -1380,7 +1248,6 @@
     },
     {
         "BriefDescription": "QPI1 BL Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2e",
         "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN1_HOM",
         "PerPkg": "1",
@@ -1390,7 +1257,6 @@
     },
     {
         "BriefDescription": "QPI1 BL Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2e",
         "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN1_NDR",
         "PerPkg": "1",
@@ -1400,7 +1266,6 @@
     },
     {
         "BriefDescription": "QPI1 BL Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2e",
         "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN1_SNP",
         "PerPkg": "1",
@@ -1410,7 +1275,6 @@
     },
     {
         "BriefDescription": "QPI1 BL Credits Empty",
-        "Counter": "0,1",
         "EventCode": "0x2e",
         "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VNA",
         "PerPkg": "1",
@@ -1420,17 +1284,15 @@
     },
     {
         "BriefDescription": "R3 AD Ring in Use; Counterclockwise",
-        "Counter": "0,1,2",
         "EventCode": "0x7",
         "EventName": "UNC_R3_RING_AD_USED.CCW",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xCC",
+        "UMask": "0xcc",
         "Unit": "R3QPI"
     },
     {
         "BriefDescription": "R3 AD Ring in Use; Counterclockwise and Even =
on VRing 0",
-        "Counter": "0,1,2",
         "EventCode": "0x7",
         "EventName": "UNC_R3_RING_AD_USED.CCW_VR0_EVEN",
         "PerPkg": "1",
@@ -1440,7 +1302,6 @@
     },
     {
         "BriefDescription": "R3 AD Ring in Use; Counterclockwise and Odd o=
n VRing 0",
-        "Counter": "0,1,2",
         "EventCode": "0x7",
         "EventName": "UNC_R3_RING_AD_USED.CCW_VR0_ODD",
         "PerPkg": "1",
@@ -1450,7 +1311,6 @@
     },
     {
         "BriefDescription": "R3 AD Ring in Use; Clockwise",
-        "Counter": "0,1,2",
         "EventCode": "0x7",
         "EventName": "UNC_R3_RING_AD_USED.CW",
         "PerPkg": "1",
@@ -1460,7 +1320,6 @@
     },
     {
         "BriefDescription": "R3 AD Ring in Use; Clockwise and Even on VRin=
g 0",
-        "Counter": "0,1,2",
         "EventCode": "0x7",
         "EventName": "UNC_R3_RING_AD_USED.CW_VR0_EVEN",
         "PerPkg": "1",
@@ -1470,7 +1329,6 @@
     },
     {
         "BriefDescription": "R3 AD Ring in Use; Clockwise and Odd on VRing=
 0",
-        "Counter": "0,1,2",
         "EventCode": "0x7",
         "EventName": "UNC_R3_RING_AD_USED.CW_VR0_ODD",
         "PerPkg": "1",
@@ -1480,17 +1338,15 @@
     },
     {
         "BriefDescription": "R3 AK Ring in Use; Counterclockwise",
-        "Counter": "0,1,2",
         "EventCode": "0x8",
         "EventName": "UNC_R3_RING_AK_USED.CCW",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xCC",
+        "UMask": "0xcc",
         "Unit": "R3QPI"
     },
     {
         "BriefDescription": "R3 AK Ring in Use; Counterclockwise and Even =
on VRing 0",
-        "Counter": "0,1,2",
         "EventCode": "0x8",
         "EventName": "UNC_R3_RING_AK_USED.CCW_VR0_EVEN",
         "PerPkg": "1",
@@ -1500,7 +1356,6 @@
     },
     {
         "BriefDescription": "R3 AK Ring in Use; Counterclockwise and Odd o=
n VRing 0",
-        "Counter": "0,1,2",
         "EventCode": "0x8",
         "EventName": "UNC_R3_RING_AK_USED.CCW_VR0_ODD",
         "PerPkg": "1",
@@ -1510,7 +1365,6 @@
     },
     {
         "BriefDescription": "R3 AK Ring in Use; Clockwise",
-        "Counter": "0,1,2",
         "EventCode": "0x8",
         "EventName": "UNC_R3_RING_AK_USED.CW",
         "PerPkg": "1",
@@ -1520,7 +1374,6 @@
     },
     {
         "BriefDescription": "R3 AK Ring in Use; Clockwise and Even on VRin=
g 0",
-        "Counter": "0,1,2",
         "EventCode": "0x8",
         "EventName": "UNC_R3_RING_AK_USED.CW_VR0_EVEN",
         "PerPkg": "1",
@@ -1530,7 +1383,6 @@
     },
     {
         "BriefDescription": "R3 AK Ring in Use; Clockwise and Odd on VRing=
 0",
-        "Counter": "0,1,2",
         "EventCode": "0x8",
         "EventName": "UNC_R3_RING_AK_USED.CW_VR0_ODD",
         "PerPkg": "1",
@@ -1540,17 +1392,15 @@
     },
     {
         "BriefDescription": "R3 BL Ring in Use; Counterclockwise",
-        "Counter": "0,1,2",
         "EventCode": "0x9",
         "EventName": "UNC_R3_RING_BL_USED.CCW",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xCC",
+        "UMask": "0xcc",
         "Unit": "R3QPI"
     },
     {
         "BriefDescription": "R3 BL Ring in Use; Counterclockwise and Even =
on VRing 0",
-        "Counter": "0,1,2",
         "EventCode": "0x9",
         "EventName": "UNC_R3_RING_BL_USED.CCW_VR0_EVEN",
         "PerPkg": "1",
@@ -1560,7 +1410,6 @@
     },
     {
         "BriefDescription": "R3 BL Ring in Use; Counterclockwise and Odd o=
n VRing 0",
-        "Counter": "0,1,2",
         "EventCode": "0x9",
         "EventName": "UNC_R3_RING_BL_USED.CCW_VR0_ODD",
         "PerPkg": "1",
@@ -1570,7 +1419,6 @@
     },
     {
         "BriefDescription": "R3 BL Ring in Use; Clockwise",
-        "Counter": "0,1,2",
         "EventCode": "0x9",
         "EventName": "UNC_R3_RING_BL_USED.CW",
         "PerPkg": "1",
@@ -1580,7 +1428,6 @@
     },
     {
         "BriefDescription": "R3 BL Ring in Use; Clockwise and Even on VRin=
g 0",
-        "Counter": "0,1,2",
         "EventCode": "0x9",
         "EventName": "UNC_R3_RING_BL_USED.CW_VR0_EVEN",
         "PerPkg": "1",
@@ -1590,7 +1437,6 @@
     },
     {
         "BriefDescription": "R3 BL Ring in Use; Clockwise and Odd on VRing=
 0",
-        "Counter": "0,1,2",
         "EventCode": "0x9",
         "EventName": "UNC_R3_RING_BL_USED.CW_VR0_ODD",
         "PerPkg": "1",
@@ -1600,27 +1446,24 @@
     },
     {
         "BriefDescription": "R2 IV Ring in Use; Any",
-        "Counter": "0,1,2",
         "EventCode": "0xA",
         "EventName": "UNC_R3_RING_IV_USED.ANY",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  The IV ring is unidirectional.  Whether UP or=
 DN is used is dependent on the system programming.  Thereofore, one should=
 generally set both the UP and DN bits for a given polarity (or both) at a =
given time.; Filters any polarity",
-        "UMask": "0xFF",
+        "UMask": "0xff",
         "Unit": "R3QPI"
     },
     {
         "BriefDescription": "R2 IV Ring in Use; Counterclockwise",
-        "Counter": "0,1,2",
         "EventCode": "0xa",
         "EventName": "UNC_R3_RING_IV_USED.CCW",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  The IV ring is unidirectional.  Whether UP or=
 DN is used is dependent on the system programming.  Thereofore, one should=
 generally set both the UP and DN bits for a given polarity (or both) at a =
given time.; Filters for Counterclockwise polarity",
-        "UMask": "0xCC",
+        "UMask": "0xcc",
         "Unit": "R3QPI"
     },
     {
         "BriefDescription": "R2 IV Ring in Use; Clockwise",
-        "Counter": "0,1,2",
         "EventCode": "0xa",
         "EventName": "UNC_R3_RING_IV_USED.CW",
         "PerPkg": "1",
@@ -1630,7 +1473,6 @@
     },
     {
         "BriefDescription": "AD Ingress Bypassed",
-        "Counter": "0,1",
         "EventCode": "0x12",
         "EventName": "UNC_R3_RxR_AD_BYPASSED",
         "PerPkg": "1",
@@ -1639,7 +1481,6 @@
     },
     {
         "BriefDescription": "Ingress Bypassed",
-        "Counter": "0,1",
         "EventCode": "0x12",
         "EventName": "UNC_R3_RxR_BYPASSED.AD",
         "PerPkg": "1",
@@ -1649,7 +1490,6 @@
     },
     {
         "BriefDescription": "Ingress Cycles Not Empty; HOM",
-        "Counter": "0,1",
         "EventCode": "0x10",
         "EventName": "UNC_R3_RxR_CYCLES_NE.HOM",
         "PerPkg": "1",
@@ -1659,7 +1499,6 @@
     },
     {
         "BriefDescription": "Ingress Cycles Not Empty; NDR",
-        "Counter": "0,1",
         "EventCode": "0x10",
         "EventName": "UNC_R3_RxR_CYCLES_NE.NDR",
         "PerPkg": "1",
@@ -1669,7 +1508,6 @@
     },
     {
         "BriefDescription": "Ingress Cycles Not Empty; SNP",
-        "Counter": "0,1",
         "EventCode": "0x10",
         "EventName": "UNC_R3_RxR_CYCLES_NE.SNP",
         "PerPkg": "1",
@@ -1679,7 +1517,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; DRS",
-        "Counter": "0,1",
         "EventCode": "0x11",
         "EventName": "UNC_R3_RxR_INSERTS.DRS",
         "PerPkg": "1",
@@ -1689,7 +1526,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; HOM",
-        "Counter": "0,1",
         "EventCode": "0x11",
         "EventName": "UNC_R3_RxR_INSERTS.HOM",
         "PerPkg": "1",
@@ -1699,7 +1535,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; NCB",
-        "Counter": "0,1",
         "EventCode": "0x11",
         "EventName": "UNC_R3_RxR_INSERTS.NCB",
         "PerPkg": "1",
@@ -1709,7 +1544,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; NCS",
-        "Counter": "0,1",
         "EventCode": "0x11",
         "EventName": "UNC_R3_RxR_INSERTS.NCS",
         "PerPkg": "1",
@@ -1719,7 +1553,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; NDR",
-        "Counter": "0,1",
         "EventCode": "0x11",
         "EventName": "UNC_R3_RxR_INSERTS.NDR",
         "PerPkg": "1",
@@ -1729,7 +1562,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations; SNP",
-        "Counter": "0,1",
         "EventCode": "0x11",
         "EventName": "UNC_R3_RxR_INSERTS.SNP",
         "PerPkg": "1",
@@ -1793,7 +1625,6 @@
     },
     {
         "BriefDescription": "Egress NACK; AK CCW",
-        "Counter": "0,1",
         "EventCode": "0x28",
         "EventName": "UNC_R3_TxR_NACK_CCW.AD",
         "PerPkg": "1",
@@ -1803,7 +1634,6 @@
     },
     {
         "BriefDescription": "Egress NACK; BL CW",
-        "Counter": "0,1",
         "EventCode": "0x28",
         "EventName": "UNC_R3_TxR_NACK_CCW.AK",
         "PerPkg": "1",
@@ -1813,7 +1643,6 @@
     },
     {
         "BriefDescription": "Egress NACK; BL CCW",
-        "Counter": "0,1",
         "EventCode": "0x28",
         "EventName": "UNC_R3_TxR_NACK_CCW.BL",
         "PerPkg": "1",
@@ -1823,7 +1652,6 @@
     },
     {
         "BriefDescription": "Egress NACK; AD CW",
-        "Counter": "0,1",
         "EventCode": "0x26",
         "EventName": "UNC_R3_TxR_NACK_CW.AD",
         "PerPkg": "1",
@@ -1833,7 +1661,6 @@
     },
     {
         "BriefDescription": "Egress NACK; AD CCW",
-        "Counter": "0,1",
         "EventCode": "0x26",
         "EventName": "UNC_R3_TxR_NACK_CW.AK",
         "PerPkg": "1",
@@ -1843,7 +1670,6 @@
     },
     {
         "BriefDescription": "Egress NACK; AK CW",
-        "Counter": "0,1",
         "EventCode": "0x26",
         "EventName": "UNC_R3_TxR_NACK_CW.BL",
         "PerPkg": "1",
@@ -1853,7 +1679,6 @@
     },
     {
         "BriefDescription": "VN0 Credit Acquisition Failed on DRS; DRS Mes=
sage Class",
-        "Counter": "0,1",
         "EventCode": "0x37",
         "EventName": "UNC_R3_VN0_CREDITS_REJECT.DRS",
         "PerPkg": "1",
@@ -1863,7 +1688,6 @@
     },
     {
         "BriefDescription": "VN0 Credit Acquisition Failed on DRS; HOM Mes=
sage Class",
-        "Counter": "0,1",
         "EventCode": "0x37",
         "EventName": "UNC_R3_VN0_CREDITS_REJECT.HOM",
         "PerPkg": "1",
@@ -1873,7 +1697,6 @@
     },
     {
         "BriefDescription": "VN0 Credit Acquisition Failed on DRS; NCB Mes=
sage Class",
-        "Counter": "0,1",
         "EventCode": "0x37",
         "EventName": "UNC_R3_VN0_CREDITS_REJECT.NCB",
         "PerPkg": "1",
@@ -1883,7 +1706,6 @@
     },
     {
         "BriefDescription": "VN0 Credit Acquisition Failed on DRS; NCS Mes=
sage Class",
-        "Counter": "0,1",
         "EventCode": "0x37",
         "EventName": "UNC_R3_VN0_CREDITS_REJECT.NCS",
         "PerPkg": "1",
@@ -1893,7 +1715,6 @@
     },
     {
         "BriefDescription": "VN0 Credit Acquisition Failed on DRS; NDR Mes=
sage Class",
-        "Counter": "0,1",
         "EventCode": "0x37",
         "EventName": "UNC_R3_VN0_CREDITS_REJECT.NDR",
         "PerPkg": "1",
@@ -1903,7 +1724,6 @@
     },
     {
         "BriefDescription": "VN0 Credit Acquisition Failed on DRS; SNP Mes=
sage Class",
-        "Counter": "0,1",
         "EventCode": "0x37",
         "EventName": "UNC_R3_VN0_CREDITS_REJECT.SNP",
         "PerPkg": "1",
@@ -1913,7 +1733,6 @@
     },
     {
         "BriefDescription": "VN0 Credit Used; DRS Message Class",
-        "Counter": "0,1",
         "EventCode": "0x36",
         "EventName": "UNC_R3_VN0_CREDITS_USED.DRS",
         "PerPkg": "1",
@@ -1923,7 +1742,6 @@
     },
     {
         "BriefDescription": "VN0 Credit Used; HOM Message Class",
-        "Counter": "0,1",
         "EventCode": "0x36",
         "EventName": "UNC_R3_VN0_CREDITS_USED.HOM",
         "PerPkg": "1",
@@ -1933,7 +1751,6 @@
     },
     {
         "BriefDescription": "VN0 Credit Used; NCB Message Class",
-        "Counter": "0,1",
         "EventCode": "0x36",
         "EventName": "UNC_R3_VN0_CREDITS_USED.NCB",
         "PerPkg": "1",
@@ -1943,7 +1760,6 @@
     },
     {
         "BriefDescription": "VN0 Credit Used; NCS Message Class",
-        "Counter": "0,1",
         "EventCode": "0x36",
         "EventName": "UNC_R3_VN0_CREDITS_USED.NCS",
         "PerPkg": "1",
@@ -1953,7 +1769,6 @@
     },
     {
         "BriefDescription": "VN0 Credit Used; NDR Message Class",
-        "Counter": "0,1",
         "EventCode": "0x36",
         "EventName": "UNC_R3_VN0_CREDITS_USED.NDR",
         "PerPkg": "1",
@@ -1963,7 +1778,6 @@
     },
     {
         "BriefDescription": "VN0 Credit Used; SNP Message Class",
-        "Counter": "0,1",
         "EventCode": "0x36",
         "EventName": "UNC_R3_VN0_CREDITS_USED.SNP",
         "PerPkg": "1",
@@ -1973,7 +1787,6 @@
     },
     {
         "BriefDescription": "VN1 Credit Acquisition Failed on DRS; DRS Mes=
sage Class",
-        "Counter": "0,1",
         "EventCode": "0x39",
         "EventName": "UNC_R3_VN1_CREDITS_REJECT.DRS",
         "PerPkg": "1",
@@ -1983,7 +1796,6 @@
     },
     {
         "BriefDescription": "VN1 Credit Acquisition Failed on DRS; HOM Mes=
sage Class",
-        "Counter": "0,1",
         "EventCode": "0x39",
         "EventName": "UNC_R3_VN1_CREDITS_REJECT.HOM",
         "PerPkg": "1",
@@ -1993,7 +1805,6 @@
     },
     {
         "BriefDescription": "VN1 Credit Acquisition Failed on DRS; NCB Mes=
sage Class",
-        "Counter": "0,1",
         "EventCode": "0x39",
         "EventName": "UNC_R3_VN1_CREDITS_REJECT.NCB",
         "PerPkg": "1",
@@ -2003,7 +1814,6 @@
     },
     {
         "BriefDescription": "VN1 Credit Acquisition Failed on DRS; NCS Mes=
sage Class",
-        "Counter": "0,1",
         "EventCode": "0x39",
         "EventName": "UNC_R3_VN1_CREDITS_REJECT.NCS",
         "PerPkg": "1",
@@ -2013,7 +1823,6 @@
     },
     {
         "BriefDescription": "VN1 Credit Acquisition Failed on DRS; NDR Mes=
sage Class",
-        "Counter": "0,1",
         "EventCode": "0x39",
         "EventName": "UNC_R3_VN1_CREDITS_REJECT.NDR",
         "PerPkg": "1",
@@ -2023,7 +1832,6 @@
     },
     {
         "BriefDescription": "VN1 Credit Acquisition Failed on DRS; SNP Mes=
sage Class",
-        "Counter": "0,1",
         "EventCode": "0x39",
         "EventName": "UNC_R3_VN1_CREDITS_REJECT.SNP",
         "PerPkg": "1",
@@ -2033,7 +1841,6 @@
     },
     {
         "BriefDescription": "VN1 Credit Used; DRS Message Class",
-        "Counter": "0,1",
         "EventCode": "0x38",
         "EventName": "UNC_R3_VN1_CREDITS_USED.DRS",
         "PerPkg": "1",
@@ -2043,7 +1850,6 @@
     },
     {
         "BriefDescription": "VN1 Credit Used; HOM Message Class",
-        "Counter": "0,1",
         "EventCode": "0x38",
         "EventName": "UNC_R3_VN1_CREDITS_USED.HOM",
         "PerPkg": "1",
@@ -2053,7 +1859,6 @@
     },
     {
         "BriefDescription": "VN1 Credit Used; NCB Message Class",
-        "Counter": "0,1",
         "EventCode": "0x38",
         "EventName": "UNC_R3_VN1_CREDITS_USED.NCB",
         "PerPkg": "1",
@@ -2063,7 +1868,6 @@
     },
     {
         "BriefDescription": "VN1 Credit Used; NCS Message Class",
-        "Counter": "0,1",
         "EventCode": "0x38",
         "EventName": "UNC_R3_VN1_CREDITS_USED.NCS",
         "PerPkg": "1",
@@ -2073,7 +1877,6 @@
     },
     {
         "BriefDescription": "VN1 Credit Used; NDR Message Class",
-        "Counter": "0,1",
         "EventCode": "0x38",
         "EventName": "UNC_R3_VN1_CREDITS_USED.NDR",
         "PerPkg": "1",
@@ -2083,7 +1886,6 @@
     },
     {
         "BriefDescription": "VN1 Credit Used; SNP Message Class",
-        "Counter": "0,1",
         "EventCode": "0x38",
         "EventName": "UNC_R3_VN1_CREDITS_USED.SNP",
         "PerPkg": "1",
@@ -2093,7 +1895,6 @@
     },
     {
         "BriefDescription": "VNA credit Acquisitions",
-        "Counter": "0,1",
         "EventCode": "0x33",
         "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED",
         "PerPkg": "1",
@@ -2102,7 +1903,6 @@
     },
     {
         "BriefDescription": "VNA credit Acquisitions; HOM Message Class",
-        "Counter": "0,1",
         "EventCode": "0x33",
         "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED.AD",
         "PerPkg": "1",
@@ -2112,7 +1912,6 @@
     },
     {
         "BriefDescription": "VNA credit Acquisitions; HOM Message Class",
-        "Counter": "0,1",
         "EventCode": "0x33",
         "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED.BL",
         "PerPkg": "1",
@@ -2122,7 +1921,6 @@
     },
     {
         "BriefDescription": "VNA Credit Reject; DRS Message Class",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_R3_VNA_CREDITS_REJECT.DRS",
         "PerPkg": "1",
@@ -2132,7 +1930,6 @@
     },
     {
         "BriefDescription": "VNA Credit Reject; HOM Message Class",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_R3_VNA_CREDITS_REJECT.HOM",
         "PerPkg": "1",
@@ -2142,7 +1939,6 @@
     },
     {
         "BriefDescription": "VNA Credit Reject; NCB Message Class",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_R3_VNA_CREDITS_REJECT.NCB",
         "PerPkg": "1",
@@ -2152,7 +1948,6 @@
     },
     {
         "BriefDescription": "VNA Credit Reject; NCS Message Class",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_R3_VNA_CREDITS_REJECT.NCS",
         "PerPkg": "1",
@@ -2162,7 +1957,6 @@
     },
     {
         "BriefDescription": "VNA Credit Reject; NDR Message Class",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_R3_VNA_CREDITS_REJECT.NDR",
         "PerPkg": "1",
@@ -2172,7 +1966,6 @@
     },
     {
         "BriefDescription": "VNA Credit Reject; SNP Message Class",
-        "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_R3_VNA_CREDITS_REJECT.SNP",
         "PerPkg": "1",
@@ -2182,7 +1975,6 @@
     },
     {
         "BriefDescription": "Cycles with no VNA credits available",
-        "Counter": "0,1",
         "EventCode": "0x31",
         "EventName": "UNC_R3_VNA_CREDIT_CYCLES_OUT",
         "PerPkg": "1",
@@ -2191,16 +1983,19 @@
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
@@ -2210,7 +2005,6 @@
     },
     {
         "BriefDescription": "VLW Received",
-        "Counter": "0,1",
         "EventCode": "0x42",
         "EventName": "UNC_U_EVENT_MSG.INT_PRIO",
         "PerPkg": "1",
@@ -2220,7 +2014,6 @@
     },
     {
         "BriefDescription": "VLW Received",
-        "Counter": "0,1",
         "EventCode": "0x42",
         "EventName": "UNC_U_EVENT_MSG.IPI_RCVD",
         "PerPkg": "1",
@@ -2230,7 +2023,6 @@
     },
     {
         "BriefDescription": "VLW Received",
-        "Counter": "0,1",
         "EventCode": "0x42",
         "EventName": "UNC_U_EVENT_MSG.MSI_RCVD",
         "PerPkg": "1",
@@ -2240,7 +2032,6 @@
     },
     {
         "BriefDescription": "VLW Received",
-        "Counter": "0,1",
         "EventCode": "0x42",
         "EventName": "UNC_U_EVENT_MSG.VLW_RCVD",
         "PerPkg": "1",
@@ -2250,7 +2041,6 @@
     },
     {
         "BriefDescription": "Filter Match",
-        "Counter": "0,1",
         "EventCode": "0x41",
         "EventName": "UNC_U_FILTER_MATCH.DISABLE",
         "PerPkg": "1",
@@ -2260,7 +2050,6 @@
     },
     {
         "BriefDescription": "Filter Match",
-        "Counter": "0,1",
         "EventCode": "0x41",
         "EventName": "UNC_U_FILTER_MATCH.ENABLE",
         "PerPkg": "1",
@@ -2270,7 +2059,6 @@
     },
     {
         "BriefDescription": "Filter Match",
-        "Counter": "0,1",
         "EventCode": "0x41",
         "EventName": "UNC_U_FILTER_MATCH.U2C_DISABLE",
         "PerPkg": "1",
@@ -2280,7 +2068,6 @@
     },
     {
         "BriefDescription": "Filter Match",
-        "Counter": "0,1",
         "EventCode": "0x41",
         "EventName": "UNC_U_FILTER_MATCH.U2C_ENABLE",
         "PerPkg": "1",
@@ -2290,7 +2077,6 @@
     },
     {
         "BriefDescription": "IDI Lock/SplitLock Cycles",
-        "Counter": "0,1",
         "EventCode": "0x44",
         "EventName": "UNC_U_LOCK_CYCLES",
         "PerPkg": "1",
@@ -2299,7 +2085,6 @@
     },
     {
         "BriefDescription": "Cycles PHOLD Assert to Ack; Assert to ACK",
-        "Counter": "0,1",
         "EventCode": "0x45",
         "EventName": "UNC_U_PHOLD_CYCLES.ASSERT_TO_ACK",
         "PerPkg": "1",
@@ -2309,7 +2094,6 @@
     },
     {
         "BriefDescription": "RACU Request",
-        "Counter": "0,1",
         "EventCode": "0x46",
         "EventName": "UNC_U_RACU_REQUESTS",
         "PerPkg": "1",
@@ -2317,7 +2101,6 @@
     },
     {
         "BriefDescription": "Monitor Sent to T0; Correctable Machine Check=
",
-        "Counter": "0,1",
         "EventCode": "0x43",
         "EventName": "UNC_U_U2C_EVENTS.CMC",
         "PerPkg": "1",
@@ -2327,7 +2110,6 @@
     },
     {
         "BriefDescription": "Monitor Sent to T0; Livelock",
-        "Counter": "0,1",
         "EventCode": "0x43",
         "EventName": "UNC_U_U2C_EVENTS.LIVELOCK",
         "PerPkg": "1",
@@ -2337,7 +2119,6 @@
     },
     {
         "BriefDescription": "Monitor Sent to T0; LTError",
-        "Counter": "0,1",
         "EventCode": "0x43",
         "EventName": "UNC_U_U2C_EVENTS.LTERROR",
         "PerPkg": "1",
@@ -2347,7 +2128,6 @@
     },
     {
         "BriefDescription": "Monitor Sent to T0; Monitor T0",
-        "Counter": "0,1",
         "EventCode": "0x43",
         "EventName": "UNC_U_U2C_EVENTS.MONITOR_T0",
         "PerPkg": "1",
@@ -2357,7 +2137,6 @@
     },
     {
         "BriefDescription": "Monitor Sent to T0; Monitor T1",
-        "Counter": "0,1",
         "EventCode": "0x43",
         "EventName": "UNC_U_U2C_EVENTS.MONITOR_T1",
         "PerPkg": "1",
@@ -2367,7 +2146,6 @@
     },
     {
         "BriefDescription": "Monitor Sent to T0; Other",
-        "Counter": "0,1",
         "EventCode": "0x43",
         "EventName": "UNC_U_U2C_EVENTS.OTHER",
         "PerPkg": "1",
@@ -2377,7 +2155,6 @@
     },
     {
         "BriefDescription": "Monitor Sent to T0; Trap",
-        "Counter": "0,1",
         "EventCode": "0x43",
         "EventName": "UNC_U_U2C_EVENTS.TRAP",
         "PerPkg": "1",
@@ -2387,7 +2164,6 @@
     },
     {
         "BriefDescription": "Monitor Sent to T0; Uncorrectable Machine Che=
ck",
-        "Counter": "0,1",
         "EventCode": "0x43",
         "EventName": "UNC_U_U2C_EVENTS.UMC",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json b/too=
ls/perf/pmu-events/arch/x86/ivytown/uncore-power.json
index 74c87217d75c..5df1ebfb89ea 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
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
@@ -9,7 +8,6 @@
     },
     {
         "BriefDescription": "Core 0 C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x70",
         "EventName": "UNC_P_CORE0_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -18,7 +16,6 @@
     },
     {
         "BriefDescription": "Core 10 C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7a",
         "EventName": "UNC_P_CORE10_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -27,7 +24,6 @@
     },
     {
         "BriefDescription": "Core 11 C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7b",
         "EventName": "UNC_P_CORE11_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -36,7 +32,6 @@
     },
     {
         "BriefDescription": "Core 12 C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7c",
         "EventName": "UNC_P_CORE12_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -45,7 +40,6 @@
     },
     {
         "BriefDescription": "Core 13 C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7d",
         "EventName": "UNC_P_CORE13_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -54,7 +48,6 @@
     },
     {
         "BriefDescription": "Core 14 C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7e",
         "EventName": "UNC_P_CORE14_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -63,7 +56,6 @@
     },
     {
         "BriefDescription": "Core 1 C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "UNC_P_CORE1_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -72,7 +64,6 @@
     },
     {
         "BriefDescription": "Core 2 C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x72",
         "EventName": "UNC_P_CORE2_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -81,7 +72,6 @@
     },
     {
         "BriefDescription": "Core 3 C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x73",
         "EventName": "UNC_P_CORE3_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -90,7 +80,6 @@
     },
     {
         "BriefDescription": "Core 4 C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x74",
         "EventName": "UNC_P_CORE4_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -99,7 +88,6 @@
     },
     {
         "BriefDescription": "Core 5 C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x75",
         "EventName": "UNC_P_CORE5_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -108,7 +96,6 @@
     },
     {
         "BriefDescription": "Core 6 C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x76",
         "EventName": "UNC_P_CORE6_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -117,7 +104,6 @@
     },
     {
         "BriefDescription": "Core 7 C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x77",
         "EventName": "UNC_P_CORE7_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -126,7 +112,6 @@
     },
     {
         "BriefDescription": "Core 8 C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x78",
         "EventName": "UNC_P_CORE8_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -135,7 +120,6 @@
     },
     {
         "BriefDescription": "Core 9 C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "UNC_P_CORE9_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -144,157 +128,126 @@
     },
     {
         "BriefDescription": "Deep C State Rejection - Core 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x17",
         "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE0",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Deep C State Rejection - Core 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE1",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Deep C State Rejection - Core 10",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE10",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Deep C State Rejection - Core 11",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE11",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Deep C State Rejection - Core 12",
-        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE12",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Deep C State Rejection - Core 13",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE13",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Deep C State Rejection - Core 14",
-        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE14",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Deep C State Rejection - Core 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE2",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Deep C State Rejection - Core 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1a",
         "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE3",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Deep C State Rejection - Core 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE4",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Deep C State Rejection - Core 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1c",
         "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE5",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Deep C State Rejection - Core 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1d",
         "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE6",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Deep C State Rejection - Core 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE7",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Deep C State Rejection - Core 8",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1f",
         "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE8",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Deep C State Rejection - Core 9",
-        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE9",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Core 0 C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_P_DEMOTIONS_CORE0",
         "PerPkg": "1",
@@ -303,7 +256,6 @@
     },
     {
         "BriefDescription": "Core 1 C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1f",
         "EventName": "UNC_P_DEMOTIONS_CORE1",
         "PerPkg": "1",
@@ -312,7 +264,6 @@
     },
     {
         "BriefDescription": "Core 10 C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x42",
         "EventName": "UNC_P_DEMOTIONS_CORE10",
         "PerPkg": "1",
@@ -321,7 +272,6 @@
     },
     {
         "BriefDescription": "Core 11 C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x43",
         "EventName": "UNC_P_DEMOTIONS_CORE11",
         "PerPkg": "1",
@@ -330,7 +280,6 @@
     },
     {
         "BriefDescription": "Core 12 C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x44",
         "EventName": "UNC_P_DEMOTIONS_CORE12",
         "PerPkg": "1",
@@ -339,7 +288,6 @@
     },
     {
         "BriefDescription": "Core 13 C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x45",
         "EventName": "UNC_P_DEMOTIONS_CORE13",
         "PerPkg": "1",
@@ -348,7 +296,6 @@
     },
     {
         "BriefDescription": "Core 14 C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x46",
         "EventName": "UNC_P_DEMOTIONS_CORE14",
         "PerPkg": "1",
@@ -357,7 +304,6 @@
     },
     {
         "BriefDescription": "Core 2 C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_P_DEMOTIONS_CORE2",
         "PerPkg": "1",
@@ -366,7 +312,6 @@
     },
     {
         "BriefDescription": "Core 3 C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_P_DEMOTIONS_CORE3",
         "PerPkg": "1",
@@ -375,7 +320,6 @@
     },
     {
         "BriefDescription": "Core 4 C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_P_DEMOTIONS_CORE4",
         "PerPkg": "1",
@@ -384,7 +328,6 @@
     },
     {
         "BriefDescription": "Core 5 C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_P_DEMOTIONS_CORE5",
         "PerPkg": "1",
@@ -393,7 +336,6 @@
     },
     {
         "BriefDescription": "Core 6 C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_P_DEMOTIONS_CORE6",
         "PerPkg": "1",
@@ -402,7 +344,6 @@
     },
     {
         "BriefDescription": "Core 7 C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_P_DEMOTIONS_CORE7",
         "PerPkg": "1",
@@ -411,7 +352,6 @@
     },
     {
         "BriefDescription": "Core 8 C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_P_DEMOTIONS_CORE8",
         "PerPkg": "1",
@@ -420,7 +360,6 @@
     },
     {
         "BriefDescription": "Core 9 C State Demotions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_P_DEMOTIONS_CORE9",
         "PerPkg": "1",
@@ -429,7 +368,6 @@
     },
     {
         "BriefDescription": "Frequency Residency",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb",
         "EventName": "UNC_P_FREQ_BAND0_CYCLES",
         "PerPkg": "1",
@@ -438,7 +376,6 @@
     },
     {
         "BriefDescription": "Frequency Residency",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc",
         "EventName": "UNC_P_FREQ_BAND1_CYCLES",
         "PerPkg": "1",
@@ -447,7 +384,6 @@
     },
     {
         "BriefDescription": "Frequency Residency",
-        "Counter": "0,1,2,3",
         "EventCode": "0xd",
         "EventName": "UNC_P_FREQ_BAND2_CYCLES",
         "PerPkg": "1",
@@ -456,7 +392,6 @@
     },
     {
         "BriefDescription": "Frequency Residency",
-        "Counter": "0,1,2,3",
         "EventCode": "0xe",
         "EventName": "UNC_P_FREQ_BAND3_CYCLES",
         "PerPkg": "1",
@@ -465,7 +400,6 @@
     },
     {
         "BriefDescription": "Current Strongest Upper Limit Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "UNC_P_FREQ_MAX_CURRENT_CYCLES",
         "PerPkg": "1",
@@ -474,7 +408,6 @@
     },
     {
         "BriefDescription": "Thermal Strongest Upper Limit Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_P_FREQ_MAX_LIMIT_THERMAL_CYCLES",
         "PerPkg": "1",
@@ -483,7 +416,6 @@
     },
     {
         "BriefDescription": "OS Strongest Upper Limit Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6",
         "EventName": "UNC_P_FREQ_MAX_OS_CYCLES",
         "PerPkg": "1",
@@ -492,7 +424,6 @@
     },
     {
         "BriefDescription": "Power Strongest Upper Limit Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x5",
         "EventName": "UNC_P_FREQ_MAX_POWER_CYCLES",
         "PerPkg": "1",
@@ -501,7 +432,6 @@
     },
     {
         "BriefDescription": "IO P Limit Strongest Lower Limit Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x61",
         "EventName": "UNC_P_FREQ_MIN_IO_P_CYCLES",
         "PerPkg": "1",
@@ -510,7 +440,6 @@
     },
     {
         "BriefDescription": "Perf P Limit Strongest Lower Limit Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x62",
         "EventName": "UNC_P_FREQ_MIN_PERF_P_CYCLES",
         "PerPkg": "1",
@@ -519,7 +448,6 @@
     },
     {
         "BriefDescription": "Cycles spent changing Frequency",
-        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "UNC_P_FREQ_TRANS_CYCLES",
         "PerPkg": "1",
@@ -528,7 +456,6 @@
     },
     {
         "BriefDescription": "Memory Phase Shedding Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2f",
         "EventName": "UNC_P_MEMORY_PHASE_SHEDDING_CYCLES",
         "PerPkg": "1",
@@ -537,67 +464,54 @@
     },
     {
         "BriefDescription": "Package C State Exit Latency",
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "UNC_P_PKG_C_EXIT_LATENCY",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the package=
 is transitioning from package C2 to C3.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Package C State Exit Latency",
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "UNC_P_PKG_C_EXIT_LATENCY_SEL",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the package=
 is transitioning from package C2 to C3.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Package C State Residency - C0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2a",
         "EventName": "UNC_P_PKG_C_STATE_RESIDENCY_C0_CYCLES",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the package=
 is in C0",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Package C State Residency - C2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2b",
         "EventName": "UNC_P_PKG_C_STATE_RESIDENCY_C2_CYCLES",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the package=
 is in C2",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Package C State Residency - C3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2c",
         "EventName": "UNC_P_PKG_C_STATE_RESIDENCY_C3_CYCLES",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the package=
 is in C3",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Package C State Residency - C6",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2d",
         "EventName": "UNC_P_PKG_C_STATE_RESIDENCY_C6_CYCLES",
-        "ExtSel": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the package=
 is in C6",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Number of cores in C-State; C0 and C1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
         "PerPkg": "1",
@@ -606,7 +520,6 @@
     },
     {
         "BriefDescription": "Number of cores in C-State; C3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
         "PerPkg": "1",
@@ -615,7 +528,6 @@
     },
     {
         "BriefDescription": "Number of cores in C-State; C6 and C7",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
         "PerPkg": "1",
@@ -624,7 +536,6 @@
     },
     {
         "BriefDescription": "External Prochot",
-        "Counter": "0,1,2,3",
         "EventCode": "0xa",
         "EventName": "UNC_P_PROCHOT_EXTERNAL_CYCLES",
         "PerPkg": "1",
@@ -633,7 +544,6 @@
     },
     {
         "BriefDescription": "Internal Prochot",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_P_PROCHOT_INTERNAL_CYCLES",
         "PerPkg": "1",
@@ -642,7 +552,6 @@
     },
     {
         "BriefDescription": "Total Core C State Transition Cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x63",
         "EventName": "UNC_P_TOTAL_TRANSITION_CYCLES",
         "PerPkg": "1",
@@ -651,7 +560,6 @@
     },
     {
         "BriefDescription": "Cycles Changing Voltage",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3",
         "EventName": "UNC_P_VOLT_TRANS_CYCLES_CHANGE",
         "PerPkg": "1",
@@ -660,7 +568,6 @@
     },
     {
         "BriefDescription": "Cycles Decreasing Voltage",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_P_VOLT_TRANS_CYCLES_DECREASE",
         "PerPkg": "1",
@@ -669,7 +576,6 @@
     },
     {
         "BriefDescription": "Cycles Increasing Voltage",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_P_VOLT_TRANS_CYCLES_INCREASE",
         "PerPkg": "1",
@@ -678,7 +584,6 @@
     },
     {
         "BriefDescription": "VR Hot",
-        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_P_VR_HOT_CYCLES",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/virtual-memory.json b/t=
ools/perf/pmu-events/arch/x86/ivytown/virtual-memory.json
index 6624d02ad715..410763dd4394 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/virtual-memory.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Demand load Miss in all translation lookaside=
 buffer (TLB) levels causes a page walk that completes of any page size.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.DEMAND_LD_WALK_COMPLETED",
         "SampleAfterValue": "100003",
@@ -10,8 +8,6 @@
     },
     {
         "BriefDescription": "Demand load cycles page miss handler (PMH) is=
 busy with this walk.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.DEMAND_LD_WALK_DURATION",
         "SampleAfterValue": "2000003",
@@ -19,8 +15,6 @@
     },
     {
         "BriefDescription": "Page walk for a large page completed for Dema=
nd load.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.LARGE_PAGE_WALK_COMPLETED",
         "SampleAfterValue": "100003",
@@ -28,8 +22,6 @@
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
@@ -38,8 +30,6 @@
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
@@ -48,8 +38,6 @@
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
@@ -58,8 +46,6 @@
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
@@ -68,8 +54,6 @@
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
@@ -78,8 +62,6 @@
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
@@ -88,8 +70,6 @@
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
@@ -98,8 +78,6 @@
     },
     {
         "BriefDescription": "Cycles when PMH is busy with page walks",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_DURATION",
         "PublicDescription": "Cycles PMH is busy with this walk.",
@@ -108,8 +86,6 @@
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
@@ -117,8 +93,6 @@
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
@@ -127,8 +101,6 @@
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
@@ -137,8 +109,6 @@
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
@@ -147,8 +117,6 @@
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
@@ -157,8 +125,6 @@
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
@@ -167,8 +133,6 @@
     },
     {
         "BriefDescription": "Cycles when PMH is busy with page walks",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_DURATION",
         "PublicDescription": "Cycle PMH is busy with a walk.",
@@ -177,8 +141,6 @@
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
@@ -187,8 +149,6 @@
     },
     {
         "BriefDescription": "STLB flush attempts",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xBD",
         "EventName": "TLB_FLUSH.STLB_ANY",
         "PublicDescription": "Count number of STLB flush attempts.",
--=20
2.39.0.314.g84b9a713c41-goog

