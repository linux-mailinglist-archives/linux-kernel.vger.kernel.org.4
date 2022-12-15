Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DD164D6BE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 07:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiLOG4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 01:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiLOG4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:56:15 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EC1396EF
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:55:57 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id r7-20020a25c107000000b006ff55ac0ee7so2624430ybf.15
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7T5U7a5q4eBwGViJ+5tYvVwQKmyiHInB8m6yrVWhl8k=;
        b=JOJIQ4lc/Ed+JXGe4LWRtUF+J2Vt9m0Hs1xoZGKLxDZW/hedR0fmmArYYyZwyni03B
         n8w3Z8emA5/ovsWxcdohLbmxo3G4js7ySPFQIKBPKtm+p5zDAE3XG4OeLSWpL72kI+0U
         94JiH9slN8RSiXbuK4ucbXISMOzB4y4p7+uFNA4F6Q3FXOwazKHgK/CR/ImhbYenfvUJ
         pmBWiDpng/ZN7oBAk2RcOSMbQYX95TW3hmWB1s9qZjK4RCCNpiFFlCy//pF4Km1GRhJU
         ph4NhUp5XeEfzKpvYWLmVfZTlgJROSxoRra26gC1DLttkTXOyW7knb1ygEDbxtXG0Uhi
         KQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7T5U7a5q4eBwGViJ+5tYvVwQKmyiHInB8m6yrVWhl8k=;
        b=ex+nvqM1GVgJTmBmUR+m9yIrkNd3Tq6/J1zI2bbT9ZeztEB85VYbxZjNeq5GeHWuZb
         0RQew2ngEL/TfYzql+nTKplKeu8y75HsJZZifsFiLdf5K9DU+kuDDTEfxUVrzmiU/aoG
         IWftbx+3kPLTpzmF+EJAuDhIDyDUb3n6HgK/HqwJe3ROC3pmgt2s50nbKi15BxaZKcS9
         pLUgvQwmcNfkQ2QpFe3VWU9lYDLs1XKDoaBqNXg6L5r1mhGzjTiAG5l7VruLB5JL7WbM
         NmMsLDOkjja1/iWeuO7qSCGYrsGkpv151302/oeq9LvmykbCNsm2UEuBpUScwwk5gcZw
         Xz8g==
X-Gm-Message-State: ANoB5pn7RMJMIiR4aq6fz1oeW2kF0HkImavi4NjJMnkU2kW+0JpDUkcP
        iHVJutwZtbULTeH8Me0CDURjq4dIeaoZ
X-Google-Smtp-Source: AA0mqf6UAodU1jriFmfSomRMKNVtctBf9Fi9jA7DWUO3xnBwWbwO0WxBmY3R/lOX/bf3oZdBS0cX5FhyD3gs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c7dc:d96f:4f9:f59d])
 (user=irogers job=sendgmr) by 2002:a81:91ca:0:b0:3c3:5477:68c1 with SMTP id
 i193-20020a8191ca000000b003c3547768c1mr1729697ywg.464.1671087356451; Wed, 14
 Dec 2022 22:55:56 -0800 (PST)
Date:   Wed, 14 Dec 2022 22:54:50 -0800
In-Reply-To: <20221215065510.1621979-1-irogers@google.com>
Message-Id: <20221215065510.1621979-4-irogers@google.com>
Mime-Version: 1.0
References: <20221215065510.1621979-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 12/32] perf vendor events intel: Refresh haswell metrics
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

Update the haswell metrics and events using the new tooling from:
https://github.com/intel/perfmon

The metrics are unchanged but the formulas differ due to parentheses,
use of exponents and removal of redundant operations like "* 1".  The
events are unchanged but unused json values are removed. The
formatting changes increase consistency across the json files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/haswell/cache.json    | 211 --------------
 .../arch/x86/haswell/floating-point.json      |  20 --
 .../pmu-events/arch/x86/haswell/frontend.json |  58 ----
 .../arch/x86/haswell/hsw-metrics.json         | 117 ++++----
 .../pmu-events/arch/x86/haswell/memory.json   | 149 ----------
 .../pmu-events/arch/x86/haswell/other.json    |   8 -
 .../pmu-events/arch/x86/haswell/pipeline.json | 258 ------------------
 .../arch/x86/haswell/uncore-cache.json        |  50 ----
 .../arch/x86/haswell/uncore-other.json        |  21 +-
 .../arch/x86/haswell/virtual-memory.json      |  98 -------
 10 files changed, 73 insertions(+), 917 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/haswell/cache.json b/tools/perf=
/pmu-events/arch/x86/haswell/cache.json
index 719b8e622f59..5a1489e79859 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/cache.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/cache.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "L1D data line replacements",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x51",
         "EventName": "L1D.REPLACEMENT",
         "PublicDescription": "This event counts when new data lines are br=
