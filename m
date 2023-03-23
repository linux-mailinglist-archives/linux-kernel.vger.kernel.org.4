Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F188C6C70F6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjCWTVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjCWTVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:21:24 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0F3D515
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:20:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54196bfcd5fso225695447b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679599255;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpUbyagLHfyugt4xjgObF98IlMw5uCwm74nv9CwNkFI=;
        b=FJ6bwSpjlzvZD/StU/PddRnv/l2k/hnYLRQ6iItzf76rmzgIjohfVdObyOh1IXhp60
         CuNIaphOhIyrLx6Nnsel8e5/RMRX6u0lCsqGxJDAqNfv1Y3kLu0dLQnCppcugL9fz9sm
         E6qwkcHJpcUHzcQijbslo+ejRrpcgUoU61oTo/fjV6CLA7anAF72Sb/k0vO3Pj/NICOx
         8GrzJ0aK42GOVw+neIggAFCMRupdJ2s6625QwMHHirN8f8HyD2P318JkAWYcx5iksXde
         nim2WBAWHRQmzBtDLmmBH7BcgLX1SNImUsFNemM0qfK+BXgP2bAfZyEGRCtjsQ35P2f2
         LlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679599255;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dpUbyagLHfyugt4xjgObF98IlMw5uCwm74nv9CwNkFI=;
        b=fhWIkOOsEEulFVkmJhfUNPeFhfOiH2AIDKZM0osi1+1wIZr6utkj66rBX2msPEApb1
         RJbZQHZZDT257uLXnSrSgi9ivd395nT8Ch6lXtVyIivf4Lm9kP7AAp6XN1jvyeHSzEd4
         gP5ZlF5WjTb1mghhc0jCqB3UI/IkGmvNuIZaCdiuwdXBhYjED5oFhlXozvjZI6TNsoTH
         vuKCmI4nafrQ205e2OSQMoO+B2eV7jnvDDJIsss8wkGa3/iezXv5WyTmIWfZvI7j+7RH
         I/h5ftM+HGKjSl7Pt0IwiDY1gj5vGxwSD+I9PV6jSZAPOi4sUHdamssIesjqpFXry9HI
         F/zA==
X-Gm-Message-State: AAQBX9cOWeHVik72gNhflMwGzwlMdVAcw8GYMD1aooe1PxMRa7kbGiHe
        bdMTUq4/qjdzHYopcBtyNsEuPc7y5zPX
X-Google-Smtp-Source: AKy350YBa8i/qR353DEb2eaMBwrV08XKVFCrwWg4R4Q0l2jXLRjJsUxHlw469MF+P8JG1CpGZn5q22bsfyeD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e705:3a3d:46e5:fb50])
 (user=irogers job=sendgmr) by 2002:a05:6902:1244:b0:b73:caa7:f05e with SMTP
 id t4-20020a056902124400b00b73caa7f05emr3090843ybu.2.1679599255478; Thu, 23
 Mar 2023 12:20:55 -0700 (PDT)
Date:   Thu, 23 Mar 2023 12:20:21 -0700
In-Reply-To: <20230323192028.135759-1-irogers@google.com>
Message-Id: <20230323192028.135759-3-irogers@google.com>
Mime-Version: 1.0
References: <20230323192028.135759-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v2 2/9] perf vendor events: Broadwellde v9 events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        samantha.alt@intel.com, weilin.wang@intel.com
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates descriptions and encodings. Adds BR_MISP_EXEC.INDIRECT events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/broadwellde/cache.json           | 105 +++----
 .../arch/x86/broadwellde/floating-point.json  |  45 +--
 .../arch/x86/broadwellde/frontend.json        |  18 +-
 .../arch/x86/broadwellde/memory.json          |  64 +++--
 .../arch/x86/broadwellde/pipeline.json        |  79 +++---
 .../arch/x86/broadwellde/uncore-cache.json    |  72 ++---
 .../arch/x86/broadwellde/uncore-memory.json   | 256 +++++++++++++++++-
 .../arch/x86/broadwellde/uncore-other.json    |  27 +-
 .../arch/x86/broadwellde/uncore-power.json    |  10 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 10 files changed, 495 insertions(+), 183 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/cache.json b/tools/=
perf/pmu-events/arch/x86/broadwellde/cache.json
index fcc99fd22b0a..6784331ac1cb 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/cache.json
@@ -8,7 +8,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Cycles a demand request was blocked due to Fi=
ll Buffers inavailability.",
+        "BriefDescription": "Cycles a demand request was blocked due to Fi=
ll Buffers unavailability.",
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL",
@@ -16,7 +16,7 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "L1D miss oustandings duration in cycles",
+        "BriefDescription": "L1D miss outstandings duration in cycles",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING",
         "PublicDescription": "This event counts duration of L1D miss outst=
anding, that is each cycle number of Fill Buffers (FB) outstanding required=
 by Demand Reads. FB either is held by demand loads, or it is held by non-d=
emand loads and gets hit at least once by demand. The valid outstanding int=
erval is defined until the FB deallocation by one of the following ways: fr=
om FB allocation, if FB is allocated by demand; from the demand Hit FB, if =
it is allocated by hardware or software prefetch.\nNote: In the L1D, a Dema=
nd Read contains cacheable or noncacheable demand loads, including ones cau=
sing cache-line splits and reads due to page walks resulted from any reques=
t type.",
@@ -139,7 +139,7 @@
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_HIT",
         "SampleAfterValue": "200003",
-        "UMask": "0x44"
+        "UMask": "0xc4"
     },
     {
         "BriefDescription": "L2 cache misses when fetching instructions.",
@@ -152,9 +152,9 @@
         "BriefDescription": "Demand Data Read requests that hit L2 cache",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
-        "PublicDescription": "This event counts the number of demand Data =
Read requests that hit L2 cache. Only not rejected loads are counted.",
+        "PublicDescription": "Counts the number of demand Data Read reques=
ts, initiated by load instructions, that hit L2 cache.",
         "SampleAfterValue": "200003",
-        "UMask": "0x41"
+        "UMask": "0xc1"
     },
     {
         "BriefDescription": "Demand Data Read miss L2, no rejects",
@@ -170,7 +170,7 @@
         "EventName": "L2_RQSTS.L2_PF_HIT",
         "PublicDescription": "This event counts the number of requests fro=
m the L2 hardware prefetchers that hit L2 cache. L3 prefetch new types.",
         "SampleAfterValue": "200003",
-        "UMask": "0x50"
+        "UMask": "0xd0"
     },
     {
         "BriefDescription": "L2 prefetch requests that miss L2 cache",
@@ -199,7 +199,7 @@
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_HIT",
         "SampleAfterValue": "200003",
-        "UMask": "0x42"
+        "UMask": "0xc2"
     },
     {
         "BriefDescription": "RFO requests that miss L2 cache.",
@@ -297,61 +297,62 @@
         "UMask": "0x4f"
     },
     {
-        "BriefDescription": "Retired load uops which data sources were L3 =
and cross-core snoop hits in on-pkg core cache. (Precise Event - PEBS)",
+        "BriefDescription": "Retired load uops which data sources were L3 =
and cross-core snoop hits in on-pkg core cache.",
         "Data_LA": "1",
         "Errata": "BDM100",
         "EventCode": "0xD2",
         "EventName": "MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT",
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts retired load uops which data sources were L3 hi=
t and a cross-core snoop hit in the on-pkg core cache.",
+        "PublicDescription": "This event counts retired load uops which da=
ta sources were L3 hit and a cross-core snoop hit in the on-pkg core cache.=
",
         "SampleAfterValue": "20011",
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "Retired load uops which data sources were Hit=
M responses from shared L3. (Precise Event - PEBS)",
+        "BriefDescription": "Retired load uops which data sources were Hit=
M responses from shared L3.",
         "Data_LA": "1",
         "Errata": "BDM100",
         "EventCode": "0xD2",
         "EventName": "MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HITM",
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts retired load uops which data sources were HitM =
responses from a core on same socket (shared L3).",
+        "PublicDescription": "This event counts retired load uops which da=
ta sources were HitM responses from a core on same socket (shared L3).",
         "SampleAfterValue": "20011",
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "Retired load uops which data sources were L3 =
hit and cross-core snoop missed in on-pkg core cache. (Precise Event - PEBS=
)",
+        "BriefDescription": "Retired load uops which data sources were L3 =
hit and cross-core snoop missed in on-pkg core cache.",
         "Data_LA": "1",
         "Errata": "BDM100",
         "EventCode": "0xD2",
         "EventName": "MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS",
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts retired load uops which data sources were L3 Hi=
t and a cross-core snoop missed in the on-pkg core cache.",
+        "PublicDescription": "This event counts retired load uops which da=
ta sources were L3 Hit and a cross-core snoop missed in the on-pkg core cac=
he.",
         "SampleAfterValue": "20011",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Retired load uops which data sources were hit=
s in L3 without snoops required. (Precise Event - PEBS)",
+        "BriefDescription": "Retired load uops which data sources were hit=
s in L3 without snoops required.",
         "Data_LA": "1",
         "Errata": "BDM100",
         "EventCode": "0xD2",
         "EventName": "MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_NONE",
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts retired load uops which data sources were hits =
in the last-level (L3) cache without snoops required.",
+        "PublicDescription": "This event counts retired load uops which da=
ta sources were hits in the last-level (L3) cache without snoops required."=
,
         "SampleAfterValue": "100003",
         "UMask": "0x8"
     },
     {
+        "BriefDescription": "Data from local DRAM either Snoop not needed =
or Snoop Miss (RspI)",
         "Data_LA": "1",
         "Errata": "BDE70, BDM100",
         "EventCode": "0xD3",
         "EventName": "MEM_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM",
         "PEBS": "1",
-        "PublicDescription": "This event counts retired load uops where th=
e data came from local DRAM. This does not include hardware prefetches. Thi=
s is a precise event.",
+        "PublicDescription": "Retired load uop whose Data Source was: loca=
l DRAM either Snoop not needed or Snoop Miss (RspI).",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Retired load uop whose Data Source was: remot=
e DRAM either Snoop not needed or Snoop Miss (RspI) (Precise Event)",
+        "BriefDescription": "Retired load uop whose Data Source was: remot=
e DRAM either Snoop not needed or Snoop Miss (RspI)",
         "Data_LA": "1",
         "Errata": "BDE70",
         "EventCode": "0xD3",
@@ -361,7 +362,7 @@
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "Retired load uop whose Data Source was: forwa=
rded from remote cache (Precise Event)",
+        "BriefDescription": "Retired load uop whose Data Source was: forwa=
rded from remote cache",
         "Data_LA": "1",
         "Errata": "BDE70",
         "EventCode": "0xD3",
@@ -371,7 +372,7 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "Retired load uop whose Data Source was: Remot=
e cache HITM (Precise Event)",
+        "BriefDescription": "Retired load uop whose Data Source was: Remot=
e cache HITM",
         "Data_LA": "1",
         "Errata": "BDE70",
         "EventCode": "0xD3",
@@ -381,69 +382,69 @@
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "Retired load uops which data sources were loa=
d uops missed L1 but hit FB due to preceding miss to the same cache line wi=
th data not ready. (Precise Event - PEBS)",
+        "BriefDescription": "Retired load uops which data sources were loa=
d uops missed L1 but hit FB due to preceding miss to the same cache line wi=
th data not ready.",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.HIT_LFB",
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts retired load uops which data sources were load =
uops missed L1 but hit a fill buffer due to a preceding miss to the same ca=
che line with the data not ready.\nNote: Only two data-sources of L1/FB are=
 applicable for AVX-256bit  even though the corresponding AVX load could be=
 serviced by a deeper level in the memory hierarchy. Data source is reporte=
d for the Low-half load.",
+        "PublicDescription": "This event counts retired load uops which da=
ta sources were load uops missed L1 but hit a fill buffer due to a precedin=
g miss to the same cache line with the data not ready.\nNote: Only two data=
-sources of L1/FB are applicable for AVX-256bit  even though the correspond=
ing AVX load could be serviced by a deeper level in the memory hierarchy. D=
ata source is reported for the Low-half load.",
         "SampleAfterValue": "100003",
         "UMask": "0x40"
     },
     {
-        "BriefDescription": "Retired load uops with L1 cache hits as data =
sources. (Precise Event - PEBS)",
+        "BriefDescription": "Retired load uops with L1 cache hits as data =
sources.",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_HIT",
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts retired load uops which data source were hits i=
n the nearest-level (L1) cache.\nNote: Only two data-sources of L1/FB are a=
pplicable for AVX-256bit  even though the corresponding AVX load could be s=
erviced by a deeper level in the memory hierarchy. Data source is reported =
for the Low-half load. This event also counts SW prefetches independent of =
the actual data source.",
+        "PublicDescription": "This event counts retired load uops which da=
ta sources were hits in the nearest-level (L1) cache.\nNote: Only two data-=
sources of L1/FB are applicable for AVX-256bit  even though the correspondi=
ng AVX load could be serviced by a deeper level in the memory hierarchy. Da=
ta source is reported for the Low-half load. This event also counts SW pref=
etches independent of the actual data source.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Retired load uops misses in L1 cache as data =
sources. Uses PEBS.",
+        "BriefDescription": "Retired load uops misses in L1 cache as data =
sources.",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_MISS",
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts retired load uops which data sources were misse=
s in the nearest-level (L1) cache. Counting excludes unknown and UC data so=
urce.",
+        "PublicDescription": "This event counts retired load uops which da=
ta sources were misses in the nearest-level (L1) cache. Counting excludes u=
nknown and UC data source.",
         "SampleAfterValue": "100003",
         "UMask": "0x8"
     },
     {
-        "BriefDescription": "Retired load uops with L2 cache hits as data =
sources. (Precise Event - PEBS)",
+        "BriefDescription": "Retired load uops with L2 cache hits as data =
sources.",
         "Data_LA": "1",
         "Errata": "BDM35",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts retired load uops which data sources were hits =
in the mid-level (L2) cache.",
+        "PublicDescription": "This event counts retired load uops which da=
ta sources were hits in the mid-level (L2) cache.",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "Retired load uops with L2 cache misses as dat=
a sources. Uses PEBS.",
+        "BriefDescription": "Miss in mid-level (L2) cache. Excludes Unknow=
n data-source.",
         "Data_LA": "1",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_MISS",
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts retired load uops which data sources were misse=
s in the mid-level (L2) cache. Counting excludes unknown and UC data source=
.",
+        "PublicDescription": "This event counts retired load uops which da=
ta sources were misses in the mid-level (L2) cache. Counting excludes unkno=
wn and UC data source.",
         "SampleAfterValue": "50021",
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "Hit in last-level (L3) cache. Excludes Unknow=
n data-source. (Precise Event - PEBS)",
+        "BriefDescription": "Retired load uops which data sources were dat=
a hits in L3 without snoops required.",
         "Data_LA": "1",
         "Errata": "BDM100",
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L3_HIT",
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts retired load uops which data sources were data =
hits in the last-level (L3) cache without snoops required.",
+        "PublicDescription": "This event counts retired load uops which da=
ta sources were data hits in the last-level (L3) cache without snoops requi=
red.",
         "SampleAfterValue": "50021",
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "Miss in last-level (L3) cache. Excludes Unkno=
wn data-source. (Precise Event - PEBS).",
+        "BriefDescription": "Miss in last-level (L3) cache. Excludes Unkno=
wn data-source.",
         "Data_LA": "1",
         "Errata": "BDM100, BDE70",
         "EventCode": "0xD1",
@@ -453,73 +454,73 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "All retired load uops. (Precise Event - PEBS)=
",
+        "BriefDescription": "Retired load uops.",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts load uops retired to the architected path with =
a filter on bits 0 and 1 applied.\nNote: This event ?ounts AVX-256bit load/=
store double-pump memory uops as a single uop at retirement. This event als=
o counts SW prefetches.",
+        "PublicDescription": "Counts all retired load uops. This event acc=
ounts for SW prefetch uops of PREFETCHNTA or PREFETCHT0/1/2 or PREFETCHW.",
         "SampleAfterValue": "2000003",
         "UMask": "0x81"
     },
     {
-        "BriefDescription": "Retired store uops that split across a cachel=
ine boundary. (Precise Event - PEBS)",
+        "BriefDescription": "Retired store uops.",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts store uops retired to the architected path with=
 a filter on bits 0 and 1 applied.\nNote: This event ?ounts AVX-256bit load=
/store double-pump memory uops as a single uop at retirement.",
+        "PublicDescription": "Counts all retired store uops.",
         "SampleAfterValue": "2000003",
         "UMask": "0x82"
     },
     {
-        "BriefDescription": "Retired load uops with locked access. (Precis=
e Event - PEBS)",
+        "BriefDescription": "Retired load uops with locked access.",
         "Data_LA": "1",
         "Errata": "BDM35",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.LOCK_LOADS",
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts load uops with locked access retired to the arc=
hitected path.",
+        "PublicDescription": "This event counts load uops with locked acce=
ss retired to the architected path.",
         "SampleAfterValue": "100007",
         "UMask": "0x21"
     },
     {
-        "BriefDescription": "Retired load uops that split across a cacheli=
ne boundary.(Precise Event - PEBS)",
+        "BriefDescription": "Retired load uops that split across a cacheli=
ne boundary.",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts line-splitted load uops retired to the architec=
ted path. A line split is across 64B cache-line which includes a page split=
 (4K).",
+        "PublicDescription": "This event counts line-splitted load uops re=
tired to the architected path. A line split is across 64B cache-line which =
includes a page split (4K).",
         "SampleAfterValue": "100003",
         "UMask": "0x41"
     },
     {
-        "BriefDescription": "Retired store uops that split across a cachel=
ine boundary. (Precise Event - PEBS)",
+        "BriefDescription": "Retired store uops that split across a cachel=
ine boundary.",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts line-splitted store uops retired to the archite=
cted path. A line split is across 64B cache-line which includes a page spli=
t (4K).",
+        "PublicDescription": "This event counts line-splitted store uops r=
etired to the architected path. A line split is across 64B cache-line which=
 includes a page split (4K).",
         "SampleAfterValue": "100003",
         "UMask": "0x42"
     },
     {
-        "BriefDescription": "Retired load uops that miss the STLB. (Precis=
e Event - PEBS)",
+        "BriefDescription": "Retired load uops that miss the STLB.",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.STLB_MISS_LOADS",
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts load uops with true STLB miss retired to the ar=
chitected path. True STLB miss is an uop triggering page walk that gets com=
pleted without blocks, and later gets retired. This page walk can end up wi=
th or without a fault.",
+        "PublicDescription": "This event counts load uops with true STLB m=
iss retired to the architected path. True STLB miss is an uop triggering pa=
ge walk that gets completed without blocks, and later gets retired. This pa=
ge walk can end up with or without a fault.",
         "SampleAfterValue": "100003",
         "UMask": "0x11"
     },
     {
-        "BriefDescription": "Retired store uops that miss the STLB. (Preci=
se Event - PEBS)",
+        "BriefDescription": "Retired store uops that miss the STLB.",
         "Data_LA": "1",
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.STLB_MISS_STORES",
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts store uops true STLB miss retired to the archit=
ected path. True STLB miss is an uop triggering page walk that gets complet=
ed without blocks, and later gets retired. This page walk can end up with o=
r without a fault.",
+        "PublicDescription": "This event counts store uops with true STLB =
miss retired to the architected path. True STLB miss is an uop triggering p=
age walk that gets completed without blocks, and later gets retired. This p=
age walk can end up with or without a fault.",
         "SampleAfterValue": "100003",
         "UMask": "0x12"
     },
