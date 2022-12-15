Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2CD64D6E9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 08:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiLOHEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 02:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiLOHCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 02:02:33 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0B16A77D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:58:45 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b4-20020a253404000000b006fad1bb09f4so2690252yba.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LbP9CfI/wphrmtxrxumHc1AjXrJ+DSqoE8tq1Yk0lxo=;
        b=gWAC5btPJ+BK0vt7r7Sf+ibGngd5oSwLDWtonisCffp5b+y65XcKhqyYFz4AEJbeXr
         ZH3+y9/h4NycMVRyZW5vwiMVceh/amO7AcuLnHkm0kvVodZTYAzJTHW5qOQIfTG/MqJ3
         WWQl2HD/YPtY3XgLwb10E40M2enNte0O9q+1tbrx+hAo7C8bNy2j7ABfdx+9VkzXyXcG
         3MsNYA1vpp1uIPaeC/w0cX1g1rFnql2iC8RvLIPDUkxuFxw6O1tnzoG39O+tRNDMjuPM
         KP3ERbvD3hi5aI+d21Trp6Ky3zAo5J9bSM3uy0O1A+npBTsvt/fopVJUf8tztcZgMDEQ
         e8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LbP9CfI/wphrmtxrxumHc1AjXrJ+DSqoE8tq1Yk0lxo=;
        b=L2cl5HD2o6MOCROcsTun5O4cs+hdPC4xie/kGa+HxNqIz0W2BcLw7K/qXMNft6zHHz
         sUh0n/5ZzI8/eKGyniUKAWlN0MXW9LvX7qtoa7QrjYcQGb2q6SUUin/mX0A0i6Mux6lG
         skRg0TreNeH9Ps53nHQkCosU5rvI3hLrt6nM5haTmQeEE2nSDpTxs05sjyGaPDj1GOH+
         ruC4vL4oHkoWywoc3enEZhHX7+4GFES97pWcrfUQVP7/YmoAtr0jGsQJ9cfPKwgxXA8Q
         k3R18cixzxxagYoNOzfJm+ZVgzN87pLujzbfT1RU0AZIq/aNrXdUt27YA+UEBICvm8/e
         vY1Q==
X-Gm-Message-State: ANoB5pkG8wJChzGoo3O9R0pvGMgFyeUdQoc6TbFvViPTXrI8VcpGkFyu
        +mJQ+u5Umd6phoB2NaBg9+Wn8GsIsrIz
X-Google-Smtp-Source: AA0mqf7GXsPyYYNPA4Z71yrL5dk2G/rxOfQbdHEtm3SOnRn+UQcS4CTibd8740RRkIC42aw44AuqUE9Q5wCr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c7dc:d96f:4f9:f59d])
 (user=irogers job=sendgmr) by 2002:a25:e648:0:b0:6f2:bad:1be7 with SMTP id
 d69-20020a25e648000000b006f20bad1be7mr65299917ybh.84.1671087524694; Wed, 14
 Dec 2022 22:58:44 -0800 (PST)
Date:   Wed, 14 Dec 2022 22:55:10 -0800
In-Reply-To: <20221215065510.1621979-1-irogers@google.com>
Message-Id: <20221215065510.1621979-24-irogers@google.com>
Mime-Version: 1.0
References: <20221215065510.1621979-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 32/32] perf vendor events intel: Refresh westmereex events
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

Update the westmereex events using the new tooling from:
https://github.com/intel/perfmon

The events are unchanged but unused json values are removed. This
increases consistency across the json files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/westmereex/cache.json | 516 ------------------
 .../arch/x86/westmereex/floating-point.json   |  28 -
 .../arch/x86/westmereex/frontend.json         |   3 -
 .../arch/x86/westmereex/memory.json           | 135 -----
 .../pmu-events/arch/x86/westmereex/other.json |  22 -
 .../arch/x86/westmereex/pipeline.json         | 129 +----
 .../arch/x86/westmereex/virtual-memory.json   |  21 -
 7 files changed, 5 insertions(+), 849 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/westmereex/cache.json b/tools/perf/pmu-events/arch/x86/westmereex/cache.json
index d6243d008bfe..6c7c52733dda 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/cache.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/cache.json
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
         "BriefDescription": "L1D prefetch load lock accepted in fill buffer",
-        "Counter": "0,1",
         "EventCode": "0x52",
         "EventName": "L1D_CACHE_PREFETCH_LOCK_FB_HIT",
         "SampleAfterValue": "2000000",
