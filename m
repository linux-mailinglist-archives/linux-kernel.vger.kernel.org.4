Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD15064D6BB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 07:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiLOGzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 01:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiLOGzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:55:48 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EB86434
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:55:39 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y6-20020a25b9c6000000b006c1c6161716so2656475ybj.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mq4nhrxJtyr4FRNNh8ibmaGoU9y2OG+CeIHdVcyxVsc=;
        b=HQv/6snaUrvf4DKn4VSVNiuU3y0kecLifPwVI3jGTjeE9Fb/zl2kfBdQJMHiPvA+w9
         Q/bf3HZ5EshCsUtSJBfTPUMvHe85ce6vO/ThJMf1T5fCb4Fm3CSJyKvBcNy0NEUZqihi
         wdevDBgfUzXxOWeZBQs2YcHqEjbljmtNFRRyq88C5+uuc0BuEgm1O+pWZ/osHpXFn+Y2
         0XFIeINhRn900DOn0g5KCjViCDH3iOuWsVkrTv41h5rgyGWfFS6XpMcMFt8A82WOiKPO
         s2J5Dn+7Kv7mL5kXEF4xUEluFGx4jyyXiAl8chw3lhPyRoCSWWrQ6CwKPQmfY8XkFgDY
         DEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mq4nhrxJtyr4FRNNh8ibmaGoU9y2OG+CeIHdVcyxVsc=;
        b=4YIPcA5j3FnABH5oF6sH2ZpJjdHZis0X/D5NPQTNqnTaaxDd7du79310+NnyWow/z9
         lXSe+hg7D2LuMCPC3EM9/Pb0TJqPnuIEsfJT95TJNSHkLWDcBbsHAmF+7b7SqPxxWWd1
         qj1AXEfJx4WhEaxh9tDfGIP9CkMJcIaw1xywoGbELhZM2kER71tlSNLUsj+v/G4H++EM
         Zdw1JbFtbGIIXJHrGgut9t1Cm6StMosJhvkxjsAdSm9EXn5NGXs5b6Dy6chotCPzcVE5
         73JaRA8STGKtcV0z5m3e6fIA49DB5qUwsPNLfDbzTjtzLCFCUSGZzmGOAFjFCT/rkCCp
         Zf6w==
X-Gm-Message-State: ANoB5pnRbJ0GdX7I3aEsfGAqfZDPWFd7TVu96itM7PrI8ZlcNe/dsUDc
        O16CBwyX+/dfWfHf3Sl3L7cR3GHckGiY
X-Google-Smtp-Source: AA0mqf40t9vyCv2r5a9YUZTfOao5NYnbEf+J7NGCq//zumCDT4nkFoiL3XeTIdr+tbOdTe8XzXkaJldw4D1N
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c7dc:d96f:4f9:f59d])
 (user=irogers job=sendgmr) by 2002:a25:7e47:0:b0:706:65d1:4a20 with SMTP id
 z68-20020a257e47000000b0070665d14a20mr10892376ybc.24.1671087338341; Wed, 14
 Dec 2022 22:55:38 -0800 (PST)
Date:   Wed, 14 Dec 2022 22:54:48 -0800
In-Reply-To: <20221215065510.1621979-1-irogers@google.com>
Message-Id: <20221215065510.1621979-2-irogers@google.com>
Mime-Version: 1.0
References: <20221215065510.1621979-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 10/32] perf vendor events intel: Refresh goldmont events
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

Update the goldmont events using the new tooling from:
https://github.com/intel/perfmon
The events are unchanged but unused json values are removed. This
increases consistency across the json files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/goldmont/cache.json   | 288 ------------------
 .../arch/x86/goldmont/floating-point.json     |   6 -
 .../arch/x86/goldmont/frontend.json           |  16 -
 .../pmu-events/arch/x86/goldmont/memory.json  |   6 -
 .../pmu-events/arch/x86/goldmont/other.json   |  10 -
 .../arch/x86/goldmont/pipeline.json           |  77 -----
 .../arch/x86/goldmont/virtual-memory.json     |  14 -
 7 files changed, 417 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/goldmont/cache.json b/tools/per=
f/pmu-events/arch/x86/goldmont/cache.json
index ed957d4f9c6d..ee47a09172a1 100644
--- a/tools/perf/pmu-events/arch/x86/goldmont/cache.json
+++ b/tools/perf/pmu-events/arch/x86/goldmont/cache.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Requests rejected by the L2Q",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "CORE_REJECT_L2Q.ALL",
         "PublicDescription": "Counts the number of demand and L1 prefetche=
r requests rejected by the L2Q due to a full or nearly full condition which=
 likely indicates back pressure from L2Q. It also counts requests that woul=
