Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2377C64D6C5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 07:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiLOG53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 01:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiLOG4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:56:25 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978E51037
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:56:12 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3c9960ad866so25789557b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INbaKr8qcjt03T25dvKyMFtX9jmhQUHnjN045qwwMHs=;
        b=eWF1LPNqNNj6jD74hdQfurWtMVC34Hy7GriaQyFxyEpQPHe62MVhCGsIuU/Ca5r5jZ
         EhCzFUledJPrAfJfJDd8SFr2Yzq6t3N5Aggj1RMWu30f0j+84aRqNo6+KZEtAOkhpqe2
         V3NR9F2Qyy33cjSGFs3ZzhYuRtZ55hn2xFG4FjNy+xMyomMIpQr7mih7tjrvCcWxg6Mv
         kuJOi9bXOVxtCJ6NrslhxOEEIOzprqLIt35d9+Of891Im+JDyNSkvEEUq1yJfLhF1JN2
         yEM44i27zbHIP98hKpf93lpIVXTFHkyQfzsEEieUv2x4NRq972cHIGfIMrtfnSPynhHJ
         d84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=INbaKr8qcjt03T25dvKyMFtX9jmhQUHnjN045qwwMHs=;
        b=fvIRJefU1E2RZXX9tA1I0EXfO9Wd3qcO+JK21n+/7u/gEvhqWzqwy53zXTzRkC4BZU
         UQXR1yJ1u1+R0WUwuQpuAi1UE2c+uA2kPy8YzUKF16wnFhm79fuDiNgVnSdy6RqgKs+r
         IqSOxiqpwaHGx/zSpWqSh4jVn4PdeXT6k/vGUoOVOXz933x0kEkHO8uQqvm0cpC7Jbi9
         T8v15Yh1xFG1666k5gtjfZLbSk5oENLl96B7RNZWl77uv4sOervytCofC0WpXOwLyAI2
         Db1j1vXqxJ+sW65j0tNBtnLn0lcY5Oyp5PA7RhATujUI1siGIJQadA54iYVjUfTHLMiU
         rcmw==
X-Gm-Message-State: ANoB5pkZteWxv1K6RbqvJLi8T+67dYg+NMXWs6bDzUetCiEqEgrhcN4v
        wWcvG1DewA5HjlzgSjsJmBvQs9Nz9uBU
X-Google-Smtp-Source: AA0mqf7J4o0hl0utQCpt+IJSf60JVr8kOc4ZdLXwM+9+O2Js5blvqNSMLDYZ0bWGpSS58+BnyppXc+0zo8fy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c7dc:d96f:4f9:f59d])
 (user=irogers job=sendgmr) by 2002:a25:e792:0:b0:6f0:9351:38ed with SMTP id
 e140-20020a25e792000000b006f0935138edmr66226775ybh.107.1671087371859; Wed, 14
 Dec 2022 22:56:11 -0800 (PST)
Date:   Wed, 14 Dec 2022 22:54:52 -0800
In-Reply-To: <20221215065510.1621979-1-irogers@google.com>
Message-Id: <20221215065510.1621979-6-irogers@google.com>
Mime-Version: 1.0
References: <20221215065510.1621979-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 14/32] perf vendor events intel: Refresh icelake metrics
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

Update the icelake metrics and events using the new tooling from:
https://github.com/intel/perfmon

The metrics are unchanged but the formulas differ due to parentheses,
use of exponents and removal of redundant operations like "* 1".  The
events are unchanged but unused json values are removed. The
formatting changes increase consistency across the json files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/icelake/cache.json    | 412 ------------------
 .../arch/x86/icelake/floating-point.json      |  28 --
 .../pmu-events/arch/x86/icelake/frontend.json | 144 ------
 .../arch/x86/icelake/icl-metrics.json         | 151 ++++---
 .../pmu-events/arch/x86/icelake/memory.json   | 171 --------
 .../pmu-events/arch/x86/icelake/other.json    | 132 ------
 .../pmu-events/arch/x86/icelake/pipeline.json | 349 +--------------
 .../arch/x86/icelake/uncore-other.json        |  10 +-
 .../arch/x86/icelake/virtual-memory.json      |  80 ----
 9 files changed, 89 insertions(+), 1388 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/icelake/cache.json b/tools/perf=
/pmu-events/arch/x86/icelake/cache.json
index 0f6b918484d5..bc6587391760 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/cache.json
@@ -1,1272 +1,860 @@
 [
     {
         "BriefDescription": "Counts the number of cache lines replaced in =
L1 data cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "L1D.REPLACEMENT",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts L1D data line replacements including =
opportunistic replacements, and replacements that require stall-for-replace=
 or block-for-replace.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Number of cycles a demand request has waited =
due to L1D Fill Buffer (FB) unavailability.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Number of phases a demand request has waited =
due to L1D Fill Buffer (FB) unavailability.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL_PERIODS",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts number of phases a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Number of cycles a demand request has waited =
due to L1D due to lack of L2 resources.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.L2_STALL",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D due to lack of L2 resources. Demand requests include cac=
heable/uncacheable demand load, store, lock or SW prefetch accesses.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Number of L1D misses that are outstanding",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts number of L1D misses that are outstan=
ding in each cycle, that is each cycle the number of Fill Buffers (FB) outs=
tanding required by Demand Reads. FB either is held by demand loads, or it =
is held by non-demand loads and gets hit at least once by demand. The valid=
 outstanding interval is defined until the FB deallocation by one of the fo=
llowing ways: from FB allocation, if FB is allocated by demand from the dem=
and Hit FB, if it is allocated by hardware or software prefetch. Note: In t=
he L1D, a Demand Read contains cacheable or noncacheable demand loads, incl=
uding ones causing cache-line splits and reads due to page walks resulted f=
rom any request type.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Cycles with L1D load Misses outstanding.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING_CYCLES",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts duration of L1D miss outstanding in c=
ycles.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "L2 cache lines filling L2",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.ALL",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of L2 cache lines filling =
the L2. Counting does not cover rejects.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1f"
     },
     {
         "BriefDescription": "Modified cache lines that are evicted by L2 c=
ache when triggered by an L2 cache fill.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.NON_SILENT",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of lines that are evicted =
by L2 cache when triggered by an L2 cache fill. Those lines are in Modified=
 state. Modified lines are written back to L3",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Non-modified cache lines that are silently dr=
opped by L2 cache when triggered by an L2 cache fill.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.SILENT",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of lines that are silently=
 dropped by L2 cache when triggered by an L2 cache fill. These lines are ty=
pically in Shared or Exclusive state. A non-threaded event.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Cache lines that have been L2 hardware prefet=
ched but not used by demand accesses",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xf2",
         "EventName": "L2_LINES_OUT.USELESS_HWPF",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of cache lines that have b=
een prefetched by the L2 hardware prefetcher but not used by demand access =
when evicted from the L2 cache",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "L2 code requests",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_CODE_RD",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the total number of L2 code requests.=
",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0xe4"
     },
     {
         "BriefDescription": "Demand Data Read requests",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of demand Data Read reques=
ts (including requests from L1D hardware prefetchers). These loads may hit =
or miss L2 cache. Only non rejected loads are counted.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0xe1"
     },
     {
         "BriefDescription": "Demand requests that miss L2 cache",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_MISS",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts demand requests that miss L2 cache.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x27"
     },
     {
         "BriefDescription": "Demand requests to L2 cache",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_REFERENCES",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts demand requests to L2 cache.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0xe7"
     },
     {
         "BriefDescription": "RFO requests to L2 cache",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_RFO",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the total number of RFO (read for own=
ership) requests to L2 cache. L2 RFO requests include both L1D demand RFO m=
isses as well as L1D RFO prefetches.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0xe2"
     },
     {
         "BriefDescription": "L2 cache hits when fetching instructions, cod=
e reads.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_HIT",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts L2 cache hits when fetching instructi=
ons, code reads.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0xc4"
     },
     {
         "BriefDescription": "L2 cache misses when fetching instructions",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_MISS",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts L2 cache misses when fetching instruc=
tions.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x24"
     },
     {
         "BriefDescription": "Demand Data Read requests that hit L2 cache",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of demand Data Read reques=
ts initiated by load instructions that hit L2 cache.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0xc1"
     },
     {
         "BriefDescription": "Demand Data Read miss L2, no rejects",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of demand Data Read reques=
ts that miss L2 cache. Only not rejected loads are counted.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x21"
     },
     {
         "BriefDescription": "RFO requests that hit L2 cache",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_HIT",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that hit L2 cache.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0xc2"
     },
     {
         "BriefDescription": "RFO requests that miss L2 cache",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_MISS",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that miss L2 cache.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x22"
     },
     {
         "BriefDescription": "SW prefetch requests that hit L2 cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.SWPF_HIT",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts Software prefetch requests that hit t=
he L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when =
FB is not full.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0xc8"
     },
     {
         "BriefDescription": "SW prefetch requests that miss L2 cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.SWPF_MISS",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts Software prefetch requests that miss =
the L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when=
 FB is not full.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x28"
     },
     {
         "BriefDescription": "L2 writebacks that access L2 cache",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xF0",
         "EventName": "L2_TRANS.L2_WB",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts L2 writebacks that access L2 cache.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x40"
     },
     {
         "BriefDescription": "Core-originated cacheable requests that misse=
d L3  (Except hardware prefetches to the L3)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.MISS",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts core-originated cacheable requests th=
at miss the L3 cache (Longest Latency cache). Requests include data and cod=
e reads, Reads-for-Ownership (RFOs), speculative accesses and hardware pref=
etches to the L1 and L2.  It does not include hardware prefetches to the L3=
, and may not count other types of requests to the L3.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x41"
     },
     {
         "BriefDescription": "Retired load instructions.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_LOADS",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts all retired load instructions. This e=
vent accounts for SW prefetch instructions of PREFETCHNTA or PREFETCHT0/1/2=
 or PREFETCHW.",
         "SampleAfterValue": "1000003",
         "UMask": "0x81"
     },
     {
         "BriefDescription": "Retired store instructions.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_STORES",
-        "L1_Hit_Indication": "1",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts all retired store instructions.",
         "SampleAfterValue": "1000003",
         "UMask": "0x82"
     },
     {
         "BriefDescription": "All retired memory instructions.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ANY",
-        "L1_Hit_Indication": "1",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts all retired memory instructions - loa=
ds and stores.",
         "SampleAfterValue": "1000003",
         "UMask": "0x83"
     },
     {
         "BriefDescription": "Retired load instructions with locked access.=
",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.LOCK_LOADS",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts retired load instructions with locked=
 access.",
         "SampleAfterValue": "100007",
         "UMask": "0x21"
     },
     {
         "BriefDescription": "Retired load instructions that split across a=
 cacheline boundary.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.SPLIT_LOADS",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts retired load instructions that split =
across a cacheline boundary.",
         "SampleAfterValue": "100003",
         "UMask": "0x41"
     },
     {
         "BriefDescription": "Retired store instructions that split across =
a cacheline boundary.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.SPLIT_STORES",
-        "L1_Hit_Indication": "1",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts retired store instructions that split=
 across a cacheline boundary.",
         "SampleAfterValue": "100003",
         "UMask": "0x42"
     },
     {
         "BriefDescription": "Retired load instructions that miss the STLB.=
",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_MISS_LOADS",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Number of retired load instructions that (st=
art a) miss in the 2nd-level TLB (STLB).",
         "SampleAfterValue": "100003",
         "UMask": "0x11"
     },
     {
         "BriefDescription": "Retired store instructions that miss the STLB=
.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_MISS_STORES",
-        "L1_Hit_Indication": "1",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Number of retired store instructions that (s=
tart a) miss in the 2nd-level TLB (STLB).",
         "SampleAfterValue": "100003",
         "UMask": "0x12"
     },
     {
         "BriefDescription": "Retired load instructions whose data sources =
were L3 and cross-core snoop hits in on-pkg core cache",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts retired load instructions whose data =
sources were L3 and cross-core snoop hits in on-pkg core cache.",
         "SampleAfterValue": "20011",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Retired load instructions whose data sources =
were HitM responses from shared L3",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts retired load instructions whose data =
sources were HitM responses from shared L3.",
         "SampleAfterValue": "20011",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Retired load instructions whose data sources =
were L3 hit and cross-core snoop missed in on-pkg core cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the retired load instructions whose d=
ata sources were L3 hit and cross-core snoop missed in on-pkg core cache.",
         "SampleAfterValue": "20011",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired load instructions whose data sources =
were hits in L3 without snoops required",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NONE",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts retired load instructions whose data =
sources were hits in L3 without snoops required.",
         "SampleAfterValue": "100003",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Number of completed demand load requests that=
 missed the L1, but hit the FB(fill buffer), because a preceding miss to th=
e same cacheline initiated the line to be brought into L1, but data is not =
yet ready in L1.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.FB_HIT",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop was load missed in L1 but hit FB (Fill Buffers) due to preceding=
 miss to the same cache line with data not ready.",
         "SampleAfterValue": "100007",
         "UMask": "0x40"
     },
     {
         "BriefDescription": "Retired load instructions with L1 cache hits =
as data sources",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L1_HIT",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L1 data cache. This event includes all SW prefet=
ches and lock instructions regardless of the data source.",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired load instructions missed L1 cache as =
data sources",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L1_MISS",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L1 cache.",
         "SampleAfterValue": "200003",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Retired load instructions with L2 cache hits =
as data sources",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L2_HIT",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts retired load instructions with L2 cac=
he hits as data sources.",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Retired load instructions missed L2 cache as =
data sources",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L2_MISS",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts retired load instructions missed L2 c=
ache as data sources.",
         "SampleAfterValue": "100021",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Retired load instructions with L3 cache hits =
as data sources",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L3_HIT",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L3 cache.",
         "SampleAfterValue": "100021",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Retired load instructions missed L3 cache as =
data sources",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L3_MISS",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L3 cache.",
         "SampleAfterValue": "50021",
         "UMask": "0x20"
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit a cacheline in the L3 where a snoop was s=
ent or not.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC03C0004",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit a cacheline in the L3 where a snoop hit i=
n another cores caches, data forwarding is required as the data is modified=
.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0004",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit a cacheline in the L3 where a snoop hit i=
n another core, data forwarding is not required.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0004",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit a cacheline in the L3 where a snoop was s=
ent but no other cores had the data.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0004",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit a cacheline in the L3 where a snoop was n=
ot needed to satisfy the request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0004",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit a cacheline in the L3 where a snoop was s=
ent.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_SENT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1E003C0004",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that hit a cacheline=
 in the L3 where a snoop was sent or not.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC03C0001",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that hit a cacheline=
 in the L3 where a snoop hit in another cores caches, data forwarding is re=
quired as the data is modified.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0001",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that hit a cacheline=
 in the L3 where a snoop hit in another core, data forwarding is not requir=
ed.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0001",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that hit a cacheline=
 in the L3 where a snoop was sent but no other cores had the data.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0001",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that hit a cacheline=
 in the L3 where a snoop was not needed to satisfy the request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0001",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that hit a cacheline=
 in the L3 where a snoop was sent.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_SENT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1E003C0001",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit a =
cacheline in the L3 where a snoop was sent or not.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_RFO.L3_HIT.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC03C0002",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit a =
cacheline in the L3 where a snoop hit in another cores caches, data forward=
ing is required as the data is modified.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0002",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit a =
cacheline in the L3 where a snoop hit in another core, data forwarding is n=
ot required.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0002",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit a =
cacheline in the L3 where a snoop was sent but no other cores had the data.=
",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0002",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit a =
cacheline in the L3 where a snoop was not needed to satisfy the request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0002",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit a =
cacheline in the L3 where a snoop was sent.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_SENT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1E003C0002",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L1 data cache prefetch requests and so=
ftware prefetches (except PREFETCHW) that hit a cacheline in the L3 where a=
 snoop was sent or not.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L1D_AND_SWPF.L3_HIT.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC03C0400",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L1 data cache prefetch requests and so=
ftware prefetches (except PREFETCHW) that hit a cacheline in the L3 where a=
 snoop was sent but no other cores had the data.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L1D_AND_SWPF.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0400",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L1 data cache prefetch requests and so=
ftware prefetches (except PREFETCHW) that hit a cacheline in the L3 where a=
 snoop was not needed to satisfy the request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L1D_AND_SWPF.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0400",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts hardware prefetch data reads (which br=
ing data to L2)  that hit a cacheline in the L3 where a snoop was sent or n=
ot.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC03C0010",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts hardware prefetch data reads (which br=
ing data to L2)  that hit a cacheline in the L3 where a snoop hit in anothe=
r cores caches, data forwarding is required as the data is modified.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0010",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts hardware prefetch data reads (which br=
ing data to L2)  that hit a cacheline in the L3 where a snoop hit in anothe=
r core, data forwarding is not required.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0010",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts hardware prefetch data reads (which br=
ing data to L2)  that hit a cacheline in the L3 where a snoop was sent but =
no other cores had the data.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0010",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts hardware prefetch data reads (which br=
ing data to L2)  that hit a cacheline in the L3 where a snoop was not neede=
d to satisfy the request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0010",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts hardware prefetch data reads (which br=
ing data to L2)  that hit a cacheline in the L3 where a snoop was sent.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_SENT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1E003C0010",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts hardware prefetch RFOs (which bring da=
ta to L2) that hit a cacheline in the L3 where a snoop was sent or not.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L2_RFO.L3_HIT.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC03C0020",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts hardware prefetch RFOs (which bring da=
ta to L2) that hit a cacheline in the L3 where a snoop hit in another cores=
 caches, data forwarding is required as the data is modified.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0020",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts hardware prefetch RFOs (which bring da=
