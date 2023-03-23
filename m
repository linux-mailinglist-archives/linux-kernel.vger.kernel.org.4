Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00CB6C70FE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjCWTV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjCWTVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:21:36 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CABB12CDE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:21:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j11-20020a25230b000000b00b6871c296bdso16182344ybj.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679599279;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uih42a7geLUhVXca3hZ+/zz/xw+NyUuKTbPaxBF4q7k=;
        b=Ynh6jCGoKZT+li3+u1mwZXjGs3n91CPqS38oeRIQG+blW16kmzIMtWjqNP8iZvtDL8
         PZfz2rKxnO4ihjzGmiLR/VQnItZ8FD+vbfKepA3NpSkOG9f5xCdiepLsTIi+JpwJ2PoH
         oQRDLvCiHq/F0YNRcJcX57GKs8kK0Tl8uI7elCnV2scPglreyj7N5eSWdfmdfbHeLvsj
         tK0Qy33mmngCDRcJ0lNX9fiFGY9sOK6+X19yTMk9m59G3pDL/EBQVlYm9QbGYgPnqX3a
         lg1F3c9xBAVoGTBW30Z42xtQcZ+mVvdn6JH5yA05+uSYhyPEBBnd+J0QPN5z9h8oohD+
         HHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679599279;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Uih42a7geLUhVXca3hZ+/zz/xw+NyUuKTbPaxBF4q7k=;
        b=aNXmv59MNET0i99oI50dVrWNoktdwF2H2i8ATm6dR2agDKT4E+ccJ6FHxdpgHM+Y4o
         rmVagyYfc74pWDHGo9qPWjFAMkNH0s4v0CXbtz7rPp0sHkF4XzelBi8rsDo5K0hVsjGr
         an0vXkLXFFkmEbqP0472z5aW1fCz3Ta1oLCZqcOgw1FXNw8UZts6sPLSgLrDTTFcMb7l
         ZYz7rbmM8y/CTQRG9xTZOndBWQ7zC+QIybZBCMUSQh/E873n833HlYrU7P1Gqm4XaZeU
         7tpArsu1ewd+e0YdcUljsufSQWYEY5nKz7U7tNfmnPWic0p4rjvUI/Azuqzh7r6AiJ0+
         D+oQ==
X-Gm-Message-State: AAQBX9d94nvh4Z3AwO2e8OtrOnKGN6Y4wwCTfmFHCv2HIR4b0pJ0J/Xf
        coreho72d1z2fSEO6qSk+prX7PPogKnj
X-Google-Smtp-Source: AKy350YggGaNwlCiD44A9fbZNxJ9fiMPPjkEibtO9jlaqdKe41qSgM6COfug3Ijk1CVuzPPiqZRrxlXOyJRa
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e705:3a3d:46e5:fb50])
 (user=irogers job=sendgmr) by 2002:a81:af02:0:b0:544:8bc1:a179 with SMTP id
 n2-20020a81af02000000b005448bc1a179mr2383526ywh.4.1679599279347; Thu, 23 Mar
 2023 12:21:19 -0700 (PDT)
Date:   Thu, 23 Mar 2023 12:20:24 -0700
In-Reply-To: <20230323192028.135759-1-irogers@google.com>
Message-Id: <20230323192028.135759-6-irogers@google.com>
Mime-Version: 1.0
References: <20230323192028.135759-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v2 5/9] perf vendor events: Haswellx v27 events
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
 .../perf/pmu-events/arch/x86/haswellx/cache.json |  2 +-
 .../pmu-events/arch/x86/haswellx/pipeline.json   |  8 ++++++++
 .../arch/x86/haswellx/uncore-cache.json          | 16 ++++++++--------
 .../arch/x86/haswellx/uncore-other.json          |  6 +++---
 tools/perf/pmu-events/arch/x86/mapfile.csv       |  2 +-
 5 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/haswellx/cache.json b/tools/per=