ought into the L1 Data cache, which cause other lines to be evicted from th=
e cache.",
@@ -11,8 +9,6 @@
     },
     {
         "BriefDescription": "Cycles a demand request was blocked due to Fi=
ll Buffers inavailability.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL",
@@ -21,8 +17,6 @@
     },
     {
         "BriefDescription": "L1D miss outstanding duration in cycles",
-        "Counter": "2",
-        "CounterHTOff": "2",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING",
         "PublicDescription": "Increments the number of outstanding L1D mis=
ses every cycle. Set Cmask =3D 1 and Edge =3D1 to count occurrences.",
@@ -31,8 +25,6 @@
     },
     {
         "BriefDescription": "Cycles with L1D load Misses outstanding.",
-        "Counter": "2",
-        "CounterHTOff": "2",
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING_CYCLES",
@@ -42,8 +34,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles with L1D load Misses outstanding from =
any thread on physical core.",
-        "Counter": "2",
-        "CounterHTOff": "2",
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING_CYCLES_ANY",
@@ -52,8 +42,6 @@
     },
     {
         "BriefDescription": "Number of times a request needed a FB entry b=
ut there was no entry available for it. That is the FB unavailability was d=
ominant reason for blocking the request. A request includes cacheable/uncac=
heable demands that is load, store or SW prefetch. HWP are e.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.REQUEST_FB_FULL",
         "SampleAfterValue": "2000003",
@@ -61,8 +49,6 @@
     },
     {
         "BriefDescription": "Not rejected writebacks that hit L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x27",
         "EventName": "L2_DEMAND_RQSTS.WB_HIT",
         "PublicDescription": "Not rejected writebacks that hit L2 cache.",
@@ -71,8 +57,6 @@
     },
     {
         "BriefDescription": "L2 cache lines filling L2",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.ALL",
         "PublicDescription": "This event counts the number of L2 cache lin=
es brought into the L2 cache.  Lines are filled into the L2 cache when ther=
e was an L2 miss.",
@@ -81,8 +65,6 @@
     },
     {
         "BriefDescription": "L2 cache lines in E state filling L2",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.E",
         "PublicDescription": "L2 cache lines in E state filling L2.",
@@ -91,8 +73,6 @@
     },
     {
         "BriefDescription": "L2 cache lines in I state filling L2",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.I",
         "PublicDescription": "L2 cache lines in I state filling L2.",
@@ -101,8 +81,6 @@
     },
     {
         "BriefDescription": "L2 cache lines in S state filling L2",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.S",
         "PublicDescription": "L2 cache lines in S state filling L2.",
@@ -111,8 +89,6 @@
     },
     {
         "BriefDescription": "Clean L2 cache lines evicted by demand",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.DEMAND_CLEAN",
         "PublicDescription": "Clean L2 cache lines evicted by demand.",
@@ -121,8 +97,6 @@
     },
     {
         "BriefDescription": "Dirty L2 cache lines evicted by demand",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.DEMAND_DIRTY",
         "PublicDescription": "Dirty L2 cache lines evicted by demand.",
@@ -131,8 +105,6 @@
     },
     {
         "BriefDescription": "L2 code requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_CODE_RD",
         "PublicDescription": "Counts all L2 code requests.",
@@ -141,8 +113,6 @@
     },
     {
         "BriefDescription": "Demand Data Read requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "HSD78, HSM80",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
@@ -152,8 +122,6 @@
     },
     {
         "BriefDescription": "Demand requests that miss L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "HSD78, HSM80",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_MISS",
@@ -163,8 +131,6 @@
     },
     {
         "BriefDescription": "Demand requests to L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "HSD78, HSM80",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_REFERENCES",
@@ -174,8 +140,6 @@
     },
     {
         "BriefDescription": "Requests from L2 hardware prefetchers",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_PF",
         "PublicDescription": "Counts all L2 HW prefetcher requests.",
@@ -184,8 +148,6 @@
     },
     {
         "BriefDescription": "RFO requests to L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_RFO",
         "PublicDescription": "Counts all L2 store RFO requests.",
@@ -194,8 +156,6 @@
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
@@ -204,8 +164,6 @@
     },
     {
         "BriefDescription": "L2 cache misses when fetching instructions",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_MISS",
         "PublicDescription": "Number of instruction fetches that missed th=
e L2 cache.",
@@ -214,8 +172,6 @@
     },
     {
         "BriefDescription": "Demand Data Read requests that hit L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "HSD78, HSM80",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
@@ -225,8 +181,6 @@
     },
     {
         "BriefDescription": "Demand Data Read miss L2, no rejects",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "HSD78, HSM80",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
@@ -236,8 +190,6 @@
     },
     {
         "BriefDescription": "L2 prefetch requests that hit L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.L2_PF_HIT",
         "PublicDescription": "Counts all L2 HW prefetcher requests that hi=
t L2.",
@@ -246,8 +198,6 @@
     },
     {
         "BriefDescription": "L2 prefetch requests that miss L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.L2_PF_MISS",
         "PublicDescription": "Counts all L2 HW prefetcher requests that mi=
ssed L2.",
@@ -256,8 +206,6 @@
     },
     {
         "BriefDescription": "All requests that miss L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "HSD78, HSM80",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.MISS",
@@ -267,8 +215,6 @@
     },
     {
         "BriefDescription": "All L2 requests",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "HSD78, HSM80",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.REFERENCES",
@@ -278,8 +224,6 @@
     },
     {
         "BriefDescription": "RFO requests that hit L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_HIT",
         "PublicDescription": "Counts the number of store RFO requests that=
 hit the L2 cache.",
@@ -288,8 +232,6 @@
     },
     {
         "BriefDescription": "RFO requests that miss L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_MISS",
         "PublicDescription": "Counts the number of store RFO requests that=
 miss the L2 cache.",
@@ -298,8 +240,6 @@
     },
     {
         "BriefDescription": "L2 or L3 HW prefetches that access L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xf0",
         "EventName": "L2_TRANS.ALL_PF",
         "PublicDescription": "Any MLC or L3 HW prefetch accessing L2, incl=
uding rejects.",
@@ -308,8 +248,6 @@
     },
     {
         "BriefDescription": "Transactions accessing L2 pipe",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xf0",
         "EventName": "L2_TRANS.ALL_REQUESTS",
         "PublicDescription": "Transactions accessing L2 pipe.",
@@ -318,8 +256,6 @@
     },
     {
         "BriefDescription": "L2 cache accesses when fetching instructions"=
,
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xf0",
         "EventName": "L2_TRANS.CODE_RD",
         "PublicDescription": "L2 cache accesses when fetching instructions=
.",
@@ -328,8 +264,6 @@
     },
     {
         "BriefDescription": "Demand Data Read requests that access L2 cach=
e",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xf0",
         "EventName": "L2_TRANS.DEMAND_DATA_RD",
         "PublicDescription": "Demand data read requests that access L2 cac=
he.",
@@ -338,8 +272,6 @@
     },
     {
         "BriefDescription": "L1D writebacks that access L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xf0",
         "EventName": "L2_TRANS.L1D_WB",
         "PublicDescription": "L1D writebacks that access L2 cache.",
@@ -348,8 +280,6 @@
     },
     {
         "BriefDescription": "L2 fill requests that access L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xf0",
         "EventName": "L2_TRANS.L2_FILL",
         "PublicDescription": "L2 fill requests that access L2 cache.",
@@ -358,8 +288,6 @@
     },
     {
         "BriefDescription": "L2 writebacks that access L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xf0",
         "EventName": "L2_TRANS.L2_WB",
         "PublicDescription": "L2 writebacks that access L2 cache.",
@@ -368,8 +296,6 @@
     },
     {
         "BriefDescription": "RFO requests that access L2 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xf0",
         "EventName": "L2_TRANS.RFO",
         "PublicDescription": "RFO requests that access L2 cache.",
@@ -378,8 +304,6 @@
     },
     {
         "BriefDescription": "Cycles when L1D is locked",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x63",
         "EventName": "LOCK_CYCLES.CACHE_LOCK_DURATION",
         "PublicDescription": "Cycles in which the L1D is locked.",
@@ -388,8 +312,6 @@
     },
     {
         "BriefDescription": "Core-originated cacheable demand requests mis=
sed L3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2E",
         "EventName": "LONGEST_LAT_CACHE.MISS",
         "PublicDescription": "This event counts each cache miss condition =
for references to the last level cache.",
@@ -398,8 +320,6 @@
     },
     {
         "BriefDescription": "Core-originated cacheable demand requests tha=
t refer to L3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2E",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
         "PublicDescription": "This event counts requests originating from =
the core that reference a cache line in the last level cache.",
@@ -408,8 +328,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were L3 =
and cross-core snoop hits in on-pkg core cache.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD29, HSD25, HSM26, HSM30",
         "EventCode": "0xD2",
@@ -420,8 +338,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were Hit=
M responses from shared L3.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD29, HSD25, HSM26, HSM30",
         "EventCode": "0xD2",
@@ -432,8 +348,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were L3 =
hit and cross-core snoop missed in on-pkg core cache.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD29, HSD25, HSM26, HSM30",
         "EventCode": "0xD2",
@@ -444,8 +358,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were hit=
s in L3 without snoops required.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD74, HSD29, HSD25, HSM26, HSM30",
         "EventCode": "0xD2",
@@ -456,8 +368,6 @@
     },
     {
         "BriefDescription": "Data from local DRAM either Snoop not needed =
or Snoop Miss (RspI)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD74, HSD29, HSD25, HSM30",
         "EventCode": "0xD3",
@@ -469,8 +379,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were loa=
d uops missed L1 but hit FB due to preceding miss to the same cache line wi=
th data not ready.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSM30",
         "EventCode": "0xD1",
@@ -481,8 +389,6 @@
     },
     {
         "BriefDescription": "Retired load uops with L1 cache hits as data =
sources.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD29, HSM30",
         "EventCode": "0xD1",
@@ -493,8 +399,6 @@
     },
     {
         "BriefDescription": "Retired load uops misses in L1 cache as data =
sources.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSM30",
         "EventCode": "0xD1",
@@ -506,8 +410,6 @@
     },
     {
         "BriefDescription": "Retired load uops with L2 cache hits as data =
sources.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD76, HSD29, HSM30",
         "EventCode": "0xD1",
@@ -518,8 +420,6 @@
     },
     {
         "BriefDescription": "Miss in mid-level (L2) cache. Excludes Unknow=
n data-source.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD29, HSM30",
         "EventCode": "0xD1",
@@ -531,8 +431,6 @@
     },
     {
         "BriefDescription": "Retired load uops which data sources were dat=
a hits in L3 without snoops required.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD74, HSD29, HSD25, HSM26, HSM30",
         "EventCode": "0xD1",
@@ -544,8 +442,6 @@
     },
     {
         "BriefDescription": "Miss in last-level (L3) cache. Excludes Unkno=
wn data-source.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD74, HSD29, HSD25, HSM26, HSM30",
         "EventCode": "0xD1",
@@ -557,8 +453,6 @@
     },
     {
         "BriefDescription": "Retired load uops.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD29, HSM30",
         "EventCode": "0xD0",
@@ -570,13 +464,10 @@
     },
     {
         "BriefDescription": "Retired store uops.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD29, HSM30",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
-        "L1_Hit_Indication": "1",
         "PEBS": "1",
         "PublicDescription": "Counts all retired store uops.",
         "SampleAfterValue": "2000003",
@@ -584,8 +475,6 @@
     },
     {
         "BriefDescription": "Retired load uops with locked access.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD76, HSD29, HSM30",
         "EventCode": "0xD0",
@@ -596,8 +485,6 @@
     },
     {
         "BriefDescription": "Retired load uops that split across a cacheli=
ne boundary.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD29, HSM30",
         "EventCode": "0xD0",
@@ -608,21 +495,16 @@
     },
     {
         "BriefDescription": "Retired store uops that split across a cachel=
ine boundary.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD29, HSM30",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
-        "L1_Hit_Indication": "1",
         "PEBS": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x42"
     },
     {
         "BriefDescription": "Retired load uops that miss the STLB.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD29, HSM30",
         "EventCode": "0xD0",
@@ -633,21 +515,16 @@
     },
     {
         "BriefDescription": "Retired store uops that miss the STLB.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
         "Errata": "HSD29, HSM30",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.STLB_MISS_STORES",
-        "L1_Hit_Indication": "1",
         "PEBS": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x12"
     },
     {
         "BriefDescription": "Demand and prefetch data reads",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.ALL_DATA_RD",
         "PublicDescription": "Data read requests sent to uncore (demand an=
d prefetch).",
@@ -656,8 +533,6 @@
     },
     {
         "BriefDescription": "Cacheable and noncacheable code read requests=
",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.DEMAND_CODE_RD",
         "PublicDescription": "Demand code read requests sent to uncore.",
@@ -666,8 +541,6 @@
     },
     {
         "BriefDescription": "Demand Data Read requests sent to uncore",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "HSD78, HSM80",
         "EventCode": "0xb0",
         "EventName": "OFFCORE_REQUESTS.DEMAND_DATA_RD",
@@ -677,8 +550,6 @@
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
@@ -687,8 +558,6 @@
     },
     {
         "BriefDescription": "Offcore requests buffer cannot take more entr=
ies for this thread core.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "OFFCORE_REQUESTS_BUFFER.SQ_FULL",
         "SampleAfterValue": "2000003",
@@ -696,8 +565,6 @@
     },
     {
         "BriefDescription": "Offcore outstanding cacheable Core Data Read =
transactions in SuperQueue (SQ), queue to uncore",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "HSD62, HSD61, HSM63",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD",
@@ -707,8 +574,6 @@
     },
     {
         "BriefDescription": "Cycles when offcore outstanding cacheable Cor=
e Data Read transactions are present in SuperQueue (SQ), queue to uncore.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "Errata": "HSD62, HSD61, HSM63",
         "EventCode": "0x60",
@@ -718,8 +583,6 @@
     },
     {
         "BriefDescription": "Cycles when offcore outstanding Demand Data R=
ead transactions are present in SuperQueue (SQ), queue to uncore.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "Errata": "HSD78, HSD62, HSD61, HSM63, HSM80",
         "EventCode": "0x60",
@@ -729,8 +592,6 @@
     },
     {
         "BriefDescription": "Offcore outstanding demand rfo reads transact=
ions in SuperQueue (SQ), queue to uncore, every cycle.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "Errata": "HSD62, HSD61, HSM63",
         "EventCode": "0x60",
@@ -740,8 +601,6 @@
     },
     {
         "BriefDescription": "Offcore outstanding code reads transactions i=
n SuperQueue (SQ), queue to uncore, every cycle",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "HSD62, HSD61, HSM63",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_CODE_RD",
@@ -751,8 +610,6 @@
     },
     {
         "BriefDescription": "Offcore outstanding Demand Data Read transact=
ions in uncore queue.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "HSD78, HSD62, HSD61, HSM63, HSM80",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD",
@@ -762,8 +619,6 @@
     },
     {
         "BriefDescription": "Cycles with at least 6 offcore outstanding De=
mand Data Read transactions in uncore queue.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "6",
         "Errata": "HSD78, HSD62, HSD61, HSM63, HSM80",
         "EventCode": "0x60",
@@ -773,8 +628,6 @@
     },
     {
         "BriefDescription": "Offcore outstanding RFO store transactions in=
 SuperQueue (SQ), queue to uncore",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "HSD62, HSD61, HSM63",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_RFO",
@@ -784,8 +637,6 @@
     },
     {
         "BriefDescription": "Offcore response can be programmed only with =
a specific pair of event select and counter MSR, and with specific event co=
des and predefine mask bit value in a dedicated MSR to specify attributes o=
f the offcore transaction.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE",
         "SampleAfterValue": "100003",
@@ -793,248 +644,186 @@
     },
     {
         "BriefDescription": "Counts all demand & prefetch code readshit in=
 the L3 and the snoops to sibling cores hit in either E/S state and the lin=
e is not forwarded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.L3_HIT.HIT_OTHER_CORE_N=
O_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0244",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data readshit in=
 the L3 and the snoop to one of the sibling cores hits the line in M state =
and the line is forwarded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_HIT.HITM_OTHER_CORE"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0091",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data readshit in=
 the L3 and the snoops to sibling cores hit in either E/S state and the lin=
e is not forwarded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_HIT.HIT_OTHER_CORE_N=
O_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0091",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "hit in the L3 and the snoop to one of the sib=
ling cores hits the line in M state and the line is forwarded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.L3_HIT.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C07F7",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "hit in the L3 and the snoops to sibling cores=
 hit in either E/S state and the line is not forwarded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.L3_HIT.HIT_OTHER_CORE_NO_=
FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C07F7",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all requestshit in the L3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_REQUESTS.L3_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C8FFF",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOshit in the L=
3 and the snoop to one of the sibling cores hits the line in M state and th=
e line is forwarded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_HIT.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0122",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOshit in the L=
3 and the snoops to sibling cores hit in either E/S state and the line is n=
ot forwarded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_HIT.HIT_OTHER_CORE_NO_FW=
D",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0122",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code readshit in the L3 and=
 the snoop to one of the sibling cores hits the line in M state and the lin=
e is forwarded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.HITM_OTHER_CO=
RE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code readshit in the L3 and=
 the snoops to sibling cores hit in either E/S state and the line is not fo=
rwarded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.HIT_OTHER_COR=
E_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data readshit in the L3 and the=
 snoop to one of the sibling cores hits the line in M state and the line is=
 forwarded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.HITM_OTHER_CO=
RE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data readshit in the L3 and the=
 snoops to sibling cores hit in either E/S state and the line is not forwar=
ded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.HIT_OTHER_COR=
E_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)hit in th=
e L3 and the snoop to one of the sibling cores hits the line in M state and=
 the line is forwarded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)hit in th=
e L3 and the snoops to sibling cores hit in either E/S state and the line i=
s not forwarded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.HIT_OTHER_CORE_NO=
_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code readshit in the L3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0040",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
readshit in the L3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0010",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOshit in the L3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0020",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code readshit in the L3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0200",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data readshit in the L3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0080",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOshit in the L3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0100",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Split locks in SQ",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xf4",
         "EventName": "SQ_MISC.SPLIT_LOCK",
         "SampleAfterValue": "100003",
diff --git a/tools/perf/pmu-events/arch/x86/haswell/floating-point.json b/t=
ools/perf/pmu-events/arch/x86/haswell/floating-point.json
index 7cf203a90a74..8fcc10f74ad9 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/floating-point.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Approximate counts of AVX & AVX2 256-bit inst=
ructions, including non-arithmetic instructions, loads, and stores.  May co=
unt non-AVX instructions that employ 256-bit operations, including (but not=
 necessarily limited to) rep string instructions that use 256-bit loads and=
 stores for optimized performance, XSAVE* and XRSTOR*, and operations that =
