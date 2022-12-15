Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7620D64D6BC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 07:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiLOG4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 01:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiLOGzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:55:53 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7A143845
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:55:47 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3d2994e2d7dso25290197b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxlfVyxSdjOPcOPu/rDczUlsWtc9HPfiKcl4tDsjwgs=;
        b=W8IohEWzbFxasgGNYPGcqOuRmL68H7fzXKTfsDzElTN3KnEwy+zmiNd9cIlbEar2H4
         mIxhgQxdcthQTBmI46S4HJ2cfpl5fHXQWRKo4PAWhuEd1qdp7AcC08GFGoldrl9reY3u
         NkglP9AGqxFWpx1efCxZti9NSZ1vIITOmB9lcHpYTuWe7b7v8OhLTMwHxfsqB/k/hg4c
         7mV7+mkqSzps7zTE3wv7VWlzdNVmNKL+ZIZ+7VqE6JPW3SBqDSk2+LvubcWj6XcuM2lb
         eUMlhbU2ExoJbzvoDQC71WAOKGntWoaSDSkX/z9rsE1TKmCuF8RzercJkVCRc6KlxQz/
         1G1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nxlfVyxSdjOPcOPu/rDczUlsWtc9HPfiKcl4tDsjwgs=;
        b=xPsWo+FvIZStC9IWwKIB1kr03R4IUCdL7Y3wnOtor41vxLpr/hd7aYcaDfqgEGhZuz
         bQXSifkYobM1gKCzqMdCCROXA9TLctlHE01xwFiyLt4o4ip/B+tyu7L5FN+gO5K1UpYv
         OmT6i+/6SZ21KodbkeGpkBFfhTDirvAJdUhUFH62/oen3JmOrxPIMxNkp3rfH37AsZvu
         Xfzp6jdd7G1iDvwofiozsBSZvbgktibtxGQ28hGgBAItmh8Oz6Ue55au16SIRz9RP5hd
         7cMYDyQM4D9oaGHBUWfIpuhDqQj529LTddu2c53Hq7ype1F8OWW1Jefz3laP/iBx5Qlq
         UlPw==
X-Gm-Message-State: ANoB5pk6hGmQ4KIkIyq8H6U0ecdsuhTNR+I0fLH0DpnEEGOq8sYTkAYt
        XNxVoF6TGG18NIXWPko1RpYGeJBONw20
X-Google-Smtp-Source: AA0mqf5rcPII445fkySGcPnGU3839nv5YnTaLKlo3edqORDEslBX905D7/MD3wl+g6P1p7oChsM1L1D+FoEF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c7dc:d96f:4f9:f59d])
 (user=irogers job=sendgmr) by 2002:a25:868f:0:b0:70b:cfb3:c0d5 with SMTP id
 z15-20020a25868f000000b0070bcfb3c0d5mr7240911ybk.319.1671087346640; Wed, 14
 Dec 2022 22:55:46 -0800 (PST)
Date:   Wed, 14 Dec 2022 22:54:49 -0800
In-Reply-To: <20221215065510.1621979-1-irogers@google.com>
Message-Id: <20221215065510.1621979-3-irogers@google.com>
Mime-Version: 1.0
References: <20221215065510.1621979-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 11/32] perf vendor events intel: Refresh goldmontplus events
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

Update the goldmontplus events using the new tooling from:
https://github.com/intel/perfmon

The events are unchanged but unused json values are removed. This
increases consistency across the json files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/goldmontplus/cache.json          | 470 ------------------
 .../arch/x86/goldmontplus/floating-point.json |  11 -
 .../arch/x86/goldmontplus/frontend.json       |  32 --
 .../arch/x86/goldmontplus/memory.json         |  10 -
 .../arch/x86/goldmontplus/other.json          |  20 -
 .../arch/x86/goldmontplus/pipeline.json       | 143 ------
 .../arch/x86/goldmontplus/virtual-memory.json |  69 ---
 7 files changed, 755 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/cache.json b/tools=
