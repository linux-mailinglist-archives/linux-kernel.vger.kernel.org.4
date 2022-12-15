Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB65064D6B9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 07:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiLOGzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 01:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLOGze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:55:34 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2D426B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:55:30 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3cf0762f741so25321377b3.16
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a/q6ShL2jvHljNNJiaHTwvy+rS7mXspYdNT4ob+H60M=;
        b=XZaW3AMTmP2dk7AoomN06rneGrGMfBBBlRzOlAMC57aCz95Qfz9hZ86YE7q+5t72Mr
         hh8+v9gvrdkpwaCBzsTBRLWvvvYixLetN6gNSjyn/wrSSzNzmLH42xOacEzeW+n9+dLT
         CgTfdVEnJ+R7PR+hQfbokqJaRazBHXDcG4OR6abz4QW0pfOZO0EG2Ecp+WvNLK0R7phw
         20Ylfuk8jMAU2aslN5PczfCJXIhjIMB2oJ1GWA7dGQU8GIyDkoxPAWsSE12QWTNZgrZk
         kCFLSIVnm2a2rkFL9L9t9iAxjmkHnrYbYBZCnpxP0LqQ4YBmrQL8VdSyCcD0G+7XDbF0
         8Faw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/q6ShL2jvHljNNJiaHTwvy+rS7mXspYdNT4ob+H60M=;
        b=59Pr98XObB4m5RQWjsYW5raXqIH1iY+6gd2n0tREaYUn5O0WQn3bsw/gcgLx3La2Ri
         j0fmWGXoL1xHEfkZFUtJKlzuPoR6pbpvxl/9PwNJ7sm4wIjYNzyGn0J/U8dQlhwz3oHt
         c24r7XG8qJ1Elv0z8yh+ppYGW9b9jR6XV5n1WqYxOKO+Vb42y3Q8qYhEQYOf43VBcsDw
         ++kGpa3cKSNE6XbRt3o5pSvV16cqn3Qfk8APJzFxYAfRwB1ncGIGb2xfuS19KgYxVBNA
         /G8mZSvrE7AO2zNEwIuiqI2LeXr4KWrFBu/Gozi8L+R27XVokEq++6/pLN/RSRKWbU6K
         6cwg==
X-Gm-Message-State: ANoB5pn8Pl7ceczpJz9DSI6vebpJKlkympXXOceQU3WoHFBgTH9gYSU7
        ZkrTQT6mrVPXFBN68Efb8nQmaQpEmpfK
X-Google-Smtp-Source: AA0mqf5XR/Ty48jMyb3IB4sbzO/xkbd+pSbF9Cmtj/O/SXCXYLV6gWNMR14+REPEtTloxCXiav0EZn56FUyc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c7dc:d96f:4f9:f59d])
 (user=irogers job=sendgmr) by 2002:a81:692:0:b0:35c:485d:4966 with SMTP id
 140-20020a810692000000b0035c485d4966mr15087283ywg.494.1671087329690; Wed, 14
 Dec 2022 22:55:29 -0800 (PST)
Date:   Wed, 14 Dec 2022 22:54:47 -0800
Message-Id: <20221215065510.1621979-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 09/32] perf vendor events intel: Refresh elkhartlake events
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

Update the elkhartlake events using the new tooling from:
https://github.com/intel/perfmon
The events are unchanged but unused json values are removed. This
increases consistency across the json files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/elkhartlake/cache.json           | 252 ------------------
 .../arch/x86/elkhartlake/floating-point.json  |  11 -
 .../arch/x86/elkhartlake/frontend.json        |  36 ---
 .../arch/x86/elkhartlake/memory.json          |  84 ------
 .../arch/x86/elkhartlake/other.json           | 143 ----------
 .../arch/x86/elkhartlake/pipeline.json        | 213 ---------------
 .../arch/x86/elkhartlake/virtual-memory.json  | 117 --------
 7 files changed, 856 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/cache.json b/tools/=
