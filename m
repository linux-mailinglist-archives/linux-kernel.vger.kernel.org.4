Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D6964D6A5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 07:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiLOGtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 01:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiLOGtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:49:03 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B7A5FBB0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:48:41 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id f11-20020a5b01cb000000b0070374b66537so2633509ybp.14
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PKQNJt9OSfeViQZ9+AaxcuWZ9UMdJXHOQ/2vfnqsmB8=;
        b=H7ifkP2aUaCNzdkVjl7tEIBIpOxHudm8uQruB5pv3J/EUOnXgpG1Md/iJnVSMVjmU8
         Q8PtdWtC30EXXmoy6DeTaQpcHEz8w2yUArsFBcU7GVQr21DNOScrRAFwSg48wePmBLcy
         k4xmJq14k+z4avXmeYV1MkTyPeQGe9Zazr3l4hFA2lvdy5MlhIEfn8FJb3oJMahLxWxi
         122s0Jqebwh7htf6G8/GxEyr+YIXj9TgKu2O1XseiX1Ch0CKWzRdhQMRMTWV0in/D+1R
         BmwkM0c/JIBZ9H7nUaH31ziNuRtKNRCPOBibsT2C0Z1yZD9dramM1six9f2IAFgpI7nh
         h+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PKQNJt9OSfeViQZ9+AaxcuWZ9UMdJXHOQ/2vfnqsmB8=;
        b=cxeFAO5RMG7K6jpjQ7aJXbxEhr2ndVYFPN1mwUrnaGlOPm+iiOgORS0brY+oPzaXzA
         NSrIfeMbdUbIGP4DsedZBMous5GQuCANC67u2vAY7ctdBFfzYtnUOD3mqxz9N1LiH+Ji
         Mg4DAbX0PaGvGuAQF0w3m8mY2g19Mu0sHjuxZ9zNM2+sIP+IvhgZaF3Cg9KpKnet1tlA
         3T6uW37EvRvWcBsiXmSEsw2Gl6LbcorCzrzSutfPBBRrJ39mKPDFM/jNovs86md+flNL
         y423HHmb5QphVOUk2EDG1sGqwa7pIFg7OtUmcy2BygPKUqKh5suBK/altAsy6J4sKrN1
         3+BQ==
X-Gm-Message-State: ANoB5plpHeGnO4bLNSb+AaKS2Vk7cpeshYNfRhlgc8Iv+8TRCPKYG6ag
        l1DDh7skBeC9JlpHD3flPjSHAzho2YE7
X-Google-Smtp-Source: AA0mqf7eZoRAdsg2NwI7sJmShyaTqKFpRqI1NXqbVgog3hRyWSkdwupniPcE2lW4848n/TZ4/qJnNhdlw42Z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c7dc:d96f:4f9:f59d])
 (user=irogers job=sendgmr) by 2002:a25:7711:0:b0:6fa:8f6b:5ac6 with SMTP id
 s17-20020a257711000000b006fa8f6b5ac6mr39105813ybc.531.1671086920832; Wed, 14
 Dec 2022 22:48:40 -0800 (PST)
Date:   Wed, 14 Dec 2022 22:47:27 -0800
In-Reply-To: <20221215064755.1620246-1-irogers@google.com>
Message-Id: <20221215064755.1620246-5-irogers@google.com>
Mime-Version: 1.0
References: <20221215064755.1620246-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 04/32] perf vendor events intel: Refresh bonnell events
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

Update the bonnell events using the new tooling from:
https://github.com/intel/perfmon
The events are unchanged but unused json values are removed and
implicit umasks of 0 are dropped. This increases consistency across
the json files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/bonnell/cache.json    | 93 -------------------
 .../arch/x86/bonnell/floating-point.json      | 47 +---------
 .../pmu-events/arch/x86/bonnell/frontend.json | 11 ---
 .../pmu-events/arch/x86/bonnell/memory.json   | 19 ----
 .../pmu-events/arch/x86/bonnell/other.json    | 74 ++-------------
 .../pmu-events/arch/x86/bonnell/pipeline.json | 65 ++-----------
 .../arch/x86/bonnell/virtual-memory.json      | 15 ---
 7 files changed, 18 insertions(+), 306 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/bonnell/cache.json b/tools/perf/pmu-events/arch/x86/bonnell/cache.json
index 86582bb8aa39..1ca95a70d48a 100644
--- a/tools/perf/pmu-events/arch/x86/bonnell/cache.json
+++ b/tools/perf/pmu-events/arch/x86/bonnell/cache.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "L1 Data Cacheable reads and writes",
-        "Counter": "0,1",
         "EventCode": "0x40",
         "EventName": "L1D_CACHE.ALL_CACHE_REF",
         "SampleAfterValue": "2000000",
