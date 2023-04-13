Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4FA6E064B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 07:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjDMFMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 01:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjDMFMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 01:12:19 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE5283F0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:11:41 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54c01480e3cso218839137b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681362700; x=1683954700;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Vu/qm7ebPvmIhqU01a0jg47awCkYqvwG1si0PjsgVU=;
        b=UMu0R3k9w0YprKPTIsgaboiFpjH3NjPr9Euwevmb5rHSILgiwgNRTA4QKgs3ErbGWX
         WYrDPlBq2aNM846XU6Mjt4yYLnz/ImtRAjczYyGd5TdqLVer5cU5Laf0XJG46w7ILP1/
         e+DRfJ8SoEPy/SGeC33R25LYY27Cd3NHWNNQUztU9+JMQKpiVrXu2J94jigFHVf1X7lO
         kbatSwd55VZQeMDh3x/KAhIrv/LpOlVDjEscHS+5jRAG1Rx1kRXqEPrUgVrkSeZ1eJUo
         Mri0na4tz5kXU/Z0M+eIsE8WoQeYpnS9FuDFkGRSC9XEBJV2vDz3BFh4jEuA5WSXmidC
         yXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681362700; x=1683954700;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0Vu/qm7ebPvmIhqU01a0jg47awCkYqvwG1si0PjsgVU=;
        b=juZY69bLSjiP4px9YOcDWpGUawoErLJYH9ME5OqXdm/aD3cJScRAyytGIzYpX5jSe0
         LdhhAkaP8+jhXBl4DyqGiZOaWPP9FQDXymGd0XiIwi+jYvh8BPztZr0jgTJS7up8fEFF
         b4ZODQk8NZSzpYuYKChFsNiv5Tqn/RfprlgdzEh+hZBFoNCjnhrQ+7eOwxwzi0SXIbFf
         AYQ8tf8OgQ3soxA2lz4joO01Uz7MQhpG7Zo7k5HZnVPkE/VoxqPbJp+3qT6VDBJlws0u
         r2NeUULL/tLKjVpPkgntC0O3TiwgEvr+o5UBqUYbVxbie/66IMMZ4F/LjS5fVe3ghb+1
         J9ag==
X-Gm-Message-State: AAQBX9fL3wwZA7UJyyBoTb45ZBil9VerL2f/OWwKWKgomrbsFD2AV1Bi
        UG/qd0wvABtopg+U7mAnDDyKX+kBbxmY
X-Google-Smtp-Source: AKy350aH3grBLHyrCS1N/3YkPxU8/YgPTNuMdumUqc3VTx+Ys82HzSIWC42eN9itudm6ixNJzzs5lj2XwVpH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c8fe:b894:ec92:d5cd])
 (user=irogers job=sendgmr) by 2002:a0d:ec02:0:b0:54c:2723:560d with SMTP id
 q2-20020a0dec02000000b0054c2723560dmr634285ywn.3.1681362700536; Wed, 12 Apr
 2023 22:11:40 -0700 (PDT)
Date:   Wed, 12 Apr 2023 22:09:57 -0700
In-Reply-To: <20230413051011.3440849-1-irogers@google.com>
Message-Id: <20230413051011.3440849-8-irogers@google.com>
Mime-Version: 1.0
References: <20230413051011.3440849-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v2 07/21] perf vendor events intel: Fix uncore topics for broadwellde
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
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
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

Remove 'uncore-other' topic classification, move to cache,
interconnect and io.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/broadwellde/uncore-cache.json    | 324 ++++-----
 .../x86/broadwellde/uncore-interconnect.json  | 614 ++++++++++++++++++
 .../{uncore-other.json =3D> uncore-io.json}     | 612 -----------------
 3 files changed, 776 insertions(+), 774 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwellde/uncore-inter=
connect.json
 rename tools/perf/pmu-events/arch/x86/broadwellde/{uncore-other.json =3D> =
uncore-io.json} (53%)

diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json b=
/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
index 2bf23ef7bfac..56bba6d4e0f6 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
@@ -4,13 +4,13 @@
         "EventCode": "0xA",
         "EventName": "UNC_C_BOUNCE_CONTROL",
         "PerPkg": "1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Uncore Clocks",
         "EventName": "UNC_C_CLOCKTICKS",
         "PerPkg": "1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Counter 0 Occupancy",
@@ -18,7 +18,7 @@
         "EventName": "UNC_C_COUNTER0_OCCUPANCY",
         "PerPkg": "1",
         "PublicDescription": "Since occupancy counts can only be captured =
in the Cbo's 0 counter, this event allows a user to capture occupancy relat=
ed information by filtering the Cb0 occupancy count captured in Counter 0. =
  The filtering available is found in the control register - threshold, inv=
ert and edge detect.   E.g. setting threshold to 1 can effectively monitor =
how many cycles the monitored queue has an entry.",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "FaST wire asserted",
@@ -26,7 +26,7 @@
         "EventName": "UNC_C_FAST_ASSERTED",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles either the local=
 distress or incoming distress signals are asserted.  Incoming distress inc=
ludes both up and dn.",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cache Lookups; Any Request",
@@ -35,7 +35,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Filters for any transaction originati=
ng from the IPQ or IRQ.  This does not include lookups originating from the=
 ISMQ.",
         "UMask": "0x11",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cache Lookups; Data Read Request",
@@ -44,7 +44,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Read transactions",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cache Lookups; Lookups that Match NID",
@@ -53,7 +53,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Qualify one of the other subevents by=
 the Target NID.  The NID is programmed in Cn_MSR_PMON_BOX_FILTER.nid.   In=
 conjunction with STATE =3D I, it is possible to monitor misses to specific=
 NIDs in the system.",
         "UMask": "0x41",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cache Lookups; Any Read Request",
@@ -62,7 +62,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Read transactions",
         "UMask": "0x21",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cache Lookups; External Snoop Request",
@@ -71,7 +71,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Filters for only snoop requests comin=
g from the remote socket(s) through the IPQ.",
         "UMask": "0x9",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cache Lookups; Write Requests",
@@ -80,7 +80,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Writeback transactions from L2 to the=
 LLC  This includes all write transactions -- both Cacheable and UC.",
         "UMask": "0x5",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Lines Victimized; Lines in E state",
@@ -89,7 +89,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Lines Victimized",
@@ -98,7 +98,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Lines Victimized; Lines in S State",
@@ -107,7 +107,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Lines Victimized",
@@ -116,7 +116,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Lines Victimized; Lines in M state",
@@ -125,7 +125,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Lines Victimized; Victimized Lines that Match=
 NID",
@@ -134,7 +134,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.; Qu=
alify one of the other subevents by the Target NID.  The NID is programmed =
in Cn_MSR_PMON_BOX_FILTER.nid.   In conjunction with STATE =3D I, it is pos=
sible to monitor misses to specific NIDs in the system.",
         "UMask": "0x40",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cbo Misc; DRd hitting non-M with raw CV=3D0",
@@ -143,7 +143,7 @@
         "PerPkg": "1",
         "PublicDescription": "Miscellaneous events in the Cbo.",
         "UMask": "0x20",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cbo Misc; Clean Victim with raw CV=3D0",
@@ -152,7 +152,7 @@
         "PerPkg": "1",
         "PublicDescription": "Miscellaneous events in the Cbo.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cbo Misc; RFO HitS",
@@ -161,7 +161,7 @@
         "PerPkg": "1",
         "PublicDescription": "Miscellaneous events in the Cbo.; Number of =
times that an RFO hit in S state.  This is useful for determining if it mig=
ht be good for a workload to use RspIWB instead of RspSWB.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cbo Misc; Silent Snoop Eviction",
@@ -170,7 +170,7 @@
         "PerPkg": "1",
         "PublicDescription": "Miscellaneous events in the Cbo.; Counts the=
 number of times when a Snoop hit in FSE states and triggered a silent evic=
tion.  This is useful because this information is lost in the PRE encodings=
.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cbo Misc",
@@ -179,7 +179,7 @@
         "PerPkg": "1",
         "PublicDescription": "Miscellaneous events in the Cbo.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cbo Misc; Write Combining Aliasing",