@@ -532,10 +533,18 @@
         "UMask": "0x8"
     },
     {
-        "BriefDescription": "Cacheable and noncachaeble code read requests=
",
+        "BriefDescription": "Any memory transaction that reached the SQ.",
+        "EventCode": "0xb0",
+        "EventName": "OFFCORE_REQUESTS.ALL_REQUESTS",
+        "PublicDescription": "This event counts memory transactions reache=
d the super queue including requests initiated by the core, all L3 prefetch=
es, page walks, and so on.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Cacheable and non-cacheable code read request=
s",
         "EventCode": "0xB0",
         "EventName": "OFFCORE_REQUESTS.DEMAND_CODE_RD",
-        "PublicDescription": "This event counts both cacheable and noncach=
aeble code read requests.",
+        "PublicDescription": "This event counts both cacheable and non-cac=
heable code read requests.",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/floating-point.json=
 b/tools/perf/pmu-events/arch/x86/broadwellde/floating-point.json
index 0b3f026158e2..e4826dc7f797 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/floating-point.json
@@ -1,70 +1,77 @@
 [
     {
-        "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d double precision floating-point instructions retired.  Each count represe=
nts 2 computations. Applies to SSE* and AVX* packed double precision floati=
ng-point instructions: ADD SUB MUL DIV MIN MAX SQRT DPP FM(N)ADD/SUB.  DPP =
and FM(N)ADD/SUB instructions count twice as they perform multiple calculat=
ions per element.",
-        "EventCode": "0xC7",
+        "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d double precision floating-point instructions retired; some instructions w=
ill count twice as noted below.  Each count represents 2 computation operat=
ions, one for each element.  Applies to SSE* and AVX* packed double precisi=
on floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQ=
RT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they=
 perform 2 calculations per element.",
+        "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 2 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as the=
y perform 2 calculations per element. The DAZ and FTZ flags in the MXCSR re=
gister need to be set when using these events.",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d single precision floating-point instructions retired.  Each count represe=
nts 4 computations. Applies to SSE* and AVX* packed single precision floati=
ng-point instructions: ADD SUB MUL DIV MIN MAX RCP RSQRT SQRT DPP FM(N)ADD/=
SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform multipl=
e calculations per element.",
-        "EventCode": "0xC7",
+        "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d single precision floating-point instructions retired; some instructions w=
ill count twice as noted below.  Each count represents 4 computation operat=
ions, one for each element.  Applies to SSE* and AVX* packed single precisi=
on floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQ=
RT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twi=
ce as they perform 4 calculations per element.",
+        "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     },
     {
-        "BriefDescription": "Number of SSE/AVX computational 256-bit packe=
d double precision floating-point instructions retired.  Each count represe=
nts 4 computations. Applies to SSE* and AVX* packed double precision floati=
ng-point instructions: ADD SUB MUL DIV MIN MAX SQRT DPP FM(N)ADD/SUB.  DPP =
and FM(N)ADD/SUB instructions count twice as they perform multiple calculat=
ions per element.",
-        "EventCode": "0xC7",
+        "BriefDescription": "Number of SSE/AVX computational 256-bit packe=
d double precision floating-point instructions retired; some instructions w=
ill count twice as noted below.  Each count represents 4 computation operat=
ions, one for each element.  Applies to SSE* and AVX* packed double precisi=
on floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQ=
RT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perform 4 c=
alculations per element.",
+        "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perform 2 =
calculations per element. The DAZ and FTZ flags in the MXCSR register need =
to be set when using these events.",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "Number of SSE/AVX computational 256-bit packe=
d single precision floating-point instructions retired.  Each count represe=
nts 8 computations. Applies to SSE* and AVX* packed single precision floati=
ng-point instructions: ADD SUB MUL DIV MIN MAX RCP RSQRT SQRT DPP FM(N)ADD/=
SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform multipl=
e calculations per element.",
+        "BriefDescription": "Number of SSE/AVX computational 256-bit packe=
d single precision floating-point instructions retired; some instructions w=
ill count twice as noted below.  Each count represents 8 computation operat=
ions, one for each element.  Applies to SSE* and AVX* packed single precisi=
on floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQ=
RT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twi=
ce as they perform 8 calculations per element.",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 8 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
         "SampleAfterValue": "2000003",
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "Number of SSE/AVX computational double precis=
ion floating-point instructions retired. Applies to SSE* and AVX*scalar, do=
uble and single precision floating-point: ADD SUB MUL DIV MIN MAX SQRT DPP =
FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perfor=
m multiple calculations per element.  ?.",
-        "EventCode": "0xC7",
+        "BriefDescription": "Number of SSE/AVX computational double precis=
ion floating-point instructions retired; some instructions will count twice=
 as noted below. Applies to SSE* and AVX* scalar and packed double precisio=
n floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQR=
T DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they =
perform multiple calculations per element.",
+        "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.DOUBLE",
         "SampleAfterValue": "2000006",
         "UMask": "0x15"
     },
     {
-        "BriefDescription": "Number of SSE/AVX computational packed floati=
ng-point instructions retired. Applies to SSE* and AVX*, packed, double and=
 single precision floating-point: ADD SUB MUL DIV MIN MAX RSQRT RCP SQRT DP=
P FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perf=
orm multiple calculations per element.",
-        "EventCode": "0xC7",
+        "BriefDescription": "Number of SSE/AVX computational packed floati=
ng-point instructions retired; some instructions will count twice as noted =
below. Applies to SSE* and AVX* packed double and single precision floating=
-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT RSQRT RC=
P DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they =
perform multiple calculations per element.",
+        "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.PACKED",
         "SampleAfterValue": "2000004",
         "UMask": "0x3c"
     },
     {
-        "BriefDescription": "Number of SSE/AVX computational scalar floati=
ng-point instructions retired. Applies to SSE* and AVX* scalar, double and =
single precision floating-point: ADD SUB MUL DIV MIN MAX RSQRT RCP SQRT FM(=
N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform multiple c=
alculations per element.",
-        "EventCode": "0xC7",
+        "BriefDescription": "Number of SSE/AVX computational scalar floati=
ng-point instructions retired; some instructions will count twice as noted =
below. Each count represents 1 computation operation.   Applies to SSE* and=
 AVX* scalar double and single precision floating-point instructions: ADD S=
UB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB. FM(N)ADD/SUB instructions c=
ount twice as they perform multiple calculations per element.",
+        "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR",
+        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision and double precision floating-point instructions retired; some =
instructions will count twice as noted below.  Each count represents 1 comp=
utational operation. Applies to SSE* and AVX* scalar single precision float=
ing-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB=
.  FM(N)ADD/SUB instructions count twice as they perform 2 calculations per=
 element. The DAZ and FTZ flags in the MXCSR register need to be set when u=
sing these events.",
         "SampleAfterValue": "2000003",
         "UMask": "0x3"
     },
     {
-        "BriefDescription": "Number of SSE/AVX computational scalar double=
 precision floating-point instructions retired.  Each count represents 1 co=
mputation. Applies to SSE* and AVX* scalar double precision floating-point =
instructions: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB inst=
ructions count twice as they perform multiple calculations per element.",
-        "EventCode": "0xC7",
+        "BriefDescription": "Number of SSE/AVX computational scalar double=
 precision floating-point instructions retired; some instructions will coun=
t twice as noted below.  Each count represents 1 computational operation. A=
pplies to SSE* and AVX* scalar double precision floating-point instructions=
: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions cou=
nt twice as they perform multiple calculations per element.",
+        "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR_DOUBLE",
+        "PublicDescription": "Number of SSE/AVX computational scalar doubl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar double precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions co=
unt twice as they perform 2 calculations per element. The DAZ and FTZ flags=
 in the MXCSR register need to be set when using these events.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Number of SSE/AVX computational scalar single=
 precision floating-point instructions retired.  Each count represents 1 co=
mputation. Applies to SSE* and AVX* scalar single precision floating-point =
instructions: ADD SUB MUL DIV MIN MAX RCP RSQRT SQRT FM(N)ADD/SUB.  FM(N)AD=
D/SUB instructions count twice as they perform multiple calculations per el=
ement.",
-        "EventCode": "0xC7",
+        "BriefDescription": "Number of SSE/AVX computational scalar single=
 precision floating-point instructions retired; some instructions will coun=
t twice as noted below.  Each count represents 1 computational operation. A=
pplies to SSE* and AVX* scalar single precision floating-point instructions=
: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB instru=
ctions count twice as they perform multiple calculations per element.",
+        "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR_SINGLE",
+        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar single precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB instr=
uctions count twice as they perform 2 calculations per element. The DAZ and=
 FTZ flags in the MXCSR register need to be set when using these events.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "Number of SSE/AVX computational single precis=
ion floating-point instructions retired. Applies to SSE* and AVX*scalar, do=
uble and single precision floating-point: ADD SUB MUL DIV MIN MAX RCP RSQRT=
 SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as t=
hey perform multiple calculations per element. ?.",
-        "EventCode": "0xC7",
+        "BriefDescription": "Number of SSE/AVX computational single precis=
ion floating-point instructions retired; some instructions will count twice=
 as noted below. Applies to SSE* and AVX* scalar and packed single precisio=
n floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQR=
T RSQRT RCP SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count=
 twice as they perform multiple calculations per element.",
+        "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SINGLE",
         "SampleAfterValue": "2000005",
         "UMask": "0x2a"
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/frontend.json b/too=
ls/perf/pmu-events/arch/x86/broadwellde/frontend.json
index d0f6678609ae..bd5da39564e1 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/frontend.json
@@ -125,16 +125,16 @@
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "Cycles when uops are being delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy",
+        "BriefDescription": "Cycles when uops are being delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequencer (MS) is busy",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_CYCLES",
-        "PublicDescription": "This event counts cycles during which uops a=
re being delivered to Instruction Decode Queue (IDQ) while the Microcode Se=
quenser (MS) is busy. Counting includes uops that may bypass the IDQ. Uops =
maybe initiated by Decode Stream Buffer (DSB) or MITE.",
+        "PublicDescription": "This event counts cycles during which uops a=
re being delivered to Instruction Decode Queue (IDQ) while the Microcode Se=
quencer (MS) is busy. Counting includes uops that may bypass the IDQ. Uops =
maybe initiated by Decode Stream Buffer (DSB) or MITE.",
         "SampleAfterValue": "2000003",
         "UMask": "0x30"
     },
     {
-        "BriefDescription": "Cycles when uops initiated by Decode Stream B=
uffer (DSB) are being delivered to Instruction Decode Queue (IDQ) while Mic=
rocode Sequenser (MS) is busy",
+        "BriefDescription": "Cycles when uops initiated by Decode Stream B=
uffer (DSB) are being delivered to Instruction Decode Queue (IDQ) while Mic=
rocode Sequencer (MS) is busy",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_DSB_CYCLES",
@@ -143,7 +143,7 @@
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "Deliveries to Instruction Decode Queue (IDQ) =
initiated by Decode Stream Buffer (DSB) while Microcode Sequenser (MS) is b=
usy",
+        "BriefDescription": "Deliveries to Instruction Decode Queue (IDQ) =
initiated by Decode Stream Buffer (DSB) while Microcode Sequencer (MS) is b=
usy",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x79",
@@ -153,7 +153,7 @@
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "Uops initiated by Decode Stream Buffer (DSB) =
that are being delivered to Instruction Decode Queue (IDQ) while Microcode =
Sequenser (MS) is busy",
+        "BriefDescription": "Uops initiated by Decode Stream Buffer (DSB) =
that are being delivered to Instruction Decode Queue (IDQ) while Microcode =
Sequencer (MS) is busy",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_DSB_UOPS",
         "PublicDescription": "This event counts the number of uops initiat=
ed by Decode Stream Buffer (DSB) that are being delivered to Instruction De=
code Queue (IDQ) while the Microcode Sequencer (MS) is busy. Counting inclu=
des uops that may bypass the IDQ.",
@@ -161,10 +161,10 @@
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "Uops initiated by MITE and delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy",
+        "BriefDescription": "Uops initiated by MITE and delivered to Instr=
uction Decode Queue (IDQ) while Microcode Sequencer (MS) is busy",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_MITE_UOPS",
-        "PublicDescription": "This event counts the number of uops initiat=
ed by MITE and delivered to Instruction Decode Queue (IDQ) while the Microc=
ode Sequenser (MS) is busy. Counting includes uops that may bypass the IDQ.=
",
+        "PublicDescription": "This event counts the number of uops initiat=
ed by MITE and delivered to Instruction Decode Queue (IDQ) while the Microc=
ode Sequencer (MS) is busy. Counting includes uops that may bypass the IDQ.=
",
         "SampleAfterValue": "2000003",
         "UMask": "0x20"
     },
@@ -178,10 +178,10 @@
         "UMask": "0x30"
     },
     {
-        "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) while Microcode Sequenser (MS) is busy",
+        "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) while Microcode Sequencer (MS) is busy",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_UOPS",
-        "PublicDescription": "This event counts the total number of uops d=
elivered to Instruction Decode Queue (IDQ) while the Microcode Sequenser (M=
S) is busy. Counting includes uops that may bypass the IDQ. Uops maybe init=
iated by Decode Stream Buffer (DSB) or MITE.",
+        "PublicDescription": "This event counts the total number of uops d=
elivered to Instruction Decode Queue (IDQ) while the Microcode Sequencer (M=
S) is busy. Counting includes uops that may bypass the IDQ. Uops maybe init=
iated by Decode Stream Buffer (DSB) or MITE.",
         "SampleAfterValue": "2000003",
         "UMask": "0x30"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/memory.json b/tools=
/perf/pmu-events/arch/x86/broadwellde/memory.json
index 12cc384d7f18..041b6ff4062e 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/memory.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/memory.json
@@ -1,10 +1,10 @@
 [
     {
-        "BriefDescription": "Number of times HLE abort was triggered (PEBS=
)",
+        "BriefDescription": "Number of times HLE abort was triggered",
         "EventCode": "0xc8",
         "EventName": "HLE_RETIRED.ABORTED",
         "PEBS": "1",
-        "PublicDescription": "Number of times HLE abort was triggered (PEB=
S).",
+        "PublicDescription": "Number of times HLE abort was triggered.",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
@@ -73,98 +73,106 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "Loads with latency value being above 128",
+        "BriefDescription": "Randomly selected loads with latency value be=
ing above 128",
+        "Data_LA": "1",
         "Errata": "BDM100, BDM35",
-        "EventCode": "0xCD",
+        "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x80",
         "PEBS": "2",
-        "PublicDescription": "This event counts loads with latency value b=
eing above 128.",
+        "PublicDescription": "Counts randomly selected loads with latency =
value being above 128.",
         "SampleAfterValue": "1009",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Loads with latency value being above 16",
+        "BriefDescription": "Randomly selected loads with latency value be=
ing above 16",
+        "Data_LA": "1",
         "Errata": "BDM100, BDM35",
-        "EventCode": "0xCD",
+        "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x10",
         "PEBS": "2",
-        "PublicDescription": "This event counts loads with latency value b=
eing above 16.",
+        "PublicDescription": "Counts randomly selected loads with latency =
value being above 16.",
         "SampleAfterValue": "20011",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Loads with latency value being above 256",
+        "BriefDescription": "Randomly selected loads with latency value be=
ing above 256",
+        "Data_LA": "1",
         "Errata": "BDM100, BDM35",
-        "EventCode": "0xCD",
+        "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x100",
         "PEBS": "2",
-        "PublicDescription": "This event counts loads with latency value b=
eing above 256.",
+        "PublicDescription": "Counts randomly selected loads with latency =
value being above 256.",
         "SampleAfterValue": "503",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Loads with latency value being above 32",
+        "BriefDescription": "Randomly selected loads with latency value be=
ing above 32",
+        "Data_LA": "1",
         "Errata": "BDM100, BDM35",
-        "EventCode": "0xCD",
+        "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x20",
         "PEBS": "2",
-        "PublicDescription": "This event counts loads with latency value b=
eing above 32.",
+        "PublicDescription": "Counts randomly selected loads with latency =
value being above 32.",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Loads with latency value being above 4",
+        "BriefDescription": "Randomly selected loads with latency value be=
ing above 4",
+        "Data_LA": "1",
         "Errata": "BDM100, BDM35",
-        "EventCode": "0xCD",
+        "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x4",
         "PEBS": "2",
-        "PublicDescription": "This event counts loads with latency value b=
eing above four.",
+        "PublicDescription": "Counts randomly selected loads with latency =
value being above four.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Loads with latency value being above 512",
+        "BriefDescription": "Randomly selected loads with latency value be=
ing above 512",
+        "Data_LA": "1",
         "Errata": "BDM100, BDM35",
-        "EventCode": "0xCD",
+        "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x200",
         "PEBS": "2",
-        "PublicDescription": "This event counts loads with latency value b=
eing above 512.",
+        "PublicDescription": "Counts randomly selected loads with latency =
value being above 512.",
         "SampleAfterValue": "101",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Loads with latency value being above 64",
+        "BriefDescription": "Randomly selected loads with latency value be=
ing above 64",
+        "Data_LA": "1",
         "Errata": "BDM100, BDM35",
-        "EventCode": "0xCD",
+        "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x40",
         "PEBS": "2",
-        "PublicDescription": "This event counts loads with latency value b=
eing above 64.",
+        "PublicDescription": "Counts randomly selected loads with latency =
value being above 64.",
         "SampleAfterValue": "2003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Loads with latency value being above 8",
+        "BriefDescription": "Randomly selected loads with latency value be=
ing above 8",
+        "Data_LA": "1",
         "Errata": "BDM100, BDM35",
-        "EventCode": "0xCD",
+        "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x8",
         "PEBS": "2",
-        "PublicDescription": "This event counts loads with latency value b=
eing above eight.",
+        "PublicDescription": "Counts randomly selected loads with latency =
value being above eight.",
         "SampleAfterValue": "50021",
         "UMask": "0x1"
     },
@@ -185,11 +193,11 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "Number of times RTM abort was triggered (PEBS=
)",
+        "BriefDescription": "Number of times RTM abort was triggered",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED",
         "PEBS": "1",
-        "PublicDescription": "Number of times RTM abort was triggered (PEB=
S).",
+        "PublicDescription": "Number of times RTM abort was triggered .",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/broadwellde/pipeline.json
index 9e7d66b07f01..9a902d2160e6 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
@@ -129,11 +129,11 @@
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "Conditional branch instructions retired. (Pre=
cise Event - PEBS)",
+        "BriefDescription": "Conditional branch instructions retired.",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.CONDITIONAL",
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts conditional branch instructions retired.",
+        "PublicDescription": "This event counts conditional branch instruc=
tions retired.",
         "SampleAfterValue": "400009",
         "UMask": "0x1"
     },
