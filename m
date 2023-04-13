Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747336E0EBA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjDMNdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjDMNci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:32:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD9DBBBB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:31:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t66-20020a254645000000b00b74680a7904so15799185yba.15
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681392717; x=1683984717;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCeF7xTS0ss5IAx6z1SSQLE1XYpIEexKHQ4MMfjLo4E=;
        b=j+idfgJLnzngC4WGHgPTCQHtH3c4Rt0BGb4cblnp6GS3xvei5BO4lkwLmCZiBBnHBC
         ZJHm6hymplRzpaGh4/PtlqCmL3XUd4nJ+lVIcKoUOwI2dyqWw3DWT8pIglFwhw4VYcXN
         golr60KOklL3/3gprPQAzYutgRqCfN5FFz00P4WdKdSXtAVpGCo3PIlBAcJJ6PsQwUj8
         RGzqjykuXHb65A/TdyK+brKQO+WfmwtoSvTZt95OuyBfAYPmr2DQSVn7E/NzRhV5Mhlx
         QZusXFFMdCJ1lDAmek2R80mtmDiZzYBA790J8KGvVuMlZiJqNMcqF3iEB5LeRV+gDtJW
         oddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681392717; x=1683984717;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mCeF7xTS0ss5IAx6z1SSQLE1XYpIEexKHQ4MMfjLo4E=;
        b=RiCjDqUQWWzm/dvkGMZTYwUvJOqXKeHq+rDrZhFDcm0Q8jA+oBxQkCEUns/VNWs5zP
         lxkjuqzJCp1U0EnThHmRx/6RKsSzg6kHDT39rDnznaYZtnDaVhGCi6ZS/A7dVUZkRMSS
         eXrioRfrV/EzRcm3QMfECm0ilI8u1HC7JzynQP5x4LwWr3pnlUKKIw4Q3O0GCETzOq/p
         bJ46PdT/y9KZ3rAPI2DMRbAx7hgs/RULulQnaXERkK/jq36G4qTtAyC8nrKvHL5/XJM8
         KzmYB9RXADQgNi/5H5leeV5En5ZDbKK80gs6V9+70jHlDGHQltdvvhuFDrjIpkjhvz/V
         TX0g==
X-Gm-Message-State: AAQBX9dhuIzkyV4Pep6yTJeEX8++6Jndhxm0bU7pnT2llhmK98bKETxo
        /GEZPPOcLrbTDwN7Zy5fWFJLeBNbIggn
X-Google-Smtp-Source: AKy350bFrW9oi1Eq9vO3cGmMpZGp43zHUwzO7Ermoo4Gv9kpHRJ9uaxz1v8HVT05XdDjxeUBppRPNYOvWMRp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c8fe:b894:ec92:d5cd])
 (user=irogers job=sendgmr) by 2002:a25:d092:0:b0:b8f:67cd:fc12 with SMTP id
 h140-20020a25d092000000b00b8f67cdfc12mr107527ybg.13.1681392717574; Thu, 13
 Apr 2023 06:31:57 -0700 (PDT)
Date:   Thu, 13 Apr 2023 06:29:42 -0700
In-Reply-To: <20230413132949.3487664-1-irogers@google.com>
Message-Id: <20230413132949.3487664-15-irogers@google.com>
Mime-Version: 1.0
References: <20230413132949.3487664-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v3 14/21] perf vendor events intel: Fix uncore topics for ivytown
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove 'uncore-other' topic classification, move to cache,
interconnect and io.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/ivytown/uncore-cache.json        |  314 +--
 .../arch/x86/ivytown/uncore-interconnect.json | 2025 +++++++++++++--
 .../arch/x86/ivytown/uncore-io.json           |  549 +++++
 .../arch/x86/ivytown/uncore-other.json        | 2174 -----------------
 4 files changed, 2531 insertions(+), 2531 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/ivytown/uncore-io.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/ivytown/uncore-other.jso=
n

diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json b/too=
ls/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
index 521175881173..8bf2706eb6d5 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
@@ -3,7 +3,7 @@
         "BriefDescription": "Uncore Clocks",
         "EventName": "UNC_C_CLOCKTICKS",
         "PerPkg": "1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Counter 0 Occupancy",
@@ -11,7 +11,7 @@
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
         "BriefDescription": "Cache Lookups; Any Request",