f/pmu-events/arch/x86/haswellx/cache.json
index 1836ed62694e..a6c81010b394 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/cache.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/cache.json
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
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json b/tools/=
perf/pmu-events/arch/x86/haswellx/pipeline.json
index 9ac36c1c24b6..540f4372623c 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
@@ -194,6 +194,14 @@
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
d macro conditional branches.",
         "EventCode": "0x89",
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json b/to=
ols/perf/pmu-events/arch/x86/haswellx/uncore-cache.json
index 183bcac99642..e969dc71bea1 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json
@@ -3114,7 +3114,7 @@
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
@@ -3123,7 +3123,7 @@
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
@@ -3132,7 +3132,7 @@
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
@@ -3141,7 +3141,7 @@
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
@@ -3150,7 +3150,7 @@
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
@@ -3159,7 +3159,7 @@
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
@@ -3168,7 +3168,7 @@
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
@@ -3177,7 +3177,7 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-other.json b/to=
ols/perf/pmu-events/arch/x86/haswellx/uncore-other.json
index 4c3e2a794117..d30e3b16c1af 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-other.json
@@ -474,7 +474,7 @@
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
@@ -2256,7 +2256,7 @@
         "EventCode": "0x33",
         "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED.AD",
         "PerPkg": "1",
-        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credts from the VN0 pool.  N=
ote that a single packet may require multiple flit buffers (i.e. when data =
is being transferred).  Therefore, this event will increment by the number =
of credits acquired in each cycle.  Filtering based on message class is not=
 provided.  One can count the number of packets transferred in a given mess=
age class using an qfclk event.; Filter for the Home (HOM) message class.  =
HOM is generally used to send requests, request responses, and snoop respon=
ses.",
+        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credits from the VN0 pool.  =
Note that a single packet may require multiple flit buffers (i.e. when data=
 is being transferred).  Therefore, this event will increment by the number=
 of credits acquired in each cycle.  Filtering based on message class is no=
t provided.  One can count the number of packets transferred in a given mes=
sage class using an qfclk event.; Filter for the Home (HOM) message class. =
 HOM is generally used to send requests, request responses, and snoop respo=
nses.",
         "UMask": "0x1",
         "Unit": "R3QPI"
     },
@@ -2265,7 +2265,7 @@
         "EventCode": "0x33",
         "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED.BL",
         "PerPkg": "1",
-        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credts from the VN0 pool.  N=
ote that a single packet may require multiple flit buffers (i.e. when data =
is being transferred).  Therefore, this event will increment by the number =
of credits acquired in each cycle.  Filtering based on message class is not=
 provided.  One can count the number of packets transferred in a given mess=
age class using an qfclk event.; Filter for the Home (HOM) message class.  =
HOM is generally used to send requests, request responses, and snoop respon=
ses.",
+        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credits from the VN0 pool.  =
Note that a single packet may require multiple flit buffers (i.e. when data=
 is being transferred).  Therefore, this event will increment by the number=
 of credits acquired in each cycle.  Filtering based on message class is no=
t provided.  One can count the number of packets transferred in a given mes=
sage class using an qfclk event.; Filter for the Home (HOM) message class. =
 HOM is generally used to send requests, request responses, and snoop respo=
nses.",
         "UMask": "0x4",
         "Unit": "R3QPI"
     },
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 927e60f3417d..e1a609401fff 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -11,7 +11,7 @@ GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-A[DE],v1.01,graniterapids,core
 GenuineIntel-6-(3C|45|46),v33,haswell,core
-GenuineIntel-6-3F,v26,haswellx,core
+GenuineIntel-6-3F,v27,haswellx,core
 GenuineIntel-6-(7D|7E|A7),v1.17,icelake,core
 GenuineIntel-6-6[AC],v1.19,icelakex,core
 GenuineIntel-6-3A,v23,ivybridge,core
--=20
2.40.0.348.gf938b09366-goog