@@ -147,38 +147,38 @@
         "UMask": "0x40"
     },
     {
-        "BriefDescription": "Direct and indirect near call instructions re=
tired. (Precise Event - PEBS)",
+        "BriefDescription": "Direct and indirect near call instructions re=
tired.",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts both direct and indirect near call instructions=
 retired.",
+        "PublicDescription": "This event counts both direct and indirect n=
ear call instructions retired.",
         "SampleAfterValue": "100007",
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "Direct and indirect macro near call instructi=
ons retired (captured in ring 3). (Precise Event - PEBS)",
+        "BriefDescription": "Direct and indirect macro near call instructi=
ons retired (captured in ring 3).",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL_R3",
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts both direct and indirect macro near call instru=
ctions retired (captured in ring 3).",
+        "PublicDescription": "This event counts both direct and indirect m=
acro near call instructions retired (captured in ring 3).",
         "SampleAfterValue": "100007",
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "Return instructions retired. (Precise Event -=
 PEBS)",
+        "BriefDescription": "Return instructions retired.",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts return instructions retired.",
+        "PublicDescription": "This event counts return instructions retire=
d.",
         "SampleAfterValue": "100007",
         "UMask": "0x8"
     },
     {
-        "BriefDescription": "Taken branch instructions retired. (Precise E=
vent - PEBS)",
+        "BriefDescription": "Taken branch instructions retired.",
         "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts taken branch instructions retired.",
+        "PublicDescription": "This event counts taken branch instructions =
retired.",
         "SampleAfterValue": "400009",
         "UMask": "0x20"
     },