@@ -188,7 +188,7 @@
         "PerPkg": "1",
         "PublicDescription": "Miscellaneous events in the Cbo.; Counts the=
 number of times that a USWC write (WCIL(F)) transaction hit in the LLC in =
M state, triggering a WBMtoI followed by the USWC write.  This occurs when =
there is WC aliasing.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "LRU Queue; LRU Age 0",
@@ -197,7 +197,7 @@
         "PerPkg": "1",
         "PublicDescription": "How often age was set to 0",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "LRU Queue; LRU Age 1",
@@ -206,7 +206,7 @@
         "PerPkg": "1",
         "PublicDescription": "How often age was set to 1",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "LRU Queue; LRU Age 2",
@@ -215,7 +215,7 @@
         "PerPkg": "1",
         "PublicDescription": "How often age was set to 2",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "LRU Queue; LRU Age 3",
@@ -224,7 +224,7 @@
         "PerPkg": "1",
         "PublicDescription": "How often age was set to 3",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "LRU Queue; LRU Bits Decremented",
@@ -233,7 +233,7 @@
         "PerPkg": "1",
         "PublicDescription": "How often all LRU bits were decremented by 1=
",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "LRU Queue; Non-0 Aged Victim",
@@ -242,7 +242,7 @@
         "PerPkg": "1",
         "PublicDescription": "How often we picked a victim that had a non-=
zero age",
         "UMask": "0x20",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD Ring In Use; All",
@@ -251,7 +251,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.",
         "UMask": "0xf",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD Ring In Use; Down",
@@ -260,7 +260,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.",
         "UMask": "0xc",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD Ring In Use; Up",
@@ -269,7 +269,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD Ring In Use; Down and Even",
@@ -278,7 +278,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Down and Even ring polarity.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD Ring In Use; Down and Odd",
@@ -287,7 +287,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Down and Odd ring polarity.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD Ring In Use; Up and Even",
@@ -296,7 +296,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Up and Even ring polarity.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD Ring In Use; Up and Odd",
@@ -305,7 +305,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Up and Odd ring polarity.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK Ring In Use; All",
@@ -314,7 +314,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
         "UMask": "0xf",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK Ring In Use; Down",
@@ -323,7 +323,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
         "UMask": "0xc",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK Ring In Use; Up",
@@ -332,7 +332,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK Ring In Use; Down and Even",
@@ -341,7 +341,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Down and Even ring polarity.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK Ring In Use; Down and Odd",
@@ -350,7 +350,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Down and Odd ring polarity.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK Ring In Use; Up and Even",
@@ -359,7 +359,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Up and Even ring polarity.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK Ring In Use; Up and Odd",
@@ -368,7 +368,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Up and Odd ring polarity.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Down",
@@ -377,7 +377,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
         "UMask": "0xf",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Down",
@@ -386,7 +386,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
         "UMask": "0xc",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Up",
@@ -395,7 +395,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Down and Even",
@@ -404,7 +404,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Down and Even ring polarity.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Down and Odd",
@@ -413,7 +413,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Down and Odd ring polarity.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Up and Even",
@@ -422,7 +422,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Up and Even ring polarity.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Up and Odd",
@@ -431,7 +431,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Up and Odd ring polarity.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; AD",
@@ -439,7 +439,7 @@
         "EventName": "UNC_C_RING_BOUNCES.AD",
         "PerPkg": "1",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; AK",
@@ -447,7 +447,7 @@
         "EventName": "UNC_C_RING_BOUNCES.AK",
         "PerPkg": "1",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; BL",
@@ -455,7 +455,7 @@
         "EventName": "UNC_C_RING_BOUNCES.BL",
         "PerPkg": "1",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Snoops of processor's cache.",
@@ -463,7 +463,7 @@
         "EventName": "UNC_C_RING_BOUNCES.IV",
         "PerPkg": "1",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Any",
@@ -472,7 +472,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  There is only 1 IV ring in BDX  Therefore, if=
 one wants to monitor the Even ring, they should select both UP_EVEN and DN=
_EVEN.  To monitor the Odd ring, they should select both UP_ODD and DN_ODD.=
; Filters any polarity",
         "UMask": "0xf",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Any",
@@ -481,7 +481,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  There is only 1 IV ring in BDX  Therefore, if=
 one wants to monitor the Even ring, they should select both UP_EVEN and DN=
_EVEN.  To monitor the Odd ring, they should select both UP_ODD and DN_ODD.=
; Filters any polarity",
         "UMask": "0xc",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Down",
@@ -490,7 +490,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  There is only 1 IV ring in BDX  Therefore, if=
 one wants to monitor the Even ring, they should select both UP_EVEN and DN=
_EVEN.  To monitor the Odd ring, they should select both UP_ODD and DN_ODD.=
; Filters for Down polarity",
         "UMask": "0xcc",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Any",
@@ -499,7 +499,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  There is only 1 IV ring in BDX  Therefore, if=
 one wants to monitor the Even ring, they should select both UP_EVEN and DN=
_EVEN.  To monitor the Odd ring, they should select both UP_ODD and DN_ODD.=
; Filters any polarity",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD",
@@ -507,7 +507,7 @@
         "EventName": "UNC_C_RING_SINK_STARVED.AD",
         "PerPkg": "1",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK",
@@ -515,7 +515,7 @@
         "EventName": "UNC_C_RING_SINK_STARVED.AK",
         "PerPkg": "1",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL",
@@ -523,7 +523,7 @@
         "EventName": "UNC_C_RING_SINK_STARVED.BL",
         "PerPkg": "1",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "IV",
@@ -531,14 +531,14 @@
         "EventName": "UNC_C_RING_SINK_STARVED.IV",
         "PerPkg": "1",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Number of cycles the Cbo is actively throttli=
ng traffic onto the Ring in order to limit bounce traffic.",
         "EventCode": "0x7",
         "EventName": "UNC_C_RING_SRC_THRTL",
         "PerPkg": "1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Arbiter Blocking Cycles; IRQ",
@@ -547,7 +547,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts cycles in external starvation.  This =
occurs when one of the ingress queues is being starved by the other queues.=
; IPQ is externally startved and therefore we are blocking the IRQ.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Arbiter Blocking Cycles; IPQ",
@@ -556,7 +556,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts cycles in external starvation.  This =
occurs when one of the ingress queues is being starved by the other queues.=
; IRQ is externally starved and therefore we are blocking the IPQ.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Arbiter Blocking Cycles; ISMQ_BID",
@@ -565,7 +565,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts cycles in external starvation.  This =
occurs when one of the ingress queues is being starved by the other queues.=
; Number of times that the ISMQ Bid.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Arbiter Blocking Cycles; PRQ",
@@ -574,7 +574,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts cycles in external starvation.  This =
occurs when one of the ingress queues is being starved by the other queues.=
",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Allocations; IPQ",
@@ -583,7 +583,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Allocations; IRQ",
@@ -592,7 +592,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Allocations; IRQ Rejected",
@@ -601,7 +601,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Allocations; PRQ",
@@ -610,7 +610,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Allocations; PRQ",
@@ -619,7 +619,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
         "UMask": "0x20",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Internal Starvation Cycles; IPQ",
@@ -628,7 +628,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts cycles in internal starvation.  This =
occurs when one (or more) of the entries in the ingress queue are being sta=
rved out by other entries in that queue.; Cycles with the IPQ in Internal S=
tarvation.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Internal Starvation Cycles; IRQ",
@@ -637,7 +637,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts cycles in internal starvation.  This =
occurs when one (or more) of the entries in the ingress queue are being sta=
rved out by other entries in that queue.; Cycles with the IRQ in Internal S=
tarvation.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Internal Starvation Cycles; ISMQ",
@@ -646,7 +646,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts cycles in internal starvation.  This =
occurs when one (or more) of the entries in the ingress queue are being sta=
rved out by other entries in that queue.; Cycles with the ISMQ in Internal =
Starvation.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Internal Starvation Cycles; PRQ",
@@ -655,7 +655,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts cycles in internal starvation.  This =
occurs when one (or more) of the entries in the ingress queue are being sta=
rved out by other entries in that queue.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Probe Queue Retries; Address Conflict",
@@ -664,7 +664,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.; Counts=
 the number of times that a request form the IPQ was retried because of a T=