@@ -57,7 +50,6 @@
     },
     {
         "BriefDescription": "L1D hardware prefetch misses",
-        "Counter": "0,1",
         "EventCode": "0x4E",
         "EventName": "L1D_PREFETCH.MISS",
         "SampleAfterValue": "200000",
@@ -65,7 +57,6 @@
     },
     {
         "BriefDescription": "L1D hardware prefetch requests",
-        "Counter": "0,1",
         "EventCode": "0x4E",
         "EventName": "L1D_PREFETCH.REQUESTS",
         "SampleAfterValue": "200000",
@@ -73,7 +64,6 @@
     },
     {
         "BriefDescription": "L1D hardware prefetch requests triggered",
-        "Counter": "0,1",
         "EventCode": "0x4E",
         "EventName": "L1D_PREFETCH.TRIGGERS",
         "SampleAfterValue": "200000",
@@ -81,7 +71,6 @@
     },
     {
         "BriefDescription": "L1 writebacks to L2 in E state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "L1D_WB_L2.E_STATE",
         "SampleAfterValue": "100000",
@@ -89,7 +78,6 @@
     },
     {
         "BriefDescription": "L1 writebacks to L2 in I state (misses)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "L1D_WB_L2.I_STATE",
         "SampleAfterValue": "100000",
@@ -97,7 +85,6 @@
     },
     {
         "BriefDescription": "All L1 writebacks to L2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "L1D_WB_L2.MESI",
         "SampleAfterValue": "100000",
@@ -105,7 +92,6 @@
     },
     {
         "BriefDescription": "L1 writebacks to L2 in M state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "L1D_WB_L2.M_STATE",
         "SampleAfterValue": "100000",
@@ -113,7 +99,6 @@
     },
     {
         "BriefDescription": "L1 writebacks to L2 in S state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "L1D_WB_L2.S_STATE",
         "SampleAfterValue": "100000",
@@ -121,7 +106,6 @@
     },
     {
         "BriefDescription": "All L2 data requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.ANY",
         "SampleAfterValue": "200000",
@@ -129,7 +113,6 @@
     },
     {
         "BriefDescription": "L2 data demand loads in E state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.DEMAND.E_STATE",
         "SampleAfterValue": "200000",
@@ -137,7 +120,6 @@
     },
     {
         "BriefDescription": "L2 data demand loads in I state (misses)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.DEMAND.I_STATE",
         "SampleAfterValue": "200000",
@@ -145,7 +127,6 @@
     },
     {
         "BriefDescription": "L2 data demand requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.DEMAND.MESI",
         "SampleAfterValue": "200000",
@@ -153,7 +134,6 @@
     },
     {
         "BriefDescription": "L2 data demand loads in M state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.DEMAND.M_STATE",
         "SampleAfterValue": "200000",
@@ -161,7 +141,6 @@
     },
     {
         "BriefDescription": "L2 data demand loads in S state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.DEMAND.S_STATE",
         "SampleAfterValue": "200000",
@@ -169,7 +148,6 @@
     },
     {
         "BriefDescription": "L2 data prefetches in E state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.PREFETCH.E_STATE",
         "SampleAfterValue": "200000",
@@ -177,7 +155,6 @@
     },
     {
         "BriefDescription": "L2 data prefetches in the I state (misses)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.PREFETCH.I_STATE",
         "SampleAfterValue": "200000",
@@ -185,7 +162,6 @@
     },
     {
         "BriefDescription": "All L2 data prefetches",
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.PREFETCH.MESI",
         "SampleAfterValue": "200000",
@@ -193,7 +169,6 @@
     },
     {
         "BriefDescription": "L2 data prefetches in M state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.PREFETCH.M_STATE",
         "SampleAfterValue": "200000",
@@ -201,7 +176,6 @@
     },
     {
         "BriefDescription": "L2 data prefetches in the S state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.PREFETCH.S_STATE",
         "SampleAfterValue": "200000",
@@ -209,7 +183,6 @@
     },
     {
         "BriefDescription": "L2 lines alloacated",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.ANY",
         "SampleAfterValue": "100000",
@@ -217,7 +190,6 @@
     },
     {
         "BriefDescription": "L2 lines allocated in the E state",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.E_STATE",
         "SampleAfterValue": "100000",
@@ -225,7 +197,6 @@
     },
     {
         "BriefDescription": "L2 lines allocated in the S state",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.S_STATE",
         "SampleAfterValue": "100000",
@@ -233,7 +204,6 @@
     },
     {
         "BriefDescription": "L2 lines evicted",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.ANY",
         "SampleAfterValue": "100000",
@@ -241,7 +211,6 @@
     },
     {
         "BriefDescription": "L2 lines evicted by a demand request",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.DEMAND_CLEAN",
         "SampleAfterValue": "100000",
@@ -249,7 +218,6 @@
     },
     {
         "BriefDescription": "L2 modified lines evicted by a demand request",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.DEMAND_DIRTY",
         "SampleAfterValue": "100000",
@@ -257,7 +225,6 @@
     },
     {
         "BriefDescription": "L2 lines evicted by a prefetch request",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.PREFETCH_CLEAN",
         "SampleAfterValue": "100000",
@@ -265,7 +232,6 @@
     },
     {
         "BriefDescription": "L2 modified lines evicted by a prefetch request",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.PREFETCH_DIRTY",
         "SampleAfterValue": "100000",
@@ -273,7 +239,6 @@
     },
     {
         "BriefDescription": "L2 instruction fetches",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.IFETCHES",
         "SampleAfterValue": "200000",
@@ -281,7 +246,6 @@
     },
     {
         "BriefDescription": "L2 instruction fetch hits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.IFETCH_HIT",
         "SampleAfterValue": "200000",
@@ -289,7 +253,6 @@
     },
     {
         "BriefDescription": "L2 instruction fetch misses",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.IFETCH_MISS",
         "SampleAfterValue": "200000",
@@ -297,7 +260,6 @@
     },
     {
         "BriefDescription": "L2 load hits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.LD_HIT",
         "SampleAfterValue": "200000",
@@ -305,7 +267,6 @@
     },
     {
         "BriefDescription": "L2 load misses",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.LD_MISS",
         "SampleAfterValue": "200000",
@@ -313,7 +274,6 @@
     },
     {
         "BriefDescription": "L2 requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.LOADS",
         "SampleAfterValue": "200000",
@@ -321,7 +281,6 @@
     },
     {
         "BriefDescription": "All L2 misses",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.MISS",
         "SampleAfterValue": "200000",
@@ -329,7 +288,6 @@
     },
     {
         "BriefDescription": "All L2 prefetches",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.PREFETCHES",
         "SampleAfterValue": "200000",
@@ -337,7 +295,6 @@
     },
     {
         "BriefDescription": "L2 prefetch hits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.PREFETCH_HIT",
         "SampleAfterValue": "200000",
@@ -345,7 +302,6 @@
     },
     {
         "BriefDescription": "L2 prefetch misses",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.PREFETCH_MISS",
         "SampleAfterValue": "200000",
@@ -353,7 +309,6 @@
     },
     {
         "BriefDescription": "All L2 requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.REFERENCES",
         "SampleAfterValue": "200000",
@@ -361,7 +316,6 @@
     },
     {
         "BriefDescription": "L2 RFO requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFOS",
         "SampleAfterValue": "200000",
@@ -369,7 +323,6 @@
     },
     {
         "BriefDescription": "L2 RFO hits",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_HIT",
         "SampleAfterValue": "200000",
@@ -377,7 +330,6 @@
     },
     {
         "BriefDescription": "L2 RFO misses",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_MISS",
         "SampleAfterValue": "200000",
@@ -385,7 +337,6 @@
     },
     {
         "BriefDescription": "All L2 transactions",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF0",
         "EventName": "L2_TRANSACTIONS.ANY",
         "SampleAfterValue": "200000",
@@ -393,7 +344,6 @@
     },
     {
         "BriefDescription": "L2 fill transactions",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF0",
         "EventName": "L2_TRANSACTIONS.FILL",
         "SampleAfterValue": "200000",
@@ -401,7 +351,6 @@
     },
     {
         "BriefDescription": "L2 instruction fetch transactions",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF0",
         "EventName": "L2_TRANSACTIONS.IFETCH",
         "SampleAfterValue": "200000",
@@ -409,7 +358,6 @@
     },
     {
         "BriefDescription": "L1D writeback to L2 transactions",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF0",
         "EventName": "L2_TRANSACTIONS.L1D_WB",
         "SampleAfterValue": "200000",
@@ -417,7 +365,6 @@
     },
     {
         "BriefDescription": "L2 Load transactions",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF0",
         "EventName": "L2_TRANSACTIONS.LOAD",
         "SampleAfterValue": "200000",
@@ -425,7 +372,6 @@
     },
     {
         "BriefDescription": "L2 prefetch transactions",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF0",
         "EventName": "L2_TRANSACTIONS.PREFETCH",
         "SampleAfterValue": "200000",
@@ -433,7 +379,6 @@
     },
     {
         "BriefDescription": "L2 RFO transactions",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF0",
         "EventName": "L2_TRANSACTIONS.RFO",
         "SampleAfterValue": "200000",
@@ -441,7 +386,6 @@
     },
     {
         "BriefDescription": "L2 writeback to LLC transactions",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF0",
         "EventName": "L2_TRANSACTIONS.WB",
         "SampleAfterValue": "200000",
@@ -449,7 +393,6 @@
     },
     {
         "BriefDescription": "L2 demand lock RFOs in E state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "L2_WRITE.LOCK.E_STATE",
         "SampleAfterValue": "100000",
@@ -457,7 +400,6 @@
     },
     {
         "BriefDescription": "All demand L2 lock RFOs that hit the cache",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "L2_WRITE.LOCK.HIT",
         "SampleAfterValue": "100000",
@@ -465,7 +407,6 @@
     },
     {
         "BriefDescription": "L2 demand lock RFOs in I state (misses)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "L2_WRITE.LOCK.I_STATE",
         "SampleAfterValue": "100000",
@@ -473,7 +414,6 @@
     },
     {
         "BriefDescription": "All demand L2 lock RFOs",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "L2_WRITE.LOCK.MESI",
         "SampleAfterValue": "100000",
@@ -481,7 +421,6 @@
     },
     {
         "BriefDescription": "L2 demand lock RFOs in M state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "L2_WRITE.LOCK.M_STATE",
         "SampleAfterValue": "100000",
@@ -489,7 +428,6 @@
     },
     {
         "BriefDescription": "L2 demand lock RFOs in S state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "L2_WRITE.LOCK.S_STATE",
         "SampleAfterValue": "100000",
@@ -497,7 +435,6 @@
     },
     {
         "BriefDescription": "All L2 demand store RFOs that hit the cache",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "L2_WRITE.RFO.HIT",
         "SampleAfterValue": "100000",
@@ -505,7 +442,6 @@
     },
     {
         "BriefDescription": "L2 demand store RFOs in I state (misses)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "L2_WRITE.RFO.I_STATE",
         "SampleAfterValue": "100000",
@@ -513,7 +449,6 @@
     },
     {
         "BriefDescription": "All L2 demand store RFOs",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "L2_WRITE.RFO.MESI",
         "SampleAfterValue": "100000",
@@ -521,7 +456,6 @@
     },
     {
         "BriefDescription": "L2 demand store RFOs in M state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "L2_WRITE.RFO.M_STATE",
         "SampleAfterValue": "100000",
@@ -529,7 +463,6 @@
     },
     {
         "BriefDescription": "L2 demand store RFOs in S state",
-        "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "L2_WRITE.RFO.S_STATE",
         "SampleAfterValue": "100000",
@@ -537,7 +470,6 @@
     },
     {
         "BriefDescription": "Longest latency cache miss",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "LONGEST_LAT_CACHE.MISS",
         "SampleAfterValue": "100000",
@@ -545,7 +477,6 @@
     },
     {
         "BriefDescription": "Longest latency cache reference",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
         "SampleAfterValue": "200000",
@@ -553,18 +484,15 @@
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
@@ -575,7 +503,6 @@
     },
     {
         "BriefDescription": "Memory instructions retired above 128 clocks (Precise Event)",
-        "Counter": "3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_128",
         "MSRIndex": "0x3F6",
@@ -586,7 +513,6 @@
     },
     {
         "BriefDescription": "Memory instructions retired above 16 clocks (Precise Event)",
-        "Counter": "3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_16",
         "MSRIndex": "0x3F6",
@@ -597,7 +523,6 @@
     },
     {
         "BriefDescription": "Memory instructions retired above 16384 clocks (Precise Event)",
-        "Counter": "3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_16384",
         "MSRIndex": "0x3F6",
@@ -608,7 +533,6 @@
     },
     {
         "BriefDescription": "Memory instructions retired above 2048 clocks (Precise Event)",
-        "Counter": "3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_2048",
         "MSRIndex": "0x3F6",
@@ -619,7 +543,6 @@
     },
     {
         "BriefDescription": "Memory instructions retired above 256 clocks (Precise Event)",
-        "Counter": "3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_256",
         "MSRIndex": "0x3F6",
@@ -630,7 +553,6 @@
     },
     {
         "BriefDescription": "Memory instructions retired above 32 clocks (Precise Event)",
-        "Counter": "3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_32",
         "MSRIndex": "0x3F6",
@@ -641,7 +563,6 @@
     },
     {
         "BriefDescription": "Memory instructions retired above 32768 clocks (Precise Event)",
-        "Counter": "3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_32768",
         "MSRIndex": "0x3F6",
@@ -652,7 +573,6 @@
     },
     {
         "BriefDescription": "Memory instructions retired above 4 clocks (Precise Event)",
-        "Counter": "3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_4",
         "MSRIndex": "0x3F6",
@@ -663,7 +583,6 @@
     },
     {
         "BriefDescription": "Memory instructions retired above 4096 clocks (Precise Event)",
-        "Counter": "3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_4096",
         "MSRIndex": "0x3F6",
@@ -674,7 +593,6 @@
     },
     {
         "BriefDescription": "Memory instructions retired above 512 clocks (Precise Event)",
-        "Counter": "3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_512",
         "MSRIndex": "0x3F6",
@@ -685,7 +603,6 @@
     },
     {
         "BriefDescription": "Memory instructions retired above 64 clocks (Precise Event)",
-        "Counter": "3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_64",
         "MSRIndex": "0x3F6",
@@ -696,7 +613,6 @@
     },
     {
         "BriefDescription": "Memory instructions retired above 8 clocks (Precise Event)",
-        "Counter": "3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_8",
         "MSRIndex": "0x3F6",
@@ -707,7 +623,6 @@
     },
     {
         "BriefDescription": "Memory instructions retired above 8192 clocks (Precise Event)",
-        "Counter": "3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_8192",
         "MSRIndex": "0x3F6",
@@ -718,7 +633,6 @@
     },
     {
         "BriefDescription": "Instructions retired which contains a load (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LOADS",
         "PEBS": "1",
@@ -727,7 +641,6 @@
     },
     {
         "BriefDescription": "Instructions retired which contains a store (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.STORES",
         "PEBS": "1",
@@ -736,7 +649,6 @@
     },
     {
         "BriefDescription": "Retired loads that miss L1D and hit an previously allocated LFB (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCB",
         "EventName": "MEM_LOAD_RETIRED.HIT_LFB",
         "PEBS": "1",
@@ -745,7 +657,6 @@
     },
     {
         "BriefDescription": "Retired loads that hit the L1 data cache (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCB",
         "EventName": "MEM_LOAD_RETIRED.L1D_HIT",
         "PEBS": "1",
@@ -754,7 +665,6 @@
     },
     {
         "BriefDescription": "Retired loads that hit the L2 cache (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCB",
         "EventName": "MEM_LOAD_RETIRED.L2_HIT",
         "PEBS": "1",
@@ -763,7 +673,6 @@
     },
     {
         "BriefDescription": "Retired loads that miss the LLC cache (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCB",
         "EventName": "MEM_LOAD_RETIRED.LLC_MISS",
         "PEBS": "1",
@@ -772,7 +681,6 @@
     },
     {
         "BriefDescription": "Retired loads that hit valid versions in the LLC cache (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCB",
         "EventName": "MEM_LOAD_RETIRED.LLC_UNSHARED_HIT",
         "PEBS": "1",
@@ -781,7 +689,6 @@
     },
     {
         "BriefDescription": "Retired loads that hit sibling core's L2 in modified or unmodified states (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCB",
         "EventName": "MEM_LOAD_RETIRED.OTHER_CORE_L2_HIT_HITM",
         "PEBS": "1",
@@ -790,7 +697,6 @@
     },
     {
         "BriefDescription": "Load instructions retired local dram and remote cache HIT data sources (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF",
         "EventName": "MEM_UNCORE_RETIRED.LOCAL_DRAM_AND_REMOTE_CACHE_HIT",
         "PEBS": "1",
@@ -799,7 +705,6 @@
     },
     {
         "BriefDescription": "Load instructions retired that HIT modified data in sibling core (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF",
         "EventName": "MEM_UNCORE_RETIRED.LOCAL_HITM",
         "PEBS": "1",
@@ -808,7 +713,6 @@
     },
     {
         "BriefDescription": "Load instructions retired remote DRAM and remote home-remote cache HITM (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF",
         "EventName": "MEM_UNCORE_RETIRED.REMOTE_DRAM",
         "PEBS": "1",
@@ -817,7 +721,6 @@
     },
     {
         "BriefDescription": "Retired loads that hit remote socket in modified state (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF",
         "EventName": "MEM_UNCORE_RETIRED.REMOTE_HITM",
         "PEBS": "1",
@@ -826,7 +729,6 @@
     },
     {
         "BriefDescription": "Load instructions retired IO (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF",
         "EventName": "MEM_UNCORE_RETIRED.UNCACHEABLE",
         "PEBS": "1",
@@ -835,7 +737,6 @@
     },
     {
         "BriefDescription": "All offcore requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.ANY",
         "SampleAfterValue": "100000",
@@ -843,7 +744,6 @@
     },
     {
         "BriefDescription": "Offcore read requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.ANY.READ",
         "SampleAfterValue": "100000",
@@ -851,7 +751,6 @@
     },
     {
         "BriefDescription": "Offcore RFO requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.ANY.RFO",
         "SampleAfterValue": "100000",
@@ -859,7 +758,6 @@
     },
     {
         "BriefDescription": "Offcore demand code read requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.DEMAND.READ_CODE",
         "SampleAfterValue": "100000",
@@ -867,7 +765,6 @@
     },
     {
         "BriefDescription": "Offcore demand data read requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.DEMAND.READ_DATA",
         "SampleAfterValue": "100000",
@@ -875,7 +772,6 @@
     },
     {
         "BriefDescription": "Offcore demand RFO requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.DEMAND.RFO",
         "SampleAfterValue": "100000",
@@ -883,7 +779,6 @@
     },
     {
         "BriefDescription": "Offcore L1 data cache writebacks",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.L1D_WRITEBACK",
         "SampleAfterValue": "100000",
@@ -951,7 +846,6 @@
     },
     {
         "BriefDescription": "Offcore requests blocked due to Super Queue full",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB2",
         "EventName": "OFFCORE_REQUESTS_SQ_FULL",
         "SampleAfterValue": "100000",
@@ -959,2240 +853,1833 @@
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
         "BriefDescription": "Super Queue LRU hints sent to LLC",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF4",
         "EventName": "SQ_MISC.LRU_HINTS",
         "SampleAfterValue": "2000000",
@@ -3200,7 +2687,6 @@
     },
     {
         "BriefDescription": "Super Queue lock splits across a cache line",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF4",
         "EventName": "SQ_MISC.SPLIT_LOCK",
         "SampleAfterValue": "2000000",
@@ -3208,7 +2694,6 @@
     },
     {
         "BriefDescription": "Loads delayed with at-Retirement block code",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6",
         "EventName": "STORE_BLOCKS.AT_RET",
         "SampleAfterValue": "200000",
@@ -3216,7 +2701,6 @@
     },
     {
         "BriefDescription": "Cacheable loads delayed with L1D block code",
-        "Counter": "0,1,2,3",
         "EventCode": "0x6",
         "EventName": "STORE_BLOCKS.L1D_BLOCK",
         "SampleAfterValue": "200000",
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json b/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
index 666e466d351c..c03f8990fa82 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
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
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/frontend.json b/tools/perf/pmu-events/arch/x86/westmereex/frontend.json
index c561ac24d91d..f7f28510e3ae 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/frontend.json
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
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/memory.json b/tools/perf/pmu-events/arch/x86/westmereex/memory.json
index 1f8cfabe08c0..f3c0d2d4bc6a 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/memory.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/memory.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "Misaligned store references",
-        "Counter": "0,1,2,3",
         "EventCode": "0x5",
         "EventName": "MISALIGN_MEM_REF.STORE",
         "SampleAfterValue": "200000",
@@ -9,738 +8,604 @@
     },
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
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/other.json b/tools/perf/pmu-events/arch/x86/westmereex/other.json
index 67bc34984fa8..488274980564 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/other.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/other.json
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
         "BriefDescription": "Loads that partially overlap an earlier store",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3",
         "EventName": "LOAD_BLOCK.OVERLAP_STORE",
         "SampleAfterValue": "200000",