transition the x87 FPU data registers between x87 and MMX.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC6",
         "EventName": "AVX_INSTS.ALL",
         "PublicDescription": "Note that a whole rep string only counts AVX=
_INST.ALL once.",
@@ -11,8 +9,6 @@
     },
     {
         "BriefDescription": "Cycles with any input/output SSE or FP assist=
",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xCA",
         "EventName": "FP_ASSIST.ANY",
@@ -22,8 +18,6 @@
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
@@ -32,8 +26,6 @@
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
@@ -42,8 +34,6 @@
     },
     {
         "BriefDescription": "Number of X87 assists due to input value.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xCA",
         "EventName": "FP_ASSIST.X87_INPUT",
         "PublicDescription": "Number of X87 FP assists due to input values=
.",
@@ -52,8 +42,6 @@
     },
     {
         "BriefDescription": "Number of X87 assists due to output value.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xCA",
         "EventName": "FP_ASSIST.X87_OUTPUT",
         "PublicDescription": "Number of X87 FP assists due to output value=
s.",
@@ -62,8 +50,6 @@
     },
     {
         "BriefDescription": "Number of SIMD Move Elimination candidate uop=
s that were eliminated.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x58",
         "EventName": "MOVE_ELIMINATION.SIMD_ELIMINATED",
         "PublicDescription": "Number of SIMD move elimination candidate uo=
ps that were eliminated.",
@@ -72,8 +58,6 @@
     },
     {
         "BriefDescription": "Number of SIMD Move Elimination candidate uop=
s that were not eliminated.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x58",
         "EventName": "MOVE_ELIMINATION.SIMD_NOT_ELIMINATED",
         "PublicDescription": "Number of SIMD move elimination candidate uo=
ps that were not eliminated.",
@@ -82,8 +66,6 @@
     },
     {
         "BriefDescription": "Number of transitions from AVX-256 to legacy =
SSE when penalty applicable.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "HSD56, HSM57",
         "EventCode": "0xC1",
         "EventName": "OTHER_ASSISTS.AVX_TO_SSE",
@@ -92,8 +74,6 @@
     },
     {
         "BriefDescription": "Number of transitions from SSE to AVX-256 whe=
n penalty applicable.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "HSD56, HSM57",
         "EventCode": "0xC1",
         "EventName": "OTHER_ASSISTS.SSE_TO_AVX",
diff --git a/tools/perf/pmu-events/arch/x86/haswell/frontend.json b/tools/p=
erf/pmu-events/arch/x86/haswell/frontend.json
index 18a993297108..73d6d681dfa7 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/frontend.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Counts the total number when the front end is=
 resteered, mainly when the BPU cannot provide a correct prediction and thi=
s is corrected by other branch handling mechanisms at the front end.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe6",
         "EventName": "BACLEARS.ANY",
         "PublicDescription": "Number of front end re-steers due to BPU mis=
prediction.",
@@ -11,8 +9,6 @@
     },
     {
         "BriefDescription": "Decode Stream Buffer (DSB)-to-MITE switch tru=
e penalty cycles.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xAB",
         "EventName": "DSB2MITE_SWITCHES.PENALTY_CYCLES",
         "SampleAfterValue": "2000003",
@@ -20,8 +16,6 @@
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
@@ -29,8 +23,6 @@
     },
     {
         "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction-cache miss.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x80",
         "EventName": "ICACHE.IFDATA_STALL",
         "SampleAfterValue": "2000003",
@@ -38,8 +30,6 @@
     },
     {
         "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction-cache miss.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x80",
         "EventName": "ICACHE.IFETCH_STALL",
         "SampleAfterValue": "2000003",
@@ -47,8 +37,6 @@
     },
     {
         "BriefDescription": "Number of Instruction Cache, Streaming Buffer=
 and Victim Cache Misses. Includes Uncacheable accesses.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x80",
         "EventName": "ICACHE.MISSES",
         "PublicDescription": "This event counts Instruction Cache (ICACHE)=
 misses.",
@@ -57,8 +45,6 @@
     },
     {
         "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng 4 Uops",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_DSB_CYCLES_4_UOPS",
@@ -68,8 +54,6 @@
     },
     {
         "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng any Uop",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_DSB_CYCLES_ANY_UOPS",
@@ -79,8 +63,6 @@
     },
     {
         "BriefDescription": "Cycles MITE is delivering 4 Uops",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_MITE_CYCLES_4_UOPS",
@@ -90,8 +72,6 @@
     },
     {
         "BriefDescription": "Cycles MITE is delivering any Uop",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_MITE_CYCLES_ANY_UOPS",
@@ -101,8 +81,6 @@
     },
     {
         "BriefDescription": "Cycles when uops are being delivered to Instr=
uction Decode Queue (IDQ) from Decode Stream Buffer (DSB) path.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES",
@@ -111,8 +89,6 @@
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
@@ -121,8 +97,6 @@
     },
     {
         "BriefDescription": "Instruction Decode Queue (IDQ) empty cycles",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Errata": "HSD135",
         "EventCode": "0x79",
         "EventName": "IDQ.EMPTY",
@@ -132,8 +106,6 @@
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
@@ -142,8 +114,6 @@
     },
     {
         "BriefDescription": "Cycles when uops are being delivered to Instr=
uction Decode Queue (IDQ) from MITE path.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_CYCLES",
@@ -152,8 +122,6 @@
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
@@ -162,8 +130,6 @@
     },
     {
         "BriefDescription": "Cycles when uops are being delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequencer (MS) is busy",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_CYCLES",
@@ -173,8 +139,6 @@
     },
     {
         "BriefDescription": "Cycles when uops initiated by Decode Stream B=
uffer (DSB) are being delivered to Instruction Decode Queue (IDQ) while Mic=
rocode Sequencer (MS) is busy.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_DSB_CYCLES",
@@ -183,8 +147,6 @@
     },
     {
         "BriefDescription": "Deliveries to Instruction Decode Queue (IDQ) =
initiated by Decode Stream Buffer (DSB) while Microcode Sequencer (MS) is b=
usy.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x79",
@@ -194,8 +156,6 @@
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
@@ -204,8 +164,6 @@
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
@@ -214,8 +172,6 @@
     },
     {
         "BriefDescription": "Number of switches from DSB (Decode Stream Bu=
ffer) or MITE (legacy decode pipeline) to the Microcode Sequencer.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x79",
@@ -225,8 +181,6 @@
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) while Microcode Sequencer (MS) is busy",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_UOPS",
         "PublicDescription": "This event counts uops delivered by the Fron=
t-end with the assistance of the microcode sequencer.  Microcode assists ar=
e used for complex instructions or scenarios that can't be handled by the s=
tandard decoder.  Using other instructions, if possible, will usually impro=
ve performance.",
@@ -235,8 +189,6 @@
     },
     {
         "BriefDescription": "Uops not delivered to Resource Allocation Tab=
le (RAT) per thread when backend of the machine is not stalled",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Errata": "HSD135",
         "EventCode": "0x9C",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
@@ -246,8 +198,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when 4 or more uops are not=
 delivered to Resource Allocation Table (RAT) when backend of the machine i=
s not stalled",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "4",
         "Errata": "HSD135",
         "EventCode": "0x9C",
@@ -258,8 +208,6 @@
     },
     {
         "BriefDescription": "Counts cycles FE delivered 4 uops or Resource=
 Allocation Table (RAT) was stalling FE.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "Errata": "HSD135",
         "EventCode": "0x9C",
@@ -270,8 +218,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when 3 or more uops are not=
 delivered to Resource Allocation Table (RAT) when backend of the machine i=
s not stalled.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "3",
         "Errata": "HSD135",
         "EventCode": "0x9C",
@@ -281,8 +227,6 @@
     },
     {
         "BriefDescription": "Cycles with less than 2 uops delivered by the=
 front end.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "2",
         "Errata": "HSD135",
         "EventCode": "0x9C",
@@ -292,8 +236,6 @@
     },
     {
         "BriefDescription": "Cycles with less than 3 uops delivered by the=
 front end.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "Errata": "HSD135",
         "EventCode": "0x9C",
diff --git a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json b/tool=
s/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
index 6cb6603efbd8..2e032beee542 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
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
ACTIVITY.CYCLES_NO_EXECUTE) + (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@=
UOPS_EXECUTED.CORE\\,cmask\\=3D3@ if (IPC > 1.8) else cpu@UOPS_EXECUTED.COR=
E\\,cmask\\=3D2@) / 2 - RS_EVENTS.EMPTY_CYCLES if (tma_fetch_latency > 0.1)=
 else RESOURCE_STALLS.SB) if #SMT_on else (min(CPU_CLK_UNHALTED.THREAD, CYC=
