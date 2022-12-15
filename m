Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C51864D6D9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 08:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLOHAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 02:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiLOG7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:59:17 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E669C62EA1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:57:35 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3bd1ff8fadfso25210907b3.18
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5H69tCzHRxxRA1R6TWGmLrKp0p+GdT5OVgyAR8jli4=;
        b=I2EzhGafNmRB22lkBEwo6etyk8hqFf7dlFOqg3Qyd+vgxCrLrHd/8WlDXtUPkZHl4s
         kNk2kdOwAbqix93mqXbHQOOzL5EC0NVEgsLm6kuKRYnS1tI3eS3zxRE0eFMSr48r+5H2
         eU2qcmxoWoFGEf/h6jaLLFIg7Li0IAZr1TssMHwwO4lyLHAjalGJ+z0pmm8oY3HECZAv
         YhpyzZBDrlMO2Bb6UbL02cAXxZcNlB5asfQSlBe6jWuq6lFz7a9eko0s+iBo687EZEy2
         2a99PHc6s4LZu7fbUKk9D++HVeZoAnQIawLuoQ9f5wNJjFPaDWcKFo26yHGZAuEOIoXe
         RAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X5H69tCzHRxxRA1R6TWGmLrKp0p+GdT5OVgyAR8jli4=;
        b=ptK9K8WnmFqzLhqRr4lO5WttN4hjUB5Hv1cA9nYR218dEOB2LNVfDw0yMhN7n0yrK3
         yJf7GyWZ+uu1DwrZV/8aoKxe+AC/NnPsV1Ong/J1w/tO0p7d/SeAUmeMYcn5T5FtYw9J
         nLkEcnnafNmPUnGSZzpIAYKqB+EUhroZvYEVmlFNOsHB8lYUVruf5SqQPTIgZJf1pq5M
         mhLVM2e3+dXyv7Syg2YyuyhEX0LpIH6oSTmmcYQAxje7hFJBCBAng5a9MI9dLZ52YC2V
         qBnkXiZyb8C64XKTUJVfLChrGvnua17PD17ZCE6OjC/5y+rEo5Z9paJyfc2Z+5nmT+Fn
         TeTw==
X-Gm-Message-State: AFqh2koR/tbGIHC99J5DEr0PRL3qgqUfAkI5WGW2t+Yx2LxMmAGeYpgT
        mVdl0/va6G1FzIE2kbcng7CiUthOMbRo
X-Google-Smtp-Source: AMrXdXuLkiOK9oUIEFtveYHvC//n/jP8unbfsvj3G45XvbXAxCevvTsKKmds9Lyz2hrU8Weqgrl7zX+gSpjM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c7dc:d96f:4f9:f59d])
 (user=irogers job=sendgmr) by 2002:a25:9847:0:b0:733:af24:fe57 with SMTP id
 k7-20020a259847000000b00733af24fe57mr362715ybo.228.1671087455044; Wed, 14 Dec
 2022 22:57:35 -0800 (PST)
Date:   Wed, 14 Dec 2022 22:55:02 -0800
In-Reply-To: <20221215065510.1621979-1-irogers@google.com>
Message-Id: <20221215065510.1621979-16-irogers@google.com>
Mime-Version: 1.0
References: <20221215065510.1621979-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 24/32] perf vendor events intel: Refresh sapphirerapids
 metrics and events
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

Update the sapphirerapids metrics and events using the new tooling from:
https://github.com/intel/perfmon

The metrics are unchanged but the formulas differ due to parentheses,
use of exponents and removal of redundant operations like "* 1". The
order of metrics varies as TMA metrics are first converted and then
removed if perfmon versions are found. The events are updated to 1.09,
in particular uncore, with fixes to uncore events and improved
descriptions. The formatting changes increase consistency across the
json files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |    2 +-
 .../arch/x86/sapphirerapids/cache.json        |  350 +-
 .../x86/sapphirerapids/floating-point.json    |   63 -
 .../arch/x86/sapphirerapids/frontend.json     |  144 -
 .../arch/x86/sapphirerapids/memory.json       |  125 +-
 .../arch/x86/sapphirerapids/other.json        |   91 +-
 .../arch/x86/sapphirerapids/pipeline.json     |  424 +-
 .../arch/x86/sapphirerapids/spr-metrics.json  | 2309 +++---
 .../x86/sapphirerapids/uncore-memory.json     |  526 +-
 .../arch/x86/sapphirerapids/uncore-other.json | 6606 ++++++++---------
 .../arch/x86/sapphirerapids/uncore-power.json |   84 +-
 .../x86/sapphirerapids/virtual-memory.json    |   80 -
 12 files changed, 4483 insertions(+), 6321 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 84f74acf91d9..a5de68bcebcd 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -21,7 +21,7 @@ GenuineIntel-6-A[AC],v1.00,meteorlake,core
 GenuineIntel-6-1[AEF],v3,nehalemep,core
 GenuineIntel-6-2E,v3,nehalemex,core
 GenuineIntel-6-2A,v17,sandybridge,core
-GenuineIntel-6-8F,v1.06,sapphirerapids,core
+GenuineIntel-6-8F,v1.09,sapphirerapids,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v14,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v53,skylake,core
 GenuineIntel-6-55-[01234],v1.28,skylakex,core
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json b/too=
ls/perf/pmu-events/arch/x86/sapphirerapids/cache.json
index c05c741e22db..92a605ecac6e 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json
@@ -1,1192 +1,898 @@
 [
     {
         "BriefDescription": "L1D.HWPF_MISS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "L1D.HWPF_MISS",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x20"
     },
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
-        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D Fill Buffer (FB) unavailablability. Demand requests incl=
ude cacheable/uncacheable demand load, store, lock or SW prefetch accesses.=
",
+        "PublicDescription": "Counts number of cycles a demand request has=
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
         "BriefDescription": "This event is deprecated. Refer to new event =
L1D_PEND_MISS.L2_STALLS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
+        "Deprecated": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.L2_STALL",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Number of cycles a demand request has waited =
due to L1D due to lack of L2 resources.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.L2_STALLS",
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
         "EventCode": "0x25",
         "EventName": "L2_LINES_IN.ALL",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of L2 cache lines filling =
the L2. Counting does not cover rejects.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1f"
     },
     {
         "BriefDescription": "L2_LINES_OUT.NON_SILENT",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_LINES_OUT.NON_SILENT",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Non-modified cache lines that are silently dr=
opped by L2 cache when triggered by an L2 cache fill.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x26",
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
         "EventCode": "0x26",
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
         "BriefDescription": "All accesses to L2 cache[This event is alias =
to L2_RQSTS.REFERENCES]",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.ALL",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses.[This event is alias to L2_RQSTS.REFERENCES]",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0xff"
     },
     {
         "BriefDescription": "Read requests with true-miss in L2 cache.[Thi=
s event is alias to L2_RQSTS.MISS]",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.MISS",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses.[This event is alias to L2_RQSTS.MISS]",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x3f"
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
         "BriefDescription": "Demand Data Read access L2 cache",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts Demand Data Read requests accessing t=
he L2 cache. These requests may hit or miss L2 cache. True-miss exclude mis=
ses that were merged with ongoing L2 misses. An access is counted once.",
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
         "BriefDescription": "L2_RQSTS.ALL_HWPF",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_HWPF",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0xf0"
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
         "BriefDescription": "Demand Data Read miss L2 cache",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts demand Data Read requests with true-m=
iss in the L2 cache. True-miss excludes misses that were merged with ongoin=
g L2 misses. An access is counted once.",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x21"
     },
     {
         "BriefDescription": "L2_RQSTS.HWPF_MISS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.HWPF_MISS",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x30"
     },
     {
         "BriefDescription": "Read requests with true-miss in L2 cache.[Thi=
s event is alias to L2_REQUEST.MISS]",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.MISS",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses.[This event is alias to L2_REQUEST.MISS]",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0x3f"
     },
     {
         "BriefDescription": "All accesses to L2 cache[This event is alias =
to L2_REQUEST.ALL]",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.REFERENCES",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses.[This event is alias to L2_REQUEST.ALL]",
         "SampleAfterValue": "200003",
-        "Speculative": "1",
         "UMask": "0xff"
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
         "BriefDescription": "Core-originated cacheable requests that refer=
 to L3 (Except hardware prefetches to the L3)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts core-originated cacheable requests to=
 the L3 cache (Longest Latency cache). Requests include data and code reads=
, Reads-for-Ownership (RFOs), speculative accesses and hardware prefetches =
to the L1 and L2.  It does not include hardware prefetches to the L3, and m=
ay not count other types of requests to the L3.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x4f"
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
         "BriefDescription": "Completed demand load uops that miss the L1 d=
-cache.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x43",
         "EventName": "MEM_LOAD_COMPLETED.L1_MISS_ANY",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Number of completed demand load requests tha=
t missed the L1 data cache including shadow misses (FB hits, merge to an on=
going L1D miss)",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0xfd"
     },
     {
         "BriefDescription": "Retired load instructions whose data sources =
were HitM responses from shared L3",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD",
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
         "BriefDescription": "Retired load instructions whose data sources =
were L3 and cross-core snoop hits in on-pkg core cache",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts retired load instructions whose data =
sources were L3 and cross-core snoop hits in on-pkg core cache.",
         "SampleAfterValue": "20011",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Retired load instructions which data sources =
missed L3 but serviced from local dram",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM",
-        "PEBScounters": "0,1,2,3",
+        "PEBS": "1",
         "PublicDescription": "Retired load instructions which data sources=
 missed L3 but serviced from local DRAM.",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM",
-        "PEBScounters": "0,1,2,3",
+        "PEBS": "1",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Retired load instructions whose data sources =
was forwarded from a remote cache",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD",
-        "PEBScounters": "0,1,2,3",
+        "PEBS": "1",
         "PublicDescription": "Retired load instructions whose data sources=
 was forwarded from a remote cache.",
         "SampleAfterValue": "100007",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM",
-        "PEBScounters": "0,1,2,3",
+        "PEBS": "1",
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "Retired load instructions with remote Intel O=
ptane DC persistent memory as the data source where the data request missed=
 all caches.",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Retired load instructions with remote Intel(R=
) Optane(TM) DC persistent memory as the data source where the data request=
 missed all caches.",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts retired load instructions with remote=
 Intel Optane DC persistent memory as the data source and the data request =
missed L3.",
+        "PublicDescription": "Counts retired load instructions with remote=
 Intel(R) Optane(TM) DC persistent memory as the data source and the data r=
equest missed L3.",
         "SampleAfterValue": "100007",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Retired instructions with at least 1 uncachea=
ble load or lock.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd4",
         "EventName": "MEM_LOAD_MISC_RETIRED.UC",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Retired instructions with at least one load =
to uncacheable memory-type, or at least one cache-line split locked access =
(Bus Lock).",
         "SampleAfterValue": "100007",
         "UMask": "0x4"
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
-        "BriefDescription": "Retired load instructions with local Intel Op=
tane DC persistent memory as the data source where the data request missed =
all caches.",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Retired load instructions with local Intel(R)=
 Optane(TM) DC persistent memory as the data source where the data request =
missed all caches.",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.LOCAL_PMM",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts retired load instructions with local =
Intel Optane DC persistent memory as the data source and the data request m=
issed L3.",
+        "PEBS": "1",
+        "PublicDescription": "Counts retired load instructions with local =
Intel(R) Optane(TM) DC persistent memory as the data source and the data re=
quest missed L3.",
         "SampleAfterValue": "1000003",
         "UMask": "0x80"
     },
     {
         "BriefDescription": "MEM_STORE_RETIRED.L2_HIT",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x44",
         "EventName": "MEM_STORE_RETIRED.L2_HIT",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired memory uops for any access",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe5",
         "EventName": "MEM_UOP_RETIRED.ANY",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of retired micro-operations (uops) fo=
r load or store memory accesses",
         "SampleAfterValue": "1000003",
         "UMask": "0x3"
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit in the L3 or were snooped from another co=
re's caches on the same socket.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_CODE_RD.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that resulted in a snoop hit a modified line in an=
other core's caches which forwarded the data.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit a modified line in a distant L3 Cache or =
were snooped from a distant core's L1/L2 caches on this socket when the sys=
tem is in SNC (sub-NUMA cluster) mode.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_CODE_RD.SNC_CACHE.HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1008000004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that either hit a non-modified line in a distant L=
3 Cache or were snooped from a distant core's L1/L2 caches on this socket w=
hen the system is in SNC (sub-NUMA cluster) mode.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_CODE_RD.SNC_CACHE.HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x808000004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that hit in the L3 o=
r were snooped from another core's caches on the same socket.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that resulted in a s=
noop hit a modified line in another core's caches which forwarded the data.=
",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that resulted in a s=
noop that hit in another core, which did not forward the data.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that resulted in a s=
noop hit in another core's caches which forwarded the unmodified data to th=
e requesting core.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y a cache on a remote socket where a snoop hit a modified line in another c=
ore's caches which forwarded the data.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.REMOTE_CACHE.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1030000001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y a cache on a remote socket where a snoop hit in another core's caches whi=
ch forwarded the unmodified data to the requesting core.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.REMOTE_CACHE.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x830000001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that hit a modified =
line in a distant L3 Cache or were snooped from a distant core's L1/L2 cach=
es on this socket when the system is in SNC (sub-NUMA cluster) mode.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.SNC_CACHE.HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1008000001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that either hit a no=
n-modified line in a distant L3 Cache or were snooped from a distant core's=
 L1/L2 caches on this socket when the system is in SNC (sub-NUMA cluster) m=
ode.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.SNC_CACHE.HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x808000001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit in=
 the L3 or were snooped from another core's caches on the same socket.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that result=
ed in a snoop hit a modified line in another core's caches which forwarded =
the data.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit a =
modified line in a distant L3 Cache or were snooped from a distant core's L=
1/L2 caches on this socket when the system is in SNC (sub-NUMA cluster) mod=
e.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.SNC_CACHE.HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1008000002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that either=
 hit a non-modified line in a distant L3 Cache or were snooped from a dista=
nt core's L1/L2 caches on this socket when the system is in SNC (sub-NUMA c=
luster) mode.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.SNC_CACHE.HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x808000002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts hardware prefetches to the L3 only tha=
t hit in the L3 or were snooped from another core's caches on the same sock=
et.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.HWPF_L3.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80082380",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that hit in the L3 or were snooped from another core's caches on the sa=
me socket.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F003C4477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that resulted in a snoop hit a modified line in another core's caches w=
hich forwarded the data.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C4477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that resulted in a snoop that hit in another core, which did not forwar=
d the data.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C4477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that resulted in a snoop hit in another core's caches which forwarded t=
he unmodified data to the requesting core.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C4477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by a cache on a remote socket where a snoop was sent=
 and data was returned (Modified or Not Modified).",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.REMOTE_CACHE.SNOOP_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1830004477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by a cache on a remote socket where a snoop hit a mo=
dified line in another core's caches which forwarded the data.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.REMOTE_CACHE.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1030004477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by a cache on a remote socket where a snoop hit in a=
nother core's caches which forwarded the unmodified data to the requesting =
core.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.REMOTE_CACHE.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x830004477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that hit a modified line in a distant L3 Cache or were snooped from a d=
istant core's L1/L2 caches on this socket when the system is in SNC (sub-NU=
MA cluster) mode.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.SNC_CACHE.HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1008004477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that either hit a non-modified line in a distant L3 Cache or were snoop=
ed from a distant core's L1/L2 caches on this socket when the system is in =
SNC (sub-NUMA cluster) mode.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.SNC_CACHE.HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x808004477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO), hard=
ware prefetch RFOs (which bring data to L2), and software prefetches for ex=
clusive ownership (PREFETCHW) that hit to a (M)odified cacheline in the L3 =
or snoop filter.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.RFO_TO_CORE.L3_HIT_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1F80040022",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts streaming stores that hit in the L3 or=
 were snooped from another core's caches on the same socket.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.STREAMING_WR.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080800",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "OFFCORE_REQUESTS.ALL_REQUESTS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.ALL_REQUESTS",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x80"
     },
     {
         "BriefDescription": "Demand and prefetch data reads",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.DATA_RD",
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
         "BriefDescription": "Demand Data Read requests sent to uncore",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x21",
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
         "BriefDescription": "This event is deprecated. Refer to new event =
OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
+        "Deprecated": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA=
_RD",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x8"
     },
+    {
+        "BriefDescription": "Cycles where at least 1 outstanding demand da=
ta read request is pending.",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_DATA=
_RD",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMA=
ND_RFO",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO"=
,
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x8"
     },
+    {
+        "BriefDescription": "For every cycle, increments by the number of =
outstanding demand data read requests pending.",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD",
+        "PublicDescription": "For every cycle, increments by the number of=
 outstanding demand data read requests pending.   Requests are considered o=
utstanding from the time they miss the core's L2 cache until the transactio=
n completion message is sent to the requestor.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Number of PREFETCHNTA instructions executed."=
,
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x40",
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
         "EventCode": "0x40",
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
         "EventCode": "0x40",
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
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.T1_T2",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT=
2 instructions executed.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x4"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/floating-point.j=
son b/tools/perf/pmu-events/arch/x86/sapphirerapids/floating-point.json
index 32074d455691..01baea3df562 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/floating-point.json
@@ -1,222 +1,159 @@
 [
     {
         "BriefDescription": "ARITH.FPDIV_ACTIVE",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.FPDIV_ACTIVE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
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
         "BriefDescription": "ASSISTS.SSE_AVX_MIX",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.SSE_AVX_MIX",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "FP_ARITH_DISPATCHED.PORT_0",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_0",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "FP_ARITH_DISPATCHED.PORT_1",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "FP_ARITH_DISPATCHED.PORT_5",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_5",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x4"
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
     },
     {
         "BriefDescription": "FP_ARITH_INST_RETIRED2.128B_PACKED_HALF",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.128B_PACKED_HALF",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "FP_ARITH_INST_RETIRED2.256B_PACKED_HALF",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.256B_PACKED_HALF",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "100003",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "FP_ARITH_INST_RETIRED2.512B_PACKED_HALF",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.512B_PACKED_HALF",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "FP_ARITH_INST_RETIRED2.COMPLEX_SCALAR_HALF",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.COMPLEX_SCALAR_HALF",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Number of all Scalar Half-Precision FP arithm=
etic instructions(1) retired - regular and complex.",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.SCALAR",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "FP_ARITH_INST_RETIRED2.SCALAR",
         "SampleAfterValue": "100003",
         "UMask": "0x3"
     },
     {
         "BriefDescription": "FP_ARITH_INST_RETIRED2.SCALAR_HALF",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.SCALAR_HALF",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Number of all Vector (also called packed) Hal=
f-Precision FP arithmetic instructions(1) retired.",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.VECTOR",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "FP_ARITH_INST_RETIRED2.VECTOR",
         "SampleAfterValue": "100003",
         "UMask": "0x1c"
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json b/=
tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json
index ff0d47ce8e9a..2c7c617f27ed 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json
@@ -1,498 +1,354 @@
 [
     {
         "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "DECODE.LCP",
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
         "BriefDescription": "Cycles the Microcode Sequencer is busy.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "DECODE.MS_BUSY",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "500009",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "DSB-to-MITE switch true penalty cycles.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x61",
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
         "MSRValue": "0x600106",
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
         "MSRValue": "0x608006",
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
         "MSRValue": "0x601006",
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
         "MSRValue": "0x600206",
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
         "MSRValue": "0x610006",
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
         "MSRValue": "0x602006",
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
         "MSRValue": "0x600406",
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
         "MSRValue": "0x620006",
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
         "MSRValue": "0x604006",
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
         "MSRValue": "0x600806",
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
         "BriefDescription": "FRONTEND_RETIRED.MS_FLOWS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.MS_FLOWS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x8",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
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
         "BriefDescription": "FRONTEND_RETIRED.UNKNOWN_BRANCH",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.UNKNOWN_BRANCH",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x17",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
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
         "EventName": "ICACHE_DATA.STALLS",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts cycles where a code line fetch is sta=
lled due to an L1 instruction cache miss. The decode pipeline works at a 32=
 Byte granularity.",
         "SampleAfterValue": "500009",
-        "Speculative": "1",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache tag miss.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "ICACHE_TAG.STALLS",
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
         "CounterMask": "6",
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
         "CounterMask": "6",
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
         "UMask": "0x20"
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
         "UMask": "0x20"
     },
     {
         "BriefDescription": "Uops delivered to IDQ while MS is busy",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_UOPS",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the total number of uops delivered by=
 the Microcode Sequencer (MS).",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x20"
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
         "CounterMask": "6",
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
         "EventCode": "0x9c",
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
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/memory.json b/to=
ols/perf/pmu-events/arch/x86/sapphirerapids/memory.json
index 6e761b628ca4..b72a36999930 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/memory.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/memory.json
@@ -1,207 +1,150 @@
 [
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
         "BriefDescription": "Cycles while L1 cache miss demand load is out=
standing.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "2",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.CYCLES_L1D_MISS",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Execution stalls while L1 cache miss demand l=
oad is outstanding.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "3",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.STALLS_L1D_MISS",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x3"
     },
     {
         "BriefDescription": "MEMORY_ACTIVITY.STALLS_L2_MISS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "5",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.STALLS_L2_MISS",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x5"
     },
     {
         "BriefDescription": "MEMORY_ACTIVITY.STALLS_L3_MISS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "9",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.STALLS_L3_MISS",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x9"
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 128 cycles.",
-        "CollectPEBSRecord": "2",
-        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x80",
         "PEBS": "2",
-        "PEBScounters": "1,2,3,4,5,6,7",
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
-        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x10",
         "PEBS": "2",
-        "PEBScounters": "1,2,3,4,5,6,7",
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
-        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x100",
         "PEBS": "2",
-        "PEBScounters": "1,2,3,4,5,6,7",
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
-        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x20",
         "PEBS": "2",
-        "PEBScounters": "1,2,3,4,5,6,7",
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
-        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x4",
         "PEBS": "2",
-        "PEBScounters": "1,2,3,4,5,6,7",
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
-        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x200",
         "PEBS": "2",
-        "PEBScounters": "1,2,3,4,5,6,7",
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
-        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x40",
         "PEBS": "2",
-        "PEBScounters": "1,2,3,4,5,6,7",
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
-        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x8",
         "PEBS": "2",
-        "PEBScounters": "1,2,3,4,5,6,7",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 8 cycles.  Reported l=
atency may be longer than just the memory latency.",
         "SampleAfterValue": "50021",
-        "TakenAlone": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Retired memory store access operations. A PDi=
st event for PEBS Store Latency Facility.",
-        "CollectPEBSRecord": "2",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.STORE_SAMPLE",
@@ -212,225 +155,187 @@
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were not supplied by the local socket's L1, L=
2, or L3 caches.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_CODE_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBFC00004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that were not suppli=
ed by the local socket's L1, L2, or L3 caches.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBFC00001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were n=
ot supplied by the local socket's L1, L2, or L3 caches.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F3FC00002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts hardware prefetches to the L3 only tha=
t missed the local socket's L1, L2, and L3 caches.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.HWPF_L3.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x94002380",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts hardware prefetches to the L3 only tha=
t were not supplied by the local socket's L1, L2, or L3 caches and the cach=
eline is homed locally.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.HWPF_L3.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84002380",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were not supplied by the local socket's L1, L2, or L3 caches.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F3FC04477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were not supplied by the local socket's L1, L2, or L3 caches and t=
he cacheline is homed locally.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F04C04477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that missed the L3 Cache and were supplied by the local socket (DRAM or=
 PMM), whether or not in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts PM=
M or DRAM accesses that are controlled by the close or distant SNC Cluster.=
  It does not count misses to the L3 which go to Local CXL Type 2 Memory or=
 Local Non DRAM.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.L3_MISS_LOCAL_SOCKET",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x70CC04477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts streaming stores that missed the local=
 socket's L1, L2, and L3 caches.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.STREAMING_WR.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x94000800",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts streaming stores that were not supplie=
d by the local socket's L1, L2, or L3 caches and the cacheline is homed loc=
ally.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.STREAMING_WR.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000800",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand data read requests that miss th=
e L3 cache.",
+        "EventCode": "0x21",
+        "EventName": "OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "For every cycle, increments by the number of =
demand data read requests pending that are known to have missed the L3 cach=
e.",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAND_DATA_RD"=
,
+        "PublicDescription": "For every cycle, increments by the number of=
 demand data read requests pending that are known to have missed the L3 cac=
he.  Note that this does not capture all elapsed cycles while requests are =
outstanding - only cycles from when the requests were known by the requesti=
ng core to have missed the L3 cache.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10"
+    },
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
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/other.json b/too=
ls/perf/pmu-events/arch/x86/sapphirerapids/other.json
index 95dbef8ae80a..5d4c15dbf4d3 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/other.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/other.json
@@ -1,428 +1,341 @@
 [
     {
         "BriefDescription": "ASSISTS.PAGE_FAULT",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.PAGE_FAULT",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Counts the cycles where the AMX (Advance Matr=
ix Extension) unit is busy performing an operation.",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb7",
         "EventName": "EXE.AMX_BUSY",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that have any type of response.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
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
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_CODE_RD.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x73C000004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM attached to this socket=
, unless in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts only those DRAM=
 accesses that are controlled by the close SNC Cluster.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_CODE_RD.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM on a distant memory con=
troller of this socket when the system is in SNC (sub-NUMA cluster) mode.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_CODE_RD.SNC_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x708000004",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that have any type o=
f response.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x73C000001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) Mode.  In S=
NC Mode counts only those DRAM accesses that are controlled by the close SN=
C Cluster.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM attached to another socket.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.REMOTE_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x730000001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y PMM attached to another socket.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.REMOTE_PMM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x703000001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM on a distant memory controller of this socket when the system is in =
SNC (sub-NUMA cluster) mode.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.SNC_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x708000001",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that have a=
ny type of response.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F3FFC0002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were s=
upplied by DRAM.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x73C000002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were s=
upplied by DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) Mo=
de.  In SNC Mode counts only those DRAM accesses that are controlled by the=
 close SNC Cluster.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were s=
upplied by DRAM on a distant memory controller of this socket when the syst=
em is in SNC (sub-NUMA cluster) mode.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.SNC_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x708000002",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts data load hardware prefetch requests t=
o the L1 data cache that have any type of response.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.HWPF_L1D.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10400",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts hardware prefetches (which bring data =
to L2) that have any type of response.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.HWPF_L2.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10070",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts hardware prefetches to the L3 only tha=
t have any type of response.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.HWPF_L3.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x12380",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts hardware prefetches to the L3 only tha=
t were not supplied by the local socket's L1, L2, or L3 caches and the cach=
eline was homed in a remote socket.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.HWPF_L3.REMOTE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90002380",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts writebacks of modified cachelines and =
streaming stores that have any type of response.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.MODIFIED_WRITE.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10808",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that have any type of response.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F3FFC4477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x73C004477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM attached to this socket, unless in Sub NUMA =
Cluster(SNC) Mode.  In SNC Mode counts only those DRAM accesses that are co=
ntrolled by the close SNC Cluster.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104004477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM attached to this socket, whether or not in S=
ub NUMA Cluster(SNC) Mode.  In SNC Mode counts DRAM accesses that are contr=
olled by the close or distant SNC Cluster.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.LOCAL_SOCKET_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x70C004477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by PMM attached to this socket, whether or not in Su=
b NUMA Cluster(SNC) Mode.  In SNC Mode counts PMM accesses that are control=
led by the close or distant SNC Cluster.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.LOCAL_SOCKET_PMM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x700C04477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were not supplied by the local socket's L1, L2, or L3 caches and w=
ere supplied by a remote socket.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.REMOTE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F33004477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM attached to another socket.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.REMOTE_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x730004477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM or PMM attached to another socket.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.REMOTE_MEMORY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x733004477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by PMM attached to another socket.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.REMOTE_PMM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x703004477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM on a distant memory controller of this socke=
t when the system is in SNC (sub-NUMA cluster) mode.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.SNC_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x708004477",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10800",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts Demand RFOs, ItoM's, PREFECTHW's, Hard=
ware RFO Prefetches to the L1/L2 and Streaming stores that likely resulted =
in a store to Memory (DRAM or PMM)",
-        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.WRITE_ESTIMATE.MEMORY",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xFBFF80822",
-        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 for the thread.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa5",
         "EventName": "RS.EMPTY",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for this logical processor. This is usually caused whe=
n the front-end pipeline runs into starvation periods (e.g. branch mispredi=
ctions or i-cache misses)",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x7"
     },
     {
         "BriefDescription": "Counts end of periods where the Reservation S=
tation (RS) was empty.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0xa5",
         "EventName": "RS.EMPTY_COUNT",
         "Invert": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts end of periods where the Reservation =
Station (RS) was empty. Could be useful to closely sample on front-end late=
ncy issues (see the FRONTEND_RETIRED event of designated precise events)",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x7"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
RS.EMPTY_COUNT",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
+        "Deprecated": "1",
         "EdgeDetect": "1",
         "EventCode": "0xa5",
         "EventName": "RS_EMPTY.COUNT",
         "Invert": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x7"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
RS.EMPTY",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Deprecated": "1",
         "EventCode": "0xa5",
         "EventName": "RS_EMPTY.CYCLES",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x7"
     },
     {
         "BriefDescription": "XQ.FULL_CYCLES",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x2d",
         "EventName": "XQ.FULL_CYCLES",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x1"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json b/=
tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
index b2f0d9393d3c..ceb14181ebc8 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
@@ -15,1357 +15,945 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
ARITH.DIV_ACTIVE",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
+        "Deprecated": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.DIVIDER_ACTIVE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x9"
     },
     {
         "BriefDescription": "Cycles when divide unit is busy executing div=
ide or square root operations.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.DIV_ACTIVE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles when divide unit is busy execu=
ting divide or square root operations. Accounts for integer and floating-po=
int operations.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x9"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
ARITH.FPDIV_ACTIVE",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
+        "Deprecated": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.FP_DIVIDER_ACTIVE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "This event counts the cycles the integer divi=
der is busy.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb0",
         "EventName": "ARITH.IDIV_ACTIVE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
ARITH.IDIV_ACTIVE",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
+        "Deprecated": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.INT_DIVIDER_ACTIVE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x8"
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
rocode assist is invoked by hardware. Examples include AD (page Access Dirt=
y), FP and AVX related assists.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x1b"
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
         "SampleAfterValue": "400009"
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
         "SampleAfterValue": "400009",
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
         "SampleAfterValue": "400009",
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
         "SampleAfterValue": "400009",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Miss-predicted near indirect branch instructi=
ons retired (excluding returns)",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts miss-predicted near indirect branch i=
nstructions retired excluding returns. TSX abort is an indirect branch.",
         "SampleAfterValue": "100003",
         "UMask": "0x80"
     },
     {
         "BriefDescription": "Mispredicted indirect CALL retired.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts retired mispredicted indirect (near t=
aken) CALL instructions, including both register and memory indirect.",
         "SampleAfterValue": "400009",
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
         "SampleAfterValue": "400009",
         "UMask": "0x20"
     },
     {
         "BriefDescription": "This event counts the number of mispredicted =
ret instructions retired. Non PEBS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RET",
         "PEBS": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "This is a non-precise version (that is, does=
 not use PEBS) of the event that counts mispredicted return instructions re=
tired.",
         "SampleAfterValue": "100007",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Core clocks when the thread is in the C0.1 li=
ght-weight slower wakeup time but more power saving optimized state.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.C01",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 light-weight slower wakeup time but more power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Core clocks when the thread is in the C0.2 li=
ght-weight faster wakeup time but less power saving optimized state.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.C02",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts core clocks when the thread is in the=
 C0.2 light-weight faster wakeup time but less power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x20"
     },
     {
         "BriefDescription": "Core clocks when the thread is in the C0.1 or=
 C0.2 or running a PAUSE in C0 ACPI state.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.C0_WAIT",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 or C0.2 power saving optimized states (TPAUSE or UMWAIT instructions)=
 or running the PAUSE instruction.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x70"
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
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts Core crystal clock cycles when curren=
t thread is unhalted and the other thread is halted.",
         "SampleAfterValue": "25003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "CPU_CLK_UNHALTED.PAUSE",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.PAUSE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x40"
     },
     {
         "BriefDescription": "CPU_CLK_UNHALTED.PAUSE_INST",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.PAUSE_INST",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x40"
     },
     {
         "BriefDescription": "Core crystal clock cycles. Cycle counts are e=
venly distributed between active threads in the Core.",
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
can approximate elapsed time while the core was not in a halt state. It is =
counted on a dedicated fixed counter, leaving the eight programmable counte=
rs available for other events. Note: On all current platforms this event st=
ops counting during 'throttling (TM)' states duty off periods the processor=
 is 'halted'.  The counter update is done at a lower clock rate then the co=
re clock the overflow status bit for this counter may appear 'sticky'.  Aft=
er the counter has overflowed and software clears the overflow status bit a=
nd resets the counter to less than MAX. The reset value to the counter is n=
ot clocked immediately so the overflow status bit will flip 'high (1)' and =
generate another PMI (if enabled) after which the reset value gets clocked =
into the counter. Therefore, software will get the interrupt, read the over=
flow status bit '1 for bit 34 while the counter value is less than MAX. Sof=
tware should ignore this case.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x3"
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. It is =
counted on a dedicated fixed counter, leaving the four (eight when Hyperthr=
eading is disabled) programmable counters available for other events. Note:=
 On all current platforms this event stops counting during 'throttling (TM)=
' states duty off periods the processor is 'halted'.  The counter update is=
 done at a lower clock rate then the core clock the overflow status bit for=
 this counter may appear 'sticky'.  After the counter has overflowed and so=
ftware clears the overflow status bit and resets the counter to less than M=
AX. The reset value to the counter is not clocked immediately so the overfl=
ow status bit will flip 'high (1)' and generate another PMI (if enabled) af=
ter which the reset value gets clocked into the counter. Therefore, softwar=
e will get the interrupt, read the overflow status bit '1 for bit 34 while =
the counter value is less than MAX. Software should ignore this case.",
         "SampleAfterValue": "2000003",
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
         "EventCode": "0x3c",
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
         "EventCode": "0xa3",
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
         "EventCode": "0xa3",
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
         "EventCode": "0xa3",
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
         "EventCode": "0xa3",
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
         "BriefDescription": "Execution stalls while memory subsystem has a=
n outstanding load.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "5",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.BOUND_ON_LOADS",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x21"
     },
     {
         "BriefDescription": "Cycles where the Store Buffer was full and no=
 loads caused an execution stall.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "2",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.BOUND_ON_STORES",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles where the Store Buffer was ful=
l and no loads caused an execution stall.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x40"
     },
     {
         "BriefDescription": "Cycles no uop executed while RS was not empty=
, the SB was not full and there was no outstanding load.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.EXE_BOUND_0_PORTS",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of cycles total of 0 uops executed on=
 all ports, Reservation Station (RS) was not empty, the Store Buffer (SB) w=
as not full and there was no outstanding load.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x80"
     },
     {
         "BriefDescription": "Instruction decoders utilized in a cycle",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x75",
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
         "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
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
-        "PEBScounters": "1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
         "SampleAfterValue": "2000003"
     },
     {
         "BriefDescription": "INST_RETIRED.MACRO_FUSED",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.MACRO_FUSED",
-        "PEBScounters": "1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Retired NOP instructions.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.NOP",
-        "PEBScounters": "1,2,3,4,5,6,7",
         "PublicDescription": "Counts all retired NOP or ENDBR32/64 instruc=
tions",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Precise instruction retired with PEBS precise=
-distribution",
-        "CollectPEBSRecord": "2",
-        "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.PREC_DIST",
         "PEBS": "1",
-        "PEBScounters": "32",
         "PublicDescription": "A version of INST_RETIRED that allows for a =
precise distribution of samples across instructions retired. It utilizes th=
e Precise Distribution of Instructions Retired (PDIR++) feature to fix bias=
 in how retired instructions get sampled. Use on Fixed Counter 0.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "INST_RETIRED.REP_ITERATION",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.REP_ITERATION",
-        "PEBScounters": "1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Counts cycles after recovery from a branch mi=
sprediction or machine clear till the first uop is issued from the resteere=
d path.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
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
         "BriefDescription": "INT_MISC.MBA_STALLS",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.MBA_STALLS",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x20"
     },
     {
         "BriefDescription": "Core cycles the allocator was stalled due to =
recovery from earlier clear event for this thread",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
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
         "BriefDescription": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x7",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
-        "TakenAlone": "1",
         "UMask": "0x40"
     },
     {
         "BriefDescription": "TMA slots where uops got dropped",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.UOP_DROPPING",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Estimated number of Top-down Microarchitectu=
re Analysis slots that got dropped due to non front-end reasons",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "INT_VEC_RETIRED.128BIT",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.128BIT",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
         "UMask": "0x13"
     },
     {
         "BriefDescription": "INT_VEC_RETIRED.256BIT",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.256BIT",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
         "UMask": "0xac"
     },
     {
         "BriefDescription": "integer ADD, SUB, SAD 128-bit vector instruct=
ions.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.ADD_128",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 128-bit vector instructions.",
         "SampleAfterValue": "1000003",
         "UMask": "0x3"
     },
     {
         "BriefDescription": "integer ADD, SUB, SAD 256-bit vector instruct=
ions.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.ADD_256",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 256-bit vector instructions.",
         "SampleAfterValue": "1000003",
         "UMask": "0xc"
     },
     {
         "BriefDescription": "INT_VEC_RETIRED.MUL_256",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.MUL_256",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
         "UMask": "0x80"
     },
     {
         "BriefDescription": "INT_VEC_RETIRED.SHUFFLES",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.SHUFFLES",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
         "UMask": "0x40"
     },
     {
         "BriefDescription": "INT_VEC_RETIRED.VNNI_128",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.VNNI_128",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "INT_VEC_RETIRED.VNNI_256",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.VNNI_256",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
         "UMask": "0x20"
     },
     {
         "BriefDescription": "False dependencies in MOB due to partial comp=
are on address.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of times a load got blocke=
d due to false dependencies in MOB due to partial compare on address.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x4"
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
         "UMask": "0x88"
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
         "UMask": "0x82"
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
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xa8",
         "EventName": "LSD.CYCLES_ACTIVE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
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
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "6",
         "EventCode": "0xa8",
         "EventName": "LSD.CYCLES_OK",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the cycles when optimal number of uop=
s is delivered by the LSD (Loop-stream detector).",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Number of Uops delivered by the LSD.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa8",
         "EventName": "LSD.UOPS",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
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
         "BriefDescription": "MISC2_RETIRED.LFENCE",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe0",
         "EventName": "MISC2_RETIRED.LFENCE",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "400009",
-        "Speculative": "1",
         "UMask": "0x20"
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
n call stack mode). The event requires LBR enable via IA32_DEBUGCTL MSR and=
 branch type selection via MSR_LBR_SELECT.",
         "SampleAfterValue": "100003",
         "UMask": "0x20"
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
         "BriefDescription": "TMA slots where no uops were being issued due=
 to lack of back-end resources.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of slots in TMA method where no micro=
-operations were being issued from front-end to back-end of the machine due=
 to lack of back-end resources.",
         "SampleAfterValue": "10000003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "TMA slots wasted due to incorrect speculation=
s.",
-        "CollectPEBSRecord": "2",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BAD_SPEC_SLOTS",
         "PublicDescription": "Number of slots of TMA method that were wast=
ed due to incorrect speculation. It covers all types of control-flow or dat=
a-related mis-speculations.",
         "SampleAfterValue": "10000003",
-        "Speculative": "1",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "TMA slots wasted due to incorrect speculation=
 by branch mispredictions",
-        "CollectPEBSRecord": "2",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
         "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by (any type of) branch mispredictions. This event es=
timates number of specualtive operations that were issued but not retired a=
s well as the out-of-order engine recovery past a branch misprediction.",
         "SampleAfterValue": "10000003",
-        "Speculative": "1",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "TOPDOWN.MEMORY_BOUND_SLOTS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.MEMORY_BOUND_SLOTS",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "10000003",
-        "Speculative": "1",
         "UMask": "0x10"
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
         "BriefDescription": "UOPS_DECODED.DEC0_UOPS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x76",
         "EventName": "UOPS_DECODED.DEC0_UOPS",
-        "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Uops executed on port 0",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_0",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of uops dispatch to execution  port 0=
.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Uops executed on port 1",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of uops dispatch to execution  port 1=
.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Uops executed on ports 2, 3 and 10",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_2_3_10",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of uops dispatch to execution ports 2=
, 3 and 10",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Uops executed on ports 4 and 9",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_4_9",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of uops dispatch to execution ports 4=
 and 9",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Uops executed on ports 5 and 11",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_5_11",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of uops dispatch to execution ports 5=
 and 11",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x20"
     },
     {
         "BriefDescription": "Uops executed on port 6",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_6",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of uops dispatch to execution  port 6=
.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x40"
     },
     {
         "BriefDescription": "Uops executed on ports 7 and 8",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_7_8",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of uops dispatch to execution  ports =
7 and 8.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x80"
     },
     {
         "BriefDescription": "Number of uops executed on the core.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb1",
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
         "EventCode": "0xb1",
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
         "EventCode": "0xb1",
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
         "EventCode": "0xb1",
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
         "EventCode": "0xb1",
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
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.STALLS",
         "Invert": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles during which no uops were disp=
atched from the Reservation Station (RS) per thread.",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
UOPS_EXECUTED.STALLS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
+        "Deprecated": "1",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.STALL_CYCLES",
         "Invert": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
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
         "EventCode": "0xb1",
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
         "EventCode": "0xae",
         "EventName": "UOPS_ISSUED.ANY",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of uops that the Resource =
Allocation Table (RAT) issues to the Reservation Station (RS).",
         "SampleAfterValue": "2000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Cycles with retired uop(s).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.CYCLES",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles where at least one uop has ret=
ired.",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Retired uops except the last uop of each inst=
ruction.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.HEAVY",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of retired micro-operation=
s (uops) except the last uop of each instruction. An instruction that is de=
coded into less than two uops does not contribute to the count.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "UOPS_RETIRED.MS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.MS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x8",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
-        "TakenAlone": "1",
         "UMask": "0x4"
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
         "EventName": "UOPS_RETIRED.STALLS",
         "Invert": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "This event counts cycles without actually re=
tired uops.",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
UOPS_RETIRED.STALLS",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
+        "Deprecated": "1",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.STALL_CYCLES",
         "Invert": "1",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     }
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json=
 b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
index 9ec42a68c160..ce18fc458e37 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
@@ -1,1643 +1,1616 @@
 [
     {
-        "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
-        "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.UO=
P_DROPPING / SLOTS",
-        "MetricGroup": "PGO;TopdownL1;tma_L1_group",
-        "MetricName": "tma_frontend_bound",
-        "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Machine_Width uops every c=
ycle to the Backend. Frontend Bound denotes unutilized issue-slots when the=
re is no Backend stall; i.e. bubbles where Frontend delivered no uops while=
 Backend could have accepted them. For example; stalls due to instruction-c=
ache misses would be categorized under Frontend Bound. Sample with: FRONTEN=
D_RETIRED.LATENCY_GE_4_PS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
+        "MetricExpr": "100 * (tma_branch_mispredicts + tma_fetch_latency *=
 tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_i=
cache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts",
+        "MetricName": "Mispredictions"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues",
-        "MetricExpr": "(topdown\\-fetch\\-lat / (topdown\\-fe\\-bound + to=
pdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.=
UOP_DROPPING / SLOTS)",
-        "MetricGroup": "Frontend;TopdownL2;tma_L2_group;tma_frontend_bound=
_group",
-        "MetricName": "tma_fetch_latency",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend latency issues.  For example; instruction-=
cache misses; iTLB misses or fetch stalls after a branch misprediction are =
categorized under Frontend Latency. In such cases; the Frontend eventually =
delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_=
16_PS;FRONTEND_RETIRED.LATENCY_GE_8_PS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Total pipeline cost of (external) Memory Band=
width related bottlenecks",
+        "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma_=
store_bound) * (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) =
+ tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bou=
nd + tma_pmm_bound + tma_store_bound) * (tma_sq_full / (tma_contested_acces=
ses + tma_data_sharing + tma_l3_hit_latency + tma_sq_full))) + tma_l1_bound=
 / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_b=
ound + tma_store_bound) * (tma_fb_full / (tma_dtlb_load + tma_fb_full + tma=
_lock_latency + tma_split_loads + tma_store_fwd_blk))",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "Memory_Bandwidth"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses",
-        "MetricExpr": "ICACHE_DATA.STALLS / CLKS",
-        "MetricGroup": "BigFoot;FetchLat;IcMiss;TopdownL3;tma_fetch_latenc=
y_group",
-        "MetricName": "tma_icache_misses",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to instruction cache misses. Sample with: FRONTEND_RE=
TIRED.L2_MISS_PS;FRONTEND_RETIRED.L1I_MISS_PS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Total pipeline cost of Memory Latency related=
 bottlenecks (external memory and off-core caches)",
+        "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma_=
store_bound) * (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + =
tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound=
 + tma_pmm_bound + tma_store_bound) * (tma_l3_hit_latency / (tma_contested_=
accesses + tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_l2_b=
ound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_p=
mm_bound + tma_store_bound))",
+        "MetricGroup": "Mem;MemoryLat;Offcore",
+        "MetricName": "Memory_Latency"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
-        "MetricExpr": "ICACHE_TAG.STALLS / CLKS",
-        "MetricGroup": "BigFoot;FetchLat;MemoryTLB;TopdownL3;tma_fetch_lat=
ency_group",
-        "MetricName": "tma_itlb_misses",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: FRONTE=
ND_RETIRED.STLB_MISS_PS;FRONTEND_RETIRED.ITLB_MISS_PS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
+        "MetricExpr": "100 * tma_memory_bound * (tma_l1_bound / max(tma_me=
mory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + t=
ma_pmm_bound + tma_store_bound) * (tma_dtlb_load / max(tma_l1_bound, tma_dt=
lb_load + tma_fb_full + tma_lock_latency + tma_split_loads + tma_store_fwd_=
blk)) + tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + t=
ma_l3_bound + tma_pmm_bound + tma_store_bound) * (tma_dtlb_store / (tma_dtl=
b_store + tma_false_sharing + tma_split_stores + tma_store_latency + tma_st=
reaming_stores)))",
+        "MetricGroup": "Mem;MemoryTLB;Offcore",
+        "MetricName": "Memory_Data_TLBs"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers",
-        "MetricExpr": "INT_MISC.CLEAR_RESTEER_CYCLES / CLKS + tma_unknown_=
branches",
-        "MetricGroup": "FetchLat;TopdownL3;tma_fetch_latency_group",
-        "MetricName": "tma_branch_resteers",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fro=
ntend delay in fetching operations from corrected path; following all sorts=
 of miss-predicted branches. For example; branchy code with lots of miss-pr=
edictions might get categorized under Branch Resteers. Note the value of th=
is node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_BRA=
NCHES",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Total pipeline cost of branch related instruc=
tions (used for program control-flow including function calls)",
+        "MetricExpr": "100 * ((BR_INST_RETIRED.COND + 3 * BR_INST_RETIRED.=
NEAR_CALL + (BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.COND_TAKEN - 2 * =
BR_INST_RETIRED.NEAR_CALL)) / SLOTS)",
+        "MetricGroup": "Ret",
+        "MetricName": "Branching_Overhead"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Branch Misprediction=
 at execution stage",
-        "MetricExpr": "(tma_branch_mispredicts / tma_bad_speculation) * IN=
T_MISC.CLEAR_RESTEER_CYCLES / CLKS",
-        "MetricGroup": "BadSpec;BrMispredicts;TopdownL4;tma_branch_resteer=
s_group",
-        "MetricName": "tma_mispredicts_resteers",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage.  Sample with: INT_MISC.CLEAR_RESTEER_CYCLES",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
+        "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_branch_resteers + tma_dsb_switch=
es + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)",
+        "MetricGroup": "BigFoot;Fed;Frontend;IcMiss;MemoryTLB",
+        "MetricName": "Big_Code"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Machine Clears",
-        "MetricExpr": "(1 - (tma_branch_mispredicts / tma_bad_speculation)=
) * INT_MISC.CLEAR_RESTEER_CYCLES / CLKS",
-        "MetricGroup": "BadSpec;MachineClears;TopdownL4;tma_branch_resteer=
s_group",
-        "MetricName": "tma_clears_resteers",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Machine Clears.  Sa=
mple with: INT_MISC.CLEAR_RESTEER_CYCLES",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks",
+        "MetricExpr": "100 * (tma_frontend_bound - tma_fetch_latency * tma=
_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icach=
e_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) - Big_Code",
+        "MetricGroup": "Fed;FetchBW;Frontend",
+        "MetricName": "Instruction_Fetch_BW"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to new branch address clears",
-        "MetricExpr": "INT_MISC.UNKNOWN_BRANCH_CYCLES / CLKS",
-        "MetricGroup": "BigFoot;FetchLat;TopdownL4;tma_branch_resteers_gro=
up",
-        "MetricName": "tma_unknown_branches",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to new branch address clears. These are fetched branc=
hes the Branch Prediction Unit was unable to recognize (First fetch or hitt=
ing BPU capacity limit). Sample with: FRONTEND_RETIRED.UNKNOWN_BRANCH",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
+        "MetricExpr": "INST_RETIRED.ANY / CLKS",
+        "MetricGroup": "Ret;Summary",
+        "MetricName": "IPC"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to switches from DSB to MITE pipelines",
-        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / CLKS",
-        "MetricGroup": "DSBmiss;FetchLat;TopdownL3;tma_fetch_latency_group=
",
-        "MetricName": "tma_dsb_switches",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS_PS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Uops Per Instruction",
+        "MetricExpr": "tma_retiring * SLOTS / INST_RETIRED.ANY",
+        "MetricGroup": "Pipeline;Ret;Retire",
+        "MetricName": "UPI"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles CPU=
 was stalled due to Length Changing Prefixes (LCPs)",
-        "MetricExpr": "DECODE.LCP / CLKS",
-        "MetricGroup": "FetchLat;TopdownL3;tma_fetch_latency_group",
-        "MetricName": "tma_lcp",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Instruction per taken branch",
+        "MetricExpr": "tma_retiring * SLOTS / BR_INST_RETIRED.NEAR_TAKEN",
+        "MetricGroup": "Branches;Fed;FetchBW",
+        "MetricName": "UpTB"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS)",
-        "MetricExpr": "3 * IDQ.MS_SWITCHES / CLKS",
-        "MetricGroup": "FetchLat;MicroSeq;TopdownL3;tma_fetch_latency_grou=
p",
-        "MetricName": "tma_ms_switches",
-        "PublicDescription": "This metric estimates the fraction of cycles=
 when the CPU was stalled due to switches of uop delivery to the Microcode =
Sequencer (MS). Commonly used instructions are optimized for delivery by th=
e DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Cert=
ain operations cannot be handled natively by the execution pipeline; and mu=
st be performed by microcode (small programs injected into the execution st=
ream). Switching to the MS too often can negatively impact performance. The=
 MS is designated to deliver long uop flows required by CISC instructions l=
ike CPUID; or uncommon conditions like Floating Point Assists when dealing =
with Denormals. Sample with: FRONTEND_RETIRED.MS_FLOWS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
+        "MetricExpr": "1 / IPC",
+        "MetricGroup": "Mem;Pipeline",
+        "MetricName": "CPI"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend bandwidth issues",
-        "MetricExpr": "max(0, tma_frontend_bound - tma_fetch_latency)",
-        "MetricGroup": "FetchBW;Frontend;TopdownL2;tma_L2_group;tma_fronte=
nd_bound_group",
-        "MetricName": "tma_fetch_bandwidth",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LA=
TENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "Pipeline",
+        "MetricName": "CLKS"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the MITE pipeline (the legacy deco=
de pipeline)",
-        "MetricExpr": "(IDQ.MITE_CYCLES_ANY - IDQ.MITE_CYCLES_OK) / CORE_C=
LKS / 2",
-        "MetricGroup": "DSBmiss;FetchBW;TopdownL3;tma_fetch_bandwidth_grou=
p",
-        "MetricName": "tma_mite",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to the MITE pipeline (the legacy dec=
ode pipeline). This pipeline is used for code that was not pre-cached in th=
e DSB or LSD. For example; inefficiencies due to asymmetric decoders; use o=
f long immediate or LCP can manifest as MITE fetch bandwidth bottleneck. Sa=
mple with: FRONTEND_RETIRED.ANY_DSB_MISS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
+        "MetricExpr": "TOPDOWN.SLOTS",
+        "MetricGroup": "tma_L1_group",
+        "MetricName": "SLOTS"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles whe=
re decoder-0 was the only active decoder",
-        "MetricExpr": "(cpu@INST_DECODED.DECODERS\\,cmask\\=3D1@ - cpu@INS=
T_DECODED.DECODERS\\,cmask\\=3D2@) / CORE_CLKS",
-        "MetricGroup": "DSBmiss;FetchBW;TopdownL4;tma_mite_group",
-        "MetricName": "tma_decoder0_alone",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Fraction of Physical Core issue-slots utilize=
d by this Logical Processor",
+        "MetricExpr": "(SLOTS / (TOPDOWN.SLOTS / 2) if #SMT_on else 1)",
+        "MetricGroup": "SMT;tma_L1_group",
+        "MetricName": "Slots_Utilization"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to DSB (decoded uop cache) fetch pipe=
line",
-        "MetricExpr": "(IDQ.DSB_CYCLES_ANY - IDQ.DSB_CYCLES_OK) / CORE_CLK=
S / 2",
-        "MetricGroup": "DSB;FetchBW;TopdownL3;tma_fetch_bandwidth_group",
-        "MetricName": "tma_dsb",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "The ratio of Executed- by Issued-Uops",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / UOPS_ISSUED.ANY",
+        "MetricGroup": "Cor;Pipeline",
+        "MetricName": "Execute_per_Issue",
+        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage."
     },
     {
-        "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
-        "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_bound + t=
ma_retiring), 0)",
-        "MetricGroup": "TopdownL1;tma_L1_group",
-        "MetricName": "tma_bad_speculation",
-        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Instructions Per Cycle across hyper-threads (=
per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / CORE_CLKS",
+        "MetricGroup": "Ret;SMT;tma_L1_group",
+        "MetricName": "CoreIPC"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction",
-        "MetricExpr": "topdown\\-br\\-mispredict / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0*SLOT=
S",
-        "MetricGroup": "BadSpec;BrMispredicts;TopdownL2;tma_L2_group;tma_b=
ad_speculation_group",
-        "MetricName": "tma_branch_mispredicts",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: TOPDOWN.BR_MISPREDICT_SLOTS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE + FP_ARITH_INST_RETIRED2.SCALAR_HALF + 2 * (FP_ARIT=
H_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED2.COMPLEX_SCALAR_H=
ALF) + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRE=
D.256B_PACKED_DOUBLE) + 8 * (FP_ARITH_INST_RETIRED2.128B_PACKED_HALF + FP_A=
RITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DO=
UBLE) + 16 * (FP_ARITH_INST_RETIRED2.256B_PACKED_HALF + FP_ARITH_INST_RETIR=
ED.512B_PACKED_SINGLE) + 32 * FP_ARITH_INST_RETIRED2.512B_PACKED_HALF + 4 *=
 AMX_OPS_RETIRED.BF16) / CORE_CLKS",
+        "MetricGroup": "Flops;Ret",
+        "MetricName": "FLOPc"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Machine Clears",
-        "MetricExpr": "max(0, tma_bad_speculation - tma_branch_mispredicts=
)",
-        "MetricGroup": "BadSpec;MachineClears;TopdownL2;tma_L2_group;tma_b=
ad_speculation_group",
-        "MetricName": "tma_machine_clears",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Machine Clears.  These slots are either wasted by uo=
ps fetched prior to the clear; or stalls the out-of-order portion of the ma=
chine needs to recover its state after the clear. For example; this can hap=
pen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modif=
ying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
+        "MetricExpr": "(FP_ARITH_DISPATCHED.PORT_0 + FP_ARITH_DISPATCHED.P=
ORT_1 + FP_ARITH_DISPATCHED.PORT_5) / (2 * CORE_CLKS)",
+        "MetricGroup": "Cor;Flops;HPC",
+        "MetricName": "FP_Arith_Utilization",
+        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)."
     },
     {
-        "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
-        "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0*SLOTS",
-        "MetricGroup": "TopdownL1;tma_L1_group",
-        "MetricName": "tma_backend_bound",
-        "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
+        "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
+        "MetricName": "ILP"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
-        "MetricExpr": "topdown\\-mem\\-bound / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0*SLOTS",
-        "MetricGroup": "Backend;TopdownL2;tma_L2_group;tma_backend_bound_g=
roup",
-        "MetricName": "tma_memory_bound",
-        "PublicDescription": "This metric represents fraction of slots the=
 Memory subsystem within the Backend was a bottleneck.  Memory Bound estima=
tes fraction of slots where pipeline is likely stalled due to demand load o=
r store instructions. This accounts mainly for (1) non-completed in-flight =
memory demand loads which coincides with execution units starvation; in add=
ition to (2) cases where stores could impose backpressure on the pipeline w=
hen many of them get buffered at the same time (less common out of the two)=
.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
+        "MetricExpr": "((1 - tma_core_bound / tma_ports_utilization if tma=
_core_bound < tma_ports_utilization else 1) if SMT_2T_Utilization > 0.5 els=
e 0)",
+        "MetricGroup": "Cor;SMT",
+        "MetricName": "Core_Bound_Likely"
     },
     {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache",
-        "MetricExpr": "max((EXE_ACTIVITY.BOUND_ON_LOADS - MEMORY_ACTIVITY.=
STALLS_L1D_MISS) / CLKS, 0)",
-        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_mem=
ory_bound_group",
-        "MetricName": "tma_l1_bound",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled without loads missing the L1 data cache.  The L1 data cache typical=
ly has the shortest latency.  However; in certain cases like loads blocked =
on older stores; a load might suffer due to high latency even though it is =
being satisfied by the L1. Another example is loads who miss in the TLB. Th=
ese cases are characterized by execution unit stalls; while some non-comple=
ted demand load lives in the machine without having that demand load missin=
g the L1 cache. Sample with: MEM_LOAD_RETIRED.L1_HIT_PS;MEM_LOAD_RETIRED.FB=
_HIT_PS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
+        "MetricExpr": "CPU_CLK_UNHALTED.DISTRIBUTED",
+        "MetricGroup": "SMT",
+        "MetricName": "CORE_CLKS"
     },
     {
-        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
-        "MetricExpr": "min(7 * cpu@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\\=3D1=
@ + DTLB_LOAD_MISSES.WALK_ACTIVE, max(CYCLE_ACTIVITY.CYCLES_MEM_ANY - MEMOR=
Y_ACTIVITY.CYCLES_L1D_MISS, 0)) / CLKS",
-        "MetricGroup": "MemoryTLB;TopdownL4;tma_l1_bound_group",
-        "MetricName": "tma_dtlb_load",
-        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS_PS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Instructions per Load (lower number means hig=
her occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_LOADS",
+        "MetricGroup": "InsType",
+        "MetricName": "IpLoad"
     },
     {
-        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the (first level) DTLB was missed by load accesses, that late=
r on hit in second-level TLB (STLB)",
-        "MetricExpr": "tma_dtlb_load - tma_load_stlb_miss",
-        "MetricGroup": "MemoryTLB;TopdownL5;tma_dtlb_load_group",
-        "MetricName": "tma_load_stlb_hit",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Instructions per Store (lower number means hi=
gher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_STORES",
+        "MetricGroup": "InsType",
+        "MetricName": "IpStore"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
where the Second-level TLB (STLB) was missed by load accesses, performing a=
 hardware page walk",
-        "MetricExpr": "DTLB_LOAD_MISSES.WALK_ACTIVE / CLKS",
-        "MetricGroup": "MemoryTLB;TopdownL5;tma_dtlb_load_group",
-        "MetricName": "tma_load_stlb_miss",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Branches;Fed;InsType",
+        "MetricName": "IpBranch"
     },
     {
-        "BriefDescription": "This metric roughly estimates fraction of cyc=
les when the memory subsystem had loads blocked since they could not forwar=
d data from earlier (in program order) overlapping stores",
-        "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / CLKS",
-        "MetricGroup": "TopdownL4;tma_l1_bound_group",
-        "MetricName": "tma_store_fwd_blk",
-        "PublicDescription": "This metric roughly estimates fraction of cy=
cles when the memory subsystem had loads blocked since they could not forwa=
rd data from earlier (in program order) overlapping stores. To streamline m=
emory operations in the pipeline; a load can avoid waiting for memory if a =
prior in-flight store is writing the data that the load wants to read (stor=
e forwarding process). However; in some cases the load may be blocked for a=
 significant time pending the store forward. For example; when the prior st=
ore is writing a smaller region than the load is reading.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Instructions per (near) call (lower number me=
ans higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
+        "MetricGroup": "Branches;Fed;PGO",
+        "MetricName": "IpCall"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
-        "MetricExpr": "(16 * max(0, MEM_INST_RETIRED.LOCK_LOADS - L2_RQSTS=
.ALL_RFO) + (MEM_INST_RETIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES) * (=
10 * L2_RQSTS.RFO_HIT + min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DEMAND_RFO))) / CLKS",
-        "MetricGroup": "Offcore;TopdownL4;tma_l1_bound_group",
-        "MetricName": "tma_lock_latency",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them. Sample with: MEM_INST_RETIRED.LOCK_LOA=
DS_PS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Instruction per taken branch",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
+        "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO",
+        "MetricName": "IpTB"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles hand=
ling memory load split accesses - load that cross 64-byte cache line bounda=
ry",
-        "MetricExpr": "Load_Miss_Real_Latency * LD_BLOCKS.NO_SR / CLKS",
-        "MetricGroup": "TopdownL4;tma_l1_bound_group",
-        "MetricName": "tma_split_loads",
-        "PublicDescription": "This metric estimates fraction of cycles han=
dling memory load split accesses - load that cross 64-byte cache line bound=
ary.  Sample with: MEM_INST_RETIRED.SPLIT_LOADS_PS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Branch instructions per taken branch. ",
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
+        "MetricGroup": "Branches;Fed;PGO",
+        "MetricName": "BpTkBranch"
     },
     {
-        "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
-        "MetricExpr": "L1D_PEND_MISS.FB_FULL / CLKS",
-        "MetricGroup": "MemoryBW;TopdownL4;tma_l1_bound_group",
-        "MetricName": "tma_fb_full",
-        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory).",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Instructions per Floating Point (FP) Operatio=
n (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR_SI=
NGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE + FP_ARITH_INST_RETIRED2.SCALAR_=
HALF + 2 * (FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARITH_INST_RETIRE=
D2.COMPLEX_SCALAR_HALF) + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + F=
P_ARITH_INST_RETIRED.256B_PACKED_DOUBLE) + 8 * (FP_ARITH_INST_RETIRED2.128B=
_PACKED_HALF + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RET=
IRED.512B_PACKED_DOUBLE) + 16 * (FP_ARITH_INST_RETIRED2.256B_PACKED_HALF + =
FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE) + 32 * FP_ARITH_INST_RETIRED2.512=
B_PACKED_HALF + 4 * AMX_OPS_RETIRED.BF16)",
+        "MetricGroup": "Flops;InsType",
+        "MetricName": "IpFLOP"
     },
     {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads",
-        "MetricExpr": "(MEMORY_ACTIVITY.STALLS_L1D_MISS - MEMORY_ACTIVITY.=
STALLS_L2_MISS) / CLKS",
-        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_mem=
ory_bound_group",
-        "MetricName": "tma_l2_bound",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_RETIRED.L2_HIT_PS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Instructions per FP Arithmetic instruction (l=
ower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR_SI=
NGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE + FP_ARITH_INST_RETIRED2.SCALAR =
+ (FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PA=
CKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_ARITH_INST_RETI=
RED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.512B_PACKED_SINGLE + FP_ARITH_INST_RETIRED2.VECTOR))",
+        "MetricGroup": "Flops;InsType",
+        "MetricName": "IpArith",
+        "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). May undercount due to FMA doubl=
e counting. Approximated prior to BDW."
     },
     {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
-        "MetricExpr": "(MEMORY_ACTIVITY.STALLS_L2_MISS - MEMORY_ACTIVITY.S=
TALLS_L3_MISS) / CLKS",
-        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_mem=
ory_bound_group",
-        "MetricName": "tma_l3_bound",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Instructions per FP Arithmetic Scalar Single-=
Precision instruction (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED.SCALAR_SIN=
GLE",
+        "MetricGroup": "Flops;FpScalar;InsType",
+        "MetricName": "IpArith_Scalar_SP",
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). May und=
ercount due to FMA double counting."
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
-        "MetricExpr": "((25 * Average_Frequency) * (MEM_LOAD_L3_HIT_RETIRE=
D.XSNP_FWD * (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM / (OCR.DEMAND_DATA_RD.L3=
_HIT.SNOOP_HITM + OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) + (24 * A=
verage_Frequency) * MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS) * (1 + (MEM_LOAD_RET=
IRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) / 2) / CLKS",
-        "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_l3_bound_g=
roup",
-        "MetricName": "tma_contested_accesses",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_FWD;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Instructions per FP Arithmetic Scalar Double-=
Precision instruction (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED.SCALAR_DOU=
BLE",
+        "MetricGroup": "Flops;FpScalar;InsType",
+        "MetricName": "IpArith_Scalar_DP",
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). May und=
ercount due to FMA double counting."
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
-        "MetricExpr": "(24 * Average_Frequency) * (MEM_LOAD_L3_HIT_RETIRED=
.XSNP_NO_FWD + MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD * (1 - (OCR.DEMAND_DATA_RD.=
L3_HIT.SNOOP_HITM / (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM + OCR.DEMAND_DATA=
_RD.L3_HIT.SNOOP_HIT_WITH_FWD)))) * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOA=
D_RETIRED.L1_MISS) / 2) / CLKS",
-        "MetricGroup": "Offcore;Snoop;TopdownL4;tma_l3_bound_group",
-        "MetricName": "tma_data_sharing",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_L3_HIT_RETIRED.XSNP_NO_FWD",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-bi=
t instruction (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.128B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRE=
D2.128B_PACKED_HALF)",
+        "MetricGroup": "Flops;FpVector;InsType",
+        "MetricName": "IpArith_AVX128",
+        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). May undercount =
due to FMA double counting."
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited)",
-        "MetricExpr": "(9 * Average_Frequency) * MEM_LOAD_RETIRED.L3_HIT *=
 (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) / 2) / CLKS",
-        "MetricGroup": "MemoryLat;TopdownL4;tma_l3_bound_group",
-        "MetricName": "tma_l3_hit_latency",
-        "PublicDescription": "This metric represents fraction of cycles wi=
th demand load accesses that hit the L3 cache under unloaded scenarios (pos=
sibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L=
3 hits) will improve the latency; reduce contention with sibling physical c=
ores and increase performance.  Note the value of this node may overlap wit=
h its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Instructions per FP Arithmetic AVX* 256-bit i=
nstruction (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.256B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRE=
D2.256B_PACKED_HALF)",
+        "MetricGroup": "Flops;FpVector;InsType",
+        "MetricName": "IpArith_AVX256",
+        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). May undercount due=
 to FMA double counting."
     },
     {
-        "BriefDescription": "This metric measures fraction of cycles where=
 the Super Queue (SQ) was full taking into account all request-types and bo=
th hardware SMT threads (Logical Processors)",
-        "MetricExpr": "(XQ.FULL_CYCLES + L1D_PEND_MISS.L2_STALLS) / CLKS",
-        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_l3_bound_group",
-        "MetricName": "tma_sq_full",
-        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). The Super Queue is used for =
requests to access the L2 cache or to go out to the Uncore.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Instructions per FP Arithmetic AVX 512-bit in=
struction (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.512B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE + FP_ARITH_INST_RETIRE=
D2.512B_PACKED_HALF)",
+        "MetricGroup": "Flops;FpVector;InsType",
+        "MetricName": "IpArith_AVX512",
+        "PublicDescription": "Instructions per FP Arithmetic AVX 512-bit i=
nstruction (lower number means higher occurrence rate). May undercount due =
to FMA double counting."
     },
     {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
-        "MetricExpr": "((MEMORY_ACTIVITY.STALLS_L3_MISS / CLKS) - tma_pmm_=
bound)",
-        "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_memory_bound_gr=
oup",
-        "MetricName": "tma_dram_bound",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_RETIRED=
.L3_MISS_PS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Instructions per FP Arithmetic AMX operation =
(lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / AMX_OPS_RETIRED.BF16",
+        "MetricGroup": "Flops;FpVector;InsType;Server",
+        "MetricName": "IpArith_AMX_F16",
+        "PublicDescription": "Instructions per FP Arithmetic AMX operation=
 (lower number means higher occurrence rate). Operations factored per matri=
ces' sizes of the AMX instructions."
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory (DRAM)",
-        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / CLKS",
-        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_dram_bound_group",
-        "MetricName": "tma_mem_bandwidth",
-        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory (DRAM).  The underlying heuristic assumes that a simi=
lar off-core traffic is generated by all IA cores. This metric does not agg=
regate non-data-read requests by this logical processor; requests from othe=
r IA Logical Processors/Physical Cores/sockets; or other non-IA devices lik=
e GPU; hence the maximum external memory bandwidth limits may or may not be=
 approached when this metric is flagged (see Uncore counters for that).",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Instructions per Integer Arithmetic AMX opera=
tion (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / AMX_OPS_RETIRED.INT8",
+        "MetricGroup": "InsType;IntVector;Server",
+        "MetricName": "IpArith_AMX_Int8",
+        "PublicDescription": "Instructions per Integer Arithmetic AMX oper=
ation (lower number means higher occurrence rate). Operations factored per =
matrices' sizes of the AMX instructions."
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to memory bandwidth Allocation=
 feature (RDT's memory bandwidth throttling).",
-        "MetricExpr": "INT_MISC.MBA_STALLS / CLKS",
-        "MetricGroup": "MemoryBW;Offcore;Server;TopdownL5;tma_mem_bandwidt=
h_group",
-        "MetricName": "tma_mba_stalls",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Instructions per Software prefetch instructio=
n (of any type: NTA/T0/T1/T2/Prefetch) (lower number means higher occurrenc=
e rate)",
+        "MetricExpr": "INST_RETIRED.ANY / cpu@SW_PREFETCH_ACCESS.T0\\,umas=
k\\=3D0xF@",
+        "MetricGroup": "Prefetches",
+        "MetricName": "IpSWPF"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles wher=
e the performance was likely hurt due to latency from external memory (DRAM=
)",
-        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DATA_RD) / CLKS - tma_mem_bandwidth",
-        "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_dram_bound_group",
-        "MetricName": "tma_mem_latency",
-        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory (DRA=
M).  This metric does not aggregate requests from other Logical Processors/=
Physical Cores/sockets (see Uncore counters for that).",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Total number of retired Instructions Sample w=
ith: INST_RETIRED.PREC_DIST",
+        "MetricExpr": "INST_RETIRED.ANY",
+        "MetricGroup": "Summary;tma_L1_group",
+        "MetricName": "Instructions"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from local memory",
-        "MetricExpr": "(54.5 * Average_Frequency) * MEM_LOAD_L3_MISS_RETIR=
ED.LOCAL_DRAM * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) /=
 2) / CLKS",
-        "MetricGroup": "Server;TopdownL5;tma_mem_latency_group",
-        "MetricName": "tma_local_dram",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from local memory. Caching will =
improve the latency and increase performance. Sample with: MEM_LOAD_L3_MISS=
_RETIRED.LOCAL_DRAM_PS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
+        "MetricExpr": "tma_retiring * SLOTS / cpu@UOPS_RETIRED.SLOTS\\,cma=
sk\\=3D1@",
+        "MetricGroup": "Pipeline;Ret",
+        "MetricName": "Retire"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote memory",
-        "MetricExpr": "(119 * Average_Frequency) * MEM_LOAD_L3_MISS_RETIRE=
D.REMOTE_DRAM * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) /=
 2) / CLKS",
-        "MetricGroup": "Server;Snoop;TopdownL5;tma_mem_latency_group",
-        "MetricName": "tma_remote_dram",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote memory. This is caus=
ed often due to non-optimal NUMA allocations. #link to NUMA article Sample =
with: MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Estimated fraction of retirement-cycles deali=
ng with repeat instructions",
+        "MetricExpr": "INST_RETIRED.REP_ITERATION / cpu@UOPS_RETIRED.SLOTS=
\\,cmask\\=3D1@",
+        "MetricGroup": "Pipeline;Ret",
+        "MetricName": "Strings_Cycles"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote cache in other socket=
s including synchronizations issues",
-        "MetricExpr": "((108 * Average_Frequency) * MEM_LOAD_L3_MISS_RETIR=
ED.REMOTE_HITM + (108 * Average_Frequency) * MEM_LOAD_L3_MISS_RETIRED.REMOT=
E_FWD) * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) / 2) / C=
LKS",
-        "MetricGroup": "Offcore;Server;Snoop;TopdownL5;tma_mem_latency_gro=
up",
-        "MetricName": "tma_remote_cache",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote cache in other socke=
ts including synchronizations issues. This is caused often due to non-optim=
al NUMA allocations. #link to NUMA article Sample with: MEM_LOAD_L3_MISS_RE=
TIRED.REMOTE_HITM_PS;MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD_PS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Instructions per a microcode Assist invocatio=
n. See Assists tree node for details (lower number means higher occurrence =
rate)",
+        "MetricExpr": "INST_RETIRED.ANY / cpu@ASSISTS.ANY\\,umask\\=3D0x1B=
@",
+        "MetricGroup": "Pipeline;Ret;Retire",
+        "MetricName": "IpAssist"
     },
     {
-        "BriefDescription": "This metric roughly estimates (based on idle =
latencies) how often the CPU was stalled on accesses to external 3D-Xpoint =
(Crystal Ridge, a.k.a",
-        "MetricExpr": "(((1 - ((19 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM=
 * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))) + 10 * ((MEM=
_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD=
_RETIRED.L1_MISS))) + (MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * (1 + (MEM_LOAD=
_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))) + (MEM_LOAD_L3_MISS_RETIRED.R=
EMOTE_HITM * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))))) =
/ ((19 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM * (1 + (MEM_LOAD_RETIRED.FB_=
HIT / MEM_LOAD_RETIRED.L1_MISS))) + 10 * ((MEM_LOAD_L3_MISS_RETIRED.LOCAL_D=
RAM * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))) + (MEM_LO=
AD_L3_MISS_RETIRED.REMOTE_FWD * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RE=
TIRED.L1_MISS))) + (MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM * (1 + (MEM_LOAD_R=
ETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))))) + (25 * (MEM_LOAD_RETIRED.LOC=
AL_PMM * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))) + 33 *=
 (MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM * (1 + (MEM_LOAD_RETIRED.FB_HIT / MEM=
_LOAD_RETIRED.L1_MISS))))))) * (MEMORY_ACTIVITY.STALLS_L3_MISS / CLKS)) if =
(1000000 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM + MEM_LOAD_RETIRED.LOCAL_PM=
M) > MEM_LOAD_RETIRED.L1_MISS) else 0)",
-        "MetricGroup": "MemoryBound;Server;TmaL3mem;TopdownL3;tma_memory_b=
ound_group",
-        "MetricName": "tma_pmm_bound",
-        "PublicDescription": "This metric roughly estimates (based on idle=
 latencies) how often the CPU was stalled on accesses to external 3D-Xpoint=
 (Crystal Ridge, a.k.a. IXP) memory by loads, PMM stands for Persistent Mem=
ory Module. ",
-        "ScaleUnit": "100%"
+        "BriefDescription": "",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D1@",
+        "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
+        "MetricName": "Execute"
     },
     {
-        "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to RFO store memory accesses; RFO store issue a read-for-ownership =
request before the write",
-        "MetricExpr": "EXE_ACTIVITY.BOUND_ON_STORES / CLKS",
-        "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_memory_bound_gr=
oup",
-        "MetricName": "tma_store_bound",
-        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to RFO store memory accesses; RFO store issue a read-for-ownership=
 request before the write. Even though store accesses do not typically stal=
l out-of-order CPUs; there are few cases where stores can lead to actual st=
alls. This metric will be flagged should RFO stores be a bottleneck. Sample=
 with: MEM_INST_RETIRED.ALL_STORES_PS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average number of Uops issued by front-end wh=
en it issued something",
+        "MetricExpr": "UOPS_ISSUED.ANY / cpu@UOPS_ISSUED.ANY\\,cmask\\=3D1=
@",
+        "MetricGroup": "Fed;FetchBW",
+        "MetricName": "Fetch_UpC"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
-        "MetricExpr": "((MEM_STORE_RETIRED.L2_HIT * 10 * (1 - (MEM_INST_RE=
TIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES))) + (1 - (MEM_INST_RETIRED.=
LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES)) * min(CPU_CLK_UNHALTED.THREAD, O=
FFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / CLKS",
-        "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_store_bound_group"=
,
-        "MetricName": "tma_store_latency",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full)",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
+        "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + IDQ.MITE_UOPS + IDQ.=
MS_UOPS)",
+        "MetricGroup": "DSB;Fed;FetchBW",
+        "MetricName": "DSB_Coverage"
     },
     {
-        "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
-        "MetricExpr": "(28 * Average_Frequency) * OCR.DEMAND_RFO.L3_HIT.SN=
OOP_HITM / CLKS",
-        "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_store_boun=
d_group",
-        "MetricName": "tma_false_sharing",
-        "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line.  Sample with: OCR.DEMAND_RFO.=
L3_HIT.SNOOP_HITM",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
.",
+        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / cpu@DSB2MITE_SWI=
TCHES.PENALTY_CYCLES\\,cmask\\=3D1\\,edge@",
+        "MetricGroup": "DSBmiss",
+        "MetricName": "DSB_Switch_Cost"
+    },
+    {
+        "BriefDescription": "Total penalty related to DSB (uop cache) miss=
es - subset of the Instruction_Fetch_BW Bottleneck.",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + =
tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb + tm=
a_mite))",
+        "MetricGroup": "DSBmiss;Fed",
+        "MetricName": "DSB_Misses"
     },
     {
-        "BriefDescription": "This metric represents rate of split store ac=
cesses",
-        "MetricExpr": "MEM_INST_RETIRED.SPLIT_STORES / CORE_CLKS",
-        "MetricGroup": "TopdownL4;tma_store_bound_group",
-        "MetricName": "tma_split_stores",
-        "PublicDescription": "This metric represents rate of split store a=
ccesses.  Consider aligning your data to the 64-byte cache line granularity=
. Sample with: MEM_INST_RETIRED.SPLIT_STORES_PS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Number of Instructions per non-speculative DS=
B miss (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / FRONTEND_RETIRED.ANY_DSB_MISS",
+        "MetricGroup": "DSBmiss;Fed",
+        "MetricName": "IpDSB_Miss_Ret"
     },
     {
-        "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to Streaming store memory accesses; Streaming store optimize out a =
read request required by RFO stores",
-        "MetricExpr": "9 * OCR.STREAMING_WR.ANY_RESPONSE / CLKS",
-        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_store_bound_group",
-        "MetricName": "tma_streaming_stores",
-        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to Streaming store memory accesses; Streaming store optimize out a=
 read request required by RFO stores. Even though store accesses do not typ=
ically stall out-of-order CPUs; there are few cases where stores can lead t=
o actual stalls. This metric will be flagged should Streaming stores be a b=
ottleneck. Sample with: OCR.STREAMING_WR.ANY_RESPONSE",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts",
+        "MetricName": "IpMispredict"
     },
     {
-        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
-        "MetricExpr": "(7 * cpu@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=3D1@ =
+ DTLB_STORE_MISSES.WALK_ACTIVE) / CORE_CLKS",
-        "MetricGroup": "MemoryTLB;TopdownL4;tma_store_bound_group",
-        "MetricName": "tma_dtlb_store",
-        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES_PS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
+        "MetricExpr": "(tma_branch_mispredicts + tma_fetch_latency * tma_m=
ispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icache_=
misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) * SLOTS / BR_MISP_RE=
TIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "Branch_Misprediction_Cost"
     },
     {
-        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the TLB was missed by store accesses, hitting in the second-l=
evel TLB (STLB)",
-        "MetricExpr": "tma_dtlb_store - tma_store_stlb_miss",
-        "MetricGroup": "MemoryTLB;TopdownL5;tma_dtlb_store_group",
-        "MetricName": "tma_store_stlb_hit",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Fraction of branches that are non-taken condi=
tionals",
+        "MetricExpr": "BR_INST_RETIRED.COND_NTAKEN / BR_INST_RETIRED.ALL_B=
RANCHES",
+        "MetricGroup": "Bad;Branches;CodeGen;PGO",
+        "MetricName": "Cond_NT"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
where the STLB was missed by store accesses, performing a hardware page wal=
k",
-        "MetricExpr": "DTLB_STORE_MISSES.WALK_ACTIVE / CORE_CLKS",
-        "MetricGroup": "MemoryTLB;TopdownL5;tma_dtlb_store_group",
-        "MetricName": "tma_store_stlb_miss",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Fraction of branches that are taken condition=
als",
+        "MetricExpr": "BR_INST_RETIRED.COND_TAKEN / BR_INST_RETIRED.ALL_BR=
ANCHES",
+        "MetricGroup": "Bad;Branches;CodeGen;PGO",
+        "MetricName": "Cond_TK"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e Core non-memory issues were of a bottleneck",
-        "MetricExpr": "max(0, tma_backend_bound - tma_memory_bound)",
-        "MetricGroup": "Backend;Compute;TopdownL2;tma_L2_group;tma_backend=
_bound_group",
-        "MetricName": "tma_core_bound",
-        "PublicDescription": "This metric represents fraction of slots whe=
re Core non-memory issues were of a bottleneck.  Shortage in hardware compu=
te resources; or dependencies in software's instructions are both categoriz=
ed under Core Bound. Hence it may indicate the machine ran out of an out-of=
-order resource; certain execution units are overloaded or dependencies in =
program's data- or instruction-flow are limiting the performance (e.g. FP-c=
hained long-latency arithmetic operations).",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Fraction of branches that are CALL or RET",
+        "MetricExpr": "(BR_INST_RETIRED.NEAR_CALL + BR_INST_RETIRED.NEAR_R=
ETURN) / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;Branches",
+        "MetricName": "CallRet"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles whe=
re the Divider unit was active",
-        "MetricExpr": "ARITH.DIVIDER_ACTIVE / CLKS",
-        "MetricGroup": "TopdownL3;tma_core_bound_group",
-        "MetricName": "tma_divider",
-        "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIVIDER_ACTIVE",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Fraction of branches that are unconditional (=
direct or indirect) jumps",
+        "MetricExpr": "(BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.COND_=
TAKEN - 2 * BR_INST_RETIRED.NEAR_CALL) / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;Branches",
+        "MetricName": "Jump"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
-        "MetricExpr": "(cpu@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x80@ + =
(EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * cpu@EXE_ACTIVITY.2_PORTS_UTIL\\=
,umask\\=3D0xc@)) / CLKS if (ARITH.DIVIDER_ACTIVE < (CYCLE_ACTIVITY.STALLS_=
TOTAL - EXE_ACTIVITY.BOUND_ON_LOADS)) else (EXE_ACTIVITY.1_PORTS_UTIL + tma=
_retiring * cpu@EXE_ACTIVITY.2_PORTS_UTIL\\,umask\\=3D0xc@) / CLKS",
-        "MetricGroup": "PortsUtil;TopdownL3;tma_core_bound_group",
-        "MetricName": "tma_ports_utilization",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Fraction of branches of other types (not indi=
vidually covered by other metrics in Info.Branches group)",
+        "MetricExpr": "1 - (Cond_NT + Cond_TK + CallRet + Jump)",
+        "MetricGroup": "Bad;Branches",
+        "MetricName": "Other_Branches"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
-        "MetricExpr": "cpu@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x80@ / C=
LKS + tma_serializing_operation * (CYCLE_ACTIVITY.STALLS_TOTAL - EXE_ACTIVI=
TY.BOUND_ON_LOADS) / CLKS",
-        "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
-        "MetricName": "tma_ports_utilized_0",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U executed no uops on any execution port (Logical Processor cycles since IC=
L, Physical Core cycles otherwise). Long-latency instructions like divides =
may contribute to this metric.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / MEM_LOAD_COMPLETED.L1_MISS_=
ANY",
+        "MetricGroup": "Mem;MemoryBound;MemoryLat",
+        "MetricName": "Load_Miss_Real_Latency"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU issue-pipeline was stalled due to serializing operations",
-        "MetricExpr": "RESOURCE_STALLS.SCOREBOARD / CLKS",
-        "MetricGroup": "TopdownL5;tma_ports_utilized_0_group",
-        "MetricName": "tma_serializing_operation",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU issue-pipeline was stalled due to serializing operations. Instruction=
s like CPUID; WRMSR or LFENCE serialize the out-of-order execution which ma=
y limit performance. Sample with: RESOURCE_STALLS.SCOREBOARD",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss. Per-Logical Proces=
sor)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLE=
S",
+        "MetricGroup": "Mem;MemoryBW;MemoryBound",
+        "MetricName": "MLP"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to PAUSE Instructions",
-        "MetricExpr": "CPU_CLK_UNHALTED.PAUSE / CLKS",
-        "MetricGroup": "TopdownL6;tma_serializing_operation_group",
-        "MetricName": "tma_slow_pause",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to PAUSE Instructions. Sample with: CPU_CLK_UNHALTED.=
PAUSE_INST",
-        "ScaleUnit": "100%"
+        "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "L1MPKI"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to LFENCE Instructions.",
-        "MetricExpr": "13 * MISC2_RETIRED.LFENCE / CLKS",
-        "MetricGroup": "TopdownL6;tma_serializing_operation_group",
-        "MetricName": "tma_memory_fence",
-        "ScaleUnit": "100%"
+        "BriefDescription": "L1 cache true misses per kilo instruction for=
 all demand loads (including speculative)",
+        "MetricExpr": "1e3 * L2_RQSTS.ALL_DEMAND_DATA_RD / INST_RETIRED.AN=
Y",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "L1MPKI_Load"
     },
     {
-        "BriefDescription": "The Mixing_Vectors metric gives the percentag=
e of injected blend uops out of all uops issued",
-        "MetricExpr": "160 * ASSISTS.SSE_AVX_MIX / CLKS",
-        "MetricGroup": "TopdownL5;tma_ports_utilized_0_group",
-        "MetricName": "tma_mixing_vectors",
-        "PublicDescription": "The Mixing_Vectors metric gives the percenta=
ge of injected blend uops out of all uops issued. Usually a Mixing_Vectors =
over 5% is worth investigating. Read more in Appendix B1 of the Optimizatio=
ns Guide for this topic.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Backend;CacheMisses;Mem",
+        "MetricName": "L2MPKI"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles wher=
e the Advanced Matrix Extensions (AMX) execution engine was busy with tile =
(arithmetic) operations",
-        "MetricExpr": "EXE.AMX_BUSY / CORE_CLKS",
-        "MetricGroup": "Compute;HPC;Server;TopdownL5;tma_ports_utilized_0_=
group",
-        "MetricName": "tma_amx_busy",
-        "ScaleUnit": "100%"
+        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all request types (including speculative)",
+        "MetricExpr": "1e3 * L2_RQSTS.MISS / INST_RETIRED.ANY",
+        "MetricGroup": "CacheMisses;Mem;Offcore",
+        "MetricName": "L2MPKI_All"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles whe=
re the CPU executed total of 1 uop per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "EXE_ACTIVITY.1_PORTS_UTIL / CLKS",
-        "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
-        "MetricName": "tma_ports_utilized_1",
-        "PublicDescription": "This metric represents fraction of cycles wh=
ere the CPU executed total of 1 uop per cycle on all execution ports (Logic=
al Processor cycles since ICL, Physical Core cycles otherwise). This can be=
 due to heavy data-dependency among software instructions; or over oversubs=
cribing a particular hardware resource. In some other cases with high 1_Por=
t_Utilized and L1_Bound; this metric can point to L1 data-cache latency bot=
tleneck that may not necessarily manifest with complete execution starvatio=
n (due to the short L1 latency e.g. walking a linked list) - looking at the=
 assembly can be helpful. Sample with: EXE_ACTIVITY.1_PORTS_UTIL",
-        "ScaleUnit": "100%"
+        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all demand loads  (including speculative)",
+        "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_MISS / INST_RETIRED.A=
NY",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "L2MPKI_Load"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 2 uops per cycle on all execution ports (Logical Process=
or cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "EXE_ACTIVITY.2_PORTS_UTIL / CLKS",
-        "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
-        "MetricName": "tma_ports_utilized_2",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop. S=
ample with: EXE_ACTIVITY.2_PORTS_UTIL",
-        "ScaleUnit": "100%"
+        "BriefDescription": "L2 cache hits per kilo instruction for all re=
quest types (including speculative)",
+        "MetricExpr": "1e3 * (L2_RQSTS.REFERENCES - L2_RQSTS.MISS) / INST_=
RETIRED.ANY",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "L2HPKI_All"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "UOPS_EXECUTED.CYCLES_GE_3 / CLKS",
-        "MetricGroup": "PortsUtil;TopdownL4;tma_ports_utilization_group",
-        "MetricName": "tma_ports_utilized_3m",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 3 or more uops per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise). Sample with:=
 UOPS_EXECUTED.CYCLES_GE_3",
-        "ScaleUnit": "100%"
+        "BriefDescription": "L2 cache hits per kilo instruction for all de=
mand loads  (including speculative)",
+        "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_HIT / INST_RETIRED.AN=
Y",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "L2HPKI_Load"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
-        "MetricExpr": "(UOPS_DISPATCHED.PORT_0 + UOPS_DISPATCHED.PORT_1 + =
UOPS_DISPATCHED.PORT_5_11 + UOPS_DISPATCHED.PORT_6) / (5 * CORE_CLKS)",
-        "MetricGroup": "TopdownL5;tma_ports_utilized_3m_group",
-        "MetricName": "tma_alu_op_utilization",
-        "ScaleUnit": "100%"
+        "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "L3MPKI"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd b=
ranch) Sample with: UOPS_DISPATCHED.PORT_0",
-        "MetricExpr": "UOPS_DISPATCHED.PORT_0 / CORE_CLKS",
-        "MetricGroup": "Compute;TopdownL6;tma_alu_op_utilization_group",
-        "MetricName": "tma_port_0",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
+        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.FB_HIT / INST_RETIRED.ANY",
+        "MetricGroup": "CacheMisses;Mem",
+        "MetricName": "FB_HPKI"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 1 (ALU) Sample with: UOPS_DISPATCHE=
D.PORT_1",
-        "MetricExpr": "UOPS_DISPATCHED.PORT_1 / CORE_CLKS",
-        "MetricGroup": "TopdownL6;tma_alu_op_utilization_group",
-        "MetricName": "tma_port_1",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
+        "MetricConstraint": "NO_NMI_WATCHDOG",
+        "MetricExpr": "(ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_P=
ENDING + DTLB_STORE_MISSES.WALK_PENDING) / (4 * CORE_CLKS)",
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "Page_Walks_Utilization"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 6 ([HSW+]Primary Branch and simple =
ALU) Sample with: UOPS_DISPATCHED.PORT_6",
-        "MetricExpr": "UOPS_DISPATCHED.PORT_6 / CORE_CLKS",
-        "MetricGroup": "TopdownL6;tma_alu_op_utilization_group",
-        "MetricName": "tma_port_6",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / duration_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L1D_Cache_Fill_BW"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Load operations Sample with: UO=
PS_DISPATCHED.PORT_2_3_10",
-        "MetricExpr": "UOPS_DISPATCHED.PORT_2_3_10 / (3 * CORE_CLKS)",
-        "MetricGroup": "TopdownL5;tma_ports_utilized_3m_group",
-        "MetricName": "tma_load_op_utilization",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / duration_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L2_Cache_Fill_BW"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Store operations Sample with: U=
OPS_DISPATCHED.PORT_7_8",
-        "MetricExpr": "(UOPS_DISPATCHED.PORT_4_9 + UOPS_DISPATCHED.PORT_7_=
8) / (4 * CORE_CLKS)",
-        "MetricGroup": "TopdownL5;tma_ports_utilized_3m_group",
-        "MetricName": "tma_store_op_utilization",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / duration_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L3_Cache_Fill_BW"
     },
     {
-        "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
-        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0*SLOTS",
-        "MetricGroup": "TopdownL1;tma_L1_group",
-        "MetricName": "tma_retiring",
-        "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided.  Sample with: UOPS_RETIRE=
D.SLOTS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
+        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1e9 / duration=
_time",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "L3_Cache_Access_BW"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations -- instructions that require=
 no more than one uop (micro-operation)",
-        "MetricExpr": "max(0, tma_retiring - tma_heavy_operations)",
-        "MetricGroup": "Retire;TopdownL2;tma_L2_group;tma_retiring_group",
-        "MetricName": "tma_light_operations",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring light-weight operations -- instructions that requir=
e no more than one uop (micro-operation). This correlates with total number=
 of instructions used by the program. A uops-per-instruction (see UPI metri=
c) ratio of 1 or less should be expected for decently optimized software ru=
nning on Intel Core/Xeon products. While this often indicates efficient X86=
 instructions were executed; high value does not necessarily mean better pe=
rformance cannot be achieved. Sample with: INST_RETIRED.PREC_DIST",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Rate of silent evictions from the L2 cache pe=
r Kilo instruction where the evicted lines are dropped (no writeback to L3 =
or memory)",
+        "MetricExpr": "1e3 * L2_LINES_OUT.SILENT / Instructions",
+        "MetricGroup": "L2Evicts;Mem;Server",
+        "MetricName": "L2_Evictions_Silent_PKI"
     },
     {
-        "BriefDescription": "This metric represents overall arithmetic flo=
ating-point (FP) operations fraction the CPU has executed (retired)",
-        "MetricExpr": "tma_x87_use + tma_fp_scalar + tma_fp_vector + tma_f=
p_amx",
-        "MetricGroup": "HPC;TopdownL3;tma_light_operations_group",
-        "MetricName": "tma_fp_arith",
-        "PublicDescription": "This metric represents overall arithmetic fl=
oating-point (FP) operations fraction the CPU has executed (retired). Note =
this metric's value may exceed its parent due to use of \"Uops\" CountDomai=
n and FMA double-counting.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Rate of non silent evictions from the L2 cach=
e per Kilo instruction",
+        "MetricExpr": "1e3 * L2_LINES_OUT.NON_SILENT / Instructions",
+        "MetricGroup": "L2Evicts;Mem;Server",
+        "MetricName": "L2_Evictions_NonSilent_PKI"
     },
     {
-        "BriefDescription": "This metric serves as an approximation of leg=
acy x87 usage",
-        "MetricExpr": "tma_retiring * UOPS_EXECUTED.X87 / UOPS_EXECUTED.TH=
READ",
-        "MetricGroup": "Compute;TopdownL4;tma_fp_arith_group",
-        "MetricName": "tma_x87_use",
-        "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
+        "MetricExpr": "L1D_Cache_Fill_BW",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L1D_Cache_Fill_BW_1T"
     },
     {
-        "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) scalar uops fraction the CPU has retired",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE + FP_ARITH_INST_RETIRED2.SCALAR) / (tma_retiring * =
SLOTS)",
-        "MetricGroup": "Compute;Flops;TopdownL4;tma_fp_arith_group",
-        "MetricName": "tma_fp_scalar",
-        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
+        "MetricExpr": "L2_Cache_Fill_BW",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L2_Cache_Fill_BW_1T"
     },
     {
-        "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) vector uops fraction the CPU has retired aggregated across all v=
ector widths",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBL=
E + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_P=
ACKED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE + FP_ARITH_INST_RET=
IRED2.VECTOR) / (tma_retiring * SLOTS)",
-        "MetricGroup": "Compute;Flops;TopdownL4;tma_fp_arith_group",
-        "MetricName": "tma_fp_vector",
-        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
+        "MetricExpr": "L3_Cache_Fill_BW",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L3_Cache_Fill_BW_1T"
     },
     {
-        "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 128-bit wide vectors",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED2.128B_PACKED_HALF=
) / (tma_retiring * SLOTS)",
-        "MetricGroup": "Compute;Flops;TopdownL5;tma_fp_vector_group",
-        "MetricName": "tma_fp_vector_128b",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
+        "MetricExpr": "L3_Cache_Access_BW",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "L3_Cache_Access_BW_1T"
     },
     {
-        "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 256-bit wide vectors",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED2.256B_PACKED_HALF=
) / (tma_retiring * SLOTS)",
-        "MetricGroup": "Compute;Flops;TopdownL5;tma_fp_vector_group",
-        "MetricName": "tma_fp_vector_256b",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricGroup": "HPC;Summary",
+        "MetricName": "CPU_Utilization"
     },
     {
-        "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 512-bit wide vectors",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.512B_PACKED_SINGLE + FP_ARITH_INST_RETIRED2.512B_PACKED_HALF=
) / (tma_retiring * SLOTS)",
-        "MetricGroup": "Compute;Flops;TopdownL5;tma_fp_vector_group",
-        "MetricName": "tma_fp_vector_512b",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 512-bit wide vectors. May overcount=
 due to FMA double counting.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Measured Average Frequency for unhalted proce=
ssors [GHz]",
+        "MetricExpr": "Turbo_Utilization * TSC / 1e9 / duration_time",
+        "MetricGroup": "Power;Summary",
+        "MetricName": "Average_Frequency"
     },
     {
-        "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) matrix uops fraction the CPU has retired (aggregated across all =
supported FP datatypes in AMX engine)",
-        "MetricExpr": "cpu@AMX_OPS_RETIRED.BF16\\,cmask\\=3D1@ / (tma_reti=
ring * SLOTS)",
-        "MetricGroup": "Compute;Flops;HPC;Pipeline;Server;TopdownL4;tma_fp=
_arith_group",
-        "MetricName": "tma_fp_amx",
-        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) matrix uops fraction the CPU has retired (aggregated across all=
 supported FP datatypes in AMX engine). Refer to AMX_Busy and GFLOPs metric=
s for actual AMX utilization and FP performance, resp.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Giga Floating Point Operations Per Second",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE + FP_ARITH_INST_RETIRED2.SCALAR_HALF + 2 * (FP_ARIT=
H_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED2.COMPLEX_SCALAR_H=
ALF) + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRE=
D.256B_PACKED_DOUBLE) + 8 * (FP_ARITH_INST_RETIRED2.128B_PACKED_HALF + FP_A=
RITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DO=
UBLE) + 16 * (FP_ARITH_INST_RETIRED2.256B_PACKED_HALF + FP_ARITH_INST_RETIR=
ED.512B_PACKED_SINGLE) + 32 * FP_ARITH_INST_RETIRED2.512B_PACKED_HALF + 4 *=
 AMX_OPS_RETIRED.BF16) / 1e9 / duration_time",
+        "MetricGroup": "Cor;Flops;HPC",
+        "MetricName": "GFLOPs",
+        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine."
     },
     {
-        "BriefDescription": "This metric represents overall Integer (Int) =
select operations fraction the CPU has executed (retired)",
-        "MetricExpr": "tma_int_vector_128b + tma_int_vector_256b + tma_shu=
ffles",
-        "MetricGroup": "Pipeline;TopdownL3;tma_light_operations_group",
-        "MetricName": "tma_int_operations",
-        "PublicDescription": "This metric represents overall Integer (Int)=
 select operations fraction the CPU has executed (retired). Vector/Matrix I=
nt operations and shuffles are counted. Note this metric's value may exceed=
 its parent due to use of \"Uops\" CountDomain.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Tera Integer (matrix) Operations Per Second",
+        "MetricExpr": "8 * AMX_OPS_RETIRED.INT8 / 1e12 / duration_time",
+        "MetricGroup": "Cor;HPC;IntVector;Server",
+        "MetricName": "TIOPS"
     },
     {
-        "BriefDescription": "This metric represents 128-bit vector Integer=
 ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction the=
 CPU has retired.",
-        "MetricExpr": "(INT_VEC_RETIRED.ADD_128 + INT_VEC_RETIRED.VNNI_128=
) / (tma_retiring * SLOTS)",
-        "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_int_opera=
tions_group",
-        "MetricName": "tma_int_vector_128b",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
+        "MetricExpr": "CLKS / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricGroup": "Power",
+        "MetricName": "Turbo_Utilization"
     },
     {
-        "BriefDescription": "This metric represents 256-bit vector Integer=
 ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction the=
 CPU has retired.",
-        "MetricExpr": "(INT_VEC_RETIRED.ADD_256 + INT_VEC_RETIRED.MUL_256 =
+ INT_VEC_RETIRED.VNNI_256) / (tma_retiring * SLOTS)",
-        "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_int_opera=
tions_group",
-        "MetricName": "tma_int_vector_256b",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
+        "MetricExpr": "(1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_U=
NHALTED.REF_DISTRIBUTED if #SMT_on else 0)",
+        "MetricGroup": "SMT",
+        "MetricName": "SMT_2T_Utilization"
     },
     {
-        "BriefDescription": "This metric approximates arithmetic Integer (=
Int) matrix uops fraction the CPU has retired (aggregated across all suppor=
ted Int datatypes in AMX engine)",
-        "MetricExpr": "cpu@AMX_OPS_RETIRED.INT8\\,cmask\\=3D1@ / (tma_reti=
ring * SLOTS)",
-        "MetricGroup": "Compute;HPC;IntVector;Pipeline;Server;TopdownL4;tm=
a_int_operations_group",
-        "MetricName": "tma_int_amx",
-        "PublicDescription": "This metric approximates arithmetic Integer =
(Int) matrix uops fraction the CPU has retired (aggregated across all suppo=
rted Int datatypes in AMX engine). Refer to AMX_Busy and TIOPs metrics for =
actual AMX utilization and Int performance, resp.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.THRE=
AD",
+        "MetricGroup": "OS",
+        "MetricName": "Kernel_Utilization"
     },
     {
-        "BriefDescription": "This metric represents Shuffle (cross \"vecto=
r lane\" data transfers) uops fraction the CPU has retired.",
-        "MetricExpr": "INT_VEC_RETIRED.SHUFFLES / (tma_retiring * SLOTS)",
-        "MetricGroup": "HPC;Pipeline;TopdownL4;tma_int_operations_group",
-        "MetricName": "tma_shuffles",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
+        "MetricGroup": "OS",
+        "MetricName": "Kernel_CPI"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations -- uops for memory load or store a=
ccesses.",
-        "MetricExpr": "tma_light_operations * MEM_UOP_RETIRED.ANY / (tma_r=
etiring * SLOTS)",
-        "MetricGroup": "Pipeline;TopdownL3;tma_light_operations_group",
-        "MetricName": "tma_memory_operations",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
+        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e=
9 / duration_time",
+        "MetricGroup": "HPC;Mem;MemoryBW;SoC",
+        "MetricName": "DRAM_BW_Use"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions -- where one uop can represent mu=
ltiple contiguous instructions",
-        "MetricExpr": "tma_light_operations * INST_RETIRED.MACRO_FUSED / (=
tma_retiring * SLOTS)",
-        "MetricGroup": "Pipeline;TopdownL3;tma_light_operations_group",
-        "MetricName": "tma_fused_instructions",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring fused instructions -- where one uop can represent m=
ultiple contiguous instructions. The instruction pairs of CMP+JCC or DEC+JC=
C are commonly used examples.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average latency of data read request to exter=
nal memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetches=
",
+        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / UNC_CHA_=
TOR_INSERTS.IA_MISS_DRD) / (Socket_CLKS / duration_time)",
+        "MetricGroup": "Mem;MemoryLat;SoC",
+        "MetricName": "MEM_Read_Latency"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring branch instructions that were not fused",
-        "MetricExpr": "tma_light_operations * (BR_INST_RETIRED.ALL_BRANCHE=
S - INST_RETIRED.MACRO_FUSED) / (tma_retiring * SLOTS)",
-        "MetricGroup": "Pipeline;TopdownL3;tma_light_operations_group",
-        "MetricName": "tma_non_fused_branches",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring branch instructions that were not fused. Non-condit=
ional branches like direct JMP or CALL would count here. Can be used to exa=
mine fusible conditional jumps that were not fused.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average number of parallel data read requests=
 to external memory. Accounts for demand loads and L1/L2 prefetches",
+        "MetricExpr": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / UNC_CHA_TOR_OCC=
UPANCY.IA_MISS_DRD@thresh\\=3D1@",
+        "MetricGroup": "Mem;MemoryBW;SoC",
+        "MetricName": "MEM_Parallel_Reads"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring NOP (no op) instructions",
-        "MetricExpr": "tma_light_operations * INST_RETIRED.NOP / (tma_reti=
ring * SLOTS)",
-        "MetricGroup": "Pipeline;TopdownL3;tma_light_operations_group",
-        "MetricName": "tma_nop_instructions",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring NOP (no op) instructions. Compilers often use NOPs =
for certain address alignments - e.g. start address of a function or loop b=
ody. Sample with: INST_RETIRED.NOP",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average latency of data read request to exter=
nal 3D X-Point memory [in nanoseconds]. Accounts for demand loads and L1/L2=
 data-read prefetches",
+        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PMM / UNC_=
CHA_TOR_INSERTS.IA_MISS_DRD_PMM) / uncore_cha_0@event\\=3D0x1@",
+        "MetricGroup": "Mem;MemoryLat;Server;SoC",
+        "MetricName": "MEM_PMM_Read_Latency"
     },
     {
-        "BriefDescription": "This metric represents the remaining light uo=
ps fraction the CPU has executed - remaining means not covered by other sib=
ling nodes. May undercount due to FMA double counting",
-        "MetricExpr": "max(0, tma_light_operations - (tma_fp_arith + tma_i=
nt_operations + tma_memory_operations + tma_fused_instructions + tma_non_fu=
sed_branches + tma_nop_instructions))",
-        "MetricGroup": "Pipeline;TopdownL3;tma_light_operations_group",
-        "MetricName": "tma_other_light_ops",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average latency of data read request to exter=
nal DRAM memory [in nanoseconds]. Accounts for demand loads and L1/L2 data-=
read prefetches",
+        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_DDR / UNC_=
CHA_TOR_INSERTS.IA_MISS_DRD_DDR) / uncore_cha_0@event\\=3D0x1@",
+        "MetricGroup": "Mem;MemoryLat;Server;SoC",
+        "MetricName": "MEM_DRAM_Read_Latency"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or microcoded sequences",
-        "MetricExpr": "topdown\\-heavy\\-ops / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0*SLOTS",
-        "MetricGroup": "Retire;TopdownL2;tma_L2_group;tma_retiring_group",
-        "MetricName": "tma_heavy_operations",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or microcoded sequences. This highly-correlates with the=
 uop length of these instructions/sequences. Sample with: UOPS_RETIRED.HEAV=
Y",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average 3DXP Memory Bandwidth Use for reads [=
GB / sec]",
+        "MetricExpr": "64 * UNC_M_PMM_RPQ_INSERTS / 1e9 / duration_time",
+        "MetricGroup": "Mem;MemoryBW;Server;SoC",
+        "MetricName": "PMM_Read_BW"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring instructions that that are decoder into two or up to=
 ([SNB+] four; [ADL+] five) uops",
-        "MetricExpr": "tma_heavy_operations - tma_microcode_sequencer",
-        "MetricGroup": "TopdownL3;tma_heavy_operations_group",
-        "MetricName": "tma_few_uops_instructions",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring instructions that that are decoder into two or up t=
o ([SNB+] four; [ADL+] five) uops. This highly-correlates with the number o=
f uops in such instructions.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average 3DXP Memory Bandwidth Use for Writes =
[GB / sec]",
+        "MetricExpr": "64 * UNC_M_PMM_WPQ_INSERTS / 1e9 / duration_time",
+        "MetricGroup": "Mem;MemoryBW;Server;SoC",
+        "MetricName": "PMM_Write_BW"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU was retiring uops fetched by the Microcode Sequencer (MS) unit",
-        "MetricExpr": "UOPS_RETIRED.MS / SLOTS",
-        "MetricGroup": "MicroSeq;TopdownL3;tma_heavy_operations_group",
-        "MetricName": "tma_microcode_sequencer",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The M=
S is used for CISC instructions not supported by the default decoders (like=
 repeat move strings; or CPUID); or by microcode assists used to address so=
me operation modes (like in Floating Point assists). These cases can often =
be avoided. Sample with: UOPS_RETIRED.MS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Average IO (network or disk) Bandwidth Use fo=
r Writes [GB / sec]",
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR * 64 / 1e9 / durati=
on_time",
+        "MetricGroup": "IoBW;Mem;Server;SoC",
+        "MetricName": "IO_Write_BW"
     },
     {
-        "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops delivered by the Microcode_Sequencer as a result of Assists=
",
-        "MetricExpr": "100 * cpu@ASSISTS.ANY\\,umask\\=3D0x1B@ / SLOTS",
-        "MetricGroup": "TopdownL4;tma_microcode_sequencer_group",
-        "MetricName": "tma_assists",
-        "PublicDescription": "This metric estimates fraction of slots the =
CPU retired uops delivered by the Microcode_Sequencer as a result of Assist=
s. Assists are long sequences of uops that are required in certain corner-c=
ases for operations that cannot be handled natively by the execution pipeli=
ne. For example; when working with very small floating point values (so-cal=
led Denormals); the FP units are not set up to perform these operations nat=
ively. Instead; a sequence of instructions to perform the computation on th=
e Denormals is injected into the pipeline. Since these microcode sequences =
might be dozens of uops long; Assists can be extremely deleterious to perfo=
rmance and they can be avoided in many cases. Sample with: ASSISTS.ANY",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Socket actual clocks when any core is active =
on that socket",
+        "MetricExpr": "uncore_cha_0@event\\=3D0x1@",
+        "MetricGroup": "SoC",
+        "MetricName": "Socket_CLKS"
     },
     {
-        "BriefDescription": "This metric roughly estimates fraction of slo=
ts the CPU retired uops as a result of handing Page Faults",
-        "MetricExpr": "99 * ASSISTS.PAGE_FAULT / SLOTS",
-        "MetricGroup": "TopdownL5;tma_assists_group",
-        "MetricName": "tma_page_faults",
-        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Page Faults. A Page Fault m=
ay apply on first application access to a memory page. Note operating syste=
m handling of page faults accounts for the majority of its cost.",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
+        "MetricGroup": "Branches;OS",
+        "MetricName": "IpFarBranch"
     },
     {
-        "BriefDescription": "This metric roughly estimates fraction of slo=
ts the CPU retired uops as a result of handing Floating Point (FP) Assists"=
,
-        "MetricExpr": "30 * ASSISTS.FP / SLOTS",
-        "MetricGroup": "HPC;TopdownL5;tma_assists_group",
-        "MetricName": "tma_fp_assists",
-        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Floating Point (FP) Assists=
. FP Assist may apply when working with very small floating point values (s=
o-called denormals).",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Uncore frequency per die [GHZ]",
+        "MetricExpr": "Socket_CLKS / #num_dies / duration_time / 1e9",
+        "MetricGroup": "SoC",
+        "MetricName": "UNCORE_FREQ"
     },
     {
-        "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops as a result of handing SSE to AVX* or AVX* to SSE transitio=
n Assists. ",
-        "MetricExpr": "63 * ASSISTS.SSE_AVX_MIX / SLOTS",
-        "MetricGroup": "HPC;TopdownL5;tma_assists_group",
-        "MetricName": "tma_avx_assists",
+        "BriefDescription": "Percentage of time spent in the active CPU po=
wer state C0",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricName": "cpu_utilization",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles the =
CPU retired uops originated from CISC (complex instruction set computer) in=
struction",
-        "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
-        "MetricGroup": "TopdownL4;tma_microcode_sequencer_group",
-        "MetricName": "tma_cisc",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU retired uops originated from CISC (complex instruction set computer) i=
nstruction. A CISC instruction has multiple uops that are required to perfo=
rm the instruction's functionality as in the case of read-modify-write as a=
n example. Since these instructions require multiple uops they may or may n=
ot imply sub-optimal use of machine resources. Sample with: FRONTEND_RETIRE=
D.MS_FLOWS",
-        "ScaleUnit": "100%"
+        "BriefDescription": "CPU operating frequency (in GHz)",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC =
* #SYSTEM_TSC_FREQ / 1e9 / duration_time",
+        "MetricName": "cpu_operating_frequency",
+        "ScaleUnit": "1GHz"
     },
     {
-        "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
-        "MetricExpr": "100 * (tma_branch_mispredicts + tma_fetch_latency *=
 tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_i=
cache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
-        "MetricGroup": "Bad;BadSpec;BrMispredicts",
-        "MetricName": "Mispredictions"
+        "BriefDescription": "Cycles per instruction retired; indicating ho=
w much time each executed instruction took; in units of cycles.",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / INST_RETIRED.ANY",
+        "MetricName": "cpi",
+        "ScaleUnit": "1per_instr"
     },
     {
-        "BriefDescription": "Total pipeline cost of (external) Memory Band=
width related bottlenecks",
-        "MetricExpr": "100 * tma_memory_bound * ((tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma=
_store_bound)) * (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)=
) + (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_=
bound + tma_pmm_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_a=
ccesses + tma_data_sharing + tma_l3_hit_latency + tma_sq_full))) + (tma_l1_=
bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_=
pmm_bound + tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_fb_full=
 + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) ",
-        "MetricGroup": "Mem;MemoryBW;Offcore",
-        "MetricName": "Memory_Bandwidth"
+        "BriefDescription": "The ratio of number of completed memory load =
instructions to the total number completed instructions",
+        "MetricExpr": "MEM_INST_RETIRED.ALL_LOADS / INST_RETIRED.ANY",
+        "MetricName": "loads_per_instr",
+        "ScaleUnit": "1per_instr"
     },
     {
-        "BriefDescription": "Total pipeline cost of Memory Latency related=
 bottlenecks (external memory and off-core caches)",
-        "MetricExpr": "100 * tma_memory_bound * ((tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma=
_store_bound)) * (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) =
+ (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bo=
und + tma_pmm_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contes=
ted_accesses + tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + (tma=
_l2_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + =
tma_pmm_bound + tma_store_bound)))",
-        "MetricGroup": "Mem;MemoryLat;Offcore",
-        "MetricName": "Memory_Latency"
+        "BriefDescription": "The ratio of number of completed memory store=
 instructions to the total number completed instructions",
+        "MetricExpr": "MEM_INST_RETIRED.ALL_STORES / INST_RETIRED.ANY",
+        "MetricName": "stores_per_instr",
+        "ScaleUnit": "1per_instr"
     },
     {
-        "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
-        "MetricExpr": "100 * tma_memory_bound * ((tma_l1_bound / max(tma_m=
emory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + =
tma_pmm_bound + tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, tma_=
dtlb_load + tma_fb_full + tma_lock_latency + tma_split_loads + tma_store_fw=
d_blk)) + (tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound =
+ tma_l3_bound + tma_pmm_bound + tma_store_bound)) * (tma_dtlb_store / (tma=
_dtlb_store + tma_false_sharing + tma_split_stores + tma_store_latency + tm=
a_streaming_stores))) ",
-        "MetricGroup": "Mem;MemoryTLB;Offcore",
-        "MetricName": "Memory_Data_TLBs"
+        "BriefDescription": "Ratio of number of requests missing L1 data c=
ache (includes data+rfo w/ prefetches) to the total number of completed ins=
tructions",
+        "MetricExpr": "L1D.REPLACEMENT / INST_RETIRED.ANY",
+        "MetricName": "l1d_mpi",
+        "ScaleUnit": "1per_instr"
     },
     {
-        "BriefDescription": "Total pipeline cost of branch related instruc=
tions (used for program control-flow including function calls)",
-        "MetricExpr": "100 * ((BR_INST_RETIRED.COND + 3 * BR_INST_RETIRED.=
NEAR_CALL + (BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.COND_TAKEN - 2 * =
BR_INST_RETIRED.NEAR_CALL)) / SLOTS)",
-        "MetricGroup": "Ret",
-        "MetricName": "Branching_Overhead"
+        "BriefDescription": "Ratio of number of demand load requests hitti=
ng in L1 data cache to the total number of completed instructions ",
+        "MetricExpr": "MEM_LOAD_RETIRED.L1_HIT / INST_RETIRED.ANY",
+        "MetricName": "l1d_demand_data_read_hits_per_instr",
+        "ScaleUnit": "1per_instr"
     },
     {
-        "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
-        "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_branch_resteers + tma_dsb_switch=
es + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)",
-        "MetricGroup": "BigFoot;Fed;Frontend;IcMiss;MemoryTLB",
-        "MetricName": "Big_Code"
+        "BriefDescription": "Ratio of number of code read requests missing=
 in L1 instruction cache (includes prefetches) to the total number of compl=
eted instructions",
+        "MetricExpr": "L2_RQSTS.ALL_CODE_RD / INST_RETIRED.ANY",
+        "MetricName": "l1_i_code_read_misses_with_prefetches_per_instr",
+        "ScaleUnit": "1per_instr"
     },
     {
-        "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks",
-        "MetricExpr": "100 * (tma_frontend_bound - tma_fetch_latency * tma=
_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icach=
e_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) - Big_Code",
-        "MetricGroup": "Fed;FetchBW;Frontend",
-        "MetricName": "Instruction_Fetch_BW"
+        "BriefDescription": "Ratio of number of completed demand load requ=
ests hitting in L2 cache to the total number of completed instructions ",
+        "MetricExpr": "MEM_LOAD_RETIRED.L2_HIT / INST_RETIRED.ANY",
+        "MetricName": "l2_demand_data_read_hits_per_instr",
+        "ScaleUnit": "1per_instr"
     },
     {
-        "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
-        "MetricExpr": "INST_RETIRED.ANY / CLKS",
-        "MetricGroup": "Ret;Summary",
-        "MetricName": "IPC"
+        "BriefDescription": "Ratio of number of requests missing L2 cache =
(includes code+data+rfo w/ prefetches) to the total number of completed ins=
tructions",
+        "MetricExpr": "L2_LINES_IN.ALL / INST_RETIRED.ANY",
+        "MetricName": "l2_mpi",
+        "ScaleUnit": "1per_instr"
     },
     {
-        "BriefDescription": "Uops Per Instruction",
-        "MetricExpr": "(tma_retiring * SLOTS) / INST_RETIRED.ANY",
-        "MetricGroup": "Pipeline;Ret;Retire",
-        "MetricName": "UPI"
+        "BriefDescription": "Ratio of number of completed data read reques=
t missing L2 cache to the total number of completed instructions",
+        "MetricExpr": "MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricName": "l2_demand_data_read_mpi",
+        "ScaleUnit": "1per_instr"
     },
     {
-        "BriefDescription": "Instruction per taken branch",
-        "MetricExpr": "(tma_retiring * SLOTS) / BR_INST_RETIRED.NEAR_TAKEN=
",
-        "MetricGroup": "Branches;Fed;FetchBW",
-        "MetricName": "UpTB"
+        "BriefDescription": "Ratio of number of code read request missing =
L2 cache to the total number of completed instructions",
+        "MetricExpr": "L2_RQSTS.CODE_RD_MISS / INST_RETIRED.ANY",
+        "MetricName": "l2_demand_code_mpi",
+        "ScaleUnit": "1per_instr"
     },
     {
-        "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
-        "MetricExpr": "1 / IPC",
-        "MetricGroup": "Mem;Pipeline",
-        "MetricName": "CPI"
+        "BriefDescription": "Ratio of number of data read requests missing=
 last level core cache (includes demand w/ prefetches) to the total number =
of completed instructions",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFDATA + UNC_CHA_=
TOR_INSERTS.IA_MISS_DRD + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF) / INST_RETI=
RED.ANY",
+        "MetricName": "llc_data_read_mpi_demand_plus_prefetch",
+        "ScaleUnit": "1per_instr"
     },
     {
-        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "Pipeline",
-        "MetricName": "CLKS"
+        "BriefDescription": "Ratio of number of code read requests missing=
 last level core cache (includes demand w/ prefetches) to the total number =
of completed instructions",
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD / INST_RETIRED.ANY"=
,
+        "MetricName": "llc_code_read_mpi_demand_plus_prefetch",
+        "ScaleUnit": "1per_instr"
     },
     {
-        "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
-        "MetricExpr": "TOPDOWN.SLOTS",
-        "MetricGroup": "tma_L1_group",
-        "MetricName": "SLOTS"
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) in nano seconds",
+        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / UNC_CHA_=
TOR_INSERTS.IA_MISS_DRD) / (UNC_CHA_CLOCKTICKS / (source_count(UNC_CHA_TOR_=
OCCUPANCY.IA_MISS_DRD) * #num_packages)) * duration_time",
+        "MetricName": "llc_demand_data_read_miss_latency",
+        "ScaleUnit": "1ns"
     },
     {
-        "BriefDescription": "Fraction of Physical Core issue-slots utilize=
d by this Logical Processor",
-        "MetricExpr": "SLOTS / (TOPDOWN.SLOTS / 2) if #SMT_on else 1",
-        "MetricGroup": "SMT;tma_L1_group",
-        "MetricName": "Slots_Utilization"
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) addressed to local memory in nano=
 seconds",
+        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL / UN=
C_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL) / (UNC_CHA_CLOCKTICKS / (source_count(=
UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL) * #num_packages)) * duration_time"=
,
+        "MetricName": "llc_demand_data_read_miss_latency_for_local_request=
s",
+        "ScaleUnit": "1ns"
     },
     {
-        "BriefDescription": "The ratio of Executed- by Issued-Uops",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / UOPS_ISSUED.ANY",
-        "MetricGroup": "Cor;Pipeline",
-        "MetricName": "Execute_per_Issue",
-        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage."
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) addressed to remote memory in nan=
o seconds",
+        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE / U=
NC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE) / (UNC_CHA_CLOCKTICKS / (source_coun=
t(UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE) * #num_packages)) * duration_ti=
me",
+        "MetricName": "llc_demand_data_read_miss_latency_for_remote_reques=
ts",
+        "ScaleUnit": "1ns"
     },
     {
-        "BriefDescription": "Instructions Per Cycle across hyper-threads (=
per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / CORE_CLKS",
-        "MetricGroup": "Ret;SMT;tma_L1_group",
-        "MetricName": "CoreIPC"
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) addressed to Intel(R) Optane(TM) =
Persistent Memory(PMEM) in nano seconds",
+        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PMM / UNC_=
CHA_TOR_INSERTS.IA_MISS_DRD_PMM) / (UNC_CHA_CLOCKTICKS / (source_count(UNC_=
CHA_TOR_OCCUPANCY.IA_MISS_DRD_PMM) * #num_packages)) * duration_time",
+        "MetricName": "llc_demand_data_read_miss_to_pmem_latency",
+        "ScaleUnit": "1ns"
     },
     {
-        "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricExpr": "(1 * (FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARIT=
H_INST_RETIRED.SCALAR_DOUBLE + FP_ARITH_INST_RETIRED2.SCALAR_HALF) + 2 * (F=
P_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED2.COMPLEX_SC=
ALAR_HALF) + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_=
RETIRED.256B_PACKED_DOUBLE) + 8 * (FP_ARITH_INST_RETIRED2.128B_PACKED_HALF =
+ FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PAC=
KED_DOUBLE) + 16 * (FP_ARITH_INST_RETIRED2.256B_PACKED_HALF + FP_ARITH_INST=
_RETIRED.512B_PACKED_SINGLE) + 32 * FP_ARITH_INST_RETIRED2.512B_PACKED_HALF=
 + 4 * AMX_OPS_RETIRED.BF16) / CORE_CLKS",
-        "MetricGroup": "Flops;Ret",
-        "MetricName": "FLOPc"
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) addressed to DRAM in nano seconds=
",
+        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_DDR / UNC_=
CHA_TOR_INSERTS.IA_MISS_DRD_DDR) / (UNC_CHA_CLOCKTICKS / (source_count(UNC_=
CHA_TOR_OCCUPANCY.IA_MISS_DRD_DDR) * #num_packages)) * duration_time",
+        "MetricName": "llc_demand_data_read_miss_to_dram_latency",
+        "ScaleUnit": "1ns"
     },
     {
-        "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
-        "MetricExpr": "(FP_ARITH_DISPATCHED.PORT_0 + FP_ARITH_DISPATCHED.P=
ORT_1 + FP_ARITH_DISPATCHED.PORT_5) / (2 * CORE_CLKS)",
-        "MetricGroup": "Cor;Flops;HPC",
-        "MetricName": "FP_Arith_Utilization",
-        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)."
+        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by a code fetch to the total number of completed ins=
tructions",
+        "MetricExpr": "ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.ANY",
+        "MetricName": "itlb_2nd_level_mpi",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by a code fetch to the total number of completed in=
structions. This implies it missed in the ITLB (Instruction TLB) and furthe=
r levels of TLB.",
+        "ScaleUnit": "1per_instr"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / ((UOPS_EXECUTED.CORE_CYCLES_=
GE_1 / 2) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
-        "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
-        "MetricName": "ILP"
+        "BriefDescription": "Ratio of number of completed page walks (for =
2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total n=
umber of completed instructions",
+        "MetricExpr": "ITLB_MISSES.WALK_COMPLETED_2M_4M / INST_RETIRED.ANY=
",
+        "MetricName": "itlb_2nd_level_large_page_mpi",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total =
number of completed instructions. This implies it missed in the Instruction=
 Translation Lookaside Buffer (ITLB) and further levels of TLB.",
+        "ScaleUnit": "1per_instr"
     },
     {
-        "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
-        "MetricExpr": "(1 - tma_core_bound / tma_ports_utilization if tma_=
core_bound < tma_ports_utilization else 1) if SMT_2T_Utilization > 0.5 else=
 0",
-        "MetricGroup": "Cor;SMT",
-        "MetricName": "Core_Bound_Likely"
+        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data loads to the total number of complete=
d instructions",
+        "MetricExpr": "DTLB_LOAD_MISSES.WALK_COMPLETED / INST_RETIRED.ANY"=
,
+        "MetricName": "dtlb_2nd_level_load_mpi",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data loads to the total number of complet=
ed instructions. This implies it missed in the DTLB and further levels of T=
LB.",
+        "ScaleUnit": "1per_instr"
     },
     {
-        "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
-        "MetricExpr": "CPU_CLK_UNHALTED.DISTRIBUTED",
-        "MetricGroup": "SMT",
-        "MetricName": "CORE_CLKS"
+        "BriefDescription": "Ratio of number of completed page walks (for =
2 megabyte page sizes) caused by demand data loads to the total number of c=
ompleted instructions",
+        "MetricExpr": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M / INST_RETIRE=
D.ANY",
+        "MetricName": "dtlb_2nd_level_2mb_large_page_load_mpi",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 2 megabyte page sizes) caused by demand data loads to the total number of =
completed instructions. This implies it missed in the Data Translation Look=
aside Buffer (DTLB) and further levels of TLB.",
+        "ScaleUnit": "1per_instr"
     },
     {
-        "BriefDescription": "Instructions per Load (lower number means hig=
her occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_LOADS",
-        "MetricGroup": "InsType",
-        "MetricName": "IpLoad"
+        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data stores to the total number of complet=
ed instructions",
+        "MetricExpr": "DTLB_STORE_MISSES.WALK_COMPLETED / INST_RETIRED.ANY=
",
+        "MetricName": "dtlb_2nd_level_store_mpi",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data stores to the total number of comple=
ted instructions. This implies it missed in the DTLB and further levels of =
TLB.",
+        "ScaleUnit": "1per_instr"
     },
     {
-        "BriefDescription": "Instructions per Store (lower number means hi=
gher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_STORES",
-        "MetricGroup": "InsType",
-        "MetricName": "IpStore"
+        "BriefDescription": "Memory read that miss the last level cache (L=
LC) addressed to local DRAM as a percentage of total memory read accesses, =
does not include LLC prefetches.",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL + UNC_CHA_TO=
R_INSERTS.IA_MISS_DRD_PREF_LOCAL) / (UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL =
+ UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_LOCAL + UNC_CHA_TOR_INSERTS.IA_MISS_=
DRD_REMOTE + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_REMOTE)",
+        "MetricName": "numa_reads_addressed_to_local_dram",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Branches;Fed;InsType",
-        "MetricName": "IpBranch"
+        "BriefDescription": "Memory reads that miss the last level cache (=
LLC) addressed to remote DRAM as a percentage of total memory read accesses=
, does not include LLC prefetches.",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE + UNC_CHA_T=
OR_INSERTS.IA_MISS_DRD_PREF_REMOTE) / (UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCA=
L + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_LOCAL + UNC_CHA_TOR_INSERTS.IA_MIS=
S_DRD_REMOTE + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_REMOTE)",
+        "MetricName": "numa_reads_addressed_to_remote_dram",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Uncore operating frequency in GHz",
+        "MetricExpr": "UNC_CHA_CLOCKTICKS / (source_count(UNC_CHA_CLOCKTIC=
KS) * #num_packages) / 1e9 / duration_time",
+        "MetricName": "uncore_frequency",
+        "ScaleUnit": "1GHz"
     },
     {
-        "BriefDescription": "Instructions per (near) call (lower number me=
ans higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
-        "MetricGroup": "Branches;Fed;PGO",
-        "MetricName": "IpCall"
+        "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data t=
ransmit bandwidth (MB/sec)",
+        "MetricExpr": "UNC_UPI_TxL_FLITS.ALL_DATA * 7.111111111111111 / 1e=
6 / duration_time",
+        "MetricName": "upi_data_transmit_bw",
+        "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Instruction per taken branch",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
-        "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO",
-        "MetricName": "IpTB"
+        "BriefDescription": "DDR memory read bandwidth (MB/sec)",
+        "MetricExpr": "UNC_M_CAS_COUNT.RD * 64 / 1e6 / duration_time",
+        "MetricName": "memory_bandwidth_read",
+        "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Branch instructions per taken branch. ",
-        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
-        "MetricGroup": "Branches;Fed;PGO",
-        "MetricName": "BpTkBranch"
+        "BriefDescription": "DDR memory write bandwidth (MB/sec)",
+        "MetricExpr": "UNC_M_CAS_COUNT.WR * 64 / 1e6 / duration_time",
+        "MetricName": "memory_bandwidth_write",
+        "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Instructions per Floating Point (FP) Operatio=
n (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / (1 * (FP_ARITH_INST_RETIRED.SCAL=
AR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE + FP_ARITH_INST_RETIRED2.SC=
ALAR_HALF) + 2 * (FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARITH_INST_=
RETIRED2.COMPLEX_SCALAR_HALF) + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SING=
LE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE) + 8 * (FP_ARITH_INST_RETIRED=
2.128B_PACKED_HALF + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_IN=
ST_RETIRED.512B_PACKED_DOUBLE) + 16 * (FP_ARITH_INST_RETIRED2.256B_PACKED_H=
ALF + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE) + 32 * FP_ARITH_INST_RETIRE=
D2.512B_PACKED_HALF + 4 * AMX_OPS_RETIRED.BF16)",
-        "MetricGroup": "Flops;InsType",
-        "MetricName": "IpFLOP"
+        "BriefDescription": "DDR memory bandwidth (MB/sec)",
+        "MetricExpr": "(UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) * 64 / 1e=
6 / duration_time",
+        "MetricName": "memory_bandwidth_total",
+        "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Instructions per FP Arithmetic instruction (l=
ower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / ((FP_ARITH_INST_RETIRED.SCALAR_S=
INGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE + FP_ARITH_INST_RETIRED2.SCALAR=
) + (FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.128B_=
PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_ARITH_INST_RE=
TIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE + FP_AR=
ITH_INST_RETIRED.512B_PACKED_SINGLE + FP_ARITH_INST_RETIRED2.VECTOR))",
-        "MetricGroup": "Flops;InsType",
-        "MetricName": "IpArith",
-        "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). May undercount due to FMA doubl=
e counting. Approximated prior to BDW."
+        "BriefDescription": "Intel(R) Optane(TM) Persistent Memory(PMEM) m=
emory read bandwidth (MB/sec)",
+        "MetricExpr": "UNC_M_PMM_RPQ_INSERTS * 64 / 1e6 / duration_time",
+        "MetricName": "pmem_memory_bandwidth_read",
+        "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Instructions per FP Arithmetic Scalar Single-=
Precision instruction (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED.SCALAR_SIN=
GLE",
-        "MetricGroup": "Flops;FpScalar;InsType",
-        "MetricName": "IpArith_Scalar_SP",
-        "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). May und=
ercount due to FMA double counting."
+        "BriefDescription": "Intel(R) Optane(TM) Persistent Memory(PMEM) m=
emory write bandwidth (MB/sec)",
+        "MetricExpr": "UNC_M_PMM_WPQ_INSERTS * 64 / 1e6 / duration_time",
+        "MetricName": "pmem_memory_bandwidth_write",
+        "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Instructions per FP Arithmetic Scalar Double-=
Precision instruction (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED.SCALAR_DOU=
BLE",
-        "MetricGroup": "Flops;FpScalar;InsType",
-        "MetricName": "IpArith_Scalar_DP",
-        "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). May und=
ercount due to FMA double counting."
+        "BriefDescription": "Intel(R) Optane(TM) Persistent Memory(PMEM) m=
emory bandwidth (MB/sec)",
+        "MetricExpr": "(UNC_M_PMM_RPQ_INSERTS + UNC_M_PMM_WPQ_INSERTS) * 6=
4 / 1e6 / duration_time",
+        "MetricName": "pmem_memory_bandwidth_total",
+        "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-bi=
t instruction (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.128B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRE=
D2.128B_PACKED_HALF)",
-        "MetricGroup": "Flops;FpVector;InsType",
-        "MetricName": "IpArith_AVX128",
-        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). May undercount =
due to FMA double counting."
+        "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the CPU.",
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR * 64 / 1e6 / durati=
on_time",
+        "MetricName": "io_bandwidth_disk_or_network_writes",
+        "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Instructions per FP Arithmetic AVX* 256-bit i=
nstruction (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.256B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRE=
D2.256B_PACKED_HALF)",
-        "MetricGroup": "Flops;FpVector;InsType",
-        "MetricName": "IpArith_AVX256",
-        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). May undercount due=
 to FMA double counting."
+        "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the CPU.",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_ITOM + UNC_CHA_TOR_INSERTS.=
IO_ITOMCACHENEAR) * 64 / 1e6 / duration_time",
+        "MetricName": "io_bandwidth_disk_or_network_reads",
+        "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Instructions per FP Arithmetic AVX 512-bit in=
struction (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.512B_PACK=
ED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE + FP_ARITH_INST_RETIRE=
D2.512B_PACKED_HALF)",
-        "MetricGroup": "Flops;FpVector;InsType",
-        "MetricName": "IpArith_AVX512",
-        "PublicDescription": "Instructions per FP Arithmetic AVX 512-bit i=
nstruction (lower number means higher occurrence rate). May undercount due =
to FMA double counting."
+        "BriefDescription": "Uops delivered from decoded instruction cache=
 (decoded stream buffer or DSB) as a percent of total uops delivered to Ins=
truction Decode Queue",
+        "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + IDQ.MITE_UOPS + IDQ.=
MS_UOPS + LSD.UOPS)",
+        "MetricName": "percent_uops_delivered_from_decoded_icache",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Instructions per FP Arithmetic AMX operation =
(lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / AMX_OPS_RETIRED.BF16",
-        "MetricGroup": "Flops;FpVector;InsType;Server",
-        "MetricName": "IpArith_AMX_F16",
-        "PublicDescription": "Instructions per FP Arithmetic AMX operation=
 (lower number means higher occurrence rate). Operations factored per matri=
ces' sizes of the AMX instructions."
+        "BriefDescription": "Uops delivered from legacy decode pipeline (M=
icro-instruction Translation Engine or MITE) as a percent of total uops del=
ivered to Instruction Decode Queue",
+        "MetricExpr": "IDQ.MITE_UOPS / (IDQ.DSB_UOPS + IDQ.MITE_UOPS + IDQ=
.MS_UOPS + LSD.UOPS)",
+        "MetricName": "percent_uops_delivered_from_legacy_decode_pipeline"=
,
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Instructions per Integer Arithmetic AMX opera=
tion (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / AMX_OPS_RETIRED.INT8",
-        "MetricGroup": "InsType;IntVector;Server",
-        "MetricName": "IpArith_AMX_Int8",
-        "PublicDescription": "Instructions per Integer Arithmetic AMX oper=
ation (lower number means higher occurrence rate). Operations factored per =
matrices' sizes of the AMX instructions."
+        "BriefDescription": "Uops delivered from microcode sequencer (MS) =
as a percent of total uops delivered to Instruction Decode Queue",
+        "MetricExpr": "IDQ.MS_UOPS / (IDQ.DSB_UOPS + IDQ.MITE_UOPS + IDQ.M=
S_UOPS + LSD.UOPS)",
+        "MetricName": "percent_uops_delivered_from_microcode_sequencer",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Instructions per Software prefetch instructio=
n (of any type: NTA/T0/T1/T2/Prefetch) (lower number means higher occurrenc=
e rate)",
-        "MetricExpr": "INST_RETIRED.ANY / cpu@SW_PREFETCH_ACCESS.T0\\,umas=
k\\=3D0xF@",
-        "MetricGroup": "Prefetches",
-        "MetricName": "IpSWPF"
+        "BriefDescription": "Bandwidth (MB/sec) of read requests that miss=
 the last level cache (LLC) and go to local memory.",
+        "MetricExpr": "UNC_CHA_REQUESTS.READS_LOCAL * 64 / 1e6 / duration_=
time",
+        "MetricName": "llc_miss_local_memory_bandwidth_read",
+        "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Total number of retired Instructions Sample w=
ith: INST_RETIRED.PREC_DIST",
-        "MetricExpr": "INST_RETIRED.ANY",
-        "MetricGroup": "Summary;tma_L1_group",
-        "MetricName": "Instructions"
+        "BriefDescription": "Bandwidth (MB/sec) of write requests that mis=
s the last level cache (LLC) and go to local memory.",
+        "MetricExpr": "UNC_CHA_REQUESTS.WRITES_LOCAL * 64 / 1e6 / duration=
_time",
+        "MetricName": "llc_miss_local_memory_bandwidth_write",
+        "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
-        "MetricExpr": "(tma_retiring * SLOTS) / cpu@UOPS_RETIRED.SLOTS\\,c=
mask\\=3D1@",
-        "MetricGroup": "Pipeline;Ret",
-        "MetricName": "Retire"
+        "BriefDescription": "Bandwidth (MB/sec) of read requests that miss=
 the last level cache (LLC) and go to remote memory.",
+        "MetricExpr": "UNC_CHA_REQUESTS.READS_REMOTE * 64 / 1e6 / duration=
_time",
+        "MetricName": "llc_miss_remote_memory_bandwidth_read",
+        "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Estimated fraction of retirement-cycles deali=
ng with repeat instructions",
-        "MetricExpr": "INST_RETIRED.REP_ITERATION / cpu@UOPS_RETIRED.SLOTS=
\\,cmask\\=3D1@",
-        "MetricGroup": "Pipeline;Ret",
-        "MetricName": "Strings_Cycles"
+        "BriefDescription": "Bandwidth (MB/sec) of write requests that mis=
s the last level cache (LLC) and go to remote memory.",
+        "MetricExpr": "UNC_CHA_REQUESTS.WRITES_REMOTE * 64 / 1e6 / duratio=
n_time",
+        "MetricName": "llc_miss_remote_memory_bandwidth_write",
+        "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Instructions per a microcode Assist invocatio=
n. See Assists tree node for details (lower number means higher occurrence =
rate)",
-        "MetricExpr": "INST_RETIRED.ANY / cpu@ASSISTS.ANY\\,umask\\=3D0x1B=
@",
-        "MetricGroup": "Pipeline;Ret;Retire",
-        "MetricName": "IpAssist"
+        "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
+        "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.UO=
P_DROPPING / slots",
+        "MetricGroup": "PGO;TopdownL1;tma_L1_group;tma_L1_group",
+        "MetricName": "tma_frontend_bound",
+        "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Machine_Width uops every c=
ycle to the Backend. Frontend Bound denotes unutilized issue-slots when the=
re is no Backend stall; i.e. bubbles where Frontend delivered no uops while=
 Backend could have accepted them. For example; stalls due to instruction-c=
ache misses would be categorized under Frontend Bound.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D1@",
-        "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
-        "MetricName": "Execute"
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues",
+        "MetricExpr": "topdown\\-fetch\\-lat / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.U=
OP_DROPPING / slots",
+        "MetricGroup": "Frontend;TopdownL2;tma_L2_group;tma_L2_group;tma_f=
rontend_bound_group",
+        "MetricName": "tma_fetch_latency",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend latency issues.  For example; instruction-=
cache misses; iTLB misses or fetch stalls after a branch misprediction are =
categorized under Frontend Latency. In such cases; the Frontend eventually =
delivers no uops for some period.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average number of Uops issued by front-end wh=
en it issued something",
-        "MetricExpr": "UOPS_ISSUED.ANY / cpu@UOPS_ISSUED.ANY\\,cmask\\=3D1=
@",
-        "MetricGroup": "Fed;FetchBW",
-        "MetricName": "Fetch_UpC"
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses.",
+        "MetricExpr": "ICACHE_DATA.STALLS / CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "BigFoot;FetchLat;IcMiss;TopdownL3;tma_L3_group;tma=
_fetch_latency_group",
+        "MetricName": "tma_icache_misses",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
-        "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + IDQ.MITE_UOPS + IDQ.=
MS_UOPS)",
-        "MetricGroup": "DSB;Fed;FetchBW",
-        "MetricName": "DSB_Coverage"
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses.",
+        "MetricExpr": "ICACHE_TAG.STALLS / CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "BigFoot;FetchLat;MemoryTLB;TopdownL3;tma_L3_group;=
tma_fetch_latency_group",
+        "MetricName": "tma_itlb_misses",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
.",
-        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / cpu@DSB2MITE_SWI=
TCHES.PENALTY_CYCLES\\,cmask\\=3D1\\,edge@",
-        "MetricGroup": "DSBmiss",
-        "MetricName": "DSB_Switch_Cost"
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers",
+        "MetricExpr": "INT_MISC.CLEAR_RESTEER_CYCLES / CPU_CLK_UNHALTED.TH=
READ + tma_unknown_branches",
+        "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group",
+        "MetricName": "tma_branch_resteers",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fro=
ntend delay in fetching operations from corrected path; following all sorts=
 of miss-predicted branches. For example; branchy code with lots of miss-pr=
edictions might get categorized under Branch Resteers. Note the value of th=
is node may overlap with its siblings.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Total penalty related to DSB (uop cache) miss=
es - subset of the Instruction_Fetch_BW Bottleneck.",
-        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + =
tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb + tm=
a_mite))",
-        "MetricGroup": "DSBmiss;Fed",
-        "MetricName": "DSB_Misses"
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Branch Misprediction=
 at execution stage. ",
+        "MetricExpr": "topdown\\-br\\-mispredict / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) / max(1 =
- (tma_frontend_bound + topdown\\-be\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + topdown\\-r=
etiring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring=
 + topdown\\-be\\-bound)), 0) * INT_MISC.CLEAR_RESTEER_CYCLES / CPU_CLK_UNH=
ALTED.THREAD",
+        "MetricGroup": "BadSpec;BrMispredicts;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group",
+        "MetricName": "tma_mispredicts_resteers",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Number of Instructions per non-speculative DS=
B miss (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / FRONTEND_RETIRED.ANY_DSB_MISS",
-        "MetricGroup": "DSBmiss;Fed",
-        "MetricName": "IpDSB_Miss_Ret"
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Machine Clears. ",
+        "MetricExpr": "(1 - topdown\\-br\\-mispredict / (topdown\\-fe\\-bo=
und + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) / m=
ax(1 - (tma_frontend_bound + topdown\\-be\\-bound / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + topdow=
n\\-retiring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-ret=
iring + topdown\\-be\\-bound)), 0)) * INT_MISC.CLEAR_RESTEER_CYCLES / CPU_C=
LK_UNHALTED.THREAD",
+        "MetricGroup": "BadSpec;MachineClears;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group",
+        "MetricName": "tma_clears_resteers",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;BadSpec;BrMispredicts",
-        "MetricName": "IpMispredict"
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to new branch address clears",
+        "MetricExpr": "INT_MISC.UNKNOWN_BRANCH_CYCLES / CPU_CLK_UNHALTED.T=
HREAD",
+        "MetricGroup": "BigFoot;FetchLat;TopdownL4;tma_L4_group;tma_branch=
_resteers_group",
+        "MetricName": "tma_unknown_branches",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to new branch address clears. These are fetched branc=
hes the Branch Prediction Unit was unable to recognize (First fetch or hitt=
ing BPU capacity limit).",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
-        "MetricExpr": " (tma_branch_mispredicts + tma_fetch_latency * tma_=
mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icache=
_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) * SLOTS / BR_MISP_R=
ETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;BrMispredicts",
-        "MetricName": "Branch_Misprediction_Cost"
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to switches from DSB to MITE pipelines",
+        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / CPU_CLK_UNHALTED=
.THREAD",
+        "MetricGroup": "DSBmiss;FetchLat;TopdownL3;tma_L3_group;tma_fetch_=
latency_group",
+        "MetricName": "tma_dsb_switches",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Fraction of branches that are non-taken condi=
tionals",
-        "MetricExpr": "BR_INST_RETIRED.COND_NTAKEN / BR_INST_RETIRED.ALL_B=
RANCHES",
-        "MetricGroup": "Bad;Branches;CodeGen;PGO",
-        "MetricName": "Cond_NT"
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 was stalled due to Length Changing Prefixes (LCPs)",
+        "MetricExpr": "DECODE.LCP / CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group",
+        "MetricName": "tma_lcp",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Fraction of branches that are taken condition=
als",
-        "MetricExpr": "BR_INST_RETIRED.COND_TAKEN / BR_INST_RETIRED.ALL_BR=
ANCHES",
-        "MetricGroup": "Bad;Branches;CodeGen;PGO",
-        "MetricName": "Cond_TK"
+        "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS)",
+        "MetricExpr": "3 * IDQ.MS_SWITCHES / CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "FetchLat;MicroSeq;TopdownL3;tma_L3_group;tma_fetch=
_latency_group",
+        "MetricName": "tma_ms_switches",
+        "PublicDescription": "This metric estimates the fraction of cycles=
 when the CPU was stalled due to switches of uop delivery to the Microcode =
Sequencer (MS). Commonly used instructions are optimized for delivery by th=
e DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Cert=
ain operations cannot be handled natively by the execution pipeline; and mu=
st be performed by microcode (small programs injected into the execution st=
ream). Switching to the MS too often can negatively impact performance. The=
 MS is designated to deliver long uop flows required by CISC instructions l=
ike CPUID; or uncommon conditions like Floating Point Assists when dealing =
with Denormals.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Fraction of branches that are CALL or RET",
-        "MetricExpr": "(BR_INST_RETIRED.NEAR_CALL + BR_INST_RETIRED.NEAR_R=
ETURN) / BR_INST_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;Branches",
-        "MetricName": "CallRet"
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend bandwidth issues",
+        "MetricExpr": "max(0, tma_frontend_bound - tma_fetch_latency)",
+        "MetricGroup": "FetchBW;Frontend;TopdownL2;tma_L2_group;tma_L2_gro=
up;tma_frontend_bound_group",
+        "MetricName": "tma_fetch_bandwidth",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Fraction of branches that are unconditional (=
direct or indirect) jumps",
-        "MetricExpr": "(BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.COND_=
TAKEN - 2 * BR_INST_RETIRED.NEAR_CALL) / BR_INST_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;Branches",
-        "MetricName": "Jump"
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the MITE pipeline (the legacy deco=
de pipeline)",
+        "MetricExpr": "(IDQ.MITE_CYCLES_ANY - IDQ.MITE_CYCLES_OK) / CPU_CL=
K_UNHALTED.DISTRIBUTED / 2",
+        "MetricGroup": "DSBmiss;FetchBW;TopdownL3;tma_L3_group;tma_fetch_b=
andwidth_group",
+        "MetricName": "tma_mite",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to the MITE pipeline (the legacy dec=
ode pipeline). This pipeline is used for code that was not pre-cached in th=
e DSB or LSD. For example; inefficiencies due to asymmetric decoders; use o=
f long immediate or LCP can manifest as MITE fetch bandwidth bottleneck.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Fraction of branches of other types (not indi=
vidually covered by other metrics in Info.Branches group)",
-        "MetricExpr": "1 - (Cond_NT + Cond_TK + CallRet + Jump)",
-        "MetricGroup": "Bad;Branches",
-        "MetricName": "Other_Branches"
+        "BriefDescription": "This metric represents fraction of cycles whe=
re decoder-0 was the only active decoder",
+        "MetricExpr": "(cpu@INST_DECODED.DECODERS\\,cmask\\=3D0x1@ - cpu@I=
NST_DECODED.DECODERS\\,cmask\\=3D0x2@) / CPU_CLK_UNHALTED.DISTRIBUTED",
+        "MetricGroup": "DSBmiss;FetchBW;TopdownL4;tma_L4_group;tma_mite_gr=
oup",
+        "MetricName": "tma_decoder0_alone",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / MEM_LOAD_COMPLETED.L1_MISS_=
ANY",
-        "MetricGroup": "Mem;MemoryBound;MemoryLat",
-        "MetricName": "Load_Miss_Real_Latency"
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to DSB (decoded uop cache) fetch pipe=
line",
+        "MetricExpr": "(IDQ.DSB_CYCLES_ANY - IDQ.DSB_CYCLES_OK) / CPU_CLK_=
UNHALTED.DISTRIBUTED / 2",
+        "MetricGroup": "DSB;FetchBW;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
+        "MetricName": "tma_dsb",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss. Per-Logical Proces=
sor)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLE=
S",
-        "MetricGroup": "Mem;MemoryBW;MemoryBound",
-        "MetricName": "MLP"
+        "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
+        "MetricExpr": "max(1 - (tma_frontend_bound + topdown\\-be\\-bound =
/ (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdo=
wn\\-be\\-bound) + topdown\\-retiring / (topdown\\-fe\\-bound + topdown\\-b=
ad\\-spec + topdown\\-retiring + topdown\\-be\\-bound)), 0)",
+        "MetricGroup": "TopdownL1;tma_L1_group;tma_L1_group",
+        "MetricName": "tma_bad_speculation",
+        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY"=
,
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "L1MPKI"
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction",
+        "MetricExpr": "topdown\\-br\\-mispredict / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * sl=
ots",
+        "MetricGroup": "BadSpec;BrMispredicts;TopdownL2;tma_L2_group;tma_L=
2_group;tma_bad_speculation_group",
+        "MetricName": "tma_branch_mispredicts",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "L1 cache true misses per kilo instruction for=
 all demand loads (including speculative)",
-        "MetricExpr": "1000 * L2_RQSTS.ALL_DEMAND_DATA_RD / INST_RETIRED.A=
NY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "L1MPKI_Load"
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Machine Clears",
+        "MetricExpr": "max(0, tma_bad_speculation - topdown\\-br\\-mispred=
ict / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + t=
opdown\\-be\\-bound))",
+        "MetricGroup": "BadSpec;MachineClears;TopdownL2;tma_L2_group;tma_L=
2_group;tma_bad_speculation_group",
+        "MetricName": "tma_machine_clears",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Machine Clears.  These slots are either wasted by uo=
ps fetched prior to the clear; or stalls the out-of-order portion of the ma=
chine needs to recover its state after the clear. For example; this can hap=
pen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modif=
ying-Code (SMC) nukes.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY"=
,
-        "MetricGroup": "Backend;CacheMisses;Mem",
-        "MetricName": "L2MPKI"
+        "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
+        "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots",
+        "MetricGroup": "TopdownL1;tma_L1_group;tma_L1_group",
+        "MetricName": "tma_backend_bound",
+        "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all request types (including speculative)",
-        "MetricExpr": "1000 * L2_RQSTS.MISS / INST_RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem;Offcore",
-        "MetricName": "L2MPKI_All"
+        "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
+        "MetricExpr": "topdown\\-mem\\-bound / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots"=
,
+        "MetricGroup": "Backend;TopdownL2;tma_L2_group;tma_L2_group;tma_ba=
ckend_bound_group",
+        "MetricName": "tma_memory_bound",
+        "PublicDescription": "This metric represents fraction of slots the=
 Memory subsystem within the Backend was a bottleneck.  Memory Bound estima=
tes fraction of slots where pipeline is likely stalled due to demand load o=
r store instructions. This accounts mainly for (1) non-completed in-flight =
memory demand loads which coincides with execution units starvation; in add=
ition to (2) cases where stores could impose backpressure on the pipeline w=
hen many of them get buffered at the same time (less common out of the two)=
.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all demand loads  (including speculative)",
-        "MetricExpr": "1000 * L2_RQSTS.DEMAND_DATA_RD_MISS / INST_RETIRED.=
ANY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "L2MPKI_Load"
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache",
+        "MetricExpr": "max((EXE_ACTIVITY.BOUND_ON_LOADS - MEMORY_ACTIVITY.=
STALLS_L1D_MISS) / CPU_CLK_UNHALTED.THREAD, 0)",
+        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
+        "MetricName": "tma_l1_bound",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled without loads missing the L1 data cache.  The L1 data cache typical=
ly has the shortest latency.  However; in certain cases like loads blocked =
on older stores; a load might suffer due to high latency even though it is =
being satisfied by the L1. Another example is loads who miss in the TLB. Th=
ese cases are characterized by execution unit stalls; while some non-comple=
ted demand load lives in the machine without having that demand load missin=
g the L1 cache.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "L2 cache hits per kilo instruction for all re=
quest types (including speculative)",
-        "MetricExpr": "1000 * (L2_RQSTS.REFERENCES - L2_RQSTS.MISS) / INST=
_RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "L2HPKI_All"
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
+        "MetricExpr": "min(7 * cpu@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\\=3D0=
x1@ + DTLB_LOAD_MISSES.WALK_ACTIVE, max(CYCLE_ACTIVITY.CYCLES_MEM_ANY - MEM=
ORY_ACTIVITY.CYCLES_L1D_MISS, 0)) / CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "MemoryTLB;TopdownL4;tma_L4_group;tma_l1_bound_grou=
p",
+        "MetricName": "tma_dtlb_load",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "L2 cache hits per kilo instruction for all de=
mand loads  (including speculative)",
-        "MetricExpr": "1000 * L2_RQSTS.DEMAND_DATA_RD_HIT / INST_RETIRED.A=
NY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "L2HPKI_Load"
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the (first level) DTLB was missed by load accesses, that late=
r on hit in second-level TLB (STLB)",
+        "MetricExpr": "tma_dtlb_load - tma_load_stlb_miss",
+        "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_load_gro=
up",
+        "MetricName": "tma_load_stlb_hit",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY"=
,
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "L3MPKI"
+        "BriefDescription": "This metric estimates the fraction of cycles =
where the Second-level TLB (STLB) was missed by load accesses, performing a=
 hardware page walk",
+        "MetricExpr": "DTLB_LOAD_MISSES.WALK_ACTIVE / CPU_CLK_UNHALTED.THR=
EAD",
+        "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_load_gro=
up",
+        "MetricName": "tma_load_stlb_miss",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
-        "MetricExpr": "1000 * MEM_LOAD_RETIRED.FB_HIT / INST_RETIRED.ANY",
-        "MetricGroup": "CacheMisses;Mem",
-        "MetricName": "FB_HPKI"
+        "BriefDescription": "This metric roughly estimates fraction of cyc=
les when the memory subsystem had loads blocked since they could not forwar=
d data from earlier (in program order) overlapping stores",
+        "MetricExpr": "min(13 * LD_BLOCKS.STORE_FORWARD / CPU_CLK_UNHALTED=
.THREAD, 1)",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
+        "MetricName": "tma_store_fwd_blk",
+        "PublicDescription": "This metric roughly estimates fraction of cy=
cles when the memory subsystem had loads blocked since they could not forwa=
rd data from earlier (in program order) overlapping stores. To streamline m=
emory operations in the pipeline; a load can avoid waiting for memory if a =
prior in-flight store is writing the data that the load wants to read (stor=
e forwarding process). However; in some cases the load may be blocked for a=
 significant time pending the store forward. For example; when the prior st=
ore is writing a smaller region than the load is reading.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
-        "MetricConstraint": "NO_NMI_WATCHDOG",
-        "MetricExpr": "(ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_P=
ENDING + DTLB_STORE_MISSES.WALK_PENDING) / (4 * CORE_CLKS)",
-        "MetricGroup": "Mem;MemoryTLB",
-        "MetricName": "Page_Walks_Utilization"
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
+        "MetricExpr": "min((16 * max(0, MEM_INST_RETIRED.LOCK_LOADS - L2_R=
QSTS.ALL_RFO) + MEM_INST_RETIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES *=
 (10 * L2_RQSTS.RFO_HIT + min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUT=
STANDING.CYCLES_WITH_DEMAND_RFO))) / CPU_CLK_UNHALTED.THREAD, 1)",
+        "MetricGroup": "Offcore;TopdownL4;tma_L4_group;tma_l1_bound_group"=
,
+        "MetricName": "tma_lock_latency",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L1D_Cache_Fill_BW"
+        "BriefDescription": "This metric estimates fraction of cycles hand=
ling memory load split accesses - load that cross 64-byte cache line bounda=
ry. ",
+        "MetricExpr": "min(Load_Miss_Real_Latency * LD_BLOCKS.NO_SR / CPU_=
CLK_UNHALTED.THREAD, 1)",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
+        "MetricName": "tma_split_loads",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L2_Cache_Fill_BW"
+        "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
+        "MetricExpr": "L1D_PEND_MISS.FB_FULL / CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "MemoryBW;TopdownL4;tma_L4_group;tma_l1_bound_group=
",
+        "MetricName": "tma_fb_full",
+        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory).",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration=
_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L3_Cache_Fill_BW"
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads",
+        "MetricExpr": "(MEMORY_ACTIVITY.STALLS_L1D_MISS - MEMORY_ACTIVITY.=
STALLS_L2_MISS) / CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
+        "MetricName": "tma_l2_bound",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 / d=
uration_time",
-        "MetricGroup": "Mem;MemoryBW;Offcore",
-        "MetricName": "L3_Cache_Access_BW"
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
+        "MetricExpr": "(MEMORY_ACTIVITY.STALLS_L2_MISS - MEMORY_ACTIVITY.S=
TALLS_L3_MISS) / CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
+        "MetricName": "tma_l3_bound",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Rate of silent evictions from the L2 cache pe=
r Kilo instruction where the evicted lines are dropped (no writeback to L3 =
or memory)",
-        "MetricExpr": "1000 * L2_LINES_OUT.SILENT / Instructions",
-        "MetricGroup": "L2Evicts;Mem;Server",
-        "MetricName": "L2_Evictions_Silent_PKI"
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
+        "MetricExpr": "min(((28 * (CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHAL=
TED.REF_TSC * #SYSTEM_TSC_FREQ / 1e9 / (duration_time * 1e3 / 1e3)) - 3 * (=
CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC * #SYSTEM_TSC_FREQ / 1e9=
 / (duration_time * 1e3 / 1e3))) * (MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD * (OCR=
.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM / (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM +=
 OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) + (27 * (CPU_CLK_UNHALTED.=
THREAD / CPU_CLK_UNHALTED.REF_TSC * #SYSTEM_TSC_FREQ / 1e9 / (duration_time=
 * 1e3 / 1e3)) - 3 * (CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC * =
#SYSTEM_TSC_FREQ / 1e9 / (duration_time * 1e3 / 1e3))) * MEM_LOAD_L3_HIT_RE=
TIRED.XSNP_MISS) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS =
/ 2) / CPU_CLK_UNHALTED.THREAD, 1)",
+        "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_l3_bound_group",
+        "MetricName": "tma_contested_accesses",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Rate of non silent evictions from the L2 cach=
e per Kilo instruction",
-        "MetricExpr": "1000 * L2_LINES_OUT.NON_SILENT / Instructions",
-        "MetricGroup": "L2Evicts;Mem;Server",
-        "MetricName": "L2_Evictions_NonSilent_PKI"
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
+        "MetricExpr": "min((27 * (CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALT=
ED.REF_TSC * #SYSTEM_TSC_FREQ / 1e9 / (duration_time * 1e3 / 1e3)) - 3 * (C=
PU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC * #SYSTEM_TSC_FREQ / 1e9 =
/ (duration_time * 1e3 / 1e3))) * (MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD + ME=
M_LOAD_L3_HIT_RETIRED.XSNP_FWD * (1 - OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM =
/ (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM + OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_H=
IT_WITH_FWD))) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / =
2) / CPU_CLK_UNHALTED.THREAD, 1)",
+        "MetricGroup": "Offcore;Snoop;TopdownL4;tma_L4_group;tma_l3_bound_=
group",
+        "MetricName": "tma_data_sharing",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
-        "MetricExpr": "L1D_Cache_Fill_BW",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L1D_Cache_Fill_BW_1T"
+        "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited)",
+        "MetricExpr": "min((12 * (CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALT=
ED.REF_TSC * #SYSTEM_TSC_FREQ / 1e9 / (duration_time * 1e3 / 1e3)) - 3 * (C=
PU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC * #SYSTEM_TSC_FREQ / 1e9 =
/ (duration_time * 1e3 / 1e3))) * MEM_LOAD_RETIRED.L3_HIT * (1 + MEM_LOAD_R=
ETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / CPU_CLK_UNHALTED.THREAD, 1)=
",
+        "MetricGroup": "MemoryLat;TopdownL4;tma_L4_group;tma_l3_bound_grou=
p",
+        "MetricName": "tma_l3_hit_latency",
+        "PublicDescription": "This metric represents fraction of cycles wi=
th demand load accesses that hit the L3 cache under unloaded scenarios (pos=
sibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L=
3 hits) will improve the latency; reduce contention with sibling physical c=
ores and increase performance.  Note the value of this node may overlap wit=
h its siblings.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
-        "MetricExpr": "L2_Cache_Fill_BW",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L2_Cache_Fill_BW_1T"
+        "BriefDescription": "This metric measures fraction of cycles where=
 the Super Queue (SQ) was full taking into account all request-types and bo=
th hardware SMT threads (Logical Processors)",
+        "MetricExpr": "(XQ.FULL_CYCLES + L1D_PEND_MISS.L2_STALLS) / CPU_CL=
K_UNHALTED.THREAD",
+        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_l3_bou=
nd_group",
+        "MetricName": "tma_sq_full",
+        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). The Super Queue is used for =
requests to access the L2 cache or to go out to the Uncore.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "L3_Cache_Fill_BW",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L3_Cache_Fill_BW_1T"
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
+        "MetricExpr": "min(MEMORY_ACTIVITY.STALLS_L3_MISS / CPU_CLK_UNHALT=
ED.THREAD - tma_pmm_bound, 1)",
+        "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
+        "MetricName": "tma_dram_bound",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
-        "MetricExpr": "L3_Cache_Access_BW",
-        "MetricGroup": "Mem;MemoryBW;Offcore",
-        "MetricName": "L3_Cache_Access_BW_1T"
+        "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory (DRAM)",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D0x4@) / CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_dram_b=
ound_group",
+        "MetricName": "tma_mem_bandwidth",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory (DRAM).  The underlying heuristic assumes that a simi=
lar off-core traffic is generated by all IA cores. This metric does not agg=
regate non-data-read requests by this logical processor; requests from othe=
r IA Logical Processors/Physical Cores/sockets; or other non-IA devices lik=
e GPU; hence the maximum external memory bandwidth limits may or may not be=
 approached when this metric is flagged (see Uncore counters for that).",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average CPU Utilization",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
-        "MetricGroup": "HPC;Summary",
-        "MetricName": "CPU_Utilization"
+        "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to memory bandwidth Allocation=
 feature (RDT's memory bandwidth throttling).",
+        "MetricExpr": "INT_MISC.MBA_STALLS / CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "MemoryBW;Offcore;Server;TopdownL5;tma_L5_group;tma=
_mem_bandwidth_group",
+        "MetricName": "tma_mba_stalls",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Measured Average Frequency for unhalted proce=
ssors [GHz]",
-        "MetricExpr": "Turbo_Utilization * msr@tsc@ / 1000000000 / duratio=
n_time",
-        "MetricGroup": "Power;Summary",
-        "MetricName": "Average_Frequency"
+        "BriefDescription": "This metric estimates fraction of cycles wher=
e the performance was likely hurt due to latency from external memory (DRAM=
)",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DATA_RD) / CPU_CLK_UNHALTED.THREAD - tma_mem_bandwidth",
+        "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_dram_=
bound_group",
+        "MetricName": "tma_mem_latency",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory (DRA=
M).  This metric does not aggregate requests from other Logical Processors/=
Physical Cores/sockets (see Uncore counters for that).",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "((1 * (FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARI=
TH_INST_RETIRED.SCALAR_DOUBLE + FP_ARITH_INST_RETIRED2.SCALAR_HALF) + 2 * (=
FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED2.COMPLEX_S=
CALAR_HALF) + 4 * (FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST=
_RETIRED.256B_PACKED_DOUBLE) + 8 * (FP_ARITH_INST_RETIRED2.128B_PACKED_HALF=
 + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PA=
CKED_DOUBLE) + 16 * (FP_ARITH_INST_RETIRED2.256B_PACKED_HALF + FP_ARITH_INS=
T_RETIRED.512B_PACKED_SINGLE) + 32 * FP_ARITH_INST_RETIRED2.512B_PACKED_HAL=
F + 4 * AMX_OPS_RETIRED.BF16) / 1000000000) / duration_time",
-        "MetricGroup": "Cor;Flops;HPC",
-        "MetricName": "GFLOPs",
-        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine."
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from local memory",
+        "MetricExpr": "min((66.5 * (CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHA=
LTED.REF_TSC * #SYSTEM_TSC_FREQ / 1e9 / (duration_time * 1e3 / 1e3)) - 12 *=
 (CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC * #SYSTEM_TSC_FREQ / 1=
e9 / (duration_time * 1e3 / 1e3))) * MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * =
(1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / CPU_CLK_UNHA=
LTED.THREAD, 1)",
+        "MetricGroup": "Server;TopdownL5;tma_L5_group;tma_mem_latency_grou=
p",
+        "MetricName": "tma_local_dram",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from local memory. Caching will =
improve the latency and increase performance.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Tera Integer (matrix) Operations Per Second",
-        "MetricExpr": "(8 * AMX_OPS_RETIRED.INT8 / 1e12) / duration_time",
-        "MetricGroup": "Cor;HPC;IntVector;Server",
-        "MetricName": "TIOPS"
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote memory",
+        "MetricExpr": "min((131 * (CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHAL=
TED.REF_TSC * #SYSTEM_TSC_FREQ / 1e9 / (duration_time * 1e3 / 1e3)) - 12 * =
(CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC * #SYSTEM_TSC_FREQ / 1e=
9 / (duration_time * 1e3 / 1e3))) * MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM * =
(1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / CPU_CLK_UNHA=
LTED.THREAD, 1)",
+        "MetricGroup": "Server;Snoop;TopdownL5;tma_L5_group;tma_mem_latenc=
y_group",
+        "MetricName": "tma_remote_dram",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote memory. This is caus=
ed often due to non-optimal NUMA allocations. #link to NUMA article",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
-        "MetricExpr": "CLKS / CPU_CLK_UNHALTED.REF_TSC",
-        "MetricGroup": "Power",
-        "MetricName": "Turbo_Utilization"
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote cache in other socket=
s including synchronizations issues",
+        "MetricExpr": "min(((120 * (CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHA=
LTED.REF_TSC * #SYSTEM_TSC_FREQ / 1e9 / (duration_time * 1e3 / 1e3)) - 12 *=
 (CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC * #SYSTEM_TSC_FREQ / 1=
e9 / (duration_time * 1e3 / 1e3))) * MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM +=
 (120 * (CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC * #SYSTEM_TSC_F=
REQ / 1e9 / (duration_time * 1e3 / 1e3)) - 12 * (CPU_CLK_UNHALTED.THREAD / =
CPU_CLK_UNHALTED.REF_TSC * #SYSTEM_TSC_FREQ / 1e9 / (duration_time * 1e3 / =
1e3))) * MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD) * (1 + MEM_LOAD_RETIRED.FB_HI=
T / MEM_LOAD_RETIRED.L1_MISS / 2) / CPU_CLK_UNHALTED.THREAD, 1)",
+        "MetricGroup": "Offcore;Server;Snoop;TopdownL5;tma_L5_group;tma_me=
m_latency_group",
+        "MetricName": "tma_remote_cache",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote cache in other socke=
ts including synchronizations issues. This is caused often due to non-optim=
al NUMA allocations. #link to NUMA article",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
-        "MetricExpr": "1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UN=
HALTED.REF_DISTRIBUTED if #SMT_on else 0",
-        "MetricGroup": "SMT",
-        "MetricName": "SMT_2T_Utilization"
+        "BriefDescription": "This metric roughly estimates (based on idle =
latencies) how often the CPU was stalled on accesses to external 3D-Xpoint =
(Crystal Ridge, a.k.a",
+        "MetricExpr": "min(((1 - (19 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_DR=
AM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS)) + 10 * (MEM_=
LOAD_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_R=
ETIRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * (1 + MEM_LOAD_RETIR=
ED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMOTE_HIT=
M * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))) / (19 * (MEM=
_LOAD_L3_MISS_RETIRED.REMOTE_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD=
_RETIRED.L1_MISS)) + 10 * (MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_L=
OAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.R=
EMOTE_FWD * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_=
LOAD_L3_MISS_RETIRED.REMOTE_HITM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_=
RETIRED.L1_MISS)) + (25 * (MEM_LOAD_RETIRED.LOCAL_PMM * (1 + MEM_LOAD_RETIR=
ED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS)) + 33 * (MEM_LOAD_L3_MISS_RETIRED.REM=
OTE_PMM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))))) * (M=
EMORY_ACTIVITY.STALLS_L3_MISS / CPU_CLK_UNHALTED.THREAD) if 1e6 * (MEM_LOAD=
_L3_MISS_RETIRED.REMOTE_PMM + MEM_LOAD_RETIRED.LOCAL_PMM) > MEM_LOAD_RETIRE=
D.L1_MISS else 0), 1)",
+        "MetricGroup": "MemoryBound;Server;TmaL3mem;TopdownL3;tma_L3_group=
;tma_memory_bound_group",
+        "MetricName": "tma_pmm_bound",
+        "PublicDescription": "This metric roughly estimates (based on idle=
 latencies) how often the CPU was stalled on accesses to external 3D-Xpoint=
 (Crystal Ridge, a.k.a. IXP) memory by loads, PMM stands for Persistent Mem=
ory Module. ",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.THRE=
AD",
-        "MetricGroup": "OS",
-        "MetricName": "Kernel_Utilization"
+        "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to RFO store memory accesses; RFO store issue a read-for-ownership =
request before the write",
+        "MetricExpr": "EXE_ACTIVITY.BOUND_ON_STORES / CPU_CLK_UNHALTED.THR=
EAD",
+        "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
+        "MetricName": "tma_store_bound",
+        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to RFO store memory accesses; RFO store issue a read-for-ownership=
 request before the write. Even though store accesses do not typically stal=
l out-of-order CPUs; there are few cases where stores can lead to actual st=
alls. This metric will be flagged should RFO stores be a bottleneck.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
-        "MetricGroup": "OS",
-        "MetricName": "Kernel_CPI"
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
+        "MetricExpr": "(MEM_STORE_RETIRED.L2_HIT * 10 * (1 - MEM_INST_RETI=
RED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES) + (1 - MEM_INST_RETIRED.LOCK_=
LOADS / MEM_INST_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE=
_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_store=
_bound_group",
+        "MetricName": "tma_store_latency",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full)",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
-        "MetricExpr": "(64 * (uncore_imc@cas_count_read@ + uncore_imc@cas_=
count_write@) / 1000000000) / duration_time",
-        "MetricGroup": "HPC;Mem;MemoryBW;SoC",
-        "MetricName": "DRAM_BW_Use"
+        "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
+        "MetricExpr": "min(28 * (CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTE=
D.REF_TSC * #SYSTEM_TSC_FREQ / 1e9 / (duration_time * 1e3 / 1e3)) * OCR.DEM=
AND_RFO.L3_HIT.SNOOP_HITM / CPU_CLK_UNHALTED.THREAD, 1)",
+        "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_store_bound_group",
+        "MetricName": "tma_false_sharing",
+        "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line. ",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average latency of data read request to exter=
nal memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetches=
",
-        "MetricExpr": "1000000000 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / U=
NC_CHA_TOR_INSERTS.IA_MISS_DRD) / (Socket_CLKS / duration_time)",
-        "MetricGroup": "Mem;MemoryLat;SoC",
-        "MetricName": "MEM_Read_Latency"
+        "BriefDescription": "This metric represents rate of split store ac=
cesses",
+        "MetricExpr": "MEM_INST_RETIRED.SPLIT_STORES / CPU_CLK_UNHALTED.DI=
STRIBUTED",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_store_bound_group",
+        "MetricName": "tma_split_stores",
+        "PublicDescription": "This metric represents rate of split store a=
ccesses.  Consider aligning your data to the 64-byte cache line granularity=
.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average number of parallel data read requests=
 to external memory. Accounts for demand loads and L1/L2 prefetches",
-        "MetricExpr": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / cha@UNC_CHA_TOR=
_OCCUPANCY.IA_MISS_DRD\\,thresh\\=3D1@",
-        "MetricGroup": "Mem;MemoryBW;SoC",
-        "MetricName": "MEM_Parallel_Reads"
+        "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to Streaming store memory accesses; Streaming store optimize out a =
read request required by RFO stores",
+        "MetricExpr": "min(9 * OCR.STREAMING_WR.ANY_RESPONSE / CPU_CLK_UNH=
ALTED.THREAD, 1)",
+        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_store_=
bound_group",
+        "MetricName": "tma_streaming_stores",
+        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to Streaming store memory accesses; Streaming store optimize out a=
 read request required by RFO stores. Even though store accesses do not typ=
ically stall out-of-order CPUs; there are few cases where stores can lead t=
o actual stalls. This metric will be flagged should Streaming stores be a b=
ottleneck.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average latency of data read request to exter=
nal 3D X-Point memory [in nanoseconds]. Accounts for demand loads and L1/L2=
 data-read prefetches",
-        "MetricExpr": "(1000000000 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PM=
M / UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PMM) / uncore_cha_0@event\\=3D0x1@)",
-        "MetricGroup": "Mem;MemoryLat;Server;SoC",
-        "MetricName": "MEM_PMM_Read_Latency"
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
+        "MetricExpr": "min((7 * cpu@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=
=3D0x1@ + DTLB_STORE_MISSES.WALK_ACTIVE) / CPU_CLK_UNHALTED.DISTRIBUTED, 1)=
",
+        "MetricGroup": "MemoryTLB;TopdownL4;tma_L4_group;tma_store_bound_g=
roup",
+        "MetricName": "tma_dtlb_store",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average latency of data read request to exter=
nal DRAM memory [in nanoseconds]. Accounts for demand loads and L1/L2 data-=
read prefetches",
-        "MetricExpr": " 1000000000 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_DD=
R / UNC_CHA_TOR_INSERTS.IA_MISS_DRD_DDR) / uncore_cha_0@event\\=3D0x1@",
-        "MetricGroup": "Mem;MemoryLat;Server;SoC",
-        "MetricName": "MEM_DRAM_Read_Latency"
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the TLB was missed by store accesses, hitting in the second-l=
evel TLB (STLB)",
+        "MetricExpr": "tma_dtlb_store - tma_store_stlb_miss",
+        "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_store_gr=
oup",
+        "MetricName": "tma_store_stlb_hit",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average 3DXP Memory Bandwidth Use for reads [=
GB / sec]",
-        "MetricExpr": "((64 * UNC_M_PMM_RPQ_INSERTS / 1000000000) / durati=
on_time)",
-        "MetricGroup": "Mem;MemoryBW;Server;SoC",
-        "MetricName": "PMM_Read_BW"
+        "BriefDescription": "This metric estimates the fraction of cycles =
where the STLB was missed by store accesses, performing a hardware page wal=
k",
+        "MetricExpr": "DTLB_STORE_MISSES.WALK_ACTIVE / CPU_CLK_UNHALTED.DI=
STRIBUTED",
+        "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_store_gr=
oup",
+        "MetricName": "tma_store_stlb_miss",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average 3DXP Memory Bandwidth Use for Writes =
[GB / sec]",
-        "MetricExpr": "((64 * UNC_M_PMM_WPQ_INSERTS / 1000000000) / durati=
on_time)",
-        "MetricGroup": "Mem;MemoryBW;Server;SoC",
-        "MetricName": "PMM_Write_BW"
+        "BriefDescription": "This metric represents fraction of slots wher=
e Core non-memory issues were of a bottleneck",
+        "MetricExpr": "max(0, topdown\\-be\\-bound / (topdown\\-fe\\-bound=
 + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - topd=
own\\-mem\\-bound / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\=
\-retiring + topdown\\-be\\-bound)) + 0 * slots",
+        "MetricGroup": "Backend;Compute;TopdownL2;tma_L2_group;tma_L2_grou=
p;tma_backend_bound_group",
+        "MetricName": "tma_core_bound",
+        "PublicDescription": "This metric represents fraction of slots whe=
re Core non-memory issues were of a bottleneck.  Shortage in hardware compu=
te resources; or dependencies in software's instructions are both categoriz=
ed under Core Bound. Hence it may indicate the machine ran out of an out-of=
-order resource; certain execution units are overloaded or dependencies in =
program's data- or instruction-flow are limiting the performance (e.g. FP-c=
hained long-latency arithmetic operations).",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average IO (network or disk) Bandwidth Use fo=
r Writes [GB / sec]",
-        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR * 64 / 1000000000 /=
 duration_time",
-        "MetricGroup": "IoBW;Mem;Server;SoC",
-        "MetricName": "IO_Write_BW"
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the Divider unit was active",
+        "MetricExpr": "ARITH.DIVIDER_ACTIVE / CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_core_bound_group",
+        "MetricName": "tma_divider",
+        "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Socket actual clocks when any core is active =
on that socket",
-        "MetricExpr": "uncore_cha_0@event\\=3D0x1@",
-        "MetricGroup": "SoC",
-        "MetricName": "Socket_CLKS"
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
+        "MetricExpr": "((cpu@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x80@ +=
 (EXE_ACTIVITY.1_PORTS_UTIL + topdown\\-retiring / (topdown\\-fe\\-bound + =
topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) * cpu@EXE=
_ACTIVITY.2_PORTS_UTIL\\,umask\\=3D0xc@)) / CPU_CLK_UNHALTED.THREAD if ARIT=
H.DIVIDER_ACTIVE < CYCLE_ACTIVITY.STALLS_TOTAL - EXE_ACTIVITY.BOUND_ON_LOAD=
S else (EXE_ACTIVITY.1_PORTS_UTIL + topdown\\-retiring / (topdown\\-fe\\-bo=
und + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) * c=
pu@EXE_ACTIVITY.2_PORTS_UTIL\\,umask\\=3D0xc@) / CPU_CLK_UNHALTED.THREAD) +=
 0 * slots",
+        "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
+        "MetricName": "tma_ports_utilization",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
-        "MetricGroup": "Branches;OS",
-        "MetricName": "IpFarBranch"
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
+        "MetricExpr": "cpu@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x80@ / C=
PU_CLK_UNHALTED.THREAD + tma_serializing_operation * (CYCLE_ACTIVITY.STALLS=
_TOTAL - EXE_ACTIVITY.BOUND_ON_LOADS) / CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
+        "MetricName": "tma_ports_utilized_0",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed no uops on any execution port (Logical Processor cycles since IC=
L, Physical Core cycles otherwise). Long-latency instructions like divides =
may contribute to this metric.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C1 residency percent per core",
-        "MetricExpr": "(cstate_core@c1\\-residency@ / msr@tsc@) * 100",
-        "MetricGroup": "Power",
-        "MetricName": "C1_Core_Residency"
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU issue-pipeline was stalled due to serializing operations",
+        "MetricExpr": "RESOURCE_STALLS.SCOREBOARD / CPU_CLK_UNHALTED.THREA=
D",
+        "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_0_group"=
,
+        "MetricName": "tma_serializing_operation",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU issue-pipeline was stalled due to serializing operations. Instruction=
s like CPUID; WRMSR or LFENCE serialize the out-of-order execution which ma=
y limit performance.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C6 residency percent per core",
-        "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
-        "MetricGroup": "Power",
-        "MetricName": "C6_Core_Residency"
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to PAUSE Instructions.",
+        "MetricExpr": "CPU_CLK_UNHALTED.PAUSE / CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "TopdownL6;tma_L6_group;tma_serializing_operation_g=
roup",
+        "MetricName": "tma_slow_pause",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C2 residency percent per package",
-        "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
-        "MetricGroup": "Power",
-        "MetricName": "C2_Pkg_Residency"
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to LFENCE Instructions.",
+        "MetricExpr": "min(13 * MISC2_RETIRED.LFENCE / CPU_CLK_UNHALTED.TH=
READ, 1)",
+        "MetricGroup": "TopdownL6;tma_L6_group;tma_serializing_operation_g=
roup",
+        "MetricName": "tma_memory_fence",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C6 residency percent per package",
-        "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
-        "MetricGroup": "Power",
-        "MetricName": "C6_Pkg_Residency"
+        "BriefDescription": "The Mixing_Vectors metric gives the percentag=
e of injected blend uops out of all uops issued",
+        "MetricExpr": "min(160 * ASSISTS.SSE_AVX_MIX / CPU_CLK_UNHALTED.TH=
READ, 1)",
+        "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_0_group"=
,
+        "MetricName": "tma_mixing_vectors",
+        "PublicDescription": "The Mixing_Vectors metric gives the percenta=
ge of injected blend uops out of all uops issued. Usually a Mixing_Vectors =
over 5% is worth investigating. Read more in Appendix B1 of the Optimizatio=
ns Guide for this topic.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Uncore frequency per die [GHZ]",
-        "MetricExpr": "Socket_CLKS / #num_dies / duration_time / 100000000=
0",
-        "MetricGroup": "SoC",
-        "MetricName": "UNCORE_FREQ"
+        "BriefDescription": "This metric estimates fraction of cycles wher=
e the Advanced Matrix Extensions (AMX) execution engine was busy with tile =
(arithmetic) operations",
+        "MetricExpr": "EXE.AMX_BUSY / CPU_CLK_UNHALTED.DISTRIBUTED",
+        "MetricGroup": "Compute;HPC;Server;TopdownL5;tma_L5_group;tma_port=
s_utilized_0_group",
+        "MetricName": "tma_amx_busy",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "CPU operating frequency (in GHz)",
-        "MetricExpr": "(( CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_T=
SC * #SYSTEM_TSC_FREQ ) / 1000000000) / duration_time",
-        "MetricGroup": "",
-        "MetricName": "cpu_operating_frequency",
-        "ScaleUnit": "1GHz"
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the CPU executed total of 1 uop per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise)",
+        "MetricExpr": "EXE_ACTIVITY.1_PORTS_UTIL / CPU_CLK_UNHALTED.THREAD=
",
+        "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
+        "MetricName": "tma_ports_utilized_1",
+        "PublicDescription": "This metric represents fraction of cycles wh=
ere the CPU executed total of 1 uop per cycle on all execution ports (Logic=
al Processor cycles since ICL, Physical Core cycles otherwise). This can be=
 due to heavy data-dependency among software instructions; or over oversubs=
cribing a particular hardware resource. In some other cases with high 1_Por=
t_Utilized and L1_Bound; this metric can point to L1 data-cache latency bot=
tleneck that may not necessarily manifest with complete execution starvatio=
n (due to the short L1 latency e.g. walking a linked list) - looking at the=
 assembly can be helpful.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "The ratio of number of completed memory load =
instructions to the total number completed instructions",
-        "MetricExpr": "MEM_INST_RETIRED.ALL_LOADS / INST_RETIRED.ANY",
-        "MetricGroup": "",
-        "MetricName": "loads_per_instr",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 2 uops per cycle on all execution ports (Logical Process=
or cycles since ICL, Physical Core cycles otherwise)",
+        "MetricExpr": "EXE_ACTIVITY.2_PORTS_UTIL / CPU_CLK_UNHALTED.THREAD=
",
+        "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
+        "MetricName": "tma_ports_utilized_2",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "The ratio of number of completed memory store=
 instructions to the total number completed instructions",
-        "MetricExpr": "MEM_INST_RETIRED.ALL_STORES / INST_RETIRED.ANY",
-        "MetricGroup": "",
-        "MetricName": "stores_per_instr",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise).",
+        "MetricExpr": "UOPS_EXECUTED.CYCLES_GE_3 / CPU_CLK_UNHALTED.THREAD=
",
+        "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
+        "MetricName": "tma_ports_utilized_3m",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Ratio of number of requests missing L1 data c=
ache (includes data+rfo w/ prefetches) to the total number of completed ins=
tructions",
-        "MetricExpr": "L1D.REPLACEMENT / INST_RETIRED.ANY",
-        "MetricGroup": "",
-        "MetricName": "l1d_mpi",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
+        "MetricExpr": "(UOPS_DISPATCHED.PORT_0 + UOPS_DISPATCHED.PORT_1 + =
UOPS_DISPATCHED.PORT_5_11 + UOPS_DISPATCHED.PORT_6) / (5 * CPU_CLK_UNHALTED=
.DISTRIBUTED)",
+        "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
+        "MetricName": "tma_alu_op_utilization",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Ratio of number of demand load requests hitti=
ng in L1 data cache to the total number of completed instructions ",
-        "MetricExpr": "MEM_LOAD_RETIRED.L1_HIT / INST_RETIRED.ANY",
-        "MetricGroup": "",
-        "MetricName": "l1d_demand_data_read_hits_per_instr",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd b=
ranch)",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_0 / CPU_CLK_UNHALTED.DISTRIBUT=
ED",
+        "MetricGroup": "Compute;TopdownL6;tma_L6_group;tma_alu_op_utilizat=
ion_group",
+        "MetricName": "tma_port_0",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Ratio of number of code read requests missing=
 in L1 instruction cache (includes prefetches) to the total number of compl=
eted instructions",
-        "MetricExpr": "L2_RQSTS.ALL_CODE_RD / INST_RETIRED.ANY",
-        "MetricGroup": "",
-        "MetricName": "l1_i_code_read_misses_with_prefetches_per_instr",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 1 (ALU)",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_1 / CPU_CLK_UNHALTED.DISTRIBUT=
ED",
+        "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p",
+        "MetricName": "tma_port_1",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Ratio of number of completed demand load requ=
ests hitting in L2 cache to the total number of completed instructions ",
-        "MetricExpr": "MEM_LOAD_RETIRED.L2_HIT / INST_RETIRED.ANY",
-        "MetricGroup": "",
-        "MetricName": "l2_demand_data_read_hits_per_instr",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 6 ([HSW+]Primary Branch and simple =
ALU)",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_6 / CPU_CLK_UNHALTED.DISTRIBUT=
ED",
+        "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p",
+        "MetricName": "tma_port_6",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Ratio of number of requests missing L2 cache =
(includes code+data+rfo w/ prefetches) to the total number of completed ins=
tructions",
-        "MetricExpr": "L2_LINES_IN.ALL / INST_RETIRED.ANY",
-        "MetricGroup": "",
-        "MetricName": "l2_mpi",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Load operations",
+        "MetricExpr": "UOPS_DISPATCHED.PORT_2_3_10 / (3 * CPU_CLK_UNHALTED=
.DISTRIBUTED)",
+        "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
+        "MetricName": "tma_load_op_utilization",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Ratio of number of completed data read reques=
t missing L2 cache to the total number of completed instructions",
-        "MetricExpr": "MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
-        "MetricGroup": "",
-        "MetricName": "l2_demand_data_read_mpi",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Store operations",
+        "MetricExpr": "(UOPS_DISPATCHED.PORT_4_9 + UOPS_DISPATCHED.PORT_7_=
8) / (4 * CPU_CLK_UNHALTED.DISTRIBUTED)",
+        "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
+        "MetricName": "tma_store_op_utilization",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Ratio of number of code read request missing =
L2 cache to the total number of completed instructions",
-        "MetricExpr": "L2_RQSTS.CODE_RD_MISS / INST_RETIRED.ANY",
-        "MetricGroup": "",
-        "MetricName": "l2_demand_code_mpi",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
+        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots",
+        "MetricGroup": "TopdownL1;tma_L1_group;tma_L1_group",
+        "MetricName": "tma_retiring",
+        "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided. ",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Ratio of number of data read requests missing=
 last level core cache (includes demand w/ prefetches) to the total number =
of completed instructions",
-        "MetricExpr": "( UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFDATA + UNC_CHA=
_TOR_INSERTS.IA_MISS_DRD + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF ) / INST_RE=
TIRED.ANY",
-        "MetricGroup": "",
-        "MetricName": "llc_data_read_mpi_demand_plus_prefetch",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations -- instructions that require=
 no more than one uop (micro-operation)",
+        "MetricExpr": "max(0, topdown\\-retiring / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - topdow=
n\\-heavy\\-ops / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-=
retiring + topdown\\-be\\-bound)) + 0 * slots",
+        "MetricGroup": "Retire;TopdownL2;tma_L2_group;tma_L2_group;tma_ret=
iring_group",
+        "MetricName": "tma_light_operations",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring light-weight operations -- instructions that requir=
e no more than one uop (micro-operation). This correlates with total number=
 of instructions used by the program. A uops-per-instruction (see UPI metri=
c) ratio of 1 or less should be expected for decently optimized software ru=
nning on Intel Core/Xeon products. While this often indicates efficient X86=
 instructions were executed; high value does not necessarily mean better pe=
rformance cannot be achieved.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Ratio of number of code read requests missing=
 last level core cache (includes demand w/ prefetches) to the total number =
of completed instructions",
-        "MetricExpr": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD / INST_RETIRED.ANY"=
,
-        "MetricGroup": "",
-        "MetricName": "llc_code_read_mpi_demand_plus_prefetch",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "This metric represents overall arithmetic flo=
ating-point (FP) operations fraction the CPU has executed (retired)",
+        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) * UOPS_EXECUTED=
.X87 / UOPS_EXECUTED.THREAD + tma_fp_scalar + tma_fp_vector + tma_fp_amx",
+        "MetricGroup": "HPC;TopdownL3;tma_L3_group;tma_light_operations_gr=
oup",
+        "MetricName": "tma_fp_arith",
+        "PublicDescription": "This metric represents overall arithmetic fl=
oating-point (FP) operations fraction the CPU has executed (retired). Note =
this metric's value may exceed its parent due to use of \"Uops\" CountDomai=
n and FMA double-counting.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) in nano seconds",
-        "MetricExpr": "( 1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD =
/ UNC_CHA_TOR_INSERTS.IA_MISS_DRD ) / ( UNC_CHA_CLOCKTICKS / ( source_count=
(UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD) * #num_packages ) ) ) * duration_time",
-        "MetricGroup": "",
-        "MetricName": "llc_demand_data_read_miss_latency",
-        "ScaleUnit": "1ns"
+        "BriefDescription": "This metric serves as an approximation of leg=
acy x87 usage",
+        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) * UOPS_EXECUTED=
.X87 / UOPS_EXECUTED.THREAD + 0 * slots",
+        "MetricGroup": "Compute;TopdownL4;tma_L4_group;tma_fp_arith_group"=
,
+        "MetricName": "tma_x87_use",
+        "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) addressed to local memory in nano=
 seconds",
-        "MetricExpr": "( 1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_=
LOCAL / UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL ) / ( UNC_CHA_CLOCKTICKS / ( =
source_count(UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL) * #num_packages ) ) )=
 * duration_time",
-        "MetricGroup": "",
-        "MetricName": "llc_demand_data_read_miss_latency_for_local_request=
s",
-        "ScaleUnit": "1ns"
+        "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) scalar uops fraction the CPU has retired",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INS=
T_RETIRED.SCALAR_DOUBLE + FP_ARITH_INST_RETIRED2.SCALAR) / (topdown\\-retir=
ing / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + t=
opdown\\-be\\-bound) * slots)",
+        "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group",
+        "MetricName": "tma_fp_scalar",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) addressed to remote memory in nan=
o seconds",
-        "MetricExpr": "( 1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_=
REMOTE / UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE ) / ( UNC_CHA_CLOCKTICKS / =
( source_count(UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE) * #num_packages ) =
) ) * duration_time",
-        "MetricGroup": "",
-        "MetricName": "llc_demand_data_read_miss_latency_for_remote_reques=
ts",
-        "ScaleUnit": "1ns"
+        "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) vector uops fraction the CPU has retired aggregated across all v=
ector widths",
+        "MetricExpr": "min((FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_=
ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_D=
OUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.51=
2B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE + FP_ARITH_INST=
_RETIRED2.VECTOR) / (topdown\\-retiring / (topdown\\-fe\\-bound + topdown\\=
-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) * slots), 1)",
+        "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group",
+        "MetricName": "tma_fp_vector",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) addressed to Intel(R) Optane(TM) =
Persistent Memory(PMEM) in nano seconds",
-        "MetricExpr": "( 1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_=
PMM / UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PMM ) / ( UNC_CHA_CLOCKTICKS / ( sour=
ce_count(UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PMM) * #num_packages ) ) ) * dur=
ation_time",
-        "MetricGroup": "",
-        "MetricName": "llc_demand_data_read_miss_to_pmem_latency",
-        "ScaleUnit": "1ns"
+        "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 128-bit wide vectors",
+        "MetricExpr": "min((FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_=
ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED2.128B_PACKED_=
HALF) / (topdown\\-retiring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec =
+ topdown\\-retiring + topdown\\-be\\-bound) * slots), 1)",
+        "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group",
+        "MetricName": "tma_fp_vector_128b",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) addressed to DRAM in nano seconds=
",
-        "MetricExpr": "( 1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_=
DDR / UNC_CHA_TOR_INSERTS.IA_MISS_DRD_DDR ) / ( UNC_CHA_CLOCKTICKS / ( sour=
ce_count(UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_DDR) * #num_packages ) ) ) * dur=
ation_time",
-        "MetricGroup": "",
-        "MetricName": "llc_demand_data_read_miss_to_dram_latency",
-        "ScaleUnit": "1ns"
+        "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 256-bit wide vectors",
+        "MetricExpr": "min((FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_=
ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED2.256B_PACKED_=
HALF) / (topdown\\-retiring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec =
+ topdown\\-retiring + topdown\\-be\\-bound) * slots), 1)",
+        "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group",
+        "MetricName": "tma_fp_vector_256b",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by a code fetch to the total number of completed ins=
tructions. This implies it missed in the ITLB (Instruction TLB) and further=
 levels of TLB.",
-        "MetricExpr": "ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.ANY",
-        "MetricGroup": "",
-        "MetricName": "itlb_2nd_level_mpi",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 512-bit wide vectors",
+        "MetricExpr": "min((FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE + FP_=
ARITH_INST_RETIRED.512B_PACKED_SINGLE + FP_ARITH_INST_RETIRED2.512B_PACKED_=
HALF) / (topdown\\-retiring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec =
+ topdown\\-retiring + topdown\\-be\\-bound) * slots), 1)",
+        "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group",
+        "MetricName": "tma_fp_vector_512b",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 512-bit wide vectors. May overcount=
 due to FMA double counting.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Ratio of number of completed page walks (for =
2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total n=
umber of completed instructions. This implies it missed in the Instruction =
Translation Lookaside Buffer (ITLB) and further levels of TLB.",
-        "MetricExpr": "ITLB_MISSES.WALK_COMPLETED_2M_4M / INST_RETIRED.ANY=
",
-        "MetricGroup": "",
-        "MetricName": "itlb_2nd_level_large_page_mpi",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) matrix uops fraction the CPU has retired (aggregated across all =
supported FP datatypes in AMX engine)",
+        "MetricExpr": "cpu@AMX_OPS_RETIRED.BF16\\,cmask\\=3D0x1@ / (topdow=
n\\-retiring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-ret=
iring + topdown\\-be\\-bound) * slots)",
+        "MetricGroup": "Compute;Flops;HPC;Pipeline;Server;TopdownL4;tma_L4=
_group;tma_fp_arith_group",
+        "MetricName": "tma_fp_amx",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) matrix uops fraction the CPU has retired (aggregated across all=
 supported FP datatypes in AMX engine). Refer to AMX_Busy and GFLOPs metric=
s for actual AMX utilization and FP performance, resp.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data loads to the total number of complete=
d instructions. This implies it missed in the DTLB and further levels of TL=
B.",
-        "MetricExpr": "DTLB_LOAD_MISSES.WALK_COMPLETED / INST_RETIRED.ANY"=
,
-        "MetricGroup": "",
-        "MetricName": "dtlb_2nd_level_load_mpi",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "This metric represents overall Integer (Int) =
select operations fraction the CPU has executed (retired)",
+        "MetricExpr": "tma_int_vector_128b + tma_int_vector_256b + tma_shu=
ffles",
+        "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
+        "MetricName": "tma_int_operations",
+        "PublicDescription": "This metric represents overall Integer (Int)=
 select operations fraction the CPU has executed (retired). Vector/Matrix I=
nt operations and shuffles are counted. Note this metric's value may exceed=
 its parent due to use of \"Uops\" CountDomain.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Ratio of number of completed page walks (for =
2 megabyte page sizes) caused by demand data loads to the total number of c=
ompleted instructions. This implies it missed in the Data Translation Looka=
side Buffer (DTLB) and further levels of TLB.",
-        "MetricExpr": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M / INST_RETIRE=
D.ANY",
-        "MetricGroup": "",
-        "MetricName": "dtlb_2nd_level_2mb_large_page_load_mpi",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "This metric represents 128-bit vector Integer=
 ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction the=
 CPU has retired.",
+        "MetricExpr": "(INT_VEC_RETIRED.ADD_128 + INT_VEC_RETIRED.VNNI_128=
) / (topdown\\-retiring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + to=
pdown\\-retiring + topdown\\-be\\-bound) * slots)",
+        "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_L4_group;=
tma_int_operations_group",
+        "MetricName": "tma_int_vector_128b",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data stores to the total number of complet=
ed instructions. This implies it missed in the DTLB and further levels of T=
LB.",
-        "MetricExpr": "DTLB_STORE_MISSES.WALK_COMPLETED / INST_RETIRED.ANY=
",
-        "MetricGroup": "",
-        "MetricName": "dtlb_2nd_level_store_mpi",
-        "ScaleUnit": "1per_instr"
+        "BriefDescription": "This metric represents 256-bit vector Integer=
 ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction the=
 CPU has retired.",
+        "MetricExpr": "(INT_VEC_RETIRED.ADD_256 + INT_VEC_RETIRED.MUL_256 =
+ INT_VEC_RETIRED.VNNI_256) / (topdown\\-retiring / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) * slots)=
",
+        "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_L4_group;=
tma_int_operations_group",
+        "MetricName": "tma_int_vector_256b",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Memory read that miss the last level cache (L=
LC) addressed to local DRAM as a percentage of total memory read accesses, =
does not include LLC prefetches.",
-        "MetricExpr": "100 * ( UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL + UNC=
_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_LOCAL ) / ( UNC_CHA_TOR_INSERTS.IA_MISS_D=
RD_LOCAL + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_LOCAL + UNC_CHA_TOR_INSERTS=
.IA_MISS_DRD_REMOTE + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_REMOTE )",
-        "MetricGroup": "",
-        "MetricName": "numa_reads_addressed_to_local_dram",
-        "ScaleUnit": "1%"
+        "BriefDescription": "This metric approximates arithmetic Integer (=
Int) matrix uops fraction the CPU has retired (aggregated across all suppor=
ted Int datatypes in AMX engine)",
+        "MetricExpr": "cpu@AMX_OPS_RETIRED.INT8\\,cmask\\=3D0x1@ / (topdow=
n\\-retiring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-ret=
iring + topdown\\-be\\-bound) * slots)",
+        "MetricGroup": "Compute;HPC;IntVector;Pipeline;Server;TopdownL4;tm=
a_L4_group;tma_int_operations_group",
+        "MetricName": "tma_int_amx",
+        "PublicDescription": "This metric approximates arithmetic Integer =
(Int) matrix uops fraction the CPU has retired (aggregated across all suppo=
rted Int datatypes in AMX engine). Refer to AMX_Busy and TIOPs metrics for =
actual AMX utilization and Int performance, resp.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Memory reads that miss the last level cache (=
LLC) addressed to remote DRAM as a percentage of total memory read accesses=
, does not include LLC prefetches.",
-        "MetricExpr": "100 * ( UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE + UN=
C_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_REMOTE ) / ( UNC_CHA_TOR_INSERTS.IA_MISS=
_DRD_LOCAL + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_LOCAL + UNC_CHA_TOR_INSER=
TS.IA_MISS_DRD_REMOTE + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_REMOTE )",
-        "MetricGroup": "",
-        "MetricName": "numa_reads_addressed_to_remote_dram",
-        "ScaleUnit": "1%"
+        "BriefDescription": "This metric represents Shuffle (cross \"vecto=
r lane\" data transfers) uops fraction the CPU has retired.",
+        "MetricExpr": "INT_VEC_RETIRED.SHUFFLES / (topdown\\-retiring / (t=
opdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\=
-be\\-bound) * slots)",
+        "MetricGroup": "HPC;Pipeline;TopdownL4;tma_L4_group;tma_int_operat=
ions_group",
+        "MetricName": "tma_shuffles",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Uncore operating frequency in GHz",
-        "MetricExpr": "( UNC_CHA_CLOCKTICKS / ( source_count(UNC_CHA_CLOCK=
TICKS) * #num_packages ) / 1000000000) / duration_time",
-        "MetricGroup": "",
-        "MetricName": "uncore_frequency",
-        "ScaleUnit": "1GHz"
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations -- uops for memory load or store a=
ccesses.",
+        "MetricExpr": "max(0, topdown\\-retiring / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - topdow=
n\\-heavy\\-ops / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-=
retiring + topdown\\-be\\-bound)) * MEM_UOP_RETIRED.ANY / (topdown\\-retiri=
ng / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + to=
pdown\\-be\\-bound) * slots)",
+        "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
+        "MetricName": "tma_memory_operations",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data t=
ransmit bandwidth (MB/sec)",
-        "MetricExpr": "( UNC_UPI_TxL_FLITS.ALL_DATA * (64 / 9.0) / 1000000=
) / duration_time",
-        "MetricGroup": "",
-        "MetricName": "upi_data_transmit_bw",
-        "ScaleUnit": "1MB/s"
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions -- where one uop can represent mu=
ltiple contiguous instructions",
+        "MetricExpr": "max(0, topdown\\-retiring / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - topdow=
n\\-heavy\\-ops / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-=
retiring + topdown\\-be\\-bound)) * INST_RETIRED.MACRO_FUSED / (topdown\\-r=
etiring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring=
 + topdown\\-be\\-bound) * slots)",
+        "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
+        "MetricName": "tma_fused_instructions",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring fused instructions -- where one uop can represent m=
ultiple contiguous instructions. The instruction pairs of CMP+JCC or DEC+JC=
C are commonly used examples.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "DDR memory read bandwidth (MB/sec)",
-        "MetricExpr": "( UNC_M_CAS_COUNT.RD * 64 / 1000000) / duration_tim=
e",
-        "MetricGroup": "",
-        "MetricName": "memory_bandwidth_read",
-        "ScaleUnit": "1MB/s"
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring branch instructions that were not fused",
+        "MetricExpr": "max(0, topdown\\-retiring / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - topdow=
n\\-heavy\\-ops / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-=
retiring + topdown\\-be\\-bound)) * (BR_INST_RETIRED.ALL_BRANCHES - INST_RE=
TIRED.MACRO_FUSED) / (topdown\\-retiring / (topdown\\-fe\\-bound + topdown\=
\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) * slots)",
+        "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
+        "MetricName": "tma_non_fused_branches",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring branch instructions that were not fused. Non-condit=
ional branches like direct JMP or CALL would count here. Can be used to exa=
mine fusible conditional jumps that were not fused.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "DDR memory write bandwidth (MB/sec)",
-        "MetricExpr": "( UNC_M_CAS_COUNT.WR * 64 / 1000000) / duration_tim=
e",
-        "MetricGroup": "",
-        "MetricName": "memory_bandwidth_write",
-        "ScaleUnit": "1MB/s"
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring NOP (no op) instructions",
+        "MetricExpr": "max(0, topdown\\-retiring / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - topdow=
n\\-heavy\\-ops / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-=
retiring + topdown\\-be\\-bound)) * INST_RETIRED.NOP / (topdown\\-retiring =
/ (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdo=
wn\\-be\\-bound) * slots)",
+        "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
+        "MetricName": "tma_nop_instructions",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring NOP (no op) instructions. Compilers often use NOPs =
for certain address alignments - e.g. start address of a function or loop b=
ody.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "DDR memory bandwidth (MB/sec)",
-        "MetricExpr": "(( UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR ) * 64 /=
 1000000) / duration_time",
-        "MetricGroup": "",
-        "MetricName": "memory_bandwidth_total",
-        "ScaleUnit": "1MB/s"
+        "BriefDescription": "This metric represents the remaining light uo=
ps fraction the CPU has executed - remaining means not covered by other sib=
ling nodes. May undercount due to FMA double counting",
+        "MetricExpr": "max(0, max(0, topdown\\-retiring / (topdown\\-fe\\-=
bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) -=
 topdown\\-heavy\\-ops / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + top=
down\\-retiring + topdown\\-be\\-bound)) - (tma_fp_arith + tma_int_operatio=
ns + tma_memory_operations + tma_fused_instructions + tma_non_fused_branche=
s + tma_nop_instructions))",
+        "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
+        "MetricName": "tma_other_light_ops",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Intel(R) Optane(TM) Persistent Memory(PMEM) m=
emory read bandwidth (MB/sec)",
-        "MetricExpr": "( UNC_M_PMM_RPQ_INSERTS * 64 / 1000000) / duration_=
time",
-        "MetricGroup": "",
-        "MetricName": "pmem_memory_bandwidth_read",
-        "ScaleUnit": "1MB/s"
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or microcoded sequences",
+        "MetricExpr": "topdown\\-heavy\\-ops / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots"=
,
+        "MetricGroup": "Retire;TopdownL2;tma_L2_group;tma_L2_group;tma_ret=
iring_group",
+        "MetricName": "tma_heavy_operations",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or microcoded sequences. This highly-correlates with the=
 uop length of these instructions/sequences.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Intel(R) Optane(TM) Persistent Memory(PMEM) m=
emory write bandwidth (MB/sec)",
-        "MetricExpr": "( UNC_M_PMM_WPQ_INSERTS * 64 / 1000000) / duration_=
time",
-        "MetricGroup": "",
-        "MetricName": "pmem_memory_bandwidth_write",
-        "ScaleUnit": "1MB/s"
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring instructions that that are decoder into two or up to=
 ([SNB+] four; [ADL+] five) uops",
+        "MetricExpr": "topdown\\-heavy\\-ops / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - tma_microc=
ode_sequencer",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_heavy_operations_group"=
,
+        "MetricName": "tma_few_uops_instructions",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring instructions that that are decoder into two or up t=
o ([SNB+] four; [ADL+] five) uops. This highly-correlates with the number o=
f uops in such instructions.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Intel(R) Optane(TM) Persistent Memory(PMEM) m=
emory bandwidth (MB/sec)",
-        "MetricExpr": "(( UNC_M_PMM_RPQ_INSERTS + UNC_M_PMM_WPQ_INSERTS ) =
* 64 / 1000000) / duration_time",
-        "MetricGroup": "",
-        "MetricName": "pmem_memory_bandwidth_total",
-        "ScaleUnit": "1MB/s"
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was retiring uops fetched by the Microcode Sequencer (MS) unit",
+        "MetricExpr": "UOPS_RETIRED.MS / slots",
+        "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_heavy_operatio=
ns_group",
+        "MetricName": "tma_microcode_sequencer",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The M=
S is used for CISC instructions not supported by the default decoders (like=
 repeat move strings; or CPUID); or by microcode assists used to address so=
me operation modes (like in Floating Point assists). These cases can often =
be avoided.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the CPU.",
-        "MetricExpr": "( UNC_CHA_TOR_INSERTS.IO_PCIRDCUR * 64 / 1000000) /=
 duration_time",
-        "MetricGroup": "",
-        "MetricName": "io_bandwidth_disk_or_network_writes",
-        "ScaleUnit": "1MB/s"
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops delivered by the Microcode_Sequencer as a result of Assists=
",
+        "MetricExpr": "min(100 * cpu@ASSISTS.ANY\\,umask\\=3D0x1B@ / slots=
, 1)",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
+        "MetricName": "tma_assists",
+        "PublicDescription": "This metric estimates fraction of slots the =
CPU retired uops delivered by the Microcode_Sequencer as a result of Assist=
s. Assists are long sequences of uops that are required in certain corner-c=
ases for operations that cannot be handled natively by the execution pipeli=
ne. For example; when working with very small floating point values (so-cal=
led Denormals); the FP units are not set up to perform these operations nat=
ively. Instead; a sequence of instructions to perform the computation on th=
e Denormals is injected into the pipeline. Since these microcode sequences =
might be dozens of uops long; Assists can be extremely deleterious to perfo=
rmance and they can be avoided in many cases.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the CPU.",
-        "MetricExpr": "(( UNC_CHA_TOR_INSERTS.IO_ITOM + UNC_CHA_TOR_INSERT=
S.IO_ITOMCACHENEAR ) * 64 / 1000000) / duration_time",
-        "MetricGroup": "",
-        "MetricName": "io_bandwidth_disk_or_network_reads",
-        "ScaleUnit": "1MB/s"
+        "BriefDescription": "This metric roughly estimates fraction of slo=
ts the CPU retired uops as a result of handing Page Faults",
+        "MetricExpr": "99 * ASSISTS.PAGE_FAULT / slots",
+        "MetricGroup": "TopdownL5;tma_L5_group;tma_assists_group",
+        "MetricName": "tma_page_faults",
+        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Page Faults. A Page Fault m=
ay apply on first application access to a memory page. Note operating syste=
m handling of page faults accounts for the majority of its cost.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Uops delivered from decoded instruction cache=
 (decoded stream buffer or DSB) as a percent of total uops delivered to Ins=
truction Decode Queue",
-        "MetricExpr": "100 * ( IDQ.DSB_UOPS / ( IDQ.DSB_UOPS + IDQ.MITE_UO=
PS + IDQ.MS_UOPS + LSD.UOPS ) )",
-        "MetricGroup": "",
-        "MetricName": "percent_uops_delivered_from_decoded_icache",
-        "ScaleUnit": "1%"
+        "BriefDescription": "This metric roughly estimates fraction of slo=
ts the CPU retired uops as a result of handing Floating Point (FP) Assists"=
,
+        "MetricExpr": "30 * ASSISTS.FP / slots",
+        "MetricGroup": "HPC;TopdownL5;tma_L5_group;tma_assists_group",
+        "MetricName": "tma_fp_assists",
+        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Floating Point (FP) Assists=
. FP Assist may apply when working with very small floating point values (s=
o-called denormals).",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Uops delivered from legacy decode pipeline (M=
icro-instruction Translation Engine or MITE) as a percent of total uops del=
ivered to Instruction Decode Queue",
-        "MetricExpr": "100 * ( IDQ.MITE_UOPS / ( IDQ.DSB_UOPS + IDQ.MITE_U=
OPS + IDQ.MS_UOPS + LSD.UOPS ) )",
-        "MetricGroup": "",
-        "MetricName": "percent_uops_delivered_from_legacy_decode_pipeline"=
,
-        "ScaleUnit": "1%"
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops as a result of handing SSE to AVX* or AVX* to SSE transitio=
n Assists. ",
+        "MetricExpr": "63 * ASSISTS.SSE_AVX_MIX / slots",
+        "MetricGroup": "HPC;TopdownL5;tma_L5_group;tma_assists_group",
+        "MetricName": "tma_avx_assists",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Uops delivered from microcode sequencer (MS) =
as a percent of total uops delivered to Instruction Decode Queue",
-        "MetricExpr": "100 * ( IDQ.MS_UOPS / ( IDQ.DSB_UOPS + IDQ.MITE_UOP=
S + IDQ.MS_UOPS + LSD.UOPS ) )",
-        "MetricGroup": "",
-        "MetricName": "percent_uops_delivered_from_microcode_sequencer",
-        "ScaleUnit": "1%"
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU retired uops originated from CISC (complex instruction set computer) in=
struction",
+        "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
+        "MetricName": "tma_cisc",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU retired uops originated from CISC (complex instruction set computer) i=
nstruction. A CISC instruction has multiple uops that are required to perfo=
rm the instruction's functionality as in the case of read-modify-write as a=
n example. Since these instructions require multiple uops they may or may n=
ot imply sub-optimal use of machine resources.",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Bandwidth (MB/sec) of read requests that miss=
 the last level cache (LLC) and go to local memory.",
-        "MetricExpr": "( UNC_CHA_REQUESTS.READS_LOCAL * 64 / 1000000) / du=
ration_time",
-        "MetricGroup": "",
-        "MetricName": "llc_miss_local_memory_bandwidth_read",
-        "ScaleUnit": "1MB/s"
+        "BriefDescription": "C1 residency percent per core",
+        "MetricExpr": "cstate_core@c1\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C1_Core_Residency",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Bandwidth (MB/sec) of write requests that mis=
s the last level cache (LLC) and go to local memory.",
-        "MetricExpr": "( UNC_CHA_REQUESTS.WRITES_LOCAL * 64 / 1000000) / d=
uration_time",
-        "MetricGroup": "",
-        "MetricName": "llc_miss_local_memory_bandwidth_write",
-        "ScaleUnit": "1MB/s"
+        "BriefDescription": "C6 residency percent per core",
+        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C6_Core_Residency",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Bandwidth (MB/sec) of read requests that miss=
 the last level cache (LLC) and go to remote memory.",
-        "MetricExpr": "( UNC_CHA_REQUESTS.READS_REMOTE * 64 / 1000000) / d=
uration_time",
-        "MetricGroup": "",
-        "MetricName": "llc_miss_remote_memory_bandwidth_read",
-        "ScaleUnit": "1MB/s"
+        "BriefDescription": "C2 residency percent per package",
+        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C2_Pkg_Residency",
+        "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Bandwidth (MB/sec) of write requests that mis=
s the last level cache (LLC) and go to remote memory.",
-        "MetricExpr": "( UNC_CHA_REQUESTS.WRITES_REMOTE * 64 / 1000000) / =
duration_time",
-        "MetricGroup": "",
-        "MetricName": "llc_miss_remote_memory_bandwidth_write",
-        "ScaleUnit": "1MB/s"
+        "BriefDescription": "C6 residency percent per package",
+        "MetricExpr": "cstate_pkg@c6\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C6_Pkg_Residency",
+        "ScaleUnit": "100%"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-memory.js=
on b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-memory.json
index 41d7cd4958a1..b77fd0f7ab50 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-memory.json
@@ -1,499 +1,461 @@
 [
     {
-        "BriefDescription": "IMC Clockticks at DCLK frequency",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x01",
-        "EventName": "UNC_M_CLOCKTICKS",
+        "BriefDescription": "Activate due to read, write, underfill, or by=
pass",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_ACT_COUNT.ALL",
         "PerPkg": "1",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "DRAM Activate Count : Counts the number of D=
RAM Activate commands sent on this channel.  Activate commands are issued t=
o open up a page on the DRAM devices so that it can be read or written to w=
ith a CAS.  One can calculate the number of Page Misses by subtracting the =
number of Page Miss precharges from the number of Activates.",
+        "UMask": "0xff",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "IMC Clockticks at HCLK frequency",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x01",
-        "EventName": "UNC_M_HCLOCKTICKS",
+        "BriefDescription": "All DRAM CAS commands issued",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT.ALL",
         "PerPkg": "1",
+        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands. : All DRAM =
Read and Write actions : DRAM RD_CAS and WR_CAS Commands : Counts the total=
 number of DRAM CAS commands issued on this channel.",
+        "UMask": "0xff",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "All DRAM read CAS commands issued (does not i=
nclude underfills)",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands. : Pseudo Cha=
nnel 0",
         "EventCode": "0x05",
-        "EventName": "UNC_M_CAS_COUNT.RD_REG",
+        "EventName": "UNC_M_CAS_COUNT.PCH0",
         "PerPkg": "1",
-        "UMask": "0x00000000c1",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands. : Pseudo Ch=
annel 0 : DRAM RD_CAS and WR_CAS Commands",
+        "UMask": "0x40",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "DRAM underfill read CAS commands issued",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands. : Pseudo Cha=
nnel 1",
         "EventCode": "0x05",
-        "EventName": "UNC_M_CAS_COUNT.RD_UNDERFILL",
+        "EventName": "UNC_M_CAS_COUNT.PCH1",
         "PerPkg": "1",
-        "UMask": "0x00000000c4",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands. : Pseudo Ch=
annel 1 : DRAM RD_CAS and WR_CAS Commands",
+        "UMask": "0x80",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "All DRAM read CAS commands issued (including =
underfills)",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
         "EventCode": "0x05",
         "EventName": "UNC_M_CAS_COUNT.RD",
         "PerPkg": "1",
-        "UMask": "0x00000000cf",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands : Counts the=
 total number of DRAM Read CAS commands issued on this channel.  This inclu=
des underfills.",
+        "UMask": "0xcf",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "All DRAM write CAS commands issued",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.",
         "EventCode": "0x05",
-        "EventName": "UNC_M_CAS_COUNT.WR",
+        "EventName": "UNC_M_CAS_COUNT.RD_PRE_REG",
         "PerPkg": "1",
-        "UMask": "0x00000000f0",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands. : DRAM RD_C=
AS and WR_CAS Commands",
+        "UMask": "0xc2",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Read Pending Queue Allocations",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x10",
-        "EventName": "UNC_M_RPQ_INSERTS.PCH0",
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT.RD_PRE_UNDERFILL",
         "PerPkg": "1",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands. : DRAM RD_C=
AS and WR_CAS Commands",
+        "UMask": "0xc8",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Read Pending Queue Allocations",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x10",
-        "EventName": "UNC_M_RPQ_INSERTS.PCH1",
+        "BriefDescription": "All DRAM read CAS commands issued (does not i=
nclude underfills)",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT.RD_REG",
         "PerPkg": "1",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands. : DRAM RD_C=
AS commands w/out auto-pre : DRAM RD_CAS and WR_CAS Commands : Counts the t=
otal number or DRAM Read CAS commands issued on this channel.  This include=
s both regular RD CAS commands as well as those with implicit Precharge.   =
We do not filter based on major mode, as RD_CAS is not issued during WMM (w=
ith the exception of underfills).",
+        "UMask": "0xc1",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Write Pending Queue Allocations",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x20",
-        "EventName": "UNC_M_WPQ_INSERTS.PCH0",
+        "BriefDescription": "DRAM underfill read CAS commands issued",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT.RD_UNDERFILL",
         "PerPkg": "1",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands. : Underfill=
 Read Issued : DRAM RD_CAS and WR_CAS Commands",
+        "UMask": "0xc4",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Write Pending Queue Allocations",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x20",
-        "EventName": "UNC_M_WPQ_INSERTS.PCH1",
+        "BriefDescription": "All DRAM write CAS commands issued",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT.WR",
         "PerPkg": "1",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands : Counts the=
 total number of DRAM Write CAS commands issued on this channel.",
+        "UMask": "0xf0",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Read Pending Queue Occupancy",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x80",
-        "EventName": "UNC_M_RPQ_OCCUPANCY_PCH0",
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands. : DRAM WR_CA=
S commands w/o auto-pre",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT.WR_NONPRE",
         "PerPkg": "1",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands. : DRAM WR_C=
AS commands w/o auto-pre : DRAM RD_CAS and WR_CAS Commands",
+        "UMask": "0xd0",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Read Pending Queue Occupancy",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x81",
-        "EventName": "UNC_M_RPQ_OCCUPANCY_PCH1",
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT.WR_PRE",
         "PerPkg": "1",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands. : DRAM RD_C=
AS and WR_CAS Commands",
+        "UMask": "0xe0",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Write Pending Queue Occupancy",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x82",
-        "EventName": "UNC_M_WPQ_OCCUPANCY_PCH0",
+        "BriefDescription": "IMC Clockticks at DCLK frequency",
+        "EventCode": "0x01",
+        "EventName": "UNC_M_CLOCKTICKS",
         "PerPkg": "1",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "Number of DRAM DCLK clock cycles while the e=
vent is enabled",
+        "UMask": "0x1",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Write Pending Queue Occupancy",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_M_WPQ_OCCUPANCY_PCH1",
+        "BriefDescription": "IMC Clockticks at HCLK frequency",
+        "EventCode": "0x01",
+        "EventName": "UNC_M_HCLOCKTICKS",
         "PerPkg": "1",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "Number of DRAM HCLK clock cycles while the e=
vent is enabled",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "PMM Read Pending Queue inserts",
+        "EventCode": "0xe3",
+        "EventName": "UNC_M_PMM_RPQ_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts number of read requests allocated in =
the PMM Read Pending Queue.",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "PMM Read Pending Queue occupancy",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
         "EventCode": "0xe0",
         "EventName": "UNC_M_PMM_RPQ_OCCUPANCY.ALL_SCH0",
         "PerPkg": "1",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "Accumulates the per cycle occupancy of the P=
MM Read Pending Queue.",
+        "UMask": "0x1",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "PMM Read Pending Queue occupancy",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
         "EventCode": "0xe0",
         "EventName": "UNC_M_PMM_RPQ_OCCUPANCY.ALL_SCH1",
         "PerPkg": "1",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "Accumulates the per cycle occupancy of the P=
MM Read Pending Queue.",
+        "UMask": "0x2",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "PMM Read Pending Queue inserts",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xe3",
-        "EventName": "UNC_M_PMM_RPQ_INSERTS",
+        "BriefDescription": "PMM Read Pending Queue Occupancy",
+        "EventCode": "0xE0",
+        "EventName": "UNC_M_PMM_RPQ_OCCUPANCY.GNT_WAIT_SCH0",
         "PerPkg": "1",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "PMM Read Pending Queue Occupancy : Accumulat=
es the per cycle occupancy of the PMM Read Pending Queue.",
+        "UMask": "0x10",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "PMM Write Pending Queue Occupancy",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xe4",
-        "EventName": "UNC_M_PMM_WPQ_OCCUPANCY.ALL",
+        "BriefDescription": "PMM Read Pending Queue Occupancy",
+        "EventCode": "0xE0",
+        "EventName": "UNC_M_PMM_RPQ_OCCUPANCY.GNT_WAIT_SCH1",
+        "PerPkg": "1",
+        "PublicDescription": "PMM Read Pending Queue Occupancy : Accumulat=
es the per cycle occupancy of the PMM Read Pending Queue.",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "PMM Read Pending Queue Occupancy",
+        "EventCode": "0xe0",
+        "EventName": "UNC_M_PMM_RPQ_OCCUPANCY.NO_GNT_SCH0",
         "PerPkg": "1",
-        "UMask": "0x03",
+        "PublicDescription": "Accumulates the per cycle occupancy of the P=
MM Read Pending Queue.",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "PMM Read Pending Queue Occupancy",
+        "EventCode": "0xe0",
+        "EventName": "UNC_M_PMM_RPQ_OCCUPANCY.NO_GNT_SCH1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the per cycle occupancy of the P=
MM Read Pending Queue.",
+        "UMask": "0x8",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "PMM Write Pending Queue inserts",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
         "EventCode": "0xe7",
         "EventName": "UNC_M_PMM_WPQ_INSERTS",
         "PerPkg": "1",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "Counts number of  write requests allocated i=
n the PMM Write Pending Queue.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "PMM Write Pending Queue Occupancy",
+        "EventCode": "0xe4",
+        "EventName": "UNC_M_PMM_WPQ_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "PMM Write Pending Queue Occupancy : Accumula=
tes the per cycle occupancy of the Write Pending Queue to the PMM DIMM.",
+        "UMask": "0x3",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "PMM Write Pending Queue Occupancy",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
         "EventCode": "0xE4",
         "EventName": "UNC_M_PMM_WPQ_OCCUPANCY.ALL_SCH0",
         "PerPkg": "1",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "PMM Write Pending Queue Occupancy : Accumula=
tes the per cycle occupancy of the PMM Write Pending Queue.",
+        "UMask": "0x1",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "PMM Write Pending Queue Occupancy",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
         "EventCode": "0xE4",
         "EventName": "UNC_M_PMM_WPQ_OCCUPANCY.ALL_SCH1",
         "PerPkg": "1",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "PMM Write Pending Queue Occupancy : Accumula=
tes the per cycle occupancy of the PMM Write Pending Queue.",
+        "UMask": "0x2",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Activate due to read, write, underfill, or by=
pass",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x02",
-        "EventName": "UNC_M_ACT_COUNT.ALL",
+        "BriefDescription": "Channel PPD Cycles",
+        "EventCode": "0x85",
+        "EventName": "UNC_M_POWER_CHANNEL_PPD",
         "PerPkg": "1",
-        "UMask": "0x00000000ff",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "Channel PPD Cycles : Number of cycles when a=
ll the ranks in the channel are in PPD mode.  If IBT=3Doff is enabled, then=
 this can be used to count those cycles.  If it is not enabled, then this c=
an count the number of cycles when that could have been taken advantage of.=
",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Precharge due to read on page miss",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x03",
-        "EventName": "UNC_M_PRE_COUNT.RD",
+        "BriefDescription": "CKE_ON_CYCLES by Rank : DIMM ID",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.LOW_0",
         "PerPkg": "1",
-        "UMask": "0x0000000011",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "CKE_ON_CYCLES by Rank : DIMM ID : Number of =
cycles spent in CKE ON mode.  The filter allows you to select a rank to mon=
itor.  If multiple ranks are in CKE ON mode at one time, the counter will O=
NLY increment by one rather than doing accumulation.  Multiple counters wil=
l need to be used to track multiple ranks simultaneously.  There is no dist=
inction between the different CKE modes (APD, PPDS, PPDF).  This can be det=
ermined based on the system programming.  These events should commonly be u=
sed with Invert to get the number of cycles in power saving mode.  Edge Det=
ect is also useful here.  Make sure that you do NOT use Invert with Edge De=
tect (this just confuses the system and is not necessary).",
+        "UMask": "0x1",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Precharge due to write on page miss",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x03",
-        "EventName": "UNC_M_PRE_COUNT.WR",
+        "BriefDescription": "CKE_ON_CYCLES by Rank : DIMM ID",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.LOW_1",
         "PerPkg": "1",
-        "UMask": "0x0000000022",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "CKE_ON_CYCLES by Rank : DIMM ID : Number of =
cycles spent in CKE ON mode.  The filter allows you to select a rank to mon=
itor.  If multiple ranks are in CKE ON mode at one time, the counter will O=
NLY increment by one rather than doing accumulation.  Multiple counters wil=
l need to be used to track multiple ranks simultaneously.  There is no dist=
inction between the different CKE modes (APD, PPDS, PPDF).  This can be det=
ermined based on the system programming.  These events should commonly be u=
sed with Invert to get the number of cycles in power saving mode.  Edge Det=
ect is also useful here.  Make sure that you do NOT use Invert with Edge De=
tect (this just confuses the system and is not necessary).",
+        "UMask": "0x2",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "DRAM Precharge commands. : Precharge due to (=
?)",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x03",
-        "EventName": "UNC_M_PRE_COUNT.PGT",
+        "BriefDescription": "CKE_ON_CYCLES by Rank : DIMM ID",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.LOW_2",
         "PerPkg": "1",
-        "UMask": "0x0000000088",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "CKE_ON_CYCLES by Rank : DIMM ID : Number of =
cycles spent in CKE ON mode.  The filter allows you to select a rank to mon=
itor.  If multiple ranks are in CKE ON mode at one time, the counter will O=
NLY increment by one rather than doing accumulation.  Multiple counters wil=
l need to be used to track multiple ranks simultaneously.  There is no dist=
inction between the different CKE modes (APD, PPDS, PPDF).  This can be det=
ermined based on the system programming.  These events should commonly be u=
sed with Invert to get the number of cycles in power saving mode.  Edge Det=
ect is also useful here.  Make sure that you do NOT use Invert with Edge De=
tect (this just confuses the system and is not necessary).",
+        "UMask": "0x4",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Precharge due to read, write, underfill, or P=
GT",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x03",
-        "EventName": "UNC_M_PRE_COUNT.ALL",
+        "BriefDescription": "CKE_ON_CYCLES by Rank : DIMM ID",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.LOW_3",
         "PerPkg": "1",
-        "UMask": "0x00000000ff",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "CKE_ON_CYCLES by Rank : DIMM ID : Number of =
cycles spent in CKE ON mode.  The filter allows you to select a rank to mon=
itor.  If multiple ranks are in CKE ON mode at one time, the counter will O=
NLY increment by one rather than doing accumulation.  Multiple counters wil=
l need to be used to track multiple ranks simultaneously.  There is no dist=
inction between the different CKE modes (APD, PPDS, PPDF).  This can be det=
ermined based on the system programming.  These events should commonly be u=
sed with Invert to get the number of cycles in power saving mode.  Edge Det=
ect is also useful here.  Make sure that you do NOT use Invert with Edge De=
tect (this just confuses the system and is not necessary).",
+        "UMask": "0x8",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "All DRAM CAS commands issued",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x05",
-        "EventName": "UNC_M_CAS_COUNT.ALL",
+        "BriefDescription": "Clock-Enabled Self-Refresh",
+        "EventCode": "0x43",
+        "EventName": "UNC_M_POWER_SELF_REFRESH",
         "PerPkg": "1",
-        "UMask": "0x00000000ff",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "Clock-Enabled Self-Refresh : Counts the numb=
er of cycles when the iMC is in self-refresh and the iMC still has a clock.=
  This happens in some package C-states.  For example, the PCU may ask the =
iMC to enter self-refresh even though some of the cores are still processin=
g.  One use of this is for Monroe technology.  Self-refresh is required dur=
ing package C3 and C6, but there is no clock in the iMC at this time, so it=
 is not possible to count these cases.",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x05",
-        "EventName": "UNC_M_CAS_COUNT.RD_PRE_REG",
+        "BriefDescription": "Precharge due to read, write, underfill, or P=
GT.",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_PRE_COUNT.ALL",
         "PerPkg": "1",
-        "UMask": "0x00000000c2",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "DRAM Precharge commands. : Counts the number=
 of DRAM Precharge commands sent on this channel.",
+        "UMask": "0xff",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x05",
-        "EventName": "UNC_M_CAS_COUNT.RD_PRE_UNDERFILL",
+        "BriefDescription": "DRAM Precharge commands. : Precharge due to (=
?)",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_PRE_COUNT.PGT",
         "PerPkg": "1",
-        "UMask": "0x00000000c8",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "DRAM Precharge commands. : Precharge due to =
(?) : Counts the number of DRAM Precharge commands sent on this channel.",
+        "UMask": "0x88",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x05",
-        "EventName": "UNC_M_CAS_COUNT.WR_PRE",
+        "BriefDescription": "DRAM Precharge commands. : Prechages from Pag=
e Table",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_PRE_COUNT.PGT_PCH0",
         "PerPkg": "1",
-        "UMask": "0x00000000e0",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "DRAM Precharge commands. : Prechages from Pa=
ge Table : Counts the number of DRAM Precharge commands sent on this channe=
l. : Equivalent to PAGE_EMPTY",
+        "UMask": "0x8",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "PMM Read Pending Queue Occupancy",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xe0",
-        "EventName": "UNC_M_PMM_RPQ_OCCUPANCY.NO_GNT_SCH0",
+        "BriefDescription": "DRAM Precharge commands.",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_PRE_COUNT.PGT_PCH1",
         "PerPkg": "1",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "DRAM Precharge commands. : Counts the number=
 of DRAM Precharge commands sent on this channel.",
+        "UMask": "0x80",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "PMM Read Pending Queue Occupancy",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xe0",
-        "EventName": "UNC_M_PMM_RPQ_OCCUPANCY.NO_GNT_SCH1",
+        "BriefDescription": "Precharge due to read on page miss",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_PRE_COUNT.RD",
         "PerPkg": "1",
-        "UMask": "0x0000000008",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "DRAM Precharge commands. : Counts the number=
 of DRAM Precharge commands sent on this channel.",
+        "UMask": "0x11",
         "Unit": "iMC"
     },
     {
         "BriefDescription": "DRAM Precharge commands. : Precharge due to r=
ead",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
         "EventCode": "0x03",
         "EventName": "UNC_M_PRE_COUNT.RD_PCH0",
         "PerPkg": "1",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "DRAM Precharge commands. : Precharge due to =
read : Counts the number of DRAM Precharge commands sent on this channel. :=
 Precharge from read bank scheduler",
+        "UMask": "0x1",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "DRAM Precharge commands. : Precharge due to w=
rite",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
+        "BriefDescription": "DRAM Precharge commands.",
         "EventCode": "0x03",
-        "EventName": "UNC_M_PRE_COUNT.WR_PCH0",
+        "EventName": "UNC_M_PRE_COUNT.RD_PCH1",
         "PerPkg": "1",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "DRAM Precharge commands. : Counts the number=
 of DRAM Precharge commands sent on this channel.",
+        "UMask": "0x10",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "DRAM Precharge commands",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
+        "BriefDescription": "DRAM Precharge commands.",
         "EventCode": "0x03",
-        "EventName": "UNC_M_PRE_COUNT.UFILL_PCH0",
+        "EventName": "UNC_M_PRE_COUNT.UFILL",
         "PerPkg": "1",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "DRAM Precharge commands. : Counts the number=
 of DRAM Precharge commands sent on this channel.",
+        "UMask": "0x44",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "DRAM Precharge commands. : Prechages from Pag=
e Table",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
+        "BriefDescription": "DRAM Precharge commands.",
         "EventCode": "0x03",
-        "EventName": "UNC_M_PRE_COUNT.PGT_PCH0",
+        "EventName": "UNC_M_PRE_COUNT.UFILL_PCH0",
         "PerPkg": "1",
-        "UMask": "0x0000000008",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "DRAM Precharge commands. : Counts the number=
 of DRAM Precharge commands sent on this channel.",
+        "UMask": "0x4",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "DRAM Precharge commands",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
+        "BriefDescription": "DRAM Precharge commands.",
         "EventCode": "0x03",
-        "EventName": "UNC_M_PRE_COUNT.RD_PCH1",
+        "EventName": "UNC_M_PRE_COUNT.UFILL_PCH1",
         "PerPkg": "1",
-        "UMask": "0x0000000010",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "DRAM Precharge commands. : Counts the number=
 of DRAM Precharge commands sent on this channel.",
+        "UMask": "0x40",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "DRAM Precharge commands",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
+        "BriefDescription": "Precharge due to write on page miss",
         "EventCode": "0x03",
-        "EventName": "UNC_M_PRE_COUNT.WR_PCH1",
+        "EventName": "UNC_M_PRE_COUNT.WR",
         "PerPkg": "1",
-        "UMask": "0x0000000020",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "DRAM Precharge commands. : Counts the number=
 of DRAM Precharge commands sent on this channel.",
+        "UMask": "0x22",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "DRAM Precharge commands",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
+        "BriefDescription": "DRAM Precharge commands. : Precharge due to w=
rite",
         "EventCode": "0x03",
-        "EventName": "UNC_M_PRE_COUNT.UFILL_PCH1",
+        "EventName": "UNC_M_PRE_COUNT.WR_PCH0",
         "PerPkg": "1",
-        "UMask": "0x0000000040",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "DRAM Precharge commands. : Precharge due to =
write : Counts the number of DRAM Precharge commands sent on this channel. =
: Precharge from write bank scheduler",
+        "UMask": "0x2",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "DRAM Precharge commands",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
+        "BriefDescription": "DRAM Precharge commands.",
         "EventCode": "0x03",
-        "EventName": "UNC_M_PRE_COUNT.PGT_PCH1",
+        "EventName": "UNC_M_PRE_COUNT.WR_PCH1",
         "PerPkg": "1",
-        "UMask": "0x0000000080",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "DRAM Precharge commands. : Counts the number=
 of DRAM Precharge commands sent on this channel.",
+        "UMask": "0x20",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "DRAM Precharge commands",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x03",
-        "EventName": "UNC_M_PRE_COUNT.UFILL",
+        "BriefDescription": "Read Pending Queue Allocations",
+        "EventCode": "0x10",
+        "EventName": "UNC_M_RPQ_INSERTS.PCH0",
         "PerPkg": "1",
-        "UMask": "0x0000000044",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "Read Pending Queue Allocations : Counts the =
number of allocations into the Read Pending Queue.  This queue is used to s=
chedule reads out to the memory controller and to track the requests.  Requ=
ests allocate into the RPQ soon after they enter the memory controller, and=
 need credits for an entry in this buffer before being sent from the HA to =
the iMC.  They deallocate after the CAS command has been issued to memory. =
 This includes both ISOCH and non-ISOCH requests.",
+        "UMask": "0x1",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands. : DRAM WR_CA=
S commands w/o auto-pre",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x05",
-        "EventName": "UNC_M_CAS_COUNT.WR_NONPRE",
+        "BriefDescription": "Read Pending Queue Allocations",
+        "EventCode": "0x10",
+        "EventName": "UNC_M_RPQ_INSERTS.PCH1",
         "PerPkg": "1",
-        "UMask": "0x00000000D0",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "Read Pending Queue Allocations : Counts the =
number of allocations into the Read Pending Queue.  This queue is used to s=
chedule reads out to the memory controller and to track the requests.  Requ=
ests allocate into the RPQ soon after they enter the memory controller, and=
 need credits for an entry in this buffer before being sent from the HA to =
the iMC.  They deallocate after the CAS command has been issued to memory. =
 This includes both ISOCH and non-ISOCH requests.",
+        "UMask": "0x2",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands. : Pseudo Cha=
nnel 0",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x05",
-        "EventName": "UNC_M_CAS_COUNT.PCH0",
+        "BriefDescription": "Read Pending Queue Occupancy",
+        "EventCode": "0x80",
+        "EventName": "UNC_M_RPQ_OCCUPANCY_PCH0",
         "PerPkg": "1",
-        "UMask": "0x0000000040",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "Read Pending Queue Occupancy : Accumulates t=
he occupancies of the Read Pending Queue each cycle.  This can then be used=
 to calculate both the average occupancy (in conjunction with the number of=
 cycles not empty) and the average latency (in conjunction with the number =
of allocations).  The RPQ is used to schedule reads out to the memory contr=
oller and to track the requests.  Requests allocate into the RPQ soon after=
 they enter the memory controller, and need credits for an entry in this bu=
ffer before being sent from the HA to the iMC. They deallocate after the CA=
S command has been issued to memory.",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands. : Pseudo Cha=
nnel 1",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x05",
-        "EventName": "UNC_M_CAS_COUNT.PCH1",
+        "BriefDescription": "Read Pending Queue Occupancy",
+        "EventCode": "0x81",
+        "EventName": "UNC_M_RPQ_OCCUPANCY_PCH1",
         "PerPkg": "1",
-        "UMask": "0x0000000080",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "Read Pending Queue Occupancy : Accumulates t=
he occupancies of the Read Pending Queue each cycle.  This can then be used=
 to calculate both the average occupancy (in conjunction with the number of=
 cycles not empty) and the average latency (in conjunction with the number =
of allocations).  The RPQ is used to schedule reads out to the memory contr=
oller and to track the requests.  Requests allocate into the RPQ soon after=
 they enter the memory controller, and need credits for an entry in this bu=
ffer before being sent from the HA to the iMC. They deallocate after the CA=
S command has been issued to memory.",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "PMM Read Pending Queue Occupancy",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xE0",
-        "EventName": "UNC_M_PMM_RPQ_OCCUPANCY.GNT_WAIT_SCH0",
+        "BriefDescription": "Write Pending Queue Allocations",
+        "EventCode": "0x20",
+        "EventName": "UNC_M_WPQ_INSERTS.PCH0",
         "PerPkg": "1",
-        "UMask": "0x0000000010",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "Write Pending Queue Allocations : Counts the=
 number of allocations into the Write Pending Queue.  This can then be used=
 to calculate the average queuing latency (in conjunction with the WPQ occu=
pancy count).  The WPQ is used to schedule write out to the memory controll=
er and to track the writes.  Requests allocate into the WPQ soon after they=
 enter the memory controller, and need credits for an entry in this buffer =
before being sent from the CHA to the iMC.  They deallocate after being iss=
ued to DRAM.  Write requests themselves are able to complete (from the pers=
pective of the rest of the system) as soon they have posted to the iMC.",
+        "UMask": "0x1",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "PMM Read Pending Queue Occupancy",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xE0",
-        "EventName": "UNC_M_PMM_RPQ_OCCUPANCY.GNT_WAIT_SCH1",
+        "BriefDescription": "Write Pending Queue Allocations",
+        "EventCode": "0x20",
+        "EventName": "UNC_M_WPQ_INSERTS.PCH1",
+        "PerPkg": "1",
+        "PublicDescription": "Write Pending Queue Allocations : Counts the=
 number of allocations into the Write Pending Queue.  This can then be used=
 to calculate the average queuing latency (in conjunction with the WPQ occu=
pancy count).  The WPQ is used to schedule write out to the memory controll=
er and to track the writes.  Requests allocate into the WPQ soon after they=
 enter the memory controller, and need credits for an entry in this buffer =
before being sent from the CHA to the iMC.  They deallocate after being iss=
ued to DRAM.  Write requests themselves are able to complete (from the pers=
pective of the rest of the system) as soon they have posted to the iMC.",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Occupancy",
+        "EventCode": "0x82",
+        "EventName": "UNC_M_WPQ_OCCUPANCY_PCH0",
+        "PerPkg": "1",
+        "PublicDescription": "Write Pending Queue Occupancy : Accumulates =
the occupancies of the Write Pending Queue each cycle.  This can then be us=
ed to calculate both the average queue occupancy (in conjunction with the n=
umber of cycles not empty) and the average latency (in conjunction with the=
 number of allocations).  The WPQ is used to schedule write out to the memo=
ry controller and to track the writes.  Requests allocate into the WPQ soon=
 after they enter the memory controller, and need credits for an entry in t=
his buffer before being sent from the HA to the iMC.  They deallocate after=
 being issued to DRAM.  Write requests themselves are able to complete (fro=
m the perspective of the rest of the system) as soon they have posted to th=
e iMC.  This is not to be confused with actually performing the write to DR=
AM.  Therefore, the average latency for this queue is actually not useful f=
or deconstruction intermediate write latencies.  So, we provide filtering b=
ased on if the request has posted or not.  By using the not posted filter, =
we can track how long writes spent in the iMC before completions were sent =
to the HA.  The posted filter, on the other hand, provides information abou=
t how much queueing is actually happening in the iMC for writes before they=
 are actually issued to memory.  High average occupancies will generally co=
incide with high write major mode counts.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Occupancy",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_WPQ_OCCUPANCY_PCH1",
         "PerPkg": "1",
-        "UMask": "0x0000000020",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "Write Pending Queue Occupancy : Accumulates =
the occupancies of the Write Pending Queue each cycle.  This can then be us=
ed to calculate both the average queue occupancy (in conjunction with the n=
umber of cycles not empty) and the average latency (in conjunction with the=
 number of allocations).  The WPQ is used to schedule write out to the memo=
ry controller and to track the writes.  Requests allocate into the WPQ soon=
 after they enter the memory controller, and need credits for an entry in t=
his buffer before being sent from the HA to the iMC.  They deallocate after=
 being issued to DRAM.  Write requests themselves are able to complete (fro=
m the perspective of the rest of the system) as soon they have posted to th=
e iMC.  This is not to be confused with actually performing the write to DR=
AM.  Therefore, the average latency for this queue is actually not useful f=
or deconstruction intermediate write latencies.  So, we provide filtering b=
ased on if the request has posted or not.  By using the not posted filter, =
we can track how long writes spent in the iMC before completions were sent =
to the HA.  The posted filter, on the other hand, provides information abou=
t how much queueing is actually happening in the iMC for writes before they=
 are actually issued to memory.  High average occupancies will generally co=
incide with high write major mode counts.",
         "Unit": "iMC"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-other.jso=
n b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-other.json
index 495ceee21071..fd253e3276df 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-other.json
@@ -1,5141 +1,4465 @@
 [
     {
-        "BriefDescription": "UPI Clockticks",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
+        "BriefDescription": "CHA Clockticks",
         "EventCode": "0x01",
-        "EventName": "UNC_UPI_CLOCKTICKS",
+        "EventName": "UNC_CHA_CLOCKTICKS",
         "PerPkg": "1",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Number of CHA clock cycles while the event i=
s enabled",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Valid Flits Sent : All Data",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x02",
-        "EventName": "UNC_UPI_TxL_FLITS.ALL_DATA",
+        "BriefDescription": "CMS Clockticks",
+        "EventCode": "0xc0",
+        "EventName": "UNC_CHA_CMS_CLOCKTICKS",
         "PerPkg": "1",
-        "UMask": "0x000000000f",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "IRP Clockticks",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x01",
-        "EventName": "UNC_I_CLOCKTICKS",
+        "BriefDescription": "Multi-socket cacheline Directory state lookup=
s; Snoop Not Needed",
+        "EventCode": "0x53",
+        "EventName": "UNC_CHA_DIR_LOOKUP.NO_SNP",
         "PerPkg": "1",
-        "UMaskExt": "0x00000000",
-        "Unit": "IRP"
+        "PublicDescription": "Counts transactions that looked into the mul=
ti-socket cacheline Directory state, and therefore did not send a snoop bec=
ause the Directory indicated it was not needed.",
+        "UMask": "0x2",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "M2P Clockticks",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x01",
-        "EventName": "UNC_M2P_CLOCKTICKS",
+        "BriefDescription": "Multi-socket cacheline Directory state lookup=
s; Snoop Needed",
+        "EventCode": "0x53",
+        "EventName": "UNC_CHA_DIR_LOOKUP.SNP",
         "PerPkg": "1",
-        "UMaskExt": "0x00000000",
-        "Unit": "M2PCIe"
+        "PublicDescription": "Counts  transactions that looked into the mu=
lti-socket cacheline Directory state, and sent one or more snoops, because =
the Directory indicated it was needed.",
+        "UMask": "0x1",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "IIO Clockticks",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x01",
-        "EventName": "UNC_IIO_CLOCKTICKS",
+        "BriefDescription": "Multi-socket cacheline Directory state update=
s; Directory Updated memory write from the HA pipe",
+        "EventCode": "0x54",
+        "EventName": "UNC_CHA_DIR_UPDATE.HA",
         "PerPkg": "1",
-        "PortMask": "0x0000",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts only multi-socket cacheline Directory=
 state updates memory writes issued from the HA pipe. This does not include=
 memory write requests which are for I (Invalid) or E (Exclusive) cacheline=
s.",
+        "UMask": "0x1",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Write request of 4 bytes made by IIO Part0 to=
 Memory",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0",
-        "FCMask": "0x07",
+        "BriefDescription": "Multi-socket cacheline Directory state update=
s; Directory Updated memory write from TOR pipe",
+        "EventCode": "0x54",
+        "EventName": "UNC_CHA_DIR_UPDATE.TOR",
         "PerPkg": "1",
-        "PortMask": "0x0001",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts only multi-socket cacheline Directory=
 state updates due to memory writes issued from the TOR pipe which are the =
result of remote transaction hitting the SF/LLC and returning data Core2Cor=
e. This does not include memory write requests which are for I (Invalid) or=
 E (Exclusive) cachelines.",
+        "UMask": "0x2",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Write request of 4 bytes made by IIO Part1 to=
 Memory",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1",
-        "FCMask": "0x07",
+        "BriefDescription": "Cache and Snoop Filter Lookups; Data Read Req=
uest",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.DATA_RD",
         "PerPkg": "1",
-        "PortMask": "0x0002",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
+        "UMask": "0x1bc1ff",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Write request of 4 bytes made by IIO Part2 to=
 Memory",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2",
-        "FCMask": "0x07",
+        "BriefDescription": "Cache and Snoop Filter Lookups; Snoop Request=
s from a Remote Socket",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.REMOTE_SNP",
         "PerPkg": "1",
-        "PortMask": "0x0004",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state.; Filters for any transaction origi=
nating from the IPQ or IRQ.  This does not include lookups originating from=
 the ISMQ.",
+        "UMask": "0x1c19ff",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Write request of 4 bytes made by IIO Part3 to=
 Memory",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
-        "FCMask": "0x07",
+        "BriefDescription": "All LLC lines in E state that are victimized =
on a fill",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_E",
         "PerPkg": "1",
-        "PortMask": "0x0008",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
+        "UMask": "0x2",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Peer to peer write request of 4 bytes made by=
 IIO Part0 to an IIO target",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART0",
-        "FCMask": "0x07",
+        "BriefDescription": "All LLC lines in M state that are victimized =
on a fill",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_M",
         "PerPkg": "1",
-        "PortMask": "0x0001",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
+        "UMask": "0x1",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Peer to peer write request of 4 bytes made by=
 IIO Part0 to an IIO target",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART1",
-        "FCMask": "0x07",
+        "BriefDescription": "All LLC lines in S state that are victimized =
on a fill",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_S",
         "PerPkg": "1",
-        "PortMask": "0x0002",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
+        "UMask": "0x4",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Peer to peer write request of 4 bytes made by=
 IIO Part0 to an IIO target",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART2",
-        "FCMask": "0x07",
+        "BriefDescription": "OSB Snoop Broadcast : Local InvItoE",
+        "EventCode": "0x55",
+        "EventName": "UNC_CHA_OSB.LOCAL_INVITOE",
         "PerPkg": "1",
-        "PortMask": "0x0004",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "OSB Snoop Broadcast : Local InvItoE : Count =
of OSB snoop broadcasts. Counts by 1 per request causing OSB snoops to be b=
roadcast. Does not count all the snoops generated by OSB.",
+        "UMask": "0x1",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Peer to peer write request of 4 bytes made by=
 IIO Part0 to an IIO target",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART3",
-        "FCMask": "0x07",
+        "BriefDescription": "OSB Snoop Broadcast : Local Rd",
+        "EventCode": "0x55",
+        "EventName": "UNC_CHA_OSB.LOCAL_READ",
         "PerPkg": "1",
-        "PortMask": "0x0008",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "OSB Snoop Broadcast : Local Rd : Count of OS=
B snoop broadcasts. Counts by 1 per request causing OSB snoops to be broadc=
ast. Does not count all the snoops generated by OSB.",
+        "UMask": "0x2",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data requested of the CPU : Card writing to D=
RAM",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART4",
-        "FCMask": "0x07",
+        "BriefDescription": "Requests for exclusive ownership of a cache l=
ine without receiving data",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.INVITOE",
         "PerPkg": "1",
-        "PortMask": "0x0010",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts the total number of requests coming f=
rom a unit on this socket for exclusive ownership of a cache line without r=
eceiving data (INVITOE) to the CHA.",
+        "UMask": "0x30",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data requested of the CPU : Card writing to D=
RAM",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART5",
-        "FCMask": "0x07",
+        "BriefDescription": "Local requests for exclusive ownership of a c=
ache line  without receiving data",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.INVITOE_LOCAL",
         "PerPkg": "1",
-        "PortMask": "0x0020",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts the total number of requests coming f=
rom a unit on this socket for exclusive ownership of a cache line without r=
eceiving data (INVITOE) to the CHA.",
+        "UMask": "0x10",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data requested of the CPU : Card writing to D=
RAM",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART6",
-        "FCMask": "0x07",
+        "BriefDescription": "Read requests made into the CHA",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.READS",
         "PerPkg": "1",
-        "PortMask": "0x0040",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts read requests made into this CHA. Rea=
ds include all read opcodes (including RFO: the Read for Ownership issued b=
efore a  write) .",
+        "UMask": "0x3",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data requested of the CPU : Card writing to D=
RAM",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART7",
-        "FCMask": "0x07",
+        "BriefDescription": "Read requests from a unit on this socket",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.READS_LOCAL",
         "PerPkg": "1",
-        "PortMask": "0x0080",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts read requests coming from a unit on t=
his socket made into this CHA. Reads include all read opcodes (including RF=
O: the Read for Ownership issued before a  write).",
+        "UMask": "0x1",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART4",
-        "FCMask": "0x07",
+        "BriefDescription": "Read requests from a remote socket",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.READS_REMOTE",
         "PerPkg": "1",
-        "PortMask": "0x0010",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts read requests coming from a remote so=
cket made into the CHA. Reads include all read opcodes (including RFO: the =
Read for Ownership issued before a  write).",
+        "UMask": "0x2",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART5",
-        "FCMask": "0x07",
+        "BriefDescription": "Write requests made into the CHA",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.WRITES",
         "PerPkg": "1",
-        "PortMask": "0x0020",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts write requests made into the CHA, inc=
luding streaming, evictions, HitM (Reads from another core to a Modified ca=
cheline), etc.",
+        "UMask": "0xc",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART6",
-        "FCMask": "0x07",
+        "BriefDescription": "Write Requests from a unit on this socket",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.WRITES_LOCAL",
         "PerPkg": "1",
-        "PortMask": "0x0040",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts  write requests coming from a unit on=
 this socket made into this CHA, including streaming, evictions, HitM (Read=
s from another core to a Modified cacheline), etc.",
+        "UMask": "0x4",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART7",
-        "FCMask": "0x07",
+        "BriefDescription": "Read and Write Requests; Writes Remote",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.WRITES_REMOTE",
         "PerPkg": "1",
-        "PortMask": "0x0080",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts the total number of read requests mad=
e into the Home Agent. Reads include all read opcodes (including RFO).  Wri=
tes include all writes (streaming, evictions, HitM, etc).",
+        "UMask": "0x8",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART0",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : All",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.ALL",
         "PerPkg": "1",
-        "PortMask": "0x0001",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : All : Counts the number of ent=
ries successfully inserted into the TOR that match qualifications specified=
 by the subevent.",
+        "UMask": "0xc001ffff",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART1",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : DDR Access",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.DDR",
         "PerPkg": "1",
-        "PortMask": "0x0002",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : DDR Access : Counts the number=
 of entries successfully inserted into the TOR that match qualifications sp=
ecified by the subevent.",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART2",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : SF/LLC Evictions",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.EVICT",
         "PerPkg": "1",
-        "PortMask": "0x0004",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : SF/LLC Evictions : Counts the =
number of entries successfully inserted into the TOR that match qualificati=
ons specified by the subevent. : TOR allocation occurred as a result of SF/=
LLC evictions (came from the ISMQ)",
+        "UMask": "0x2",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART3",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : Just Hits",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.HIT",
         "PerPkg": "1",
-        "PortMask": "0x0008",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : Just Hits : Counts the number =
of entries successfully inserted into the TOR that match qualifications spe=
cified by the subevent.",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART4",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts; All from Local IA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA",
         "PerPkg": "1",
-        "PortMask": "0x0010",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.; A=
ll locally initiated requests from IA Cores",
+        "UMask": "0xc001ff01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART5",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts;CLFlush from Local IA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_CLFLUSH",
         "PerPkg": "1",
-        "PortMask": "0x0020",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.; C=
LFlush events that are initiated from the Core",
+        "UMask": "0xc8c7ff01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART6",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts;CLFlushOpt from Local IA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_CLFLUSHOPT",
         "PerPkg": "1",
-        "PortMask": "0x0040",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.; C=
LFlushOpt events that are initiated from the Core",
+        "UMask": "0xc8d7ff01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART7",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts; CRd from local IA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_CRD",
         "PerPkg": "1",
-        "PortMask": "0x0080",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts; Code read from local IA that mi=
sses in the snoop filter",
+        "UMask": "0xc80fff01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "M2M Clockticks",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x01",
-        "EventName": "UNC_M2M_CLOCKTICKS",
+        "BriefDescription": "TOR Inserts; CRd Pref from local IA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_CRD_PREF",
         "PerPkg": "1",
-        "UMaskExt": "0x00000000",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Inserts; Code read prefetch from local I=
A that misses in the snoop filter",
+        "UMask": "0xc88fff01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "M3UPI Clockticks",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x01",
-        "EventName": "UNC_M3UPI_CLOCKTICKS",
+        "BriefDescription": "TOR Inserts; DRd from local IA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD",
         "PerPkg": "1",
-        "UMaskExt": "0x00000000",
-        "Unit": "M3UPI"
+        "PublicDescription": "TOR Inserts; Data read from local IA that mi=
sses in the snoop filter",
+        "UMask": "0xc817ff01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read requests from a unit on this socket",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x50",
-        "EventName": "UNC_CHA_REQUESTS.READS_LOCAL",
+        "BriefDescription": "TOR Inserts : DRd PTEs issued by iA Cores",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_DRDPTE",
         "PerPkg": "1",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "TOR Inserts : DRd PTEs issued by iA Cores du=
e to a page walk : Counts the number of entries successfully inserted into =
the TOR that match qualifications specified by the subevent.   Does not inc=
lude addressless requests such as locks and interrupts.",
+        "UMask": "0xc837ff01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read requests from a remote socket",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x50",
-        "EventName": "UNC_CHA_REQUESTS.READS_REMOTE",
+        "BriefDescription": "TOR Inserts; DRd Opt from local IA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD_OPT",
         "PerPkg": "1",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "TOR Inserts; Data read opt from local IA tha=
t misses in the snoop filter",
+        "UMask": "0xc827ff01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Write Requests from a unit on this socket",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x50",
-        "EventName": "UNC_CHA_REQUESTS.WRITES_LOCAL",
+        "BriefDescription": "TOR Inserts; DRd Opt Pref from local IA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD_OPT_PREF",
         "PerPkg": "1",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "TOR Inserts; Data read opt prefetch from loc=
al IA that misses in the snoop filter",
+        "UMask": "0xc8a7ff01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read and Write Requests; Writes Remote",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x50",
-        "EventName": "UNC_CHA_REQUESTS.WRITES_REMOTE",
+        "BriefDescription": "TOR Inserts; DRd Pref from local IA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD_PREF",
         "PerPkg": "1",
-        "UMask": "0x0000000008",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "TOR Inserts; Data read prefetch from local I=
A that misses in the snoop filter",
+        "UMask": "0xc897ff01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Requests for exclusive ownership of a cache l=
ine without receiving data",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x50",
-        "EventName": "UNC_CHA_REQUESTS.INVITOE",
+        "BriefDescription": "TOR Inserts; Hits from Local IA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT",
         "PerPkg": "1",
-        "UMask": "0x0000000030",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.",
+        "UMask": "0xc001fd01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "CHA Clockticks",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x01",
-        "EventName": "UNC_CHA_CLOCKTICKS",
+        "BriefDescription": "TOR Inserts; CRd hits from local IA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD",
         "PerPkg": "1",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "TOR Inserts; Code read from local IA that hi=
ts in the snoop filter",
+        "UMask": "0xc80ffd01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts for CRd misses from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
+        "BriefDescription": "TOR Inserts; CRd Pref hits from local IA",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD_PREF",
         "PerPkg": "1",
-        "UMask": "0x00c80ffe01",
-        "UMaskExt": "0x00c80ffe",
+        "PublicDescription": "TOR Inserts; Code read prefetch from local I=
A that hits in the snoop filter",
+        "UMask": "0xc88ffd01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts for DRd misses from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
+        "BriefDescription": "TOR Inserts; DRd hits from local IA",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD",
         "PerPkg": "1",
-        "UMask": "0x00c817fe01",
-        "UMaskExt": "0x00c817fe",
+        "PublicDescription": "TOR Inserts; Data read from local IA that hi=
ts in the snoop filter",
+        "UMask": "0xc817fd01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts for DRd Pref misses from local IA=
",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
+        "BriefDescription": "TOR Inserts : DRd PTEs issued by iA Cores tha=
t Hit the LLC",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRDPTE",
         "PerPkg": "1",
-        "UMask": "0x00c897fe01",
-        "UMaskExt": "0x00c897fe",
+        "PublicDescription": "TOR Inserts : DRd PTEs issued by iA Cores du=
e to page walks that hit the LLC : Counts the number of entries successfull=
y inserted into the TOR that match qualifications specified by the subevent=
.   Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc837fd01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts for ItoM from local IO",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
+        "BriefDescription": "TOR Inserts; DRd Opt hits from local IA",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOM",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD_OPT",
         "PerPkg": "1",
-        "UMask": "0x00cc43ff04",
-        "UMaskExt": "0x00cc43ff",
+        "PublicDescription": "TOR Inserts; Data read opt from local IA tha=
t hits in the snoop filter",
+        "UMask": "0xc827fd01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts for DRd misses from local IA targ=
eting local memory",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
+        "BriefDescription": "TOR Inserts; DRd Opt Pref hits from local IA"=
,
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD_OPT_PREF",
         "PerPkg": "1",
-        "UMask": "0x00c816fe01",
-        "UMaskExt": "0x00c816fe",
+        "PublicDescription": "TOR Inserts; Data read opt prefetch from loc=
al IA that hits in the snoop filter",
+        "UMask": "0xc8a7fd01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts for DRd misses from local IA targ=
eting remote memory",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
+        "BriefDescription": "TOR Inserts; DRd Pref hits from local IA",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD_PREF",
         "PerPkg": "1",
-        "UMask": "0x00c8177e01",
-        "UMaskExt": "0x00c8177e",
+        "PublicDescription": "TOR Inserts; Data read prefetch from local I=
A that hits in the snoop filter",
+        "UMask": "0xc897fd01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts for DRd Pref misses from local IA=
 targeting local memory",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
+        "BriefDescription": "TOR Inserts : ItoMs issued by iA Cores that H=
it LLC",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_LOCAL",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_ITOM",
         "PerPkg": "1",
-        "UMask": "0x00C896FE01",
-        "UMaskExt": "0x00C896FE",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xcc47fd01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts for DRd Pref misses from local IA=
 targeting remote memory",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
+        "BriefDescription": "TOR Inserts; LLCPrefCode hits from local IA",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_REMOTE",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LLCPREFCODE",
         "PerPkg": "1",
-        "UMask": "0x00C8977E01",
-        "UMaskExt": "0x00C8977E",
+        "PublicDescription": "TOR Inserts; Last level cache prefetch code =
read from local IA that hits in the snoop filter",
+        "UMask": "0xcccffd01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Occupancy for DRd misses from local IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD",
+        "BriefDescription": "TOR Inserts; LLCPrefData hits from local IA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LLCPREFDATA",
         "PerPkg": "1",
-        "UMask": "0x00c817fe01",
-        "UMaskExt": "0x00c817fe",
+        "PublicDescription": "TOR Inserts; Last level cache prefetch data =
read from local IA that hits in the snoop filter",
+        "UMask": "0xccd7fd01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Occupancy for DRd misses from local IA ta=
rgeting local memory",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL",
+        "BriefDescription": "TOR Inserts; LLCPrefRFO hits from local IA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LLCPREFRFO",
         "PerPkg": "1",
-        "UMask": "0x00c816fe01",
-        "UMaskExt": "0x00c816fe",
+        "PublicDescription": "TOR Inserts; Last level cache prefetch read =
for ownership from local IA that hits in the snoop filter",
+        "UMask": "0xccc7fd01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Occupancy for DRd misses from local IA ta=
rgeting remote memory",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE",
+        "BriefDescription": "TOR Inserts; RFO hits from local IA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO",
         "PerPkg": "1",
-        "UMask": "0x00c8177e01",
-        "UMaskExt": "0x00c8177e",
+        "PublicDescription": "TOR Inserts; Read for ownership from local I=
A that hits in the snoop filter",
+        "UMask": "0xc807fd01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts for DRds issued by iA Cores targe=
ting PMM Mem that Missed the LLC",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
+        "BriefDescription": "TOR Inserts; RFO Pref hits from local IA",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PMM",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO_PREF",
         "PerPkg": "1",
-        "UMask": "0x00c8178a01",
-        "UMaskExt": "0x00c8178a",
+        "PublicDescription": "TOR Inserts; Read for ownership prefetch fro=
m local IA that hits in the snoop filter",
+        "UMask": "0xc887fd01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts for DRds issued by IA Cores targe=
ting DDR Mem that Missed the LLC",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
+        "BriefDescription": "TOR Inserts;ItoM from Local IA",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_DDR",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_ITOM",
         "PerPkg": "1",
-        "UMask": "0x00c8178601",
-        "UMaskExt": "0x00c81786",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.; I=
toM events that are initiated from the Core",
+        "UMask": "0xcc47ff01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Occupancy for DRds issued by iA Cores tar=
geting DDR Mem that Missed the LLC",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_DDR",
+        "BriefDescription": "TOR Inserts : ItoMCacheNears issued by iA Cor=
es",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_ITOMCACHENEAR",
         "PerPkg": "1",
-        "UMask": "0x00c8178601",
-        "UMaskExt": "0x00c81786",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xcd47ff01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Occupancy for DRds issued by iA Cores tar=
geting PMM Mem that Missed the LLC",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PMM",
+        "BriefDescription": "TOR Inserts; LLCPrefCode from local IA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_LLCPREFCODE",
         "PerPkg": "1",
-        "UMask": "0x00c8178a01",
-        "UMaskExt": "0x00c8178a",
+        "PublicDescription": "TOR Inserts; Last level cache prefetch code =
read from local IA.",
+        "UMask": "0xcccfff01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts for RdCur from local IO",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
+        "BriefDescription": "TOR Inserts; LLCPrefData from local IA",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_LLCPREFDATA",
         "PerPkg": "1",
-        "UMask": "0x00c8f3ff04",
-        "UMaskExt": "0x00c8f3ff",
+        "PublicDescription": "TOR Inserts; Last level cache prefetch data =
read from local IA.",
+        "UMask": "0xccd7ff01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts for ItoMCacheNears from IO device=
s",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
+        "BriefDescription": "TOR Inserts; LLCPrefRFO from local IA",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOMCACHENEAR",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_LLCPREFRFO",
         "PerPkg": "1",
-        "UMask": "0x00cd43ff04",
-        "UMaskExt": "0x00cd43ff",
+        "PublicDescription": "TOR Inserts; Last level cache prefetch read =
for ownership from local IA that misses in the snoop filter",
+        "UMask": "0xccc7ff01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Valid Flits Sent : Slot 0",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x02",
-        "EventName": "UNC_UPI_TxL_FLITS.SLOT0",
+        "BriefDescription": "TOR Inserts; misses from Local IA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
         "PerPkg": "1",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "TOR Inserts : All requests from iA Cores tha=
t Missed the LLC : Counts the number of entries successfully inserted into =
the TOR that match qualifications specified by the subevent.   Does not inc=
lude addressless requests such as locks and interrupts.",
+        "UMask": "0xc001fe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Valid Flits Sent : Slot 1",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x02",
-        "EventName": "UNC_UPI_TxL_FLITS.SLOT1",
+        "BriefDescription": "TOR Inserts for CRd misses from local IA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD",
         "PerPkg": "1",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Inserts into the TOR from local IA cores whi=
ch miss the LLC and snoop filter with the opcode CRd",
+        "UMask": "0xc80ffe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Valid Flits Sent : Slot 2",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x02",
-        "EventName": "UNC_UPI_TxL_FLITS.SLOT2",
+        "BriefDescription": "TOR Inserts : CRd issued by iA Cores that Mis=
sed the LLC - HOMed locally",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_LOCAL",
         "PerPkg": "1",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc80efe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Valid Flits Sent : Data",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x02",
-        "EventName": "UNC_UPI_TxL_FLITS.DATA",
+        "BriefDescription": "TOR Inserts; CRd Pref misses from local IA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_PREF",
         "PerPkg": "1",
-        "UMask": "0x0000000008",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "TOR Inserts; Code read prefetch from local I=
A that misses in the snoop filter",
+        "UMask": "0xc88ffe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Valid Flits Sent : LLCRD Not Empty",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x02",
-        "EventName": "UNC_UPI_TxL_FLITS.LLCRD",
+        "BriefDescription": "TOR Inserts : CRd_Prefs issued by iA Cores th=
at Missed the LLC - HOMed locally",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_PREF_LOCAL",
         "PerPkg": "1",
-        "UMask": "0x0000000010",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc88efe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Valid Flits Sent : Slot NULL or LLCRD Empty",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x02",
-        "EventName": "UNC_UPI_TxL_FLITS.NULL",
+        "BriefDescription": "TOR Inserts : CRd_Prefs issued by iA Cores th=
at Missed the LLC - HOMed remotely",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_PREF_REMOTE",
         "PerPkg": "1",
-        "UMask": "0x0000000020",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc88f7e01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Valid Flits Sent : LLCTRL",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x02",
-        "EventName": "UNC_UPI_TxL_FLITS.LLCTRL",
+        "BriefDescription": "TOR Inserts : CRd issued by iA Cores that Mis=
sed the LLC - HOMed remotely",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_REMOTE",
         "PerPkg": "1",
-        "UMask": "0x0000000040",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc80f7e01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Valid Flits Sent : Protocol Header",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x02",
-        "EventName": "UNC_UPI_TxL_FLITS.PROTHDR",
+        "BriefDescription": "TOR Inserts for DRd misses from local IA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD",
         "PerPkg": "1",
-        "UMask": "0x0000000080",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Inserts into the TOR from local IA cores whi=
ch miss the LLC and snoop filter with the opcode DRd",
+        "UMask": "0xc817fe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Valid Flits Sent : All Non Data",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x02",
-        "EventName": "UNC_UPI_TxL_FLITS.NON_DATA",
+        "BriefDescription": "TOR Inserts : DRd PTEs issued by iA Cores tha=
t Missed the LLC",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRDPTE",
         "PerPkg": "1",
-        "UMask": "0x0000000097",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "TOR Inserts : DRd PTEs issued by iA Cores du=
e to a page walk that missed the LLC : Counts the number of entries success=
fully inserted into the TOR that match qualifications specified by the sube=
vent.   Does not include addressless requests such as locks and interrupts.=
",
+        "UMask": "0xc837fe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Valid Flits Sent : Idle",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x02",
-        "EventName": "UNC_UPI_TxL_FLITS.IDLE",
+        "BriefDescription": "TOR Inserts for DRds issued by IA Cores targe=
ting DDR Mem that Missed the LLC",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_DDR",
         "PerPkg": "1",
-        "UMask": "0x0000000047",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Inserts into the TOR from local IA cores whi=
ch miss the LLC and snoop filter with the opcode DRd, and which target DDR =
memory",
+        "UMask": "0xc8178601",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "All Null Flits",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x02",
-        "EventName": "UNC_UPI_TxL_FLITS.ALL_NULL",
+        "BriefDescription": "TOR Inserts for DRd misses from local IA targ=
eting local memory",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL",
         "PerPkg": "1",
-        "UMask": "0x0000000027",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Inserts into the TOR from local IA cores whi=
ch miss the LLC and snoop filter with the opcode DRd, and which target loca=
l memory",
+        "UMask": "0xc816fe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Valid Flits Received : Slot 0",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x03",
-        "EventName": "UNC_UPI_RxL_FLITS.SLOT0",
+        "BriefDescription": "TOR Inserts : DRds issued by iA Cores targeti=
ng DDR Mem that Missed the LLC - HOMed locally",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL_DDR",
         "PerPkg": "1",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc8168601",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Valid Flits Received : Slot 1",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x03",
-        "EventName": "UNC_UPI_RxL_FLITS.SLOT1",
+        "BriefDescription": "TOR Inserts : DRds issued by iA Cores targeti=
ng PMM Mem that Missed the LLC - HOMed locally",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL_PMM",
         "PerPkg": "1",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc8168a01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Valid Flits Received : Slot 2",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x03",
-        "EventName": "UNC_UPI_RxL_FLITS.SLOT2",
+        "BriefDescription": "TOR Inserts; DRd Opt misses from local IA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT",
         "PerPkg": "1",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "TOR Inserts; Data read opt from local IA tha=
t misses in the snoop filter",
+        "UMask": "0xc827fe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Valid Flits Received : Data",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x03",
-        "EventName": "UNC_UPI_RxL_FLITS.DATA",
+        "BriefDescription": "TOR Inserts; DRd Opt Pref misses from local I=
A",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF",
         "PerPkg": "1",
-        "UMask": "0x0000000008",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "TOR Inserts; Data read opt prefetch from loc=
al IA that misses in the snoop filter",
+        "UMask": "0xc8a7fe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Valid Flits Received : LLCRD Not Empty",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x03",
-        "EventName": "UNC_UPI_RxL_FLITS.LLCRD",
+        "BriefDescription": "TOR Inserts for DRds issued by iA Cores targe=
ting PMM Mem that Missed the LLC",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PMM",
         "PerPkg": "1",
-        "UMask": "0x0000000010",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Inserts into the TOR from local IA cores whi=
ch miss the LLC and snoop filter with the opcode DRd, and which target PMM =
memory",
+        "UMask": "0xc8178a01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Valid Flits Received : Slot NULL or LLCRD Emp=
ty",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x03",
-        "EventName": "UNC_UPI_RxL_FLITS.NULL",
+        "BriefDescription": "TOR Inserts for DRd Pref misses from local IA=
",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF",
         "PerPkg": "1",
-        "UMask": "0x0000000020",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Inserts into the TOR from local IA cores whi=
ch miss the LLC and snoop filter with the opcode DRD_PREF",
+        "UMask": "0xc897fe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Valid Flits Received : LLCTRL",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x03",
-        "EventName": "UNC_UPI_RxL_FLITS.LLCTRL",
+        "BriefDescription": "TOR Inserts : DRd_Prefs issued by iA Cores ta=
rgeting DDR Mem that Missed the LLC",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_DDR",
         "PerPkg": "1",
-        "UMask": "0x0000000040",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc8978601",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Valid Flits Received : Protocol Header",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x03",
-        "EventName": "UNC_UPI_RxL_FLITS.PROTHDR",
+        "BriefDescription": "TOR Inserts for DRd Pref misses from local IA=
 targeting local memory",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_LOCAL",
         "PerPkg": "1",
-        "UMask": "0x0000000080",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Inserts into the TOR from local IA cores whi=
ch miss the LLC and snoop filter with the opcode DRD_PREF, and target local=
 memory",
+        "UMask": "0xc896fe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Valid Flits Received : All Data",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x03",
-        "EventName": "UNC_UPI_RxL_FLITS.ALL_DATA",
+        "BriefDescription": "TOR Inserts : DRd_Prefs issued by iA Cores ta=
rgeting DDR Mem that Missed the LLC - HOMed locally",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_LOCAL_DDR",
         "PerPkg": "1",
-        "UMask": "0x000000000f",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc8968601",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Valid Flits Received : All Non Data",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x03",
-        "EventName": "UNC_UPI_RxL_FLITS.NON_DATA",
+        "BriefDescription": "TOR Inserts : DRd_Prefs issued by iA Cores ta=
rgeting PMM Mem that Missed the LLC - HOMed locally",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_LOCAL_PMM",
         "PerPkg": "1",
-        "UMask": "0x0000000097",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc8968a01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Valid Flits Received : Idle",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x03",
-        "EventName": "UNC_UPI_RxL_FLITS.IDLE",
+        "BriefDescription": "TOR Inserts : DRd_Prefs issued by iA Cores ta=
rgeting PMM Mem that Missed the LLC",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_PMM",
         "PerPkg": "1",
-        "UMask": "0x0000000047",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc8978a01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Null FLITs received from any slot",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x03",
-        "EventName": "UNC_UPI_RxL_FLITS.ALL_NULL",
+        "BriefDescription": "TOR Inserts for DRd Pref misses from local IA=
 targeting remote memory",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_REMOTE",
         "PerPkg": "1",
-        "UMask": "0x0000000027",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Inserts into the TOR from local IA cores whi=
ch miss the LLC and snoop filter with the opcode DRD_PREF, and target remot=
e memory",
+        "UMask": "0xc8977e01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Matches on Transmit path of a UPI Port : Non-=
Coherent Bypass",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x04",
-        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCB",
+        "BriefDescription": "TOR Inserts : DRd_Prefs issued by iA Cores ta=
rgeting DDR Mem that Missed the LLC - HOMed remotely",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_REMOTE_DDR",
         "PerPkg": "1",
-        "UMask": "0x000000000e",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc8970601",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Matches on Transmit path of a UPI Port : Non-=
Coherent Bypass, Match Opcode",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x04",
-        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCB_OPC",
+        "BriefDescription": "TOR Inserts : DRd_Prefs issued by iA Cores ta=
rgeting PMM Mem that Missed the LLC - HOMed remotely",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_REMOTE_PMM",
         "PerPkg": "1",
-        "UMask": "0x000000010e",
-        "UMaskExt": "0x00000001",
-        "Unit": "UPI LL"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc8970a01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Matches on Transmit path of a UPI Port : Non-=
Coherent Standard",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x04",
-        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCS",
+        "BriefDescription": "TOR Inserts for DRd misses from local IA targ=
eting remote memory",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE",
         "PerPkg": "1",
-        "UMask": "0x000000000f",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Inserts into the TOR from local IA cores whi=
ch miss the LLC and snoop filter with the opcode DRd, and target remote mem=
ory",
+        "UMask": "0xc8177e01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Matches on Transmit path of a UPI Port : Non-=
Coherent Standard, Match Opcode",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x04",
-        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCS_OPC",
+        "BriefDescription": "TOR Inserts : DRds issued by iA Cores targeti=
ng DDR Mem that Missed the LLC - HOMed remotely",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE_DDR",
         "PerPkg": "1",
-        "UMask": "0x000000010f",
-        "UMaskExt": "0x00000001",
-        "Unit": "UPI LL"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc8170601",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Matches on Receive path of a UPI Port : Non-C=
oherent Bypass",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x05",
-        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCB",
+        "BriefDescription": "TOR Inserts : DRds issued by iA Cores targeti=
ng PMM Mem that Missed the LLC - HOMed remotely",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE_PMM",
         "PerPkg": "1",
-        "UMask": "0x000000000e",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc8170a01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Matches on Receive path of a UPI Port : Non-C=
oherent Bypass, Match Opcode",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x05",
-        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCB_OPC",
+        "BriefDescription": "TOR Inserts : ItoMs issued by iA Cores that M=
issed LLC",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_ITOM",
         "PerPkg": "1",
-        "UMask": "0x000000010e",
-        "UMaskExt": "0x00000001",
-        "Unit": "UPI LL"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xcc47fe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Matches on Receive path of a UPI Port : Non-C=
oherent Standard",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x05",
-        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCS",
+        "BriefDescription": "TOR Inserts; LLCPrefCode misses from local IA=
",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFCODE",
         "PerPkg": "1",
-        "UMask": "0x000000000f",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "TOR Inserts; Last level cache prefetch code =
read from local IA that misses in the snoop filter",
+        "UMask": "0xcccffe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Matches on Receive path of a UPI Port : Non-C=
oherent Standard, Match Opcode",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x05",
-        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCS_OPC",
+        "BriefDescription": "TOR Inserts; LLCPrefData misses from local IA=
",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFDATA",
         "PerPkg": "1",
-        "UMask": "0x000000010f",
-        "UMaskExt": "0x00000001",
-        "Unit": "UPI LL"
+        "PublicDescription": "TOR Inserts; Last level cache prefetch data =
read from local IA that misses in the snoop filter",
+        "UMask": "0xccd7fe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Direct packet attempts : D2C",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x12",
-        "EventName": "UNC_UPI_DIRECT_ATTEMPTS.D2C",
+        "BriefDescription": "TOR Inserts; LLCPrefRFO misses from local IA"=
,
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFRFO",
         "PerPkg": "1",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "TOR Inserts; Last level cache prefetch read =
for ownership from local IA that misses in the snoop filter",
+        "UMask": "0xccc7fe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Cycles in L1",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x21",
-        "EventName": "UNC_UPI_L1_POWER_CYCLES",
+        "BriefDescription": "TOR Inserts : WCiLFs issued by iA Cores targe=
ting DDR that missed the LLC - HOMed locally",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LOCAL_WCILF_DDR",
         "PerPkg": "1",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc8668601",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "RxQ Flit Buffer Allocations : Slot 0",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x30",
-        "EventName": "UNC_UPI_RxL_INSERTS.SLOT0",
+        "BriefDescription": "TOR Inserts : WCiLFs issued by iA Cores targe=
ting PMM that missed the LLC - HOMed locally",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LOCAL_WCILF_PMM",
         "PerPkg": "1",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc8668a01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "RxQ Flit Buffer Allocations : Slot 1",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x30",
-        "EventName": "UNC_UPI_RxL_INSERTS.SLOT1",
+        "BriefDescription": "TOR Inserts : WCiLs issued by iA Cores target=
ing DDR that missed the LLC - HOMed locally",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LOCAL_WCIL_DDR",
         "PerPkg": "1",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc86e8601",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "RxQ Flit Buffer Allocations : Slot 2",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x30",
-        "EventName": "UNC_UPI_RxL_INSERTS.SLOT2",
+        "BriefDescription": "TOR Inserts : WCiLs issued by iA Cores target=
ing PMM that missed the LLC - HOMed locally",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LOCAL_WCIL_PMM",
         "PerPkg": "1",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc86e8a01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "RxQ Flit Buffer Bypassed : Slot 0",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x31",
-        "EventName": "UNC_UPI_RxL_BYPASSED.SLOT0",
+        "BriefDescription": "TOR Inserts : WCiLFs issued by iA Cores targe=
ting DDR that missed the LLC - HOMed remotely",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_REMOTE_WCILF_DDR",
         "PerPkg": "1",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc8670601",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "RxQ Flit Buffer Bypassed : Slot 1",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x31",
-        "EventName": "UNC_UPI_RxL_BYPASSED.SLOT1",
+        "BriefDescription": "TOR Inserts : WCiLFs issued by iA Cores targe=
ting PMM that missed the LLC - HOMed remotely",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_REMOTE_WCILF_PMM",
         "PerPkg": "1",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc8670a01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "RxQ Flit Buffer Bypassed : Slot 2",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x31",
-        "EventName": "UNC_UPI_RxL_BYPASSED.SLOT2",
+        "BriefDescription": "TOR Inserts : WCiLs issued by iA Cores target=
ing DDR that missed the LLC - HOMed remotely",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_REMOTE_WCIL_DDR",
         "PerPkg": "1",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc86f0601",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "RxQ Occupancy - All Packets : Slot 0",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x32",
-        "EventName": "UNC_UPI_RxL_OCCUPANCY.SLOT0",
+        "BriefDescription": "TOR Inserts : WCiLs issued by iA Cores target=
ing PMM that missed the LLC - HOMed remotely",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_REMOTE_WCIL_PMM",
         "PerPkg": "1",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc86f0a01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "RxQ Occupancy - All Packets : Slot 1",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x32",
-        "EventName": "UNC_UPI_RxL_OCCUPANCY.SLOT1",
+        "BriefDescription": "TOR Inserts; RFO misses from local IA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO",
         "PerPkg": "1",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "TOR Inserts; Read for ownership from local I=
A that misses in the snoop filter",
+        "UMask": "0xc807fe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "RxQ Occupancy - All Packets : Slot 2",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x32",
-        "EventName": "UNC_UPI_RxL_OCCUPANCY.SLOT2",
+        "BriefDescription": "TOR Inserts RFO misses from local IA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_LOCAL",
         "PerPkg": "1",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "TOR Inserts; Read for ownership from local I=
A that misses in the snoop filter",
+        "UMask": "0xc806fe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Tx Flit Buffer Allocations",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x40",
-        "EventName": "UNC_UPI_TxL_INSERTS",
+        "BriefDescription": "TOR Inserts; RFO pref misses from local IA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF",
         "PerPkg": "1",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "TOR Inserts; Read for ownership prefetch fro=
m local IA that misses in the snoop filter",
+        "UMask": "0xc887fe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Tx Flit Buffer Bypassed",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x41",
-        "EventName": "UNC_UPI_TxL_BYPASSED",
+        "BriefDescription": "TOR Inserts; RFO prefetch misses from local I=
A",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_LOCAL",
         "PerPkg": "1",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "TOR Inserts; Read for ownership prefetch fro=
m local IA that misses in the snoop filter",
+        "UMask": "0xc886fe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Tx Flit Buffer Occupancy",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x42",
-        "EventName": "UNC_UPI_TxL_OCCUPANCY",
+        "BriefDescription": "TOR Inserts; RFO prefetch misses from local I=
A",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_REMOTE",
         "PerPkg": "1",
-        "UMaskExt": "0x00000000",
-        "Unit": "UPI LL"
+        "PublicDescription": "TOR Inserts; Read for ownership prefetch fro=
m local IA that misses in the snoop filter",
+        "UMask": "0xc8877e01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "FAF allocation -- sent to ADQ",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x16",
-        "EventName": "UNC_I_FAF_TRANSACTIONS",
+        "BriefDescription": "TOR Inserts; RFO misses from local IA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_REMOTE",
         "PerPkg": "1",
-        "UMaskExt": "0x00000000",
-        "Unit": "IRP"
+        "PublicDescription": "TOR Inserts Read for ownership from local IA=
 that misses in the snoop filter",
+        "UMask": "0xc8077e01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "FAF - request insert from TC",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x18",
-        "EventName": "UNC_I_FAF_INSERTS",
+        "BriefDescription": "TOR Inserts : UCRdFs issued by iA Cores that =
Missed LLC",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_UCRDF",
         "PerPkg": "1",
-        "UMaskExt": "0x00000000",
-        "Unit": "IRP"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc877de01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "FAF occupancy",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x19",
-        "EventName": "UNC_I_FAF_OCCUPANCY",
+        "BriefDescription": "TOR Inserts : WCiLs issued by iA Cores that M=
issed the LLC",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCIL",
         "PerPkg": "1",
-        "UMaskExt": "0x00000000",
-        "Unit": "IRP"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc86ffe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": ": All Inserts Inbound (p2p + faf + cset)",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x20",
-        "EventName": "UNC_I_IRP_ALL.INBOUND_INSERTS",
+        "BriefDescription": "TOR Inserts : WCiLF issued by iA Cores that M=
issed the LLC",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCILF",
         "PerPkg": "1",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IRP"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc867fe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Inbound write (fast path) requests received b=
y the IRP",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x11",
-        "EventName": "UNC_I_TRANSACTIONS.WR_PREF",
+        "BriefDescription": "TOR Inserts : WCiLFs issued by iA Cores targe=
ting DDR that missed the LLC",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCILF_DDR",
         "PerPkg": "1",
-        "UMask": "0x0000000008",
-        "UMaskExt": "0x00000000",
-        "Unit": "IRP"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc8678601",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "CMS Clockticks",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc0",
-        "EventName": "UNC_M2P_CMS_CLOCKTICKS",
+        "BriefDescription": "TOR Inserts : WCiLFs issued by iA Cores targe=
ting PMM that missed the LLC",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCILF_PMM",
         "PerPkg": "1",
-        "Unit": "M2PCIe"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc8678a01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read request for 4 bytes made by IIO Part0 to=
 Memory",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : WCiLs issued by iA Cores target=
ing DDR that missed the LLC",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCIL_DDR",
         "PerPkg": "1",
-        "PortMask": "0x0001",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc86f8601",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read request for 4 bytes made by IIO Part1 to=
 Memory",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : WCiLs issued by iA Cores target=
ing PMM that missed the LLC",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCIL_PMM",
         "PerPkg": "1",
-        "PortMask": "0x0002",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc86f8a01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read request for 4 bytes made by IIO Part2 to=
 Memory",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : WiLs issued by iA Cores that Mi=
ssed LLC",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WIL",
         "PerPkg": "1",
-        "PortMask": "0x0004",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc87fde01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read request for 4 bytes made by IIO Part3 to=
 Memory",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts; RFO from local IA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_RFO",
         "PerPkg": "1",
-        "PortMask": "0x0008",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts; Read for ownership from local I=
A that misses in the snoop filter",
+        "UMask": "0xc807ff01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data requested of the CPU : Card reading from=
 DRAM",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART4",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts; RFO pref from local IA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_RFO_PREF",
         "PerPkg": "1",
-        "PortMask": "0x0010",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts; Read for ownership prefetch fro=
m local IA that misses in the snoop filter",
+        "UMask": "0xc887ff01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data requested of the CPU : Card reading from=
 DRAM",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART5",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts;SpecItoM from Local IA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_SPECITOM",
         "PerPkg": "1",
-        "PortMask": "0x0020",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.; S=
pecItoM events that are initiated from the Core",
+        "UMask": "0xcc57ff01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data requested of the CPU : Card reading from=
 DRAM",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART6",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : WBEFtoEs issued by an IA Core. =
 Non Modified Write Backs",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WBEFTOE",
         "PerPkg": "1",
-        "PortMask": "0x0040",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "WbEFtoEs issued by iA Cores .  (Non Modified=
 Write Backs)  :Counts the number of entries successfully inserted into the=
 TOR that match qualifications specified by the subevent.  Does not include=
 addressless requests such as locks and interrupts.",
+        "UMask": "0xcc3fff01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data requested of the CPU : Card reading from=
 DRAM",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART7",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : WbMtoIs issued by an iA Cores. =
Modified Write Backs",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WBMTOI",
         "PerPkg": "1",
-        "PortMask": "0x0080",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "WbMtoIs issued by iA Cores .  (Modified Writ=
e Backs)  :Counts the number of entries successfully inserted into the TOR =
that match qualifications specified by the subevent.  Does not include addr=
essless requests such as locks and interrupts.",
+        "UMask": "0xcc27ff01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Write request of up to a 64 byte transaction =
is made by IIO Part0 to Memory",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART0",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : WCiLs issued by iA Cores",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WCIL",
         "PerPkg": "1",
-        "PortMask": "0x0001",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc86fff01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Write request of up to a 64 byte transaction =
is made by IIO Part1 to Memory",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART1",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : WCiLF issued by iA Cores",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WCILF",
         "PerPkg": "1",
-        "PortMask": "0x0002",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc867ff01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Write request of up to a 64 byte transaction =
is made by IIO Part2 to Memory",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART2",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts; All from local IO",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO",
         "PerPkg": "1",
-        "PortMask": "0x0004",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc001ff04",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Write request of up to a 64 byte transaction =
is made by IIO Part3 to Memory",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART3",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : CLFlushes issued by IO Devices"=
,
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_CLFLUSH",
         "PerPkg": "1",
-        "PortMask": "0x0008",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc8c3ff04",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read request for up to a 64 byte transaction =
is made by IIO Part0 to Memory",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART0",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts; Hits from local IO",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT",
         "PerPkg": "1",
-        "PortMask": "0x0001",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc001fd04",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read request for up to a 64 byte transaction =
is  made by IIO Part1 to Memory",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART1",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts; ItoM hits from local IO",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_ITOM",
         "PerPkg": "1",
-        "PortMask": "0x0002",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xcc43fd04",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read request for up to a 64 byte transaction =
is made by IIO Part2 to Memory",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART2",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : ItoMCacheNears, indicating a pa=
rtial write request, from IO Devices that hit the LLC",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_ITOMCACHENEAR",
         "PerPkg": "1",
-        "PortMask": "0x0004",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : ItoMCacheNears, indicating a p=
artial write request, from IO Devices that hit the LLC : Counts the number =
of entries successfully inserted into the TOR that match qualifications spe=
cified by the subevent.   Does not include addressless requests such as loc=
ks and interrupts.",
+        "UMask": "0xcd43fd04",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read request for up to a 64 byte transaction =
is made by IIO Part3 to Memory",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART3",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts; RdCur and FsRdCur hits from loca=
l IO",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_PCIRDCUR",
         "PerPkg": "1",
-        "PortMask": "0x0008",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : PCIRdCurs issued by IO Devices=
 that hit the LLC : Counts the number of entries successfully inserted into=
 the TOR that match qualifications specified by the subevent.   Does not in=
clude addressless requests such as locks and interrupts.",
+        "UMask": "0xc8f3fd04",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART4",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts; RFO hits from local IO",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_RFO",
         "PerPkg": "1",
-        "PortMask": "0x0010",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc803fd04",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART5",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts for ItoM from local IO",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOM",
         "PerPkg": "1",
-        "PortMask": "0x0020",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Inserts into the TOR from local IO with the =
opcode ItoM",
+        "UMask": "0xcc43ff04",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART6",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts for ItoMCacheNears from IO device=
s.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOMCACHENEAR",
         "PerPkg": "1",
-        "PortMask": "0x0040",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Inserts into the TOR from local IO devices w=
ith the opcode ItoMCacheNears.  This event indicates a partial write reques=
t.",
+        "UMask": "0xcd43ff04",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART7",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts; Misses from local IO",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS",
         "PerPkg": "1",
-        "PortMask": "0x0080",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc001fe04",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART4",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts; ItoM misses from local IO",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOM",
         "PerPkg": "1",
-        "PortMask": "0x0010",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xcc43fe04",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART5",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : ItoMCacheNears, indicating a pa=
rtial write request, from IO Devices that missed the LLC",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOMCACHENEAR",
         "PerPkg": "1",
-        "PortMask": "0x0020",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : ItoMCacheNears, indicating a p=
artial write request, from IO Devices that missed the LLC : Counts the numb=
er of entries successfully inserted into the TOR that match qualifications =
specified by the subevent.   Does not include addressless requests such as =
locks and interrupts.",
+        "UMask": "0xcd43fe04",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART6",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts; RdCur and FsRdCur misses from lo=
cal IO",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_PCIRDCUR",
         "PerPkg": "1",
-        "PortMask": "0x0040",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : PCIRdCurs issued by IO Devices=
 that missed the LLC : Counts the number of entries successfully inserted i=
nto the TOR that match qualifications specified by the subevent.   Does not=
 include addressless requests such as locks and interrupts.",
+        "UMask": "0xc8f3fe04",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART7",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts; RFO misses from local IO",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_RFO",
         "PerPkg": "1",
-        "PortMask": "0x0080",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : RFOs issued by IO Devices that=
 missed the LLC : Counts the number of entries successfully inserted into t=
he TOR that match qualifications specified by the subevent.   Does not incl=
ude addressless requests such as locks and interrupts.",
+        "UMask": "0xc803fe04",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Write request of 4 bytes made to IIO Part0 by=
 the CPU",
-        "Counter": "2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART0",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts for RdCur from local IO",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR",
         "PerPkg": "1",
-        "PortMask": "0x0001",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Inserts into the TOR from local IO with the =
opcode RdCur",
+        "UMask": "0xc8f3ff04",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Write request of 4 bytes made to IIO Part1 by=
 the CPU",
-        "Counter": "2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART1",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts; RFO from local IO",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_RFO",
         "PerPkg": "1",
-        "PortMask": "0x0002",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : RFOs issued by IO Devices : Co=
unts the number of entries successfully inserted into the TOR that match qu=
alifications specified by the subevent.   Does not include addressless requ=
ests such as locks and interrupts.",
+        "UMask": "0xc803ff04",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Write request of 4 bytes made to IIO Part2 by=
 the CPU",
-        "Counter": "2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART2",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : WbMtoIs issued by IO Devices",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_WBMTOI",
         "PerPkg": "1",
-        "PortMask": "0x0004",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent.   =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xcc23ff04",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Write request of 4 bytes made to IIO Part3 by=
 the CPU",
-        "Counter": "2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART3",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : IPQ",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IPQ",
         "PerPkg": "1",
-        "PortMask": "0x0008",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : IPQ : Counts the number of ent=
ries successfully inserted into the TOR that match qualifications specified=
 by the subevent.",
+        "UMask": "0x8",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
-        "Counter": "2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART4",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : IRQ - iA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IRQ_IA",
         "PerPkg": "1",
-        "PortMask": "0x0010",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : IRQ - iA : Counts the number o=
f entries successfully inserted into the TOR that match qualifications spec=
ified by the subevent. : From an iA Core",
+        "UMask": "0x1",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
-        "Counter": "2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART5",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : IRQ - Non iA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IRQ_NON_IA",
         "PerPkg": "1",
-        "PortMask": "0x0020",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : IRQ - Non iA : Counts the numb=
er of entries successfully inserted into the TOR that match qualifications =
specified by the subevent.",
+        "UMask": "0x10",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
-        "Counter": "2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART6",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : Just ISOC",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.ISOC",
         "PerPkg": "1",
-        "PortMask": "0x0040",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : Just ISOC : Counts the number =
of entries successfully inserted into the TOR that match qualifications spe=
cified by the subevent.",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
-        "Counter": "2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART7",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : Just Local Targets",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.LOCAL_TGT",
         "PerPkg": "1",
-        "PortMask": "0x0080",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : Just Local Targets : Counts th=
e number of entries successfully inserted into the TOR that match qualifica=
tions specified by the subevent.",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Write request of up to a 64 byte transaction =
is made to IIO Part0 by the CPU",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART0",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : All from Local iA and IO",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.LOC_ALL",
         "PerPkg": "1",
-        "PortMask": "0x0001",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : All from Local iA and IO : Cou=
nts the number of entries successfully inserted into the TOR that match qua=
lifications specified by the subevent. : All locally initiated requests",
+        "UMask": "0xc000ff05",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Write request of up to a 64 byte transaction =
is made to IIO Part1 by the CPU",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART1",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : All from Local iA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.LOC_IA",
         "PerPkg": "1",
-        "PortMask": "0x0002",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : All from Local iA : Counts the=
 number of entries successfully inserted into the TOR that match qualificat=
ions specified by the subevent. : All locally initiated requests from iA Co=
res",
+        "UMask": "0xc000ff01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Write request of up to a 64 byte transaction =
is made to IIO Part2 by the CPU",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART2",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : All from Local IO",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.LOC_IO",
         "PerPkg": "1",
-        "PortMask": "0x0004",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : All from Local IO : Counts the=
 number of entries successfully inserted into the TOR that match qualificat=
ions specified by the subevent. : All locally generated IO traffic",
+        "UMask": "0xc000ff04",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Write request of up to a 64 byte transaction =
is made to IIO Part3 by the CPU",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART3",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : Match the Opcode in b[29:19] of=
 the extended umask field",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.MATCH_OPC",
         "PerPkg": "1",
-        "PortMask": "0x0008",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : Match the Opcode in b[29:19] o=
f the extended umask field : Counts the number of entries successfully inse=
rted into the TOR that match qualifications specified by the subevent.",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read request for up to a 64 byte transaction =
is made by the CPU to IIO Part0",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART0",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : Just Misses",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.MISS",
         "PerPkg": "1",
-        "PortMask": "0x0001",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : Just Misses : Counts the numbe=
r of entries successfully inserted into the TOR that match qualifications s=
pecified by the subevent.",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read request for up to a 64 byte transaction =
is made by the CPU to IIO Part1",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART1",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : MMCFG Access",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.MMCFG",
         "PerPkg": "1",
-        "PortMask": "0x0002",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : MMCFG Access : Counts the numb=
er of entries successfully inserted into the TOR that match qualifications =
specified by the subevent.",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read request for up to a 64 byte transaction =
is made by the CPU to IIO Part2",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART2",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : MMIO Access",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.MMIO",
         "PerPkg": "1",
-        "PortMask": "0x0004",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : MMIO Access : Counts the numbe=
r of entries successfully inserted into the TOR that match qualifications s=
pecified by the subevent.",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read request for up to a 64 byte transaction =
is made by the CPU to IIO Part3",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART3",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : Just NonCoherent",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.NONCOH",
         "PerPkg": "1",
-        "PortMask": "0x0008",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : Just NonCoherent : Counts the =
number of entries successfully inserted into the TOR that match qualificati=
ons specified by the subevent.",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART4",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : PMM Access",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.PMM",
         "PerPkg": "1",
-        "PortMask": "0x0010",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : PM Access : Counts the number =
of entries successfully inserted into the TOR that match qualifications spe=
cified by the subevent.",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART5",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : Match the PreMorphed Opcode in =
b[29:19] of the extended umask field",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.PREMORPH_OPC",
         "PerPkg": "1",
-        "PortMask": "0x0020",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : Match the PreMorphed Opcode in=
 b[29:19] of the extended umask field : Counts the number of entries succes=
sfully inserted into the TOR that match qualifications specified by the sub=
event.",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART6",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : PRQ - IOSF",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.PRQ_IOSF",
         "PerPkg": "1",
-        "PortMask": "0x0040",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : PRQ - IOSF : Counts the number=
 of entries successfully inserted into the TOR that match qualifications sp=
ecified by the subevent. : From a PCIe Device",
+        "UMask": "0x4",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART7",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : PRQ - Non IOSF",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.PRQ_NON_IOSF",
         "PerPkg": "1",
-        "PortMask": "0x0080",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : PRQ - Non IOSF : Counts the nu=
mber of entries successfully inserted into the TOR that match qualification=
s specified by the subevent.",
+        "UMask": "0x20",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART4",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : Just Remote Targets",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.REMOTE_TGT",
         "PerPkg": "1",
-        "PortMask": "0x0010",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : Just Remote Targets : Counts t=
he number of entries successfully inserted into the TOR that match qualific=
ations specified by the subevent.",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART5",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : All from Remote",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.REM_ALL",
         "PerPkg": "1",
-        "PortMask": "0x0020",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : All from Remote : Counts the n=
umber of entries successfully inserted into the TOR that match qualificatio=
ns specified by the subevent. : All remote requests (e.g. snoops, writeback=
s) that came from remote sockets",
+        "UMask": "0xc001ffc8",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART6",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : All Snoops from Remote",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.REM_SNPS",
         "PerPkg": "1",
-        "PortMask": "0x0040",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : All Snoops from Remote : Count=
s the number of entries successfully inserted into the TOR that match quali=
fications specified by the subevent. : All snoops to this LLC that came fro=
m remote sockets",
+        "UMask": "0xc001ff08",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART7",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : RRQ",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.RRQ",
         "PerPkg": "1",
-        "PortMask": "0x0080",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : RRQ : Counts the number of ent=
ries successfully inserted into the TOR that match qualifications specified=
 by the subevent.",
+        "UMask": "0x40",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART0",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts; All Snoops from Remote",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.SNPS_FROM_REM",
         "PerPkg": "1",
-        "PortMask": "0x0001",
-        "UMask": "0x0000000080",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match qualifications specified by the subevent. Al=
l snoops to this LLC that came from remote sockets.",
+        "UMask": "0xc001ff08",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART1",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Inserts : WBQ",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.WBQ",
         "PerPkg": "1",
-        "PortMask": "0x0002",
-        "UMask": "0x0000000080",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Inserts : WBQ : Counts the number of ent=
ries successfully inserted into the TOR that match qualifications specified=
 by the subevent.",
+        "UMask": "0x80",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART2",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Occupancy : All",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All : For each cycle, this e=
vent accumulates the number of valid entries in the TOR that match qualific=
ations specified by the subevent.   T",
+        "UMask": "0xc001ffff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : DDR Access",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DDR Access : For each cycle,=
 this event accumulates the number of valid entries in the TOR that match q=
ualifications specified by the subevent.",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : SF/LLC Evictions",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.EVICT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : SF/LLC Evictions : For each =
cycle, this event accumulates the number of valid entries in the TOR that m=
atch qualifications specified by the subevent.   T : TOR allocation occurre=
d as a result of SF/LLC evictions (came from the ISMQ)",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : Just Hits",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.HIT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : Just Hits : For each cycle, =
this event accumulates the number of valid entries in the TOR that match qu=
alifications specified by the subevent.   T",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; All from local IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All requests from iA Cores :=
 For each cycle, this event accumulates the number of valid entries in the =
TOR that match qualifications specified by the subevent.     Does not inclu=
de addressless requests such as locks and interrupts.",
+        "UMask": "0xc001ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : CLFlushes issued by iA Cores"=
,
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_CLFLUSH",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CLFlushes issued by iA Cores=
 : For each cycle, this event accumulates the number of valid entries in th=
e TOR that match qualifications specified by the subevent.     Does not inc=
lude addressless requests such as locks and interrupts.",
+        "UMask": "0xc8c7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : CLFlushOpts issued by iA Core=
s",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_CLFLUSHOPT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CLFlushOpts issued by iA Cor=
es : For each cycle, this event accumulates the number of valid entries in =
the TOR that match qualifications specified by the subevent.     Does not i=
nclude addressless requests such as locks and interrupts.",
+        "UMask": "0xc8d7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; CRd from local IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_CRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy; Code read from local IA that =
misses in the snoop filter",
+        "UMask": "0xc80fff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; CRd Pref from local IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_CRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy; Code read prefetch from local=
 IA that misses in the snoop filter",
+        "UMask": "0xc88fff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; DRd from local IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_DRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy; Data read from local IA that =
misses in the snoop filter",
+        "UMask": "0xc817ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; DRd Opt from local IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_DRD_OPT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy; Data read opt from local IA t=
hat misses in the snoop filter",
+        "UMask": "0xc827ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; DRd Opt Pref from local IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_DRD_OPT_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy; Data read opt prefetch from l=
ocal IA that misses in the snoop filter",
+        "UMask": "0xc8a7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; DRd Pref from local IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_DRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy; Data read prefetch from local=
 IA that misses in the snoop filter",
+        "UMask": "0xc897ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Hits from local IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All requests from iA Cores t=
hat Hit the LLC : For each cycle, this event accumulates the number of vali=
d entries in the TOR that match qualifications specified by the subevent.  =
   Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc001fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; CRd hits from local IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy; Code read from local IA that =
hits in the snoop filter",
+        "UMask": "0xc80ffd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; CRd Pref hits from local IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy; Code read prefetch from local=
 IA that hits in the snoop filter",
+        "UMask": "0xc88ffd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; DRd hits from local IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy; Data read from local IA that =
hits in the snoop filter",
+        "UMask": "0xc817fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; DRd Opt hits from local IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD_OPT",
         "PerPkg": "1",
-        "PortMask": "0x0004",
-        "UMask": "0x0000000080",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Occupancy; Data read opt from local IA t=
hat hits in the snoop filter",
+        "UMask": "0xc827fd01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART3",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Occupancy; DRd Opt Pref hits from local I=
A",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD_OPT_PREF",
         "PerPkg": "1",
-        "PortMask": "0x0008",
-        "UMask": "0x0000000080",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Occupancy; Data read opt prefetch from l=
ocal IA that hits in the snoop filter",
+        "UMask": "0xc8a7fd01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART4",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Occupancy; DRd Pref hits from local IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD_PREF",
         "PerPkg": "1",
-        "PortMask": "0x0010",
-        "UMask": "0x0000000080",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Occupancy; Data read prefetch from local=
 IA that hits in the snoop filter",
+        "UMask": "0xc897fd01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART5",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Occupancy : ItoMs issued by iA Cores that=
 Hit LLC",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_ITOM",
         "PerPkg": "1",
-        "PortMask": "0x0020",
-        "UMask": "0x0000000080",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Occupancy : ItoMs issued by iA Cores tha=
t Hit LLC : For each cycle, this event accumulates the number of valid entr=
ies in the TOR that match qualifications specified by the subevent.     Doe=
s not include addressless requests such as locks and interrupts.",
+        "UMask": "0xcc47fd01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART6",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Occupancy; LLCPrefCode hits from local IA=
",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LLCPREFCODE",
         "PerPkg": "1",
-        "PortMask": "0x0040",
-        "UMask": "0x0000000080",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Occupancy; Last level cache prefetch cod=
e read from local IA that hits in the snoop filter",
+        "UMask": "0xcccffd01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART7",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Occupancy; LLCPrefData hits from local IA=
",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LLCPREFDATA",
         "PerPkg": "1",
-        "PortMask": "0x0080",
-        "UMask": "0x0000000080",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Occupancy; Last level cache prefetch dat=
a read from local IA that hits in the snoop filter",
+        "UMask": "0xccd7fd01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 0",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc2",
-        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART0",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Occupancy; LLCPrefRFO hits from local IA"=
,
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LLCPREFRFO",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Occupancy; Last level cache prefetch rea=
d for ownership from local IA that hits in the snoop filter",
+        "UMask": "0xccc7fd01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 1",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc2",
-        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART1",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Occupancy; RFO hits from local IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Occupancy; Read for ownership from local=
 IA that hits in the snoop filter",
+        "UMask": "0xc807fd01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 2",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc2",
-        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART2",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Occupancy; RFO Pref hits from local IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO_PREF",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Occupancy; Read for ownership prefetch f=
rom local IA that hits in the snoop filter",
+        "UMask": "0xc887fd01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 3",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc2",
-        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART3",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Occupancy : ItoMs issued by iA Cores",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_ITOM",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Occupancy : ItoMs issued by iA Cores : F=
or each cycle, this event accumulates the number of valid entries in the TO=
R that match qualifications specified by the subevent.     Does not include=
 addressless requests such as locks and interrupts.",
+        "UMask": "0xcc47ff01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 4",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc2",
-        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART4",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Occupancy : ItoMCacheNears issued by iA C=
ores",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_ITOMCACHENEAR",
         "PerPkg": "1",
-        "PortMask": "0x10",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Occupancy : ItoMCacheNears issued by iA =
Cores : For each cycle, this event accumulates the number of valid entries =
in the TOR that match qualifications specified by the subevent.     Does no=
t include addressless requests such as locks and interrupts.",
+        "UMask": "0xcd47ff01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 5",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc2",
-        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART5",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Occupancy; LLCPrefCode from local IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_LLCPREFCODE",
         "PerPkg": "1",
-        "PortMask": "0x20",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Occupancy; Last level cache prefetch dat=
a read from local IA.",
+        "UMask": "0xcccfff01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 6",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc2",
-        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART6",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Occupancy; LLCPrefData from local IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_LLCPREFDATA",
         "PerPkg": "1",
-        "PortMask": "0x40",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Occupancy; Last level cache prefetch dat=
a read from local IA that misses in the snoop filter",
+        "UMask": "0xccd7ff01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 7",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc2",
-        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART7",
-        "FCMask": "0x07",
+        "BriefDescription": "TOR Occupancy; LLCPrefRFO from local IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_LLCPREFRFO",
         "PerPkg": "1",
-        "PortMask": "0x80",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Occupancy; Last level cache prefetch rea=
d for ownership from local IA that misses in the snoop filter",
+        "UMask": "0xccc7ff01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.ALL_PARTS",
-        "Counter": "2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xd5",
-        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.ALL_PARTS",
-        "FCMask": "0x04",
+        "BriefDescription": "TOR Occupancy; Misses from Local IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS",
         "PerPkg": "1",
-        "UMask": "0x00000000ff",
-        "UMaskExt": "0x00000000",
-        "Unit": "IIO"
+        "PublicDescription": "TOR Occupancy : All requests from iA Cores t=
hat Missed the LLC : For each cycle, this event accumulates the number of v=
alid entries in the TOR that match qualifications specified by the subevent=
.     Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc001fe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "AD Ingress (from CMS) : AD Ingress (from CMS)=
 Allocations",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x02",
-        "EventName": "UNC_M2M_RxC_AD_INSERTS",
+        "BriefDescription": "TOR Occupancy; CRd misses from local IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD",
         "PerPkg": "1",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Occupancy; Code read from local IA that =
misses in the snoop filter",
+        "UMask": "0xc80ffe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "AD Ingress (from CMS) Occupancy",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x03",
-        "EventName": "UNC_M2M_RxC_AD_OCCUPANCY",
+        "BriefDescription": "TOR Occupancy : CRd issued by iA Cores that M=
issed the LLC - HOMed locally",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_LOCAL",
         "PerPkg": "1",
-        "UMaskExt": "0x00000000",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Occupancy : CRd issued by iA Cores that =
Missed the LLC - HOMed locally : For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.     Does not include addressless requests such as locks and i=
nterrupts.",
+        "UMask": "0xc80efe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Messages sent direct to core (bypassing the C=
HA)",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x16",
-        "EventName": "UNC_M2M_DIRECT2CORE_TAKEN",
+        "BriefDescription": "TOR Occupancy; CRd Pref misses from local IA"=
,
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_PREF",
         "PerPkg": "1",
-        "UMask": "0x07",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Occupancy; Code read prefetch from local=
 IA that misses in the snoop filter",
+        "UMask": "0xc88ffe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Cycles when direct to core mode (which bypass=
es the CHA) was disabled",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x17",
-        "EventName": "UNC_M2M_DIRECT2CORE_NOT_TAKEN_DIRSTATE",
+        "BriefDescription": "TOR Occupancy : CRd_Prefs issued by iA Cores =
that Missed the LLC - HOMed locally",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_PREF_LOCAL",
         "PerPkg": "1",
-        "UMask": "0x07",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Occupancy : CRd_Prefs issued by iA Cores=
 that Missed the LLC - HOMed locally : For each cycle, this event accumulat=
es the number of valid entries in the TOR that match qualifications specifi=
ed by the subevent.     Does not include addressless requests such as locks=
 and interrupts.",
+        "UMask": "0xc88efe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Number of reads in which direct to core trans=
action were overridden",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x18",
-        "EventName": "UNC_M2M_DIRECT2CORE_TXN_OVERRIDE",
+        "BriefDescription": "TOR Occupancy : CRd_Prefs issued by iA Cores =
that Missed the LLC - HOMed remotely",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_PREF_REMOTE",
         "PerPkg": "1",
-        "UMask": "0x03",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Occupancy : CRd_Prefs issued by iA Cores=
 that Missed the LLC - HOMed remotely : For each cycle, this event accumula=
tes the number of valid entries in the TOR that match qualifications specif=
ied by the subevent.     Does not include addressless requests such as lock=
s and interrupts.",
+        "UMask": "0xc88f7e01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Messages sent direct to the Intel UPI",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x19",
-        "EventName": "UNC_M2M_DIRECT2UPI_TAKEN",
+        "BriefDescription": "TOR Occupancy : CRd issued by iA Cores that M=
issed the LLC - HOMed remotely",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_REMOTE",
         "PerPkg": "1",
-        "UMask": "0x07",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Occupancy : CRd issued by iA Cores that =
Missed the LLC - HOMed remotely : For each cycle, this event accumulates th=
e number of valid entries in the TOR that match qualifications specified by=
 the subevent.     Does not include addressless requests such as locks and =
interrupts.",
+        "UMask": "0xc80f7e01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Cycles when direct to Intel UPI was disabled"=
,
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x1a",
-        "EventName": "UNC_M2M_DIRECT2UPI_NOT_TAKEN_DIRSTATE",
+        "BriefDescription": "TOR Occupancy for DRd misses from local IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD",
         "PerPkg": "1",
-        "UMask": "0x07",
-        "Unit": "M2M"
+        "PublicDescription": "Number of cycles for elements in the TOR fro=
m local IA cores which miss the LLC and snoop filter with the opcode DRd",
+        "UMask": "0xc817fe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Number of reads in which direct to Intel UPI =
transactions were overridden",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x1b",
-        "EventName": "UNC_M2M_DIRECT2UPI_NOT_TAKEN_CREDITS",
+        "BriefDescription": "TOR Occupancy for DRds issued by iA Cores tar=
geting DDR Mem that Missed the LLC",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_DDR",
         "PerPkg": "1",
-        "UMask": "0x07",
-        "Unit": "M2M"
+        "PublicDescription": "Number of cycles for elements in the TOR fro=
m local IA cores which miss the LLC and snoop filter with the opcode DRd, a=
nd which target DDR memory",
+        "UMask": "0xc8178601",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Number of reads that a message sent direct2 I=
ntel UPI was overridden",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x1c",
-        "EventName": "UNC_M2M_DIRECT2UPI_TXN_OVERRIDE",
+        "BriefDescription": "TOR Occupancy for DRd misses from local IA ta=
rgeting local memory",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL",
         "PerPkg": "1",
-        "UMask": "0x03",
-        "Unit": "M2M"
+        "PublicDescription": "Number of cycles for elements in the TOR fro=
m local IA cores which miss the LLC and snoop filter with the opcode DRd, a=
nd which target local memory",
+        "UMask": "0xc816fe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory lookups (any=
 state found)",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x20",
-        "EventName": "UNC_M2M_DIRECTORY_LOOKUP.ANY",
+        "BriefDescription": "TOR Occupancy : DRds issued by iA Cores targe=
ting DDR Mem that Missed the LLC - HOMed locally",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL_DDR",
         "PerPkg": "1",
-        "UMask": "0x01",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Occupancy : DRds issued by iA Cores targ=
eting DDR Mem that Missed the LLC - HOMed locally : For each cycle, this ev=
ent accumulates the number of valid entries in the TOR that match qualifica=
tions specified by the subevent.     Does not include addressless requests =
such as locks and interrupts.",
+        "UMask": "0xc8168601",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory lookups (cac=
heline found in A state)",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x20",
-        "EventName": "UNC_M2M_DIRECTORY_LOOKUP.STATE_A",
+        "BriefDescription": "TOR Occupancy : DRds issued by iA Cores targe=
ting PMM Mem that Missed the LLC - HOMed locally",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL_PMM",
         "PerPkg": "1",
-        "UMask": "0x08",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Occupancy : DRds issued by iA Cores targ=
eting PMM Mem that Missed the LLC - HOMed locally : For each cycle, this ev=
ent accumulates the number of valid entries in the TOR that match qualifica=
tions specified by the subevent.     Does not include addressless requests =
such as locks and interrupts.",
+        "UMask": "0xc8168a01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory lookup (cach=
eline found in I state)",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x20",
-        "EventName": "UNC_M2M_DIRECTORY_LOOKUP.STATE_I",
+        "BriefDescription": "TOR Occupancy; DRd Opt misses from local IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT",
         "PerPkg": "1",
-        "UMask": "0x02",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Occupancy; Data read opt from local IA t=
hat misses in the snoop filter",
+        "UMask": "0xc827fe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory lookup (cach=
eline found in S state)",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x20",
-        "EventName": "UNC_M2M_DIRECTORY_LOOKUP.STATE_S",
+        "BriefDescription": "TOR Occupancy; DRd Opt Pref misses from local=
 IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT_PREF",
         "PerPkg": "1",
-        "UMask": "0x04",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Occupancy; Data read opt prefetch from l=
ocal IA that misses in the snoop filter",
+        "UMask": "0xc8a7fe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory update from =
A to I",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x21",
-        "EventName": "UNC_M2M_DIRECTORY_UPDATE.A2I",
+        "BriefDescription": "TOR Occupancy for DRds issued by iA Cores tar=
geting PMM Mem that Missed the LLC",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PMM",
         "PerPkg": "1",
-        "UMask": "0x0320",
-        "UMaskExt": "0x03",
-        "Unit": "M2M"
+        "PublicDescription": "Number of cycles for elements in the TOR fro=
m local IA cores which miss the LLC and snoop filter with the opcode DRd, a=
nd which target PMM memory",
+        "UMask": "0xc8178a01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory update from =
A to S",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x21",
-        "EventName": "UNC_M2M_DIRECTORY_UPDATE.A2S",
+        "BriefDescription": "TOR Occupancy; DRd Pref misses from local IA"=
,
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF",
         "PerPkg": "1",
-        "UMask": "0x0340",
-        "UMaskExt": "0x03",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Occupancy; Data read prefetch from local=
 IA that misses in the snoop filter",
+        "UMask": "0xc897fe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory update from/=
to Any state",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x21",
-        "EventName": "UNC_M2M_DIRECTORY_UPDATE.ANY",
+        "BriefDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores =
targeting DDR Mem that Missed the LLC",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_DDR",
         "PerPkg": "1",
-        "UMask": "0x0301",
-        "UMaskExt": "0x03",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores=
 targeting DDR Mem that Missed the LLC : For each cycle, this event accumul=
ates the number of valid entries in the TOR that match qualifications speci=
fied by the subevent.     Does not include addressless requests such as loc=
ks and interrupts.",
+        "UMask": "0xc8978601",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory update from =
I to A",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x21",
-        "EventName": "UNC_M2M_DIRECTORY_UPDATE.I2A",
+        "BriefDescription": "TOR Occupancy; DRd Pref misses from local IA"=
,
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_LOCAL",
         "PerPkg": "1",
-        "UMask": "0x0304",
-        "UMaskExt": "0x03",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Occupancy; Data read prefetch from local=
 IA that misses in the snoop filter",
+        "UMask": "0xc896fe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory update from =
I to S",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x21",
-        "EventName": "UNC_M2M_DIRECTORY_UPDATE.I2S",
+        "BriefDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores =
targeting DDR Mem that Missed the LLC - HOMed locally",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_LOCAL_DDR",
         "PerPkg": "1",
-        "UMask": "0x0302",
-        "UMaskExt": "0x03",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores=
 targeting DDR Mem that Missed the LLC - HOMed locally : For each cycle, th=
is event accumulates the number of valid entries in the TOR that match qual=
ifications specified by the subevent.     Does not include addressless requ=
ests such as locks and interrupts.",
+        "UMask": "0xc8968601",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory update from =
S to A",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x21",
-        "EventName": "UNC_M2M_DIRECTORY_UPDATE.S2A",
+        "BriefDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores =
targeting PMM Mem that Missed the LLC - HOMed locally",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_LOCAL_PMM",
         "PerPkg": "1",
-        "UMask": "0x0310",
-        "UMaskExt": "0x03",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores=
 targeting PMM Mem that Missed the LLC - HOMed locally : For each cycle, th=
is event accumulates the number of valid entries in the TOR that match qual=
ifications specified by the subevent.     Does not include addressless requ=
ests such as locks and interrupts.",
+        "UMask": "0xc8968a01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory update from =
S to I",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x21",
-        "EventName": "UNC_M2M_DIRECTORY_UPDATE.S2I",
+        "BriefDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores =
targeting PMM Mem that Missed the LLC",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_PMM",
         "PerPkg": "1",
-        "UMask": "0x0308",
-        "UMaskExt": "0x03",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores=
 targeting PMM Mem that Missed the LLC : For each cycle, this event accumul=
ates the number of valid entries in the TOR that match qualifications speci=
fied by the subevent.     Does not include addressless requests such as loc=
ks and interrupts.",
+        "UMask": "0xc8978a01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Tracker Inserts : Channel 0",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x32",
-        "EventName": "UNC_M2M_TRACKER_INSERTS.CH0",
+        "BriefDescription": "TOR Occupancy; DRd Pref misses from local IA"=
,
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_REMOTE",
         "PerPkg": "1",
-        "UMask": "0x0000000104",
-        "UMaskExt": "0x00000001",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Occupancy; Data read prefetch from local=
 IA that misses in the snoop filter",
+        "UMask": "0xc8977e01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Tracker Inserts : Channel 1",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x32",
-        "EventName": "UNC_M2M_TRACKER_INSERTS.CH1",
+        "BriefDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores =
targeting DDR Mem that Missed the LLC - HOMed remotely",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_REMOTE_DDR",
         "PerPkg": "1",
-        "UMask": "0x0000000204",
-        "UMaskExt": "0x00000002",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores=
 targeting DDR Mem that Missed the LLC - HOMed remotely : For each cycle, t=
his event accumulates the number of valid entries in the TOR that match qua=
lifications specified by the subevent.     Does not include addressless req=
uests such as locks and interrupts.",
+        "UMask": "0xc8970601",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Tracker Occupancy : Channel 0",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x33",
-        "EventName": "UNC_M2M_TRACKER_OCCUPANCY.CH0",
+        "BriefDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores =
targeting PMM Mem that Missed the LLC - HOMed remotely",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_REMOTE_PMM",
         "PerPkg": "1",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores=
 targeting PMM Mem that Missed the LLC - HOMed remotely : For each cycle, t=
his event accumulates the number of valid entries in the TOR that match qua=
lifications specified by the subevent.     Does not include addressless req=
uests such as locks and interrupts.",
+        "UMask": "0xc8970a01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Tracker Occupancy : Channel 1",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x33",
-        "EventName": "UNC_M2M_TRACKER_OCCUPANCY.CH1",
+        "BriefDescription": "TOR Occupancy for DRd misses from local IA ta=
rgeting remote memory",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE",
         "PerPkg": "1",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
-        "Unit": "M2M"
+        "PublicDescription": "Number of cycles for elements in the TOR fro=
m local IA cores which miss the LLC and snoop filter with the opcode DRd, a=
nd which target remote memory",
+        "UMask": "0xc8177e01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data Prefetches Dropped",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x58",
-        "EventName": "UNC_M2M_PREFCAM_DEMAND_DROPS.CH0_XPT",
+        "BriefDescription": "TOR Occupancy : DRds issued by iA Cores targe=
ting DDR Mem that Missed the LLC - HOMed remotely",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE_DDR",
         "PerPkg": "1",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Occupancy : DRds issued by iA Cores targ=
eting DDR Mem that Missed the LLC - HOMed remotely : For each cycle, this e=
vent accumulates the number of valid entries in the TOR that match qualific=
ations specified by the subevent.     Does not include addressless requests=
 such as locks and interrupts.",
+        "UMask": "0xc8170601",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data Prefetches Dropped",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x58",
-        "EventName": "UNC_M2M_PREFCAM_DEMAND_DROPS.CH0_UPI",
+        "BriefDescription": "TOR Occupancy : DRds issued by iA Cores targe=
ting PMM Mem that Missed the LLC - HOMed remotely",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE_PMM",
         "PerPkg": "1",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Occupancy : DRds issued by iA Cores targ=
eting PMM Mem that Missed the LLC - HOMed remotely : For each cycle, this e=
vent accumulates the number of valid entries in the TOR that match qualific=
ations specified by the subevent.     Does not include addressless requests=
 such as locks and interrupts.",
+        "UMask": "0xc8170a01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data Prefetches Dropped",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x58",
-        "EventName": "UNC_M2M_PREFCAM_DEMAND_DROPS.CH1_XPT",
+        "BriefDescription": "TOR Occupancy : ItoMs issued by iA Cores that=
 Missed LLC",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_ITOM",
         "PerPkg": "1",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Occupancy : ItoMs issued by iA Cores tha=
t Missed LLC : For each cycle, this event accumulates the number of valid e=
ntries in the TOR that match qualifications specified by the subevent.     =
Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xcc47fe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data Prefetches Dropped",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x58",
-        "EventName": "UNC_M2M_PREFCAM_DEMAND_DROPS.CH1_UPI",
+        "BriefDescription": "TOR Occupancy; LLCPrefCode misses from local =
IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFCODE",
         "PerPkg": "1",
-        "UMask": "0x0000000008",
-        "UMaskExt": "0x00000000",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Occupancy; Last level cache prefetch cod=
e read from local IA that misses in the snoop filter",
+        "UMask": "0xcccffe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Prefetch CAM Inserts : UPI - All Channels",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x56",
-        "EventName": "UNC_M2M_PREFCAM_INSERTS.UPI_ALLCH",
+        "BriefDescription": "TOR Occupancy; LLCPrefData misses from local =
IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFDATA",
         "PerPkg": "1",
-        "UMask": "0x000000000a",
-        "UMaskExt": "0x00000000",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Occupancy; Last level cache prefetch dat=
a read from local IA that misses in the snoop filter",
+        "UMask": "0xccd7fe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Prefetch CAM Inserts : XPT - All Channels",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x56",
-        "EventName": "UNC_M2M_PREFCAM_INSERTS.XPT_ALLCH",
+        "BriefDescription": "TOR Occupancy; LLCPrefRFO misses from local I=
A",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFRFO",
         "PerPkg": "1",
-        "UMask": "0x0000000005",
-        "UMaskExt": "0x00000000",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Occupancy; Last level cache prefetch rea=
d for ownership from local IA that misses in the snoop filter",
+        "UMask": "0xccc7fe01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data Prefetches Dropped",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x58",
-        "EventName": "UNC_M2M_PREFCAM_DEMAND_DROPS.XPT_ALLCH",
+        "BriefDescription": "TOR Occupancy : WCiLFs issued by iA Cores tar=
geting DDR that missed the LLC - HOMed locally",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LOCAL_WCILF_DDR",
         "PerPkg": "1",
-        "UMask": "0x0000000005",
-        "UMaskExt": "0x00000000",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Occupancy : WCiLFs issued by iA Cores ta=
rgeting DDR that missed the LLC - HOMed locally : For each cycle, this even=
t accumulates the number of valid entries in the TOR that match qualificati=
ons specified by the subevent.     Does not include addressless requests su=
ch as locks and interrupts.",
+        "UMask": "0xc8668601",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": ": UPI - All Channels",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x5d",
-        "EventName": "UNC_M2M_PREFCAM_DEMAND_MERGE.UPI_ALLCH",
+        "BriefDescription": "TOR Occupancy : WCiLFs issued by iA Cores tar=
geting PMM that missed the LLC - HOMed locally",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LOCAL_WCILF_PMM",
         "PerPkg": "1",
-        "UMask": "0x000000000a",
-        "UMaskExt": "0x00000000",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Occupancy : WCiLFs issued by iA Cores ta=
rgeting PMM that missed the LLC - HOMed locally : For each cycle, this even=
t accumulates the number of valid entries in the TOR that match qualificati=
ons specified by the subevent.     Does not include addressless requests su=
ch as locks and interrupts.",
+        "UMask": "0xc8668a01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": ": XPT - All Channels",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x5d",
-        "EventName": "UNC_M2M_PREFCAM_DEMAND_MERGE.XPT_ALLCH",
+        "BriefDescription": "TOR Occupancy : WCiLs issued by iA Cores targ=
eting DDR that missed the LLC - HOMed locally",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LOCAL_WCIL_DDR",
         "PerPkg": "1",
-        "UMask": "0x0000000005",
-        "UMaskExt": "0x00000000",
-        "Unit": "M2M"
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores tar=
geting DDR that missed the LLC - HOMed locally : For each cycle, this event=
 accumulates the number of valid entries in the TOR that match qualificatio=
ns specified by the subevent.     Does not include addressless requests suc=
h as locks and interrupts.",
+        "UMask": "0xc86e8601",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "FlowQ Generated Prefetch",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x29",
-        "EventName": "UNC_M3UPI_UPI_PREFETCH_SPAWN",
+        "BriefDescription": "TOR Occupancy : WCiLs issued by iA Cores targ=
eting PMM that missed the LLC - HOMed locally",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LOCAL_WCIL_PMM",
         "PerPkg": "1",
-        "UMaskExt": "0x00000000",
-        "Unit": "M3UPI"
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores tar=
geting PMM that missed the LLC - HOMed locally : For each cycle, this event=
 accumulates the number of valid entries in the TOR that match qualificatio=
ns specified by the subevent.     Does not include addressless requests suc=
h as locks and interrupts.",
+        "UMask": "0xc86e8a01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "D2U Sent",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x2a",
-        "EventName": "UNC_M3UPI_D2U_SENT",
+        "BriefDescription": "TOR Occupancy : WCiLFs issued by iA Cores tar=
geting DDR that missed the LLC - HOMed remotely",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_REMOTE_WCILF_DDR",
         "PerPkg": "1",
-        "UMaskExt": "0x00000000",
-        "Unit": "M3UPI"
+        "PublicDescription": "TOR Occupancy : WCiLFs issued by iA Cores ta=
rgeting DDR that missed the LLC - HOMed remotely : For each cycle, this eve=
nt accumulates the number of valid entries in the TOR that match qualificat=
ions specified by the subevent.     Does not include addressless requests s=
uch as locks and interrupts.",
+        "UMask": "0xc8670601",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "D2C Sent",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x2b",
-        "EventName": "UNC_M3UPI_D2C_SENT",
+        "BriefDescription": "TOR Occupancy : WCiLFs issued by iA Cores tar=
geting PMM that missed the LLC - HOMed remotely",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_REMOTE_WCILF_PMM",
         "PerPkg": "1",
-        "UMaskExt": "0x00000000",
-        "Unit": "M3UPI"
+        "PublicDescription": "TOR Occupancy : WCiLFs issued by iA Cores ta=
rgeting PMM that missed the LLC - HOMed remotely : For each cycle, this eve=
nt accumulates the number of valid entries in the TOR that match qualificat=
ions specified by the subevent.     Does not include addressless requests s=
uch as locks and interrupts.",
+        "UMask": "0xc8670a01",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "M3UPI CMS Clockticks",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc0",
-        "EventName": "UNC_M3UPI_CMS_CLOCKTICKS",
+        "BriefDescription": "TOR Occupancy : WCiLs issued by iA Cores targ=
eting DDR that missed the LLC - HOMed remotely",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_REMOTE_WCIL_DDR",
         "PerPkg": "1",
-        "Unit": "M3UPI"
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores tar=
geting DDR that missed the LLC - HOMed remotely : For each cycle, this even=
t accumulates the number of valid entries in the TOR that match qualificati=
ons specified by the subevent.     Does not include addressless requests su=
ch as locks and interrupts.",
+        "UMask": "0xc86f0601",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Local requests for exclusive ownership of a c=
ache line  without receiving data",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x50",
-        "EventName": "UNC_CHA_REQUESTS.INVITOE_LOCAL",
+        "BriefDescription": "TOR Occupancy : WCiLs issued by iA Cores targ=
eting PMM that missed the LLC - HOMed remotely",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_REMOTE_WCIL_PMM",
         "PerPkg": "1",
-        "UMask": "0x0000000010",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores tar=
geting PMM that missed the LLC - HOMed remotely : For each cycle, this even=
t accumulates the number of valid entries in the TOR that match qualificati=
ons specified by the subevent.     Does not include addressless requests su=
ch as locks and interrupts.",
+        "UMask": "0xc86f0a01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read requests made into the CHA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x50",
-        "EventName": "UNC_CHA_REQUESTS.READS",
+        "BriefDescription": "TOR Occupancy; RFO misses from local IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO",
         "PerPkg": "1",
-        "UMask": "0x0000000003",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "TOR Occupancy; Read for ownership from local=
 IA that misses in the snoop filter",
+        "UMask": "0xc807fe01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Write requests made into the CHA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x50",
-        "EventName": "UNC_CHA_REQUESTS.WRITES",
+        "BriefDescription": "TOR Occupancy; RFO misses from local IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_LOCAL",
         "PerPkg": "1",
-        "UMask": "0x000000000c",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "TOR Occupancy; Read for ownership from local=
 IA that misses in the snoop filter",
+        "UMask": "0xc806fe01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory state lookup=
s; Snoop Not Needed",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x53",
-        "EventName": "UNC_CHA_DIR_LOOKUP.NO_SNP",
+        "BriefDescription": "TOR Occupancy; RFO prefetch misses from local=
 IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF",
         "PerPkg": "1",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "TOR Occupancy; Read for ownership prefetch f=
rom local IA that misses in the snoop filter",
+        "UMask": "0xc887fe01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory state lookup=
s; Snoop Needed",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x53",
-        "EventName": "UNC_CHA_DIR_LOOKUP.SNP",
+        "BriefDescription": "TOR Occupancy; RFO prefetch misses from local=
 IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF_LOCAL",
         "PerPkg": "1",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "TOR Occupancy; Read for ownership prefetch f=
rom local IA that misses in the snoop filter",
+        "UMask": "0xc886fe01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory state update=
s; Directory Updated memory write from the HA pipe",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x54",
-        "EventName": "UNC_CHA_DIR_UPDATE.HA",
+        "BriefDescription": "TOR Occupancy; RFO prefetch misses from local=
 IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF_REMOTE",
         "PerPkg": "1",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "TOR Occupancy; Read for ownership prefetch f=
rom local IA that misses in the snoop filter",
+        "UMask": "0xc8877e01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory state update=
s; Directory Updated memory write from TOR pipe",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x54",
-        "EventName": "UNC_CHA_DIR_UPDATE.TOR",
+        "BriefDescription": "TOR Occupancy; RFO misses from local IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_REMOTE",
         "PerPkg": "1",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "TOR Occupancy; Read for ownership from local=
 IA that misses in the snoop filter",
+        "UMask": "0xc8077e01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "OSB Snoop Broadcast : Local InvItoE",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x55",
-        "EventName": "UNC_CHA_OSB.LOCAL_INVITOE",
+        "BriefDescription": "TOR Occupancy : UCRdFs issued by iA Cores tha=
t Missed LLC",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_UCRDF",
         "PerPkg": "1",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "TOR Occupancy : UCRdFs issued by iA Cores th=
at Missed LLC : For each cycle, this event accumulates the number of valid =
entries in the TOR that match qualifications specified by the subevent.    =
 Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc877de01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "OSB Snoop Broadcast : Local Rd",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x55",
-        "EventName": "UNC_CHA_OSB.LOCAL_READ",
+        "BriefDescription": "TOR Occupancy : WCiLs issued by iA Cores that=
 Missed the LLC",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCIL",
         "PerPkg": "1",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores tha=
t Missed the LLC : For each cycle, this event accumulates the number of val=
id entries in the TOR that match qualifications specified by the subevent. =
    Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc86ffe01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "CMS Clockticks",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc0",
-        "EventName": "UNC_CHA_CMS_CLOCKTICKS",
+        "BriefDescription": "TOR Occupancy : WCiLF issued by iA Cores that=
 Missed the LLC",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCILF",
         "PerPkg": "1",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "TOR Occupancy : WCiLF issued by iA Cores tha=
t Missed the LLC : For each cycle, this event accumulates the number of val=
id entries in the TOR that match qualifications specified by the subevent. =
    Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc867fe01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Cache and Snoop Filter Lookups; Data Read Req=
uest",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x34",
-        "EventName": "UNC_CHA_LLC_LOOKUP.DATA_RD",
+        "BriefDescription": "TOR Occupancy : WCiLFs issued by iA Cores tar=
geting DDR that missed the LLC",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCILF_DDR",
         "PerPkg": "1",
-        "UMask": "0x00001bc1ff",
-        "UMaskExt": "0x00001bc1",
+        "PublicDescription": "TOR Occupancy : WCiLFs issued by iA Cores ta=
rgeting DDR that missed the LLC : For each cycle, this event accumulates th=
e number of valid entries in the TOR that match qualifications specified by=
 the subevent.     Does not include addressless requests such as locks and =
interrupts.",
+        "UMask": "0xc8678601",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Cache and Snoop Filter Lookups; Snoop Request=
s from a Remote Socket",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x34",
-        "EventName": "UNC_CHA_LLC_LOOKUP.REMOTE_SNP",
+        "BriefDescription": "TOR Occupancy : WCiLFs issued by iA Cores tar=
geting PMM that missed the LLC",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCILF_PMM",
         "PerPkg": "1",
-        "UMask": "0x00001c19ff",
-        "UMaskExt": "0x00001c19",
+        "PublicDescription": "TOR Occupancy : WCiLFs issued by iA Cores ta=
rgeting PMM that missed the LLC : For each cycle, this event accumulates th=
e number of valid entries in the TOR that match qualifications specified by=
 the subevent.     Does not include addressless requests such as locks and =
interrupts.",
+        "UMask": "0xc8678a01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts; All Snoops from Remote",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.SNPS_FROM_REM",
+        "BriefDescription": "TOR Occupancy : WCiLs issued by iA Cores targ=
eting DDR that missed the LLC",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCIL_DDR",
         "PerPkg": "1",
-        "UMask": "0x00c001ff08",
-        "UMaskExt": "0x00c001ff",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores tar=
geting DDR that missed the LLC : For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.     Does not include addressless requests such as locks and i=
nterrupts.",
+        "UMask": "0xc86f8601",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : All",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.ALL",
+        "BriefDescription": "TOR Occupancy : WCiLs issued by iA Cores targ=
eting PMM that missed the LLC",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCIL_PMM",
         "PerPkg": "1",
-        "UMask": "0x00C001FFff",
-        "UMaskExt": "0x00C001FF",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores tar=
geting PMM that missed the LLC : For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.     Does not include addressless requests such as locks and i=
nterrupts.",
+        "UMask": "0xc86f8a01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts; All from Local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA",
+        "BriefDescription": "TOR Occupancy : WiLs issued by iA Cores that =
Missed LLC",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WIL",
         "PerPkg": "1",
-        "UMask": "0x00c001ff01",
-        "UMaskExt": "0x00c001ff",
+        "PublicDescription": "TOR Occupancy : WiLs issued by iA Cores that=
 Missed LLC : For each cycle, this event accumulates the number of valid en=
tries in the TOR that match qualifications specified by the subevent.     D=
oes not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc87fde01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts; Hits from Local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT",
+        "BriefDescription": "TOR Occupancy; RFO from local IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_RFO",
         "PerPkg": "1",
-        "UMask": "0x00c001fd01",
-        "UMaskExt": "0x00c001fd",
+        "PublicDescription": "TOR Occupancy; Read for ownership from local=
 IA that misses in the snoop filter",
+        "UMask": "0xc807ff01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts; CRd hits from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD",
+        "BriefDescription": "TOR Occupancy; RFO prefetch from local IA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_RFO_PREF",
         "PerPkg": "1",
-        "UMask": "0x00c80ffd01",
-        "UMaskExt": "0x00c80ffd",
+        "PublicDescription": "TOR Occupancy; Read for ownership prefetch f=
rom local IA that misses in the snoop filter",
+        "UMask": "0xc887ff01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts; DRd hits from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD",
+        "BriefDescription": "TOR Occupancy : SpecItoMs issued by iA Cores"=
,
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_SPECITOM",
         "PerPkg": "1",
-        "UMask": "0x00c817fd01",
-        "UMaskExt": "0x00c817fd",
+        "PublicDescription": "TOR Occupancy : SpecItoMs issued by iA Cores=
 : For each cycle, this event accumulates the number of valid entries in th=
e TOR that match qualifications specified by the subevent.     Does not inc=
lude addressless requests such as locks and interrupts.",
+        "UMask": "0xcc57ff01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts; LLCPrefRFO hits from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LLCPREFRFO",
+        "BriefDescription": "TOR Occupancy : WbMtoIs issued by iA Cores",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_WBMTOI",
         "PerPkg": "1",
-        "UMask": "0x00ccc7fd01",
-        "UMaskExt": "0x00ccc7fd",
+        "PublicDescription": "TOR Occupancy : WbMtoIs issued by iA Cores :=
 For each cycle, this event accumulates the number of valid entries in the =
TOR that match qualifications specified by the subevent.     Does not inclu=
de addressless requests such as locks and interrupts.",
+        "UMask": "0xcc27ff01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts; RFO hits from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO",
+        "BriefDescription": "TOR Occupancy : WCiLs issued by iA Cores",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_WCIL",
         "PerPkg": "1",
-        "UMask": "0x00c807fd01",
-        "UMaskExt": "0x00c807fd",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores : F=
or each cycle, this event accumulates the number of valid entries in the TO=
R that match qualifications specified by the subevent.     Does not include=
 addressless requests such as locks and interrupts.",
+        "UMask": "0xc86fff01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts; misses from Local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
+        "BriefDescription": "TOR Occupancy : WCiLF issued by iA Cores",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_WCILF",
         "PerPkg": "1",
-        "UMask": "0x00c001fe01",
-        "UMaskExt": "0x00c001fe",
+        "PublicDescription": "TOR Occupancy : WCiLF issued by iA Cores : F=
or each cycle, this event accumulates the number of valid entries in the TO=
R that match qualifications specified by the subevent.     Does not include=
 addressless requests such as locks and interrupts.",
+        "UMask": "0xc867ff01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts; LLCPrefRFO misses from local IA"=
,
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFRFO",
+        "BriefDescription": "TOR Occupancy; All from local IO",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO",
         "PerPkg": "1",
-        "UMask": "0x00ccc7fe01",
-        "UMaskExt": "0x00ccc7fe",
+        "PublicDescription": "TOR Occupancy : All requests from IO Devices=
 : For each cycle, this event accumulates the number of valid entries in th=
e TOR that match qualifications specified by the subevent.     Does not inc=
lude addressless requests such as locks and interrupts.",
+        "UMask": "0xc001ff04",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts; RFO misses from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO",
+        "BriefDescription": "TOR Occupancy : CLFlushes issued by IO Device=
s",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_CLFLUSH",
         "PerPkg": "1",
-        "UMask": "0x00c807fe01",
-        "UMaskExt": "0x00c807fe",
+        "PublicDescription": "TOR Occupancy : CLFlushes issued by IO Devic=
es : For each cycle, this event accumulates the number of valid entries in =
the TOR that match qualifications specified by the subevent.     Does not i=
nclude addressless requests such as locks and interrupts.",
+        "UMask": "0xc8c3ff04",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts; All from local IO",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO",
+        "BriefDescription": "TOR Occupancy; Hits from local IO",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT",
         "PerPkg": "1",
-        "UMask": "0x00c001ff04",
-        "UMaskExt": "0x00c001ff",
+        "PublicDescription": "TOR Occupancy : All requests from IO Devices=
 that hit the LLC : For each cycle, this event accumulates the number of va=
lid entries in the TOR that match qualifications specified by the subevent.=
     Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc001fd04",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts; Hits from local IO",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT",
+        "BriefDescription": "TOR Occupancy; ITOM hits from local IO",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT_ITOM",
         "PerPkg": "1",
-        "UMask": "0x00c001fd04",
-        "UMaskExt": "0x00c001fd",
+        "PublicDescription": "TOR Occupancy : ItoMs issued by IO Devices t=
hat Hit the LLC : For each cycle, this event accumulates the number of vali=
d entries in the TOR that match qualifications specified by the subevent.  =
   Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xcc43fd04",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts; Misses from local IO",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS",
+        "BriefDescription": "TOR Occupancy : ItoMCacheNears, indicating a =
partial write request, from IO Devices that hit the LLC",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT_ITOMCACHENEAR",
         "PerPkg": "1",
-        "UMask": "0x00c001fe04",
-        "UMaskExt": "0x00c001fe",
+        "PublicDescription": "TOR Occupancy : ItoMCacheNears, indicating a=
 partial write request, from IO Devices that hit the LLC : For each cycle, =
this event accumulates the number of valid entries in the TOR that match qu=
alifications specified by the subevent.     Does not include addressless re=
quests such as locks and interrupts.",
+        "UMask": "0xcd43fd04",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts; ItoM misses from local IO",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOM",
+        "BriefDescription": "TOR Occupancy; RdCur and FsRdCur hits from lo=
cal IO",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT_PCIRDCUR",
         "PerPkg": "1",
-        "UMask": "0x00cc43fe04",
-        "UMaskExt": "0x00cc43fe",
+        "PublicDescription": "TOR Occupancy : PCIRdCurs issued by IO Devic=
es that hit the LLC : For each cycle, this event accumulates the number of =
valid entries in the TOR that match qualifications specified by the subeven=
t.     Does not include addressless requests such as locks and interrupts."=
,
+        "UMask": "0xc8f3fd04",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts; RFO misses from local IO",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_RFO",
+        "BriefDescription": "TOR Occupancy; RFO hits from local IO",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT_RFO",
         "PerPkg": "1",
-        "UMask": "0x00c803fe04",
-        "UMaskExt": "0x00c803fe",
+        "PublicDescription": "TOR Occupancy : RFOs issued by IO Devices th=
at hit the LLC : For each cycle, this event accumulates the number of valid=
 entries in the TOR that match qualifications specified by the subevent.   =
  Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc803fd04",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : IRQ - iA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IRQ_IA",
+        "BriefDescription": "TOR Occupancy; ITOM from local IO",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_ITOM",
         "PerPkg": "1",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "TOR Occupancy : ItoMs issued by IO Devices :=
 For each cycle, this event accumulates the number of valid entries in the =
TOR that match qualifications specified by the subevent.     Does not inclu=
de addressless requests such as locks and interrupts.",
+        "UMask": "0xcc43ff04",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : SF/LLC Evictions",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.EVICT",
+        "BriefDescription": "TOR Occupancy; Misses from local IO",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS",
         "PerPkg": "1",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "TOR Occupancy : All requests from IO Devices=
 that missed the LLC : For each cycle, this event accumulates the number of=
 valid entries in the TOR that match qualifications specified by the subeve=
nt.     Does not include addressless requests such as locks and interrupts.=
",
+        "UMask": "0xc001fe04",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : PRQ - IOSF",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.PRQ_IOSF",
+        "BriefDescription": "TOR Occupancy; ITOM misses from local IO",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOM",
         "PerPkg": "1",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "TOR Occupancy : ItoMs issued by IO Devices t=
hat missed the LLC : For each cycle, this event accumulates the number of v=
alid entries in the TOR that match qualifications specified by the subevent=
.     Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xcc43fe04",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : IPQ",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IPQ",
+        "BriefDescription": "TOR Occupancy : ItoMCacheNears, indicating a =
partial write request, from IO Devices that missed the LLC",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOMCACHENEAR",
         "PerPkg": "1",
-        "UMask": "0x0000000008",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "TOR Occupancy : ItoMCacheNears, indicating a=
 partial write request, from IO Devices that missed the LLC : For each cycl=
e, this event accumulates the number of valid entries in the TOR that match=
 qualifications specified by the subevent.     Does not include addressless=
 requests such as locks and interrupts.",
+        "UMask": "0xcd43fe04",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : IRQ - Non iA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IRQ_NON_IA",
+        "BriefDescription": "TOR Occupancy; RdCur and FsRdCur misses from =
local IO",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_PCIRDCUR",
         "PerPkg": "1",
-        "UMask": "0x0000000010",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "TOR Occupancy : PCIRdCurs issued by IO Devic=
es that missed the LLC : For each cycle, this event accumulates the number =
of valid entries in the TOR that match qualifications specified by the sube=
vent.     Does not include addressless requests such as locks and interrupt=
s.",
+        "UMask": "0xc8f3fe04",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : PRQ - Non IOSF",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.PRQ_NON_IOSF",
+        "BriefDescription": "TOR Occupancy; RFO misses from local IO",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_RFO",
         "PerPkg": "1",
-        "UMask": "0x0000000020",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "TOR Occupancy : RFOs issued by IO Devices th=
at missed the LLC : For each cycle, this event accumulates the number of va=
lid entries in the TOR that match qualifications specified by the subevent.=
     Does not include addressless requests such as locks and interrupts.",
+        "UMask": "0xc803fe04",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : RRQ",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.RRQ",
+        "BriefDescription": "TOR Occupancy; RdCur and FsRdCur from local I=
O",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_PCIRDCUR",
         "PerPkg": "1",
-        "UMask": "0x0000000040",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "TOR Occupancy : PCIRdCurs issued by IO Devic=
es : For each cycle, this event accumulates the number of valid entries in =
the TOR that match qualifications specified by the subevent.     Does not i=
nclude addressless requests such as locks and interrupts.",
+        "UMask": "0xc8f3ff04",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : WBQ",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.WBQ",
+        "BriefDescription": "TOR Occupancy; ItoM from local IO",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_RFO",
         "PerPkg": "1",
-        "UMask": "0x0000000080",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "TOR Occupancy : RFOs issued by IO Devices : =
For each cycle, this event accumulates the number of valid entries in the T=
OR that match qualifications specified by the subevent.     Does not includ=
e addressless requests such as locks and interrupts.",
+        "UMask": "0xc803ff04",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : All from Local IO",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.LOC_IO",
+        "BriefDescription": "TOR Occupancy : WbMtoIs issued by IO Devices"=
,
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_WBMTOI",
         "PerPkg": "1",
-        "UMask": "0x00C000FF04",
-        "UMaskExt": "0x00C000FF",
+        "PublicDescription": "TOR Occupancy : WbMtoIs issued by IO Devices=
 : For each cycle, this event accumulates the number of valid entries in th=
e TOR that match qualifications specified by the subevent.     Does not inc=
lude addressless requests such as locks and interrupts.",
+        "UMask": "0xcc23ff04",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : All from Local iA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.LOC_IA",
+        "BriefDescription": "TOR Occupancy : IPQ",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IPQ",
         "PerPkg": "1",
-        "UMask": "0x00c000ff01",
-        "UMaskExt": "0x00c000ff",
+        "PublicDescription": "TOR Occupancy : IPQ : For each cycle, this e=
vent accumulates the number of valid entries in the TOR that match qualific=
ations specified by the subevent.   T",
+        "UMask": "0x8",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : All from Local iA and IO",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.LOC_ALL",
+        "BriefDescription": "TOR Occupancy : IRQ - iA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IRQ_IA",
         "PerPkg": "1",
-        "UMask": "0x00C000FF05",
-        "UMaskExt": "0x00C000FF",
+        "PublicDescription": "TOR Occupancy : IRQ - iA : For each cycle, t=
his event accumulates the number of valid entries in the TOR that match qua=
lifications specified by the subevent.   T : From an iA Core",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : All Snoops from Remote",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.REM_SNPS",
+        "BriefDescription": "TOR Occupancy : IRQ - Non iA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IRQ_NON_IA",
         "PerPkg": "1",
-        "UMask": "0x00C001FF08",
-        "UMaskExt": "0x00C001FF",
+        "PublicDescription": "TOR Occupancy : IRQ - Non iA : For each cycl=
e, this event accumulates the number of valid entries in the TOR that match=
 qualifications specified by the subevent.   T",
+        "UMask": "0x10",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : All from Remote",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.REM_ALL",
+        "BriefDescription": "TOR Occupancy : Just ISOC",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.ISOC",
         "PerPkg": "1",
-        "UMask": "0x00C001FFC8",
-        "UMaskExt": "0x00C001FF",
+        "PublicDescription": "TOR Occupancy : Just ISOC : For each cycle, =
this event accumulates the number of valid entries in the TOR that match qu=
alifications specified by the subevent.   T",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : Just Hits",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.HIT",
+        "BriefDescription": "TOR Occupancy : Just Local Targets",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.LOCAL_TGT",
         "PerPkg": "1",
-        "UMaskExt": "0x00000001",
+        "PublicDescription": "TOR Occupancy : Just Local Targets : For eac=
h cycle, this event accumulates the number of valid entries in the TOR that=
 match qualifications specified by the subevent.   T",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : Just Misses",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.MISS",
+        "BriefDescription": "TOR Occupancy : All from Local iA and IO",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.LOC_ALL",
         "PerPkg": "1",
-        "UMaskExt": "0x00000002",
+        "PublicDescription": "TOR Occupancy : All from Local iA and IO : F=
or each cycle, this event accumulates the number of valid entries in the TO=
R that match qualifications specified by the subevent.   T : All locally in=
itiated requests",
+        "UMask": "0xc000ff05",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : MMCFG Access",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.MMCFG",
+        "BriefDescription": "TOR Occupancy : All from Local iA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.LOC_IA",
         "PerPkg": "1",
-        "UMaskExt": "0x00000020",
+        "PublicDescription": "TOR Occupancy : All from Local iA : For each=
 cycle, this event accumulates the number of valid entries in the TOR that =
match qualifications specified by the subevent.   T : All locally initiated=
 requests from iA Cores",
+        "UMask": "0xc000ff01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : MMIO Access",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.MMIO",
+        "BriefDescription": "TOR Occupancy : All from Local IO",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.LOC_IO",
         "PerPkg": "1",
-        "UMaskExt": "0x00000040",
+        "PublicDescription": "TOR Occupancy : All from Local IO : For each=
 cycle, this event accumulates the number of valid entries in the TOR that =
match qualifications specified by the subevent.   T : All locally generated=
 IO traffic",
+        "UMask": "0xc000ff04",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : Just Local Targets",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.LOCAL_TGT",
+        "BriefDescription": "TOR Occupancy : Match the Opcode in b[29:19] =
of the extended umask field",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.MATCH_OPC",
         "PerPkg": "1",
-        "UMaskExt": "0x00000080",
+        "PublicDescription": "TOR Occupancy : Match the Opcode in b[29:19]=
 of the extended umask field : For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   T",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : Just Remote Targets",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.REMOTE_TGT",
+        "BriefDescription": "TOR Occupancy : Just Misses",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.MISS",
         "PerPkg": "1",
-        "UMaskExt": "0x00000100",
+        "PublicDescription": "TOR Occupancy : Just Misses : For each cycle=
, this event accumulates the number of valid entries in the TOR that match =
qualifications specified by the subevent.   T",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : Match the Opcode in b[29:19] of=
 the extended umask field",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.MATCH_OPC",
+        "BriefDescription": "TOR Occupancy : MMCFG Access",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.MMCFG",
         "PerPkg": "1",
-        "UMaskExt": "0x00000200",
+        "PublicDescription": "TOR Occupancy : MMCFG Access : For each cycl=
e, this event accumulates the number of valid entries in the TOR that match=
 qualifications specified by the subevent.   T",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : Match the PreMorphed Opcode in =
b[29:19] of the extended umask field",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.PREMORPH_OPC",
+        "BriefDescription": "TOR Occupancy : MMIO Access",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.MMIO",
         "PerPkg": "1",
-        "UMaskExt": "0x00000400",
+        "PublicDescription": "TOR Occupancy : MMIO Access : For each cycle=
, this event accumulates the number of valid entries in the TOR that match =
qualifications specified by the subevent.   T",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : Just NonCoherent",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.NONCOH",
+        "BriefDescription": "TOR Occupancy : Just NonCoherent",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.NONCOH",
         "PerPkg": "1",
-        "UMaskExt": "0x01000000",
+        "PublicDescription": "TOR Occupancy : Just NonCoherent : For each =
cycle, this event accumulates the number of valid entries in the TOR that m=
atch qualifications specified by the subevent.   T",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : Just ISOC",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.ISOC",
+        "BriefDescription": "TOR Occupancy : PMM Access",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.PMM",
         "PerPkg": "1",
-        "UMaskExt": "0x02000000",
+        "PublicDescription": "TOR Occupancy : PMM Access : For each cycle,=
 this event accumulates the number of valid entries in the TOR that match q=
ualifications specified by the subevent.",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts; CRd Pref hits from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD_PREF",
+        "BriefDescription": "TOR Occupancy : Match the PreMorphed Opcode i=
n b[29:19] of the extended umask field",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.PREMORPH_OPC",
         "PerPkg": "1",
-        "UMask": "0x00c88ffd01",
-        "UMaskExt": "0x00c88ffd",
+        "PublicDescription": "TOR Occupancy : Match the PreMorphed Opcode =
in b[29:19] of the extended umask field : For each cycle, this event accumu=
lates the number of valid entries in the TOR that match qualifications spec=
ified by the subevent.   T",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts; DRd Pref hits from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD_PREF",
+        "BriefDescription": "TOR Occupancy : PRQ - IOSF",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.PRQ",
         "PerPkg": "1",
-        "UMask": "0x00c897fd01",
-        "UMaskExt": "0x00c897fd",
+        "PublicDescription": "TOR Occupancy : PRQ - IOSF : For each cycle,=
 this event accumulates the number of valid entries in the TOR that match q=
ualifications specified by the subevent.   T : From a PCIe Device",
+        "UMask": "0x4",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts; DRd Opt hits from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD_OPT",
+        "BriefDescription": "TOR Occupancy : PRQ - Non IOSF",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.PRQ_NON_IOSF",
         "PerPkg": "1",
-        "UMask": "0x00c827fd01",
-        "UMaskExt": "0x00c827fd",
+        "PublicDescription": "TOR Occupancy : PRQ - Non IOSF : For each cy=
cle, this event accumulates the number of valid entries in the TOR that mat=
ch qualifications specified by the subevent.   T",
+        "UMask": "0x20",
         "Unit": "CHA"
     },
-    {
-        "BriefDescription": "TOR Inserts; DRd Opt Pref hits from local IA"=
,
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD_OPT_PREF",
+    {
+        "BriefDescription": "TOR Occupancy : Just Remote Targets",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.REMOTE_TGT",
         "PerPkg": "1",
-        "UMask": "0x00c8a7fd01",
-        "UMaskExt": "0x00c8a7fd",
+        "PublicDescription": "TOR Occupancy : Just Remote Targets : For ea=
ch cycle, this event accumulates the number of valid entries in the TOR tha=
t match qualifications specified by the subevent.   T",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts; RFO Pref hits from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO_PREF",
+        "BriefDescription": "TOR Occupancy : All from Remote",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.REM_ALL",
         "PerPkg": "1",
-        "UMask": "0x00c887fd01",
-        "UMaskExt": "0x00c887fd",
+        "PublicDescription": "TOR Occupancy : All from Remote : For each c=
ycle, this event accumulates the number of valid entries in the TOR that ma=
tch qualifications specified by the subevent.   T : All remote requests (e.=
g. snoops, writebacks) that came from remote sockets",
+        "UMask": "0xc001ffc8",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts; CRd Pref misses from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_PREF",
+        "BriefDescription": "TOR Occupancy : All Snoops from Remote",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.REM_SNPS",
         "PerPkg": "1",
-        "UMask": "0x00c88ffe01",
-        "UMaskExt": "0x00c88ffe",
+        "PublicDescription": "TOR Occupancy : All Snoops from Remote : For=
 each cycle, this event accumulates the number of valid entries in the TOR =
that match qualifications specified by the subevent.   T : All snoops to th=
is LLC that came from remote sockets",
+        "UMask": "0xc001ff08",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts; DRd Opt misses from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT",
+        "BriefDescription": "TOR Occupancy : RRQ",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.RRQ",
         "PerPkg": "1",
-        "UMask": "0x00c827fe01",
-        "UMaskExt": "0x00c827fe",
+        "PublicDescription": "TOR Occupancy : RRQ : For each cycle, this e=
vent accumulates the number of valid entries in the TOR that match qualific=
ations specified by the subevent.   T",
+        "UMask": "0x40",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts; DRd Opt Pref misses from local I=
A",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF",
+        "BriefDescription": "TOR Occupancy; All Snoops from Remote",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.SNPS_FROM_REM",
         "PerPkg": "1",
-        "UMask": "0x00c8a7fe01",
-        "UMaskExt": "0x00c8a7fe",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   All snoops to this LLC that came from remote sockets.",
+        "UMask": "0xc001ff08",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts; RFO pref misses from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF",
+        "BriefDescription": "TOR Occupancy : WBQ",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.WBQ",
         "PerPkg": "1",
-        "UMask": "0x00c887fe01",
-        "UMaskExt": "0x00c887fe",
+        "PublicDescription": "TOR Occupancy : WBQ : For each cycle, this e=
vent accumulates the number of valid entries in the TOR that match qualific=
ations specified by the subevent.   T",
+        "UMask": "0x80",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts; ItoM hits from local IO",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_ITOM",
+        "BriefDescription": "IIO Clockticks",
+        "EventCode": "0x01",
+        "EventName": "UNC_IIO_CLOCKTICKS",
         "PerPkg": "1",
-        "UMask": "0x00cc43fd04",
-        "UMaskExt": "0x00cc43fd",
-        "Unit": "CHA"
+        "PortMask": "0x0000",
+        "PublicDescription": "Number of IIO clock cycles while the event i=
s enabled",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Inserts; RFO hits from local IO",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_RFO",
+        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 0",
+        "EventCode": "0xc2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART0",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c803fd04",
-        "UMaskExt": "0x00c803fd",
-        "Unit": "CHA"
+        "PortMask": "0x01",
+        "PublicDescription": "PCIe Completion Buffer Inserts of completion=
s with data : Part 0 : x16 card plugged in to Lane 0/1/2/3, Or x8 card plug=
ged in to Lane 0/1, Or x4 card is plugged in to slot 0",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Inserts; RFO from local IO",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO_RFO",
+        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 1",
+        "EventCode": "0xc2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART1",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c803ff04",
-        "UMaskExt": "0x00c803ff",
-        "Unit": "CHA"
+        "PortMask": "0x02",
+        "PublicDescription": "PCIe Completion Buffer Inserts of completion=
s with data : Part 1 : x16 card plugged in to Lane 0/1/2/3, Or x8 card plug=
ged in to Lane 0/1, Or x4 card is plugged in to slot 1",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Inserts; RFO pref from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_RFO_PREF",
+        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 2",
+        "EventCode": "0xc2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART2",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c887ff01",
-        "UMaskExt": "0x00c887ff",
-        "Unit": "CHA"
+        "PortMask": "0x04",
+        "PublicDescription": "PCIe Completion Buffer Inserts of completion=
s with data : Part 2 : x16 card plugged in to Lane 0/1/2/3, Or x8 card plug=
ged in to Lane 0/1, Or x4 card is plugged in to slot 2",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Inserts; RFO from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_RFO",
+        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 3",
+        "EventCode": "0xc2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART3",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c807ff01",
-        "UMaskExt": "0x00c807ff",
-        "Unit": "CHA"
+        "PortMask": "0x08",
+        "PublicDescription": "PCIe Completion Buffer Inserts of completion=
s with data : Part 2 : x16 card plugged in to Lane 0/1/2/3, Or x8 card plug=
ged in to Lane 0/1, Or x4 card is plugged in to slot 3",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Inserts; LLCPrefRFO from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_LLCPREFRFO",
+        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 4",
+        "EventCode": "0xc2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART4",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00ccc7ff01",
-        "UMaskExt": "0x00ccc7ff",
-        "Unit": "CHA"
+        "PortMask": "0x10",
+        "PublicDescription": "PCIe Completion Buffer Inserts of completion=
s with data : Part 0 : x16 card plugged in to Lane 0/1/2/3, Or x8 card plug=
ged in to Lane 0/1, Or x4 card is plugged in to slot 4",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Inserts; DRd from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD",
+        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 5",
+        "EventCode": "0xc2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART5",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c817ff01",
-        "UMaskExt": "0x00c817ff",
-        "Unit": "CHA"
+        "PortMask": "0x20",
+        "PublicDescription": "PCIe Completion Buffer Inserts of completion=
s with data : Part 1 : x16 card plugged in to Lane 0/1/2/3, Or x8 card plug=
ged in to Lane 0/1, Or x4 card is plugged in to slot 5",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Inserts; DRd Pref from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD_PREF",
+        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 6",
+        "EventCode": "0xc2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART6",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c897ff01",
-        "UMaskExt": "0x00c897ff",
-        "Unit": "CHA"
+        "PortMask": "0x40",
+        "PublicDescription": "PCIe Completion Buffer Inserts of completion=
s with data : Part 2 : x16 card plugged in to Lane 0/1/2/3, Or x8 card plug=
ged in to Lane 0/1, Or x4 card is plugged in to slot 6",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Inserts; DRd Opt from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD_OPT",
+        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 7",
+        "EventCode": "0xc2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART7",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c827ff01",
-        "UMaskExt": "0x00c827ff",
-        "Unit": "CHA"
+        "PortMask": "0x80",
+        "PublicDescription": "PCIe Completion Buffer Inserts of completion=
s with data : Part 2 : x16 card plugged in to Lane 0/1/2/3, Or x8 card plug=
ged in to Lane 0/1, Or x4 card is plugged in to slot 7",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Inserts; DRd Opt Pref from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD_OPT_PREF",
+        "BriefDescription": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.ALL_PARTS",
+        "EventCode": "0xd5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.ALL_PARTS",
+        "FCMask": "0x04",
         "PerPkg": "1",
-        "UMask": "0x00c8a7ff01",
-        "UMaskExt": "0x00c8a7ff",
-        "Unit": "CHA"
+        "UMask": "0xff",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Inserts; CRd Pref from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_CRD_PREF",
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "EventCode": "0xc0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.IOMMU0",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00C88FFF01",
-        "UMaskExt": "0x00C88FFF",
-        "Unit": "CHA"
+        "PortMask": "0x0100",
+        "PublicDescription": "Data requested by the CPU : Core writing to =
Cards MMIO space : Number of DWs (4 bytes) requested by the main die.  Incl=
udes all requests initiated by the main die, including reads and writes. : =
IOMMU - Type 0",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Inserts; CRd from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_CRD",
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "EventCode": "0xc0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.IOMMU1",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c80fff01",
-        "UMaskExt": "0x00c80fff",
-        "Unit": "CHA"
+        "PortMask": "0x0200",
+        "PublicDescription": "Data requested by the CPU : Core writing to =
Cards MMIO space : Number of DWs (4 bytes) requested by the main die.  Incl=
udes all requests initiated by the main die, including reads and writes. : =
IOMMU - Type 1",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Inserts RFO misses from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_LOCAL",
+        "BriefDescription": "Write request of 4 bytes made to IIO Part0 by=
 the CPU",
+        "EventCode": "0xc0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c806fe01",
-        "UMaskExt": "0x00c806fe",
-        "Unit": "CHA"
+        "PortMask": "0x0001",
+        "PublicDescription": "Data requested by the CPU : Core writing to =
Card's MMIO space : Number of DWs (4 bytes) requested by the main die.  Inc=
ludes all requests initiated by the main die, including reads and writes. :=
 x16 card plugged in to stack, Or x8 card plugged in to Lane 0/1, Or x4 car=
d is plugged in to slot 0",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Inserts; RFO misses from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_REMOTE",
+        "BriefDescription": "Write request of 4 bytes made to IIO Part1 by=
 the CPU",
+        "EventCode": "0xc0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART1",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c8077e01",
-        "UMaskExt": "0x00c8077e",
-        "Unit": "CHA"
+        "PortMask": "0x0002",
+        "PublicDescription": "Data requested by the CPU : Core writing to =
Card's MMIO space : Number of DWs (4 bytes) requested by the main die.  Inc=
ludes all requests initiated by the main die, including reads and writes. :=
 x4 card is plugged in to slot 1",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Inserts; RFO prefetch misses from local I=
A",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_LOCAL",
+        "BriefDescription": "Write request of 4 bytes made to IIO Part2 by=
 the CPU",
+        "EventCode": "0xc0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART2",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c886fe01",
-        "UMaskExt": "0x00c886fe",
-        "Unit": "CHA"
+        "PortMask": "0x0004",
+        "PublicDescription": "Data requested by the CPU : Core writing to =
Card's MMIO space : Number of DWs (4 bytes) requested by the main die.  Inc=
ludes all requests initiated by the main die, including reads and writes. :=
 x8 card plugged in to Lane 2/3, Or x4 card is plugged in to slot 1",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Inserts; RFO prefetch misses from local I=
A",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_REMOTE",
+        "BriefDescription": "Write request of 4 bytes made to IIO Part3 by=
 the CPU",
+        "EventCode": "0xc0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART3",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c8877e01",
-        "UMaskExt": "0x00c8877e",
-        "Unit": "CHA"
+        "PortMask": "0x0008",
+        "PublicDescription": "Data requested by the CPU : Core writing to =
Card's MMIO space : Number of DWs (4 bytes) requested by the main die.  Inc=
ludes all requests initiated by the main die, including reads and writes. :=
 x4 card is plugged in to slot 3",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Inserts;CLFlush from Local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_CLFLUSH",
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "EventCode": "0xc0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART4",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c8c7ff01",
-        "UMaskExt": "0x00c8c7ff",
-        "Unit": "CHA"
+        "PortMask": "0x0010",
+        "PublicDescription": "Data requested by the CPU : Core writing to =
Cards MMIO space : Number of DWs (4 bytes) requested by the main die.  Incl=
udes all requests initiated by the main die, including reads and writes. : =
x16 card plugged in to stack, Or x8 card plugged in to Lane 0/1, Or x4 card=
 is plugged in to slot 0",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Inserts;CLFlushOpt from Local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_CLFLUSHOPT",
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "EventCode": "0xc0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART5",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c8d7ff01",
-        "UMaskExt": "0x00c8d7ff",
-        "Unit": "CHA"
+        "PortMask": "0x0020",
+        "PublicDescription": "Data requested by the CPU : Core writing to =
Cards MMIO space : Number of DWs (4 bytes) requested by the main die.  Incl=
udes all requests initiated by the main die, including reads and writes. : =
x4 card is plugged in to slot 1",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Inserts;ItoM from Local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_ITOM",
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "EventCode": "0xc0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART6",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00cc47ff01",
-        "UMaskExt": "0x00cc47ff",
-        "Unit": "CHA"
+        "PortMask": "0x0040",
+        "PublicDescription": "Data requested by the CPU : Core writing to =
Cards MMIO space : Number of DWs (4 bytes) requested by the main die.  Incl=
udes all requests initiated by the main die, including reads and writes. : =
x8 card plugged in to Lane 2/3, Or x4 card is plugged in to slot 1",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Inserts;SpecItoM from Local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_SPECITOM",
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "EventCode": "0xc0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART7",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00cc57ff01",
-        "UMaskExt": "0x00cc57ff",
-        "Unit": "CHA"
+        "PortMask": "0x0080",
+        "PublicDescription": "Data requested by the CPU : Core writing to =
Cards MMIO space : Number of DWs (4 bytes) requested by the main die.  Incl=
udes all requests initiated by the main die, including reads and writes. : =
x4 card is plugged in to slot 3",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; All Snoops from Remote",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.SNPS_FROM_REM",
+        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART0",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c001ff08",
-        "UMaskExt": "0x00c001ff",
-        "Unit": "CHA"
+        "PortMask": "0x0001",
+        "PublicDescription": "Data requested of the CPU : CmpD - device se=
nding completion to CPU request : Number of DWs (4 bytes) the card requests=
 of the main die.    Includes all requests initiated by the Card, including=
 reads and writes. : x16 card plugged in to Lane 0/1/2/3, Or x8 card plugge=
d in to Lane 0/1, Or x4 card is plugged in to slot 0",
+        "UMask": "0x80",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy : All",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.ALL",
+        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART1",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00C001FFff",
-        "UMaskExt": "0x00C001FF",
-        "Unit": "CHA"
+        "PortMask": "0x0002",
+        "PublicDescription": "Data requested of the CPU : CmpD - device se=
nding completion to CPU request : Number of DWs (4 bytes) the card requests=
 of the main die.    Includes all requests initiated by the Card, including=
 reads and writes. : x4 card is plugged in to slot 1",
+        "UMask": "0x80",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; All from local IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA",
+        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART2",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c001ff01",
-        "UMaskExt": "0x00c001ff",
-        "Unit": "CHA"
+        "PortMask": "0x0004",
+        "PublicDescription": "Data requested of the CPU : CmpD - device se=
nding completion to CPU request : Number of DWs (4 bytes) the card requests=
 of the main die.    Includes all requests initiated by the Card, including=
 reads and writes. : x8 card plugged in to Lane 2/3, Or x4 card is plugged =
in to slot 2",
+        "UMask": "0x80",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; Hits from local IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT",
+        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART3",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c001fd01",
-        "UMaskExt": "0x00c001fd",
-        "Unit": "CHA"
+        "PortMask": "0x0008",
+        "PublicDescription": "Data requested of the CPU : CmpD - device se=
nding completion to CPU request : Number of DWs (4 bytes) the card requests=
 of the main die.    Includes all requests initiated by the Card, including=
 reads and writes. : x4 card is plugged in to slot 3",
+        "UMask": "0x80",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; CRd hits from local IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CRD",
+        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART4",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c80ffd01",
-        "UMaskExt": "0x00c80ffd",
-        "Unit": "CHA"
+        "PortMask": "0x0010",
+        "PublicDescription": "Data requested of the CPU : CmpD - device se=
nding completion to CPU request : Number of DWs (4 bytes) the card requests=
 of the main die.    Includes all requests initiated by the Card, including=
 reads and writes. : x16 card plugged in to Lane 4/5/6/7, Or x8 card plugge=
d in to Lane 4/5, Or x4 card is plugged in to slot 4",
+        "UMask": "0x80",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; DRd hits from local IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD",
+        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART5",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c817fd01",
-        "UMaskExt": "0x00c817fd",
-        "Unit": "CHA"
+        "PortMask": "0x0020",
+        "PublicDescription": "Data requested of the CPU : CmpD - device se=
nding completion to CPU request : Number of DWs (4 bytes) the card requests=
 of the main die.    Includes all requests initiated by the Card, including=
 reads and writes. : x4 card is plugged in to slot 5",
+        "UMask": "0x80",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; LLCPrefRFO hits from local IA"=
,
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LLCPREFRFO",
+        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART6",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00ccc7fd01",
-        "UMaskExt": "0x00ccc7fd",
-        "Unit": "CHA"
+        "PortMask": "0x0040",
+        "PublicDescription": "Data requested of the CPU : CmpD - device se=
nding completion to CPU request : Number of DWs (4 bytes) the card requests=
 of the main die.    Includes all requests initiated by the Card, including=
 reads and writes. : x8 card plugged in to Lane 6/7, Or x4 card is plugged =
in to slot 6",
+        "UMask": "0x80",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; RFO hits from local IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO",
+        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART7",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c807fd01",
-        "UMaskExt": "0x00c807fd",
-        "Unit": "CHA"
+        "PortMask": "0x0080",
+        "PublicDescription": "Data requested of the CPU : CmpD - device se=
nding completion to CPU request : Number of DWs (4 bytes) the card requests=
 of the main die.    Includes all requests initiated by the Card, including=
 reads and writes. : x4 card is plugged in to slot 7",
+        "UMask": "0x80",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; Misses from Local IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS",
+        "BriefDescription": "Read request for 4 bytes made by IIO Part0 to=
 Memory",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c001fe01",
-        "UMaskExt": "0x00c001fe",
-        "Unit": "CHA"
+        "PortMask": "0x0001",
+        "PublicDescription": "Data requested of the CPU : Card reading fro=
m DRAM : Number of DWs (4 bytes) the card requests of the main die.    Incl=
udes all requests initiated by the Card, including reads and writes. : x16 =
card plugged in to stack, Or x8 card plugged in to Lane 0/1, Or x4 card is =
plugged in to slot 0",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; CRd misses from local IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD",
+        "BriefDescription": "Read request for 4 bytes made by IIO Part1 to=
 Memory",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c80ffe01",
-        "UMaskExt": "0x00c80ffe",
-        "Unit": "CHA"
+        "PortMask": "0x0002",
+        "PublicDescription": "Data requested of the CPU : Card reading fro=
m DRAM : Number of DWs (4 bytes) the card requests of the main die.    Incl=
udes all requests initiated by the Card, including reads and writes. : x4 c=
ard is plugged in to slot 1",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; LLCPrefRFO misses from local I=
A",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFRFO",
+        "BriefDescription": "Read request for 4 bytes made by IIO Part2 to=
 Memory",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00ccc7fe01",
-        "UMaskExt": "0x00ccc7fe",
-        "Unit": "CHA"
+        "PortMask": "0x0004",
+        "PublicDescription": "Data requested of the CPU : Card reading fro=
m DRAM : Number of DWs (4 bytes) the card requests of the main die.    Incl=
udes all requests initiated by the Card, including reads and writes. : x8 c=
ard plugged in to Lane 2/3, Or x4 card is plugged in to slot 1",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; RFO misses from local IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO",
+        "BriefDescription": "Read request for 4 bytes made by IIO Part3 to=
 Memory",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c807fe01",
-        "UMaskExt": "0x00c807fe",
-        "Unit": "CHA"
+        "PortMask": "0x0008",
+        "PublicDescription": "Data requested of the CPU : Card reading fro=
m DRAM : Number of DWs (4 bytes) the card requests of the main die.    Incl=
udes all requests initiated by the Card, including reads and writes. : x4 c=
ard is plugged in to slot 3",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; All from local IO",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO",
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 DRAM",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART4",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c001ff04",
-        "UMaskExt": "0x00c001ff",
-        "Unit": "CHA"
+        "PortMask": "0x0010",
+        "PublicDescription": "Data requested of the CPU : Card reading fro=
m DRAM : Number of DWs (4 bytes) the card requests of the main die.    Incl=
udes all requests initiated by the Card, including reads and writes. : x16 =
card plugged in to stack, Or x8 card plugged in to Lane 0/1, Or x4 card is =
plugged in to slot 0",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; Hits from local IO",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT",
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 DRAM",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART5",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c001fd04",
-        "UMaskExt": "0x00c001fd",
-        "Unit": "CHA"
+        "PortMask": "0x0020",
+        "PublicDescription": "Data requested of the CPU : Card reading fro=
m DRAM : Number of DWs (4 bytes) the card requests of the main die.    Incl=
udes all requests initiated by the Card, including reads and writes. : x4 c=
ard is plugged in to slot 1",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; Misses from local IO",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS",
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 DRAM",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART6",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c001fe04",
-        "UMaskExt": "0x00c001fe",
-        "Unit": "CHA"
+        "PortMask": "0x0040",
+        "PublicDescription": "Data requested of the CPU : Card reading fro=
m DRAM : Number of DWs (4 bytes) the card requests of the main die.    Incl=
udes all requests initiated by the Card, including reads and writes. : x8 c=
ard plugged in to Lane 2/3, Or x4 card is plugged in to slot 1",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; RFO misses from local IO",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_RFO",
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 DRAM",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART7",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c803fe04",
-        "UMaskExt": "0x00c803fe",
-        "Unit": "CHA"
+        "PortMask": "0x0080",
+        "PublicDescription": "Data requested of the CPU : Card reading fro=
m DRAM : Number of DWs (4 bytes) the card requests of the main die.    Incl=
udes all requests initiated by the Card, including reads and writes. : x4 c=
ard is plugged in to slot 3",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; ITOM misses from local IO",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOM",
+        "BriefDescription": "Write request of 4 bytes made by IIO Part0 to=
 Memory",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00cc43fe04",
-        "UMaskExt": "0x00cc43fe",
-        "Unit": "CHA"
+        "PortMask": "0x0001",
+        "PublicDescription": "Data requested of the CPU : Card writing to =
DRAM : Number of DWs (4 bytes) the card requests of the main die.    Includ=
es all requests initiated by the Card, including reads and writes. : x16 ca=
rd plugged in to stack, Or x8 card plugged in to Lane 0/1, Or x4 card is pl=
ugged in to slot 0",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy : IRQ - iA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IRQ_IA",
+        "BriefDescription": "Write request of 4 bytes made by IIO Part1 to=
 Memory",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "CHA"
+        "PortMask": "0x0002",
+        "PublicDescription": "Data requested of the CPU : Card writing to =
DRAM : Number of DWs (4 bytes) the card requests of the main die.    Includ=
es all requests initiated by the Card, including reads and writes. : x4 car=
d is plugged in to slot 1",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy : SF/LLC Evictions",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.EVICT",
+        "BriefDescription": "Write request of 4 bytes made by IIO Part2 to=
 Memory",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
-        "Unit": "CHA"
+        "PortMask": "0x0004",
+        "PublicDescription": "Data requested of the CPU : Card writing to =
DRAM : Number of DWs (4 bytes) the card requests of the main die.    Includ=
es all requests initiated by the Card, including reads and writes. : x8 car=
d plugged in to Lane 2/3, Or x4 card is plugged in to slot 1",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy : PRQ - IOSF",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.PRQ",
+        "BriefDescription": "Write request of 4 bytes made by IIO Part3 to=
 Memory",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "CHA"
+        "PortMask": "0x0008",
+        "PublicDescription": "Data requested of the CPU : Card writing to =
DRAM : Number of DWs (4 bytes) the card requests of the main die.    Includ=
es all requests initiated by the Card, including reads and writes. : x4 car=
d is plugged in to slot 3",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy : IPQ",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IPQ",
+        "BriefDescription": "Data requested of the CPU : Card writing to D=
RAM",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART4",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x0000000008",
-        "UMaskExt": "0x00000000",
-        "Unit": "CHA"
+        "PortMask": "0x0010",
+        "PublicDescription": "Data requested of the CPU : Card writing to =
DRAM : Number of DWs (4 bytes) the card requests of the main die.    Includ=
es all requests initiated by the Card, including reads and writes. : x16 ca=
rd plugged in to stack, Or x8 card plugged in to Lane 0/1, Or x4 card is pl=
ugged in to slot 0",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy : IRQ - Non iA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IRQ_NON_IA",
+        "BriefDescription": "Data requested of the CPU : Card writing to D=
RAM",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART5",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x0000000010",
-        "UMaskExt": "0x00000000",
-        "Unit": "CHA"
+        "PortMask": "0x0020",
+        "PublicDescription": "Data requested of the CPU : Card writing to =
DRAM : Number of DWs (4 bytes) the card requests of the main die.    Includ=
es all requests initiated by the Card, including reads and writes. : x4 car=
d is plugged in to slot 1",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy : PRQ - Non IOSF",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.PRQ_NON_IOSF",
+        "BriefDescription": "Data requested of the CPU : Card writing to D=
RAM",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART6",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x0000000020",
-        "UMaskExt": "0x00000000",
-        "Unit": "CHA"
+        "PortMask": "0x0040",
+        "PublicDescription": "Data requested of the CPU : Card writing to =
DRAM : Number of DWs (4 bytes) the card requests of the main die.    Includ=
es all requests initiated by the Card, including reads and writes. : x8 car=
d plugged in to Lane 2/3, Or x4 card is plugged in to slot 1",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy : RRQ",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.RRQ",
+        "BriefDescription": "Data requested of the CPU : Card writing to D=
RAM",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART7",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x0000000040",
-        "UMaskExt": "0x00000000",
-        "Unit": "CHA"
+        "PortMask": "0x0080",
+        "PublicDescription": "Data requested of the CPU : Card writing to =
DRAM : Number of DWs (4 bytes) the card requests of the main die.    Includ=
es all requests initiated by the Card, including reads and writes. : x4 car=
d is plugged in to slot 3",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy : WBQ",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.WBQ",
+        "BriefDescription": "Peer to peer write request of 4 bytes made by=
 IIO Part0 to an IIO target",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART0",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x0000000080",
-        "UMaskExt": "0x00000000",
-        "Unit": "CHA"
+        "PortMask": "0x0001",
+        "PublicDescription": "Data requested of the CPU : Card writing to =
another Card (same or different stack) : Number of DWs (4 bytes) the card r=
equests of the main die.    Includes all requests initiated by the Card, in=
cluding reads and writes. : x16 card plugged in to stack, Or x8 card plugge=
d in to Lane 0/1, Or x4 card is plugged in to slot 0",
+        "UMask": "0x2",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy : All from Local IO",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.LOC_IO",
+        "BriefDescription": "Peer to peer write request of 4 bytes made by=
 IIO Part0 to an IIO target",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART1",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00C000FF04",
-        "UMaskExt": "0x00C000FF",
-        "Unit": "CHA"
+        "PortMask": "0x0002",
+        "PublicDescription": "Data requested of the CPU : Card writing to =
another Card (same or different stack) : Number of DWs (4 bytes) the card r=
equests of the main die.    Includes all requests initiated by the Card, in=
cluding reads and writes. : x4 card is plugged in to slot 1",
+        "UMask": "0x2",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy : All from Local iA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.LOC_IA",
+        "BriefDescription": "Peer to peer write request of 4 bytes made by=
 IIO Part0 to an IIO target",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART2",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00C000FF01",
-        "UMaskExt": "0x00C000FF",
-        "Unit": "CHA"
+        "PortMask": "0x0004",
+        "PublicDescription": "Data requested of the CPU : Card writing to =
another Card (same or different stack) : Number of DWs (4 bytes) the card r=
equests of the main die.    Includes all requests initiated by the Card, in=
cluding reads and writes. : x8 card plugged in to Lane 2/3, Or x4 card is p=
lugged in to slot 1",
+        "UMask": "0x2",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy : All from Local iA and IO",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.LOC_ALL",
+        "BriefDescription": "Peer to peer write request of 4 bytes made by=
 IIO Part0 to an IIO target",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART3",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00C000FF05",
-        "UMaskExt": "0x00C000FF",
-        "Unit": "CHA"
+        "PortMask": "0x0008",
+        "PublicDescription": "Data requested of the CPU : Card writing to =
another Card (same or different stack) : Number of DWs (4 bytes) the card r=
equests of the main die.    Includes all requests initiated by the Card, in=
cluding reads and writes. : x4 card is plugged in to slot 3",
+        "UMask": "0x2",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy : All Snoops from Remote",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.REM_SNPS",
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART4",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00C001FF08",
-        "UMaskExt": "0x00C001FF",
-        "Unit": "CHA"
+        "PortMask": "0x0010",
+        "PublicDescription": "Data requested of the CPU : Card writing to =
another Card (same or different stack) : Number of DWs (4 bytes) the card r=
equests of the main die.    Includes all requests initiated by the Card, in=
cluding reads and writes. : x16 card plugged in to stack, Or x8 card plugge=
d in to Lane 0/1, Or x4 card is plugged in to slot 0",
+        "UMask": "0x2",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy : All from Remote",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.REM_ALL",
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART5",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00C001FFC8",
-        "UMaskExt": "0x00C001FF",
-        "Unit": "CHA"
+        "PortMask": "0x0020",
+        "PublicDescription": "Data requested of the CPU : Card writing to =
another Card (same or different stack) : Number of DWs (4 bytes) the card r=
equests of the main die.    Includes all requests initiated by the Card, in=
cluding reads and writes. : x4 card is plugged in to slot 1",
+        "UMask": "0x2",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy : Just Hits",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.HIT",
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART6",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMaskExt": "0x00000001",
-        "Unit": "CHA"
+        "PortMask": "0x0040",
+        "PublicDescription": "Data requested of the CPU : Card writing to =
another Card (same or different stack) : Number of DWs (4 bytes) the card r=
equests of the main die.    Includes all requests initiated by the Card, in=
cluding reads and writes. : x8 card plugged in to Lane 2/3, Or x4 card is p=
lugged in to slot 1",
+        "UMask": "0x2",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy : Just Misses",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.MISS",
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART7",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMaskExt": "0x00000002",
-        "Unit": "CHA"
+        "PortMask": "0x0080",
+        "PublicDescription": "Data requested of the CPU : Card writing to =
another Card (same or different stack) : Number of DWs (4 bytes) the card r=
equests of the main die.    Includes all requests initiated by the Card, in=
cluding reads and writes. : x4 card is plugged in to slot 3",
+        "UMask": "0x2",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy : MMCFG Access",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.MMCFG",
+        "BriefDescription": ": Context cache hits",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.CTXT_CACHE_HITS",
         "PerPkg": "1",
-        "UMaskExt": "0x00000020",
-        "Unit": "CHA"
+        "PortMask": "0x0000",
+        "PublicDescription": ": Context cache hits : Counts each time a fi=
rst look up of the transaction hits the RCC.",
+        "UMask": "0x80",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy : MMIO Access",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.MMIO",
+        "BriefDescription": ": Context cache lookups",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.CTXT_CACHE_LOOKUPS",
         "PerPkg": "1",
-        "UMaskExt": "0x00000040",
-        "Unit": "CHA"
+        "PortMask": "0x0000",
+        "PublicDescription": ": Context cache lookups : Counts each time a=
 transaction looks up root context cache.",
+        "UMask": "0x40",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy : Just Local Targets",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.LOCAL_TGT",
+        "BriefDescription": ": IOTLB lookups first",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.FIRST_LOOKUPS",
         "PerPkg": "1",
-        "UMaskExt": "0x00000080",
-        "Unit": "CHA"
+        "PortMask": "0x0000",
+        "PublicDescription": ": IOTLB lookups first : Some transactions ha=
ve to look up IOTLB multiple times.  Counts the first time a request looks =
up IOTLB.",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy : Just Remote Targets",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.REMOTE_TGT",
+        "BriefDescription": "IOTLB Fills (same as IOTLB miss)",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.MISSES",
         "PerPkg": "1",
-        "UMaskExt": "0x00000100",
-        "Unit": "CHA"
+        "PortMask": "0x0000",
+        "PublicDescription": "IOTLB Fills (same as IOTLB miss) : When a tr=
ansaction misses IOTLB, it does a page walk to look up memory and bring in =
the relevant page translation. Counts when this page translation is written=
 to IOTLB.",
+        "UMask": "0x20",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy : Match the Opcode in b[29:19] =
of the extended umask field",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.MATCH_OPC",
+        "BriefDescription": ": IOMMU memory access",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.NUM_MEM_ACCESSES",
         "PerPkg": "1",
-        "UMaskExt": "0x00000200",
-        "Unit": "CHA"
+        "PublicDescription": ": IOMMU memory access : IOMMU sends out memo=
ry fetches when it misses the cache look up which is indicated by this sign=
al.  M2IOSF only uses low priority channel",
+        "UMask": "0xc0",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy : Match the PreMorphed Opcode i=
n b[29:19] of the extended umask field",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.PREMORPH_OPC",
+        "BriefDescription": ": PWC Hit to a 2M page",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.PWC_1G_HITS",
         "PerPkg": "1",
-        "UMaskExt": "0x00000400",
-        "Unit": "CHA"
+        "PublicDescription": ": PWC Hit to a 2M page : Counts each time a =
transaction's first look up hits the SLPWC at the 2M level",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy : Just NonCoherent",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.NONCOH",
+        "BriefDescription": ": PWT Hit to a 256T page",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.PWC_256T_HITS",
         "PerPkg": "1",
-        "UMaskExt": "0x01000000",
-        "Unit": "CHA"
+        "PublicDescription": ": PWT Hit to a 256T page : Counts each time =
a transaction's first look up hits the SLPWC at the 512G level",
+        "UMask": "0x10",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy : Just ISOC",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.ISOC",
+        "BriefDescription": ": PWC Hit to a 4K page",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.PWC_2M_HITS",
         "PerPkg": "1",
-        "UMaskExt": "0x02000000",
-        "Unit": "CHA"
+        "PublicDescription": ": PWC Hit to a 4K page : Counts each time a =
transaction's first look up hits the SLPWC at the 4K level",
+        "UMask": "0x2",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; CRd Pref hits from local IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CRD_PREF",
+        "BriefDescription": ": PWC Hit to a 1G page",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.PWC_512G_HITS",
         "PerPkg": "1",
-        "UMask": "0x00c88ffd01",
-        "UMaskExt": "0x00c88ffd",
-        "Unit": "CHA"
+        "PublicDescription": ": PWC Hit to a 1G page : Counts each time a =
transaction's first look up hits the SLPWC at the 1G level",
+        "UMask": "0x8",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; DRd Pref hits from local IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD_PREF",
+        "BriefDescription": ": Global IOTLB invalidation cycles",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.PWT_OCCUPANCY_MSB",
         "PerPkg": "1",
-        "UMask": "0x00c897fd01",
-        "UMaskExt": "0x00c897fd",
-        "Unit": "CHA"
+        "PortMask": "0x0000",
+        "PublicDescription": ": Global IOTLB invalidation cycles : Indicat=
es that IOMMU is doing global invalidation.",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; DRd Opt hits from local IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD_OPT",
+        "BriefDescription": "PWT occupancy.  Does not include 9th bit of o=
ccupancy (will undercount if PWT is greater than 255 per cycle).",
+        "EventCode": "0x42",
+        "EventName": "UNC_IIO_PWT_OCCUPANCY",
         "PerPkg": "1",
-        "UMask": "0x00c827fd01",
-        "UMaskExt": "0x00c827fd",
-        "Unit": "CHA"
+        "PortMask": "0x0000",
+        "PublicDescription": "PWT occupancy : Indicates how many page walk=
s are outstanding at any point in time.",
+        "UMask": "0xff",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; DRd Opt Pref hits from local I=
A",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD_OPT_PREF",
+        "BriefDescription": "Read request for up to a 64 byte transaction =
is made by the CPU to IIO Part0",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART0",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c8a7fd01",
-        "UMaskExt": "0x00c8a7fd",
-        "Unit": "CHA"
+        "PortMask": "0x0001",
+        "PublicDescription": "Number Transactions requested by the CPU : C=
ore reading from Card's MMIO space : Also known as Outbound.  Number of req=
uests initiated by the main die, including reads and writes. : x16 card plu=
gged in to stack, Or x8 card plugged in to Lane 0/1, Or x4 card is plugged =
in to slot 0",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; RFO Pref hits from local IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO_PREF",
+        "BriefDescription": "Read request for up to a 64 byte transaction =
is made by the CPU to IIO Part1",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART1",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c887fd01",
-        "UMaskExt": "0x00c887fd",
-        "Unit": "CHA"
+        "PortMask": "0x0002",
+        "PublicDescription": "Number Transactions requested by the CPU : C=
ore reading from Card's MMIO space : Also known as Outbound.  Number of req=
uests initiated by the main die, including reads and writes. : x4 card is p=
lugged in to slot 1",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; CRd Pref misses from local IA"=
,
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_PREF",
+        "BriefDescription": "Read request for up to a 64 byte transaction =
is made by the CPU to IIO Part2",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART2",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c88ffe01",
-        "UMaskExt": "0x00c88ffe",
-        "Unit": "CHA"
+        "PortMask": "0x0004",
+        "PublicDescription": "Number Transactions requested by the CPU : C=
ore reading from Card's MMIO space : Also known as Outbound.  Number of req=
uests initiated by the main die, including reads and writes. : x8 card plug=
ged in to Lane 2/3, Or x4 card is plugged in to slot 1",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; DRd Pref misses from local IA"=
,
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF",
+        "BriefDescription": "Read request for up to a 64 byte transaction =
is made by the CPU to IIO Part3",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART3",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c897fe01",
-        "UMaskExt": "0x00c897fe",
-        "Unit": "CHA"
+        "PortMask": "0x0008",
+        "PublicDescription": "Number Transactions requested by the CPU : C=
ore reading from Card's MMIO space : Also known as Outbound.  Number of req=
uests initiated by the main die, including reads and writes. : x4 card is p=
lugged in to slot 3",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; DRd Opt misses from local IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT",
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART4",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c827fe01",
-        "UMaskExt": "0x00c827fe",
-        "Unit": "CHA"
+        "PortMask": "0x0010",
+        "PublicDescription": "Number Transactions requested by the CPU : C=
ore reading from Cards MMIO space : Also known as Outbound.  Number of requ=
ests initiated by the main die, including reads and writes. : x16 card plug=
ged in to stack, Or x8 card plugged in to Lane 0/1, Or x4 card is plugged i=
n to slot 0",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; DRd Opt Pref misses from local=
 IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT_PREF",
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART5",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c8a7fe01",
-        "UMaskExt": "0x00c8a7fe",
-        "Unit": "CHA"
+        "PortMask": "0x0020",
+        "PublicDescription": "Number Transactions requested by the CPU : C=
ore reading from Cards MMIO space : Also known as Outbound.  Number of requ=
ests initiated by the main die, including reads and writes. : x4 card is pl=
ugged in to slot 1",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; RFO prefetch misses from local=
 IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF",
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART6",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c887fe01",
-        "UMaskExt": "0x00c887fe",
-        "Unit": "CHA"
+        "PortMask": "0x0040",
+        "PublicDescription": "Number Transactions requested by the CPU : C=
ore reading from Cards MMIO space : Also known as Outbound.  Number of requ=
ests initiated by the main die, including reads and writes. : x8 card plugg=
ed in to Lane 2/3, Or x4 card is plugged in to slot 1",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; ITOM hits from local IO",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT_ITOM",
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART7",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00cc43fd04",
-        "UMaskExt": "0x00cc43fd",
-        "Unit": "CHA"
+        "PortMask": "0x0080",
+        "PublicDescription": "Number Transactions requested by the CPU : C=
ore reading from Cards MMIO space : Also known as Outbound.  Number of requ=
ests initiated by the main die, including reads and writes. : x4 card is pl=
ugged in to slot 3",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; RFO hits from local IO",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT_RFO",
+        "BriefDescription": "Write request of up to a 64 byte transaction =
is made to IIO Part0 by the CPU",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c803fd04",
-        "UMaskExt": "0x00c803fd",
-        "Unit": "CHA"
+        "PortMask": "0x0001",
+        "PublicDescription": "Number Transactions requested by the CPU : C=
ore writing to Card's MMIO space : Also known as Outbound.  Number of reque=
sts initiated by the main die, including reads and writes. : x16 card plugg=
ed in to stack, Or x8 card plugged in to Lane 0/1, Or x4 card is plugged in=
 to slot 0",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; ItoM from local IO",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_RFO",
+        "BriefDescription": "Write request of up to a 64 byte transaction =
is made to IIO Part1 by the CPU",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART1",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c803ff04",
-        "UMaskExt": "0x00c803ff",
-        "Unit": "CHA"
+        "PortMask": "0x0002",
+        "PublicDescription": "Number Transactions requested by the CPU : C=
ore writing to Card's MMIO space : Also known as Outbound.  Number of reque=
sts initiated by the main die, including reads and writes. : x4 card is plu=
gged in to slot 1",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; ITOM from local IO",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_ITOM",
+        "BriefDescription": "Write request of up to a 64 byte transaction =
is made to IIO Part2 by the CPU",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART2",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00cc43ff04",
-        "UMaskExt": "0x00cc43ff",
-        "Unit": "CHA"
+        "PortMask": "0x0004",
+        "PublicDescription": "Number Transactions requested by the CPU : C=
ore writing to Card's MMIO space : Also known as Outbound.  Number of reque=
sts initiated by the main die, including reads and writes. : x8 card plugge=
d in to Lane 2/3, Or x4 card is plugged in to slot 1",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; RFO from local IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_RFO",
+        "BriefDescription": "Write request of up to a 64 byte transaction =
is made to IIO Part3 by the CPU",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART3",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c807ff01",
-        "UMaskExt": "0x00c807ff",
-        "Unit": "CHA"
+        "PortMask": "0x0008",
+        "PublicDescription": "Number Transactions requested by the CPU : C=
ore writing to Card's MMIO space : Also known as Outbound.  Number of reque=
sts initiated by the main die, including reads and writes. : x4 card is plu=
gged in to slot 3",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; RFO prefetch from local IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_RFO_PREF",
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART4",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c887ff01",
-        "UMaskExt": "0x00c887ff",
-        "Unit": "CHA"
+        "PortMask": "0x0010",
+        "PublicDescription": "Number Transactions requested by the CPU : C=
ore writing to Cards MMIO space : Also known as Outbound.  Number of reques=
ts initiated by the main die, including reads and writes. : x16 card plugge=
d in to stack, Or x8 card plugged in to Lane 0/1, Or x4 card is plugged in =
to slot 0",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; LLCPrefRFO from local IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_LLCPREFRFO",
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART5",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00ccc7ff01",
-        "UMaskExt": "0x00ccc7ff",
-        "Unit": "CHA"
+        "PortMask": "0x0020",
+        "PublicDescription": "Number Transactions requested by the CPU : C=
ore writing to Cards MMIO space : Also known as Outbound.  Number of reques=
ts initiated by the main die, including reads and writes. : x4 card is plug=
ged in to slot 1",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; DRd from local IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_DRD",
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART6",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c817ff01",
-        "UMaskExt": "0x00c817ff",
-        "Unit": "CHA"
+        "PortMask": "0x0040",
+        "PublicDescription": "Number Transactions requested by the CPU : C=
ore writing to Cards MMIO space : Also known as Outbound.  Number of reques=
ts initiated by the main die, including reads and writes. : x8 card plugged=
 in to Lane 2/3, Or x4 card is plugged in to slot 1",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; DRd Opt from local IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_DRD_OPT",
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART7",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c827ff01",
-        "UMaskExt": "0x00c827ff",
-        "Unit": "CHA"
+        "PortMask": "0x0080",
+        "PublicDescription": "Number Transactions requested by the CPU : C=
ore writing to Cards MMIO space : Also known as Outbound.  Number of reques=
ts initiated by the main die, including reads and writes. : x4 card is plug=
ged in to slot 3",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; DRd Opt Pref from local IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_DRD_OPT_PREF",
+        "BriefDescription": "Read request for up to a 64 byte transaction =
is made by IIO Part0 to Memory",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART0",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c8a7ff01",
-        "UMaskExt": "0x00c8a7ff",
-        "Unit": "CHA"
+        "PortMask": "0x0001",
+        "PublicDescription": "Number Transactions requested of the CPU : C=
ard reading from DRAM : Also known as Inbound.  Number of 64B cache line re=
quests initiated by the Card, including reads and writes. : x16 card plugge=
d in to stack, Or x8 card plugged in to Lane 0/1, Or x4 card is plugged in =
to slot 0",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; CRd from local IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_CRD",
+        "BriefDescription": "Read request for up to a 64 byte transaction =
is  made by IIO Part1 to Memory",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART1",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c80fff01",
-        "UMaskExt": "0x00c80fff",
-        "Unit": "CHA"
+        "PortMask": "0x0002",
+        "PublicDescription": "Number Transactions requested of the CPU : C=
ard reading from DRAM : Also known as Inbound.  Number of 64B cache line re=
quests initiated by the Card, including reads and writes. : x4 card is plug=
ged in to slot 1",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; CRd Pref from local IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_CRD_PREF",
+        "BriefDescription": "Read request for up to a 64 byte transaction =
is made by IIO Part2 to Memory",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART2",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c88fff01",
-        "UMaskExt": "0x00c88fff",
-        "Unit": "CHA"
+        "PortMask": "0x0004",
+        "PublicDescription": "Number Transactions requested of the CPU : C=
ard reading from DRAM : Also known as Inbound.  Number of 64B cache line re=
quests initiated by the Card, including reads and writes. : x8 card plugged=
 in to Lane 2/3, Or x4 card is plugged in to slot 1",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; DRd Pref from local IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_DRD_PREF",
+        "BriefDescription": "Read request for up to a 64 byte transaction =
is made by IIO Part3 to Memory",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART3",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c897ff01",
-        "UMaskExt": "0x00c897ff",
-        "Unit": "CHA"
+        "PortMask": "0x0008",
+        "PublicDescription": "Number Transactions requested of the CPU : C=
ard reading from DRAM : Also known as Inbound.  Number of 64B cache line re=
quests initiated by the Card, including reads and writes. : x4 card is plug=
ged in to slot 3",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; DRd Pref misses from local IA"=
,
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_LOCAL",
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART4",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00C896FE01",
-        "UMaskExt": "0x00C896FE",
-        "Unit": "CHA"
+        "PortMask": "0x0010",
+        "PublicDescription": "Number Transactions requested of the CPU : C=
ard reading from DRAM : Also known as Inbound.  Number of 64B cache line re=
quests initiated by the Card, including reads and writes. : x16 card plugge=
d in to stack, Or x8 card plugged in to Lane 0/1, Or x4 card is plugged in =
to slot 0",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; DRd Pref misses from local IA"=
,
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_REMOTE",
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART5",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00C8977E01",
-        "UMaskExt": "0x00C8977E",
-        "Unit": "CHA"
+        "PortMask": "0x0020",
+        "PublicDescription": "Number Transactions requested of the CPU : C=
ard reading from DRAM : Also known as Inbound.  Number of 64B cache line re=
quests initiated by the Card, including reads and writes. : x4 card is plug=
ged in to slot 1",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; RFO misses from local IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_LOCAL",
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART6",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c806fe01",
-        "UMaskExt": "0x00c806fe",
-        "Unit": "CHA"
+        "PortMask": "0x0040",
+        "PublicDescription": "Number Transactions requested of the CPU : C=
ard reading from DRAM : Also known as Inbound.  Number of 64B cache line re=
quests initiated by the Card, including reads and writes. : x8 card plugged=
 in to Lane 2/3, Or x4 card is plugged in to slot 1",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; RFO misses from local IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_REMOTE",
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART7",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c8077e01",
-        "UMaskExt": "0x00c8077e",
-        "Unit": "CHA"
+        "PortMask": "0x0080",
+        "PublicDescription": "Number Transactions requested of the CPU : C=
ard reading from DRAM : Also known as Inbound.  Number of 64B cache line re=
quests initiated by the Card, including reads and writes. : x4 card is plug=
ged in to slot 3",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; RFO prefetch misses from local=
 IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF_LOCAL",
+        "BriefDescription": "Write request of up to a 64 byte transaction =
is made by IIO Part0 to Memory",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c886fe01",
-        "UMaskExt": "0x00c886fe",
-        "Unit": "CHA"
+        "PortMask": "0x0001",
+        "PublicDescription": "Number Transactions requested of the CPU : C=
ard writing to DRAM : Also known as Inbound.  Number of 64B cache line requ=
ests initiated by the Card, including reads and writes. : x16 card plugged =
in to stack, Or x8 card plugged in to Lane 0/1, Or x4 card is plugged in to=
 slot 0",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; RFO prefetch misses from local=
 IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF_REMOTE",
+        "BriefDescription": "Write request of up to a 64 byte transaction =
is made by IIO Part1 to Memory",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART1",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c8877e01",
-        "UMaskExt": "0x00c8877e",
-        "Unit": "CHA"
+        "PortMask": "0x0002",
+        "PublicDescription": "Number Transactions requested of the CPU : C=
ard writing to DRAM : Also known as Inbound.  Number of 64B cache line requ=
ests initiated by the Card, including reads and writes. : x4 card is plugge=
d in to slot 1",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "All LLC lines in E state that are victimized =
on a fill",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x37",
-        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_E",
+        "BriefDescription": "Write request of up to a 64 byte transaction =
is made by IIO Part2 to Memory",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART2",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x0000000002",
-        "UMaskExt": "0x00000000",
-        "Unit": "CHA"
+        "PortMask": "0x0004",
+        "PublicDescription": "Number Transactions requested of the CPU : C=
ard writing to DRAM : Also known as Inbound.  Number of 64B cache line requ=
ests initiated by the Card, including reads and writes. : x8 card plugged i=
n to Lane 2/3, Or x4 card is plugged in to slot 1",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "All LLC lines in M state that are victimized =
on a fill",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x37",
-        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_M",
+        "BriefDescription": "Write request of up to a 64 byte transaction =
is made by IIO Part3 to Memory",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART3",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x0000000001",
-        "UMaskExt": "0x00000000",
-        "Unit": "CHA"
+        "PortMask": "0x0008",
+        "PublicDescription": "Number Transactions requested of the CPU : C=
ard writing to DRAM : Also known as Inbound.  Number of 64B cache line requ=
ests initiated by the Card, including reads and writes. : x4 card is plugge=
d in to slot 3",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "All LLC lines in S state that are victimized =
on a fill",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x37",
-        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_S",
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART4",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x0000000004",
-        "UMaskExt": "0x00000000",
-        "Unit": "CHA"
+        "PortMask": "0x0010",
+        "PublicDescription": "Number Transactions requested of the CPU : C=
ard writing to DRAM : Also known as Inbound.  Number of 64B cache line requ=
ests initiated by the Card, including reads and writes. : x16 card plugged =
in to stack, Or x8 card plugged in to Lane 0/1, Or x4 card is plugged in to=
 slot 0",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Inserts : ItoMCacheNears, indicating a pa=
rtial write request, from IO Devices that hit the LLC",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_ITOMCACHENEAR",
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART5",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00cd43fd04",
-        "UMaskExt": "0x00cd43fd",
-        "Unit": "CHA"
+        "PortMask": "0x0020",
+        "PublicDescription": "Number Transactions requested of the CPU : C=
ard writing to DRAM : Also known as Inbound.  Number of 64B cache line requ=
ests initiated by the Card, including reads and writes. : x4 card is plugge=
d in to slot 1",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Inserts : ItoMCacheNears, indicating a pa=
rtial write request, from IO Devices that missed the LLC",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOMCACHENEAR",
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART6",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00cd43fe04",
-        "UMaskExt": "0x00cd43fe",
-        "Unit": "CHA"
+        "PortMask": "0x0040",
+        "PublicDescription": "Number Transactions requested of the CPU : C=
ard writing to DRAM : Also known as Inbound.  Number of 64B cache line requ=
ests initiated by the Card, including reads and writes. : x8 card plugged i=
n to Lane 2/3, Or x4 card is plugged in to slot 1",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Inserts : DRd PTEs issued by iA Cores tha=
t Missed the LLC",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRDPTE",
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART7",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c837fe01",
-        "UMaskExt": "0x00c837fe",
-        "Unit": "CHA"
+        "PortMask": "0x0080",
+        "PublicDescription": "Number Transactions requested of the CPU : C=
ard writing to DRAM : Also known as Inbound.  Number of 64B cache line requ=
ests initiated by the Card, including reads and writes. : x4 card is plugge=
d in to slot 3",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Inserts : DRd PTEs issued by iA Cores tha=
t Hit the LLC",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRDPTE",
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART0",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c837fd01",
-        "UMaskExt": "0x00c837fd",
-        "Unit": "CHA"
+        "PortMask": "0x0001",
+        "PublicDescription": "Number Transactions requested of the CPU : C=
ard writing to another Card (same or different stack) : Also known as Inbou=
nd.  Number of 64B cache line requests initiated by the Card, including rea=
ds and writes. : x16 card plugged in to Lane 0/1/2/3, Or x8 card plugged in=
 to Lane 0/1, Or x4 card is plugged in to slot 0",
+        "UMask": "0x2",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Inserts : DRd PTEs issued by iA Cores",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_DRDPTE",
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART1",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c837ff01",
-        "UMaskExt": "0x00c837ff",
-        "Unit": "CHA"
+        "PortMask": "0x0002",
+        "PublicDescription": "Number Transactions requested of the CPU : C=
ard writing to another Card (same or different stack) : Also known as Inbou=
nd.  Number of 64B cache line requests initiated by the Card, including rea=
ds and writes. : x4 card is plugged in to slot 1",
+        "UMask": "0x2",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Inserts : WBEFtoEs issued by an IA Core. =
 Non Modified Write Backs",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_WBEFTOE",
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART2",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0xcc3fff01",
-        "UMaskExt": "0xcc3fff",
-        "Unit": "CHA"
+        "PortMask": "0x0004",
+        "PublicDescription": "Number Transactions requested of the CPU : C=
ard writing to another Card (same or different stack) : Also known as Inbou=
nd.  Number of 64B cache line requests initiated by the Card, including rea=
ds and writes. : x8 card plugged in to Lane 2/3, Or x4 card is plugged in t=
o slot 2",
+        "UMask": "0x2",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Inserts; RdCur and FsRdCur hits from loca=
l IO",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_PCIRDCUR",
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART3",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c8f3fd04",
-        "UMaskExt": "0x00c8f3fd",
-        "Unit": "CHA"
+        "PortMask": "0x0008",
+        "PublicDescription": "Number Transactions requested of the CPU : C=
ard writing to another Card (same or different stack) : Also known as Inbou=
nd.  Number of 64B cache line requests initiated by the Card, including rea=
ds and writes. : x4 card is plugged in to slot 3",
+        "UMask": "0x2",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Inserts; RdCur and FsRdCur misses from lo=
cal IO",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_PCIRDCUR",
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART4",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c8f3fe04",
-        "UMaskExt": "0x00c8f3fe",
-        "Unit": "CHA"
+        "PortMask": "0x0010",
+        "PublicDescription": "Number Transactions requested of the CPU : C=
ard writing to another Card (same or different stack) : Also known as Inbou=
nd.  Number of 64B cache line requests initiated by the Card, including rea=
ds and writes. : x16 card plugged in to Lane 4/5/6/7, Or x8 card plugged in=
 to Lane 4/5, Or x4 card is plugged in to slot 4",
+        "UMask": "0x2",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; RdCur and FsRdCur hits from lo=
cal IO",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT_PCIRDCUR",
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART5",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c8f3fd04",
-        "UMaskExt": "0x00c8f3fd",
-        "Unit": "CHA"
+        "PortMask": "0x0020",
+        "PublicDescription": "Number Transactions requested of the CPU : C=
ard writing to another Card (same or different stack) : Also known as Inbou=
nd.  Number of 64B cache line requests initiated by the Card, including rea=
ds and writes. : x4 card is plugged in to slot 5",
+        "UMask": "0x2",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; RdCur and FsRdCur misses from =
local IO",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_PCIRDCUR",
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART6",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c8f3fe04",
-        "UMaskExt": "0x00c8f3fe",
-        "Unit": "CHA"
+        "PortMask": "0x0040",
+        "PublicDescription": "Number Transactions requested of the CPU : C=
ard writing to another Card (same or different stack) : Also known as Inbou=
nd.  Number of 64B cache line requests initiated by the Card, including rea=
ds and writes. : x8 card plugged in to Lane 6/7, Or x4 card is plugged in t=
o slot 6",
+        "UMask": "0x2",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "TOR Occupancy; RdCur and FsRdCur from local I=
O",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_PCIRDCUR",
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART7",
+        "FCMask": "0x07",
         "PerPkg": "1",
-        "UMask": "0x00c8f3ff04",
-        "UMaskExt": "0x00c8f3ff",
-        "Unit": "CHA"
+        "PortMask": "0x0080",
+        "PublicDescription": "Number Transactions requested of the CPU : C=
ard writing to another Card (same or different stack) : Also known as Inbou=
nd.  Number of 64B cache line requests initiated by the Card, including rea=
ds and writes. : x4 card is plugged in to slot 7",
+        "UMask": "0x2",
+        "Unit": "IIO"
     },
-    {
-        "BriefDescription": "TOR Inserts; LLCPrefCode hits from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LLCPREFCODE",
+    {
+        "BriefDescription": "IRP Clockticks",
+        "EventCode": "0x01",
+        "EventName": "UNC_I_CLOCKTICKS",
         "PerPkg": "1",
-        "UMask": "0x00cccffd01",
-        "UMaskExt": "0x00cccffd",
-        "Unit": "CHA"
+        "PublicDescription": "Number of IRP clock cycles while the event i=
s enabled",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "TOR Inserts; LLCPrefData hits from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LLCPREFDATA",
+        "BriefDescription": "FAF - request insert from TC.",
+        "EventCode": "0x18",
+        "EventName": "UNC_I_FAF_INSERTS",
         "PerPkg": "1",
-        "UMask": "0x00ccd7fd01",
-        "UMaskExt": "0x00ccd7fd",
-        "Unit": "CHA"
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "TOR Inserts; LLCPrefData from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_LLCPREFDATA",
+        "BriefDescription": "FAF occupancy",
+        "EventCode": "0x19",
+        "EventName": "UNC_I_FAF_OCCUPANCY",
         "PerPkg": "1",
-        "UMask": "0x00ccd7ff01",
-        "UMaskExt": "0x00ccd7ff",
-        "Unit": "CHA"
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "TOR Inserts; LLCPrefCode misses from local IA=
",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFCODE",
+        "BriefDescription": "FAF allocation -- sent to ADQ",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_FAF_TRANSACTIONS",
         "PerPkg": "1",
-        "UMask": "0x00cccffe01",
-        "UMaskExt": "0x00cccffe",
-        "Unit": "CHA"
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "TOR Inserts; LLCPrefData misses from local IA=
",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFDATA",
+        "BriefDescription": ": All Inserts Inbound (p2p + faf + cset)",
+        "EventCode": "0x20",
+        "EventName": "UNC_I_IRP_ALL.INBOUND_INSERTS",
         "PerPkg": "1",
-        "UMask": "0x00ccd7fe01",
-        "UMaskExt": "0x00ccd7fe",
-        "Unit": "CHA"
+        "UMask": "0x1",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "TOR Occupancy; LLCPrefCode hits from local IA=
",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LLCPREFCODE",
+        "BriefDescription": "Misc Events - Set 1 : Lost Forward",
+        "EventCode": "0x1f",
+        "EventName": "UNC_I_MISC1.LOST_FWD",
         "PerPkg": "1",
-        "UMask": "0x00cccffd01",
-        "UMaskExt": "0x00cccffd",
-        "Unit": "CHA"
+        "PublicDescription": "Misc Events - Set 1 : Lost Forward : Snoop p=
ulled away ownership before a write was committed",
+        "UMask": "0x10",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "TOR Occupancy; LLCPrefData hits from local IA=
",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LLCPREFDATA",
+        "BriefDescription": "Inbound write (fast path) requests received b=
y the IRP.",
+        "EventCode": "0x11",
+        "EventName": "UNC_I_TRANSACTIONS.WR_PREF",
         "PerPkg": "1",
-        "UMask": "0x00ccd7fd01",
-        "UMaskExt": "0x00ccd7fd",
-        "Unit": "CHA"
+        "PublicDescription": "Inbound write (fast path) requests to cohere=
nt memory, received by the IRP resulting in write ownership requests issued=
 by IRP to the mesh.",
+        "UMask": "0x8",
+        "Unit": "IRP"
     },
     {
-        "BriefDescription": "TOR Occupancy; LLCPrefData from local IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_LLCPREFDATA",
+        "BriefDescription": "M2M Clockticks",
+        "EventCode": "0x01",
+        "EventName": "UNC_M2M_CLOCKTICKS",
         "PerPkg": "1",
-        "UMask": "0x00ccd7ff01",
-        "UMaskExt": "0x00ccd7ff",
-        "Unit": "CHA"
+        "PublicDescription": "Clockticks of the mesh to memory (M2M)",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Occupancy; LLCPrefCode misses from local =
IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFCODE",
+        "BriefDescription": "Cycles when direct to core mode (which bypass=
es the CHA) was disabled",
+        "EventCode": "0x17",
+        "EventName": "UNC_M2M_DIRECT2CORE_NOT_TAKEN_DIRSTATE",
         "PerPkg": "1",
-        "UMask": "0x00cccffe01",
-        "UMaskExt": "0x00cccffe",
-        "Unit": "CHA"
+        "UMask": "0x7",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Occupancy; LLCPrefData misses from local =
IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFDATA",
+        "BriefDescription": "Messages sent direct to core (bypassing the C=
HA)",
+        "EventCode": "0x16",
+        "EventName": "UNC_M2M_DIRECT2CORE_TAKEN",
         "PerPkg": "1",
-        "UMask": "0x00ccd7fe01",
-        "UMaskExt": "0x00ccd7fe",
-        "Unit": "CHA"
+        "UMask": "0x7",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts; LLCPrefCode from local IA",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_LLCPREFCODE",
+        "BriefDescription": "Number of reads in which direct to core trans=
action were overridden",
+        "EventCode": "0x18",
+        "EventName": "UNC_M2M_DIRECT2CORE_TXN_OVERRIDE",
         "PerPkg": "1",
-        "UMask": "0x00cccfff01",
-        "UMaskExt": "0x00cccfff",
-        "Unit": "CHA"
+        "UMask": "0x3",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Occupancy; LLCPrefCode from local IA",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_LLCPREFCODE",
+        "BriefDescription": "Number of reads in which direct to Intel UPI =
transactions were overridden",
+        "EventCode": "0x1b",
+        "EventName": "UNC_M2M_DIRECT2UPI_NOT_TAKEN_CREDITS",
         "PerPkg": "1",
-        "UMask": "0x00cccfff01",
-        "UMaskExt": "0x00cccfff",
-        "Unit": "CHA"
+        "UMask": "0x7",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : DRds issued by iA Cores targeti=
ng PMM Mem that Missed the LLC - HOMed locally",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL_PMM",
+        "BriefDescription": "Cycles when direct to Intel UPI was disabled"=
,
+        "EventCode": "0x1a",
+        "EventName": "UNC_M2M_DIRECT2UPI_NOT_TAKEN_DIRSTATE",
         "PerPkg": "1",
-        "UMask": "0x00c8168a01",
-        "UMaskExt": "0x00c8168a",
-        "Unit": "CHA"
+        "UMask": "0x7",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : DRds issued by iA Cores targeti=
ng PMM Mem that Missed the LLC - HOMed remotely",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE_PMM",
+        "BriefDescription": "Messages sent direct to the Intel UPI",
+        "EventCode": "0x19",
+        "EventName": "UNC_M2M_DIRECT2UPI_TAKEN",
         "PerPkg": "1",
-        "UMask": "0x00c8170a01",
-        "UMaskExt": "0x00c8170a",
-        "Unit": "CHA"
+        "UMask": "0x7",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : DRds issued by iA Cores targeti=
ng DDR Mem that Missed the LLC - HOMed locally",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL_DDR",
+        "BriefDescription": "Number of reads that a message sent direct2 I=
ntel UPI was overridden",
+        "EventCode": "0x1c",
+        "EventName": "UNC_M2M_DIRECT2UPI_TXN_OVERRIDE",
         "PerPkg": "1",
-        "UMask": "0x00c8168601",
-        "UMaskExt": "0x00c81686",
-        "Unit": "CHA"
+        "UMask": "0x3",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : DRds issued by iA Cores targeti=
ng DDR Mem that Missed the LLC - HOMed remotely",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE_DDR",
+        "BriefDescription": "Multi-socket cacheline Directory lookups (any=
 state found)",
+        "EventCode": "0x20",
+        "EventName": "UNC_M2M_DIRECTORY_LOOKUP.ANY",
         "PerPkg": "1",
-        "UMask": "0x00c8170601",
-        "UMaskExt": "0x00c81706",
-        "Unit": "CHA"
+        "UMask": "0x1",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : DRd_Prefs issued by iA Cores ta=
rgeting PMM Mem that Missed the LLC",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_PMM",
+        "BriefDescription": "Multi-socket cacheline Directory lookups (cac=
heline found in A state)",
+        "EventCode": "0x20",
+        "EventName": "UNC_M2M_DIRECTORY_LOOKUP.STATE_A",
         "PerPkg": "1",
-        "UMask": "0x00C8978A01",
-        "UMaskExt": "0x00C8978A",
-        "Unit": "CHA"
+        "UMask": "0x8",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : DRd_Prefs issued by iA Cores ta=
rgeting PMM Mem that Missed the LLC - HOMed locally",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_LOCAL_PMM",
+        "BriefDescription": "Multi-socket cacheline Directory lookup (cach=
eline found in I state)",
+        "EventCode": "0x20",
+        "EventName": "UNC_M2M_DIRECTORY_LOOKUP.STATE_I",
         "PerPkg": "1",
-        "UMask": "0x00C8968A01",
-        "UMaskExt": "0x00C8968A",
-        "Unit": "CHA"
+        "UMask": "0x2",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : DRd_Prefs issued by iA Cores ta=
rgeting PMM Mem that Missed the LLC - HOMed remotely",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_REMOTE_PMM",
+        "BriefDescription": "Multi-socket cacheline Directory lookup (cach=
eline found in S state)",
+        "EventCode": "0x20",
+        "EventName": "UNC_M2M_DIRECTORY_LOOKUP.STATE_S",
         "PerPkg": "1",
-        "UMask": "0x00C8970A01",
-        "UMaskExt": "0x00C8970A",
-        "Unit": "CHA"
+        "UMask": "0x4",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : DRd_Prefs issued by iA Cores ta=
rgeting DDR Mem that Missed the LLC",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_DDR",
+        "BriefDescription": "Multi-socket cacheline Directory update from =
A to I",
+        "EventCode": "0x21",
+        "EventName": "UNC_M2M_DIRECTORY_UPDATE.A2I",
         "PerPkg": "1",
-        "UMask": "0x00C8978601",
-        "UMaskExt": "0x00C89786",
-        "Unit": "CHA"
+        "UMask": "0x320",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : DRd_Prefs issued by iA Cores ta=
rgeting DDR Mem that Missed the LLC - HOMed locally",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_LOCAL_DDR",
+        "BriefDescription": "Multi-socket cacheline Directory update from =
A to S",
+        "EventCode": "0x21",
+        "EventName": "UNC_M2M_DIRECTORY_UPDATE.A2S",
         "PerPkg": "1",
-        "UMask": "0x00C8968601",
-        "UMaskExt": "0x00C89686",
-        "Unit": "CHA"
+        "UMask": "0x340",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : DRd_Prefs issued by iA Cores ta=
rgeting DDR Mem that Missed the LLC - HOMed remotely",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_REMOTE_DDR",
+        "BriefDescription": "Multi-socket cacheline Directory update from/=
to Any state",
+        "EventCode": "0x21",
+        "EventName": "UNC_M2M_DIRECTORY_UPDATE.ANY",
         "PerPkg": "1",
-        "UMask": "0x00C8970601",
-        "UMaskExt": "0x00C89706",
-        "Unit": "CHA"
+        "UMask": "0x301",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : CRd issued by iA Cores that Mis=
sed the LLC - HOMed locally",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_LOCAL",
+        "BriefDescription": "Multi-socket cacheline Directory update from =
I to A",
+        "EventCode": "0x21",
+        "EventName": "UNC_M2M_DIRECTORY_UPDATE.I2A",
         "PerPkg": "1",
-        "UMask": "0x00C80EFE01",
-        "UMaskExt": "0x00C80EFE",
-        "Unit": "CHA"
+        "UMask": "0x304",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : CRd issued by iA Cores that Mis=
sed the LLC - HOMed remotely",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_REMOTE",
+        "BriefDescription": "Multi-socket cacheline Directory update from =
I to S",
+        "EventCode": "0x21",
+        "EventName": "UNC_M2M_DIRECTORY_UPDATE.I2S",
         "PerPkg": "1",
-        "UMask": "0x00C80F7E01",
-        "UMaskExt": "0x00C80F7E",
-        "Unit": "CHA"
+        "UMask": "0x302",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : CRd_Prefs issued by iA Cores th=
at Missed the LLC - HOMed locally",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_PREF_LOCAL",
+        "BriefDescription": "Multi-socket cacheline Directory update from =
S to A",
+        "EventCode": "0x21",
+        "EventName": "UNC_M2M_DIRECTORY_UPDATE.S2A",
         "PerPkg": "1",
-        "UMask": "0x00C88EFE01",
-        "UMaskExt": "0x00C88EFE",
-        "Unit": "CHA"
+        "UMask": "0x310",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : CRd_Prefs issued by iA Cores th=
at Missed the LLC - HOMed remotely",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_PREF_REMOTE",
+        "BriefDescription": "Multi-socket cacheline Directory update from =
S to I",
+        "EventCode": "0x21",
+        "EventName": "UNC_M2M_DIRECTORY_UPDATE.S2I",
         "PerPkg": "1",
-        "UMask": "0x00C88F7E01",
-        "UMaskExt": "0x00C88F7E",
-        "Unit": "CHA"
+        "UMask": "0x308",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : ItoMCacheNears issued by iA Cor=
es",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_ITOMCACHENEAR",
+        "BriefDescription": "UNC_M2M_IMC_READS.TO_PMM",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2M_IMC_READS.TO_PMM",
         "PerPkg": "1",
-        "UMask": "0x00CD47FF01",
-        "UMaskExt": "0x00CD47FF",
-        "Unit": "CHA"
+        "UMask": "0x320",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : WbMtoIs issued by an iA Cores. =
Modified Write Backs",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_WBMTOI",
+        "BriefDescription": "PMM - All Channels",
+        "EventCode": "0x25",
+        "EventName": "UNC_M2M_IMC_WRITES.TO_PMM",
         "PerPkg": "1",
-        "UMask": "0x00cc27ff01",
-        "UMaskExt": "0x00cc27ff",
-        "Unit": "CHA"
+        "UMask": "0x1880",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : ItoMs issued by iA Cores that H=
it LLC",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_ITOM",
+        "BriefDescription": "Data Prefetches Dropped",
+        "EventCode": "0x58",
+        "EventName": "UNC_M2M_PREFCAM_DEMAND_DROPS.CH0_UPI",
         "PerPkg": "1",
-        "UMask": "0x00CC47FD01",
-        "UMaskExt": "0x00CC47FD",
-        "Unit": "CHA"
+        "UMask": "0x2",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : ItoMs issued by iA Cores that M=
issed LLC",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_ITOM",
+        "BriefDescription": "Data Prefetches Dropped",
+        "EventCode": "0x58",
+        "EventName": "UNC_M2M_PREFCAM_DEMAND_DROPS.CH0_XPT",
         "PerPkg": "1",
-        "UMask": "0x00CC47FE01",
-        "UMaskExt": "0x00CC47FE",
-        "Unit": "CHA"
+        "UMask": "0x1",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : UCRdFs issued by iA Cores that =
Missed LLC",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_UCRDF",
+        "BriefDescription": "Data Prefetches Dropped",
+        "EventCode": "0x58",
+        "EventName": "UNC_M2M_PREFCAM_DEMAND_DROPS.CH1_UPI",
         "PerPkg": "1",
-        "UMask": "0x00C877DE01",
-        "UMaskExt": "0x00C877DE",
-        "Unit": "CHA"
+        "UMask": "0x8",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : WiLs issued by iA Cores that Mi=
ssed LLC",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WIL",
+        "BriefDescription": "Data Prefetches Dropped",
+        "EventCode": "0x58",
+        "EventName": "UNC_M2M_PREFCAM_DEMAND_DROPS.CH1_XPT",
         "PerPkg": "1",
-        "UMask": "0x00C87FDE01",
-        "UMaskExt": "0x00C87FDE",
-        "Unit": "CHA"
+        "UMask": "0x4",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : WCiLF issued by iA Cores",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_WCILF",
+        "BriefDescription": "Data Prefetches Dropped",
+        "EventCode": "0x58",
+        "EventName": "UNC_M2M_PREFCAM_DEMAND_DROPS.XPT_ALLCH",
         "PerPkg": "1",
-        "UMask": "0x00C867FF01",
-        "UMaskExt": "0x00C867FF",
-        "Unit": "CHA"
+        "UMask": "0x5",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : WCiLF issued by iA Cores that M=
issed the LLC",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCILF",
+        "BriefDescription": ": UPI - All Channels",
+        "EventCode": "0x5d",
+        "EventName": "UNC_M2M_PREFCAM_DEMAND_MERGE.UPI_ALLCH",
         "PerPkg": "1",
-        "UMask": "0x00C867FE01",
-        "UMaskExt": "0x00C867FE",
-        "Unit": "CHA"
+        "UMask": "0xa",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : WCiLFs issued by iA Cores targe=
ting PMM that missed the LLC",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCILF_PMM",
+        "BriefDescription": ": XPT - All Channels",
+        "EventCode": "0x5d",
+        "EventName": "UNC_M2M_PREFCAM_DEMAND_MERGE.XPT_ALLCH",
         "PerPkg": "1",
-        "UMask": "0x00C8678A01",
-        "UMaskExt": "0x00C8678A",
-        "Unit": "CHA"
+        "UMask": "0x5",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : WCiLFs issued by iA Cores targe=
ting PMM that missed the LLC - HOMed locally",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LOCAL_WCILF_PMM",
+        "BriefDescription": "Prefetch CAM Inserts : UPI - All Channels",
+        "EventCode": "0x56",
+        "EventName": "UNC_M2M_PREFCAM_INSERTS.UPI_ALLCH",
         "PerPkg": "1",
-        "UMask": "0x00C8668A01",
-        "UMaskExt": "0x00C8668A",
-        "Unit": "CHA"
+        "UMask": "0xa",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : WCiLFs issued by iA Cores targe=
ting PMM that missed the LLC - HOMed remotely",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_REMOTE_WCILF_PMM",
+        "BriefDescription": "Prefetch CAM Inserts : XPT - All Channels",
+        "EventCode": "0x56",
+        "EventName": "UNC_M2M_PREFCAM_INSERTS.XPT_ALLCH",
         "PerPkg": "1",
-        "UMask": "0x00C8670A01",
-        "UMaskExt": "0x00C8670A",
-        "Unit": "CHA"
+        "PublicDescription": "Prefetch CAM Inserts : XPT -All Channels",
+        "UMask": "0x5",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : WCiLFs issued by iA Cores targe=
ting DDR that missed the LLC",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCILF_DDR",
+        "BriefDescription": "AD Ingress (from CMS) : AD Ingress (from CMS)=
 Allocations",
+        "EventCode": "0x02",
+        "EventName": "UNC_M2M_RxC_AD_INSERTS",
         "PerPkg": "1",
-        "UMask": "0x00C8678601",
-        "UMaskExt": "0x00C86786",
-        "Unit": "CHA"
+        "UMask": "0x1",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : WCiLFs issued by iA Cores targe=
ting DDR that missed the LLC - HOMed locally",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LOCAL_WCILF_DDR",
+        "BriefDescription": "AD Ingress (from CMS) Occupancy",
+        "EventCode": "0x03",
+        "EventName": "UNC_M2M_RxC_AD_OCCUPANCY",
         "PerPkg": "1",
-        "UMask": "0x00C8668601",
-        "UMaskExt": "0x00C86686",
-        "Unit": "CHA"
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : WCiLFs issued by iA Cores targe=
ting DDR that missed the LLC - HOMed remotely",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_REMOTE_WCILF_DDR",
+        "BriefDescription": "Tracker Inserts : Channel 0",
+        "EventCode": "0x32",
+        "EventName": "UNC_M2M_TRACKER_INSERTS.CH0",
         "PerPkg": "1",
-        "UMask": "0x00C8670601",
-        "UMaskExt": "0x00C86706",
-        "Unit": "CHA"
+        "UMask": "0x104",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : WCiLs issued by iA Cores",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_WCIL",
+        "BriefDescription": "Tracker Inserts : Channel 1",
+        "EventCode": "0x32",
+        "EventName": "UNC_M2M_TRACKER_INSERTS.CH1",
         "PerPkg": "1",
-        "UMask": "0x00C86FFF01",
-        "UMaskExt": "0x00C86FFF",
-        "Unit": "CHA"
+        "UMask": "0x204",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : WCiLs issued by iA Cores that M=
issed the LLC",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCIL",
+        "BriefDescription": "Tracker Occupancy : Channel 0",
+        "EventCode": "0x33",
+        "EventName": "UNC_M2M_TRACKER_OCCUPANCY.CH0",
         "PerPkg": "1",
-        "UMask": "0x00C86FFE01",
-        "UMaskExt": "0x00C86FFE",
-        "Unit": "CHA"
+        "UMask": "0x1",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : WCiLs issued by iA Cores target=
ing PMM that missed the LLC",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCIL_PMM",
+        "BriefDescription": "Tracker Occupancy : Channel 1",
+        "EventCode": "0x33",
+        "EventName": "UNC_M2M_TRACKER_OCCUPANCY.CH1",
         "PerPkg": "1",
-        "UMask": "0x00C86F8A01",
-        "UMaskExt": "0x00C86F8A",
-        "Unit": "CHA"
+        "UMask": "0x2",
+        "Unit": "M2M"
     },
     {
-        "BriefDescription": "TOR Inserts : WCiLs issued by iA Cores target=
ing PMM that missed the LLC - HOMed locally",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LOCAL_WCIL_PMM",
+        "BriefDescription": "M2P Clockticks",
+        "EventCode": "0x01",
+        "EventName": "UNC_M2P_CLOCKTICKS",
         "PerPkg": "1",
-        "UMask": "0x00C86E8A01",
-        "UMaskExt": "0x00C86E8A",
-        "Unit": "CHA"
+        "PublicDescription": "Number of M2P clock cycles while the event i=
s enabled",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Inserts : WCiLs issued by iA Cores target=
ing PMM that missed the LLC - HOMed remotely",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_REMOTE_WCIL_PMM",
+        "BriefDescription": "CMS Clockticks",
+        "EventCode": "0xc0",
+        "EventName": "UNC_M2P_CMS_CLOCKTICKS",
         "PerPkg": "1",
-        "UMask": "0x00C86F0A01",
-        "UMaskExt": "0x00C86F0A",
-        "Unit": "CHA"
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Inserts : WCiLs issued by iA Cores target=
ing DDR that missed the LLC",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCIL_DDR",
+        "BriefDescription": "M3UPI Clockticks",
+        "EventCode": "0x01",
+        "EventName": "UNC_M3UPI_CLOCKTICKS",
         "PerPkg": "1",
-        "UMask": "0x00C86F8601",
-        "UMaskExt": "0x00C86F86",
-        "Unit": "CHA"
+        "PublicDescription": "Number of M2UPI clock cycles while the event=
 is enabled",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "TOR Inserts : WCiLs issued by iA Cores target=
ing DDR that missed the LLC - HOMed locally",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LOCAL_WCIL_DDR",
+        "BriefDescription": "M3UPI CMS Clockticks",
+        "EventCode": "0xc0",
+        "EventName": "UNC_M3UPI_CMS_CLOCKTICKS",
         "PerPkg": "1",
-        "UMask": "0x00C86E8601",
-        "UMaskExt": "0x00C86E86",
-        "Unit": "CHA"
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "TOR Inserts : WCiLs issued by iA Cores target=
ing DDR that missed the LLC - HOMed remotely",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_REMOTE_WCIL_DDR",
+        "BriefDescription": "D2C Sent",
+        "EventCode": "0x2b",
+        "EventName": "UNC_M3UPI_D2C_SENT",
         "PerPkg": "1",
-        "UMask": "0x00C86F0601",
-        "UMaskExt": "0x00C86F06",
-        "Unit": "CHA"
+        "PublicDescription": "D2C Sent : Count cases BL sends direct to co=
re",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "TOR Inserts : WbMtoIs issued by IO Devices",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO_WBMTOI",
+        "BriefDescription": "D2U Sent",
+        "EventCode": "0x2a",
+        "EventName": "UNC_M3UPI_D2U_SENT",
         "PerPkg": "1",
-        "UMask": "0x00CC23FF04",
-        "UMaskExt": "0x00CC23FF",
-        "Unit": "CHA"
+        "PublicDescription": "D2U Sent : Cases where SMI3 sends D2U comman=
d",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "TOR Inserts : CLFlushes issued by IO Devices"=
,
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO_CLFLUSH",
+        "BriefDescription": "FlowQ Generated Prefetch",
+        "EventCode": "0x29",
+        "EventName": "UNC_M3UPI_UPI_PREFETCH_SPAWN",
         "PerPkg": "1",
-        "UMask": "0x00C8C3FF04",
-        "UMaskExt": "0x00C8C3FF",
-        "Unit": "CHA"
+        "PublicDescription": "FlowQ Generated Prefetch : Count cases where=
 FlowQ causes spawn of Prefetch to iMC/SMI3 target",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "TOR Occupancy : DRds issued by iA Cores targe=
ting PMM Mem that Missed the LLC - HOMed locally",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL_PMM",
+        "BriefDescription": "UPI Clockticks",
+        "EventCode": "0x01",
+        "EventName": "UNC_UPI_CLOCKTICKS",
         "PerPkg": "1",
-        "UMask": "0x00c8168a01",
-        "UMaskExt": "0x00c8168a",
-        "Unit": "CHA"
+        "PublicDescription": "Number of UPI LL clock cycles while the even=
t is enabled",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : DRds issued by iA Cores targe=
ting PMM Mem that Missed the LLC - HOMed remotely",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE_PMM",
+        "BriefDescription": "Direct packet attempts : D2C",
+        "EventCode": "0x12",
+        "EventName": "UNC_UPI_DIRECT_ATTEMPTS.D2C",
         "PerPkg": "1",
-        "UMask": "0x00c8170a01",
-        "UMaskExt": "0x00c8170a",
-        "Unit": "CHA"
+        "PublicDescription": "Direct packet attempts : D2C : Counts the nu=
mber of DRS packets that we attempted to do direct2core/direct2UPI on.  The=
re are 4 mutually exclusive filters.  Filter [0] can be used to get success=
ful spawns, while [1:3] provide the different failure cases.  Note that thi=
s does not count packets that are not candidates for Direct2Core.  The only=
 candidates for Direct2Core are DRS packets destined for Cbos.",
+        "UMask": "0x1",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : DRds issued by iA Cores targe=
ting DDR Mem that Missed the LLC - HOMed locally",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL_DDR",
+        "BriefDescription": "Cycles in L1",
+        "EventCode": "0x21",
+        "EventName": "UNC_UPI_L1_POWER_CYCLES",
         "PerPkg": "1",
-        "UMask": "0x00c8168601",
-        "UMaskExt": "0x00c81686",
-        "Unit": "CHA"
+        "PublicDescription": "Cycles in L1 : Number of UPI qfclk cycles sp=
ent in L1 power mode.  L1 is a mode that totally shuts down a UPI link.  Us=
e edge detect to count the number of instances when the UPI link entered L1=
.  Link power states are per link and per direction, so for example the Tx =
direction could be in one state while Rx was in another. Because L1 totally=
 shuts down the link, it takes a good amount of time to exit this mode.",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : DRds issued by iA Cores targe=
ting DDR Mem that Missed the LLC - HOMed remotely",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE_DDR",
+        "BriefDescription": "Matches on Receive path of a UPI Port : Non-C=
oherent Bypass",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCB",
         "PerPkg": "1",
-        "UMask": "0x00c8170601",
-        "UMaskExt": "0x00c81706",
-        "Unit": "CHA"
+        "PublicDescription": "Matches on Receive path of a UPI Port : Non-=
Coherent Bypass : Matches on Receive path of a UPI port.\r\nMatch based on =
UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class Enable=
\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remote E=
nable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot Hdr E=
nable\r\nP: Single Slot Hdr Enable\r\nLink Layer control types are excluded=
 (LL CTRL, slot NULL, LLCRD) even under specific opcode match_en cases.\r\n=
Note: If Message Class is disabled, we expect opcode to also be disabled.",
+        "UMask": "0xe",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores =
targeting PMM Mem that Missed the LLC",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_PMM",
+        "BriefDescription": "Matches on Receive path of a UPI Port : Non-C=
oherent Bypass, Match Opcode",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCB_OPC",
         "PerPkg": "1",
-        "UMask": "0x00c8978a01",
-        "UMaskExt": "0x00c8978a",
-        "Unit": "CHA"
+        "PublicDescription": "Matches on Receive path of a UPI Port : Non-=
Coherent Bypass, Match Opcode : Matches on Receive path of a UPI port.\r\nM=
atch based on UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Messag=
e Class Enable\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\=
r\nT: Remote Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: D=
ual Slot Hdr Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control type=
s are excluded (LL CTRL, slot NULL, LLCRD) even under specific opcode match=
_en cases.\r\nNote: If Message Class is disabled, we expect opcode to also =
be disabled.",
+        "UMask": "0x10e",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores =
targeting PMM Mem that Missed the LLC - HOMed locally",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_LOCAL_PMM",
+        "BriefDescription": "Matches on Receive path of a UPI Port : Non-C=
oherent Standard",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCS",
         "PerPkg": "1",
-        "UMask": "0x00c8968a01",
-        "UMaskExt": "0x00c8968a",
-        "Unit": "CHA"
+        "PublicDescription": "Matches on Receive path of a UPI Port : Non-=
Coherent Standard : Matches on Receive path of a UPI port.\r\nMatch based o=
n UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class Enab=
le\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remote=
 Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot Hdr=
 Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control types are exclud=
ed (LL CTRL, slot NULL, LLCRD) even under specific opcode match_en cases.\r=
\nNote: If Message Class is disabled, we expect opcode to also be disabled.=
",
+        "UMask": "0xf",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores =
targeting PMM Mem that Missed the LLC - HOMed remotely",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_REMOTE_PMM",
+        "BriefDescription": "Matches on Receive path of a UPI Port : Non-C=
oherent Standard, Match Opcode",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCS_OPC",
         "PerPkg": "1",
-        "UMask": "0x00c8970a01",
-        "UMaskExt": "0x00c8970a",
-        "Unit": "CHA"
+        "PublicDescription": "Matches on Receive path of a UPI Port : Non-=
Coherent Standard, Match Opcode : Matches on Receive path of a UPI port.\r\=
nMatch based on UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Mess=
age Class Enable\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enabl=
e\r\nT: Remote Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ:=
 Dual Slot Hdr Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control ty=
pes are excluded (LL CTRL, slot NULL, LLCRD) even under specific opcode mat=
ch_en cases.\r\nNote: If Message Class is disabled, we expect opcode to als=
o be disabled.",
+        "UMask": "0x10f",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores =
targeting DDR Mem that Missed the LLC",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_DDR",
+        "BriefDescription": "RxQ Flit Buffer Bypassed : Slot 0",
+        "EventCode": "0x31",
+        "EventName": "UNC_UPI_RxL_BYPASSED.SLOT0",
         "PerPkg": "1",
-        "UMask": "0x00c8978601",
-        "UMaskExt": "0x00c89786",
-        "Unit": "CHA"
+        "PublicDescription": "RxQ Flit Buffer Bypassed : Slot 0 : Counts t=
he number of times that an incoming flit was able to bypass the flit buffer=
 and pass directly across the BGF and into the Egress.  This is a latency o=
ptimization, and should generally be the common case.  If this value is les=
s than the number of flits transferred, it implies that there was queueing =
getting onto the ring, and thus the transactions saw higher latency.",
+        "UMask": "0x1",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores =
targeting DDR Mem that Missed the LLC - HOMed locally",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_LOCAL_DDR",
+        "BriefDescription": "RxQ Flit Buffer Bypassed : Slot 1",
+        "EventCode": "0x31",
+        "EventName": "UNC_UPI_RxL_BYPASSED.SLOT1",
         "PerPkg": "1",
-        "UMask": "0x00c8968601",
-        "UMaskExt": "0x00c89686",
-        "Unit": "CHA"
+        "PublicDescription": "RxQ Flit Buffer Bypassed : Slot 1 : Counts t=
he number of times that an incoming flit was able to bypass the flit buffer=
 and pass directly across the BGF and into the Egress.  This is a latency o=
ptimization, and should generally be the common case.  If this value is les=
s than the number of flits transferred, it implies that there was queueing =
getting onto the ring, and thus the transactions saw higher latency.",
+        "UMask": "0x2",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores =
targeting DDR Mem that Missed the LLC - HOMed remotely",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_REMOTE_DDR",
+        "BriefDescription": "RxQ Flit Buffer Bypassed : Slot 2",
+        "EventCode": "0x31",
+        "EventName": "UNC_UPI_RxL_BYPASSED.SLOT2",
         "PerPkg": "1",
-        "UMask": "0x00c8970601",
-        "UMaskExt": "0x00c89706",
-        "Unit": "CHA"
+        "PublicDescription": "RxQ Flit Buffer Bypassed : Slot 2 : Counts t=
he number of times that an incoming flit was able to bypass the flit buffer=
 and pass directly across the BGF and into the Egress.  This is a latency o=
ptimization, and should generally be the common case.  If this value is les=
s than the number of flits transferred, it implies that there was queueing =
getting onto the ring, and thus the transactions saw higher latency.",
+        "UMask": "0x4",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : CRd issued by iA Cores that M=
issed the LLC - HOMed locally",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_LOCAL",
+        "BriefDescription": "Valid Flits Received : All Data",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.ALL_DATA",
         "PerPkg": "1",
-        "UMask": "0x00c80efe01",
-        "UMaskExt": "0x00c80efe",
-        "Unit": "CHA"
+        "PublicDescription": "Valid Flits Received : All Data : Shows lega=
l flit time (hides impact of L0p and L0c).",
+        "UMask": "0xf",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : CRd issued by iA Cores that M=
issed the LLC - HOMed remotely",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_REMOTE",
+        "BriefDescription": "Null FLITs received from any slot",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.ALL_NULL",
         "PerPkg": "1",
-        "UMask": "0x00c80f7e01",
-        "UMaskExt": "0x00c80f7e",
-        "Unit": "CHA"
+        "UMask": "0x27",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : CRd_Prefs issued by iA Cores =
that Missed the LLC - HOMed locally",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_PREF_LOCAL",
+        "BriefDescription": "Valid Flits Received : Data",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.DATA",
         "PerPkg": "1",
-        "UMask": "0x00c88efe01",
-        "UMaskExt": "0x00c88efe",
-        "Unit": "CHA"
+        "PublicDescription": "Valid Flits Received : Data : Shows legal fl=
it time (hides impact of L0p and L0c). : Count Data Flits (which consume al=
l slots), but how much to count is based on Slot0-2 mask, so count can be 0=
-3 depending on which slots are enabled for counting..",
+        "UMask": "0x8",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : CRd_Prefs issued by iA Cores =
that Missed the LLC - HOMed remotely",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_PREF_REMOTE",
+        "BriefDescription": "Valid Flits Received : Idle",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.IDLE",
         "PerPkg": "1",
-        "UMask": "0x00c88f7e01",
-        "UMaskExt": "0x00c88f7e",
-        "Unit": "CHA"
+        "PublicDescription": "Valid Flits Received : Idle : Shows legal fl=
it time (hides impact of L0p and L0c).",
+        "UMask": "0x47",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : CLFlushes issued by iA Cores"=
,
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_CLFLUSH",
+        "BriefDescription": "Valid Flits Received : LLCRD Not Empty",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.LLCRD",
         "PerPkg": "1",
-        "UMask": "0x00c8c7ff01",
-        "UMaskExt": "0x00c8c7ff",
-        "Unit": "CHA"
+        "PublicDescription": "Valid Flits Received : LLCRD Not Empty : Sho=
ws legal flit time (hides impact of L0p and L0c). : Enables counting of LLC=
RD (with non-zero payload). This only applies to slot 2 since LLCRD is only=
 allowed in slot 2",
+        "UMask": "0x10",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : CLFlushOpts issued by iA Core=
s",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_CLFLUSHOPT",
+        "BriefDescription": "Valid Flits Received : LLCTRL",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.LLCTRL",
         "PerPkg": "1",
-        "UMask": "0x00c8d7ff01",
-        "UMaskExt": "0x00c8d7ff",
-        "Unit": "CHA"
+        "PublicDescription": "Valid Flits Received : LLCTRL : Shows legal =
flit time (hides impact of L0p and L0c). : Equivalent to an idle packet.  E=
nables counting of slot 0 LLCTRL messages.",
+        "UMask": "0x40",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : ItoMCacheNears issued by iA C=
ores",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_ITOMCACHENEAR",
+        "BriefDescription": "Valid Flits Received : All Non Data",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.NON_DATA",
         "PerPkg": "1",
-        "UMask": "0x00cd47ff01",
-        "UMaskExt": "0x00cd47ff",
-        "Unit": "CHA"
+        "PublicDescription": "Valid Flits Received : All Non Data : Shows =
legal flit time (hides impact of L0p and L0c).",
+        "UMask": "0x97",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : SpecItoMs issued by iA Cores"=
,
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_SPECITOM",
+        "BriefDescription": "Valid Flits Received : Slot NULL or LLCRD Emp=
ty",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.NULL",
         "PerPkg": "1",
-        "UMask": "0x00cc57ff01",
-        "UMaskExt": "0x00cc57ff",
-        "Unit": "CHA"
+        "PublicDescription": "Valid Flits Received : Slot NULL or LLCRD Em=
pty : Shows legal flit time (hides impact of L0p and L0c). : LLCRD with all=
 zeros is treated as NULL. Slot 1 is not treated as NULL if slot 0 is a dua=
l slot. This can apply to slot 0,1, or 2.",
+        "UMask": "0x20",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : WbMtoIs issued by iA Cores",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_WBMTOI",
+        "BriefDescription": "Valid Flits Received : Protocol Header",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.PROTHDR",
         "PerPkg": "1",
-        "UMask": "0x00cc27ff01",
-        "UMaskExt": "0x00cc27ff",
-        "Unit": "CHA"
+        "PublicDescription": "Valid Flits Received : Protocol Header : Sho=
ws legal flit time (hides impact of L0p and L0c). : Enables count of protoc=
ol headers in slot 0,1,2 (depending on slot uMask bits)",
+        "UMask": "0x80",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : ItoMs issued by iA Cores",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_ITOM",
+        "BriefDescription": "Valid Flits Received : Slot 0",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.SLOT0",
         "PerPkg": "1",
-        "UMask": "0x00cc47ff01",
-        "UMaskExt": "0x00cc47ff",
-        "Unit": "CHA"
+        "PublicDescription": "Valid Flits Received : Slot 0 : Shows legal =
flit time (hides impact of L0p and L0c). : Count Slot 0 - Other mask bits d=
etermine types of headers to count.",
+        "UMask": "0x1",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : ItoMs issued by iA Cores that=
 Hit LLC",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_ITOM",
+        "BriefDescription": "Valid Flits Received : Slot 1",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.SLOT1",
         "PerPkg": "1",
-        "UMask": "0x00cc47fd01",
-        "UMaskExt": "0x00cc47fd",
-        "Unit": "CHA"
+        "PublicDescription": "Valid Flits Received : Slot 1 : Shows legal =
flit time (hides impact of L0p and L0c). : Count Slot 1 - Other mask bits d=
etermine types of headers to count.",
+        "UMask": "0x2",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : ItoMs issued by iA Cores that=
 Missed LLC",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_ITOM",
+        "BriefDescription": "Valid Flits Received : Slot 2",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.SLOT2",
         "PerPkg": "1",
-        "UMask": "0x00cc47fe01",
-        "UMaskExt": "0x00cc47fe",
-        "Unit": "CHA"
+        "PublicDescription": "Valid Flits Received : Slot 2 : Shows legal =
flit time (hides impact of L0p and L0c). : Count Slot 2 - Other mask bits d=
etermine types of headers to count.",
+        "UMask": "0x4",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : UCRdFs issued by iA Cores tha=
t Missed LLC",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_UCRDF",
+        "BriefDescription": "RxQ Flit Buffer Allocations : Slot 0",
+        "EventCode": "0x30",
+        "EventName": "UNC_UPI_RxL_INSERTS.SLOT0",
         "PerPkg": "1",
-        "UMask": "0x00c877de01",
-        "UMaskExt": "0x00c877de",
-        "Unit": "CHA"
+        "PublicDescription": "RxQ Flit Buffer Allocations : Slot 0 : Numbe=
r of allocations into the UPI Rx Flit Buffer.  Generally, when data is tran=
smitted across UPI, it will bypass the RxQ and pass directly to the ring in=
terface.  If things back up getting transmitted onto the ring, however, it =
may need to allocate into this buffer, thus increasing the latency.  This e=
vent can be used in conjunction with the Flit Buffer Occupancy event in ord=
er to calculate the average flit buffer lifetime.",
+        "UMask": "0x1",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : WiLs issued by iA Cores that =
Missed LLC",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WIL",
+        "BriefDescription": "RxQ Flit Buffer Allocations : Slot 1",
+        "EventCode": "0x30",
+        "EventName": "UNC_UPI_RxL_INSERTS.SLOT1",
         "PerPkg": "1",
-        "UMask": "0x00c87fde01",
-        "UMaskExt": "0x00c87fde",
-        "Unit": "CHA"
+        "PublicDescription": "RxQ Flit Buffer Allocations : Slot 1 : Numbe=
r of allocations into the UPI Rx Flit Buffer.  Generally, when data is tran=
smitted across UPI, it will bypass the RxQ and pass directly to the ring in=
terface.  If things back up getting transmitted onto the ring, however, it =
may need to allocate into this buffer, thus increasing the latency.  This e=
vent can be used in conjunction with the Flit Buffer Occupancy event in ord=
er to calculate the average flit buffer lifetime.",
+        "UMask": "0x2",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : WCiLF issued by iA Cores",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_WCILF",
+        "BriefDescription": "RxQ Flit Buffer Allocations : Slot 2",
+        "EventCode": "0x30",
+        "EventName": "UNC_UPI_RxL_INSERTS.SLOT2",
         "PerPkg": "1",
-        "UMask": "0x00c867ff01",
-        "UMaskExt": "0x00c867ff",
-        "Unit": "CHA"
+        "PublicDescription": "RxQ Flit Buffer Allocations : Slot 2 : Numbe=
r of allocations into the UPI Rx Flit Buffer.  Generally, when data is tran=
smitted across UPI, it will bypass the RxQ and pass directly to the ring in=
terface.  If things back up getting transmitted onto the ring, however, it =
may need to allocate into this buffer, thus increasing the latency.  This e=
vent can be used in conjunction with the Flit Buffer Occupancy event in ord=
er to calculate the average flit buffer lifetime.",
+        "UMask": "0x4",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : WCiLF issued by iA Cores that=
 Missed the LLC",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCILF",
+        "BriefDescription": "RxQ Occupancy - All Packets : Slot 0",
+        "EventCode": "0x32",
+        "EventName": "UNC_UPI_RxL_OCCUPANCY.SLOT0",
         "PerPkg": "1",
-        "UMask": "0x00c867fe01",
-        "UMaskExt": "0x00c867fe",
-        "Unit": "CHA"
+        "PublicDescription": "RxQ Occupancy - All Packets : Slot 0 : Accum=
ulates the number of elements in the UPI RxQ in each cycle.  Generally, whe=
n data is transmitted across UPI, it will bypass the RxQ and pass directly =
to the ring interface.  If things back up getting transmitted onto the ring=
, however, it may need to allocate into this buffer, thus increasing the la=
tency.  This event can be used in conjunction with the Flit Buffer Not Empt=
y event to calculate average occupancy, or with the Flit Buffer Allocations=
 event to track average lifetime.",
+        "UMask": "0x1",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : WCiLFs issued by iA Cores tar=
geting PMM that missed the LLC",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCILF_PMM",
+        "BriefDescription": "RxQ Occupancy - All Packets : Slot 1",
+        "EventCode": "0x32",
+        "EventName": "UNC_UPI_RxL_OCCUPANCY.SLOT1",
         "PerPkg": "1",
-        "UMask": "0x00c8678a01",
-        "UMaskExt": "0x00c8678a",
-        "Unit": "CHA"
+        "PublicDescription": "RxQ Occupancy - All Packets : Slot 1 : Accum=
ulates the number of elements in the UPI RxQ in each cycle.  Generally, whe=
n data is transmitted across UPI, it will bypass the RxQ and pass directly =
to the ring interface.  If things back up getting transmitted onto the ring=
, however, it may need to allocate into this buffer, thus increasing the la=
tency.  This event can be used in conjunction with the Flit Buffer Not Empt=
y event to calculate average occupancy, or with the Flit Buffer Allocations=
 event to track average lifetime.",
+        "UMask": "0x2",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : WCiLFs issued by iA Cores tar=
geting PMM that missed the LLC - HOMed locally",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LOCAL_WCILF_PMM",
+        "BriefDescription": "RxQ Occupancy - All Packets : Slot 2",
+        "EventCode": "0x32",
+        "EventName": "UNC_UPI_RxL_OCCUPANCY.SLOT2",
         "PerPkg": "1",
-        "UMask": "0x00c8668a01",
-        "UMaskExt": "0x00c8668a",
-        "Unit": "CHA"
+        "PublicDescription": "RxQ Occupancy - All Packets : Slot 2 : Accum=
ulates the number of elements in the UPI RxQ in each cycle.  Generally, whe=
n data is transmitted across UPI, it will bypass the RxQ and pass directly =
to the ring interface.  If things back up getting transmitted onto the ring=
, however, it may need to allocate into this buffer, thus increasing the la=
tency.  This event can be used in conjunction with the Flit Buffer Not Empt=
y event to calculate average occupancy, or with the Flit Buffer Allocations=
 event to track average lifetime.",
+        "UMask": "0x4",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : WCiLFs issued by iA Cores tar=
geting PMM that missed the LLC - HOMed remotely",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_REMOTE_WCILF_PMM",
+        "BriefDescription": "Cycles in L0p",
+        "EventCode": "0x27",
+        "EventName": "UNC_UPI_TxL0P_POWER_CYCLES",
         "PerPkg": "1",
-        "UMask": "0x00c8670a01",
-        "UMaskExt": "0x00c8670a",
-        "Unit": "CHA"
+        "PublicDescription": "Cycles in L0p : Number of UPI qfclk cycles s=
pent in L0p power mode.  L0p is a mode where we disable 1/2 of the UPI lane=
s, decreasing our bandwidth in order to save power.  It increases snoop and=
 data transfer latencies and decreases overall bandwidth.  This mode can be=
 very useful in NUMA optimized workloads that largely only utilize UPI for =
snoops and their responses.  Use edge detect to count the number of instanc=
es when the UPI link entered L0p.  Link power states are per link and per d=
irection, so for example the Tx direction could be in one state while Rx wa=
s in another.",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : WCiLFs issued by iA Cores tar=
geting DDR that missed the LLC",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCILF_DDR",
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Non-=
Coherent Bypass",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCB",
         "PerPkg": "1",
-        "UMask": "0x00c8678601",
-        "UMaskExt": "0x00c86786",
-        "Unit": "CHA"
+        "PublicDescription": "Matches on Transmit path of a UPI Port : Non=
-Coherent Bypass : Matches on Transmit path of a UPI port.\r\nMatch based o=
n UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class Enab=
le\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remote=
 Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot Hdr=
 Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control types are exclud=
ed (LL CTRL, slot NULL, LLCRD) even under specific opcode match_en cases.\r=
\nNote: If Message Class is disabled, we expect opcode to also be disabled.=
",
+        "UMask": "0xe",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : WCiLFs issued by iA Cores tar=
geting DDR that missed the LLC - HOMed locally",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LOCAL_WCILF_DDR",
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Non-=
Coherent Bypass, Match Opcode",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCB_OPC",
         "PerPkg": "1",
-        "UMask": "0x00c8668601",
-        "UMaskExt": "0x00c86686",
-        "Unit": "CHA"
+        "PublicDescription": "Matches on Transmit path of a UPI Port : Non=
-Coherent Bypass, Match Opcode : Matches on Transmit path of a UPI port.\r\=
nMatch based on UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Mess=
age Class Enable\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enabl=
e\r\nT: Remote Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ:=
 Dual Slot Hdr Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control ty=
pes are excluded (LL CTRL, slot NULL, LLCRD) even under specific opcode mat=
ch_en cases.\r\nNote: If Message Class is disabled, we expect opcode to als=
o be disabled.",
+        "UMask": "0x10e",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : WCiLFs issued by iA Cores tar=
geting DDR that missed the LLC - HOMed remotely",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_REMOTE_WCILF_DDR",
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Non-=
Coherent Standard",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCS",
         "PerPkg": "1",
-        "UMask": "0x00c8670601",
-        "UMaskExt": "0x00c86706",
-        "Unit": "CHA"
+        "PublicDescription": "Matches on Transmit path of a UPI Port : Non=
-Coherent Standard : Matches on Transmit path of a UPI port.\r\nMatch based=
 on UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Message Class En=
able\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Enable\r\nT: Remo=
te Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\nQ: Dual Slot H=
dr Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control types are excl=
uded (LL CTRL, slot NULL, LLCRD) even under specific opcode match_en cases.=
\r\nNote: If Message Class is disabled, we expect opcode to also be disable=
d.",
+        "UMask": "0xf",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : WCiLs issued by iA Cores",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_WCIL",
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Non-=
Coherent Standard, Match Opcode",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCS_OPC",
         "PerPkg": "1",
-        "UMask": "0x00c86fff01",
-        "UMaskExt": "0x00c86fff",
-        "Unit": "CHA"
+        "PublicDescription": "Matches on Transmit path of a UPI Port : Non=
-Coherent Standard, Match Opcode : Matches on Transmit path of a UPI port.\=
r\nMatch based on UMask specific bits:\r\nZ: Message Class (3-bit)\r\nY: Me=
ssage Class Enable\r\nW: Opcode (4-bit)\r\nV: Opcode Enable\r\nU: Local Ena=
ble\r\nT: Remote Enable\r\nS: Data Hdr Enable\r\nR: Non-Data Hdr Enable\r\n=
Q: Dual Slot Hdr Enable\r\nP: Single Slot Hdr Enable\r\nLink Layer control =
types are excluded (LL CTRL, slot NULL, LLCRD) even under specific opcode m=
atch_en cases.\r\nNote: If Message Class is disabled, we expect opcode to a=
lso be disabled.",
+        "UMask": "0x10f",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : WCiLs issued by iA Cores that=
 Missed the LLC",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCIL",
+        "BriefDescription": "Tx Flit Buffer Bypassed",
+        "EventCode": "0x41",
+        "EventName": "UNC_UPI_TxL_BYPASSED",
         "PerPkg": "1",
-        "UMask": "0x00c86ffe01",
-        "UMaskExt": "0x00c86ffe",
-        "Unit": "CHA"
+        "PublicDescription": "Tx Flit Buffer Bypassed : Counts the number =
of times that an incoming flit was able to bypass the Tx flit buffer and pa=
ss directly out the UPI Link. Generally, when data is transmitted across UP=
I, it will bypass the TxQ and pass directly to the link.  However, the TxQ =
will be used with L0p and when LLR occurs, increasing latency to transfer o=
ut to the link.",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : WCiLs issued by iA Cores targ=
eting PMM that missed the LLC",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCIL_PMM",
+        "BriefDescription": "Valid Flits Sent : All Data",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.ALL_DATA",
         "PerPkg": "1",
-        "UMask": "0x00c86f8a01",
-        "UMaskExt": "0x00c86f8a",
-        "Unit": "CHA"
+        "PublicDescription": "Valid Flits Sent : All Data : Counts number =
of data flits across this UPI link.",
+        "UMask": "0xf",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : WCiLs issued by iA Cores targ=
eting PMM that missed the LLC - HOMed locally",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LOCAL_WCIL_PMM",
+        "BriefDescription": "All Null Flits",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.ALL_NULL",
         "PerPkg": "1",
-        "UMask": "0x00c86e8a01",
-        "UMaskExt": "0x00c86e8a",
-        "Unit": "CHA"
+        "UMask": "0x27",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : WCiLs issued by iA Cores targ=
eting PMM that missed the LLC - HOMed remotely",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_REMOTE_WCIL_PMM",
+        "BriefDescription": "Valid Flits Sent : Data",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.DATA",
         "PerPkg": "1",
-        "UMask": "0x00c86f0a01",
-        "UMaskExt": "0x00c86f0a",
-        "Unit": "CHA"
+        "PublicDescription": "Valid Flits Sent : Data : Shows legal flit t=
ime (hides impact of L0p and L0c). : Count Data Flits (which consume all sl=
ots), but how much to count is based on Slot0-2 mask, so count can be 0-3 d=
epending on which slots are enabled for counting..",
+        "UMask": "0x8",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : WCiLs issued by iA Cores targ=
eting DDR that missed the LLC",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCIL_DDR",
+        "BriefDescription": "Valid Flits Sent : Idle",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.IDLE",
         "PerPkg": "1",
-        "UMask": "0x00c86f8601",
-        "UMaskExt": "0x00c86f86",
-        "Unit": "CHA"
+        "PublicDescription": "Valid Flits Sent : Idle : Shows legal flit t=
ime (hides impact of L0p and L0c).",
+        "UMask": "0x47",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : WCiLs issued by iA Cores targ=
eting DDR that missed the LLC - HOMed locally",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LOCAL_WCIL_DDR",
+        "BriefDescription": "Valid Flits Sent : LLCRD Not Empty",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.LLCRD",
         "PerPkg": "1",
-        "UMask": "0x00c86e8601",
-        "UMaskExt": "0x00c86e86",
-        "Unit": "CHA"
+        "PublicDescription": "Valid Flits Sent : LLCRD Not Empty : Shows l=
egal flit time (hides impact of L0p and L0c). : Enables counting of LLCRD (=
with non-zero payload). This only applies to slot 2 since LLCRD is only all=
owed in slot 2",
+        "UMask": "0x10",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : WCiLs issued by iA Cores targ=
eting DDR that missed the LLC - HOMed remotely",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_REMOTE_WCIL_DDR",
+        "BriefDescription": "Valid Flits Sent : LLCTRL",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.LLCTRL",
         "PerPkg": "1",
-        "UMask": "0x00c86f0601",
-        "UMaskExt": "0x00c86f06",
-        "Unit": "CHA"
+        "PublicDescription": "Valid Flits Sent : LLCTRL : Shows legal flit=
 time (hides impact of L0p and L0c). : Equivalent to an idle packet.  Enabl=
es counting of slot 0 LLCTRL messages.",
+        "UMask": "0x40",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : WbMtoIs issued by IO Devices"=
,
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_WBMTOI",
+        "BriefDescription": "Valid Flits Sent : All Non Data",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.NON_DATA",
         "PerPkg": "1",
-        "UMask": "0x00cc23ff04",
-        "UMaskExt": "0x00cc23ff",
-        "Unit": "CHA"
+        "PublicDescription": "Valid Flits Sent : All Non Data : Shows lega=
l flit time (hides impact of L0p and L0c).",
+        "UMask": "0x97",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : CLFlushes issued by IO Device=
s",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_CLFLUSH",
+        "BriefDescription": "Valid Flits Sent : Slot NULL or LLCRD Empty",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.NULL",
         "PerPkg": "1",
-        "UMask": "0x00c8c3ff04",
-        "UMaskExt": "0x00c8c3ff",
-        "Unit": "CHA"
+        "PublicDescription": "Valid Flits Sent : Slot NULL or LLCRD Empty =
: Shows legal flit time (hides impact of L0p and L0c). : LLCRD with all zer=
os is treated as NULL. Slot 1 is not treated as NULL if slot 0 is a dual sl=
ot. This can apply to slot 0,1, or 2.",
+        "UMask": "0x20",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : ItoMCacheNears, indicating a =
partial write request, from IO Devices that hit the LLC",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT_ITOMCACHENEAR",
+        "BriefDescription": "Valid Flits Sent : Protocol Header",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.PROTHDR",
         "PerPkg": "1",
-        "UMask": "0x00cd43fd04",
-        "UMaskExt": "0x00cd43fd",
-        "Unit": "CHA"
+        "PublicDescription": "Valid Flits Sent : Protocol Header : Shows l=
egal flit time (hides impact of L0p and L0c). : Enables count of protocol h=
eaders in slot 0,1,2 (depending on slot uMask bits)",
+        "UMask": "0x80",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : ItoMCacheNears, indicating a =
partial write request, from IO Devices that missed the LLC",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOMCACHENEAR",
+        "BriefDescription": "Valid Flits Sent : Slot 0",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.SLOT0",
         "PerPkg": "1",
-        "UMask": "0x00cd43fe04",
-        "UMaskExt": "0x00cd43fe",
-        "Unit": "CHA"
+        "PublicDescription": "Valid Flits Sent : Slot 0 : Shows legal flit=
 time (hides impact of L0p and L0c). : Count Slot 0 - Other mask bits deter=
mine types of headers to count.",
+        "UMask": "0x1",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : PMM Access",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.PMM",
+        "BriefDescription": "Valid Flits Sent : Slot 1",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.SLOT1",
         "PerPkg": "1",
-        "UMaskExt": "0x00000008",
-        "Unit": "CHA"
+        "PublicDescription": "Valid Flits Sent : Slot 1 : Shows legal flit=
 time (hides impact of L0p and L0c). : Count Slot 1 - Other mask bits deter=
mine types of headers to count.",
+        "UMask": "0x2",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Inserts : PMM Access",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.PMM",
+        "BriefDescription": "Valid Flits Sent : Slot 2",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.SLOT2",
         "PerPkg": "1",
-        "UMaskExt": "0x00000008",
-        "Unit": "CHA"
+        "PublicDescription": "Valid Flits Sent : Slot 2 : Shows legal flit=
 time (hides impact of L0p and L0c). : Count Slot 2 - Other mask bits deter=
mine types of headers to count.",
+        "UMask": "0x4",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Occupancy : DDR Access",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.DDR",
+        "BriefDescription": "Tx Flit Buffer Allocations",
+        "EventCode": "0x40",
+        "EventName": "UNC_UPI_TxL_INSERTS",
         "PerPkg": "1",
-        "UMaskExt": "0x00000004",
-        "Unit": "CHA"
+        "PublicDescription": "Tx Flit Buffer Allocations : Number of alloc=
ations into the UPI Tx Flit Buffer.  Generally, when data is transmitted ac=
ross UPI, it will bypass the TxQ and pass directly to the link.  However, t=
he TxQ will be used with L0p and when LLR occurs, increasing latency to tra=
nsfer out to the link.  This event can be used in conjunction with the Flit=
 Buffer Occupancy event in order to calculate the average flit buffer lifet=
ime.",
+        "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "TOR Inserts : DDR Access",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.DDR",
+        "BriefDescription": "Tx Flit Buffer Occupancy",
+        "EventCode": "0x42",
+        "EventName": "UNC_UPI_TxL_OCCUPANCY",
         "PerPkg": "1",
-        "UMaskExt": "0x00000004",
-        "Unit": "CHA"
+        "PublicDescription": "Tx Flit Buffer Occupancy : Accumulates the n=
umber of flits in the TxQ.  Generally, when data is transmitted across UPI,=
 it will bypass the TxQ and pass directly to the link.  However, the TxQ wi=
ll be used with L0p and when LLR occurs, increasing latency to transfer out=
 to the link. This can be used with the cycles not empty event to track ave=
rage occupancy, or the allocations event to track average lifetime in the T=
xQ.",
+        "Unit": "UPI LL"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-power.jso=
n b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-power.json
index 6299afe544cb..b1d5a605e0a7 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-power.json
@@ -1,12 +1,90 @@
 [
     {
         "BriefDescription": "PCU PCLK Clockticks",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
         "EventCode": "0x01",
         "EventName": "UNC_P_CLOCKTICKS",
         "PerPkg": "1",
-        "UMaskExt": "0x00000000",
+        "PublicDescription": "Number of PCU PCLK Clock cycles while the ev=
ent is enabled",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Thermal Strongest Upper Limit Cycles",
+        "EventCode": "0x04",
+        "EventName": "UNC_P_FREQ_MAX_LIMIT_THERMAL_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Thermal Strongest Upper Limit Cycles : Numbe=
r of cycles any frequency is reduced due to a thermal limit.  Count only if=
 throttling is occurring.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Power Strongest Upper Limit Cycles",
+        "EventCode": "0x05",
+        "EventName": "UNC_P_FREQ_MAX_POWER_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Power Strongest Upper Limit Cycles : Counts =
the number of cycles when power is the upper limit on frequency.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Cycles spent changing Frequency",
+        "EventCode": "0x74",
+        "EventName": "UNC_P_FREQ_TRANS_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Cycles spent changing Frequency : Counts the=
 number of cycles when the system is changing frequency.  This can not be f=
iltered by thread ID.  One can also use it with the occupancy counter that =
monitors number of threads in C0 to estimate the performance impact that fr=
equency transitions had on the system.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Package C State Residency - C2E",
+        "EventCode": "0x2b",
+        "EventName": "UNC_P_PKG_RESIDENCY_C2E_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Package C State Residency - C2E : Counts the=
 number of cycles when the package was in C2E.  This event can be used in c=
onjunction with edge detect to count C2E entrances (or exits using invert).=
  Residency events do not include transition times.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Package C State Residency - C6",
+        "EventCode": "0x2d",
+        "EventName": "UNC_P_PKG_RESIDENCY_C6_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Package C State Residency - C6 : Counts the =
number of cycles when the package was in C6.  This event can be used in con=
junction with edge detect to count C6 entrances (or exits using invert).  R=
esidency events do not include transition times.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Number of cores in C0",
+        "EventCode": "0x35",
+        "EventName": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C0",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cores in C0 : This is an occupancy=
 event that tracks the number of cores that are in the chosen C-State.  It =
can be used by itself to get the average number of cores in that C-state wi=
th thresholding to generate histograms, or with other PCU events and occupa=
ncy triggering to capture other details.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Number of cores in C3",
+        "EventCode": "0x36",
+        "EventName": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C3",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cores in C3 : This is an occupancy=
 event that tracks the number of cores that are in the chosen C-State.  It =
can be used by itself to get the average number of cores in that C-state wi=
th thresholding to generate histograms, or with other PCU events and occupa=
ncy triggering to capture other details.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Number of cores in C6",
+        "EventCode": "0x37",
+        "EventName": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C6",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cores in C6 : This is an occupancy=
 event that tracks the number of cores that are in the chosen C-State.  It =
can be used by itself to get the average number of cores in that C-state wi=
th thresholding to generate histograms, or with other PCU events and occupa=
ncy triggering to capture other details.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "External Prochot",
+        "EventCode": "0x0a",
+        "EventName": "UNC_P_PROCHOT_EXTERNAL_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "External Prochot : Counts the number of cycl=
es that we are in external PROCHOT mode.  This mode is triggered when a sen=
sor off the die determines that something off-die (like DRAM) is too hot an=
d must throttle to avoid damaging the chip.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Internal Prochot",
+        "EventCode": "0x09",
+        "EventName": "UNC_P_PROCHOT_INTERNAL_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Internal Prochot : Counts the number of cycl=
es that we are in Internal PROCHOT mode.  This mode is triggered when a sen=
sor on the die determines that we are too hot and must throttle to avoid da=
maging the chip.",
         "Unit": "PCU"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/virtual-memory.j=
son b/tools/perf/pmu-events/arch/x86/sapphirerapids/virtual-memory.json
index f591f4fedc0b..a1e3b8d2ebe7 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/virtual-memory.json
@@ -1,245 +1,165 @@
 [
     {
         "BriefDescription": "Loads that miss the DTLB and hit the STLB.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
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
         "EventCode": "0x12",
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
         "EventCode": "0x12",
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
d to a 1G page.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_1G",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Page walks completed due to a demand data loa=
d to a 2M/4M page.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x12",
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
         "EventCode": "0x12",
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
         "EventCode": "0x12",
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
         "EventCode": "0x13",
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
         "EventCode": "0x13",
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
         "EventCode": "0x13",
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
re to a 1G page.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_1G",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x8"
     },
     {
         "BriefDescription": "Page walks completed due to a demand data sto=
re to a 2M/4M page.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
         "EventCode": "0x13",
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
         "EventCode": "0x13",
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
         "EventCode": "0x13",
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
         "EventCode": "0x11",
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
         "EventCode": "0x11",
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
         "EventCode": "0x11",
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
         "EventCode": "0x11",
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
         "EventCode": "0x11",
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
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_PENDING",
-        "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks outstanding =
for an outstanding code (instruction fetch) request in the PMH (Page Miss H=
andler) each cycle.",
         "SampleAfterValue": "100003",
-        "Speculative": "1",
         "UMask": "0x10"
     }
 ]
--=20
2.39.0.314.g84b9a713c41-goog