ta to L2) that hit a cacheline in the L3 where a snoop hit in another core,=
 data forwarding is not required.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0020",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts hardware prefetch RFOs (which bring da=
ta to L2) that hit a cacheline in the L3 where a snoop was sent but no othe=
r cores had the data.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0020",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts hardware prefetch RFOs (which bring da=
ta to L2) that hit a cacheline in the L3 where a snoop was not needed to sa=
tisfy the request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0020",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts hardware prefetch RFOs (which bring da=
ta to L2) that hit a cacheline in the L3 where a snoop was sent.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_SENT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1E003C0020",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts hardware prefetches to the L3 only tha=
t hit a cacheline in the L3 where a snoop was sent or not.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L3.L3_HIT.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC03C2380",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts miscellaneous requests, such as I/O an=
d un-cacheable accesses that hit a cacheline in the L3 where a snoop hit in=
 another core, data forwarding is not required.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.OTHER.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C8000",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts miscellaneous requests, such as I/O an=
d un-cacheable accesses that hit a cacheline in the L3 where a snoop was se=
nt but no other cores had the data.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.OTHER.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C8000",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts miscellaneous requests, such as I/O an=
d un-cacheable accesses that hit a cacheline in the L3 where a snoop was no=
t needed to satisfy the request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.OTHER.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C8000",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts miscellaneous requests, such as I/O an=
d un-cacheable accesses that hit a cacheline in the L3 where a snoop was se=
nt.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.OTHER.L3_HIT.SNOOP_SENT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1E003C8000",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts streaming stores that hit a cacheline =
in the L3 where a snoop was sent or not.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.STREAMING_WR.L3_HIT.ANY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC03C0800",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Demand and prefetch data reads",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.ALL_DATA_RD",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the demand and prefetch data reads. A=
ll Core Data Reads include cacheable 'Demands' and L2 prefetchers (not L3 p=
refetchers). Counting also covers reads due to page walks resulted from any=
 request type.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Counts memory transactions sent to the uncore=