perf/pmu-events/arch/x86/elkhartlake/cache.json
index d674ee88c3a5..0ab90e3bf76b 100644
--- a/tools/perf/pmu-events/arch/x86/elkhartlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/elkhartlake/cache.json
@@ -1,1137 +1,885 @@
 [
     {
         "BriefDescription": "Counts the number of core requests (demand an=
d L1 prefetchers) rejected by the L2 queue (L2Q) due to a full condition.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "CORE_REJECT_L2Q.ANY",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of (demand and L1 prefetch=
ers) core requests rejected by the L2 queue (L2Q) due to a full or nearly f=
ull condition, which likely indicates back pressure from L2Q.  It also coun=
ts requests that would have gone directly to the External Queue (XQ), but a=
re rejected due to a full or nearly full condition, indicating back pressur=
e from the IDI link.  The L2Q may also reject transactions  from a core to =
ensure fairness between cores, or to delay a cores dirty eviction when the =
address conflicts incoming external snoops.  (Note that L2 prefetcher reque=
sts that are dropped are not counted by this event).  Counts on a per core =
basis.",
         "SampleAfterValue": "200003"
     },
     {
         "BriefDescription": "Counts the number of L1D cacheline (dirty) ev=
ictions caused by load misses, stores, and prefetches.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "DL1.DIRTY_EVICTION",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of L1D cacheline (dirty) e=
victions caused by load misses, stores, and prefetches.  Does not count evi=
ctions or dirty writebacks caused by snoops.  Does not count a replacement =
unless a (dirty) line was written back.",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of demand and prefetch tran=
sactions that the External Queue (XQ) rejects due to a full or near full co=
ndition.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x30",
         "EventName": "L2_REJECT_XQ.ANY",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of demand and prefetch tra=
nsactions that the External Queue (XQ) rejects due to a full or near full c=
ondition which likely indicates back pressure from the IDI link.  The XQ ma=
y reject transactions from the L2Q (non-cacheable requests), BBL (L2 misses=
) and WOB (L2 write-back victims).",
         "SampleAfterValue": "200003"
     },
     {
         "BriefDescription": "Counts the total number of L2 Cache accesses.=
 Counts on a per core basis.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.ALL",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the total number of L2 Cache Accesses=
, includes hits, misses, rejects  front door requests for CRd/DRd/RFO/ItoM/=
L2 Prefetches only.  Counts on a per core basis.",
         "SampleAfterValue": "200003"
     },
     {
         "BriefDescription": "Counts the number of L2 Cache accesses that r=
esulted in a hit. Counts on a per core basis.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.HIT",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of L2 Cache accesses that =
resulted in a hit from a front door request only (does not include rejects =
or recycles), Counts on a per core basis.",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts the number of L2 Cache accesses that r=
esulted in a miss. Counts on a per core basis.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.MISS",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of L2 Cache accesses that =
resulted in a miss from a front door request only (does not include rejects=
 or recycles). Counts on a per core basis.",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of L2 Cache accesses that m=
iss the L2 and get rejected. Counts on a per core basis.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.REJECTS",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of L2 Cache accesses that =
miss the L2 and get BBL reject  short and long rejects (includes those coun=
ted in L2_reject_XQ.any). Counts on a per core basis.",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Counts the number of cacheable memory request=
s that miss in the LLC. Counts on a per core basis.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.MISS",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of cacheable memory reques=
ts that miss in the Last Level Cache (LLC). Requests include demand loads, =
reads for ownership (RFO), instruction fetches and L1 HW prefetches. If the=
 platform has an L3 cache, the LLC is the L3 cache, otherwise it is the L2 =
cache. Counts on a per core basis.",
         "SampleAfterValue": "200003",
         "UMask": "0x41"
     },
     {
         "BriefDescription": "Counts the number of cacheable memory request=
s that access the LLC. Counts on a per core basis.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of cacheable memory reques=
ts that access the Last Level Cache (LLC). Requests include demand loads, r=
eads for ownership (RFO), instruction fetches and L1 HW prefetches. If the =
platform has an L3 cache, the LLC is the L3 cache, otherwise it is the L2 c=
ache. Counts on a per core basis.",
         "SampleAfterValue": "200003",
         "UMask": "0x4f"
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which hit in the L2, LLC, DRAM o=
r MMIO (Non-DRAM).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.IFETCH",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x38"
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which hit in DRAM or MMIO (Non-D=
RAM).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.IFETCH_DRAM_HIT",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of cycles the core is stal=
led due to an instruction cache or translation lookaside buffer (TLB) miss =
which hit in DRAM or MMIO (non-DRAM).",
         "SampleAfterValue": "200003",
         "UMask": "0x20"
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which hit in the L2 cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.IFETCH_L2_HIT",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of cycles the core is stal=
led due to an instruction cache or Translation Lookaside Buffer (TLB) miss =
which hit in the L2 cache.",
         "SampleAfterValue": "200003",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which hit in the LLC or other co=
re with HITE/F/M.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.IFETCH_LLC_HIT",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of cycles the core is stal=
led due to an instruction cache or Translation Lookaside Buffer (TLB) miss =
which hit in the Last Level Cache (LLC) or other core with HITE/F/M.",
         "SampleAfterValue": "200003",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load miss which hit in the L2, LLC, DRAM or MMIO (Non-DR=
AM).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.LOAD",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x7"
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load miss which hit in DRAM or MMIO (Non-DRAM).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.LOAD_DRAM_HIT",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load which hit in the L2 cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.LOAD_L2_HIT",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load which hit in the LLC or other core with HITE/F/M.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.LOAD_LLC_HIT",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of cycles the core is stal=
led due to a demand load which hit in the Last Level Cache (LLC) or other c=
ore with HITE/F/M.",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a store buffer being full.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.STORE_BUFFER_FULL",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x40"
     },
     {
         "BriefDescription": "Counts the number of load uops retired that h=
it in DRAM.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.DRAM_HIT",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x80"
     },
     {
         "BriefDescription": "Counts the number of load uops retired that h=
it in the L3 cache, in which a snoop was required and modified data was for=
warded from another core or module.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.HITM",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x20"
     },
     {
         "BriefDescription": "Counts the number of load uops retired that h=
it in the L1 data cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_HIT",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of load uops retired that m=
iss in the L1 data cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_MISS",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Counts the number of load uops retired that h=
it in the L2 cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts the number of load uops retired that m=
iss in the L2 cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_MISS",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Counts the number of load uops retired that h=
it in the L3 cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L3_HIT",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Counts the number of memory uops retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.ALL",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of memory uops retired.  A=
 single uop that performs both a load AND a store will be counted as 1, not=
 2 (e.g. ADD [mem], CONST)",
         "SampleAfterValue": "200003",
         "UMask": "0x83"
     },
     {
         "BriefDescription": "Counts the number of load uops retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the total number of load uops retired=
.",
         "SampleAfterValue": "200003",
         "UMask": "0x81"
     },
     {
         "BriefDescription": "Counts the number of store uops retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the total number of store uops retire=
d.",
         "SampleAfterValue": "200003",
         "UMask": "0x82"
     },
     {
         "BriefDescription": "Counts the number of load uops retired that p=
erformed one or more locks.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOCK_LOADS",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x21"
     },
     {
         "BriefDescription": "Counts the number of memory uops retired that=
 were splits.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x43"
     },
     {
         "BriefDescription": "Counts the number of retired split load uops.=
",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x41"
     },
     {
         "BriefDescription": "Counts the number of retired split store uops=
.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x42"
     },
     {
         "BriefDescription": "Counts all code reads that were supplied by t=
he L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.ALL_CODE_RD.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1F803C0044",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all code reads that were supplied by t=
he L3 cache where a snoop was sent, the snoop hit, and modified data was fo=
rwarded.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.ALL_CODE_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0044",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all code reads that were supplied by t=
he L3 cache where a snoop was sent, the snoop hit, but no data was forwarde=
d.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.ALL_CODE_RD.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0044",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all code reads that were supplied by t=
he L3 cache where a snoop was sent, the snoop hit, and non-modified data wa=
s forwarded.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.ALL_CODE_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0044",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all code reads that were supplied by t=
he L3 cache where a snoop was sent but the snoop missed.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.ALL_CODE_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0044",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all code reads that were supplied by t=
he L3 cache where no snoop was needed to satisfy the request.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.ALL_CODE_RD.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0044",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts modified writebacks from L1 cache and =
L2 cache that were supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.COREWB_M.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3001F803C0000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_CODE_RD.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1F803C0004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by the L3 cache where a snoop w=
as sent, the snoop hit, and modified data was forwarded.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by the L3 cache where a snoop w=
as sent, the snoop hit, but no data was forwarded.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by the L3 cache where a snoop w=
as sent, the snoop hit, and non-modified data was forwarded.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by the L3 cache where a snoop w=
as sent but the snoop missed.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by the L3 cache where no snoop =
was needed to satisfy the request.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1F803C0001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re supplied by the L3 cache where a snoop was sent, the snoop hit, and modi=
fied data was forwarded.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re supplied by the L3 cache where a snoop was sent, the snoop hit, but no d=
ata was forwarded.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HIT_NO_FWD"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re supplied by the L3 cache where a snoop was sent, the snoop hit, and non-=
modified data was forwarded.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HIT_WITH_FW=
D",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re supplied by the L3 cache where a snoop was sent but the snoop missed.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re supplied by the L3 cache where no snoop was needed to satisfy the reques=
t.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_NOT_NEEDED"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1F803C0001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HITM",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HIT_NO_FWD",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_MISS",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_NOT_NEEDED",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_RFO.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1F803C0002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and modified data was=
 forwarded.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, but no data was forwa=
rded.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and non-modified data=
 was forwarded.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache where a snoop was sent but the snoop missed.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache where no snoop was needed to satisfy the request.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts streaming stores which modify a full 6=
4 byte cacheline that were supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.FULL_STREAMING_WR.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x801F803C0000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L1 data cache hardware prefetches and =
software prefetches (except PREFETCHW and PFRFO) that were supplied by the =
L3 cache where a snoop was sent, the snoop hit, and modified data was forwa=
rded.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L1D_AND_SWPF.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0400",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1F803C0040",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were supplied by the L3 cache where a s=
noop was sent, the snoop hit, and modified data was forwarded.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0040",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were supplied by the L3 cache where a s=
noop was sent, the snoop hit, but no data was forwarded.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0040",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were supplied by the L3 cache where a s=
noop was sent, the snoop hit, and non-modified data was forwarded.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0040",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were supplied by the L3 cache where a s=
noop was sent but the snoop missed.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0040",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were supplied by the L3 cache where no =
snoop was needed to satisfy the request.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0040",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1F803C0010",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were supplied by the L3 cache where a s=
noop was sent, the snoop hit, and modified data was forwarded.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0010",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were supplied by the L3 cache where a s=
noop was sent, the snoop hit, but no data was forwarded.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0010",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were supplied by the L3 cache where a s=
noop was sent, the snoop hit, and non-modified data was forwarded.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0010",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were supplied by the L3 cache where a s=
noop was sent but the snoop missed.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0010",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were supplied by the L3 cache where no =
snoop was needed to satisfy the request.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0010",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_RFO.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1F803C0020",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were supplied by the L3 cache where a snoop w=
as sent, the snoop hit, and modified data was forwarded.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0020",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were supplied by the L3 cache where a snoop w=
as sent, the snoop hit, but no data was forwarded.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0020",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were supplied by the L3 cache where a snoop w=
as sent, the snoop hit, and non-modified data was forwarded.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0020",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were supplied by the L3 cache where a snoop w=
as sent but the snoop missed.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0020",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were supplied by the L3 cache where no snoop =
was needed to satisfy the request.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0020",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts modified writebacks from L1 cache that=
 miss the L2 cache that were supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.L1WB_M.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1001F803C0000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts modified writeBacks from L2 cache that=
 miss the L3 cache that were supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.L2WB_M.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2001F803C0000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts streaming stores which modify only par=
t of a 64 byte cacheline that were supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.PARTIAL_STREAMING_WR.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x401F803C0000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.READS_TO_CORE.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1F803C0477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by the L3 cache where a snoop was sent, the snoop hit, and modif=
ied data was forwarded.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by the L3 cache where a snoop was sent, the snoop hit, but no da=
ta was forwarded.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by the L3 cache where a snoop was sent, the snoop hit, and non-m=
odified data was forwarded.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by the L3 cache where a snoop was sent but the snoop missed.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by the L3 cache where no snoop was needed to satisfy the request=
.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts streaming stores that were supplied by=
 the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.STREAMING_WR.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1F803C0800",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts uncached memory reads that were suppli=
ed by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.UC_RD.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x101F803C0000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts uncached memory reads that were suppli=
ed by the L3 cache where a snoop was sent, the snoop hit, and modified data=
 was forwarded.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.UC_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1010003C0000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts uncached memory reads that were suppli=
ed by the L3 cache where a snoop was sent, the snoop hit, but no data was f=
orwarded.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.UC_RD.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004003C0000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts uncached memory reads that were suppli=
ed by the L3 cache where a snoop was sent, the snoop hit, and non-modified =
data was forwarded.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.UC_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1008003C0000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts uncached memory reads that were suppli=
ed by the L3 cache where a snoop was sent but the snoop missed.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.UC_RD.L3_HIT.SNOOP_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1002003C0000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts uncached memory reads that were suppli=
ed by the L3 cache where no snoop was needed to satisfy the request.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.UC_RD.L3_HIT.SNOOP_NOT_NEEDED",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1001003C0000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts uncached memory writes that were suppl=
ied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.UC_WR.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x201F803C0000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to instruction cache misses.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.ICACHE",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x20"
     }
diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/floating-point.json=
 b/tools/perf/pmu-events/arch/x86/elkhartlake/floating-point.json
index 2e1b80c714fd..88522244b760 100644
--- a/tools/perf/pmu-events/arch/x86/elkhartlake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/elkhartlake/floating-point.json
@@ -1,36 +1,25 @@
 [
     {
         "BriefDescription": "Counts the number of cycles the floating poin=
t divider is busy.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xcd",
         "EventName": "CYCLES_DIV_BUSY.FPDIV",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of cycles the floating poi=
nt divider is busy.  Does not imply a stall waiting for the divider.",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts the number of floating point operation=
s retired that required microcode assist.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.FP_ASSIST",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of floating point operatio=
ns retired that required microcode assist, which is not a reflection of the=
 number of FP operations, instructions or uops.",
         "SampleAfterValue": "20003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Counts the number of floating point divide uo=
ps retired (x87 and SSE, including x87 sqrt).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.FPDIV",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     }
diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/frontend.json b/too=
ls/perf/pmu-events/arch/x86/elkhartlake/frontend.json
index 5d938a5dafcf..5ba998e06592 100644
--- a/tools/perf/pmu-events/arch/x86/elkhartlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/elkhartlake/frontend.json
@@ -1,103 +1,67 @@
 [
     {
         "BriefDescription": "Counts the total number of BACLEARS due to al=
l branch types including conditional and unconditional jumps, returns, and =
indirect branches.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xe6",
         "EventName": "BACLEARS.ANY",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the total number of BACLEARS, which o=
ccur when the Branch Target Buffer (BTB) prediction or lack thereof, was co=
rrected by a later branch predictor in the frontend.  Includes BACLEARS due=
 to all branch types including conditional and unconditional jumps, returns=
, and indirect branches.",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of BACLEARS due to a condit=
ional jump.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xe6",
         "EventName": "BACLEARS.COND",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Counts the number of BACLEARS due to an indir=
ect branch.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xe6",
         "EventName": "BACLEARS.INDIRECT",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts the number of BACLEARS due to a return=
 branch.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xe6",
         "EventName": "BACLEARS.RETURN",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Counts the number of BACLEARS due to a direct=
, unconditional jump.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xe6",
         "EventName": "BACLEARS.UNCOND",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Counts the number of times a decode restricti=
on reduces the decode throughput due to wrong instruction length prediction=
.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xe9",
         "EventName": "DECODE_RESTRICTION.PREDECODE_WRONG",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of requests to the instruct=
ion cache for one or more bytes of a cache line.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "ICACHE.ACCESSES",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the total number of requests to the i=
nstruction cache.  The event only counts new cache line accesses, so that m=
ultiple back to back fetches to the exact same cache line or byte chunk cou=
nt as one.  Specifically, the event counts when accesses from sequential co=
de crosses the cache line boundary, or when a branch target is moved to a n=
ew line or to a non-sequential byte chunk of the same line.",
         "SampleAfterValue": "200003",
         "UMask": "0x3"
     },
     {
         "BriefDescription": "Counts the number of instruction cache hits."=
,
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "ICACHE.HIT",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of requests that hit in th=
e instruction cache.  The event only counts new cache line accesses, so tha=
t multiple back to back fetches to the exact same cache line and byte chunk=
 count as one.  Specifically, the event counts when accesses from sequentia=
l code crosses the cache line boundary, or when a branch target is moved to=
 a new line or to a non-sequential byte chunk of the same line.",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of instruction cache misses=
.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "ICACHE.MISSES",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of missed requests to the =
instruction cache.  The event only counts new cache line accesses, so that =
multiple back to back fetches to the exact same cache line and byte chunk c=
ount as one.  Specifically, the event counts when accesses from sequential =
code crosses the cache line boundary, or when a branch target is moved to a=
 new line or to a non-sequential byte chunk of the same line.",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/memory.json b/tools=
/perf/pmu-events/arch/x86/elkhartlake/memory.json
index 15eba23796e4..18621909d1a9 100644
--- a/tools/perf/pmu-events/arch/x86/elkhartlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/elkhartlake/memory.json
@@ -1,441 +1,357 @@
 [
     {
         "BriefDescription": "Counts the number of machine clears due to me=
mory ordering caused by a snoop from an external agent. Does not count inte=
rnally generated machine clears such as those due to memory disambiguation.=
",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "20003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts the number of misaligned load uops tha=
t are 4K page splits.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "MISALIGN_MEM_REF.LOAD_PAGE_SPLIT",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts the number of misaligned store uops th=
at are 4K page splits.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "MISALIGN_MEM_REF.STORE_PAGE_SPLIT",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Counts all code reads that were not supplied =
by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.ALL_CODE_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000044",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all code reads that were not supplied =
by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.ALL_CODE_RD.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000044",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts modified writebacks from L1 cache and =
L2 cache that were not supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.COREWB_M.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3002184000000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts modified writebacks from L1 cache and =
L2 cache that were not supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.COREWB_M.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3002184000000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were not supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_CODE_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were not supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_CODE_RD.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re not supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re not supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.L3_MISS",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.L3_MISS_LOCAL",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were not suppli=
ed by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were not suppli=
ed by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_RFO.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts streaming stores which modify a full 6=
4 byte cacheline that were not supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.FULL_STREAMING_WR.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x802184000000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts streaming stores which modify a full 6=
4 byte cacheline that were not supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.FULL_STREAMING_WR.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x802184000000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were not supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_CODE_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000040",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were not supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_CODE_RD.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000040",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were not supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000010",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were not supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_DATA_RD.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000010",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were not supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000020",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were not supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_RFO.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000020",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts modified writebacks from L1 cache that=
 miss the L2 cache that were not supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.L1WB_M.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1002184000000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts modified writebacks from L1 cache that=
 miss the L2 cache that were not supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.L1WB_M.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1002184000000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts modified writeBacks from L2 cache that=
 miss the L3 cache that were not supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.L2WB_M.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2002184000000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts modified writeBacks from L2 cache that=
 miss the L3 cache that were not supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.L2WB_M.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2002184000000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts miscellaneous requests, such as I/O ac=
cesses, that were not supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.OTHER.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184008000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts miscellaneous requests, such as I/O ac=
cesses, that were not supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.OTHER.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184008000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts streaming stores which modify only par=
t of a 64 byte cacheline that were not supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.PARTIAL_STREAMING_WR.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x402184000000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts streaming stores which modify only par=
t of a 64 byte cacheline that were not supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.PARTIAL_STREAMING_WR.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x402184000000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all hardware and software prefetches t=
hat were not supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.PREFETCHES.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000470",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e not supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.READS_TO_CORE.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e not supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.READS_TO_CORE.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts streaming stores that were not supplie=
d by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.STREAMING_WR.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000800",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts streaming stores that were not supplie=
d by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.STREAMING_WR.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2184000800",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts uncached memory reads that were not su=
pplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.UC_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x102184000000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts uncached memory reads that were not su=
pplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.UC_RD.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x102184000000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts uncached memory writes that were not s=
upplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.UC_WR.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x202184000000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts uncached memory writes that were not s=
upplied by the L3 cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.UC_WR.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x202184000000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     }
diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/other.json b/tools/=
perf/pmu-events/arch/x86/elkhartlake/other.json
index 4a1b7cc5aa23..00ae180ded25 100644
--- a/tools/perf/pmu-events/arch/x86/elkhartlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/elkhartlake/other.json
@@ -1,674 +1,531 @@
 [
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BUS_LOCK.SELF_LOCKS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EdgeDetect": "1",
         "EventCode": "0x63",
         "EventName": "BUS_LOCK.ALL",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003"
     },
     {
         "BriefDescription": "Counts the number of unhalted cycles a core i=
s blocked due to an accepted lock issued by other cores.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x63",
         "EventName": "BUS_LOCK.BLOCK_CYCLES",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of unhalted cycles a core =
is blocked due to an accepted lock issued by other cores. Counts on a per c=
ore basis.",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BUS_LOCK.BLOCK_CYCLES",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x63",
         "EventName": "BUS_LOCK.CYCLES_OTHER_BLOCK",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BUS_LOCK.LOCK_CYCLES",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x63",
         "EventName": "BUS_LOCK.CYCLES_SELF_BLOCK",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of unhalted cycles a core i=
s blocked due to an accepted lock it issued.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x63",
         "EventName": "BUS_LOCK.LOCK_CYCLES",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of unhalted cycles a core =
is blocked due to an accepted lock it issued. Counts on a per core basis.",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of bus locks a core issued =
its self (e.g. lock to UC or Split Lock) and does not include cache locks."=
,
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EdgeDetect": "1",
         "EventCode": "0x63",
         "EventName": "BUS_LOCK.SELF_LOCKS",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of bus locks a core issued=
 its self (e.g. lock to UC or Split Lock) and does not include cache locks.=
 Counts on a per core basis.",
         "SampleAfterValue": "200003"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
MEM_BOUND_STALLS.LOAD_DRAM_HIT",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "C0_STALLS.LOAD_DRAM_HIT",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
MEM_BOUND_STALLS.LOAD_L2_HIT",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "C0_STALLS.LOAD_L2_HIT",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
MEM_BOUND_STALLS.LOAD_LLC_HIT",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "C0_STALLS.LOAD_LLC_HIT",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts the number of core cycles during which=
 interrupts are masked (disabled).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xcb",
         "EventName": "HW_INTERRUPTS.MASKED",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of core cycles during whic=
h interrupts are masked (disabled). Increments by 1 each core cycle that EF=
LAGS.IF is 0, regardless of whether interrupts are pending or not.",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts the number of core cycles during which=
 there are pending interrupts while interrupts are masked (disabled).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xcb",
         "EventName": "HW_INTERRUPTS.PENDING_AND_MASKED",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of core cycles during whic=
h there are pending interrupts while interrupts are masked (disabled). Incr=
ements by 1 each core cycle that both EFLAGS.IF is 0 and an INTR is pending=
 (which means the APIC is telling the ROB to cause an INTR). This event doe=
s not increment if EFLAGS.IF is 0 but all interrupt in the APICs Interrupt =
Request Register (IRR) are inhibited by the PPR (thus either by ISRV or TPR=
)  because in these cases the interrupts would be held up in the APIC and w=
ould not be pended to the ROB. This event does count when an interrupt is o=
nly inhibited by MOV/POP SS state machines or the STI state machine. These =
extra inhibits only last for a single instructions and would not be importa=
nt.",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Counts the number of hardware interrupts rece=
ived by the processor.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xcb",
         "EventName": "HW_INTERRUPTS.RECEIVED",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "203",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all code reads that have any type of r=
esponse.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.ALL_CODE_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10044",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all code reads that were supplied by D=
RAM.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.ALL_CODE_RD.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000044",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all code reads that were supplied by D=
RAM.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.ALL_CODE_RD.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000044",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all code reads that have an outstandin=
g request. Returns the number of cycles until the response is received (i.e=
. XQ to XQ latency).",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.ALL_CODE_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x8000000000000044",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts modified writebacks from L1 cache and =
L2 cache that have any type of response.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.COREWB_M.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3000000010000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts modified writebacks from L1 cache and =
L2 cache that have an outstanding request. Returns the number of cycles unt=
il the response is received (i.e. XQ to XQ latency).",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.COREWB_M.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x8003000000000000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that have any type of response.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_CODE_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_CODE_RD.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_CODE_RD.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that ha=
ve any type of response.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re supplied by DRAM.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re supplied by DRAM.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that ha=
ve an outstanding request. Returns the number of cycles until the response =
is received (i.e. XQ to XQ latency).",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x8000000000000001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.ANY_RESPONSE",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.DRAM",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_RD.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.LOCAL_DRAM",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.OUTSTANDING",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x8000000000000001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have any type o=
f response.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y DRAM.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_RFO.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y DRAM.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_RFO.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have an outstan=
ding request. Returns the number of cycles until the response is received (=
i.e. XQ to XQ latency).",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_RFO.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x8000000000000002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts streaming stores which modify a full 6=
4 byte cacheline that have any type of response.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.FULL_STREAMING_WR.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800000010000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L1 data cache hardware prefetches and =
software prefetches (except PREFETCHW and PFRFO) that have any type of resp=
onse.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L1D_AND_SWPF.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10400",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that have any type of response.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_CODE_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10040",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were supplied by DRAM.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_CODE_RD.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000040",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were supplied by DRAM.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_CODE_RD.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000040",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that have an outstanding request. Returns th=
e number of cycles until the response is received (i.e. XQ to XQ latency)."=
,
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_CODE_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x8000000000000040",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that have any type of response.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10010",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were supplied by DRAM.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_DATA_RD.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000010",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were supplied by DRAM.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_DATA_RD.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000010",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that have any type of response.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10020",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were supplied by DRAM.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_RFO.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000020",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were supplied by DRAM.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_RFO.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000020",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that have an outstanding request. Returns the numb=
er of cycles until the response is received (i.e. XQ to XQ latency).",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.HWPF_L2_RFO.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x8000000000000020",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts modified writebacks from L1 cache that=
 miss the L2 cache that have any type of response.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.L1WB_M.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000000010000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts modified writeBacks from L2 cache that=
 miss the L3 cache that have any type of response.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.L2WB_M.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000000010000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts miscellaneous requests, such as I/O ac=
cesses, that have any type of response.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.OTHER.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x18000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts streaming stores which modify only par=
t of a 64 byte cacheline that have any type of response.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.PARTIAL_STREAMING_WR.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400000010000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all hardware and software prefetches t=
hat have any type of response.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.PREFETCHES.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10470",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that hav=
e any type of response.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.READS_TO_CORE.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by DRAM.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.READS_TO_CORE.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by DRAM.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.READS_TO_CORE.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x184000477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that hav=
e an outstanding request. Returns the number of cycles until the response i=
s received (i.e. XQ to XQ latency).",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.READS_TO_CORE.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x8000000000000477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10800",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts uncached memory reads that have any ty=
pe of response.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.UC_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100000010000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts uncached memory reads that were suppli=
ed by DRAM.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.UC_RD.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100184000000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts uncached memory reads that were suppli=
ed by DRAM.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.UC_RD.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100184000000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts uncached memory reads that have an out=
standing request. Returns the number of cycles until the response is receiv=
ed (i.e. XQ to XQ latency).",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.UC_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x8000100000000000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts uncached memory writes that have any t=
ype of response.",
-        "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.UC_WR.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200000010000",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     }
diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/elkhartlake/pipeline.json
index 09919fdb9a38..9dd8c909facc 100644
--- a/tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json
@@ -1,662 +1,449 @@
 [
     {
         "BriefDescription": "Counts the total number of branch instruction=
s retired for all branch types.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the total number of instructions in w=
hich the instruction pointer (IP) of the processor is resteered due to a br=
anch instruction and the branch instruction successfully retires.  All bran=
ch type instructions are accounted for.",
         "SampleAfterValue": "200003"
     },
     {
         "BriefDescription": "Counts the number of near CALL branch instruc=
tions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.CALL",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0xf9"
     },
     {
         "BriefDescription": "Counts the number of far branch instructions =
retired, includes far jump, far call and return, and interrupt call and ret=
urn.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0xbf"
     },
     {
         "BriefDescription": "Counts the number of near indirect CALL branc=
h instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.IND_CALL",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0xfb"
     },
     {
         "BriefDescription": "Counts the number of retired JCC (Jump on Con=
ditional Code) branch instructions retired, includes both taken and not tak=
en branches.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.JCC",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x7e"
     },
     {
         "BriefDescription": "Counts the number of near indirect JMP and ne=
ar indirect CALL branch instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NON_RETURN_IND",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0xeb"
     },
     {
         "BriefDescription": "Counts the number of near relative CALL branc=
h instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.REL_CALL",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0xfd"
     },
     {
         "BriefDescription": "Counts the number of near RET branch instruct=
ions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.RETURN",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0xf7"
     },
     {
         "BriefDescription": "Counts the number of taken JCC (Jump on Condi=
tional Code) branch instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.TAKEN_JCC",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0xfe"
     },
     {
         "BriefDescription": "Counts the total number of mispredicted branc=
h instructions retired for all branch types.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the total number of mispredicted bran=
ch instructions retired.  All branch type instructions are accounted for.  =
Prediction of the branch target address enables the processor to begin exec=
uting instructions before the non-speculative execution path is known. The =
branch prediction unit (BPU) predicts the target address based on the instr=
uction pointer (IP) of the branch and on the execution path through which e=
xecution reached this IP.    A branch misprediction occurs when the predict=
ion is wrong, and results in discarding all instructions executed in the sp=
eculative path and re-fetching from the correct path.",
         "SampleAfterValue": "200003"
     },
     {
         "BriefDescription": "Counts the number of mispredicted near indire=
ct CALL branch instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.IND_CALL",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0xfb"
     },
     {
         "BriefDescription": "Counts the number of mispredicted JCC (Jump o=
n Conditional Code) branch instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.JCC",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x7e"
     },
     {
         "BriefDescription": "Counts the number of mispredicted near indire=
ct JMP and near indirect CALL branch instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NON_RETURN_IND",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0xeb"
     },
     {
         "BriefDescription": "Counts the number of mispredicted near RET br=
anch instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RETURN",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0xf7"
     },
     {
         "BriefDescription": "Counts the number of mispredicted taken JCC (=
Jump on Conditional Code) branch instructions retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.TAKEN_JCC",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0xfe"
     },
     {
         "BriefDescription": "Counts the total number of BTCLEARS.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xe8",
         "EventName": "BTCLEAR.ANY",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the total number of BTCLEARS which oc=
curs when the Branch Target Buffer (BTB) predicts a taken branch.",
         "SampleAfterValue": "200003"
     },
     {
         "BriefDescription": "Counts the number of unhalted core clock cycl=
es. (Fixed event)",
-        "CollectPEBSRecord": "2",
-        "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.CORE",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "33",
         "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state. The core enters the halt state when it is runni=
ng the HLT instruction. The core frequency may change from time to time. Fo=
r this reason this event may have a changing ratio with regards to time. Th=
is event uses fixed counter 1.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts the number of unhalted core clock cycl=
es.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.CORE_P",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state. The core enters the halt state when it is runni=
ng the HLT instruction. The core frequency may change from time to time. Fo=
r this reason this event may have a changing ratio with regards to time. Th=
is event uses a programmable general purpose performance counter.",
         "SampleAfterValue": "2000003"
     },
     {
         "BriefDescription": "Counts the number of unhalted reference clock=
 cycles at TSC frequency.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of reference cycles that t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction. This event is not affected by core frequency ch=
anges and increments at a fixed frequency that is also used for the Time St=
amp Counter (TSC). This event uses fixed counter 2.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of unhalted reference clock=
 cycles at TSC frequency. (Fixed event)",
-        "CollectPEBSRecord": "2",
-        "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "34",
         "PublicDescription": "Counts the number of reference cycles that t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction. This event is not affected by core frequency ch=
anges and increments at a fixed frequency that is also used for the Time St=
amp Counter (TSC). This event uses fixed counter 2.",
         "SampleAfterValue": "2000003",
         "UMask": "0x3"
     },
     {
         "BriefDescription": "Counts the number of unhalted reference clock=
 cycles at TSC frequency.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of reference cycles that t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction. This event is not affected by core frequency ch=
anges and increments at a fixed frequency that is also used for the Time St=
amp Counter (TSC). This event uses a programmable general purpose performan=
ce counter.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "This event is deprecated.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xcd",
         "EventName": "CYCLES_DIV_BUSY.ANY",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "2000003"
     },
     {
         "BriefDescription": "Counts the number of cycles the integer divid=
er is busy.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xcd",
         "EventName": "CYCLES_DIV_BUSY.IDIV",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of cycles the integer divi=
der is busy.  Does not imply a stall waiting for the divider.",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the total number of instructions retir=
ed. (Fixed event)",
-        "CollectPEBSRecord": "2",
-        "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
-        "PEBScounters": "32",
         "PublicDescription": "Counts the total number of instructions that=
 retired. For instructions that consist of multiple uops, this event counts=
 the retirement of the last uop of the instruction. This event continues co=
unting during hardware interrupts, traps, and inside interrupt handlers. Th=
is event uses fixed counter 0.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the total number of instructions retir=
ed.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.ANY_P",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the total number of instructions that=
 retired. For instructions that consist of multiple uops, this event counts=
 the retirement of the last uop of the instruction. This event continues co=
unting during hardware interrupts, traps, and inside interrupt handlers. Th=
is event uses a programmable general purpose performance counter.",
         "SampleAfterValue": "2000003"
     },
     {
         "BriefDescription": "Counts the number of retired loads that are b=
locked because it initially appears to be store forward blocked, but subseq=
uently is shown not to be blocked based on 4K alias check.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.4K_ALIAS",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Counts the number of retired loads that are b=
locked for any of the following reasons:  DTLB miss, address alias, store f=
orward or data unknown (includes memory disambiguation blocks and ESP consu=
ming load blocks).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.ALL",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Counts the number of retired loads that are b=
locked because its address exactly matches an older store whose data is not=
 ready.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.DATA_UNKNOWN",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of retired loads that are b=
locked because its address partially overlapped with an older store.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts the total number of machine clears for=
 any reason including, but not limited to, memory ordering, memory disambig=
uation, SMC, and FP assist.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.ANY",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "20003"
     },
     {
         "BriefDescription": "Counts the number of machine clears due to me=
mory ordering in which an internal load passes an older store within the sa=
me CPU.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.DISAMBIGUATION",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "20003",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Counts the number of machine clears due to a =
page fault.  Counts both I-Side and D-Side (Loads/Stores) page faults.  A p=
age fault occurs when either the page is not present, or an access violatio=
n occurs.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.PAGE_FAULT",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "20003",
         "UMask": "0x20"
     },
     {
         "BriefDescription": "Counts the number of machine clears due to pr=
ogram modifying data (self modifying code) within 1K of a recently fetched =
code page.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.SMC",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "20003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a misp=
redicted jump or a machine clear.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window including r=
elevant microcode flows and while uops are not yet available in the instruc=
tion queue (IQ) even if an FE_bound event occurs during this period. Also i=
ncludes the issue slots that were consumed by the backend but were thrown a=
way because they were younger than the mispredict or machine clear.",
         "SampleAfterValue": "1000003",
         "UMask": "0x6"
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to fast nukes such as memory orde=
ring and memory disambiguation machine clears.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.FASTNUKE",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a mach=
ine clear (nuke) of any kind including memory ordering and memory disambigu=
ation.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to branch mispredicts.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.MISPREDICT",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
TOPDOWN_BAD_SPECULATION.FASTNUKE",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.MONUKE",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts the total number of issue slots every =
cycle that were not consumed by the backend due to backend stalls.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.ALL",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003"
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to certain allocation restriction=
s.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to memory reservation stalls in w=
hich a scheduler is not able to accept uops.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.MEM_SCHEDULER",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to IEC or FPC RAT stalls, which c=
an be due to FIQ or IEC reservation stalls in which the integer, floating p=
oint or SIMD scheduler is not able to accept uops.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to the physical register file una=
ble to accept an entry (marble stalls).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.REGISTER",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x20"
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to the reorder buffer being full =
(ROB stalls).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.REORDER_BUFFER",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x40"
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to scoreboards from the instructi=
on queue (IQ), jump execution unit (JEU), or microcode sequencer (MS).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.SERIALIZATION",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "This event is deprecated.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.STORE_BUFFER",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Counts the total number of issue slots every =
cycle that were not consumed by the backend due to frontend stalls.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.ALL",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003"
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to BACLEARS.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.BRANCH_DETECT",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of issue slots every cycle=
 that were not delivered by the frontend due to BACLEARS, which occurs when=
 the Branch Target Buffer (BTB) prediction or lack thereof, was corrected b=
y a later branch predictor in the frontend. Includes BACLEARS due to all br=
anch types including conditional and unconditional jumps, returns, and indi=
rect branches.",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to BTCLEARS.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.BRANCH_RESTEER",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of issue slots every cycle=
 that were not delivered by the frontend due to BTCLEARS, which occurs when=
 the Branch Target Buffer (BTB) predicts a taken branch.",
         "SampleAfterValue": "1000003",
         "UMask": "0x40"
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to the microcode sequencer (MS)=
.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.CISC",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to decode stalls.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.DECODE",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to ITLB misses.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.ITLB",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of issue slots every cycle=
 that were not delivered by the frontend due to Instruction Table Lookaside=
 Buffer (ITLB) misses.",
         "SampleAfterValue": "1000003",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to other common frontend stalls=
 not categorized.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.OTHER",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x80"
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to wrong predecodes.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.PREDECODE",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Counts the total number of consumed retiremen=
t slots.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc2",
         "EventName": "TOPDOWN_RETIRING.ALL",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003"
     },
     {
         "BriefDescription": "Counts the number of uops issued by the front=
 end every cycle.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x0e",
         "EventName": "UOPS_ISSUED.ANY",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of uops issued by the fron=
t end every cycle. When 4-uops are requested and only 2-uops are delivered,=
 the event counts 2.  Uops_issued correlates to the number of ROB entries. =
 If uop takes 2 ROB slots it counts as 2 uops_issued.",
         "SampleAfterValue": "200003"
     },
     {
         "BriefDescription": "Counts the total number of uops retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.ALL",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "2000003"
     },
     {
         "BriefDescription": "Counts the number of integer divide uops reti=
red.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.IDIV",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Counts the number of uops that are from compl=
ex flows issued by the micro-sequencer (MS).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.MS",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of uops that are from comp=
lex flows issued by the Microcode Sequencer (MS). This includes uops from f=
lows due to complex instructions, faults, assists, and inserted flows.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of x87 uops retired, includ=
es those in MS flows.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.X87",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     }
diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/virtual-memory.json=
 b/tools/perf/pmu-events/arch/x86/elkhartlake/virtual-memory.json
index b82f11591f13..cabe29e70e79 100644
--- a/tools/perf/pmu-events/arch/x86/elkhartlake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/elkhartlake/virtual-memory.json
@@ -1,363 +1,246 @@
 [
     {
         "BriefDescription": "Counts the number of page walks due to loads =
that miss the PDE (Page Directory Entry) cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.PDE_CACHE_MISS",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x80"
     },
     {
         "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to a demand load that did not start a page walk. A=
ccount for all page sizes. Will result in a DTLB write from STLB.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x20"
     },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to load DTLB misses to any page size.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks completed du=
e to loads (including SW prefetches) whose address translations missed in a=
ll Translation Lookaside Buffer (TLB) levels and were mapped to any page si=
ze. Includes page walks that page fault.",
         "SampleAfterValue": "200003",
         "UMask": "0xe"
     },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to load DTLB misses to a 1G page.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_1G",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks completed du=
e to loads (including SW prefetches) whose address translations missed in a=
ll Translation Lookaside Buffer (TLB) levels and were mapped to 1GB pages. =
Includes page walks that page fault.",
         "SampleAfterValue": "200003",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to load DTLB misses to a 2M or 4M page.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks completed du=
e to loads (including SW prefetches) whose address translations missed in a=
ll Translation Lookaside Buffer (TLB) levels and were mapped to 2M or 4M pa=
ges. Includes page walks that page fault.",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to load DTLB misses to a 4K page.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks completed du=
e to loads (including SW prefetches) whose address translations missed in a=
ll Translation Lookaside Buffer (TLB) levels and were mapped to 4K pages. I=
ncludes page walks that page fault.",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts the number of page walks outstanding i=
n the page miss handler (PMH) for demand loads every cycle.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_PENDING",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks outstanding =
in the page miss handler (PMH) for demand loads every cycle.  A page walk i=
s outstanding from start till PMH becomes idle again (ready to serve next w=
alk). Includes EPT-walk intervals.",
         "SampleAfterValue": "200003",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Counts the number of page walks due to stores=
 that miss the PDE (Page Directory Entry) cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.PDE_CACHE_MISS",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "2000003",
         "UMask": "0x80"
     },
     {
         "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to stores that did not start a page walk. Account =
for all pages sizes. Will result in a DTLB write from STLB.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.STLB_HIT",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "2000003",
         "UMask": "0x20"
     },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to store DTLB misses to any page size.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks completed du=
e to stores whose address translations missed in all Translation Lookaside =
Buffer (TLB) levels and were mapped to any page size.  Includes page walks =
that page fault.",
         "SampleAfterValue": "200003",
         "UMask": "0xe"
     },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to store DTLB misses to a 1G page.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_1G",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks completed du=
e to stores whose address translations missed in all Translation Lookaside =
Buffer (TLB) levels and were mapped to 1G pages.  Includes page walks that =
page fault.",
         "SampleAfterValue": "200003",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to store DTLB misses to a 2M or 4M page.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks completed du=
e to stores whose address translations missed in all Translation Lookaside =
Buffer (TLB) levels and were mapped to 2M or 4M pages.  Includes page walks=
 that page fault.",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to store DTLB misses to a 4K page.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks completed du=
e to stores whose address translations missed in all Translation Lookaside =
Buffer (TLB) levels and were mapped to 4K pages.  Includes page walks that =
page fault.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts the number of page walks outstanding i=
n the page miss handler (PMH) for stores every cycle.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_PENDING",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks outstanding =
in the page miss handler (PMH) for stores every cycle.  A page walk is outs=
tanding from start till PMH becomes idle again (ready to serve next walk). =
Includes EPT-walk intervals.",
         "SampleAfterValue": "200003",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Counts the number of Extended Page Directory =
Entry hits.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4f",
         "EventName": "EPT.EPDE_HIT",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of Extended Page Directory=
 Entry hits.  The Extended Page Directory cache is used by Virtual Machine =
operating systems while the guest operating systems use the standard TLB ca=
ches.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of Extended Page Directory =
Entry misses.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4f",
         "EventName": "EPT.EPDE_MISS",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number Extended Page Directory En=
try misses.  The Extended Page Directory cache is used by Virtual Machine o=
perating systems while the guest operating systems use the standard TLB cac=
hes.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts the number of Extended Page Directory =
Pointer Entry hits.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4f",
         "EventName": "EPT.EPDPE_HIT",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number Extended Page Directory Po=
inter Entry hits.  The Extended Page Directory cache is used by Virtual Mac=
hine operating systems while the guest operating systems use the standard T=
LB caches.",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Counts the number of Extended Page Directory =
Pointer Entry misses.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4f",
         "EventName": "EPT.EPDPE_MISS",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number Extended Page Directory Po=
inter Entry misses.  The Extended Page Directory cache is used by Virtual M=
achine operating systems while the guest operating systems use the standard=
 TLB caches.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Counts the number of page walks outstanding f=
or an Extended Page table walk including GTLB hits per cycle.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4f",
         "EventName": "EPT.WALK_PENDING",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks outstanding =
for an Extended Page table walk including GTLB hits per cycle.  The Extende=
d Page Directory cache is used by Virtual Machine operating systems while t=
he guest operating systems use the standard TLB caches.",
         "SampleAfterValue": "200003",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Counts the number of times there was an ITLB =
miss and a new translation was filled into the ITLB.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x81",
         "EventName": "ITLB.FILLS",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of times the machine was u=
nable to find a translation in the Instruction Translation Lookaside Buffer=
 (ITLB) and a new translation was filled into the ITLB. The event is specul=
ative in nature, but will not count translations (page walks) that are begu=
n and not finished, or translations that are finished but not filled into t=
he ITLB.",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Counts the number of page walks due to an ins=
truction fetch that miss the PDE (Page Directory Entry) cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.PDE_CACHE_MISS",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "2000003",
         "UMask": "0x80"
     },
     {
         "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to an instruction fetch that did not start a page =
walk. Account for all pages sizes. Will result in an ITLB write from STLB."=
,
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.STLB_HIT",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "2000003",
         "UMask": "0x20"
     },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to instruction fetch misses to any page size.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks completed du=