@@ -214,6 +214,14 @@
         "SampleAfterValue": "200003",
         "UMask": "0xc4"
     },
+    {
+        "BriefDescription": "Speculative mispredicted indirect branches",
+        "EventCode": "0x89",
+        "EventName": "BR_MISP_EXEC.INDIRECT",
+        "PublicDescription": "Counts speculatively miss-predicted indirect=
 branches at execution time. Counts for indirect near CALL or JMP instructi=
ons (RET excluded).",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe4"
+    },
     {
         "BriefDescription": "Not taken speculative and retired mispredicte=
d macro conditional branches",
         "EventCode": "0x89",
@@ -270,29 +278,29 @@
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "Mispredicted conditional branch instructions =
retired. (Precise Event - PEBS)",
+        "BriefDescription": "Mispredicted conditional branch instructions =
retired.",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.CONDITIONAL",
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts mispredicted conditional branch instructions re=
tired.",
+        "PublicDescription": "This event counts mispredicted conditional b=
ranch instructions retired.",
         "SampleAfterValue": "400009",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "number of near branch instructions retired th=
at were mispredicted and taken. (Precise Event - PEBS).",
+        "BriefDescription": "number of near branch instructions retired th=
at were mispredicted and taken.",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
         "PEBS": "1",
-        "PublicDescription": "Number of near branch instructions retired t=
hat were mispredicted and taken. (Precise Event - PEBS).",
+        "PublicDescription": "Number of near branch instructions retired t=
hat were mispredicted and taken.",
         "SampleAfterValue": "400009",
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "This event counts the number of mispredicted =
ret instructions retired.(Precise Event)",
+        "BriefDescription": "This event counts the number of mispredicted =
ret instructions retired. Non PEBS",
         "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.RET",
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts mispredicted return instructions retired.",
+        "PublicDescription": "This event counts mispredicted return instru=
ctions retired.",
         "SampleAfterValue": "100007",
         "UMask": "0x8"
     },
@@ -300,7 +308,7 @@
         "BriefDescription": "Count XClk pulses when this thread is unhalte=
d and the other thread is halted.",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE",
-        "SampleAfterValue": "2000003",
+        "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
     {
@@ -308,7 +316,7 @@
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_THREAD_UNHALTED.REF_XCLK",
         "PublicDescription": "This is a fixed-frequency event programmed t=
o general counters. It counts when the core is unhalted at 100 Mhz.",
-        "SampleAfterValue": "2000003",
+        "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
@@ -316,14 +324,14 @@
         "BriefDescription": "Reference cycles when the at least one thread=
 on the physical core is unhalted (counts at 100 MHz rate).",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY",
-        "SampleAfterValue": "2000003",
+        "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Count XClk pulses when this thread is unhalte=
d and the other thread is halted.",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
-        "SampleAfterValue": "2000003",
+        "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
     {
@@ -338,7 +346,7 @@
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.REF_XCLK",
         "PublicDescription": "Reference cycles when the thread is unhalted=
 (counts at 100 MHz rate).",
-        "SampleAfterValue": "2000003",
+        "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
@@ -346,7 +354,7 @@
         "BriefDescription": "Reference cycles when the at least one thread=
 on the physical core is unhalted (counts at 100 MHz rate).",
         "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.REF_XCLK_ANY",
-        "SampleAfterValue": "2000003",
+        "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
@@ -500,7 +508,7 @@
         "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction.",
         "EventCode": "0x87",
         "EventName": "ILD_STALL.LCP",
-        "PublicDescription": "This event counts stalls occured due to chan=
ging prefix length (66, 67 or REX.W when they change the length of the deco=
ded instruction). Occurrences counting is proportional to the number of pre=
fixes in a 16B-line. This may result in the following penalties: three-cycl=
e penalty for each LCP in a 16-byte chunk.",
+        "PublicDescription": "This event counts stalls occurred due to cha=
nging prefix length (66, 67 or REX.W when they change the length of the dec=
oded instruction). Occurrences counting is proportional to the number of pr=
efixes in a 16B-line. This may result in the following penalties: three-cyc=
le penalty for each LCP in a 16-byte chunk.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -681,9 +689,9 @@
     },
     {
         "BriefDescription": "Resource-related stall cycles",
-        "EventCode": "0xA2",
+        "EventCode": "0xa2",
         "EventName": "RESOURCE_STALLS.ANY",
-        "PublicDescription": "This event counts resource-related stall cyc=
les. Reasons for stalls can be as follows:\n - *any* u-arch structure got f=
ull (LB, SB, RS, ROB, BOB, LM, Physical Register Reclaim Table (PRRT), or P=
hysical History Table (PHT) slots)\n - *any* u-arch structure got empty (li=
ke INT/SIMD FreeLists)\n - FPU control word (FPCW), MXCSR\nand others. This=
 counts cycles that the pipeline backend blocked uop delivery from the fron=
t end.",
+        "PublicDescription": "This event counts resource-related stall cyc=
les.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -909,7 +917,7 @@
     },
     {
         "AnyThread": "1",
-        "BriefDescription": "Cycles per core when uops are exectuted in po=
rt 0.",
+        "BriefDescription": "Cycles per core when uops are executed in por=
t 0.",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_0_CORE",
         "SampleAfterValue": "2000003",
@@ -925,7 +933,7 @@
     },
     {
         "AnyThread": "1",
-        "BriefDescription": "Cycles per core when uops are exectuted in po=
rt 1.",
+        "BriefDescription": "Cycles per core when uops are executed in por=
t 1.",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_1_CORE",
         "SampleAfterValue": "2000003",
@@ -973,7 +981,7 @@
     },
     {
         "AnyThread": "1",
-        "BriefDescription": "Cycles per core when uops are exectuted in po=
rt 4.",
+        "BriefDescription": "Cycles per core when uops are executed in por=
t 4.",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_4_CORE",
         "SampleAfterValue": "2000003",
@@ -989,7 +997,7 @@
     },
     {
         "AnyThread": "1",
-        "BriefDescription": "Cycles per core when uops are exectuted in po=
rt 5.",
+        "BriefDescription": "Cycles per core when uops are executed in por=
t 5.",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_5_CORE",
         "SampleAfterValue": "2000003",
@@ -1005,7 +1013,7 @@
     },
     {
         "AnyThread": "1",
-        "BriefDescription": "Cycles per core when uops are exectuted in po=
rt 6.",
+        "BriefDescription": "Cycles per core when uops are executed in por=
t 6.",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_6_CORE",
         "SampleAfterValue": "2000003",
@@ -1068,21 +1076,20 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Actually retired uops. (Precise Event - PEBS)=
",
-        "Data_LA": "1",
+        "BriefDescription": "Actually retired uops.",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.ALL",
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts all actually retired uops. Counting increments =
by two for micro-fused uops, and by one for macro-fused and other uops. Max=
imal increment value for one cycle is eight.",
+        "PublicDescription": "This event counts all actually retired uops.=
 Counting increments by two for micro-fused uops, and by one for macro-fuse=
d and other uops. Maximal increment value for one cycle is eight.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Retirement slots used. (Precise Event - PEBS)=
",
+        "BriefDescription": "Retirement slots used.",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.RETIRE_SLOTS",
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts the number of retirement slots used.",
+        "PublicDescription": "This event counts the number of retirement s=
lots used.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -1098,7 +1105,7 @@
     },
     {
         "BriefDescription": "Cycles with less than 10 actually retired uop=
s.",
-        "CounterMask": "10",
+        "CounterMask": "16",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.TOTAL_CYCLES",
         "Invert": "1",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json b=
/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
index b8c9845308b2..2bf23ef7bfac 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
@@ -78,7 +78,7 @@
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.WRITE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Writeback transactions from L2 to the=
 LLC  This includes all write transactions -- both Cachable and UC.",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Writeback transactions from L2 to the=
 LLC  This includes all write transactions -- both Cacheable and UC.",
         "UMask": "0x5",
         "Unit": "CBO"
     },
@@ -968,7 +968,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.ALL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserted=
 into the TOR.    This includes requests that reside in the TOR for a short=
 time, such as LLC Hits that do not need to snoop cores or requests that ge=
t rejected and have to be retried through one of the ingress queues.  The T=
OR is more commonly a bottleneck in skews with smaller core counts, where t=
he ratio of RTIDs to TOR entries is larger.  Note that there are reserved T=
OR entries for various request types, so it is possible that a given reques=
t type be blocked with an occupancy that is less than 20.  Also note that g=
enerally requests will not be able to arbitrate into the TOR pipeline if th=
ere are no available TOR slots.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserte=
d into the TOR.    This includes requests that reside in the TOR for a shor=
t time, such as LLC Hits that do not need to snoop cores or requests that g=
et rejected and have to be retried through one of the ingress queues.  The =
TOR is more commonly a bottleneck in skews with smaller core counts, where =
the ratio of RTIDs to TOR entries is larger.  Note that there are reserved =
TOR entries for various request types, so it is possible that a given reque=
st type be blocked with an occupancy that is less than 20.  Also note that =
generally requests will not be able to arbitrate into the TOR pipeline if t=
here are no available TOR slots.",
         "UMask": "0x8",
         "Unit": "CBO"
     },
@@ -977,7 +977,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.EVICTION",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Eviction transactions ins=
erted into the TOR.  Evictions can be quick, such as when the line is in th=
e F, S, or E states and no core valid bits are set.  They can also be longe=
r if either CV bits are set (so the cores need to be snooped) and/or if the=
re is a HitM (in which case it is necessary to write the request out to mem=
ory).",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Eviction transactions in=
serted into the TOR.  Evictions can be quick, such as when the line is in t=
he F, S, or E states and no core valid bits are set.  They can also be long=
er if either CV bits are set (so the cores need to be snooped) and/or if th=
ere is a HitM (in which case it is necessary to write the request out to me=
mory).",
         "UMask": "0x4",
         "Unit": "CBO"
     },
@@ -986,7 +986,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.LOCAL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserted=
 into the TOR that are satisifed by locally HOMed memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserte=
d into the TOR that are satisfied by locally HOMed memory.",
         "UMask": "0x28",
         "Unit": "CBO"
     },
@@ -995,7 +995,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.LOCAL_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisif=
ed by an opcode,  inserted into the TOR that are satisifed by locally HOMed=
 memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisf=
ied by an opcode,  inserted into the TOR that are satisfied by locally HOMe=
d memory.",
         "UMask": "0x21",
         "Unit": "CBO"
     },
@@ -1004,7 +1004,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_LOCAL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that are satisifed by locally HOMed memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that are satisfied by locally HOMed memory.",
         "UMask": "0x2a",
         "Unit": "CBO"
     },
@@ -1013,7 +1013,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satisi=
fed by an opcode, inserted into the TOR that are satisifed by locally HOMed=
 memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satis=
fied by an opcode, inserted into the TOR that are satisfied by locally HOMe=
d memory.",
         "UMask": "0x23",
         "Unit": "CBO"
     },
@@ -1022,7 +1022,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match an opcode.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
         "UMask": "0x3",
         "Unit": "CBO"
     },
@@ -1031,7 +1031,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_REMOTE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that are satisifed by remote caches or remote memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that are satisfied by remote caches or remote memory.",
         "UMask": "0x8a",
         "Unit": "CBO"
     },
@@ -1040,7 +1040,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satisi=
fed by an opcode,  inserted into the TOR that are satisifed by remote cache=
s or remote memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satis=
fied by an opcode,  inserted into the TOR that are satisfied by remote cach=
es or remote memory.",
         "UMask": "0x83",
         "Unit": "CBO"
     },
@@ -1049,7 +1049,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_ALL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched (matches =
an RTID destination) transactions inserted into the TOR.  The NID is progra=
mmed in Cn_MSR_PMON_BOX_FILTER.nid.  In conjunction with STATE =3D I, it is=
 possible to monitor misses to specific NIDs in the system.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched (matches=
 an RTID destination) transactions inserted into the TOR.  The NID is progr=
ammed in Cn_MSR_PMON_BOX_FILTER.nid.  In conjunction with STATE =3D I, it i=
s possible to monitor misses to specific NIDs in the system.",
         "UMask": "0x48",
         "Unit": "CBO"
     },
@@ -1058,7 +1058,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_EVICTION",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched eviction tran=
sactions inserted into the TOR.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched eviction tra=
nsactions inserted into the TOR.",
         "UMask": "0x44",
         "Unit": "CBO"
     },
@@ -1067,7 +1067,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_MISS_ALL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched miss requ=
ests that were inserted into the TOR.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched miss req=
uests that were inserted into the TOR.",
         "UMask": "0x4a",
         "Unit": "CBO"
     },
@@ -1076,7 +1076,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_MISS_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match a NID and an opcode.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match a NID and an opcode.",
         "UMask": "0x43",
         "Unit": "CBO"
     },
@@ -1085,7 +1085,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted int=
o the TOR that match a NID and an opcode.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match a NID and an opcode.",
         "UMask": "0x41",
         "Unit": "CBO"
     },
@@ -1094,7 +1094,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_WB",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched write transac=
tions inserted into the TOR.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched write transa=
ctions inserted into the TOR.",
         "UMask": "0x50",
         "Unit": "CBO"
     },
@@ -1103,7 +1103,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted int=
o the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
         "UMask": "0x1",
         "Unit": "CBO"
     },