.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.ALL_REQUESTS",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts memory transactions sent to the uncor=
e including requests initiated by the core, all L3 prefetches, reads result=
ing from page walks, and snoop responses.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x80"
     },
     {
         "BriefDescription": "Demand Data Read requests sent to uncore",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb0",
         "EventName": "OFFCORE_REQUESTS.DEMAND_DATA_RD",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the Demand Data Read requests sent to=
 uncore. Use it in conjunction with OFFCORE_REQUESTS_OUTSTANDING to determi=
ne average latency in the uncore.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Demand RFO requests including regular RFOs, l=
ocks, ItoM",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb0",
         "EventName": "OFFCORE_REQUESTS.DEMAND_RFO",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the demand RFO (read for ownership) r=
equests including regular RFOs, locks, ItoM.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "For every cycle, increments by the number of =
outstanding data read requests pending.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "For every cycle, increments by the number of=
 outstanding data read requests pending.  Data read requests include cachea=
ble demand reads and L2 prefetches, but do not include RFOs, code reads or =
prefetches to the L3.  Reads due to page walks resulting from any request t=
ype will also be counted.  Requests are considered outstanding from the tim=
e they miss the core's L2 cache until the transaction completion message is=
 sent to the requestor.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Cycles where at least 1 outstanding data read=
 request is pending.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Cycles where at least 1 outstanding data rea=
d request is pending.  Data read requests include cacheable demand reads an=
d L2 prefetches, but do not include RFOs, code reads or prefetches to the L=
3.  Reads due to page walks resulting from any request type will also be co=
unted.  Requests are considered outstanding from the time they miss the cor=
e's L2 cache until the transaction completion message is sent to the reques=
tor.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Cycles where at least 1 outstanding Demand RF=
O request is pending.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO"=
,
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Cycles where at least 1 outstanding Demand R=
FO request is pending.   RFOs are initiated by a core as part of a data sto=
re operation.  Demand RFO requests include RFOs, locks, and ItoM transactio=
ns.  Requests are considered outstanding from the time they miss the core's=
 L2 cache until the transaction completion message is sent to the requestor=
.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "For every cycle, increments by the number of =
outstanding demand data read requests pending.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "For every cycle, increments by the number of=
 outstanding demand data read requests pending.   Requests are considered o=
utstanding from the time they miss the core's L2 cache until the transactio=
n completion message is sent to the requestor.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Store Read transactions pending for off-core.=
 Highly correlated.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_RFO",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of off-core outstanding re=
ad-for-ownership (RFO) store transactions every cycle. An RFO transaction i=
s considered to be in the Off-core outstanding state between L2 cache miss =
and transaction completion.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Cycles the queue waiting for offcore response=
s is full.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xf4",
         "EventName": "SQ_MISC.SQ_FULL",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the cycles for which the thread is ac=
tive and the queue waiting for responses from the uncore cannot take any mo=
re entries.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Number of PREFETCHNTA instructions executed."=
,
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "SW_PREFETCH_ACCESS.NTA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of PREFETCHNTA instruction=
s executed.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Number of PREFETCHW instructions executed.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of PREFETCHW instructions =
executed.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Number of PREFETCHT0 instructions executed.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "SW_PREFETCH_ACCESS.T0",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of PREFETCHT0 instructions=
 executed.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Number of PREFETCHT1 or PREFETCHT2 instructio=
ns executed.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "SW_PREFETCH_ACCESS.T1_T2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT=
2 instructions executed.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x4"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/icelake/floating-point.json b/t=
ools/perf/pmu-events/arch/x86/icelake/floating-point.json
index 1925388969bb..655342dadac6 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/floating-point.json
@@ -1,100 +1,72 @@
 [
     {
         "BriefDescription": "Counts all microcode FP assists.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.FP",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts all microcode Floating Point assists.=
",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts number of SSE/AVX computational 128-bi=
t packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 2 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed double =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice =
as they perform 2 calculations per element.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 2 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as the=
y perform 2 calculations per element. The DAZ and FTZ flags in the MXCSR re=
gister need to be set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d single precision floating-point instructions retired; some instructions w=
ill count twice as noted below.  Each count represents 4 computation operat=
ions, one for each element.  Applies to SSE* and AVX* packed single precisi=
on floating-point instructions: ADD SUB MUL DIV MIN MAX RCP14 RSQRT14 SQRT =
DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they pe=
rform 2 calculations per element.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Counts number of SSE/AVX computational 256-bi=
t packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 4 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed double =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perf=
orm 2 calculations per element.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perform 2 =
calculations per element. The DAZ and FTZ flags in the MXCSR register need =
to be set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Counts number of SSE/AVX computational 256-bi=
t packed single precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 8 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed single =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions co=
unt twice as they perform 2 calculations per element.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 8 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x20"
     },
     {
         "BriefDescription": "Counts number of SSE/AVX computational 512-bi=
t packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 8 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed double =
precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14=
 RCP14 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform =
2 calculations per element.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of SSE/AVX computational 512-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 8 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14 RCP14=
 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform 2 calc=
ulations per element. The DAZ and FTZ flags in the MXCSR register need to b=
e set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x40"
     },
     {
         "BriefDescription": "Counts number of SSE/AVX computational 512-bi=
t packed single precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 16 computatio=
n operations, one for each element.  Applies to SSE* and AVX* packed single=
 precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT1=
4 RCP14 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform=
 2 calculations per element.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of SSE/AVX computational 512-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 16 computation oper=
ations, one for each element.  Applies to SSE* and AVX* packed single preci=
sion floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14 RCP1=
4 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform 2 cal=
culations per element. The DAZ and FTZ flags in the MXCSR register need to =
be set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x80"
     },
     {
         "BriefDescription": "Counts number of SSE/AVX computational scalar=
 double precision floating-point instructions retired; some instructions wi=
ll count twice as noted below.  Each count represents 1 computational opera=
tion. Applies to SSE* and AVX* scalar double precision floating-point instr=
uctions: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructi=
ons count twice as they perform 2 calculations per element.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR_DOUBLE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of SSE/AVX computational scalar doubl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar double precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions co=
unt twice as they perform 2 calculations per element. The DAZ and FTZ flags=
 in the MXCSR register need to be set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts number of SSE/AVX computational scalar=
 single precision floating-point instructions retired; some instructions wi=
ll count twice as noted below.  Each count represents 1 computational opera=
tion. Applies to SSE* and AVX* scalar single precision floating-point instr=
uctions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB=
 instructions count twice as they perform 2 calculations per element.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR_SINGLE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar single precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB instr=
uctions count twice as they perform 2 calculations per element. The DAZ and=
 FTZ flags in the MXCSR register need to be set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
diff --git a/tools/perf/pmu-events/arch/x86/icelake/frontend.json b/tools/p=
erf/pmu-events/arch/x86/icelake/frontend.json
index 739361d3f52f..3e3d2b002170 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/frontend.json
@@ -1,497 +1,353 @@
 [
     {
         "BriefDescription": "Counts the total number when the front end is=
 resteered, mainly when the BPU cannot provide a correct prediction and thi=
s is corrected by other branch handling mechanisms at the front end.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xe6",
         "EventName": "BACLEARS.ANY",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of times the front-end is =
resteered when it finds a branch instruction in a fetch line. This occurs f=
or the first time a branch instruction is fetched or when the branch is not=
 tracked by the BPU (Branch Prediction Unit) anymore.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Decode Stream Buffer (DSB)-to-MITE transition=
s count.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0xab",
         "EventName": "DSB2MITE_SWITCHES.COUNT",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of Decode Stream Buffer (D=
SB a.k.a. Uop Cache)-to-MITE speculative transitions.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "DSB-to-MITE switch true penalty cycles.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xab",
         "EventName": "DSB2MITE_SWITCHES.PENALTY_CYCLES",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Decode Stream Buffer (DSB) is a Uop-cache th=
at holds translations of previously fetched instructions that were decoded =
by the legacy x86 decode pipeline (MITE). This event counts fetch penalty c=
ycles when a transition occurs from DSB to MITE.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Retired Instructions who experienced DSB miss=
.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.ANY_DSB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x1",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts retired Instructions that experienced=
 DSB (Decode stream buffer i.e. the decoded instruction-cache) miss.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired Instructions who experienced a critic=
al DSB miss.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.DSB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x11",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of retired Instructions that experien=
ced a critical DSB (Decode stream buffer i.e. the decoded instruction-cache=
) miss. Critical means stalls were exposed to the back-end as a result of t=
he DSB miss.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired Instructions who experienced iTLB tru=
e miss.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.ITLB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x14",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts retired Instructions that experienced=
 iTLB (Instruction TLB) true miss.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired Instructions who experienced Instruct=
ion L1 Cache true miss.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.L1I_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x12",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts retired Instructions who experienced =
Instruction L1 Cache true miss.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired Instructions who experienced Instruct=
ion L2 Cache true miss.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.L2_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x13",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts retired Instructions who experienced =
Instruction L2 Cache true miss.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired instructions after front-end starvati=
on of at least 1 cycle",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_1",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x500106",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
1 cycle which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 128 cycles=
 which was not interrupted by a back-end stall.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_128",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x508006",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 12=
8 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 16 cycles =
which was not interrupted by a back-end stall.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_16",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x501006",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 16 cycles. During th=
is period the front-end delivered no uops.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired instructions after front-end starvati=
on of at least 2 cycles",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_2",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x500206",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
2 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 256 cycles=
 which was not interrupted by a back-end stall.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_256",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x510006",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 25=
6 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end had at least 1 bubble-slot for a period of 2=
 cycles which was not interrupted by a back-end stall.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x100206",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after the front-end had at least 1 bubble-slot for a per=
iod of 2 cycles. A bubble-slot is an empty issue-pipeline slot while there =
was no RAT stall.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 32 cycles =
which was not interrupted by a back-end stall.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_32",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x502006",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 32 cycles. During th=
is period the front-end delivered no uops.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 4 cycles w=
hich was not interrupted by a back-end stall.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_4",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x500406",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 4 =
cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 512 cycles=
 which was not interrupted by a back-end stall.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_512",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x520006",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 51=
2 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 64 cycles =
which was not interrupted by a back-end stall.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_64",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x504006",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 64=
 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 8 cycles w=
hich was not interrupted by a back-end stall.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_8",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x500806",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 8 cycles. During thi=
s period the front-end delivered no uops.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired Instructions who experienced STLB (2n=
d level TLB) true miss.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.STLB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x15",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts retired Instructions that experienced=
 STLB (2nd level TLB) true miss.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache miss.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "ICACHE_16B.IFDATA_STALL",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts cycles where a code line fetch is sta=
lled due to an L1 instruction cache miss. The legacy decode pipeline works =
at a 16 Byte granularity.",
         "SampleAfterValue": "500009",
-        "Speculative": "1",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Instruction fetch tag lookups that hit in the=
 instruction cache (L1I). Counts at 64-byte cache-line granularity.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "ICACHE_64B.IFTAG_HIT",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts instruction fetch tag lookups that hi=
t in the instruction cache (L1I). Counts at 64-byte cache-line granularity.=
 Accounts for both cacheable and uncacheable accesses.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Instruction fetch tag lookups that miss in th=
e instruction cache (L1I). Counts at 64-byte cache-line granularity.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "ICACHE_64B.IFTAG_MISS",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts instruction fetch tag lookups that mi=
ss in the instruction cache (L1I). Counts at 64-byte cache-line granularity=
. Accounts for both cacheable and uncacheable accesses.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache tag miss.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "ICACHE_64B.IFTAG_STALL",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts cycles where a code fetch is stalled =
due to L1 instruction cache tag miss.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng any Uop",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES_ANY",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of cycles uops were delive=
red to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) p=
ath.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Cycles DSB is delivering optimal number of Uo=
ps",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "5",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES_OK",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the M=
ITE (legacy decode pipeline) path. During these cycles uops are not being d=
elivered from the Decode Stream Buffer (DSB).",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from the Decode Stream Buffer (DSB) path",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_UOPS",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Cycles MITE is delivering any Uop",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_CYCLES_ANY",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of cycles uops were delive=
red to the Instruction Decode Queue (IDQ) from the MITE (legacy decode pipe=
line) path. During these cycles uops are not being delivered from the Decod=
e Stream Buffer (DSB).",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Cycles MITE is delivering optimal number of U=
ops",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "5",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_CYCLES_OK",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the M=
ITE (legacy decode pipeline) path. During these cycles uops are not being d=
elivered from the Decode Stream Buffer (DSB).",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from MITE path",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_UOPS",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the MITE path. This also means that uops are=
 not being delivered from the Decode Stream Buffer (DSB).",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Cycles when uops are being delivered to IDQ w=
hile MS is busy",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_CYCLES_ANY",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts cycles during which uops are being de=
livered to Instruction Decode Queue (IDQ) while the Microcode Sequencer (MS=
) is busy. Uops maybe initiated by Decode Stream Buffer (DSB) or MITE.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x30"
     },
     {
         "BriefDescription": "Number of switches from DSB or MITE to the MS=
",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_SWITCHES",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Number of switches from DSB (Decode Stream B=
uffer) or MITE (legacy decode pipeline) to the Microcode Sequencer.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x30"
     },
     {
         "BriefDescription": "Uops delivered to IDQ while MS is busy",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_UOPS",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the total number of uops delivered by=
 the Microcode Sequencer (MS). Any instruction over 4 uops will be delivere=
d by the MS. Some instructions such as transcendentals may additionally gen=
erate uops from the MS.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x30"
     },
     {
         "BriefDescription": "Uops not delivered by IDQ when backend of the=
 machine is not stalled",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Cycles when no uops are not delivered by the =
IDQ when backend of the machine is not stalled",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "5",
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Cycles when optimal number of uops was delive=
red to the back-end when the back-end is not stalled",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x9C",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK",
         "Invert": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x1"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json b/tool=
s/perf/pmu-events/arch/x86/icelake/icl-metrics.json
index 3b5ef09eb8ef..2ad36e00d289 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
@@ -41,7 +41,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Branch Misprediction=
 at execution stage",
-        "MetricExpr": "(BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRED.AL=
L_BRANCHES + MACHINE_CLEARS.COUNT)) * INT_MISC.CLEAR_RESTEER_CYCLES / CLKS"=
,
+        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRED.ALL=
_BRANCHES + MACHINE_CLEARS.COUNT) * INT_MISC.CLEAR_RESTEER_CYCLES / CLKS",
         "MetricGroup": "BadSpec;BrMispredicts;TopdownL4;tma_branch_resteer=
s_group",
         "MetricName": "tma_mispredicts_resteers",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage.  Sample with: INT_MISC.CLEAR_RESTEER_CYCLES",
@@ -49,7 +49,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Machine Clears",
-        "MetricExpr": "(1 - (BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIR=
ED.ALL_BRANCHES + MACHINE_CLEARS.COUNT))) * INT_MISC.CLEAR_RESTEER_CYCLES /=
 CLKS",
+        "MetricExpr": "(1 - BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRE=
D.ALL_BRANCHES + MACHINE_CLEARS.COUNT)) * INT_MISC.CLEAR_RESTEER_CYCLES / C=
LKS",
         "MetricGroup": "BadSpec;MachineClears;TopdownL4;tma_branch_resteer=
s_group",
         "MetricName": "tma_clears_resteers",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Machine Clears.  Sa=
mple with: INT_MISC.CLEAR_RESTEER_CYCLES",
@@ -143,7 +143,7 @@
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
@@ -159,7 +159,7 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
-        "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + (5 * cpu@IN=
T_MISC.RECOVERY_CYCLES\\,cmask\\=3D1\\,edge@) / SLOTS",
+        "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 5 * cpu@INT=
_MISC.RECOVERY_CYCLES\\,cmask\\=3D1\\,edge@ / SLOTS",
         "MetricGroup": "TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