e to instruction fetches whose address translations missed in all Translati=
on Lookaside Buffer (TLB) levels and were mapped to any page size.  Include=
s page walks that page fault.",
         "SampleAfterValue": "200003",
         "UMask": "0xe"
     },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to instruction fetch misses to a 1G page.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_1G",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks completed du=
e to instruction fetches whose address translations missed in all Translati=
on Lookaside Buffer (TLB) levels and were mapped to 1G pages.  Includes pag=
e walks that page fault.",
         "SampleAfterValue": "200003",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to instruction fetch misses to a 2M or 4M page.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks completed du=
e to instruction fetches whose address translations missed in all Translati=
on Lookaside Buffer (TLB) levels and were mapped to 2M or 4M pages.  Includ=
es page walks that page fault.",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to instruction fetch misses to a 4K page.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks completed du=
e to instruction fetches whose address translations missed in all Translati=
on Lookaside Buffer (TLB) levels and were mapped to 4K pages.  Includes pag=
e walks that page fault.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts the number of page walks outstanding i=
n the page miss handler (PMH) for instruction fetches every cycle.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_PENDING",
-        "PDIR_COUNTER": "NA",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks outstanding =
in the page miss handler (PMH) for instruction fetches every cycle.  A page=
 walk is outstanding from start till PMH becomes idle again (ready to serve=
 next walk).",
         "SampleAfterValue": "200003",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Counts the number of retired loads that are b=
locked due to a first level TLB miss.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.DTLB_MISS",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Counts the number of memory uops retired that=
 missed in the second level TLB.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x13"
     },
     {
         "BriefDescription": "Counts the number of load uops retired that m=
iss in the second Level TLB.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS_LOADS",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x11"
     },
     {
         "BriefDescription": "Counts the number of store uops retired that =
miss in the second level TLB.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS_STORES",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x12"
     }
--=20
2.39.0.314.g84b9a713c41-goog