@@ -1112,7 +1112,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.REMOTE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserted=
 into the TOR that are satisifed by remote caches or remote memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserte=
d into the TOR that are satisfied by remote caches or remote memory.",
         "UMask": "0x88",
         "Unit": "CBO"
     },
@@ -1121,7 +1121,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.REMOTE_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisif=
ed by an opcode,  inserted into the TOR that are satisifed by remote caches=
 or remote memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisf=
ied by an opcode,  inserted into the TOR that are satisfied by remote cache=
s or remote memory.",
         "UMask": "0x81",
         "Unit": "CBO"
     },
@@ -1130,7 +1130,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.WB",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Write transactions insert=
ed into the TOR.   This does not include RFO, but actual operations that co=
ntain data being sent from the core.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Write transactions inser=
ted into the TOR.   This does not include RFO, but actual operations that c=
ontain data being sent from the core.",
         "UMask": "0x10",
         "Unit": "CBO"
     },
@@ -1166,7 +1166,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.LOCAL_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisifed by an opcode,  in the TOR that are satis=
ifed by locally HOMed memory.",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisfied by an opcode,  in the TOR that are satis=
fied by locally HOMed memory.",
         "UMask": "0x21",
         "Unit": "CBO"
     },
@@ -1193,7 +1193,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.MISS_LOCAL_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisifed by an opcode, in the TOR that are sa=
tisifed by locally HOMed memory.",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisfied by an opcode, in the TOR that are sa=
tisfied by locally HOMed memory.",
         "UMask": "0x23",
         "Unit": "CBO"
     },
@@ -1220,7 +1220,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.MISS_REMOTE_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisifed by an opcode, in the TOR that are sa=
tisifed by remote caches or remote memory.",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisfied by an opcode, in the TOR that are sa=
tisfied by remote caches or remote memory.",
         "UMask": "0x83",
         "Unit": "CBO"
     },
@@ -1301,7 +1301,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.REMOTE_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisifed by an opcode,  in the TOR that are satis=
ifed by remote caches or remote memory.",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisfied by an opcode,  in the TOR that are satis=
fied by remote caches or remote memory.",
         "UMask": "0x81",
         "Unit": "CBO"
     },
@@ -1388,7 +1388,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_C_TxR_INSERTS.BL_CORE",
         "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Corebo destined for the BL ring.  This is commonly used for=
 transfering writeback data to the cache.",
+        "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Corebo destined for the BL ring.  This is commonly used for=
 transferring writeback data to the cache.",
         "UMask": "0x40",
         "Unit": "CBO"
     },
@@ -1535,7 +1535,7 @@
         "EventCode": "0x41",
         "EventName": "UNC_H_DIRECTORY_LAT_OPT",
         "PerPkg": "1",
-        "PublicDescription": "Directory Latency Optimization Data Return P=
ath Taken. When directory mode is enabled and the directory retuned for a r=
ead is Dir=3DI, then data can be returned using a faster path if certain co=
nditions are met (credits, free pipeline, etc).",
+        "PublicDescription": "Directory Latency Optimization Data Return P=
ath Taken. When directory mode is enabled and the directory returned for a =
read is Dir=3DI, then data can be returned using a faster path if certain c=
onditions are met (credits, free pipeline, etc).",
         "Unit": "HA"
     },
     {
@@ -2647,7 +2647,7 @@
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSPSFWD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the total number of RspI snoop respon=
ses received.  Whenever a snoops are issued, one or more snoop responses wi=
ll be returned depending on the topology of the system.   In systems larger=
 than 2s, when multiple snoops are returned this will count all the snoops =
that are received.  For example, if 3 snoops were issued and returned RspI,=
 RspS, and RspSFwd; then each of these sub-events would increment by 1.; Fi=
lters for a snoop response of RspSFwd.  This is returned when a remote cach=
ing agent forwards data but holds on to its currentl copy.  This is common =
for data and code reads that hit in a remote socket in E or F state.",
+        "PublicDescription": "Counts the total number of RspI snoop respon=
ses received.  Whenever a snoops are issued, one or more snoop responses wi=
ll be returned depending on the topology of the system.   In systems larger=
 than 2s, when multiple snoops are returned this will count all the snoops =
that are received.  For example, if 3 snoops were issued and returned RspI,=
 RspS, and RspSFwd; then each of these sub-events would increment by 1.; Fi=
lters for a snoop response of RspSFwd.  This is returned when a remote cach=
ing agent forwards data but holds on to its current copy.  This is common f=
or data and code reads that hit in a remote socket in E or F state.",
         "UMask": "0x8",
         "Unit": "HA"
     },
@@ -2719,7 +2719,7 @@
         "EventCode": "0x60",
         "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPSFWD",
         "PerPkg": "1",
-        "PublicDescription": "Number of snoop responses received for a Loc=
al  request; Filters for a snoop response of RspSFwd.  This is returned whe=
n a remote caching agent forwards data but holds on to its currentl copy.  =
This is common for data and code reads that hit in a remote socket in E or =
F state.",
+        "PublicDescription": "Number of snoop responses received for a Loc=
al  request; Filters for a snoop response of RspSFwd.  This is returned whe=
n a remote caching agent forwards data but holds on to its current copy.  T=
his is common for data and code reads that hit in a remote socket in E or F=
 state.",
         "UMask": "0x8",
         "Unit": "HA"
     },
@@ -2931,7 +2931,7 @@
         "Unit": "HA"
     },
     {
-        "BriefDescription": "Tracker Occupancy Accumultor; Local InvItoE R=
equests",
+        "BriefDescription": "Tracker Occupancy Accumulator; Local InvItoE =
Requests",
         "EventCode": "0x4",
         "EventName": "UNC_H_TRACKER_OCCUPANCY.INVITOE_LOCAL",
         "PerPkg": "1",
@@ -2940,7 +2940,7 @@
         "Unit": "HA"
     },
     {
-        "BriefDescription": "Tracker Occupancy Accumultor; Remote InvItoE =
Requests",
+        "BriefDescription": "Tracker Occupancy Accumulator; Remote InvItoE=
 Requests",
         "EventCode": "0x4",
         "EventName": "UNC_H_TRACKER_OCCUPANCY.INVITOE_REMOTE",
         "PerPkg": "1",
@@ -2949,7 +2949,7 @@
         "Unit": "HA"
     },
     {
-        "BriefDescription": "Tracker Occupancy Accumultor; Local Read Requ=
ests",
+        "BriefDescription": "Tracker Occupancy Accumulator; Local Read Req=
uests",
         "EventCode": "0x4",
         "EventName": "UNC_H_TRACKER_OCCUPANCY.READS_LOCAL",
         "PerPkg": "1",
@@ -2958,7 +2958,7 @@
         "Unit": "HA"
     },
     {
-        "BriefDescription": "Tracker Occupancy Accumultor; Remote Read Req=
uests",
+        "BriefDescription": "Tracker Occupancy Accumulator; Remote Read Re=
quests",
         "EventCode": "0x4",
         "EventName": "UNC_H_TRACKER_OCCUPANCY.READS_REMOTE",
         "PerPkg": "1",
@@ -2967,7 +2967,7 @@
         "Unit": "HA"
     },
     {
-        "BriefDescription": "Tracker Occupancy Accumultor; Local Write Req=
uests",
+        "BriefDescription": "Tracker Occupancy Accumulator; Local Write Re=
quests",
         "EventCode": "0x4",
         "EventName": "UNC_H_TRACKER_OCCUPANCY.WRITES_LOCAL",
         "PerPkg": "1",
@@ -2976,7 +2976,7 @@
         "Unit": "HA"
     },
     {
-        "BriefDescription": "Tracker Occupancy Accumultor; Remote Write Re=
quests",
+        "BriefDescription": "Tracker Occupancy Accumulator; Remote Write R=
equests",
         "EventCode": "0x4",
         "EventName": "UNC_H_TRACKER_OCCUPANCY.WRITES_REMOTE",
         "PerPkg": "1",
@@ -2985,7 +2985,7 @@
         "Unit": "HA"
     },
     {
-        "BriefDescription": "Data Pending Occupancy Accumultor; Local Requ=
ests",
+        "BriefDescription": "Data Pending Occupancy Accumulator; Local Req=
uests",
         "EventCode": "0x5",
         "EventName": "UNC_H_TRACKER_PENDING_OCCUPANCY.LOCAL",
         "PerPkg": "1",
@@ -2994,7 +2994,7 @@
         "Unit": "HA"
     },
     {
-        "BriefDescription": "Data Pending Occupancy Accumultor; Remote Req=
uests",
+        "BriefDescription": "Data Pending Occupancy Accumulator; Remote Re=
quests",
         "EventCode": "0x5",
         "EventName": "UNC_H_TRACKER_PENDING_OCCUPANCY.REMOTE",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-memory.json =
b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-memory.json
index c3f2f6c2ac74..a764234a3584 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-memory.json
@@ -166,7 +166,7 @@
         "EventCode": "0x9",
         "EventName": "UNC_M_ECC_CORRECTABLE_ERRORS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of ECC errors detected and=
 corrected by the iMC on this channel.  This counter is only useful with EC=
C DRAM devices.  This count will increment one time for each correction reg=
ardless of the number of bits corrected.  The iMC can correct up to 4 bit e=
rrors in independent channel mode and 8 bit erros in lockstep mode.",
+        "PublicDescription": "Counts the number of ECC errors detected and=
 corrected by the iMC on this channel.  This counter is only useful with EC=
C DRAM devices.  This count will increment one time for each correction reg=
ardless of the number of bits corrected.  The iMC can correct up to 4 bit e=
rrors in independent channel mode and 8 bit errors in lockstep mode.",
         "Unit": "iMC"
     },
     {
@@ -302,6 +302,7 @@
         "Unit": "iMC"
     },
     {
+        "BriefDescription": "UNC_M_POWER_PCU_THROTTLING",
         "EventCode": "0x42",
         "EventName": "UNC_M_POWER_PCU_THROTTLING",
         "PerPkg": "1",
@@ -487,6 +488,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.ALLBANKS",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : All Banks",
         "UMask": "0x10",
         "Unit": "iMC"
     },
@@ -495,6 +497,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK0",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 0",
         "Unit": "iMC"
     },
     {
@@ -502,6 +505,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK1",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 1",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -510,6 +514,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK10",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 10",
         "UMask": "0xa",
         "Unit": "iMC"
     },
@@ -518,6 +523,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK11",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 11",
         "UMask": "0xb",
         "Unit": "iMC"
     },
@@ -526,6 +532,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK12",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 12",
         "UMask": "0xc",
         "Unit": "iMC"
     },
@@ -534,6 +541,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK13",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 13",
         "UMask": "0xd",
         "Unit": "iMC"
     },
@@ -542,6 +550,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK14",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 14",
         "UMask": "0xe",
         "Unit": "iMC"
     },
@@ -550,6 +559,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK15",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 15",
         "UMask": "0xf",
         "Unit": "iMC"
     },
@@ -558,6 +568,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK2",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 2",
         "UMask": "0x2",
         "Unit": "iMC"
     },
@@ -566,6 +577,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK3",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 3",
         "UMask": "0x3",
         "Unit": "iMC"
     },
@@ -574,6 +586,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK4",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 4",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -582,6 +595,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK5",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 5",
         "UMask": "0x5",
         "Unit": "iMC"
     },
@@ -590,6 +604,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK6",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 6",
         "UMask": "0x6",
         "Unit": "iMC"
     },
@@ -598,6 +613,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK7",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 7",
         "UMask": "0x7",
         "Unit": "iMC"
     },
@@ -606,6 +622,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK8",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 8",
         "UMask": "0x8",
         "Unit": "iMC"
     },
@@ -614,6 +631,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANK9",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 9",
         "UMask": "0x9",
         "Unit": "iMC"
     },
@@ -622,6 +640,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANKG0",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 0 (Bank=
s 0-3)",
         "UMask": "0x11",
         "Unit": "iMC"
     },
@@ -630,6 +649,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANKG1",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 1 (Bank=
s 4-7)",
         "UMask": "0x12",
         "Unit": "iMC"
     },
@@ -638,6 +658,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANKG2",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 2 (Bank=
s 8-11)",
         "UMask": "0x13",
         "Unit": "iMC"
     },
@@ -646,6 +667,7 @@
         "EventCode": "0xB0",
         "EventName": "UNC_M_RD_CAS_RANK0.BANKG3",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 3 (Bank=
s 12-15)",
         "UMask": "0x14",
         "Unit": "iMC"
     },
@@ -654,6 +676,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.ALLBANKS",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : All Banks",
         "UMask": "0x10",
         "Unit": "iMC"
     },
@@ -662,6 +685,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK0",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 0",
         "Unit": "iMC"
     },
     {
@@ -669,6 +693,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK1",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 1",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -677,6 +702,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK10",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 10",
         "UMask": "0xa",
         "Unit": "iMC"
     },
@@ -685,6 +711,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK11",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 11",
         "UMask": "0xb",
         "Unit": "iMC"
     },
@@ -693,6 +720,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK12",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 12",
         "UMask": "0xc",
         "Unit": "iMC"
     },
@@ -701,6 +729,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK13",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 13",
         "UMask": "0xd",
         "Unit": "iMC"
     },
@@ -709,6 +738,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK14",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 14",
         "UMask": "0xe",
         "Unit": "iMC"
     },