LE_ACTIVITY.CYCLES_NO_EXECUTE) + cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cp=
u@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ if (IPC > 1.8) else cpu@UOPS_EXECUTED.C=
ORE\\,cmask\\=3D2@ - RS_EVENTS.EMPTY_CYCLES if (tma_fetch_latency > 0.1) el=
se RESOURCE_STALLS.SB)) * tma_backend_bound",
+        "MetricExpr": "((min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.STALL=
S_LDM_PENDING) + RESOURCE_STALLS.SB) / (min(CPU_CLK_UNHALTED.THREAD, CYCLE_=
ACTIVITY.CYCLES_NO_EXECUTE) + (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@=
UOPS_EXECUTED.CORE\\,cmask\\=3D3@ if IPC > 1.8 else cpu@UOPS_EXECUTED.CORE\=
\,cmask\\=3D2@) / 2 - RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 els=
e RESOURCE_STALLS.SB) if #SMT_on else (min(CPU_CLK_UNHALTED.THREAD, CYCLE_A=
CTIVITY.CYCLES_NO_EXECUTE) + cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UO=
PS_EXECUTED.CORE\\,cmask\\=3D3@ if IPC > 1.8 else (cpu@UOPS_EXECUTED.CORE\\=
,cmask\\=3D2@ - RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else RESO=
URCE_STALLS.SB))) * tma_backend_bound",
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
-        "MetricExpr": "(MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD_UOPS_RETI=
RED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS)) * CYCLE_ACTIVITY.STALLS_L2=
_PENDING / CLKS",
+        "MetricExpr": "MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD_UOPS_RETIR=
ED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS) * CYCLE_ACTIVITY.STALLS_L2_P=
ENDING / CLKS",
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
-        "MetricExpr": "(60 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HITM * (1 =
+ mem_load_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD=
_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOP=
S_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS) + MEM_=
LOAD_UOPS_RETIRED.L3_MISS))) + 43 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS=
 * (1 + mem_load_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + ME=
M_LOAD_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LO=
AD_UOPS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS) =
+ MEM_LOAD_UOPS_RETIRED.L3_MISS)))) / CLKS",
+        "MetricExpr": "(60 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HITM * (1 =
+ MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_=
UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS=
_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_LO=
AD_UOPS_RETIRED.L3_MISS))) + 43 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS *=
 (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_L=
OAD_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_=
UOPS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + ME=
M_LOAD_UOPS_RETIRED.L3_MISS)))) / CLKS",
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
-        "MetricExpr": "43 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT * (1 + =
mem_load_uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_U=
OPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_=
L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS) + MEM_LO=
AD_UOPS_RETIRED.L3_MISS))) / CLKS",
+        "MetricExpr": "43 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT * (1 + =
MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UO=
PS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_L=
3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_LOAD=
_UOPS_RETIRED.L3_MISS))) / CLKS",
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
-        "MetricExpr": "29 * (MEM_LOAD_UOPS_RETIRED.L3_HIT * (1 + mem_load_=
uops_retired.hit_lfb / ((MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UOPS_RETIR=
ED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_L3_HIT_RE=
TIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS) + MEM_LOAD_UOPS_R=
ETIRED.L3_MISS))) / CLKS",
+        "MetricExpr": "29 * (MEM_LOAD_UOPS_RETIRED.L3_HIT * (1 + MEM_LOAD_=
UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UOPS_RETIRE=
D.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_L3_HIT_RET=
IRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_LOAD_UOPS_RET=
IRED.L3_MISS))) / CLKS",
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
-        "MetricExpr": "(1 - (MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD_UOPS=
_RETIRED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS))) * CYCLE_ACTIVITY.STA=
LLS_L2_PENDING / CLKS",
+        "MetricExpr": "(1 - MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD_UOPS_=
RETIRED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS)) * CYCLE_ACTIVITY.STALL=
S_L2_PENDING / CLKS",
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
S_NO_EXECUTE) + (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UOPS_EXECUTED.=
CORE\\,cmask\\=3D3@ if (IPC > 1.8) else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D=
2@) / 2 - RS_EVENTS.EMPTY_CYCLES if (tma_fetch_latency > 0.1) else RESOURCE=
_STALLS.SB) if #SMT_on else (min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CY=
CLES_NO_EXECUTE) + cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UOPS_EXECUTE=
D.CORE\\,cmask\\=3D3@ if (IPC > 1.8) else cpu@UOPS_EXECUTED.CORE\\,cmask\\=
=3D2@ - RS_EVENTS.EMPTY_CYCLES if (tma_fetch_latency > 0.1) else RESOURCE_S=
TALLS.SB) - RESOURCE_STALLS.SB - min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVIT=
Y.STALLS_LDM_PENDING)) / CLKS",
+        "MetricExpr": "((min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLE=
S_NO_EXECUTE) + (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UOPS_EXECUTED.=
CORE\\,cmask\\=3D3@ if IPC > 1.8 else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@=
) / 2 - RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else RESOURCE_STA=
LLS.SB) if #SMT_on else (min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLES=
_NO_EXECUTE) + cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UOPS_EXECUTED.CO=
RE\\,cmask\\=3D3@ if IPC > 1.8 else (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@ =
- RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else RESOURCE_STALLS.SB=
)) - RESOURCE_STALLS.SB - min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.STALL=
S_LDM_PENDING)) / CLKS",
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
XECUTED.CORE\\,cmask\\=3D2@) / 2 if #SMT_on else (cpu@UOPS_EXECUTED.CORE\\,=
cmask\\=3D1@ - cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@) / CORE_CLKS",
+        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D2@) / 2 if #SMT_on else (cpu@UOPS_EXECUTED.CORE\\=
,cmask\\=3D1@ - cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@) / CORE_CLKS)",
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
XECUTED.CORE\\,cmask\\=3D3@) / 2 if #SMT_on else (cpu@UOPS_EXECUTED.CORE\\,=
cmask\\=3D2@ - cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@) / CORE_CLKS",
+        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D3@) / 2 if #SMT_on else (cpu@UOPS_EXECUTED.CORE\\=
,cmask\\=3D2@ - cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@) / CORE_CLKS)",
         "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
         "MetricName": "tma_ports_utilized_2",
         "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop.",
@@ -344,14 +344,14 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise).",
-        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ / 2) if #SM=
T_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@) / CORE_CLKS",
+        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ / 2 if #SMT_=
on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@) / CORE_CLKS",
         "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
         "MetricName": "tma_ports_utilized_3m",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
-        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_0 + UOPS_DISPATCHED_PORT=
.PORT_1 + UOPS_DISPATCHED_PORT.PORT_5 + UOPS_DISPATCHED_PORT.PORT_6) / (4 *=
 CORE_CLKS)",
+        "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_0 + UOPS_DISPATCHED_PORT=
.PORT_1 + UOPS_DISPATCHED_PORT.PORT_5 + UOPS_DISPATCHED_PORT.PORT_6) / SLOT=
S",
         "MetricGroup": "TopdownL5;tma_ports_utilized_3m_group",
         "MetricName": "tma_alu_op_utilization",
         "ScaleUnit": "100%"
@@ -407,7 +407,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Store operations",
-        "MetricExpr": "UOPS_DISPATCHED_PORT.PORT_4 / CORE_CLKS",
+        "MetricExpr": "tma_port_4",
         "MetricGroup": "TopdownL5;tma_ports_utilized_3m_group",
         "MetricName": "tma_store_op_utilization",
         "ScaleUnit": "100%"
@@ -460,7 +460,7 @@
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
@@ -526,13 +526,13 @@
     },
     {
         "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
-        "MetricExpr": "(UOPS_EXECUTED.CORE / 2 / ((cpu@UOPS_EXECUTED.CORE\=
\,cmask\\=3D1@ / 2) if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@))=
 if #SMT_on else UOPS_EXECUTED.CORE / ((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D=
1@ / 2) if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@)",
+        "MetricExpr": "(UOPS_EXECUTED.CORE / 2 / (cpu@UOPS_EXECUTED.CORE\\=
,cmask\\=3D1@ / 2 if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@) if=
 #SMT_on else UOPS_EXECUTED.CORE / (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ /=
 2 if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@))",
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
@@ -586,7 +586,7 @@
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
@@ -598,7 +598,7 @@
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
@@ -610,19 +610,19 @@
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
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L3_MISS / INST_RETIRED=
.ANY",
+        "MetricExpr": "1e3 * MEM_LOAD_UOPS_RETIRED.L3_MISS / INST_RETIRED.=
ANY",
         "MetricGroup": "CacheMisses;Mem",
         "MetricName": "L3MPKI"
     },
@@ -635,19 +635,19 @@
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
@@ -677,13 +677,13 @@
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
@@ -695,7 +695,7 @@
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
@@ -713,68 +713,87 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/haswell/memory.json b/tools/per=
f/pmu-events/arch/x86/haswell/memory.json
index 9e5a1e0966d9..9fb63e1dab08 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/memory.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/memory.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Number of times an HLE execution aborted due =
to any reasons (multiple categories may count as one).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.ABORTED",
         "PEBS": "1",