OR reject from an address conflicts.  Address conflicts out of the IPQ shou=
ld be rare.  They will generally only occur if two different sockets are se=
nding requests to the same address at the same time.  This is a true confli=
ct case, unlike the IPQ Address Conflict which is commonly caused by prefet=
ching characteristics.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Probe Queue Retries; Any Reject",
@@ -673,7 +673,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.; Counts=
 the number of times that a request form the IPQ was retried because of a T=
OR reject.  TOR rejects from the IPQ can be caused by the Egress being full=
 or Address Conflicts.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Probe Queue Retries; No Egress Credits",
@@ -682,7 +682,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.; Counts=
 the number of times that a request form the IPQ was retried because of a T=
OR reject from the Egress being full.  IPQ requests make use of the AD Egre=
ss for regular responses, the BL egress to forward data, and the AK egress =
to return credits.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Probe Queue Retries; No QPI Credits",
@@ -691,7 +691,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Probe Queue Retries; No AD Sbo Credits",
@@ -700,7 +700,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.; Counts=
 the number of times that a request from the IPQ was retried because of it =
lacked credits to send an AD packet to the Sbo.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Probe Queue Retries; Target Node Filter",
@@ -709,7 +709,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.; Counts=
 the number of times that a request from the IPQ was retried filtered by th=
e Target NodeID as specified in the Cbox's Filter register.",
         "UMask": "0x40",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; Address Confli=
ct",
@@ -718,7 +718,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that a request fr=
om the IRQ was retried because of an address match in the TOR.  In order to=
 maintain coherency, requests to the same address are not allowed to pass e=
ach other up in the Cbo.  Therefore, if there is an outstanding request to =
a given address, one cannot issue another request to that address until it =
is complete.  This comes up most commonly with prefetches.  Outstanding pre=
fetches occasionally will not complete their memory fetch and a demand requ=
est to the same address will then sit in the IRQ and get retried until the =
prefetch fills the data into the LLC.  Therefore, it will not be uncommon t=
o see this case in high bandwidth streaming workloads when the LLC Prefetch=
er in the core is enabled.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; Any Reject",
@@ -727,7 +727,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of IRQ retries that occur.=
  Requests from the IRQ are retried if they are rejected from the TOR pipel=
ine for a variety of reasons.  Some of the most common reasons include if t=
he Egress is full, there are no RTIDs, or there is a Physical Address match=
 to another outstanding request.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No Egress Cred=
its",
@@ -736,7 +736,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that a request fr=
om the IRQ was retried because it failed to acquire an entry in the Egress.=
  The egress is the buffer that queues up for allocating onto the ring.  IR=
Q requests can make use of all four rings and all four Egresses.  If any of=
 the queues that a given request needs to make use of are full, the request=
 will be retried.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No IIO Credits=
",
@@ -745,7 +745,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a request attempted to acqui=
re the NCS/NCB credit for sending messages on BL to the IIO.  There is a si=
ngle credit in each CBo that is shared between the NCS and NCB message clas=
ses for sending transactions on the BL ring (such as read data) to the IIO.=
",
         "UMask": "0x20",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects",
@@ -754,7 +754,7 @@
         "PerPkg": "1",
         "PublicDescription": "Qualify one of the other subevents by a give=
n RTID destination NID.  The NID is programmed in Cn_MSR_PMON_BOX_FILTER1.n=
id.",
         "UMask": "0x40",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No QPI Credits=
",
@@ -763,7 +763,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of requests rejects because of lack o=
f QPI Ingress credits.  These credits are required in order to send transac=
tions to the QPI agent.  Please see the QPI_IGR_CREDITS events for more inf=
ormation.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No RTIDs",
@@ -772,7 +772,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that requests fro=
m the IRQ were retried because there were no RTIDs available.  RTIDs are re=
quired after a request misses the LLC and needs to send snoops and/or reque=
sts to memory.  If there are no RTIDs available, requests will queue up in =
the IRQ and retry until one becomes available.  Note that there are multipl=
e RTID pools for the different sockets.  There may be cases where the local=
 RTIDs are all used, but requests destined for remote memory can still acqu=
ire an RTID because there are remote RTIDs available.  This event does not =
provide any filtering for this case.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No AD Sbo Cred=
its",
@@ -781,7 +781,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that a request fr=
om the IPQ was retried because of it lacked credits to send an AD packet to=
 the Sbo.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No BL Sbo Cred=
its",
@@ -790,7 +790,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that a request fr=
om the IPQ was retried because of it lacked credits to send an BL packet to=
 the Sbo.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; Target Node Fi=
lter",
@@ -799,7 +799,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that a request fr=
om the IPQ was retried filtered by the Target NodeID as specified in the Cb=
ox's Filter register.",
         "UMask": "0x40",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "ISMQ Retries; Any Reject",
@@ -808,7 +808,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.; Counts the =
total number of times that a request from the ISMQ retried because of a TOR=
 reject.  ISMQ requests generally will not need to retry (or at least ISMQ =
retries are less common than IRQ retries).  ISMQ requests will retry if the=
y are not able to acquire a needed Egress credit to get onto the ring, or f=
or cache evictions that need to acquire an RTID.  Most ISMQ requests alread=
y have an RTID, so eviction retries will be less common here.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "ISMQ Retries; No Egress Credits",
@@ -817,7 +817,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.; Counts the =
number of times that a request from the ISMQ retried because of a TOR rejec=
t caused by a lack of Egress credits. The egress is the buffer that queues =
up for allocating onto the ring.  If any of the Egress queues that a given =
request needs to make use of are full, the request will be retried.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "ISMQ Retries; No IIO Credits",
@@ -826,7 +826,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.; Number of t=
imes a request attempted to acquire the NCS/NCB credit for sending messages=
 on BL to the IIO.  There is a single credit in each CBo that is shared bet=
ween the NCS and NCB message classes for sending transactions on the BL rin=
g (such as read data) to the IIO.",
         "UMask": "0x20",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "ISMQ Retries",
@@ -835,7 +835,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.; Qualify one=
 of the other subevents by a given RTID destination NID.  The NID is progra=
mmed in Cn_MSR_PMON_BOX_FILTER1.nid.",
         "UMask": "0x40",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "ISMQ Retries; No QPI Credits",
@@ -844,7 +844,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "ISMQ Retries; No RTIDs",
@@ -853,7 +853,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.; Counts the =
number of times that a request from the ISMQ retried because of a TOR rejec=
t caused by no RTIDs.  M-state cache evictions are serviced through the ISM=
Q, and must acquire an RTID in order to write back to memory.  If no RTIDs =
are available, they will be retried.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "ISMQ Retries",
@@ -862,7 +862,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.; Qualify one=
 of the other subevents by a given RTID destination NID.  The NID is progra=
mmed in Cn_MSR_PMON_BOX_FILTER1.nid.",
         "UMask": "0x80",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "ISMQ Request Queue Rejects; No AD Sbo Credits=
",
@@ -871,7 +871,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that a request fr=
om the ISMQ was retried because of it lacked credits to send an AD packet t=
o the Sbo.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "ISMQ Request Queue Rejects; No BL Sbo Credits=
",
@@ -880,7 +880,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that a request fr=
om the ISMQ was retried because of it lacked credits to send an BL packet t=
o the Sbo.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "ISMQ Request Queue Rejects; Target Node Filte=
r",
@@ -889,7 +889,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that a request fr=
om the ISMQ was retried filtered by the Target NodeID as specified in the C=
box's Filter register.",
         "UMask": "0x40",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Occupancy; IPQ",
@@ -898,7 +898,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Occupancy; IRQ",
@@ -907,7 +907,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Occupancy; IRQ Rejected",
@@ -916,7 +916,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Occupancy; PRQ Rejects",
@@ -925,7 +925,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.",
         "UMask": "0x20",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "SBo Credits Acquired; For AD Ring",
