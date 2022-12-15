Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD91464D6CF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 07:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiLOG7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 01:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiLOG6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:58:25 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3D660368
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:56:53 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id y6-20020a25b9c6000000b006c1c6161716so2659079ybj.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgCGeJgGWxSXpCc2LOXt0Yt6Pwuovw4gY/VZ6S6e7nA=;
        b=BtpyxCk/WatRzOQ+dJtCQ2ItlZNMGpn/U43qgUjKJZ5C68jG1RNgdwziWBXalcUzxP
         OZCOJXN7eDkFS1zNJ3n0I/tMFgsX3r+aZ5ifqayRUClvR2/OrZYgQPMOR+hgCakAaBQm
         CZSCzh/9C/uZTtUkf22EcSoDFGTf6faXf/bHQ8rnkF3A8hd6hLuxMr3UvNazXSRD+l9T
         Lh57k+A94p8jPjacD5XfMdA9L/WJZ4ercnakJwZ6NsKmQM8iWl/aZf9aOCkAGcun0ceh
         HIWZuDvgoX/a6Xq9Ux72TEve8lN01yJwpL/+bnlaBwXHntKlVbWk/E0UFCDD3BrdjxZl
         f38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NgCGeJgGWxSXpCc2LOXt0Yt6Pwuovw4gY/VZ6S6e7nA=;
        b=7Ej88CXcGc9hQsEF8ZDn6HRZ1UNGIdDrsjB3NelisQd/E85gLWX3BOG2tQTaVIpCCd
         Lv4XdqyDXc0TGxv4sOWWzoiNnQ1y+QNJDZJnfisRn+NyUOWI6LiYAxf5ghkO3qLTY0WB
         RsSqkD5PBba67+BozmYu9Fk1FJm1/SAl3P2Dijo/PQItsbdnJqgbXxNutfk98HtXXSjS
         dxBM+mB/9Mvp5CHzYVlx89wpZUZ1bFmQCYh3JkMPHXjOC6CIfKoK5xPttnyBB3hRCKVq
         XJKR/iGaQoN4PxCMFnCuRODgpbtxMNtT9ogXkMN3BE6W4D77vaYoJUdYrYLSD71+0Fv+
         YX9Q==
X-Gm-Message-State: ANoB5plhTVxqQaAVTy9WOaCMBzRLFZy2d0C0PBhgGu5iEYv3uyMoMwID
        kjbafT72y5R4y26gd2z3/6qW2LxkYOI+
X-Google-Smtp-Source: AA0mqf6fM5qiBLU7OVSsRMy5Qz2zY6lIO/lvWIMN01zKFK5cKzyhuCuUMn6g9bE7vJRvCSBjXBg7GBbuYzPv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c7dc:d96f:4f9:f59d])
 (user=irogers job=sendgmr) by 2002:a05:690c:d81:b0:3b6:4fa2:1a10 with SMTP id
 da1-20020a05690c0d8100b003b64fa21a10mr2920520ywb.48.1671087412745; Wed, 14
 Dec 2022 22:56:52 -0800 (PST)
Date:   Wed, 14 Dec 2022 22:54:57 -0800
In-Reply-To: <20221215065510.1621979-1-irogers@google.com>
Message-Id: <20221215065510.1621979-11-irogers@google.com>
Mime-Version: 1.0
References: <20221215065510.1621979-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 19/32] perf vendor events intel: Refresh knightslanding events
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

Update the knightslanding events using the new tooling from:
https://github.com/intel/perfmon

The events are unchanged but unused json values are removed. This
increases consistency across the json files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/knightslanding/cache.json        |  411 -------
 .../x86/knightslanding/floating-point.json    |    3 -
 .../arch/x86/knightslanding/frontend.json     |    7 -
 .../arch/x86/knightslanding/memory.json       |  201 ----
 .../arch/x86/knightslanding/pipeline.json     |   44 -
 .../arch/x86/knightslanding/uncore-other.json | 1040 +++++------------
 .../x86/knightslanding/virtual-memory.json    |    7 -
 7 files changed, 299 insertions(+), 1414 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/cache.json b/too=
ls/perf/pmu-events/arch/x86/knightslanding/cache.json
index 5e10eabda300..01aea3d2832e 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
@@ -1,14 +1,12 @@
 [
     {
         "BriefDescription": "Counts the number of MEC requests that were n=
ot accepted into the L2Q because of any L2  queue reject condition. There i=
s no concept of at-ret here. It might include requests due to instructions =
in the speculative path.",
-        "Counter": "0,1",
         "EventCode": "0x31",
         "EventName": "CORE_REJECT_L2Q.ALL",
         "SampleAfterValue": "200003"
     },
     {
         "BriefDescription": "Counts the number of core cycles the fetch st=
alls because of an icache miss. This is a cummulative count of core cycles =
the fetch stalled for all icache misses.",
-        "Counter": "0,1",
         "EventCode": "0x86",
         "EventName": "FETCH_STALL.ICACHE_FILL_PENDING_CYCLES",
         "PublicDescription": "This event counts the number of core cycles =
the fetch stalls because of an icache miss. This is a cumulative count of c=
ycles the NIP stalled for all icache misses.",
@@ -17,7 +15,6 @@
     },
     {
         "BriefDescription": "Counts the number of L2 cache misses",
-        "Counter": "0,1",
         "EventCode": "0x2E",
         "EventName": "L2_REQUESTS.MISS",
         "SampleAfterValue": "200003",
@@ -25,7 +22,6 @@
     },
     {
         "BriefDescription": "Counts the total number of L2 cache reference=
s.",
-        "Counter": "0,1",
         "EventCode": "0x2E",
         "EventName": "L2_REQUESTS.REFERENCE",
         "SampleAfterValue": "200003",
@@ -33,14 +29,12 @@
     },
     {
         "BriefDescription": "Counts the number of MEC requests from the L2=
Q that reference a cache line (cacheable requests) exlcuding SW prefetches =
filling only to L2 cache and L1 evictions (automatically exlcudes L2HWP, UC=
, WC) that were rejected - Multiple repeated rejects should be counted mult=
iple times",
-        "Counter": "0,1",
         "EventCode": "0x30",
         "EventName": "L2_REQUESTS_REJECT.ALL",
         "SampleAfterValue": "200003"
     },
     {
         "BriefDescription": "Counts all the load micro-ops retired",
-        "Counter": "0,1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
         "PublicDescription": "This event counts the number of load micro-o=
ps retired.",
@@ -49,7 +43,6 @@
     },
     {
         "BriefDescription": "Counts all the store micro-ops retired",
-        "Counter": "0,1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
         "PublicDescription": "This event counts the number of store micro-=
ops retired.",
@@ -58,7 +51,6 @@
     },
     {
         "BriefDescription": "Counts the loads retired that get the data fr=
om the other core in the same tile in M state",
-        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.HITM",
@@ -68,7 +60,6 @@
     },
     {
         "BriefDescription": "Counts the number of load micro-ops retired t=
hat miss in L1 D cache",
-        "Counter": "0,1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.L1_MISS_LOADS",
         "PublicDescription": "This event counts the number of load micro-o=
ps retired that miss in L1 Data cache. Note that prefetch misses will not b=
e counted.",
@@ -77,7 +68,6 @@
     },
     {
         "BriefDescription": "Counts the number of load micro-ops retired t=
hat hit in the L2",
-        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.L2_HIT_LOADS",
@@ -87,7 +77,6 @@
     },
     {
         "BriefDescription": "Counts the number of load micro-ops retired t=
hat miss in the L2",
-        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.L2_MISS_LOADS",
@@ -97,7 +86,6 @@
     },
     {
         "BriefDescription": "Counts the number of load micro-ops retired t=
hat caused micro TLB miss",
-        "Counter": "0,1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.UTLB_MISS_LOADS",
         "SampleAfterValue": "200003",
@@ -105,7 +93,6 @@
     },
     {
         "BriefDescription": "Counts the matrix events specified by MSR_OFF=
CORE_RESPx",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE",
         "SampleAfterValue": "100007",
@@ -113,2190 +100,1792 @@
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for any response",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010044",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for reponses from snoop request hit with data fo=
rwarded from it Far(not in the same quadrant as the request)-other tile L2 =
in E/F/M state. Valid only in SNC4 Cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1800400044",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for responses from a snoop request hit with data=
 forwarded from its Far(not in the same quadrant as the request)-other tile=
's L2 in E/F state. Valid only for SNC4 cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_FAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800400044",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for responses from a snoop request hit with data=
 forwarded from its Far(not in the same quadrant as the request)-other tile=
's L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000400044",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for reponses from snoop request hit with data fo=
rwarded from its Near-other tile L2 in E/F/M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1800180044",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for responses from a snoop request hit with data=
 forwarded from its Near-other tile's L2 in E/F state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800080044",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for responses from a snoop request hit with data=
 forwarded from its Near-other tile's L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080044",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for responses which hit its own tile's L2 with d=
ata in E state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0004000044",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for responses which hit its own tile's L2 with d=
ata in F state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0010000044",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for responses which hit its own tile's L2 with d=
ata in M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0002000044",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for responses which hit its own tile's L2 with d=
ata in S state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0008000044",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that are outstanding, per weighted cycle, from the time of the=
 request to when any response is received. The oustanding response should b=
e programmed only on PMC0.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000000044",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for any response",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000013091",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for reponses from snoop request hit with =
data forwarded from it Far(not in the same quadrant as the request)-other t=
ile L2 in E/F/M state. Valid only in SNC4 Cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1800403091",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for responses from a snoop request hit wi=
th data forwarded from its Far(not in the same quadrant as the request)-oth=
er tile's L2 in E/F state. Valid only for SNC4 cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_FAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800403091",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for responses from a snoop request hit wi=
th data forwarded from its Far(not in the same quadrant as the request)-oth=
er tile's L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000403091",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for reponses from snoop request hit with =
data forwarded from its Near-other tile L2 in E/F/M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1800183091",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for responses from a snoop request hit wi=
th data forwarded from its Near-other tile's L2 in E/F state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800083091",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for responses from a snoop request hit wi=
th data forwarded from its Near-other tile's L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000083091",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for responses which hit its own tile's L2=
 with data in E state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0004003091",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for responses which hit its own tile's L2=
 with data in F state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0010003091",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for responses which hit its own tile's L2=
 with data in M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0002003091",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for responses which hit its own tile's L2=
 with data in S state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0008003091",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that are outstanding, per weighted cycle, from the time=
 of the request to when any response is received. The oustanding response s=
hould be programmed only on PMC0.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000003091",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r any response",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010070",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r reponses from snoop request hit with data forwarded from it Far(not in th=
e same quadrant as the request)-other tile L2 in E/F/M state. Valid only in=
 SNC4 Cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1800400070",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r responses from a snoop request hit with data forwarded from its Far(not i=
n the same quadrant as the request)-other tile's L2 in E/F state. Valid onl=
y for SNC4 cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_FAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800400070",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r responses from a snoop request hit with data forwarded from its Far(not i=
n the same quadrant as the request)-other tile's L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000400070",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r reponses from snoop request hit with data forwarded from its Near-other t=
ile L2 in E/F/M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1800180070",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r responses from a snoop request hit with data forwarded from its Near-othe=
r tile's L2 in E/F state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800080070",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r responses from a snoop request hit with data forwarded from its Near-othe=
r tile's L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080070",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r responses which hit its own tile's L2 with data in E state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0004000070",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r responses which hit its own tile's L2 with data in F state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0010000070",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r responses which hit its own tile's L2 with data in M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0002000070",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Prefetch requests that are outstan=
ding, per weighted cycle, from the time of the request to when any response=
 is received. The oustanding response should be programmed only on PMC0.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000000070",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for an=
y response",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00000132f7",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for re=
ponses from snoop request hit with data forwarded from it Far(not in the sa=
me quadrant as the request)-other tile L2 in E/F/M state. Valid only in SNC=
4 Cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x18004032f7",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for re=
sponses from a snoop request hit with data forwarded from its Far(not in th=
e same quadrant as the request)-other tile's L2 in E/F state. Valid only fo=
r SNC4 cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_FAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x08004032f7",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for re=
sponses from a snoop request hit with data forwarded from its Far(not in th=
e same quadrant as the request)-other tile's L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10004032f7",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for re=
ponses from snoop request hit with data forwarded from its Near-other tile =
L2 in E/F/M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x18001832f7",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for re=
sponses from a snoop request hit with data forwarded from its Near-other ti=
le's L2 in E/F state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x08000832f7",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for re=
sponses from a snoop request hit with data forwarded from its Near-other ti=
le's L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10000832f7",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for re=
sponses which hit its own tile's L2 with data in E state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00040032f7",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for re=
sponses which hit its own tile's L2 with data in F state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00100032f7",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for re=
sponses which hit its own tile's L2 with data in M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00020032f7",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for re=
sponses which hit its own tile's L2 with data in S state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00080032f7",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Read request  that are outstanding=
, per weighted cycle, from the time of the request to when any response is =
received. The oustanding response should be programmed only on PMC0.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x40000032f7",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any request that accounts for any resp=
onse",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000018000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any request that accounts for reponses=
 from snoop request hit with data forwarded from it Far(not in the same qua=
drant as the request)-other tile L2 in E/F/M state. Valid only in SNC4 Clus=
ter mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1800408000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any request that accounts for response=
s from a snoop request hit with data forwarded from its Far(not in the same=
 quadrant as the request)-other tile's L2 in E/F state. Valid only for SNC4=
 cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_FAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800408000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any request that accounts for response=
s from a snoop request hit with data forwarded from its Far(not in the same=
 quadrant as the request)-other tile's L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000408000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any request that accounts for reponses=
 from snoop request hit with data forwarded from its Near-other tile L2 in =
E/F/M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1800188000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any request that accounts for response=
s from a snoop request hit with data forwarded from its Near-other tile's L=
2 in E/F state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800088000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any request that accounts for response=
s from a snoop request hit with data forwarded from its Near-other tile's L=
2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000088000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any request that accounts for response=
s which hit its own tile's L2 with data in E state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0004008000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any request that accounts for response=
s which hit its own tile's L2 with data in F state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0010008000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any request that accounts for response=
s which hit its own tile's L2 with data in M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0002008000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any request that accounts for response=
s which hit its own tile's L2 with data in S state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0008008000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any request that are outstanding, per =
weighted cycle, from the time of the request to when any response is receiv=
ed. The oustanding response should be programmed only on PMC0.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000008000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for any response",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010022",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for reponses from snoop request hit with data forwarded from =
it Far(not in the same quadrant as the request)-other tile L2 in E/F/M stat=
e. Valid only in SNC4 Cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1800400022",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for responses from a snoop request hit with data forwarded fr=
om its Far(not in the same quadrant as the request)-other tile's L2 in E/F =
state. Valid only for SNC4 cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_FAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800400022",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for responses from a snoop request hit with data forwarded fr=
om its Far(not in the same quadrant as the request)-other tile's L2 in M st=
ate.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000400022",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for reponses from snoop request hit with data forwarded from =
its Near-other tile L2 in E/F/M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1800180022",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for responses from a snoop request hit with data forwarded fr=
om its Near-other tile's L2 in E/F state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800080022",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for responses from a snoop request hit with data forwarded fr=
om its Near-other tile's L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080022",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for responses which hit its own tile's L2 with data in E stat=
e",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0004000022",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for responses which hit its own tile's L2 with data in F stat=
e",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0010000022",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for responses which hit its own tile's L2 with data in M stat=
e",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0002000022",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for responses which hit its own tile's L2 with data in S stat=
e",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0008000022",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that are outstanding, per weighted cycle, from the time of the request to w=
hen any response is received. The oustanding response should be programmed =
only on PMC0.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000000022",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for any response",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010400",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for reponses from snoop request hit with data forwarded from it F=
ar(not in the same quadrant as the request)-other tile L2 in E/F/M state. V=
alid only in SNC4 Cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1800400400",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for responses from a snoop request hit with data forwarded from i=
ts Far(not in the same quadrant as the request)-other tile's L2 in E/F stat=
e. Valid only for SNC4 cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_FAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800400400",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for responses from a snoop request hit with data forwarded from i=
ts Far(not in the same quadrant as the request)-other tile's L2 in M state.=
",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000400400",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for reponses from snoop request hit with data forwarded from its =
Near-other tile L2 in E/F/M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1800180400",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for responses from a snoop request hit with data forwarded from i=
ts Near-other tile's L2 in E/F state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800080400",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for responses from a snoop request hit with data forwarded from i=
ts Near-other tile's L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080400",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for responses which hit its own tile's L2 with data in E state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0004000400",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for responses which hit its own tile's L2 with data in F state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0010000400",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for responses which hit its own tile's L2 with data in M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0002000400",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for responses which hit its own tile's L2 with data in S state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0008000400",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 are outstanding, per weighted cycle, from the time of the request to when =
any response is received. The oustanding response should be programmed only=
 on PMC0.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000000400",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for any response",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010004",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for reponses from snoop request hit with data forwarded f=