@@ -167,7 +167,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
-        "MetricExpr": "((CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.BOUN=
D_ON_STORES) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UTIL + =
tma_retiring * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) =
* tma_backend_bound",
+        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.BOUND=
_ON_STORES) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UTIL + t=
ma_retiring * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES) * =
tma_backend_bound",
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
@@ -213,7 +213,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
-        "MetricExpr": "(16 * max(0, MEM_INST_RETIRED.LOCK_LOADS - L2_RQSTS=
.ALL_RFO) + (MEM_INST_RETIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES) * (=
10 * L2_RQSTS.RFO_HIT + min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DEMAND_RFO))) / CLKS",
+        "MetricExpr": "(16 * max(0, MEM_INST_RETIRED.LOCK_LOADS - L2_RQSTS=
.ALL_RFO) + MEM_INST_RETIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES * (10=
 * L2_RQSTS.RFO_HIT + min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTAN=
DING.CYCLES_WITH_DEMAND_RFO))) / CLKS",
         "MetricGroup": "Offcore;TopdownL4;tma_l1_bound_group",
         "MetricName": "tma_lock_latency",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them. Sample with: MEM_INST_RETIRED.LOCK_LOA=
DS_PS",
@@ -245,7 +245,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads",
-        "MetricExpr": "((MEM_LOAD_RETIRED.L2_HIT * (1 + (MEM_LOAD_RETIRED.=
FB_HIT / MEM_LOAD_RETIRED.L1_MISS))) / ((MEM_LOAD_RETIRED.L2_HIT * (1 + (ME=
M_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))) + L1D_PEND_MISS.FB_FULL=
_PERIODS)) * ((CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MI=
SS) / CLKS)",
+        "MetricExpr": "MEM_LOAD_RETIRED.L2_HIT * (1 + MEM_LOAD_RETIRED.FB_=
HIT / MEM_LOAD_RETIRED.L1_MISS) / (MEM_LOAD_RETIRED.L2_HIT * (1 + MEM_LOAD_=
RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + L1D_PEND_MISS.FB_FULL_PERIODS)=
 * ((CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / CLKS=
)",
         "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_mem=
ory_bound_group",
         "MetricName": "tma_l2_bound",
         "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_RETIRED.L2_HIT_PS",
@@ -261,7 +261,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
-        "MetricExpr": "((29 * Average_Frequency) * MEM_LOAD_L3_HIT_RETIRED=
.XSNP_HITM + (23.5 * Average_Frequency) * MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS=
) * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) / 2) / CLKS",
+        "MetricExpr": "(29 * Average_Frequency * MEM_LOAD_L3_HIT_RETIRED.X=
SNP_HITM + 23.5 * Average_Frequency * MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS) * =
(1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / CLKS",
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
@@ -269,7 +269,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
-        "MetricExpr": "(23.5 * Average_Frequency) * MEM_LOAD_L3_HIT_RETIRE=
D.XSNP_HIT * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) / 2)=
 / CLKS",
+        "MetricExpr": "23.5 * Average_Frequency * MEM_LOAD_L3_HIT_RETIRED.=
XSNP_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / C=
LKS",
         "MetricGroup": "Offcore;Snoop;TopdownL4;tma_l3_bound_group",
         "MetricName": "tma_data_sharing",
         "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_L3_HIT_RETIRED.XSNP_HIT_PS",
@@ -277,7 +277,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited)",
-        "MetricExpr": "(9 * Average_Frequency) * MEM_LOAD_RETIRED.L3_HIT *=
 (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) / 2) / CLKS",
+        "MetricExpr": "9 * Average_Frequency * MEM_LOAD_RETIRED.L3_HIT * (=
1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / CLKS",
         "MetricGroup": "MemoryLat;TopdownL4;tma_l3_bound_group",
         "MetricName": "tma_l3_hit_latency",
         "PublicDescription": "This metric represents fraction of cycles wi=
th demand load accesses that hit the L3 cache under unloaded scenarios (pos=
sibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L=
3 hits) will improve the latency; reduce contention with sibling physical c=
ores and increase performance.  Note the value of this node may overlap wit=
h its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS",
@@ -293,7 +293,7 @@
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
-        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L3_MISS / CLKS + ((CYCLE_ACT=
IVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / CLKS) - tma_l2_bou=
nd)",
+        "MetricExpr": "CYCLE_ACTIVITY.STALLS_L3_MISS / CLKS + (CYCLE_ACTIV=
ITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / CLKS - tma_l2_bound"=
,
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_memory_bound_gr=
oup",
         "MetricName": "tma_dram_bound",
         "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_RETIRED=
.L3_MISS_PS",
@@ -325,7 +325,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
-        "MetricExpr": "((L2_RQSTS.RFO_HIT * 10 * (1 - (MEM_INST_RETIRED.LO=
CK_LOADS / MEM_INST_RETIRED.ALL_STORES))) + (1 - (MEM_INST_RETIRED.LOCK_LOA=
DS / MEM_INST_RETIRED.ALL_STORES)) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_R=
EQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / CLKS",
+        "MetricExpr": "(L2_RQSTS.RFO_HIT * 10 * (1 - MEM_INST_RETIRED.LOCK=
_LOADS / MEM_INST_RETIRED.ALL_STORES) + (1 - MEM_INST_RETIRED.LOCK_LOADS / =
MEM_INST_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUEST=
S_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / CLKS",
         "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_store_bound_group"=
,
         "MetricName": "tma_store_latency",
         "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full)",
@@ -333,7 +333,7 @@
     },
     {
         "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
-        "MetricExpr": "(32.5 * Average_Frequency) * OCR.DEMAND_RFO.L3_HIT.=
SNOOP_HITM / CLKS",
+        "MetricExpr": "32.5 * Average_Frequency * OCR.DEMAND_RFO.L3_HIT.SN=
OOP_HITM / CLKS",
         "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_store_boun=
d_group",
         "MetricName": "tma_false_sharing",
         "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line.  Sample with: OCR.DEMAND_RFO.=
L3_HIT.SNOOP_HITM",
@@ -395,7 +395,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
-        "MetricExpr": "(cpu@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x80@ + =
(EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * EXE_ACTIVITY.2_PORTS_UTIL)) / C=
LKS if (ARITH.DIVIDER_ACTIVE < (CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVIT=
Y.STALLS_MEM_ANY)) else (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * EXE_ACT=
IVITY.2_PORTS_UTIL) / CLKS",
+        "MetricExpr": "((cpu@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x80@ +=
 (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * EXE_ACTIVITY.2_PORTS_UTIL)) / =
CLKS if ARITH.DIVIDER_ACTIVE < CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY=
.STALLS_MEM_ANY else (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * EXE_ACTIVI=
TY.2_PORTS_UTIL) / CLKS)",
         "MetricGroup": "PortsUtil;TopdownL3;tma_core_bound_group",
         "MetricName": "tma_ports_utilization",
         "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations.",
@@ -508,7 +508,7 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
-        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0*SLOTS",
+        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * SLOTS",
         "MetricGroup": "TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided.  Sample with: UOPS_RETIRE=
D.SLOTS",
@@ -625,7 +625,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU was retiring uops fetched by the Microcode Sequencer (MS) unit",
-        "MetricExpr": "((tma_retiring * SLOTS) / UOPS_ISSUED.ANY) * IDQ.MS=
_UOPS / SLOTS",
+        "MetricExpr": "tma_retiring * SLOTS / UOPS_ISSUED.ANY * IDQ.MS_UOP=
S / SLOTS",
         "MetricGroup": "MicroSeq;TopdownL3;tma_heavy_operations_group",
         "MetricName": "tma_microcode_sequencer",
         "PublicDescription": "This metric represents fraction of slots the=
 CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The M=
S is used for CISC instructions not supported by the default decoders (like=
 repeat move strings; or CPUID); or by microcode assists used to address so=
me operation modes (like in Floating Point assists). These cases can often =
be avoided. Sample with: IDQ.MS_UOPS",
@@ -655,19 +655,19 @@
     },
     {
         "BriefDescription": "Total pipeline cost of (external) Memory Band=
width related bottlenecks",
-        "MetricExpr": "100 * tma_memory_bound * ((tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + (tma_l3_boun=
d / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_stor=
e_bound)) * (tma_sq_full / (tma_contested_accesses + tma_data_sharing + tma=
_l3_hit_latency + tma_sq_full))) + (tma_l1_bound / (tma_dram_bound + tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_fb_full / (=
tma_4k_aliasing + tma_dtlb_load + tma_fb_full + tma_lock_latency + tma_spli=
t_loads + tma_store_fwd_blk)) ",
+        "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (=
tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_l3_bound /=
 (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_b=
ound) * (tma_sq_full / (tma_contested_accesses + tma_data_sharing + tma_l3_=
hit_latency + tma_sq_full))) + tma_l1_bound / (tma_dram_bound + tma_l1_boun=
d + tma_l2_bound + tma_l3_bound + tma_store_bound) * (tma_fb_full / (tma_4k=
_aliasing + tma_dtlb_load + tma_fb_full + tma_lock_latency + tma_split_load=
s + tma_store_fwd_blk))",
         "MetricGroup": "Mem;MemoryBW;Offcore",
         "MetricName": "Memory_Bandwidth"
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Latency related=
 bottlenecks (external memory and off-core caches)",
-        "MetricExpr": "100 * tma_memory_bound * ((tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + (tma_l3_bound =
/ (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_=
bound)) * (tma_l3_hit_latency / (tma_contested_accesses + tma_data_sharing =
+ tma_l3_hit_latency + tma_sq_full)) + (tma_l2_bound / (tma_dram_bound + tm=
a_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)))",
+        "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (=
tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_l3_bound / (=
tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bou=
nd) * (tma_l3_hit_latency / (tma_contested_accesses + tma_data_sharing + tm=
a_l3_hit_latency + tma_sq_full)) + tma_l2_bound / (tma_dram_bound + tma_l1_=
bound + tma_l2_bound + tma_l3_bound + tma_store_bound))",
         "MetricGroup": "Mem;MemoryLat;Offcore",
         "MetricName": "Memory_Latency"
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
-        "MetricExpr": "100 * tma_memory_bound * ((tma_l1_bound / max(tma_m=
emory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + =
tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, tma_4k_aliasing + tm=
a_dtlb_load + tma_fb_full + tma_lock_latency + tma_split_loads + tma_store_=
fwd_blk)) + (tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_boun=
d + tma_l3_bound + tma_store_bound)) * (tma_dtlb_store / (tma_dtlb_store + =
tma_false_sharing + tma_split_stores + tma_store_latency + tma_streaming_st=
ores))) ",
+        "MetricExpr": "100 * tma_memory_bound * (tma_l1_bound / max(tma_me=
mory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + t=
ma_store_bound) * (tma_dtlb_load / max(tma_l1_bound, tma_4k_aliasing + tma_=
dtlb_load + tma_fb_full + tma_lock_latency + tma_split_loads + tma_store_fw=
d_blk)) + tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound +=
 tma_l3_bound + tma_store_bound) * (tma_dtlb_store / (tma_dtlb_store + tma_=
false_sharing + tma_split_stores + tma_store_latency + tma_streaming_stores=
)))",
         "MetricGroup": "Mem;MemoryTLB;Offcore",
         "MetricName": "Memory_Data_TLBs"
     },
@@ -697,13 +697,13 @@
     },
     {
         "BriefDescription": "Uops Per Instruction",
-        "MetricExpr": "(tma_retiring * SLOTS) / INST_RETIRED.ANY",
+        "MetricExpr": "tma_retiring * SLOTS / INST_RETIRED.ANY",
         "MetricGroup": "Pipeline;Ret;Retire",
         "MetricName": "UPI"
     },
     {
         "BriefDescription": "Instruction per taken branch",
-        "MetricExpr": "(tma_retiring * SLOTS) / BR_INST_RETIRED.NEAR_TAKEN=
",
+        "MetricExpr": "tma_retiring * SLOTS / BR_INST_RETIRED.NEAR_TAKEN",
         "MetricGroup": "Branches;Fed;FetchBW",
         "MetricName": "UpTB"
     },
@@ -727,7 +727,7 @@
     },
     {
         "BriefDescription": "Fraction of Physical Core issue-slots utilize=
d by this Logical Processor",
-        "MetricExpr": "SLOTS / (TOPDOWN.SLOTS / 2) if #SMT_on else 1",
+        "MetricExpr": "(SLOTS / (TOPDOWN.SLOTS / 2) if #SMT_on else 1)",
         "MetricGroup": "SMT;tma_L1_group",
         "MetricName": "Slots_Utilization"
     },
