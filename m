Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768A864D6D3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 08:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiLOHAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 02:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiLOG6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:58:38 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D8C36D6E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:57:11 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3dddef6adb6so25624247b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yqt+3boJREqhU/IJbwsZUAwyTndbxmyM8dLYEA+keXM=;
        b=ZRRIdlq+T+RdwvIPHzbexyNTDTBbVpnJ/dXzSzE8PGHx2k+Oc17nWVTAq+AnekTzZf
         UDH/tDISG8x82WOez6KOYsuOumLkFYEsWEaUuSWRcaGEFLh1NUVrw6sASOyMGMj7btc/
         P+EfM2S5btYnzqbj0UDGP4pzk5q7AfDg4a+nfPKpJUkuaxXpCZ76wg/Ca9A5KG6F0/aO
         JsljdueBMhzx46pIA9LFJeboAwVKPNpKMlHUkHULmsGEVwrhVNDyWbRLY9zM0bNQFRrj
         rAOiFW01IieVeNk7Xhqsu8l80bSCk+M6v3occ110hYforKRpyuelqkRp6kyX8svamsKJ
         FxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yqt+3boJREqhU/IJbwsZUAwyTndbxmyM8dLYEA+keXM=;
        b=TG+tUML3oPX0++rlKUakuGkbqzMPcbZ+Y131fwQ7Wi/WteRB9nypgitrFPlPFlCDFE
         NkcTYMd2z/NCej3h+atkCLtKHW1EwdyMixCeJjv1rMnDCh4DOabqW8CIypbW+nB8zIfk
         nz9g37KCQ9mw8f7WV/Floh+rv0CJ0kTKpdAhkrhVEggApC8ErfnAGVtANeNMpRdEmiCr
         HX8fKvbFoF0tBVbnUcvg1e+SamsPhGY6S5Dsma82jCgVE2sgxvdX3M23xT4i/u4GvP2q
         HtT0KRFqkO/QkPoDBt+d3nvVHmZNeSmSBRKqEs2VtkpvNjCWbT+VRPYmO/wHWg8zt/ut
         hfnw==
X-Gm-Message-State: ANoB5pl5xYSfdO2xOD9idI3SEMyQpRnmxoCag0iBNjRpxtFwrHLbJiu6
        unkZ5rN2bv4e3uZh0zvrqjnJ2Q3/+tNj
X-Google-Smtp-Source: AA0mqf7EGOFQ4H479epSqIy/wXxvtJd2wpWFfWrlkTbi+rolUVJ6PcOJBRC7gFW7JzPm9RA3Rg6Uv3S4zeXW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c7dc:d96f:4f9:f59d])
 (user=irogers job=sendgmr) by 2002:a5b:24b:0:b0:6ca:3b11:8d76 with SMTP id
 g11-20020a5b024b000000b006ca3b118d76mr74287764ybp.202.1671087431311; Wed, 14
 Dec 2022 22:57:11 -0800 (PST)
Date:   Wed, 14 Dec 2022 22:54:59 -0800
In-Reply-To: <20221215065510.1621979-1-irogers@google.com>
Message-Id: <20221215065510.1621979-13-irogers@google.com>
Mime-Version: 1.0
References: <20221215065510.1621979-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 21/32] perf vendor events intel: Refresh nehalemep events
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the nehalemep events using the new tooling from:
https://github.com/intel/perfmon

The events are unchanged but unused json values are removed. This
increases consistency across the json files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/nehalemep/cache.json  | 524 ------------------
 .../arch/x86/nehalemep/floating-point.json    |  28 -
 .../arch/x86/nehalemep/frontend.json          |   3 -
 .../pmu-events/arch/x86/nehalemep/memory.json | 134 -----
 .../pmu-events/arch/x86/nehalemep/other.json  |  18 -
 .../arch/x86/nehalemep/pipeline.json          | 127 +----
 .../arch/x86/nehalemep/virtual-memory.json    |  13 -
 7 files changed, 5 insertions(+), 842 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/cache.json b/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
index 1ee91300baf9..1a132fcda964 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "Cycles L1D locked",
-        "Counter": "0,1",
         "EventCode": "0x63",
         "EventName": "CACHE_LOCK_CYCLES.L1D",
         "SampleAfterValue": "2000000",