@@ -65,7 +57,6 @@
     },
     {
         "BriefDescription": "All loads dispatched",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "LOAD_DISPATCH.ANY",
         "SampleAfterValue": "2000000",
@@ -73,7 +64,6 @@
     },
     {
         "BriefDescription": "Loads dispatched from the MOB",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "LOAD_DISPATCH.MOB",
         "SampleAfterValue": "2000000",
@@ -81,7 +71,6 @@
     },
     {
         "BriefDescription": "Loads dispatched that bypass the MOB",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "LOAD_DISPATCH.RS",
         "SampleAfterValue": "2000000",
@@ -89,7 +78,6 @@
     },
     {
         "BriefDescription": "Loads dispatched from stage 305",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "LOAD_DISPATCH.RS_DELAYED",
         "SampleAfterValue": "2000000",
@@ -97,7 +85,6 @@
     },
     {
         "BriefDescription": "False dependencies due to partial address aliasing",
-        "Counter": "0,1,2,3",
         "EventCode": "0x7",
         "EventName": "PARTIAL_ADDRESS_ALIAS",
         "SampleAfterValue": "200000",
@@ -105,7 +92,6 @@
     },
     {
         "BriefDescription": "All Store buffer stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "SB_DRAIN.ANY",
         "SampleAfterValue": "200000",
@@ -113,7 +99,6 @@
     },
     {
         "BriefDescription": "Segment rename stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD4",
         "EventName": "SEG_RENAME_STALLS",
         "SampleAfterValue": "2000000",
@@ -121,7 +106,6 @@
     },
     {
         "BriefDescription": "Snoop code requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "SNOOPQ_REQUESTS.CODE",
         "SampleAfterValue": "100000",
@@ -129,7 +113,6 @@
     },
     {
         "BriefDescription": "Snoop data requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "SNOOPQ_REQUESTS.DATA",
         "SampleAfterValue": "100000",
@@ -137,7 +120,6 @@
     },
     {
         "BriefDescription": "Snoop invalidate requests",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "SNOOPQ_REQUESTS.INVALIDATE",
         "SampleAfterValue": "100000",
@@ -190,7 +172,6 @@
     },
     {
         "BriefDescription": "Thread responded HIT to snoop",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB8",
         "EventName": "SNOOP_RESPONSE.HIT",
         "SampleAfterValue": "100000",
@@ -198,7 +179,6 @@
     },
     {
         "BriefDescription": "Thread responded HITE to snoop",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB8",
         "EventName": "SNOOP_RESPONSE.HITE",
         "SampleAfterValue": "100000",
@@ -206,7 +186,6 @@
     },
     {
         "BriefDescription": "Thread responded HITM to snoop",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB8",
         "EventName": "SNOOP_RESPONSE.HITM",
         "SampleAfterValue": "100000",
@@ -214,7 +193,6 @@
     },
     {
         "BriefDescription": "Super Queue full stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF6",
         "EventName": "SQ_FULL_STALL_CYCLES",
         "SampleAfterValue": "2000000",
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/pipeline.json b/tools/perf/pmu-events/arch/x86/westmereex/pipeline.json
index 7d6c2c1e0db0..1c61d18a4b5f 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/pipeline.json
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
         "BriefDescription": "Mispredicted retired branch instructions (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
@@ -280,7 +246,6 @@
     },
     {
         "BriefDescription": "Mispredicted conditional retired branches (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.CONDITIONAL",
         "PEBS": "1",
@@ -289,7 +254,6 @@
     },
     {
         "BriefDescription": "Mispredicted near retired calls (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.NEAR_CALL",
         "PEBS": "1",
@@ -298,15 +262,11 @@
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
@@ -314,33 +274,25 @@
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
@@ -348,7 +300,6 @@
     },
     {
         "BriefDescription": "Instruction Queue full stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "ILD_STALL.IQ_FULL",
         "SampleAfterValue": "2000000",
@@ -356,7 +307,6 @@
     },
     {
         "BriefDescription": "Length Change Prefix stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "ILD_STALL.LCP",
         "SampleAfterValue": "2000000",
@@ -364,7 +314,6 @@
     },
     {
         "BriefDescription": "Stall cycles due to BPU MRU bypass",
-        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "ILD_STALL.MRU",
         "SampleAfterValue": "2000000",
@@ -372,7 +321,6 @@
     },
     {
         "BriefDescription": "Regen stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "ILD_STALL.REGEN",
         "SampleAfterValue": "2000000",
@@ -380,7 +328,6 @@
     },
     {
         "BriefDescription": "Instructions that must be decoded by decoder 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "INST_DECODED.DEC0",
         "SampleAfterValue": "2000000",
@@ -388,7 +335,6 @@
     },
     {
         "BriefDescription": "Instructions written to instruction queue.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x17",
         "EventName": "INST_QUEUE_WRITES",
         "SampleAfterValue": "2000000",
@@ -396,7 +342,6 @@
     },
     {
         "BriefDescription": "Cycles instructions are written to the instruction queue",
-        "Counter": "0,1,2,3",
         "EventCode": "0x1E",
         "EventName": "INST_QUEUE_WRITE_CYCLES",
         "SampleAfterValue": "2000000",
@@ -404,15 +349,11 @@
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
@@ -421,7 +362,6 @@
     },
     {
         "BriefDescription": "Retired MMX instructions (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.MMX",
         "PEBS": "1",
@@ -430,7 +370,6 @@
     },
     {
         "BriefDescription": "Total cycles (Precise Event)",
-        "Counter": "0,1,2,3",
         "CounterMask": "16",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.TOTAL_CYCLES",
@@ -441,7 +380,6 @@
     },
     {
         "BriefDescription": "Total cycles (Precise Event)",
-        "Counter": "0,1,2,3",
         "CounterMask": "16",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.TOTAL_CYCLES_PS",
@@ -452,7 +390,6 @@
     },
     {
         "BriefDescription": "Retired floating-point operations (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.X87",
         "PEBS": "1",
@@ -461,7 +398,6 @@
     },
     {
         "BriefDescription": "Load operations conflicting with software prefetches",
-        "Counter": "0,1",
         "EventCode": "0x4C",
         "EventName": "LOAD_HIT_PRE",
         "SampleAfterValue": "200000",
@@ -469,7 +405,6 @@
     },
     {
         "BriefDescription": "Cycles when uops were delivered by the LSD",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xA8",
         "EventName": "LSD.ACTIVE",
@@ -478,7 +413,6 @@
     },
     {
         "BriefDescription": "Cycles no uops were delivered by the LSD",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xA8",
         "EventName": "LSD.INACTIVE",
@@ -488,7 +422,6 @@
     },
     {
         "BriefDescription": "Loops that can't stream from the instruction queue",
-        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "LSD_OVERFLOW",
         "SampleAfterValue": "2000000",
@@ -496,7 +429,6 @@
     },
     {
         "BriefDescription": "Cycles machine clear asserted",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.CYCLES",
         "SampleAfterValue": "20000",
@@ -504,7 +436,6 @@
     },
     {
         "BriefDescription": "Execution pipeline restart due to Memory ordering conflicts",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MEM_ORDER",
         "SampleAfterValue": "20000",
@@ -512,7 +443,6 @@
     },
     {
         "BriefDescription": "Self-Modifying Code detected",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.SMC",
         "SampleAfterValue": "20000",
@@ -520,7 +450,6 @@
     },
     {
         "BriefDescription": "All RAT stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "RAT_STALLS.ANY",
         "SampleAfterValue": "2000000",
@@ -528,7 +457,6 @@
     },
     {
         "BriefDescription": "Flag stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "RAT_STALLS.FLAGS",
         "SampleAfterValue": "2000000",
@@ -536,7 +464,6 @@
     },
     {
         "BriefDescription": "Partial register stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "RAT_STALLS.REGISTERS",
         "SampleAfterValue": "2000000",
@@ -544,7 +471,6 @@
     },
     {
         "BriefDescription": "ROB read port stalls cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "RAT_STALLS.ROB_READ_PORT",
         "SampleAfterValue": "2000000",
@@ -552,7 +478,6 @@
     },
     {
         "BriefDescription": "Scoreboard stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "RAT_STALLS.SCOREBOARD",
         "SampleAfterValue": "2000000",
@@ -560,7 +485,6 @@
     },
     {
         "BriefDescription": "Resource related stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.ANY",
         "SampleAfterValue": "2000000",
@@ -568,7 +492,6 @@
     },
     {
         "BriefDescription": "FPU control word write stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.FPCW",
         "SampleAfterValue": "2000000",
@@ -576,7 +499,6 @@
     },
     {
         "BriefDescription": "Load buffer stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.LOAD",
         "SampleAfterValue": "2000000",
@@ -584,7 +506,6 @@
     },
     {
         "BriefDescription": "MXCSR rename stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.MXCSR",
         "SampleAfterValue": "2000000",
@@ -592,7 +513,6 @@
     },
     {
         "BriefDescription": "Other Resource related stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.OTHER",
         "SampleAfterValue": "2000000",
@@ -600,7 +520,6 @@
     },
     {
         "BriefDescription": "ROB full stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.ROB_FULL",
         "SampleAfterValue": "2000000",
@@ -608,7 +527,6 @@
     },
     {
         "BriefDescription": "Reservation Station full stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.RS_FULL",
         "SampleAfterValue": "2000000",
@@ -616,7 +534,6 @@
     },
     {
         "BriefDescription": "Store buffer stall cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.STORE",
         "SampleAfterValue": "2000000",
@@ -624,7 +541,6 @@
     },
     {
         "BriefDescription": "SIMD Packed-Double Uops retired (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC7",
         "EventName": "SSEX_UOPS_RETIRED.PACKED_DOUBLE",
         "PEBS": "1",
@@ -633,7 +549,6 @@
     },
     {
         "BriefDescription": "SIMD Packed-Single Uops retired (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC7",
         "EventName": "SSEX_UOPS_RETIRED.PACKED_SINGLE",
         "PEBS": "1",
@@ -642,7 +557,6 @@
     },
     {
         "BriefDescription": "SIMD Scalar-Double Uops retired (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC7",
         "EventName": "SSEX_UOPS_RETIRED.SCALAR_DOUBLE",
         "PEBS": "1",
@@ -651,7 +565,6 @@
     },
     {
         "BriefDescription": "SIMD Scalar-Single Uops retired (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC7",
         "EventName": "SSEX_UOPS_RETIRED.SCALAR_SINGLE",
         "PEBS": "1",
@@ -660,7 +573,6 @@
     },
     {
         "BriefDescription": "SIMD Vector Integer Uops retired (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC7",
         "EventName": "SSEX_UOPS_RETIRED.VECTOR_INTEGER",
         "PEBS": "1",
@@ -669,7 +581,6 @@
     },
     {
         "BriefDescription": "Stack pointer instructions decoded",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD1",
         "EventName": "UOPS_DECODED.ESP_FOLDING",
         "SampleAfterValue": "2000000",
@@ -677,7 +588,6 @@
     },
     {
         "BriefDescription": "Stack pointer sync operations",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD1",
         "EventName": "UOPS_DECODED.ESP_SYNC",
         "SampleAfterValue": "2000000",
@@ -685,7 +595,6 @@
     },
     {
         "BriefDescription": "Uops decoded by Microcode Sequencer",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xD1",
         "EventName": "UOPS_DECODED.MS_CYCLES_ACTIVE",
@@ -694,7 +603,6 @@
     },
     {
         "BriefDescription": "Cycles no Uops are decoded",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xD1",
         "EventName": "UOPS_DECODED.STALL_CYCLES",
@@ -705,7 +613,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles Uops executed on any port (core count)",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_ACTIVE_CYCLES",
@@ -715,7 +622,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles Uops executed on ports 0-4 (core count)",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_ACTIVE_CYCLES_NO_PORT5",
@@ -724,7 +630,6 @@
     },
     {
         "BriefDescription": "Uops executed on any port (core count)",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0xB1",
@@ -735,7 +640,6 @@
     },
     {
         "BriefDescription": "Uops executed on ports 0-4 (core count)",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0xB1",
@@ -747,7 +651,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles no Uops issued on any port (core count)",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_STALL_CYCLES",
@@ -758,7 +661,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles no Uops issued on ports 0-4 (core count)",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_STALL_CYCLES_NO_PORT5",
@@ -768,7 +670,6 @@
     },
     {
         "BriefDescription": "Uops executed on port 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.PORT0",
         "SampleAfterValue": "2000000",
@@ -776,7 +677,6 @@
     },
     {
         "BriefDescription": "Uops issued on ports 0, 1 or 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.PORT015",
         "SampleAfterValue": "2000000",
@@ -784,7 +684,6 @@
     },
     {
         "BriefDescription": "Cycles no Uops issued on ports 0, 1 or 5",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.PORT015_STALL_CYCLES",
@@ -794,7 +693,6 @@
     },
     {
         "BriefDescription": "Uops executed on port 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.PORT1",
         "SampleAfterValue": "2000000",
@@ -803,7 +701,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Uops issued on ports 2, 3 or 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.PORT234_CORE",
         "SampleAfterValue": "2000000",
@@ -812,7 +709,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Uops executed on port 2 (core count)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.PORT2_CORE",
         "SampleAfterValue": "2000000",
@@ -821,7 +717,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Uops executed on port 3 (core count)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.PORT3_CORE",
         "SampleAfterValue": "2000000",
@@ -830,7 +725,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Uops executed on port 4 (core count)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.PORT4_CORE",
         "SampleAfterValue": "2000000",
@@ -838,7 +732,6 @@
     },
     {
         "BriefDescription": "Uops executed on port 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.PORT5",
         "SampleAfterValue": "2000000",
@@ -846,7 +739,6 @@
     },
     {
         "BriefDescription": "Uops issued",
-        "Counter": "0,1,2,3",
         "EventCode": "0xE",
         "EventName": "UOPS_ISSUED.ANY",
         "SampleAfterValue": "2000000",
@@ -855,7 +747,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles no Uops were issued on any thread",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xE",
         "EventName": "UOPS_ISSUED.CORE_STALL_CYCLES",
@@ -866,7 +757,6 @@
     {
         "AnyThread": "1",
         "BriefDescription": "Cycles Uops were issued on either thread",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xE",
         "EventName": "UOPS_ISSUED.CYCLES_ALL_THREADS",
@@ -875,7 +765,6 @@
     },
     {
         "BriefDescription": "Fused Uops issued",
-        "Counter": "0,1,2,3",
         "EventCode": "0xE",
         "EventName": "UOPS_ISSUED.FUSED",
         "SampleAfterValue": "2000000",
@@ -883,7 +772,6 @@
     },
     {
         "BriefDescription": "Cycles no Uops were issued",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xE",
         "EventName": "UOPS_ISSUED.STALL_CYCLES",
@@ -893,7 +781,6 @@
     },
     {
         "BriefDescription": "Cycles Uops are being retired",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.ACTIVE_CYCLES",
@@ -903,7 +790,6 @@
     },
     {
         "BriefDescription": "Uops retired (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.ANY",
         "PEBS": "1",
@@ -912,7 +798,6 @@
     },
     {
         "BriefDescription": "Macro-fused Uops retired (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.MACRO_FUSED",
         "PEBS": "1",
@@ -921,7 +806,6 @@
     },
     {
         "BriefDescription": "Retirement slots used (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.RETIRE_SLOTS",
         "PEBS": "1",
@@ -930,7 +814,6 @@
     },
     {
         "BriefDescription": "Cycles Uops are not retiring (Precise Event)",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.STALL_CYCLES",
@@ -941,7 +824,6 @@
     },
     {
         "BriefDescription": "Total cycles using precise uop retired event (Precise Event)",
-        "Counter": "0,1,2,3",
         "CounterMask": "16",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.TOTAL_CYCLES",
@@ -952,7 +834,6 @@
     },
     {
         "BriefDescription": "Uop unfusions due to FP exceptions",
-        "Counter": "0,1,2,3",
         "EventCode": "0xDB",
         "EventName": "UOP_UNFUSION",
         "SampleAfterValue": "2000000",
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json b/tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json
index 0c3501e6e5a3..6c92b2be2d06 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json
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
         "BriefDescription": "DTLB load miss large page walks",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "DTLB_LOAD_MISSES.LARGE_WALK_COMPLETED",
         "SampleAfterValue": "200000",
@@ -17,7 +15,6 @@
     },
     {
         "BriefDescription": "DTLB load miss caused by low part of address",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "DTLB_LOAD_MISSES.PDE_MISS",
         "SampleAfterValue": "200000",
@@ -25,7 +22,6 @@
     },
     {
         "BriefDescription": "DTLB second level hit",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
         "SampleAfterValue": "2000000",
@@ -33,7 +29,6 @@
     },
     {
         "BriefDescription": "DTLB load miss page walks complete",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
         "SampleAfterValue": "200000",
@@ -41,7 +36,6 @@
     },
     {
         "BriefDescription": "DTLB load miss page walk cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8",
         "EventName": "DTLB_LOAD_MISSES.WALK_CYCLES",
         "SampleAfterValue": "200000",
@@ -49,7 +43,6 @@
     },
     {
         "BriefDescription": "DTLB misses",
-        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_MISSES.ANY",
         "SampleAfterValue": "200000",
@@ -57,7 +50,6 @@
     },
     {
         "BriefDescription": "DTLB miss large page walks",
-        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_MISSES.LARGE_WALK_COMPLETED",
         "SampleAfterValue": "200000",
@@ -65,7 +57,6 @@
     },
     {
         "BriefDescription": "DTLB misses caused by low part of address. Count also includes 2M page references because 2M pages do not use the PDE.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_MISSES.PDE_MISS",
         "SampleAfterValue": "200000",
@@ -73,7 +64,6 @@
     },
     {
         "BriefDescription": "DTLB first level misses but second level hit",
-        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_MISSES.STLB_HIT",
         "SampleAfterValue": "200000",
@@ -81,7 +71,6 @@
     },
     {
         "BriefDescription": "DTLB miss page walks",
-        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_MISSES.WALK_COMPLETED",
         "SampleAfterValue": "200000",
@@ -89,7 +78,6 @@
     },
     {
         "BriefDescription": "DTLB miss page walk cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_MISSES.WALK_CYCLES",
         "SampleAfterValue": "2000000",
@@ -97,7 +85,6 @@
     },
     {
         "BriefDescription": "Extended Page Table walk cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4F",
         "EventName": "EPT.WALK_CYCLES",
         "SampleAfterValue": "2000000",
@@ -105,7 +92,6 @@
     },
     {
         "BriefDescription": "ITLB flushes",
-        "Counter": "0,1,2,3",
         "EventCode": "0xAE",
         "EventName": "ITLB_FLUSH",
         "SampleAfterValue": "2000000",
@@ -113,7 +99,6 @@
     },
     {
         "BriefDescription": "ITLB miss",
-        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.ANY",
         "SampleAfterValue": "200000",
@@ -121,7 +106,6 @@
     },
     {
         "BriefDescription": "ITLB miss large page walks",
-        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.LARGE_WALK_COMPLETED",
         "SampleAfterValue": "200000",
@@ -129,7 +113,6 @@
     },
     {
         "BriefDescription": "ITLB miss page walks",
-        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
         "SampleAfterValue": "200000",
@@ -137,7 +120,6 @@
     },
     {
         "BriefDescription": "ITLB miss page walk cycles",
-        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_CYCLES",
         "SampleAfterValue": "2000000",
@@ -145,7 +127,6 @@
     },
     {
         "BriefDescription": "Retired instructions that missed the ITLB (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC8",
         "EventName": "ITLB_MISS_RETIRED",
         "PEBS": "1",
@@ -154,7 +135,6 @@
     },
     {
         "BriefDescription": "Retired loads that miss the DTLB (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCB",
         "EventName": "MEM_LOAD_RETIRED.DTLB_MISS",
         "PEBS": "1",
@@ -163,7 +143,6 @@
     },
     {
         "BriefDescription": "Retired stores that miss the DTLB (Precise Event)",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC",
         "EventName": "MEM_STORE_RETIRED.DTLB_MISS",
         "PEBS": "1",
-- 
2.39.0.314.g84b9a713c41-goog