@@ -11,8 +9,6 @@
     },
     {
         "BriefDescription": "Number of times an HLE execution aborted due =
to various memory events (e.g., read/write capacity and conflicts).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.ABORTED_MISC1",
         "SampleAfterValue": "2000003",
@@ -20,8 +16,6 @@
     },
     {
         "BriefDescription": "Number of times an HLE execution aborted due =
to uncommon conditions.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.ABORTED_MISC2",
         "SampleAfterValue": "2000003",
@@ -29,8 +23,6 @@
     },
     {
         "BriefDescription": "Number of times an HLE execution aborted due =
to HLE-unfriendly instructions.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.ABORTED_MISC3",
         "SampleAfterValue": "2000003",
@@ -38,8 +30,6 @@
     },
     {
         "BriefDescription": "Number of times an HLE execution aborted due =
to incompatible memory type.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "HSD65",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.ABORTED_MISC4",
@@ -48,8 +38,6 @@
     },
     {
         "BriefDescription": "Number of times an HLE execution aborted due =
to none of the previous 4 categories (e.g. interrupts)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.ABORTED_MISC5",
         "PublicDescription": "Number of times an HLE execution aborted due=
 to none of the previous 4 categories (e.g. interrupts).",
@@ -58,8 +46,6 @@
     },
     {
         "BriefDescription": "Number of times an HLE execution successfully=
 committed.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.COMMIT",
         "SampleAfterValue": "2000003",
@@ -67,8 +53,6 @@
     },
     {
         "BriefDescription": "Number of times an HLE execution started.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC8",
         "EventName": "HLE_RETIRED.START",
         "SampleAfterValue": "2000003",
@@ -76,8 +60,6 @@
     },
     {
         "BriefDescription": "Counts the number of machine clears due to me=
mory order conflicts.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
         "PublicDescription": "This event counts the number of memory order=
ing machine clears detected. Memory ordering machine clears can result from=
 memory address aliasing or snoops from another hardware thread or core to =
data inflight in the pipeline.  Machine clears can have a significant perfo=
rmance impact if they are happening frequently.",
@@ -86,8 +68,6 @@
     },
     {
         "BriefDescription": "Randomly selected loads with latency value be=
ing above 128.",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "Data_LA": "1",
         "Errata": "HSD76, HSD25, HSM26",
         "EventCode": "0xcd",
@@ -96,13 +76,10 @@
         "MSRValue": "0x80",
         "PEBS": "2",
         "SampleAfterValue": "1009",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Randomly selected loads with latency value be=
ing above 16.",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "Data_LA": "1",
         "Errata": "HSD76, HSD25, HSM26",
         "EventCode": "0xcd",
@@ -111,13 +88,10 @@
         "MSRValue": "0x10",
         "PEBS": "2",
         "SampleAfterValue": "20011",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Randomly selected loads with latency value be=
ing above 256.",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "Data_LA": "1",
         "Errata": "HSD76, HSD25, HSM26",
         "EventCode": "0xcd",
@@ -126,13 +100,10 @@
         "MSRValue": "0x100",
         "PEBS": "2",
         "SampleAfterValue": "503",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Randomly selected loads with latency value be=
ing above 32.",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "Data_LA": "1",
         "Errata": "HSD76, HSD25, HSM26",
         "EventCode": "0xcd",
@@ -141,13 +112,10 @@
         "MSRValue": "0x20",
         "PEBS": "2",
         "SampleAfterValue": "100003",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Randomly selected loads with latency value be=
ing above 4.",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "Data_LA": "1",
         "Errata": "HSD76, HSD25, HSM26",
         "EventCode": "0xcd",
@@ -156,13 +124,10 @@
         "MSRValue": "0x4",
         "PEBS": "2",
         "SampleAfterValue": "100003",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Randomly selected loads with latency value be=
ing above 512.",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "Data_LA": "1",
         "Errata": "HSD76, HSD25, HSM26",
         "EventCode": "0xcd",
@@ -171,13 +136,10 @@
         "MSRValue": "0x200",
         "PEBS": "2",
         "SampleAfterValue": "101",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Randomly selected loads with latency value be=
ing above 64.",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "Data_LA": "1",
         "Errata": "HSD76, HSD25, HSM26",
         "EventCode": "0xcd",
@@ -186,13 +148,10 @@
         "MSRValue": "0x40",
         "PEBS": "2",
         "SampleAfterValue": "2003",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Randomly selected loads with latency value be=
ing above 8.",
-        "Counter": "3",
-        "CounterHTOff": "3",
         "Data_LA": "1",
         "Errata": "HSD76, HSD25, HSM26",
         "EventCode": "0xcd",
@@ -201,13 +160,10 @@
         "MSRValue": "0x8",
         "PEBS": "2",
         "SampleAfterValue": "50021",
-        "TakenAlone": "1",
         "UMask": "0x1"
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
@@ -216,8 +172,6 @@
     },
     {
         "BriefDescription": "Speculative cache line split STA uops dispatc=
hed to L1 cache",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x05",
         "EventName": "MISALIGN_MEM_REF.STORES",
         "PublicDescription": "Speculative cache-line split store-address u=
ops dispatched to L1D.",
@@ -226,260 +180,195 @@
     },
     {
         "BriefDescription": "Counts all demand & prefetch code readsmiss i=
n the L3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00244",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch code readsmiss t=
he L3 and the data is returned from local dram",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.L3_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400244",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data readsmiss i=
n the L3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00091",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch data readsmiss t=
he L3 and the data is returned from local dram",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400091",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "miss in the L3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC007F7",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "miss the L3 and the data is returned from loc=
al dram",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.L3_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004007F7",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all requestsmiss in the L3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_REQUESTS.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC08FFF",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOsmiss in the =
L3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00122",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand & prefetch RFOsmiss the L3 =
and the data is returned from local dram",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400122",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code readsmiss in the L3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.ANY_RESPONSE=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand code readsmiss the L3 and t=
he data is returned from local dram",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data readsmiss in the L3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.ANY_RESPONSE=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data readsmiss the L3 and the d=
ata is returned from local dram",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)miss in t=
he L3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all demand data writes (RFOs)miss the =
L3 and the data is returned from local dram",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code readsmiss in the L3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS.ANY_RESPONSE"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00040",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to L2) data =
readsmiss in the L3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS.ANY_RESPONSE"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00010",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOsmiss in the L3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00020",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code readsmiss in the L3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS.ANY_RESPONSE"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00200",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data readsmiss in the L3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS.ANY_RESPONSE"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00080",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOsmiss in the L3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00100",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to any reasons (multiple categories may count as one).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED",
         "PEBS": "1",
@@ -488,8 +377,6 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to various memory events (e.g. read/write capacity and conflicts)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_MISC1",
         "PublicDescription": "Number of times an RTM execution aborted due=
 to various memory events (e.g. read/write capacity and conflicts).",
@@ -498,8 +385,6 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to various memory events (e.g., read/write capacity and conflicts).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_MISC2",
         "SampleAfterValue": "2000003",
@@ -507,8 +392,6 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to HLE-unfriendly instructions.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_MISC3",
         "SampleAfterValue": "2000003",
@@ -516,8 +399,6 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to incompatible memory type.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Errata": "HSD65",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_MISC4",
@@ -526,8 +407,6 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to none of the previous 4 categories (e.g. interrupt)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_MISC5",
         "PublicDescription": "Number of times an RTM execution aborted due=
 to none of the previous 4 categories (e.g. interrupt).",
@@ -536,8 +415,6 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution successfully=
 committed.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.COMMIT",
         "SampleAfterValue": "2000003",
@@ -545,8 +422,6 @@
     },
     {
         "BriefDescription": "Number of times an RTM execution started.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xC9",
         "EventName": "RTM_RETIRED.START",
         "SampleAfterValue": "2000003",
@@ -554,8 +429,6 @@
     },
     {
         "BriefDescription": "Counts the number of times a class of instruc=
tions that may cause a transactional abort was executed. Since this is the =
count of execution, it may not always cause a transactional abort.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5d",
         "EventName": "TX_EXEC.MISC1",
         "SampleAfterValue": "2000003",
@@ -563,8 +436,6 @@
     },
     {
         "BriefDescription": "Counts the number of times a class of instruc=
tions (e.g., vzeroupper) that may cause a transactional abort was executed =
inside a transactional region.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5d",
         "EventName": "TX_EXEC.MISC2",
         "SampleAfterValue": "2000003",
@@ -572,8 +443,6 @@
     },
     {
         "BriefDescription": "Counts the number of times an instruction exe=
cution caused the transactional nest count supported to be exceeded.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5d",
         "EventName": "TX_EXEC.MISC3",
         "SampleAfterValue": "2000003",
@@ -581,8 +450,6 @@
     },
     {
         "BriefDescription": "Counts the number of times a XBEGIN instructi=
on was executed inside an HLE transactional region.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5d",
         "EventName": "TX_EXEC.MISC4",
         "SampleAfterValue": "2000003",
@@ -590,8 +457,6 @@
     },
     {
         "BriefDescription": "Counts the number of times an HLE XACQUIRE in=
struction was executed inside an RTM transactional region.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5d",
         "EventName": "TX_EXEC.MISC5",
         "SampleAfterValue": "2000003",
@@ -599,8 +464,6 @@
     },
     {
         "BriefDescription": "Number of times a transactional abort was sig=
naled due to a data capacity limitation for transactional writes.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_CAPACITY_WRITE",
         "SampleAfterValue": "2000003",
@@ -608,8 +471,6 @@
     },
     {
         "BriefDescription": "Number of times a transactional abort was sig=
naled due to a data conflict on a transactionally accessed address.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_CONFLICT",
         "SampleAfterValue": "2000003",
@@ -617,8 +478,6 @@
     },
     {
         "BriefDescription": "Number of times an HLE transactional executio=
n aborted due to XRELEASE lock not satisfying the address and value require=
ments in the elision buffer.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_HLE_ELISION_BUFFER_MISMATCH",
         "SampleAfterValue": "2000003",
@@ -626,8 +485,6 @@
     },
     {
         "BriefDescription": "Number of times an HLE transactional executio=
n aborted due to NoAllocatedElisionBuffer being non-zero.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_HLE_ELISION_BUFFER_NOT_EMPTY",
         "SampleAfterValue": "2000003",
@@ -635,8 +492,6 @@
     },
     {
         "BriefDescription": "Number of times an HLE transactional executio=
n aborted due to an unsupported read alignment from the elision buffer.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_HLE_ELISION_BUFFER_UNSUPPORTED_ALIGNMEN=
T",
         "SampleAfterValue": "2000003",
@@ -644,8 +499,6 @@
     },
     {
         "BriefDescription": "Number of times a HLE transactional region ab=
orted due to a non XRELEASE prefixed instruction writing to an elided lock =
in the elision buffer.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_HLE_STORE_TO_ELIDED_LOCK",
         "SampleAfterValue": "2000003",
@@ -653,8 +506,6 @@
     },
     {
         "BriefDescription": "Number of times HLE lock could not be elided =
due to ElisionBufferAvailable being zero.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x54",
         "EventName": "TX_MEM.HLE_ELISION_BUFFER_FULL",
         "SampleAfterValue": "2000003",
diff --git a/tools/perf/pmu-events/arch/x86/haswell/other.json b/tools/perf=
/pmu-events/arch/x86/haswell/other.json
index 7ca34f09b185..2395ebf112db 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/other.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/other.json
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
hile thread is in ring 0.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x5C",
@@ -22,8 +18,6 @@
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
@@ -32,8 +26,6 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/haswell/pipeline.json b/tools/p=
erf/pmu-events/arch/x86/haswell/pipeline.json
index 42f6a8100661..9ac36c1c24b6 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Any uop executed by the Divider. (This includ=
es all divide uops, sqrt, ...)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x14",
         "EventName": "ARITH.DIVIDER_UOPS",
         "SampleAfterValue": "2000003",
@@ -10,8 +8,6 @@
     },
     {
         "BriefDescription": "Speculative and retired  branches",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_BRANCHES",
         "PublicDescription": "Counts all near executed branches (not neces=
sarily retired).",
@@ -20,8 +16,6 @@
     },
     {
         "BriefDescription": "Speculative and retired macro-conditional bra=
nches.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_CONDITIONAL",
         "SampleAfterValue": "200003",
@@ -29,8 +23,6 @@
     },
     {
         "BriefDescription": "Speculative and retired macro-unconditional b=
ranches excluding calls and indirects.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_DIRECT_JMP",
         "SampleAfterValue": "200003",
@@ -38,8 +30,6 @@
     },
     {
         "BriefDescription": "Speculative and retired direct near calls.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_DIRECT_NEAR_CALL",
         "SampleAfterValue": "200003",
@@ -47,8 +37,6 @@
     },
     {
         "BriefDescription": "Speculative and retired indirect branches exc=
luding calls and returns.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_INDIRECT_JUMP_NON_CALL_RET",
         "SampleAfterValue": "200003",
@@ -56,8 +44,6 @@
     },
     {
         "BriefDescription": "Speculative and retired indirect return branc=
hes.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ALL_INDIRECT_NEAR_RETURN",
         "SampleAfterValue": "200003",
@@ -65,8 +51,6 @@
     },
     {
         "BriefDescription": "Not taken macro-conditional branches.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.NONTAKEN_CONDITIONAL",
         "SampleAfterValue": "200003",
@@ -74,8 +58,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired macro-condition=
al branches.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_CONDITIONAL",
         "SampleAfterValue": "200003",
@@ -83,8 +65,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired macro-condition=
al branch instructions excluding calls and indirects.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_DIRECT_JUMP",
         "SampleAfterValue": "200003",
@@ -92,8 +72,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired direct near cal=
ls.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_DIRECT_NEAR_CALL",
         "SampleAfterValue": "200003",
@@ -101,8 +79,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired indirect branch=
es excluding calls and returns.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_INDIRECT_JUMP_NON_CALL_RET",
         "SampleAfterValue": "200003",
@@ -110,8 +86,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired indirect calls.=
",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_INDIRECT_NEAR_CALL",
         "SampleAfterValue": "200003",
@@ -119,8 +93,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired indirect branch=
es with return mnemonic.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN_INDIRECT_NEAR_RETURN",
         "SampleAfterValue": "200003",
@@ -128,8 +100,6 @@
     },
     {
         "BriefDescription": "All (macro) branch instructions retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PublicDescription": "Branch instructions at retirement.",
@@ -137,8 +107,6 @@
     },
     {
         "BriefDescription": "All (macro) branch instructions retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES_PEBS",
         "PEBS": "2",
@@ -147,8 +115,6 @@
     },
     {
         "BriefDescription": "Conditional branch instructions retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.CONDITIONAL",
         "PEBS": "1",
@@ -158,8 +124,6 @@
     },
     {
         "BriefDescription": "Far branch instructions retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
         "PublicDescription": "Number of far branches retired.",
@@ -168,8 +132,6 @@
     },
     {
         "BriefDescription": "Direct and indirect near call instructions re=
tired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
         "PEBS": "1",
@@ -178,8 +140,6 @@
     },
     {
         "BriefDescription": "Direct and indirect macro near call instructi=
ons retired (captured in ring 3).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL_R3",
         "PEBS": "1",
@@ -188,8 +148,6 @@
     },
     {
         "BriefDescription": "Return instructions retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
         "PEBS": "1",
@@ -199,8 +157,6 @@
     },
     {
         "BriefDescription": "Taken branch instructions retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
         "PEBS": "1",
@@ -210,8 +166,6 @@
     },
     {
         "BriefDescription": "Not taken branch instructions retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NOT_TAKEN",
         "PublicDescription": "Counts the number of not taken branch instru=
ctions retired.",
@@ -220,8 +174,6 @@
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
@@ -230,8 +182,6 @@
     },
     {
         "BriefDescription": "Speculative and retired mispredicted macro co=
nditional branches.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.ALL_CONDITIONAL",
         "SampleAfterValue": "200003",
@@ -239,8 +189,6 @@
     },
     {
         "BriefDescription": "Mispredicted indirect branches excluding call=
s and returns.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.ALL_INDIRECT_JUMP_NON_CALL_RET",
         "SampleAfterValue": "200003",
@@ -248,8 +196,6 @@
     },
     {
         "BriefDescription": "Not taken speculative and retired mispredicte=
d macro conditional branches.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.NONTAKEN_CONDITIONAL",
         "SampleAfterValue": "200003",
@@ -257,8 +203,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired mispredicted ma=
cro conditional branches.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.TAKEN_CONDITIONAL",
         "SampleAfterValue": "200003",
@@ -266,8 +210,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired mispredicted in=
direct branches excluding calls and returns.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.TAKEN_INDIRECT_JUMP_NON_CALL_RET",
         "SampleAfterValue": "200003",
@@ -275,8 +217,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired mispredicted in=
direct calls.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.TAKEN_INDIRECT_NEAR_CALL",
         "SampleAfterValue": "200003",
@@ -284,8 +224,6 @@
     },
     {
         "BriefDescription": "Taken speculative and retired mispredicted in=
direct branches with return mnemonic.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.TAKEN_RETURN_NEAR",
         "SampleAfterValue": "200003",
@@ -293,8 +231,6 @@
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
@@ -302,8 +238,6 @@
     },
     {
         "BriefDescription": "Mispredicted macro branch instructions retire=
d.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES_PEBS",
         "PEBS": "2",
@@ -313,8 +247,6 @@
     },
     {
         "BriefDescription": "Mispredicted conditional branch instructions =
retired.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.CONDITIONAL",
         "PEBS": "1",
@@ -323,8 +255,6 @@
     },
     {
         "BriefDescription": "number of near branch instructions retired th=
at were mispredicted and taken.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
         "PEBS": "1",
@@ -334,8 +264,6 @@
     },
     {
         "BriefDescription": "Count XClk pulses when this thread is unhalte=
d and the other thread is halted.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE",
         "SampleAfterValue": "100003",
@@ -343,8 +271,6 @@
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
@@ -354,8 +280,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Reference cycles when the at least one thread=
 on the physical core is unhalted (counts at 100 MHz rate)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY",
         "PublicDescription": "Reference cycles when the at least one threa=
d on the physical core is unhalted (counts at 100 MHz rate).",
@@ -364,8 +288,6 @@
     },
     {
         "BriefDescription": "Count XClk pulses when this thread is unhalte=
d and the other thread is halted.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
         "SampleAfterValue": "100003",
@@ -373,8 +295,6 @@
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
ate.",
         "SampleAfterValue": "2000003",
@@ -382,8 +302,6 @@
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
@@ -393,8 +311,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Reference cycles when the at least one thread=
 on the physical core is unhalted (counts at 100 MHz rate)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.REF_XCLK_ANY",
         "PublicDescription": "Reference cycles when the at least one threa=
d on the physical core is unhalted (counts at 100 MHz rate).",
@@ -403,8 +319,6 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt st=
ate.",
-        "Counter": "Fixed counter 1",
-        "CounterHTOff": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "This event counts the number of thread cycle=
s while the thread is not in a halt state. The thread enters the halt state=
 when it is running the HLT instruction. The core frequency may change from=
 time to time due to power or thermal throttling.",
         "SampleAfterValue": "2000003",
@@ -413,16 +327,12 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core cycles when at least one thread on the p=
hysical core is not in halt state.",
-        "Counter": "Fixed counter 1",
-        "CounterHTOff": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
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
@@ -431,16 +341,12 @@
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
         "BriefDescription": "Cycles with pending L1 cache miss loads.",
-        "Counter": "2",
-        "CounterHTOff": "2",
         "CounterMask": "8",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_PENDING",
@@ -450,8 +356,6 @@
     },
     {
         "BriefDescription": "Cycles with pending L2 cache miss loads.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "Errata": "HSD78, HSM63, HSM80",
         "EventCode": "0xa3",
@@ -462,8 +366,6 @@
     },
     {
         "BriefDescription": "Cycles with pending memory loads.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "2",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_LDM_PENDING",
@@ -473,8 +375,6 @@
     },
     {
         "BriefDescription": "This event increments by 1 for every cycle wh=
ere there was no execute for this thread.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "4",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_NO_EXECUTE",
@@ -484,8 +384,6 @@
     },
     {
         "BriefDescription": "Execution stalls due to L1 data cache misses"=
,
-        "Counter": "2",
-        "CounterHTOff": "2",
         "CounterMask": "12",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L1D_PENDING",
@@ -495,8 +393,6 @@
     },
     {
         "BriefDescription": "Execution stalls due to L2 cache misses.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "5",
         "Errata": "HSM63, HSM80",
         "EventCode": "0xa3",
@@ -507,8 +403,6 @@
     },
     {
         "BriefDescription": "Execution stalls due to memory subsystem.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "6",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.STALLS_LDM_PENDING",
@@ -518,8 +412,6 @@
     },
     {
         "BriefDescription": "Stall cycles because IQ is full",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x87",
         "EventName": "ILD_STALL.IQ_FULL",
         "PublicDescription": "Stall cycles due to IQ is full.",
@@ -528,8 +420,6 @@
     },
     {
         "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x87",
         "EventName": "ILD_STALL.LCP",
         "PublicDescription": "This event counts cycles where the decoder i=
s stalled on an instruction with a length changing prefix (LCP).",
@@ -538,8 +428,6 @@
     },
     {
         "BriefDescription": "Instructions retired from execution.",
-        "Counter": "Fixed counter 0",
-        "CounterHTOff": "Fixed counter 0",
         "Errata": "HSD140, HSD143",
         "EventName": "INST_RETIRED.ANY",
         "PublicDescription": "This event counts the number of instructions=
 retired from execution. For instructions that consist of multiple micro-op=
s, this event counts the retirement of the last micro-op of the instruction=
. Counting continues during hardware interrupts, traps, and inside interrup=
t handlers. INST_RETIRED.ANY is counted by a designated fixed counter, leav=
ing the programmable counters available for other events. Faulting executio=
ns of GETSEC/VM entry/VM Exit/MWait will not count as retired instructions.=
",
@@ -548,8 +436,6 @@
     },
     {
         "BriefDescription": "Number of instructions retired. General Count=
er   - architectural event",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "HSD11, HSD140",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.ANY_P",
@@ -558,8 +444,6 @@
     },
     {
         "BriefDescription": "Precise instruction retired event with HW to =
reduce effect of PEBS shadow in IP distribution",
-        "Counter": "1",
-        "CounterHTOff": "1",
         "Errata": "HSD140",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.PREC_DIST",
@@ -570,8 +454,6 @@
     },
     {
         "BriefDescription": "FP operations retired. X87 FP operations that=
 have no exceptions: Counts also flows that have several X87 or flows that =
use X87 uops in the exception handling.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.X87",
         "PublicDescription": "This is a non-precise version (that is, does=
 not use PEBS) of the event that counts FP operations retired. For X87 FP o=