@@ -717,6 +747,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK15",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 15",
         "UMask": "0xf",
         "Unit": "iMC"
     },
@@ -725,6 +756,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK2",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 2",
         "UMask": "0x2",
         "Unit": "iMC"
     },
@@ -733,6 +765,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK3",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 3",
         "UMask": "0x3",
         "Unit": "iMC"
     },
@@ -741,6 +774,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK4",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 4",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -749,6 +783,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK5",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 5",
         "UMask": "0x5",
         "Unit": "iMC"
     },
@@ -757,6 +792,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK6",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 6",
         "UMask": "0x6",
         "Unit": "iMC"
     },
@@ -765,6 +801,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK7",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 7",
         "UMask": "0x7",
         "Unit": "iMC"
     },
@@ -773,6 +810,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK8",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 8",
         "UMask": "0x8",
         "Unit": "iMC"
     },
@@ -781,6 +819,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANK9",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 9",
         "UMask": "0x9",
         "Unit": "iMC"
     },
@@ -789,6 +828,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANKG0",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 0 (Bank=
s 0-3)",
         "UMask": "0x11",
         "Unit": "iMC"
     },
@@ -797,6 +837,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANKG1",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 1 (Bank=
s 4-7)",
         "UMask": "0x12",
         "Unit": "iMC"
     },
@@ -805,6 +846,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANKG2",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 2 (Bank=
s 8-11)",
         "UMask": "0x13",
         "Unit": "iMC"
     },
@@ -813,6 +855,7 @@
         "EventCode": "0xB1",
         "EventName": "UNC_M_RD_CAS_RANK1.BANKG3",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 3 (Bank=
s 12-15)",
         "UMask": "0x14",
         "Unit": "iMC"
     },
@@ -821,6 +864,7 @@
         "EventCode": "0xB2",
         "EventName": "UNC_M_RD_CAS_RANK2.BANK0",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 0",
         "Unit": "iMC"
     },
     {
@@ -828,6 +872,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.ALLBANKS",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : All Banks",
         "UMask": "0x10",
         "Unit": "iMC"
     },
@@ -836,6 +881,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK0",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 0",
         "Unit": "iMC"
     },
     {
@@ -843,6 +889,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK1",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 1",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -851,6 +898,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK10",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 10",
         "UMask": "0xa",
         "Unit": "iMC"
     },
@@ -859,6 +907,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK11",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 11",
         "UMask": "0xb",
         "Unit": "iMC"
     },
@@ -867,6 +916,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK12",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 12",
         "UMask": "0xc",
         "Unit": "iMC"
     },
@@ -875,6 +925,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK13",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 13",
         "UMask": "0xd",
         "Unit": "iMC"
     },
@@ -883,6 +934,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK14",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 14",
         "UMask": "0xe",
         "Unit": "iMC"
     },
@@ -891,6 +943,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK15",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 15",
         "UMask": "0xf",
         "Unit": "iMC"
     },
@@ -899,6 +952,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK2",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 2",
         "UMask": "0x2",
         "Unit": "iMC"
     },
@@ -907,6 +961,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK3",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 3",
         "UMask": "0x3",
         "Unit": "iMC"
     },
@@ -915,6 +970,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK4",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 4",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -923,6 +979,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK5",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 5",
         "UMask": "0x5",
         "Unit": "iMC"
     },
@@ -931,6 +988,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK6",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 6",
         "UMask": "0x6",
         "Unit": "iMC"
     },
@@ -939,6 +997,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK7",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 7",
         "UMask": "0x7",
         "Unit": "iMC"
     },
@@ -947,6 +1006,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK8",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 8",
         "UMask": "0x8",
         "Unit": "iMC"
     },
@@ -955,6 +1015,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANK9",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 9",
         "UMask": "0x9",
         "Unit": "iMC"
     },
@@ -963,6 +1024,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANKG0",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 0 (Bank=
s 0-3)",
         "UMask": "0x11",
         "Unit": "iMC"
     },
@@ -971,6 +1033,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANKG1",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 1 (Bank=
s 4-7)",
         "UMask": "0x12",
         "Unit": "iMC"
     },
@@ -979,6 +1042,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANKG2",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 2 (Bank=
s 8-11)",
         "UMask": "0x13",
         "Unit": "iMC"
     },
@@ -987,6 +1051,7 @@
         "EventCode": "0xB4",
         "EventName": "UNC_M_RD_CAS_RANK4.BANKG3",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 3 (Bank=
s 12-15)",
         "UMask": "0x14",
         "Unit": "iMC"
     },
@@ -995,6 +1060,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.ALLBANKS",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : All Banks",
         "UMask": "0x10",
         "Unit": "iMC"
     },
@@ -1003,6 +1069,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK0",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 0",
         "Unit": "iMC"
     },
     {
@@ -1010,6 +1077,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK1",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 1",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -1018,6 +1086,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK10",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 10",
         "UMask": "0xa",
         "Unit": "iMC"
     },
@@ -1026,6 +1095,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK11",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 11",
         "UMask": "0xb",
         "Unit": "iMC"
     },
@@ -1034,6 +1104,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK12",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 12",
         "UMask": "0xc",
         "Unit": "iMC"
     },
@@ -1042,6 +1113,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK13",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 13",
         "UMask": "0xd",
         "Unit": "iMC"
     },
@@ -1050,6 +1122,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK14",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 14",
         "UMask": "0xe",
         "Unit": "iMC"
     },
@@ -1058,6 +1131,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK15",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 15",
         "UMask": "0xf",
         "Unit": "iMC"
     },
@@ -1066,6 +1140,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK2",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 2",
         "UMask": "0x2",
         "Unit": "iMC"
     },
@@ -1074,6 +1149,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK3",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 3",
         "UMask": "0x3",
         "Unit": "iMC"
     },
@@ -1082,6 +1158,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK4",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 4",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -1090,6 +1167,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK5",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 5",
         "UMask": "0x5",
         "Unit": "iMC"
     },
@@ -1098,6 +1176,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK6",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 6",
         "UMask": "0x6",
         "Unit": "iMC"
     },
@@ -1106,6 +1185,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK7",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 7",
         "UMask": "0x7",
         "Unit": "iMC"
     },
@@ -1114,6 +1194,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK8",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 8",
         "UMask": "0x8",
         "Unit": "iMC"
     },
@@ -1122,6 +1203,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANK9",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 9",
         "UMask": "0x9",
         "Unit": "iMC"
     },
@@ -1130,6 +1212,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANKG0",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 0 (Bank=
s 0-3)",
         "UMask": "0x11",
         "Unit": "iMC"
     },
@@ -1138,6 +1221,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANKG1",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 1 (Bank=
s 4-7)",
         "UMask": "0x12",
         "Unit": "iMC"
     },
@@ -1146,6 +1230,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANKG2",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 2 (Bank=
s 8-11)",
         "UMask": "0x13",
         "Unit": "iMC"
     },
@@ -1154,6 +1239,7 @@
         "EventCode": "0xB5",
         "EventName": "UNC_M_RD_CAS_RANK5.BANKG3",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 3 (Bank=
s 12-15)",
         "UMask": "0x14",
         "Unit": "iMC"
     },
@@ -1162,6 +1248,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.ALLBANKS",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : All Banks",
         "UMask": "0x10",
         "Unit": "iMC"
     },
@@ -1170,6 +1257,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK0",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 0",
         "Unit": "iMC"
     },
     {
@@ -1177,6 +1265,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK1",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 1",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -1185,6 +1274,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK10",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 10",
         "UMask": "0xa",
         "Unit": "iMC"
     },
@@ -1193,6 +1283,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK11",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 11",
         "UMask": "0xb",
         "Unit": "iMC"
     },
@@ -1201,6 +1292,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK12",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 12",
         "UMask": "0xc",
         "Unit": "iMC"
     },
@@ -1209,6 +1301,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK13",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 13",
         "UMask": "0xd",
         "Unit": "iMC"
     },
@@ -1217,6 +1310,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK14",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 14",
         "UMask": "0xe",
         "Unit": "iMC"
     },
@@ -1225,6 +1319,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK15",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 15",
         "UMask": "0xf",
         "Unit": "iMC"
     },
@@ -1233,6 +1328,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK2",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 2",
         "UMask": "0x2",
         "Unit": "iMC"
     },
@@ -1241,6 +1337,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK3",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 3",
         "UMask": "0x3",
         "Unit": "iMC"
     },
@@ -1249,6 +1346,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK4",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 4",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -1257,6 +1355,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK5",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 5",
         "UMask": "0x5",
         "Unit": "iMC"
     },
@@ -1265,6 +1364,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK6",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 6",
         "UMask": "0x6",
         "Unit": "iMC"
     },
@@ -1273,6 +1373,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK7",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 7",
         "UMask": "0x7",
         "Unit": "iMC"
     },
@@ -1281,6 +1382,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK8",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 8",
         "UMask": "0x8",
         "Unit": "iMC"
     },
@@ -1289,6 +1391,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANK9",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 9",
         "UMask": "0x9",
         "Unit": "iMC"
     },
@@ -1297,6 +1400,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANKG0",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 0 (Bank=
s 0-3)",
         "UMask": "0x11",
         "Unit": "iMC"
     },
@@ -1305,6 +1409,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANKG1",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 1 (Bank=
s 4-7)",
         "UMask": "0x12",
         "Unit": "iMC"
     },
@@ -1313,6 +1418,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANKG2",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 2 (Bank=
s 8-11)",
         "UMask": "0x13",
         "Unit": "iMC"
     },
@@ -1321,6 +1427,7 @@
         "EventCode": "0xB6",
         "EventName": "UNC_M_RD_CAS_RANK6.BANKG3",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 3 (Bank=
s 12-15)",
         "UMask": "0x14",
         "Unit": "iMC"
     },
@@ -1329,6 +1436,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.ALLBANKS",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : All Banks",
         "UMask": "0x10",
         "Unit": "iMC"
     },
@@ -1337,6 +1445,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK0",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 0",
         "Unit": "iMC"
     },
     {
@@ -1344,6 +1453,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK1",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 1",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -1352,6 +1462,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK10",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 10",
         "UMask": "0xa",
         "Unit": "iMC"
     },
@@ -1360,6 +1471,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK11",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 11",
         "UMask": "0xb",
         "Unit": "iMC"
     },
@@ -1368,6 +1480,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK12",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 12",
         "UMask": "0xc",
         "Unit": "iMC"
     },
@@ -1376,6 +1489,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK13",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 13",
         "UMask": "0xd",
         "Unit": "iMC"
     },
@@ -1384,6 +1498,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK14",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 14",
         "UMask": "0xe",
         "Unit": "iMC"
     },
@@ -1392,6 +1507,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK15",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 15",
         "UMask": "0xf",
         "Unit": "iMC"
     },
@@ -1400,6 +1516,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK2",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 2",
         "UMask": "0x2",
         "Unit": "iMC"
     },
@@ -1408,6 +1525,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK3",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 3",
         "UMask": "0x3",
         "Unit": "iMC"
     },
@@ -1416,6 +1534,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK4",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 4",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -1424,6 +1543,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK5",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 5",
         "UMask": "0x5",
         "Unit": "iMC"
     },
@@ -1432,6 +1552,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK6",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 6",
         "UMask": "0x6",
         "Unit": "iMC"
     },
@@ -1440,6 +1561,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK7",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 7",
         "UMask": "0x7",
         "Unit": "iMC"
     },
@@ -1448,6 +1570,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK8",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 8",
         "UMask": "0x8",
         "Unit": "iMC"
     },
@@ -1456,6 +1579,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANK9",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank 9",
         "UMask": "0x9",
         "Unit": "iMC"
     },
@@ -1464,6 +1588,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANKG0",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 0 (Bank=
s 0-3)",
         "UMask": "0x11",
         "Unit": "iMC"
     },
@@ -1472,6 +1597,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANKG1",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 1 (Bank=
s 4-7)",
         "UMask": "0x12",
         "Unit": "iMC"
     },
@@ -1480,6 +1606,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANKG2",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 2 (Bank=
s 8-11)",
         "UMask": "0x13",
         "Unit": "iMC"
     },
@@ -1488,6 +1615,7 @@
         "EventCode": "0xB7",
         "EventName": "UNC_M_RD_CAS_RANK7.BANKG3",
         "PerPkg": "1",
+        "PublicDescription": "RD_CAS Access to Rank 0 : Bank Group 3 (Bank=
s 12-15)",
         "UMask": "0x14",
         "Unit": "iMC"
     },
@@ -1598,6 +1726,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.ALLBANKS",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : All Banks",
         "UMask": "0x10",
         "Unit": "iMC"
     },
@@ -1606,6 +1735,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK0",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 0",
         "Unit": "iMC"
     },
     {
@@ -1613,6 +1743,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK1",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 1",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -1621,6 +1752,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK10",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 10",
         "UMask": "0xa",
         "Unit": "iMC"
     },
@@ -1629,6 +1761,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK11",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 11",
         "UMask": "0xb",
         "Unit": "iMC"
     },
@@ -1637,6 +1770,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK12",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 12",
         "UMask": "0xc",
         "Unit": "iMC"
     },
@@ -1645,6 +1779,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK13",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 13",
         "UMask": "0xd",
         "Unit": "iMC"
     },
@@ -1653,6 +1788,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK14",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 14",
         "UMask": "0xe",
         "Unit": "iMC"
     },