@@ -9,7 +8,6 @@
     },
     {
         "BriefDescription": "L1 Data reads and writes",
-        "Counter": "0,1",
         "EventCode": "0x40",
         "EventName": "L1D_CACHE.ALL_REF",
         "SampleAfterValue": "2000000",
@@ -17,7 +15,6 @@
     },
     {
         "BriefDescription": "Modified cache lines evicted from the L1 data cache",
-        "Counter": "0,1",
         "EventCode": "0x40",
         "EventName": "L1D_CACHE.EVICT",
         "SampleAfterValue": "200000",
@@ -25,7 +22,6 @@
     },
     {
         "BriefDescription": "L1 Cacheable Data Reads",
-        "Counter": "0,1",
         "EventCode": "0x40",
         "EventName": "L1D_CACHE.LD",
         "SampleAfterValue": "2000000",
@@ -33,7 +29,6 @@
     },
     {
         "BriefDescription": "L1 Data line replacements",
-        "Counter": "0,1",
         "EventCode": "0x40",
         "EventName": "L1D_CACHE.REPL",
         "SampleAfterValue": "200000",
@@ -41,7 +36,6 @@
     },
     {
         "BriefDescription": "Modified cache lines allocated in the L1 data cache",
-        "Counter": "0,1",
         "EventCode": "0x40",
         "EventName": "L1D_CACHE.REPLM",
         "SampleAfterValue": "200000",
@@ -49,7 +43,6 @@
     },
     {
         "BriefDescription": "L1 Cacheable Data Writes",
-        "Counter": "0,1",
         "EventCode": "0x40",
         "EventName": "L1D_CACHE.ST",
         "SampleAfterValue": "2000000",
@@ -57,7 +50,6 @@
     },
     {
         "BriefDescription": "Cycles L2 address bus is in use.",
-        "Counter": "0,1",
         "EventCode": "0x21",
         "EventName": "L2_ADS.SELF",
         "SampleAfterValue": "200000",
@@ -65,7 +57,6 @@
     },
     {
         "BriefDescription": "All data requests from the L1 data cache",
-        "Counter": "0,1",
         "EventCode": "0x2C",
         "EventName": "L2_DATA_RQSTS.SELF.E_STATE",
         "SampleAfterValue": "200000",
@@ -73,7 +64,6 @@
     },
     {
         "BriefDescription": "All data requests from the L1 data cache",
-        "Counter": "0,1",
         "EventCode": "0x2C",
         "EventName": "L2_DATA_RQSTS.SELF.I_STATE",
         "SampleAfterValue": "200000",
@@ -81,7 +71,6 @@
     },
     {
         "BriefDescription": "All data requests from the L1 data cache",
-        "Counter": "0,1",
         "EventCode": "0x2C",
         "EventName": "L2_DATA_RQSTS.SELF.MESI",
         "SampleAfterValue": "200000",
@@ -89,7 +78,6 @@
     },
     {
         "BriefDescription": "All data requests from the L1 data cache",
-        "Counter": "0,1",
         "EventCode": "0x2C",
         "EventName": "L2_DATA_RQSTS.SELF.M_STATE",
         "SampleAfterValue": "200000",
@@ -97,7 +85,6 @@
     },
     {
         "BriefDescription": "All data requests from the L1 data cache",
-        "Counter": "0,1",
         "EventCode": "0x2C",
         "EventName": "L2_DATA_RQSTS.SELF.S_STATE",
         "SampleAfterValue": "200000",
@@ -105,7 +92,6 @@
     },
     {
         "BriefDescription": "Cycles the L2 cache data bus is busy.",
-        "Counter": "0,1",
         "EventCode": "0x22",
         "EventName": "L2_DBUS_BUSY.SELF",
         "SampleAfterValue": "200000",
@@ -113,7 +99,6 @@
     },
     {
         "BriefDescription": "Cycles the L2 transfers data to the core.",
-        "Counter": "0,1",
         "EventCode": "0x23",
         "EventName": "L2_DBUS_BUSY_RD.SELF",
         "SampleAfterValue": "200000",
@@ -121,7 +106,6 @@
     },
     {
         "BriefDescription": "L2 cacheable instruction fetch requests",
-        "Counter": "0,1",
         "EventCode": "0x28",
         "EventName": "L2_IFETCH.SELF.E_STATE",
         "SampleAfterValue": "200000",
@@ -129,7 +113,6 @@
     },
     {
         "BriefDescription": "L2 cacheable instruction fetch requests",
-        "Counter": "0,1",
         "EventCode": "0x28",
         "EventName": "L2_IFETCH.SELF.I_STATE",
         "SampleAfterValue": "200000",
@@ -137,7 +120,6 @@
     },
     {
         "BriefDescription": "L2 cacheable instruction fetch requests",
-        "Counter": "0,1",
         "EventCode": "0x28",
         "EventName": "L2_IFETCH.SELF.MESI",
         "SampleAfterValue": "200000",
@@ -145,7 +127,6 @@
     },
     {
         "BriefDescription": "L2 cacheable instruction fetch requests",
-        "Counter": "0,1",
         "EventCode": "0x28",
         "EventName": "L2_IFETCH.SELF.M_STATE",
         "SampleAfterValue": "200000",
@@ -153,7 +134,6 @@
     },
     {
         "BriefDescription": "L2 cacheable instruction fetch requests",
-        "Counter": "0,1",
         "EventCode": "0x28",
         "EventName": "L2_IFETCH.SELF.S_STATE",
         "SampleAfterValue": "200000",
@@ -161,7 +141,6 @@
     },
     {
         "BriefDescription": "L2 cache reads",
-        "Counter": "0,1",
         "EventCode": "0x29",
         "EventName": "L2_LD.SELF.ANY.E_STATE",
         "SampleAfterValue": "200000",
@@ -169,7 +148,6 @@
     },
     {
         "BriefDescription": "L2 cache reads",
-        "Counter": "0,1",
         "EventCode": "0x29",
         "EventName": "L2_LD.SELF.ANY.I_STATE",
         "SampleAfterValue": "200000",
@@ -177,7 +155,6 @@
     },
     {
         "BriefDescription": "L2 cache reads",
-        "Counter": "0,1",
         "EventCode": "0x29",
         "EventName": "L2_LD.SELF.ANY.MESI",
         "SampleAfterValue": "200000",
@@ -185,7 +162,6 @@
     },
     {
         "BriefDescription": "L2 cache reads",
-        "Counter": "0,1",
         "EventCode": "0x29",
         "EventName": "L2_LD.SELF.ANY.M_STATE",
         "SampleAfterValue": "200000",
@@ -193,7 +169,6 @@
     },
     {
         "BriefDescription": "L2 cache reads",
-        "Counter": "0,1",
         "EventCode": "0x29",
         "EventName": "L2_LD.SELF.ANY.S_STATE",
         "SampleAfterValue": "200000",
@@ -201,7 +176,6 @@
     },
     {
         "BriefDescription": "L2 cache reads",
-        "Counter": "0,1",
         "EventCode": "0x29",
         "EventName": "L2_LD.SELF.DEMAND.E_STATE",
         "SampleAfterValue": "200000",
@@ -209,7 +183,6 @@
     },
     {
         "BriefDescription": "L2 cache reads",
-        "Counter": "0,1",
         "EventCode": "0x29",
         "EventName": "L2_LD.SELF.DEMAND.I_STATE",
         "SampleAfterValue": "200000",
@@ -217,7 +190,6 @@
     },
     {
         "BriefDescription": "L2 cache reads",
-        "Counter": "0,1",
         "EventCode": "0x29",
         "EventName": "L2_LD.SELF.DEMAND.MESI",
         "SampleAfterValue": "200000",
@@ -225,7 +197,6 @@
     },
     {
         "BriefDescription": "L2 cache reads",
-        "Counter": "0,1",
         "EventCode": "0x29",
         "EventName": "L2_LD.SELF.DEMAND.M_STATE",
         "SampleAfterValue": "200000",
@@ -233,7 +204,6 @@
     },
     {
         "BriefDescription": "L2 cache reads",
-        "Counter": "0,1",
         "EventCode": "0x29",
         "EventName": "L2_LD.SELF.DEMAND.S_STATE",
         "SampleAfterValue": "200000",
@@ -241,7 +211,6 @@
     },
     {
         "BriefDescription": "L2 cache reads",
-        "Counter": "0,1",
         "EventCode": "0x29",
         "EventName": "L2_LD.SELF.PREFETCH.E_STATE",
         "SampleAfterValue": "200000",
@@ -249,7 +218,6 @@
     },
     {
         "BriefDescription": "L2 cache reads",
-        "Counter": "0,1",
         "EventCode": "0x29",
         "EventName": "L2_LD.SELF.PREFETCH.I_STATE",
         "SampleAfterValue": "200000",
@@ -257,7 +225,6 @@
     },
     {
         "BriefDescription": "L2 cache reads",
-        "Counter": "0,1",
         "EventCode": "0x29",
         "EventName": "L2_LD.SELF.PREFETCH.MESI",
         "SampleAfterValue": "200000",
@@ -265,7 +232,6 @@
     },
     {
         "BriefDescription": "L2 cache reads",
-        "Counter": "0,1",
         "EventCode": "0x29",
         "EventName": "L2_LD.SELF.PREFETCH.M_STATE",
         "SampleAfterValue": "200000",
@@ -273,7 +239,6 @@
     },
     {
         "BriefDescription": "L2 cache reads",
-        "Counter": "0,1",
         "EventCode": "0x29",
         "EventName": "L2_LD.SELF.PREFETCH.S_STATE",
         "SampleAfterValue": "200000",
@@ -281,7 +246,6 @@
     },
     {
         "BriefDescription": "All read requests from L1 instruction and data caches",
-        "Counter": "0,1",
         "EventCode": "0x2D",
         "EventName": "L2_LD_IFETCH.SELF.E_STATE",
         "SampleAfterValue": "200000",
@@ -289,7 +253,6 @@
     },
     {
         "BriefDescription": "All read requests from L1 instruction and data caches",
-        "Counter": "0,1",
         "EventCode": "0x2D",
         "EventName": "L2_LD_IFETCH.SELF.I_STATE",
         "SampleAfterValue": "200000",
@@ -297,7 +260,6 @@
     },
     {
         "BriefDescription": "All read requests from L1 instruction and data caches",
-        "Counter": "0,1",
         "EventCode": "0x2D",
         "EventName": "L2_LD_IFETCH.SELF.MESI",
         "SampleAfterValue": "200000",
@@ -305,7 +267,6 @@
     },
     {
         "BriefDescription": "All read requests from L1 instruction and data caches",
-        "Counter": "0,1",
         "EventCode": "0x2D",
         "EventName": "L2_LD_IFETCH.SELF.M_STATE",
         "SampleAfterValue": "200000",
@@ -313,7 +274,6 @@
     },
     {
         "BriefDescription": "All read requests from L1 instruction and data caches",
-        "Counter": "0,1",
         "EventCode": "0x2D",
         "EventName": "L2_LD_IFETCH.SELF.S_STATE",
         "SampleAfterValue": "200000",
@@ -321,7 +281,6 @@
     },
     {
         "BriefDescription": "L2 cache misses.",
-        "Counter": "0,1",
         "EventCode": "0x24",
         "EventName": "L2_LINES_IN.SELF.ANY",
         "SampleAfterValue": "200000",
@@ -329,7 +288,6 @@
     },
     {
         "BriefDescription": "L2 cache misses.",
-        "Counter": "0,1",
         "EventCode": "0x24",
         "EventName": "L2_LINES_IN.SELF.DEMAND",
         "SampleAfterValue": "200000",
@@ -337,7 +295,6 @@
     },
     {
         "BriefDescription": "L2 cache misses.",
-        "Counter": "0,1",
         "EventCode": "0x24",
         "EventName": "L2_LINES_IN.SELF.PREFETCH",
         "SampleAfterValue": "200000",
@@ -345,7 +302,6 @@
     },
     {
         "BriefDescription": "L2 cache lines evicted.",
-        "Counter": "0,1",
         "EventCode": "0x26",
         "EventName": "L2_LINES_OUT.SELF.ANY",
         "SampleAfterValue": "200000",
@@ -353,7 +309,6 @@
     },
     {
         "BriefDescription": "L2 cache lines evicted.",
-        "Counter": "0,1",
         "EventCode": "0x26",
         "EventName": "L2_LINES_OUT.SELF.DEMAND",
         "SampleAfterValue": "200000",
@@ -361,7 +316,6 @@
     },
     {
         "BriefDescription": "L2 cache lines evicted.",
-        "Counter": "0,1",
         "EventCode": "0x26",
         "EventName": "L2_LINES_OUT.SELF.PREFETCH",
         "SampleAfterValue": "200000",
@@ -369,7 +323,6 @@
     },
     {
         "BriefDescription": "L2 locked accesses",
-        "Counter": "0,1",
         "EventCode": "0x2B",
         "EventName": "L2_LOCK.SELF.E_STATE",
         "SampleAfterValue": "200000",
@@ -377,7 +330,6 @@
     },
     {
         "BriefDescription": "L2 locked accesses",
-        "Counter": "0,1",
         "EventCode": "0x2B",
         "EventName": "L2_LOCK.SELF.I_STATE",
         "SampleAfterValue": "200000",
@@ -385,7 +337,6 @@
     },
     {
         "BriefDescription": "L2 locked accesses",
-        "Counter": "0,1",
         "EventCode": "0x2B",
         "EventName": "L2_LOCK.SELF.MESI",
         "SampleAfterValue": "200000",
@@ -393,7 +344,6 @@
     },
     {
         "BriefDescription": "L2 locked accesses",
-        "Counter": "0,1",
         "EventCode": "0x2B",
         "EventName": "L2_LOCK.SELF.M_STATE",
         "SampleAfterValue": "200000",
@@ -401,7 +351,6 @@
     },
     {
         "BriefDescription": "L2 locked accesses",
-        "Counter": "0,1",
         "EventCode": "0x2B",
         "EventName": "L2_LOCK.SELF.S_STATE",
         "SampleAfterValue": "200000",
@@ -409,7 +358,6 @@
     },
     {
         "BriefDescription": "L2 cache line modifications.",
-        "Counter": "0,1",
         "EventCode": "0x25",
         "EventName": "L2_M_LINES_IN.SELF",
         "SampleAfterValue": "200000",
@@ -417,7 +365,6 @@
     },
     {
         "BriefDescription": "Modified lines evicted from the L2 cache",
-        "Counter": "0,1",
         "EventCode": "0x27",
         "EventName": "L2_M_LINES_OUT.SELF.ANY",
         "SampleAfterValue": "200000",
@@ -425,7 +372,6 @@
     },
     {
         "BriefDescription": "Modified lines evicted from the L2 cache",
-        "Counter": "0,1",
         "EventCode": "0x27",
         "EventName": "L2_M_LINES_OUT.SELF.DEMAND",
         "SampleAfterValue": "200000",
@@ -433,7 +379,6 @@
     },
     {
         "BriefDescription": "Modified lines evicted from the L2 cache",
-        "Counter": "0,1",
         "EventCode": "0x27",
         "EventName": "L2_M_LINES_OUT.SELF.PREFETCH",
         "SampleAfterValue": "200000",
@@ -441,7 +386,6 @@
     },
     {
         "BriefDescription": "Cycles no L2 cache requests are pending",
-        "Counter": "0,1",
         "EventCode": "0x32",
         "EventName": "L2_NO_REQ.SELF",
         "SampleAfterValue": "200000",
@@ -449,7 +393,6 @@
     },
     {
         "BriefDescription": "Rejected L2 cache requests",
-        "Counter": "0,1",
         "EventCode": "0x30",
         "EventName": "L2_REJECT_BUSQ.SELF.ANY.E_STATE",
         "SampleAfterValue": "200000",
@@ -457,7 +400,6 @@
     },
     {
         "BriefDescription": "Rejected L2 cache requests",
-        "Counter": "0,1",
         "EventCode": "0x30",
         "EventName": "L2_REJECT_BUSQ.SELF.ANY.I_STATE",
         "SampleAfterValue": "200000",
@@ -465,7 +407,6 @@
     },
     {
         "BriefDescription": "Rejected L2 cache requests",
-        "Counter": "0,1",
         "EventCode": "0x30",
         "EventName": "L2_REJECT_BUSQ.SELF.ANY.MESI",
         "SampleAfterValue": "200000",
@@ -473,7 +414,6 @@
     },
     {
         "BriefDescription": "Rejected L2 cache requests",
-        "Counter": "0,1",
         "EventCode": "0x30",
         "EventName": "L2_REJECT_BUSQ.SELF.ANY.M_STATE",
         "SampleAfterValue": "200000",
@@ -481,7 +421,6 @@
     },
     {
         "BriefDescription": "Rejected L2 cache requests",
-        "Counter": "0,1",
         "EventCode": "0x30",
         "EventName": "L2_REJECT_BUSQ.SELF.ANY.S_STATE",
         "SampleAfterValue": "200000",
@@ -489,7 +428,6 @@
     },
     {
         "BriefDescription": "Rejected L2 cache requests",
-        "Counter": "0,1",
         "EventCode": "0x30",
         "EventName": "L2_REJECT_BUSQ.SELF.DEMAND.E_STATE",
         "SampleAfterValue": "200000",
@@ -497,7 +435,6 @@
     },
     {
         "BriefDescription": "Rejected L2 cache requests",
-        "Counter": "0,1",
         "EventCode": "0x30",
         "EventName": "L2_REJECT_BUSQ.SELF.DEMAND.I_STATE",
         "SampleAfterValue": "200000",
@@ -505,7 +442,6 @@
     },
     {
         "BriefDescription": "Rejected L2 cache requests",
-        "Counter": "0,1",
         "EventCode": "0x30",
         "EventName": "L2_REJECT_BUSQ.SELF.DEMAND.MESI",
         "SampleAfterValue": "200000",
@@ -513,7 +449,6 @@
     },
     {
         "BriefDescription": "Rejected L2 cache requests",
-        "Counter": "0,1",
         "EventCode": "0x30",
         "EventName": "L2_REJECT_BUSQ.SELF.DEMAND.M_STATE",
         "SampleAfterValue": "200000",
@@ -521,7 +456,6 @@
     },
     {
         "BriefDescription": "Rejected L2 cache requests",
-        "Counter": "0,1",
         "EventCode": "0x30",
         "EventName": "L2_REJECT_BUSQ.SELF.DEMAND.S_STATE",
         "SampleAfterValue": "200000",
@@ -529,7 +463,6 @@
     },
     {
         "BriefDescription": "Rejected L2 cache requests",
-        "Counter": "0,1",
         "EventCode": "0x30",
         "EventName": "L2_REJECT_BUSQ.SELF.PREFETCH.E_STATE",
         "SampleAfterValue": "200000",
@@ -537,7 +470,6 @@
     },
     {
         "BriefDescription": "Rejected L2 cache requests",
-        "Counter": "0,1",
         "EventCode": "0x30",
         "EventName": "L2_REJECT_BUSQ.SELF.PREFETCH.I_STATE",
         "SampleAfterValue": "200000",
@@ -545,7 +477,6 @@
     },
     {
         "BriefDescription": "Rejected L2 cache requests",
-        "Counter": "0,1",
         "EventCode": "0x30",
         "EventName": "L2_REJECT_BUSQ.SELF.PREFETCH.MESI",
         "SampleAfterValue": "200000",
@@ -553,7 +484,6 @@
     },
     {
         "BriefDescription": "Rejected L2 cache requests",
-        "Counter": "0,1",
         "EventCode": "0x30",
         "EventName": "L2_REJECT_BUSQ.SELF.PREFETCH.M_STATE",
         "SampleAfterValue": "200000",
@@ -561,7 +491,6 @@
     },
     {
         "BriefDescription": "Rejected L2 cache requests",
-        "Counter": "0,1",
         "EventCode": "0x30",
         "EventName": "L2_REJECT_BUSQ.SELF.PREFETCH.S_STATE",
         "SampleAfterValue": "200000",
@@ -569,7 +498,6 @@
     },
     {
         "BriefDescription": "L2 cache requests",
-        "Counter": "0,1",
         "EventCode": "0x2E",
         "EventName": "L2_RQSTS.SELF.ANY.E_STATE",
         "SampleAfterValue": "200000",
@@ -577,7 +505,6 @@
     },
     {
         "BriefDescription": "L2 cache requests",
-        "Counter": "0,1",
         "EventCode": "0x2E",
         "EventName": "L2_RQSTS.SELF.ANY.I_STATE",
         "SampleAfterValue": "200000",
@@ -585,7 +512,6 @@
     },
     {
         "BriefDescription": "L2 cache requests",
-        "Counter": "0,1",
         "EventCode": "0x2E",
         "EventName": "L2_RQSTS.SELF.ANY.MESI",
         "SampleAfterValue": "200000",
@@ -593,7 +519,6 @@
     },
     {
         "BriefDescription": "L2 cache requests",
-        "Counter": "0,1",
         "EventCode": "0x2E",
         "EventName": "L2_RQSTS.SELF.ANY.M_STATE",
         "SampleAfterValue": "200000",
@@ -601,7 +526,6 @@
     },
     {
         "BriefDescription": "L2 cache requests",
-        "Counter": "0,1",
         "EventCode": "0x2E",
         "EventName": "L2_RQSTS.SELF.ANY.S_STATE",
         "SampleAfterValue": "200000",
@@ -609,7 +533,6 @@
     },
     {
         "BriefDescription": "L2 cache requests",
-        "Counter": "0,1",
         "EventCode": "0x2E",
         "EventName": "L2_RQSTS.SELF.DEMAND.E_STATE",
         "SampleAfterValue": "200000",
@@ -617,7 +540,6 @@
     },
     {
         "BriefDescription": "L2 cache demand requests from this core that missed the L2",
-        "Counter": "0,1",
         "EventCode": "0x2E",
         "EventName": "L2_RQSTS.SELF.DEMAND.I_STATE",
         "SampleAfterValue": "200000",
@@ -625,7 +547,6 @@
     },
     {
         "BriefDescription": "L2 cache demand requests from this core",
-        "Counter": "0,1",
         "EventCode": "0x2E",
         "EventName": "L2_RQSTS.SELF.DEMAND.MESI",
         "SampleAfterValue": "200000",
@@ -633,7 +554,6 @@
     },
     {
         "BriefDescription": "L2 cache requests",
-        "Counter": "0,1",
         "EventCode": "0x2E",
         "EventName": "L2_RQSTS.SELF.DEMAND.M_STATE",
         "SampleAfterValue": "200000",
@@ -641,7 +561,6 @@
     },
     {
         "BriefDescription": "L2 cache requests",
-        "Counter": "0,1",
         "EventCode": "0x2E",
         "EventName": "L2_RQSTS.SELF.DEMAND.S_STATE",
         "SampleAfterValue": "200000",
@@ -649,7 +568,6 @@
     },
     {
         "BriefDescription": "L2 cache requests",
-        "Counter": "0,1",
         "EventCode": "0x2E",
         "EventName": "L2_RQSTS.SELF.PREFETCH.E_STATE",
         "SampleAfterValue": "200000",
@@ -657,7 +575,6 @@
     },
     {
         "BriefDescription": "L2 cache requests",
-        "Counter": "0,1",
         "EventCode": "0x2E",
         "EventName": "L2_RQSTS.SELF.PREFETCH.I_STATE",
         "SampleAfterValue": "200000",
@@ -665,7 +582,6 @@
     },
     {
         "BriefDescription": "L2 cache requests",
-        "Counter": "0,1",
         "EventCode": "0x2E",
         "EventName": "L2_RQSTS.SELF.PREFETCH.MESI",
         "SampleAfterValue": "200000",
@@ -673,7 +589,6 @@
     },
     {
         "BriefDescription": "L2 cache requests",
-        "Counter": "0,1",
         "EventCode": "0x2E",
         "EventName": "L2_RQSTS.SELF.PREFETCH.M_STATE",
         "SampleAfterValue": "200000",
@@ -681,7 +596,6 @@
     },
     {
         "BriefDescription": "L2 cache requests",
-        "Counter": "0,1",
         "EventCode": "0x2E",
         "EventName": "L2_RQSTS.SELF.PREFETCH.S_STATE",
         "SampleAfterValue": "200000",
@@ -689,7 +603,6 @@
     },
     {
         "BriefDescription": "L2 store requests",
-        "Counter": "0,1",
         "EventCode": "0x2A",
         "EventName": "L2_ST.SELF.E_STATE",
         "SampleAfterValue": "200000",
@@ -697,7 +610,6 @@
     },
     {
         "BriefDescription": "L2 store requests",
-        "Counter": "0,1",
         "EventCode": "0x2A",
         "EventName": "L2_ST.SELF.I_STATE",
         "SampleAfterValue": "200000",
@@ -705,7 +617,6 @@
     },
     {
         "BriefDescription": "L2 store requests",
-        "Counter": "0,1",
         "EventCode": "0x2A",
         "EventName": "L2_ST.SELF.MESI",
         "SampleAfterValue": "200000",
@@ -713,7 +624,6 @@
     },
     {
         "BriefDescription": "L2 store requests",
-        "Counter": "0,1",
         "EventCode": "0x2A",
         "EventName": "L2_ST.SELF.M_STATE",
         "SampleAfterValue": "200000",
@@ -721,7 +631,6 @@
     },
     {
         "BriefDescription": "L2 store requests",
-        "Counter": "0,1",
         "EventCode": "0x2A",
         "EventName": "L2_ST.SELF.S_STATE",
         "SampleAfterValue": "200000",
@@ -729,7 +638,6 @@
     },
     {
         "BriefDescription": "Retired loads that hit the L2 cache (precise event).",
-        "Counter": "0,1",
         "EventCode": "0xCB",
         "EventName": "MEM_LOAD_RETIRED.L2_HIT",
         "SampleAfterValue": "200000",
@@ -737,7 +645,6 @@
     },
     {
         "BriefDescription": "Retired loads that miss the L2 cache",
-        "Counter": "0,1",
         "EventCode": "0xCB",
         "EventName": "MEM_LOAD_RETIRED.L2_MISS",
         "SampleAfterValue": "10000",
diff --git a/tools/perf/pmu-events/arch/x86/bonnell/floating-point.json b/tools/perf/pmu-events/arch/x86/bonnell/floating-point.json
index 1fa347d07c98..18bf5ec47e72 100644
--- a/tools/perf/pmu-events/arch/x86/bonnell/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/bonnell/floating-point.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "Floating point assists for retired operations.",
-        "Counter": "0,1",
         "EventCode": "0x11",
         "EventName": "FP_ASSIST.AR",
         "SampleAfterValue": "10000",
@@ -9,7 +8,6 @@
     },
     {
         "BriefDescription": "Floating point assists.",
-        "Counter": "0,1",
         "EventCode": "0x11",
         "EventName": "FP_ASSIST.S",
         "SampleAfterValue": "10000",
@@ -17,15 +15,12 @@
     },
     {
         "BriefDescription": "SIMD assists invoked.",
-        "Counter": "0,1",
         "EventCode": "0xCD",
         "EventName": "SIMD_ASSIST",
-        "SampleAfterValue": "100000",
-        "UMask": "0x0"
+        "SampleAfterValue": "100000"
     },
     {
         "BriefDescription": "Retired computational Streaming SIMD Extensions (SSE) packed-single instructions.",
-        "Counter": "0,1",
         "EventCode": "0xCA",
         "EventName": "SIMD_COMP_INST_RETIRED.PACKED_SINGLE",
         "SampleAfterValue": "2000000",
@@ -33,7 +28,6 @@
     },
     {
         "BriefDescription": "Retired computational Streaming SIMD Extensions 2 (SSE2) scalar-double instructions.",
-        "Counter": "0,1",
         "EventCode": "0xCA",
         "EventName": "SIMD_COMP_INST_RETIRED.SCALAR_DOUBLE",
         "SampleAfterValue": "2000000",
@@ -41,7 +35,6 @@
     },
     {
         "BriefDescription": "Retired computational Streaming SIMD Extensions (SSE) scalar-single instructions.",
-        "Counter": "0,1",
         "EventCode": "0xCA",
         "EventName": "SIMD_COMP_INST_RETIRED.SCALAR_SINGLE",
         "SampleAfterValue": "2000000",
@@ -49,15 +42,12 @@
     },
     {
         "BriefDescription": "SIMD Instructions retired.",
-        "Counter": "0,1",
         "EventCode": "0xCE",
         "EventName": "SIMD_INSTR_RETIRED",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x0"
+        "SampleAfterValue": "2000000"
     },
     {
         "BriefDescription": "Retired Streaming SIMD Extensions (SSE) packed-single instructions.",
-        "Counter": "0,1",
         "EventCode": "0xC7",
         "EventName": "SIMD_INST_RETIRED.PACKED_SINGLE",
         "SampleAfterValue": "2000000",
@@ -65,7 +55,6 @@
     },
     {
         "BriefDescription": "Retired Streaming SIMD Extensions 2 (SSE2) scalar-double instructions.",
-        "Counter": "0,1",
         "EventCode": "0xC7",
         "EventName": "SIMD_INST_RETIRED.SCALAR_DOUBLE",
         "SampleAfterValue": "2000000",
@@ -73,7 +62,6 @@
     },
     {
         "BriefDescription": "Retired Streaming SIMD Extensions (SSE) scalar-single instructions.",
-        "Counter": "0,1",
         "EventCode": "0xC7",
         "EventName": "SIMD_INST_RETIRED.SCALAR_SINGLE",
         "SampleAfterValue": "2000000",
@@ -81,7 +69,6 @@
     },
     {
         "BriefDescription": "Retired Streaming SIMD Extensions 2 (SSE2) vector instructions.",
-        "Counter": "0,1",
         "EventCode": "0xC7",
         "EventName": "SIMD_INST_RETIRED.VECTOR",
         "SampleAfterValue": "2000000",
@@ -89,15 +76,12 @@
     },
     {
         "BriefDescription": "Saturated arithmetic instructions retired.",
-        "Counter": "0,1",
         "EventCode": "0xCF",
         "EventName": "SIMD_SAT_INSTR_RETIRED",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x0"
+        "SampleAfterValue": "2000000"
     },
     {
         "BriefDescription": "SIMD saturated arithmetic micro-ops retired.",
-        "Counter": "0,1",
         "EventCode": "0xB1",
         "EventName": "SIMD_SAT_UOP_EXEC.AR",
         "SampleAfterValue": "2000000",
@@ -105,15 +89,12 @@
     },
     {
         "BriefDescription": "SIMD saturated arithmetic micro-ops executed.",
-        "Counter": "0,1",
         "EventCode": "0xB1",
         "EventName": "SIMD_SAT_UOP_EXEC.S",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x0"
+        "SampleAfterValue": "2000000"
     },
     {
         "BriefDescription": "SIMD micro-ops retired (excluding stores).",
-        "Counter": "0,1",
         "EventCode": "0xB0",
         "EventName": "SIMD_UOPS_EXEC.AR",
         "PEBS": "2",
@@ -122,15 +103,12 @@
     },
     {
         "BriefDescription": "SIMD micro-ops executed (excluding stores).",
-        "Counter": "0,1",
         "EventCode": "0xB0",
         "EventName": "SIMD_UOPS_EXEC.S",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x0"
+        "SampleAfterValue": "2000000"
     },
     {
         "BriefDescription": "SIMD packed arithmetic micro-ops retired",
-        "Counter": "0,1",
         "EventCode": "0xB3",
         "EventName": "SIMD_UOP_TYPE_EXEC.ARITHMETIC.AR",
         "SampleAfterValue": "2000000",
@@ -138,7 +116,6 @@
     },
     {
         "BriefDescription": "SIMD packed arithmetic micro-ops executed",
-        "Counter": "0,1",
         "EventCode": "0xB3",
         "EventName": "SIMD_UOP_TYPE_EXEC.ARITHMETIC.S",
         "SampleAfterValue": "2000000",
@@ -146,7 +123,6 @@
     },
     {
         "BriefDescription": "SIMD packed logical micro-ops retired",
-        "Counter": "0,1",
         "EventCode": "0xB3",
         "EventName": "SIMD_UOP_TYPE_EXEC.LOGICAL.AR",
         "SampleAfterValue": "2000000",
@@ -154,7 +130,6 @@
     },
     {
         "BriefDescription": "SIMD packed logical micro-ops executed",
-        "Counter": "0,1",
         "EventCode": "0xB3",
         "EventName": "SIMD_UOP_TYPE_EXEC.LOGICAL.S",
         "SampleAfterValue": "2000000",
@@ -162,7 +137,6 @@
     },
     {
         "BriefDescription": "SIMD packed multiply micro-ops retired",
-        "Counter": "0,1",
         "EventCode": "0xB3",
         "EventName": "SIMD_UOP_TYPE_EXEC.MUL.AR",
         "SampleAfterValue": "2000000",
@@ -170,7 +144,6 @@
     },
     {
         "BriefDescription": "SIMD packed multiply micro-ops executed",
-        "Counter": "0,1",
         "EventCode": "0xB3",
         "EventName": "SIMD_UOP_TYPE_EXEC.MUL.S",
         "SampleAfterValue": "2000000",
@@ -178,7 +151,6 @@
     },
     {
         "BriefDescription": "SIMD packed micro-ops retired",
-        "Counter": "0,1",
         "EventCode": "0xB3",
         "EventName": "SIMD_UOP_TYPE_EXEC.PACK.AR",
         "SampleAfterValue": "2000000",
@@ -186,7 +158,6 @@
     },
     {
         "BriefDescription": "SIMD packed micro-ops executed",
-        "Counter": "0,1",
         "EventCode": "0xB3",
         "EventName": "SIMD_UOP_TYPE_EXEC.PACK.S",
         "SampleAfterValue": "2000000",
@@ -194,7 +165,6 @@
     },
     {
         "BriefDescription": "SIMD packed shift micro-ops retired",
-        "Counter": "0,1",
         "EventCode": "0xB3",
         "EventName": "SIMD_UOP_TYPE_EXEC.SHIFT.AR",
         "SampleAfterValue": "2000000",
@@ -202,7 +172,6 @@
     },
     {
         "BriefDescription": "SIMD packed shift micro-ops executed",
-        "Counter": "0,1",
         "EventCode": "0xB3",
         "EventName": "SIMD_UOP_TYPE_EXEC.SHIFT.S",
         "SampleAfterValue": "2000000",
@@ -210,7 +179,6 @@
     },
     {
         "BriefDescription": "SIMD unpacked micro-ops retired",
-        "Counter": "0,1",
         "EventCode": "0xB3",
         "EventName": "SIMD_UOP_TYPE_EXEC.UNPACK.AR",
         "SampleAfterValue": "2000000",
@@ -218,7 +186,6 @@
     },
     {
         "BriefDescription": "SIMD unpacked micro-ops executed",
-        "Counter": "0,1",
         "EventCode": "0xB3",
         "EventName": "SIMD_UOP_TYPE_EXEC.UNPACK.S",
         "SampleAfterValue": "2000000",
@@ -226,7 +193,6 @@
     },
     {
         "BriefDescription": "Floating point computational micro-ops retired.",
-        "Counter": "0,1",
         "EventCode": "0x10",
         "EventName": "X87_COMP_OPS_EXE.ANY.AR",
         "PEBS": "2",
@@ -235,7 +201,6 @@
     },
     {
         "BriefDescription": "Floating point computational micro-ops executed.",
-        "Counter": "0,1",
         "EventCode": "0x10",
         "EventName": "X87_COMP_OPS_EXE.ANY.S",
         "SampleAfterValue": "2000000",
@@ -243,7 +208,6 @@
     },
     {
         "BriefDescription": "FXCH uops retired.",
-        "Counter": "0,1",
         "EventCode": "0x10",
         "EventName": "X87_COMP_OPS_EXE.FXCH.AR",
         "PEBS": "2",
@@ -252,7 +216,6 @@
     },
     {
         "BriefDescription": "FXCH uops executed.",
-        "Counter": "0,1",
         "EventCode": "0x10",
         "EventName": "X87_COMP_OPS_EXE.FXCH.S",
         "SampleAfterValue": "2000000",
diff --git a/tools/perf/pmu-events/arch/x86/bonnell/frontend.json b/tools/perf/pmu-events/arch/x86/bonnell/frontend.json
index 21fe5fe229aa..8d2f4edfb597 100644
--- a/tools/perf/pmu-events/arch/x86/bonnell/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/bonnell/frontend.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "BACLEARS asserted.",
-        "Counter": "0,1",
         "EventCode": "0xE6",
         "EventName": "BACLEARS.ANY",
         "SampleAfterValue": "2000000",
@@ -9,7 +8,6 @@
     },
     {
         "BriefDescription": "Cycles during which instruction fetches are  stalled.",
-        "Counter": "0,1",
         "EventCode": "0x86",
         "EventName": "CYCLES_ICACHE_MEM_STALLED.ICACHE_MEM_STALLED",
         "SampleAfterValue": "2000000",
@@ -17,7 +15,6 @@
     },
     {
         "BriefDescription": "Decode stall due to IQ full",
-        "Counter": "0,1",
         "EventCode": "0x87",
         "EventName": "DECODE_STALL.IQ_FULL",
         "SampleAfterValue": "2000000",
@@ -25,7 +22,6 @@
     },
     {
         "BriefDescription": "Decode stall due to PFB empty",
-        "Counter": "0,1",
         "EventCode": "0x87",
         "EventName": "DECODE_STALL.PFB_EMPTY",
         "SampleAfterValue": "2000000",
@@ -33,7 +29,6 @@
     },
     {
         "BriefDescription": "Instruction fetches.",
-        "Counter": "0,1",
         "EventCode": "0x80",
         "EventName": "ICACHE.ACCESSES",
         "SampleAfterValue": "200000",
@@ -41,7 +36,6 @@
     },
     {
         "BriefDescription": "Icache hit",
-        "Counter": "0,1",
         "EventCode": "0x80",
         "EventName": "ICACHE.HIT",
         "SampleAfterValue": "200000",
@@ -49,7 +43,6 @@
     },
     {
         "BriefDescription": "Icache miss",
-        "Counter": "0,1",
         "EventCode": "0x80",
         "EventName": "ICACHE.MISSES",
         "SampleAfterValue": "200000",
@@ -57,7 +50,6 @@
     },
     {
         "BriefDescription": "All Instructions decoded",
-        "Counter": "0,1",
         "EventCode": "0xAA",
         "EventName": "MACRO_INSTS.ALL_DECODED",
         "SampleAfterValue": "2000000",
@@ -65,7 +57,6 @@
     },
     {
         "BriefDescription": "CISC macro instructions decoded",
-        "Counter": "0,1",
         "EventCode": "0xAA",
         "EventName": "MACRO_INSTS.CISC_DECODED",
         "SampleAfterValue": "2000000",
@@ -73,7 +64,6 @@
     },
     {
         "BriefDescription": "Non-CISC nacro instructions decoded",
-        "Counter": "0,1",
         "EventCode": "0xAA",
         "EventName": "MACRO_INSTS.NON_CISC_DECODED",
         "SampleAfterValue": "2000000",
@@ -81,7 +71,6 @@
     },
     {
         "BriefDescription": "This event counts the cycles where 1 or more uops are issued by the micro-sequencer (MS), including microcode assists and inserted flows, and written to the IQ.",
-        "Counter": "0,1",
         "CounterMask": "1",
         "EventCode": "0xA9",
         "EventName": "UOPS.MS_CYCLES",
diff --git a/tools/perf/pmu-events/arch/x86/bonnell/memory.json b/tools/perf/pmu-events/arch/x86/bonnell/memory.json
index f8b45b6fb4d3..ac02dc2482c8 100644
--- a/tools/perf/pmu-events/arch/x86/bonnell/memory.json
+++ b/tools/perf/pmu-events/arch/x86/bonnell/memory.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "Nonzero segbase 1 bubble",
-        "Counter": "0,1",
         "EventCode": "0x5",
         "EventName": "MISALIGN_MEM_REF.BUBBLE",
         "SampleAfterValue": "200000",
@@ -9,7 +8,6 @@
     },
     {
         "BriefDescription": "Nonzero segbase load 1 bubble",
-        "Counter": "0,1",
         "EventCode": "0x5",
         "EventName": "MISALIGN_MEM_REF.LD_BUBBLE",
         "SampleAfterValue": "200000",
@@ -17,7 +15,6 @@
     },
     {
         "BriefDescription": "Load splits",
-        "Counter": "0,1",
         "EventCode": "0x5",
         "EventName": "MISALIGN_MEM_REF.LD_SPLIT",
         "SampleAfterValue": "200000",
@@ -25,7 +22,6 @@
     },
     {
         "BriefDescription": "Load splits (At Retirement)",
-        "Counter": "0,1",
         "EventCode": "0x5",
         "EventName": "MISALIGN_MEM_REF.LD_SPLIT.AR",
         "SampleAfterValue": "200000",
@@ -33,7 +29,6 @@
     },
     {
         "BriefDescription": "Nonzero segbase ld-op-st 1 bubble",
-        "Counter": "0,1",
         "EventCode": "0x5",
         "EventName": "MISALIGN_MEM_REF.RMW_BUBBLE",
         "SampleAfterValue": "200000",
@@ -41,7 +36,6 @@
     },
     {
         "BriefDescription": "ld-op-st splits",
-        "Counter": "0,1",
         "EventCode": "0x5",
         "EventName": "MISALIGN_MEM_REF.RMW_SPLIT",
         "SampleAfterValue": "200000",
@@ -49,7 +43,6 @@
     },
     {
         "BriefDescription": "Memory references that cross an 8-byte boundary.",
-        "Counter": "0,1",
         "EventCode": "0x5",
         "EventName": "MISALIGN_MEM_REF.SPLIT",
         "SampleAfterValue": "200000",
@@ -57,7 +50,6 @@
     },
     {
         "BriefDescription": "Memory references that cross an 8-byte boundary (At Retirement)",
-        "Counter": "0,1",
         "EventCode": "0x5",
         "EventName": "MISALIGN_MEM_REF.SPLIT.AR",
         "SampleAfterValue": "200000",
@@ -65,7 +57,6 @@
     },
     {
         "BriefDescription": "Nonzero segbase store 1 bubble",
-        "Counter": "0,1",
         "EventCode": "0x5",
         "EventName": "MISALIGN_MEM_REF.ST_BUBBLE",
         "SampleAfterValue": "200000",
@@ -73,7 +64,6 @@
     },
     {
         "BriefDescription": "Store splits",
-        "Counter": "0,1",
         "EventCode": "0x5",
         "EventName": "MISALIGN_MEM_REF.ST_SPLIT",
         "SampleAfterValue": "200000",
@@ -81,7 +71,6 @@
     },
     {
         "BriefDescription": "Store splits (Ar Retirement)",
-        "Counter": "0,1",
         "EventCode": "0x5",
         "EventName": "MISALIGN_MEM_REF.ST_SPLIT.AR",
         "SampleAfterValue": "200000",
@@ -89,7 +78,6 @@
     },
     {
         "BriefDescription": "L1 hardware prefetch request",
-        "Counter": "0,1",
         "EventCode": "0x7",
         "EventName": "PREFETCH.HW_PREFETCH",
         "SampleAfterValue": "2000000",
@@ -97,7 +85,6 @@
     },
     {
         "BriefDescription": "Streaming SIMD Extensions (SSE) Prefetch NTA instructions executed",
-        "Counter": "0,1",
         "EventCode": "0x7",
         "EventName": "PREFETCH.PREFETCHNTA",
         "SampleAfterValue": "200000",
@@ -105,7 +92,6 @@
     },
     {
         "BriefDescription": "Streaming SIMD Extensions (SSE) PrefetchT0 instructions executed.",
-        "Counter": "0,1",
         "EventCode": "0x7",
         "EventName": "PREFETCH.PREFETCHT0",
         "SampleAfterValue": "200000",
@@ -113,7 +99,6 @@
     },
     {
         "BriefDescription": "Streaming SIMD Extensions (SSE) PrefetchT1 instructions executed.",
-        "Counter": "0,1",
         "EventCode": "0x7",
         "EventName": "PREFETCH.PREFETCHT1",
         "SampleAfterValue": "200000",
@@ -121,7 +106,6 @@
     },
     {
         "BriefDescription": "Streaming SIMD Extensions (SSE) PrefetchT2 instructions executed.",
-        "Counter": "0,1",
         "EventCode": "0x7",
         "EventName": "PREFETCH.PREFETCHT2",
         "SampleAfterValue": "200000",
@@ -129,7 +113,6 @@
     },
     {
         "BriefDescription": "Any Software prefetch",
-        "Counter": "0,1",
         "EventCode": "0x7",
         "EventName": "PREFETCH.SOFTWARE_PREFETCH",
         "SampleAfterValue": "200000",
@@ -137,7 +120,6 @@
     },
     {
         "BriefDescription": "Any Software prefetch",
-        "Counter": "0,1",
         "EventCode": "0x7",
         "EventName": "PREFETCH.SOFTWARE_PREFETCH.AR",
         "SampleAfterValue": "200000",
@@ -145,7 +127,6 @@
     },
     {
         "BriefDescription": "Streaming SIMD Extensions (SSE) PrefetchT1 and PrefetchT2 instructions executed",
-        "Counter": "0,1",
         "EventCode": "0x7",
         "EventName": "PREFETCH.SW_L2",
         "SampleAfterValue": "200000",
diff --git a/tools/perf/pmu-events/arch/x86/bonnell/other.json b/tools/perf/pmu-events/arch/x86/bonnell/other.json
index e0bdcfbfa9dc..782594c8bda5 100644
--- a/tools/perf/pmu-events/arch/x86/bonnell/other.json
+++ b/tools/perf/pmu-events/arch/x86/bonnell/other.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "Bus queue is empty.",
-        "Counter": "0,1",
         "EventCode": "0x7D",
         "EventName": "BUSQ_EMPTY.SELF",
         "SampleAfterValue": "200000",
@@ -9,7 +8,6 @@
     },
     {
         "BriefDescription": "Number of Bus Not Ready signals asserted.",
-        "Counter": "0,1",
         "EventCode": "0x61",
         "EventName": "BUS_BNR_DRV.ALL_AGENTS",
         "SampleAfterValue": "200000",
@@ -17,15 +15,12 @@
     },
     {
         "BriefDescription": "Number of Bus Not Ready signals asserted.",
-        "Counter": "0,1",
         "EventCode": "0x61",
         "EventName": "BUS_BNR_DRV.THIS_AGENT",
-        "SampleAfterValue": "200000",
-        "UMask": "0x0"
+        "SampleAfterValue": "200000"
     },
     {
         "BriefDescription": "Bus cycles while processor receives data.",
-        "Counter": "0,1",
         "EventCode": "0x64",
         "EventName": "BUS_DATA_RCV.SELF",
         "SampleAfterValue": "200000",
@@ -33,7 +28,6 @@
     },
     {
         "BriefDescription": "Bus cycles when data is sent on the bus.",
-        "Counter": "0,1",
         "EventCode": "0x62",
         "EventName": "BUS_DRDY_CLOCKS.ALL_AGENTS",
         "SampleAfterValue": "200000",
@@ -41,15 +35,12 @@
     },
     {
         "BriefDescription": "Bus cycles when data is sent on the bus.",
-        "Counter": "0,1",
         "EventCode": "0x62",
         "EventName": "BUS_DRDY_CLOCKS.THIS_AGENT",
-        "SampleAfterValue": "200000",
-        "UMask": "0x0"
+        "SampleAfterValue": "200000"
     },
     {
         "BriefDescription": "HITM signal asserted.",
-        "Counter": "0,1",
         "EventCode": "0x7B",
         "EventName": "BUS_HITM_DRV.ALL_AGENTS",
         "SampleAfterValue": "200000",
@@ -57,15 +48,12 @@
     },
     {
         "BriefDescription": "HITM signal asserted.",
-        "Counter": "0,1",
         "EventCode": "0x7B",
         "EventName": "BUS_HITM_DRV.THIS_AGENT",
-        "SampleAfterValue": "200000",
-        "UMask": "0x0"
+        "SampleAfterValue": "200000"
     },
     {
         "BriefDescription": "HIT signal asserted.",
-        "Counter": "0,1",
         "EventCode": "0x7A",
         "EventName": "BUS_HIT_DRV.ALL_AGENTS",
         "SampleAfterValue": "200000",
@@ -73,15 +61,12 @@
     },
     {
         "BriefDescription": "HIT signal asserted.",
-        "Counter": "0,1",
         "EventCode": "0x7A",
         "EventName": "BUS_HIT_DRV.THIS_AGENT",
-        "SampleAfterValue": "200000",
-        "UMask": "0x0"
+        "SampleAfterValue": "200000"
     },
     {
         "BriefDescription": "IO requests waiting in the bus queue.",
-        "Counter": "0,1",
         "EventCode": "0x7F",
         "EventName": "BUS_IO_WAIT.SELF",
         "SampleAfterValue": "200000",
@@ -89,7 +74,6 @@
     },
     {
         "BriefDescription": "Bus cycles when a LOCK signal is asserted.",
-        "Counter": "0,1",
         "EventCode": "0x63",
         "EventName": "BUS_LOCK_CLOCKS.ALL_AGENTS",
         "SampleAfterValue": "200000",
@@ -97,7 +81,6 @@
     },
     {
         "BriefDescription": "Bus cycles when a LOCK signal is asserted.",
-        "Counter": "0,1",
         "EventCode": "0x63",
         "EventName": "BUS_LOCK_CLOCKS.SELF",
         "SampleAfterValue": "200000",
@@ -105,7 +88,6 @@
     },
     {
         "BriefDescription": "Outstanding cacheable data read bus requests duration.",
-        "Counter": "0,1",
         "EventCode": "0x60",
         "EventName": "BUS_REQUEST_OUTSTANDING.ALL_AGENTS",
         "SampleAfterValue": "200000",
@@ -113,7 +95,6 @@
     },
     {
         "BriefDescription": "Outstanding cacheable data read bus requests duration.",
-        "Counter": "0,1",
         "EventCode": "0x60",
         "EventName": "BUS_REQUEST_OUTSTANDING.SELF",
         "SampleAfterValue": "200000",
@@ -121,7 +102,6 @@
     },
     {
         "BriefDescription": "All bus transactions.",
-        "Counter": "0,1",
         "EventCode": "0x70",
         "EventName": "BUS_TRANS_ANY.ALL_AGENTS",
         "SampleAfterValue": "200000",
@@ -129,7 +109,6 @@
     },
     {
         "BriefDescription": "All bus transactions.",
-        "Counter": "0,1",
         "EventCode": "0x70",
         "EventName": "BUS_TRANS_ANY.SELF",
         "SampleAfterValue": "200000",
@@ -137,7 +116,6 @@
     },
     {
         "BriefDescription": "Burst read bus transactions.",
-        "Counter": "0,1",
         "EventCode": "0x65",
         "EventName": "BUS_TRANS_BRD.ALL_AGENTS",
         "SampleAfterValue": "200000",
@@ -145,7 +123,6 @@
     },
     {
         "BriefDescription": "Burst read bus transactions.",
-        "Counter": "0,1",
         "EventCode": "0x65",
         "EventName": "BUS_TRANS_BRD.SELF",
         "SampleAfterValue": "200000",
@@ -153,7 +130,6 @@
     },
     {
         "BriefDescription": "Burst (full cache-line) bus transactions.",
-        "Counter": "0,1",
         "EventCode": "0x6E",
         "EventName": "BUS_TRANS_BURST.ALL_AGENTS",
         "SampleAfterValue": "200000",
@@ -161,7 +137,6 @@
     },
     {
         "BriefDescription": "Burst (full cache-line) bus transactions.",
-        "Counter": "0,1",
         "EventCode": "0x6E",
         "EventName": "BUS_TRANS_BURST.SELF",
         "SampleAfterValue": "200000",
@@ -169,7 +144,6 @@
     },
     {
         "BriefDescription": "Deferred bus transactions.",
-        "Counter": "0,1",
         "EventCode": "0x6D",
         "EventName": "BUS_TRANS_DEF.ALL_AGENTS",
         "SampleAfterValue": "200000",
@@ -177,7 +151,6 @@
     },
     {
         "BriefDescription": "Deferred bus transactions.",
-        "Counter": "0,1",
         "EventCode": "0x6D",
         "EventName": "BUS_TRANS_DEF.SELF",
         "SampleAfterValue": "200000",
@@ -185,7 +158,6 @@
     },
     {
         "BriefDescription": "Instruction-fetch bus transactions.",
-        "Counter": "0,1",
         "EventCode": "0x68",
         "EventName": "BUS_TRANS_IFETCH.ALL_AGENTS",
         "SampleAfterValue": "200000",
@@ -193,7 +165,6 @@
     },
     {
         "BriefDescription": "Instruction-fetch bus transactions.",
-        "Counter": "0,1",
         "EventCode": "0x68",
         "EventName": "BUS_TRANS_IFETCH.SELF",
         "SampleAfterValue": "200000",
@@ -201,7 +172,6 @@
     },
     {
         "BriefDescription": "Invalidate bus transactions.",
-        "Counter": "0,1",
         "EventCode": "0x69",
         "EventName": "BUS_TRANS_INVAL.ALL_AGENTS",
         "SampleAfterValue": "200000",
@@ -209,7 +179,6 @@
     },
     {
         "BriefDescription": "Invalidate bus transactions.",
-        "Counter": "0,1",
         "EventCode": "0x69",
         "EventName": "BUS_TRANS_INVAL.SELF",
         "SampleAfterValue": "200000",
@@ -217,7 +186,6 @@
     },
     {
         "BriefDescription": "IO bus transactions.",
-        "Counter": "0,1",
         "EventCode": "0x6C",
         "EventName": "BUS_TRANS_IO.ALL_AGENTS",
         "SampleAfterValue": "200000",
@@ -225,7 +193,6 @@
     },
     {
         "BriefDescription": "IO bus transactions.",
-        "Counter": "0,1",
         "EventCode": "0x6C",
         "EventName": "BUS_TRANS_IO.SELF",
         "SampleAfterValue": "200000",
@@ -233,7 +200,6 @@
     },
     {
         "BriefDescription": "Memory bus transactions.",
-        "Counter": "0,1",
         "EventCode": "0x6F",
         "EventName": "BUS_TRANS_MEM.ALL_AGENTS",
         "SampleAfterValue": "200000",
@@ -241,7 +207,6 @@
     },
     {
         "BriefDescription": "Memory bus transactions.",
-        "Counter": "0,1",
         "EventCode": "0x6F",
         "EventName": "BUS_TRANS_MEM.SELF",
         "SampleAfterValue": "200000",
@@ -249,7 +214,6 @@
     },
     {
         "BriefDescription": "Partial bus transactions.",
-        "Counter": "0,1",
         "EventCode": "0x6B",
         "EventName": "BUS_TRANS_P.ALL_AGENTS",
         "SampleAfterValue": "200000",
@@ -257,7 +221,6 @@
     },
     {
         "BriefDescription": "Partial bus transactions.",
-        "Counter": "0,1",
         "EventCode": "0x6B",
         "EventName": "BUS_TRANS_P.SELF",
         "SampleAfterValue": "200000",
@@ -265,7 +228,6 @@
     },
     {
         "BriefDescription": "Partial write bus transaction.",
-        "Counter": "0,1",
         "EventCode": "0x6A",
         "EventName": "BUS_TRANS_PWR.ALL_AGENTS",
         "SampleAfterValue": "200000",
@@ -273,7 +235,6 @@
     },
     {
         "BriefDescription": "Partial write bus transaction.",
-        "Counter": "0,1",
         "EventCode": "0x6A",
         "EventName": "BUS_TRANS_PWR.SELF",
         "SampleAfterValue": "200000",
@@ -281,7 +242,6 @@
     },
     {
         "BriefDescription": "RFO bus transactions.",
-        "Counter": "0,1",
         "EventCode": "0x66",
         "EventName": "BUS_TRANS_RFO.ALL_AGENTS",
         "SampleAfterValue": "200000",
@@ -289,7 +249,6 @@
     },
     {
         "BriefDescription": "RFO bus transactions.",
-        "Counter": "0,1",
         "EventCode": "0x66",
         "EventName": "BUS_TRANS_RFO.SELF",
         "SampleAfterValue": "200000",
@@ -297,7 +256,6 @@
     },
     {
         "BriefDescription": "Explicit writeback bus transactions.",
-        "Counter": "0,1",
         "EventCode": "0x67",
         "EventName": "BUS_TRANS_WB.ALL_AGENTS",
         "SampleAfterValue": "200000",
@@ -305,7 +263,6 @@
     },
     {
         "BriefDescription": "Explicit writeback bus transactions.",
-        "Counter": "0,1",
         "EventCode": "0x67",
         "EventName": "BUS_TRANS_WB.SELF",
         "SampleAfterValue": "200000",
@@ -313,7 +270,6 @@
     },
     {
         "BriefDescription": "Cycles during which interrupts are disabled.",
-        "Counter": "0,1",
         "EventCode": "0xC6",
         "EventName": "CYCLES_INT_MASKED.CYCLES_INT_MASKED",
         "SampleAfterValue": "2000000",
@@ -321,7 +277,6 @@
     },
     {
         "BriefDescription": "Cycles during which interrupts are pending and disabled.",
-        "Counter": "0,1",
         "EventCode": "0xC6",
         "EventName": "CYCLES_INT_MASKED.CYCLES_INT_PENDING_AND_MASKED",
         "SampleAfterValue": "2000000",
@@ -329,7 +284,6 @@
     },
     {
         "BriefDescription": "Memory cluster signals to block micro-op dispatch for any reason",
-        "Counter": "0,1",
         "EventCode": "0x9",
         "EventName": "DISPATCH_BLOCKED.ANY",
         "SampleAfterValue": "200000",
@@ -337,15 +291,12 @@
     },
     {
         "BriefDescription": "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
-        "Counter": "0,1",
         "EventCode": "0x3A",
         "EventName": "EIST_TRANS",
-        "SampleAfterValue": "200000",
-        "UMask": "0x0"
+        "SampleAfterValue": "200000"
     },
     {
         "BriefDescription": "External snoops.",
-        "Counter": "0,1",
         "EventCode": "0x77",
         "EventName": "EXT_SNOOP.ALL_AGENTS.ANY",
         "SampleAfterValue": "200000",
@@ -353,7 +304,6 @@
     },
     {
         "BriefDescription": "External snoops.",
-        "Counter": "0,1",
         "EventCode": "0x77",
         "EventName": "EXT_SNOOP.ALL_AGENTS.CLEAN",
         "SampleAfterValue": "200000",
@@ -361,7 +311,6 @@
     },
     {
         "BriefDescription": "External snoops.",
-        "Counter": "0,1",
         "EventCode": "0x77",
         "EventName": "EXT_SNOOP.ALL_AGENTS.HIT",
         "SampleAfterValue": "200000",
@@ -369,7 +318,6 @@
     },
     {
         "BriefDescription": "External snoops.",
-        "Counter": "0,1",
         "EventCode": "0x77",
         "EventName": "EXT_SNOOP.ALL_AGENTS.HITM",
         "SampleAfterValue": "200000",
@@ -377,7 +325,6 @@
     },
     {
         "BriefDescription": "External snoops.",
-        "Counter": "0,1",
         "EventCode": "0x77",
         "EventName": "EXT_SNOOP.THIS_AGENT.ANY",
         "SampleAfterValue": "200000",
@@ -385,7 +332,6 @@
     },
     {
         "BriefDescription": "External snoops.",
-        "Counter": "0,1",
         "EventCode": "0x77",
         "EventName": "EXT_SNOOP.THIS_AGENT.CLEAN",
         "SampleAfterValue": "200000",
@@ -393,7 +339,6 @@
     },
     {
         "BriefDescription": "External snoops.",
-        "Counter": "0,1",
         "EventCode": "0x77",
         "EventName": "EXT_SNOOP.THIS_AGENT.HIT",
         "SampleAfterValue": "200000",
@@ -401,7 +346,6 @@
     },
     {
         "BriefDescription": "External snoops.",
-        "Counter": "0,1",
         "EventCode": "0x77",
         "EventName": "EXT_SNOOP.THIS_AGENT.HITM",
         "SampleAfterValue": "200000",
@@ -409,15 +353,12 @@
     },
     {
         "BriefDescription": "Hardware interrupts received.",
-        "Counter": "0,1",
         "EventCode": "0xC8",
         "EventName": "HW_INT_RCV",
-        "SampleAfterValue": "200000",
-        "UMask": "0x0"
+        "SampleAfterValue": "200000"
     },
     {
         "BriefDescription": "Number of segment register loads.",
-        "Counter": "0,1",
         "EventCode": "0x6",
         "EventName": "SEGMENT_REG_LOADS.ANY",
         "SampleAfterValue": "200000",
@@ -425,7 +366,6 @@
     },
     {
         "BriefDescription": "Bus stalled for snoops.",
-        "Counter": "0,1",
         "EventCode": "0x7E",
         "EventName": "SNOOP_STALL_DRV.ALL_AGENTS",
         "SampleAfterValue": "200000",
@@ -433,7 +373,6 @@
     },
     {
         "BriefDescription": "Bus stalled for snoops.",
-        "Counter": "0,1",
         "EventCode": "0x7E",
         "EventName": "SNOOP_STALL_DRV.SELF",
         "SampleAfterValue": "200000",
@@ -441,7 +380,6 @@
     },
     {
         "BriefDescription": "Number of thermal trips",
-        "Counter": "0,1",
         "EventCode": "0x3B",
         "EventName": "THERMAL_TRIP",
         "SampleAfterValue": "200000",
diff --git a/tools/perf/pmu-events/arch/x86/bonnell/pipeline.json b/tools/perf/pmu-events/arch/x86/bonnell/pipeline.json
index f5123c99a7ba..91b98ee8ba9a 100644
--- a/tools/perf/pmu-events/arch/x86/bonnell/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/bonnell/pipeline.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "Bogus branches",
-        "Counter": "0,1",
         "EventCode": "0xE4",
         "EventName": "BOGUS_BR",
         "SampleAfterValue": "2000000",
@@ -9,7 +8,6 @@
     },
     {
         "BriefDescription": "Branch instructions decoded",
-        "Counter": "0,1",
         "EventCode": "0xE0",
         "EventName": "BR_INST_DECODED",
         "SampleAfterValue": "2000000",
@@ -17,15 +15,12 @@
     },
     {
         "BriefDescription": "Retired branch instructions.",
-        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ANY",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x0"
+        "SampleAfterValue": "2000000"
     },
     {
         "BriefDescription": "Retired branch instructions.",
-        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ANY1",
         "SampleAfterValue": "2000000",
@@ -33,16 +28,13 @@
     },
     {
         "BriefDescription": "Retired mispredicted branch instructions (precise event).",
-        "Counter": "0,1",
         "EventCode": "0xC5",
         "EventName": "BR_INST_RETIRED.MISPRED",
         "PEBS": "1",
-        "SampleAfterValue": "200000",
-        "UMask": "0x0"
+        "SampleAfterValue": "200000"
     },
     {
         "BriefDescription": "Retired branch instructions that were mispredicted not-taken.",
-        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.MISPRED_NOT_TAKEN",
         "SampleAfterValue": "200000",
@@ -50,7 +42,6 @@
     },
     {
         "BriefDescription": "Retired branch instructions that were mispredicted taken.",
-        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.MISPRED_TAKEN",
         "SampleAfterValue": "200000",
@@ -58,7 +49,6 @@
     },
     {
         "BriefDescription": "Retired branch instructions that were predicted not-taken.",
-        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.PRED_NOT_TAKEN",
         "SampleAfterValue": "2000000",
@@ -66,7 +56,6 @@
     },
     {
         "BriefDescription": "Retired branch instructions that were predicted taken.",
-        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.PRED_TAKEN",
         "SampleAfterValue": "2000000",
@@ -74,7 +63,6 @@
     },
     {
         "BriefDescription": "Retired taken branch instructions.",
-        "Counter": "0,1",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.TAKEN",
         "SampleAfterValue": "2000000",
@@ -82,7 +70,6 @@
     },
     {
         "BriefDescription": "All macro conditional branch instructions.",
-        "Counter": "0,1",
         "EventCode": "0x88",
         "EventName": "BR_INST_TYPE_RETIRED.COND",
         "SampleAfterValue": "2000000",
@@ -90,7 +77,6 @@
     },
     {
         "BriefDescription": "Only taken macro conditional branch instructions",
-        "Counter": "0,1",
         "EventCode": "0x88",
         "EventName": "BR_INST_TYPE_RETIRED.COND_TAKEN",
         "SampleAfterValue": "2000000",
@@ -98,7 +84,6 @@
     },
     {
         "BriefDescription": "All non-indirect calls",
-        "Counter": "0,1",
         "EventCode": "0x88",
         "EventName": "BR_INST_TYPE_RETIRED.DIR_CALL",
         "SampleAfterValue": "2000000",
@@ -106,7 +91,6 @@
     },
     {
         "BriefDescription": "All indirect branches that are not calls.",
-        "Counter": "0,1",
         "EventCode": "0x88",
         "EventName": "BR_INST_TYPE_RETIRED.IND",
         "SampleAfterValue": "2000000",
@@ -114,7 +98,6 @@
     },
     {
         "BriefDescription": "All indirect calls, including both register and memory indirect.",
-        "Counter": "0,1",
         "EventCode": "0x88",
         "EventName": "BR_INST_TYPE_RETIRED.IND_CALL",
         "SampleAfterValue": "2000000",
@@ -122,7 +105,6 @@
     },
     {
         "BriefDescription": "All indirect branches that have a return mnemonic",
-        "Counter": "0,1",
         "EventCode": "0x88",
         "EventName": "BR_INST_TYPE_RETIRED.RET",
         "SampleAfterValue": "2000000",
@@ -130,7 +112,6 @@
     },
     {
         "BriefDescription": "All macro unconditional branch instructions, excluding calls and indirects",
-        "Counter": "0,1",
         "EventCode": "0x88",
         "EventName": "BR_INST_TYPE_RETIRED.UNCOND",
         "SampleAfterValue": "2000000",
@@ -138,7 +119,6 @@
     },
     {
         "BriefDescription": "Mispredicted cond branch instructions retired",
-        "Counter": "0,1",
         "EventCode": "0x89",
         "EventName": "BR_MISSP_TYPE_RETIRED.COND",
         "SampleAfterValue": "200000",
@@ -146,7 +126,6 @@
     },
     {
         "BriefDescription": "Mispredicted and taken cond branch instructions retired",
-        "Counter": "0,1",
         "EventCode": "0x89",
         "EventName": "BR_MISSP_TYPE_RETIRED.COND_TAKEN",
         "SampleAfterValue": "200000",
@@ -154,7 +133,6 @@
     },
     {
         "BriefDescription": "Mispredicted ind branches that are not calls",
-        "Counter": "0,1",
         "EventCode": "0x89",
         "EventName": "BR_MISSP_TYPE_RETIRED.IND",
         "SampleAfterValue": "200000",
@@ -162,7 +140,6 @@
     },
     {
         "BriefDescription": "Mispredicted indirect calls, including both register and memory indirect.",
-        "Counter": "0,1",
         "EventCode": "0x89",
         "EventName": "BR_MISSP_TYPE_RETIRED.IND_CALL",
         "SampleAfterValue": "200000",
@@ -170,7 +147,6 @@
     },
     {
         "BriefDescription": "Mispredicted return branches",
-        "Counter": "0,1",
         "EventCode": "0x89",
         "EventName": "BR_MISSP_TYPE_RETIRED.RETURN",
         "SampleAfterValue": "200000",
@@ -178,7 +154,6 @@
     },
     {
         "BriefDescription": "Bus cycles when core is not halted",
-        "Counter": "0,1",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.BUS",
         "SampleAfterValue": "200000",
@@ -186,31 +161,24 @@
     },
     {
         "BriefDescription": "Core cycles when core is not halted",
-        "Counter": "Fixed counter 2",
         "EventCode": "0xA",
         "EventName": "CPU_CLK_UNHALTED.CORE",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x0"
+        "SampleAfterValue": "2000000"
     },
     {
         "BriefDescription": "Core cycles when core is not halted",
-        "Counter": "0,1",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.CORE_P",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x0"
+        "SampleAfterValue": "2000000"
     },
     {
         "BriefDescription": "Reference cycles when core is not halted.",
-        "Counter": "Fixed counter 3",
         "EventCode": "0xA",
         "EventName": "CPU_CLK_UNHALTED.REF",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x0"
+        "SampleAfterValue": "2000000"
     },
     {
         "BriefDescription": "Cycles the divider is busy.",
-        "Counter": "0,1",
         "EventCode": "0x14",
         "EventName": "CYCLES_DIV_BUSY",
         "SampleAfterValue": "2000000",
@@ -218,7 +186,6 @@
     },
     {
         "BriefDescription": "Divide operations retired",
-        "Counter": "0,1",
         "EventCode": "0x13",
         "EventName": "DIV.AR",
         "SampleAfterValue": "2000000",
@@ -226,7 +193,6 @@
     },
     {
         "BriefDescription": "Divide operations executed.",
-        "Counter": "0,1",
         "EventCode": "0x13",
         "EventName": "DIV.S",
         "SampleAfterValue": "2000000",
@@ -234,24 +200,19 @@
     },
     {
         "BriefDescription": "Instructions retired.",
-        "Counter": "Fixed counter 1",
         "EventCode": "0xA",
         "EventName": "INST_RETIRED.ANY",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x0"
+        "SampleAfterValue": "2000000"
     },
     {
         "BriefDescription": "Instructions retired (precise event).",
-        "Counter": "0,1",
         "EventCode": "0xC0",
         "EventName": "INST_RETIRED.ANY_P",
         "PEBS": "2",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x0"
+        "SampleAfterValue": "2000000"
     },
     {
         "BriefDescription": "Self-Modifying Code detected.",
-        "Counter": "0,1",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.SMC",
         "SampleAfterValue": "200000",
@@ -259,7 +220,6 @@
     },
     {
         "BriefDescription": "Multiply operations retired",
-        "Counter": "0,1",
         "EventCode": "0x12",
         "EventName": "MUL.AR",
         "SampleAfterValue": "2000000",
@@ -267,7 +227,6 @@
     },
     {
         "BriefDescription": "Multiply operations executed.",
-        "Counter": "0,1",
         "EventCode": "0x12",
         "EventName": "MUL.S",
         "SampleAfterValue": "2000000",
@@ -275,7 +234,6 @@
     },
     {
         "BriefDescription": "Micro-op reissues for any cause",
-        "Counter": "0,1",
         "EventCode": "0x3",
         "EventName": "REISSUE.ANY",
         "SampleAfterValue": "200000",
@@ -283,7 +241,6 @@
     },
     {
         "BriefDescription": "Micro-op reissues for any cause (At Retirement)",
-        "Counter": "0,1",
         "EventCode": "0x3",
         "EventName": "REISSUE.ANY.AR",
         "SampleAfterValue": "200000",
@@ -291,7 +248,6 @@
     },
     {
         "BriefDescription": "Micro-op reissues on a store-load collision",
-        "Counter": "0,1",
         "EventCode": "0x3",
         "EventName": "REISSUE.OVERLAP_STORE",
         "SampleAfterValue": "200000",
@@ -299,7 +255,6 @@
     },
     {
         "BriefDescription": "Micro-op reissues on a store-load collision (At Retirement)",
-        "Counter": "0,1",
         "EventCode": "0x3",
         "EventName": "REISSUE.OVERLAP_STORE.AR",
         "SampleAfterValue": "200000",
@@ -307,7 +262,6 @@
     },
     {
         "BriefDescription": "Cycles issue is stalled due to div busy.",
-        "Counter": "0,1",
         "EventCode": "0xDC",
         "EventName": "RESOURCE_STALLS.DIV_BUSY",
         "SampleAfterValue": "2000000",
@@ -315,7 +269,6 @@
     },
     {
         "BriefDescription": "All store forwards",
-        "Counter": "0,1",
         "EventCode": "0x2",
         "EventName": "STORE_FORWARDS.ANY",
         "SampleAfterValue": "200000",
@@ -323,7 +276,6 @@
     },
     {
         "BriefDescription": "Good store forwards",
-        "Counter": "0,1",
         "EventCode": "0x2",
         "EventName": "STORE_FORWARDS.GOOD",
         "SampleAfterValue": "200000",
@@ -331,7 +283,6 @@
     },
     {
         "BriefDescription": "Micro-ops retired.",
-        "Counter": "0,1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.ANY",
         "SampleAfterValue": "2000000",
@@ -339,7 +290,6 @@
     },
     {
         "BriefDescription": "Cycles no micro-ops retired.",
-        "Counter": "0,1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.STALLED_CYCLES",
         "SampleAfterValue": "2000000",
@@ -347,7 +297,6 @@
     },
     {
         "BriefDescription": "Periods no micro-ops retired.",
-        "Counter": "0,1",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.STALLS",
         "SampleAfterValue": "2000000",
diff --git a/tools/perf/pmu-events/arch/x86/bonnell/virtual-memory.json b/tools/perf/pmu-events/arch/x86/bonnell/virtual-memory.json
index e8512c585572..82e07c73cff0 100644
--- a/tools/perf/pmu-events/arch/x86/bonnell/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/bonnell/virtual-memory.json
@@ -1,7 +1,6 @@
 [
     {
         "BriefDescription": "Memory accesses that missed the DTLB.",
-        "Counter": "0,1",
         "EventCode": "0x8",
         "EventName": "DATA_TLB_MISSES.DTLB_MISS",
         "SampleAfterValue": "200000",
@@ -9,7 +8,6 @@
     },
     {
         "BriefDescription": "DTLB misses due to load operations.",
-        "Counter": "0,1",
         "EventCode": "0x8",
         "EventName": "DATA_TLB_MISSES.DTLB_MISS_LD",
         "SampleAfterValue": "200000",
@@ -17,7 +15,6 @@
     },
     {
         "BriefDescription": "DTLB misses due to store operations.",
-        "Counter": "0,1",
         "EventCode": "0x8",
         "EventName": "DATA_TLB_MISSES.DTLB_MISS_ST",
         "SampleAfterValue": "200000",
@@ -25,7 +22,6 @@
     },
     {
         "BriefDescription": "L0 DTLB misses due to load operations.",
-        "Counter": "0,1",
         "EventCode": "0x8",
         "EventName": "DATA_TLB_MISSES.L0_DTLB_MISS_LD",
         "SampleAfterValue": "200000",
@@ -33,7 +29,6 @@
     },
     {
         "BriefDescription": "L0 DTLB misses due to store operations",
-        "Counter": "0,1",
         "EventCode": "0x8",
         "EventName": "DATA_TLB_MISSES.L0_DTLB_MISS_ST",
         "SampleAfterValue": "200000",
@@ -41,7 +36,6 @@
     },
     {
         "BriefDescription": "ITLB flushes.",
-        "Counter": "0,1",
         "EventCode": "0x82",
         "EventName": "ITLB.FLUSH",
         "SampleAfterValue": "200000",
@@ -49,7 +43,6 @@
     },
     {
         "BriefDescription": "ITLB hits.",
-        "Counter": "0,1",
         "EventCode": "0x82",
         "EventName": "ITLB.HIT",
         "SampleAfterValue": "200000",
@@ -57,7 +50,6 @@
     },
     {
         "BriefDescription": "ITLB misses.",
-        "Counter": "0,1",
         "EventCode": "0x82",
         "EventName": "ITLB.MISSES",
         "PEBS": "2",
@@ -66,7 +58,6 @@
     },
     {
         "BriefDescription": "Retired loads that miss the DTLB (precise event).",
-        "Counter": "0,1",
         "EventCode": "0xCB",
         "EventName": "MEM_LOAD_RETIRED.DTLB_MISS",
         "PEBS": "1",
@@ -75,7 +66,6 @@
     },
     {
         "BriefDescription": "Duration of page-walks in core cycles",
-        "Counter": "0,1",
         "EventCode": "0xC",
         "EventName": "PAGE_WALKS.CYCLES",
         "SampleAfterValue": "2000000",
@@ -83,7 +73,6 @@
     },
     {
         "BriefDescription": "Duration of D-side only page walks",
-        "Counter": "0,1",
         "EventCode": "0xC",
         "EventName": "PAGE_WALKS.D_SIDE_CYCLES",
         "SampleAfterValue": "2000000",
@@ -91,7 +80,6 @@
     },
     {
         "BriefDescription": "Number of D-side only page walks",
-        "Counter": "0,1",
         "EventCode": "0xC",
         "EventName": "PAGE_WALKS.D_SIDE_WALKS",
         "SampleAfterValue": "200000",
@@ -99,7 +87,6 @@
     },
     {
         "BriefDescription": "Duration of I-Side page walks",
-        "Counter": "0,1",
         "EventCode": "0xC",
         "EventName": "PAGE_WALKS.I_SIDE_CYCLES",
         "SampleAfterValue": "2000000",
@@ -107,7 +94,6 @@
     },
     {
         "BriefDescription": "Number of I-Side page walks",
-        "Counter": "0,1",
         "EventCode": "0xC",
         "EventName": "PAGE_WALKS.I_SIDE_WALKS",
         "SampleAfterValue": "200000",
@@ -115,7 +101,6 @@
     },
     {
         "BriefDescription": "Number of page-walks executed.",
-        "Counter": "0,1",
         "EventCode": "0xC",
         "EventName": "PAGE_WALKS.WALKS",
         "SampleAfterValue": "200000",
-- 
2.39.0.314.g84b9a713c41-goog