perations that have no exceptions counting also includes flows that have se=
veral X87, or flows that use X87 uops in the exception handling.",
@@ -580,8 +462,6 @@
     },
     {
         "BriefDescription": "Core cycles the allocator was stalled due to =
recovery from earlier clear event for this thread (e.g. misprediction or me=
mory nuke)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x0D",
         "EventName": "INT_MISC.RECOVERY_CYCLES",
@@ -592,8 +472,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Core cycles the allocator was stalled due to =
recovery from earlier clear event for any thread running on the physical co=
re (e.g. misprediction or memory nuke)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x0D",
         "EventName": "INT_MISC.RECOVERY_CYCLES_ANY",
@@ -603,8 +481,6 @@
     },
     {
         "BriefDescription": "The number of times that split load operation=
s are temporarily blocked because all resources for handling the split acce=
sses are in use",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.NO_SR",
         "PublicDescription": "The number of times that split load operatio=
ns are temporarily blocked because all resources for handling the split acc=
esses are in use.",
@@ -613,8 +489,6 @@
     },
     {
         "BriefDescription": "loads blocked by overlapping with store buffe=
r that cannot be forwarded",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
         "PublicDescription": "This event counts loads that followed a stor=
e to the same address, where the data could not be forwarded inside the pip=
eline from the store to the load.  The most common reason why store forward=
ing would be blocked is when a load's address range overlaps with a precedi=
ng smaller uncompleted store. The penalty for blocked store forwarding is t=
hat the load must wait for the store to write its value to the cache before=
 it can be issued.",
@@ -623,8 +497,6 @@
     },
     {
         "BriefDescription": "False dependencies in MOB due to partial comp=
are on address.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x07",
         "EventName": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS",
         "PublicDescription": "Aliasing occurs when a load is issued after =
a store and their memory addresses are offset by 4K.  This event counts the=
 number of loads that aliased with a preceding store, resulting in an exten=
ded address check in the pipeline which can have a performance impact.",
@@ -633,8 +505,6 @@
     },
     {
         "BriefDescription": "Not software-prefetch load dispatches that hi=
t FB allocated for hardware prefetch",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x4c",
         "EventName": "LOAD_HIT_PRE.HW_PF",
         "PublicDescription": "Non-SW-prefetch load dispatches that hit fil=
l buffer allocated for H/W prefetch.",
@@ -643,8 +513,6 @@
     },
     {
         "BriefDescription": "Not software-prefetch load dispatches that hi=
t FB allocated for software prefetch",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x4c",
         "EventName": "LOAD_HIT_PRE.SW_PF",
         "PublicDescription": "Non-SW-prefetch load dispatches that hit fil=
l buffer allocated for S/W prefetch.",
@@ -653,8 +521,6 @@
     },
     {
         "BriefDescription": "Cycles 4 Uops delivered by the LSD, but didn'=
t come from the decoder.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0xA8",
         "EventName": "LSD.CYCLES_4_UOPS",
@@ -663,8 +529,6 @@
     },
     {
         "BriefDescription": "Cycles Uops delivered by the LSD, but didn't =
come from the decoder.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xA8",
         "EventName": "LSD.CYCLES_ACTIVE",
@@ -673,8 +537,6 @@
     },
     {
         "BriefDescription": "Number of Uops delivered by the LSD.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa8",
         "EventName": "LSD.UOPS",
         "PublicDescription": "Number of uops delivered by the LSD.",
@@ -683,8 +545,6 @@
     },
     {
         "BriefDescription": "Number of machine clears (nukes) of any type.=
",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0xC3",
@@ -694,8 +554,6 @@
     },
     {
         "BriefDescription": "Cycles there was a Nuke. Account for both thr=
ead-specific and All Thread Nukes.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.CYCLES",
         "SampleAfterValue": "2000003",
@@ -703,8 +561,6 @@
     },
     {
         "BriefDescription": "This event counts the number of executed Inte=
l AVX masked load operations that refer to an illegal address range with th=
e mask bits set to 0.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MASKMOV",
         "SampleAfterValue": "100003",
@@ -712,8 +568,6 @@
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
@@ -722,8 +576,6 @@
     },
     {
         "BriefDescription": "Number of integer Move Elimination candidate =
uops that were eliminated.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x58",
         "EventName": "MOVE_ELIMINATION.INT_ELIMINATED",
         "PublicDescription": "Number of integer move elimination candidate=
 uops that were eliminated.",
@@ -732,8 +584,6 @@
     },
     {
         "BriefDescription": "Number of integer Move Elimination candidate =
uops that were not eliminated.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x58",
         "EventName": "MOVE_ELIMINATION.INT_NOT_ELIMINATED",
         "PublicDescription": "Number of integer move elimination candidate=
 uops that were not eliminated.",
@@ -742,8 +592,6 @@
     },
     {
         "BriefDescription": "Number of times any microcode assist is invok=
ed by HW upon uop writeback.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC1",
         "EventName": "OTHER_ASSISTS.ANY_WB_ASSIST",
         "PublicDescription": "Number of microcode assists invoked by HW up=
on uop writeback.",
@@ -752,8 +600,6 @@
     },
     {
         "BriefDescription": "Resource-related stall cycles",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "HSD135",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.ANY",
@@ -763,8 +609,6 @@
     },
     {
         "BriefDescription": "Cycles stalled due to re-order buffer full.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.ROB",
         "SampleAfterValue": "2000003",
@@ -772,8 +616,6 @@
     },
     {
         "BriefDescription": "Cycles stalled due to no eligible RS entry av=
ailable.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.RS",
         "SampleAfterValue": "2000003",
@@ -781,8 +623,6 @@
     },
     {
         "BriefDescription": "Cycles stalled due to no store buffers availa=
ble. (not including draining form sync).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.SB",
         "PublicDescription": "This event counts cycles during which no ins=
tructions were allocated because no Store Buffers (SB) were available.",
@@ -791,8 +631,6 @@
     },
     {
         "BriefDescription": "Count cases of saving new LBR",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xCC",
         "EventName": "ROB_MISC_EVENTS.LBR_INSERTS",
         "PublicDescription": "Count cases of saving new LBR records by har=
dware.",
@@ -801,8 +639,6 @@
     },
     {
         "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 for the thread",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5E",
         "EventName": "RS_EVENTS.EMPTY_CYCLES",
         "PublicDescription": "This event counts cycles when the Reservatio=
n Station ( RS ) is empty for the thread. The RS is a structure that buffer=
s allocated micro-ops from the Front-end. If there are many cycles when the=
 RS is empty, it may represent an underflow of instructions delivered from =
the Front-end.",
@@ -811,8 +647,6 @@
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
@@ -823,8 +657,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 0.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_0",
         "SampleAfterValue": "2000003",
@@ -832,8 +664,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 1.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_1",
         "SampleAfterValue": "2000003",
@@ -841,8 +671,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 2.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_2",
         "SampleAfterValue": "2000003",
@@ -850,8 +678,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 3.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_3",
         "SampleAfterValue": "2000003",
@@ -859,8 +685,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 4.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_4",
         "SampleAfterValue": "2000003",
@@ -868,8 +692,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 5.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_5",
         "SampleAfterValue": "2000003",
@@ -877,8 +699,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 6.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_6",
         "SampleAfterValue": "2000003",
@@ -886,8 +706,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 7.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_DISPATCHED_PORT.PORT_7",
         "SampleAfterValue": "2000003",
@@ -895,8 +713,6 @@
     },
     {
         "BriefDescription": "Number of uops executed on the core.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "HSD30, HSM31",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE",
@@ -906,8 +722,6 @@
     },
     {
         "BriefDescription": "Cycles at least 1 micro-op is executed from a=
ny thread on physical core.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "Errata": "HSD30, HSM31",
         "EventCode": "0xb1",
@@ -917,8 +731,6 @@
     },
     {
         "BriefDescription": "Cycles at least 2 micro-op is executed from a=
ny thread on physical core.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "2",
         "Errata": "HSD30, HSM31",
         "EventCode": "0xb1",
@@ -928,8 +740,6 @@
     },
     {
         "BriefDescription": "Cycles at least 3 micro-op is executed from a=
ny thread on physical core.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "3",
         "Errata": "HSD30, HSM31",
         "EventCode": "0xb1",
@@ -939,8 +749,6 @@
     },
     {
         "BriefDescription": "Cycles at least 4 micro-op is executed from a=
ny thread on physical core.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "Errata": "HSD30, HSM31",
         "EventCode": "0xb1",
@@ -950,8 +758,6 @@
     },
     {
         "BriefDescription": "Cycles with no micro-ops executed from any th=
read on physical core.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "Errata": "HSD30, HSM31",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_NONE",
@@ -961,8 +767,6 @@
     },
     {
         "BriefDescription": "Cycles where at least 1 uop was executed per-=
thread",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "Errata": "HSD144, HSD30, HSM31",
         "EventCode": "0xB1",
@@ -973,8 +777,6 @@
     },
     {
         "BriefDescription": "Cycles where at least 2 uops were executed pe=
r-thread",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "2",
         "Errata": "HSD144, HSD30, HSM31",
         "EventCode": "0xB1",
@@ -985,8 +787,6 @@
     },
     {
         "BriefDescription": "Cycles where at least 3 uops were executed pe=
r-thread",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "3",
         "Errata": "HSD144, HSD30, HSM31",
         "EventCode": "0xB1",
@@ -997,8 +797,6 @@
     },
     {
         "BriefDescription": "Cycles where at least 4 uops were executed pe=
r-thread.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "4",
         "Errata": "HSD144, HSD30, HSM31",
         "EventCode": "0xB1",
@@ -1008,8 +806,6 @@
     },
     {
         "BriefDescription": "Counts number of cycles no uops were dispatch=
ed to be executed on this thread.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "Errata": "HSD144, HSD30, HSM31",
         "EventCode": "0xB1",
@@ -1020,8 +816,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 0",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_0",
         "PublicDescription": "Cycles which a uop is dispatched on port 0 i=
n this thread.",
@@ -1031,8 +825,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are executed in por=
t 0.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_0_CORE",
         "SampleAfterValue": "2000003",
@@ -1040,8 +832,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 1",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_1",
         "PublicDescription": "Cycles which a uop is dispatched on port 1 i=
n this thread.",
@@ -1051,8 +841,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are executed in por=
t 1.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_1_CORE",
         "SampleAfterValue": "2000003",
@@ -1060,8 +848,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 2",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_2",
         "PublicDescription": "Cycles which a uop is dispatched on port 2 i=
n this thread.",
@@ -1071,8 +857,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are dispatched to p=
ort 2.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_2_CORE",
         "SampleAfterValue": "2000003",
@@ -1080,8 +864,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 3",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_3",
         "PublicDescription": "Cycles which a uop is dispatched on port 3 i=
n this thread.",
@@ -1091,8 +873,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are dispatched to p=
ort 3.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_3_CORE",
         "SampleAfterValue": "2000003",
@@ -1100,8 +880,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 4",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_4",
         "PublicDescription": "Cycles which a uop is dispatched on port 4 i=
n this thread.",
@@ -1111,8 +889,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are executed in por=
t 4.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_4_CORE",
         "SampleAfterValue": "2000003",
@@ -1120,8 +896,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 5",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_5",
         "PublicDescription": "Cycles which a uop is dispatched on port 5 i=
n this thread.",
@@ -1131,8 +905,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are executed in por=
t 5.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_5_CORE",
         "SampleAfterValue": "2000003",
@@ -1140,8 +912,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 6",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_6",
         "PublicDescription": "Cycles which a uop is dispatched on port 6 i=
n this thread.",
@@ -1151,8 +921,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are executed in por=
t 6.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_6_CORE",
         "SampleAfterValue": "2000003",
@@ -1160,8 +928,6 @@
     },
     {
         "BriefDescription": "Cycles per thread when uops are executed in p=
ort 7",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_7",
         "PublicDescription": "Cycles which a uop is dispatched on port 7 i=
n this thread.",
@@ -1171,8 +937,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles per core when uops are dispatched to p=
ort 7.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_7_CORE",
         "SampleAfterValue": "2000003",
@@ -1180,8 +944,6 @@
     },
     {
         "BriefDescription": "Uops that Resource Allocation Table (RAT) iss=
ues to Reservation Station (RS)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.ANY",
         "PublicDescription": "This event counts the number of uops issued =
by the Front-end of the pipeline to the Back-end. This event is counted at =
the allocation stage and will count both retired and non-retired uops.",
@@ -1191,8 +953,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles when Resource Allocation Table (RAT) d=
oes not issue Uops to Reservation Station (RS) for all threads.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.CORE_STALL_CYCLES",
@@ -1202,8 +962,6 @@
     },
     {
         "BriefDescription": "Number of flags-merge uops being allocated. S=
uch uops considered perf sensitive; added by GSR u-arch.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.FLAGS_MERGE",
         "PublicDescription": "Number of flags-merge uops allocated. Such u=
ops add delay.",
@@ -1212,8 +970,6 @@
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
@@ -1222,8 +978,6 @@
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
. Such uop has 3 sources (for example, 2 sources + immediate) regardless of=
 whether it is a result of LEA instruction or not.",
@@ -1232,8 +986,6 @@
     },
     {
         "BriefDescription": "Cycles when Resource Allocation Table (RAT) d=
oes not issue Uops to Reservation Station (RS) for the thread.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.STALL_CYCLES",
@@ -1243,8 +995,6 @@
     },
     {
         "BriefDescription": "Actually retired uops.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.ALL",
         "PEBS": "1",
@@ -1255,8 +1005,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles without actually retired uops.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.CORE_STALL_CYCLES",
@@ -1266,8 +1014,6 @@
     },
     {
         "BriefDescription": "Retirement slots used.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.RETIRE_SLOTS",
         "PEBS": "1",
@@ -1277,8 +1023,6 @@
     },
     {
         "BriefDescription": "Cycles without actually retired uops.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.STALL_CYCLES",
@@ -1288,8 +1032,6 @@
     },
     {
         "BriefDescription": "Cycles with less than 10 actually retired uop=
s.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "CounterMask": "16",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.TOTAL_CYCLES",
diff --git a/tools/perf/pmu-events/arch/x86/haswell/uncore-cache.json b/too=
ls/perf/pmu-events/arch/x86/haswell/uncore-cache.json
index 6b0639944d78..c538557ba4c0 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/uncore-cache.json
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
diff --git a/tools/perf/pmu-events/arch/x86/haswell/uncore-other.json b/too=
ls/perf/pmu-events/arch/x86/haswell/uncore-other.json
index 56c4b380dc95..84cc2536de69 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/uncore-other.json
@@ -5,17 +5,15 @@
         "EventName": "UNC_ARB_COH_TRK_OCCUPANCY.All",
         "PerPkg": "1",
         "PublicDescription": "Each cycle count number of valid entries in =
Coherency Tracker queue from allocation till deallocation. Aperture request=
s (snoops) appear as NC decoded internally and become coherent (snoop L3, a=
ccess memory).",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "ARB"
     },
     {
         "BriefDescription": "Number of entries allocated. Account for Any =
type: e.g. Snoop, Core aperture, etc.",
-        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
         "PerPkg": "1",
-        "PublicDescription": "Number of entries allocated. Account for Any=
 type: e.g. Snoop, Core aperture, etc.",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "ARB"
     },
     {
@@ -23,48 +21,39 @@
         "EventCode": "0x80",
         "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
         "PerPkg": "1",
-        "PublicDescription": "Each cycle counts number of all Core outgoin=
g valid entries. Such entry is defined as valid from its allocation till fi=
rst of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coh=
erent traffic.",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "ARB"
     },
     {
         "BriefDescription": "Cycles with at least one request outstanding =
is waiting for data return from memory controller. Account for coherent and=
 non-coherent requests initiated by IA Cores, Processor Graphics Unit, or L=
LC.",
-        "Counter": "0,",
         "CounterMask": "1",
         "EventCode": "0x80",
         "EventName": "UNC_ARB_TRK_OCCUPANCY.CYCLES_WITH_ANY_REQUEST",
         "PerPkg": "1",
-        "PublicDescription": "Cycles with at least one request outstanding=
 is waiting for data return from memory controller. Account for coherent an=
d non-coherent requests initiated by IA Cores, Processor Graphics Unit, or =
LLC.\n",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "ARB"
     },
     {
         "BriefDescription": "Total number of Core outgoing entries allocat=
ed. Accounts for Coherent and non-coherent traffic.",
-        "Counter": "0,1",
         "EventCode": "0x81",
         "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
         "PerPkg": "1",
-        "PublicDescription": "Total number of Core outgoing entries alloca=
ted. Accounts for Coherent and non-coherent traffic.",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "ARB"
     },
     {
         "BriefDescription": "Number of Writes allocated - any write transa=
ctions: full/partials writes and evictions.",
-        "Counter": "0,1",
         "EventCode": "0x81",
         "EventName": "UNC_ARB_TRK_REQUESTS.WRITES",
         "PerPkg": "1",
-        "PublicDescription": "Number of Writes allocated - any write trans=
actions: full/partials writes and evictions.",
         "UMask": "0x20",
         "Unit": "ARB"
     },
     {
         "BriefDescription": "This 48-bit fixed counter counts the UCLK cyc=
les.",
-        "Counter": "FIXED",
         "EventCode": "0xff",
         "EventName": "UNC_CLOCK.SOCKET",
         "PerPkg": "1",
-        "PublicDescription": "This 48-bit fixed counter counts the UCLK cy=
cles.",
         "Unit": "CLOCK"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/haswell/virtual-memory.json b/t=
ools/perf/pmu-events/arch/x86/haswell/virtual-memory.json
index 57d2a6452fec..87a4ec1ee7d7 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/virtual-memory.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Load misses in all DTLB levels that cause pag=
e walks",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.MISS_CAUSES_A_WALK",
         "PublicDescription": "Misses in all TLB levels that cause a page w=
alk of any page size.",
@@ -11,8 +9,6 @@
     },
     {
         "BriefDescription": "DTLB demand load misses with low part of line=
ar-to-physical address translation missed",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.PDE_CACHE_MISS",
         "PublicDescription": "DTLB demand load misses with low part of lin=
ear-to-physical address translation missed.",
@@ -21,8 +17,6 @@
     },
     {
         "BriefDescription": "Load operations that miss the first DTLB leve=
l but hit the second and do not cause page walks",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
         "PublicDescription": "Number of cache load STLB hits. No page walk=
.",
@@ -31,8 +25,6 @@
     },
     {
         "BriefDescription": "Load misses that miss the  DTLB and hit the S=
TLB (2M)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.STLB_HIT_2M",
         "PublicDescription": "This event counts load operations from a 2M =
page that miss the first DTLB level but hit the second and do not cause pag=
e walks.",
@@ -41,8 +33,6 @@
     },
     {
         "BriefDescription": "Load misses that miss the  DTLB and hit the S=
TLB (4K)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.STLB_HIT_4K",
         "PublicDescription": "This event counts load operations from a 4K =
page that miss the first DTLB level but hit the second and do not cause pag=
e walks.",
@@ -51,8 +41,6 @@
     },
     {
         "BriefDescription": "Demand load Miss in all translation lookaside=
 buffer (TLB) levels causes a page walk that completes of any page size.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
         "PublicDescription": "Completed page walks in any TLB of any page =
size due to demand load misses.",
@@ -61,8 +49,6 @@
     },
     {
         "BriefDescription": "Load miss in all TLB levels causes a page wal=
k that completes. (1G)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_1G",
         "SampleAfterValue": "2000003",
@@ -70,8 +56,6 @@
     },
     {
         "BriefDescription": "Demand load Miss in all translation lookaside=
 buffer (TLB) levels causes a page walk that completes (2M/4M).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
         "PublicDescription": "Completed page walks due to demand load miss=
es that caused 2M/4M page walks in any TLB levels.",
@@ -80,8 +64,6 @@
     },
     {
         "BriefDescription": "Demand load Miss in all translation lookaside=
 buffer (TLB) levels causes a page walk that completes (4K).",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
         "PublicDescription": "Completed page walks due to demand load miss=
es that caused 4K page walks in any TLB levels.",
@@ -90,8 +72,6 @@
     },
     {
         "BriefDescription": "Cycles when PMH is busy with page walks",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_DURATION",
         "PublicDescription": "This event counts cycles when the  page miss=
 handler (PMH) is servicing page walks caused by DTLB load misses.",
@@ -100,8 +80,6 @@
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
@@ -110,8 +88,6 @@
     },
     {
         "BriefDescription": "DTLB store misses with low part of linear-to-=
physical address translation missed",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.PDE_CACHE_MISS",
         "PublicDescription": "DTLB store misses with low part of linear-to=
-physical address translation missed.",
@@ -120,8 +96,6 @@
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
@@ -130,8 +104,6 @@
     },
     {
         "BriefDescription": "Store misses that miss the  DTLB and hit the =
STLB (2M)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.STLB_HIT_2M",
         "PublicDescription": "This event counts store operations from a 2M=
 page that miss the first DTLB level but hit the second and do not cause pa=
ge walks.",
@@ -140,8 +112,6 @@
     },
     {
         "BriefDescription": "Store misses that miss the  DTLB and hit the =
STLB (4K)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.STLB_HIT_4K",
         "PublicDescription": "This event counts store operations from a 4K=
 page that miss the first DTLB level but hit the second and do not cause pa=
ge walks.",
@@ -150,8 +120,6 @@
     },
     {
         "BriefDescription": "Store misses in all DTLB levels that cause co=
mpleted page walks",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
         "PublicDescription": "Completed page walks due to store miss in an=
y TLB levels of any page size (4K/2M/4M/1G).",
@@ -160,8 +128,6 @@
     },
     {
         "BriefDescription": "Store misses in all DTLB levels that cause co=
mpleted page walks. (1G)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_1G",
         "SampleAfterValue": "100003",
@@ -169,8 +135,6 @@
     },
     {
         "BriefDescription": "Store misses in all DTLB levels that cause co=
mpleted page walks (2M/4M)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
         "PublicDescription": "Completed page walks due to store misses in =
one or more TLB levels of 2M/4M page structure.",
@@ -179,8 +143,6 @@
     },
     {
         "BriefDescription": "Store miss in all TLB levels causes a page wa=
lk that completes. (4K)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
         "PublicDescription": "Completed page walks due to store misses in =
one or more TLB levels of 4K page structure.",
@@ -189,8 +151,6 @@
     },
     {
         "BriefDescription": "Cycles when PMH is busy with page walks",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_DURATION",
         "PublicDescription": "This event counts cycles when the  page miss=
 handler (PMH) is servicing page walks caused by DTLB store misses.",
@@ -199,8 +159,6 @@
     },
     {
         "BriefDescription": "Cycle count for an Extended Page table walk."=
,
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x4f",
         "EventName": "EPT.WALK_CYCLES",
         "SampleAfterValue": "2000003",
@@ -208,8 +166,6 @@
     },
     {
         "BriefDescription": "Flushing of the Instruction TLB (ITLB) pages,=
 includes 4k/2M/4M pages.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xae",
         "EventName": "ITLB.ITLB_FLUSH",
         "PublicDescription": "Counts the number of ITLB flushes, includes =
4k/2M/4M pages.",
@@ -218,8 +174,6 @@
     },
     {
         "BriefDescription": "Misses at all ITLB levels that cause page wal=
ks",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.MISS_CAUSES_A_WALK",
         "PublicDescription": "Misses in ITLB that causes a page walk of an=
y page size.",
@@ -228,8 +182,6 @@
     },
     {
         "BriefDescription": "Operations that miss the first ITLB level but=
 hit the second and do not cause any page walks",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.STLB_HIT",
         "PublicDescription": "ITLB misses that hit STLB. No page walk.",
@@ -238,8 +190,6 @@
     },
     {
         "BriefDescription": "Code misses that miss the  DTLB and hit the S=
TLB (2M)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.STLB_HIT_2M",
         "PublicDescription": "ITLB misses that hit STLB (2M).",
@@ -248,8 +198,6 @@
     },
     {
         "BriefDescription": "Core misses that miss the  DTLB and hit the S=
TLB (4K)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.STLB_HIT_4K",
         "PublicDescription": "ITLB misses that hit STLB (4K).",
@@ -258,8 +206,6 @@
     },
     {
         "BriefDescription": "Misses in all ITLB levels that cause complete=
d page walks",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
         "PublicDescription": "Completed page walks in ITLB of any page siz=
e.",
@@ -268,8 +214,6 @@
     },
     {
         "BriefDescription": "Store miss in all TLB levels causes a page wa=
lk that completes. (1G)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_1G",
         "SampleAfterValue": "100003",
@@ -277,8 +221,6 @@
     },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (2M/4M)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
         "PublicDescription": "Completed page walks due to misses in ITLB 2=