@@ -1661,6 +1797,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK15",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 15",
         "UMask": "0xf",
         "Unit": "iMC"
     },
@@ -1669,6 +1806,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK2",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 2",
         "UMask": "0x2",
         "Unit": "iMC"
     },
@@ -1677,6 +1815,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK3",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 3",
         "UMask": "0x3",
         "Unit": "iMC"
     },
@@ -1685,6 +1824,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK4",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 4",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -1693,6 +1833,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK5",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 5",
         "UMask": "0x5",
         "Unit": "iMC"
     },
@@ -1701,6 +1842,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK6",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 6",
         "UMask": "0x6",
         "Unit": "iMC"
     },
@@ -1709,6 +1851,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK7",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 7",
         "UMask": "0x7",
         "Unit": "iMC"
     },
@@ -1717,6 +1860,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK8",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 8",
         "UMask": "0x8",
         "Unit": "iMC"
     },
@@ -1725,6 +1869,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANK9",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 9",
         "UMask": "0x9",
         "Unit": "iMC"
     },
@@ -1733,6 +1878,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANKG0",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 0 (Bank=
s 0-3)",
         "UMask": "0x11",
         "Unit": "iMC"
     },
@@ -1741,6 +1887,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANKG1",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 1 (Bank=
s 4-7)",
         "UMask": "0x12",
         "Unit": "iMC"
     },
@@ -1749,6 +1896,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANKG2",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 2 (Bank=
s 8-11)",
         "UMask": "0x13",
         "Unit": "iMC"
     },
@@ -1757,6 +1905,7 @@
         "EventCode": "0xB8",
         "EventName": "UNC_M_WR_CAS_RANK0.BANKG3",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 3 (Bank=
s 12-15)",
         "UMask": "0x14",
         "Unit": "iMC"
     },
@@ -1765,6 +1914,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.ALLBANKS",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : All Banks",
         "UMask": "0x10",
         "Unit": "iMC"
     },
@@ -1773,6 +1923,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK0",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 0",
         "Unit": "iMC"
     },
     {
@@ -1780,6 +1931,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK1",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 1",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -1788,6 +1940,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK10",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 10",
         "UMask": "0xa",
         "Unit": "iMC"
     },
@@ -1796,6 +1949,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK11",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 11",
         "UMask": "0xb",
         "Unit": "iMC"
     },
@@ -1804,6 +1958,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK12",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 12",
         "UMask": "0xc",
         "Unit": "iMC"
     },
@@ -1812,6 +1967,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK13",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 13",
         "UMask": "0xd",
         "Unit": "iMC"
     },
@@ -1820,6 +1976,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK14",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 14",
         "UMask": "0xe",
         "Unit": "iMC"
     },
@@ -1828,6 +1985,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK15",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 15",
         "UMask": "0xf",
         "Unit": "iMC"
     },
@@ -1836,6 +1994,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK2",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 2",
         "UMask": "0x2",
         "Unit": "iMC"
     },
@@ -1844,6 +2003,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK3",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 3",
         "UMask": "0x3",
         "Unit": "iMC"
     },
@@ -1852,6 +2012,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK4",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 4",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -1860,6 +2021,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK5",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 5",
         "UMask": "0x5",
         "Unit": "iMC"
     },
@@ -1868,6 +2030,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK6",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 6",
         "UMask": "0x6",
         "Unit": "iMC"
     },
@@ -1876,6 +2039,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK7",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 7",
         "UMask": "0x7",
         "Unit": "iMC"
     },
@@ -1884,6 +2048,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK8",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 8",
         "UMask": "0x8",
         "Unit": "iMC"
     },
@@ -1892,6 +2057,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANK9",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 9",
         "UMask": "0x9",
         "Unit": "iMC"
     },
@@ -1900,6 +2066,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANKG0",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 0 (Bank=
s 0-3)",
         "UMask": "0x11",
         "Unit": "iMC"
     },
@@ -1908,6 +2075,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANKG1",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 1 (Bank=
s 4-7)",
         "UMask": "0x12",
         "Unit": "iMC"
     },
@@ -1916,6 +2084,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANKG2",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 2 (Bank=
s 8-11)",
         "UMask": "0x13",
         "Unit": "iMC"
     },
@@ -1924,6 +2093,7 @@
         "EventCode": "0xB9",
         "EventName": "UNC_M_WR_CAS_RANK1.BANKG3",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 3 (Bank=
s 12-15)",
         "UMask": "0x14",
         "Unit": "iMC"
     },
@@ -1932,6 +2102,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.ALLBANKS",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : All Banks",
         "UMask": "0x10",
         "Unit": "iMC"
     },
@@ -1940,6 +2111,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK0",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 0",
         "Unit": "iMC"
     },
     {
@@ -1947,6 +2119,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK1",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 1",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -1955,6 +2128,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK10",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 10",
         "UMask": "0xa",
         "Unit": "iMC"
     },
@@ -1963,6 +2137,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK11",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 11",
         "UMask": "0xb",
         "Unit": "iMC"
     },
@@ -1971,6 +2146,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK12",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 12",
         "UMask": "0xc",
         "Unit": "iMC"
     },
@@ -1979,6 +2155,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK13",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 13",
         "UMask": "0xd",
         "Unit": "iMC"
     },
@@ -1987,6 +2164,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK14",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 14",
         "UMask": "0xe",
         "Unit": "iMC"
     },
@@ -1995,6 +2173,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK15",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 15",
         "UMask": "0xf",
         "Unit": "iMC"
     },
@@ -2003,6 +2182,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK2",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 2",
         "UMask": "0x2",
         "Unit": "iMC"
     },
@@ -2011,6 +2191,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK3",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 3",
         "UMask": "0x3",
         "Unit": "iMC"
     },
@@ -2019,6 +2200,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK4",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 4",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -2027,6 +2209,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK5",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 5",
         "UMask": "0x5",
         "Unit": "iMC"
     },
@@ -2035,6 +2218,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK6",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 6",
         "UMask": "0x6",
         "Unit": "iMC"
     },
@@ -2043,6 +2227,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK7",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 7",
         "UMask": "0x7",
         "Unit": "iMC"
     },
@@ -2051,6 +2236,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK8",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 8",
         "UMask": "0x8",
         "Unit": "iMC"
     },
@@ -2059,6 +2245,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANK9",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 9",
         "UMask": "0x9",
         "Unit": "iMC"
     },
@@ -2067,6 +2254,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANKG0",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 0 (Bank=
s 0-3)",
         "UMask": "0x11",
         "Unit": "iMC"
     },
@@ -2075,6 +2263,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANKG1",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 1 (Bank=
s 4-7)",
         "UMask": "0x12",
         "Unit": "iMC"
     },
@@ -2083,6 +2272,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANKG2",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 2 (Bank=
s 8-11)",
         "UMask": "0x13",
         "Unit": "iMC"
     },
@@ -2091,6 +2281,7 @@
         "EventCode": "0xBC",
         "EventName": "UNC_M_WR_CAS_RANK4.BANKG3",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 3 (Bank=
s 12-15)",
         "UMask": "0x14",
         "Unit": "iMC"
     },
@@ -2099,6 +2290,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.ALLBANKS",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : All Banks",
         "UMask": "0x10",
         "Unit": "iMC"
     },
@@ -2107,6 +2299,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK0",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 0",
         "Unit": "iMC"
     },
     {
@@ -2114,6 +2307,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK1",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 1",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -2122,6 +2316,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK10",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 10",
         "UMask": "0xa",
         "Unit": "iMC"
     },
@@ -2130,6 +2325,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK11",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 11",
         "UMask": "0xb",
         "Unit": "iMC"
     },
@@ -2138,6 +2334,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK12",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 12",
         "UMask": "0xc",
         "Unit": "iMC"
     },
@@ -2146,6 +2343,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK13",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 13",
         "UMask": "0xd",
         "Unit": "iMC"
     },
@@ -2154,6 +2352,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK14",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 14",
         "UMask": "0xe",
         "Unit": "iMC"
     },
@@ -2162,6 +2361,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK15",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 15",
         "UMask": "0xf",
         "Unit": "iMC"
     },
@@ -2170,6 +2370,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK2",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 2",
         "UMask": "0x2",
         "Unit": "iMC"
     },
@@ -2178,6 +2379,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK3",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 3",
         "UMask": "0x3",
         "Unit": "iMC"
     },
@@ -2186,6 +2388,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK4",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 4",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -2194,6 +2397,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK5",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 5",
         "UMask": "0x5",
         "Unit": "iMC"
     },
@@ -2202,6 +2406,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK6",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 6",
         "UMask": "0x6",
         "Unit": "iMC"
     },
@@ -2210,6 +2415,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK7",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 7",
         "UMask": "0x7",
         "Unit": "iMC"
     },
@@ -2218,6 +2424,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK8",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 8",
         "UMask": "0x8",
         "Unit": "iMC"
     },
@@ -2226,6 +2433,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANK9",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 9",
         "UMask": "0x9",
         "Unit": "iMC"
     },
@@ -2234,6 +2442,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANKG0",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 0 (Bank=
s 0-3)",
         "UMask": "0x11",
         "Unit": "iMC"
     },
@@ -2242,6 +2451,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANKG1",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 1 (Bank=
s 4-7)",
         "UMask": "0x12",
         "Unit": "iMC"
     },
@@ -2250,6 +2460,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANKG2",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 2 (Bank=
s 8-11)",
         "UMask": "0x13",
         "Unit": "iMC"
     },
@@ -2258,6 +2469,7 @@
         "EventCode": "0xBD",
         "EventName": "UNC_M_WR_CAS_RANK5.BANKG3",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 3 (Bank=
s 12-15)",
         "UMask": "0x14",
         "Unit": "iMC"
     },
@@ -2266,6 +2478,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.ALLBANKS",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : All Banks",
         "UMask": "0x10",
         "Unit": "iMC"
     },
@@ -2274,6 +2487,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK0",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 0",
         "Unit": "iMC"
     },
     {
@@ -2281,6 +2495,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK1",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 1",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -2289,6 +2504,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK10",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 10",
         "UMask": "0xa",
         "Unit": "iMC"
     },
@@ -2297,6 +2513,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK11",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 11",
         "UMask": "0xb",
         "Unit": "iMC"
     },
@@ -2305,6 +2522,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK12",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 12",
         "UMask": "0xc",
         "Unit": "iMC"
     },
@@ -2313,6 +2531,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK13",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 13",
         "UMask": "0xd",
         "Unit": "iMC"
     },
@@ -2321,6 +2540,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK14",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 14",
         "UMask": "0xe",
         "Unit": "iMC"
     },
@@ -2329,6 +2549,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK15",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 15",
         "UMask": "0xf",
         "Unit": "iMC"
     },
@@ -2337,6 +2558,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK2",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 2",
         "UMask": "0x2",
         "Unit": "iMC"
     },
@@ -2345,6 +2567,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK3",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 3",
         "UMask": "0x3",
         "Unit": "iMC"
     },
@@ -2353,6 +2576,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK4",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 4",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -2361,6 +2585,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK5",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 5",
         "UMask": "0x5",
         "Unit": "iMC"
     },
@@ -2369,6 +2594,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK6",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 6",
         "UMask": "0x6",
         "Unit": "iMC"
     },
@@ -2377,6 +2603,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK7",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 7",
         "UMask": "0x7",
         "Unit": "iMC"
     },
@@ -2385,6 +2612,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK8",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 8",
         "UMask": "0x8",
         "Unit": "iMC"
     },
@@ -2393,6 +2621,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANK9",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 9",
         "UMask": "0x9",
         "Unit": "iMC"
     },
@@ -2401,6 +2630,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANKG0",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 0 (Bank=
s 0-3)",
         "UMask": "0x11",
         "Unit": "iMC"
     },
@@ -2409,6 +2639,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANKG1",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 1 (Bank=
s 4-7)",
         "UMask": "0x12",
         "Unit": "iMC"
     },
@@ -2417,6 +2648,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANKG2",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 2 (Bank=
s 8-11)",
         "UMask": "0x13",
         "Unit": "iMC"
     },
@@ -2425,6 +2657,7 @@
         "EventCode": "0xBE",
         "EventName": "UNC_M_WR_CAS_RANK6.BANKG3",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 3 (Bank=
s 12-15)",
         "UMask": "0x14",
         "Unit": "iMC"
     },
@@ -2433,6 +2666,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.ALLBANKS",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : All Banks",
         "UMask": "0x10",
         "Unit": "iMC"
     },
@@ -2441,6 +2675,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK0",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 0",
         "Unit": "iMC"
     },
     {
@@ -2448,6 +2683,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK1",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 1",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -2456,6 +2692,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK10",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 10",
         "UMask": "0xa",
         "Unit": "iMC"
     },
@@ -2464,6 +2701,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK11",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 11",
         "UMask": "0xb",
         "Unit": "iMC"
     },
@@ -2472,6 +2710,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK12",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 12",
         "UMask": "0xc",
         "Unit": "iMC"
     },
@@ -2480,6 +2719,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK13",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 13",
         "UMask": "0xd",
         "Unit": "iMC"
     },
@@ -2488,6 +2728,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK14",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 14",
         "UMask": "0xe",
         "Unit": "iMC"
     },
@@ -2496,6 +2737,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK15",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 15",
         "UMask": "0xf",
         "Unit": "iMC"
     },