rom it Far(not in the same quadrant as the request)-other tile L2 in E/F/M =
state. Valid only in SNC4 Cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1800400004",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for responses from a snoop request hit with data forwarde=
d from its Far(not in the same quadrant as the request)-other tile's L2 in =
E/F state. Valid only for SNC4 cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_FAR_TILE_E_F"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800400004",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for responses from a snoop request hit with data forwarde=
d from its Far(not in the same quadrant as the request)-other tile's L2 in =
M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000400004",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for reponses from snoop request hit with data forwarded f=
rom its Near-other tile L2 in E/F/M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1800180004",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for responses from a snoop request hit with data forwarde=
d from its Near-other tile's L2 in E/F state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_NEAR_TILE_E_F=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800080004",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for responses from a snoop request hit with data forwarde=
d from its Near-other tile's L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080004",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for responses which hit its own tile's L2 with data in E =
state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0004000004",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for responses which hit its own tile's L2 with data in F =
state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0010000004",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for responses which hit its own tile's L2 with data in M =
state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0002000004",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for responses which hit its own tile's L2 with data in S =
state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0008000004",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that are outstanding, per weighted cycle, from the time of the request =
to when any response is received. The oustanding response should be program=
med only on PMC0.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000000004",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for any response",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010001",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for responses from a snoop request hit with data f=
orwarded from its Far(not in the same quadrant as the request)-other tile's=
 L2 in E/F state. Valid only for SNC4 cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_HIT_FAR_TILE_E_F"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800400001",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for responses from a snoop request hit with data f=
orwarded from its Far(not in the same quadrant as the request)-other tile's=
 L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000400001",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for responses from a snoop request hit with data f=
orwarded from its Near-other tile's L2 in E/F state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_HIT_NEAR_TILE_E_F=
",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800080001",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for responses from a snoop request hit with data f=
orwarded from its Near-other tile's L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080001",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for responses which hit its own tile's L2 with dat=
a in E state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0004000001",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for responses which hit its own tile's L2 with dat=
a in F state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0010000001",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for responses which hit its own tile's L2 with dat=
a in M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0002000001",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for responses which hit its own tile's L2 with dat=
a in S state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0008000001",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that are outstanding, per weighted cycle, from the time of the r=
equest to when any response is received. The oustanding response should be =
programmed only on PMC0.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000000001",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for any response",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010002",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for reponses from snoop request hit with data forwarded from it Far(no=
t in the same quadrant as the request)-other tile L2 in E/F/M state. Valid =
only in SNC4 Cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1800400002",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for responses from a snoop request hit with data forwarded from its Fa=
r(not in the same quadrant as the request)-other tile's L2 in E/F state. Va=
lid only for SNC4 cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_FAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800400002",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for responses from a snoop request hit with data forwarded from its Fa=
r(not in the same quadrant as the request)-other tile's L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000400002",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for reponses from snoop request hit with data forwarded from its Near-=
other tile L2 in E/F/M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1800180002",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for responses from a snoop request hit with data forwarded from its Ne=
ar-other tile's L2 in E/F state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800080002",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for responses from a snoop request hit with data forwarded from its Ne=
ar-other tile's L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080002",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for responses which hit its own tile's L2 with data in E state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0004000002",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for responses which hit its own tile's L2 with data in F state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0010000002",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for responses which hit its own tile's L2 with data in M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0002000002",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for responses which hit its own tile's L2 with data in S state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0008000002",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that are =
outstanding, per weighted cycle, from the time of the request to when any r=
esponse is received. The oustanding response should be programmed only on P=
MC0.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000000002",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Full streaming stores (WC and should b=
e programmed on PMC1) that accounts for any response",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.FULL_STREAMING_STORES.ANY_RESPONSE"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010800",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for any response",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010080",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for reponses from snoop =
request hit with data forwarded from it Far(not in the same quadrant as the=
 request)-other tile L2 in E/F/M state. Valid only in SNC4 Cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1800400080",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for responses from a sno=
op request hit with data forwarded from its Far(not in the same quadrant as=
 the request)-other tile's L2 in E/F state. Valid only for SNC4 cluster mod=
e.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_FAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800400080",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for responses from a sno=
op request hit with data forwarded from its Far(not in the same quadrant as=
 the request)-other tile's L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000400080",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for reponses from snoop =
request hit with data forwarded from its Near-other tile L2 in E/F/M state"=
,
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1800180080",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for responses from a sno=
op request hit with data forwarded from its Near-other tile's L2 in E/F sta=
te.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_NEAR_TILE_E_F"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800080080",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for responses from a sno=
op request hit with data forwarded from its Near-other tile's L2 in M state=
.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080080",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for responses which hit =
its own tile's L2 with data in E state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0004000080",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for responses which hit =
its own tile's L2 with data in F state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0010000080",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for responses which hit =
its own tile's L2 with data in M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0002000080",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for responses which hit =
its own tile's L2 with data in S state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0008000080",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that are outstanding, per weighted cyc=
le, from the time of the request to when any response is received. The oust=
anding response should be programmed only on PMC0.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000000080",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial streaming stores (WC and shoul=
d be programmed on PMC1) that accounts for any response",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_STREAMING_STORES.ANY_RESPON=
SE",
         "MSRIndex": "0x1a7",
         "MSRValue": "0x0000014000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for any response",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.ANY_RESPONSE",
         "MSRIndex": "0x1a7",
         "MSRValue": "0x0000010100",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for reponses from snoop request hi=
t with data forwarded from it Far(not in the same quadrant as the request)-=
other tile L2 in E/F/M state. Valid only in SNC4 Cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a7",
         "MSRValue": "0x1800400100",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for responses from a snoop request=
 hit with data forwarded from its Far(not in the same quadrant as the reque=
st)-other tile's L2 in E/F state. Valid only for SNC4 cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_FAR_TILE_E_F"=
,
         "MSRIndex": "0x1a7",
         "MSRValue": "0x0800400100",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for responses from a snoop request=
 hit with data forwarded from its Far(not in the same quadrant as the reque=
st)-other tile's L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a7",
         "MSRValue": "0x1000400100",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for reponses from snoop request hi=
t with data forwarded from its Near-other tile L2 in E/F/M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a7",
         "MSRValue": "0x1800180100",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for responses from a snoop request=
 hit with data forwarded from its Near-other tile's L2 in E/F state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_NEAR_TILE_E_F=
",
         "MSRIndex": "0x1a7",
         "MSRValue": "0x0800080100",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for responses from a snoop request=
 hit with data forwarded from its Near-other tile's L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a7",
         "MSRValue": "0x1000080100",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for responses which hit its own ti=
le's L2 with data in E state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a7",
         "MSRValue": "0x0004000100",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for responses which hit its own ti=
le's L2 with data in F state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a7",
         "MSRValue": "0x0010000100",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for responses which hit its own ti=
le's L2 with data in M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a7",
         "MSRValue": "0x0002000100",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for responses which hit its own ti=
le's L2 with data in S state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a7",
         "MSRValue": "0x0008000100",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r any response",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000012000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r reponses from snoop request hit with data forwarded from it Far(not in th=
e same quadrant as the request)-other tile L2 in E/F/M state. Valid only in=
 SNC4 Cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1800402000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r responses from a snoop request hit with data forwarded from its Far(not i=
n the same quadrant as the request)-other tile's L2 in E/F state. Valid onl=
y for SNC4 cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_FAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800402000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r responses from a snoop request hit with data forwarded from its Far(not i=
n the same quadrant as the request)-other tile's L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000402000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r reponses from snoop request hit with data forwarded from its Near-other t=
ile L2 in E/F/M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1800182000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r responses from a snoop request hit with data forwarded from its Near-othe=
r tile's L2 in E/F state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_NEAR_TILE_E_F"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800082000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r responses from a snoop request hit with data forwarded from its Near-othe=
r tile's L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000082000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r responses which hit its own tile's L2 with data in E state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0004002000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r responses which hit its own tile's L2 with data in F state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0010002000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r responses which hit its own tile's L2 with data in M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0002002000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r responses which hit its own tile's L2 with data in S state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0008002000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that are outstan=
ding, per weighted cycle, from the time of the request to when any response=
 is received. The oustanding response should be programmed only on PMC0.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000002000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r any response",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010040",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r reponses from snoop request hit with data forwarded from it Far(not in th=
e same quadrant as the request)-other tile L2 in E/F/M state. Valid only in=
 SNC4 Cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1800400040",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r responses from a snoop request hit with data forwarded from its Far(not i=
n the same quadrant as the request)-other tile's L2 in E/F state. Valid onl=
y for SNC4 cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_FAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800400040",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r responses from a snoop request hit with data forwarded from its Far(not i=
n the same quadrant as the request)-other tile's L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000400040",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r reponses from snoop request hit with data forwarded from its Near-other t=
ile L2 in E/F/M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1800180040",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r responses from a snoop request hit with data forwarded from its Near-othe=
r tile's L2 in E/F state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_NEAR_TILE_E_F"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800080040",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r responses from a snoop request hit with data forwarded from its Near-othe=
r tile's L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080040",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r responses which hit its own tile's L2 with data in E state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0004000040",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r responses which hit its own tile's L2 with data in F state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0010000040",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that are outstan=
ding, per weighted cycle, from the time of the request to when any response=
 is received. The oustanding response should be programmed only on PMC0.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000000040",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for any response",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010020",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for responses from a snoop request hit with=
 data forwarded from its Far(not in the same quadrant as the request)-other=
 tile's L2 in E/F state. Valid only for SNC4 cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_FAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800400020",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for responses from a snoop request hit with=
 data forwarded from its Far(not in the same quadrant as the request)-other=
 tile's L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000400020",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for reponses from snoop request hit with da=
ta forwarded from its Near-other tile L2 in E/F/M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1800180020",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for responses from a snoop request hit with=
 data forwarded from its Near-other tile's L2 in E/F state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800080020",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for responses from a snoop request hit with=
 data forwarded from its Near-other tile's L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080020",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for responses which hit its own tile's L2 w=
ith data in E state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0004000020",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for responses which hit its own tile's L2 w=
ith data in F state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0010000020",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for responses which hit its own tile's L2 w=
ith data in M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0002000020",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for responses which hit its own tile's L2 w=
ith data in S state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0008000020",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that provides no supplier details",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.SUPPLIER_NONE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000020020",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
any response",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000011000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
reponses from snoop request hit with data forwarded from it Far(not in the =
same quadrant as the request)-other tile L2 in E/F/M state. Valid only in S=
NC4 Cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1800401000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
responses from a snoop request hit with data forwarded from its Far(not in =
the same quadrant as the request)-other tile's L2 in E/F state. Valid only =
for SNC4 cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_FAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800401000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
responses from a snoop request hit with data forwarded from its Far(not in =
the same quadrant as the request)-other tile's L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000401000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
reponses from snoop request hit with data forwarded from its Near-other til=
e L2 in E/F/M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1800181000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
responses from a snoop request hit with data forwarded from its Near-other =
tile's L2 in E/F state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800081000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
responses from a snoop request hit with data forwarded from its Near-other =
tile's L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000081000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
responses which hit its own tile's L2 with data in E state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0004001000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
responses which hit its own tile's L2 with data in F state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0010001000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
responses which hit its own tile's L2 with data in M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0002001000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
responses which hit its own tile's L2 with data in S state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0008001000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Software Prefetches that are outstandi=
ng, per weighted cycle, from the time of the request to when any response i=
s received. The oustanding response should be programmed only on PMC0.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000001000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all streaming stores (WC and should be=
 programmed on PMC1) that accounts for any response",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.STREAMING_STORES.ANY_RESPONSE",
         "MSRIndex": "0x1a7",
         "MSRValue": "0x0000014800",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for any response",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0000010200",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for responses from a snoop request hit wi=
th data forwarded from its Far(not in the same quadrant as the request)-oth=
er tile's L2 in E/F state. Valid only for SNC4 cluster mode.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_FAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800400200",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for responses from a snoop request hit wi=
th data forwarded from its Far(not in the same quadrant as the request)-oth=
er tile's L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000400200",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for reponses from snoop request hit with =
data forwarded from its Near-other tile L2 in E/F/M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1800180200",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for responses from a snoop request hit wi=
th data forwarded from its Near-other tile's L2 in E/F state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_NEAR_TILE_E_F"=
,
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0800080200",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for responses from a snoop request hit wi=
th data forwarded from its Near-other tile's L2 in M state.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080200",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for responses which hit its own tile's L2=
 with data in E state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0004000200",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for responses which hit its own tile's L2=
 with data in F state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0010000200",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for responses which hit its own tile's L2=
 with data in M state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0002000200",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for responses which hit its own tile's L2=
 with data in S state",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0008000200",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that are outstanding, per weighted cycle, from the time=
 of the request to when any response is received. The oustanding response s=
hould be programmed only on PMC0.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "MSRValue": "0x4000000200",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     }
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/floating-point.j=
son b/tools/perf/pmu-events/arch/x86/knightslanding/floating-point.json
index ff5db600e420..ecc96f32f167 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/floating-point.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "Counts the number of floating operations reti=
red that required microcode assists",
-        "Counter": "0,1",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.FP_ASSIST",
         "PublicDescription": "This event counts the number of times that t=