@@ -746,26 +746,26 @@
     },
     {
         "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricExpr": "(1 * (FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARIT=
H_INST_RETIRED.SCALAR_DOUBLE) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBL=
E + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.2=
56B_PACKED_DOUBLE) + 8 * (FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARI=
TH_INST_RETIRED.512B_PACKED_DOUBLE) + 16 * FP_ARITH_INST_RETIRED.512B_PACKE=
D_SINGLE) / CORE_CLKS",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 =
* (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PA=
CKED_DOUBLE) + 8 * (FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INS=
T_RETIRED.512B_PACKED_DOUBLE) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SING=
LE) / CORE_CLKS",
         "MetricGroup": "Flops;Ret",
         "MetricName": "FLOPc"
     },
     {
         "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
-        "MetricExpr": "((FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_IN=
ST_RETIRED.SCALAR_DOUBLE) + (FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_=
ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_D=
OUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.51=
2B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE)) / (2 * CORE_C=
LKS)",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE + (FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_AR=
ITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOU=
BLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B=
_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE)) / (2 * CORE_CLK=
S)",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "FP_Arith_Utilization",
         "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)."
     },
     {
         "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / ((UOPS_EXECUTED.CORE_CYCLES_=
GE_1 / 2) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
         "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
         "MetricName": "ILP"
     },
     {
         "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
-        "MetricExpr": "(1 - tma_core_bound / tma_ports_utilization if tma_=
core_bound < tma_ports_utilization else 1) if SMT_2T_Utilization > 0.5 else=
 0",
+        "MetricExpr": "((1 - tma_core_bound / tma_ports_utilization if tma=
_core_bound < tma_ports_utilization else 1) if SMT_2T_Utilization > 0.5 els=
e 0)",
         "MetricGroup": "Cor;SMT",
         "MetricName": "Core_Bound_Likely"
     },
@@ -813,13 +813,13 @@
     },
     {
         "BriefDescription": "Instructions per Floating Point (FP) Operatio=
n (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / (1 * (FP_ARITH_INST_RETIRED.SCAL=
AR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE) + 2 * FP_ARITH_INST_RETIRE=
D.128B_PACKED_DOUBLE + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_A=
RITH_INST_RETIRED.256B_PACKED_DOUBLE) + 8 * (FP_ARITH_INST_RETIRED.256B_PAC=
KED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE) + 16 * FP_ARITH_INST=
_RETIRED.512B_PACKED_SINGLE)",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR_SI=
NGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE + 2 * FP_ARITH_INST_RETIRED.128B=
_PACKED_DOUBLE + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_I=
NST_RETIRED.256B_PACKED_DOUBLE) + 8 * (FP_ARITH_INST_RETIRED.256B_PACKED_SI=
NGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE) + 16 * FP_ARITH_INST_RETIR=
ED.512B_PACKED_SINGLE)",
         "MetricGroup": "Flops;InsType",
         "MetricName": "IpFLOP"
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic instruction (l=
ower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / ((FP_ARITH_INST_RETIRED.SCALAR_S=
INGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE) + (FP_ARITH_INST_RETIRED.128B_=
PACKED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RE=
TIRED.256B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_AR=
ITH_INST_RETIRED.512B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SIN=
GLE))",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR_SI=
NGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE + (FP_ARITH_INST_RETIRED.128B_PA=
CKED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETI=
RED.256B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARIT=
H_INST_RETIRED.512B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SINGL=
E))",
         "MetricGroup": "Flops;InsType",
         "MetricName": "IpArith",
         "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). May undercount due to FMA doubl=
e counting. Approximated prior to BDW."
@@ -873,7 +873,7 @@
     },
     {
         "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
-        "MetricExpr": "(tma_retiring * SLOTS) / cpu@UOPS_RETIRED.SLOTS\\,c=
mask\\=3D1@",
+        "MetricExpr": "tma_retiring * SLOTS / cpu@UOPS_RETIRED.SLOTS\\,cma=
sk\\=3D1@",
         "MetricGroup": "Pipeline;Ret",
         "MetricName": "Retire"
     },
@@ -927,7 +927,7 @@
     },
     {
         "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
-        "MetricExpr": " (tma_branch_mispredicts + tma_fetch_latency * tma_=
mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icache=
_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) * SLOTS / BR_MISP_R=
ETIRED.ALL_BRANCHES",
+        "MetricExpr": "(tma_branch_mispredicts + tma_fetch_latency * tma_m=
ispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icache_=
misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) * SLOTS / BR_MISP_RE=
TIRED.ALL_BRANCHES",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "Branch_Misprediction_Cost"
     },
@@ -975,49 +975,49 @@
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY"=
,
+        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY",
         "MetricGroup": "CacheMisses;Mem",
         "MetricName": "L1MPKI"
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 all demand loads (including speculative)",
-        "MetricExpr": "1000 * L2_RQSTS.ALL_DEMAND_DATA_RD / INST_RETIRED.A=
NY",
+        "MetricExpr": "1e3 * L2_RQSTS.ALL_DEMAND_DATA_RD / INST_RETIRED.AN=
Y",
         "MetricGroup": "CacheMisses;Mem",
         "MetricName": "L1MPKI_Load"
     },
     {
         "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY"=
,
+        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
         "MetricGroup": "Backend;CacheMisses;Mem",
         "MetricName": "L2MPKI"
     },
     {
         "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all request types (including speculative)",
-        "MetricExpr": "1000 * ((OFFCORE_REQUESTS.ALL_DATA_RD - OFFCORE_REQ=
UESTS.DEMAND_DATA_RD) + L2_RQSTS.ALL_DEMAND_MISS + L2_RQSTS.SWPF_MISS) / In=
structions",
+        "MetricExpr": "1e3 * (OFFCORE_REQUESTS.ALL_DATA_RD - OFFCORE_REQUE=
STS.DEMAND_DATA_RD + L2_RQSTS.ALL_DEMAND_MISS + L2_RQSTS.SWPF_MISS) / Instr=
uctions",
         "MetricGroup": "CacheMisses;Mem;Offcore",
         "MetricName": "L2MPKI_All"
     },
     {
         "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all demand loads  (including speculative)",
-        "MetricExpr": "1000 * L2_RQSTS.DEMAND_DATA_RD_MISS / INST_RETIRED.=
ANY",
+        "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_MISS / INST_RETIRED.A=
NY",
         "MetricGroup": "CacheMisses;Mem",
         "MetricName": "L2MPKI_Load"
     },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all de=
mand loads  (including speculative)",
-        "MetricExpr": "1000 * L2_RQSTS.DEMAND_DATA_RD_HIT / INST_RETIRED.A=
NY",
+        "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_HIT / INST_RETIRED.AN=
Y",
         "MetricGroup": "CacheMisses;Mem",
         "MetricName": "L2HPKI_Load"
     },
     {
         "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY"=
,
+        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY",
         "MetricGroup": "CacheMisses;Mem",
         "MetricName": "L3MPKI"
     },
     {
         "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
-        "MetricExpr": "1000 * MEM_LOAD_RETIRED.FB_HIT / INST_RETIRED.ANY",
+        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.FB_HIT / INST_RETIRED.ANY",
         "MetricGroup": "CacheMisses;Mem",
         "MetricName": "FB_HPKI"
     },
@@ -1030,25 +1030,25 @@
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
     {
         "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 / d=
uration_time",
+        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1e9 / duration=
_time",
         "MetricGroup": "Mem;MemoryBW;Offcore",
         "MetricName": "L3_Cache_Access_BW"
     },
@@ -1078,19 +1078,19 @@
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
-        "MetricExpr": "((1 * (FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARI=
TH_INST_RETIRED.SCALAR_DOUBLE) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUB=
LE + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.=
256B_PACKED_DOUBLE) + 8 * (FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_AR=
ITH_INST_RETIRED.512B_PACKED_DOUBLE) + 16 * FP_ARITH_INST_RETIRED.512B_PACK=
ED_SINGLE) / 1000000000) / duration_time",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 =
* (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PA=
CKED_DOUBLE) + 8 * (FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INS=
T_RETIRED.512B_PACKED_DOUBLE) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SING=
LE) / 1e9 / duration_time",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "GFLOPs",
         "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine."
@@ -1124,7 +1124,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
-        "MetricExpr": "1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UN=
HALTED.REF_DISTRIBUTED if #SMT_on else 0",
+        "MetricExpr": "(1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_U=
NHALTED.REF_DISTRIBUTED if #SMT_on else 0)",
         "MetricGroup": "SMT",
         "MetricName": "SMT_2T_Utilization"
     },