@@ -2504,6 +2746,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK2",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 2",
         "UMask": "0x2",
         "Unit": "iMC"
     },
@@ -2512,6 +2755,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK3",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 3",
         "UMask": "0x3",
         "Unit": "iMC"
     },
@@ -2520,6 +2764,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK4",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 4",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -2528,6 +2773,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK5",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 5",
         "UMask": "0x5",
         "Unit": "iMC"
     },
@@ -2536,6 +2782,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK6",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 6",
         "UMask": "0x6",
         "Unit": "iMC"
     },
@@ -2544,6 +2791,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK7",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 7",
         "UMask": "0x7",
         "Unit": "iMC"
     },
@@ -2552,6 +2800,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK8",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 8",
         "UMask": "0x8",
         "Unit": "iMC"
     },
@@ -2560,6 +2809,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANK9",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank 9",
         "UMask": "0x9",
         "Unit": "iMC"
     },
@@ -2568,6 +2818,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANKG0",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 0 (Bank=
s 0-3)",
         "UMask": "0x11",
         "Unit": "iMC"
     },
@@ -2576,6 +2827,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANKG1",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 1 (Bank=
s 4-7)",
         "UMask": "0x12",
         "Unit": "iMC"
     },
@@ -2584,6 +2836,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANKG2",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 2 (Bank=
s 8-11)",
         "UMask": "0x13",
         "Unit": "iMC"
     },
@@ -2592,6 +2845,7 @@
         "EventCode": "0xBF",
         "EventName": "UNC_M_WR_CAS_RANK7.BANKG3",
         "PerPkg": "1",
+        "PublicDescription": "WR_CAS Access to Rank 0 : Bank Group 3 (Bank=
s 12-15)",
         "UMask": "0x14",
         "Unit": "iMC"
     }
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-other.json b=
/tools/perf/pmu-events/arch/x86/broadwellde/uncore-other.json
index 753b381b77fe..fea3dea67f38 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-other.json
@@ -101,6 +101,7 @@
         "EventCode": "0x14",
         "EventName": "UNC_I_MISC0.2ND_ATOMIC_INSERT",
         "PerPkg": "1",
+        "PublicDescription": "Counts Timeouts - Set 0 : Cache Inserts of A=
tomic Transactions as Secondary",
         "UMask": "0x10",
         "Unit": "IRP"
     },
@@ -109,6 +110,7 @@
         "EventCode": "0x14",
         "EventName": "UNC_I_MISC0.2ND_RD_INSERT",
         "PerPkg": "1",
+        "PublicDescription": "Counts Timeouts - Set 0 : Cache Inserts of R=
ead Transactions as Secondary",
         "UMask": "0x4",
         "Unit": "IRP"
     },
@@ -117,6 +119,7 @@
         "EventCode": "0x14",
         "EventName": "UNC_I_MISC0.2ND_WR_INSERT",
         "PerPkg": "1",
+        "PublicDescription": "Counts Timeouts - Set 0 : Cache Inserts of W=
rite Transactions as Secondary",
         "UMask": "0x8",
         "Unit": "IRP"
     },
@@ -125,6 +128,7 @@
         "EventCode": "0x14",
         "EventName": "UNC_I_MISC0.FAST_REJ",
         "PerPkg": "1",
+        "PublicDescription": "Counts Timeouts - Set 0 : Fastpath Rejects",
         "UMask": "0x2",
         "Unit": "IRP"
     },
@@ -133,6 +137,7 @@
         "EventCode": "0x14",
         "EventName": "UNC_I_MISC0.FAST_REQ",
         "PerPkg": "1",
+        "PublicDescription": "Counts Timeouts - Set 0 : Fastpath Requests"=
,
         "UMask": "0x1",
         "Unit": "IRP"
     },
@@ -141,6 +146,7 @@
         "EventCode": "0x14",
         "EventName": "UNC_I_MISC0.FAST_XFER",
         "PerPkg": "1",
+        "PublicDescription": "Counts Timeouts - Set 0 : Fastpath Transfers=
 From Primary to Secondary",
         "UMask": "0x20",
         "Unit": "IRP"
     },
@@ -149,6 +155,7 @@
         "EventCode": "0x14",
         "EventName": "UNC_I_MISC0.PF_ACK_HINT",
         "PerPkg": "1",
+        "PublicDescription": "Counts Timeouts - Set 0 : Prefetch Ack Hints=
 From Primary to Secondary",
         "UMask": "0x40",
         "Unit": "IRP"
     },
@@ -175,6 +182,7 @@
         "EventCode": "0x15",
         "EventName": "UNC_I_MISC1.LOST_FWD",
         "PerPkg": "1",
+        "PublicDescription": "Misc Events - Set 1 : Lost Forward : Snoop p=
ulled away ownership before a write was committed",
         "UMask": "0x10",
         "Unit": "IRP"
     },
@@ -241,6 +249,7 @@
         "Unit": "IRP"
     },
     {
+        "BriefDescription": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
         "EventCode": "0x4",
         "EventName": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
         "PerPkg": "1",
@@ -256,6 +265,7 @@
         "Unit": "IRP"
     },
     {
+        "BriefDescription": "UNC_I_RxR_BL_DRS_OCCUPANCY",
         "EventCode": "0x7",
         "EventName": "UNC_I_RxR_BL_DRS_OCCUPANCY",
         "PerPkg": "1",
@@ -263,6 +273,7 @@
         "Unit": "IRP"
     },
     {
+        "BriefDescription": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
         "EventCode": "0x5",
         "EventName": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
         "PerPkg": "1",
@@ -278,6 +289,7 @@
         "Unit": "IRP"
     },
     {
+        "BriefDescription": "UNC_I_RxR_BL_NCB_OCCUPANCY",
         "EventCode": "0x8",
         "EventName": "UNC_I_RxR_BL_NCB_OCCUPANCY",
         "PerPkg": "1",
@@ -285,6 +297,7 @@
         "Unit": "IRP"
     },
     {
+        "BriefDescription": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
         "EventCode": "0x6",
         "EventName": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
         "PerPkg": "1",
@@ -300,6 +313,7 @@
         "Unit": "IRP"
     },
     {
+        "BriefDescription": "UNC_I_RxR_BL_NCS_OCCUPANCY",
         "EventCode": "0x9",
         "EventName": "UNC_I_RxR_BL_NCS_OCCUPANCY",
         "PerPkg": "1",
@@ -311,6 +325,7 @@
         "EventCode": "0x17",
         "EventName": "UNC_I_SNOOP_RESP.HIT_ES",
         "PerPkg": "1",
+        "PublicDescription": "Snoop Responses : Hit E or S",
         "UMask": "0x4",
         "Unit": "IRP"
     },
@@ -319,6 +334,7 @@
         "EventCode": "0x17",
         "EventName": "UNC_I_SNOOP_RESP.HIT_I",
         "PerPkg": "1",
+        "PublicDescription": "Snoop Responses : Hit I",
         "UMask": "0x2",
         "Unit": "IRP"
     },
@@ -327,6 +343,7 @@
         "EventCode": "0x17",
         "EventName": "UNC_I_SNOOP_RESP.HIT_M",
         "PerPkg": "1",
+        "PublicDescription": "Snoop Responses : Hit M",
         "UMask": "0x8",
         "Unit": "IRP"
     },
@@ -335,6 +352,7 @@
         "EventCode": "0x17",
         "EventName": "UNC_I_SNOOP_RESP.MISS",
         "PerPkg": "1",
+        "PublicDescription": "Snoop Responses : Miss",
         "UMask": "0x1",
         "Unit": "IRP"
     },
@@ -343,6 +361,7 @@
         "EventCode": "0x17",
         "EventName": "UNC_I_SNOOP_RESP.SNPCODE",
         "PerPkg": "1",
+        "PublicDescription": "Snoop Responses : SnpCode",
         "UMask": "0x10",
         "Unit": "IRP"
     },
@@ -351,6 +370,7 @@
         "EventCode": "0x17",
         "EventName": "UNC_I_SNOOP_RESP.SNPDATA",
         "PerPkg": "1",
+        "PublicDescription": "Snoop Responses : SnpData",
         "UMask": "0x20",
         "Unit": "IRP"
     },
@@ -359,6 +379,7 @@
         "EventCode": "0x17",
         "EventName": "UNC_I_SNOOP_RESP.SNPINV",
         "PerPkg": "1",
+        "PublicDescription": "Snoop Responses : SnpInv",
         "UMask": "0x40",
         "Unit": "IRP"
     },
@@ -453,7 +474,7 @@
         "EventCode": "0xD",
         "EventName": "UNC_I_TxR_REQUEST_OCCUPANCY",
         "PerPkg": "1",
-        "PublicDescription": "Accumultes the number of outstanding outboun=
d requests from the IRP to the switch (towards the devices).  This can be u=
sed in conjuection with the allocations event in order to calculate average=
 latency of outbound requests.",
+        "PublicDescription": "Accumulates the number of outstanding outbou=
nd requests from the IRP to the switch (towards the devices).  This can be =
used in conjunction with the allocations event in order to calculate averag=
e latency of outbound requests.",
         "Unit": "IRP"
     },
     {
@@ -465,6 +486,7 @@
         "Unit": "R2PCIe"
     },
     {
+        "BriefDescription": "UNC_R2_IIO_CREDIT.ISOCH_QPI0",
         "EventCode": "0x2D",
         "EventName": "UNC_R2_IIO_CREDIT.ISOCH_QPI0",
         "PerPkg": "1",
@@ -472,6 +494,7 @@
         "Unit": "R2PCIe"
     },
     {
+        "BriefDescription": "UNC_R2_IIO_CREDIT.ISOCH_QPI1",
         "EventCode": "0x2D",
         "EventName": "UNC_R2_IIO_CREDIT.ISOCH_QPI1",
         "PerPkg": "1",
@@ -479,6 +502,7 @@
         "Unit": "R2PCIe"
     },
     {
+        "BriefDescription": "UNC_R2_IIO_CREDIT.PRQ_QPI0",
         "EventCode": "0x2D",
         "EventName": "UNC_R2_IIO_CREDIT.PRQ_QPI0",
         "PerPkg": "1",
@@ -486,6 +510,7 @@
         "Unit": "R2PCIe"
     },
     {
+        "BriefDescription": "UNC_R2_IIO_CREDIT.PRQ_QPI1",
         "EventCode": "0x2D",
         "EventName": "UNC_R2_IIO_CREDIT.PRQ_QPI1",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json b=
/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
index 124b3fe2e0e1..83d20130c217 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
@@ -395,7 +395,7 @@
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
         "PerPkg": "1",
-        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with threshholding to gene=
rate histograms, or with other PCU events and occupancy triggering to captu=
re other details.",
+        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with thresholding to gener=
ate histograms, or with other PCU events and occupancy triggering to captur=
e other details.",
         "Unit": "PCU"
     },
     {
@@ -403,7 +403,7 @@
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
         "PerPkg": "1",
-        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with threshholding to gene=
rate histograms, or with other PCU events and occupancy triggering to captu=
re other details.",
+        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with thresholding to gener=
ate histograms, or with other PCU events and occupancy triggering to captur=
e other details.",
         "Unit": "PCU"
     },
     {
@@ -411,7 +411,7 @@
         "EventCode": "0x80",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
         "PerPkg": "1",
-        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with threshholding to gene=
rate histograms, or with other PCU events and occupancy triggering to captu=
re other details.",
+        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with thresholding to gener=
ate histograms, or with other PCU events and occupancy triggering to captur=
e other details.",
         "Unit": "PCU"
     },
     {
@@ -427,7 +427,7 @@
         "EventCode": "0x9",
         "EventName": "UNC_P_PROCHOT_INTERNAL_CYCLES",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that we are in I=
nteral PROCHOT mode.  This mode is triggered when a sensor on the die deter=
mines that we are too hot and must throttle to avoid damaging the chip.",
+        "PublicDescription": "Counts the number of cycles that we are in I=
nternal PROCHOT mode.  This mode is triggered when a sensor on the die dete=
rmines that we are too hot and must throttle to avoid damaging the chip.",
         "Unit": "PCU"
     },
     {
@@ -439,6 +439,7 @@
         "Unit": "PCU"
     },
     {
+        "BriefDescription": "UNC_P_UFS_TRANSITIONS_RING_GV",
         "EventCode": "0x79",
         "EventName": "UNC_P_UFS_TRANSITIONS_RING_GV",
         "PerPkg": "1",
@@ -450,6 +451,7 @@
         "EventCode": "0x42",
         "EventName": "UNC_P_VR_HOT_CYCLES",
         "PerPkg": "1",
+        "PublicDescription": "VR Hot : Number of cycles that a CPU SVID VR=
 is hot.  Does not cover DRAM VRs",
         "Unit": "PCU"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 70be860bcb53..4fa827c7f719 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -3,7 +3,7 @@ GenuineIntel-6-(97|9A|B7|BA|BF),v1.19,alderlake,core
 GenuineIntel-6-BE,v1.19,alderlaken,core
 GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
 GenuineIntel-6-(3D|47),v27,broadwell,core
-GenuineIntel-6-56,v7,broadwellde,core
+GenuineIntel-6-56,v9,broadwellde,core
 GenuineIntel-6-4F,v19,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.17,cascadelakex,core
 GenuineIntel-6-9[6C],v1.03,elkhartlake,core
--=20
2.40.0.348.gf938b09366-goog