@@ -934,7 +934,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of Sbo credits acquired in a given cy=
cle, per ring.  Each Cbo is assigned an Sbo it can communicate with.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "SBo Credits Acquired; For BL Ring",
@@ -943,7 +943,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of Sbo credits acquired in a given cy=
cle, per ring.  Each Cbo is assigned an Sbo it can communicate with.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "SBo Credits Occupancy; For AD Ring",
@@ -952,7 +952,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of Sbo credits in use in a given cycl=
e, per ring.  Each Cbo is assigned an Sbo it can communicate with.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "SBo Credits Occupancy; For BL Ring",
@@ -961,7 +961,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of Sbo credits in use in a given cycl=
e, per ring.  Each Cbo is assigned an Sbo it can communicate with.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; All",
@@ -970,7 +970,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
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
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Evictions",
@@ -979,7 +979,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
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
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Local Memory",
@@ -988,7 +988,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserte=
d into the TOR that are satisfied by locally HOMed memory.",
         "UMask": "0x28",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Local Memory - Opcode Matched",
@@ -997,7 +997,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisf=
ied by an opcode,  inserted into the TOR that are satisfied by locally HOMe=
d memory.",
         "UMask": "0x21",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Misses to Local Memory",
@@ -1006,7 +1006,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that are satisfied by locally HOMed memory.",
         "UMask": "0x2a",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Misses to Local Memory - Opcode =
Matched",
@@ -1015,7 +1015,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satis=
fied by an opcode, inserted into the TOR that are satisfied by locally HOMe=
d memory.",
         "UMask": "0x23",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Miss Opcode Match",
@@ -1024,7 +1024,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Misses to Remote Memory",
@@ -1033,7 +1033,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that are satisfied by remote caches or remote memory.",
         "UMask": "0x8a",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Misses to Remote Memory - Opcode=
 Matched",
@@ -1042,7 +1042,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satis=
fied by an opcode,  inserted into the TOR that are satisfied by remote cach=
es or remote memory.",
         "UMask": "0x83",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; NID Matched",
@@ -1051,7 +1051,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
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
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; NID Matched Evictions",
@@ -1060,7 +1060,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched eviction tra=
nsactions inserted into the TOR.",
         "UMask": "0x44",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; NID Matched Miss All",
@@ -1069,7 +1069,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched miss req=
uests that were inserted into the TOR.",
         "UMask": "0x4a",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; NID and Opcode Matched Miss",
@@ -1078,7 +1078,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match a NID and an opcode.",
         "UMask": "0x43",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; NID and Opcode Matched",
@@ -1087,7 +1087,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match a NID and an opcode.",
         "UMask": "0x41",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; NID Matched Writebacks",
@@ -1096,7 +1096,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched write transa=
ctions inserted into the TOR.",
         "UMask": "0x50",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Opcode Match",
@@ -1105,7 +1105,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Remote Memory",
@@ -1114,7 +1114,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserte=
d into the TOR that are satisfied by remote caches or remote memory.",
         "UMask": "0x88",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Remote Memory - Opcode Matched",
@@ -1123,7 +1123,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisf=
ied by an opcode,  inserted into the TOR that are satisfied by remote cache=
s or remote memory.",
         "UMask": "0x81",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Writebacks",
@@ -1132,7 +1132,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Write transactions inser=
ted into the TOR.   This does not include RFO, but actual operations that c=
ontain data being sent from the core.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; Any",
@@ -1141,7 +1141,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); All valid TO=
R entries.  This includes requests that reside in the TOR for a short time,=
 such as LLC Hits that do not need to snoop cores or requests that get reje=
cted and have to be retried through one of the ingress queues.  The TOR is =
more commonly a bottleneck in skews with smaller core counts, where the rat=
io of RTIDs to TOR entries is larger.  Note that there are reserved TOR ent=
ries for various request types, so it is possible that a given request type=
 be blocked with an occupancy that is less than 20.  Also note that general=
ly requests will not be able to arbitrate into the TOR pipeline if there ar=
e no available TOR slots.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; Evictions",
@@ -1150,7 +1150,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding eviction transactions in the TOR.  Evictions can be quick, such a=
s when the line is in the F, S, or E states and no core valid bits are set.=
  They can also be longer if either CV bits are set (so the cores need to b=
e snooped) and/or if there is a HitM (in which case it is necessary to writ=
e the request out to memory).",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy",
@@ -1159,7 +1159,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
         "UMask": "0x28",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; Local Memory - Opcode Matched"=
,
@@ -1168,7 +1168,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisfied by an opcode,  in the TOR that are satis=
fied by locally HOMed memory.",
         "UMask": "0x21",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; Miss All",
@@ -1177,7 +1177,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding miss requests in the TOR.  'Miss' means the allocation requires a=
n RTID.  This generally means that the request was sent to memory or MMIO."=
,
         "UMask": "0xa",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy",
@@ -1186,7 +1186,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
         "UMask": "0x2a",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; Misses to Local Memory - Opcod=
e Matched",
@@ -1195,7 +1195,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisfied by an opcode, in the TOR that are sa=
tisfied by locally HOMed memory.",
         "UMask": "0x23",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; Miss Opcode Match",
@@ -1204,7 +1204,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); TOR entries =
for miss transactions that match an opcode. This generally means that the r=
equest was sent to memory or MMIO.",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy",
@@ -1213,7 +1213,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
         "UMask": "0x8a",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; Misses to Remote Memory - Opco=
de Matched",
@@ -1222,7 +1222,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisfied by an opcode, in the TOR that are sa=
tisfied by remote caches or remote memory.",
         "UMask": "0x83",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; NID Matched",
@@ -1231,7 +1231,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of NI=
D matched outstanding requests in the TOR.  The NID is programmed in Cn_MSR=
_PMON_BOX_FILTER.nid.In conjunction with STATE =3D I, it is possible to mon=
itor misses to specific NIDs in the system.",
         "UMask": "0x48",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; NID Matched Evictions",
@@ -1240,7 +1240,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding NID matched eviction transactions in the TOR .",
         "UMask": "0x44",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; NID Matched",
@@ -1249,7 +1249,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss requests in the TOR that match a NID.",
         "UMask": "0x4a",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; NID and Opcode Matched Miss",
@@ -1258,7 +1258,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss requests in the TOR that match a NID and an opcode.",
         "UMask": "0x43",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; NID and Opcode Matched",
@@ -1267,7 +1267,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); TOR entries =
that match a NID and an opcode.",
         "UMask": "0x41",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; NID Matched Writebacks",
@@ -1276,7 +1276,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); NID matched =
write transactions int the TOR.",
         "UMask": "0x50",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; Opcode Match",
@@ -1285,7 +1285,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); TOR entries =
that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc).",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy",
@@ -1294,7 +1294,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
         "UMask": "0x88",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; Remote Memory - Opcode Matched=
",
@@ -1303,7 +1303,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisfied by an opcode,  in the TOR that are satis=
fied by remote caches or remote memory.",
         "UMask": "0x81",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; Writebacks",
@@ -1312,7 +1312,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Write transa=
ctions in the TOR.   This does not include RFO, but actual operations that =
contain data being sent from the core.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Onto AD Ring",
@@ -1320,7 +1320,7 @@
         "EventName": "UNC_C_TxR_ADS_USED.AD",
         "PerPkg": "1",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Onto AK Ring",
@@ -1328,7 +1328,7 @@
         "EventName": "UNC_C_TxR_ADS_USED.AK",
         "PerPkg": "1",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Onto BL Ring",
@@ -1336,7 +1336,7 @@
         "EventName": "UNC_C_TxR_ADS_USED.BL",
         "PerPkg": "1",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Egress Allocations; AD - Cachebo",
@@ -1345,7 +1345,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Cachebo destined for the AD ring.  Some example include out=
bound requests, snoop requests, and snoop responses.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Egress Allocations; AD - Corebo",
@@ -1354,7 +1354,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Corebo destined for the AD ring.  This is commonly used for=
 outbound requests.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Egress Allocations; AK - Cachebo",