@@ -20,7 +20,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:17] bits correspond to [M'FMESI] state.; Filters for any transaction o=
riginating from the IPQ or IRQ.  This does not include lookups originating =
from the ISMQ.",
         "UMask": "0x11",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cache Lookups; Data Read Request",
@@ -29,7 +29,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:17] bits correspond to [M'FMESI] state.; Read transactions",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cache Lookups; Lookups that Match NID",
@@ -38,7 +38,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:17] bits correspond to [M'FMESI] state.; Qualify one of the other sube=
vents by the Target NID.  The NID is programmed in Cn_MSR_PMON_BOX_FILTER.n=
id.   In conjunction with STATE =3D I, it is possible to monitor misses to =
specific NIDs in the system.",
         "UMask": "0x41",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cache Lookups; External Snoop Request",
@@ -47,7 +47,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:17] bits correspond to [M'FMESI] state.; Filters for only snoop reques=
ts coming from the remote socket(s) through the IPQ.",
         "UMask": "0x9",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cache Lookups; Write Requests",
@@ -56,7 +56,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:17] bits correspond to [M'FMESI] state.; Writeback transactions from L=
2 to the LLC  This includes all write transactions -- both Cacheable and UC=
.",
         "UMask": "0x5",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Lines Victimized; Lines in E state",
@@ -65,7 +65,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Lines Victimized",
@@ -74,7 +74,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Lines Victimized; Lines in M state",
@@ -83,7 +83,7 @@
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
@@ -92,7 +92,7 @@
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
         "BriefDescription": "Lines Victimized; Lines in S State",
@@ -101,7 +101,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cbo Misc; RFO HitS",
@@ -110,7 +110,7 @@
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
@@ -119,7 +119,7 @@
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
@@ -128,7 +128,7 @@
         "PerPkg": "1",
         "PublicDescription": "Miscellaneous events in the Cbo.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cbo Misc; Write Combining Aliasing",
@@ -137,7 +137,7 @@
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
@@ -146,7 +146,7 @@
         "PerPkg": "1",
         "PublicDescription": "How often age was set to 0",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "LRU Queue; LRU Age 1",
@@ -155,7 +155,7 @@
         "PerPkg": "1",
         "PublicDescription": "How often age was set to 1",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "LRU Queue; LRU Age 2",
@@ -164,7 +164,7 @@
         "PerPkg": "1",
         "PublicDescription": "How often age was set to 2",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "LRU Queue; LRU Age 3",
@@ -173,7 +173,7 @@
         "PerPkg": "1",
         "PublicDescription": "How often age was set to 3",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "LRU Queue; LRU Bits Decremented",
@@ -182,7 +182,7 @@
         "PerPkg": "1",
         "PublicDescription": "How often all LRU bits were decremented by 1=
",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "LRU Queue; Non-0 Aged Victim",
@@ -191,7 +191,7 @@
         "PerPkg": "1",
         "PublicDescription": "How often we picked a victim that had a non-=
zero age",
         "UMask": "0x20",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD Ring In Use; Counterclockwise",
@@ -200,7 +200,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
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
         "BriefDescription": "AD Ring In Use; Clockwise",
@@ -209,7 +209,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
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
         "BriefDescription": "AD Ring In Use; Down",
@@ -218,7 +218,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.",
         "UMask": "0xcc",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD Ring In Use; Down and Even on Vring 0",
@@ -227,7 +227,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Down and Even ring polarity on Virtual Ring 0.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD Ring In Use; Down and Odd on Vring 0",
@@ -236,7 +236,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Down and Odd ring polarity on Virtual Ring 0.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD Ring In Use; Down and Even on VRing 1",
@@ -245,7 +245,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Down and Even ring polarity on Virtual Ring 1.",
         "UMask": "0x40",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD Ring In Use; Down and Odd on VRing 1",
@@ -254,7 +254,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Down and Odd ring polarity on Virtual Ring 1.",
         "UMask": "0x80",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD Ring In Use; Up",
@@ -263,7 +263,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.",
         "UMask": "0x33",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD Ring In Use; Up and Even on Vring 0",
@@ -272,7 +272,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Up and Even ring polarity on Virtual Ring 0.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD Ring In Use; Up and Odd on Vring 0",
@@ -281,7 +281,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Up and Odd ring polarity on Virtual Ring 0.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD Ring In Use; Up and Even on VRing 1",
@@ -290,7 +290,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Up and Even ring polarity on Virtual Ring 1.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD Ring In Use; Up and Odd on VRing 1",
@@ -299,7 +299,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Up and Odd ring polarity on Virtual Ring 1.",
         "UMask": "0x20",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK Ring In Use; Counterclockwise",
@@ -308,7 +308,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
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
         "BriefDescription": "AK Ring In Use; Clockwise",
@@ -317,7 +317,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
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
         "BriefDescription": "AK Ring In Use; Down",
@@ -326,7 +326,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
         "UMask": "0xcc",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK Ring In Use; Down and Even on Vring 0",
@@ -335,7 +335,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Down and Even ring polarity on Virtual Ring 0.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK Ring In Use; Down and Odd on Vring 0",
@@ -344,7 +344,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Down and Odd ring polarity on Virtual Ring 0.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK Ring In Use; Down and Even on VRing 1",
@@ -353,7 +353,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Down and Even ring polarity on Virtual Ring 1.",
         "UMask": "0x40",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK Ring In Use; Down and Odd on VRing 1",
@@ -362,7 +362,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Down and Odd ring polarity on Virtual Ring 1.",
         "UMask": "0x80",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK Ring In Use; Up",
@@ -371,7 +371,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
         "UMask": "0x33",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK Ring In Use; Up and Even on Vring 0",
@@ -380,7 +380,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Up and Even ring polarity on Virtual Ring 0.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK Ring In Use; Up and Odd on Vring 0",
@@ -389,7 +389,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Up and Odd ring polarity on Virtual Ring 0.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK Ring In Use; Up and Even on VRing 1",
@@ -398,7 +398,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Up and Even ring polarity on Virtual Ring 1.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK Ring In Use; Up and Odd on VRing 1",
@@ -407,7 +407,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Up and Odd ring polarity on Virtual Ring 1.",
         "UMask": "0x20",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Counterclockwise",
@@ -416,7 +416,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
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
         "BriefDescription": "BL Ring in Use; Clockwise",
@@ -425,7 +425,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
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
         "BriefDescription": "BL Ring in Use; Down",
@@ -434,7 +434,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
         "UMask": "0xcc",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Down and Even on Vring 0",
@@ -443,7 +443,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Down and Even ring polarity on Virtual Ring 0.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Down and Odd on Vring 0",
@@ -452,7 +452,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Down and Odd ring polarity on Virtual Ring 0.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Down and Even on VRing 1",
@@ -461,7 +461,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Down and Even ring polarity on Virtual Ring 1.",
         "UMask": "0x40",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Down and Odd on VRing 1",
@@ -470,7 +470,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Down and Odd ring polarity on Virtual Ring 1.",
         "UMask": "0x80",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Up",
@@ -479,7 +479,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
         "UMask": "0x33",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Up and Even on Vring 0",
@@ -488,7 +488,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Up and Even ring polarity on Virtual Ring 0.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Up and Odd on Vring 0",
@@ -497,7 +497,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Up and Odd ring polarity on Virtual Ring 0.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Up and Even on VRing 1",
@@ -506,7 +506,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Up and Even ring polarity on Virtual Ring 1.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Up and Odd on VRing 1",
@@ -515,7 +515,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Up and Odd ring polarity on Virtual Ring 1.",
         "UMask": "0x20",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.",
@@ -523,7 +523,7 @@
         "EventName": "UNC_C_RING_BOUNCES.AD_IRQ",
         "PerPkg": "1",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Acknowledgements to core",
@@ -531,7 +531,7 @@
         "EventName": "UNC_C_RING_BOUNCES.AK",
         "PerPkg": "1",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.: Acknowledgements to core",
@@ -539,7 +539,7 @@
         "EventName": "UNC_C_RING_BOUNCES.AK_CORE",
         "PerPkg": "1",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Data Responses to core",
@@ -547,7 +547,7 @@
         "EventName": "UNC_C_RING_BOUNCES.BL",
         "PerPkg": "1",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.: Data Responses to core",
@@ -555,7 +555,7 @@
         "EventName": "UNC_C_RING_BOUNCES.BL_CORE",
         "PerPkg": "1",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Snoops of processor's cache.",
@@ -563,7 +563,7 @@
         "EventName": "UNC_C_RING_BOUNCES.IV",
         "PerPkg": "1",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.: Snoops of processor's cache.",
@@ -571,7 +571,7 @@
         "EventName": "UNC_C_RING_BOUNCES.IV_CORE",
         "PerPkg": "1",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "IV Ring in Use; Any",
@@ -580,7 +580,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters any polarity",
         "UMask": "0xf",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "IV Ring in Use; Down",
@@ -589,7 +589,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for Down polarity",
         "UMask": "0xcc",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "IV Ring in Use; Up",
@@ -598,34 +598,34 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for Up polarity",
         "UMask": "0x33",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "EventCode": "0x6",
         "EventName": "UNC_C_RING_SINK_STARVED.AD_IPQ",
         "PerPkg": "1",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "EventCode": "0x6",
         "EventName": "UNC_C_RING_SINK_STARVED.AD_IRQ",
         "PerPkg": "1",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "EventCode": "0x6",
         "EventName": "UNC_C_RING_SINK_STARVED.IV",
         "PerPkg": "1",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "EventCode": "0x7",
         "EventName": "UNC_C_RING_SRC_THRTL",
         "PerPkg": "1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Arbiter Blocking Cycles; IRQ",
@@ -634,7 +634,7 @@
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
@@ -643,7 +643,7 @@
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
@@ -652,7 +652,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts cycles in external starvation.  This =
occurs when one of the ingress queues is being starved by the other queues.=
; Number of times that the ISMQ Bid.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Arbiter Blocking Cycles",
@@ -661,7 +661,7 @@
         "PerPkg": "1",
         "PublicDescription": "IRQ is blocking the ingress queue and causin=
g the starvation.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Allocations; IPQ",
@@ -670,7 +670,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Allocations; IRQ",
@@ -679,7 +679,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Allocations; IRQ Rejected",
@@ -688,7 +688,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Allocations: IRQ Rejected",
@@ -697,7 +697,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Allocations; VFIFO",
@@ -706,7 +706,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.; Counts the number of allocations into the IRQ=
 Ordering FIFO.  In JKT, it is necessary to keep IO requests in order.  The=
refore, they are allocated into an ordering FIFO that sits next to the IRQ,=
 and must be satisfied from the FIFO in order (with respect to each other).=
  This event, in conjunction with the Occupancy Accumulator event, can be u=
sed to calculate average lifetime in the FIFO.  Transactions are allocated =
into the FIFO as soon as they enter the Cachebo (and the IRQ) and are deall=
ocated from the FIFO as soon as they are deallocated from the IRQ.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Internal Starvation Cycles; IPQ",
@@ -715,7 +715,7 @@
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
@@ -724,7 +724,7 @@
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
@@ -733,7 +733,7 @@
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
         "BriefDescription": "Probe Queue Retries; Address Conflict",
@@ -742,7 +742,7 @@
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
@@ -751,7 +751,7 @@
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
@@ -760,7 +760,7 @@
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
@@ -769,7 +769,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; Address Confli=
ct",
@@ -778,7 +778,7 @@
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
@@ -787,7 +787,7 @@
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
@@ -796,7 +796,7 @@
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
@@ -805,7 +805,7 @@
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
         "BriefDescription": "Ingress Request Queue Rejects; No QPI Credits=
",
@@ -814,7 +814,7 @@
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
@@ -823,7 +823,7 @@
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
         "BriefDescription": "ISMQ Retries; Any Reject",
@@ -832,7 +832,7 @@
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
@@ -841,7 +841,7 @@
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
@@ -850,7 +850,7 @@
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
         "BriefDescription": "ISMQ Retries; No QPI Credits",
@@ -859,7 +859,7 @@
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
@@ -868,7 +868,7 @@
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
         "BriefDescription": "ISMQ Retries; No WB Credits",
@@ -877,7 +877,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.; Retries of =
writes to local memory due to lack of HT WB credits",
         "UMask": "0x80",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Occupancy; IPQ",
@@ -886,7 +886,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Occupancy; IRQ",
@@ -895,7 +895,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Occupancy; IRQ Rejected",
@@ -904,7 +904,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "IRQ Rejected",
@@ -913,7 +913,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Occupancy; VFIFO",
@@ -922,7 +922,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.; Accumulates the number of used entries in the I=
RQ Ordering FIFO in each cycle.  In JKT, it is necessary to keep IO request=
s in order.  Therefore, they are allocated into an ordering FIFO that sits =
next to the IRQ, and must be satisfied from the FIFO in order (with respect=
 to each other).  This event, in conjunction with the Allocations event, ca=
n be used to calculate average lifetime in the FIFO.  This event can be use=
d in conjunction with the Not Empty event to calculate average queue occupa=
ncy. Transactions are allocated into the FIFO as soon as they enter the Cac=
hebo (and the IRQ) and are deallocated from the FIFO as soon as they are de=
allocated from the IRQ.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; All",
@@ -931,7 +931,7 @@
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
@@ -940,7 +940,7 @@
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
@@ -949,7 +949,7 @@
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
@@ -958,7 +958,7 @@
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
@@ -967,7 +967,7 @@
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
@@ -976,7 +976,7 @@
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
@@ -985,7 +985,7 @@
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
@@ -994,7 +994,7 @@
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
@@ -1003,7 +1003,7 @@
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
@@ -1012,7 +1012,7 @@
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
@@ -1021,7 +1021,7 @@
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
@@ -1030,7 +1030,7 @@
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
@@ -1039,7 +1039,7 @@
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
@@ -1048,7 +1048,7 @@
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
@@ -1057,7 +1057,7 @@
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
@@ -1066,7 +1066,7 @@
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
@@ -1075,7 +1075,7 @@
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
@@ -1084,7 +1084,7 @@
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
@@ -1093,7 +1093,7 @@
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
@@ -1102,7 +1102,7 @@
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
@@ -1111,7 +1111,7 @@
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
@@ -1120,7 +1120,7 @@
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
@@ -1129,7 +1129,7 @@
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
@@ -1138,7 +1138,7 @@
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
@@ -1147,7 +1147,7 @@
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
@@ -1156,7 +1156,7 @@
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
@@ -1165,7 +1165,7 @@
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
@@ -1174,7 +1174,7 @@
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
@@ -1183,7 +1183,7 @@
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
@@ -1192,7 +1192,7 @@
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
@@ -1201,7 +1201,7 @@
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
@@ -1210,7 +1210,7 @@
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
@@ -1219,7 +1219,7 @@
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
@@ -1228,7 +1228,7 @@
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
@@ -1237,7 +1237,7 @@
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
@@ -1246,7 +1246,7 @@
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
@@ -1255,7 +1255,7 @@
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
@@ -1264,7 +1264,7 @@
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
@@ -1273,7 +1273,7 @@
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
@@ -1281,7 +1281,7 @@
         "EventName": "UNC_C_TxR_ADS_USED.AD",
         "PerPkg": "1",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Onto AK Ring",
@@ -1289,7 +1289,7 @@
         "EventName": "UNC_C_TxR_ADS_USED.AK",
         "PerPkg": "1",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Onto BL Ring",
@@ -1297,7 +1297,7 @@
         "EventName": "UNC_C_TxR_ADS_USED.BL",
         "PerPkg": "1",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Egress Allocations; AD - Cachebo",
@@ -1306,7 +1306,7 @@
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
@@ -1315,7 +1315,7 @@
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
@@ -1324,7 +1324,7 @@
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
@@ -1333,7 +1333,7 @@
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
@@ -1342,7 +1342,7 @@
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
@@ -1351,7 +1351,7 @@
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
@@ -1360,7 +1360,7 @@
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
@@ -1369,7 +1369,7 @@
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
@@ -1378,7 +1378,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Egress cannot send a transaction onto the ring for =
a long period of time.; cycles that both AK egresses spent in starvation",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Injection Starvation; Onto IV Ring",
@@ -1387,7 +1387,7 @@
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
         "BriefDescription": "BT Bypass",
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.jso=
n b/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
index e1b9799e3036..ccf451534d16 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
@@ -1,11 +1,316 @@
 [
+    {
+        "BriefDescription": "Address Match (Conflict) Count; Conflict Merg=
es",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_ADDRESS_MATCH.MERGE_COUNT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when an inbound w=
rite (from a device to memory or another device) had an address match with =
another request in the write cache.; When two requests to the same address =
from the same source are received back to back, it is possible to merge the=
 two of them together.",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Address Match (Conflict) Count; Conflict Stal=
ls",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_ADDRESS_MATCH.STALL_COUNT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when an inbound w=
rite (from a device to memory or another device) had an address match with =
another request in the write cache.; When it is not possible to merge two c=
onflicting requests, a stall event occurs.  This is bad for performance.",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Write Ack Pending Occupancy; Any Source",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_CACHE_ACK_PENDING_OCCUPANCY.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of writes that have a=
cquired ownership but have not yet returned their data to the uncore.  Thes=
e writes are generally queued up in the switch trying to get to the head of=
 their queues so that they can post their data.  The queue occuapancy incre=
ments when the ACK is received, and decrements when either the data is retu=
rned OR a tickle is received and ownership is released.  Note that a single=
 tickle can result in multiple decrements.; Tracks only those requests that=
 come from the port specified in the IRP_PmonFilter.OrderingQ register.  Th=
is register allows one to select one specific queue.  It is not possible to=
 monitor multiple queues at a time.",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Write Ack Pending Occupancy; Select Source",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_CACHE_ACK_PENDING_OCCUPANCY.SOURCE",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of writes that have a=
cquired ownership but have not yet returned their data to the uncore.  Thes=
e writes are generally queued up in the switch trying to get to the head of=
 their queues so that they can post their data.  The queue occuapancy incre=
ments when the ACK is received, and decrements when either the data is retu=
rned OR a tickle is received and ownership is released.  Note that a single=
 tickle can result in multiple decrements.; Tracks all requests from any so=
urce port.",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outstanding Write Ownership Occupancy; Any So=
urce",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_CACHE_OWN_OCCUPANCY.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of writes (and write =
prefetches) that are outstanding in the uncore trying to acquire ownership =
in each cycle.  This can be used with the write transaction count to calcul=
ate the average write latency in the uncore.  The occupancy increments when=
 a write request is issued, and decrements when the data is returned.; Trac=
ks all requests from any source port.",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outstanding Write Ownership Occupancy; Select=
 Source",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_CACHE_OWN_OCCUPANCY.SOURCE",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of writes (and write =
prefetches) that are outstanding in the uncore trying to acquire ownership =
in each cycle.  This can be used with the write transaction count to calcul=
ate the average write latency in the uncore.  The occupancy increments when=
 a write request is issued, and decrements when the data is returned.; Trac=
ks only those requests that come from the port specified in the IRP_PmonFil=
ter.OrderingQ register.  This register allows one to select one specific qu=
eue.  It is not possible to monitor multiple queues at a time.",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outstanding Read Occupancy; Any Source",
+        "EventCode": "0x10",
+        "EventName": "UNC_I_CACHE_READ_OCCUPANCY.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of reads that are out=
standing in the uncore in each cycle.  This can be used with the read trans=
action count to calculate the average read latency in the uncore.  The occu=
pancy increments when a read request is issued, and decrements when the dat=
a is returned.; Tracks all requests from any source port.",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outstanding Read Occupancy; Select Source",
+        "EventCode": "0x10",
+        "EventName": "UNC_I_CACHE_READ_OCCUPANCY.SOURCE",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of reads that are out=
standing in the uncore in each cycle.  This can be used with the read trans=
action count to calculate the average read latency in the uncore.  The occu=
pancy increments when a read request is issued, and decrements when the dat=
a is returned.; Tracks only those requests that come from the port specifie=
d in the IRP_PmonFilter.OrderingQ register.  This register allows one to se=
lect one specific queue.  It is not possible to monitor multiple queues at =
a time.",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
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
+        "BriefDescription": "Outstanding Write Occupancy; Any Source",
+        "EventCode": "0x11",
+        "EventName": "UNC_I_CACHE_WRITE_OCCUPANCY.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of writes (and write =
prefetches)  that are outstanding in the uncore in each cycle.  This can be=
 used with the transaction count event to calculate the average latency in =
the uncore.  The occupancy increments when the ownership fetch/prefetch is =
issued, and decrements the data is returned to the uncore.; Tracks all requ=
ests from any source port.",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outstanding Write Occupancy; Select Source",
+        "EventCode": "0x11",
+        "EventName": "UNC_I_CACHE_WRITE_OCCUPANCY.SOURCE",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of writes (and write =
prefetches)  that are outstanding in the uncore in each cycle.  This can be=
 used with the transaction count event to calculate the average latency in =
the uncore.  The occupancy increments when the ownership fetch/prefetch is =
issued, and decrements the data is returned to the uncore.; Tracks only tho=
se requests that come from the port specified in the IRP_PmonFilter.Orderin=
gQ register.  This register allows one to select one specific queue.  It is=
 not possible to monitor multiple queues at a time.",
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
+        "EventCode": "0xb",
+        "EventName": "UNC_I_RxR_AK_CYCLES_FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the AK Ingr=
ess is full.  This queue is where the IRP receives responses from R2PCIe (t=
he ring).",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "AK Ingress Occupancy",
+        "EventCode": "0xa",
+        "EventName": "UNC_I_RxR_AK_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the AK=
 Ingress.  This queue is where the IRP receives responses from R2PCIe (the =
ring).",
+        "Unit": "IRP"
+    },
+    {
+        "EventCode": "0xc",
+        "EventName": "UNC_I_RxR_AK_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of the AK Ingress =
in each cycles.  This queue is where the IRP receives responses from R2PCIe=
 (the ring).",
+        "Unit": "IRP"
+    },
+    {
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
+        "BriefDescription": "Tickle Count; Ownership Lost",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TICKLES.LOST_OWNERSHIP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of tickles that are receiv=
ed.  This is for both explicit (from Cbo) and implicit (internal conflict) =
tickles.; Tracks the number of requests that lost ownership as a result of =
a tickle.  When a tickle comes in, if the request is not at the head of the=
 queue in the switch, then that request as well as any requests behind it i=
n the switch queue will lose ownership and have to re-acquire it later when=
 they get to the head of the queue.  This will therefore track the number o=
f requests that lost ownership and not just the number of tickles.",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Tickle Count; Data Returned",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TICKLES.TOP_OF_QUEUE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of tickles that are receiv=
ed.  This is for both explicit (from Cbo) and implicit (internal conflict) =
tickles.; Tracks the number of cases when a tickle was received but the req=
uests was at the head of the queue in the switch.  In this case, data is re=
turned rather than releasing ownership.",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count: Read Prefetches",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_TRANSACTIONS.PD_PREFETCHES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Read Prefetches",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_TRANSACTIONS.RD_PREFETCHES",
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
+        "EventCode": "0x15",
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
+        "EventCode": "0x15",
+        "EventName": "UNC_I_TRANSACTIONS.WRITES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Trackes only write requests.=
  Each write request should have a prefetch, so there is no need to explici=
tly track these requests.  For writes that are tickled and have to retry, t=
he counter will be incremented for each retry.",
+        "UMask": "0x2",
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
+        "EventCode": "0xe",
+        "EventName": "UNC_I_TxR_DATA_INSERTS_NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of requests issued to the =
switch (towards the devices).",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outbound Read Requests",
+        "EventCode": "0xf",
+        "EventName": "UNC_I_TxR_DATA_INSERTS_NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of requests issued to the =
switch (towards the devices).",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outbound Request Queue Occupancy",
+        "EventCode": "0xd",
+        "EventName": "UNC_I_TxR_REQUEST_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumultes the number of outstanding outboun=
d requests from the IRP to the switch (towards the devices).  This can be u=
sed in conjuection with the allocations event in order to calculate average=
 latency of outbound requests.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Write Ordering Stalls",
+        "EventCode": "0x1a",
+        "EventName": "UNC_I_WRITE_ORDERING_STALL_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are p=
ending write ACK's in the switch but the switch->IRP pipeline is not utiliz=
ed.",
+        "Unit": "IRP"
+    },
     {
         "BriefDescription": "Number of qfclks",
         "EventCode": "0x14",
         "EventName": "UNC_Q_CLOCKTICKS",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of clocks in the QPI LL.  =
This clock runs at 1/8th the GT/s speed of the QPI link.  For example, a 8G=
T/s link will have qfclk or 1GHz.  JKT does not support dynamic link speeds=
, so this frequency is fixed.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Count of CTO Events",
@@ -13,7 +318,7 @@
         "EventName": "UNC_Q_CTO_COUNT",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of CTO (cluster trigger ou=
ts) events that were asserted across the two slots.  If both slots trigger =
in a given cycle, the event will increment by 2.  You can use edge detect t=
o count the number of cases when both events triggered.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egres=
s Credits",
@@ -22,7 +327,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because there were not enough Egress=
 credits.  Had there been enough credits, the spawn would have worked as th=
e RBT bit was set and the RBT tag matched.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egres=
s and RBT Miss",
@@ -31,7 +336,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the RBT tag did not match an=
d there weren't enough Egress credits.   The valid bit was set.",
         "UMask": "0x20",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egres=
s and RBT Invalid",
@@ -40,7 +345,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because there were not enough Egress=
 credits AND the RBT bit was not set, but the RBT tag matched.",
         "UMask": "0x8",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egres=
s and RBT Miss, Invalid",
@@ -49,7 +354,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the RBT tag did not match, t=
he valid bit was not set and there weren't enough Egress credits.",
         "UMask": "0x80",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - RBT M=
iss",
@@ -58,7 +363,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the RBT tag did not match al=
though the valid bit was set and there were enough Egress credits.",
         "UMask": "0x10",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - RBT I=
nvalid",
@@ -67,7 +372,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the route-back table (RBT) s=
pecified that the transaction should not trigger a direct2core transaction.=
  This is common for IO transactions.  There were enough Egress credits and=
 the RBT tag matched but the valid bit was not set.",
         "UMask": "0x4",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - RBT M=
iss and Invalid",
@@ -76,7 +381,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the RBT tag did not match an=
d the valid bit was not set although there were enough Egress credits.",
         "UMask": "0x40",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Direct 2 Core Spawning; Spawn Success",
@@ -85,7 +390,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn was successful.  There were sufficient cred=
its, the RBT valid bit was set and there was an RBT tag match.  The message=
 was marked to spawn direct2core.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Cycles in L1",
@@ -93,205 +398,205 @@
         "EventName": "UNC_Q_L1_POWER_CYCLES",
         "PerPkg": "1",
         "PublicDescription": "Number of QPI qfclk cycles spent in L1 power=
 mode.  L1 is a mode that totally shuts down a QPI link.  Use edge detect t=
o count the number of instances when the QPI link entered L1.  Link power s=
tates are per link and per direction, so for example the Tx direction could=
 be in one state while Rx was in another. Because L1 totally shuts down the=
 link, it takes a good amount of time to exit this mode.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MATCH_MASK",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.DRS.AnyDataC",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.DRS.AnyResp",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.DRS.AnyResp11flits",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.DRS.AnyResp9flits",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.DRS.DataC_E",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.DRS.DataC_E_Cmp",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.DRS.DataC_E_FrcAckCnflt",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.DRS.DataC_F",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.DRS.DataC_F_Cmp",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.DRS.DataC_F_FrcAckCnflt",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.DRS.DataC_M",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.DRS.WbEData",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.DRS.WbIData",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.DRS.WbSData",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.HOM.AnyReq",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.HOM.AnyResp",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.HOM.RespFwd",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.HOM.RespFwdI",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.HOM.RespFwdIWb",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.HOM.RespFwdS",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.HOM.RespFwdSWb",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.HOM.RespIWb",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.HOM.RespSWb",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.NCB.AnyInt",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.NCB.AnyMsg",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.NCB.AnyMsg11flits",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.NCB.AnyMsg9flits",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.NCS.AnyMsg1or2flits",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.NCS.AnyMsg3flits",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.NCS.NcRd",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.NDR.AnyCmp",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "EventCode": "0x38",
         "EventName": "UNC_Q_MESSAGE.SNP.AnySnp",
         "PerPkg": "1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Cycles in L0p",
@@ -299,7 +604,7 @@
         "EventName": "UNC_Q_RxL0P_POWER_CYCLES",
         "PerPkg": "1",
         "PublicDescription": "Number of QPI qfclk cycles spent in L0p powe=
r mode.  L0p is a mode where we disable 1/2 of the QPI lanes, decreasing ou=
r bandwidth in order to save power.  It increases snoop and data transfer l=
atencies and decreases overall bandwidth.  This mode can be very useful in =
NUMA optimized workloads that largely only utilize QPI for snoops and their=
 responses.  Use edge detect to count the number of instances when the QPI =
link entered L0p.  Link power states are per link and per direction, so for=
 example the Tx direction could be in one state while Rx was in another.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Cycles in L0",
@@ -307,7 +612,7 @@
         "EventName": "UNC_Q_RxL0_POWER_CYCLES",
         "PerPkg": "1",
         "PublicDescription": "Number of QPI qfclk cycles spent in L0 power=
 mode in the Link Layer.  L0 is the default mode which provides the highest=
 performance with the most power.  Use edge detect to count the number of i=
nstances that the link entered L0.  Link power states are per link and per =
direction, so for example the Tx direction could be in one state while Rx w=
as in another.  The phy layer  sometimes leaves L0 for training, which will=
 not be captured by this event.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Rx Flit Buffer Bypassed",
@@ -315,7 +620,7 @@
         "EventName": "UNC_Q_RxL_BYPASSED",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an incoming =
flit was able to bypass the flit buffer and pass directly across the BGF an=
d into the Egress.  This is a latency optimization, and should generally be=
 the common case.  If this value is less than the number of flits transferr=
ed, it implies that there was queueing getting onto the ring, and thus the =
transactions saw higher latency.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "CRC Errors Detected; LinkInit",
@@ -324,7 +629,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of CRC errors detected in the QPI Age=
nt.  Each QPI flit incorporates 8 bits of CRC for error detection.  This co=
unts the number of flits where the CRC was able to detect an error.  After =
an error has been detected, the QPI agent will send a request to the transm=
itting socket to resend the flit (as well as any flits that came after it).=
; CRC errors detected during link initialization.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "CRC Errors Detected; Normal Operations",
@@ -333,7 +638,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of CRC errors detected in the QPI Age=
nt.  Each QPI flit incorporates 8 bits of CRC for error detection.  This co=
unts the number of flits where the CRC was able to detect an error.  After =
an error has been detected, the QPI agent will send a request to the transm=
itting socket to resend the flit (as well as any flits that came after it).=
; CRC errors detected during normal operation.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "VN0 Credit Consumed; DRS",
@@ -342,7 +647,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN0 credit for the DRS message class.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "VN0 Credit Consumed; HOM",
@@ -351,7 +656,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN0 credit for the HOM message class.",
         "UMask": "0x8",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "VN0 Credit Consumed; NCB",
@@ -360,7 +665,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN0 credit for the NCB message class.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "VN0 Credit Consumed; NCS",
@@ -369,7 +674,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN0 credit for the NCS message class.",
         "UMask": "0x4",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "VN0 Credit Consumed; NDR",
@@ -378,7 +683,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN0 credit for the NDR message class.",
         "UMask": "0x20",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "VN0 Credit Consumed; SNP",
@@ -387,7 +692,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN0 credit for the SNP message class.",
         "UMask": "0x10",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "VN1 Credit Consumed; DRS",
@@ -396,7 +701,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the DRS message class.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "VN1 Credit Consumed; HOM",
@@ -405,7 +710,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the HOM message class.",
         "UMask": "0x8",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "VN1 Credit Consumed; NCB",
@@ -414,7 +719,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the NCB message class.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "VN1 Credit Consumed; NCS",
@@ -423,7 +728,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the NCS message class.",
         "UMask": "0x4",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "VN1 Credit Consumed; NDR",
@@ -432,7 +737,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the NDR message class.",
         "UMask": "0x20",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "VN1 Credit Consumed; SNP",
@@ -441,7 +746,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the SNP message class.",
         "UMask": "0x10",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "VNA Credit Consumed",
@@ -449,7 +754,7 @@
         "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VNA",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VNA c=
redit was consumed (i.e. message uses a VNA credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Cycles Not Empty",
@@ -457,7 +762,7 @@
         "EventName": "UNC_Q_RxL_CYCLES_NE",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Cycles Not Empty - DRS; for VN0",
@@ -466,7 +771,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors DRS flits only.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Cycles Not Empty - DRS; for VN1",
@@ -475,7 +780,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors DRS flits only.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Cycles Not Empty - HOM; for VN0",
@@ -484,7 +789,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors HOM flits only.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Cycles Not Empty - HOM; for VN1",
@@ -493,7 +798,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors HOM flits only.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Cycles Not Empty - NCB; for VN0",
@@ -502,7 +807,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NCB flits only.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Cycles Not Empty - NCB; for VN1",
@@ -511,7 +816,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NCB flits only.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Cycles Not Empty - NCS; for VN0",
@@ -520,7 +825,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NCS flits only.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Cycles Not Empty - NCS; for VN1",
@@ -529,7 +834,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NCS flits only.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Cycles Not Empty - NDR; for VN0",
@@ -538,7 +843,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NDR flits only.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Cycles Not Empty - NDR; for VN1",
@@ -547,7 +852,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NDR flits only.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Cycles Not Empty - SNP; for VN0",
@@ -556,7 +861,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors SNP flits only.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Cycles Not Empty - SNP; for VN1",
@@ -565,7 +870,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors SNP flits only.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 0; Data Tx Flits",
@@ -574,7 +879,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each f=
lit is made up of 80 bits of information (in addition to some ECC data).  I=
n full-width (L0) mode, flits are made up of four fits, each of which conta=
ins 20 bits of data (along with some additional ECC data).   In half-width =
(L0p) mode, the fits are only 10 bits, and therefore it takes twice as many=
 fits to transmit a flit.  When one talks about QPI speed (for example, 8.0=
 GT/s), the transfers here refer to fits.  Therefore, in L0, the system wil=
l transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate th=
e bandwidth of the link by taking: flits*80b/time.  Note that this is not t=
he same as data bandwidth.  For example, when we are transferring a 64B cac=
heline across QPI, we will break it into 9 flits -- 1 with header informati=
on and 8 with 64 bits of actual data and an additional 16 bits of other inf=
ormation.  To calculate data bandwidth, one should therefore do: data flits=
 * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of data flits re=
ceived over QPI.  Each flit contains 64b of data.  This includes both DRS a=
nd NCB data flits (coherent and non-coherent).  This can be used to calcula=
te the data bandwidth of the QPI link.  One can get a good picture of the Q=
PI-link characteristics by evaluating the protocol flits, data flits, and i=
dle/null flits.  This does not include the header flits that go in data pac=
kets.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 0; Idle and Null Flits=
",
@@ -583,7 +888,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each f=
lit is made up of 80 bits of information (in addition to some ECC data).  I=
n full-width (L0) mode, flits are made up of four fits, each of which conta=
ins 20 bits of data (along with some additional ECC data).   In half-width =
(L0p) mode, the fits are only 10 bits, and therefore it takes twice as many=
 fits to transmit a flit.  When one talks about QPI speed (for example, 8.0=
 GT/s), the transfers here refer to fits.  Therefore, in L0, the system wil=
l transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate th=
e bandwidth of the link by taking: flits*80b/time.  Note that this is not t=
he same as data bandwidth.  For example, when we are transferring a 64B cac=
heline across QPI, we will break it into 9 flits -- 1 with header informati=
on and 8 with 64 bits of actual data and an additional 16 bits of other inf=
ormation.  To calculate data bandwidth, one should therefore do: data flits=
 * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of flits receive=
d over QPI that do not hold protocol payload.  When QPI is not in a power s=
aving state, it continuously transmits flits across the link.  When there a=
re no protocol flits to send, it will send IDLE and NULL flits  across.  Th=
ese flits sometimes do carry a payload, such as credit returns, but are gen=
erally not considered part of the QPI bandwidth.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 0; Non-Data protocol T=
x Flits",
@@ -592,7 +897,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each f=
lit is made up of 80 bits of information (in addition to some ECC data).  I=
n full-width (L0) mode, flits are made up of four fits, each of which conta=
ins 20 bits of data (along with some additional ECC data).   In half-width =
(L0p) mode, the fits are only 10 bits, and therefore it takes twice as many=
 fits to transmit a flit.  When one talks about QPI speed (for example, 8.0=
 GT/s), the transfers here refer to fits.  Therefore, in L0, the system wil=
l transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate th=
e bandwidth of the link by taking: flits*80b/time.  Note that this is not t=
he same as data bandwidth.  For example, when we are transferring a 64B cac=
heline across QPI, we will break it into 9 flits -- 1 with header informati=
on and 8 with 64 bits of actual data and an additional 16 bits of other inf=
ormation.  To calculate data bandwidth, one should therefore do: data flits=
 * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NULL non-=
data flits received across QPI.  This basically tracks the protocol overhea=
d on the QPI link.  One can get a good picture of the QPI-link characterist=
ics by evaluating the protocol flits, data flits, and idle/null flits.  Thi=
s includes the header flits for data packets.",
         "UMask": "0x4",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 1; DRS Flits (both Hea=
der and Data)",
@@ -601,7 +906,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of flits received over QPI on the DRS (Data Respo=
nse) channel.  DRS flits are used to transmit data with coherency.  This do=
es not count data flits received over the NCB channel which transmits non-c=
oherent data.",
         "UMask": "0x18",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 1; DRS Data Flits",
@@ -610,7 +915,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of data flits received over QPI on the DRS (Data =
Response) channel.  DRS flits are used to transmit data with coherency.  Th=
is does not count data flits received over the NCB channel which transmits =
non-coherent data.  This includes only the data flits (not the header).",
         "UMask": "0x8",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 1; DRS Header Flits",
@@ -619,7 +924,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of protocol flits received over QPI on the DRS (D=
ata Response) channel.  DRS flits are used to transmit data with coherency.=
  This does not count data flits received over the NCB channel which transm=
its non-coherent data.  This includes only the header flits (not the data).=
  This includes extended headers.",
         "UMask": "0x10",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 1; HOM Flits",
@@ -628,7 +933,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the number of flits received over QPI on the home channel.",
         "UMask": "0x6",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 1; HOM Non-Request Fli=
ts",
@@ -637,7 +942,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the number of non-request flits received over QPI on the home chan=
nel.  These are most commonly snoop responses, and this event can be used a=
s a proxy for that.",
         "UMask": "0x4",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 1; HOM Request Flits",
@@ -646,7 +951,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the number of data request received over QPI on the home channel. =
 This basically counts the number of remote memory requests received over Q=
PI.  In conjunction with the local read count in the Home Agent, one can ca=
lculate the number of LLC Misses.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 1; SNP Flits",
@@ -655,7 +960,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the number of snoop request flits received over QPI.  These reques=
ts are contained in the snoop channel.  This does not include snoop respons=
es, which are received on the home channel.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 2; Non-Coherent Rx Fli=
ts",
@@ -664,7 +969,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Number of Non-Coherent Bypass flits.  These packets are generally used to=
 transmit non-coherent data across QPI.",
         "UMask": "0xc",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 2; Non-Coherent data R=
x Flits",
@@ -673,7 +978,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Number of Non-Coherent Bypass data flits.  These flits are generally used=
 to transmit non-coherent data across QPI.  This does not include a count o=
f the DRS (coherent) data flits.  This only counts the data flits, not the =
NCB headers.",
         "UMask": "0x4",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 2; Non-Coherent non-da=
ta Rx Flits",
@@ -682,7 +987,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Number of Non-Coherent Bypass non-data flits.  These packets are generall=
y used to transmit non-coherent data across QPI, and the flits counted here=
 are for headers and other non-data flits.  This includes extended headers.=
",
         "UMask": "0x8",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 2; Non-Coherent standa=
rd Rx Flits",
@@ -691,7 +996,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Number of NCS (non-coherent standard) flits received over QPI.    This in=
cludes extended headers.",
         "UMask": "0x10",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 2; Non-Data Response R=
x Flits - AD",
@@ -700,7 +1005,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of flits received over the NDR (Non-Data Response=
) channel.  This channel is used to send a variety of protocol flits includ=
ing grants and completions.  This is only for NDR packets to the local sock=
et which use the AK ring.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 2; Non-Data Response R=
x Flits - AK",
@@ -709,7 +1014,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transferring a 64B cacheline across=
 QPI, we will break it into 9 flits -- 1 with header information and 8 with=
 64 bits of actual data and an additional 16 bits of other information.  To=
 calculate data bandwidth, one should therefore do: data flits * 8B / time.=
; Counts the total number of flits received over the NDR (Non-Data Response=
) channel.  This channel is used to send a variety of protocol flits includ=
ing grants and completions.  This is only for NDR packets destined for Rout=
e-thru to a remote socket.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations",
@@ -717,7 +1022,7 @@
         "EventName": "UNC_Q_RxL_INSERTS",
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - DRS",
@@ -725,7 +1030,7 @@
         "EventName": "UNC_Q_RxL_INSERTS_DRS",
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only DRS flits.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - DRS; for VN0",
@@ -734,7 +1039,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only DRS flits.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - DRS; for VN1",
@@ -743,7 +1048,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only DRS flits.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - HOM",
@@ -751,7 +1056,7 @@
         "EventName": "UNC_Q_RxL_INSERTS_HOM",
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only HOM flits.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - HOM; for VN0",
@@ -760,7 +1065,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only HOM flits.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - HOM; for VN1",
@@ -769,7 +1074,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only HOM flits.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - NCB",
@@ -777,7 +1082,7 @@
         "EventName": "UNC_Q_RxL_INSERTS_NCB",
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NCB flits.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - NCB; for VN0",
@@ -786,7 +1091,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NCB flits.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - NCB; for VN1",
@@ -795,7 +1100,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NCB flits.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - NCS",
@@ -803,7 +1108,7 @@
         "EventName": "UNC_Q_RxL_INSERTS_NCS",
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NCS flits.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - NCS; for VN0",
@@ -812,7 +1117,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NCS flits.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - NCS; for VN1",
@@ -821,7 +1126,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NCS flits.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - NDR",
@@ -829,7 +1134,7 @@
         "EventName": "UNC_Q_RxL_INSERTS_NDR",
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NDR flits.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - NDR; for VN0",
@@ -838,7 +1143,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NDR flits.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - NDR; for VN1",
@@ -847,7 +1152,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NDR flits.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - SNP",
@@ -855,7 +1160,7 @@
         "EventName": "UNC_Q_RxL_INSERTS_SNP",
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only SNP flits.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - SNP; for VN0",
@@ -864,7 +1169,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only SNP flits.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations - SNP; for VN1",
@@ -873,7 +1178,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only SNP flits.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Occupancy - All Packets",
@@ -881,7 +1186,7 @@
         "EventName": "UNC_Q_RxL_OCCUPANCY",
         "PerPkg": "1",
         "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Occupancy - DRS",
@@ -889,7 +1194,7 @@
         "EventName": "UNC_Q_RxL_OCCUPANCY_DRS",
         "PerPkg": "1",
         "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors DRS flits only.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Occupancy - DRS; for VN0",
@@ -898,7 +1203,7 @@
         "PerPkg": "1",
         "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors DRS flits only.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Occupancy - DRS; for VN1",
@@ -907,7 +1212,7 @@
         "PerPkg": "1",
         "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors DRS flits only.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Occupancy - HOM",
@@ -915,7 +1220,7 @@
         "EventName": "UNC_Q_RxL_OCCUPANCY_HOM",
         "PerPkg": "1",
         "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors HOM flits only.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Occupancy - HOM; for VN0",
@@ -924,7 +1229,7 @@
         "PerPkg": "1",
         "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors HOM flits only.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Occupancy - HOM; for VN1",
@@ -933,7 +1238,7 @@
         "PerPkg": "1",
         "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors HOM flits only.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Occupancy - NCB",
@@ -941,7 +1246,7 @@
         "EventName": "UNC_Q_RxL_OCCUPANCY_NCB",
         "PerPkg": "1",
         "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NCB flits only.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Occupancy - NCB; for VN0",
@@ -950,7 +1255,7 @@
         "PerPkg": "1",
         "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NCB flits only.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Occupancy - NCB; for VN1",
@@ -959,7 +1264,7 @@
         "PerPkg": "1",
         "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NCB flits only.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Occupancy - NCS",
@@ -967,7 +1272,7 @@
         "EventName": "UNC_Q_RxL_OCCUPANCY_NCS",
         "PerPkg": "1",
         "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NCS flits only.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Occupancy - NCS; for VN0",
@@ -976,7 +1281,7 @@
         "PerPkg": "1",
         "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NCS flits only.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Occupancy - NCS; for VN1",
@@ -985,7 +1290,7 @@
         "PerPkg": "1",
         "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NCS flits only.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Occupancy - NDR",
@@ -993,7 +1298,7 @@
         "EventName": "UNC_Q_RxL_OCCUPANCY_NDR",
         "PerPkg": "1",
         "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NDR flits only.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Occupancy - NDR; for VN0",
@@ -1002,7 +1307,7 @@
         "PerPkg": "1",
         "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NDR flits only.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Occupancy - NDR; for VN1",
@@ -1011,7 +1316,7 @@
         "PerPkg": "1",
         "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NDR flits only.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Occupancy - SNP",
@@ -1019,7 +1324,7 @@
         "EventName": "UNC_Q_RxL_OCCUPANCY_SNP",
         "PerPkg": "1",
         "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors SNP flits only.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Occupancy - SNP; for VN0",
@@ -1028,7 +1333,7 @@
         "PerPkg": "1",
         "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors SNP flits only.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "RxQ Occupancy - SNP; for VN1",
@@ -1037,7 +1342,7 @@
         "PerPkg": "1",
         "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors SNP flits only.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - H=
OM",
@@ -1046,7 +1351,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the HOM message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - D=
RS",
@@ -1055,7 +1360,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the DRS message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
         "UMask": "0x8",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - S=
NP",
@@ -1064,7 +1369,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the SNP message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - N=
DR",
@@ -1073,7 +1378,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the NDR message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
         "UMask": "0x4",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - N=
CS",
@@ -1082,7 +1387,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the NCS message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
         "UMask": "0x20",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - N=
CB",
@@ -1091,7 +1396,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the NCB message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
         "UMask": "0x10",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI on VN0; Egress Credit=
s",
@@ -1100,7 +1405,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet because there were insufficient BGF cre=
dits.  For details on a message class granularity, use the Egress Credit Oc=
cupancy events.",
         "UMask": "0x40",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI on VN0; GV",
@@ -1109,7 +1414,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled because a GV transition (frequency transition) w=
as taking place.",
         "UMask": "0x80",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - H=
OM",
@@ -1118,7 +1423,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the HOM message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - D=
RS",
@@ -1127,7 +1432,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the DRS message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
         "UMask": "0x8",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - S=
NP",
@@ -1136,7 +1441,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the SNP message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - N=
DR",
@@ -1145,7 +1450,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the NDR message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
         "UMask": "0x4",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - N=
CS",
@@ -1154,7 +1459,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the NCS message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
         "UMask": "0x20",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - N=
CB",
@@ -1163,7 +1468,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the NCB message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
         "UMask": "0x10",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Cycles in L0p",
@@ -1171,7 +1476,7 @@
         "EventName": "UNC_Q_TxL0P_POWER_CYCLES",
         "PerPkg": "1",
         "PublicDescription": "Number of QPI qfclk cycles spent in L0p powe=
r mode.  L0p is a mode where we disable 1/2 of the QPI lanes, decreasing ou=
r bandwidth in order to save power.  It increases snoop and data transfer l=
atencies and decreases overall bandwidth.  This mode can be very useful in =
NUMA optimized workloads that largely only utilize QPI for snoops and their=
 responses.  Use edge detect to count the number of instances when the QPI =
link entered L0p.  Link power states are per link and per direction, so for=
 example the Tx direction could be in one state while Rx was in another.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Cycles in L0",
@@ -1179,7 +1484,7 @@
         "EventName": "UNC_Q_TxL0_POWER_CYCLES",
         "PerPkg": "1",
         "PublicDescription": "Number of QPI qfclk cycles spent in L0 power=
 mode in the Link Layer.  L0 is the default mode which provides the highest=
 performance with the most power.  Use edge detect to count the number of i=
nstances that the link entered L0.  Link power states are per link and per =
direction, so for example the Tx direction could be in one state while Rx w=
as in another.  The phy layer  sometimes leaves L0 for training, which will=
 not be captured by this event.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Tx Flit Buffer Bypassed",
@@ -1187,7 +1492,7 @@
         "EventName": "UNC_Q_TxL_BYPASSED",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an incoming =
flit was able to bypass the Tx flit buffer and pass directly out the QPI Li=
nk. Generally, when data is transmitted across QPI, it will bypass the TxQ =
and pass directly to the link.  However, the TxQ will be used with L0p and =
when LLR occurs, increasing latency to transfer out to the link.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Cycles Stalled with no LLR Credits; LLR is al=
most full",
@@ -1196,7 +1501,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of cycles when the Tx side ran out of=
 Link Layer Retry credits, causing the Tx to stall.; When LLR is almost ful=
l, we block some but not all packets.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Cycles Stalled with no LLR Credits; LLR is fu=
ll",
@@ -1205,7 +1510,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of cycles when the Tx side ran out of=
 Link Layer Retry credits, causing the Tx to stall.; When LLR is totally fu=
ll, we are not allowed to send any packets.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Tx Flit Buffer Cycles not Empty",
@@ -1213,7 +1518,7 @@
         "EventName": "UNC_Q_TxL_CYCLES_NE",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles when the TxQ is =
not empty. Generally, when data is transmitted across QPI, it will bypass t=
he TxQ and pass directly to the link.  However, the TxQ will be used with L=
0p and when LLR occurs, increasing latency to transfer out to the link.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 0; Data Tx Flits",
@@ -1221,7 +1526,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach flit is made up of 80 bits of information (in addition to some ECC data=
).  In full-width (L0) mode, flits are made up of four fits, each of which =
contains 20 bits of data (along with some additional ECC data).   In half-w=
idth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as=
 many fits to transmit a flit.  When one talks about QPI speed (for example=
, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the syste=
m will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as data bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual data and an additional 16 bits of othe=
r information.  To calculate data bandwidth, one should therefore do: data =
flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of data fli=
ts transmitted over QPI.  Each flit contains 64b of data.  This includes bo=
th DRS and NCB data flits (coherent and non-coherent).  This can be used to=
 calculate the data bandwidth of the QPI link.  One can get a good picture =
of the QPI-link characteristics by evaluating the protocol flits, data flit=
s, and idle/null flits.  This does not include the header flits that go in =
data packets.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 0; Non-Data protoco=
l Tx Flits",
@@ -1229,7 +1534,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach flit is made up of 80 bits of information (in addition to some ECC data=
).  In full-width (L0) mode, flits are made up of four fits, each of which =
contains 20 bits of data (along with some additional ECC data).   In half-w=
idth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as=
 many fits to transmit a flit.  When one talks about QPI speed (for example=
, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the syste=
m will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as data bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual data and an additional 16 bits of othe=
r information.  To calculate data bandwidth, one should therefore do: data =
flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NULL=
 non-data flits transmitted across QPI.  This basically tracks the protocol=
 overhead on the QPI link.  One can get a good picture of the QPI-link char=
acteristics by evaluating the protocol flits, data flits, and idle/null fli=
ts.  This includes the header flits for data packets.",
         "UMask": "0x4",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; DRS Flits (both =
Header and Data)",
@@ -1237,7 +1542,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of flits transmitted over QPI on the DRS (Da=
ta Response) channel.  DRS flits are used to transmit data with coherency."=
,
         "UMask": "0x18",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; DRS Data Flits",
@@ -1245,7 +1550,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of data flits transmitted over QPI on the DR=
S (Data Response) channel.  DRS flits are used to transmit data with cohere=
ncy.  This does not count data flits transmitted over the NCB channel which=
 transmits non-coherent data.  This includes only the data flits (not the h=
eader).",
         "UMask": "0x8",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; DRS Header Flits=
",
@@ -1253,7 +1558,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of protocol flits transmitted over QPI on th=
e DRS (Data Response) channel.  DRS flits are used to transmit data with co=
herency.  This does not count data flits transmitted over the NCB channel w=
hich transmits non-coherent data.  This includes only the header flits (not=
 the data).  This includes extended headers.",
         "UMask": "0x10",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; HOM Flits",
@@ -1261,7 +1566,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the number of flits transmitted over QPI on the home channel.=
",
         "UMask": "0x6",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; HOM Non-Request =
Flits",
@@ -1269,7 +1574,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the number of non-request flits transmitted over QPI on the h=
ome channel.  These are most commonly snoop responses, and this event can b=
e used as a proxy for that.",
         "UMask": "0x4",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; HOM Request Flit=
s",
@@ -1277,7 +1582,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the number of data request transmitted over QPI on the home c=
hannel.  This basically counts the number of remote memory requests transmi=
tted over QPI.  In conjunction with the local read count in the Home Agent,=
 one can calculate the number of LLC Misses.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; SNP Flits",
@@ -1285,7 +1590,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for SNP, HOM, and DRS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the number of snoop request flits transmitted over QPI.  Thes=
e requests are contained in the snoop channel.  This does not include snoop=
 responses, which are transmitted on the home channel.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 2; Non-Coherent Byp=
ass Tx Flits",
@@ -1294,7 +1599,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Number of Non-Coherent Bypass flits.  These packets are generally us=
ed to transmit non-coherent data across QPI.",
         "UMask": "0xc",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 2; Non-Coherent dat=
a Tx Flits",
@@ -1303,7 +1608,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Number of Non-Coherent Bypass data flits.  These flits are generally=
 used to transmit non-coherent data across QPI.  This does not include a co=
unt of the DRS (coherent) data flits.  This only counts the data flits, not=
 the NCB headers.",
         "UMask": "0x4",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 2; Non-Coherent non=
-data Tx Flits",
@@ -1312,7 +1617,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Number of Non-Coherent Bypass non-data flits.  These packets are gen=
erally used to transmit non-coherent data across QPI, and the flits counted=
 here are for headers and other non-data flits.  This includes extended hea=
ders.",
         "UMask": "0x8",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 2; Non-Coherent sta=
ndard Tx Flits",
@@ -1321,7 +1626,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Number of NCS (non-coherent standard) flits transmitted over QPI.   =
 This includes extended headers.",
         "UMask": "0x10",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 2; Non-Data Respons=
e Tx Flits - AD",
@@ -1330,7 +1635,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of flits transmitted over the NDR (Non-Data =
Response) channel.  This channel is used to send a variety of protocol flit=
s including grants and completions.  This is only for NDR packets to the lo=
cal socket which use the AK ring.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 2; Non-Data Respons=
e Tx Flits - AK",
@@ -1339,7 +1644,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three groups that allow us to track flits. =
 It includes filters for NDR, NCB, and NCS message classes.  Each flit is m=
ade up of 80 bits of information (in addition to some ECC data).  In full-w=
idth (L0) mode, flits are made up of four fits, each of which contains 20 b=
its of data (along with some additional ECC data).   In half-width (L0p) mo=
de, the fits are only 10 bits, and therefore it takes twice as many fits to=
 transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), =
the transfers here refer to fits.  Therefore, in L0, the system will transf=
er 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwi=
dth of the link by taking: flits*80b/time.  Note that this is not the same =
as data bandwidth.  For example, when we are transferring a 64B cacheline a=
cross QPI, we will break it into 9 flits -- 1 with header information and 8=
 with 64 bits of actual data and an additional 16 bits of other information=
.  To calculate data bandwidth, one should therefore do: data flits * 8B / =
time.; Counts the total number of flits transmitted over the NDR (Non-Data =
Response) channel.  This channel is used to send a variety of protocol flit=
s including grants and completions.  This is only for NDR packets destined =
for Route-thru to a remote socket.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Tx Flit Buffer Allocations",
@@ -1347,7 +1652,7 @@
         "EventName": "UNC_Q_TxL_INSERTS",
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the QPI Tx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
TxQ and pass directly to the link.  However, the TxQ will be used with L0p =
and when LLR occurs, increasing latency to transfer out to the link.  This =
event can be used in conjunction with the Flit Buffer Occupancy event in or=
der to calculate the average flit buffer lifetime.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Tx Flit Buffer Occupancy",
@@ -1355,7 +1660,7 @@
         "EventName": "UNC_Q_TxL_OCCUPANCY",
         "PerPkg": "1",
         "PublicDescription": "Accumulates the number of flits in the TxQ. =
 Generally, when data is transmitted across QPI, it will bypass the TxQ and=
 pass directly to the link.  However, the TxQ will be used with L0p and whe=
n LLR occurs, increasing latency to transfer out to the link. This can be u=
sed with the cycles not empty event to track average occupancy, or the allo=
cations event to track average lifetime in the TxQ.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - HOM; for VN0"=
,
@@ -1364,7 +1669,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle. Flow Control FIFO for H=
ome messages on AD.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - HOM; for VN1"=
,
@@ -1373,7 +1678,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle. Flow Control FIFO for H=
ome messages on AD.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - AD HOM; for V=
N0",
@@ -1382,7 +1687,7 @@
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle.  Flow Control FIFO for HOM messages on AD.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - AD HOM; for V=
N1",
@@ -1391,7 +1696,7 @@
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle.  Flow Control FIFO for HOM messages on AD.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - AD NDR; for V=
N0",
@@ -1400,7 +1705,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle.  Flow Control FIFO for =
NDR messages on AD.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - AD NDR; for V=
N1",
@@ -1409,7 +1714,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle.  Flow Control FIFO for =
NDR messages on AD.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - AD NDR; for V=
N0",
@@ -1418,7 +1723,7 @@
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle. Flow Control FIFO  for NDR messages on AD.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - AD NDR; for V=
N1",
@@ -1427,7 +1732,7 @@
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle. Flow Control FIFO  for NDR messages on AD.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - SNP; for VN0"=
,
@@ -1436,7 +1741,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle.  Flow Control FIFO for =
Snoop messages on AD.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - SNP; for VN1"=
,
@@ -1445,7 +1750,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle.  Flow Control FIFO for =
Snoop messages on AD.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - AD SNP; for V=
N0",
@@ -1454,7 +1759,7 @@
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle.  Flow Control FIFO for Snoop messages on AD.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - AD SNP; for V=
N1",
@@ -1463,7 +1768,7 @@
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle.  Flow Control FIFO for Snoop messages on AD.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - AK NDR",
@@ -1471,7 +1776,7 @@
         "EventName": "UNC_Q_TxR_AK_NDR_CREDIT_ACQUIRED",
         "PerPkg": "1",
         "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. Local NDR message class to AK Egre=
ss.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - AK NDR: for V=
N0",
@@ -1480,7 +1785,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. Local NDR message class to AK Egre=
ss.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - AK NDR: for V=
N1",
@@ -1489,7 +1794,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. Local NDR message class to AK Egre=
ss.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - AK NDR",
@@ -1497,7 +1802,7 @@
         "EventName": "UNC_Q_TxR_AK_NDR_CREDIT_OCCUPANCY",
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  Local NDR message class to AK Egress.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - AK NDR: for V=
N0",
@@ -1506,7 +1811,7 @@
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  Local NDR message class to AK Egress.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - AK NDR: for V=
N1",
@@ -1515,7 +1820,7 @@
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  Local NDR message class to AK Egress.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - DRS; for VN0"=
,
@@ -1524,7 +1829,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. DRS message class to BL Egress.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - DRS; for VN1"=
,
@@ -1533,7 +1838,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. DRS message class to BL Egress.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - DRS; for Shar=
ed VN",
@@ -1542,7 +1847,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. DRS message class to BL Egress.",
         "UMask": "0x4",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - BL DRS; for V=
N0",
@@ -1551,7 +1856,7 @@
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  DRS message class to BL Egress.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - BL DRS; for V=
N1",
@@ -1560,7 +1865,7 @@
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  DRS message class to BL Egress.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - BL DRS; for S=
hared VN",
@@ -1569,7 +1874,7 @@
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  DRS message class to BL Egress.",
         "UMask": "0x4",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - NCB; for VN0"=
,
@@ -1578,7 +1883,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. NCB message class to BL Egress.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - NCB; for VN1"=
,
@@ -1587,7 +1892,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. NCB message class to BL Egress.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - BL NCB; for V=
N0",
@@ -1596,7 +1901,7 @@
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  NCB message class to BL Egress.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - BL NCB; for V=
N1",
@@ -1605,7 +1910,7 @@
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  NCB message class to BL Egress.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - NCS; for VN0"=
,
@@ -1614,7 +1919,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. NCS message class to BL Egress.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - NCS; for VN1"=
,
@@ -1623,7 +1928,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. NCS message class to BL Egress.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - BL NCS; for V=
N0",
@@ -1632,7 +1937,7 @@
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  NCS message class to BL Egress.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "R3QPI Egress Credit Occupancy - BL NCS; for V=
N1",
@@ -1641,7 +1946,7 @@
         "PerPkg": "1",
         "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  NCS message class to BL Egress.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "VNA Credits Returned",
@@ -1649,7 +1954,7 @@
         "EventName": "UNC_Q_VNA_CREDIT_RETURNS",
         "PerPkg": "1",
         "PublicDescription": "Number of VNA credits returned.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "VNA Credits Pending Return - Occupancy",
@@ -1657,6 +1962,1326 @@
         "EventName": "UNC_Q_VNA_CREDIT_RETURN_OCCUPANCY",
         "PerPkg": "1",
         "PublicDescription": "Number of VNA credits in the Rx side that ar=
e waitng to be returned back across the link.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
+    },
+    {
+        "BriefDescription": "Number of uclks in domain",
+        "EventCode": "0x1",
+        "EventName": "UNC_R3_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of uclks in the QPI uclk d=
omain.  This could be slightly different than the count in the Ubox because=
 of enable/freeze delays.  However, because the QPI Agent is close to the U=
box, they generally should not diverge by more than a handful of cycles.",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x2c",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO10",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 10",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x2c",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO11",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 11",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x2c",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO12",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 12",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x2c",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO13",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 13",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x2c",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO14",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 14&16",
+        "UMask": "0x40",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x2c",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO8",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 8",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x2c",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO9",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 9",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x2b",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO0",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 0",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x2b",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO1",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x2b",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO2",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 2",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x2b",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO3",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 3",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x2b",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO4",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 4",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x2b",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO5",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 5",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x2b",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO6",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 6",
+        "UMask": "0x40",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "EventCode": "0x2b",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO7",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 7",
+        "UMask": "0x80",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "HA/R2 AD Credits Empty",
+        "EventCode": "0x2f",
+        "EventName": "UNC_R3_HA_R2_BL_CREDITS_EMPTY.HA0",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to either HA or=
 R2 on the BL Ring; HA0",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "HA/R2 AD Credits Empty",
+        "EventCode": "0x2f",
+        "EventName": "UNC_R3_HA_R2_BL_CREDITS_EMPTY.HA1",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to either HA or=
 R2 on the BL Ring; HA1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "HA/R2 AD Credits Empty",
+        "EventCode": "0x2f",
+        "EventName": "UNC_R3_HA_R2_BL_CREDITS_EMPTY.R2_NCB",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to either HA or=
 R2 on the BL Ring; R2 NCB Messages",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "HA/R2 AD Credits Empty",
+        "EventCode": "0x2f",
+        "EventName": "UNC_R3_HA_R2_BL_CREDITS_EMPTY.R2_NCS",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to either HA or=
 R2 on the BL Ring; R2 NCS Messages",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 AD Credits Empty",
+        "EventCode": "0x29",
+        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN0_HOM",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN0 HOM Messages",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 AD Credits Empty",
+        "EventCode": "0x29",
+        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN0_NDR",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN0 NDR Messages",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 AD Credits Empty",
+        "EventCode": "0x29",
+        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN0_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN0 SNP Messages",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 AD Credits Empty",
+        "EventCode": "0x29",
+        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN1_HOM",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN1 HOM Messages",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 AD Credits Empty",
+        "EventCode": "0x29",
+        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN1_NDR",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN1 NDR Messages",
+        "UMask": "0x40",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 AD Credits Empty",
+        "EventCode": "0x29",
+        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN1_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN1 SNP Messages",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 AD Credits Empty",
+        "EventCode": "0x29",
+        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VNA",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VNA",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 BL Credits Empty",
+        "EventCode": "0x2d",
+        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN0_HOM",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VN0 HOM Messages",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 BL Credits Empty",
+        "EventCode": "0x2d",
+        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN0_NDR",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VN0 NDR Messages",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 BL Credits Empty",
+        "EventCode": "0x2d",
+        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN0_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VN0 SNP Messages",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 BL Credits Empty",
+        "EventCode": "0x2d",
+        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN1_HOM",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VN1 HOM Messages",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 BL Credits Empty",
+        "EventCode": "0x2d",
+        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN1_NDR",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VN1 NDR Messages",
+        "UMask": "0x40",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 BL Credits Empty",
+        "EventCode": "0x2d",
+        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN1_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VN1 SNP Messages",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 BL Credits Empty",
+        "EventCode": "0x2d",
+        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VNA",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VNA",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 AD Credits Empty",
+        "EventCode": "0x2a",
+        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN0_HOM",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VN0 HOM Messages",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 AD Credits Empty",
+        "EventCode": "0x2a",
+        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN0_NDR",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VN0 NDR Messages",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 AD Credits Empty",
+        "EventCode": "0x2a",
+        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN0_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VN0 SNP Messages",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 AD Credits Empty",
+        "EventCode": "0x2a",
+        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN1_HOM",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VN1 HOM Messages",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 AD Credits Empty",
+        "EventCode": "0x2a",
+        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN1_NDR",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VN1 NDR Messages",
+        "UMask": "0x40",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 AD Credits Empty",
+        "EventCode": "0x2a",
+        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN1_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VN1 SNP Messages",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 AD Credits Empty",
+        "EventCode": "0x2a",
+        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VNA",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VNA",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 BL Credits Empty",
+        "EventCode": "0x2e",
+        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN0_HOM",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN0 HOM Messages",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 BL Credits Empty",
+        "EventCode": "0x2e",
+        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN0_NDR",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN0 NDR Messages",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 BL Credits Empty",
+        "EventCode": "0x2e",
+        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN0_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN0 SNP Messages",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 BL Credits Empty",
+        "EventCode": "0x2e",
+        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN1_HOM",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN1 HOM Messages",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 BL Credits Empty",
+        "EventCode": "0x2e",
+        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN1_NDR",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN1 NDR Messages",
+        "UMask": "0x40",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 BL Credits Empty",
+        "EventCode": "0x2e",
+        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN1_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN1 SNP Messages",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 BL Credits Empty",
+        "EventCode": "0x2e",
+        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VNA",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VNA",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Counterclockwise",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xcc",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Counterclockwise and Even =
on VRing 0",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CCW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 0.",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Counterclockwise and Odd o=
n VRing 0",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CCW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 0.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Clockwise",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x33",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Clockwise and Even on VRin=
g 0",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 0.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Clockwise and Odd on VRing=
 0",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 0.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Counterclockwise",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xcc",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Counterclockwise and Even =
on VRing 0",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CCW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 0.",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Counterclockwise and Odd o=
n VRing 0",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CCW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 0.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Clockwise",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x33",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Clockwise and Even on VRin=
g 0",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 0.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Clockwise and Odd on VRing=
 0",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 0.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Counterclockwise",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xcc",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Counterclockwise and Even =
on VRing 0",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CCW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 0.",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Counterclockwise and Odd o=
n VRing 0",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CCW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 0.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Clockwise",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x33",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Clockwise and Even on VRin=
g 0",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 0.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Clockwise and Odd on VRing=
 0",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 0.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R2 IV Ring in Use; Any",
+        "EventCode": "0xA",
+        "EventName": "UNC_R3_RING_IV_USED.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  The IV ring is unidirectional.  Whether UP or=
 DN is used is dependent on the system programming.  Thereofore, one should=
 generally set both the UP and DN bits for a given polarity (or both) at a =
given time.; Filters any polarity",
+        "UMask": "0xff",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R2 IV Ring in Use; Counterclockwise",
+        "EventCode": "0xa",
+        "EventName": "UNC_R3_RING_IV_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  The IV ring is unidirectional.  Whether UP or=
 DN is used is dependent on the system programming.  Thereofore, one should=
 generally set both the UP and DN bits for a given polarity (or both) at a =
given time.; Filters for Counterclockwise polarity",
+        "UMask": "0xcc",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R2 IV Ring in Use; Clockwise",
+        "EventCode": "0xa",
+        "EventName": "UNC_R3_RING_IV_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  The IV ring is unidirectional.  Whether UP or=
 DN is used is dependent on the system programming.  Thereofore, one should=
 generally set both the UP and DN bits for a given polarity (or both) at a =
given time.; Filters for Clockwise polarity",
+        "UMask": "0x33",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "AD Ingress Bypassed",
+        "EventCode": "0x12",
+        "EventName": "UNC_R3_RxR_AD_BYPASSED",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when the AD Ingre=
ss was bypassed and an incoming transaction was bypassed directly across th=
e BGF and into the qfclk domain.",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Bypassed",
+        "EventCode": "0x12",
+        "EventName": "UNC_R3_RxR_BYPASSED.AD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when the Ingress =
was bypassed and an incoming transaction was bypassed directly across the B=
GF and into the qfclk domain.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; HOM",
+        "EventCode": "0x10",
+        "EventName": "UNC_R3_RxR_CYCLES_NE.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the QPI Ing=
ress is not empty.  This tracks one of the three rings that are used by the=
 QPI agent.  This can be used in conjunction with the QPI Ingress Occupancy=
 Accumulator event in order to calculate average queue occupancy.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.; H=
OM Ingress Queue",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; NDR",
+        "EventCode": "0x10",
+        "EventName": "UNC_R3_RxR_CYCLES_NE.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the QPI Ing=
ress is not empty.  This tracks one of the three rings that are used by the=
 QPI agent.  This can be used in conjunction with the QPI Ingress Occupancy=
 Accumulator event in order to calculate average queue occupancy.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.; N=
DR Ingress Queue",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; SNP",
+        "EventCode": "0x10",
+        "EventName": "UNC_R3_RxR_CYCLES_NE.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the QPI Ing=
ress is not empty.  This tracks one of the three rings that are used by the=
 QPI agent.  This can be used in conjunction with the QPI Ingress Occupancy=
 Accumulator event in order to calculate average queue occupancy.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.; S=
NP Ingress Queue",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; DRS",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; DRS Ingress=
 Queue",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; HOM",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; HOM Ingress=
 Queue",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; NCB",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; NCB Ingress=
 Queue",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; NCS",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; NCS Ingress=
 Queue",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; NDR",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; NDR Ingress=
 Queue",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; SNP",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; SNP Ingress=
 Queue",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy Accumulator; DRS",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of a given QPI Ing=
ress queue in each cycles.  This tracks one of the three ring Ingress buffe=
rs.  This can be used with the QPI Ingress Not Empty event to calculate ave=
rage occupancy or the QPI Ingress Allocations event in order to calculate a=
verage queuing latency.; DRS Ingress Queue",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy Accumulator; HOM",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of a given QPI Ing=
ress queue in each cycles.  This tracks one of the three ring Ingress buffe=
rs.  This can be used with the QPI Ingress Not Empty event to calculate ave=
rage occupancy or the QPI Ingress Allocations event in order to calculate a=
verage queuing latency.; HOM Ingress Queue",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy Accumulator; NCB",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of a given QPI Ing=
ress queue in each cycles.  This tracks one of the three ring Ingress buffe=
rs.  This can be used with the QPI Ingress Not Empty event to calculate ave=
rage occupancy or the QPI Ingress Allocations event in order to calculate a=
verage queuing latency.; NCB Ingress Queue",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy Accumulator; NCS",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of a given QPI Ing=
ress queue in each cycles.  This tracks one of the three ring Ingress buffe=
rs.  This can be used with the QPI Ingress Not Empty event to calculate ave=
rage occupancy or the QPI Ingress Allocations event in order to calculate a=
verage queuing latency.; NCS Ingress Queue",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy Accumulator; NDR",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of a given QPI Ing=
ress queue in each cycles.  This tracks one of the three ring Ingress buffe=
rs.  This can be used with the QPI Ingress Not Empty event to calculate ave=
rage occupancy or the QPI Ingress Allocations event in order to calculate a=
verage queuing latency.; NDR Ingress Queue",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy Accumulator; SNP",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of a given QPI Ing=
ress queue in each cycles.  This tracks one of the three ring Ingress buffe=
rs.  This can be used with the QPI Ingress Not Empty event to calculate ave=
rage occupancy or the QPI Ingress Allocations event in order to calculate a=
verage queuing latency.; SNP Ingress Queue",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Egress NACK; AK CCW",
+        "EventCode": "0x28",
+        "EventName": "UNC_R3_TxR_NACK_CCW.AD",
+        "PerPkg": "1",
+        "PublicDescription": "BL CounterClockwise Egress Queue",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Egress NACK; BL CW",
+        "EventCode": "0x28",
+        "EventName": "UNC_R3_TxR_NACK_CCW.AK",
+        "PerPkg": "1",
+        "PublicDescription": "AD Clockwise Egress Queue",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Egress NACK; BL CCW",
+        "EventCode": "0x28",
+        "EventName": "UNC_R3_TxR_NACK_CCW.BL",
+        "PerPkg": "1",
+        "PublicDescription": "AD CounterClockwise Egress Queue",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Egress NACK; AD CW",
+        "EventCode": "0x26",
+        "EventName": "UNC_R3_TxR_NACK_CW.AD",
+        "PerPkg": "1",
+        "PublicDescription": "AD Clockwise Egress Queue",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Egress NACK; AD CCW",
+        "EventCode": "0x26",
+        "EventName": "UNC_R3_TxR_NACK_CW.AK",
+        "PerPkg": "1",
+        "PublicDescription": "AD CounterClockwise Egress Queue",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Egress NACK; AK CW",
+        "EventCode": "0x26",
+        "EventName": "UNC_R3_TxR_NACK_CW.BL",
+        "PerPkg": "1",
+        "PublicDescription": "BL Clockwise Egress Queue",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; DRS Mes=
sage Class",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; Filter =
for Data Response (DRS).  DRS is generally used to transmit data with coher=
ency.  For example, remote reads and writes, or cache to cache transfers wi=
ll transmit their data using DRS.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; HOM Mes=
sage Class",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; Filter =
for the Home (HOM) message class.  HOM is generally used to send requests, =
request responses, and snoop responses.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; NCB Mes=
sage Class",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; Filter =
for Non-Coherent Broadcast (NCB).  NCB is generally used to transmit data w=
ithout coherency.  For example, non-coherent read data returns.",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; NCS Mes=
sage Class",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; Filter =
for Non-Coherent Standard (NCS).  NCS is commonly used for ?",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; NDR Mes=
sage Class",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; NDR pac=
kets are used to transmit a variety of protocol flits including grants and =
completions (CMP).",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; SNP Mes=
sage Class",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; Filter =
for Snoop (SNP) message class.  SNP is used for outgoing snoops.  Note that=
 snoop responses flow on the HOM message class.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; DRS Message Class",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; Filter for Data Response (DRS).  DRS is generally used to transm=
it data with coherency.  For example, remote reads and writes, or cache to =
cache transfers will transmit their data using DRS.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; HOM Message Class",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; Filter for the Home (HOM) message class.  HOM is generally used =
to send requests, request responses, and snoop responses.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; NCB Message Class",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; Filter for Non-Coherent Broadcast (NCB).  NCB is generally used =
to transmit data without coherency.  For example, non-coherent read data re=
turns.",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; NCS Message Class",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; Filter for Non-Coherent Standard (NCS).  NCS is commonly used fo=
r ?",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; NDR Message Class",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; NDR packets are used to transmit a variety of protocol flits inc=
luding grants and completions (CMP).",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; SNP Message Class",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; Filter for Snoop (SNP) message class.  SNP is used for outgoing =
snoops.  Note that snoop responses flow on the HOM message class.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; DRS Mes=
sage Class",
+        "EventCode": "0x39",
+        "EventName": "UNC_R3_VN1_CREDITS_REJECT.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; Filter for =
Data Response (DRS).  DRS is generally used to transmit data with coherency=
.  For example, remote reads and writes, or cache to cache transfers will t=
ransmit their data using DRS.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; HOM Mes=
sage Class",
+        "EventCode": "0x39",
+        "EventName": "UNC_R3_VN1_CREDITS_REJECT.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; Filter for =
the Home (HOM) message class.  HOM is generally used to send requests, requ=
est responses, and snoop responses.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; NCB Mes=
sage Class",
+        "EventCode": "0x39",
+        "EventName": "UNC_R3_VN1_CREDITS_REJECT.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; Filter for =
Non-Coherent Broadcast (NCB).  NCB is generally used to transmit data witho=
ut coherency.  For example, non-coherent read data returns.",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; NCS Mes=
sage Class",
+        "EventCode": "0x39",
+        "EventName": "UNC_R3_VN1_CREDITS_REJECT.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; Filter for =
Non-Coherent Standard (NCS).  NCS is commonly used for ?",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; NDR Mes=
sage Class",
+        "EventCode": "0x39",
+        "EventName": "UNC_R3_VN1_CREDITS_REJECT.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; NDR packets=
 are used to transmit a variety of protocol flits including grants and comp=
letions (CMP).",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; SNP Mes=
sage Class",
+        "EventCode": "0x39",
+        "EventName": "UNC_R3_VN1_CREDITS_REJECT.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; Filter for =
Snoop (SNP) message class.  SNP is used for outgoing snoops.  Note that sno=
op responses flow on the HOM message class.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Used; DRS Message Class",
+        "EventCode": "0x38",
+        "EventName": "UNC_R3_VN1_CREDITS_USED.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; Filter for Data Response (DRS).  DRS is generally used to transm=
it data with coherency.  For example, remote reads and writes, or cache to =
cache transfers will transmit their data using DRS.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Used; HOM Message Class",
+        "EventCode": "0x38",
+        "EventName": "UNC_R3_VN1_CREDITS_USED.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; Filter for the Home (HOM) message class.  HOM is generally used =
to send requests, request responses, and snoop responses.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Used; NCB Message Class",
+        "EventCode": "0x38",
+        "EventName": "UNC_R3_VN1_CREDITS_USED.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; Filter for Non-Coherent Broadcast (NCB).  NCB is generally used =
to transmit data without coherency.  For example, non-coherent read data re=
turns.",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Used; NCS Message Class",
+        "EventCode": "0x38",
+        "EventName": "UNC_R3_VN1_CREDITS_USED.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; Filter for Non-Coherent Standard (NCS).  NCS is commonly used fo=
r ?",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Used; NDR Message Class",
+        "EventCode": "0x38",
+        "EventName": "UNC_R3_VN1_CREDITS_USED.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; NDR packets are used to transmit a variety of protocol flits inc=
luding grants and completions (CMP).",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Used; SNP Message Class",
+        "EventCode": "0x38",
+        "EventName": "UNC_R3_VN1_CREDITS_USED.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; Filter for Snoop (SNP) message class.  SNP is used for outgoing =
snoops.  Note that snoop responses flow on the HOM message class.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA credit Acquisitions",
+        "EventCode": "0x33",
+        "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED",
+        "PerPkg": "1",
+        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credits from the VN0 pool.  =
Note that a single packet may require multiple flit buffers (i.e. when data=
 is being transferred).  Therefore, this event will increment by the number=
 of credits acquired in each cycle.  Filtering based on message class is no=
t provided.  One can count the number of packets transferred in a given mes=
sage class using an qfclk event.",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA credit Acquisitions; HOM Message Class",
+        "EventCode": "0x33",
+        "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED.AD",
+        "PerPkg": "1",
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
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA credit Acquisitions; HOM Message Class",
+        "EventCode": "0x33",
+        "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED.BL",
+        "PerPkg": "1",
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
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; DRS Message Class",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; Filter for Data Response (DRS).  DRS =
is generally used to transmit data with coherency.  For example, remote rea=
ds and writes, or cache to cache transfers will transmit their data using D=
RS.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; HOM Message Class",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; Filter for the Home (HOM) message cla=
ss.  HOM is generally used to send requests, request responses, and snoop r=
esponses.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; NCB Message Class",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; Filter for Non-Coherent Broadcast (NC=
B).  NCB is generally used to transmit data without coherency.  For example=
, non-coherent read data returns.",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; NCS Message Class",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; Filter for Non-Coherent Standard (NCS=
).",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; NDR Message Class",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; NDR packets are used to transmit a va=
riety of protocol flits including grants and completions (CMP).",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; SNP Message Class",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; Filter for Snoop (SNP) message class.=
  SNP is used for outgoing snoops.  Note that snoop responses flow on the H=
OM message class.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Cycles with no VNA credits available",
+        "EventCode": "0x31",
+        "EventName": "UNC_R3_VNA_CREDIT_CYCLES_OUT",
+        "PerPkg": "1",
+        "PublicDescription": "Number of QPI uclk cycles when the transmitt=
ed has no VNA credits available and therefore cannot send any requests on t=
his channel.  Note that this does not mean that no flits can be transmitted=
, as those holding VN0 credits will still (potentially) be able to transmit=
.  Generally it is the goal of the uncore that VNA credits should not run o=
ut, as this can substantially throttle back useful QPI bandwidth.",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Cycles with 1 or more VNA credits in use",
+        "EventCode": "0x32",
+        "EventName": "UNC_R3_VNA_CREDIT_CYCLES_USED",
+        "PerPkg": "1",
+        "PublicDescription": "Number of QPI uclk cycles with one or more V=
NA credits in use.  This event can be used in conjunction with the VNA In-U=
se Accumulator to calculate the average number of used VNA credits.",
+        "Unit": "R3QPI"
+    },
+    {
+        "EventName": "UNC_U_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "UBOX"
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
+        "BriefDescription": "VLW Received",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.INT_PRIO",
+        "PerPkg": "1",
+        "PublicDescription": "Virtual Logical Wire (legacy) message were r=
eceived from Uncore.   Specify the thread to filter on using NCUPMONCTRLGLC=
TR.ThreadID.",
+        "UMask": "0x10",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "VLW Received",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.IPI_RCVD",
+        "PerPkg": "1",
+        "PublicDescription": "Virtual Logical Wire (legacy) message were r=
eceived from Uncore.   Specify the thread to filter on using NCUPMONCTRLGLC=
TR.ThreadID.",
+        "UMask": "0x4",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "VLW Received",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.MSI_RCVD",
+        "PerPkg": "1",
+        "PublicDescription": "Virtual Logical Wire (legacy) message were r=
eceived from Uncore.   Specify the thread to filter on using NCUPMONCTRLGLC=
TR.ThreadID.",
+        "UMask": "0x2",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "VLW Received",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.VLW_RCVD",
+        "PerPkg": "1",
+        "PublicDescription": "Virtual Logical Wire (legacy) message were r=
eceived from Uncore.   Specify the thread to filter on using NCUPMONCTRLGLC=
TR.ThreadID.",
+        "UMask": "0x1",
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
+        "BriefDescription": "IDI Lock/SplitLock Cycles",
+        "EventCode": "0x44",
+        "EventName": "UNC_U_LOCK_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times an IDI Lock/SplitLock sequen=
ce was started",
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
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-io.json b/tools/=
perf/pmu-events/arch/x86/ivytown/uncore-io.json
new file mode 100644
index 000000000000..5887e6ebcfa8
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-io.json
@@ -0,0 +1,549 @@
+[
+    {
+        "BriefDescription": "Number of uclks in domain",
+        "EventCode": "0x1",
+        "EventName": "UNC_R2_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of uclks in the R2PCIe ucl=
k domain.  This could be slightly different than the count in the Ubox beca=
use of enable/freeze delays.  However, because the R2PCIe is close to the U=
box, they generally should not diverge by more than a handful of cycles.",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credit Acquired; DRS",
+        "EventCode": "0x33",
+        "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of credits that are acquir=
ed in the R2PCIe agent for sending transactions into the IIO on either NCB =
or NCS are in use.  Transactions from the BL ring going into the IIO Agent =
must first acquire a credit.  These credits are for either the NCB or NCS m=
essage classes.  NCB, or non-coherent bypass messages are used to transmit =
data without coherency (and are common).  NCS is used for reads to PCIe (an=
d should be used sparingly).; Credits to the IIO for the DRS message class.=
",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credit Acquired; NCB",
+        "EventCode": "0x33",
+        "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of credits that are acquir=
ed in the R2PCIe agent for sending transactions into the IIO on either NCB =
or NCS are in use.  Transactions from the BL ring going into the IIO Agent =
must first acquire a credit.  These credits are for either the NCB or NCS m=
essage classes.  NCB, or non-coherent bypass messages are used to transmit =
data without coherency (and are common).  NCS is used for reads to PCIe (an=
d should be used sparingly).; Credits to the IIO for the NCB message class.=
",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credit Acquired; NCS",
+        "EventCode": "0x33",
+        "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of credits that are acquir=
ed in the R2PCIe agent for sending transactions into the IIO on either NCB =
or NCS are in use.  Transactions from the BL ring going into the IIO Agent =
must first acquire a credit.  These credits are for either the NCB or NCS m=
essage classes.  NCB, or non-coherent bypass messages are used to transmit =
data without coherency (and are common).  NCS is used for reads to PCIe (an=
d should be used sparingly).; Credits to the IIO for the NCS message class.=
",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Failed to Acquire a Credit; DRS",
+        "EventCode": "0x34",
+        "EventName": "UNC_R2_IIO_CREDITS_REJECT.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that a request pe=
nding in the BL Ingress attempted to acquire either a NCB or NCS credit to =
transmit into the IIO, but was rejected because no credits were available. =
 NCB, or non-coherent bypass messages are used to transmit data without coh=
erency (and are common).  NCS is used for reads to PCIe (and should be used=
 sparingly).; Credits to the IIO for the DRS message class.",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credits in Use; DRS",
+        "EventCode": "0x32",
+        "EventName": "UNC_R2_IIO_CREDITS_USED.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when one or more=
 credits in the R2PCIe agent for sending transactions into the IIO on eithe=
r NCB or NCS are in use.  Transactions from the BL ring going into the IIO =
Agent must first acquire a credit.  These credits are for either the NCB or=
 NCS message classes.  NCB, or non-coherent bypass messages are used to tra=
nsmit data without coherency (and are common).  NCS is used for reads to PC=
Ie (and should be used sparingly).; Credits to the IIO for the DRS message =
class.",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credits in Use; NCB",
+        "EventCode": "0x32",
+        "EventName": "UNC_R2_IIO_CREDITS_USED.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when one or more=
 credits in the R2PCIe agent for sending transactions into the IIO on eithe=
r NCB or NCS are in use.  Transactions from the BL ring going into the IIO =
Agent must first acquire a credit.  These credits are for either the NCB or=
 NCS message classes.  NCB, or non-coherent bypass messages are used to tra=
nsmit data without coherency (and are common).  NCS is used for reads to PC=
Ie (and should be used sparingly).; Credits to the IIO for the NCB message =
class.",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credits in Use; NCS",
+        "EventCode": "0x32",
+        "EventName": "UNC_R2_IIO_CREDITS_USED.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when one or more=
 credits in the R2PCIe agent for sending transactions into the IIO on eithe=
r NCB or NCS are in use.  Transactions from the BL ring going into the IIO =
Agent must first acquire a credit.  These credits are for either the NCB or=
 NCS message classes.  NCB, or non-coherent bypass messages are used to tra=
nsmit data without coherency (and are common).  NCS is used for reads to PC=
Ie (and should be used sparingly).; Credits to the IIO for the NCS message =
class.",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Counterclockwise",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xcc",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Even =
on VRing 0",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CCW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 0.",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Odd o=
n VRing 0",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CCW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 0.",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Even =
on VRing 1",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CCW_VR1_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 1.",
+        "UMask": "0x40",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Odd o=
n VRing 1",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CCW_VR1_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 1.",
+        "UMask": "0x80",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Clockwise",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x33",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Clockwise and Even on VRin=
g 0",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 0.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Clockwise and Odd on VRing=
 0",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 0.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Clockwise and Even on VRin=
g 1",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CW_VR1_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 1.",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Clockwise and Odd on VRing=
 1",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CW_VR1_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 1.",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Counterclockwise",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xcc",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Even =
on VRing 0",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CCW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 0.",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Odd o=
n VRing 0",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CCW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 0.",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Even =
on VRing 1",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CCW_VR1_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 1.",
+        "UMask": "0x40",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Odd o=
n VRing 1",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CCW_VR1_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 1.",
+        "UMask": "0x80",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Clockwise",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x33",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Clockwise and Even on VRin=
g 0",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 0.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Clockwise and Odd on VRing=
 0",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 0.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Clockwise and Even on VRin=
g 1",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CW_VR1_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 1.",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Clockwise and Odd on VRing=
 1",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CW_VR1_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 1.",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Counterclockwise",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xcc",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Even =
on VRing 0",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CCW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 0.",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Odd o=
n VRing 0",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CCW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 0.",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Even =
on VRing 1",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CCW_VR1_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 1.",
+        "UMask": "0x40",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Odd o=
n VRing 1",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CCW_VR1_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 1.",
+        "UMask": "0x80",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Clockwise",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x33",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Clockwise and Even on VRin=
g 0",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 0.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Clockwise and Odd on VRing=
 0",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 0.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Clockwise and Even on VRin=
g 1",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CW_VR1_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 1.",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Clockwise and Odd on VRing=
 1",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CW_VR1_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 1.",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 IV Ring in Use; Any",
+        "EventCode": "0xA",
+        "EventName": "UNC_R2_RING_IV_USED.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  The IV ring is unidirectional.  Whether UP or=
 DN is used is dependent on the system programming.  Thereofore, one should=
 generally set both the UP and DN bits for a given polarity (or both) at a =
given time.; Filters any polarity",
+        "UMask": "0xff",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 IV Ring in Use; Counterclockwise",
+        "EventCode": "0xa",
+        "EventName": "UNC_R2_RING_IV_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  The IV ring is unidirectional.  Whether UP or=
 DN is used is dependent on the system programming.  Thereofore, one should=
 generally set both the UP and DN bits for a given polarity (or both) at a =
given time.; Filters for Counterclockwise polarity",
+        "UMask": "0xcc",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 IV Ring in Use; Clockwise",
+        "EventCode": "0xa",
+        "EventName": "UNC_R2_RING_IV_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  The IV ring is unidirectional.  Whether UP or=
 DN is used is dependent on the system programming.  Thereofore, one should=
 generally set both the UP and DN bits for a given polarity (or both) at a =
given time.; Filters for Clockwise polarity",
+        "UMask": "0x33",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "AK Ingress Bounced",
+        "EventCode": "0x12",
+        "EventName": "UNC_R2_RxR_AK_BOUNCES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a request de=
stined for the AK ingress bounced.",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "AK Ingress Bounced; Counterclockwise",
+        "EventCode": "0x12",
+        "EventName": "UNC_R2_RxR_AK_BOUNCES.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a request de=
stined for the AK ingress bounced.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "AK Ingress Bounced; Clockwise",
+        "EventCode": "0x12",
+        "EventName": "UNC_R2_RxR_AK_BOUNCES.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a request de=
stined for the AK ingress bounced.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; NCB",
+        "EventCode": "0x10",
+        "EventName": "UNC_R2_RxR_CYCLES_NE.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Ingress is not empty.  This tracks one of the three rings that are used by =
the R2PCIe agent.  This can be used in conjunction with the R2PCIe Ingress =
Occupancy Accumulator event in order to calculate average queue occupancy. =
 Multiple ingress buffers can be tracked at a given time using multiple cou=
nters.; NCB Ingress Queue",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; NCS",
+        "EventCode": "0x10",
+        "EventName": "UNC_R2_RxR_CYCLES_NE.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Ingress is not empty.  This tracks one of the three rings that are used by =
the R2PCIe agent.  This can be used in conjunction with the R2PCIe Ingress =
Occupancy Accumulator event in order to calculate average queue occupancy. =
 Multiple ingress buffers can be tracked at a given time using multiple cou=
nters.; NCS Ingress Queue",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; NCB",
+        "EventCode": "0x11",
+        "EventName": "UNC_R2_RxR_INSERTS.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the R2=
PCIe Ingress.  This tracks one of the three rings that are used by the R2PC=
Ie agent.  This can be used in conjunction with the R2PCIe Ingress Occupanc=
y Accumulator event in order to calculate average queue latency.  Multiple =
ingress buffers can be tracked at a given time using multiple counters.; NC=
B Ingress Queue",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; NCS",
+        "EventCode": "0x11",
+        "EventName": "UNC_R2_RxR_INSERTS.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the R2=
PCIe Ingress.  This tracks one of the three rings that are used by the R2PC=
Ie agent.  This can be used in conjunction with the R2PCIe Ingress Occupanc=
y Accumulator event in order to calculate average queue latency.  Multiple =
ingress buffers can be tracked at a given time using multiple counters.; NC=
S Ingress Queue",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy Accumulator; DRS",
+        "EventCode": "0x13",
+        "EventName": "UNC_R2_RxR_OCCUPANCY.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of a given R2PCIe =
Ingress queue in each cycles.  This tracks one of the three ring Ingress bu=
ffers.  This can be used with the R2PCIe Ingress Not Empty event to calcula=
te average occupancy or the R2PCIe Ingress Allocations event in order to ca=
lculate average queuing latency.; DRS Ingress Queue",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Full; AD",
+        "EventCode": "0x25",
+        "EventName": "UNC_R2_TxR_CYCLES_FULL.AD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress buffer is full.; AD Egress Queue",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Full; AK",
+        "EventCode": "0x25",
+        "EventName": "UNC_R2_TxR_CYCLES_FULL.AK",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress buffer is full.; AK Egress Queue",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Full; BL",
+        "EventCode": "0x25",
+        "EventName": "UNC_R2_TxR_CYCLES_FULL.BL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress buffer is full.; BL Egress Queue",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Not Empty; AD",
+        "EventCode": "0x23",
+        "EventName": "UNC_R2_TxR_CYCLES_NE.AD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress is not empty.  This tracks one of the three rings that are used by t=
he R2PCIe agent.  This can be used in conjunction with the R2PCIe Egress Oc=
cupancy Accumulator event in order to calculate average queue occupancy.  O=
nly a single Egress queue can be tracked at any given time.  It is not poss=
ible to filter based on direction or polarity.; AD Egress Queue",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Not Empty; AK",
+        "EventCode": "0x23",
+        "EventName": "UNC_R2_TxR_CYCLES_NE.AK",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress is not empty.  This tracks one of the three rings that are used by t=
he R2PCIe agent.  This can be used in conjunction with the R2PCIe Egress Oc=
cupancy Accumulator event in order to calculate average queue occupancy.  O=
nly a single Egress queue can be tracked at any given time.  It is not poss=
ible to filter based on direction or polarity.; AK Egress Queue",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Not Empty; BL",
+        "EventCode": "0x23",
+        "EventName": "UNC_R2_TxR_CYCLES_NE.BL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress is not empty.  This tracks one of the three rings that are used by t=
he R2PCIe agent.  This can be used in conjunction with the R2PCIe Egress Oc=
cupancy Accumulator event in order to calculate average queue occupancy.  O=
nly a single Egress queue can be tracked at any given time.  It is not poss=
ible to filter based on direction or polarity.; BL Egress Queue",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; AD CCW",
+        "EventCode": "0x28",
+        "EventName": "UNC_R2_TxR_NACK_CCW.AD",
+        "PerPkg": "1",
+        "PublicDescription": "AD CounterClockwise Egress Queue",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; AK CCW",
+        "EventCode": "0x28",
+        "EventName": "UNC_R2_TxR_NACK_CCW.AK",
+        "PerPkg": "1",
+        "PublicDescription": "AK CounterClockwise Egress Queue",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; BL CCW",
+        "EventCode": "0x28",
+        "EventName": "UNC_R2_TxR_NACK_CCW.BL",
+        "PerPkg": "1",
+        "PublicDescription": "BL CounterClockwise Egress Queue",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CW NACK; AD CW",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACK_CW.AD",
+        "PerPkg": "1",
+        "PublicDescription": "AD Clockwise Egress Queue",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CW NACK; AK CW",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACK_CW.AK",
+        "PerPkg": "1",
+        "PublicDescription": "AK Clockwise Egress Queue",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CW NACK; BL CW",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACK_CW.BL",
+        "PerPkg": "1",
+        "PublicDescription": "BL Clockwise Egress Queue",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-other.json b/too=
ls/perf/pmu-events/arch/x86/ivytown/uncore-other.json
deleted file mode 100644
index af9d14a6d145..000000000000
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-other.json
+++ /dev/null
@@ -1,2174 +0,0 @@
-[
-    {
-        "BriefDescription": "Address Match (Conflict) Count; Conflict Merg=
es",
-        "EventCode": "0x17",
-        "EventName": "UNC_I_ADDRESS_MATCH.MERGE_COUNT",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when an inbound w=
rite (from a device to memory or another device) had an address match with =
another request in the write cache.; When two requests to the same address =
from the same source are received back to back, it is possible to merge the=
 two of them together.",
-        "UMask": "0x2",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Address Match (Conflict) Count; Conflict Stal=
ls",
-        "EventCode": "0x17",
-        "EventName": "UNC_I_ADDRESS_MATCH.STALL_COUNT",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when an inbound w=
rite (from a device to memory or another device) had an address match with =
another request in the write cache.; When it is not possible to merge two c=
onflicting requests, a stall event occurs.  This is bad for performance.",
-        "UMask": "0x1",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Write Ack Pending Occupancy; Any Source",
-        "EventCode": "0x14",
-        "EventName": "UNC_I_CACHE_ACK_PENDING_OCCUPANCY.ANY",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the number of writes that have a=
cquired ownership but have not yet returned their data to the uncore.  Thes=
e writes are generally queued up in the switch trying to get to the head of=
 their queues so that they can post their data.  The queue occuapancy incre=
ments when the ACK is received, and decrements when either the data is retu=
rned OR a tickle is received and ownership is released.  Note that a single=
 tickle can result in multiple decrements.; Tracks only those requests that=
 come from the port specified in the IRP_PmonFilter.OrderingQ register.  Th=
is register allows one to select one specific queue.  It is not possible to=
 monitor multiple queues at a time.",
-        "UMask": "0x1",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Write Ack Pending Occupancy; Select Source",
-        "EventCode": "0x14",
-        "EventName": "UNC_I_CACHE_ACK_PENDING_OCCUPANCY.SOURCE",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the number of writes that have a=
cquired ownership but have not yet returned their data to the uncore.  Thes=
e writes are generally queued up in the switch trying to get to the head of=
 their queues so that they can post their data.  The queue occuapancy incre=
ments when the ACK is received, and decrements when either the data is retu=
rned OR a tickle is received and ownership is released.  Note that a single=
 tickle can result in multiple decrements.; Tracks all requests from any so=
urce port.",
-        "UMask": "0x2",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Outstanding Write Ownership Occupancy; Any So=
urce",
-        "EventCode": "0x13",
-        "EventName": "UNC_I_CACHE_OWN_OCCUPANCY.ANY",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the number of writes (and write =
prefetches) that are outstanding in the uncore trying to acquire ownership =
in each cycle.  This can be used with the write transaction count to calcul=
ate the average write latency in the uncore.  The occupancy increments when=
 a write request is issued, and decrements when the data is returned.; Trac=
ks all requests from any source port.",
-        "UMask": "0x1",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Outstanding Write Ownership Occupancy; Select=
 Source",
-        "EventCode": "0x13",
-        "EventName": "UNC_I_CACHE_OWN_OCCUPANCY.SOURCE",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the number of writes (and write =
prefetches) that are outstanding in the uncore trying to acquire ownership =
in each cycle.  This can be used with the write transaction count to calcul=
ate the average write latency in the uncore.  The occupancy increments when=
 a write request is issued, and decrements when the data is returned.; Trac=
ks only those requests that come from the port specified in the IRP_PmonFil=
ter.OrderingQ register.  This register allows one to select one specific qu=
eue.  It is not possible to monitor multiple queues at a time.",
-        "UMask": "0x2",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Outstanding Read Occupancy; Any Source",
-        "EventCode": "0x10",
-        "EventName": "UNC_I_CACHE_READ_OCCUPANCY.ANY",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the number of reads that are out=
standing in the uncore in each cycle.  This can be used with the read trans=
action count to calculate the average read latency in the uncore.  The occu=
pancy increments when a read request is issued, and decrements when the dat=
a is returned.; Tracks all requests from any source port.",
-        "UMask": "0x1",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Outstanding Read Occupancy; Select Source",
-        "EventCode": "0x10",
-        "EventName": "UNC_I_CACHE_READ_OCCUPANCY.SOURCE",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the number of reads that are out=
standing in the uncore in each cycle.  This can be used with the read trans=
action count to calculate the average read latency in the uncore.  The occu=
pancy increments when a read request is issued, and decrements when the dat=
a is returned.; Tracks only those requests that come from the port specifie=
d in the IRP_PmonFilter.OrderingQ register.  This register allows one to se=
lect one specific queue.  It is not possible to monitor multiple queues at =
a time.",
-        "UMask": "0x2",
-        "Unit": "IRP"
-    },
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
-        "BriefDescription": "Outstanding Write Occupancy; Any Source",
-        "EventCode": "0x11",
-        "EventName": "UNC_I_CACHE_WRITE_OCCUPANCY.ANY",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the number of writes (and write =
prefetches)  that are outstanding in the uncore in each cycle.  This can be=
 used with the transaction count event to calculate the average latency in =
the uncore.  The occupancy increments when the ownership fetch/prefetch is =
issued, and decrements the data is returned to the uncore.; Tracks all requ=
ests from any source port.",
-        "UMask": "0x1",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Outstanding Write Occupancy; Select Source",
-        "EventCode": "0x11",
-        "EventName": "UNC_I_CACHE_WRITE_OCCUPANCY.SOURCE",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the number of writes (and write =
prefetches)  that are outstanding in the uncore in each cycle.  This can be=
 used with the transaction count event to calculate the average latency in =
the uncore.  The occupancy increments when the ownership fetch/prefetch is =
issued, and decrements the data is returned to the uncore.; Tracks only tho=
se requests that come from the port specified in the IRP_PmonFilter.Orderin=
gQ register.  This register allows one to select one specific queue.  It is=
 not possible to monitor multiple queues at a time.",
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
-        "EventCode": "0xb",
-        "EventName": "UNC_I_RxR_AK_CYCLES_FULL",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the AK Ingr=
ess is full.  This queue is where the IRP receives responses from R2PCIe (t=
he ring).",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "AK Ingress Occupancy",
-        "EventCode": "0xa",
-        "EventName": "UNC_I_RxR_AK_INSERTS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the AK=
 Ingress.  This queue is where the IRP receives responses from R2PCIe (the =
ring).",
-        "Unit": "IRP"
-    },
-    {
-        "EventCode": "0xc",
-        "EventName": "UNC_I_RxR_AK_OCCUPANCY",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of the AK Ingress =
in each cycles.  This queue is where the IRP receives responses from R2PCIe=
 (the ring).",
-        "Unit": "IRP"
-    },
-    {
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
-        "BriefDescription": "Tickle Count; Ownership Lost",
-        "EventCode": "0x16",
-        "EventName": "UNC_I_TICKLES.LOST_OWNERSHIP",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of tickles that are receiv=
ed.  This is for both explicit (from Cbo) and implicit (internal conflict) =
tickles.; Tracks the number of requests that lost ownership as a result of =
a tickle.  When a tickle comes in, if the request is not at the head of the=
 queue in the switch, then that request as well as any requests behind it i=
n the switch queue will lose ownership and have to re-acquire it later when=
 they get to the head of the queue.  This will therefore track the number o=
f requests that lost ownership and not just the number of tickles.",
-        "UMask": "0x1",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Tickle Count; Data Returned",
-        "EventCode": "0x16",
-        "EventName": "UNC_I_TICKLES.TOP_OF_QUEUE",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of tickles that are receiv=
ed.  This is for both explicit (from Cbo) and implicit (internal conflict) =
tickles.; Tracks the number of cases when a tickle was received but the req=
uests was at the head of the queue in the switch.  In this case, data is re=
turned rather than releasing ownership.",
-        "UMask": "0x2",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Inbound Transaction Count: Read Prefetches",
-        "EventCode": "0x15",
-        "EventName": "UNC_I_TRANSACTIONS.PD_PREFETCHES",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.",
-        "UMask": "0x4",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Inbound Transaction Count; Read Prefetches",
-        "EventCode": "0x15",
-        "EventName": "UNC_I_TRANSACTIONS.RD_PREFETCHES",
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
-        "EventCode": "0x15",
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
-        "EventCode": "0x15",
-        "EventName": "UNC_I_TRANSACTIONS.WRITES",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Trackes only write requests.=
  Each write request should have a prefetch, so there is no need to explici=
tly track these requests.  For writes that are tickled and have to retry, t=
he counter will be incremented for each retry.",
-        "UMask": "0x2",
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
-        "EventCode": "0xe",
-        "EventName": "UNC_I_TxR_DATA_INSERTS_NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of requests issued to the =
switch (towards the devices).",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Outbound Read Requests",
-        "EventCode": "0xf",
-        "EventName": "UNC_I_TxR_DATA_INSERTS_NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of requests issued to the =
switch (towards the devices).",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Outbound Request Queue Occupancy",
-        "EventCode": "0xd",
-        "EventName": "UNC_I_TxR_REQUEST_OCCUPANCY",
-        "PerPkg": "1",
-        "PublicDescription": "Accumultes the number of outstanding outboun=
d requests from the IRP to the switch (towards the devices).  This can be u=
sed in conjuection with the allocations event in order to calculate average=
 latency of outbound requests.",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Write Ordering Stalls",
-        "EventCode": "0x1a",
-        "EventName": "UNC_I_WRITE_ORDERING_STALL_CYCLES",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when there are p=
ending write ACK's in the switch but the switch->IRP pipeline is not utiliz=
ed.",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Number of uclks in domain",
-        "EventCode": "0x1",
-        "EventName": "UNC_R2_CLOCKTICKS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of uclks in the R2PCIe ucl=
k domain.  This could be slightly different than the count in the Ubox beca=
use of enable/freeze delays.  However, because the R2PCIe is close to the U=
box, they generally should not diverge by more than a handful of cycles.",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2PCIe IIO Credit Acquired; DRS",
-        "EventCode": "0x33",
-        "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.DRS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of credits that are acquir=
ed in the R2PCIe agent for sending transactions into the IIO on either NCB =
or NCS are in use.  Transactions from the BL ring going into the IIO Agent =
must first acquire a credit.  These credits are for either the NCB or NCS m=
essage classes.  NCB, or non-coherent bypass messages are used to transmit =
data without coherency (and are common).  NCS is used for reads to PCIe (an=
d should be used sparingly).; Credits to the IIO for the DRS message class.=
",
-        "UMask": "0x8",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2PCIe IIO Credit Acquired; NCB",
-        "EventCode": "0x33",
-        "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of credits that are acquir=
ed in the R2PCIe agent for sending transactions into the IIO on either NCB =
or NCS are in use.  Transactions from the BL ring going into the IIO Agent =
must first acquire a credit.  These credits are for either the NCB or NCS m=
essage classes.  NCB, or non-coherent bypass messages are used to transmit =
data without coherency (and are common).  NCS is used for reads to PCIe (an=
d should be used sparingly).; Credits to the IIO for the NCB message class.=
",
-        "UMask": "0x10",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2PCIe IIO Credit Acquired; NCS",
-        "EventCode": "0x33",
-        "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of credits that are acquir=
ed in the R2PCIe agent for sending transactions into the IIO on either NCB =
or NCS are in use.  Transactions from the BL ring going into the IIO Agent =
must first acquire a credit.  These credits are for either the NCB or NCS m=
essage classes.  NCB, or non-coherent bypass messages are used to transmit =
data without coherency (and are common).  NCS is used for reads to PCIe (an=
d should be used sparingly).; Credits to the IIO for the NCS message class.=
",
-        "UMask": "0x20",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2PCIe IIO Failed to Acquire a Credit; DRS",
-        "EventCode": "0x34",
-        "EventName": "UNC_R2_IIO_CREDITS_REJECT.DRS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that a request pe=
nding in the BL Ingress attempted to acquire either a NCB or NCS credit to =
transmit into the IIO, but was rejected because no credits were available. =
 NCB, or non-coherent bypass messages are used to transmit data without coh=
erency (and are common).  NCS is used for reads to PCIe (and should be used=
 sparingly).; Credits to the IIO for the DRS message class.",
-        "UMask": "0x8",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2PCIe IIO Credits in Use; DRS",
-        "EventCode": "0x32",
-        "EventName": "UNC_R2_IIO_CREDITS_USED.DRS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when one or more=
 credits in the R2PCIe agent for sending transactions into the IIO on eithe=
r NCB or NCS are in use.  Transactions from the BL ring going into the IIO =
Agent must first acquire a credit.  These credits are for either the NCB or=
 NCS message classes.  NCB, or non-coherent bypass messages are used to tra=
nsmit data without coherency (and are common).  NCS is used for reads to PC=
Ie (and should be used sparingly).; Credits to the IIO for the DRS message =
class.",
-        "UMask": "0x8",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2PCIe IIO Credits in Use; NCB",
-        "EventCode": "0x32",
-        "EventName": "UNC_R2_IIO_CREDITS_USED.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when one or more=
 credits in the R2PCIe agent for sending transactions into the IIO on eithe=
r NCB or NCS are in use.  Transactions from the BL ring going into the IIO =
Agent must first acquire a credit.  These credits are for either the NCB or=
 NCS message classes.  NCB, or non-coherent bypass messages are used to tra=
nsmit data without coherency (and are common).  NCS is used for reads to PC=
Ie (and should be used sparingly).; Credits to the IIO for the NCB message =
class.",
-        "UMask": "0x10",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2PCIe IIO Credits in Use; NCS",
-        "EventCode": "0x32",
-        "EventName": "UNC_R2_IIO_CREDITS_USED.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when one or more=
 credits in the R2PCIe agent for sending transactions into the IIO on eithe=
r NCB or NCS are in use.  Transactions from the BL ring going into the IIO =
Agent must first acquire a credit.  These credits are for either the NCB or=
 NCS message classes.  NCB, or non-coherent bypass messages are used to tra=
nsmit data without coherency (and are common).  NCS is used for reads to PC=
Ie (and should be used sparingly).; Credits to the IIO for the NCS message =
class.",
-        "UMask": "0x20",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AD Ring in Use; Counterclockwise",
-        "EventCode": "0x7",
-        "EventName": "UNC_R2_RING_AD_USED.CCW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xcc",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Even =
on VRing 0",
-        "EventCode": "0x7",
-        "EventName": "UNC_R2_RING_AD_USED.CCW_VR0_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 0.",
-        "UMask": "0x4",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Odd o=
n VRing 0",
-        "EventCode": "0x7",
-        "EventName": "UNC_R2_RING_AD_USED.CCW_VR0_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 0.",
-        "UMask": "0x8",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Even =
on VRing 1",
-        "EventCode": "0x7",
-        "EventName": "UNC_R2_RING_AD_USED.CCW_VR1_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 1.",
-        "UMask": "0x40",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Odd o=
n VRing 1",
-        "EventCode": "0x7",
-        "EventName": "UNC_R2_RING_AD_USED.CCW_VR1_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 1.",
-        "UMask": "0x80",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AD Ring in Use; Clockwise",
-        "EventCode": "0x7",
-        "EventName": "UNC_R2_RING_AD_USED.CW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x33",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AD Ring in Use; Clockwise and Even on VRin=
g 0",
-        "EventCode": "0x7",
-        "EventName": "UNC_R2_RING_AD_USED.CW_VR0_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 0.",
-        "UMask": "0x1",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AD Ring in Use; Clockwise and Odd on VRing=
 0",
-        "EventCode": "0x7",
-        "EventName": "UNC_R2_RING_AD_USED.CW_VR0_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 0.",
-        "UMask": "0x2",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AD Ring in Use; Clockwise and Even on VRin=
g 1",
-        "EventCode": "0x7",
-        "EventName": "UNC_R2_RING_AD_USED.CW_VR1_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 1.",
-        "UMask": "0x10",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AD Ring in Use; Clockwise and Odd on VRing=
 1",
-        "EventCode": "0x7",
-        "EventName": "UNC_R2_RING_AD_USED.CW_VR1_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 1.",
-        "UMask": "0x20",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AK Ring in Use; Counterclockwise",
-        "EventCode": "0x8",
-        "EventName": "UNC_R2_RING_AK_USED.CCW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xcc",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Even =
on VRing 0",
-        "EventCode": "0x8",
-        "EventName": "UNC_R2_RING_AK_USED.CCW_VR0_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 0.",
-        "UMask": "0x4",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Odd o=
n VRing 0",
-        "EventCode": "0x8",
-        "EventName": "UNC_R2_RING_AK_USED.CCW_VR0_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 0.",
-        "UMask": "0x8",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Even =
on VRing 1",
-        "EventCode": "0x8",
-        "EventName": "UNC_R2_RING_AK_USED.CCW_VR1_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 1.",
-        "UMask": "0x40",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Odd o=
n VRing 1",
-        "EventCode": "0x8",
-        "EventName": "UNC_R2_RING_AK_USED.CCW_VR1_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 1.",
-        "UMask": "0x80",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AK Ring in Use; Clockwise",
-        "EventCode": "0x8",
-        "EventName": "UNC_R2_RING_AK_USED.CW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x33",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AK Ring in Use; Clockwise and Even on VRin=
g 0",
-        "EventCode": "0x8",
-        "EventName": "UNC_R2_RING_AK_USED.CW_VR0_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 0.",
-        "UMask": "0x1",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AK Ring in Use; Clockwise and Odd on VRing=
 0",
-        "EventCode": "0x8",
-        "EventName": "UNC_R2_RING_AK_USED.CW_VR0_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 0.",
-        "UMask": "0x2",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AK Ring in Use; Clockwise and Even on VRin=
g 1",
-        "EventCode": "0x8",
-        "EventName": "UNC_R2_RING_AK_USED.CW_VR1_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 1.",
-        "UMask": "0x10",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AK Ring in Use; Clockwise and Odd on VRing=
 1",
-        "EventCode": "0x8",
-        "EventName": "UNC_R2_RING_AK_USED.CW_VR1_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 1.",
-        "UMask": "0x20",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 BL Ring in Use; Counterclockwise",
-        "EventCode": "0x9",
-        "EventName": "UNC_R2_RING_BL_USED.CCW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xcc",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Even =
on VRing 0",
-        "EventCode": "0x9",
-        "EventName": "UNC_R2_RING_BL_USED.CCW_VR0_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 0.",
-        "UMask": "0x4",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Odd o=
n VRing 0",
-        "EventCode": "0x9",
-        "EventName": "UNC_R2_RING_BL_USED.CCW_VR0_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 0.",
-        "UMask": "0x8",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Even =
on VRing 1",
-        "EventCode": "0x9",
-        "EventName": "UNC_R2_RING_BL_USED.CCW_VR1_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 1.",
-        "UMask": "0x40",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Odd o=
n VRing 1",
-        "EventCode": "0x9",
-        "EventName": "UNC_R2_RING_BL_USED.CCW_VR1_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 1.",
-        "UMask": "0x80",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 BL Ring in Use; Clockwise",
-        "EventCode": "0x9",
-        "EventName": "UNC_R2_RING_BL_USED.CW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x33",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 BL Ring in Use; Clockwise and Even on VRin=
g 0",
-        "EventCode": "0x9",
-        "EventName": "UNC_R2_RING_BL_USED.CW_VR0_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 0.",
-        "UMask": "0x1",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 BL Ring in Use; Clockwise and Odd on VRing=
 0",
-        "EventCode": "0x9",
-        "EventName": "UNC_R2_RING_BL_USED.CW_VR0_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 0.",
-        "UMask": "0x2",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 BL Ring in Use; Clockwise and Even on VRin=
g 1",
-        "EventCode": "0x9",
-        "EventName": "UNC_R2_RING_BL_USED.CW_VR1_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 1.",
-        "UMask": "0x10",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 BL Ring in Use; Clockwise and Odd on VRing=
 1",
-        "EventCode": "0x9",
-        "EventName": "UNC_R2_RING_BL_USED.CW_VR1_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 1.",
-        "UMask": "0x20",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 IV Ring in Use; Any",
-        "EventCode": "0xA",
-        "EventName": "UNC_R2_RING_IV_USED.ANY",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  The IV ring is unidirectional.  Whether UP or=
 DN is used is dependent on the system programming.  Thereofore, one should=
 generally set both the UP and DN bits for a given polarity (or both) at a =
given time.; Filters any polarity",
-        "UMask": "0xff",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 IV Ring in Use; Counterclockwise",
-        "EventCode": "0xa",
-        "EventName": "UNC_R2_RING_IV_USED.CCW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  The IV ring is unidirectional.  Whether UP or=
 DN is used is dependent on the system programming.  Thereofore, one should=
 generally set both the UP and DN bits for a given polarity (or both) at a =
given time.; Filters for Counterclockwise polarity",
-        "UMask": "0xcc",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 IV Ring in Use; Clockwise",
-        "EventCode": "0xa",
-        "EventName": "UNC_R2_RING_IV_USED.CW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  The IV ring is unidirectional.  Whether UP or=
 DN is used is dependent on the system programming.  Thereofore, one should=
 generally set both the UP and DN bits for a given polarity (or both) at a =
given time.; Filters for Clockwise polarity",
-        "UMask": "0x33",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "AK Ingress Bounced",
-        "EventCode": "0x12",
-        "EventName": "UNC_R2_RxR_AK_BOUNCES",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when a request de=
stined for the AK ingress bounced.",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "AK Ingress Bounced; Counterclockwise",
-        "EventCode": "0x12",
-        "EventName": "UNC_R2_RxR_AK_BOUNCES.CCW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when a request de=
stined for the AK ingress bounced.",
-        "UMask": "0x2",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "AK Ingress Bounced; Clockwise",
-        "EventCode": "0x12",
-        "EventName": "UNC_R2_RxR_AK_BOUNCES.CW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when a request de=
stined for the AK ingress bounced.",
-        "UMask": "0x1",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Ingress Cycles Not Empty; NCB",
-        "EventCode": "0x10",
-        "EventName": "UNC_R2_RxR_CYCLES_NE.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Ingress is not empty.  This tracks one of the three rings that are used by =
the R2PCIe agent.  This can be used in conjunction with the R2PCIe Ingress =
Occupancy Accumulator event in order to calculate average queue occupancy. =
 Multiple ingress buffers can be tracked at a given time using multiple cou=
nters.; NCB Ingress Queue",
-        "UMask": "0x10",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Ingress Cycles Not Empty; NCS",
-        "EventCode": "0x10",
-        "EventName": "UNC_R2_RxR_CYCLES_NE.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Ingress is not empty.  This tracks one of the three rings that are used by =
the R2PCIe agent.  This can be used in conjunction with the R2PCIe Ingress =
Occupancy Accumulator event in order to calculate average queue occupancy. =
 Multiple ingress buffers can be tracked at a given time using multiple cou=
nters.; NCS Ingress Queue",
-        "UMask": "0x20",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Ingress Allocations; NCB",
-        "EventCode": "0x11",
-        "EventName": "UNC_R2_RxR_INSERTS.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the R2=
PCIe Ingress.  This tracks one of the three rings that are used by the R2PC=
Ie agent.  This can be used in conjunction with the R2PCIe Ingress Occupanc=
y Accumulator event in order to calculate average queue latency.  Multiple =
ingress buffers can be tracked at a given time using multiple counters.; NC=
B Ingress Queue",
-        "UMask": "0x10",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Ingress Allocations; NCS",
-        "EventCode": "0x11",
-        "EventName": "UNC_R2_RxR_INSERTS.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the R2=
PCIe Ingress.  This tracks one of the three rings that are used by the R2PC=
Ie agent.  This can be used in conjunction with the R2PCIe Ingress Occupanc=
y Accumulator event in order to calculate average queue latency.  Multiple =
ingress buffers can be tracked at a given time using multiple counters.; NC=
S Ingress Queue",
-        "UMask": "0x20",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Ingress Occupancy Accumulator; DRS",
-        "EventCode": "0x13",
-        "EventName": "UNC_R2_RxR_OCCUPANCY.DRS",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of a given R2PCIe =
Ingress queue in each cycles.  This tracks one of the three ring Ingress bu=
ffers.  This can be used with the R2PCIe Ingress Not Empty event to calcula=
te average occupancy or the R2PCIe Ingress Allocations event in order to ca=
lculate average queuing latency.; DRS Ingress Queue",
-        "UMask": "0x8",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress Cycles Full; AD",
-        "EventCode": "0x25",
-        "EventName": "UNC_R2_TxR_CYCLES_FULL.AD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress buffer is full.; AD Egress Queue",
-        "UMask": "0x1",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress Cycles Full; AK",
-        "EventCode": "0x25",
-        "EventName": "UNC_R2_TxR_CYCLES_FULL.AK",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress buffer is full.; AK Egress Queue",
-        "UMask": "0x2",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress Cycles Full; BL",
-        "EventCode": "0x25",
-        "EventName": "UNC_R2_TxR_CYCLES_FULL.BL",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress buffer is full.; BL Egress Queue",
-        "UMask": "0x4",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress Cycles Not Empty; AD",
-        "EventCode": "0x23",
-        "EventName": "UNC_R2_TxR_CYCLES_NE.AD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress is not empty.  This tracks one of the three rings that are used by t=
he R2PCIe agent.  This can be used in conjunction with the R2PCIe Egress Oc=
cupancy Accumulator event in order to calculate average queue occupancy.  O=
nly a single Egress queue can be tracked at any given time.  It is not poss=
ible to filter based on direction or polarity.; AD Egress Queue",
-        "UMask": "0x1",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress Cycles Not Empty; AK",
-        "EventCode": "0x23",
-        "EventName": "UNC_R2_TxR_CYCLES_NE.AK",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress is not empty.  This tracks one of the three rings that are used by t=
he R2PCIe agent.  This can be used in conjunction with the R2PCIe Egress Oc=
cupancy Accumulator event in order to calculate average queue occupancy.  O=
nly a single Egress queue can be tracked at any given time.  It is not poss=
ible to filter based on direction or polarity.; AK Egress Queue",
-        "UMask": "0x2",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress Cycles Not Empty; BL",
-        "EventCode": "0x23",
-        "EventName": "UNC_R2_TxR_CYCLES_NE.BL",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress is not empty.  This tracks one of the three rings that are used by t=
he R2PCIe agent.  This can be used in conjunction with the R2PCIe Egress Oc=
cupancy Accumulator event in order to calculate average queue occupancy.  O=
nly a single Egress queue can be tracked at any given time.  It is not poss=
ible to filter based on direction or polarity.; BL Egress Queue",
-        "UMask": "0x4",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress CCW NACK; AD CCW",
-        "EventCode": "0x28",
-        "EventName": "UNC_R2_TxR_NACK_CCW.AD",
-        "PerPkg": "1",
-        "PublicDescription": "AD CounterClockwise Egress Queue",
-        "UMask": "0x1",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress CCW NACK; AK CCW",
-        "EventCode": "0x28",
-        "EventName": "UNC_R2_TxR_NACK_CCW.AK",
-        "PerPkg": "1",
-        "PublicDescription": "AK CounterClockwise Egress Queue",
-        "UMask": "0x2",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress CCW NACK; BL CCW",
-        "EventCode": "0x28",
-        "EventName": "UNC_R2_TxR_NACK_CCW.BL",
-        "PerPkg": "1",
-        "PublicDescription": "BL CounterClockwise Egress Queue",
-        "UMask": "0x4",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress CW NACK; AD CW",
-        "EventCode": "0x26",
-        "EventName": "UNC_R2_TxR_NACK_CW.AD",
-        "PerPkg": "1",
-        "PublicDescription": "AD Clockwise Egress Queue",
-        "UMask": "0x1",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress CW NACK; AK CW",
-        "EventCode": "0x26",
-        "EventName": "UNC_R2_TxR_NACK_CW.AK",
-        "PerPkg": "1",
-        "PublicDescription": "AK Clockwise Egress Queue",
-        "UMask": "0x2",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress CW NACK; BL CW",
-        "EventCode": "0x26",
-        "EventName": "UNC_R2_TxR_NACK_CW.BL",
-        "PerPkg": "1",
-        "PublicDescription": "BL Clockwise Egress Queue",
-        "UMask": "0x4",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Number of uclks in domain",
-        "EventCode": "0x1",
-        "EventName": "UNC_R3_CLOCKTICKS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of uclks in the QPI uclk d=
omain.  This could be slightly different than the count in the Ubox because=
 of enable/freeze delays.  However, because the QPI Agent is close to the U=
box, they generally should not diverge by more than a handful of cycles.",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x2c",
-        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO10",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 10",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x2c",
-        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO11",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 11",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x2c",
-        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO12",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 12",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x2c",
-        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO13",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 13",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x2c",
-        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO14",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 14&16",
-        "UMask": "0x40",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x2c",
-        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO8",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 8",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x2c",
-        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO9",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 9",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x2b",
-        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO0",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 0",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x2b",
-        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO1",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 1",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x2b",
-        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO2",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 2",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x2b",
-        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO3",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 3",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x2b",
-        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO4",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 4",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x2b",
-        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO5",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 5",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x2b",
-        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO6",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 6",
-        "UMask": "0x40",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "CBox AD Credits Empty",
-        "EventCode": "0x2b",
-        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO7",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 7",
-        "UMask": "0x80",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "HA/R2 AD Credits Empty",
-        "EventCode": "0x2f",
-        "EventName": "UNC_R3_HA_R2_BL_CREDITS_EMPTY.HA0",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to either HA or=
 R2 on the BL Ring; HA0",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "HA/R2 AD Credits Empty",
-        "EventCode": "0x2f",
-        "EventName": "UNC_R3_HA_R2_BL_CREDITS_EMPTY.HA1",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to either HA or=
 R2 on the BL Ring; HA1",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "HA/R2 AD Credits Empty",
-        "EventCode": "0x2f",
-        "EventName": "UNC_R3_HA_R2_BL_CREDITS_EMPTY.R2_NCB",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to either HA or=
 R2 on the BL Ring; R2 NCB Messages",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "HA/R2 AD Credits Empty",
-        "EventCode": "0x2f",
-        "EventName": "UNC_R3_HA_R2_BL_CREDITS_EMPTY.R2_NCS",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to either HA or=
 R2 on the BL Ring; R2 NCS Messages",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI0 AD Credits Empty",
-        "EventCode": "0x29",
-        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN0_HOM",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN0 HOM Messages",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI0 AD Credits Empty",
-        "EventCode": "0x29",
-        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN0_NDR",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN0 NDR Messages",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI0 AD Credits Empty",
-        "EventCode": "0x29",
-        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN0_SNP",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN0 SNP Messages",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI0 AD Credits Empty",
-        "EventCode": "0x29",
-        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN1_HOM",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN1 HOM Messages",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI0 AD Credits Empty",
-        "EventCode": "0x29",
-        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN1_NDR",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN1 NDR Messages",
-        "UMask": "0x40",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI0 AD Credits Empty",
-        "EventCode": "0x29",
-        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN1_SNP",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN1 SNP Messages",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI0 AD Credits Empty",
-        "EventCode": "0x29",
-        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VNA",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VNA",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI0 BL Credits Empty",
-        "EventCode": "0x2d",
-        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN0_HOM",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VN0 HOM Messages",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI0 BL Credits Empty",
-        "EventCode": "0x2d",
-        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN0_NDR",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VN0 NDR Messages",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI0 BL Credits Empty",
-        "EventCode": "0x2d",
-        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN0_SNP",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VN0 SNP Messages",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI0 BL Credits Empty",
-        "EventCode": "0x2d",
-        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN1_HOM",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VN1 HOM Messages",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI0 BL Credits Empty",
-        "EventCode": "0x2d",
-        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN1_NDR",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VN1 NDR Messages",
-        "UMask": "0x40",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI0 BL Credits Empty",
-        "EventCode": "0x2d",
-        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN1_SNP",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VN1 SNP Messages",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI0 BL Credits Empty",
-        "EventCode": "0x2d",
-        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VNA",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VNA",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI1 AD Credits Empty",
-        "EventCode": "0x2a",
-        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN0_HOM",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VN0 HOM Messages",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI1 AD Credits Empty",
-        "EventCode": "0x2a",
-        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN0_NDR",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VN0 NDR Messages",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI1 AD Credits Empty",
-        "EventCode": "0x2a",
-        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN0_SNP",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VN0 SNP Messages",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI1 AD Credits Empty",
-        "EventCode": "0x2a",
-        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN1_HOM",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VN1 HOM Messages",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI1 AD Credits Empty",
-        "EventCode": "0x2a",
-        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN1_NDR",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VN1 NDR Messages",
-        "UMask": "0x40",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI1 AD Credits Empty",
-        "EventCode": "0x2a",
-        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN1_SNP",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VN1 SNP Messages",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI1 AD Credits Empty",
-        "EventCode": "0x2a",
-        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VNA",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VNA",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI1 BL Credits Empty",
-        "EventCode": "0x2e",
-        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN0_HOM",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN0 HOM Messages",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI1 BL Credits Empty",
-        "EventCode": "0x2e",
-        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN0_NDR",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN0 NDR Messages",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI1 BL Credits Empty",
-        "EventCode": "0x2e",
-        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN0_SNP",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN0 SNP Messages",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI1 BL Credits Empty",
-        "EventCode": "0x2e",
-        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN1_HOM",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN1 HOM Messages",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI1 BL Credits Empty",
-        "EventCode": "0x2e",
-        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN1_NDR",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN1 NDR Messages",
-        "UMask": "0x40",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI1 BL Credits Empty",
-        "EventCode": "0x2e",
-        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN1_SNP",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN1 SNP Messages",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "QPI1 BL Credits Empty",
-        "EventCode": "0x2e",
-        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VNA",
-        "PerPkg": "1",
-        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VNA",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AD Ring in Use; Counterclockwise",
-        "EventCode": "0x7",
-        "EventName": "UNC_R3_RING_AD_USED.CCW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xcc",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AD Ring in Use; Counterclockwise and Even =
on VRing 0",
-        "EventCode": "0x7",
-        "EventName": "UNC_R3_RING_AD_USED.CCW_VR0_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 0.",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AD Ring in Use; Counterclockwise and Odd o=
n VRing 0",
-        "EventCode": "0x7",
-        "EventName": "UNC_R3_RING_AD_USED.CCW_VR0_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 0.",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AD Ring in Use; Clockwise",
-        "EventCode": "0x7",
-        "EventName": "UNC_R3_RING_AD_USED.CW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x33",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AD Ring in Use; Clockwise and Even on VRin=
g 0",
-        "EventCode": "0x7",
-        "EventName": "UNC_R3_RING_AD_USED.CW_VR0_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 0.",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AD Ring in Use; Clockwise and Odd on VRing=
 0",
-        "EventCode": "0x7",
-        "EventName": "UNC_R3_RING_AD_USED.CW_VR0_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 0.",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AK Ring in Use; Counterclockwise",
-        "EventCode": "0x8",
-        "EventName": "UNC_R3_RING_AK_USED.CCW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xcc",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AK Ring in Use; Counterclockwise and Even =
on VRing 0",
-        "EventCode": "0x8",
-        "EventName": "UNC_R3_RING_AK_USED.CCW_VR0_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 0.",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AK Ring in Use; Counterclockwise and Odd o=
n VRing 0",
-        "EventCode": "0x8",
-        "EventName": "UNC_R3_RING_AK_USED.CCW_VR0_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 0.",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AK Ring in Use; Clockwise",
-        "EventCode": "0x8",
-        "EventName": "UNC_R3_RING_AK_USED.CW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x33",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AK Ring in Use; Clockwise and Even on VRin=
g 0",
-        "EventCode": "0x8",
-        "EventName": "UNC_R3_RING_AK_USED.CW_VR0_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 0.",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AK Ring in Use; Clockwise and Odd on VRing=
 0",
-        "EventCode": "0x8",
-        "EventName": "UNC_R3_RING_AK_USED.CW_VR0_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 0.",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 BL Ring in Use; Counterclockwise",
-        "EventCode": "0x9",
-        "EventName": "UNC_R3_RING_BL_USED.CCW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0xcc",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 BL Ring in Use; Counterclockwise and Even =
on VRing 0",
-        "EventCode": "0x9",
-        "EventName": "UNC_R3_RING_BL_USED.CCW_VR0_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 0.",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 BL Ring in Use; Counterclockwise and Odd o=
n VRing 0",
-        "EventCode": "0x9",
-        "EventName": "UNC_R3_RING_BL_USED.CCW_VR0_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 0.",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 BL Ring in Use; Clockwise",
-        "EventCode": "0x9",
-        "EventName": "UNC_R3_RING_BL_USED.CW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x33",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 BL Ring in Use; Clockwise and Even on VRin=
g 0",
-        "EventCode": "0x9",
-        "EventName": "UNC_R3_RING_BL_USED.CW_VR0_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 0.",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 BL Ring in Use; Clockwise and Odd on VRing=
 0",
-        "EventCode": "0x9",
-        "EventName": "UNC_R3_RING_BL_USED.CW_VR0_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 0.",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R2 IV Ring in Use; Any",
-        "EventCode": "0xA",
-        "EventName": "UNC_R3_RING_IV_USED.ANY",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  The IV ring is unidirectional.  Whether UP or=
 DN is used is dependent on the system programming.  Thereofore, one should=
 generally set both the UP and DN bits for a given polarity (or both) at a =
given time.; Filters any polarity",
-        "UMask": "0xff",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R2 IV Ring in Use; Counterclockwise",
-        "EventCode": "0xa",
-        "EventName": "UNC_R3_RING_IV_USED.CCW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  The IV ring is unidirectional.  Whether UP or=
 DN is used is dependent on the system programming.  Thereofore, one should=
 generally set both the UP and DN bits for a given polarity (or both) at a =
given time.; Filters for Counterclockwise polarity",
-        "UMask": "0xcc",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R2 IV Ring in Use; Clockwise",
-        "EventCode": "0xa",
-        "EventName": "UNC_R3_RING_IV_USED.CW",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  The IV ring is unidirectional.  Whether UP or=
 DN is used is dependent on the system programming.  Thereofore, one should=
 generally set both the UP and DN bits for a given polarity (or both) at a =
given time.; Filters for Clockwise polarity",
-        "UMask": "0x33",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "AD Ingress Bypassed",
-        "EventCode": "0x12",
-        "EventName": "UNC_R3_RxR_AD_BYPASSED",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when the AD Ingre=
ss was bypassed and an incoming transaction was bypassed directly across th=
e BGF and into the qfclk domain.",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Ingress Bypassed",
-        "EventCode": "0x12",
-        "EventName": "UNC_R3_RxR_BYPASSED.AD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when the Ingress =
was bypassed and an incoming transaction was bypassed directly across the B=
GF and into the qfclk domain.",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Ingress Cycles Not Empty; HOM",
-        "EventCode": "0x10",
-        "EventName": "UNC_R3_RxR_CYCLES_NE.HOM",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the QPI Ing=
ress is not empty.  This tracks one of the three rings that are used by the=
 QPI agent.  This can be used in conjunction with the QPI Ingress Occupancy=
 Accumulator event in order to calculate average queue occupancy.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.; H=
OM Ingress Queue",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Ingress Cycles Not Empty; NDR",
-        "EventCode": "0x10",
-        "EventName": "UNC_R3_RxR_CYCLES_NE.NDR",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the QPI Ing=
ress is not empty.  This tracks one of the three rings that are used by the=
 QPI agent.  This can be used in conjunction with the QPI Ingress Occupancy=
 Accumulator event in order to calculate average queue occupancy.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.; N=
DR Ingress Queue",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Ingress Cycles Not Empty; SNP",
-        "EventCode": "0x10",
-        "EventName": "UNC_R3_RxR_CYCLES_NE.SNP",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the QPI Ing=
ress is not empty.  This tracks one of the three rings that are used by the=
 QPI agent.  This can be used in conjunction with the QPI Ingress Occupancy=
 Accumulator event in order to calculate average queue occupancy.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.; S=
NP Ingress Queue",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Ingress Allocations; DRS",
-        "EventCode": "0x11",
-        "EventName": "UNC_R3_RxR_INSERTS.DRS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; DRS Ingress=
 Queue",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Ingress Allocations; HOM",
-        "EventCode": "0x11",
-        "EventName": "UNC_R3_RxR_INSERTS.HOM",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; HOM Ingress=
 Queue",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Ingress Allocations; NCB",
-        "EventCode": "0x11",
-        "EventName": "UNC_R3_RxR_INSERTS.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; NCB Ingress=
 Queue",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Ingress Allocations; NCS",
-        "EventCode": "0x11",
-        "EventName": "UNC_R3_RxR_INSERTS.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; NCS Ingress=
 Queue",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Ingress Allocations; NDR",
-        "EventCode": "0x11",
-        "EventName": "UNC_R3_RxR_INSERTS.NDR",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; NDR Ingress=
 Queue",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Ingress Allocations; SNP",
-        "EventCode": "0x11",
-        "EventName": "UNC_R3_RxR_INSERTS.SNP",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; SNP Ingress=
 Queue",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Ingress Occupancy Accumulator; DRS",
-        "EventCode": "0x13",
-        "EventName": "UNC_R3_RxR_OCCUPANCY.DRS",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of a given QPI Ing=
ress queue in each cycles.  This tracks one of the three ring Ingress buffe=
rs.  This can be used with the QPI Ingress Not Empty event to calculate ave=
rage occupancy or the QPI Ingress Allocations event in order to calculate a=
verage queuing latency.; DRS Ingress Queue",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Ingress Occupancy Accumulator; HOM",
-        "EventCode": "0x13",
-        "EventName": "UNC_R3_RxR_OCCUPANCY.HOM",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of a given QPI Ing=
ress queue in each cycles.  This tracks one of the three ring Ingress buffe=
rs.  This can be used with the QPI Ingress Not Empty event to calculate ave=
rage occupancy or the QPI Ingress Allocations event in order to calculate a=
verage queuing latency.; HOM Ingress Queue",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Ingress Occupancy Accumulator; NCB",
-        "EventCode": "0x13",
-        "EventName": "UNC_R3_RxR_OCCUPANCY.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of a given QPI Ing=
ress queue in each cycles.  This tracks one of the three ring Ingress buffe=
rs.  This can be used with the QPI Ingress Not Empty event to calculate ave=
rage occupancy or the QPI Ingress Allocations event in order to calculate a=
verage queuing latency.; NCB Ingress Queue",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Ingress Occupancy Accumulator; NCS",
-        "EventCode": "0x13",
-        "EventName": "UNC_R3_RxR_OCCUPANCY.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of a given QPI Ing=
ress queue in each cycles.  This tracks one of the three ring Ingress buffe=
rs.  This can be used with the QPI Ingress Not Empty event to calculate ave=
rage occupancy or the QPI Ingress Allocations event in order to calculate a=
verage queuing latency.; NCS Ingress Queue",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Ingress Occupancy Accumulator; NDR",
-        "EventCode": "0x13",
-        "EventName": "UNC_R3_RxR_OCCUPANCY.NDR",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of a given QPI Ing=
ress queue in each cycles.  This tracks one of the three ring Ingress buffe=
rs.  This can be used with the QPI Ingress Not Empty event to calculate ave=
rage occupancy or the QPI Ingress Allocations event in order to calculate a=
verage queuing latency.; NDR Ingress Queue",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Ingress Occupancy Accumulator; SNP",
-        "EventCode": "0x13",
-        "EventName": "UNC_R3_RxR_OCCUPANCY.SNP",
-        "PerPkg": "1",
-        "PublicDescription": "Accumulates the occupancy of a given QPI Ing=
ress queue in each cycles.  This tracks one of the three ring Ingress buffe=
rs.  This can be used with the QPI Ingress Not Empty event to calculate ave=
rage occupancy or the QPI Ingress Allocations event in order to calculate a=
verage queuing latency.; SNP Ingress Queue",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Egress NACK; AK CCW",
-        "EventCode": "0x28",
-        "EventName": "UNC_R3_TxR_NACK_CCW.AD",
-        "PerPkg": "1",
-        "PublicDescription": "BL CounterClockwise Egress Queue",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Egress NACK; BL CW",
-        "EventCode": "0x28",
-        "EventName": "UNC_R3_TxR_NACK_CCW.AK",
-        "PerPkg": "1",
-        "PublicDescription": "AD Clockwise Egress Queue",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Egress NACK; BL CCW",
-        "EventCode": "0x28",
-        "EventName": "UNC_R3_TxR_NACK_CCW.BL",
-        "PerPkg": "1",
-        "PublicDescription": "AD CounterClockwise Egress Queue",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Egress NACK; AD CW",
-        "EventCode": "0x26",
-        "EventName": "UNC_R3_TxR_NACK_CW.AD",
-        "PerPkg": "1",
-        "PublicDescription": "AD Clockwise Egress Queue",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Egress NACK; AD CCW",
-        "EventCode": "0x26",
-        "EventName": "UNC_R3_TxR_NACK_CW.AK",
-        "PerPkg": "1",
-        "PublicDescription": "AD CounterClockwise Egress Queue",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Egress NACK; AK CW",
-        "EventCode": "0x26",
-        "EventName": "UNC_R3_TxR_NACK_CW.BL",
-        "PerPkg": "1",
-        "PublicDescription": "BL Clockwise Egress Queue",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; DRS Mes=
sage Class",
-        "EventCode": "0x37",
-        "EventName": "UNC_R3_VN0_CREDITS_REJECT.DRS",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; Filter =
for Data Response (DRS).  DRS is generally used to transmit data with coher=
ency.  For example, remote reads and writes, or cache to cache transfers wi=
ll transmit their data using DRS.",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; HOM Mes=
sage Class",
-        "EventCode": "0x37",
-        "EventName": "UNC_R3_VN0_CREDITS_REJECT.HOM",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; Filter =
for the Home (HOM) message class.  HOM is generally used to send requests, =
request responses, and snoop responses.",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; NCB Mes=
sage Class",
-        "EventCode": "0x37",
-        "EventName": "UNC_R3_VN0_CREDITS_REJECT.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; Filter =
for Non-Coherent Broadcast (NCB).  NCB is generally used to transmit data w=
ithout coherency.  For example, non-coherent read data returns.",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; NCS Mes=
sage Class",
-        "EventCode": "0x37",
-        "EventName": "UNC_R3_VN0_CREDITS_REJECT.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; Filter =
for Non-Coherent Standard (NCS).  NCS is commonly used for ?",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; NDR Mes=
sage Class",
-        "EventCode": "0x37",
-        "EventName": "UNC_R3_VN0_CREDITS_REJECT.NDR",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; NDR pac=
kets are used to transmit a variety of protocol flits including grants and =
completions (CMP).",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; SNP Mes=
sage Class",
-        "EventCode": "0x37",
-        "EventName": "UNC_R3_VN0_CREDITS_REJECT.SNP",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; Filter =
for Snoop (SNP) message class.  SNP is used for outgoing snoops.  Note that=
 snoop responses flow on the HOM message class.",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN0 Credit Used; DRS Message Class",
-        "EventCode": "0x36",
-        "EventName": "UNC_R3_VN0_CREDITS_USED.DRS",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; Filter for Data Response (DRS).  DRS is generally used to transm=
it data with coherency.  For example, remote reads and writes, or cache to =
cache transfers will transmit their data using DRS.",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN0 Credit Used; HOM Message Class",
-        "EventCode": "0x36",
-        "EventName": "UNC_R3_VN0_CREDITS_USED.HOM",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; Filter for the Home (HOM) message class.  HOM is generally used =
to send requests, request responses, and snoop responses.",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN0 Credit Used; NCB Message Class",
-        "EventCode": "0x36",
-        "EventName": "UNC_R3_VN0_CREDITS_USED.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; Filter for Non-Coherent Broadcast (NCB).  NCB is generally used =
to transmit data without coherency.  For example, non-coherent read data re=
turns.",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN0 Credit Used; NCS Message Class",
-        "EventCode": "0x36",
-        "EventName": "UNC_R3_VN0_CREDITS_USED.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; Filter for Non-Coherent Standard (NCS).  NCS is commonly used fo=
r ?",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN0 Credit Used; NDR Message Class",
-        "EventCode": "0x36",
-        "EventName": "UNC_R3_VN0_CREDITS_USED.NDR",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; NDR packets are used to transmit a variety of protocol flits inc=
luding grants and completions (CMP).",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN0 Credit Used; SNP Message Class",
-        "EventCode": "0x36",
-        "EventName": "UNC_R3_VN0_CREDITS_USED.SNP",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; Filter for Snoop (SNP) message class.  SNP is used for outgoing =
snoops.  Note that snoop responses flow on the HOM message class.",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; DRS Mes=
sage Class",
-        "EventCode": "0x39",
-        "EventName": "UNC_R3_VN1_CREDITS_REJECT.DRS",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; Filter for =
Data Response (DRS).  DRS is generally used to transmit data with coherency=
.  For example, remote reads and writes, or cache to cache transfers will t=
ransmit their data using DRS.",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; HOM Mes=
sage Class",
-        "EventCode": "0x39",
-        "EventName": "UNC_R3_VN1_CREDITS_REJECT.HOM",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; Filter for =
the Home (HOM) message class.  HOM is generally used to send requests, requ=
est responses, and snoop responses.",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; NCB Mes=
sage Class",
-        "EventCode": "0x39",
-        "EventName": "UNC_R3_VN1_CREDITS_REJECT.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; Filter for =
Non-Coherent Broadcast (NCB).  NCB is generally used to transmit data witho=
ut coherency.  For example, non-coherent read data returns.",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; NCS Mes=
sage Class",
-        "EventCode": "0x39",
-        "EventName": "UNC_R3_VN1_CREDITS_REJECT.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; Filter for =
Non-Coherent Standard (NCS).  NCS is commonly used for ?",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; NDR Mes=
sage Class",
-        "EventCode": "0x39",
-        "EventName": "UNC_R3_VN1_CREDITS_REJECT.NDR",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; NDR packets=
 are used to transmit a variety of protocol flits including grants and comp=
letions (CMP).",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; SNP Mes=
sage Class",
-        "EventCode": "0x39",
-        "EventName": "UNC_R3_VN1_CREDITS_REJECT.SNP",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; Filter for =
Snoop (SNP) message class.  SNP is used for outgoing snoops.  Note that sno=
op responses flow on the HOM message class.",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Credit Used; DRS Message Class",
-        "EventCode": "0x38",
-        "EventName": "UNC_R3_VN1_CREDITS_USED.DRS",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; Filter for Data Response (DRS).  DRS is generally used to transm=
it data with coherency.  For example, remote reads and writes, or cache to =
cache transfers will transmit their data using DRS.",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Credit Used; HOM Message Class",
-        "EventCode": "0x38",
-        "EventName": "UNC_R3_VN1_CREDITS_USED.HOM",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; Filter for the Home (HOM) message class.  HOM is generally used =
to send requests, request responses, and snoop responses.",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Credit Used; NCB Message Class",
-        "EventCode": "0x38",
-        "EventName": "UNC_R3_VN1_CREDITS_USED.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; Filter for Non-Coherent Broadcast (NCB).  NCB is generally used =
to transmit data without coherency.  For example, non-coherent read data re=
turns.",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Credit Used; NCS Message Class",
-        "EventCode": "0x38",
-        "EventName": "UNC_R3_VN1_CREDITS_USED.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; Filter for Non-Coherent Standard (NCS).  NCS is commonly used fo=
r ?",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Credit Used; NDR Message Class",
-        "EventCode": "0x38",
-        "EventName": "UNC_R3_VN1_CREDITS_USED.NDR",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; NDR packets are used to transmit a variety of protocol flits inc=
luding grants and completions (CMP).",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VN1 Credit Used; SNP Message Class",
-        "EventCode": "0x38",
-        "EventName": "UNC_R3_VN1_CREDITS_USED.SNP",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; Filter for Snoop (SNP) message class.  SNP is used for outgoing =
snoops.  Note that snoop responses flow on the HOM message class.",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VNA credit Acquisitions",
-        "EventCode": "0x33",
-        "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED",
-        "PerPkg": "1",
-        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credits from the VN0 pool.  =
Note that a single packet may require multiple flit buffers (i.e. when data=
 is being transferred).  Therefore, this event will increment by the number=
 of credits acquired in each cycle.  Filtering based on message class is no=
t provided.  One can count the number of packets transferred in a given mes=
sage class using an qfclk event.",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VNA credit Acquisitions; HOM Message Class",
-        "EventCode": "0x33",
-        "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED.AD",
-        "PerPkg": "1",
-        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
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
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VNA credit Acquisitions; HOM Message Class",
-        "EventCode": "0x33",
-        "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED.BL",
-        "PerPkg": "1",
-        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
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
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VNA Credit Reject; DRS Message Class",
-        "EventCode": "0x34",
-        "EventName": "UNC_R3_VNA_CREDITS_REJECT.DRS",
-        "PerPkg": "1",
-        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; Filter for Data Response (DRS).  DRS =
is generally used to transmit data with coherency.  For example, remote rea=
ds and writes, or cache to cache transfers will transmit their data using D=
RS.",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VNA Credit Reject; HOM Message Class",
-        "EventCode": "0x34",
-        "EventName": "UNC_R3_VNA_CREDITS_REJECT.HOM",
-        "PerPkg": "1",
-        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; Filter for the Home (HOM) message cla=
ss.  HOM is generally used to send requests, request responses, and snoop r=
esponses.",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VNA Credit Reject; NCB Message Class",
-        "EventCode": "0x34",
-        "EventName": "UNC_R3_VNA_CREDITS_REJECT.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; Filter for Non-Coherent Broadcast (NC=
B).  NCB is generally used to transmit data without coherency.  For example=
, non-coherent read data returns.",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VNA Credit Reject; NCS Message Class",
-        "EventCode": "0x34",
-        "EventName": "UNC_R3_VNA_CREDITS_REJECT.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; Filter for Non-Coherent Standard (NCS=
).",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VNA Credit Reject; NDR Message Class",
-        "EventCode": "0x34",
-        "EventName": "UNC_R3_VNA_CREDITS_REJECT.NDR",
-        "PerPkg": "1",
-        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; NDR packets are used to transmit a va=
riety of protocol flits including grants and completions (CMP).",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "VNA Credit Reject; SNP Message Class",
-        "EventCode": "0x34",
-        "EventName": "UNC_R3_VNA_CREDITS_REJECT.SNP",
-        "PerPkg": "1",
-        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; Filter for Snoop (SNP) message class.=
  SNP is used for outgoing snoops.  Note that snoop responses flow on the H=
OM message class.",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Cycles with no VNA credits available",
-        "EventCode": "0x31",
-        "EventName": "UNC_R3_VNA_CREDIT_CYCLES_OUT",
-        "PerPkg": "1",
-        "PublicDescription": "Number of QPI uclk cycles when the transmitt=
ed has no VNA credits available and therefore cannot send any requests on t=
his channel.  Note that this does not mean that no flits can be transmitted=
, as those holding VN0 credits will still (potentially) be able to transmit=
.  Generally it is the goal of the uncore that VNA credits should not run o=
ut, as this can substantially throttle back useful QPI bandwidth.",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Cycles with 1 or more VNA credits in use",
-        "EventCode": "0x32",
-        "EventName": "UNC_R3_VNA_CREDIT_CYCLES_USED",
-        "PerPkg": "1",
-        "PublicDescription": "Number of QPI uclk cycles with one or more V=
NA credits in use.  This event can be used in conjunction with the VNA In-U=
se Accumulator to calculate the average number of used VNA credits.",
-        "Unit": "R3QPI"
-    },
-    {
-        "EventName": "UNC_U_CLOCKTICKS",
-        "PerPkg": "1",
-        "Unit": "UBOX"
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
-        "BriefDescription": "VLW Received",
-        "EventCode": "0x42",
-        "EventName": "UNC_U_EVENT_MSG.INT_PRIO",
-        "PerPkg": "1",
-        "PublicDescription": "Virtual Logical Wire (legacy) message were r=
eceived from Uncore.   Specify the thread to filter on using NCUPMONCTRLGLC=
TR.ThreadID.",
-        "UMask": "0x10",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "VLW Received",
-        "EventCode": "0x42",
-        "EventName": "UNC_U_EVENT_MSG.IPI_RCVD",
-        "PerPkg": "1",
-        "PublicDescription": "Virtual Logical Wire (legacy) message were r=
eceived from Uncore.   Specify the thread to filter on using NCUPMONCTRLGLC=
TR.ThreadID.",
-        "UMask": "0x4",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "VLW Received",
-        "EventCode": "0x42",
-        "EventName": "UNC_U_EVENT_MSG.MSI_RCVD",
-        "PerPkg": "1",
-        "PublicDescription": "Virtual Logical Wire (legacy) message were r=
eceived from Uncore.   Specify the thread to filter on using NCUPMONCTRLGLC=
TR.ThreadID.",
-        "UMask": "0x2",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "VLW Received",
-        "EventCode": "0x42",
-        "EventName": "UNC_U_EVENT_MSG.VLW_RCVD",
-        "PerPkg": "1",
-        "PublicDescription": "Virtual Logical Wire (legacy) message were r=
eceived from Uncore.   Specify the thread to filter on using NCUPMONCTRLGLC=
TR.ThreadID.",
-        "UMask": "0x1",
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
-        "BriefDescription": "IDI Lock/SplitLock Cycles",
-        "EventCode": "0x44",
-        "EventName": "UNC_U_LOCK_CYCLES",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times an IDI Lock/SplitLock sequen=
ce was started",
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
-    }
-]
--=20
2.40.0.577.gac1e443424-goog