M/4M page entries.",
@@ -287,8 +229,6 @@
     },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (4K)",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
         "PublicDescription": "Completed page walks due to misses in ITLB 4=
K page entries.",
@@ -297,8 +237,6 @@
     },
     {
         "BriefDescription": "Cycles when PMH is busy with page walks",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_DURATION",
         "PublicDescription": "This event counts cycles when the  page miss=
 handler (PMH) is servicing page walks caused by ITLB misses.",
@@ -307,8 +245,6 @@
     },
     {
         "BriefDescription": "Number of DTLB page walker hits in the L1+FB"=
,
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.DTLB_L1",
         "PublicDescription": "Number of DTLB page walker loads that hit in=
 the L1+FB.",
@@ -317,8 +253,6 @@
     },
     {
         "BriefDescription": "Number of DTLB page walker hits in the L2",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.DTLB_L2",
         "PublicDescription": "Number of DTLB page walker loads that hit in=
 the L2.",
@@ -327,8 +261,6 @@
     },
     {
         "BriefDescription": "Number of DTLB page walker hits in the L3 + X=
SNP",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Errata": "HSD25",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.DTLB_L3",
@@ -338,8 +270,6 @@
     },
     {
         "BriefDescription": "Number of DTLB page walker hits in Memory",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Errata": "HSD25",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.DTLB_MEMORY",
@@ -349,8 +279,6 @@
     },
     {
         "BriefDescription": "Counts the number of Extended Page Table walk=
s from the DTLB that hit in the L1 and FB.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.EPT_DTLB_L1",
         "SampleAfterValue": "2000003",
@@ -358,8 +286,6 @@
     },
     {
         "BriefDescription": "Counts the number of Extended Page Table walk=
s from the DTLB that hit in the L2.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.EPT_DTLB_L2",
         "SampleAfterValue": "2000003",
@@ -367,8 +293,6 @@
     },
     {
         "BriefDescription": "Counts the number of Extended Page Table walk=
s from the DTLB that hit in the L3.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.EPT_DTLB_L3",
         "SampleAfterValue": "2000003",
@@ -376,8 +300,6 @@
     },
     {
         "BriefDescription": "Counts the number of Extended Page Table walk=
s from the DTLB that hit in memory.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.EPT_DTLB_MEMORY",
         "SampleAfterValue": "2000003",
@@ -385,8 +307,6 @@
     },
     {
         "BriefDescription": "Counts the number of Extended Page Table walk=
s from the ITLB that hit in the L1 and FB.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.EPT_ITLB_L1",
         "SampleAfterValue": "2000003",
@@ -394,8 +314,6 @@
     },
     {
         "BriefDescription": "Counts the number of Extended Page Table walk=
s from the ITLB that hit in the L2.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.EPT_ITLB_L2",
         "SampleAfterValue": "2000003",
@@ -403,8 +321,6 @@
     },
     {
         "BriefDescription": "Counts the number of Extended Page Table walk=
s from the ITLB that hit in the L2.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.EPT_ITLB_L3",
         "SampleAfterValue": "2000003",
@@ -412,8 +328,6 @@
     },
     {
         "BriefDescription": "Counts the number of Extended Page Table walk=
s from the ITLB that hit in memory.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.EPT_ITLB_MEMORY",
         "SampleAfterValue": "2000003",
@@ -421,8 +335,6 @@
     },
     {
         "BriefDescription": "Number of ITLB page walker hits in the L1+FB"=
,
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.ITLB_L1",
         "PublicDescription": "Number of ITLB page walker loads that hit in=
 the L1+FB.",
@@ -431,8 +343,6 @@
     },
     {
         "BriefDescription": "Number of ITLB page walker hits in the L2",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.ITLB_L2",
         "PublicDescription": "Number of ITLB page walker loads that hit in=
 the L2.",
@@ -441,8 +351,6 @@
     },
     {
         "BriefDescription": "Number of ITLB page walker hits in the L3 + X=
SNP",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Errata": "HSD25",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.ITLB_L3",
@@ -452,8 +360,6 @@
     },
     {
         "BriefDescription": "Number of ITLB page walker hits in Memory",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3",
         "Errata": "HSD25",
         "EventCode": "0xBC",
         "EventName": "PAGE_WALKER_LOADS.ITLB_MEMORY",
@@ -463,8 +369,6 @@
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
@@ -473,8 +377,6 @@
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