@@ -1363,7 +1363,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Cachebo destined for the AK ring.  This is commonly used fo=
r credit returns and GO responses.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Egress Allocations; AK - Corebo",
@@ -1372,7 +1372,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Corebo destined for the AK ring.  This is commonly used for=
 snoop responses coming from the core and destined for a Cachebo.",
         "UMask": "0x20",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Egress Allocations; BL - Cacheno",
@@ -1381,7 +1381,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Cachebo destined for the BL ring.  This is commonly used to=
 send data from the cache to various destinations.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Egress Allocations; BL - Corebo",
@@ -1390,7 +1390,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Corebo destined for the BL ring.  This is commonly used for=
 transferring writeback data to the cache.",
         "UMask": "0x40",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Egress Allocations; IV - Cachebo",
@@ -1399,7 +1399,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Cachebo destined for the IV ring.  This is commonly used fo=
r snoops to the cores.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Injection Starvation; Onto AD Ring (to core)"=
,
@@ -1408,7 +1408,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Egress cannot send a transaction onto the ring for =
a long period of time.; cycles that the core AD egress spent in starvation"=
,
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Injection Starvation; Onto AK Ring",
@@ -1417,7 +1417,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Egress cannot send a transaction onto the ring for =
a long period of time.; cycles that both AK egresses spent in starvation",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Injection Starvation; Onto BL Ring",
@@ -1426,7 +1426,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Egress cannot send a transaction onto the ring for =
a long period of time.; cycles that both BL egresses spent in starvation",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Injection Starvation; Onto IV Ring",
@@ -1435,7 +1435,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Egress cannot send a transaction onto the ring for =
a long period of time.; cycles that the cachebo IV egress spent in starvati=
on",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BT Cycles Not Empty",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-interconnect=
.json b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-interconnect.json
new file mode 100644
index 000000000000..8a327e0f1441
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-interconnect.json
@@ -0,0 +1,614 @@
+[
+    {
+        "BriefDescription": "Total Write Cache Occupancy; Any Source",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of reads and writes t=
hat are outstanding in the uncore in each cycle.  This is effectively the s=
um of the READ_OCCUPANCY and WRITE_OCCUPANCY events.; Tracks all requests f=
rom any source port.",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Total Write Cache Occupancy; Select Source",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.SOURCE",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of reads and writes t=
hat are outstanding in the uncore in each cycle.  This is effectively the s=
um of the READ_OCCUPANCY and WRITE_OCCUPANCY events.; Tracks only those req=
uests that come from the port specified in the IRP_PmonFilter.OrderingQ reg=
ister.  This register allows one to select one specific queue.  It is not p=
ossible to monitor multiple queues at a time.",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Clocks in the IRP",
+        "EventName": "UNC_I_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of clocks in the IRP.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; CLFlush",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_COHERENT_OPS.CLFLUSH",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "UMask": "0x80",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; CRd",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_COHERENT_OPS.CRD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; DRd",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_COHERENT_OPS.DRD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; PCIDCAHin5t",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_COHERENT_OPS.PCIDCAHINT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; PCIRdCur",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_COHERENT_OPS.PCIRDCUR",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; PCIItoM",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_COHERENT_OPS.PCITOM",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; RFO",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_COHERENT_OPS.RFO",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; WbMtoI",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_COHERENT_OPS.WBMTOI",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "UMask": "0x40",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Cache Inserts of Atomic =
Transactions as Secondary",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.2ND_ATOMIC_INSERT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts Timeouts - Set 0 : Cache Inserts of A=
tomic Transactions as Secondary",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Cache Inserts of Read Tr=
ansactions as Secondary",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.2ND_RD_INSERT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts Timeouts - Set 0 : Cache Inserts of R=
ead Transactions as Secondary",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Cache Inserts of Write T=
ransactions as Secondary",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.2ND_WR_INSERT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts Timeouts - Set 0 : Cache Inserts of W=
rite Transactions as Secondary",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Fastpath Rejects",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.FAST_REJ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts Timeouts - Set 0 : Fastpath Rejects",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Fastpath Requests",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.FAST_REQ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts Timeouts - Set 0 : Fastpath Requests"=
,
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Fastpath Transfers From =
Primary to Secondary",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.FAST_XFER",
+        "PerPkg": "1",
+        "PublicDescription": "Counts Timeouts - Set 0 : Fastpath Transfers=
 From Primary to Secondary",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Prefetch Ack Hints From =
Primary to Secondary",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.PF_ACK_HINT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts Timeouts - Set 0 : Prefetch Ack Hints=
 From Primary to Secondary",
+        "UMask": "0x40",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Prefetch TimeOut",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.PF_TIMEOUT",
+        "PerPkg": "1",
+        "PublicDescription": "Indicates the fetch for a previous prefetch =
wasn't accepted by the prefetch.   This happens in the case of a prefetch T=
imeOut",
+        "UMask": "0x80",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Data Throttled",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.DATA_THROTTLE",
+        "PerPkg": "1",
+        "PublicDescription": "IRP throttled switch data",
+        "UMask": "0x80",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.LOST_FWD",
+        "PerPkg": "1",
+        "PublicDescription": "Misc Events - Set 1 : Lost Forward : Snoop p=
ulled away ownership before a write was committed",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Received Invalid",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.SEC_RCVD_INVLD",
+        "PerPkg": "1",
+        "PublicDescription": "Secondary received a transfer that did not h=
ave sufficient MESI state",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Received Valid",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.SEC_RCVD_VLD",
+        "PerPkg": "1",
+        "PublicDescription": "Secondary received a transfer that did have =
sufficient MESI state",
+        "UMask": "0x40",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Slow Transfer of E Line"=
,
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.SLOW_E",
+        "PerPkg": "1",
+        "PublicDescription": "Secondary received a transfer that did have =
sufficient MESI state",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Slow Transfer of I Line"=
,
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.SLOW_I",
+        "PerPkg": "1",
+        "PublicDescription": "Snoop took cacheline ownership before write =
from data was committed.",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Slow Transfer of M Line"=
,
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.SLOW_M",
+        "PerPkg": "1",
+        "PublicDescription": "Snoop took cacheline ownership before write =
from data was committed.",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Slow Transfer of S Line"=
,
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.SLOW_S",
+        "PerPkg": "1",
+        "PublicDescription": "Secondary received a transfer that did not h=
ave sufficient MESI state",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "AK Ingress Occupancy",
+        "EventCode": "0xA",
+        "EventName": "UNC_I_RxR_AK_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the AK=
 Ingress.  This queue is where the IRP receives responses from R2PCIe (the =
ring).",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
+        "EventCode": "0x4",
+        "EventName": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL Ingress Occupancy - DRS",
+        "EventCode": "0x1",
+        "EventName": "UNC_I_RxR_BL_DRS_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "UNC_I_RxR_BL_DRS_OCCUPANCY",
+        "EventCode": "0x7",
+        "EventName": "UNC_I_RxR_BL_DRS_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
+        "EventCode": "0x5",
+        "EventName": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL Ingress Occupancy - NCB",
+        "EventCode": "0x2",
+        "EventName": "UNC_I_RxR_BL_NCB_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "UNC_I_RxR_BL_NCB_OCCUPANCY",
+        "EventCode": "0x8",
+        "EventName": "UNC_I_RxR_BL_NCB_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
+        "EventCode": "0x6",
+        "EventName": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL Ingress Occupancy - NCS",
+        "EventCode": "0x3",
+        "EventName": "UNC_I_RxR_BL_NCS_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "UNC_I_RxR_BL_NCS_OCCUPANCY",
+        "EventCode": "0x9",
+        "EventName": "UNC_I_RxR_BL_NCS_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses; Hit E or S",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_SNOOP_RESP.HIT_ES",
+        "PerPkg": "1",
+        "PublicDescription": "Snoop Responses : Hit E or S",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses; Hit I",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_SNOOP_RESP.HIT_I",
+        "PerPkg": "1",
+        "PublicDescription": "Snoop Responses : Hit I",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses; Hit M",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_SNOOP_RESP.HIT_M",
+        "PerPkg": "1",
+        "PublicDescription": "Snoop Responses : Hit M",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses; Miss",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_SNOOP_RESP.MISS",
+        "PerPkg": "1",
+        "PublicDescription": "Snoop Responses : Miss",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses; SnpCode",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_SNOOP_RESP.SNPCODE",
+        "PerPkg": "1",
+        "PublicDescription": "Snoop Responses : SnpCode",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses; SnpData",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_SNOOP_RESP.SNPDATA",
+        "PerPkg": "1",
+        "PublicDescription": "Snoop Responses : SnpData",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses; SnpInv",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_SNOOP_RESP.SNPINV",
+        "PerPkg": "1",
+        "PublicDescription": "Snoop Responses : SnpInv",
+        "UMask": "0x40",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Atomic",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TRANSACTIONS.ATOMIC",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks the number of atomic =
transactions",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Other",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TRANSACTIONS.OTHER",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks the number of 'other'=
 kinds of transactions.",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Read Prefetches",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TRANSACTIONS.RD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks the number of read pr=
efetches.",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Reads",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TRANSACTIONS.READS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks only read requests (n=
ot including read prefetches).",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Writes",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TRANSACTIONS.WRITES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks only write requests. =
 Each write request should have a prefetch, so there is no need to explicit=
ly track these requests.",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Write Prefetches",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TRANSACTIONS.WR_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks the number of write p=
refetches.",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "No AD Egress Credit Stalls",
+        "EventCode": "0x18",
+        "EventName": "UNC_I_TxR_AD_STALL_CREDIT_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number times when it is not possi=
ble to issue a request to the R2PCIe because there are no AD Egress Credits=
 available.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "No BL Egress Credit Stalls",
+        "EventCode": "0x19",
+        "EventName": "UNC_I_TxR_BL_STALL_CREDIT_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number times when it is not possi=
ble to issue data to the R2PCIe because there are no BL Egress Credits avai=
lable.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outbound Read Requests",
+        "EventCode": "0xE",
+        "EventName": "UNC_I_TxR_DATA_INSERTS_NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of requests issued to the =
switch (towards the devices).",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outbound Read Requests",
+        "EventCode": "0xF",
+        "EventName": "UNC_I_TxR_DATA_INSERTS_NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of requests issued to the =
switch (towards the devices).",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outbound Request Queue Occupancy",
+        "EventCode": "0xD",
+        "EventName": "UNC_I_TxR_REQUEST_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of outstanding outbou=
nd requests from the IRP to the switch (towards the devices).  This can be =
used in conjunction with the allocations event in order to calculate averag=
e latency of outbound requests.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "VLW Received",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.DOORBELL_RCVD",
+        "PerPkg": "1",
+        "PublicDescription": "Virtual Logical Wire (legacy) message were r=
eceived from Uncore.   Specify the thread to filter on using NCUPMONCTRLGLC=
TR.ThreadID.",
+        "UMask": "0x8",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Filter Match",
+        "EventCode": "0x41",
+        "EventName": "UNC_U_FILTER_MATCH.DISABLE",
+        "PerPkg": "1",
+        "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
+        "UMask": "0x2",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Filter Match",
+        "EventCode": "0x41",
+        "EventName": "UNC_U_FILTER_MATCH.ENABLE",
+        "PerPkg": "1",
+        "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
+        "UMask": "0x1",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Filter Match",
+        "EventCode": "0x41",
+        "EventName": "UNC_U_FILTER_MATCH.U2C_DISABLE",
+        "PerPkg": "1",
+        "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
+        "UMask": "0x8",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Filter Match",
+        "EventCode": "0x41",
+        "EventName": "UNC_U_FILTER_MATCH.U2C_ENABLE",
+        "PerPkg": "1",
+        "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
+        "UMask": "0x4",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Cycles PHOLD Assert to Ack; Assert to ACK",
+        "EventCode": "0x45",
+        "EventName": "UNC_U_PHOLD_CYCLES.ASSERT_TO_ACK",
+        "PerPkg": "1",
+        "PublicDescription": "PHOLD cycles.  Filter from source CoreID.",
+        "UMask": "0x1",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "RACU Request",
+        "EventCode": "0x46",
+        "EventName": "UNC_U_RACU_REQUESTS",
+        "PerPkg": "1",
+        "PublicDescription": "Number outstanding register requests within =
message channel tracker",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Correctable Machine Check=
",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.CMC",
+        "PerPkg": "1",
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
+        "UMask": "0x10",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Livelock",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.LIVELOCK",
+        "PerPkg": "1",
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores; Filter by core",
+        "UMask": "0x4",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; LTError",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.LTERROR",
+        "PerPkg": "1",
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores; Filter by core",
+        "UMask": "0x8",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Monitor T0",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.MONITOR_T0",
+        "PerPkg": "1",
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores; Filter by core",
+        "UMask": "0x1",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Monitor T1",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.MONITOR_T1",
+        "PerPkg": "1",
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores; Filter by core",
+        "UMask": "0x2",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Other",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.OTHER",
+        "PerPkg": "1",
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores; PREQ, PSMI, P2U, Thermal, PCUSMI, PMI",
+        "UMask": "0x80",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Trap",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.TRAP",
+        "PerPkg": "1",
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
+        "UMask": "0x40",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Uncorrectable Machine Che=
ck",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.UMC",
+        "PerPkg": "1",
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
+        "UMask": "0x20",
+        "Unit": "UBOX"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-other.json b=
/tools/perf/pmu-events/arch/x86/broadwellde/uncore-io.json
similarity index 53%
rename from tools/perf/pmu-events/arch/x86/broadwellde/uncore-other.json
rename to tools/perf/pmu-events/arch/x86/broadwellde/uncore-io.json
index fea3dea67f38..01e04daf03da 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-io.json
@@ -1,482 +1,4 @@
 [
-    {
-        "BriefDescription": "Total Write Cache Occupancy; Any Source",
-        "EventCode": "0x12",
-        "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.ANY",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the number of reads and writes t=
hat are outstanding in the uncore in each cycle.  This is effectively the s=
um of the READ_OCCUPANCY and WRITE_OCCUPANCY events.; Tracks all requests f=
rom any source port.",
-        "UMask": "0x1",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Total Write Cache Occupancy; Select Source",
-        "EventCode": "0x12",
-        "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.SOURCE",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the number of reads and writes t=
hat are outstanding in the uncore in each cycle.  This is effectively the s=
um of the READ_OCCUPANCY and WRITE_OCCUPANCY events.; Tracks only those req=
uests that come from the port specified in the IRP_PmonFilter.OrderingQ reg=
ister.  This register allows one to select one specific queue.  It is not p=
ossible to monitor multiple queues at a time.",
-        "UMask": "0x2",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Clocks in the IRP",
-        "EventName": "UNC_I_CLOCKTICKS",
-        "PerPkg": "1",
-        "PublicDescription": "Number of clocks in the IRP.",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Coherent Ops; CLFlush",
-        "EventCode": "0x13",
-        "EventName": "UNC_I_COHERENT_OPS.CLFLUSH",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
-        "UMask": "0x80",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Coherent Ops; CRd",
-        "EventCode": "0x13",
-        "EventName": "UNC_I_COHERENT_OPS.CRD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
-        "UMask": "0x2",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Coherent Ops; DRd",
-        "EventCode": "0x13",
-        "EventName": "UNC_I_COHERENT_OPS.DRD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
-        "UMask": "0x4",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Coherent Ops; PCIDCAHin5t",
-        "EventCode": "0x13",
-        "EventName": "UNC_I_COHERENT_OPS.PCIDCAHINT",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
-        "UMask": "0x20",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Coherent Ops; PCIRdCur",
-        "EventCode": "0x13",
-        "EventName": "UNC_I_COHERENT_OPS.PCIRDCUR",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
-        "UMask": "0x1",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Coherent Ops; PCIItoM",
-        "EventCode": "0x13",
-        "EventName": "UNC_I_COHERENT_OPS.PCITOM",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
-        "UMask": "0x10",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Coherent Ops; RFO",
-        "EventCode": "0x13",
-        "EventName": "UNC_I_COHERENT_OPS.RFO",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
-        "UMask": "0x8",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Coherent Ops; WbMtoI",
-        "EventCode": "0x13",
-        "EventName": "UNC_I_COHERENT_OPS.WBMTOI",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
-        "UMask": "0x40",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 0; Cache Inserts of Atomic =
Transactions as Secondary",
-        "EventCode": "0x14",
-        "EventName": "UNC_I_MISC0.2ND_ATOMIC_INSERT",
-        "PerPkg": "1",
-        "PublicDescription": "Counts Timeouts - Set 0 : Cache Inserts of A=
tomic Transactions as Secondary",
-        "UMask": "0x10",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 0; Cache Inserts of Read Tr=
ansactions as Secondary",
-        "EventCode": "0x14",
-        "EventName": "UNC_I_MISC0.2ND_RD_INSERT",
-        "PerPkg": "1",
-        "PublicDescription": "Counts Timeouts - Set 0 : Cache Inserts of R=
ead Transactions as Secondary",
-        "UMask": "0x4",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 0; Cache Inserts of Write T=
ransactions as Secondary",
-        "EventCode": "0x14",
-        "EventName": "UNC_I_MISC0.2ND_WR_INSERT",
-        "PerPkg": "1",
-        "PublicDescription": "Counts Timeouts - Set 0 : Cache Inserts of W=
rite Transactions as Secondary",
-        "UMask": "0x8",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 0; Fastpath Rejects",
-        "EventCode": "0x14",
-        "EventName": "UNC_I_MISC0.FAST_REJ",
-        "PerPkg": "1",
-        "PublicDescription": "Counts Timeouts - Set 0 : Fastpath Rejects",
-        "UMask": "0x2",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 0; Fastpath Requests",
-        "EventCode": "0x14",
-        "EventName": "UNC_I_MISC0.FAST_REQ",
-        "PerPkg": "1",
-        "PublicDescription": "Counts Timeouts - Set 0 : Fastpath Requests"=
,
-        "UMask": "0x1",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 0; Fastpath Transfers From =
Primary to Secondary",
-        "EventCode": "0x14",
-        "EventName": "UNC_I_MISC0.FAST_XFER",
-        "PerPkg": "1",
-        "PublicDescription": "Counts Timeouts - Set 0 : Fastpath Transfers=
 From Primary to Secondary",
-        "UMask": "0x20",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 0; Prefetch Ack Hints From =
Primary to Secondary",
-        "EventCode": "0x14",
-        "EventName": "UNC_I_MISC0.PF_ACK_HINT",
-        "PerPkg": "1",
-        "PublicDescription": "Counts Timeouts - Set 0 : Prefetch Ack Hints=
 From Primary to Secondary",
-        "UMask": "0x40",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 0; Prefetch TimeOut",
-        "EventCode": "0x14",
-        "EventName": "UNC_I_MISC0.PF_TIMEOUT",
-        "PerPkg": "1",
-        "PublicDescription": "Indicates the fetch for a previous prefetch =
wasn't accepted by the prefetch.   This happens in the case of a prefetch T=
imeOut",
-        "UMask": "0x80",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 1; Data Throttled",
-        "EventCode": "0x15",
-        "EventName": "UNC_I_MISC1.DATA_THROTTLE",
-        "PerPkg": "1",
-        "PublicDescription": "IRP throttled switch data",
-        "UMask": "0x80",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 1",
-        "EventCode": "0x15",
-        "EventName": "UNC_I_MISC1.LOST_FWD",
-        "PerPkg": "1",
-        "PublicDescription": "Misc Events - Set 1 : Lost Forward : Snoop p=
ulled away ownership before a write was committed",
-        "UMask": "0x10",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 1; Received Invalid",
-        "EventCode": "0x15",
-        "EventName": "UNC_I_MISC1.SEC_RCVD_INVLD",
-        "PerPkg": "1",
-        "PublicDescription": "Secondary received a transfer that did not h=
ave sufficient MESI state",
-        "UMask": "0x20",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 1; Received Valid",
-        "EventCode": "0x15",
-        "EventName": "UNC_I_MISC1.SEC_RCVD_VLD",
-        "PerPkg": "1",
-        "PublicDescription": "Secondary received a transfer that did have =
sufficient MESI state",
-        "UMask": "0x40",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 1; Slow Transfer of E Line"=
,
-        "EventCode": "0x15",
-        "EventName": "UNC_I_MISC1.SLOW_E",
-        "PerPkg": "1",
-        "PublicDescription": "Secondary received a transfer that did have =
sufficient MESI state",
-        "UMask": "0x4",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 1; Slow Transfer of I Line"=
,
-        "EventCode": "0x15",
-        "EventName": "UNC_I_MISC1.SLOW_I",
-        "PerPkg": "1",
-        "PublicDescription": "Snoop took cacheline ownership before write =
from data was committed.",
-        "UMask": "0x1",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 1; Slow Transfer of M Line"=
,
-        "EventCode": "0x15",
-        "EventName": "UNC_I_MISC1.SLOW_M",
-        "PerPkg": "1",
-        "PublicDescription": "Snoop took cacheline ownership before write =
from data was committed.",
-        "UMask": "0x8",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Misc Events - Set 1; Slow Transfer of S Line"=
,
-        "EventCode": "0x15",
-        "EventName": "UNC_I_MISC1.SLOW_S",
-        "PerPkg": "1",
-        "PublicDescription": "Secondary received a transfer that did not h=
ave sufficient MESI state",
-        "UMask": "0x2",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "AK Ingress Occupancy",
-        "EventCode": "0xA",
-        "EventName": "UNC_I_RxR_AK_INSERTS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the AK=
 Ingress.  This queue is where the IRP receives responses from R2PCIe (the =
ring).",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
-        "EventCode": "0x4",
-        "EventName": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "BL Ingress Occupancy - DRS",
-        "EventCode": "0x1",
-        "EventName": "UNC_I_RxR_BL_DRS_INSERTS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "UNC_I_RxR_BL_DRS_OCCUPANCY",
-        "EventCode": "0x7",
-        "EventName": "UNC_I_RxR_BL_DRS_OCCUPANCY",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
-        "EventCode": "0x5",
-        "EventName": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "BL Ingress Occupancy - NCB",
-        "EventCode": "0x2",
-        "EventName": "UNC_I_RxR_BL_NCB_INSERTS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "UNC_I_RxR_BL_NCB_OCCUPANCY",
-        "EventCode": "0x8",
-        "EventName": "UNC_I_RxR_BL_NCB_OCCUPANCY",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
-        "EventCode": "0x6",
-        "EventName": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "BL Ingress Occupancy - NCS",
-        "EventCode": "0x3",
-        "EventName": "UNC_I_RxR_BL_NCS_INSERTS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "UNC_I_RxR_BL_NCS_OCCUPANCY",
-        "EventCode": "0x9",
-        "EventName": "UNC_I_RxR_BL_NCS_OCCUPANCY",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Snoop Responses; Hit E or S",
-        "EventCode": "0x17",
-        "EventName": "UNC_I_SNOOP_RESP.HIT_ES",
-        "PerPkg": "1",
-        "PublicDescription": "Snoop Responses : Hit E or S",
-        "UMask": "0x4",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Snoop Responses; Hit I",
-        "EventCode": "0x17",
-        "EventName": "UNC_I_SNOOP_RESP.HIT_I",
-        "PerPkg": "1",
-        "PublicDescription": "Snoop Responses : Hit I",
-        "UMask": "0x2",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Snoop Responses; Hit M",
-        "EventCode": "0x17",
-        "EventName": "UNC_I_SNOOP_RESP.HIT_M",
-        "PerPkg": "1",
-        "PublicDescription": "Snoop Responses : Hit M",
-        "UMask": "0x8",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Snoop Responses; Miss",
-        "EventCode": "0x17",
-        "EventName": "UNC_I_SNOOP_RESP.MISS",
-        "PerPkg": "1",
-        "PublicDescription": "Snoop Responses : Miss",
-        "UMask": "0x1",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Snoop Responses; SnpCode",
-        "EventCode": "0x17",
-        "EventName": "UNC_I_SNOOP_RESP.SNPCODE",
-        "PerPkg": "1",
-        "PublicDescription": "Snoop Responses : SnpCode",
-        "UMask": "0x10",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Snoop Responses; SnpData",
-        "EventCode": "0x17",
-        "EventName": "UNC_I_SNOOP_RESP.SNPDATA",
-        "PerPkg": "1",
-        "PublicDescription": "Snoop Responses : SnpData",
-        "UMask": "0x20",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Snoop Responses; SnpInv",
-        "EventCode": "0x17",
-        "EventName": "UNC_I_SNOOP_RESP.SNPINV",
-        "PerPkg": "1",
-        "PublicDescription": "Snoop Responses : SnpInv",
-        "UMask": "0x40",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Inbound Transaction Count; Atomic",
-        "EventCode": "0x16",
-        "EventName": "UNC_I_TRANSACTIONS.ATOMIC",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks the number of atomic =
transactions",
-        "UMask": "0x10",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Inbound Transaction Count; Other",
-        "EventCode": "0x16",
-        "EventName": "UNC_I_TRANSACTIONS.OTHER",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks the number of 'other'=
 kinds of transactions.",
-        "UMask": "0x20",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Inbound Transaction Count; Read Prefetches",
-        "EventCode": "0x16",
-        "EventName": "UNC_I_TRANSACTIONS.RD_PREF",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks the number of read pr=
efetches.",
-        "UMask": "0x4",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Inbound Transaction Count; Reads",
-        "EventCode": "0x16",
-        "EventName": "UNC_I_TRANSACTIONS.READS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks only read requests (n=
ot including read prefetches).",
-        "UMask": "0x1",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Inbound Transaction Count; Writes",
-        "EventCode": "0x16",
-        "EventName": "UNC_I_TRANSACTIONS.WRITES",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks only write requests. =
 Each write request should have a prefetch, so there is no need to explicit=
ly track these requests.",
-        "UMask": "0x2",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Inbound Transaction Count; Write Prefetches",
-        "EventCode": "0x16",
-        "EventName": "UNC_I_TRANSACTIONS.WR_PREF",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks the number of write p=
refetches.",
-        "UMask": "0x8",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "No AD Egress Credit Stalls",
-        "EventCode": "0x18",
-        "EventName": "UNC_I_TxR_AD_STALL_CREDIT_CYCLES",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number times when it is not possi=
ble to issue a request to the R2PCIe because there are no AD Egress Credits=
 available.",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "No BL Egress Credit Stalls",
-        "EventCode": "0x19",
-        "EventName": "UNC_I_TxR_BL_STALL_CREDIT_CYCLES",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number times when it is not possi=
ble to issue data to the R2PCIe because there are no BL Egress Credits avai=
lable.",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Outbound Read Requests",
-        "EventCode": "0xE",
-        "EventName": "UNC_I_TxR_DATA_INSERTS_NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of requests issued to the =
switch (towards the devices).",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Outbound Read Requests",
-        "EventCode": "0xF",
-        "EventName": "UNC_I_TxR_DATA_INSERTS_NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of requests issued to the =
switch (towards the devices).",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Outbound Request Queue Occupancy",
-        "EventCode": "0xD",
-        "EventName": "UNC_I_TxR_REQUEST_OCCUPANCY",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the number of outstanding outbou=
nd requests from the IRP to the switch (towards the devices).  This can be =
used in conjunction with the allocations event in order to calculate averag=
e latency of outbound requests.",
-        "Unit": "IRP"
-    },
     {
         "BriefDescription": "Number of uclks in domain",
         "EventCode": "0x1",
@@ -1029,139 +551,5 @@
         "PublicDescription": "AD CounterClockwise Egress Queue",
         "UMask": "0x10",
         "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "VLW Received",
-        "EventCode": "0x42",
-        "EventName": "UNC_U_EVENT_MSG.DOORBELL_RCVD",
-        "PerPkg": "1",
-        "PublicDescription": "Virtual Logical Wire (legacy) message were r=
eceived from Uncore.   Specify the thread to filter on using NCUPMONCTRLGLC=
TR.ThreadID.",
-        "UMask": "0x8",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Filter Match",
-        "EventCode": "0x41",
-        "EventName": "UNC_U_FILTER_MATCH.DISABLE",
-        "PerPkg": "1",
-        "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
-        "UMask": "0x2",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Filter Match",
-        "EventCode": "0x41",
-        "EventName": "UNC_U_FILTER_MATCH.ENABLE",
-        "PerPkg": "1",
-        "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
-        "UMask": "0x1",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Filter Match",
-        "EventCode": "0x41",
-        "EventName": "UNC_U_FILTER_MATCH.U2C_DISABLE",
-        "PerPkg": "1",
-        "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
-        "UMask": "0x8",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Filter Match",
-        "EventCode": "0x41",
-        "EventName": "UNC_U_FILTER_MATCH.U2C_ENABLE",
-        "PerPkg": "1",
-        "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
-        "UMask": "0x4",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Cycles PHOLD Assert to Ack; Assert to ACK",
-        "EventCode": "0x45",
-        "EventName": "UNC_U_PHOLD_CYCLES.ASSERT_TO_ACK",
-        "PerPkg": "1",
-        "PublicDescription": "PHOLD cycles.  Filter from source CoreID.",
-        "UMask": "0x1",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "RACU Request",
-        "EventCode": "0x46",
-        "EventName": "UNC_U_RACU_REQUESTS",
-        "PerPkg": "1",
-        "PublicDescription": "Number outstanding register requests within =
message channel tracker",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Monitor Sent to T0; Correctable Machine Check=
",
-        "EventCode": "0x43",
-        "EventName": "UNC_U_U2C_EVENTS.CMC",
-        "PerPkg": "1",
-        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
-        "UMask": "0x10",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Monitor Sent to T0; Livelock",
-        "EventCode": "0x43",
-        "EventName": "UNC_U_U2C_EVENTS.LIVELOCK",
-        "PerPkg": "1",
-        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores; Filter by core",
-        "UMask": "0x4",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Monitor Sent to T0; LTError",
-        "EventCode": "0x43",
-        "EventName": "UNC_U_U2C_EVENTS.LTERROR",
-        "PerPkg": "1",
-        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores; Filter by core",
-        "UMask": "0x8",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Monitor Sent to T0; Monitor T0",
-        "EventCode": "0x43",
-        "EventName": "UNC_U_U2C_EVENTS.MONITOR_T0",
-        "PerPkg": "1",
-        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores; Filter by core",
-        "UMask": "0x1",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Monitor Sent to T0; Monitor T1",
-        "EventCode": "0x43",
-        "EventName": "UNC_U_U2C_EVENTS.MONITOR_T1",
-        "PerPkg": "1",
-        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores; Filter by core",
-        "UMask": "0x2",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Monitor Sent to T0; Other",
-        "EventCode": "0x43",
-        "EventName": "UNC_U_U2C_EVENTS.OTHER",
-        "PerPkg": "1",
-        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores; PREQ, PSMI, P2U, Thermal, PCUSMI, PMI",
-        "UMask": "0x80",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Monitor Sent to T0; Trap",
-        "EventCode": "0x43",
-        "EventName": "UNC_U_U2C_EVENTS.TRAP",
-        "PerPkg": "1",
-        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
-        "UMask": "0x40",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Monitor Sent to T0; Uncorrectable Machine Che=
ck",
-        "EventCode": "0x43",
-        "EventName": "UNC_U_U2C_EVENTS.UMC",
-        "PerPkg": "1",
-        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
-        "UMask": "0x20",
-        "Unit": "UBOX"
     }
 ]
--=20
2.40.0.577.gac1e443424-goog