@@ -1142,68 +1142,89 @@
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
     },
     {
         "BriefDescription": "C8 residency percent per package",
-        "MetricExpr": "(cstate_pkg@c8\\-residency@ / msr@tsc@) * 100",
+        "MetricExpr": "cstate_pkg@c8\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C8_Pkg_Residency"
+        "MetricName": "C8_Pkg_Residency",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C9 residency percent per package",
-        "MetricExpr": "(cstate_pkg@c9\\-residency@ / msr@tsc@) * 100",
+        "MetricExpr": "cstate_pkg@c9\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C9_Pkg_Residency"
+        "MetricName": "C9_Pkg_Residency",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C10 residency percent per package",
-        "MetricExpr": "(cstate_pkg@c10\\-residency@ / msr@tsc@) * 100",
+        "MetricExpr": "cstate_pkg@c10\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C10_Pkg_Residency"
+        "MetricName": "C10_Pkg_Residency",
+        "ScaleUnit": "100%"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/icelake/memory.json b/tools/per=
f/pmu-events/arch/x86/icelake/memory.json
index a6f43cbc2d0a..e8d2ec1c029b 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/memory.json
@@ -1,565 +1,394 @@
 [
     {
         "BriefDescription": "Cycles while L3 cache miss demand load is out=
standing.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "2",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L3_MISS",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Execution stalls while L3 cache miss demand l=
oad is outstanding.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "6",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L3_MISS",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x6"
     },
     {
         "BriefDescription": "Number of times an HLE execution aborted due =
to any reasons (multiple categories may count as one).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.ABORTED",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of times HLE abort was tri=
ggered.",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Number of times an HLE execution aborted due =
to unfriendly events (such as interrupts).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.ABORTED_EVENTS",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of times an HLE execution =
aborted due to unfriendly events (such as interrupts).",
         "SampleAfterValue": "100003",
         "UMask": "0x80"
     },
     {
         "BriefDescription": "Number of times an HLE execution aborted due =
to various memory events (e.g., read/write capacity and conflicts).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.ABORTED_MEM",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of times an HLE execution =
aborted due to various memory events (e.g., read/write capacity and conflic=
ts).",
         "SampleAfterValue": "100003",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Number of times an HLE execution aborted due =
to HLE-unfriendly instructions and certain unfriendly events (such as AD as=
sists etc.).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.ABORTED_UNFRIENDLY",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of times an HLE execution =
aborted due to HLE-unfriendly instructions and certain unfriendly events (s=
uch as AD assists etc.).",
         "SampleAfterValue": "100003",
         "UMask": "0x20"
     },
     {
         "BriefDescription": "Number of times an HLE execution successfully=
 committed",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.COMMIT",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of times HLE commit succee=
ded.",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Number of times an HLE execution started.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.START",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of times we entered an HLE=
 region. Does not count nested transactions.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Number of machine clears due to memory orderi=
ng conflicts.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of Machine Clears detected=
 dye to memory ordering. Memory Ordering Machine Clears may apply when a me=
mory read may not conform to the memory ordering rules of the x86 architect=
ure",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 128 cycles.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x80",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 128 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "1009",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 16 cycles.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x10",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 16 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "20011",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 256 cycles.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x100",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 256 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "503",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 32 cycles.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x20",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 32 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "100007",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 4 cycles.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x4",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 4 cycles.  Reported l=
atency may be longer than just the memory latency.",
         "SampleAfterValue": "100003",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 512 cycles.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x200",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 512 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "101",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 64 cycles.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x40",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 64 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "2003",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 8 cycles.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x8",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 8 cycles.  Reported l=
atency may be longer than just the memory latency.",
         "SampleAfterValue": "50021",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that was not supplied by the L3 cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_CODE_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00004",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that was not supplie=
d by the L3 cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00001",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that was no=
t supplied by the L3 cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00002",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L1 data cache prefetch requests and so=
ftware prefetches (except PREFETCHW) that was not supplied by the L3 cache.=
",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L1D_AND_SWPF.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00400",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts hardware prefetch data reads (which br=
ing data to L2)  that was not supplied by the L3 cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L2_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00010",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts hardware prefetch RFOs (which bring da=
ta to L2) that was not supplied by the L3 cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L2_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00020",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts miscellaneous requests, such as I/O an=
d un-cacheable accesses that was not supplied by the L3 cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.OTHER.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC08000",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts streaming stores that was not supplied=
 by the L3 cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.STREAMING_WR.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00800",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data read requests that miss th=
e L3 cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xb0",
         "EventName": "OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Cycles where at least one demand data read re=
quest known to have missed the L3 cache is pending.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x60",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_L3_MISS_DEM=
AND_DATA_RD",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Cycles where at least one demand data read r=
equest known to have missed the L3 cache is pending.  Note that this does n=
ot capture all elapsed cycles while requests are outstanding - only cycles =
from when the requests were known to have missed the L3 cache.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of times RTM abort was tri=
ggered.",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to none of the previous 4 categories (e.g. interrupt)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_EVENTS",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of times an RTM execution =
aborted due to none of the previous 4 categories (e.g. interrupt).",
         "SampleAfterValue": "100003",
         "UMask": "0x80"
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to various memory events (e.g. read/write capacity and conflicts)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_MEM",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of times an RTM execution =
aborted due to various memory events (e.g. read/write capacity and conflict=
s).",
         "SampleAfterValue": "100003",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to incompatible memory type",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_MEMTYPE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of times an RTM execution =
aborted due to incompatible memory type.",
         "SampleAfterValue": "100003",
         "UMask": "0x40"
     },
     {
         "BriefDescription": "Number of times an RTM execution aborted due =
to HLE-unfriendly instructions",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_UNFRIENDLY",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of times an RTM execution =
aborted due to HLE-unfriendly instructions.",
         "SampleAfterValue": "100003",
         "UMask": "0x20"
     },
     {
         "BriefDescription": "Number of times an RTM execution successfully=
 committed",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.COMMIT",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of times RTM commit succee=
ded.",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Number of times an RTM execution started.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.START",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of times we entered an RTM=
 region. Does not count nested transactions.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of times a class of instruc=
tions that may cause a transactional abort was executed inside a transactio=
nal region",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5d",
         "EventName": "TX_EXEC.MISC2",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts Unfriendly TSX abort triggered by a v=
zeroupper instruction.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Number of times an instruction execution caus=
ed the transactional nest count supported to be exceeded",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5d",
         "EventName": "TX_EXEC.MISC3",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts Unfriendly TSX abort triggered by a n=
est count that is too deep.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Speculatively counts the number of TSX aborts=
 due to a data capacity limitation for transactional reads",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_CAPACITY_READ",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Speculatively counts the number of Transacti=
onal Synchronization Extensions (TSX) aborts due to a data capacity limitat=
ion for transactional reads",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x80"
     },
     {
         "BriefDescription": "Speculatively counts the number of TSX aborts=
 due to a data capacity limitation for transactional writes.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_CAPACITY_WRITE",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Speculatively counts the number of Transacti=
onal Synchronization Extensions (TSX) aborts due to a data capacity limitat=
ion for transactional writes.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Number of times a transactional abort was sig=
naled due to a data conflict on a transactionally accessed address",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_CONFLICT",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of times a TSX line had a =
cache conflict.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Number of times an HLE transactional executio=
n aborted due to XRELEASE lock not satisfying the address and value require=
ments in the elision buffer",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_HLE_ELISION_BUFFER_MISMATCH",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of times a TSX Abort was t=
riggered due to release/commit but data and address mismatch.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Number of times an HLE transactional executio=
n aborted due to NoAllocatedElisionBuffer being non-zero.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_HLE_ELISION_BUFFER_NOT_EMPTY",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of times a TSX Abort was t=
riggered due to commit but Lock Buffer not empty.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Number of times an HLE transactional executio=
n aborted due to an unsupported read alignment from the elision buffer.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_HLE_ELISION_BUFFER_UNSUPPORTED_ALIGNMEN=
T",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of times a TSX Abort was t=
riggered due to attempting an unsupported alignment from Lock Buffer.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x20"
     },
     {
         "BriefDescription": "Number of times a HLE transactional region ab=
orted due to a non XRELEASE prefixed instruction writing to an elided lock =
in the elision buffer",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_HLE_STORE_TO_ELIDED_LOCK",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of times a TSX Abort was t=
riggered due to a non-release/commit store to lock.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Number of times HLE lock could not be elided =
due to ElisionBufferAvailable being zero.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.HLE_ELISION_BUFFER_FULL",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of times we could not allo=
cate Lock Buffer.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x40"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/icelake/other.json b/tools/perf=
/pmu-events/arch/x86/icelake/other.json
index 3055710595c4..cfb590632918 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/other.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/other.json
@@ -1,374 +1,242 @@
 [
     {
         "BriefDescription": "Core cycles where the core was running in a m=
anner where Turbo may be clipped to the Non-AVX turbo schedule.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "CORE_POWER.LVL0_TURBO_LICENSE",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts Core cycles where the core was runnin=
g with power-delivery for baseline license level 0.  This includes non-AVX =
codes, SSE, AVX 128-bit, and low-current AVX 256-bit codes.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x7"
     },
     {
         "BriefDescription": "Core cycles where the core was running in a m=
anner where Turbo may be clipped to the AVX2 turbo schedule.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "CORE_POWER.LVL1_TURBO_LICENSE",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts Core cycles where the core was runnin=
g with power-delivery for license level 1.  This includes high current AVX =
256-bit instructions as well as low current AVX 512-bit instructions.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x18"
     },
     {
         "BriefDescription": "Core cycles where the core was running in a m=
anner where Turbo may be clipped to the AVX512 turbo schedule.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "CORE_POWER.LVL2_TURBO_LICENSE",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Core cycles where the core was running with =
power-delivery for license level 2 (introduced in Skylake Server microarcht=
ecture).  This includes high current AVX 512-bit instructions.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x20"
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that have any type of response.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_CODE_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10004",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that DRAM supplied the request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_CODE_RD.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000004",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that DRAM supplied the request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_CODE_RD.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000004",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that have any type o=
f response.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10001",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that DRAM supplied t=
he request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_DATA_RD.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000001",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that DRAM supplied t=
he request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000001",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that have a=
ny type of response.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10002",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that DRAM s=
upplied the request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_RFO.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000002",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that DRAM s=
upplied the request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_RFO.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000002",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L1 data cache prefetch requests and so=
ftware prefetches (except PREFETCHW) that have any type of response.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L1D_AND_SWPF.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10400",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L1 data cache prefetch requests and so=
ftware prefetches (except PREFETCHW) that DRAM supplied the request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L1D_AND_SWPF.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000400",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L1 data cache prefetch requests and so=
ftware prefetches (except PREFETCHW) that DRAM supplied the request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L1D_AND_SWPF.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000400",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts hardware prefetch data reads (which br=
ing data to L2)  that have any type of response.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L2_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10010",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts hardware prefetch data reads (which br=
ing data to L2)  that DRAM supplied the request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L2_DATA_RD.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000010",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts hardware prefetch data reads (which br=
ing data to L2)  that DRAM supplied the request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L2_DATA_RD.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000010",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts hardware prefetch RFOs (which bring da=
ta to L2) that have any type of response.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L2_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10020",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts hardware prefetch RFOs (which bring da=
ta to L2) that DRAM supplied the request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L2_RFO.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000020",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts hardware prefetch RFOs (which bring da=
ta to L2) that DRAM supplied the request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L2_RFO.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000020",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts miscellaneous requests, such as I/O an=
d un-cacheable accesses that have any type of response.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.OTHER.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x18000",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts miscellaneous requests, such as I/O an=
d un-cacheable accesses that DRAM supplied the request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.OTHER.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184008000",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts miscellaneous requests, such as I/O an=
d un-cacheable accesses that DRAM supplied the request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.OTHER.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184008000",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10800",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts streaming stores that DRAM supplied th=
e request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.STREAMING_WR.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000800",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts streaming stores that DRAM supplied th=
e request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.STREAMING_WR.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000800",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/icelake/pipeline.json b/tools/p=
erf/pmu-events/arch/x86/icelake/pipeline.json
index c74a7369cff3..3b31a842a0b1 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
@@ -1,703 +1,490 @@
 [
     {
         "BriefDescription": "Cycles when divide unit is busy executing div=
ide or square root operations.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x14",
         "EventName": "ARITH.DIVIDER_ACTIVE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles when divide unit is busy execu=
ting divide or square root operations. Accounts for integer and floating-po=
int operations.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x9"
     },
     {
         "BriefDescription": "Number of occurrences where a microcode assis=
t is invoked by hardware.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.ANY",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of occurrences where a mic=
rocode assist is invoked by hardware Examples include AD (page Access Dirty=
), FP and AVX related assists.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x7"
     },
     {
         "BriefDescription": "All branch instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts all branch instructions retired.",
         "SampleAfterValue": "400009"
     },
     {
         "BriefDescription": "Conditional branch instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts conditional branch instructions retir=
ed.",
         "SampleAfterValue": "400009",
         "UMask": "0x11"
     },
     {
         "BriefDescription": "Not taken branch instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_NTAKEN",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts not taken branch instructions retired=
.",
         "SampleAfterValue": "400009",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Taken conditional branch instructions retired=
.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_TAKEN",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts taken conditional branch instructions=
 retired.",
         "SampleAfterValue": "400009",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Far branch instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts far branch instructions retired.",
         "SampleAfterValue": "100007",
         "UMask": "0x40"
     },
     {
         "BriefDescription": "Indirect near branch instructions retired (ex=
cluding returns)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts near indirect branch instructions ret=
ired excluding returns. TSX abort is an indirect branch.",
         "SampleAfterValue": "100003",
         "UMask": "0x80"
     },
     {
         "BriefDescription": "Direct and indirect near call instructions re=
tired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts both direct and indirect near call in=
structions retired.",
         "SampleAfterValue": "100007",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Return instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts return instructions retired.",
         "SampleAfterValue": "100007",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Taken branch instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts taken branch instructions retired.",
         "SampleAfterValue": "400009",
         "UMask": "0x20"
     },
     {
         "BriefDescription": "All mispredicted branch instructions retired.=
",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts all the retired branch instructions t=
hat were mispredicted by the processor. A branch misprediction occurs when =
the processor incorrectly predicts the destination of the branch.  When the=
 misprediction is discovered at execution, all the instructions executed in=
 the wrong (speculative) path must be discarded, and the processor must sta=
rt fetching from the correct path.",
         "SampleAfterValue": "50021"
     },
     {
         "BriefDescription": "Mispredicted conditional branch instructions =
retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts mispredicted conditional branch instr=
uctions retired.",
         "SampleAfterValue": "50021",
         "UMask": "0x11"
     },
     {
         "BriefDescription": "Mispredicted non-taken conditional branch ins=
tructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_NTAKEN",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of conditional branch inst=
ructions retired that were mispredicted and the branch direction was not ta=
ken.",
         "SampleAfterValue": "50021",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "number of branch instructions retired that we=
re mispredicted and taken.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_TAKEN",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts taken conditional mispredicted branch=
 instructions retired.",
         "SampleAfterValue": "50021",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "All miss-predicted indirect branch instructio=
ns retired (excluding RETs. TSX aborts is considered indirect branch).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts all miss-predicted indirect branch in=
structions retired (excluding RETs. TSX aborts is considered indirect branc=
h).",
         "SampleAfterValue": "50021",
         "UMask": "0x80"
     },
     {
         "BriefDescription": "Mispredicted indirect CALL instructions retir=
ed.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts retired mispredicted indirect (near t=
aken) CALL instructions, including both register and memory indirect.",
         "SampleAfterValue": "50021",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Number of near branch instructions retired th=
at were mispredicted and taken.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts number of near branch instructions re=
tired that were mispredicted and taken.",
         "SampleAfterValue": "50021",
         "UMask": "0x20"
     },
     {
         "BriefDescription": "Cycle counts are evenly distributed between a=
ctive threads in the Core.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.DISTRIBUTED",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "This event distributes cycle counts between =
active hyperthreads, i.e., those in C0.  A hyperthread becomes inactive whe=
n it executes the HLT or MWAIT instructions.  If all other hyperthreads are=
 inactive (or disabled or do not exist), all counts are attributed to this =
hyperthread. To obtain the full count when the Core is active, sum the coun=
ts from each hyperthread.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Core crystal clock cycles when this thread is=
 unhalted and the other thread is halted.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts Core crystal clock cycles when curren=
t thread is unhalted and the other thread is halted.",
         "SampleAfterValue": "25003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Core crystal clock cycles. Cycle counts are e=
venly distributed between active threads in the Core.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF_DISTRIBUTED",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "This event distributes Core crystal clock cy=
cle counts between active hyperthreads, i.e., those in C0 sleep-state. A hy=
perthread becomes inactive when it executes the HLT or MWAIT instructions. =
If one thread is active in a core, all counts are attributed to this hypert=
hread. To obtain the full count when the Core is active, sum the counts fro=
m each hyperthread.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
-        "CollectPEBSRecord": "2",
-        "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
-        "PEBScounters": "34",
         "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. This e=
vent has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK event. It is c=
ounted on a dedicated fixed counter, leaving the eight programmable counter=
s available for other events. Note: On all current platforms this event sto=
ps counting during 'throttling (TM)' states duty off periods the processor =
is 'halted'.  The counter update is done at a lower clock rate then the cor=
e clock the overflow status bit for this counter may appear 'sticky'.  Afte=
r the counter has overflowed and software clears the overflow status bit an=
d resets the counter to less than MAX. The reset value to the counter is no=
t clocked immediately so the overflow status bit will flip 'high (1)' and g=
enerate another PMI (if enabled) after which the reset value gets clocked i=
nto the counter. Therefore, software will get the interrupt, read the overf=
low status bit '1 for bit 34 while the counter value is less than MAX. Soft=
ware should ignore this case.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x3"
     },
     {
         "BriefDescription": "Core crystal clock cycles when the thread is =
unhalted.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.REF_XCLK",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts core crystal clock cycles when the th=
read is unhalted.",
         "SampleAfterValue": "25003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt st=
ate",
-        "CollectPEBSRecord": "2",
-        "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
-        "PEBScounters": "33",
         "PublicDescription": "Counts the number of core cycles while the t=
hread is not in a halt state. The thread enters the halt state when it is r=
unning the HLT instruction. This event is a component in many key event rat=
ios. The core frequency may change from time to time due to transitions ass=
ociated with Enhanced Intel SpeedStep Technology or TM2. For this reason th=
is event may have a changing ratio with regards to time. When the core freq=
uency is constant, this event can approximate elapsed time while the core w=
as not in the halt state. It is counted on a dedicated fixed counter, leavi=
ng the eight programmable counters available for other events.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Thread cycles when thread is not in halt stat=
e",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time.",
-        "SampleAfterValue": "2000003",
-        "Speculative": "1"
+        "SampleAfterValue": "2000003"
     },
     {
         "BriefDescription": "Cycles while L1 cache miss demand load is out=
standing.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "8",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_MISS",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Cycles while L2 cache miss demand load is out=
standing.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L2_MISS",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Cycles while memory subsystem has an outstand=
ing load.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "16",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_MEM_ANY",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Execution stalls while L1 cache miss demand l=
oad is outstanding.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "12",
         "EventCode": "0xA3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L1D_MISS",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0xc"
     },
     {
         "BriefDescription": "Execution stalls while L2 cache miss demand l=
oad is outstanding.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "5",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L2_MISS",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x5"
     },
     {
         "BriefDescription": "Execution stalls while memory subsystem has a=
n outstanding load.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "20",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_MEM_ANY",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x14"
     },
     {
         "BriefDescription": "Total execution stalls.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_TOTAL",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Cycles total of 1 uop is executed on all port=
s and Reservation Station was not empty.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.1_PORTS_UTIL",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles during which a total of 1 uop =
was executed on all ports and Reservation Station (RS) was not empty.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Cycles total of 2 uops are executed on all po=
rts and Reservation Station was not empty.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.2_PORTS_UTIL",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles during which a total of 2 uops=
 were executed on all ports and Reservation Station (RS) was not empty.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Cycles total of 3 uops are executed on all po=
rts and Reservation Station was not empty.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.3_PORTS_UTIL",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Cycles total of 3 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Cycles total of 4 uops are executed on all po=
rts and Reservation Station was not empty.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.4_PORTS_UTIL",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Cycles total of 4 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Cycles where the Store Buffer was full and no=
 loads caused an execution stall.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "2",
         "EventCode": "0xA6",
         "EventName": "EXE_ACTIVITY.BOUND_ON_STORES",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles where the Store Buffer was ful=
l and no loads caused an execution stall.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x40"
     },
     {
         "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "ILD_STALL.LCP",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk.",
         "SampleAfterValue": "500009",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Instruction decoders utilized in a cycle",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x55",
         "EventName": "INST_DECODED.DECODERS",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Number of decoders utilized in a cycle when =
the MITE (legacy decode pipeline) fetches instructions.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Number of instructions retired. Fixed Counter=
 - architectural event",
-        "CollectPEBSRecord": "2",
-        "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
-        "PEBScounters": "32",
         "PublicDescription": "Counts the number of instructions retired - =
an Architectural PerfMon event. Counting continues during hardware interrup=
ts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is counte=
d by a designated fixed counter freeing up programmable counters to count o=
ther events. INST_RETIRED.ANY_P is counted by a programmable counter.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Number of instructions retired. General Count=
er - architectural event",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.ANY_P",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of instructions retired - =
an Architectural PerfMon event. Counting continues during hardware interrup=
ts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is counte=
d by a designated fixed counter freeing up programmable counters to count o=
ther events. INST_RETIRED.ANY_P is counted by a programmable counter.",
         "SampleAfterValue": "2000003"
     },
     {
         "BriefDescription": "Number of all retired NOP instructions.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.NOP",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Precise instruction retired event with a redu=
ced effect of PEBS shadow in IP distribution",
-        "CollectPEBSRecord": "2",
-        "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.PREC_DIST",
         "PEBS": "1",
-        "PEBScounters": "32",
         "PublicDescription": "A version of INST_RETIRED that allows for a =
more unbiased distribution of samples across instructions retired. It utili=
zes the Precise Distribution of Instructions Retired (PDIR) feature to miti=
gate some bias in how retired instructions get sampled. Use on Fixed Counte=
r 0.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Cycles without actually retired instructions.=
",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.STALL_CYCLES",
         "Invert": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "This event counts cycles without actually re=
tired instructions.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Cycles the Backend cluster is recovering afte=
r a miss-speculation or a Store Buffer or Load Buffer drain stall.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x0D",
         "EventName": "INT_MISC.ALL_RECOVERY_CYCLES",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles the Backend cluster is recover=
ing after a miss-speculation or a Store Buffer or Load Buffer drain stall."=
,
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x3"
     },
     {
         "BriefDescription": "Counts cycles after recovery from a branch mi=
sprediction or machine clear till the first uop is issued from the resteere=
d path.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x0d",
         "EventName": "INT_MISC.CLEAR_RESTEER_CYCLES",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Cycles after recovery from a branch mispredi=
ction or machine clear till the first uop is issued from the resteered path=
.",
         "SampleAfterValue": "500009",
-        "Speculative": "1",
         "UMask": "0x80"
     },
     {
         "BriefDescription": "Core cycles the allocator was stalled due to =
recovery from earlier clear event for this thread",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x0D",
         "EventName": "INT_MISC.RECOVERY_CYCLES",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts core cycles when the Resource allocat=
or was stalled due to recovery from an earlier branch misprediction or mach=
ine clear event.",
         "SampleAfterValue": "500009",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "TMA slots where uops got dropped",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x0d",
         "EventName": "INT_MISC.UOP_DROPPING",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Estimated number of Top-down Microarchitectu=
re Analysis slots that got dropped due to non front-end reasons",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "The number of times that split load operation=
s are temporarily blocked because all resources for handling the split acce=
sses are in use.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.NO_SR",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of times that split load o=
perations are temporarily blocked because all resources for handling the sp=
lit accesses are in use.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Loads blocked due to overlapping with a prece=
ding store that cannot be forwarded.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of times where store forwa=
rding was prevented for a load operation. The most common case is a load bl=
ocked due to the address of memory access (partially) overlapping with a pr=
eceding uncompleted store. Note: See the table of not supported store forwa=
rds in the Optimization Guide.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "False dependencies due to partial compare on =
address.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x07",
         "EventName": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of times a load got blocke=
d due to false dependencies due to partial compare on address.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of demand load dispatches t=
hat hit L1D fill buffer (FB) allocated for software prefetch.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4c",
         "EventName": "LOAD_HIT_PREFETCH.SWPF",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts all not software-prefetch load dispat=
ches that hit the fill buffer (FB) allocated for the software prefetch. It =
can also be incremented by some lock instructions. So it should only be use=
d with profiling so that the locks can be excluded by ASM (Assembly File) i=
nspection of the nearby instructions.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Cycles Uops delivered by the LSD, but didn't =
come from the decoder.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xA8",
         "EventName": "LSD.CYCLES_ACTIVE",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the cycles when at least one uop is d=
elivered by the LSD (Loop-stream detector).",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Cycles optimal number of Uops delivered by th=
e LSD, but did not come from the decoder.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "5",
         "EventCode": "0xa8",
         "EventName": "LSD.CYCLES_OK",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the cycles when optimal number of uop=
s is delivered by the LSD (Loop-stream detector).",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Number of Uops delivered by the LSD.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xa8",
         "EventName": "LSD.UOPS",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of uops delivered to the b=
ack-end by the LSD(Loop Stream Detector).",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Number of machine clears (nukes) of any type.=
",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.COUNT",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of machine clears (nukes) =
of any type.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Self-modifying code (SMC) detected.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.SMC",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts self-modifying code (SMC) detected, w=
hich causes a machine clear.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Increments whenever there is an update to the=
 LBR array.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcc",
         "EventName": "MISC_RETIRED.LBR_INSERTS",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Increments when an entry is added to the Las=
t Branch Record (LBR) array (or removed from the array in case of RETURNs i=
n call stack mode). The event requires LBR to be enabled properly.",
         "SampleAfterValue": "100003",
         "UMask": "0x20"
     },
     {
         "BriefDescription": "Number of retired PAUSE instructions. This ev=
ent is not supported on first SKL and KBL products.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcc",
         "EventName": "MISC_RETIRED.PAUSE_INST",
         "PublicDescription": "Counts number of retired PAUSE instructions.=
 This event is not supported on first SKL and KBL products.",
@@ -706,422 +493,288 @@
     },
     {
         "BriefDescription": "Cycles stalled due to no store buffers availa=
ble. (not including draining form sync).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa2",
         "EventName": "RESOURCE_STALLS.SB",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts allocation stall cycles caused by the=
 store buffer (SB) being full. This counts cycles that the pipeline back-en=
d blocked uop delivery from the front-end.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Counts cycles where the pipeline is stalled d=
ue to serializing operations.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa2",
         "EventName": "RESOURCE_STALLS.SCOREBOARD",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 for the thread",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x5e",
         "EventName": "RS_EVENTS.EMPTY_CYCLES",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for this logical processor. This is usually caused whe=
n the front-end pipeline runs into stravation periods (e.g. branch mispredi=
ctions or i-cache misses)",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts end of periods where the Reservation S=
tation (RS) was empty.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x5E",
         "EventName": "RS_EVENTS.EMPTY_END",
         "Invert": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts end of periods where the Reservation =
Station (RS) was empty. Could be useful to closely sample on front-end late=
ncy issues (see the FRONTEND_RETIRED event of designated precise events)",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "TMA slots where no uops were being issued due=
 to lack of back-end resources.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of Top-down Microarchitect=
ure Analysis (TMA) method's  slots where no micro-operations were being iss=
ued from front-end to back-end of the machine due to lack of back-end resou=
rces.",
         "SampleAfterValue": "10000003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "TMA slots wasted due to incorrect speculation=
 by branch mispredictions",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by branch mispredictions. This event estimates number=
 of operations that were issued but not retired from the specualtive path a=
s well as the out-of-order engine recovery past a branch misprediction.",
         "SampleAfterValue": "10000003",
-        "Speculative": "1",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "TMA slots available for an unhalted logical p=
rocessor. Fixed counter - architectural event",
-        "CollectPEBSRecord": "2",
-        "Counter": "Fixed counter 3",
         "EventName": "TOPDOWN.SLOTS",
-        "PEBScounters": "35",
         "PublicDescription": "Number of available slots for an unhalted lo=
gical processor. The event increments by machine-width of the narrowest pip=
eline as employed by the Top-down Microarchitecture Analysis method (TMA). =
The count is distributed among unhalted logical processors (hyper-threads) =
who share the same physical core. Software can use this event as the denomi=
nator for the top-level metrics of the TMA method. This architectural event=
 is counted on a designated fixed counter (Fixed Counter 3).",
         "SampleAfterValue": "10000003",
-        "Speculative": "1",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "TMA slots available for an unhalted logical p=
rocessor. General counter - architectural event",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.SLOTS_P",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of available slots for an =
unhalted logical processor. The event increments by machine-width of the na=
rrowest pipeline as employed by the Top-down Microarchitecture Analysis met=
hod. The count is distributed among unhalted logical processors (hyper-thre=
ads) who share the same physical core.",
         "SampleAfterValue": "10000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Number of uops decoded out of instructions ex=
clusively fetched by decoder 0",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x56",
         "EventName": "UOPS_DECODED.DEC0",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Uops exclusively fetched by decoder 0",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Number of uops executed on port 0",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa1",
         "EventName": "UOPS_DISPATCHED.PORT_0",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts, on the per-thread basis, cycles duri=
ng which at least one uop is dispatched from the Reservation Station (RS) t=
o port 0.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Number of uops executed on port 1",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa1",
         "EventName": "UOPS_DISPATCHED.PORT_1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts, on the per-thread basis, cycles duri=
ng which at least one uop is dispatched from the Reservation Station (RS) t=
o port 1.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Number of uops executed on port 2 and 3",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa1",
         "EventName": "UOPS_DISPATCHED.PORT_2_3",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts, on the per-thread basis, cycles duri=
ng which at least one uop is dispatched from the Reservation Station (RS) t=
o ports 2 and 3.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Number of uops executed on port 4 and 9",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa1",
         "EventName": "UOPS_DISPATCHED.PORT_4_9",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts, on the per-thread basis, cycles duri=
ng which at least one uop is dispatched from the Reservation Station (RS) t=
o ports 5 and 9.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Number of uops executed on port 5",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa1",
         "EventName": "UOPS_DISPATCHED.PORT_5",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts, on the per-thread basis, cycles duri=
ng which at least one uop is dispatched from the Reservation Station (RS) t=
o port 5.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x20"
     },
     {
         "BriefDescription": "Number of uops executed on port 6",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa1",
         "EventName": "UOPS_DISPATCHED.PORT_6",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts, on the per-thread basis, cycles duri=
ng which at least one uop is dispatched from the Reservation Station (RS) t=
o port 6.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x40"
     },
     {
         "BriefDescription": "Number of uops executed on port 7 and 8",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa1",
         "EventName": "UOPS_DISPATCHED.PORT_7_8",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts, on the per-thread basis, cycles duri=
ng which at least one uop is dispatched from the Reservation Station (RS) t=
o ports 7 and 8.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x80"
     },
     {
         "BriefDescription": "Number of uops executed on the core.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of uops executed from any =
thread.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Cycles at least 1 micro-op is executed from a=
ny thread on physical core.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles when at least 1 micro-op is ex=
ecuted from any thread on physical core.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Cycles at least 2 micro-op is executed from a=
ny thread on physical core.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "2",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_2",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles when at least 2 micro-ops are =
executed from any thread on physical core.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Cycles at least 3 micro-op is executed from a=
ny thread on physical core.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "3",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_3",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles when at least 3 micro-ops are =
executed from any thread on physical core.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Cycles at least 4 micro-op is executed from a=
ny thread on physical core.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_4",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles when at least 4 micro-ops are =
executed from any thread on physical core.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Cycles where at least 1 uop was executed per-=
thread",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Cycles where at least 1 uop was executed per=
-thread.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Cycles where at least 2 uops were executed pe=
r-thread",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "2",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_2",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Cycles where at least 2 uops were executed p=
er-thread.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Cycles where at least 3 uops were executed pe=
r-thread",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "3",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_3",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Cycles where at least 3 uops were executed p=
er-thread.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Cycles where at least 4 uops were executed pe=
r-thread",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_4",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Cycles where at least 4 uops were executed p=
er-thread.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts number of cycles no uops were dispatch=
ed to be executed on this thread.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.STALL_CYCLES",
         "Invert": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles during which no uops were disp=
atched from the Reservation Station (RS) per thread.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of uops to be executed per-=
thread each cycle.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.THREAD",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of x87 uops dispatched.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.X87",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of x87 uops executed.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Uops that RAT issues to RS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x0e",
         "EventName": "UOPS_ISSUED.ANY",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of uops that the Resource =
Allocation Table (RAT) issues to the Reservation Station (RS).",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Cycles when RAT does not issue Uops to RS for=
 the thread",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.STALL_CYCLES",
         "Invert": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles during which the Resource Allo=
cation Table (RAT) does not issue any Uops to the reservation station (RS) =
for the current thread.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Uops inserted at issue-stage in order to pres=
erve upper bits of vector registers.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x0e",
         "EventName": "UOPS_ISSUED.VECTOR_WIDTH_MISMATCH",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of Blend Uops issued by th=
e Resource Allocation Table (RAT) to the reservation station (RS) in order =
to preserve upper bits of vector registers. Starting with the Skylake micro=
architecture, these Blend uops are needed since every Intel SSE instruction=
 executed in Dirty Upper State needs to preserve bits 128-255 of the destin=
ation register. For more information, refer to Mixing Intel AVX and Intel S=
SE Code section of the Optimization Guide.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Retirement slots used.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.SLOTS",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the retirement slots used each cycle.=
",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Cycles without actually retired uops.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.STALL_CYCLES",
         "Invert": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "This event counts cycles without actually re=
tired uops.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Cycles with less than 10 actually retired uop=
s.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "10",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.TOTAL_CYCLES",
         "Invert": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of cycles using always tru=
e condition (uops_ret &amp;lt; 16) applied to non PEBS uops retired event."=
,
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
diff --git a/tools/perf/pmu-events/arch/x86/icelake/uncore-other.json b/too=
ls/perf/pmu-events/arch/x86/icelake/uncore-other.json
index e007b976547d..f7aff8818f46 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/uncore-other.json
@@ -1,31 +1,25 @@
 [
     {
         "BriefDescription": "Number of entries allocated. Account for Any =
type: e.g. Snoop,  etc.",
-        "Counter": "1",
         "EventCode": "0x84",
         "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
         "PerPkg": "1",
-        "PublicDescription": "Number of entries allocated. Account for Any=
 type: e.g. Snoop,  etc.",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "ARB"
     },
     {
         "BriefDescription": "Total number of all outgoing entries allocate=
d. Accounts for Coherent and non-coherent traffic.",
-        "Counter": "1",
         "EventCode": "0x81",
         "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
         "PerPkg": "1",
-        "PublicDescription": "Total number of all outgoing entries allocat=
ed. Accounts for Coherent and non-coherent traffic.",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "ARB"
     },
     {
         "BriefDescription": "UNC_CLOCK.SOCKET",
-        "Counter": "FIXED",
         "EventCode": "0xff",
         "EventName": "UNC_CLOCK.SOCKET",
         "PerPkg": "1",
-        "PublicDescription": "UNC_CLOCK.SOCKET",
         "Unit": "CLOCK"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/icelake/virtual-memory.json b/t=
ools/perf/pmu-events/arch/x86/icelake/virtual-memory.json
index 58809e16bf98..b28f62ce1f39 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/virtual-memory.json
@@ -1,245 +1,165 @@
 [
     {
         "BriefDescription": "Loads that miss the DTLB and hit the STLB.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts loads that miss the DTLB (Data TLB) a=
nd hit the STLB (Second level TLB).",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x20"
     },
     {
         "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for a demand load.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_ACTIVE",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a demand load.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Load miss in all TLB levels causes a page wal=
k that completes. (All page sizes)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data loads. This implies it missed in the DTLB and furth=
er levels of TLB. The page walk can end with or without a fault.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0xe"
     },
     {
         "BriefDescription": "Page walks completed due to a demand data loa=
d to a 2M/4M page.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data loads. This implies address translations missed in the=
 DTLB and further levels of TLB. The page walk can end with or without a fa=
ult.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Page walks completed due to a demand data loa=
d to a 4K page.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Number of page walks outstanding for a demand=
 load in the PMH each cycle.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_PENDING",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks outstanding =
for a demand load in the PMH (Page Miss Handler) each cycle.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Stores that miss the DTLB and hit the STLB.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.STLB_HIT",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts stores that miss the DTLB (Data TLB) =
and hit the STLB (2nd Level TLB).",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x20"
     },
     {
         "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for a store.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_ACTIVE",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a store.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Store misses in all TLB levels causes a page =
walk that completes. (All page sizes)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data stores. This implies it missed in the DTLB and furt=
her levels of TLB. The page walk can end with or without a fault.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0xe"
     },
     {
         "BriefDescription": "Page walks completed due to a demand data sto=
re to a 2M/4M page.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data stores. This implies address translations missed in th=
e DTLB and further levels of TLB. The page walk can end with or without a f=
ault.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Page walks completed due to a demand data sto=
re to a 4K page.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Number of page walks outstanding for a store =
in the PMH each cycle.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_PENDING",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks outstanding =
for a store in the PMH (Page Miss Handler) each cycle.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Instruction fetch requests that miss the ITLB=
 and hit the STLB.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.STLB_HIT",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts instruction fetch requests that miss =
the ITLB (Instruction TLB) and hit the STLB (Second-level TLB).",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x20"
     },
     {
         "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for code (instruction fetch) request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_ACTIVE",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a code (instruction fetch) request=
.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (All page sizes)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks (all page sizes)=
 caused by a code fetch. This implies it missed in the ITLB (Instruction TL=
B) and further levels of TLB. The page walk can end with or without a fault=
.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0xe"
     },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (2M/4M)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks (2M/4M page size=
s) caused by a code fetch. This implies it missed in the ITLB (Instruction =
TLB) and further levels of TLB. The page walk can end with or without a fau=
lt.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (4K)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks (4K page sizes) =
caused by a code fetch. This implies it missed in the ITLB (Instruction TLB=
) and further levels of TLB. The page walk can end with or without a fault.=
",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Number of page walks outstanding for an outst=
anding code request in the PMH each cycle.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_PENDING",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks outstanding =
for an outstanding code (instruction fetch) request in the PMH (Page Miss H=
andler) each cycle.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "DTLB flush attempts of the thread-specific en=
tries",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "TLB_FLUSH.DTLB_THREAD",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of DTLB flush attempts of =
the thread-specific entries.",
         "SampleAfterValue": "100007",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "STLB flush attempts",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "TLB_FLUSH.STLB_ANY",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of any STLB flush attempts=
 (such as entire, VPID, PCID, InvPage, CR3 write, etc.).",
         "SampleAfterValue": "100007",
-        "Speculative": "1",
         "UMask": "0x20"
     }
 ]
--=20
2.39.0.314.g84b9a713c41-goog