@@ -9,7 +8,6 @@
     },
     {
         "BriefDescription": "Cycles L1D and L2 locked",
-        "Counter": "0,1",
         "EventCode": "0x63",
         "EventName": "CACHE_LOCK_CYCLES.L1D_L2",
         "SampleAfterValue": "2000000",
@@ -17,7 +15,6 @@
     },
     {
         "BriefDescription": "L1D cache lines replaced in M state",
-        "Counter": "0,1",
         "EventCode": "0x51",
         "EventName": "L1D.M_EVICT",
         "SampleAfterValue": "2000000",
@@ -25,7 +22,6 @@
     },
     {
         "BriefDescription": "L1D cache lines allocated in the M state",
-        "Counter": "0,1",
         "EventCode": "0x51",
         "EventName": "L1D.M_REPL",
         "SampleAfterValue": "2000000",
@@ -33,7 +29,6 @@
     },
     {
         "BriefDescription": "L1D snoop eviction of cache lines in M state",
-        "Counter": "0,1",
         "EventCode": "0x51",
         "EventName": "L1D.M_SNOOP_EVICT",
         "SampleAfterValue": "2000000",
@@ -41,7 +36,6 @@
     },
     {
         "BriefDescription": "L1 data cache lines allocated",
-        "Counter": "0,1",
         "EventCode": "0x51",
         "EventName": "L1D.REPL",
         "SampleAfterValue": "2000000",
@@ -49,7 +43,6 @@
     },
     {
         "BriefDescription": "All references to the L1 data cache",
-        "Counter": "0,1",
         "EventCode": "0x43",
         "EventName": "L1D_ALL_REF.ANY",
         "SampleAfterValue": "2000000",
@@ -57,7 +50,6 @@
     },
     {
         "BriefDescription": "L1 data cacheable reads and writes",
-        "Counter": "0,1",
         "EventCode": "0x43",
         "EventName": "L1D_ALL_REF.CACHEABLE",
         "SampleAfterValue": "2000000",
@@ -65,7 +57,6 @@
     },
     {
         "BriefDescription": "L1 data cache read in E state",
-        "Counter": "0,1",
         "EventCode": "0x40",
         "EventName": "L1D_CACHE_LD.E_STATE",
         "SampleAfterValue": "2000000",
@@ -73,7 +64,6 @@
     },
     {
         "BriefDescription": "L1 data cache read in I state (misses)",
-        "Counter": "0,1",
         "EventCode": "0x40",
         "EventName": "L1D_CACHE_LD.I_STATE",
         "SampleAfterValue": "2000000",
@@ -81,7 +71,6 @@
     },
     {
         "BriefDescription": "L1 data cache reads",
-        "Counter": "0,1",
         "EventCode": "0x40",
         "EventName": "L1D_CACHE_LD.MESI",
         "SampleAfterValue": "2000000",
@@ -89,7 +78,6 @@
     },
     {
         "BriefDescription": "L1 data cache read in M state",
-        "Counter": "0,1",
         "EventCode": "0x40",
         "EventName": "L1D_CACHE_LD.M_STATE",
         "SampleAfterValue": "2000000",
@@ -97,7 +85,6 @@
     },
     {
         "BriefDescription": "L1 data cache read in S state",
-        "Counter": "0,1",
         "EventCode": "0x40",
         "EventName": "L1D_CACHE_LD.S_STATE",
         "SampleAfterValue": "2000000",
@@ -105,7 +92,6 @@
     },
     {
         "BriefDescription": "L1 data cache load locks in E state",
-        "Counter": "0,1",
         "EventCode": "0x42",
         "EventName": "L1D_CACHE_LOCK.E_STATE",
         "SampleAfterValue": "2000000",
@@ -113,7 +99,6 @@
     },
     {
         "BriefDescription": "L1 data cache load lock hits",
-        "Counter": "0,1",
         "EventCode": "0x42",
         "EventName": "L1D_CACHE_LOCK.HIT",
         "SampleAfterValue": "2000000",
@@ -121,7 +106,6 @@
     },
     {
         "BriefDescription": "L1 data cache load locks in M state",
-        "Counter": "0,1",
         "EventCode": "0x42",
         "EventName": "L1D_CACHE_LOCK.M_STATE",
         "SampleAfterValue": "2000000",
@@ -129,7 +113,6 @@
     },
     {
         "BriefDescription": "L1 data cache load locks in S state",
-        "Counter": "0,1",
         "EventCode": "0x42",
         "EventName": "L1D_CACHE_LOCK.S_STATE",
         "SampleAfterValue": "2000000",
@@ -137,7 +120,6 @@
     },
     {
         "BriefDescription": "L1D load lock accepted in fill buffer",
-        "Counter": "0,1",
         "EventCode": "0x53",
         "EventName": "L1D_CACHE_LOCK_FB_HIT",
         "SampleAfterValue": "2000000",
@@ -145,7 +127,6 @@
     },
     {
         "BriefDescription": "L1D prefetch load lock accepted in fill buffer",
-        "Counter": "0,1",
         "EventCode": "0x52",
         "EventName": "L1D_CACHE_PREFETCH_LOCK_FB_HIT",
         "SampleAfterValue": "2000000",
@@ -153,7 +134,6 @@
     },
     {
         "BriefDescription": "L1 data cache stores in E state",
-        "Counter": "0,1",
         "EventCode": "0x41",
         "EventName": "L1D_CACHE_ST.E_STATE",
         "SampleAfterValue": "2000000",
@@ -161,7 +141,6 @@
     },
     {
         "BriefDescription": "L1 data cache stores in M state",
-        "Counter": "0,1",
         "EventCode": "0x41",
         "EventName": "L1D_CACHE_ST.M_STATE",
         "SampleAfterValue": "2000000",
@@ -169,7 +148,6 @@
     },
     {
         "BriefDescription": "L1 data cache stores in S state",
-        "Counter": "0,1",
         "EventCode": "0x41",
         "EventName": "L1D_CACHE_ST.S_STATE",
         "SampleAfterValue": "2000000",
@@ -177,7 +155,6 @@
     },
     {
         "BriefDescription": "L1D hardware prefetch misses",
-        "Counter": "0,1",
         "EventCode": "0x4E",
         "EventName": "L1D_PREFETCH.MISS",
         "SampleAfterValue": "200000",
@@ -185,7 +162,6 @@
     },
     {
         "BriefDescription": "L1D hardware prefetch requests",
-        "Counter": "0,1",
         "EventCode": "0x4E",
         "EventName": "L1D_PREFETCH.REQUESTS",
         "SampleAfterValue": "200000",
@@ -193,7 +169,6 @@
     },
     {
         "BriefDescription": "L1D hardware prefetch requests triggered",
-        "Counter": "0,1",
         "EventCode": "0x4E",
         "EventName": "L1D_PREFETCH.TRIGGERS",
         "SampleAfterValue": "200000",
@@ -201,7 +176,6 @@
     },
     {
         "BriefDescription": "L1 writebacks to L2 in E state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "L1D_WB_L2.E_STATE",
         "SampleAfterValue": "100000",
@@ -209,7 +183,6 @@
     },
     {
         "BriefDescription": "L1 writebacks to L2 in I state (misses)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "L1D_WB_L2.I_STATE",
         "SampleAfterValue": "100000",
@@ -217,7 +190,6 @@
     },
     {
         "BriefDescription": "All L1 writebacks to L2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "L1D_WB_L2.MESI",
         "SampleAfterValue": "100000",
@@ -225,7 +197,6 @@
     },
     {
         "BriefDescription": "L1 writebacks to L2 in M state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "L1D_WB_L2.M_STATE",
         "SampleAfterValue": "100000",
@@ -233,7 +204,6 @@
     },
     {
         "BriefDescription": "L1 writebacks to L2 in S state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "L1D_WB_L2.S_STATE",
         "SampleAfterValue": "100000",
@@ -241,7 +211,6 @@
     },
     {
         "BriefDescription": "All L2 data requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.ANY",
         "SampleAfterValue": "200000",
@@ -249,7 +218,6 @@
     },
     {
         "BriefDescription": "L2 data demand loads in E state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.DEMAND.E_STATE",
         "SampleAfterValue": "200000",
@@ -257,7 +225,6 @@
     },
     {
         "BriefDescription": "L2 data demand loads in I state (misses)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.DEMAND.I_STATE",
         "SampleAfterValue": "200000",
@@ -265,7 +232,6 @@
     },
     {
         "BriefDescription": "L2 data demand requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.DEMAND.MESI",
         "SampleAfterValue": "200000",
@@ -273,7 +239,6 @@
     },
     {
         "BriefDescription": "L2 data demand loads in M state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.DEMAND.M_STATE",
         "SampleAfterValue": "200000",
@@ -281,7 +246,6 @@
     },
     {
         "BriefDescription": "L2 data demand loads in S state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.DEMAND.S_STATE",
         "SampleAfterValue": "200000",
@@ -289,7 +253,6 @@
     },
     {
         "BriefDescription": "L2 data prefetches in E state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.PREFETCH.E_STATE",
         "SampleAfterValue": "200000",
@@ -297,7 +260,6 @@
     },
     {
         "BriefDescription": "L2 data prefetches in the I state (misses)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.PREFETCH.I_STATE",
         "SampleAfterValue": "200000",
@@ -305,7 +267,6 @@
     },
     {
         "BriefDescription": "All L2 data prefetches",
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.PREFETCH.MESI",
         "SampleAfterValue": "200000",
@@ -313,7 +274,6 @@
     },
     {
         "BriefDescription": "L2 data prefetches in M state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.PREFETCH.M_STATE",
         "SampleAfterValue": "200000",
@@ -321,7 +281,6 @@
     },
     {
         "BriefDescription": "L2 data prefetches in the S state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.PREFETCH.S_STATE",
         "SampleAfterValue": "200000",
@@ -329,7 +288,6 @@
     },
     {
         "BriefDescription": "L2 lines alloacated",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.ANY",
         "SampleAfterValue": "100000",
@@ -337,7 +295,6 @@
     },
     {
         "BriefDescription": "L2 lines allocated in the E state",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.E_STATE",
         "SampleAfterValue": "100000",
@@ -345,7 +302,6 @@
     },
     {
         "BriefDescription": "L2 lines allocated in the S state",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.S_STATE",
         "SampleAfterValue": "100000",
@@ -353,7 +309,6 @@
     },
     {
         "BriefDescription": "L2 lines evicted",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.ANY",
         "SampleAfterValue": "100000",
@@ -361,7 +316,6 @@
     },
     {
         "BriefDescription": "L2 lines evicted by a demand request",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.DEMAND_CLEAN",
         "SampleAfterValue": "100000",
@@ -369,7 +323,6 @@
     },
     {
         "BriefDescription": "L2 modified lines evicted by a demand request",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.DEMAND_DIRTY",
         "SampleAfterValue": "100000",
@@ -377,7 +330,6 @@
     },
     {
         "BriefDescription": "L2 lines evicted by a prefetch request",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.PREFETCH_CLEAN",
         "SampleAfterValue": "100000",
@@ -385,7 +337,6 @@
     },
     {
         "BriefDescription": "L2 modified lines evicted by a prefetch request",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.PREFETCH_DIRTY",
         "SampleAfterValue": "100000",
@@ -393,7 +344,6 @@
     },
     {
         "BriefDescription": "L2 instruction fetches",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.IFETCHES",
         "SampleAfterValue": "200000",
@@ -401,7 +351,6 @@
     },
     {
         "BriefDescription": "L2 instruction fetch hits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.IFETCH_HIT",
         "SampleAfterValue": "200000",
@@ -409,7 +358,6 @@
     },
     {
         "BriefDescription": "L2 instruction fetch misses",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.IFETCH_MISS",
         "SampleAfterValue": "200000",
@@ -417,7 +365,6 @@
     },
     {
         "BriefDescription": "L2 load hits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.LD_HIT",
         "SampleAfterValue": "200000",
@@ -425,7 +372,6 @@
     },
     {
         "BriefDescription": "L2 load misses",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.LD_MISS",
         "SampleAfterValue": "200000",
@@ -433,7 +379,6 @@
     },
     {
         "BriefDescription": "L2 requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.LOADS",
         "SampleAfterValue": "200000",
@@ -441,7 +386,6 @@
     },
     {
         "BriefDescription": "All L2 misses",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.MISS",
         "SampleAfterValue": "200000",
@@ -449,7 +393,6 @@
     },
     {
         "BriefDescription": "All L2 prefetches",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.PREFETCHES",
         "SampleAfterValue": "200000",
@@ -457,7 +400,6 @@
     },
     {
         "BriefDescription": "L2 prefetch hits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.PREFETCH_HIT",
         "SampleAfterValue": "200000",
@@ -465,7 +407,6 @@
     },
     {
         "BriefDescription": "L2 prefetch misses",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.PREFETCH_MISS",
         "SampleAfterValue": "200000",
@@ -473,7 +414,6 @@
     },
     {
         "BriefDescription": "All L2 requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.REFERENCES",
         "SampleAfterValue": "200000",
@@ -481,7 +421,6 @@
     },
     {
         "BriefDescription": "L2 RFO requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFOS",
         "SampleAfterValue": "200000",
@@ -489,7 +428,6 @@
     },
     {
         "BriefDescription": "L2 RFO hits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_HIT",
         "SampleAfterValue": "200000",
@@ -497,7 +435,6 @@
     },
     {
         "BriefDescription": "L2 RFO misses",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_MISS",
         "SampleAfterValue": "200000",
@@ -505,7 +442,6 @@
     },
     {
         "BriefDescription": "All L2 transactions",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF0",
         "EventName": "L2_TRANSACTIONS.ANY",
         "SampleAfterValue": "200000",
@@ -513,7 +449,6 @@
     },
     {
         "BriefDescription": "L2 fill transactions",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF0",
         "EventName": "L2_TRANSACTIONS.FILL",
         "SampleAfterValue": "200000",
@@ -521,7 +456,6 @@
     },
     {
         "BriefDescription": "L2 instruction fetch transactions",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF0",
         "EventName": "L2_TRANSACTIONS.IFETCH",
         "SampleAfterValue": "200000",
@@ -529,7 +463,6 @@
     },
     {
         "BriefDescription": "L1D writeback to L2 transactions",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF0",
         "EventName": "L2_TRANSACTIONS.L1D_WB",
         "SampleAfterValue": "200000",
@@ -537,7 +470,6 @@
     },
     {
         "BriefDescription": "L2 Load transactions",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF0",
         "EventName": "L2_TRANSACTIONS.LOAD",
         "SampleAfterValue": "200000",
@@ -545,7 +477,6 @@
     },
     {
         "BriefDescription": "L2 prefetch transactions",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF0",
         "EventName": "L2_TRANSACTIONS.PREFETCH",
         "SampleAfterValue": "200000",
@@ -553,7 +484,6 @@
     },
     {
         "BriefDescription": "L2 RFO transactions",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF0",
         "EventName": "L2_TRANSACTIONS.RFO",
         "SampleAfterValue": "200000",
@@ -561,7 +491,6 @@
     },
     {
         "BriefDescription": "L2 writeback to LLC transactions",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF0",
         "EventName": "L2_TRANSACTIONS.WB",
         "SampleAfterValue": "200000",
@@ -569,7 +498,6 @@
     },
     {
         "BriefDescription": "L2 demand lock RFOs in E state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "L2_WRITE.LOCK.E_STATE",
         "SampleAfterValue": "100000",
@@ -577,7 +505,6 @@
     },
     {
         "BriefDescription": "All demand L2 lock RFOs that hit the cache",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "L2_WRITE.LOCK.HIT",
         "SampleAfterValue": "100000",
@@ -585,7 +512,6 @@
     },
     {
         "BriefDescription": "L2 demand lock RFOs in I state (misses)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "L2_WRITE.LOCK.I_STATE",
         "SampleAfterValue": "100000",
@@ -593,7 +519,6 @@
     },
     {
         "BriefDescription": "All demand L2 lock RFOs",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "L2_WRITE.LOCK.MESI",
         "SampleAfterValue": "100000",
@@ -601,7 +526,6 @@
     },
     {
         "BriefDescription": "L2 demand lock RFOs in M state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "L2_WRITE.LOCK.M_STATE",
         "SampleAfterValue": "100000",
@@ -609,7 +533,6 @@
     },
     {
         "BriefDescription": "L2 demand lock RFOs in S state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "L2_WRITE.LOCK.S_STATE",
         "SampleAfterValue": "100000",
@@ -617,7 +540,6 @@
     },
     {
         "BriefDescription": "All L2 demand store RFOs that hit the cache",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "L2_WRITE.RFO.HIT",
         "SampleAfterValue": "100000",
@@ -625,7 +547,6 @@
     },
     {
         "BriefDescription": "L2 demand store RFOs in I state (misses)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "L2_WRITE.RFO.I_STATE",
         "SampleAfterValue": "100000",
@@ -633,7 +554,6 @@
     },
     {
         "BriefDescription": "All L2 demand store RFOs",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "L2_WRITE.RFO.MESI",
         "SampleAfterValue": "100000",
@@ -641,7 +561,6 @@
     },
     {
         "BriefDescription": "L2 demand store RFOs in M state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "L2_WRITE.RFO.M_STATE",
         "SampleAfterValue": "100000",
@@ -649,7 +568,6 @@
     },
     {
         "BriefDescription": "L2 demand store RFOs in S state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "L2_WRITE.RFO.S_STATE",
         "SampleAfterValue": "100000",
@@ -657,7 +575,6 @@
     },
     {
         "BriefDescription": "Longest latency cache miss",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "LONGEST_LAT_CACHE.MISS",
         "SampleAfterValue": "100000",
@@ -665,7 +582,6 @@
     },
     {
         "BriefDescription": "Longest latency cache reference",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
         "SampleAfterValue": "200000",
@@ -673,18 +589,15 @@
     },
     {
         "BriefDescription": "Memory instructions retired above 0 clocks (Precise Event)",
-        "Counter": "3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_0",
         "MSRIndex": "0x3F6",
-        "MSRValue": "0x0",
         "PEBS": "2",
         "SampleAfterValue": "2000000",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Memory instructions retired above 1024 clocks (Precise Event)",
-        "Counter": "3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_1024",
         "MSRIndex": "0x3F6",
@@ -695,7 +608,6 @@
     },
     {
         "BriefDescription": "Memory instructions retired above 128 clocks (Precise Event)",
-        "Counter": "3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_128",
         "MSRIndex": "0x3F6",
@@ -706,7 +618,6 @@
     },
     {
         "BriefDescription": "Memory instructions retired above 16 clocks (Precise Event)",
-        "Counter": "3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_16",
         "MSRIndex": "0x3F6",
@@ -717,7 +628,6 @@
     },
     {
         "BriefDescription": "Memory instructions retired above 16384 clocks (Precise Event)",
-        "Counter": "3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_16384",
         "MSRIndex": "0x3F6",
@@ -728,7 +638,6 @@
     },
     {
         "BriefDescription": "Memory instructions retired above 2048 clocks (Precise Event)",
-        "Counter": "3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_2048",
         "MSRIndex": "0x3F6",
@@ -739,7 +648,6 @@
     },
     {
         "BriefDescription": "Memory instructions retired above 256 clocks (Precise Event)",
-        "Counter": "3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_256",
         "MSRIndex": "0x3F6",
@@ -750,7 +658,6 @@
     },
     {
         "BriefDescription": "Memory instructions retired above 32 clocks (Precise Event)",
-        "Counter": "3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_32",
         "MSRIndex": "0x3F6",
@@ -761,7 +668,6 @@
     },
     {
         "BriefDescription": "Memory instructions retired above 32768 clocks (Precise Event)",
-        "Counter": "3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_32768",
         "MSRIndex": "0x3F6",
@@ -772,7 +678,6 @@
     },
     {
         "BriefDescription": "Memory instructions retired above 4 clocks (Precise Event)",
-        "Counter": "3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_4",
         "MSRIndex": "0x3F6",
@@ -783,7 +688,6 @@
     },
     {
         "BriefDescription": "Memory instructions retired above 4096 clocks (Precise Event)",
-        "Counter": "3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_4096",
         "MSRIndex": "0x3F6",
@@ -794,7 +698,6 @@
     },
     {
         "BriefDescription": "Memory instructions retired above 512 clocks (Precise Event)",
-        "Counter": "3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_512",
         "MSRIndex": "0x3F6",
@@ -805,7 +708,6 @@
     },
     {
         "BriefDescription": "Memory instructions retired above 64 clocks (Precise Event)",
-        "Counter": "3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_64",
         "MSRIndex": "0x3F6",
@@ -816,7 +718,6 @@
     },
     {
         "BriefDescription": "Memory instructions retired above 8 clocks (Precise Event)",
-        "Counter": "3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_8",
         "MSRIndex": "0x3F6",
@@ -827,7 +728,6 @@
     },
     {
         "BriefDescription": "Memory instructions retired above 8192 clocks (Precise Event)",
-        "Counter": "3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_8192",
         "MSRIndex": "0x3F6",
@@ -838,7 +738,6 @@
     },
     {
         "BriefDescription": "Instructions retired which contains a load (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LOADS",
         "PEBS": "1",
@@ -847,7 +746,6 @@
     },
     {
         "BriefDescription": "Instructions retired which contains a store (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.STORES",
         "PEBS": "1",
@@ -856,7 +754,6 @@
     },
     {
         "BriefDescription": "Retired loads that miss L1D and hit an previously allocated LFB (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCB",
         "EventName": "MEM_LOAD_RETIRED.HIT_LFB",
         "PEBS": "1",
@@ -865,7 +762,6 @@
     },
     {
         "BriefDescription": "Retired loads that hit the L1 data cache (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCB",
         "EventName": "MEM_LOAD_RETIRED.L1D_HIT",
         "PEBS": "1",
@@ -874,7 +770,6 @@
     },
     {
         "BriefDescription": "Retired loads that hit the L2 cache (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCB",
         "EventName": "MEM_LOAD_RETIRED.L2_HIT",
         "PEBS": "1",
@@ -883,7 +778,6 @@
     },
     {
         "BriefDescription": "Retired loads that miss the LLC cache (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCB",
         "EventName": "MEM_LOAD_RETIRED.LLC_MISS",
         "PEBS": "1",
@@ -892,7 +786,6 @@
     },
     {
         "BriefDescription": "Retired loads that hit valid versions in the LLC cache (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCB",
         "EventName": "MEM_LOAD_RETIRED.LLC_UNSHARED_HIT",
         "PEBS": "1",
@@ -901,7 +794,6 @@
     },
     {
         "BriefDescription": "Retired loads that hit sibling core's L2 in modified or unmodified states (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCB",
         "EventName": "MEM_LOAD_RETIRED.OTHER_CORE_L2_HIT_HITM",
         "PEBS": "1",
@@ -910,7 +802,6 @@
     },
     {
         "BriefDescription": "Load instructions retired with a data source of local DRAM or locally homed remote hitm (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF",
         "EventName": "MEM_UNCORE_RETIRED.LOCAL_DRAM",
         "PEBS": "1",
@@ -919,7 +810,6 @@
     },
     {
         "BriefDescription": "Load instructions retired that HIT modified data in sibling core (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF",
         "EventName": "MEM_UNCORE_RETIRED.OTHER_CORE_L2_HITM",
         "PEBS": "1",
@@ -928,7 +818,6 @@
     },
     {
         "BriefDescription": "Load instructions retired remote cache HIT data source (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF",
         "EventName": "MEM_UNCORE_RETIRED.REMOTE_CACHE_LOCAL_HOME_HIT",
         "PEBS": "1",
@@ -937,7 +826,6 @@
     },
     {
         "BriefDescription": "Load instructions retired remote DRAM and remote home-remote cache HITM (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF",
         "EventName": "MEM_UNCORE_RETIRED.REMOTE_DRAM",
         "PEBS": "1",
@@ -946,7 +834,6 @@
     },
     {
         "BriefDescription": "Load instructions retired IO (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF",
         "EventName": "MEM_UNCORE_RETIRED.UNCACHEABLE",
         "PEBS": "1",
@@ -955,7 +842,6 @@
     },
     {
         "BriefDescription": "Offcore L1 data cache writebacks",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.L1D_WRITEBACK",
         "SampleAfterValue": "100000",
@@ -963,7 +849,6 @@
     },
     {
         "BriefDescription": "Offcore requests blocked due to Super Queue full",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB2",
         "EventName": "OFFCORE_REQUESTS_SQ_FULL",
         "SampleAfterValue": "100000",
@@ -971,2240 +856,1833 @@
     },
     {
         "BriefDescription": "Offcore data reads satisfied by any cache or DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x7F11",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "All offcore data reads",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.ANY_LOCATION",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xFF11",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore data reads satisfied by the IO, CSR, MMIO unit",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x8011",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore data reads satisfied by the LLC and not found in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x111",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore data reads satisfied by the LLC and HIT in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x211",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore data reads satisfied by the LLC  and HITM in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x411",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore data reads satisfied by the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x711",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore data reads satisfied by the LLC or local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4711",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore data reads satisfied by a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1811",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore data reads satisfied by a remote cache or remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x3811",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore data reads that HIT in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1011",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore data reads that HITM in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x811",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code reads satisfied by any cache or DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x7F44",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "All offcore code reads",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.ANY_LOCATION",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xFF44",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code reads satisfied by the IO, CSR, MMIO unit",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x8044",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code reads satisfied by the LLC and not found in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x144",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code reads satisfied by the LLC and HIT in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x244",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code reads satisfied by the LLC  and HITM in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x444",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code reads satisfied by the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x744",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code reads satisfied by the LLC or local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4744",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code reads satisfied by a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1844",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code reads satisfied by a remote cache or remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x3844",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code reads that HIT in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1044",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code reads that HITM in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x844",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore requests satisfied by any cache or DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x7FFF",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "All offcore requests",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.ANY_LOCATION",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xFFFF",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore requests satisfied by the IO, CSR, MMIO unit",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x80FF",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore requests satisfied by the LLC and not found in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1FF",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore requests satisfied by the LLC and HIT in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x2FF",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore requests satisfied by the LLC  and HITM in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4FF",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore requests satisfied by the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x7FF",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore requests satisfied by the LLC or local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x47FF",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore requests satisfied by a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x18FF",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore requests satisfied by a remote cache or remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x38FF",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore requests that HIT in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x10FF",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore requests that HITM in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x8FF",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore RFO requests satisfied by any cache or DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x7F22",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "All offcore RFO requests",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.ANY_LOCATION",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xFF22",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore RFO requests satisfied by the IO, CSR, MMIO unit",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x8022",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore RFO requests satisfied by the LLC and not found in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x122",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore RFO requests satisfied by the LLC and HIT in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x222",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore RFO requests satisfied by the LLC  and HITM in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x422",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore RFO requests satisfied by the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x722",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore RFO requests satisfied by the LLC or local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4722",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore RFO requests satisfied by a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1822",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore RFO requests satisfied by a remote cache or remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x3822",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore RFO requests that HIT in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1022",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore RFO requests that HITM in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x822",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore writebacks to any cache or DRAM.",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x7F08",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "All offcore writebacks",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.ANY_LOCATION",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xFF08",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore writebacks to the IO, CSR, MMIO unit.",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x8008",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore writebacks to the LLC and not found in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x108",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore writebacks to the LLC  and HITM in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x408",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore writebacks to the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x708",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore writebacks to the LLC or local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4708",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore writebacks to a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1808",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore writebacks to a remote cache or remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x3808",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore writebacks that HIT in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1008",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore writebacks that HITM in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x808",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code or data read requests satisfied by any cache or DRAM.",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x7F77",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "All offcore code or data read requests",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.ANY_LOCATION",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xFF77",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code or data read requests satisfied by the IO, CSR, MMIO unit.",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x8077",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code or data read requests satisfied by the LLC and not found in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x177",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code or data read requests satisfied by the LLC and HIT in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x277",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code or data read requests satisfied by the LLC  and HITM in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x477",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code or data read requests satisfied by the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x777",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code or data read requests satisfied by the LLC or local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4777",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code or data read requests satisfied by a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1877",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code or data read requests satisfied by a remote cache or remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x3877",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code or data read requests that HIT in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1077",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code or data read requests that HITM in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x877",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore request = all data, response = any cache_dram",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x7F33",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore request = all data, response = any location",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.ANY_LOCATION",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xFF33",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the IO, CSR, MMIO unit",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x8033",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC and not found in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x133",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC and HIT in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x233",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC  and HITM in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x433",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore request = all data, response = local cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x733",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore request = all data, response = local cache or dram",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4733",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore request = all data, response = remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1833",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore request = all data, response = remote cache or dram",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x3833",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore data reads, RFOs, and prefetches that HIT in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1033",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore data reads, RFOs, and prefetches that HITM in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x833",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data requests satisfied by any cache or DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x7F03",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "All offcore demand data requests",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.ANY_LOCATION",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xFF03",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data requests satisfied by the IO, CSR, MMIO unit.",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x8003",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data requests satisfied by the LLC and not found in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x103",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data requests satisfied by the LLC and HIT in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x203",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data requests satisfied by the LLC  and HITM in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x403",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data requests satisfied by the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x703",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data requests satisfied by the LLC or local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4703",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data requests satisfied by a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1803",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data requests satisfied by a remote cache or remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x3803",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data requests that HIT in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1003",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data requests that HITM in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x803",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data reads satisfied by any cache or DRAM.",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x7F01",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "All offcore demand data reads",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.ANY_LOCATION",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xFF01",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data reads satisfied by the IO, CSR, MMIO unit",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x8001",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data reads satisfied by the LLC and not found in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x101",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data reads satisfied by the LLC and HIT in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x201",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data reads satisfied by the LLC  and HITM in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x401",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data reads satisfied by the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x701",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data reads satisfied by the LLC or local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4701",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data reads satisfied by a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1801",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data reads satisfied by a remote cache or remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x3801",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data reads that HIT in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1001",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data reads that HITM in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x801",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand code reads satisfied by any cache or DRAM.",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x7F04",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "All offcore demand code reads",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.ANY_LOCATION",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xFF04",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand code reads satisfied by the IO, CSR, MMIO unit",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x8004",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand code reads satisfied by the LLC and not found in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x104",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand code reads satisfied by the LLC and HIT in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x204",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand code reads satisfied by the LLC  and HITM in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x404",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand code reads satisfied by the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x704",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand code reads satisfied by the LLC or local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4704",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand code reads satisfied by a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1804",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand code reads satisfied by a remote cache or remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x3804",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand code reads that HIT in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1004",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand code reads that HITM in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x804",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand RFO requests satisfied by any cache or DRAM.",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x7F02",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "All offcore demand RFO requests",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.ANY_LOCATION",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xFF02",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand RFO requests satisfied by the IO, CSR, MMIO unit",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x8002",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand RFO requests satisfied by the LLC and not found in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x102",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand RFO requests satisfied by the LLC and HIT in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x202",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand RFO requests satisfied by the LLC  and HITM in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x402",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand RFO requests satisfied by the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x702",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand RFO requests satisfied by the LLC or local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4702",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand RFO requests satisfied by a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1802",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand RFO requests satisfied by a remote cache or remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x3802",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand RFO requests that HIT in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1002",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand RFO requests that HITM in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x802",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore other requests satisfied by any cache or DRAM.",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x7F80",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "All offcore other requests",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.ANY_LOCATION",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xFF80",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore other requests satisfied by the IO, CSR, MMIO unit",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x8080",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore other requests satisfied by the LLC and not found in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x180",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore other requests satisfied by the LLC and HIT in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x280",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore other requests satisfied by the LLC  and HITM in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x480",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore other requests satisfied by the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x780",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore other requests satisfied by the LLC or local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4780",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore other requests satisfied by a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1880",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore other requests satisfied by a remote cache or remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x3880",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore other requests that HIT in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1080",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore other requests that HITM in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x880",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data requests satisfied by any cache or DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x7F30",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "All offcore prefetch data requests",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.ANY_LOCATION",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xFF30",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data requests satisfied by the IO, CSR, MMIO unit.",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x8030",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data requests satisfied by the LLC and not found in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x130",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data requests satisfied by the LLC and HIT in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x230",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data requests satisfied by the LLC  and HITM in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x430",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data requests satisfied by the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x730",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data requests satisfied by the LLC or local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4730",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data requests satisfied by a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1830",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data requests satisfied by a remote cache or remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x3830",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data requests that HIT in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1030",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data requests that HITM in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x830",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data reads satisfied by any cache or DRAM.",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x7F10",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "All offcore prefetch data reads",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.ANY_LOCATION",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xFF10",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data reads satisfied by the IO, CSR, MMIO unit",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x8010",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data reads satisfied by the LLC and not found in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x110",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data reads satisfied by the LLC and HIT in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x210",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data reads satisfied by the LLC  and HITM in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x410",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data reads satisfied by the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x710",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data reads satisfied by the LLC or local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4710",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data reads satisfied by a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1810",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data reads satisfied by a remote cache or remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x3810",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data reads that HIT in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1010",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data reads that HITM in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x810",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch code reads satisfied by any cache or DRAM.",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x7F40",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "All offcore prefetch code reads",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.ANY_LOCATION",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xFF40",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch code reads satisfied by the IO, CSR, MMIO unit",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x8040",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch code reads satisfied by the LLC and not found in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x140",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch code reads satisfied by the LLC and HIT in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x240",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch code reads satisfied by the LLC  and HITM in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x440",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch code reads satisfied by the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x740",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch code reads satisfied by the LLC or local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4740",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch code reads satisfied by a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1840",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch code reads satisfied by a remote cache or remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x3840",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch code reads that HIT in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1040",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch code reads that HITM in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x840",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch RFO requests satisfied by any cache or DRAM.",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x7F20",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "All offcore prefetch RFO requests",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.ANY_LOCATION",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xFF20",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch RFO requests satisfied by the IO, CSR, MMIO unit",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x8020",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch RFO requests satisfied by the LLC and not found in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x120",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch RFO requests satisfied by the LLC and HIT in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x220",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch RFO requests satisfied by the LLC  and HITM in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x420",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch RFO requests satisfied by the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x720",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch RFO requests satisfied by the LLC or local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4720",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch RFO requests satisfied by a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1820",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch RFO requests satisfied by a remote cache or remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x3820",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch RFO requests that HIT in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1020",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch RFO requests that HITM in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x820",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch requests satisfied by any cache or DRAM.",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x7F70",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "All offcore prefetch requests",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.ANY_LOCATION",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xFF70",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch requests satisfied by the IO, CSR, MMIO unit",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x8070",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch requests satisfied by the LLC and not found in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x170",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch requests satisfied by the LLC and HIT in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x270",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch requests satisfied by the LLC  and HITM in a sibling core",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x470",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch requests satisfied by the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x770",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch requests satisfied by the LLC or local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4770",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch requests satisfied by a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1870",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch requests satisfied by a remote cache or remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x3870",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch requests that HIT in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x1070",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch requests that HITM in a remote cache",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x870",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Super Queue lock splits across a cache line",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF4",
         "EventName": "SQ_MISC.SPLIT_LOCK",
         "SampleAfterValue": "2000000",
@@ -3212,7 +2690,6 @@
     },
     {
         "BriefDescription": "Loads delayed with at-Retirement block code",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6",
         "EventName": "STORE_BLOCKS.AT_RET",
         "SampleAfterValue": "200000",
@@ -3220,7 +2697,6 @@
     },
     {
         "BriefDescription": "Cacheable loads delayed with L1D block code",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6",
         "EventName": "STORE_BLOCKS.L1D_BLOCK",
         "SampleAfterValue": "200000",
diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json b/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
index 666e466d351c..c03f8990fa82 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "X87 Floating point assists (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF7",
         "EventName": "FP_ASSIST.ALL",
         "PEBS": "1",
@@ -10,7 +9,6 @@
     },
     {
         "BriefDescription": "X87 Floating poiint assists for invalid input value (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF7",
         "EventName": "FP_ASSIST.INPUT",
         "PEBS": "1",
@@ -19,7 +17,6 @@
     },
     {
         "BriefDescription": "X87 Floating point assists for invalid output value (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF7",
         "EventName": "FP_ASSIST.OUTPUT",
         "PEBS": "1",
@@ -28,7 +25,6 @@
     },
     {
         "BriefDescription": "MMX Uops",
-        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "FP_COMP_OPS_EXE.MMX",
         "SampleAfterValue": "2000000",
@@ -36,7 +32,6 @@
     },
     {
         "BriefDescription": "SSE2 integer Uops",
-        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "FP_COMP_OPS_EXE.SSE2_INTEGER",
         "SampleAfterValue": "2000000",
@@ -44,7 +39,6 @@
     },
     {
         "BriefDescription": "SSE* FP double precision Uops",
-        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "FP_COMP_OPS_EXE.SSE_DOUBLE_PRECISION",
         "SampleAfterValue": "2000000",
@@ -52,7 +46,6 @@
     },
     {
         "BriefDescription": "SSE and SSE2 FP Uops",
-        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "FP_COMP_OPS_EXE.SSE_FP",
         "SampleAfterValue": "2000000",
@@ -60,7 +53,6 @@
     },
     {
         "BriefDescription": "SSE FP packed Uops",
-        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "FP_COMP_OPS_EXE.SSE_FP_PACKED",
         "SampleAfterValue": "2000000",
@@ -68,7 +60,6 @@
     },
     {
         "BriefDescription": "SSE FP scalar Uops",
-        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "FP_COMP_OPS_EXE.SSE_FP_SCALAR",
         "SampleAfterValue": "2000000",
@@ -76,7 +67,6 @@
     },
     {
         "BriefDescription": "SSE* FP single precision Uops",
-        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "FP_COMP_OPS_EXE.SSE_SINGLE_PRECISION",
         "SampleAfterValue": "2000000",
@@ -84,7 +74,6 @@
     },
     {
         "BriefDescription": "Computational floating-point operations executed",
-        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "FP_COMP_OPS_EXE.X87",
         "SampleAfterValue": "2000000",
@@ -92,7 +81,6 @@
     },
     {
         "BriefDescription": "All Floating Point to and from MMX transitions",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCC",
         "EventName": "FP_MMX_TRANS.ANY",
         "SampleAfterValue": "2000000",
@@ -100,7 +88,6 @@
     },
     {
         "BriefDescription": "Transitions from MMX to Floating Point instructions",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCC",
         "EventName": "FP_MMX_TRANS.TO_FP",
         "SampleAfterValue": "2000000",
@@ -108,7 +95,6 @@
     },
     {
         "BriefDescription": "Transitions from Floating Point to MMX instructions",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCC",
         "EventName": "FP_MMX_TRANS.TO_MMX",
         "SampleAfterValue": "2000000",
@@ -116,7 +102,6 @@
     },
     {
         "BriefDescription": "128 bit SIMD integer pack operations",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "SIMD_INT_128.PACK",
         "SampleAfterValue": "200000",
@@ -124,7 +109,6 @@
     },
     {
         "BriefDescription": "128 bit SIMD integer arithmetic operations",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "SIMD_INT_128.PACKED_ARITH",
         "SampleAfterValue": "200000",
@@ -132,7 +116,6 @@
     },
     {
         "BriefDescription": "128 bit SIMD integer logical operations",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "SIMD_INT_128.PACKED_LOGICAL",
         "SampleAfterValue": "200000",
@@ -140,7 +123,6 @@
     },
     {
         "BriefDescription": "128 bit SIMD integer multiply operations",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "SIMD_INT_128.PACKED_MPY",
         "SampleAfterValue": "200000",
@@ -148,7 +130,6 @@
     },
     {
         "BriefDescription": "128 bit SIMD integer shift operations",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "SIMD_INT_128.PACKED_SHIFT",
         "SampleAfterValue": "200000",
@@ -156,7 +137,6 @@
     },
     {
         "BriefDescription": "128 bit SIMD integer shuffle/move operations",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "SIMD_INT_128.SHUFFLE_MOVE",
         "SampleAfterValue": "200000",
@@ -164,7 +144,6 @@
     },
     {
         "BriefDescription": "128 bit SIMD integer unpack operations",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "SIMD_INT_128.UNPACK",
         "SampleAfterValue": "200000",
@@ -172,7 +151,6 @@
     },
     {
         "BriefDescription": "SIMD integer 64 bit pack operations",
-        "Counter": "0,1,2,3",
         "EventCode": "0xFD",
         "EventName": "SIMD_INT_64.PACK",
         "SampleAfterValue": "200000",
@@ -180,7 +158,6 @@
     },
     {
         "BriefDescription": "SIMD integer 64 bit arithmetic operations",
-        "Counter": "0,1,2,3",
         "EventCode": "0xFD",
         "EventName": "SIMD_INT_64.PACKED_ARITH",
         "SampleAfterValue": "200000",
@@ -188,7 +165,6 @@
     },
     {
         "BriefDescription": "SIMD integer 64 bit logical operations",
-        "Counter": "0,1,2,3",
         "EventCode": "0xFD",
         "EventName": "SIMD_INT_64.PACKED_LOGICAL",
         "SampleAfterValue": "200000",
@@ -196,7 +172,6 @@
     },
     {
         "BriefDescription": "SIMD integer 64 bit packed multiply operations",
-        "Counter": "0,1,2,3",
         "EventCode": "0xFD",
         "EventName": "SIMD_INT_64.PACKED_MPY",
         "SampleAfterValue": "200000",
@@ -204,7 +179,6 @@
     },
     {
         "BriefDescription": "SIMD integer 64 bit shift operations",
-        "Counter": "0,1,2,3",
         "EventCode": "0xFD",
         "EventName": "SIMD_INT_64.PACKED_SHIFT",
         "SampleAfterValue": "200000",
@@ -212,7 +186,6 @@
     },
     {
         "BriefDescription": "SIMD integer 64 bit shuffle/move operations",
-        "Counter": "0,1,2,3",
         "EventCode": "0xFD",
         "EventName": "SIMD_INT_64.SHUFFLE_MOVE",
         "SampleAfterValue": "200000",
@@ -220,7 +193,6 @@
     },
     {
         "BriefDescription": "SIMD integer 64 bit unpack operations",
-        "Counter": "0,1,2,3",
         "EventCode": "0xFD",
         "EventName": "SIMD_INT_64.UNPACK",
         "SampleAfterValue": "200000",
diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/frontend.json b/tools/perf/pmu-events/arch/x86/nehalemep/frontend.json
index c561ac24d91d..f7f28510e3ae 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/frontend.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "Instructions decoded",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "MACRO_INSTS.DECODED",
         "SampleAfterValue": "2000000",
@@ -9,7 +8,6 @@
     },
     {
         "BriefDescription": "Macro-fused instructions decoded",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA6",
         "EventName": "MACRO_INSTS.FUSIONS_DECODED",
         "SampleAfterValue": "2000000",
@@ -17,7 +15,6 @@
     },
     {
         "BriefDescription": "Two Uop instructions decoded",
-        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "TWO_UOP_INSTS_DECODED",
         "SampleAfterValue": "2000000",
diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/memory.json b/tools/perf/pmu-events/arch/x86/nehalemep/memory.json
index 6e95de3f3409..f810880a295e 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/memory.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/memory.json
@@ -1,738 +1,604 @@
 [
     {
         "BriefDescription": "Offcore data reads satisfied by any DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.ANY_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x6011",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore data reads that missed the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xF811",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore data reads satisfied by the local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4011",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore data reads satisfied by a remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x2011",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code reads satisfied by any DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.ANY_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x6044",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code reads that missed the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xF844",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code reads satisfied by the local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4044",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code reads satisfied by a remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x2044",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore requests satisfied by any DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.ANY_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x60FF",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore requests that missed the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xF8FF",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore requests satisfied by the local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x40FF",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore requests satisfied by a remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x20FF",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore RFO requests satisfied by any DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.ANY_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x6022",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore RFO requests that missed the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xF822",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore RFO requests satisfied by the local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4022",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore RFO requests satisfied by a remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x2022",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore writebacks to any DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.ANY_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x6008",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore writebacks that missed the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xF808",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore writebacks to the local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4008",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore writebacks to a remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x2008",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code or data read requests satisfied by any DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.ANY_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x6077",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code or data read requests that missed the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xF877",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code or data read requests satisfied by the local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4077",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore code or data read requests satisfied by a remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x2077",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore request = all data, response = any DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.ANY_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x6033",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore request = all data, response = any LLC miss",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xF833",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the local DRAM.",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4033",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x2033",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data requests satisfied by any DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.ANY_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x6003",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data requests that missed the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xF803",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data requests satisfied by the local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4003",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data requests satisfied by a remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x2003",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data reads satisfied by any DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.ANY_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x6001",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data reads that missed the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xF801",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data reads satisfied by the local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4001",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand data reads satisfied by a remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x2001",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand code reads satisfied by any DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.ANY_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x6004",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand code reads that missed the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xF804",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand code reads satisfied by the local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4004",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand code reads satisfied by a remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x2004",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand RFO requests satisfied by any DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.ANY_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x6002",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand RFO requests that missed the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xF802",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand RFO requests satisfied by the local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4002",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore demand RFO requests satisfied by a remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x2002",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore other requests satisfied by any DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.ANY_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x6080",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore other requests that missed the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xF880",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore other requests satisfied by a remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x2080",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data requests satisfied by any DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.ANY_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x6030",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data requests that missed the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xF830",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data requests satisfied by the local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4030",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data requests satisfied by a remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x2030",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data reads satisfied by any DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.ANY_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x6010",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data reads that missed the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xF810",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data reads satisfied by the local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4010",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch data reads satisfied by a remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x2010",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch code reads satisfied by any DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.ANY_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x6040",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch code reads that missed the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xF840",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch code reads satisfied by the local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4040",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch code reads satisfied by a remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x2040",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch RFO requests satisfied by any DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.ANY_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x6020",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch RFO requests that missed the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xF820",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch RFO requests satisfied by the local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4020",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch RFO requests satisfied by a remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x2020",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch requests satisfied by any DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.ANY_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x6070",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch requests that missed the LLC",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
         "MSRValue": "0xF870",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch requests satisfied by the local DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x4070",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Offcore prefetch requests satisfied by a remote DRAM",
-        "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
         "MSRValue": "0x2070",
-        "Offcore": "1",
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     }
diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/other.json b/tools/perf/pmu-events/arch/x86/nehalemep/other.json
index f6887b234b0e..fb706cb51832 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/other.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/other.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "ES segment renames",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD5",
         "EventName": "ES_REG_RENAMES",
         "SampleAfterValue": "2000000",
@@ -9,7 +8,6 @@
     },
     {
         "BriefDescription": "I/O transactions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6C",
         "EventName": "IO_TRANSACTIONS",
         "SampleAfterValue": "2000000",
@@ -17,7 +15,6 @@
     },
     {
         "BriefDescription": "L1I instruction fetch stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "L1I.CYCLES_STALLED",
         "SampleAfterValue": "2000000",
@@ -25,7 +22,6 @@
     },
     {
         "BriefDescription": "L1I instruction fetch hits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "L1I.HITS",
         "SampleAfterValue": "2000000",
@@ -33,7 +29,6 @@
     },
     {
         "BriefDescription": "L1I instruction fetch misses",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "L1I.MISSES",
         "SampleAfterValue": "2000000",
@@ -41,7 +36,6 @@
     },
     {
         "BriefDescription": "L1I Instruction fetches",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "L1I.READS",
         "SampleAfterValue": "2000000",
@@ -49,7 +43,6 @@
     },
     {
         "BriefDescription": "Large ITLB hit",
-        "Counter": "0,1,2,3",
         "EventCode": "0x82",
         "EventName": "LARGE_ITLB.HIT",
         "SampleAfterValue": "200000",
@@ -57,7 +50,6 @@
     },
     {
         "BriefDescription": "All loads dispatched",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "LOAD_DISPATCH.ANY",
         "SampleAfterValue": "2000000",
@@ -65,7 +57,6 @@
     },
     {
         "BriefDescription": "Loads dispatched from the MOB",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "LOAD_DISPATCH.MOB",
         "SampleAfterValue": "2000000",
@@ -73,7 +64,6 @@
     },
     {
         "BriefDescription": "Loads dispatched that bypass the MOB",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "LOAD_DISPATCH.RS",
         "SampleAfterValue": "2000000",
@@ -81,7 +71,6 @@
     },
     {
         "BriefDescription": "Loads dispatched from stage 305",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "LOAD_DISPATCH.RS_DELAYED",
         "SampleAfterValue": "2000000",
@@ -89,7 +78,6 @@
     },
     {
         "BriefDescription": "False dependencies due to partial address aliasing",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "PARTIAL_ADDRESS_ALIAS",
         "SampleAfterValue": "200000",
@@ -97,7 +85,6 @@
     },
     {
         "BriefDescription": "All Store buffer stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "SB_DRAIN.ANY",
         "SampleAfterValue": "200000",
@@ -105,7 +92,6 @@
     },
     {
         "BriefDescription": "Segment rename stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD4",
         "EventName": "SEG_RENAME_STALLS",
         "SampleAfterValue": "2000000",
@@ -113,7 +99,6 @@
     },
     {
         "BriefDescription": "Thread responded HIT to snoop",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB8",
         "EventName": "SNOOP_RESPONSE.HIT",
         "SampleAfterValue": "100000",
@@ -121,7 +106,6 @@
     },
     {
         "BriefDescription": "Thread responded HITE to snoop",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB8",
         "EventName": "SNOOP_RESPONSE.HITE",
         "SampleAfterValue": "100000",
@@ -129,7 +113,6 @@
     },
     {
         "BriefDescription": "Thread responded HITM to snoop",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB8",
         "EventName": "SNOOP_RESPONSE.HITM",
         "SampleAfterValue": "100000",
@@ -137,7 +120,6 @@
     },
     {
         "BriefDescription": "Super Queue full stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF6",
         "EventName": "SQ_FULL_STALL_CYCLES",
         "SampleAfterValue": "2000000",
diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/pipeline.json b/tools/perf/pmu-events/arch/x86/nehalemep/pipeline.json
index 6fc1a6efd8e8..c45f2ffa861e 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/pipeline.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "Cycles the divider is busy",
-        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "ARITH.CYCLES_DIV_BUSY",
         "SampleAfterValue": "2000000",
@@ -9,7 +8,6 @@
     },
     {
         "BriefDescription": "Divide Operations executed",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x14",
@@ -20,7 +18,6 @@
     },
     {
         "BriefDescription": "Multiply operations executed",
-        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "ARITH.MUL",
         "SampleAfterValue": "2000000",
@@ -28,7 +25,6 @@
     },
     {
         "BriefDescription": "BACLEAR asserted with bad target address",
-        "Counter": "0,1,2,3",
         "EventCode": "0xE6",
         "EventName": "BACLEAR.BAD_TARGET",
         "SampleAfterValue": "2000000",
@@ -36,7 +32,6 @@
     },
     {
         "BriefDescription": "BACLEAR asserted, regardless of cause",
-        "Counter": "0,1,2,3",
         "EventCode": "0xE6",
         "EventName": "BACLEAR.CLEAR",
         "SampleAfterValue": "2000000",
@@ -44,7 +39,6 @@
     },
     {
         "BriefDescription": "Instruction queue forced BACLEAR",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA7",
         "EventName": "BACLEAR_FORCE_IQ",
         "SampleAfterValue": "2000000",
@@ -52,7 +46,6 @@
     },
     {
         "BriefDescription": "Early Branch Prediciton Unit clears",
-        "Counter": "0,1,2,3",
         "EventCode": "0xE8",
         "EventName": "BPU_CLEARS.EARLY",
         "SampleAfterValue": "2000000",
@@ -60,7 +53,6 @@
     },
     {
         "BriefDescription": "Late Branch Prediction Unit clears",
-        "Counter": "0,1,2,3",
         "EventCode": "0xE8",
         "EventName": "BPU_CLEARS.LATE",
         "SampleAfterValue": "2000000",
@@ -68,7 +60,6 @@
     },
     {
         "BriefDescription": "Branch prediction unit missed call or return",
-        "Counter": "0,1,2,3",
         "EventCode": "0xE5",
         "EventName": "BPU_MISSED_CALL_RET",
         "SampleAfterValue": "2000000",
@@ -76,7 +67,6 @@
     },
     {
         "BriefDescription": "Branch instructions decoded",
-        "Counter": "0,1,2,3",
         "EventCode": "0xE0",
         "EventName": "BR_INST_DECODED",
         "SampleAfterValue": "2000000",
@@ -84,7 +74,6 @@
     },
     {
         "BriefDescription": "Branch instructions executed",
-        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ANY",
         "SampleAfterValue": "200000",
@@ -92,7 +81,6 @@
     },
     {
         "BriefDescription": "Conditional branch instructions executed",
-        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.COND",
         "SampleAfterValue": "200000",
@@ -100,7 +88,6 @@
     },
     {
         "BriefDescription": "Unconditional branches executed",
-        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.DIRECT",
         "SampleAfterValue": "200000",
@@ -108,7 +95,6 @@
     },
     {
         "BriefDescription": "Unconditional call branches executed",
-        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.DIRECT_NEAR_CALL",
         "SampleAfterValue": "20000",
@@ -116,7 +102,6 @@
     },
     {
         "BriefDescription": "Indirect call branches executed",
-        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.INDIRECT_NEAR_CALL",
         "SampleAfterValue": "20000",
@@ -124,7 +109,6 @@
     },
     {
         "BriefDescription": "Indirect non call branches executed",
-        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.INDIRECT_NON_CALL",
         "SampleAfterValue": "20000",
@@ -132,7 +116,6 @@
     },
     {
         "BriefDescription": "Call branches executed",
-        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.NEAR_CALLS",
         "SampleAfterValue": "20000",
@@ -140,7 +123,6 @@
     },
     {
         "BriefDescription": "All non call branches executed",
-        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.NON_CALLS",
         "SampleAfterValue": "200000",
@@ -148,7 +130,6 @@
     },
     {
         "BriefDescription": "Indirect return branches executed",
-        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.RETURN_NEAR",
         "SampleAfterValue": "20000",
@@ -156,7 +137,6 @@
     },
     {
         "BriefDescription": "Taken branches executed",
-        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN",
         "SampleAfterValue": "200000",
@@ -164,7 +144,6 @@
     },
     {
         "BriefDescription": "Retired branch instructions (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
@@ -173,7 +152,6 @@
     },
     {
         "BriefDescription": "Retired conditional branch instructions (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.CONDITIONAL",
         "PEBS": "1",
@@ -182,7 +160,6 @@
     },
     {
         "BriefDescription": "Retired near call instructions (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
         "PEBS": "1",
@@ -191,7 +168,6 @@
     },
     {
         "BriefDescription": "Mispredicted branches executed",
-        "Counter": "0,1,2,3",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.ANY",
         "SampleAfterValue": "20000",
@@ -199,7 +175,6 @@
     },
     {
         "BriefDescription": "Mispredicted conditional branches executed",
-        "Counter": "0,1,2,3",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.COND",
         "SampleAfterValue": "20000",
@@ -207,7 +182,6 @@
     },
     {
         "BriefDescription": "Mispredicted unconditional branches executed",
-        "Counter": "0,1,2,3",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.DIRECT",
         "SampleAfterValue": "20000",
@@ -215,7 +189,6 @@
     },
     {
         "BriefDescription": "Mispredicted non call branches executed",
-        "Counter": "0,1,2,3",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.DIRECT_NEAR_CALL",
         "SampleAfterValue": "2000",
@@ -223,7 +196,6 @@
     },
     {
         "BriefDescription": "Mispredicted indirect call branches executed",
-        "Counter": "0,1,2,3",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.INDIRECT_NEAR_CALL",
         "SampleAfterValue": "2000",
@@ -231,7 +203,6 @@
     },
     {
         "BriefDescription": "Mispredicted indirect non call branches executed",
-        "Counter": "0,1,2,3",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.INDIRECT_NON_CALL",
         "SampleAfterValue": "2000",
@@ -239,7 +210,6 @@
     },
     {
         "BriefDescription": "Mispredicted call branches executed",
-        "Counter": "0,1,2,3",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.NEAR_CALLS",
         "SampleAfterValue": "2000",
@@ -247,7 +217,6 @@
     },
     {
         "BriefDescription": "Mispredicted non call branches executed",
-        "Counter": "0,1,2,3",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.NON_CALLS",
         "SampleAfterValue": "20000",
@@ -255,7 +224,6 @@
     },
     {
         "BriefDescription": "Mispredicted return branches executed",
-        "Counter": "0,1,2,3",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.RETURN_NEAR",
         "SampleAfterValue": "2000",
@@ -263,7 +231,6 @@
     },
     {
         "BriefDescription": "Mispredicted taken branches executed",
-        "Counter": "0,1,2,3",
         "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.TAKEN",
         "SampleAfterValue": "20000",
@@ -271,7 +238,6 @@
     },
     {
         "BriefDescription": "Mispredicted near retired calls (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.NEAR_CALL",
         "PEBS": "1",
@@ -280,15 +246,11 @@
     },
     {
         "BriefDescription": "Reference cycles when thread is not halted (fixed counter)",
-        "Counter": "Fixed counter 3",
-        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x0"
+        "SampleAfterValue": "2000000"
     },
     {
         "BriefDescription": "Reference base clock (133 Mhz) cycles when thread is not halted (programmable counter)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.REF_P",
         "SampleAfterValue": "100000",
@@ -296,33 +258,25 @@
     },
     {
         "BriefDescription": "Cycles when thread is not halted (fixed counter)",
-        "Counter": "Fixed counter 2",
-        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x0"
+        "SampleAfterValue": "2000000"
     },
     {
         "BriefDescription": "Cycles when thread is not halted (programmable counter)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x0"
+        "SampleAfterValue": "2000000"
     },
     {
         "BriefDescription": "Total CPU cycles",
-        "Counter": "0,1,2,3",
         "CounterMask": "2",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.TOTAL_CYCLES",
         "Invert": "1",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x0"
+        "SampleAfterValue": "2000000"
     },
     {
         "BriefDescription": "Any Instruction Length Decoder stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "ILD_STALL.ANY",
         "SampleAfterValue": "2000000",
@@ -330,7 +284,6 @@
     },
     {
         "BriefDescription": "Instruction Queue full stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "ILD_STALL.IQ_FULL",
         "SampleAfterValue": "2000000",
@@ -338,7 +291,6 @@
     },
     {
         "BriefDescription": "Length Change Prefix stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "ILD_STALL.LCP",
         "SampleAfterValue": "2000000",
@@ -346,7 +298,6 @@
     },
     {
         "BriefDescription": "Stall cycles due to BPU MRU bypass",
-        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "ILD_STALL.MRU",
         "SampleAfterValue": "2000000",
@@ -354,7 +305,6 @@
     },
     {
         "BriefDescription": "Regen stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "ILD_STALL.REGEN",
         "SampleAfterValue": "2000000",
@@ -362,7 +312,6 @@
     },
     {
         "BriefDescription": "Instructions that must be decoded by decoder 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "INST_DECODED.DEC0",
         "SampleAfterValue": "2000000",
@@ -370,7 +319,6 @@
     },
     {
         "BriefDescription": "Instructions written to instruction queue.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x17",
         "EventName": "INST_QUEUE_WRITES",
         "SampleAfterValue": "2000000",
@@ -378,7 +326,6 @@
     },
     {
         "BriefDescription": "Cycles instructions are written to the instruction queue",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1E",
         "EventName": "INST_QUEUE_WRITE_CYCLES",
         "SampleAfterValue": "2000000",
@@ -386,15 +333,11 @@
     },
     {
         "BriefDescription": "Instructions retired (fixed counter)",
-        "Counter": "Fixed counter 1",
-        "EventCode": "0x0",
         "EventName": "INST_RETIRED.ANY",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x0"
+        "SampleAfterValue": "2000000"
     },
     {
         "BriefDescription": "Instructions retired (Programmable counter and Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.ANY_P",
         "PEBS": "1",
@@ -403,7 +346,6 @@
     },
     {
         "BriefDescription": "Retired MMX instructions (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.MMX",
         "PEBS": "1",
@@ -412,7 +354,6 @@
     },
     {
         "BriefDescription": "Total cycles (Precise Event)",
-        "Counter": "0,1,2,3",
         "CounterMask": "16",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.TOTAL_CYCLES",
@@ -423,7 +364,6 @@
     },
     {
         "BriefDescription": "Total cycles (Precise Event)",
-        "Counter": "0,1,2,3",
         "CounterMask": "16",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.TOTAL_CYCLES_PS",
@@ -434,7 +374,6 @@
     },
     {
         "BriefDescription": "Retired floating-point operations (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.X87",
         "PEBS": "1",
@@ -443,7 +382,6 @@
     },
     {
         "BriefDescription": "Load operations conflicting with software prefetches",
-        "Counter": "0,1",
         "EventCode": "0x4C",
         "EventName": "LOAD_HIT_PRE",
         "SampleAfterValue": "200000",
@@ -451,7 +389,6 @@
     },
     {
         "BriefDescription": "Cycles when uops were delivered by the LSD",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xA8",
         "EventName": "LSD.ACTIVE",
@@ -460,7 +397,6 @@
     },
     {
         "BriefDescription": "Cycles no uops were delivered by the LSD",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xA8",
         "EventName": "LSD.INACTIVE",
@@ -470,7 +406,6 @@
     },
     {
         "BriefDescription": "Loops that can't stream from the instruction queue",
-        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "LSD_OVERFLOW",
         "SampleAfterValue": "2000000",
@@ -478,7 +413,6 @@
     },
     {
         "BriefDescription": "Cycles machine clear asserted",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.CYCLES",
         "SampleAfterValue": "20000",
@@ -486,7 +420,6 @@
     },
     {
         "BriefDescription": "Execution pipeline restart due to Memory ordering conflicts",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MEM_ORDER",
         "SampleAfterValue": "20000",
@@ -494,7 +427,6 @@
     },
     {
         "BriefDescription": "Self-Modifying Code detected",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.SMC",
         "SampleAfterValue": "20000",
@@ -502,7 +434,6 @@
     },
     {
         "BriefDescription": "All RAT stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "RAT_STALLS.ANY",
         "SampleAfterValue": "2000000",
@@ -510,7 +441,6 @@
     },
     {
         "BriefDescription": "Flag stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "RAT_STALLS.FLAGS",
         "SampleAfterValue": "2000000",
@@ -518,7 +448,6 @@
     },
     {
         "BriefDescription": "Partial register stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "RAT_STALLS.REGISTERS",
         "SampleAfterValue": "2000000",
@@ -526,7 +455,6 @@
     },
     {
         "BriefDescription": "ROB read port stalls cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "RAT_STALLS.ROB_READ_PORT",
         "SampleAfterValue": "2000000",
@@ -534,7 +462,6 @@
     },
     {
         "BriefDescription": "Scoreboard stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "RAT_STALLS.SCOREBOARD",
         "SampleAfterValue": "2000000",
@@ -542,7 +469,6 @@
     },
     {
         "BriefDescription": "Resource related stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.ANY",
         "SampleAfterValue": "2000000",
@@ -550,7 +476,6 @@
     },
     {
         "BriefDescription": "FPU control word write stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.FPCW",
         "SampleAfterValue": "2000000",
@@ -558,7 +483,6 @@
     },
     {
         "BriefDescription": "Load buffer stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.LOAD",
         "SampleAfterValue": "2000000",
@@ -566,7 +490,6 @@
     },
     {
         "BriefDescription": "MXCSR rename stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.MXCSR",
         "SampleAfterValue": "2000000",
@@ -574,7 +497,6 @@
     },
     {
         "BriefDescription": "Other Resource related stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.OTHER",
         "SampleAfterValue": "2000000",
@@ -582,7 +504,6 @@
     },
     {
         "BriefDescription": "ROB full stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.ROB_FULL",
         "SampleAfterValue": "2000000",
@@ -590,7 +511,6 @@
     },
     {
         "BriefDescription": "Reservation Station full stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.RS_FULL",
         "SampleAfterValue": "2000000",
@@ -598,7 +518,6 @@
     },
     {
         "BriefDescription": "Store buffer stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.STORE",
         "SampleAfterValue": "2000000",
@@ -606,7 +525,6 @@
     },
     {
         "BriefDescription": "SIMD Packed-Double Uops retired (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC7",
         "EventName": "SSEX_UOPS_RETIRED.PACKED_DOUBLE",
         "PEBS": "1",
@@ -615,7 +533,6 @@
     },
     {
         "BriefDescription": "SIMD Packed-Single Uops retired (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC7",
         "EventName": "SSEX_UOPS_RETIRED.PACKED_SINGLE",
         "PEBS": "1",
@@ -624,7 +541,6 @@
     },
     {
         "BriefDescription": "SIMD Scalar-Double Uops retired (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC7",
         "EventName": "SSEX_UOPS_RETIRED.SCALAR_DOUBLE",
         "PEBS": "1",
@@ -633,7 +549,6 @@
     },
     {
         "BriefDescription": "SIMD Scalar-Single Uops retired (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC7",
         "EventName": "SSEX_UOPS_RETIRED.SCALAR_SINGLE",
         "PEBS": "1",
@@ -642,7 +557,6 @@
     },
     {
         "BriefDescription": "SIMD Vector Integer Uops retired (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC7",
         "EventName": "SSEX_UOPS_RETIRED.VECTOR_INTEGER",
         "PEBS": "1",
@@ -651,7 +565,6 @@
     },
     {
         "BriefDescription": "Stack pointer instructions decoded",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD1",
         "EventName": "UOPS_DECODED.ESP_FOLDING",
         "SampleAfterValue": "2000000",
@@ -659,7 +572,6 @@
     },
     {
         "BriefDescription": "Stack pointer sync operations",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD1",
         "EventName": "UOPS_DECODED.ESP_SYNC",
         "SampleAfterValue": "2000000",
@@ -667,7 +579,6 @@
     },
     {
         "BriefDescription": "Uops decoded by Microcode Sequencer",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xD1",
         "EventName": "UOPS_DECODED.MS_CYCLES_ACTIVE",
@@ -676,7 +587,6 @@
     },
     {
         "BriefDescription": "Cycles no Uops are decoded",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xD1",
         "EventName": "UOPS_DECODED.STALL_CYCLES",
@@ -687,7 +597,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles Uops executed on any port (core count)",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_ACTIVE_CYCLES",
@@ -697,7 +606,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles Uops executed on ports 0-4 (core count)",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_ACTIVE_CYCLES_NO_PORT5",
@@ -707,7 +615,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Uops executed on any port (core count)",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0xB1",
@@ -719,7 +626,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Uops executed on ports 0-4 (core count)",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0xB1",
@@ -731,7 +637,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles no Uops issued on any port (core count)",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_STALL_CYCLES",
@@ -742,7 +647,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles no Uops issued on ports 0-4 (core count)",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_STALL_CYCLES_NO_PORT5",
@@ -752,7 +656,6 @@
     },
     {
         "BriefDescription": "Uops executed on port 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.PORT0",
         "SampleAfterValue": "2000000",
@@ -760,7 +663,6 @@
     },
     {
         "BriefDescription": "Uops issued on ports 0, 1 or 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.PORT015",
         "SampleAfterValue": "2000000",
@@ -768,7 +670,6 @@
     },
     {
         "BriefDescription": "Cycles no Uops issued on ports 0, 1 or 5",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.PORT015_STALL_CYCLES",
@@ -778,7 +679,6 @@
     },
     {
         "BriefDescription": "Uops executed on port 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.PORT1",
         "SampleAfterValue": "2000000",
@@ -787,7 +687,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Uops issued on ports 2, 3 or 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.PORT234_CORE",
         "SampleAfterValue": "2000000",
@@ -796,7 +695,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Uops executed on port 2 (core count)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.PORT2_CORE",
         "SampleAfterValue": "2000000",
@@ -805,7 +703,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Uops executed on port 3 (core count)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.PORT3_CORE",
         "SampleAfterValue": "2000000",
@@ -814,7 +711,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Uops executed on port 4 (core count)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.PORT4_CORE",
         "SampleAfterValue": "2000000",
@@ -822,7 +718,6 @@
     },
     {
         "BriefDescription": "Uops executed on port 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.PORT5",
         "SampleAfterValue": "2000000",
@@ -830,7 +725,6 @@
     },
     {
         "BriefDescription": "Uops issued",
-        "Counter": "0,1,2,3",
         "EventCode": "0xE",
         "EventName": "UOPS_ISSUED.ANY",
         "SampleAfterValue": "2000000",
@@ -839,7 +733,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles no Uops were issued on any thread",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xE",
         "EventName": "UOPS_ISSUED.CORE_STALL_CYCLES",
@@ -850,7 +743,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles Uops were issued on either thread",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xE",
         "EventName": "UOPS_ISSUED.CYCLES_ALL_THREADS",
@@ -859,7 +751,6 @@
     },
     {
         "BriefDescription": "Fused Uops issued",
-        "Counter": "0,1,2,3",
         "EventCode": "0xE",
         "EventName": "UOPS_ISSUED.FUSED",
         "SampleAfterValue": "2000000",
@@ -867,7 +758,6 @@
     },
     {
         "BriefDescription": "Cycles no Uops were issued",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xE",
         "EventName": "UOPS_ISSUED.STALL_CYCLES",
@@ -877,7 +767,6 @@
     },
     {
         "BriefDescription": "Cycles Uops are being retired",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.ACTIVE_CYCLES",
@@ -887,7 +776,6 @@
     },
     {
         "BriefDescription": "Uops retired (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.ANY",
         "PEBS": "1",
@@ -896,7 +784,6 @@
     },
     {
         "BriefDescription": "Macro-fused Uops retired (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.MACRO_FUSED",
         "PEBS": "1",
@@ -905,7 +792,6 @@
     },
     {
         "BriefDescription": "Retirement slots used (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.RETIRE_SLOTS",
         "PEBS": "1",
@@ -914,7 +800,6 @@
     },
     {
         "BriefDescription": "Cycles Uops are not retiring (Precise Event)",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.STALL_CYCLES",
@@ -925,7 +810,6 @@
     },
     {
         "BriefDescription": "Total cycles using precise uop retired event (Precise Event)",
-        "Counter": "0,1,2,3",
         "CounterMask": "16",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.TOTAL_CYCLES",
@@ -936,7 +820,6 @@
     },
     {
         "BriefDescription": "Uop unfusions due to FP exceptions",
-        "Counter": "0,1,2,3",
         "EventCode": "0xDB",
         "EventName": "UOP_UNFUSION",
         "SampleAfterValue": "2000000",
diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json b/tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json
index e88c0802e679..c434cd4ef4f1 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "DTLB load misses",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "DTLB_LOAD_MISSES.ANY",
         "SampleAfterValue": "200000",
@@ -9,7 +8,6 @@
     },
     {
         "BriefDescription": "DTLB load miss caused by low part of address",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "DTLB_LOAD_MISSES.PDE_MISS",
         "SampleAfterValue": "200000",
@@ -17,7 +15,6 @@
     },
     {
         "BriefDescription": "DTLB second level hit",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
         "SampleAfterValue": "2000000",
@@ -25,7 +22,6 @@
     },
     {
         "BriefDescription": "DTLB load miss page walks complete",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
         "SampleAfterValue": "200000",
@@ -33,7 +29,6 @@
     },
     {
         "BriefDescription": "DTLB misses",
-        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_MISSES.ANY",
         "SampleAfterValue": "200000",
@@ -41,7 +36,6 @@
     },
     {
         "BriefDescription": "DTLB first level misses but second level hit",
-        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_MISSES.STLB_HIT",
         "SampleAfterValue": "200000",
@@ -49,7 +43,6 @@
     },
     {
         "BriefDescription": "DTLB miss page walks",
-        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_MISSES.WALK_COMPLETED",
         "SampleAfterValue": "200000",
@@ -57,7 +50,6 @@
     },
     {
         "BriefDescription": "ITLB flushes",
-        "Counter": "0,1,2,3",
         "EventCode": "0xAE",
         "EventName": "ITLB_FLUSH",
         "SampleAfterValue": "2000000",
@@ -65,7 +57,6 @@
     },
     {
         "BriefDescription": "ITLB miss",
-        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.ANY",
         "SampleAfterValue": "200000",
@@ -73,7 +64,6 @@
     },
     {
         "BriefDescription": "ITLB miss page walks",
-        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
         "SampleAfterValue": "200000",
@@ -81,7 +71,6 @@
     },
     {
         "BriefDescription": "Retired instructions that missed the ITLB (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC8",
         "EventName": "ITLB_MISS_RETIRED",
         "PEBS": "1",
@@ -90,7 +79,6 @@
     },
     {
         "BriefDescription": "Retired loads that miss the DTLB (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCB",
         "EventName": "MEM_LOAD_RETIRED.DTLB_MISS",
         "PEBS": "1",
@@ -99,7 +87,6 @@
     },
     {
         "BriefDescription": "Retired stores that miss the DTLB (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC",
         "EventName": "MEM_STORE_RETIRED.DTLB_MISS",
         "PEBS": "1",
-- 
2.39.0.314.g84b9a713c41-goog