d have gone directly to the XQ, but are rejected due to a full or nearly fu=
ll condition, indicating back pressure from the IDI link. The L2Q may also =
reject transactions from a core to ensure fairness between cores, or to del=
ay a core's dirty eviction when the address conflicts with incoming externa=
l snoops.",
@@ -10,8 +8,6 @@
     },
     {
         "BriefDescription": "L1 Cache evictions for dirty data",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "DL1.DIRTY_EVICTION",
         "PublicDescription": "Counts when a modified (dirty) cache line is=
 evicted from the data L1 cache and needs to be written back to memory.  No=
 count will occur if the evicted line is clean, and hence does not require =
a writeback.",
@@ -20,8 +16,6 @@
     },
     {
         "BriefDescription": "Cycles code-fetch stalled due to an outstandi=
ng ICache miss.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "FETCH_STALL.ICACHE_FILL_PENDING_CYCLES",
         "PublicDescription": "Counts cycles that fetch is stalled due to a=
n outstanding ICache miss. That is, the decoder queue is able to accept byt=
es, but the fetch unit is unable to provide bytes due to an ICache miss.  N=
ote: this event is not the same as the total number of cycles spent retriev=
ing instruction cache lines from the memory hierarchy.",
@@ -30,8 +24,6 @@
     },
     {
         "BriefDescription": "Requests rejected by the XQ",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x30",
         "EventName": "L2_REJECT_XQ.ALL",
         "PublicDescription": "Counts the number of demand and prefetch tra=
nsactions that the L2 XQ rejects due to a full or near full condition which=
 likely indicates back pressure from the intra-die interconnect (IDI) fabri=
c. The XQ may reject transactions from the L2Q (non-cacheable requests), L2=
 misses and L2 write-back victims.",
@@ -39,8 +31,6 @@
     },
     {
         "BriefDescription": "L2 cache request misses",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "LONGEST_LAT_CACHE.MISS",
         "PublicDescription": "Counts memory requests originating from the =
core that miss in the L2 cache.",
@@ -49,8 +39,6 @@
     },
     {
         "BriefDescription": "L2 cache requests",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
         "PublicDescription": "Counts memory requests originating from the =
core that reference a cache line in the L2 cache.",
@@ -59,8 +47,6 @@
     },
     {
         "BriefDescription": "Loads retired that came from DRAM (Precise ev=
ent capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.DRAM_HIT",
@@ -71,8 +57,6 @@
     },
     {
         "BriefDescription": "Memory uop retired where cross core or cross =
module HITM occurred (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.HITM",
@@ -83,8 +67,6 @@
     },
     {
         "BriefDescription": "Load uops retired that hit L1 data cache (Pre=
cise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_HIT",
@@ -95,8 +77,6 @@
     },
     {
         "BriefDescription": "Load uops retired that missed L1 data cache (=
Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_MISS",
@@ -107,8 +87,6 @@
     },
     {
         "BriefDescription": "Load uops retired that hit L2 (Precise event =
capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
@@ -119,8 +97,6 @@
     },
     {
         "BriefDescription": "Load uops retired that missed L2 (Precise eve=
nt capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_MISS",
@@ -131,8 +107,6 @@
     },
     {
         "BriefDescription": "Loads retired that hit WCB (Precise event cap=
able)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.WCB_HIT",
@@ -143,8 +117,6 @@
     },
     {
         "BriefDescription": "Memory uops retired (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.ALL",
@@ -155,8 +127,6 @@
     },
     {
         "BriefDescription": "Load uops retired (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
@@ -167,8 +137,6 @@
     },
     {
         "BriefDescription": "Store uops retired (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
@@ -179,8 +147,6 @@
     },
     {
         "BriefDescription": "Locked load uops retired (Precise event capab=
le)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.LOCK_LOADS",
@@ -191,8 +157,6 @@
     },
     {
         "BriefDescription": "Memory uops retired that split a cache-line (=
Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT",
@@ -203,8 +167,6 @@
     },
     {
         "BriefDescription": "Load uops retired that split a cache-line (Pr=
ecise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
@@ -215,8 +177,6 @@
     },
     {
         "BriefDescription": "Stores uops retired that split a cache-line (=
Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
@@ -227,8 +187,6 @@
     },
     {
         "BriefDescription": "Requires MSR_OFFCORE_RESP[0,1] to specify req=
uest type and response. (duplicated for both MSRs)",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE",
         "SampleAfterValue": "100007",
@@ -236,1066 +194,820 @@
     },
     {
         "BriefDescription": "Counts data reads (demand & prefetch) that hi=
t the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000043091",
-        "Offcore": "1",
         "PublicDescription": "Counts data reads (demand & prefetch) that h=
it the L2 cache. Requires MSR_OFFCORE_RESP[0,1] to specify request type and=
 response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data reads (demand & prefetch) that mi=
ss the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3600003091",
-        "Offcore": "1",
         "PublicDescription": "Counts data reads (demand & prefetch) that m=
iss the L2 cache. Requires MSR_OFFCORE_RESP[0,1] to specify request type an=
d response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data reads (demand & prefetch) that mi=
ss the L2 cache with a snoop hit in the other processor module, data forwar=
ding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_MISS.HITM_OTHER_CORE=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000003091",
-        "Offcore": "1",
         "PublicDescription": "Counts data reads (demand & prefetch) that m=
iss the L2 cache with a snoop hit in the other processor module, data forwa=
rding is required. Requires MSR_OFFCORE_RESP[0,1] to specify request type a=
nd response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data reads (demand & prefetch) that mi=
ss the L2 cache with a snoop hit in the other processor module, no data for=
warding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_MISS.HIT_OTHER_CORE_=
NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400003091",
-        "Offcore": "1",
         "PublicDescription": "Counts data reads (demand & prefetch) that m=
iss the L2 cache with a snoop hit in the other processor module, no data fo=
rwarding is required. Requires MSR_OFFCORE_RESP[0,1] to specify request typ=
e and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data reads (demand & prefetch) that tr=
ue miss for the L2 cache with a snoop miss in the other processor module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_MISS.SNOOP_MISS_OR_N=
O_SNOOP_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200003091",
-        "Offcore": "1",
         "PublicDescription": "Counts data reads (demand & prefetch) that t=
rue miss for the L2 cache with a snoop miss in the other processor module. =
 Requires MSR_OFFCORE_RESP[0,1] to specify request type and response. (dupl=
icated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data reads generated by L1 or L2 prefe=
tchers that hit the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_DATA_RD.L2_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000043010",
-        "Offcore": "1",
         "PublicDescription": "Counts data reads generated by L1 or L2 pref=
etchers that hit the L2 cache. Requires MSR_OFFCORE_RESP[0,1] to specify re=
quest type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data reads generated by L1 or L2 prefe=
tchers that miss the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_DATA_RD.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3600003010",
-        "Offcore": "1",
         "PublicDescription": "Counts data reads generated by L1 or L2 pref=
etchers that miss the L2 cache. Requires MSR_OFFCORE_RESP[0,1] to specify r=
equest type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data reads generated by L1 or L2 prefe=
tchers that miss the L2 cache with a snoop hit in the other processor modul=
e, data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_DATA_RD.L2_MISS.HITM_OTHER_C=
ORE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000003010",
-        "Offcore": "1",
         "PublicDescription": "Counts data reads generated by L1 or L2 pref=
etchers that miss the L2 cache with a snoop hit in the other processor modu=
le, data forwarding is required. Requires MSR_OFFCORE_RESP[0,1] to specify =
request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data reads generated by L1 or L2 prefe=
tchers that miss the L2 cache with a snoop hit in the other processor modul=
e, no data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_DATA_RD.L2_MISS.HIT_OTHER_CO=
RE_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400003010",
-        "Offcore": "1",
         "PublicDescription": "Counts data reads generated by L1 or L2 pref=
etchers that miss the L2 cache with a snoop hit in the other processor modu=
le, no data forwarding is required. Requires MSR_OFFCORE_RESP[0,1] to speci=
fy request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data reads generated by L1 or L2 prefe=
tchers that true miss for the L2 cache with a snoop miss in the other proce=
ssor module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_DATA_RD.L2_MISS.SNOOP_MISS_O=
R_NO_SNOOP_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200003010",
-        "Offcore": "1",
         "PublicDescription": "Counts data reads generated by L1 or L2 pref=
etchers that true miss for the L2 cache with a snoop miss in the other proc=
essor module.  Requires MSR_OFFCORE_RESP[0,1] to specify request type and r=
esponse. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data read, code read, and read for own=
ership (RFO) requests (demand & prefetch) that hit the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00000432b7",
-        "Offcore": "1",
         "PublicDescription": "Counts data read, code read, and read for ow=
nership (RFO) requests (demand & prefetch) that hit the L2 cache. Requires =
MSR_OFFCORE_RESP[0,1] to specify request type and response. (duplicated for=
 both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data read, code read, and read for own=
ership (RFO) requests (demand & prefetch) that miss the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x36000032b7",
-        "Offcore": "1",
         "PublicDescription": "Counts data read, code read, and read for ow=
nership (RFO) requests (demand & prefetch) that miss the L2 cache. Requires=
 MSR_OFFCORE_RESP[0,1] to specify request type and response. (duplicated fo=
r both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data read, code read, and read for own=
ership (RFO) requests (demand & prefetch) that miss the L2 cache with a sno=
op hit in the other processor module, data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_MISS.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10000032b7",
-        "Offcore": "1",
         "PublicDescription": "Counts data read, code read, and read for ow=
nership (RFO) requests (demand & prefetch) that miss the L2 cache with a sn=
oop hit in the other processor module, data forwarding is required. Require=
s MSR_OFFCORE_RESP[0,1] to specify request type and response. (duplicated f=
or both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data read, code read, and read for own=
ership (RFO) requests (demand & prefetch) that miss the L2 cache with a sno=
op hit in the other processor module, no data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_MISS.HIT_OTHER_CORE_NO_=
FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x04000032b7",
-        "Offcore": "1",
         "PublicDescription": "Counts data read, code read, and read for ow=
nership (RFO) requests (demand & prefetch) that miss the L2 cache with a sn=
oop hit in the other processor module, no data forwarding is required. Requ=
ires MSR_OFFCORE_RESP[0,1] to specify request type and response. (duplicate=
d for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data read, code read, and read for own=
ership (RFO) requests (demand & prefetch) that true miss for the L2 cache w=
ith a snoop miss in the other processor module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_MISS.SNOOP_MISS_OR_NO_S=
NOOP_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x02000032b7",
-        "Offcore": "1",
         "PublicDescription": "Counts data read, code read, and read for ow=
nership (RFO) requests (demand & prefetch) that true miss for the L2 cache =
with a snoop miss in the other processor module.  Requires MSR_OFFCORE_RESP=
[0,1] to specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts requests to the uncore subsystem that =
have any transaction responses from the uncore subsystem.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000018000",
-        "Offcore": "1",
         "PublicDescription": "Counts requests to the uncore subsystem that=
 have any transaction responses from the uncore subsystem. Requires MSR_OFF=
CORE_RESP[0,1] to specify request type and response. (duplicated for both M=
SRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts requests to the uncore subsystem that =
hit the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000048000",
-        "Offcore": "1",
         "PublicDescription": "Counts requests to the uncore subsystem that=
 hit the L2 cache. Requires MSR_OFFCORE_RESP[0,1] to specify request type a=
nd response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts requests to the uncore subsystem that =
miss the L2 cache with a snoop hit in the other processor module, data forw=
arding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_MISS.HITM_OTHER_CORE=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000008000",
-        "Offcore": "1",
         "PublicDescription": "Counts requests to the uncore subsystem that=
 miss the L2 cache with a snoop hit in the other processor module, data for=
warding is required. Requires MSR_OFFCORE_RESP[0,1] to specify request type=
 and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts requests to the uncore subsystem that =
miss the L2 cache with a snoop hit in the other processor module, no data f=
orwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_MISS.HIT_OTHER_CORE_=
NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400008000",
-        "Offcore": "1",
         "PublicDescription": "Counts requests to the uncore subsystem that=
 miss the L2 cache with a snoop hit in the other processor module, no data =
forwarding is required. Requires MSR_OFFCORE_RESP[0,1] to specify request t=
ype and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts requests to the uncore subsystem that =
true miss for the L2 cache with a snoop miss in the other processor module.=
",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_MISS.SNOOP_MISS_OR_N=
O_SNOOP_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200008000",
-        "Offcore": "1",
         "PublicDescription": "Counts requests to the uncore subsystem that=
 true miss for the L2 cache with a snoop miss in the other processor module=
.  Requires MSR_OFFCORE_RESP[0,1] to specify request type and response. (du=
plicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests (de=
mand & prefetch) that hit the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000040022",
-        "Offcore": "1",
         "PublicDescription": "Counts reads for ownership (RFO) requests (d=
emand & prefetch) that hit the L2 cache. Requires MSR_OFFCORE_RESP[0,1] to =
specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests (de=
mand & prefetch) that miss the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3600000022",
-        "Offcore": "1",
         "PublicDescription": "Counts reads for ownership (RFO) requests (d=
emand & prefetch) that miss the L2 cache. Requires MSR_OFFCORE_RESP[0,1] to=
 specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests (de=
mand & prefetch) that miss the L2 cache with a snoop hit in the other proce=
ssor module, data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_MISS.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000000022",
-        "Offcore": "1",
         "PublicDescription": "Counts reads for ownership (RFO) requests (d=
emand & prefetch) that miss the L2 cache with a snoop hit in the other proc=
essor module, data forwarding is required. Requires MSR_OFFCORE_RESP[0,1] t=
o specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests (de=
mand & prefetch) that miss the L2 cache with a snoop hit in the other proce=
ssor module, no data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_MISS.HIT_OTHER_CORE_NO_F=
WD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400000022",
-        "Offcore": "1",
         "PublicDescription": "Counts reads for ownership (RFO) requests (d=
emand & prefetch) that miss the L2 cache with a snoop hit in the other proc=
essor module, no data forwarding is required. Requires MSR_OFFCORE_RESP[0,1=
] to specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests (de=
mand & prefetch) that true miss for the L2 cache with a snoop miss in the o=
ther processor module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_MISS.SNOOP_MISS_OR_NO_SN=
OOP_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200000022",
-        "Offcore": "1",
         "PublicDescription": "Counts reads for ownership (RFO) requests (d=
emand & prefetch) that true miss for the L2 cache with a snoop miss in the =
other processor module.  Requires MSR_OFFCORE_RESP[0,1] to specify request =
type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts bus lock and split lock requests that =
have any transaction responses from the uncore subsystem.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010400",
-        "Offcore": "1",
         "PublicDescription": "Counts bus lock and split lock requests that=
 have any transaction responses from the uncore subsystem. Requires MSR_OFF=
CORE_RESP[0,1] to specify request type and response. (duplicated for both M=
SRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of writeback transactions c=
aused by L1 or L2 cache evictions that hit the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.L2_HIT",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x0000040008",
-        "Offcore": "1",
         "PublicDescription": "Counts the number of writeback transactions =
caused by L1 or L2 cache evictions that hit the L2 cache. Requires MSR_OFFC=
ORE_RESP[0,1] to specify request type and response. (duplicated for both MS=
Rs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of writeback transactions c=
aused by L1 or L2 cache evictions that miss the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.L2_MISS.ANY",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x3600000008",
-        "Offcore": "1",
         "PublicDescription": "Counts the number of writeback transactions =
caused by L1 or L2 cache evictions that miss the L2 cache. Requires MSR_OFF=
CORE_RESP[0,1] to specify request type and response. (duplicated for both M=
SRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of writeback transactions c=
aused by L1 or L2 cache evictions that miss the L2 cache with a snoop hit i=
n the other processor module, data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.L2_MISS.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x1000000008",
-        "Offcore": "1",
         "PublicDescription": "Counts the number of writeback transactions =
caused by L1 or L2 cache evictions that miss the L2 cache with a snoop hit =
in the other processor module, data forwarding is required. Requires MSR_OF=
FCORE_RESP[0,1] to specify request type and response. (duplicated for both =
MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of writeback transactions c=
aused by L1 or L2 cache evictions that miss the L2 cache with a snoop hit i=
n the other processor module, no data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.L2_MISS.HIT_OTHER_CORE_NO_FW=
D",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x0400000008",
-        "Offcore": "1",
         "PublicDescription": "Counts the number of writeback transactions =
caused by L1 or L2 cache evictions that miss the L2 cache with a snoop hit =
in the other processor module, no data forwarding is required. Requires MSR=
_OFFCORE_RESP[0,1] to specify request type and response. (duplicated for bo=
th MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of writeback transactions c=
aused by L1 or L2 cache evictions that true miss for the L2 cache with a sn=
oop miss in the other processor module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.L2_MISS.SNOOP_MISS_OR_NO_SNO=
OP_NEEDED",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x0200000008",
-        "Offcore": "1",
         "PublicDescription": "Counts the number of writeback transactions =
caused by L1 or L2 cache evictions that true miss for the L2 cache with a s=
noop miss in the other processor module.  Requires MSR_OFFCORE_RESP[0,1] to=
 specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction cacheline and I-sid=
e prefetch requests that miss the instruction cache that hit the L2 cache."=
,
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000040004",
-        "Offcore": "1",
         "PublicDescription": "Counts demand instruction cacheline and I-si=
de prefetch requests that miss the instruction cache that hit the L2 cache.=
 Requires MSR_OFFCORE_RESP[0,1] to specify request type and response. (dupl=
icated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction cacheline and I-sid=
e prefetch requests that miss the instruction cache that miss the L2 cache.=
",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3600000004",
-        "Offcore": "1",
         "PublicDescription": "Counts demand instruction cacheline and I-si=
de prefetch requests that miss the instruction cache that miss the L2 cache=
. Requires MSR_OFFCORE_RESP[0,1] to specify request type and response. (dup=
licated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction cacheline and I-sid=
e prefetch requests that miss the instruction cache that miss the L2 cache =
with a snoop hit in the other processor module, no data forwarding is requi=
red.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_MISS.HIT_OTHER_CO=
RE_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400000004",
-        "Offcore": "1",
         "PublicDescription": "Counts demand instruction cacheline and I-si=
de prefetch requests that miss the instruction cache that miss the L2 cache=
 with a snoop hit in the other processor module, no data forwarding is requ=
ired. Requires MSR_OFFCORE_RESP[0,1] to specify request type and response. =
(duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction cacheline and I-sid=
e prefetch requests that miss the instruction cache that true miss for the =
L2 cache with a snoop miss in the other processor module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_MISS.SNOOP_MISS_O=
R_NO_SNOOP_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200000004",
-        "Offcore": "1",
         "PublicDescription": "Counts demand instruction cacheline and I-si=
de prefetch requests that miss the instruction cache that true miss for the=
 L2 cache with a snoop miss in the other processor module.  Requires MSR_OF=
FCORE_RESP[0,1] to specify request type and response. (duplicated for both =
MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction cacheline and I-sid=
e prefetch requests that miss the instruction cache that are outstanding, p=
er cycle, from the time of the L2 miss to when any response is received.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000000004",
-        "Offcore": "1",
         "PublicDescription": "Counts demand instruction cacheline and I-si=
de prefetch requests that miss the instruction cache that are outstanding, =
per cycle, from the time of the L2 miss to when any response is received. R=
equires MSR_OFFCORE_RESP[0,1] to specify request type and response. (duplic=
ated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand cacheable data reads of full ca=
che lines that hit the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000040001",
-        "Offcore": "1",
         "PublicDescription": "Counts demand cacheable data reads of full c=
ache lines that hit the L2 cache. Requires MSR_OFFCORE_RESP[0,1] to specify=
 request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand cacheable data reads of full ca=
che lines that miss the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3600000001",
-        "Offcore": "1",
         "PublicDescription": "Counts demand cacheable data reads of full c=
ache lines that miss the L2 cache. Requires MSR_OFFCORE_RESP[0,1] to specif=
y request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand cacheable data reads of full ca=
che lines that miss the L2 cache with a snoop hit in the other processor mo=
dule, data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_MISS.HITM_OTHER_C=
ORE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000000001",
-        "Offcore": "1",
         "PublicDescription": "Counts demand cacheable data reads of full c=
ache lines that miss the L2 cache with a snoop hit in the other processor m=
odule, data forwarding is required. Requires MSR_OFFCORE_RESP[0,1] to speci=
fy request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand cacheable data reads of full ca=
che lines that miss the L2 cache with a snoop hit in the other processor mo=
dule, no data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_MISS.HIT_OTHER_CO=
RE_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400000001",
-        "Offcore": "1",
         "PublicDescription": "Counts demand cacheable data reads of full c=
ache lines that miss the L2 cache with a snoop hit in the other processor m=
odule, no data forwarding is required. Requires MSR_OFFCORE_RESP[0,1] to sp=
ecify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand cacheable data reads of full ca=
che lines that true miss for the L2 cache with a snoop miss in the other pr=
ocessor module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_MISS.SNOOP_MISS_O=
R_NO_SNOOP_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200000001",
-        "Offcore": "1",
         "PublicDescription": "Counts demand cacheable data reads of full c=
ache lines that true miss for the L2 cache with a snoop miss in the other p=
rocessor module.  Requires MSR_OFFCORE_RESP[0,1] to specify request type an=
d response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand cacheable data reads of full ca=
che lines that are outstanding, per cycle, from the time of the L2 miss to =
when any response is received.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000000001",
-        "Offcore": "1",
         "PublicDescription": "Counts demand cacheable data reads of full c=
ache lines that are outstanding, per cycle, from the time of the L2 miss to=
 when any response is received. Requires MSR_OFFCORE_RESP[0,1] to specify r=
equest type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts generated by a write to full data cache line that hit the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000040002",
-        "Offcore": "1",
         "PublicDescription": "Counts demand reads for ownership (RFO) requ=
ests generated by a write to full data cache line that hit the L2 cache. Re=
quires MSR_OFFCORE_RESP[0,1] to specify request type and response. (duplica=
ted for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts generated by a write to full data cache line that miss the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3600000002",
-        "Offcore": "1",
         "PublicDescription": "Counts demand reads for ownership (RFO) requ=
ests generated by a write to full data cache line that miss the L2 cache. R=
equires MSR_OFFCORE_RESP[0,1] to specify request type and response. (duplic=
ated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts generated by a write to full data cache line that miss the L2 cache wit=
h a snoop hit in the other processor module, data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_MISS.HITM_OTHER_CORE"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000000002",
-        "Offcore": "1",
         "PublicDescription": "Counts demand reads for ownership (RFO) requ=
ests generated by a write to full data cache line that miss the L2 cache wi=
th a snoop hit in the other processor module, data forwarding is required. =
Requires MSR_OFFCORE_RESP[0,1] to specify request type and response. (dupli=
cated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts generated by a write to full data cache line that miss the L2 cache wit=
h a snoop hit in the other processor module, no data forwarding is required=
.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_MISS.HIT_OTHER_CORE_N=
O_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400000002",
-        "Offcore": "1",
         "PublicDescription": "Counts demand reads for ownership (RFO) requ=
ests generated by a write to full data cache line that miss the L2 cache wi=
th a snoop hit in the other processor module, no data forwarding is require=
d. Requires MSR_OFFCORE_RESP[0,1] to specify request type and response. (du=
plicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts generated by a write to full data cache line that true miss for the L2 =
cache with a snoop miss in the other processor module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_MISS.SNOOP_MISS_OR_NO=
_SNOOP_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200000002",
-        "Offcore": "1",
         "PublicDescription": "Counts demand reads for ownership (RFO) requ=
ests generated by a write to full data cache line that true miss for the L2=
 cache with a snoop miss in the other processor module.  Requires MSR_OFFCO=
RE_RESP[0,1] to specify request type and response. (duplicated for both MSR=
s)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts generated by a write to full data cache line that are outstanding, per =
cycle, from the time of the L2 miss to when any response is received.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000000002",
-        "Offcore": "1",
         "PublicDescription": "Counts demand reads for ownership (RFO) requ=
ests generated by a write to full data cache line that are outstanding, per=
 cycle, from the time of the L2 miss to when any response is received. Requ=
ires MSR_OFFCORE_RESP[0,1] to specify request type and response. (duplicate=
d for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts full cache line data writes to uncache=
able write combining (USWC) memory region and full cache-line non-temporal =
writes that hit the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.FULL_STREAMING_STORES.L2_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000040800",
-        "Offcore": "1",
         "PublicDescription": "Counts full cache line data writes to uncach=
eable write combining (USWC) memory region and full cache-line non-temporal=
 writes that hit the L2 cache. Requires MSR_OFFCORE_RESP[0,1] to specify re=
quest type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts full cache line data writes to uncache=
able write combining (USWC) memory region and full cache-line non-temporal =
writes that miss the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.FULL_STREAMING_STORES.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3600000800",
-        "Offcore": "1",
         "PublicDescription": "Counts full cache line data writes to uncach=
eable write combining (USWC) memory region and full cache-line non-temporal=
 writes that miss the L2 cache. Requires MSR_OFFCORE_RESP[0,1] to specify r=
equest type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts full cache line data writes to uncache=
able write combining (USWC) memory region and full cache-line non-temporal =
writes that miss the L2 cache with a snoop hit in the other processor modul=
e, data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.FULL_STREAMING_STORES.L2_MISS.HITM_=
OTHER_CORE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000000800",
-        "Offcore": "1",
         "PublicDescription": "Counts full cache line data writes to uncach=
eable write combining (USWC) memory region and full cache-line non-temporal=
 writes that miss the L2 cache with a snoop hit in the other processor modu=
le, data forwarding is required. Requires MSR_OFFCORE_RESP[0,1] to specify =
request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts full cache line data writes to uncache=
able write combining (USWC) memory region and full cache-line non-temporal =
writes that miss the L2 cache with a snoop hit in the other processor modul=
e, no data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.FULL_STREAMING_STORES.L2_MISS.HIT_O=
THER_CORE_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400000800",
-        "Offcore": "1",
         "PublicDescription": "Counts full cache line data writes to uncach=
eable write combining (USWC) memory region and full cache-line non-temporal=
 writes that miss the L2 cache with a snoop hit in the other processor modu=
le, no data forwarding is required. Requires MSR_OFFCORE_RESP[0,1] to speci=
fy request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts full cache line data writes to uncache=
able write combining (USWC) memory region and full cache-line non-temporal =
writes that true miss for the L2 cache with a snoop miss in the other proce=
ssor module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.FULL_STREAMING_STORES.L2_MISS.SNOOP=
_MISS_OR_NO_SNOOP_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200000800",
-        "Offcore": "1",
         "PublicDescription": "Counts full cache line data writes to uncach=
eable write combining (USWC) memory region and full cache-line non-temporal=
 writes that true miss for the L2 cache with a snoop miss in the other proc=
essor module.  Requires MSR_OFFCORE_RESP[0,1] to specify request type and r=
esponse. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data partial reads, including d=
ata in uncacheable (UC) or uncacheable write combining (USWC) memory types =
that miss the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3600000080",
-        "Offcore": "1",
         "PublicDescription": "Counts demand data partial reads, including =
data in uncacheable (UC) or uncacheable write combining (USWC) memory types=
 that miss the L2 cache. Requires MSR_OFFCORE_RESP[0,1] to specify request =
type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts partial cache line data writes to unca=
cheable write combining (USWC) memory region  that hit the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_STREAMING_STORES.L2_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000044000",
-        "Offcore": "1",
         "PublicDescription": "Counts partial cache line data writes to unc=
acheable write combining (USWC) memory region  that hit the L2 cache. Requi=
res MSR_OFFCORE_RESP[0,1] to specify request type and response. (duplicated=
 for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts partial cache line data writes to unca=
cheable write combining (USWC) memory region  that miss the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_STREAMING_STORES.L2_MISS.AN=
Y",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3600004000",
-        "Offcore": "1",
         "PublicDescription": "Counts partial cache line data writes to unc=
acheable write combining (USWC) memory region  that miss the L2 cache. Requ=
ires MSR_OFFCORE_RESP[0,1] to specify request type and response. (duplicate=
d for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts partial cache line data writes to unca=
cheable write combining (USWC) memory region  that miss the L2 cache with a=
 snoop hit in the other processor module, data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_STREAMING_STORES.L2_MISS.HI=
TM_OTHER_CORE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000004000",
-        "Offcore": "1",
         "PublicDescription": "Counts partial cache line data writes to unc=
acheable write combining (USWC) memory region  that miss the L2 cache with =
a snoop hit in the other processor module, data forwarding is required. Req=
uires MSR_OFFCORE_RESP[0,1] to specify request type and response. (duplicat=
ed for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts partial cache line data writes to unca=
cheable write combining (USWC) memory region  that miss the L2 cache with a=
 snoop hit in the other processor module, no data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_STREAMING_STORES.L2_MISS.HI=
T_OTHER_CORE_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400004000",
-        "Offcore": "1",
         "PublicDescription": "Counts partial cache line data writes to unc=
acheable write combining (USWC) memory region  that miss the L2 cache with =
a snoop hit in the other processor module, no data forwarding is required. =
Requires MSR_OFFCORE_RESP[0,1] to specify request type and response. (dupli=
cated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts partial cache line data writes to unca=
cheable write combining (USWC) memory region  that true miss for the L2 cac=
he with a snoop miss in the other processor module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_STREAMING_STORES.L2_MISS.SN=
OOP_MISS_OR_NO_SNOOP_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200004000",
-        "Offcore": "1",
         "PublicDescription": "Counts partial cache line data writes to unc=
acheable write combining (USWC) memory region  that true miss for the L2 ca=
che with a snoop miss in the other processor module.  Requires MSR_OFFCORE_=
RESP[0,1] to specify request type and response. (duplicated for both MSRs)"=
,
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of demand write requests (R=
FO) generated by a write to partial data cache line, including the writes t=
o uncacheable (UC) and write through (WT), and write protected (WP) types o=
f memory that miss the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3600000100",
-        "Offcore": "1",
         "PublicDescription": "Counts the number of demand write requests (=
RFO) generated by a write to partial data cache line, including the writes =
to uncacheable (UC) and write through (WT), and write protected (WP) types =
of memory that miss the L2 cache. Requires MSR_OFFCORE_RESP[0,1] to specify=
 request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cache line reads generated by har=
dware L1 data cache prefetcher that hit the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000042000",
-        "Offcore": "1",
         "PublicDescription": "Counts data cache line reads generated by ha=
rdware L1 data cache prefetcher that hit the L2 cache. Requires MSR_OFFCORE=
_RESP[0,1] to specify request type and response. (duplicated for both MSRs)=
",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cache line reads generated by har=
dware L1 data cache prefetcher that miss the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3600002000",
-        "Offcore": "1",
         "PublicDescription": "Counts data cache line reads generated by ha=
rdware L1 data cache prefetcher that miss the L2 cache. Requires MSR_OFFCOR=
E_RESP[0,1] to specify request type and response. (duplicated for both MSRs=
)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cache line reads generated by har=
dware L1 data cache prefetcher that miss the L2 cache with a snoop hit in t=
he other processor module, data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_MISS.HITM_OTHER_CO=
RE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000002000",
-        "Offcore": "1",
         "PublicDescription": "Counts data cache line reads generated by ha=
rdware L1 data cache prefetcher that miss the L2 cache with a snoop hit in =
the other processor module, data forwarding is required. Requires MSR_OFFCO=
RE_RESP[0,1] to specify request type and response. (duplicated for both MSR=
s)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cache line reads generated by har=
dware L1 data cache prefetcher that miss the L2 cache with a snoop hit in t=
he other processor module, no data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_MISS.HIT_OTHER_COR=
E_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400002000",
-        "Offcore": "1",
         "PublicDescription": "Counts data cache line reads generated by ha=
rdware L1 data cache prefetcher that miss the L2 cache with a snoop hit in =
the other processor module, no data forwarding is required. Requires MSR_OF=
FCORE_RESP[0,1] to specify request type and response. (duplicated for both =
MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cache line reads generated by har=
dware L1 data cache prefetcher that true miss for the L2 cache with a snoop=
 miss in the other processor module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_MISS.SNOOP_MISS_OR=
_NO_SNOOP_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200002000",
-        "Offcore": "1",
         "PublicDescription": "Counts data cache line reads generated by ha=
rdware L1 data cache prefetcher that true miss for the L2 cache with a snoo=
p miss in the other processor module.  Requires MSR_OFFCORE_RESP[0,1] to sp=
ecify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cacheline reads generated by hard=
ware L2 cache prefetcher that hit the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L2_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000040010",
-        "Offcore": "1",
         "PublicDescription": "Counts data cacheline reads generated by har=
dware L2 cache prefetcher that hit the L2 cache. Requires MSR_OFFCORE_RESP[=
0,1] to specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cacheline reads generated by hard=
ware L2 cache prefetcher that miss the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3600000010",
-        "Offcore": "1",
         "PublicDescription": "Counts data cacheline reads generated by har=
dware L2 cache prefetcher that miss the L2 cache. Requires MSR_OFFCORE_RESP=
[0,1] to specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cacheline reads generated by hard=
ware L2 cache prefetcher that miss the L2 cache with a snoop hit in the oth=
er processor module, data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L2_MISS.HITM_OTHER_CO=
RE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000000010",
-        "Offcore": "1",
         "PublicDescription": "Counts data cacheline reads generated by har=
dware L2 cache prefetcher that miss the L2 cache with a snoop hit in the ot=
her processor module, data forwarding is required. Requires MSR_OFFCORE_RES=
P[0,1] to specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cacheline reads generated by hard=
ware L2 cache prefetcher that miss the L2 cache with a snoop hit in the oth=
er processor module, no data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L2_MISS.HIT_OTHER_COR=
E_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400000010",
-        "Offcore": "1",
         "PublicDescription": "Counts data cacheline reads generated by har=
dware L2 cache prefetcher that miss the L2 cache with a snoop hit in the ot=
her processor module, no data forwarding is required. Requires MSR_OFFCORE_=
RESP[0,1] to specify request type and response. (duplicated for both MSRs)"=
,
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cacheline reads generated by hard=
ware L2 cache prefetcher that true miss for the L2 cache with a snoop miss =
in the other processor module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L2_MISS.SNOOP_MISS_OR=
_NO_SNOOP_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200000010",
-        "Offcore": "1",
         "PublicDescription": "Counts data cacheline reads generated by har=
dware L2 cache prefetcher that true miss for the L2 cache with a snoop miss=
 in the other processor module.  Requires MSR_OFFCORE_RESP[0,1] to specify =
request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests gen=
erated by L2 prefetcher that hit the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000040020",
-        "Offcore": "1",
         "PublicDescription": "Counts reads for ownership (RFO) requests ge=
nerated by L2 prefetcher that hit the L2 cache. Requires MSR_OFFCORE_RESP[0=
,1] to specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests gen=
erated by L2 prefetcher that miss the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3600000020",
-        "Offcore": "1",
         "PublicDescription": "Counts reads for ownership (RFO) requests ge=
nerated by L2 prefetcher that miss the L2 cache. Requires MSR_OFFCORE_RESP[=
0,1] to specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests gen=
erated by L2 prefetcher that miss the L2 cache with a snoop hit in the othe=
r processor module, data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_MISS.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000000020",
-        "Offcore": "1",
         "PublicDescription": "Counts reads for ownership (RFO) requests ge=
nerated by L2 prefetcher that miss the L2 cache with a snoop hit in the oth=
er processor module, data forwarding is required. Requires MSR_OFFCORE_RESP=
[0,1] to specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests gen=
erated by L2 prefetcher that miss the L2 cache with a snoop hit in the othe=
r processor module, no data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_MISS.HIT_OTHER_CORE_NO=
_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400000020",
-        "Offcore": "1",
         "PublicDescription": "Counts reads for ownership (RFO) requests ge=
nerated by L2 prefetcher that miss the L2 cache with a snoop hit in the oth=
er processor module, no data forwarding is required. Requires MSR_OFFCORE_R=
ESP[0,1] to specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests gen=
erated by L2 prefetcher that true miss for the L2 cache with a snoop miss i=
n the other processor module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_MISS.SNOOP_MISS_OR_NO_=
SNOOP_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200000020",
-        "Offcore": "1",
         "PublicDescription": "Counts reads for ownership (RFO) requests ge=
nerated by L2 prefetcher that true miss for the L2 cache with a snoop miss =
in the other processor module.  Requires MSR_OFFCORE_RESP[0,1] to specify r=
equest type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any data writes to uncacheable write c=
ombining (USWC) memory region  that hit the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.STREAMING_STORES.L2_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000044800",
-        "Offcore": "1",
         "PublicDescription": "Counts any data writes to uncacheable write =
combining (USWC) memory region  that hit the L2 cache. Requires MSR_OFFCORE=
_RESP[0,1] to specify request type and response. (duplicated for both MSRs)=
",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any data writes to uncacheable write c=
ombining (USWC) memory region  that miss the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.STREAMING_STORES.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3600004800",
-        "Offcore": "1",
         "PublicDescription": "Counts any data writes to uncacheable write =
combining (USWC) memory region  that miss the L2 cache. Requires MSR_OFFCOR=
E_RESP[0,1] to specify request type and response. (duplicated for both MSRs=
)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cache lines requests by software =
prefetch instructions that hit the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.SW_PREFETCH.L2_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000041000",
-        "Offcore": "1",
         "PublicDescription": "Counts data cache lines requests by software=
 prefetch instructions that hit the L2 cache. Requires MSR_OFFCORE_RESP[0,1=
] to specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cache lines requests by software =
prefetch instructions that miss the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.SW_PREFETCH.L2_MISS.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3600001000",
-        "Offcore": "1",
         "PublicDescription": "Counts data cache lines requests by software=
 prefetch instructions that miss the L2 cache. Requires MSR_OFFCORE_RESP[0,=
1] to specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cache lines requests by software =
prefetch instructions that miss the L2 cache with a snoop hit in the other =
processor module, data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.SW_PREFETCH.L2_MISS.HITM_OTHER_CORE=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000001000",
-        "Offcore": "1",
         "PublicDescription": "Counts data cache lines requests by software=
 prefetch instructions that miss the L2 cache with a snoop hit in the other=
 processor module, data forwarding is required. Requires MSR_OFFCORE_RESP[0=
,1] to specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cache lines requests by software =
prefetch instructions that miss the L2 cache with a snoop hit in the other =
processor module, no data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.SW_PREFETCH.L2_MISS.HIT_OTHER_CORE_=
NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0400001000",
-        "Offcore": "1",
         "PublicDescription": "Counts data cache lines requests by software=
 prefetch instructions that miss the L2 cache with a snoop hit in the other=
 processor module, no data forwarding is required. Requires MSR_OFFCORE_RES=
P[0,1] to specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cache lines requests by software =
prefetch instructions that true miss for the L2 cache with a snoop miss in =
the other processor module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.SW_PREFETCH.L2_MISS.SNOOP_MISS_OR_N=
O_SNOOP_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0200001000",
-        "Offcore": "1",
         "PublicDescription": "Counts data cache lines requests by software=
 prefetch instructions that true miss for the L2 cache with a snoop miss in=
 the other processor module.  Requires MSR_OFFCORE_RESP[0,1] to specify req=
uest type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
diff --git a/tools/perf/pmu-events/arch/x86/goldmont/floating-point.json b/=
tools/perf/pmu-events/arch/x86/goldmont/floating-point.json
index 37174392a510..a3f03855ca05 100644
--- a/tools/perf/pmu-events/arch/x86/goldmont/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/goldmont/floating-point.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Cycles the FP divide unit is busy",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCD",
         "EventName": "CYCLES_DIV_BUSY.FPDIV",
         "PublicDescription": "Counts core cycles the floating point divide=
 unit is busy.",
@@ -11,8 +9,6 @@
     },
     {
         "BriefDescription": "Machine clears due to FP assists",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.FP_ASSIST",
         "PublicDescription": "Counts machine clears due to floating point =
(FP) operations needing assists.  For instance, if the result was a floatin=
g point denormal, the hardware clears the pipeline and reissues uops to pro=
duce the correct IEEE compliant denormal result.",
@@ -21,8 +17,6 @@
     },
     {
         "BriefDescription": "Floating point divide uops retired. (Precise =
Event Capable)",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.FPDIV",
         "PEBS": "2",
diff --git a/tools/perf/pmu-events/arch/x86/goldmont/frontend.json b/tools/=
perf/pmu-events/arch/x86/goldmont/frontend.json
index 216da6e121c8..ace2a114b546 100644
--- a/tools/perf/pmu-events/arch/x86/goldmont/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/goldmont/frontend.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "BACLEARs asserted for any branch type",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xE6",
         "EventName": "BACLEARS.ALL",
         "PublicDescription": "Counts the number of times a BACLEAR is sign=
aled for any reason, including, but not limited to indirect branch/call,  J=
cc (Jump on Conditional Code/Jump if Condition is Met) branch, unconditiona=
l branch/call, and returns.",
@@ -11,8 +9,6 @@
     },
     {
         "BriefDescription": "BACLEARs asserted for conditional branch",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xE6",
         "EventName": "BACLEARS.COND",
         "PublicDescription": "Counts BACLEARS on Jcc (Jump on Conditional =
Code/Jump if Condition is Met) branches.",
@@ -21,8 +17,6 @@
     },
     {
         "BriefDescription": "BACLEARs asserted for return branch",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xE6",
         "EventName": "BACLEARS.RETURN",
         "PublicDescription": "Counts BACLEARS on return instructions.",
@@ -31,8 +25,6 @@
     },
     {
         "BriefDescription": "Decode restrictions due to predicting wrong i=
nstruction length",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xE9",
         "EventName": "DECODE_RESTRICTION.PREDECODE_WRONG",
         "PublicDescription": "Counts the number of times the prediction (f=
rom the predecode cache) for instruction length is incorrect.",
@@ -41,8 +33,6 @@
     },
     {
         "BriefDescription": "References per ICache line. This event counts=
 differently than Intel processors based on Silvermont microarchitecture",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "ICACHE.ACCESSES",
         "PublicDescription": "Counts requests to the Instruction Cache (IC=
ache) for one or more bytes in an ICache Line.  The event strives to count =
on a cache line basis, so that multiple fetches to a single cache line coun=
t as one ICACHE.ACCESS.  Specifically, the event counts when accesses from =
straight line code crosses the cache line boundary, or when a branch target=
 is to a new line.\r\nThis event counts differently than Intel processors b=
ased on Silvermont microarchitecture.",
@@ -51,8 +41,6 @@
     },
     {
         "BriefDescription": "References per ICache line that are available=
 in the ICache (hit). This event counts differently than Intel processors b=
ased on Silvermont microarchitecture",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "ICACHE.HIT",
         "PublicDescription": "Counts requests to the Instruction Cache (IC=
ache) for one or more bytes in an ICache Line and that cache line is in the=
 ICache (hit).  The event strives to count on a cache line basis, so that m=
ultiple accesses which hit in a single cache line count as one ICACHE.HIT. =
 Specifically, the event counts when straight line code crosses the cache l=
ine boundary, or when a branch target is to a new line, and that cache line=
 is in the ICache. This event counts differently than Intel processors base=
d on Silvermont microarchitecture.",
@@ -61,8 +49,6 @@
     },
     {
         "BriefDescription": "References per ICache line that are not avail=
able in the ICache (miss). This event counts differently than Intel process=
ors based on Silvermont microarchitecture",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "ICACHE.MISSES",
         "PublicDescription": "Counts requests to the Instruction Cache (IC=
ache)  for one or more bytes in an ICache Line and that cache line is not i=
n the ICache (miss).  The event strives to count on a cache line basis, so =
that multiple accesses which miss in a single cache line count as one ICACH=
E.MISS.  Specifically, the event counts when straight line code crosses the=
 cache line boundary, or when a branch target is to a new line, and that ca=
che line is not in the ICache. This event counts differently than Intel pro=
cessors based on Silvermont microarchitecture.",
@@ -71,8 +57,6 @@
     },
     {
         "BriefDescription": "MS decode starts",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xE7",
         "EventName": "MS_DECODED.MS_ENTRY",
         "PublicDescription": "Counts the number of times the Microcode Seq=
uencer (MS) starts a flow of uops from the MSROM. It does not count every t=
ime a uop is read from the MSROM.  The most common case that this counts is=
 when a micro-coded instruction is encountered by the front end of the mach=
ine.  Other cases include when an instruction encounters a fault, trap, or =
microcode assist of any sort that initiates a flow of uops.  The event will=
 count MS startups for uops that are speculative, and subsequently cleared =
by branch mispredict or a machine clear.",
diff --git a/tools/perf/pmu-events/arch/x86/goldmont/memory.json b/tools/pe=
rf/pmu-events/arch/x86/goldmont/memory.json
index 9f6f0328249e..b97642a109ee 100644
--- a/tools/perf/pmu-events/arch/x86/goldmont/memory.json
+++ b/tools/perf/pmu-events/arch/x86/goldmont/memory.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Machine clears due to memory ordering issue",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
         "PublicDescription": "Counts machine clears due to memory ordering=
 issues.  This occurs when a snoop request happens and the machine is uncer=
tain if memory ordering will be preserved as another core is in the process=
 of modifying the data.",
@@ -11,8 +9,6 @@
     },
     {
         "BriefDescription": "Load uops that split a page (Precise event ca=
pable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "MISALIGN_MEM_REF.LOAD_PAGE_SPLIT",
         "PEBS": "2",
@@ -22,8 +18,6 @@
     },
     {
         "BriefDescription": "Store uops that split a page (Precise event c=
apable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "MISALIGN_MEM_REF.STORE_PAGE_SPLIT",
         "PEBS": "2",
diff --git a/tools/perf/pmu-events/arch/x86/goldmont/other.json b/tools/per=
f/pmu-events/arch/x86/goldmont/other.json
index d888f67aa2ea..c4fd0acb15bc 100644
--- a/tools/perf/pmu-events/arch/x86/goldmont/other.json
+++ b/tools/perf/pmu-events/arch/x86/goldmont/other.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Cycles code-fetch stalled due to any reason."=
,
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "FETCH_STALL.ALL",
         "PublicDescription": "Counts cycles that fetch is stalled due to a=
ny reason. That is, the decoder queue is able to accept bytes, but the fetc=
h unit is unable to provide bytes.  This will include cycles due to an ITLB=
 miss, ICache miss and other events.",
@@ -10,8 +8,6 @@
     },
     {
         "BriefDescription": "Cycles code-fetch stalled due to an outstandi=
ng ITLB miss.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "FETCH_STALL.ITLB_FILL_PENDING_CYCLES",
         "PublicDescription": "Counts cycles that fetch is stalled due to a=
n outstanding ITLB miss. That is, the decoder queue is able to accept bytes=
, but the fetch unit is unable to provide bytes due to an ITLB miss.  Note:=
 this event is not the same as page walk cycles to retrieve an instruction =
translation.",
@@ -20,8 +16,6 @@
     },
     {
         "BriefDescription": "Cycles hardware interrupts are masked",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCB",
         "EventName": "HW_INTERRUPTS.MASKED",
         "PublicDescription": "Counts the number of core cycles during whic=
h interrupts are masked (disabled). Increments by 1 each core cycle that EF=
LAGS.IF is 0, regardless of whether interrupts are pending or not.",
@@ -30,8 +24,6 @@
     },
     {
         "BriefDescription": "Cycles pending interrupts are masked",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCB",
         "EventName": "HW_INTERRUPTS.PENDING_AND_MASKED",
         "PublicDescription": "Counts core cycles during which there are pe=
nding interrupts, but interrupts are masked (EFLAGS.IF =3D 0).",
@@ -40,8 +32,6 @@
     },
     {
         "BriefDescription": "Hardware interrupts received",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCB",
         "EventName": "HW_INTERRUPTS.RECEIVED",
         "PublicDescription": "Counts hardware interrupts received by the p=
rocessor.",
diff --git a/tools/perf/pmu-events/arch/x86/goldmont/pipeline.json b/tools/=
perf/pmu-events/arch/x86/goldmont/pipeline.json
index 42ff0b134aeb..acb897483a87 100644
--- a/tools/perf/pmu-events/arch/x86/goldmont/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/goldmont/pipeline.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "Retired branch instructions (Precise event ca=
pable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PEBS": "2",
@@ -11,8 +9,6 @@
     },
     {
         "BriefDescription": "Retired taken branch instructions (Precise ev=
ent capable)",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ALL_TAKEN_BRANCHES",
         "PEBS": "2",
@@ -22,8 +18,6 @@
     },
     {
         "BriefDescription": "Retired near call instructions (Precise event=
 capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.CALL",
         "PEBS": "2",
@@ -33,8 +27,6 @@
     },
     {
         "BriefDescription": "Retired far branch instructions (Precise even=
t capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
         "PEBS": "2",
@@ -44,8 +36,6 @@
     },
     {
         "BriefDescription": "Retired near indirect call instructions (Prec=
ise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.IND_CALL",
         "PEBS": "2",
@@ -55,8 +45,6 @@
     },
     {
         "BriefDescription": "Retired conditional branch instructions (Prec=
ise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.JCC",
         "PEBS": "2",
@@ -66,8 +54,6 @@
     },
     {
         "BriefDescription": "Retired instructions of near indirect Jmp or =
call (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NON_RETURN_IND",
         "PEBS": "2",
@@ -77,8 +63,6 @@
     },
     {
         "BriefDescription": "Retired near relative call instructions (Prec=
ise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.REL_CALL",
         "PEBS": "2",
@@ -88,8 +72,6 @@
     },
     {
         "BriefDescription": "Retired near return instructions (Precise eve=
nt capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.RETURN",
         "PEBS": "2",
@@ -99,8 +81,6 @@
     },
     {
         "BriefDescription": "Retired conditional branch instructions that =
were taken (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.TAKEN_JCC",
         "PEBS": "2",
@@ -110,8 +90,6 @@
     },
     {
         "BriefDescription": "Retired mispredicted branch instructions (Pre=
cise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PEBS": "2",
@@ -120,8 +98,6 @@
     },
     {
         "BriefDescription": "Retired mispredicted near indirect call instr=
uctions (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.IND_CALL",
         "PEBS": "2",
@@ -131,8 +107,6 @@
     },
     {
         "BriefDescription": "Retired mispredicted conditional branch instr=
uctions (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.JCC",
         "PEBS": "2",
@@ -142,8 +116,6 @@
     },
     {
         "BriefDescription": "Retired mispredicted instructions of near ind=
irect Jmp or near indirect call. (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.NON_RETURN_IND",
         "PEBS": "2",
@@ -153,8 +125,6 @@
     },
     {
         "BriefDescription": "Retired mispredicted near return instructions=
 (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.RETURN",
         "PEBS": "2",
@@ -164,8 +134,6 @@
     },
     {
         "BriefDescription": "Retired mispredicted conditional branch instr=
uctions that were taken (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.TAKEN_JCC",
         "PEBS": "2",
@@ -175,7 +143,6 @@
     },
     {
         "BriefDescription": "Core cycles when core is not halted  (Fixed e=
vent)",
-        "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.CORE",
         "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state.  The core enters the halt state when it is runn=
ing the HLT instruction. In mobile systems the core frequency may change fr=
om time to time. For this reason this event may have a changing ratio with =
regards to time.  This event uses fixed counter 1.  You cannot collect a PE=
Bs record for this event.",
         "SampleAfterValue": "2000003",
@@ -183,8 +150,6 @@
     },
     {
         "BriefDescription": "Core cycles when core is not halted",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.CORE_P",
         "PublicDescription": "Core cycles when core is not halted.  This e=
vent uses a (_P)rogrammable general purpose performance counter.",
@@ -192,8 +157,6 @@
     },
     {
         "BriefDescription": "Reference cycles when core is not halted",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.REF",
         "PublicDescription": "Reference cycles when core is not halted.  T=
his event uses a programmable general purpose performance counter.",
@@ -202,7 +165,6 @@
     },
     {
         "BriefDescription": "Reference cycles when core is not halted  (Fi=
xed event)",
-        "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "Counts the number of reference cycles that t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction.  In mobile systems the core frequency may chang=
e from time.  This event is not affected by core frequency changes but coun=
ts as if the core is running at the maximum frequency all the time.  This e=
vent uses fixed counter 2.  You cannot collect a PEBs record for this event=
.",
         "SampleAfterValue": "2000003",
@@ -210,8 +172,6 @@
     },
     {
         "BriefDescription": "Cycles a divider is busy",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCD",
         "EventName": "CYCLES_DIV_BUSY.ALL",
         "PublicDescription": "Counts core cycles if either divide unit is =
busy.",
@@ -219,8 +179,6 @@
     },
     {
         "BriefDescription": "Cycles the integer divide unit is busy",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCD",
         "EventName": "CYCLES_DIV_BUSY.IDIV",
         "PublicDescription": "Counts core cycles the integer divide unit i=
s busy.",
@@ -229,7 +187,6 @@
     },
     {
         "BriefDescription": "Instructions retired (Fixed event)",
-        "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
         "PublicDescription": "Counts the number of instructions that retir=
e execution. For instructions that consist of multiple uops, this event cou=
nts the retirement of the last uop of the instruction. The counter continue=
s counting during hardware interrupts, traps, and inside interrupt handlers=
.  This event uses fixed counter 0.  You cannot collect a PEBs record for t=
his event.",
         "SampleAfterValue": "2000003",
@@ -237,8 +194,6 @@
     },
     {
         "BriefDescription": "Instructions retired (Precise event capable)"=
,
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.ANY_P",
         "PEBS": "2",
@@ -247,8 +202,6 @@
     },
     {
         "BriefDescription": "Unfilled issue slots per cycle",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCA",
         "EventName": "ISSUE_SLOTS_NOT_CONSUMED.ANY",
         "PublicDescription": "Counts the number of issue slots per core cy=
cle that were not consumed by the backend due to either a full resource  in=
 the backend (RESOURCE_FULL) or due to the processor recovering from some e=
vent (RECOVERY).",
@@ -256,8 +209,6 @@
     },
     {
         "BriefDescription": "Unfilled issue slots per cycle to recover",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCA",
         "EventName": "ISSUE_SLOTS_NOT_CONSUMED.RECOVERY",
         "PublicDescription": "Counts the number of issue slots per core cy=
cle that were not consumed by the backend because allocation is stalled wai=
ting for a mispredicted jump to retire or other branch-like conditions (e.g=
. the event is relevant during certain microcode flows).   Counts all issue=
 slots blocked while within this window including slots where uops were not=
 available in the Instruction Queue.",
@@ -266,8 +217,6 @@
     },
     {
         "BriefDescription": "Unfilled issue slots per cycle because of a f=
ull resource in the backend",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCA",
         "EventName": "ISSUE_SLOTS_NOT_CONSUMED.RESOURCE_FULL",
         "PublicDescription": "Counts the number of issue slots per core cy=
cle that were not consumed because of a full resource in the backend.  Incl=
uding but not limited to resources such as the Re-order Buffer (ROB), reser=
vation stations (RS), load/store buffers, physical registers, or any other =
needed machine resource that is currently unavailable.   Note that uops mus=
t be available for consumption in order for this event to fire.  If a uop i=
s not available (Instruction Queue is empty), this event will not count.",
@@ -276,8 +225,6 @@
     },
     {
         "BriefDescription": "Loads blocked because address has 4k partial =
address false dependence (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.4K_ALIAS",
         "PEBS": "2",
@@ -287,8 +234,6 @@
     },
     {
         "BriefDescription": "Loads blocked (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.ALL_BLOCK",
         "PEBS": "2",
@@ -298,8 +243,6 @@
     },
     {
         "BriefDescription": "Loads blocked due to store data not ready (Pr=
ecise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.DATA_UNKNOWN",
         "PEBS": "2",
@@ -309,8 +252,6 @@
     },
     {
         "BriefDescription": "Loads blocked due to store forward restrictio=
n (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
         "PEBS": "2",
@@ -320,8 +261,6 @@
     },
     {
         "BriefDescription": "Loads blocked because address in not in the U=
TLB (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.UTLB_MISS",
         "PEBS": "2",
@@ -331,8 +270,6 @@
     },
     {
         "BriefDescription": "All machine clears",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.ALL",
         "PublicDescription": "Counts machine clears for any reason.",
@@ -340,8 +277,6 @@
     },
     {
         "BriefDescription": "Machine clears due to memory disambiguation",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.DISAMBIGUATION",
         "PublicDescription": "Counts machine clears due to memory disambig=
uation.  Memory disambiguation happens when a load which has been issued co=
nflicts with a previous unretired store in the pipeline whose address was n=
ot known at issue time, but is later resolved to be the same as the load ad=
dress.",
@@ -350,8 +285,6 @@
     },
     {
         "BriefDescription": "Self-Modifying Code detected",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.SMC",
         "PublicDescription": "Counts the number of times that the processo=
r detects that a program is writing to a code section and has to perform a =
machine clear because of that modification.  Self-modifying code (SMC) caus=
es a severe penalty in all Intel(R) architecture processors.",
@@ -360,8 +293,6 @@
     },
     {
         "BriefDescription": "Uops issued to the back end per cycle",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.ANY",
         "PublicDescription": "Counts uops issued by the front end and allo=
cated into the back end of the machine.  This event counts uops that retire=
 as well as uops that were speculatively executed but didn't retire. The so=
rt of speculative uops that might be counted includes, but is not limited t=
o those uops issued in the shadow of a miss-predicted branch, those uops th=
at are inserted during an assist (such as for a denormal floating point res=
ult), and (previously allocated) uops that might be canceled during a machi=
ne clear.",
@@ -369,8 +300,6 @@
     },
     {
         "BriefDescription": "Uops requested but not-delivered to the back-=
end per cycle",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9C",
         "EventName": "UOPS_NOT_DELIVERED.ANY",
         "PublicDescription": "This event used to measure front-end ineffic=
iencies. I.e. when front-end of the machine is not delivering uops to the b=
ack-end and the back-end has is not stalled. This event can be used to iden=
tify if the machine is truly front-end bound.  When this event occurs, it i=
s an indication that the front-end of the machine is operating at less than=
 its theoretical peak performance. Background: We can think of the processo=
r pipeline as being divided into 2 broader parts: Front-end and Back-end. F=
ront-end is responsible for fetching the instruction, decoding into uops in=
 machine understandable format and putting them into a uop queue to be cons=
umed by back end. The back-end then takes these uops, allocates the require=
d resources.  When all resources are ready, uops are executed. If the back-=
end is not ready to accept uops from the front-end, then we do not want to =
count these as front-end bottlenecks.  However, whenever we have bottleneck=
s in the back-end, we will have allocation unit stalls and eventually forci=
ng the front-end to wait until the back-end is ready to receive more uops. =
This event counts only when back-end is requesting more uops and front-end =
is not able to provide them. When 3 uops are requested and no uops are deli=
vered, the event counts 3. When 3 are requested, and only 1 is delivered, t=
he event counts 2. When only 2 are delivered, the event counts 1. Alternati=
vely stated, the event will not count if 3 uops are delivered, or if the ba=
ck end is stalled and not requesting any uops at all.  Counts indicate miss=
ed opportunities for the front-end to deliver a uop to the back end. Some e=
xamples of conditions that cause front-end efficiencies are: ICache misses,=
 ITLB misses, and decoder restrictions that limit the front-end bandwidth. =
Known Issues: Some uops require multiple allocation slots.  These uops will=
 not be charged as a front end 'not delivered' opportunity, and will be reg=
arded as a back end problem. For example, the INC instruction has one uop t=
hat requires 2 issue slots.  A stream of INC instructions will not count as=
 UOPS_NOT_DELIVERED, even though only one instruction can be issued per clo=
ck.  The low uop issue rate for a stream of INC instructions is considered =
to be a back end issue.",
@@ -378,8 +307,6 @@
     },
     {
         "BriefDescription": "Uops retired (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.ANY",
         "PEBS": "2",
@@ -388,8 +315,6 @@
     },
     {
         "BriefDescription": "Integer divide uops retired. (Precise Event C=
apable)",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.IDIV",
         "PEBS": "2",
@@ -399,8 +324,6 @@
     },
     {
         "BriefDescription": "MS uops retired (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.MS",
         "PEBS": "2",
diff --git a/tools/perf/pmu-events/arch/x86/goldmont/virtual-memory.json b/=
tools/perf/pmu-events/arch/x86/goldmont/virtual-memory.json
index 2e17e02e1463..8c4929a517fa 100644
--- a/tools/perf/pmu-events/arch/x86/goldmont/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/goldmont/virtual-memory.json
@@ -1,8 +1,6 @@
 [
     {
         "BriefDescription": "ITLB misses",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x81",
         "EventName": "ITLB.MISS",
         "PublicDescription": "Counts the number of times the machine was u=
nable to find a translation in the Instruction Translation Lookaside Buffer=
 (ITLB) for a linear address of an instruction fetch.  It counts when new t=
ranslation are filled into the ITLB.  The event is speculative in nature, b=
ut will not count translations (page walks) that are begun and not finished=
, or translations that are finished but not filled into the ITLB.",
@@ -11,8 +9,6 @@
     },
     {
         "BriefDescription": "Memory uops retired that missed the DTLB (Pre=
cise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS",
@@ -23,8 +19,6 @@
     },
     {
         "BriefDescription": "Load uops retired that missed the DTLB (Preci=
se event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS_LOADS",
@@ -35,8 +29,6 @@
     },
     {
         "BriefDescription": "Store uops retired that missed the DTLB (Prec=
ise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS_STORES",
@@ -47,8 +39,6 @@
     },
     {
         "BriefDescription": "Duration of page-walks in cycles",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "PAGE_WALKS.CYCLES",
         "PublicDescription": "Counts every core cycle a page-walk is in pr=
ogress due to either a data memory operation or an instruction fetch.",
@@ -57,8 +47,6 @@
     },
     {
         "BriefDescription": "Duration of D-side page-walks in cycles",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "PAGE_WALKS.D_SIDE_CYCLES",
         "PublicDescription": "Counts every core cycle when a Data-side (wa=
lks due to a data operation) page walk is in progress.",
@@ -67,8 +55,6 @@
     },
     {
         "BriefDescription": "Duration of I-side pagewalks in cycles",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "PAGE_WALKS.I_SIDE_CYCLES",
         "PublicDescription": "Counts every core cycle when a Instruction-s=
ide (walks due to an instruction fetch) page walk is in progress.",
--=20
2.39.0.314.g84b9a713c41-goog