he pipeline stalled due to FP operations needing assists.",
@@ -10,7 +9,6 @@
     },
     {
         "BriefDescription": "Counts the number of vector SSE, AVX, AVX2, A=
VX-512 micro-ops retired. More specifically, it counts packed SSE, AVX, AVX=
2, AVX-512 micro-ops (both floating point and integer) except for loads (me=
mory-to-register mov-type micro-ops), packed byte and word multiplies.",
-        "Counter": "0,1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.PACKED_SIMD",
         "PublicDescription": "This event counts the number of packed vecto=
r SSE, AVX, AVX2, and AVX-512 micro-ops retired (floating point, integer an=
d store) except for loads (memory-to-register mov-type micro-ops), packed b=
yte and word multiplies.",
@@ -19,7 +17,6 @@
     },
     {
         "BriefDescription": "Counts the number of scalar SSE, AVX, AVX2, A=
VX-512 micro-ops retired. More specifically, it counts scalar SSE, AVX, AVX=
2, AVX-512 micro-ops except for loads (memory-to-register mov-type micro op=
s), division, sqrt.",
-        "Counter": "0,1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.SCALAR_SIMD",
         "PublicDescription": "This event counts the number of scalar SSE, =
AVX, AVX2, AVX-512 micro-ops retired (floating point, integer and store) ex=
cept for loads (memory-to-register mov-type micro ops), division, sqrt.",
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/frontend.json b/=
tools/perf/pmu-events/arch/x86/knightslanding/frontend.json
index 63343a0d1e86..9001f5019848 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/frontend.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "Counts the number of times the front end rest=
eers for any branch as a result of another branch handling mechanism in the=
 front end.",
-        "Counter": "0,1",
         "EventCode": "0xE6",
         "EventName": "BACLEARS.ALL",
         "SampleAfterValue": "200003",
@@ -9,7 +8,6 @@
     },
     {
         "BriefDescription": "Counts the number of times the front end rest=
eers for conditional branches as a result of another branch handling mechan=
ism in the front end.",
-        "Counter": "0,1",
         "EventCode": "0xE6",
         "EventName": "BACLEARS.COND",
         "SampleAfterValue": "200003",
@@ -17,7 +15,6 @@
     },
     {
         "BriefDescription": "Counts the number of times the front end rest=
eers for RET branches as a result of another branch handling mechanism in t=
he front end.",
-        "Counter": "0,1",
         "EventCode": "0xE6",
         "EventName": "BACLEARS.RETURN",
         "SampleAfterValue": "200003",
@@ -25,7 +22,6 @@
     },
     {
         "BriefDescription": "Counts all instruction fetches, including unc=
acheable fetches.",
-        "Counter": "0,1",
         "EventCode": "0x80",
         "EventName": "ICACHE.ACCESSES",
         "SampleAfterValue": "200003",
@@ -33,7 +29,6 @@
     },
     {
         "BriefDescription": "Counts all instruction fetches that hit the i=
nstruction cache.",
-        "Counter": "0,1",
         "EventCode": "0x80",
         "EventName": "ICACHE.HIT",
         "SampleAfterValue": "200003",
@@ -41,7 +36,6 @@
     },
     {
         "BriefDescription": "Counts all instruction fetches that miss the =
instruction cache or produce memory requests. An instruction fetch miss is =
counted only once and not once for every cycle it is outstanding.",
-        "Counter": "0,1",
         "EventCode": "0x80",
         "EventName": "ICACHE.MISSES",
         "SampleAfterValue": "200003",
@@ -49,7 +43,6 @@
     },
     {
         "BriefDescription": "Counts the number of times the MSROM starts a=
 flow of uops.",
-        "Counter": "0,1",
         "EventCode": "0xE7",
         "EventName": "MS_DECODED.MS_ENTRY",
         "SampleAfterValue": "200003",
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/memory.json b/to=
ols/perf/pmu-events/arch/x86/knightslanding/memory.json
index 2611defaeaa2..b0361f6f0dd9 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/memory.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/memory.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "Counts the number of times the machine clears=
 due to memory ordering hazards",
-        "Counter": "0,1",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
         "SampleAfterValue": "200003",
@@ -9,1101 +8,901 @@
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for responses from DDR (local and far)",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.DDR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0181800044",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for data responses from DRAM Far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0101000044",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for data responses from DRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080800044",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for responses from MCDRAM (local and far)",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.MCDRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0180600044",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for data responses from MCDRAM Far or Other tile=
 L2 hit far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100400044",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for data responses from MCDRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080200044",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for responses from DDR (local and far)",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.DDR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0181803091",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for data responses from DRAM Far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0101003091",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for data responses from DRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080803091",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for responses from MCDRAM (local and far)=
",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.MCDRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0180603091",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for data responses from MCDRAM Far or Oth=
er tile L2 hit far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100403091",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for data responses from MCDRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080203091",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r data responses from DRAM Far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0101000070",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r data responses from DRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080800070",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r responses from MCDRAM (local and far)",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.MCDRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0180600070",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r data responses from MCDRAM Far or Other tile L2 hit far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100400070",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Prefetch requests that accounts fo=
r data responses from MCDRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080200070",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for re=
sponses from DDR (local and far)",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.DDR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x01818032f7",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for da=
ta responses from DRAM Far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x01010032f7",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for da=
ta responses from DRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00808032f7",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for re=
sponses from MCDRAM (local and far)",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.MCDRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x01806032f7",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for da=
ta responses from MCDRAM Far or Other tile L2 hit far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x01004032f7",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any Read request  that accounts for da=
ta responses from MCDRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x00802032f7",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any request that accounts for response=
s from DDR (local and far)",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.DDR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0181808000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any request that accounts for data res=
ponses from DRAM Far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0101008000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any request that accounts for data res=
ponses from DRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080808000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any request that accounts for response=
s from MCDRAM (local and far)",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.MCDRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0180608000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any request that accounts for data res=
ponses from MCDRAM Far or Other tile L2 hit far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100408000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts any request that accounts for data res=
ponses from MCDRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080208000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for responses from DDR (local and far)",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.DDR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0181800022",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for data responses from DRAM Far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0101000022",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for data responses from DRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080800022",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for responses from MCDRAM (local and far)",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.MCDRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0180600022",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for data responses from MCDRAM Far or Other tile L2 hit far."=
,
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100400022",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for data responses from MCDRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080200022",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for responses from DDR (local and far)",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.DDR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0181800400",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for data responses from DRAM Far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0101000400",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for data responses from DRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080800400",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for responses from MCDRAM (local and far)",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.MCDRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0180600400",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for data responses from MCDRAM Far or Other tile L2 hit far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100400400",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for data responses from MCDRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080200400",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for responses from DDR (local and far)",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.DDR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0181800004",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for data responses from DRAM Far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0101000004",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for data responses from DRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080800004",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for responses from MCDRAM (local and far)",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.MCDRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0180600004",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for data responses from MCDRAM Far or Other tile L2 hit f=
ar.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100400004",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for data responses from MCDRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080200004",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for responses from DDR (local and far)",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.DDR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0181800001",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for data responses from DRAM Far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0101000001",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for data responses from DRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080800001",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for responses from MCDRAM (local and far)",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.MCDRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0180600001",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for data responses from MCDRAM Far or Other tile L=
2 hit far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100400001",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that accounts for data responses from MCDRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080200001",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for responses from DDR (local and far)",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.DDR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0181800002",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for data responses from DRAM Far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0101000002",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for data responses from DRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080800002",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for responses from MCDRAM (local and far)",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.MCDRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0180600002",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for data responses from MCDRAM Far or Other tile L2 hit far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100400002",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for data responses from MCDRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080200002",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for responses from DDR (=
local and far)",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.DDR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0181800080",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for data responses from =
DRAM Far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0101000080",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for data responses from =
DRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080800080",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for responses from MCDRA=
M (local and far)",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.MCDRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0180600080",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for data responses from =
MCDRAM Far or Other tile L2 hit far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100400080",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for data responses from =
MCDRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080200080",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for responses from any N=
ON_DRAM system address. This includes MMIO transactions",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000020080",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for data responses from DRAM Far."=
,
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.DDR_FAR",
         "MSRIndex": "0x1a7",
         "MSRValue": "0x0101000100",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for data responses from DRAM Local=
.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.DDR_NEAR",
         "MSRIndex": "0x1a7",
         "MSRValue": "0x0080800100",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for responses from MCDRAM (local a=
nd far)",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.MCDRAM",
         "MSRIndex": "0x1a7",
         "MSRValue": "0x0180600100",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for data responses from MCDRAM Far=
 or Other tile L2 hit far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.MCDRAM_FAR",
         "MSRIndex": "0x1a7",
         "MSRValue": "0x0100400100",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for data responses from MCDRAM Loc=
al.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.MCDRAM_NEAR",
         "MSRIndex": "0x1a7",
         "MSRValue": "0x0080200100",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r responses from DDR (local and far)",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.DDR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0181802000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r data responses from DRAM Far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0101002000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r data responses from DRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080802000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r data responses from MCDRAM Far or Other tile L2 hit far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100402000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r data responses from MCDRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080202000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r responses from DDR (local and far)",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.DDR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0181800040",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r data responses from DRAM Far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0101000040",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r data responses from DRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080800040",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r data responses from MCDRAM Far or Other tile L2 hit far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100400040",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r data responses from MCDRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080200040",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for responses from DDR (local and far)",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.DDR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0181800020",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for data responses from DRAM Far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0101000020",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for data responses from DRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080800020",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for responses from MCDRAM (local and far)",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.MCDRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0180600020",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for data responses from MCDRAM Far or Other=
 tile L2 hit far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100400020",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for data responses from MCDRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080200020",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for responses from any NON_DRAM system addr=
ess. This includes MMIO transactions",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.NON_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000020020",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
responses from DDR (local and far)",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.DDR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0181801000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
data responses from DRAM Far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0101001000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
data responses from DRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080801000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
responses from MCDRAM (local and far)",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.MCDRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0180601000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
data responses from MCDRAM Far or Other tile L2 hit far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100401000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Software Prefetches that accounts for =
data responses from MCDRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080201000",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for responses from DDR (local and far)",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.DDR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0181800200",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for data responses from DRAM Far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0101000200",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for data responses from DRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.DDR_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080800200",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for responses from MCDRAM (local and far)=
",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.MCDRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0180600200",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for data responses from MCDRAM Far or Oth=
er tile L2 hit far.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0100400200",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for data responses from MCDRAM Local.",
-        "Counter": "0,1",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.MCDRAM_NEAR",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x0080200200",
-        "Offcore": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     }
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json b/=
tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
index 1f13bc2686cb..1b803fa38641 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "Counts the number of branch instructions reti=
red",
-        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
@@ -9,7 +8,6 @@
     },
     {
         "BriefDescription": "Counts the number of near CALL branch instruc=
tions retired.",
-        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.CALL",
         "PEBS": "1",
@@ -18,7 +16,6 @@
     },
     {
         "BriefDescription": "Counts the number of far branch instructions =
retired.",
-        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
         "PEBS": "1",
@@ -27,7 +24,6 @@
     },
     {
         "BriefDescription": "Counts the number of near indirect CALL branc=
h instructions retired.",
-        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.IND_CALL",
         "PEBS": "1",
@@ -36,7 +32,6 @@
     },
     {
         "BriefDescription": "Counts the number of branch instructions reti=
red that were conditional jumps.",
-        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.JCC",
         "PEBS": "1",
@@ -45,7 +40,6 @@
     },
     {
         "BriefDescription": "Counts the number of branch instructions reti=
red that were near indirect CALL or near indirect JMP.",
-        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NON_RETURN_IND",
         "PEBS": "1",
@@ -54,7 +48,6 @@
     },
     {
         "BriefDescription": "Counts the number of near relative CALL branc=
h instructions retired.",
-        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.REL_CALL",
         "PEBS": "1",
@@ -63,7 +56,6 @@
     },
     {
         "BriefDescription": "Counts the number of near RET branch instruct=
ions retired.",
-        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.RETURN",
         "PEBS": "1",
@@ -72,7 +64,6 @@
     },
     {
         "BriefDescription": "Counts the number of branch instructions reti=
red that were conditional jumps and predicted taken.",
-        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.TAKEN_JCC",
         "PEBS": "1",
@@ -81,7 +72,6 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted branch inst=
ructions retired",
-        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
@@ -89,7 +79,6 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted near CALL b=
ranch instructions retired.",
-        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.CALL",
         "PEBS": "1",
@@ -98,7 +87,6 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted far branch =
instructions retired.",
-        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.FAR_BRANCH",
         "PEBS": "1",
@@ -107,7 +95,6 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted near indire=
ct CALL branch instructions retired.",
-        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.IND_CALL",
         "PEBS": "1",
@@ -116,7 +103,6 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted branch inst=
ructions retired that were conditional jumps.",
-        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.JCC",
         "PEBS": "1",
@@ -125,7 +111,6 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted branch inst=
ructions retired that were near indirect CALL or near indirect JMP.",
-        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.NON_RETURN_IND",
         "PEBS": "1",
@@ -134,7 +119,6 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted near relati=
ve CALL branch instructions retired.",
-        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.REL_CALL",
         "PEBS": "1",
@@ -143,7 +127,6 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted near RET br=
anch instructions retired.",
-        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.RETURN",
         "PEBS": "1",
@@ -152,7 +135,6 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted branch inst=
ructions retired that were conditional jumps and predicted taken.",
-        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.TAKEN_JCC",
         "PEBS": "1",
@@ -161,7 +143,6 @@
     },
     {
         "BriefDescription": "Counts the number of unhalted reference clock=
 cycles",
-        "Counter": "0,1",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.REF",
         "SampleAfterValue": "2000003",
@@ -169,14 +150,12 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted =
reference clock cycles",
-        "Counter": "Fixed counter 3",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "SampleAfterValue": "2000003",
         "UMask": "0x3"
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles",
-        "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "This event counts the number of core cycles =
while the thread is not in a halt state. The thread enters the halt state w=
hen it is running the HLT instruction. This event is a component in many ke=
y event ratios. The core frequency may change from time to time due to tran=
sitions associated with Enhanced Intel SpeedStep Technology or TM2. For thi=
s reason this event may have a changing ratio with regards to time. When th=
e core frequency is constant, this event can approximate elapsed time while=
 the core was not in the halt state. It is counted on a dedicated fixed cou=
nter",
         "SampleAfterValue": "2000003",
@@ -184,14 +163,12 @@
     },
     {
         "BriefDescription": "Counts the number of unhalted core clock cycl=
es",
-        "Counter": "0,1",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
         "SampleAfterValue": "2000003"
     },
     {
         "BriefDescription": "Cycles the number of core cycles when divider=
 is busy.  Does not imply a stall waiting for the divider.",
-        "Counter": "0,1",
         "EventCode": "0xCD",
         "EventName": "CYCLES_DIV_BUSY.ALL",
         "PublicDescription": "This event counts cycles when the divider is=
 busy. More specifically cycles when the divide unit is unable to accept a =
new divide uop because it is busy processing a previously dispatched uop. T=
he cycles will be counted irrespective of whether or not another divide uop=
 is waiting to enter the divide unit (from the RS). This event counts integ=
er divides, x87 divides, divss, divsd, sqrtss, sqrtsd event and does not co=
unt vector divides.",
@@ -200,7 +177,6 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of instructi=
ons retired",
-        "Counter": "Fixed counter 1",
         "EventName": "INST_RETIRED.ANY",
         "PublicDescription": "This event counts the number of instructions=
 that retire.  For instructions that consist of multiple micro-ops, this ev=
ent counts exactly once, as the last micro-op of the instruction retires.  =
The event continues counting while instructions retire, including during in=
terrupt service routines caused by hardware interrupts, faults or traps.",
         "SampleAfterValue": "2000003",
@@ -208,14 +184,12 @@
     },
     {
         "BriefDescription": "Counts the total number of instructions retir=
ed",
-        "Counter": "0,1",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.ANY_P",
         "SampleAfterValue": "2000003"
     },
     {
         "BriefDescription": "Counts all nukes",
-        "Counter": "0,1",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.ALL",
         "SampleAfterValue": "200003",
@@ -223,7 +197,6 @@
     },
     {
         "BriefDescription": "Counts the number of times that the machine c=
lears due to program modifying data within 1K of a recently fetched code pa=
ge",
-        "Counter": "0,1",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.SMC",
         "SampleAfterValue": "200003",
@@ -231,7 +204,6 @@
     },
     {
         "BriefDescription": "Counts the total number of core cycles when n=
o micro-ops are allocated for any reason.",
-        "Counter": "0,1",
         "EventCode": "0xCA",
         "EventName": "NO_ALLOC_CYCLES.ALL",
         "SampleAfterValue": "200003",
@@ -239,7 +211,6 @@
     },
     {
         "BriefDescription": "Counts the number of core cycles when no micr=
o-ops are allocated and the alloc pipe is stalled waiting for a mispredicte=
d branch to retire.",
-        "Counter": "0,1",
         "EventCode": "0xCA",
         "EventName": "NO_ALLOC_CYCLES.MISPREDICTS",
         "PublicDescription": "This event counts the number of core cycles =
when no uops are allocated and the alloc pipe is stalled waiting for a misp=
redicted branch to retire.",
@@ -248,7 +219,6 @@
     },
     {
         "BriefDescription": "Counts the number of core cycles when no micr=
o-ops are allocated, the IQ is empty, and no other condition is blocking al=
location.",
-        "Counter": "0,1",
         "EventCode": "0xCA",
         "EventName": "NO_ALLOC_CYCLES.NOT_DELIVERED",
         "PublicDescription": "This event counts the number of core cycles =
when no uops are allocated, the instruction queue is empty and the alloc pi=
pe is stalled waiting for instructions to be fetched.",
@@ -257,7 +227,6 @@
     },
     {
         "BriefDescription": "Counts the number of core cycles when no micr=
o-ops are allocated and a RATstall (caused by reservation station full) is =
asserted.",
-        "Counter": "0,1",
         "EventCode": "0xCA",
         "EventName": "NO_ALLOC_CYCLES.RAT_STALL",
         "SampleAfterValue": "200003",
@@ -265,7 +234,6 @@
     },
     {
         "BriefDescription": "Counts the number of core cycles when no micr=
o-ops are allocated and the ROB is full",
-        "Counter": "0,1",
         "EventCode": "0xCA",
         "EventName": "NO_ALLOC_CYCLES.ROB_FULL",
         "SampleAfterValue": "200003",
@@ -273,7 +241,6 @@
     },
     {
         "BriefDescription": "Counts any retired load that was pushed into =
the recycle queue for any reason.",
-        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "RECYCLEQ.ANY_LD",
         "SampleAfterValue": "200003",
@@ -281,7 +248,6 @@
     },
     {
         "BriefDescription": "Counts any retired store that was pushed into=
 the recycle queue for any reason.",
-        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "RECYCLEQ.ANY_ST",
         "SampleAfterValue": "200003",
@@ -289,7 +255,6 @@
     },
     {
         "BriefDescription": "Counts the number of occurences a retired loa=
d gets blocked because its address overlaps with a store whose data is not =
ready",
-        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "RECYCLEQ.LD_BLOCK_STD_NOTREADY",
         "SampleAfterValue": "200003",
@@ -297,7 +262,6 @@
     },
     {
         "BriefDescription": "Counts the number of occurences a retired loa=
d gets blocked because its address partially overlaps with a store",
-        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0x03",
         "EventName": "RECYCLEQ.LD_BLOCK_ST_FORWARD",
@@ -307,7 +271,6 @@
     },
     {
         "BriefDescription": "Counts the number of occurences a retired loa=
d that is a cache line split. Each split should be counted only once.",
-        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0x03",
         "EventName": "RECYCLEQ.LD_SPLITS",
@@ -317,7 +280,6 @@
     },
     {
         "BriefDescription": "Counts all the retired locked loads. It does =
not include stores because we would double count if we count stores",
-        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "RECYCLEQ.LOCK",
         "SampleAfterValue": "200003",
@@ -325,7 +287,6 @@
     },
     {
         "BriefDescription": "Counts the store micro-ops retired that were =
pushed in the rehad queue because the store address buffer is full",
-        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "RECYCLEQ.STA_FULL",
         "SampleAfterValue": "200003",
@@ -333,7 +294,6 @@
     },
     {
         "BriefDescription": "Counts the number of occurences a retired sto=
re that is a cache line split. Each split should be counted only once.",
-        "Counter": "0,1",
         "EventCode": "0x03",
         "EventName": "RECYCLEQ.ST_SPLITS",
         "PublicDescription": "This event counts the number of retired stor=
e that experienced a cache line boundary split(Precise Event). Note that ea=
ch spilt should be counted only once.",
@@ -342,7 +302,6 @@
     },
     {
         "BriefDescription": "Counts the total number of core cycles the Al=
loc pipeline is stalled when any one of the reservation stations is full.",
-        "Counter": "0,1",
         "EventCode": "0xCB",
         "EventName": "RS_FULL_STALL.ALL",
         "SampleAfterValue": "200003",
@@ -350,7 +309,6 @@
     },
     {
         "BriefDescription": "Counts the number of core cycles when allocat=
ion pipeline is stalled and is waiting for a free MEC reservation station e=
ntry.",
-        "Counter": "0,1",
         "EventCode": "0xCB",
         "EventName": "RS_FULL_STALL.MEC",
         "SampleAfterValue": "200003",
@@ -358,7 +316,6 @@
     },
     {
         "BriefDescription": "Counts the number of micro-ops retired",
-        "Counter": "0,1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.ALL",
         "PublicDescription": "This event counts the number of micro-ops (u=
ops) retired. The processor decodes complex macro instructions into a seque=
nce of simpler uops. Most instructions are composed of one or two uops. Som=
e instructions are decoded into longer sequences such as repeat instruction=
s, floating point transcendental instructions, and assists.",
@@ -367,7 +324,6 @@
     },
     {
         "BriefDescription": "Counts the number of micro-ops retired that a=
re from the complex flows issued by the micro-sequencer (MS).",
-        "Counter": "0,1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.MS",
         "PublicDescription": "This event counts the number of micro-ops re=
tired that were supplied from MSROM.",
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.jso=
n b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.json
index a5e1a9a47e73..a31dca71e868 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.json
@@ -1,7 +1,6 @@
 [
     {
-        "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -IP=
Q",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -IP=
Q",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.IPQ_HIT",
         "PerPkg": "1",
@@ -9,8 +8,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -IP=
Q",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -IP=
Q",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.IPQ_MISS",
         "PerPkg": "1",
@@ -18,8 +16,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -IR=
Q",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -IR=
Q",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.IRQ_HIT",
         "PerPkg": "1",
@@ -27,8 +24,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -IR=
Q ",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -IR=
Q",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.IRQ_MISS",
         "PerPkg": "1",
@@ -36,8 +32,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -IR=
Q or PRQ",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -IR=
Q or PRQ",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.LOC_ALL",
         "PerPkg": "1",
@@ -45,8 +40,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -PR=
Q",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -PR=
Q",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.PRQ_HIT",
         "PerPkg": "1",
@@ -54,8 +48,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -PR=
Q",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -PR=
Q",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.PRQ_MISS",
         "PerPkg": "1",
@@ -64,43 +57,38 @@
     },
     {
         "BriefDescription": "Counts the number of read requests and stream=
ing stores that hit in MCDRAM cache and the data in MCDRAM is clean with re=
spect to DDR. This event is only valid in cache and hybrid memory mode.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_E_EDC_ACCESS.HIT_CLEAN",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "EDC_UCLK"
     },
     {
-        "BriefDescription": "Counts the number of read requests and stream=
ing stores that hit in MCDRAM cache and the data in MCDRAM is dirty with re=
spect to DDR. This event is only valid in cache and hybrid memory mode. ",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Counts the number of read requests and stream=
ing stores that hit in MCDRAM cache and the data in MCDRAM is dirty with re=
spect to DDR. This event is only valid in cache and hybrid memory mode.",
         "EventCode": "0x02",
         "EventName": "UNC_E_EDC_ACCESS.HIT_DIRTY",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "EDC_UCLK"
     },
     {
         "BriefDescription": "Counts the number of read requests and stream=
ing stores that miss in MCDRAM cache and the data evicted from the MCDRAM i=
s clean with respect to DDR. This event is only valid in cache and hybrid m=
emory mode.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_E_EDC_ACCESS.MISS_CLEAN",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "EDC_UCLK"
     },
     {
         "BriefDescription": "Counts the number of read requests and stream=
ing stores that miss in MCDRAM cache and the data evicted from the MCDRAM i=
s dirty with respect to DDR. This event is only valid in cache and hybrid m=
emory mode.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_E_EDC_ACCESS.MISS_DIRTY",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "EDC_UCLK"
     },
     {
         "BriefDescription": "Number of EDC Hits or Misses. Miss I",
-        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_E_EDC_ACCESS.MISS_INVALID",
         "PerPkg": "1",
@@ -109,75 +97,66 @@
     },
     {
         "BriefDescription": "ECLK count",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_E_E_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "EDC_ECLK"
     },
     {
-        "BriefDescription": "Counts the number of read requests received b=
y the MCDRAM controller. This event is valid in all three memory modes: fla=
t, cache and hybrid. In cache and hybrid memory mode, this event counts all=
 read requests as well as streaming stores that hit or miss in the MCDRAM c=
ache. ",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Counts the number of read requests received b=
y the MCDRAM controller. This event is valid in all three memory modes: fla=
t, cache and hybrid. In cache and hybrid memory mode, this event counts all=
 read requests as well as streaming stores that hit or miss in the MCDRAM c=
ache.",
         "EventCode": "0x01",
         "EventName": "UNC_E_RPQ_INSERTS",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "EDC_ECLK"
     },
     {
         "BriefDescription": "UCLK count",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_E_U_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "EDC_UCLK"
     },
     {
         "BriefDescription": "Counts the number of write requests received =
by the MCDRAM controller. This event is valid in all three memory modes: fl=
at, cache and hybrid. In cache and hybrid memory mode, this event counts al=
l streaming stores, writebacks and, read requests that miss in MCDRAM cache=
.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_E_WPQ_INSERTS",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "EDC_ECLK"
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED.TGR0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED.TGR1",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED.TGR2",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED.TGR3",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED.TGR4",
         "PerPkg": "1",
@@ -186,7 +165,6 @@
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED.TGR5",
         "PerPkg": "1",
@@ -195,7 +173,6 @@
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED.TGR6",
         "PerPkg": "1",
@@ -204,7 +181,6 @@
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED.TGR7",
         "PerPkg": "1",
@@ -213,61 +189,54 @@
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 0-7",
-        "Counter": "0,1,2,3",
         "EventCode": "0x81",
         "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED_EXT.ANY_OF_TGR0_THRU_TGR7"=
,
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 8",
-        "Counter": "0,1,2,3",
         "EventCode": "0x81",
         "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED_EXT.TGR8",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x82",
         "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY.TGR0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x82",
         "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY.TGR1",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x82",
         "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY.TGR2",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x82",
         "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY.TGR3",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0x82",
         "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY.TGR4",
         "PerPkg": "1",
@@ -276,7 +245,6 @@
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0x82",
         "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY.TGR5",
         "PerPkg": "1",
@@ -285,7 +253,6 @@
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0x82",
         "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY.TGR6",
         "PerPkg": "1",
@@ -294,7 +261,6 @@
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0x82",
         "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY.TGR7",
         "PerPkg": "1",
@@ -303,61 +269,54 @@
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 0-7",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY_EXT.ANY_OF_TGR0_THRU_TGR7=
",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 8",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY_EXT.TGR8",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED.TGR0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED.TGR1",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED.TGR2",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED.TGR3",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED.TGR4",
         "PerPkg": "1",
@@ -366,7 +325,6 @@
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED.TGR5",
         "PerPkg": "1",
@@ -375,7 +333,6 @@
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED.TGR6",
         "PerPkg": "1",
@@ -384,7 +341,6 @@
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0x88",
         "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED.TGR7",
         "PerPkg": "1",
@@ -393,61 +349,54 @@
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 0-7",
-        "Counter": "0,1,2,3",
         "EventCode": "0x89",
         "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED_EXT.ANY_OF_TGR0_THRU_TGR7"=
,
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 8",
-        "Counter": "0,1,2,3",
         "EventCode": "0x89",
         "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED_EXT.TGR8",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8A",
         "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY.TGR0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8A",
         "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY.TGR1",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8A",
         "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY.TGR2",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8A",
         "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY.TGR3",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8A",
         "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY.TGR4",
         "PerPkg": "1",
@@ -456,7 +405,6 @@
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8A",
         "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY.TGR5",
         "PerPkg": "1",
@@ -465,7 +413,6 @@
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8A",
         "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY.TGR6",
         "PerPkg": "1",
@@ -474,7 +421,6 @@
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8A",
         "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY.TGR7",
         "PerPkg": "1",
@@ -483,61 +429,54 @@
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 0-7",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8B",
         "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY_EXT.ANY_OF_TGR0_THRU_TGR7=
",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 8",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8B",
         "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY_EXT.TGR8",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD.TGR0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD.TGR1",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD.TGR2",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD.TGR3",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD.TGR4",
         "PerPkg": "1",
@@ -546,7 +485,6 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD.TGR5",
         "PerPkg": "1",
@@ -555,7 +493,6 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD.TGR6",
         "PerPkg": "1",
@@ -564,7 +501,6 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD0",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD.TGR7",
         "PerPkg": "1",
@@ -573,61 +509,54 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 0-7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD1",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD_EXT.ANY_OF_TGR=
0_THRU_TGR7",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 8",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD1",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD_EXT.TGR8",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD4",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL.TGR0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD4",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL.TGR1",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD4",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL.TGR2",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD4",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL.TGR3",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD4",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL.TGR4",
         "PerPkg": "1",
@@ -636,7 +565,6 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD4",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL.TGR5",
         "PerPkg": "1",
@@ -645,7 +573,6 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD4",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL.TGR6",
         "PerPkg": "1",
@@ -654,7 +581,6 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD4",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL.TGR7",
         "PerPkg": "1",
@@ -663,61 +589,54 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 0-7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD5",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL_EXT.ANY_OF_TGR=
0_THRU_TGR7",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 8",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD5",
         "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL_EXT.TGR8",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED.TGR0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED.TGR1",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED.TGR2",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED.TGR3",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED.TGR4",
         "PerPkg": "1",
@@ -726,7 +645,6 @@
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED.TGR5",
         "PerPkg": "1",
@@ -735,7 +653,6 @@
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED.TGR6",
         "PerPkg": "1",
@@ -744,7 +661,6 @@
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED.TGR7",
         "PerPkg": "1",
@@ -753,61 +669,54 @@
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 0-7",
-        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED_EXT.ANY_OF_TGR0_THRU_TGR7"=
,
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 8",
-        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED_EXT.TGR8",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY.TGR0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY.TGR1",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY.TGR2",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY.TGR3",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY.TGR4",
         "PerPkg": "1",
@@ -816,7 +725,6 @@
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY.TGR5",
         "PerPkg": "1",
@@ -825,7 +733,6 @@
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY.TGR6",
         "PerPkg": "1",
@@ -834,7 +741,6 @@
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY.TGR7",
         "PerPkg": "1",
@@ -843,61 +749,54 @@
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 0-7",
-        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY_EXT.ANY_OF_TGR0_THRU_TGR7=
",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 8",
-        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY_EXT.TGR8",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8C",
         "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED.TGR0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8C",
         "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED.TGR1",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8C",
         "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED.TGR2",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8C",
         "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED.TGR3",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8C",
         "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED.TGR4",
         "PerPkg": "1",
@@ -906,7 +805,6 @@
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8C",
         "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED.TGR5",
         "PerPkg": "1",
@@ -915,7 +813,6 @@
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8C",
         "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED.TGR6",
         "PerPkg": "1",
@@ -924,7 +821,6 @@
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8C",
         "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED.TGR7",
         "PerPkg": "1",
@@ -933,61 +829,54 @@
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 0-7",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8D",
         "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED_EXT.ANY_OF_TGR0_THRU_TGR7"=
,
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 8",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8D",
         "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED_EXT.TGR8",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8E",
         "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY.TGR0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8E",
         "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY.TGR1",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8E",
         "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY.TGR2",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8E",
         "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY.TGR3",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8E",
         "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY.TGR4",
         "PerPkg": "1",
@@ -996,7 +885,6 @@
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8E",
         "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY.TGR5",
         "PerPkg": "1",
@@ -1005,7 +893,6 @@
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8E",
         "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY.TGR6",
         "PerPkg": "1",
@@ -1014,7 +901,6 @@
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8E",
         "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY.TGR7",
         "PerPkg": "1",
@@ -1023,61 +909,54 @@
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 0-7",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8F",
         "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY_EXT.ANY_OF_TGR0_THRU_TGR7=
",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 8",
-        "Counter": "0,1,2,3",
         "EventCode": "0x8F",
         "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY_EXT.TGR8",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD.TGR0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD.TGR1",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD.TGR2",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD.TGR3",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD.TGR4",
         "PerPkg": "1",
@@ -1086,7 +965,6 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD.TGR5",
         "PerPkg": "1",
@@ -1095,7 +973,6 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD.TGR6",
         "PerPkg": "1",
@@ -1104,7 +981,6 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD2",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD.TGR7",
         "PerPkg": "1",
@@ -1113,61 +989,54 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 0-7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD3",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD_EXT.ANY_OF_TGR=
0_THRU_TGR7",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 8",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD3",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD_EXT.TGR8",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD6",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL.TGR0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD6",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL.TGR1",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 2",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD6",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL.TGR2",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 3",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD6",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL.TGR3",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 4",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD6",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL.TGR4",
         "PerPkg": "1",
@@ -1176,7 +1045,6 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 5",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD6",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL.TGR5",
         "PerPkg": "1",
@@ -1185,7 +1053,6 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 6",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD6",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL.TGR6",
         "PerPkg": "1",
@@ -1194,7 +1061,6 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD6",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL.TGR7",
         "PerPkg": "1",
@@ -1203,43 +1069,38 @@
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 0-7",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD7",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL_EXT.ANY_OF_TGR=
0_THRU_TGR7",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 8",
-        "Counter": "0,1,2,3",
         "EventCode": "0xD7",
         "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL_EXT.TGR8",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Cache Lookups. Counts the number of times the=
 LLC was accessed. Writeback transactions from L2 to the LLC  This includes=
 all write transactions -- both Cachable and UC.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_H_CACHE_LINES_VICTIMIZED.E_STATE",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Cache Lookups. Counts the number of times the=
 LLC was accessed. Filters for any transaction originating from the IPQ or =
IRQ.  This does not include lookups originating from the ISMQ.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_H_CACHE_LINES_VICTIMIZED.F_STATE",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Lines Victimized that Match NID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_H_CACHE_LINES_VICTIMIZED.LOCAL",
         "PerPkg": "1",
@@ -1248,16 +1109,14 @@
     },
     {
         "BriefDescription": "Cache Lookups. Counts the number of times the=
 LLC was accessed. Read transactions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_H_CACHE_LINES_VICTIMIZED.M_STATE",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Lines Victimized that Does Not Match NID",
-        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_H_CACHE_LINES_VICTIMIZED.REMOTE",
         "PerPkg": "1",
@@ -1266,16 +1125,14 @@
     },
     {
         "BriefDescription": "Cache Lookups. Counts the number of times the=
 LLC was accessed. Filters for only snoop requests coming from the remote s=
ocket(s) through the IPQ.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_H_CACHE_LINES_VICTIMIZED.S_STATE",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Uncore Clocks",
-        "Counter": "0,1,2,3",
         "EventCode": "0xC0",
         "EventName": "UNC_H_CLOCK",
         "PerPkg": "1",
@@ -1283,313 +1140,278 @@
     },
     {
         "BriefDescription": "CMS Horizontal ADS Used",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9D",
         "EventName": "UNC_H_EGRESS_HORZ_ADS_USED.AD",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Horizontal ADS Used",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9D",
         "EventName": "UNC_H_EGRESS_HORZ_ADS_USED.AK",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Horizontal ADS Used",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9D",
         "EventName": "UNC_H_EGRESS_HORZ_ADS_USED.BL",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Horizontal Egress Bypass. AD ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9F",
         "EventName": "UNC_H_EGRESS_HORZ_BYPASS.AD",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Horizontal Egress Bypass. AK ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9F",
         "EventName": "UNC_H_EGRESS_HORZ_BYPASS.AK",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Horizontal Egress Bypass. BL ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9F",
         "EventName": "UNC_H_EGRESS_HORZ_BYPASS.BL",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Horizontal Egress Bypass. IV ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9F",
         "EventName": "UNC_H_EGRESS_HORZ_BYPASS.IV",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full AD=
",
-        "Counter": "0,1,2,3",
         "EventCode": "0x96",
         "EventName": "UNC_H_EGRESS_HORZ_CYCLES_FULL.AD",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full AK=
",
-        "Counter": "0,1,2,3",
         "EventCode": "0x96",
         "EventName": "UNC_H_EGRESS_HORZ_CYCLES_FULL.AK",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full BL=
",
-        "Counter": "0,1,2,3",
         "EventCode": "0x96",
         "EventName": "UNC_H_EGRESS_HORZ_CYCLES_FULL.BL",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full IV=
",
-        "Counter": "0,1,2,3",
         "EventCode": "0x96",
         "EventName": "UNC_H_EGRESS_HORZ_CYCLES_FULL.IV",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty AD",
-        "Counter": "0,1,2,3",
         "EventCode": "0x97",
         "EventName": "UNC_H_EGRESS_HORZ_CYCLES_NE.AD",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty AK",
-        "Counter": "0,1,2,3",
         "EventCode": "0x97",
         "EventName": "UNC_H_EGRESS_HORZ_CYCLES_NE.AK",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty BL",
-        "Counter": "0,1,2,3",
         "EventCode": "0x97",
         "EventName": "UNC_H_EGRESS_HORZ_CYCLES_NE.BL",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty IV",
-        "Counter": "0,1,2,3",
         "EventCode": "0x97",
         "EventName": "UNC_H_EGRESS_HORZ_CYCLES_NE.IV",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Horizontal Egress Inserts AD",
-        "Counter": "0,1,2,3",
         "EventCode": "0x95",
         "EventName": "UNC_H_EGRESS_HORZ_INSERTS.AD",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Horizontal Egress Inserts AK",
-        "Counter": "0,1,2,3",
         "EventCode": "0x95",
         "EventName": "UNC_H_EGRESS_HORZ_INSERTS.AK",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Horizontal Egress Inserts BL",
-        "Counter": "0,1,2,3",
         "EventCode": "0x95",
         "EventName": "UNC_H_EGRESS_HORZ_INSERTS.BL",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Horizontal Egress Inserts IV",
-        "Counter": "0,1,2,3",
         "EventCode": "0x95",
         "EventName": "UNC_H_EGRESS_HORZ_INSERTS.IV",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Horizontal Egress NACKs",
-        "Counter": "0,1,2,3",
         "EventCode": "0x99",
         "EventName": "UNC_H_EGRESS_HORZ_NACK.AD",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Horizontal Egress NACKs",
-        "Counter": "0,1,2,3",
         "EventCode": "0x99",
         "EventName": "UNC_H_EGRESS_HORZ_NACK.AK",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Horizontal Egress NACKs",
-        "Counter": "0,1,2,3",
         "EventCode": "0x99",
         "EventName": "UNC_H_EGRESS_HORZ_NACK.BL",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Horizontal Egress NACKs",
-        "Counter": "0,1,2,3",
         "EventCode": "0x99",
         "EventName": "UNC_H_EGRESS_HORZ_NACK.IV",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Horizontal Egress Occupancy AD",
-        "Counter": "0,1,2,3",
         "EventCode": "0x94",
         "EventName": "UNC_H_EGRESS_HORZ_OCCUPANCY.AD",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Horizontal Egress Occupancy AK",
-        "Counter": "0,1,2,3",
         "EventCode": "0x94",
         "EventName": "UNC_H_EGRESS_HORZ_OCCUPANCY.AK",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Horizontal Egress Occupancy BL",
-        "Counter": "0,1,2,3",
         "EventCode": "0x94",
         "EventName": "UNC_H_EGRESS_HORZ_OCCUPANCY.BL",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Horizontal Egress Occupancy IV",
-        "Counter": "0,1,2,3",
         "EventCode": "0x94",
         "EventName": "UNC_H_EGRESS_HORZ_OCCUPANCY.IV",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Horizontal Egress Injection Starvation",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9B",
         "EventName": "UNC_H_EGRESS_HORZ_STARVED.AD",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Horizontal Egress Injection Starvation",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9B",
         "EventName": "UNC_H_EGRESS_HORZ_STARVED.AK",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Horizontal Egress Injection Starvation",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9B",
         "EventName": "UNC_H_EGRESS_HORZ_STARVED.BL",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Horizontal Egress Injection Starvation",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9B",
         "EventName": "UNC_H_EGRESS_HORZ_STARVED.IV",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts number of cycles IV was blocked in the=
 TGR Egress due to SNP/GO Ordering requirements",
-        "Counter": "0,1,2,3",
         "EventCode": "0xAE",
         "EventName": "UNC_H_EGRESS_ORDERING.IV_SNP_GO_DN",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts number of cycles IV was blocked in the=
 TGR Egress due to SNP/GO Ordering requirements",
-        "Counter": "0,1,2,3",
         "EventCode": "0xAE",
         "EventName": "UNC_H_EGRESS_ORDERING.IV_SNP_GO_UP",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Vertical ADS Used",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9C",
         "EventName": "UNC_H_EGRESS_VERT_ADS_USED.AD_AG0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Vertical ADS Used",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9C",
         "EventName": "UNC_H_EGRESS_VERT_ADS_USED.AD_AG1",
         "PerPkg": "1",
@@ -1598,16 +1420,14 @@
     },
     {
         "BriefDescription": "CMS Vertical ADS Used",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9C",
         "EventName": "UNC_H_EGRESS_VERT_ADS_USED.AK_AG0",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Vertical ADS Used",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9C",
         "EventName": "UNC_H_EGRESS_VERT_ADS_USED.AK_AG1",
         "PerPkg": "1",
@@ -1616,16 +1436,14 @@
     },
     {
         "BriefDescription": "CMS Vertical ADS Used",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9C",
         "EventName": "UNC_H_EGRESS_VERT_ADS_USED.BL_AG0",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Vertical ADS Used",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9C",
         "EventName": "UNC_H_EGRESS_VERT_ADS_USED.BL_AG1",
         "PerPkg": "1",
@@ -1634,16 +1452,14 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress Bypass. AD ring agent 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9E",
         "EventName": "UNC_H_EGRESS_VERT_BYPASS.AD_AG0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Vertical Egress Bypass. AD ring agent 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9E",
         "EventName": "UNC_H_EGRESS_VERT_BYPASS.AD_AG1",
         "PerPkg": "1",
@@ -1652,16 +1468,14 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress Bypass. AK ring agent 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9E",
         "EventName": "UNC_H_EGRESS_VERT_BYPASS.AK_AG0",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Vertical Egress Bypass. AK ring agent 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9E",
         "EventName": "UNC_H_EGRESS_VERT_BYPASS.AK_AG1",
         "PerPkg": "1",
@@ -1670,16 +1484,14 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress Bypass. BL ring agent 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9E",
         "EventName": "UNC_H_EGRESS_VERT_BYPASS.BL_AG0",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Vertical Egress Bypass. BL ring agent 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9E",
         "EventName": "UNC_H_EGRESS_VERT_BYPASS.BL_AG1",
         "PerPkg": "1",
@@ -1688,25 +1500,22 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress Bypass. IV ring agent 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9E",
         "EventName": "UNC_H_EGRESS_VERT_BYPASS.IV",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full AD -=
 Agent 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x92",
         "EventName": "UNC_H_EGRESS_VERT_CYCLES_FULL.AD_AG0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full AD -=
 Agent 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x92",
         "EventName": "UNC_H_EGRESS_VERT_CYCLES_FULL.AD_AG1",
         "PerPkg": "1",
@@ -1715,16 +1524,14 @@
     },
     {
         "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full AK -=
 Agent 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x92",
         "EventName": "UNC_H_EGRESS_VERT_CYCLES_FULL.AK_AG0",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full AK -=
 Agent 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x92",
         "EventName": "UNC_H_EGRESS_VERT_CYCLES_FULL.AK_AG1",
         "PerPkg": "1",
@@ -1733,16 +1540,14 @@
     },
     {
         "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full BL -=
 Agent 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x92",
         "EventName": "UNC_H_EGRESS_VERT_CYCLES_FULL.BL_AG0",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full BL -=
 Agent 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x92",
         "EventName": "UNC_H_EGRESS_VERT_CYCLES_FULL.BL_AG1",
         "PerPkg": "1",
@@ -1751,25 +1556,22 @@
     },
     {
         "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full IV -=
 Agent 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x92",
         "EventName": "UNC_H_EGRESS_VERT_CYCLES_FULL.IV_AG0",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 AD - Agent 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x93",
         "EventName": "UNC_H_EGRESS_VERT_CYCLES_NE.AD_AG0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 AD - Agent 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x93",
         "EventName": "UNC_H_EGRESS_VERT_CYCLES_NE.AD_AG1",
         "PerPkg": "1",
@@ -1778,16 +1580,14 @@
     },
     {
         "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 AK - Agent 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x93",
         "EventName": "UNC_H_EGRESS_VERT_CYCLES_NE.AK_AG0",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 AK - Agent 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x93",
         "EventName": "UNC_H_EGRESS_VERT_CYCLES_NE.AK_AG1",
         "PerPkg": "1",
@@ -1796,16 +1596,14 @@
     },
     {
         "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 BL - Agent 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x93",
         "EventName": "UNC_H_EGRESS_VERT_CYCLES_NE.BL_AG0",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 BL - Agent 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x93",
         "EventName": "UNC_H_EGRESS_VERT_CYCLES_NE.BL_AG1",
         "PerPkg": "1",
@@ -1814,25 +1612,22 @@
     },
     {
         "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 IV - Agent 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x93",
         "EventName": "UNC_H_EGRESS_VERT_CYCLES_NE.IV_AG0",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Vert Egress Allocations AD - Agent 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x91",
         "EventName": "UNC_H_EGRESS_VERT_INSERTS.AD_AG0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Vert Egress Allocations AD - Agent 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x91",
         "EventName": "UNC_H_EGRESS_VERT_INSERTS.AD_AG1",
         "PerPkg": "1",
@@ -1841,16 +1636,14 @@
     },
     {
         "BriefDescription": "CMS Vert Egress Allocations AK - Agent 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x91",
         "EventName": "UNC_H_EGRESS_VERT_INSERTS.AK_AG0",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Vert Egress Allocations AK - Agent 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x91",
         "EventName": "UNC_H_EGRESS_VERT_INSERTS.AK_AG1",
         "PerPkg": "1",
@@ -1859,16 +1652,14 @@
     },
     {
         "BriefDescription": "CMS Vert Egress Allocations BL - Agent 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x91",
         "EventName": "UNC_H_EGRESS_VERT_INSERTS.BL_AG0",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Vert Egress Allocations BL - Agent 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x91",
         "EventName": "UNC_H_EGRESS_VERT_INSERTS.BL_AG1",
         "PerPkg": "1",
@@ -1877,25 +1668,22 @@
     },
     {
         "BriefDescription": "CMS Vert Egress Allocations IV - Agent 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x91",
         "EventName": "UNC_H_EGRESS_VERT_INSERTS.IV_AG0",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Vertical Egress NACKs",
-        "Counter": "0,1,2,3",
         "EventCode": "0x98",
         "EventName": "UNC_H_EGRESS_VERT_NACK.AD_AG0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Vertical Egress NACKs",
-        "Counter": "0,1,2,3",
         "EventCode": "0x98",
         "EventName": "UNC_H_EGRESS_VERT_NACK.AD_AG1",
         "PerPkg": "1",
@@ -1904,16 +1692,14 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress NACKs Onto AK Ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x98",
         "EventName": "UNC_H_EGRESS_VERT_NACK.AK_AG0",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Vertical Egress NACKs",
-        "Counter": "0,1,2,3",
         "EventCode": "0x98",
         "EventName": "UNC_H_EGRESS_VERT_NACK.AK_AG1",
         "PerPkg": "1",
@@ -1922,16 +1708,14 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress NACKs Onto BL Ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x98",
         "EventName": "UNC_H_EGRESS_VERT_NACK.BL_AG0",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Vertical Egress NACKs",
-        "Counter": "0,1,2,3",
         "EventCode": "0x98",
         "EventName": "UNC_H_EGRESS_VERT_NACK.BL_AG1",
         "PerPkg": "1",
@@ -1940,25 +1724,22 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress NACKs",
-        "Counter": "0,1,2,3",
         "EventCode": "0x98",
         "EventName": "UNC_H_EGRESS_VERT_NACK.IV_AG0",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Vert Egress Occupancy AD - Agent 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x90",
         "EventName": "UNC_H_EGRESS_VERT_OCCUPANCY.AD_AG0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Vert Egress Occupancy AD - Agent 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x90",
         "EventName": "UNC_H_EGRESS_VERT_OCCUPANCY.AD_AG1",
         "PerPkg": "1",
@@ -1967,16 +1748,14 @@
     },
     {
         "BriefDescription": "CMS Vert Egress Occupancy AK - Agent 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x90",
         "EventName": "UNC_H_EGRESS_VERT_OCCUPANCY.AK_AG0",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Vert Egress Occupancy AK - Agent 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x90",
         "EventName": "UNC_H_EGRESS_VERT_OCCUPANCY.AK_AG1",
         "PerPkg": "1",
@@ -1985,16 +1764,14 @@
     },
     {
         "BriefDescription": "CMS Vert Egress Occupancy BL - Agent 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x90",
         "EventName": "UNC_H_EGRESS_VERT_OCCUPANCY.BL_AG0",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Vert Egress Occupancy BL - Agent 1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x90",
         "EventName": "UNC_H_EGRESS_VERT_OCCUPANCY.BL_AG1",
         "PerPkg": "1",
@@ -2003,25 +1780,22 @@
     },
     {
         "BriefDescription": "CMS Vert Egress Occupancy IV - Agent 0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x90",
         "EventName": "UNC_H_EGRESS_VERT_OCCUPANCY.IV_AG0",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Vertical Egress Injection Starvation",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9A",
         "EventName": "UNC_H_EGRESS_VERT_STARVED.AD_AG0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Vertical Egress Injection Starvation",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9A",
         "EventName": "UNC_H_EGRESS_VERT_STARVED.AD_AG1",
         "PerPkg": "1",
@@ -2030,16 +1804,14 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress Injection Starvation Onto=
 AK Ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9A",
         "EventName": "UNC_H_EGRESS_VERT_STARVED.AK_AG0",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Vertical Egress Injection Starvation",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9A",
         "EventName": "UNC_H_EGRESS_VERT_STARVED.AK_AG1",
         "PerPkg": "1",
@@ -2048,16 +1820,14 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress Injection Starvation Onto=
 BL Ring",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9A",
         "EventName": "UNC_H_EGRESS_VERT_STARVED.BL_AG0",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CMS Vertical Egress Injection Starvation",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9A",
         "EventName": "UNC_H_EGRESS_VERT_STARVED.BL_AG1",
         "PerPkg": "1",
@@ -2066,25 +1836,22 @@
     },
     {
         "BriefDescription": "CMS Vertical Egress Injection Starvation",
-        "Counter": "0,1,2,3",
         "EventCode": "0x9A",
         "EventName": "UNC_H_EGRESS_VERT_STARVED.IV_AG0",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts cycles source throttling is adderted -=
 horizontal",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA5",
         "EventName": "UNC_H_FAST_ASSERTED.HORZ",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts cycles source throttling is adderted -=
 vertical",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA5",
         "EventName": "UNC_H_FAST_ASSERTED.VERT",
         "PerPkg": "1",
@@ -2092,160 +1859,142 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the Horizont=
al AD ring is being used at this ring stop - Left and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA7",
         "EventName": "UNC_H_HORZ_RING_AD_IN_USE.LEFT_EVEN",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of cycles that the Horizont=
al AD ring is being used at this ring stop - Left and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA7",
         "EventName": "UNC_H_HORZ_RING_AD_IN_USE.LEFT_ODD",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of cycles that the Horizont=
al AD ring is being used at this ring stop - Right and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA7",
         "EventName": "UNC_H_HORZ_RING_AD_IN_USE.RIGHT_EVEN",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of cycles that the Horizont=
al AD ring is being used at this ring stop - Right and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA7",
         "EventName": "UNC_H_HORZ_RING_AD_IN_USE.RIGHT_ODD",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of cycles that the Horizont=
al AK ring is being used at this ring stop - Left and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA9",
         "EventName": "UNC_H_HORZ_RING_AK_IN_USE.LEFT_EVEN",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of cycles that the Horizont=
al AK ring is being used at this ring stop - Left and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA9",
         "EventName": "UNC_H_HORZ_RING_AK_IN_USE.LEFT_ODD",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of cycles that the Horizont=
al AK ring is being used at this ring stop - Right and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA9",
         "EventName": "UNC_H_HORZ_RING_AK_IN_USE.RIGHT_EVEN",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of cycles that the Horizont=
al AK ring is being used at this ring stop - Right and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA9",
         "EventName": "UNC_H_HORZ_RING_AK_IN_USE.RIGHT_ODD",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of cycles that the Horizont=
al BL ring is being used at this ring stop - Left and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0xAB",
         "EventName": "UNC_H_HORZ_RING_BL_IN_USE.LEFT_EVEN",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of cycles that the Horizont=
al BL ring is being used at this ring stop - Left and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0xAB",
         "EventName": "UNC_H_HORZ_RING_BL_IN_USE.LEFT_ODD",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of cycles that the Horizont=
al BL ring is being used at this ring stop - Right and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0xAB",
         "EventName": "UNC_H_HORZ_RING_BL_IN_USE.RIGHT_EVEN",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of cycles that the Horizont=
al BL ring is being used at this ring stop - Right and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0xAB",
         "EventName": "UNC_H_HORZ_RING_BL_IN_USE.RIGHT_ODD",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of cycles that the Horizont=
al IV ring is being used at this ring stop - Left",
-        "Counter": "0,1,2,3",
         "EventCode": "0xAD",
         "EventName": "UNC_H_HORZ_RING_IV_IN_USE.LEFT",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of cycles that the Horizont=
al IV ring is being used at this ring stop - Right",
-        "Counter": "0,1,2,3",
         "EventCode": "0xAD",
         "EventName": "UNC_H_HORZ_RING_IV_IN_USE.RIGHT",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Ingress Allocations. Counts number of allocat=
ions per cycle into the specified Ingress queue. - IPQ",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_H_INGRESS_INSERTS.IPQ",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Ingress Allocations. Counts number of allocat=
ions per cycle into the specified Ingress queue. - IRQ",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_H_INGRESS_INSERTS.IRQ",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Ingress Allocations. Counts number of allocat=
ions per cycle into the specified Ingress queue. - IRQ Rejected",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_H_INGRESS_INSERTS.IRQ_REJ",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Ingress Allocations. Counts number of allocat=
ions per cycle into the specified Ingress queue. - PRQ",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_H_INGRESS_INSERTS.PRQ",
         "PerPkg": "1",
@@ -2254,7 +2003,6 @@
     },
     {
         "BriefDescription": "Ingress Allocations. Counts number of allocat=
ions per cycle into the specified Ingress queue. - PRQ Rejected",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_H_INGRESS_INSERTS.PRQ_REJ",
         "PerPkg": "1",
@@ -2263,34 +2011,30 @@
     },
     {
         "BriefDescription": "Cycles with the IPQ in Internal Starvation.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_H_INGRESS_INT_STARVED.IPQ",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Cycles with the IRQ in Internal Starvation.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_H_INGRESS_INT_STARVED.IRQ",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Cycles with the ISMQ in Internal Starvation."=
,
-        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_H_INGRESS_INT_STARVED.ISMQ",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Ingress internal starvation cycles. Counts cy=
cles in internal starvation. This occurs when one or more of the entries in=
 the ingress queue are being starved out by other entries in the queue.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_H_INGRESS_INT_STARVED.PRQ",
         "PerPkg": "1",
@@ -2302,7 +2046,7 @@
         "EventCode": "0x11",
         "EventName": "UNC_H_INGRESS_OCCUPANCY.IPQ",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
@@ -2310,7 +2054,7 @@
         "EventCode": "0x11",
         "EventName": "UNC_H_INGRESS_OCCUPANCY.IRQ",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
@@ -2318,7 +2062,7 @@
         "EventCode": "0x11",
         "EventName": "UNC_H_INGRESS_OCCUPANCY.IRQ_REJ",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
@@ -2339,25 +2083,22 @@
     },
     {
         "BriefDescription": "Ingress Probe Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_INGRESS_RETRY_IPQ0_REJECT.AD_REQ_VN0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Ingress Probe Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_INGRESS_RETRY_IPQ0_REJECT.AD_RSP_VN0",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Ingress Probe Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_INGRESS_RETRY_IPQ0_REJECT.AK_NON_UPI",
         "PerPkg": "1",
@@ -2366,7 +2107,6 @@
     },
     {
         "BriefDescription": "Ingress Probe Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_INGRESS_RETRY_IPQ0_REJECT.BL_NCB_VN0",
         "PerPkg": "1",
@@ -2375,7 +2115,6 @@
     },
     {
         "BriefDescription": "Ingress Probe Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_INGRESS_RETRY_IPQ0_REJECT.BL_NCS_VN0",
         "PerPkg": "1",
@@ -2384,25 +2123,22 @@
     },
     {
         "BriefDescription": "Ingress Probe Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_INGRESS_RETRY_IPQ0_REJECT.BL_RSP_VN0",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Ingress Probe Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_INGRESS_RETRY_IPQ0_REJECT.BL_WB_VN0",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Ingress Probe Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_H_INGRESS_RETRY_IPQ0_REJECT.IV_NON_UPI",
         "PerPkg": "1",
@@ -2411,7 +2147,6 @@
     },
     {
         "BriefDescription": "Ingress Probe Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_H_INGRESS_RETRY_IPQ1_REJECT.ALLOW_SNP",
         "PerPkg": "1",
@@ -2420,16 +2155,14 @@
     },
     {
         "BriefDescription": "Ingress Probe Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_H_INGRESS_RETRY_IPQ1_REJECT.ANY_REJECT_IPQ0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Ingress Probe Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_H_INGRESS_RETRY_IPQ1_REJECT.PA_MATCH",
         "PerPkg": "1",
@@ -2438,16 +2171,14 @@
     },
     {
         "BriefDescription": "Ingress Probe Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_H_INGRESS_RETRY_IPQ1_REJECT.SF_VICTIM",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Ingress Probe Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_H_INGRESS_RETRY_IPQ1_REJECT.SF_WAY",
         "PerPkg": "1",
@@ -2456,25 +2187,22 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_H_INGRESS_RETRY_IRQ0_REJECT.AD_REQ_VN0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_H_INGRESS_RETRY_IRQ0_REJECT.AD_RSP_VN0",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_H_INGRESS_RETRY_IRQ0_REJECT.AK_NON_UPI",
         "PerPkg": "1",
@@ -2483,7 +2211,6 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_H_INGRESS_RETRY_IRQ0_REJECT.BL_NCB_VN0",
         "PerPkg": "1",
@@ -2492,7 +2219,6 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_H_INGRESS_RETRY_IRQ0_REJECT.BL_NCS_VN0",
         "PerPkg": "1",
@@ -2501,25 +2227,22 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_H_INGRESS_RETRY_IRQ0_REJECT.BL_RSP_VN0",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_H_INGRESS_RETRY_IRQ0_REJECT.BL_WB_VN0",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_H_INGRESS_RETRY_IRQ0_REJECT.IV_NON_UPI",
         "PerPkg": "1",
@@ -2528,7 +2251,6 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_H_INGRESS_RETRY_IRQ1_REJECT.ALLOW_SNP",
         "PerPkg": "1",
@@ -2537,16 +2259,14 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_H_INGRESS_RETRY_IRQ1_REJECT.ANY_REJECT_IRQ0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_H_INGRESS_RETRY_IRQ1_REJECT.PA_MATCH",
         "PerPkg": "1",
@@ -2555,16 +2275,14 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_H_INGRESS_RETRY_IRQ1_REJECT.SF_VICTIM",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_H_INGRESS_RETRY_IRQ1_REJECT.SF_WAY",
         "PerPkg": "1",
@@ -2573,25 +2291,22 @@
     },
     {
         "BriefDescription": "ISMQ Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_REJECT.AD_REQ_VN0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "ISMQ Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_REJECT.AD_RSP_VN0",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "ISMQ Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_REJECT.AK_NON_UPI",
         "PerPkg": "1",
@@ -2600,7 +2315,6 @@
     },
     {
         "BriefDescription": "ISMQ Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_REJECT.BL_NCB_VN0",
         "PerPkg": "1",
@@ -2609,7 +2323,6 @@
     },
     {
         "BriefDescription": "ISMQ Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_REJECT.BL_NCS_VN0",
         "PerPkg": "1",
@@ -2618,25 +2331,22 @@
     },
     {
         "BriefDescription": "ISMQ Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_REJECT.BL_RSP_VN0",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "ISMQ Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_REJECT.BL_WB_VN0",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "ISMQ Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_REJECT.IV_NON_UPI",
         "PerPkg": "1",
@@ -2645,25 +2355,22 @@
     },
     {
         "BriefDescription": "ISMQ Retries",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2C",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_RETRY.AD_REQ_VN0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "ISMQ Retries",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2C",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_RETRY.AD_RSP_VN0",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "ISMQ Retries",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2C",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_RETRY.AK_NON_UPI",
         "PerPkg": "1",
@@ -2672,7 +2379,6 @@
     },
     {
         "BriefDescription": "ISMQ Retries",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2C",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_RETRY.BL_NCB_VN0",
         "PerPkg": "1",
@@ -2681,7 +2387,6 @@
     },
     {
         "BriefDescription": "ISMQ Retries",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2C",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_RETRY.BL_NCS_VN0",
         "PerPkg": "1",
@@ -2690,25 +2395,22 @@
     },
     {
         "BriefDescription": "ISMQ Retries",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2C",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_RETRY.BL_RSP_VN0",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "ISMQ Retries",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2C",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_RETRY.BL_WB_VN0",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "ISMQ Retries",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2C",
         "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_RETRY.IV_NON_UPI",
         "PerPkg": "1",
@@ -2717,25 +2419,22 @@
     },
     {
         "BriefDescription": "Other Queue Retries",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_H_INGRESS_RETRY_OTHER0_RETRY.AD_REQ_VN0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Other Queue Retries",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_H_INGRESS_RETRY_OTHER0_RETRY.AD_RSP_VN0",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Other Queue Retries",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_H_INGRESS_RETRY_OTHER0_RETRY.AK_NON_UPI",
         "PerPkg": "1",
@@ -2744,7 +2443,6 @@
     },
     {
         "BriefDescription": "Other Queue Retries",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_H_INGRESS_RETRY_OTHER0_RETRY.BL_NCB_VN0",
         "PerPkg": "1",
@@ -2753,7 +2451,6 @@
     },
     {
         "BriefDescription": "Other Queue Retries",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_H_INGRESS_RETRY_OTHER0_RETRY.BL_NCS_VN0",
         "PerPkg": "1",
@@ -2762,25 +2459,22 @@
     },
     {
         "BriefDescription": "Other Queue Retries",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_H_INGRESS_RETRY_OTHER0_RETRY.BL_RSP_VN0",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Other Queue Retries",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_H_INGRESS_RETRY_OTHER0_RETRY.BL_WB_VN0",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Other Queue Retries",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_H_INGRESS_RETRY_OTHER0_RETRY.IV_NON_UPI",
         "PerPkg": "1",
@@ -2789,7 +2483,6 @@
     },
     {
         "BriefDescription": "Other Queue Retries",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2F",
         "EventName": "UNC_H_INGRESS_RETRY_OTHER1_RETRY.ALLOW_SNP",
         "PerPkg": "1",
@@ -2798,16 +2491,14 @@
     },
     {
         "BriefDescription": "Other Queue Retries",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2F",
         "EventName": "UNC_H_INGRESS_RETRY_OTHER1_RETRY.ANY_REJECT_IRQ0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Other Queue Retries",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2F",
         "EventName": "UNC_H_INGRESS_RETRY_OTHER1_RETRY.PA_MATCH",
         "PerPkg": "1",
@@ -2816,16 +2507,14 @@
     },
     {
         "BriefDescription": "Other Queue Retries",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2F",
         "EventName": "UNC_H_INGRESS_RETRY_OTHER1_RETRY.SF_VICTIM",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Other Queue Retries",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2F",
         "EventName": "UNC_H_INGRESS_RETRY_OTHER1_RETRY.SF_WAY",
         "PerPkg": "1",
@@ -2834,25 +2523,22 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_H_INGRESS_RETRY_PRQ0_REJECT.AD_REQ_VN0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_H_INGRESS_RETRY_PRQ0_REJECT.AD_RSP_VN0",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_H_INGRESS_RETRY_PRQ0_REJECT.AK_NON_UPI",
         "PerPkg": "1",
@@ -2861,7 +2547,6 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_H_INGRESS_RETRY_PRQ0_REJECT.BL_NCB_VN0",
         "PerPkg": "1",
@@ -2870,7 +2555,6 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_H_INGRESS_RETRY_PRQ0_REJECT.BL_NCS_VN0",
         "PerPkg": "1",
@@ -2879,25 +2563,22 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_H_INGRESS_RETRY_PRQ0_REJECT.BL_RSP_VN0",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_H_INGRESS_RETRY_PRQ0_REJECT.BL_WB_VN0",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_H_INGRESS_RETRY_PRQ0_REJECT.IV_NON_UPI",
         "PerPkg": "1",
@@ -2906,7 +2587,6 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_INGRESS_RETRY_PRQ1_REJECT.ALLOW_SNP",
         "PerPkg": "1",
@@ -2915,16 +2595,14 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_INGRESS_RETRY_PRQ1_REJECT.ANY_REJECT_IRQ0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_INGRESS_RETRY_PRQ1_REJECT.PA_MATCH",
         "PerPkg": "1",
@@ -2933,16 +2611,14 @@
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_INGRESS_RETRY_PRQ1_REJECT.SF_VICTIM",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_INGRESS_RETRY_PRQ1_REJECT.SF_WAY",
         "PerPkg": "1",
@@ -2951,25 +2627,22 @@
     },
     {
         "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.AD_REQ_VN0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.AD_RSP_VN0",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.AK_NON_UPI",
         "PerPkg": "1",
@@ -2978,7 +2651,6 @@
     },
     {
         "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.BL_NCB_VN0",
         "PerPkg": "1",
@@ -2987,7 +2659,6 @@
     },
     {
         "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.BL_NCS_VN0",
         "PerPkg": "1",
@@ -2996,25 +2667,22 @@
     },
     {
         "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.BL_RSP_VN0",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.BL_WB_VN0",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.IV_NON_UPI",
         "PerPkg": "1",
@@ -3023,7 +2691,6 @@
     },
     {
         "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2B",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q1_RETRY.ALLOW_SNP",
         "PerPkg": "1",
@@ -3032,16 +2699,14 @@
     },
     {
         "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2B",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q1_RETRY.ANY_REJECT_IRQ0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2B",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q1_RETRY.PA_MATCH",
         "PerPkg": "1",
@@ -3050,16 +2715,14 @@
     },
     {
         "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2B",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q1_RETRY.SF_VICTIM",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2B",
         "EventName": "UNC_H_INGRESS_RETRY_REQ_Q1_RETRY.SF_WAY",
         "PerPkg": "1",
@@ -3068,7 +2731,6 @@
     },
     {
         "BriefDescription": "Miscellaneous events in the Cbo. CV0 Prefetch=
 Miss",
-        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_H_MISC.CV0_PREF_MISS",
         "PerPkg": "1",
@@ -3077,7 +2739,6 @@
     },
     {
         "BriefDescription": "Miscellaneous events in the Cbo. CV0 Prefetch=
 Victim",
-        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_H_MISC.CV0_PREF_VIC",
         "PerPkg": "1",
@@ -3086,178 +2747,158 @@
     },
     {
         "BriefDescription": "Miscellaneous events in the Cbo. RFO HitS",
-        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_H_MISC.RFO_HIT_S",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Miscellaneous events in the Cbo. Silent Snoop=
 Eviction",
-        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_H_MISC.RSPI_WAS_FSE",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Miscellaneous events in the Cbo. Write Combin=
ing Aliasing",
-        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_H_MISC.WC_ALIASING",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Number of incoming messages from the Horizont=
al ring that were bounced, by ring type.",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UNC_H_RING_BOUNCES_HORZ.AD",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Number of incoming messages from the Horizont=
al ring that were bounced, by ring type - Acknowledgements to core",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UNC_H_RING_BOUNCES_HORZ.AK",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Number of incoming messages from the Horizont=
al ring that were bounced, by ring type - Data Responses to core.",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UNC_H_RING_BOUNCES_HORZ.BL",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Number of incoming messages from the Horizont=
al ring that were bounced, by ring type - Snoops of processor's cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA1",
         "EventName": "UNC_H_RING_BOUNCES_HORZ.IV",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Number of incoming messages from the Vertical=
 ring that were bounced, by ring type.",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA0",
         "EventName": "UNC_H_RING_BOUNCES_VERT.AD",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Number of incoming messages from the Vertical=
 ring that were bounced, by ring type - Acknowledgements to core",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA0",
         "EventName": "UNC_H_RING_BOUNCES_VERT.AK",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Number of incoming messages from the Vertical=
 ring that were bounced, by ring type - Data Responses to core.",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA0",
         "EventName": "UNC_H_RING_BOUNCES_VERT.BL",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Number of incoming messages from the Vertical=
 ring that were bounced, by ring type - Snoops of processor's cache.",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA0",
         "EventName": "UNC_H_RING_BOUNCES_VERT.IV",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Horizontal ring sink starvation count - AD ri=
ng",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA3",
         "EventName": "UNC_H_RING_SINK_STARVED_HORZ.AD",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Horizontal ring sink starvation count - AK ri=
ng",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA3",
         "EventName": "UNC_H_RING_SINK_STARVED_HORZ.AK",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Horizontal ring sink starvation count - BL ri=
ng",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA3",
         "EventName": "UNC_H_RING_SINK_STARVED_HORZ.BL",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Horizontal ring sink starvation count - IV ri=
ng",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA3",
         "EventName": "UNC_H_RING_SINK_STARVED_HORZ.IV",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Vertical ring sink starvation count - AD ring=
",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
         "EventName": "UNC_H_RING_SINK_STARVED_VERT.AD",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Vertical ring sink starvation count - AK ring=
",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
         "EventName": "UNC_H_RING_SINK_STARVED_VERT.AK",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Vertical ring sink starvation count - BL ring=
",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
         "EventName": "UNC_H_RING_SINK_STARVED_VERT.BL",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Vertical ring sink starvation count - IV ring=
",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
         "EventName": "UNC_H_RING_SINK_STARVED_VERT.IV",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts cycles in throttle mode.",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA4",
         "EventName": "UNC_H_RING_SRC_THRTL",
         "PerPkg": "1",
@@ -3265,7 +2906,6 @@
     },
     {
         "BriefDescription": "Cache Lookups. Counts the number of times the=
 LLC was accessed. Filters for any transaction originating from the IPQ or =
IRQ.  This does not include lookups originating from the ISMQ.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_H_SF_LOOKUP.ANY",
         "PerPkg": "1",
@@ -3274,43 +2914,38 @@
     },
     {
         "BriefDescription": "Cache Lookups. Counts the number of times the=
 LLC was accessed. Read transactions",
-        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_H_SF_LOOKUP.DATA_READ",
         "PerPkg": "1",
-        "UMask": "0x03",
+        "UMask": "0x3",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Cache Lookups. Counts the number of times the=
 LLC was accessed. Filters for only snoop requests coming from the remote s=
ocket(s) through the IPQ.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_H_SF_LOOKUP.REMOTE_SNOOP",
         "PerPkg": "1",
-        "UMask": "0x09",
+        "UMask": "0x9",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Cache Lookups. Counts the number of times the=
 LLC was accessed. Writeback transactions from L2 to the LLC  This includes=
 all write transactions -- both Cachable and UC.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_H_SF_LOOKUP.WRITE",
         "PerPkg": "1",
-        "UMask": "0x05",
+        "UMask": "0x5",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, because a message from the other queue has higher priorit=
y",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_H_TG_INGRESS_BUSY_STARVED.AD_BNC",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, because a message from the other queue has higher priorit=
y",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_H_TG_INGRESS_BUSY_STARVED.AD_CRD",
         "PerPkg": "1",
@@ -3319,16 +2954,14 @@
     },
     {
         "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, because a message from the other queue has higher priorit=
y",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_H_TG_INGRESS_BUSY_STARVED.BL_BNC",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, because a message from the other queue has higher priorit=
y",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB4",
         "EventName": "UNC_H_TG_INGRESS_BUSY_STARVED.BL_CRD",
         "PerPkg": "1",
@@ -3337,16 +2970,14 @@
     },
     {
         "BriefDescription": "Transgress Ingress Bypass. Number of packets =
bypassing the CMS Ingress .",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB2",
         "EventName": "UNC_H_TG_INGRESS_BYPASS.AD_BNC",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Transgress Ingress Bypass. Number of packets =
bypassing the CMS Ingress .",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB2",
         "EventName": "UNC_H_TG_INGRESS_BYPASS.AD_CRD",
         "PerPkg": "1",
@@ -3355,25 +2986,22 @@
     },
     {
         "BriefDescription": "Transgress Ingress Bypass. Number of packets =
bypassing the CMS Ingress .",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB2",
         "EventName": "UNC_H_TG_INGRESS_BYPASS.AK_BNC",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Transgress Ingress Bypass. Number of packets =
bypassing the CMS Ingress .",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB2",
         "EventName": "UNC_H_TG_INGRESS_BYPASS.BL_BNC",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Transgress Ingress Bypass. Number of packets =
bypassing the CMS Ingress .",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB2",
         "EventName": "UNC_H_TG_INGRESS_BYPASS.BL_CRD",
         "PerPkg": "1",
@@ -3382,25 +3010,22 @@
     },
     {
         "BriefDescription": "Transgress Ingress Bypass. Number of packets =
bypassing the CMS Ingress .",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB2",
         "EventName": "UNC_H_TG_INGRESS_BYPASS.IV_BNC",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, the Ingress is unable to forward to the Egress due to a l=
ack of credit.",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB3",
         "EventName": "UNC_H_TG_INGRESS_CRD_STARVED.AD_BNC",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, the Ingress is unable to forward to the Egress due to a l=
ack of credit.",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB3",
         "EventName": "UNC_H_TG_INGRESS_CRD_STARVED.AD_CRD",
         "PerPkg": "1",
@@ -3409,25 +3034,22 @@
     },
     {
         "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, the Ingress is unable to forward to the Egress due to a l=
ack of credit.",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB3",
         "EventName": "UNC_H_TG_INGRESS_CRD_STARVED.AK_BNC",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, the Ingress is unable to forward to the Egress due to a l=
ack of credit.",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB3",
         "EventName": "UNC_H_TG_INGRESS_CRD_STARVED.BL_BNC",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, the Ingress is unable to forward to the Egress due to a l=
ack of credit.",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB3",
         "EventName": "UNC_H_TG_INGRESS_CRD_STARVED.BL_CRD",
         "PerPkg": "1",
@@ -3436,7 +3058,6 @@
     },
     {
         "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, the Ingress is unable to forward to the Egress due to a l=
ack of credit.",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB3",
         "EventName": "UNC_H_TG_INGRESS_CRD_STARVED.IFV",
         "PerPkg": "1",
@@ -3445,25 +3066,22 @@
     },
     {
         "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, the Ingress is unable to forward to the Egress due to a l=
ack of credit.",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB3",
         "EventName": "UNC_H_TG_INGRESS_CRD_STARVED.IV_BNC",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Transgress Ingress Allocations. Number of all=
ocations into the CMS Ingress  The Ingress is used to queue up requests rec=
eived from the mesh",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_H_TG_INGRESS_INSERTS.AD_BNC",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Transgress Ingress Allocations. Number of all=
ocations into the CMS Ingress  The Ingress is used to queue up requests rec=
eived from the mesh",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_H_TG_INGRESS_INSERTS.AD_CRD",
         "PerPkg": "1",
@@ -3472,25 +3090,22 @@
     },
     {
         "BriefDescription": "Transgress Ingress Allocations. Number of all=
ocations into the CMS Ingress  The Ingress is used to queue up requests rec=
eived from the mesh",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_H_TG_INGRESS_INSERTS.AK_BNC",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Transgress Ingress Allocations. Number of all=
ocations into the CMS Ingress  The Ingress is used to queue up requests rec=
eived from the mesh",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_H_TG_INGRESS_INSERTS.BL_BNC",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Transgress Ingress Allocations. Number of all=
ocations into the CMS Ingress  The Ingress is used to queue up requests rec=
eived from the mesh",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_H_TG_INGRESS_INSERTS.BL_CRD",
         "PerPkg": "1",
@@ -3499,25 +3114,22 @@
     },
     {
         "BriefDescription": "Transgress Ingress Allocations. Number of all=
ocations into the CMS Ingress  The Ingress is used to queue up requests rec=
eived from the mesh",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB1",
         "EventName": "UNC_H_TG_INGRESS_INSERTS.IV_BNC",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Transgress Ingress Occupancy. Occupancy event=
 for the Ingress buffers in the CMS  The Ingress is used to queue up reques=
ts received from the mesh",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_H_TG_INGRESS_OCCUPANCY.AD_BNC",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Transgress Ingress Occupancy. Occupancy event=
 for the Ingress buffers in the CMS  The Ingress is used to queue up reques=
ts received from the mesh",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_H_TG_INGRESS_OCCUPANCY.AD_CRD",
         "PerPkg": "1",
@@ -3526,25 +3138,22 @@
     },
     {
         "BriefDescription": "Transgress Ingress Occupancy. Occupancy event=
 for the Ingress buffers in the CMS  The Ingress is used to queue up reques=
ts received from the mesh",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_H_TG_INGRESS_OCCUPANCY.AK_BNC",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Transgress Ingress Occupancy. Occupancy event=
 for the Ingress buffers in the CMS  The Ingress is used to queue up reques=
ts received from the mesh",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_H_TG_INGRESS_OCCUPANCY.BL_BNC",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Transgress Ingress Occupancy. Occupancy event=
 for the Ingress buffers in the CMS  The Ingress is used to queue up reques=
ts received from the mesh",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_H_TG_INGRESS_OCCUPANCY.BL_CRD",
         "PerPkg": "1",
@@ -3553,16 +3162,14 @@
     },
     {
         "BriefDescription": "Transgress Ingress Occupancy. Occupancy event=
 for the Ingress buffers in the CMS  The Ingress is used to queue up reques=
ts received from the mesh",
-        "Counter": "0,1,2,3",
         "EventCode": "0xB0",
         "EventName": "UNC_H_TG_INGRESS_OCCUPANCY.IV_BNC",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -SF=
/LLC Evictions",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -SF=
/LLC Evictions",
         "EventCode": "0x35",
         "EventName": "UNC_H_TOR_INSERTS.EVICT",
         "PerPkg": "1",
@@ -3570,17 +3177,15 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -Hi=
t (Not a Miss)",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -Hi=
t (Not a Miss)",
         "EventCode": "0x35",
         "EventName": "UNC_H_TOR_INSERTS.HIT",
         "PerPkg": "1",
-        "UMask": "0x1F",
+        "UMask": "0x1f",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -IP=
Q",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -IP=
Q",
         "EventCode": "0x35",
         "EventName": "UNC_H_TOR_INSERTS.IPQ",
         "PerPkg": "1",
@@ -3588,8 +3193,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -IR=
Q",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -IR=
Q",
         "EventCode": "0x35",
         "EventName": "UNC_H_TOR_INSERTS.IRQ",
         "PerPkg": "1",
@@ -3597,17 +3201,15 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -Mi=
ss",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -Mi=
ss",
         "EventCode": "0x35",
         "EventName": "UNC_H_TOR_INSERTS.MISS",
         "PerPkg": "1",
-        "UMask": "0x2F",
+        "UMask": "0x2f",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -PR=
Q",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Counts the number of entries successfully ins=
erted into the TOR that match  qualifications specified by the subevent -PR=
Q",
         "EventCode": "0x35",
         "EventName": "UNC_H_TOR_INSERTS.PRQ",
         "PerPkg": "1",
@@ -3627,7 +3229,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_H_TOR_OCCUPANCY.HIT",
         "PerPkg": "1",
-        "UMask": "0x1F",
+        "UMask": "0x1f",
         "Unit": "CHA"
     },
     {
@@ -3683,7 +3285,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_H_TOR_OCCUPANCY.MISS",
         "PerPkg": "1",
-        "UMask": "0x2F",
+        "UMask": "0x2f",
         "Unit": "CHA"
     },
     {
@@ -3712,167 +3314,148 @@
     },
     {
         "BriefDescription": "Uncore Clocks",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_H_U_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of cycles that the Vertical=
 AD ring is being used at this ring stop - Down and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA6",
         "EventName": "UNC_H_VERT_RING_AD_IN_USE.DN_EVEN",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of cycles that the Vertical=
 AD ring is being used at this ring stop - Down and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA6",
         "EventName": "UNC_H_VERT_RING_AD_IN_USE.DN_ODD",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of cycles that the Vertical=
 AD ring is being used at this ring stop - Up and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA6",
         "EventName": "UNC_H_VERT_RING_AD_IN_USE.UP_EVEN",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of cycles that the Vertical=
 AD ring is being used at this ring stop - Up and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA6",
         "EventName": "UNC_H_VERT_RING_AD_IN_USE.UP_ODD",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of cycles that the Vertical=
 AK ring is being used at this ring stop - Down and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA8",
         "EventName": "UNC_H_VERT_RING_AK_IN_USE.DN_EVEN",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of cycles that the Vertical=
 AK ring is being used at this ring stop - Down and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA8",
         "EventName": "UNC_H_VERT_RING_AK_IN_USE.DN_ODD",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of cycles that the Vertical=
 AK ring is being used at this ring stop - Up and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA8",
         "EventName": "UNC_H_VERT_RING_AK_IN_USE.UP_EVEN",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of cycles that the Vertical=
 AK ring is being used at this ring stop - Up and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0xA8",
         "EventName": "UNC_H_VERT_RING_AK_IN_USE.UP_ODD",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of cycles that the Vertical=
 BL ring is being used at this ring stop - Down and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0xAA",
         "EventName": "UNC_H_VERT_RING_BL_IN_USE.DN_EVEN",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of cycles that the Vertical=
 BL ring is being used at this ring stop - Down and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0xAA",
         "EventName": "UNC_H_VERT_RING_BL_IN_USE.DN_ODD",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of cycles that the Vertical=
 BL ring is being used at this ring stop - Up and Even",
-        "Counter": "0,1,2,3",
         "EventCode": "0xAA",
         "EventName": "UNC_H_VERT_RING_BL_IN_USE.UP_EVEN",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of cycles that the Vertical=
 BL ring is being used at this ring stop - Up and Odd",
-        "Counter": "0,1,2,3",
         "EventCode": "0xAA",
         "EventName": "UNC_H_VERT_RING_BL_IN_USE.UP_ODD",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of cycles that the Vertical=
 IV ring is being used at this ring stop - Down",
-        "Counter": "0,1,2,3",
         "EventCode": "0xAC",
         "EventName": "UNC_H_VERT_RING_IV_IN_USE.DN",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of cycles that the Vertical=
 IV ring is being used at this ring stop - Up",
-        "Counter": "0,1,2,3",
         "EventCode": "0xAC",
         "EventName": "UNC_H_VERT_RING_IV_IN_USE.UP",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  AD_0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.AD_0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "M2PCIe"
     },
     {
         "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  AD_1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.AD_1",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "M2PCIe"
     },
     {
         "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  AK_0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.AK_0",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "M2PCIe"
     },
     {
         "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  AK_1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.AK_1",
         "PerPkg": "1",
@@ -3881,16 +3464,14 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  BL_0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.BL_0",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "M2PCIe"
     },
     {
         "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  BL_1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.BL_1",
         "PerPkg": "1",
@@ -3899,34 +3480,30 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  AD_0",
-        "Counter": "0,1",
         "EventCode": "0x23",
         "EventName": "UNC_M2P_EGRESS_CYCLES_NE.AD_0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "M2PCIe"
     },
     {
         "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  AD_1",
-        "Counter": "0,1",
         "EventCode": "0x23",
         "EventName": "UNC_M2P_EGRESS_CYCLES_NE.AD_1",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "M2PCIe"
     },
     {
         "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  AK_0",
-        "Counter": "0,1",
         "EventCode": "0x23",
         "EventName": "UNC_M2P_EGRESS_CYCLES_NE.AK_0",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "M2PCIe"
     },
     {
         "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  AK_1",
-        "Counter": "0,1",
         "EventCode": "0x23",
         "EventName": "UNC_M2P_EGRESS_CYCLES_NE.AK_1",
         "PerPkg": "1",
@@ -3935,16 +3512,14 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  BL_0",
-        "Counter": "0,1",
         "EventCode": "0x23",
         "EventName": "UNC_M2P_EGRESS_CYCLES_NE.BL_0",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "M2PCIe"
     },
     {
         "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  BL_1",
-        "Counter": "0,1",
         "EventCode": "0x23",
         "EventName": "UNC_M2P_EGRESS_CYCLES_NE.BL_1",
         "PerPkg": "1",
@@ -3953,16 +3528,14 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AD_0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2P_EGRESS_INSERTS.AD_0",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "M2PCIe"
     },
     {
         "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AD_1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2P_EGRESS_INSERTS.AD_1",
         "PerPkg": "1",
@@ -3971,16 +3544,14 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AK_0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2P_EGRESS_INSERTS.AK_0",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "M2PCIe"
     },
     {
         "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AK_1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2P_EGRESS_INSERTS.AK_1",
         "PerPkg": "1",
@@ -3989,16 +3560,14 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AK_CRD_0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2P_EGRESS_INSERTS.AK_CRD_0",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x8",
         "Unit": "M2PCIe"
     },
     {
         "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AK_CRD_1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2P_EGRESS_INSERTS.AK_CRD_1",
         "PerPkg": "1",
@@ -4007,16 +3576,14 @@
     },
     {
         "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. BL_0",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2P_EGRESS_INSERTS.BL_0",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "M2PCIe"
     },
     {
         "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. BL_1",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2P_EGRESS_INSERTS.BL_1",
         "PerPkg": "1",
@@ -4025,7 +3592,6 @@
     },
     {
         "BriefDescription": "Ingress Queue Cycles Not Empty. Counts the nu=
mber of cycles when the M2PCIe Ingress is not empty.ALL",
-        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M2P_INGRESS_CYCLES_NE.ALL",
         "PerPkg": "1",
@@ -4034,68 +3600,60 @@
     },
     {
         "BriefDescription": "Ingress Queue Cycles Not Empty. Counts the nu=
mber of cycles when the M2PCIe Ingress is not empty.CBO_IDI",
-        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M2P_INGRESS_CYCLES_NE.CBO_IDI",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "M2PCIe"
     },
     {
         "BriefDescription": "Ingress Queue Cycles Not Empty. Counts the nu=
mber of cycles when the M2PCIe Ingress is not empty.CBO_NCB",
-        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M2P_INGRESS_CYCLES_NE.CBO_NCB",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "M2PCIe"
     },
     {
         "BriefDescription": "Ingress Queue Cycles Not Empty. Counts the nu=
mber of cycles when the M2PCIe Ingress is not empty.CBO_NCS",
-        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M2P_INGRESS_CYCLES_NE.CBO_NCS",
         "PerPkg": "1",
-        "UMask": "0x04",
+        "UMask": "0x4",
         "Unit": "M2PCIe"
     },
     {
         "BriefDescription": "CAS All",
-        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_CAS_COUNT.ALL",
         "PerPkg": "1",
-        "UMask": "0x03",
+        "UMask": "0x3",
         "Unit": "iMC_DCLK"
     },
     {
         "BriefDescription": "CAS Reads",
-        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_CAS_COUNT.RD",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x1",
         "Unit": "iMC_DCLK"
     },
     {
         "BriefDescription": "CAS Writes",
-        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_CAS_COUNT.WR",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x2",
         "Unit": "iMC_DCLK"
     },
     {
         "BriefDescription": "DCLK count",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_M_D_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "iMC_DCLK"
     },
     {
         "BriefDescription": "UCLK count",
-        "Counter": "0,1,2,3",
         "EventName": "UNC_M_U_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "iMC_UCLK"
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/virtual-memory.j=
son b/tools/perf/pmu-events/arch/x86/knightslanding/virtual-memory.json
index 821cdd44a12f..99a8fa8f19cc 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/virtual-memory.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "Counts the number of load micro-ops retired t=
hat cause a DTLB miss",
-        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0x04",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS_LOADS",
@@ -11,7 +10,6 @@
     },
     {
         "BriefDescription": "Counts the total number of core cycles for al=
l the page walks. The cycles for page walks started in speculative path wil=
l also be included.",
-        "Counter": "0,1",
         "EventCode": "0x05",
         "EventName": "PAGE_WALKS.CYCLES",
         "PublicDescription": "This event counts every cycle when a data (D=
) page walk or instruction (I) page walk is in progress.",
@@ -20,7 +18,6 @@
     },
     {
         "BriefDescription": "Counts the total number of core cycles for al=
l the D-side page walks. The cycles for page walks started in speculative p=
ath will also be included.",
-        "Counter": "0,1",
         "EventCode": "0x05",
         "EventName": "PAGE_WALKS.D_SIDE_CYCLES",
         "SampleAfterValue": "200003",
@@ -28,7 +25,6 @@
     },
     {
         "BriefDescription": "Counts the total D-side page walks that are c=
ompleted or started. The page walks started in the speculative path will al=
so be counted",
-        "Counter": "0,1",
         "EdgeDetect": "1",
         "EventCode": "0x05",
         "EventName": "PAGE_WALKS.D_SIDE_WALKS",
@@ -37,7 +33,6 @@
     },
     {
         "BriefDescription": "Counts the total number of core cycles for al=
l the I-side page walks. The cycles for page walks started in speculative p=
ath will also be included.",
-        "Counter": "0,1",
         "EventCode": "0x05",
         "EventName": "PAGE_WALKS.I_SIDE_CYCLES",
         "PublicDescription": "This event counts every cycle when an I-side=
 (walks due to an instruction fetch) page walk is in progress.",
@@ -46,7 +41,6 @@
     },
     {
         "BriefDescription": "Counts the total I-side page walks that are c=
ompleted.",
-        "Counter": "0,1",
         "EdgeDetect": "1",
         "EventCode": "0x05",
         "EventName": "PAGE_WALKS.I_SIDE_WALKS",
@@ -55,7 +49,6 @@
     },
     {
         "BriefDescription": "Counts the total page walks that are complete=
d (I-side and D-side)",
-        "Counter": "0,1",
         "EdgeDetect": "1",
         "EventCode": "0x05",
         "EventName": "PAGE_WALKS.WALKS",
--=20
2.39.0.314.g84b9a713c41-goog