/perf/pmu-events/arch/x86/goldmontplus/cache.json
index 16e8913c0434..a7f80fd1b1df 100644
--- a/tools/perf/pmu-events/arch/x86/goldmontplus/cache.json
+++ b/tools/perf/pmu-events/arch/x86/goldmontplus/cache.json
@@ -1,1463 +1,993 @@
 [
     {
         "BriefDescription": "Requests rejected by the L2Q",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "CORE_REJECT_L2Q.ALL",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of demand and L1 prefetche=
r requests rejected by the L2Q due to a full or nearly full condition which=
 likely indicates back pressure from L2Q. It also counts requests that woul=
d have gone directly to the XQ, but are rejected due to a full or nearly fu=
ll condition, indicating back pressure from the IDI link. The L2Q may also =
reject transactions from a core to insure fairness between cores, or to del=
ay a core's dirty eviction when the address conflicts with incoming externa=
l snoops.",
         "SampleAfterValue": "200003"
     },
     {
         "BriefDescription": "L1 Cache evictions for dirty data",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "DL1.REPLACEMENT",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts when a modified (dirty) cache line is=
 evicted from the data L1 cache and needs to be written back to memory.  No=
 count will occur if the evicted line is clean, and hence does not require =
a writeback.",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Cycles code-fetch stalled due to an outstandi=
ng ICache miss.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "FETCH_STALL.ICACHE_FILL_PENDING_CYCLES",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts cycles that fetch is stalled due to a=
n outstanding ICache miss. That is, the decoder queue is able to accept byt=
es, but the fetch unit is unable to provide bytes due to an ICache miss.  N=
ote: this event is not the same as the total number of cycles spent retriev=
ing instruction cache lines from the memory hierarchy.",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Requests rejected by the XQ",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x30",
         "EventName": "L2_REJECT_XQ.ALL",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of demand and prefetch tra=
nsactions that the L2 XQ rejects due to a full or near full condition which=
 likely indicates back pressure from the intra-die interconnect (IDI) fabri=
c. The XQ may reject transactions from the L2Q (non-cacheable requests), L2=
 misses and L2 write-back victims.",
         "SampleAfterValue": "200003"
     },
     {
         "BriefDescription": "L2 cache request misses",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "LONGEST_LAT_CACHE.MISS",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts memory requests originating from the =
core that miss in the L2 cache.",
         "SampleAfterValue": "200003",
         "UMask": "0x41"
     },
     {
         "BriefDescription": "L2 cache requests",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts memory requests originating from the =
core that reference a cache line in the L2 cache.",
         "SampleAfterValue": "200003",
         "UMask": "0x4f"
     },
     {
         "BriefDescription": "Loads retired that came from DRAM (Precise ev=
ent capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.DRAM_HIT",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts memory load uops retired where the da=
ta is retrieved from DRAM.  Event is counted at retirement, so the speculat=
ive loads are ignored.  A memory load can hit (or miss) the L1 cache, hit (=
or miss) the L2 cache, hit DRAM, hit in the WCB or receive a HITM response.=
",
         "SampleAfterValue": "200003",
         "UMask": "0x80"
     },
     {
         "BriefDescription": "Memory uop retired where cross core or cross =
module HITM occurred (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.HITM",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts load uops retired where the cache lin=
e containing the data was in the modified state of another core or modules =
cache (HITM).  More specifically, this means that when the load address was=
 checked by other caching agents (typically another processor) in the syste=
m, one of those caching agents indicated that they had a dirty copy of the =
data.  Loads that obtain a HITM response incur greater latency than most is=
 typical for a load.  In addition, since HITM indicates that some other pro=
cessor had this data in its cache, it implies that the data was shared betw=
een processors, or potentially was a lock or semaphore value.  This event i=
s useful for locating sharing, false sharing, and contended locks.",
         "SampleAfterValue": "200003",
         "UMask": "0x20"
     },
     {
         "BriefDescription": "Load uops retired that hit L1 data cache (Pre=
cise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_HIT",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts load uops retired that hit the L1 dat=
a cache.",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Load uops retired that missed L1 data cache (=
Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_MISS",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts load uops retired that miss the L1 da=
ta cache.",
         "SampleAfterValue": "200003",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Load uops retired that hit L2 (Precise event =
capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts load uops retired that hit in the L2 =
cache.",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Load uops retired that missed L2 (Precise eve=
nt capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_MISS",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts load uops retired that miss in the L2=
 cache.",
         "SampleAfterValue": "200003",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Loads retired that hit WCB (Precise event cap=
able)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.WCB_HIT",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts memory load uops retired where the da=
ta is retrieved from the WCB (or fill buffer), indicating that the load fou=
nd its data while that data was in the process of being brought into the L1=
 cache.  Typically a load will receive this indication when some other load=
 or prefetch missed the L1 cache and was in the process of retrieving the c=
ache line containing the data, but that process had not yet finished (and w=
ritten the data back to the cache). For example, consider load X and Y, bot=
h referencing the same cache line that is not in the L1 cache.  If load X m=
isses cache first, it obtains and WCB (or fill buffer) and begins the proce=
ss of requesting the data.  When load Y requests the data, it will either h=
it the WCB, or the L1 cache, depending on exactly what time the request to =
Y occurs.",
         "SampleAfterValue": "200003",
         "UMask": "0x40"
     },
     {
         "BriefDescription": "Memory uops retired (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.ALL",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of memory uops retired tha=
t is either a loads or a store or both.",
         "SampleAfterValue": "200003",
         "UMask": "0x83"
     },
     {
         "BriefDescription": "Load uops retired (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of load uops retired.",
         "SampleAfterValue": "200003",
         "UMask": "0x81"
     },
     {
         "BriefDescription": "Store uops retired (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of store uops retired.",
         "SampleAfterValue": "200003",
         "UMask": "0x82"
     },
     {
         "BriefDescription": "Locked load uops retired (Precise event capab=
le)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.LOCK_LOADS",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts locked memory uops retired.  This inc=
ludes regular locks and bus locks. (To specifically count bus locks only, s=
ee the Offcore response event.)  A locked access is one with a lock prefix,=
 or an exchange to memory.  See the SDM for a complete description of which=
 memory load accesses are locks.",
         "SampleAfterValue": "200003",
         "UMask": "0x21"
     },
     {
         "BriefDescription": "Memory uops retired that split a cache-line (=
Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts memory uops retired where the data re=
quested spans a 64 byte cache line boundary.",
         "SampleAfterValue": "200003",
         "UMask": "0x43"
     },
     {
         "BriefDescription": "Load uops retired that split a cache-line (Pr=
ecise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts load uops retired where the data requ=
ested spans a 64 byte cache line boundary.",
         "SampleAfterValue": "200003",
         "UMask": "0x41"
     },
     {
         "BriefDescription": "Stores uops retired that split a cache-line (=
Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts store uops retired where the data req=
uested spans a 64 byte cache line boundary.",
         "SampleAfterValue": "200003",
         "UMask": "0x42"
     },
     {
         "BriefDescription": "Requires MSR_OFFCORE_RESP[0,1] to specify req=
uest type and response. (duplicated for both MSRs)",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data reads (demand & prefetch) have an=
y transaction responses from the uncore subsystem.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000013091",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data reads (demand & prefetch) have a=
ny transaction responses from the uncore subsystem. Requires MSR_OFFCORE_RE=
SP[0,1] to specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data reads (demand & prefetch) hit the=
 L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000043091",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data reads (demand & prefetch) hit th=
e L2 cache. Requires MSR_OFFCORE_RESP[0,1] to specify request type and resp=
onse. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data reads (demand & prefetch) miss th=
e L2 cache with a snoop hit in the other processor module, data forwarding =
is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_MISS.HITM_OTHER_CORE=
",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x1000003091",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data reads (demand & prefetch) miss t=
he L2 cache with a snoop hit in the other processor module, data forwarding=
 is required. Requires MSR_OFFCORE_RESP[0,1] to specify request type and re=
sponse. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data reads (demand & prefetch) true mi=
ss for the L2 cache with a snoop miss in the other processor module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_MISS.SNOOP_MISS_OR_N=
O_SNOOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0200003091",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data reads (demand & prefetch) true m=
iss for the L2 cache with a snoop miss in the other processor module.  Requ=
ires MSR_OFFCORE_RESP[0,1] to specify request type and response. (duplicate=
d for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data reads (demand & prefetch) outstan=
ding, per cycle, from the time of the L2 miss to when any response is recei=
ved.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000003091",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data reads (demand & prefetch) outsta=
nding, per cycle, from the time of the L2 miss to when any response is rece=
ived. Requires MSR_OFFCORE_RESP[0,1] to specify request type and response. =
(duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data reads generated by L1 or L2 prefe=
tchers have any transaction responses from the uncore subsystem.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000013010",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data reads generated by L1 or L2 pref=
etchers have any transaction responses from the uncore subsystem. Requires =
MSR_OFFCORE_RESP[0,1] to specify request type and response. (duplicated for=
 both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data reads generated by L1 or L2 prefe=
tchers hit the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_DATA_RD.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000043010",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data reads generated by L1 or L2 pref=
etchers hit the L2 cache. Requires MSR_OFFCORE_RESP[0,1] to specify request=
 type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data reads generated by L1 or L2 prefe=
tchers miss the L2 cache with a snoop hit in the other processor module, da=
ta forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_DATA_RD.L2_MISS.HITM_OTHER_C=
ORE",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x1000003010",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data reads generated by L1 or L2 pref=
etchers miss the L2 cache with a snoop hit in the other processor module, d=
ata forwarding is required. Requires MSR_OFFCORE_RESP[0,1] to specify reque=
st type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data reads generated by L1 or L2 prefe=
tchers true miss for the L2 cache with a snoop miss in the other processor =
module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_DATA_RD.L2_MISS.SNOOP_MISS_O=
R_NO_SNOOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0200003010",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data reads generated by L1 or L2 pref=
etchers true miss for the L2 cache with a snoop miss in the other processor=
 module.  Requires MSR_OFFCORE_RESP[0,1] to specify request type and respon=
se. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data reads generated by L1 or L2 prefe=
tchers outstanding, per cycle, from the time of the L2 miss to when any res=
ponse is received.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000003010",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data reads generated by L1 or L2 pref=
etchers outstanding, per cycle, from the time of the L2 miss to when any re=
sponse is received. Requires MSR_OFFCORE_RESP[0,1] to specify request type =
and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data read, code read, and read for own=
ership (RFO) requests (demand & prefetch) have any transaction responses fr=
om the uncore subsystem.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x00000132b7",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data read, code read, and read for ow=
nership (RFO) requests (demand & prefetch) have any transaction responses f=
rom the uncore subsystem. Requires MSR_OFFCORE_RESP[0,1] to specify request=
 type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data read, code read, and read for own=
ership (RFO) requests (demand & prefetch) hit the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x00000432b7",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data read, code read, and read for ow=
nership (RFO) requests (demand & prefetch) hit the L2 cache. Requires MSR_O=
FFCORE_RESP[0,1] to specify request type and response. (duplicated for both=
 MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data read, code read, and read for own=
ership (RFO) requests (demand & prefetch) miss the L2 cache with a snoop hi=
t in the other processor module, data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_MISS.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x10000032b7",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data read, code read, and read for ow=
nership (RFO) requests (demand & prefetch) miss the L2 cache with a snoop h=
it in the other processor module, data forwarding is required. Requires MSR=
_OFFCORE_RESP[0,1] to specify request type and response. (duplicated for bo=
th MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data read, code read, and read for own=
ership (RFO) requests (demand & prefetch) true miss for the L2 cache with a=
 snoop miss in the other processor module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_MISS.SNOOP_MISS_OR_NO_S=
NOOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x02000032b7",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data read, code read, and read for ow=
nership (RFO) requests (demand & prefetch) true miss for the L2 cache with =
a snoop miss in the other processor module.  Requires MSR_OFFCORE_RESP[0,1]=
 to specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data read, code read, and read for own=
ership (RFO) requests (demand & prefetch) outstanding, per cycle, from the =
time of the L2 miss to when any response is received.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x40000032b7",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data read, code read, and read for ow=
nership (RFO) requests (demand & prefetch) outstanding, per cycle, from the=
 time of the L2 miss to when any response is received. Requires MSR_OFFCORE=
_RESP[0,1] to specify request type and response. (duplicated for both MSRs)=
",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts requests to the uncore subsystem have =
any transaction responses from the uncore subsystem.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000018000",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts requests to the uncore subsystem have=
 any transaction responses from the uncore subsystem. Requires MSR_OFFCORE_=
RESP[0,1] to specify request type and response. (duplicated for both MSRs)"=
,
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts requests to the uncore subsystem hit t=
he L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000048000",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts requests to the uncore subsystem hit =
the L2 cache. Requires MSR_OFFCORE_RESP[0,1] to specify request type and re=
sponse. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts requests to the uncore subsystem miss =
the L2 cache with a snoop hit in the other processor module, data forwardin=
g is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_MISS.HITM_OTHER_CORE=
",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x1000008000",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts requests to the uncore subsystem miss=
 the L2 cache with a snoop hit in the other processor module, data forwardi=
ng is required. Requires MSR_OFFCORE_RESP[0,1] to specify request type and =
response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts requests to the uncore subsystem true =
miss for the L2 cache with a snoop miss in the other processor module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_MISS.SNOOP_MISS_OR_N=
O_SNOOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0200008000",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts requests to the uncore subsystem true=
 miss for the L2 cache with a snoop miss in the other processor module.  Re=
quires MSR_OFFCORE_RESP[0,1] to specify request type and response. (duplica=
ted for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts requests to the uncore subsystem outst=
anding, per cycle, from the time of the L2 miss to when any response is rec=
eived.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000008000",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts requests to the uncore subsystem outs=
tanding, per cycle, from the time of the L2 miss to when any response is re=
ceived. Requires MSR_OFFCORE_RESP[0,1] to specify request type and response=
. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests (de=
mand & prefetch) have any transaction responses from the uncore subsystem."=
,
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000010022",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts reads for ownership (RFO) requests (d=
emand & prefetch) have any transaction responses from the uncore subsystem.=
 Requires MSR_OFFCORE_RESP[0,1] to specify request type and response. (dupl=
icated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests (de=
mand & prefetch) hit the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000040022",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts reads for ownership (RFO) requests (d=
emand & prefetch) hit the L2 cache. Requires MSR_OFFCORE_RESP[0,1] to speci=
fy request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests (de=
mand & prefetch) miss the L2 cache with a snoop hit in the other processor =
module, data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_MISS.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x1000000022",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts reads for ownership (RFO) requests (d=
emand & prefetch) miss the L2 cache with a snoop hit in the other processor=
 module, data forwarding is required. Requires MSR_OFFCORE_RESP[0,1] to spe=
cify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests (de=
mand & prefetch) true miss for the L2 cache with a snoop miss in the other =
processor module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_MISS.SNOOP_MISS_OR_NO_SN=
OOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0200000022",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts reads for ownership (RFO) requests (d=
emand & prefetch) true miss for the L2 cache with a snoop miss in the other=
 processor module.  Requires MSR_OFFCORE_RESP[0,1] to specify request type =
and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests (de=
mand & prefetch) outstanding, per cycle, from the time of the L2 miss to wh=
en any response is received.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000000022",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts reads for ownership (RFO) requests (d=
emand & prefetch) outstanding, per cycle, from the time of the L2 miss to w=
hen any response is received. Requires MSR_OFFCORE_RESP[0,1] to specify req=
uest type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts bus lock and split lock requests have =
any transaction responses from the uncore subsystem.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000010400",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts bus lock and split lock requests have=
 any transaction responses from the uncore subsystem. Requires MSR_OFFCORE_=
RESP[0,1] to specify request type and response. (duplicated for both MSRs)"=
,
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts bus lock and split lock requests hit t=
he L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000040400",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts bus lock and split lock requests hit =
the L2 cache. Requires MSR_OFFCORE_RESP[0,1] to specify request type and re=
sponse. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts bus lock and split lock requests miss =
the L2 cache with a snoop hit in the other processor module, data forwardin=
g is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_MISS.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x1000000400",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts bus lock and split lock requests miss=
 the L2 cache with a snoop hit in the other processor module, data forwardi=
ng is required. Requires MSR_OFFCORE_RESP[0,1] to specify request type and =
response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts bus lock and split lock requests true =
miss for the L2 cache with a snoop miss in the other processor module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_MISS.SNOOP_MISS_OR_NO_=
SNOOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0200000400",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts bus lock and split lock requests true=
 miss for the L2 cache with a snoop miss in the other processor module.  Re=
quires MSR_OFFCORE_RESP[0,1] to specify request type and response. (duplica=
ted for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts bus lock and split lock requests outst=
anding, per cycle, from the time of the L2 miss to when any response is rec=
eived.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000000400",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts bus lock and split lock requests outs=
tanding, per cycle, from the time of the L2 miss to when any response is re=
ceived. Requires MSR_OFFCORE_RESP[0,1] to specify request type and response=
. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of writeback transactions c=
aused by L1 or L2 cache evictions have any transaction responses from the u=
ncore subsystem.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000010008",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of writeback transactions =
caused by L1 or L2 cache evictions have any transaction responses from the =
uncore subsystem. Requires MSR_OFFCORE_RESP[0,1] to specify request type an=
d response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of writeback transactions c=
aused by L1 or L2 cache evictions hit the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000040008",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of writeback transactions =
caused by L1 or L2 cache evictions hit the L2 cache. Requires MSR_OFFCORE_R=
ESP[0,1] to specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of writeback transactions c=
aused by L1 or L2 cache evictions miss the L2 cache with a snoop hit in the=
 other processor module, data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.L2_MISS.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x1000000008",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of writeback transactions =
caused by L1 or L2 cache evictions miss the L2 cache with a snoop hit in th=
e other processor module, data forwarding is required. Requires MSR_OFFCORE=
_RESP[0,1] to specify request type and response. (duplicated for both MSRs)=
",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of writeback transactions c=
aused by L1 or L2 cache evictions true miss for the L2 cache with a snoop m=
iss in the other processor module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.L2_MISS.SNOOP_MISS_OR_NO_SNO=
OP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0200000008",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of writeback transactions =
caused by L1 or L2 cache evictions true miss for the L2 cache with a snoop =
miss in the other processor module.  Requires MSR_OFFCORE_RESP[0,1] to spec=
ify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of writeback transactions c=
aused by L1 or L2 cache evictions outstanding, per cycle, from the time of =
the L2 miss to when any response is received.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000000008",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of writeback transactions =
caused by L1 or L2 cache evictions outstanding, per cycle, from the time of=
 the L2 miss to when any response is received. Requires MSR_OFFCORE_RESP[0,=
1] to specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction cacheline and I-sid=
e prefetch requests that miss the instruction cache have any transaction re=
sponses from the uncore subsystem.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000010004",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts demand instruction cacheline and I-si=
de prefetch requests that miss the instruction cache have any transaction r=
esponses from the uncore subsystem. Requires MSR_OFFCORE_RESP[0,1] to speci=
fy request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction cacheline and I-sid=
e prefetch requests that miss the instruction cache hit the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000040004",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts demand instruction cacheline and I-si=
de prefetch requests that miss the instruction cache hit the L2 cache. Requ=
ires MSR_OFFCORE_RESP[0,1] to specify request type and response. (duplicate=
d for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction cacheline and I-sid=
e prefetch requests that miss the instruction cache miss the L2 cache with =
a snoop hit in the other processor module, data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_MISS.HITM_OTHER_C=
ORE",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x1000000004",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts demand instruction cacheline and I-si=
de prefetch requests that miss the instruction cache miss the L2 cache with=
 a snoop hit in the other processor module, data forwarding is required. Re=
quires MSR_OFFCORE_RESP[0,1] to specify request type and response. (duplica=
ted for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction cacheline and I-sid=
e prefetch requests that miss the instruction cache true miss for the L2 ca=
che with a snoop miss in the other processor module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_MISS.SNOOP_MISS_O=
R_NO_SNOOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0200000004",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts demand instruction cacheline and I-si=
de prefetch requests that miss the instruction cache true miss for the L2 c=
ache with a snoop miss in the other processor module.  Requires MSR_OFFCORE=
_RESP[0,1] to specify request type and response. (duplicated for both MSRs)=
",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction cacheline and I-sid=
e prefetch requests that miss the instruction cache outstanding, per cycle,=
 from the time of the L2 miss to when any response is received.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000000004",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts demand instruction cacheline and I-si=
de prefetch requests that miss the instruction cache outstanding, per cycle=
, from the time of the L2 miss to when any response is received. Requires M=
SR_OFFCORE_RESP[0,1] to specify request type and response. (duplicated for =
both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand cacheable data reads of full ca=
che lines have any transaction responses from the uncore subsystem.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000010001",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts demand cacheable data reads of full c=
ache lines have any transaction responses from the uncore subsystem. Requir=
es MSR_OFFCORE_RESP[0,1] to specify request type and response. (duplicated =
for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand cacheable data reads of full ca=
che lines hit the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000040001",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts demand cacheable data reads of full c=
ache lines hit the L2 cache. Requires MSR_OFFCORE_RESP[0,1] to specify requ=
est type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand cacheable data reads of full ca=
che lines miss the L2 cache with a snoop hit in the other processor module,=
 data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_MISS.HITM_OTHER_C=
ORE",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x1000000001",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts demand cacheable data reads of full c=
ache lines miss the L2 cache with a snoop hit in the other processor module=
, data forwarding is required. Requires MSR_OFFCORE_RESP[0,1] to specify re=
quest type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand cacheable data reads of full ca=
che lines true miss for the L2 cache with a snoop miss in the other process=
or module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_MISS.SNOOP_MISS_O=
R_NO_SNOOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0200000001",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts demand cacheable data reads of full c=
ache lines true miss for the L2 cache with a snoop miss in the other proces=
sor module.  Requires MSR_OFFCORE_RESP[0,1] to specify request type and res=
ponse. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand cacheable data reads of full ca=
che lines outstanding, per cycle, from the time of the L2 miss to when any =
response is received.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000000001",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts demand cacheable data reads of full c=
ache lines outstanding, per cycle, from the time of the L2 miss to when any=
 response is received. Requires MSR_OFFCORE_RESP[0,1] to specify request ty=
pe and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts generated by a write to full data cache line have any transaction respo=
nses from the uncore subsystem.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000010002",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts demand reads for ownership (RFO) requ=
ests generated by a write to full data cache line have any transaction resp=
onses from the uncore subsystem. Requires MSR_OFFCORE_RESP[0,1] to specify =
request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts generated by a write to full data cache line hit the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000040002",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts demand reads for ownership (RFO) requ=
ests generated by a write to full data cache line hit the L2 cache. Require=
s MSR_OFFCORE_RESP[0,1] to specify request type and response. (duplicated f=
or both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts generated by a write to full data cache line miss the L2 cache with a s=
noop hit in the other processor module, data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_MISS.HITM_OTHER_CORE"=
,
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x1000000002",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts demand reads for ownership (RFO) requ=
ests generated by a write to full data cache line miss the L2 cache with a =
snoop hit in the other processor module, data forwarding is required. Requi=
res MSR_OFFCORE_RESP[0,1] to specify request type and response. (duplicated=
 for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts generated by a write to full data cache line true miss for the L2 cache=
 with a snoop miss in the other processor module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_MISS.SNOOP_MISS_OR_NO=
_SNOOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0200000002",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts demand reads for ownership (RFO) requ=
ests generated by a write to full data cache line true miss for the L2 cach=
e with a snoop miss in the other processor module.  Requires MSR_OFFCORE_RE=
SP[0,1] to specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts generated by a write to full data cache line outstanding, per cycle, fr=
om the time of the L2 miss to when any response is received.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000000002",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts demand reads for ownership (RFO) requ=
ests generated by a write to full data cache line outstanding, per cycle, f=
rom the time of the L2 miss to when any response is received. Requires MSR_=
OFFCORE_RESP[0,1] to specify request type and response. (duplicated for bot=
h MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts full cache line data writes to uncache=
able write combining (USWC) memory region and full cache-line non-temporal =
writes have any transaction responses from the uncore subsystem.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.FULL_STREAMING_STORES.ANY_RESPONSE"=
,
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000010800",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts full cache line data writes to uncach=
eable write combining (USWC) memory region and full cache-line non-temporal=
 writes have any transaction responses from the uncore subsystem. Requires =
MSR_OFFCORE_RESP[0,1] to specify request type and response. (duplicated for=
 both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts full cache line data writes to uncache=
able write combining (USWC) memory region and full cache-line non-temporal =
writes hit the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.FULL_STREAMING_STORES.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000040800",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts full cache line data writes to uncach=
eable write combining (USWC) memory region and full cache-line non-temporal=
 writes hit the L2 cache. Requires MSR_OFFCORE_RESP[0,1] to specify request=
 type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts full cache line data writes to uncache=
able write combining (USWC) memory region and full cache-line non-temporal =
writes miss the L2 cache with a snoop hit in the other processor module, da=
ta forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.FULL_STREAMING_STORES.L2_MISS.HITM_=
OTHER_CORE",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x1000000800",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts full cache line data writes to uncach=
eable write combining (USWC) memory region and full cache-line non-temporal=
 writes miss the L2 cache with a snoop hit in the other processor module, d=
ata forwarding is required. Requires MSR_OFFCORE_RESP[0,1] to specify reque=
st type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts full cache line data writes to uncache=
able write combining (USWC) memory region and full cache-line non-temporal =
writes true miss for the L2 cache with a snoop miss in the other processor =
module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.FULL_STREAMING_STORES.L2_MISS.SNOOP=
_MISS_OR_NO_SNOOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0200000800",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts full cache line data writes to uncach=
eable write combining (USWC) memory region and full cache-line non-temporal=
 writes true miss for the L2 cache with a snoop miss in the other processor=
 module.  Requires MSR_OFFCORE_RESP[0,1] to specify request type and respon=
se. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts full cache line data writes to uncache=
able write combining (USWC) memory region and full cache-line non-temporal =
writes outstanding, per cycle, from the time of the L2 miss to when any res=
ponse is received.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.FULL_STREAMING_STORES.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000000800",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts full cache line data writes to uncach=
eable write combining (USWC) memory region and full cache-line non-temporal=
 writes outstanding, per cycle, from the time of the L2 miss to when any re=
sponse is received. Requires MSR_OFFCORE_RESP[0,1] to specify request type =
and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cache line reads generated by har=
dware L1 data cache prefetcher have any transaction responses from the unco=
re subsystem.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000012000",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data cache line reads generated by ha=
rdware L1 data cache prefetcher have any transaction responses from the unc=
ore subsystem. Requires MSR_OFFCORE_RESP[0,1] to specify request type and r=
esponse. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cache line reads generated by har=
dware L1 data cache prefetcher hit the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000042000",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data cache line reads generated by ha=
rdware L1 data cache prefetcher hit the L2 cache. Requires MSR_OFFCORE_RESP=
[0,1] to specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cache line reads generated by har=
dware L1 data cache prefetcher miss the L2 cache with a snoop hit in the ot=
her processor module, data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_MISS.HITM_OTHER_CO=
RE",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x1000002000",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data cache line reads generated by ha=
rdware L1 data cache prefetcher miss the L2 cache with a snoop hit in the o=
ther processor module, data forwarding is required. Requires MSR_OFFCORE_RE=
SP[0,1] to specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cache line reads generated by har=
dware L1 data cache prefetcher true miss for the L2 cache with a snoop miss=
 in the other processor module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_MISS.SNOOP_MISS_OR=
_NO_SNOOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0200002000",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data cache line reads generated by ha=
rdware L1 data cache prefetcher true miss for the L2 cache with a snoop mis=
s in the other processor module.  Requires MSR_OFFCORE_RESP[0,1] to specify=
 request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cache line reads generated by har=
dware L1 data cache prefetcher outstanding, per cycle, from the time of the=
 L2 miss to when any response is received.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000002000",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data cache line reads generated by ha=
rdware L1 data cache prefetcher outstanding, per cycle, from the time of th=
e L2 miss to when any response is received. Requires MSR_OFFCORE_RESP[0,1] =
to specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cacheline reads generated by hard=
ware L2 cache prefetcher have any transaction responses from the uncore sub=
system.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000010010",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data cacheline reads generated by har=
dware L2 cache prefetcher have any transaction responses from the uncore su=
bsystem. Requires MSR_OFFCORE_RESP[0,1] to specify request type and respons=
e. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cacheline reads generated by hard=
ware L2 cache prefetcher hit the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000040010",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data cacheline reads generated by har=
dware L2 cache prefetcher hit the L2 cache. Requires MSR_OFFCORE_RESP[0,1] =
to specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cacheline reads generated by hard=
ware L2 cache prefetcher miss the L2 cache with a snoop hit in the other pr=
ocessor module, data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L2_MISS.HITM_OTHER_CO=
RE",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x1000000010",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data cacheline reads generated by har=
dware L2 cache prefetcher miss the L2 cache with a snoop hit in the other p=
rocessor module, data forwarding is required. Requires MSR_OFFCORE_RESP[0,1=
] to specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cacheline reads generated by hard=
ware L2 cache prefetcher true miss for the L2 cache with a snoop miss in th=
e other processor module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L2_MISS.SNOOP_MISS_OR=
_NO_SNOOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0200000010",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data cacheline reads generated by har=
dware L2 cache prefetcher true miss for the L2 cache with a snoop miss in t=
he other processor module.  Requires MSR_OFFCORE_RESP[0,1] to specify reque=
st type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cacheline reads generated by hard=
ware L2 cache prefetcher outstanding, per cycle, from the time of the L2 mi=
ss to when any response is received.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000000010",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data cacheline reads generated by har=
dware L2 cache prefetcher outstanding, per cycle, from the time of the L2 m=
iss to when any response is received. Requires MSR_OFFCORE_RESP[0,1] to spe=
cify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests gen=
erated by L2 prefetcher have any transaction responses from the uncore subs=
ystem.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000010020",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts reads for ownership (RFO) requests ge=
nerated by L2 prefetcher have any transaction responses from the uncore sub=
system. Requires MSR_OFFCORE_RESP[0,1] to specify request type and response=
. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests gen=
erated by L2 prefetcher hit the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000040020",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts reads for ownership (RFO) requests ge=
nerated by L2 prefetcher hit the L2 cache. Requires MSR_OFFCORE_RESP[0,1] t=
o specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests gen=
erated by L2 prefetcher miss the L2 cache with a snoop hit in the other pro=
cessor module, data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_MISS.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x1000000020",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts reads for ownership (RFO) requests ge=
nerated by L2 prefetcher miss the L2 cache with a snoop hit in the other pr=
ocessor module, data forwarding is required. Requires MSR_OFFCORE_RESP[0,1]=
 to specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests gen=
erated by L2 prefetcher true miss for the L2 cache with a snoop miss in the=
 other processor module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_MISS.SNOOP_MISS_OR_NO_=
SNOOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0200000020",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts reads for ownership (RFO) requests ge=
nerated by L2 prefetcher true miss for the L2 cache with a snoop miss in th=
e other processor module.  Requires MSR_OFFCORE_RESP[0,1] to specify reques=
t type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts reads for ownership (RFO) requests gen=
erated by L2 prefetcher outstanding, per cycle, from the time of the L2 mis=
s to when any response is received.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000000020",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts reads for ownership (RFO) requests ge=
nerated by L2 prefetcher outstanding, per cycle, from the time of the L2 mi=
ss to when any response is received. Requires MSR_OFFCORE_RESP[0,1] to spec=
ify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any data writes to uncacheable write c=
ombining (USWC) memory region  have any transaction responses from the unco=
re subsystem.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.STREAMING_STORES.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000014800",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts any data writes to uncacheable write =
combining (USWC) memory region  have any transaction responses from the unc=
ore subsystem. Requires MSR_OFFCORE_RESP[0,1] to specify request type and r=
esponse. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any data writes to uncacheable write c=
ombining (USWC) memory region  hit the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.STREAMING_STORES.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000044800",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts any data writes to uncacheable write =
combining (USWC) memory region  hit the L2 cache. Requires MSR_OFFCORE_RESP=
[0,1] to specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any data writes to uncacheable write c=
ombining (USWC) memory region  miss the L2 cache with a snoop hit in the ot=
her processor module, data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.STREAMING_STORES.L2_MISS.HITM_OTHER=
_CORE",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x1000004800",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts any data writes to uncacheable write =
combining (USWC) memory region  miss the L2 cache with a snoop hit in the o=
ther processor module, data forwarding is required. Requires MSR_OFFCORE_RE=
SP[0,1] to specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any data writes to uncacheable write c=
ombining (USWC) memory region  true miss for the L2 cache with a snoop miss=
 in the other processor module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.STREAMING_STORES.L2_MISS.SNOOP_MISS=
_OR_NO_SNOOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0200004800",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts any data writes to uncacheable write =
combining (USWC) memory region  true miss for the L2 cache with a snoop mis=
s in the other processor module.  Requires MSR_OFFCORE_RESP[0,1] to specify=
 request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any data writes to uncacheable write c=
ombining (USWC) memory region  outstanding, per cycle, from the time of the=
 L2 miss to when any response is received.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.STREAMING_STORES.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000004800",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts any data writes to uncacheable write =
combining (USWC) memory region  outstanding, per cycle, from the time of th=
e L2 miss to when any response is received. Requires MSR_OFFCORE_RESP[0,1] =
to specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cache lines requests by software =
prefetch instructions have any transaction responses from the uncore subsys=
tem.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.SW_PREFETCH.ANY_RESPONSE",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000011000",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data cache lines requests by software=
 prefetch instructions have any transaction responses from the uncore subsy=
stem. Requires MSR_OFFCORE_RESP[0,1] to specify request type and response. =
(duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cache lines requests by software =
prefetch instructions hit the L2 cache.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.SW_PREFETCH.L2_HIT",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0000041000",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data cache lines requests by software=
 prefetch instructions hit the L2 cache. Requires MSR_OFFCORE_RESP[0,1] to =
specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cache lines requests by software =
prefetch instructions miss the L2 cache with a snoop hit in the other proce=
ssor module, data forwarding is required.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.SW_PREFETCH.L2_MISS.HITM_OTHER_CORE=
",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x1000001000",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data cache lines requests by software=
 prefetch instructions miss the L2 cache with a snoop hit in the other proc=
essor module, data forwarding is required. Requires MSR_OFFCORE_RESP[0,1] t=
o specify request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cache lines requests by software =
prefetch instructions true miss for the L2 cache with a snoop miss in the o=
ther processor module.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.SW_PREFETCH.L2_MISS.SNOOP_MISS_OR_N=
O_SNOOP_NEEDED",
         "MSRIndex": "0x1a6, 0x1a7",
         "MSRValue": "0x0200001000",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data cache lines requests by software=
 prefetch instructions true miss for the L2 cache with a snoop miss in the =
other processor module.  Requires MSR_OFFCORE_RESP[0,1] to specify request =
type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data cache lines requests by software =
prefetch instructions outstanding, per cycle, from the time of the L2 miss =
to when any response is received.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.SW_PREFETCH.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000001000",
-        "Offcore": "1",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts data cache lines requests by software=
 prefetch instructions outstanding, per cycle, from the time of the L2 miss=
 to when any response is received. Requires MSR_OFFCORE_RESP[0,1] to specif=
y request type and response. (duplicated for both MSRs)",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/floating-point.jso=
n b/tools/perf/pmu-events/arch/x86/goldmontplus/floating-point.json
index 9c3d22439530..822a7a6bcaeb 100644
--- a/tools/perf/pmu-events/arch/x86/goldmontplus/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/goldmontplus/floating-point.json
@@ -1,36 +1,25 @@
 [
     {
         "BriefDescription": "Cycles the FP divide unit is busy",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCD",
         "EventName": "CYCLES_DIV_BUSY.FPDIV",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts core cycles the floating point divide=
 unit is busy.",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Machine clears due to FP assists",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.FP_ASSIST",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts machine clears due to floating point =
(FP) operations needing assists.  For instance, if the result was a floatin=
g point denormal, the hardware clears the pipeline and reissues uops to pro=
duce the correct IEEE compliant denormal result.",
         "SampleAfterValue": "20003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Floating point divide uops retired (Precise E=
vent Capable)",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.FPDIV",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of floating point divide u=
ops retired.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/frontend.json b/to=
ols/perf/pmu-events/arch/x86/goldmontplus/frontend.json
index 4c2abfbac8f8..ace2a114b546 100644
--- a/tools/perf/pmu-events/arch/x86/goldmontplus/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/goldmontplus/frontend.json
@@ -1,96 +1,64 @@
 [
     {
         "BriefDescription": "BACLEARs asserted for any branch type",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xE6",
         "EventName": "BACLEARS.ALL",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of times a BACLEAR is sign=
aled for any reason, including, but not limited to indirect branch/call,  J=
cc (Jump on Conditional Code/Jump if Condition is Met) branch, unconditiona=
l branch/call, and returns.",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "BACLEARs asserted for conditional branch",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xE6",
         "EventName": "BACLEARS.COND",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts BACLEARS on Jcc (Jump on Conditional =
Code/Jump if Condition is Met) branches.",
         "SampleAfterValue": "200003",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "BACLEARs asserted for return branch",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xE6",
         "EventName": "BACLEARS.RETURN",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts BACLEARS on return instructions.",
         "SampleAfterValue": "200003",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Decode restrictions due to predicting wrong i=
nstruction length",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xE9",
         "EventName": "DECODE_RESTRICTION.PREDECODE_WRONG",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of times the prediction (f=
rom the predecode cache) for instruction length is incorrect.",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "References per ICache line. This event counts=
 differently than Intel processors based on Silvermont microarchitecture",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "ICACHE.ACCESSES",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts requests to the Instruction Cache (IC=
ache) for one or more bytes in an ICache Line.  The event strives to count =
on a cache line basis, so that multiple fetches to a single cache line coun=
t as one ICACHE.ACCESS.  Specifically, the event counts when accesses from =
straight line code crosses the cache line boundary, or when a branch target=
 is to a new line.\r\nThis event counts differently than Intel processors b=
ased on Silvermont microarchitecture.",
         "SampleAfterValue": "200003",
         "UMask": "0x3"
     },
     {
         "BriefDescription": "References per ICache line that are available=
 in the ICache (hit). This event counts differently than Intel processors b=
ased on Silvermont microarchitecture",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "ICACHE.HIT",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts requests to the Instruction Cache (IC=
ache) for one or more bytes in an ICache Line and that cache line is in the=
 ICache (hit).  The event strives to count on a cache line basis, so that m=
ultiple accesses which hit in a single cache line count as one ICACHE.HIT. =
 Specifically, the event counts when straight line code crosses the cache l=
ine boundary, or when a branch target is to a new line, and that cache line=
 is in the ICache. This event counts differently than Intel processors base=
d on Silvermont microarchitecture.",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "References per ICache line that are not avail=
able in the ICache (miss). This event counts differently than Intel process=
ors based on Silvermont microarchitecture",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "ICACHE.MISSES",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts requests to the Instruction Cache (IC=
ache)  for one or more bytes in an ICache Line and that cache line is not i=
n the ICache (miss).  The event strives to count on a cache line basis, so =
that multiple accesses which miss in a single cache line count as one ICACH=
E.MISS.  Specifically, the event counts when straight line code crosses the=
 cache line boundary, or when a branch target is to a new line, and that ca=
che line is not in the ICache. This event counts differently than Intel pro=
cessors based on Silvermont microarchitecture.",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "MS decode starts",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xE7",
         "EventName": "MS_DECODED.MS_ENTRY",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of times the Microcode Seq=
uencer (MS) starts a flow of uops from the MSROM. It does not count every t=
ime a uop is read from the MSROM.  The most common case that this counts is=
 when a micro-coded instruction is encountered by the front end of the mach=
ine.  Other cases include when an instruction encounters a fault, trap, or =
microcode assist of any sort that initiates a flow of uops.  The event will=
 count MS startups for uops that are speculative, and subsequently cleared =
by branch mispredict or a machine clear.",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/memory.json b/tool=
s/perf/pmu-events/arch/x86/goldmontplus/memory.json
index ae0cb3451866..7038873a5c8d 100644
--- a/tools/perf/pmu-events/arch/x86/goldmontplus/memory.json
+++ b/tools/perf/pmu-events/arch/x86/goldmontplus/memory.json
@@ -1,36 +1,26 @@
 [
     {
         "BriefDescription": "Machine clears due to memory ordering issue",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts machine clears due to memory ordering=
 issues.  This occurs when a snoop request happens and the machine is uncer=
tain if memory ordering will be preserved - as another core is in the proce=
ss of modifying the data.",
         "SampleAfterValue": "20003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Load uops that split a page (Precise event ca=
pable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "MISALIGN_MEM_REF.LOAD_PAGE_SPLIT",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts when a memory load of a uop spans a p=
age boundary (a split) is retired.",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Store uops that split a page (Precise event c=
apable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "MISALIGN_MEM_REF.STORE_PAGE_SPLIT",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts when a memory store of a uop spans a =
page boundary (a split) is retired.",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/other.json b/tools=
/perf/pmu-events/arch/x86/goldmontplus/other.json
index 92586fe4538a..ec0ce9078c98 100644
--- a/tools/perf/pmu-events/arch/x86/goldmontplus/other.json
+++ b/tools/perf/pmu-events/arch/x86/goldmontplus/other.json
@@ -1,59 +1,39 @@
 [
     {
         "BriefDescription": "Cycles code-fetch stalled due to any reason."=
,
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "FETCH_STALL.ALL",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts cycles that fetch is stalled due to a=
ny reason. That is, the decoder queue is able to accept bytes, but the fetc=
h unit is unable to provide bytes.  This will include cycles due to an ITLB=
 miss, ICache miss and other events.",
         "SampleAfterValue": "200003"
     },
     {
         "BriefDescription": "Cycles the code-fetch stalls and an ITLB miss=
 is outstanding.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "FETCH_STALL.ITLB_FILL_PENDING_CYCLES",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts cycles that fetch is stalled due to a=
n outstanding ITLB miss. That is, the decoder queue is able to accept bytes=
, but the fetch unit is unable to provide bytes due to an ITLB miss.  Note:=
 this event is not the same as page walk cycles to retrieve an instruction =
translation.",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Cycles hardware interrupts are masked",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCB",
         "EventName": "HW_INTERRUPTS.MASKED",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of core cycles during whic=
h interrupts are masked (disabled). Increments by 1 each core cycle that EF=
LAGS.IF is 0, regardless of whether interrupts are pending or not.",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Cycles pending interrupts are masked",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCB",
         "EventName": "HW_INTERRUPTS.PENDING_AND_MASKED",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts core cycles during which there are pe=
nding interrupts, but interrupts are masked (EFLAGS.IF =3D 0).",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Hardware interrupts received",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCB",
         "EventName": "HW_INTERRUPTS.RECEIVED",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts hardware interrupts received by the p=
rocessor.",
         "SampleAfterValue": "203",
         "UMask": "0x1"
diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json b/to=
ols/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
index 2b712b12cc1f..33ef331e77e0 100644
--- a/tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
@@ -1,289 +1,208 @@
 [
     {
         "BriefDescription": "Retired branch instructions (Precise event ca=
pable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts branch instructions retired for all b=
ranch types.  This is an architectural performance event.",
         "SampleAfterValue": "200003"
     },
     {
         "BriefDescription": "Retired taken branch instructions (Precise ev=
ent capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ALL_TAKEN_BRANCHES",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of taken branch instructio=
ns retired.",
         "SampleAfterValue": "200003",
         "UMask": "0x80"
     },
     {
         "BriefDescription": "Retired near call instructions (Precise event=
 capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.CALL",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts near CALL branch instructions retired=
.",
         "SampleAfterValue": "200003",
         "UMask": "0xf9"
     },
     {
         "BriefDescription": "Retired far branch instructions (Precise even=
t capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts far branch instructions retired.  Thi=
s includes far jump, far call and return, and Interrupt call and return.",
         "SampleAfterValue": "200003",
         "UMask": "0xbf"
     },
     {
         "BriefDescription": "Retired near indirect call instructions (Prec=
ise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.IND_CALL",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts near indirect CALL branch instruction=
s retired.",
         "SampleAfterValue": "200003",
         "UMask": "0xfb"
     },
     {
         "BriefDescription": "Retired conditional branch instructions (Prec=
ise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.JCC",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts retired Jcc (Jump on Conditional Code=
/Jump if Condition is Met) branch instructions retired, including both when=
 the branch was taken and when it was not taken.",
         "SampleAfterValue": "200003",
         "UMask": "0x7e"
     },
     {
         "BriefDescription": "Retired instructions of near indirect Jmp or =
call (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NON_RETURN_IND",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts near indirect call or near indirect j=
mp branch instructions retired.",
         "SampleAfterValue": "200003",
         "UMask": "0xeb"
     },
     {
         "BriefDescription": "Retired near relative call instructions (Prec=
ise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.REL_CALL",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts near relative CALL branch instruction=
s retired.",
         "SampleAfterValue": "200003",
         "UMask": "0xfd"
     },
     {
         "BriefDescription": "Retired near return instructions (Precise eve=
nt capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.RETURN",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts near return branch instructions retir=
ed.",
         "SampleAfterValue": "200003",
         "UMask": "0xf7"
     },
     {
         "BriefDescription": "Retired conditional branch instructions that =
were taken (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.TAKEN_JCC",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts Jcc (Jump on Conditional Code/Jump if=
 Condition is Met) branch instructions retired that were taken and does not=
 count when the Jcc branch instruction were not taken.",
         "SampleAfterValue": "200003",
         "UMask": "0xfe"
     },
     {
         "BriefDescription": "Retired mispredicted branch instructions (Pre=
cise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts mispredicted branch instructions reti=
red including all branch types.",
         "SampleAfterValue": "200003"
     },
     {
         "BriefDescription": "Retired mispredicted near indirect call instr=
uctions (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.IND_CALL",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts mispredicted near indirect CALL branc=
h instructions retired, where the target address taken was not what the pro=
cessor predicted.",
         "SampleAfterValue": "200003",
         "UMask": "0xfb"
     },
     {
         "BriefDescription": "Retired mispredicted conditional branch instr=
uctions (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.JCC",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts mispredicted retired Jcc (Jump on Con=
ditional Code/Jump if Condition is Met) branch instructions retired, includ=
ing both when the branch was supposed to be taken and when it was not suppo=
sed to be taken (but the processor predicted the opposite condition).",
         "SampleAfterValue": "200003",
         "UMask": "0x7e"
     },
     {
         "BriefDescription": "Retired mispredicted instructions of near ind=
irect Jmp or near indirect call (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.NON_RETURN_IND",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts mispredicted branch instructions reti=
red that were near indirect call or near indirect jmp, where the target add=
ress taken was not what the processor predicted.",
         "SampleAfterValue": "200003",
         "UMask": "0xeb"
     },
     {
         "BriefDescription": "Retired mispredicted near return instructions=
 (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.RETURN",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts mispredicted near RET branch instruct=
ions retired, where the return address taken was not what the processor pre=
dicted.",
         "SampleAfterValue": "200003",
         "UMask": "0xf7"
     },
     {
         "BriefDescription": "Retired mispredicted conditional branch instr=
uctions that were taken (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.TAKEN_JCC",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts mispredicted retired Jcc (Jump on Con=
ditional Code/Jump if Condition is Met) branch instructions retired that we=
re supposed to be taken but the processor predicted that it would not be ta=
ken.",
         "SampleAfterValue": "200003",
         "UMask": "0xfe"
     },
     {
         "BriefDescription": "Core cycles when core is not halted  (Fixed e=
vent)",
-        "CollectPEBSRecord": "1",
-        "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.CORE",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "33",
         "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state.  The core enters the halt state when it is runn=
ing the HLT instruction. In mobile systems the core frequency may change fr=
om time to time. For this reason this event may have a changing ratio with =
regards to time.  This event uses fixed counter 1.  You cannot collect a PE=
Bs record for this event.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Core cycles when core is not halted",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.CORE_P",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Core cycles when core is not halted.  This e=
vent uses a (_P)rogrammable general purpose performance counter.",
         "SampleAfterValue": "2000003"
     },
     {
         "BriefDescription": "Reference cycles when core is not halted",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.REF",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Reference cycles when core is not halted.  T=
his event uses a (_P)rogrammable general purpose performance counter.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Reference cycles when core is not halted  (Fi=
xed event)",
-        "CollectPEBSRecord": "1",
-        "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "34",
         "PublicDescription": "Counts the number of reference cycles that t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction.  In mobile systems the core frequency may chang=
e from time.  This event is not affected by core frequency changes but coun=
ts as if the core is running at the maximum frequency all the time.  This e=
vent uses fixed counter 2.  You cannot collect a PEBs record for this event=
.",
         "SampleAfterValue": "2000003",
         "UMask": "0x3"
     },
     {
         "BriefDescription": "Cycles a divider is busy",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCD",
         "EventName": "CYCLES_DIV_BUSY.ALL",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts core cycles if either divide unit is =
busy.",
         "SampleAfterValue": "2000003"
     },
     {
         "BriefDescription": "Cycles the integer divide unit is busy",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCD",
         "EventName": "CYCLES_DIV_BUSY.IDIV",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts core cycles the integer divide unit i=
s busy.",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Instructions retired (Fixed event)",
-        "CollectPEBSRecord": "1",
-        "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
-        "PDIR_COUNTER": "na",
         "PEBS": "2",
-        "PEBScounters": "32",
         "PublicDescription": "Counts the number of instructions that retir=
e execution. For instructions that consist of multiple uops, this event cou=
nts the retirement of the last uop of the instruction. The counter continue=
s counting during hardware interrupts, traps, and inside interrupt handlers=
.  This event uses fixed counter 0.  You cannot collect a PEBs record for t=
his event.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Instructions retired (Precise event capable)"=
,
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.ANY_P",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of instructions that retir=
e execution. For instructions that consist of multiple uops, this event cou=
nts the retirement of the last uop of the instruction. The event continues =
counting during hardware interrupts, traps, and inside interrupt handlers. =
 This is an architectural performance event.  This event uses a (_P)rogramm=
able general purpose performance counter. *This event is Precise Event capa=
ble:  The EventingRIP field in the PEBS record is precise to the address of=
 the instruction which caused the event.  Note: Because PEBS records can be=
 collected only on IA32_PMC0, only one event can use the PEBS facility at a=
 time.",
         "SampleAfterValue": "2000003"
     },
     {
         "BriefDescription": "Instructions retired - using Reduced Skid PEB=
S feature",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.PREC_DIST",
         "PEBS": "2",
@@ -292,201 +211,139 @@
     },
     {
         "BriefDescription": "Unfilled issue slots per cycle",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCA",
         "EventName": "ISSUE_SLOTS_NOT_CONSUMED.ANY",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of issue slots per core cy=
cle that were not consumed by the backend due to either a full resource  in=
 the backend (RESOURCE_FULL) or due to the processor recovering from some e=
vent (RECOVERY).",
         "SampleAfterValue": "200003"
     },
     {
         "BriefDescription": "Unfilled issue slots per cycle to recover",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCA",
         "EventName": "ISSUE_SLOTS_NOT_CONSUMED.RECOVERY",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of issue slots per core cy=
cle that were not consumed by the backend because allocation is stalled wai=
ting for a mispredicted jump to retire or other branch-like conditions (e.g=
. the event is relevant during certain microcode flows).   Counts all issue=
 slots blocked while within this window including slots where uops were not=
 available in the Instruction Queue.",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Unfilled issue slots per cycle because of a f=
ull resource in the backend",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xCA",
         "EventName": "ISSUE_SLOTS_NOT_CONSUMED.RESOURCE_FULL",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of issue slots per core cy=
cle that were not consumed because of a full resource in the backend.  Incl=
uding but not limited to resources such as the Re-order Buffer (ROB), reser=
vation stations (RS), load/store buffers, physical registers, or any other =
needed machine resource that is currently unavailable.   Note that uops mus=
t be available for consumption in order for this event to fire.  If a uop i=
s not available (Instruction Queue is empty), this event will not count.",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Loads blocked because address has 4k partial =
address false dependence (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.4K_ALIAS",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts loads that block because their addres=
s modulo 4K matches a pending store.",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Loads blocked (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.ALL_BLOCK",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts anytime a load that retires is blocke=
d for any reason.",
         "SampleAfterValue": "200003",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Loads blocked due to store data not ready (Pr=
ecise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.DATA_UNKNOWN",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts a load blocked from using a store for=
ward, but did not occur because the store data was not available at the rig=
ht time.  The forward might occur subsequently when the data is available."=
,
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Loads blocked due to store forward restrictio=
n (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts a load blocked from using a store for=
ward because of an address/size mismatch, only one of the loads blocked fro=
m each store will be counted.",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Loads blocked because address in not in the U=
TLB (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.UTLB_MISS",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts loads blocked because they are unable=
 to find their physical address in the micro TLB (UTLB).",
         "SampleAfterValue": "200003",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "All machine clears",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.ALL",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts machine clears for any reason.",
         "SampleAfterValue": "20003"
     },
     {
         "BriefDescription": "Machine clears due to memory disambiguation",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.DISAMBIGUATION",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts machine clears due to memory disambig=
uation.  Memory disambiguation happens when a load which has been issued co=
nflicts with a previous unretired store in the pipeline whose address was n=
ot known at issue time, but is later resolved to be the same as the load ad=
dress.",
         "SampleAfterValue": "20003",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Machines clear due to a page fault",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.PAGE_FAULT",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of times that the machines=
 clears due to a page fault. Covers both I-side and D-side(Loads/Stores) pa=
ge faults. A page fault occurs when either page is not present, or an acces=
s violation",
         "SampleAfterValue": "20003",
         "UMask": "0x20"
     },
     {
         "BriefDescription": "Self-Modifying Code detected",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.SMC",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of times that the processo=
r detects that a program is writing to a code section and has to perform a =
machine clear because of that modification.  Self-modifying code (SMC) caus=
es a severe penalty in all Intel(R) architecture processors.",
         "SampleAfterValue": "20003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Uops issued to the back end per cycle",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x0E",
         "EventName": "UOPS_ISSUED.ANY",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts uops issued by the front end and allo=
cated into the back end of the machine.  This event counts uops that retire=
 as well as uops that were speculatively executed but didn't retire. The so=
rt of speculative uops that might be counted includes, but is not limited t=
o those uops issued in the shadow of a miss-predicted branch, those uops th=
at are inserted during an assist (such as for a denormal floating point res=
ult), and (previously allocated) uops that might be canceled during a machi=
ne clear.",
         "SampleAfterValue": "200003"
     },
     {
         "BriefDescription": "Uops requested but not-delivered to the back-=
end per cycle",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9C",
         "EventName": "UOPS_NOT_DELIVERED.ANY",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
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
         "SampleAfterValue": "200003"
     },
     {
         "BriefDescription": "Uops retired (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.ANY",
-        "PDIR_COUNTER": "na",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts uops which retired.",
         "SampleAfterValue": "2000003"
     },
     {
         "BriefDescription": "Integer divide uops retired (Precise Event Ca=
pable)",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.IDIV",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of integer divide uops ret=
ired.",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "MS uops retired (Precise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.MS",
-        "PDIR_COUNTER": "na",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts uops retired that are from the comple=
x flows issued by the micro-sequencer (MS).  Counts both the uops from a mi=
cro-coded instruction, and the uops that might be generated from a micro-co=
ded assist.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.jso=
n b/tools/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.json
index 1f7db22c15e6..3d6feb45a50b 100644
--- a/tools/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.json
@@ -1,219 +1,150 @@
 [
     {
         "BriefDescription": "Page walk completed due to a demand load to a=
 1GB page",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_1GB",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts page walks completed due to demand da=
ta loads (including SW prefetches) whose address translations missed in all=
 TLB levels and were mapped to 1GB pages.  The page walks can end with or w=
ithout a page fault.",
         "SampleAfterValue": "200003",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Page walk completed due to a demand load to a=
 2M or 4M page",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts page walks completed due to demand da=
ta loads (including SW prefetches) whose address translations missed in all=
 TLB levels and were mapped to 2M or 4M pages.  The page walks can end with=
 or without a page fault.",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Page walk completed due to a demand load to a=
 4K page",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts page walks completed due to demand da=
ta loads (including SW prefetches) whose address translations missed in all=
 TLB levels and were mapped to 4K pages.  The page walks can end with or wi=
thout a page fault.",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Page walks outstanding due to a demand load e=
very cycle.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_PENDING",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts once per cycle for each page walk occ=
urring due to a load (demand data loads or SW prefetches). Includes cycles =
spent traversing the Extended Page Table (EPT). Average cycles per walk can=
 be calculated by dividing by the number of walks.",
         "SampleAfterValue": "200003",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Page walk completed due to a demand data stor=
e to a 1GB page",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_1GB",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts page walks completed due to demand da=
ta stores whose address translations missed in the TLB and were mapped to 1=
GB pages.  The page walks can end with or without a page fault.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Page walk completed due to a demand data stor=
e to a 2M or 4M page",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts page walks completed due to demand da=
ta stores whose address translations missed in the TLB and were mapped to 2=
M or 4M pages.  The page walks can end with or without a page fault.",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Page walk completed due to a demand data stor=
e to a 4K page",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts page walks completed due to demand da=
ta stores whose address translations missed in the TLB and were mapped to 4=
K pages.  The page walks can end with or without a page fault.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Page walks outstanding due to a demand data s=
tore every cycle.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_PENDING",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts once per cycle for each page walk occ=
urring due to a demand data store. Includes cycles spent traversing the Ext=
ended Page Table (EPT). Average cycles per walk can be calculated by dividi=
ng by the number of walks.",
         "SampleAfterValue": "200003",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Page walks outstanding due to walking the EPT=
 every cycle",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x4F",
         "EventName": "EPT.WALK_PENDING",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts once per cycle for each page walk onl=
y while traversing the Extended Page Table (EPT), and does not count during=
 the rest of the translation.  The EPT is used for translating Guest-Physic=
al Addresses to Physical Addresses for Virtual Machine Monitors (VMMs).  Av=
erage cycles per walk can be calculated by dividing the count by number of =
walks.",
         "SampleAfterValue": "200003",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "ITLB misses",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x81",
         "EventName": "ITLB.MISS",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of times the machine was u=
nable to find a translation in the Instruction Translation Lookaside Buffer=
 (ITLB) for a linear address of an instruction fetch.  It counts when new t=
ranslation are filled into the ITLB.  The event is speculative in nature, b=
ut will not count translations (page walks) that are begun and not finished=
, or translations that are finished but not filled into the ITLB.",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Page walk completed due to an instruction fet=
ch in a 1GB page",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_1GB",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts page walks completed due to instructi=
on fetches whose address translations missed in the TLB and were mapped to =
1GB pages.  The page walks can end with or without a page fault.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Page walk completed due to an instruction fet=
ch in a 2M or 4M page",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts page walks completed due to instructi=
on fetches whose address translations missed in the TLB and were mapped to =
2M or 4M pages.  The page walks can end with or without a page fault.",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Page walk completed due to an instruction fet=
ch in a 4K page",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts page walks completed due to instructi=
on fetches whose address translations missed in the TLB and were mapped to =
4K pages.  The page walks can end with or without a page fault.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Page walks outstanding due to an instruction =
fetch every cycle.",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_PENDING",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts once per cycle for each page walk occ=
urring due to an instruction fetch. Includes cycles spent traversing the Ex=
tended Page Table (EPT). Average cycles per walk can be calculated by divid=
ing by the number of walks.",
         "SampleAfterValue": "200003",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Memory uops retired that missed the DTLB (Pre=
cise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts uops retired that had a DTLB miss on =
load, store or either.  Note that when two distinct memory operations to th=
e same page miss the DTLB, only one of them will be recorded as a DTLB miss=
.",
         "SampleAfterValue": "200003",
         "UMask": "0x13"
     },
     {
         "BriefDescription": "Load uops retired that missed the DTLB (Preci=
se event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS_LOADS",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts load uops retired that caused a DTLB =
miss.",
         "SampleAfterValue": "200003",
         "UMask": "0x11"
     },
     {
         "BriefDescription": "Store uops retired that missed the DTLB (Prec=
ise event capable)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS_STORES",
         "PEBS": "2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts store uops retired that caused a DTLB=
 miss.",
         "SampleAfterValue": "200003",
         "UMask": "0x12"
     },
     {
         "BriefDescription": "STLB flushes",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xBD",
         "EventName": "TLB_FLUSHES.STLB_ANY",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts STLB flushes.  The TLBs are flushed o=
n instructions like INVLPG and MOV to CR3.",
         "SampleAfterValue": "20003",
         "UMask": "0x20"
--=20
2.39.0.314.g84b9a713c41-goog

